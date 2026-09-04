require 'ruby2d'
require_relative 'src/object'

class Game
  def initialize
    # Criação da Interface e dos elementos do game
    # Janela
    @window = Window
    @window.set(
      title: 'Mini-Gems',
      width:  @window.display_width - 600,
      height: @window.display_height - 400,
      background: 'green',
      resizable: 'True',
      fullscreen: false
    )

    # Mouse
    @mouse_held = false
    @mouse = GameObject.new(
          @window.mouse_x, 
          @window.mouse_y,
          "assets/mouse.png",
          64,
          64,
          100)  

    # Definindo itens de drop(objetos)
    @drag_items = []  
    @selected_item = nil
    (0..25).each do |index|
        @drag_items << GameObject.new(80*index, 0, "assets/gem.png", 96, 96, index)
      end

    # Definindo zonas de drop(grids)
    @drop_zones = []
    (0..4).each do |line|
      (0..4).each do |column|
        @drop_zones << GameObject.new(
          @window.width / 2 - 175 + (column - 1) * 120,
          @window.height / 2 - 175 + (line - 1) * 120,
          "assets/border-rect.png",
          96,
          96,
          0
        )
      end
    end
      for zone in @drop_zones
        zone.item= false
      end
  end

  def highest_z_index?(item)
    puts(@drag_items.max_by(&:z).z)
    item.z == @drag_items.max_by(&:z).z
  end

  # Método de ancoragem de itens nos grids
  def anchor_to_grid(drag_item)
    @drop_zones.each do |zone|
      if drag_item.check_collision(zone) && !zone.item
        drag_item.x = zone.x
        drag_item.y = zone.y
        zone.item = drag_item
        @drag_items.delete(drag_item)
        return true
      end
      false
    end
  end

  # Método de verificação de inputs
  def check_inputs
    # Screenshot
    @window.on :key_up do |event|
      if event.key == 'f12'
        Window.screenshot("shot_#{Time.now.to_i}.png")
      end
    end
    
    @window.on :mouse_move do |event|
      # Movimenta a sprite do Mouse
      @mouse.x = event.x
      @mouse.y = event.y

      # Arrastar item com o mouse
      for item in @drag_items
        if @mouse_held &&
          @mouse.check_collision(item)
            #verificação do maior z index
            if self.highest_z_index?(item) 
              item.x = @mouse.x - item.width/2
              item.y = @mouse.y - item.height/2
            end
        end
      end
    end

    # Definindo o Drag
    @window.on :mouse_down do |event|
      if event.button == :left
        @mouse_held = true
      end
    end

    # Definindo o Drop
    @window.on :mouse_up do |event|
      if event.button == :left
        @mouse_held = false

        # Alinha cada item arrastado à sua respectiva grade
        @drag_items.map { |item| anchor_to_grid(item) }

      end
    end
  end

  def main
    # Atualização da interface a cada quadro
    @window.update do
      self.check_inputs
    end
  end

  def run
     # Roda o Game
     self.main
    @window.show
  end
end

game = Game.new
game.run
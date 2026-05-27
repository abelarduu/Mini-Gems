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
    (0..9).each do |obj|
        @drag_items << GameObject.new(80*obj, 80, "assets/rect.png", 150, 150, 1)
      end

    # Definindo zonas de drop(grids)
    @drop_zones = []
    (0..2).each do |line|
      (0..2).each do |column|
        @drop_zones << GameObject.new(
          @window.width / 2 - 75 + (column - 1) * 220,
          @window.height / 2 - 75 + (line - 1) * 180,
          "assets/border-rect.png",
          150,
          150,
          0
        )
      end
    end
      for zone in @drop_zones
        zone.item= false
      end
  end

  # Método de ancoragem de itens nos grids
  def anchor_to_grid(drag_item)
    @drop_zones.each do |zone|
      if drag_item.check_collision(zone) && !zone.item
        drag_item.x = zone.x
        drag_item.y = zone.y
        zone.item = drag_item
        return true
      end
    end
    false
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
          item.x = @mouse.x - item.width/2
          item.y = @mouse.y - item.height/2
        end
      end
    end

    # Alinha cada item arrastado à sua respectiva grade
    @drag_items.map { |item|anchor_to_grid(item) }

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
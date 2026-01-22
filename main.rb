require 'ruby2d'
require_relative 'src/object'

class Game
  def initialize
    # Criação da Interface e dos elementos do game
    @window = Window
    @window.set(
      title:'Mini-Gems',
      width: @window.display_width - 300,
      height: @window.display_height - 300,
      fullscreen: false,
      resizable:true,
      background:'green',
      mouse_visible: false
    )

    @WIDTH = @window.width
    @HEIGHT = @window.height
    @mouse_held = false

    @mouse = GameObject.new(@window.mouse_x,@window.mouse_y, "assets/mouse.png", 64, 64, 100)

    @drop_zones = []
    
  (0..2).each do |line|
    (0..2).each do |column|
      @drop_zones << GameObject.new(
        @window.width / 2 - 75 + (column - 1) * 220,
        @window.height / 2 - 75 + (line - 1) * 180,
        "assets/border-rect.png",
        150,
        150,
        1
      )
    end
  end

    @drag_item = GameObject.new(200, 180, "assets/rect.png",150, 150, 1)
  end

  def get_mouse_pos
    # retorna a posição X/Y do mouse na Interface
    [@window.mouse_x, @window.mouse_y]
  end

  def check_inputs
    @window.on :mouse_down do |event|
      if event.button == :left
        @mouse_held = true
      end
    end

    @window.on :mouse_up do |event|
      if event.button == :left
        @mouse_held = false

        # Encaixa o item na área de drop
        for zone in @drop_zones
          if @drag_item.check_collision(zone)
            @drag_item.x = zone.x
            @drag_item.y = zone.y
          end
        end
      end
    end

    @window.on :mouse_move do |event|
      # Movimenta a sprite do Mouse
      @mouse.x = event.x
      @mouse.y = event.y
      
      # Arrastar item com o mouse
      if @mouse_held &&
        @mouse.check_collision(@drag_item)
        @drag_item.x = @mouse.x - @drag_item.width/2
        @drag_item.y = @mouse.y - @drag_item.height/2
      end
    end

    @window.on :key_down do |event|
      if event.key == 'f12'
        Window.screenshot("shot_#{Time.now.to_i}.png")
        puts 'Screenshot tirado!'
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

Game.new.run
require 'ruby2d'

class Game
  def initialize
    # Criação da Interface e dos elementos do game
    @window = Window
    @window.set(
      title:'Mini-Gems',
      width: Window.display_width- 300,
      height: Window.display_height-300,
      fullscreen: false,
      background:'green',
      mouse_visible:false
    )

    @WIDTH = @window.width
    @HEIGHT = @window.height
    @mouse_held = false

    @rect= Rectangle.new(
                    x: 15,
                    y: 25,
                    width: 150,
                    height: 150,
                    color: 'teal',
                    z: 20
                  )

    @mouse= Sprite.new(
                  'assets/mouse.png',
                  width:64,
                  height:64,
                  z: 100
                  )

  end

  def check_collision( obj1, obj2)
    # Verifica a colisão entre 2 objetos no eixo X/Y
    if obj1.x > obj2.x && \
      obj1.x < obj2.x + obj2.width

      if obj1.y > obj2.y && \
         obj1.y < obj2.y + obj2.height
        true
      end
    end
  end

  def get_mouse_pos
    # retorna a posição X/Y do mouse na Interface
    [Window.mouse_x, Window.mouse_y]
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
      end
    end

    @window.on :mouse_move do |event|
      @mouse.x = event.x
      @mouse.y = event.y
      
      if @mouse_held &&
        self.check_collision(@mouse, @rect)

        @rect.x = @mouse.x - @rect.width/2
        @rect.y = @mouse.y - @rect.height/2
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
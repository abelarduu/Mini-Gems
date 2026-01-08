require 'ruby2d'

# Padronização de Objetos
class GameObject < Sprite
  def initialize(x, y, img, w, h, z)
      super(
        img,
        x: x,
        y: y,
        width: w,
        height: h,
        z: z
      )

      @initial_pos_x = x
      @initial_pos_y = y
  end

  def check_collision(obj)
    # Verifica a colisão entre 2 objetos no eixo X/Y
    if self.x > obj.x && \
      self.x < obj.x + obj.width

      if self.y > obj.y && \
         self.y < obj.y + obj.height
        true
      end
    end
  end
end

class Game
  def initialize
    # Criação da Interface e dos elementos do game
    @window = Window
    @window.set(
      title:'Mini-Gems',
      width: @window.display_width - 300,
      height: @window.display_height - 300,
      fullscreen: false,
      background:'green',
      mouse_visible:false
    )

    @WIDTH = @window.width
    @HEIGHT = @window.height
    @mouse_held = false

    @mouse = GameObject.new(@window.mouse_x,@window.mouse_y, "assets/mouse.png", 64, 64, 100)
    @rect = GameObject.new( 15, 25, "assets/border-rect.png",150, 150, 1)

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
      end
    end

    @window.on :mouse_move do |event|
      @mouse.x = event.x
      @mouse.y = event.y
      
      if @mouse_held &&
        @mouse.check_collision(@rect)

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
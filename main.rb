require 'ruby2d'

class Game
  def initialize
    # Criação da Interface e dos elementos do game
    @window = Window
    @window.set(
            title:'Mini-Gems',
            background:'green',
            resizable: true)
            
    @WIDTH = @window.width
    @HEIGHT = @window.height
    @mouse_held = false
    
    @rect = Rectangle.new(
                      x: 15, y: 25,
                      width: 50, height: 50,
                      color: 'teal',
                      z: 20)
  end

  def get_mouse_pos 
    # retorna a posição X/Y do mouse na Interface
    [Window.mouse_x, Window.mouse_y]
  end

  def check_collision(obj1, obj2)
    # Verifica a colisão entre 2 objetos no eixo X/Y
    if obj1.x > obj2.x && \
      obj1.x < obj2.x + obj2.width

      if obj1.y > obj2.y && \
         obj1.y < obj2.y + obj2.height
          true
      end
    end
  end

  def check_inputs
    @window.on :mouse_down do |event|
      case event.button
      when :left
        @mouse_held = true
      end
    end
    
    @window.on :mouse_up do |event|
      case event.button
      when :left
        @mouse_held = false
      end
    end

    @window.on :mouse do |event|
      if @mouse_held &&
        check_collision(event, @rect)
          @rect.x = event.x - @rect.width/2
          @rect.y = event.y - @rect.height/2
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
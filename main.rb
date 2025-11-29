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

    @mouse_pos = Window.mouse_x, Window.mouse_y
            
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

  def main
    # Atualização da interface a cada quadro
    @window.update do
      @rect.x= Window.mouse_x - @rect.width/2
      @rect.y= Window.mouse_y - @rect.height/2

      puts self.get_mouse_pos
    end
  end

  def run
    # Roda o Game
    self.main
    @window.show
  end
end

Game.new.run
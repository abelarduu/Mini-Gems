require 'ruby2d'

class Game
  def initialize
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
                      width: 200, height: 150,
                      color: 'teal',
                      z: 20)
  end

  def get_mouse_pos
    [Window.mouse_x, Window.mouse_y]
  end

  def main
    @window.update do
      puts self.get_mouse_pos
      # @WIDTH , @HEIGHT

    end
  end

  def run
    self.main
    @window.show
  end
end

Game.new.run
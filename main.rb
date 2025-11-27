require 'ruby2d'

class Game
  def initialize
    @window = Ruby2D::Window.new()
    @window.set(
      title:'Mini-Gems',
      background:'green',
      resizable: true)

    @WIDTH = @Window.width
    @HEIGHT = @Window.height
  end

  def main
    @window.update do
      puts @WIDTH , @HEIGHT
    end
  end

  def run
    self.main
    @window.show
  end
end

Game.new.run
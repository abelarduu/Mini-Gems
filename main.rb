require 'ruby2d'

class Game
  def initialize
    @window = Ruby2D::Window.new(title: 'Mini-Gems')
  end

  def main
    @window.update do
      puts @window
    end
  end

  def run
    self.main
    @window.show
  end
end

Game.new.run
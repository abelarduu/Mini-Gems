require 'ruby2d'

class Game
  include Ruby2D

  def initialize
    @window = Window.new(title: 'Mini-Gems')
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

game = Game.new
game.run

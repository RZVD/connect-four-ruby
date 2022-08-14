require_relative 'game'

game = Game.new

game.play until game.ended?

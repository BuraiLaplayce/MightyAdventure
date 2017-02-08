require 'gosu'
require 'rubygems'

class Shoot
	attr_reader :x, :y, :radius
	def initialize(window,x, y, dir)
		@x = x# + 12
		@y = y# - 10
		@dir = dir
		@imagem = Gosu::Image.new("Miscellaneous/Animations/Genm/Shoot.png")
		@radius = 10
		@window = window
	end
	def move
		@x +=  4 * (@dir == :right ? 1 : -1)
	end
	def draw
		factor = 1.0 * (@dir == :right ? 1 : -1)
		@imagem.draw(@x - @radius, @y - @radius, 0, factor, 1.0)
	end
	def natela?
		direita = @window.width + @radius
		esquerda = -@radius
		cima = -@radius
		baixo = @window.height + @radius 
		@x > esquerda && @x < direita && @y > cima && @y < baixo
	end
end
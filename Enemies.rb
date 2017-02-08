require 'rubygems'
require 'gosu'

class Enemie1
	attr_reader :x, :y, :life, :dir

	def initialize(map, x ,y)
		@x, @y = x, y
		@dir = :left
		@map = map
		@vy = 0
		@standing = Gosu::Image.new("Miscellaneous/Animations/Enemies/Enemie1S.png")
		@jumping = Gosu::Image.new("Miscellaneous/Animations/Enemies/Enemie1J.png")
		@life = 5
		@cur_image = @standing
	end 

	def draw(map=nil)
		if map then
			@map = map
		end
		if @dir == :right then
			offs_x = -10
			factor = 1.0
		else
			offs_x = 10
			factor = -1.0
		end
		@cur_image.draw(@x + offs_x, @y - 32, 0, factor, 1.0)
	end

	def would_fit(offs_x, offs_y)
	    not @map.solid?(@x + offs_x, @y + offs_y) and
	      not @map.solid?(@x + offs_x, @y + offs_y)
  	end

  	def update(move_x=0)
  		if (move_x == 0)
	      	@cur_image = @standing
	    end
	    if (@vy < 0) or (@vy > 0)
	      	@cur_image = @jumping
	    end
	    if move_x > 0 then
	      @dir = :right
	      move_x.times { if would_fit(1, 0) then @x += 0.375 end }
	    end
	    if move_x < 0 then
	      @dir = :left
	      (-move_x).times { if would_fit(-1, 0) then @x -= 0.375 end }
	    end
	    @vy += 1
	    if @vy > 0 then
	      	@vy.times { if would_fit(0, 1) then @y += 0.275 else @vy = 0 end }
	    end
	    if @vy < 0 then
	      	(-@vy).times { if would_fit(0, -1) then @y -= 0.275 else @vy = 0 end }
	    end
	end

  	def try_to_jump
		if @map.solid?(@x, @y + 1) then
			@vy = -20
		end
	end
end
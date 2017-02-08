require 'rubygems'
require 'gosu'
class Genm
	attr_reader :x, :y, :life, :dir, :vy

	def initialize(map, x ,y)
		@x, @y = x, y
		@map = map
		@dir = :right
		@vy = 0
		@standing = Gosu::Image.new("Miscellaneous/Animations/Genm/GenmS.png")
		@walking = Gosu::Image.load_tiles("Miscellaneous/Animations/Genm/GenmW.png", 28, 32)
		@jumping = Gosu::Image.new("Miscellaneous/Animations/Genm/GenmJ.png")
		@shotingS = Gosu::Image.new("Miscellaneous/Animations/Genm/GenmSS.png")
		@shotingJ = Gosu::Image.new("Miscellaneous/Animations/Genm/GenmJS.png")
		@cur_image = @standing
		@life = 16
#		@damage = Gosu::Sample.new("/.wav")

	end

	def draw
		if @dir == :right then
			offs_x = -18
			factor = 1.0
		else
			offs_x = 18
			factor = -1.0
		end
		@cur_image.draw(@x + offs_x, @y - 31, 0, factor, 1.0)
	end

	def would_fit(offs_x, offs_y)
	    not @map.solid?(@x + offs_x, @y + offs_y) and
	      not @map.solid?(@x + offs_x, @y + offs_y)
  	end

	def update(move_x)
		if (Gosu::button_down? Gosu::KbX) then
	      @life -=1
	    end
		if (move_x == 0)
	      	@cur_image = @standing
	      	if (Gosu::button_down? Gosu::KbSpace) then
				@cur_image = @shotingS
			end
	    elsif (move_x > 0) or (move_x < 0)
			if not (@vy < 0) then
				@cur_image = @walking[Gosu::milliseconds / 150% @walking.size]
			end
	    end
	    if (@vy < 0) or (@vy > 0)
	      	@cur_image = @jumping
	 	    if (Gosu::button_down? Gosu::KbSpace) then
				@cur_image = @shotingJ
			end
	    end

	    if Gosu::button_down? Gosu::KbUp then
	    	@cur_image = @jumping
	    	if (@vy == 0) then
	    		@cur_image = @jumping
	    	end
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
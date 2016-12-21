class Sniper
	attr_reader :x, :y

	def initialize(map, x ,y)
		@x, @y = x, y
		@dir = :left
		@vy = 0
		@standing =
		@right = Gosu::Image.new()
		@left = Gosu::Image.new()
		@jump = Gosu::Image.new()
		@fallen = Gosu::Image.new()

#		@life = 30
#		@damage = Gosu::Sample.new("/.wav")

	end

	def draw
#		@sprite.draw(@x + offs_x, @y - 49, 0, factor, 1.0)
	end

	def update
#		if @life == 30 then
#			@life = Gosu::Image.new("Miscellaneous/Life Bar/ExAid/Life30.png", :tileable => true)
#			if @life > 30 then
#				@damage.play(1, 1, false)
#				@stand = @damage_anim
#			end
#		end
#		if @life == 29 then
#			@life = Gosu::Image.new("Miscellaneous/Life Bar/ExAid/Life29.png", :tileable => true)
#			if @life > 29 then
#				@damage.play(1, 1, false)
#				@stand = @damage_anim
#			end
#			if @life >29 then
#				@life_up.play(1 , 1, false)
#				
#		end

	end

end
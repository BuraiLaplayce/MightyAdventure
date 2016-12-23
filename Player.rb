class Sniper
	attr_reader :x, :y

	def initialize(map, x ,y)
		@x, @y = x, y
		@dir = :left
		@vy = 0
		@standing =Gosu::
		@right = Gosu::Image.new()
		@right_anim1 = Gosu::Image.new()
		@right_anim2 = Gosu::Image.new()
		@right_anim3 = Gosu::Image.new()
		@left = Gosu::Image.new()
		@left_anim1 = Gosu::Image.new()
		@left_anim2 = Gosu::Image.new()
		@left_anim3 = Gosu::Image.new()
		@jump = Gosu::Image.new()
		@fallen = Gosu::Image.new()

#		@life = 30
#		@damage = Gosu::Sample.new("/.wav")

	end

	def draw

	end

	def update
		while Gosu::button_down? Gosu::KbRight do
			@sprite = @left_anim
		end
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
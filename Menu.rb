require 'rubygems'
require 'gosu'
#require_relative 'Player'

module Tiles
	A = 0
	B = 1
	C = 2
	D = 3
	E = 4
	F = 5
	G = 6
	H = 7
	I = 8
	J = 9
	K = 10
	L = 11
end

class StageOne
	attr_reader :width, :height
	def initialize(filename)
		@tileset = Gosu::Image.load_tiles("StageOne/StageOne.png", 16, 16, :tileable => true)
		lines = File.readlines(filename).map { |line| line.chomp }
		@height = lines.size
		@width = lines[0].size
		@tiles = Array.new(@width) do |x|
		    Array.new(@height) do |y|
				case lines[y][x, 1]
				when 'a'
					Tiles::A
				when 'b'
					Tiles::B
				when 'c'
					Tiles::C
				when 'd'
					Tiles::D
				when 'e'
					Tiles::E
				when 'f'
					Tiles::F
				when 'g'
					Tiles::G
				when 'h'
					Tiles::H
				when 'i'
					Tiles::I
				when 'j'
					Tiles::J
				when 'k'
					Tiles::K
				when 'l'
					Tiles::L
				else
					nil
				end
			end
		end
	end

	def draw
		@height.times do |y|
			@width.times do |x|
				tile = @tiles[x][y]
				if tile 
					@tileset[tile].draw(x * 16, y * 16, 0)
				end
			end
		end
	end

	def solid?(x,y)
		y < 0 || @tiles[x / 16][y / 16]
	end
end

class MightyAdventure < Gosu::Window
	def initialize
		super(256, 224, false)
		self.caption = "Mighty Adventure"
		@status = "begin"
		@background_image = Gosu::Image.new("Menu/Menu.png", :tileable => true)
		@background_song = Gosu::Song.new("Sounds/Menu.wav")
		@background_song.play(true)

		@menu_anim = Gosu::Image.load_tiles(self, "Menu/Game_Start_Animation.png", 107, 107, false)
		@image = @menu_anim[Gosu::milliseconds / 100% @menu_anim.size]
		@game_start_song = Gosu::Song.new("Sounds/Game_Start.wav")
		@switch_window_begin = Gosu::Image.new("Menu/Switch.png", :tileable => true)

		@characterselect = Gosu::Image.new("CharacterMenu/CharacterSelect.png", :tileable => true)
		@exaid_selected_anim = Gosu::Image.new("CharacterMenu/ExAidSelected.png", :tileable => true)
		@brave_selected_anim = Gosu::Image.new("CharacterMenu/BraveSelected.png", :tileable => true)
		@sniper_selected_anim = Gosu::Image.new("CharacterMenu/SniperSelected.png", :tileable => true)
		@characterselect_background_song = Gosu::Song.new("Sounds/CharacterSelectBack.wav")
		@characterchange_song = Gosu::Sample.new("Sounds/CharacterChange.wav")
		@title_back_song = Gosu::Sample.new("Sounds/Back.wav")

		@note_song = Gosu::Sample.new("Sounds/Note.wav")

		@stageone_back_song = Gosu::Song.new("Sounds/StageOne.wav")

	end

	def draw
		if @status == "begin" then
			draw_begin
		elsif @status == "characterselect" then
			draw_characterselect
		elsif @status == "wait" then
			draw_wait
		elsif @status == "note" then
			draw_note
		elsif @status == "stageone" then
			draw_stageone
#		elsif @status == "stagetwo" then
#			draw_stagetwo
#		elsif @status == "gameover" then
#			draw_gameover
		end
	end

	def draw_begin
		@background_image.draw(0, 0, 0)
		@image.draw(74, 94, 0)
	end

	def draw_characterselect
		@background_image.draw(0, 0, 0)
		@image.draw(0, 20, 0)
	end

	def draw_wait
		@background_image.draw(0, 0, 0)
	end

	def draw_note
		@background_image.draw(0, 0, 0)
		@note_image.draw(58, 50, 0)
	end

	def draw_stageone
		@background_image.draw( 0, 0, 0)
#		Gosu::translate(-@camera_x, -@camera_y) do
			@stage.draw
#		end
	end

#	def draw_stagetwo
#	end

#	def draw_gameover
#	end

	def update
		if @status == "begin" then
			update_begin
		elsif @status == "characterselect" then
			update_characterselect
		elsif @status == "wait" then
			update_wait
		elsif @status == "note" then
			update_note
		elsif @status == "stageone" then
			update_stageone
#		elsif @status == "stagetwo" then
#			update_stagetwo
#		elsif @status == "gameover" then
#			update_gameover
		end
	end

	def update_begin
		@image = @menu_anim[Gosu::milliseconds / 100% @menu_anim.size]
		if Gosu::button_down? Gosu::KbEnter or Gosu::button_down? Gosu::KbReturn then
			@background_song.stop
			@game_start_song.play(false)
			sleep 0.5
			@status = "characterselect"
			@image = @exaid_selected_anim
			@background_song = @characterselect_background_song
			@background_song.play(true)
		end
		if Gosu::button_down? Gosu::KbEscape then
			sleep 0.5
			close
		end
	end

	def update_characterselect
		@background_image = @characterselect
		@characterselect_background_song.play(true)
		if @image == @exaid_selected_anim then
			if Gosu::button_down? Gosu::KbRight and not Gosu::button_down? Gosu::KbLeft then
				@characterchange_song.play(1, 1, false)
				@image = @brave_selected_anim
				if @image == @brave_selected_anim then
					sleep 0.15
				end
			end				
			if Gosu::button_down? Gosu::KbLeft and not Gosu::button_down? Gosu::KbRight then
				@characterchange_song.play(1, 1, false)
				@image = @sniper_selected_anim
				if @image == @sniper_selected_anim then
					sleep 0.15
				end
			end
			if Gosu::button_down? Gosu::KbEnter or Gosu::button_down? Gosu::KbReturn then
				@characterselect_background_song.stop
				@game_start_song.play(false)
				sleep 0.5
				#@jogador = ExAid.new()
				@status = "wait"
				@background_image = Gosu::Image.new("Note/Wait.png")
			end	
		end
		if @image == @brave_selected_anim then
			if Gosu::button_down? Gosu::KbLeft and not Gosu::button_down? Gosu::KbRight then
				@characterchange_song.play(1, 1, false)
				@image = @exaid_selected_anim
				if @image == @exaid_selected_anim then
					sleep 0.15
				end
			end
			if Gosu::button_down? Gosu::KbEnter or Gosu::button_down? Gosu::KbReturn then
				@characterselect_background_song.stop
				@game_start_song.play(false)
				sleep 0.5
				#@jogador = Brave.new()
				@status = "wait"
				@background_image = Gosu::Image.new("Note/Wait.png")
			end	
		end
		if @image == @sniper_selected_anim then
			if Gosu::button_down? Gosu::KbRight and not Gosu::button_down? Gosu::KbLeft then
				@characterchange_song.play(1, 1, false)
				@image = @exaid_selected_anim
				if @image == @exaid_selected_anim then
					sleep 0.15
				end
			end
			if Gosu::button_down? Gosu::KbEnter or Gosu::button_down? Gosu::KbReturn then
				@characterselect_background_song.stop
				@game_start_song.play(false)
				sleep 0.5
				#@jogador = Sniper.new()
				@status = "wait"
				@background_image = Gosu::Image.new("Note/Wait.png")
			end	
		end
		if Gosu::button_down? Gosu::KbSpace then
			@characterselect_background_song.stop
			@title_back_song.play(1 , 1 ,false)
			sleep 0.5
			@status = "begin"
			initialize
		end			
	end

	def update_wait
		@note_image = Gosu::Image.new("Note/Note.png")
		sleep 0.4
		@status = "note"
		@note_song.play(1, 1 ,false)
	end

	def update_note
		if Gosu::button_down? Gosu::KbSpace then
			close
		end
		if Gosu::button_down? Gosu::KbReturn or Gosu::button_down? Gosu::KbEnter then
			@game_start_song.play(false)
			sleep 0.5
			@status = "stageone"
			@background_image = Gosu::Image.new("StageOne/BackStageOne.png")
			@stage = StageOne.new("StageOne/StageOne.txt")
		end
	end

	def update_stageone
		@stageone_back_song.play(true)		
	end

#	def update_gameover
#	end

end


window = MightyAdventure.new
window.show
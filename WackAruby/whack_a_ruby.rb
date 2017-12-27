require 'gosu'

class WhackARuby < Gosu::Window

def initialize 
	super(800, 600)
	self.caption = 'Whack the cookie!'
	@image = Gosu::Image.new('cookie.png')
	@x = 200
	@y = 200
	@width = 50
	@height = 43
	@velocity_x = 2
	@velocity_y = 2
	@visible = 0
	@ghost_image = Gosu::Image.new('ghost.png')
	@hit = 0
	@font = Gosu::Font.new(30)
	@score = 0
	@playing = true
	

end

def update
 if @playing
	@x += @velocity_x 
	@y += @velocity_y 
	@visible -= 1
	@time_left = (100 - (Gosu.milliseconds / 1000))
	@playing = false if @time_left < 0
	@velocity_x *= -1 if @x + @width / 2 > 800 || @x - @width / 2 < 0
	@velocity_y *= -1 if @y + @height / 2 > 600 || @y - @height / 2 < 0
	@visible = 50 if @visible < -7 && rand < 0.01
	
end
end

def button_down(id)

if @playing
	if (id == Gosu::MS_LEFT)
		if Gosu.distance(mouse_x, mouse_y, @x, @y) < 50 && @visible >= 0
			@hit = 1
			@score += 5
		else
			@hit = -1
			@score -= 1
		end
	end
	
end
end


def draw

	if @visible > 0
		@image.draw(@x - @width / 2, @y - @height / 2, 1)
	end
	@ghost_image.draw(mouse_x - 40, mouse_y - 10, 1)

	if @hit == 0
		c = Gosu::Color::NONE
	elsif @hit == 1
		c = Gosu::Color::GREEN
	elsif @hit == -1
		c = Gosu::Color::RED
	end
 
 draw_quad(0,0,c,800,0,c,800,600,c,0,600,c)
 @hit = 0
 @font.draw(@time_left.to_s, 20, 20, 2)
 @font.draw(@score.to_s, 700, 20, 2)
 	
 	unless @playing
 	@font.draw('Game Over', 300, 300, 3)
 	@visible = 20
	end
end

end
window=WhackARuby.new
window.show


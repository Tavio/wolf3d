require "wolf3d/version"
require 'rubygems' rescue nil
require 'chingu'
include Gosu

module Wolf3d
  class Player < Chingu::GameObject  
    def move_left;  @x -= 3; end
    def move_right; @x += 3; end
    def move_up;    @y -= 3; end
    def move_down;  @y += 3; end
  end

  class Game < Chingu::Window
    def initialize
      super(640, 480, false)
      self.input = { :escape => :exit } # exits example on Escape
    
      @player = Wolf3d::Player.create(:x => 200, :y => 200, :image => Image["spaceship.png"])
      @player.input = { :holding_left => :move_left, :holding_right => :move_right, 
                      :holding_up => :move_up, :holding_down => :move_down }
    end
  
    def update
      super
      self.caption = "FPS: #{self.fps} milliseconds_since_last_tick: #{self.milliseconds_since_last_tick}"
    end
  end
end



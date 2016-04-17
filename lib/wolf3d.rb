require "wolf3d/version"
require "world"
require "vector2d"
require "player"
require 'search_ray'
require 'dda'
require 'rubygems' rescue nil
require 'chingu'
include Gosu

module Wolf3d

  class Ship < Chingu::GameObject  
    def move_left;  @x -= 3; end
    def move_right; @x += 3; end
    def move_up;    @y -= 3; end
    def move_down;  @y += 3; end
  end

  class Game < Chingu::Window

    SCREEN_WIDTH = 640
    SCREEN_HEIGHT = 480

    def initialize
      super(SCREEN_WIDTH, SCREEN_HEIGHT, false)
      self.caption = "Wolf3D"
      configure_input
      @player = Player.new(Vector2d.new(22, 12), Vector2d.new(-1, 0))
      @camera_plane = Vector2d.new(0, 0.66)
      @curr_frame_time = 0
      @last_frame_time = 0
      #@ship = Ship.create(:x => 200, :y => 200, :image => Image["spaceship.png"])
      #@ship.input = { :holding_left => :move_left, :holding_right => :move_right, 
      #                :holding_up => :move_up, :holding_down => :move_down }
    end
  
    def update
      super
      #self.caption = "#{@ship.x}, #{@ship.y}"
      search_rays(@player, @camera_plane, SCREEN_WIDTH).each do |search_ray|
        wallHit = Dda.search_wall(search_ray, World.map)
      end
    end

    private

    def configure_input
      self.input = { :escape => :exit } 
    end

    #TODO: write explanation on how look direction is calculated
    def search_rays(player, camera_plane, screen_width)
      (0..SCREEN_WIDTH).map do |screenX|
        camera_x = 2 * screenX / SCREEN_WIDTH.to_f - 1; # x-coordinate in camera space
        SearchRay.new(player, camera_plane, camera_x)
      end
    end
  end
end



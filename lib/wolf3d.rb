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

  class Wall < Chingu::GameObject
    def initialize(options = {})
      super
      @x = options[:x] 
      @y = options[:y]
      @h = options[:h]
      @rect = Chingu::Rect.new(@x, @y, 1, @h)
      @c = Gosu::Color.new(0xffff0000) 
    end

     def draw
      $window.draw_rect(@rect, @c, 1)
    end
  end

  class Game < Chingu::Window

    SCREEN_WIDTH = 640
    SCREEN_HEIGHT = 480

    def initialize
      super(SCREEN_WIDTH, SCREEN_HEIGHT, false)
      self.caption = "Wolf3D"
      configure_input
      @player = Player.new(Vector2d.new(7, 13), Vector2d.new(-1, 0))
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
        wall_hit = Dda.search_wall(search_ray, World.map)
        #wall_distance = @player.position.distance(wall_hit.map_pos)
        wall_distance = ((wall_hit.map_pos - search_ray.position).projection(@player.look_direction)).magnitude
        #Calculate height of line to draw on screen
        line_height = (SCREEN_HEIGHT / wall_distance).to_i

        #calculate lowest and highest pixel to fill in current stripe
        draw_start = - line_height / 2 + SCREEN_HEIGHT / 2;
        draw_start = 0 if draw_start < 0
        draw_end = line_height / 2 + SCREEN_HEIGHT / 2;
        draw_end = SCREEN_HEIGHT - 1 if draw_end >= SCREEN_HEIGHT

        Wall.create(:x => search_ray.screen_x, :y => draw_start, :h => draw_end - draw_start) 
      end
    end

    private

    def configure_input
      self.input = { :escape => :exit } 
    end

    #TODO: write explanation on how look direction is calculated
    def search_rays(player, camera_plane, screen_width)
      (0..SCREEN_WIDTH).map do |screen_x|
        camera_x = 2 * screen_x / SCREEN_WIDTH.to_f - 1; # x-coordinate in camera space
        SearchRay.new(player, camera_plane, camera_x, screen_x)
      end
    end
  end
end

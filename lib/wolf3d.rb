require "wolf3d/version"
require "world"
require "vector2d"
require "player"
require 'collision_ray'
require 'rubygems' rescue nil
require 'chingu'
include Gosu

module Wolf3d
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
    end
  
    def update
      super
      rays = collision_rays(@player, @camera_plane, SCREEN_WIDTH)
    end

    private

    def configure_input
      self.input = { :escape => :exit } # exits example on Escape
    end

    def collision_rays(player, camera_plane, screen_width)
      (0..SCREEN_WIDTH).map do |screenX|
        cameraX = 2 * screenX / SCREEN_WIDTH.to_f - 1; # x-coordinate in camera space
        CollisionRay.new(Vector2d.new(player.position.x, player.position.y),
                         Vector2d.new(@player.lookDirection.x + @camera_plane.x * cameraX, 
                                      @player.lookDirection.y + @camera_plane.y * cameraX)) 
      end
    end
  end
end



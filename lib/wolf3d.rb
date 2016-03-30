require "wolf3d/version"
require "world"
require "player"
require "vector2d"
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
      for screenX in (0..SCREEN_WIDTH) do
        cameraX = 2 * screenX / SCREEN_WIDTH.to_f - 1; # x-coordinate in camera space
        rayPosX = @player.position.x;
        rayPosY = @player.position.y;
        rayDirX = @player.lookDirection.x + @camera_plane.x * cameraX;
        rayDirY = @player.lookDirection.y + @camera_plane.y * cameraX;
      end
    end

    private

    def configure_input
      self.input = { :escape => :exit } # exits example on Escape
    end
  end
end



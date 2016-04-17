module Wolf3d
  class SearchRay
    attr_reader :position, :direction, :deltaDist, :sideDist, :step

    def initialize(player, camera_plane, camera_x)
      @position = Vector2d.new(player.position.x, player.position.y)
      @direction = Vector2d.new(player.lookDirection.x + camera_plane.x * camera_x, 
                                player.lookDirection.y + camera_plane.y * camera_x)
      @deltaDist = delta_dist(@direction)
      @sideDist = side_dist(@position, @direction, @deltaDist)
      @step = calculate_step(@direction)
    end

    private

    # A vector representing the distance the ray has to travel in order to go from
    # one x side of the map grid to another x side of the grid, and from one y side of
    # the grid to another y side of the map grid.
    #
    # To understand the calculations draw the grid on the cartesian plane, then draw the
    # ray vector starting from the origin. Assuming the ray direction has coordinates
    # (x', y'), then the line equation for the ray is y = y'/x' * x. The first x side
    # of the grid the ray touches has line equation x = 1, and the first y side of
    # the grid the ray touches has line equation y = 1. Thus, the intersection points
    # of these lines are (x'/y', 1) and (1, y'/x'). By using Pythagoras, we get to
    # deltaX = sqrt((x'/y') ^ 2 + 1), and deltaY = sqrt(1 + (y'/x') ^ 2).

    def delta_dist(ray_direction)
      Vector2d.new(Math.sqrt(1 + (ray_direction.y * ray_direction.y) / (ray_direction.x * ray_direction.x)),
                   Math.sqrt(1 + (ray_direction.x * ray_direction.x) / (ray_direction.y * ray_direction.y)))
    end

    # A vector representing the distance the ray has to travel in order to go from 
    # its current position to the nearest x side and the nearest y side of the grid.
    
    def side_dist(position, direction, deltaDist)
      mapPosition = position.to_i 
      sideDistX = direction.x < 0 ? (position.x - mapPosition.x) * deltaDist.x : (mapPosition.x + 1.0 - position.x) * deltaDist.x
      sideDistY = direction.y < 0 ? (position.y - mapPosition.y) * deltaDist.y : (mapPosition.y + 1.0 - position.y) * deltaDist.y
      Vector2d.new(sideDistX, sideDistY)
    end

    def calculate_step(direction)
      Vector2d.new(direction.x < 0 ? -1 : 1, direction.y < 0 ? -1 : 1)
    end
  end
end

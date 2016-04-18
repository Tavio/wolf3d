module Wolf3d
  class SearchRay
    attr_reader :position, :direction, :delta_dist, :side_dist, :step

    def initialize(player, camera_plane, camera_x)
      @position = Vector2d.new(player.position.x, player.position.y)
      @direction = calculate_direction(player.look_direction, camera_plane, camera_x) 
      @delta_dist = calculate_delta_dist(@direction)
      @side_dist = calculate_side_dist(@position, @direction, @delta_dist)
      @step = calculate_step(@direction)
    end

    private

    # The camera plane is a vector that is always perpendicular to the player's
    # look direction, and is used in the formulas below to create the search rays.
    # Each ray represents a pixel along the width of the screen, and the distance between
    # each of them is determined by the magnitude of the camera plane vector (field of view).

    def calculate_direction(look_direction, camera_plane, camera_x)
      Vector2d.new(look_direction.x + camera_plane.x * camera_x, 
                   look_direction.y + camera_plane.y * camera_x)
    end

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

    def calculate_delta_dist(ray_direction)
      Vector2d.new(Math.sqrt(1 + (ray_direction.y * ray_direction.y) / (ray_direction.x * ray_direction.x)),
                   Math.sqrt(1 + (ray_direction.x * ray_direction.x) / (ray_direction.y * ray_direction.y)))
    end

    # A vector representing the distance the ray has to travel in order to go from 
    # its current position to the nearest x side and the nearest y side of the grid.
    # The formulas below can be proven by triangle similarity, e.g.: 
    # delta_dist/side_dist = 1 / (position.x - mapPosition.x). Draw it and you'll see!
    
    def calculate_side_dist(position, direction, delta_dist)
      map_position = position.to_i 
      side_dist_x = direction.x < 0 ? (position.x - map_position.x) * delta_dist.x : (map_position.x + 1.0 - position.x) * delta_dist.x
      side_dist_y = direction.y < 0 ? (position.y - map_position.y) * delta_dist.y : (map_position.y + 1.0 - position.y) * delta_dist.y
      Vector2d.new(side_dist_x, side_dist_y)
    end

    def calculate_step(direction)
      Vector2d.new(direction.x < 0 ? -1 : 1, direction.y < 0 ? -1 : 1)
    end
  end
end

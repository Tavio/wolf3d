module Wolf3d
  class CollisionRay
    attr_reader :position, :direction, :deltaDist

    def initialize(position, direction)
      @position = position
      @direction = direction
      @deltaDist = delta_dist(@direction)
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
    # of these lines are (x'/y', 1) and (1, y'/x'). By using pythagoras, we get to
    # deltaX = sqrt((x'/y') ^ 2 + 1), and deltaY = sqrt(1 + (y'/x') ^ 2).

    def delta_dist(ray_direction)
      Vector2d.new(Math.sqrt(1 + (ray_direction.y * ray_direction.y) / (ray_direction.x * ray_direction.x)),
                   Math.sqrt(1 + (ray_direction.x * ray_direction.x) / (ray_direction.y * ray_direction.y)))
    end
  end
end

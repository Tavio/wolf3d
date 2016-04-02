module Wolf3d
  class CollisionRay
    attr_reader :position, :direction

    def initialize(position, direction)
      @position = position
      @direction = direction
    end
  end
end

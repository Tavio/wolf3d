module Wolf3d
  class Player
    attr_accessor :position, :lookDirection

    def initialize(initialPosition, initialLookDirection)
      @position = initialPosition
      @lookDirection = initialLookDirection
    end
  end
end

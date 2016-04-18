module Wolf3d
  class Player
    attr_accessor :position, :look_direction

    def initialize(initial_position, initial_look_direction)
      @position = initial_position
      @look_direction = initial_look_direction
    end
  end
end

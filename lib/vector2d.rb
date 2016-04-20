module Wolf3d
  class Vector2d
    attr_accessor :x, :y

    def initialize(x, y)
      @x = x
      @y = y
    end

    def to_i
      Vector2d.new(x.to_i, y.to_i)
    end

    def +(other)
      Vector2d.new(x + other.x, y + other.y) 
    end

    def -(other)
      Vector2d.new(x - other.x, y - other.y)
    end

    def *(constant)
      Vector2d.new(x * constant, y * constant)
    end

    def ==(other)
      other.x == x && other.y == y
    end

    def dot(other)
      x * other.x + y * other.y
    end

    def projection(other)
      other * (self.dot(other) / other.dot(other))
    end

    def magnitude
      Math.sqrt(x ** 2 + y ** 2)
    end

    def distance(other)
      Math.sqrt((other.x - x) ** 2 + (other.y - y) ** 2)
    end
  end
end

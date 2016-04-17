module Wolf3d
  class Dda
    def self.search_wall(search_ray, world_map)
      mapPos = search_ray.position.to_i
      sideDist = search_ray.sideDist
      sideHit = nil
      loop do
        if sideDist.x < sideDist.y 
          sideDist.x += search_ray.deltaDist.x
          mapPos.x += search_ray.step.x
          sideHit = :horizontal
        else
          sideDist.y += search_ray.deltaDist.y
          mapPos.y += search_ray.step.y
          sideHit = :vertical
        end
        break if world_map[mapPos.x, mapPos.y] > 0
      end
      WallHit.new(mapPos, sideHit)
    end
  end

  class WallHit
    attr_reader :mapPos, :sideHit
    
    def initialize (mapPos, sideHit)
      @mapPos = mapPos
      @sideHit = sideHit
    end
  end
end

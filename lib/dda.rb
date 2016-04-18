module Wolf3d
  class Dda
    def self.search_wall(search_ray, world_map)
      map_pos = search_ray.position.to_i
      side_dist = search_ray.side_dist
      side_hit = nil
      loop do
        if side_dist.x < side_dist.y 
          side_dist.x += search_ray.delta_dist.x
          map_pos.x += search_ray.step.x
          side_hit = :horizontal
        else
          side_dist.y += search_ray.delta_dist.y
          map_pos.y += search_ray.step.y
          side_hit = :vertical
        end
        break if world_map[map_pos.x, map_pos.y] > 0
      end
      WallHit.new(map_pos, side_hit)
    end
  end

  class WallHit
    attr_reader :map_pos, :side_hit
    
    def initialize (map_pos, side_hit)
      @map_pos = map_pos
      @side_hit = side_hit
    end
  end
end

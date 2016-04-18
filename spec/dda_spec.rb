require 'spec_helper'
require 'matrix'

describe Wolf3d::Dda do
  subject { Wolf3d::Dda }

  let(:world_map) {
    Matrix[[1, 1, 1, 1, 1, 1, 1, 1, 1, 1], 
           [1, 0, 0, 0, 0, 0, 0, 0, 0, 1], 
           [1, 0, 0, 0, 0, 0, 0, 0, 0, 1], 
           [1, 0, 0, 0, 0, 0, 0, 0, 0, 1], 
           [1, 0, 0, 0, 1, 1, 0, 0, 0, 1], 
           [1, 0, 0, 0, 1, 1, 0, 0, 0, 1], 
           [1, 0, 0, 0, 0, 0, 0, 0, 0, 1], 
           [1, 0, 0, 0, 0, 0, 0, 0, 0, 1], 
           [1, 0, 0, 0, 0, 0, 0, 0, 0, 1], 
           [1, 1, 1, 1, 1, 1, 1, 1, 1, 1]]
  }

  let(:delta_dist) { Wolf3d::Vector2d.new(1.5, 1) }
  let(:side_dist) { Wolf3d::Vector2d.new(0, 0) }
  let(:position) { Wolf3d::Vector2d.new(1, 1) }
  let(:step) { Wolf3d::Vector2d.new(1, 1) }
  let(:search_ray) { stub(delta_dist: delta_dist, 
                          side_dist: side_dist,
                          position: position,
                          step: step) } 

  describe '#search_wall' do

    it "finds the first wall in the search ray's direction" do
      expect(subject.search_wall(search_ray, world_map).map_pos).to eq Wolf3d::Vector2d.new(4, 5)
    end

    it "hits the wall on its x side" do
      expect(subject.search_wall(search_ray, world_map).side_hit).to eq :horizontal 
    end
  end
end

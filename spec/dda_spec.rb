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

  let(:deltaDist) { Wolf3d::Vector2d.new(1.5, 1) }
  let(:sideDist) { Wolf3d::Vector2d.new(0, 0) }
  let(:position) { Wolf3d::Vector2d.new(1, 1) }
  let(:step) { Wolf3d::Vector2d.new(1, 1) }
  let(:search_ray) { stub(deltaDist: deltaDist, 
                          sideDist: sideDist,
                          position: position,
                          step: step) } 

  describe '#search_wall' do

    it "finds the first wall in the search ray's direction" do
      expect(subject.search_wall(search_ray, world_map).mapPos).to eq Wolf3d::Vector2d.new(4, 5)
    end

    it "hits the wall on its x side" do
      expect(subject.search_wall(search_ray, world_map).sideHit).to eq :horizontal 
    end
  end
end

#!/usr/bin/env ruby -wKU

module Napakalaki
    class Prize
        def initialize(treasures,levels)
            @treasures = treasures
            @levels = levels
        end

        def to_s
            "Levels = #{levels.to_s}, Treasures = #{treasures.to_s}"
        end
        
        attr_reader :treasures, :levels
    end
end
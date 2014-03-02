#!/usr/bin/env ruby -wKU

module Napakalaki
    class Monster
        def initialize(name, level, bad, prize)
            @name = name
            @level = level
            @bad = bad
            @prize = prize
        end
        
        attr_reader :name, :level

        def to_s
            "Name: #{name}, Level: #{level}"
        end
    end
    
end
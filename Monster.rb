#!/usr/bin/env ruby -wKU

module Napakalaki
    class Monster
        def initialize(name, level, bad, prize)
            @name = name
            @level = level
            @bad = bad
            @prize = prize
        end
        
        attr_reader :name, :level, :bad, :prize

        def to_s
            "Nombre: #{name}, Nivel: #{level}\n\tBuen rollo: #{prize}\n\tMal rollo: #{bad}"
        end
    end
end
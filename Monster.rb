#!/usr/bin/env ruby
#encoding: utf-8

module Napakalaki
    class Monster
        def initialize(name, level, bad, prize)
            @name = name
            @level = level
            @bad = bad
            @prize = prize
        end
        
        attr_reader :name, :level, :bad, :prize

        # Da una cadena con la información del monstruo
        def to_s
            "Nombre: #{name}, Nivel: #{level}\n\tBuen rollo: #{prize}\n\tMal rollo: #{bad}"
        end
    end
end
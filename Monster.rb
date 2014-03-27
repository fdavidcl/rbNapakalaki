#!/usr/bin/env ruby
#encoding: utf-8

module Game
    class Monster
        def initialize(name, level, bad, prize)
            @name = name
            @level = level
            @badConsequence = bad
            @prize = prize
        end
        
        attr_reader :name, :level, :badConsequence, :prize

        # Da una cadena con la información del monstruo
        def toS
            "Nombre: #{name}, Nivel: #{level}\n\tBuen rollo: #{prize}\n\tMal rollo: #{bad}"
        end
    end
end
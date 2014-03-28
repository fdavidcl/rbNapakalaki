#!/usr/bin/env ruby
#encoding: utf-8

require_relative "Prize"

module Game
    class Monster
        def initialize(name, level, bad, prize)
            @name = name
            @level = level
            @badConsequence = bad
            @prize = prize
        end
        
        def getName
            @name
        end
        
        def getLevel
            @level
        end
        
        def getBadConsequence
            @badConsequence
        end
        
        def getPrize
            @prize
        end

        # Da una cadena con la información del monstruo
        def to_s
            "Nombre: #{getName}, Nivel: #{getLevel}\n\tBuen rollo: #{getPrize}\n\tMal rollo: #{getBadConsequence}"
        end
    end
end
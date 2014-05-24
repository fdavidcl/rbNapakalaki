#!/usr/bin/env ruby
#encoding: utf-8

require_relative "Card"
require_relative "Prize"

module Game
    # Clase que representa un monstruo del juego
    class Monster
        def initialize(name, level, bad, prize, levelChangeAgainstCultistPlayer = 0)
            @name = name
            @level = level
            @badConsequence = bad
            @prize = prize
            @levelChangeAgainstCultistPlayer = levelChangeAgainstCultistPlayer
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

        def getBasicValue
            getLevel
        end

        def getSpecialValue
            getLevel + @levelChangeAgainstCultistPlayer
        end

        # Da una cadena con la información del monstruo
        def to_s
            "Nombre: #{@name}, Nivel: #{@level}\n\tBuen rollo: #{@prize}\n\tMal rollo: #{@badConsequence}"
        end

        include Card
    end
end

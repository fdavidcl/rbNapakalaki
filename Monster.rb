#!/usr/bin/env ruby
#encoding: utf-8

require_relative "Prize"

module Game
    # Clase que representa un monstruo del juego
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
            "Nombre: #{@name}, Nivel: #{@level}\n\tBuen rollo: #{@prize}\n\tMal rollo: #{@badConsequence}"
        end
    end
end

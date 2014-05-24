#!/usr/bin/env ruby
#encoding: utf-8

require_relative "Card"

module Game
    # Clase que representa una carta de sectario
    class Cultist
        def initialize(name, gainedLevels)
            @name = name
            @gainedLevels = gainedLevels
        end

        def getBasicValue
            @gainedLevels
        end

        def getSpecialValue
            getBasicValue * CultistPlayer.getTotalCultistPlayers
        end

        include Card
    end
end

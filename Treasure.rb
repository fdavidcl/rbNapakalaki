#!/usr/bin/env ruby
#encoding: utf-8

module Game
    # Clase que representa un tesoro
    class Treasure
        def initialize(name, gold, min, max, type)
            @name = name
            @goldCoins = gold
            @minBonus = min
            @maxBonus = max
            @type = type
        end

        def getName
            @name
        end

        def getGoldCoins
            @goldCoins
        end

        def getMinBonus
            @minBonus
        end

        def getMaxBonus
            @maxBonus
        end

        def getBasicValue
            getMinBonus
        end

        def getSpecialValue
            getMaxBonus
        end

        def getType
            @type
        end

        def to_s
            "#{@type.upcase} \"#{@name}\" (#{@goldCoins} oro" +  (@type != NECKLACE ? ", +#{@minBonus}/+#{@maxBonus} bonus)" : ")")
        end
    end
end

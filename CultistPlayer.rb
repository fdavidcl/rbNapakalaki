#!/usr/bin/env ruby
#encoding: utf-8

require_relative "Player"

module Game
    # Clase que representa a un jugador sectario
    class CultistPlayer < Player
        @@totalCultistPlayers = 0

        def initialize(oldplayer, cultistcard)
            copy(oldplayer)
            @myCultistCard = cultistcard
            @@totalCultistPlayers += 1
        end

        def self.getTotalCultistPlayers
            @@totalCultistPlayers
        end

        def getCombatLevel
            super + myCultistCard.getSpecialValue
        end

        def shouldConvert
            false
        end

        def getOpponentLevel(m)
            m.getSpecialValue
        end

        def computeGoldCoinsValue(treasures)
            treasures.inject(0) { |sum, t|
                sum += t.getGoldCoins*2
            } / 1000
        end
    end
end

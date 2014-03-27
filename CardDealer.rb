#!/usr/bin/env ruby
#encoding: utf-8

require "singleton"

module Game
    class CardDealer
        include Singleton

        def initialize
            @unusedMonsters = []
            @usedMonsters = []
            @unusedTreasures = []
            @usedTreasures = []
        end

        private
        def initTreasureCardDeck
        end

        def initMonsterCardDeck
        end

        def shuffleTreasures
        end

        def shuffleMonsters
        end

        public
        def nextTreasure
        end

        def nextMonster
        end

        def giveTreasureBack(t)
        end

        def giveMonsterBack(m)
        end

        def initCards
        end
    end
end
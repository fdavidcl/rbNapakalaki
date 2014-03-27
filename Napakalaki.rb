#!/usr/bin/env ruby
#encoding: utf-8

require "singleton"
requireRelative "Monster", "Player", "CombatResult", "CardDealer"

module Game
    # Clase 'singleton' que contiene el mecanismo del juego
    class Napakalaki
        include Singleton

        def initialize
            @currentMonster = nil
            @currentPlayer = nil
            @players = []
        end

        private
        def initPlayers(names)
        end

        def nextPlayer
        end

        public
        def combat
        end

        def discardVisibleTreasure(t)
        end

        def discardHiddenTreasure(t)
        end

        def makeTreasureVisible(t)
        end

        def buyLevels(visible, hidden)
        end

        def initGame(players)
        end

        attr_reader :currentPlayer, :currentMonster

        def canMakeTreasureVisible?(t)
        end

        def visibleTreasures
        end

        def hiddenTreasures
        end

        def nextTurn
        end

        def nextTurnAllowed
        end

        def endOfGame(result)
        end
    end
end
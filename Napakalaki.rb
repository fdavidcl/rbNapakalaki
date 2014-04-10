#!/usr/bin/env ruby
#encoding: utf-8

require "singleton"
require_relative "Monster"
require_relative "Player"
require_relative "CombatResult"
require_relative "CardDealer"

module Game
    # Clase 'singleton' que contiene el mecanismo del juego
    class Napakalaki
        include Singleton

        def initialize
            @currentMonster = nil
            @currentPlayer = nil
            @currentPlayerIndex = nil
            @players = []
        end

        private
        def initPlayers(names)
            players = names.map { |n|
                Player.new(n)
            }
        end

        def nextPlayer
            currentPlayerIndex += 1
            currentPlayer = players[currentPlayerIndex]
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

        def getCurrentPlayer
            @currentPlayer
        end
        
        def getCurrentMonster
            @currentMonster
        end
        
        def canMakeTreasureVisible(t)
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
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
            #players debe ser no vacío, comprobar
            players = names.map { |n|
                Player.new(n)
            }
        end

        def nextPlayer
            # players debe ser no vacío
            currentPlayerIndex += 1
            currentPlayer %= players.size
            currentPlayer = players[currentPlayerIndex]
        end

        public
        def combat
            @currentPlayer.combat(@currentMonster)
            Dealer.instance.giveMonsterBack(@currentMonster)
        end

        def discardVisibleTreasure(t)
        end

        def discardHiddenTreasure(t)
        end

        def makeTreasureVisible(t)
        end

        def buyLevels(visible, hidden)
            @currentPlayer.buyLevels(visible,hidden)
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
            @currentMonster.validState
        end

        def endOfGame(result)
            result == WINANDWINGAME
        end
    end
end
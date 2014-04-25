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
            @players = names.collect { |n|
                Player.new(n)
            }
        end

        def nextPlayer
            # players debe ser no vacío
            @currentPlayerIndex += 1
            @currentPlayerIndex %= players.size
            @players[@currentPlayerIndex]
        end

        public
        def combat
            result = @currentPlayer.combat(@currentMonster)
            CardDealer.instance.giveMonsterBack(@currentMonster)
            result
        end

        def discardVisibleTreasure(t)
            @currentPlayer.discardVisibleTreasure t
        end

        def discardHiddenTreasure(t)
            @currentPlayer.discardHiddenTreasure t
        end

        def makeTreasureVisible(t)
            @currentPlayer.makeTreasureVisible t
        end

        def buyLevels(visible, hidden)
            @currentPlayer.buyLevels(visible,hidden)
        end

        def initGame(players)
            CardDealer.instance.initCards
            initPlayers players
            # Inicializamos el jugador
            @currentPlayerIndex = Random.rand players.size
            @currentPlayer = @players[@currentPlayerIndex]
            nextTurn            
        end

        def getCurrentPlayer
            @currentPlayer
        end
        
        def getCurrentMonster
            @currentMonster
        end
        
        def canMakeTreasureVisible(t)
            @currentPlayer.canMakeTreasureVisible
        end

        def getVisibleTreasures
            @currentPlayer.getVisibleTreasures
        end

        def getHiddenTreasures
            @currentPlayer.getHiddenTreasures
        end

        def nextTurn
            stateOK = nextTurnAllowed
            
            if stateOK
                @currentMonster = CardDealer.instance.nextMonster
                @currentPlayer = nextPlayer
                @currentPlayer.initTreasures if @currentPlayer.isDead
            end
            
            stateOK
        end

        def nextTurnAllowed
            @currentPlayer.validState
        end

        def endOfGame(result)
            result == WINANDWINGAME
        end
    end
end


#!/usr/bin/env ruby
#encoding: utf-8

require_relative "Treasure"
require_relative "Dice"
require_relative "BadConsequence"
require_relative "CardDealer"
require_relative "CombatResult"

module Game
    
    class Player
        def initialize(name)
            @dead = true
            @name = name
            @level = 0
            @hiddenTreasures = []
            @visibleTreasures = []
            @pendingBadConsequence = nil
        end

        private
        def bringToLife
            @dead = false
        end
        
        def incrementLevels(l)
            @level += l
        end
        
        def decrementLevels(l)
            @level = [level-l, 1].max
        end
        
        def setPendingBadConsequence(b)
            @pendingBadConsequence = b
        end
        
        def die
            @dead = true
        end
        
        def discardNecklaceVisible
            @visibleTreasures.delete(NECKLACE)
        end
        
        def dieIfNoTreasures
            @dead = true if visibleTreasures.empty? and hiddenTreasures.empty?
        end
        
        def computeGoldCoinsValue(t)
            t.inject{|sum,x} sum += x.getGoldCoins} / 1000
        end
        
        def canIBuyLevels(l)
            @level + l >= 10
        end
        
        public
        def applyPrize(p)
        end
        
        def combat(m)
        end
        
        def applyBadConsequence(bad)
        end
        
        def makeTreasureVisible(t)
        end
        
        def canMakeTreasureVisible(t)
            if !@visibleTreasures.include?(t) @visibleTreasures << t
        end
        
        def discardVisibleTreasure(t)
            @visibleTreasures.delete_at @visibleTreasures.index(t)
        end
        
        def discardHiddenTreasure(t)
            @hiddenTreasures.delete_at @hiddenTreasures.index(t)
        end
        
        def buyLevels(visible,hidden)
        end
        
        def getCombatLevel
            if @visibleTreasures.include?(NECKLACE)
                @visibleTreasures.inject(@level){ |sum,x| sum+= x.getMaxBonus }
            else
                @visibleTreasures.inject(@level){ |sum,x| sum+= x.getMinBonus }
            end
        end
        
        def validState
            @pendingBadConsequence.nil?
        end
        
        def initTreasures
        end
        
        def isDead
            @dead
        end
        
        def hasVisibleTreasures
            @visibleTreasures.any?
        end
        
        def getVisibleTreasures
            @visibleTreasures.clone
        end
        
        def getHiddenTreasures
            @hiddenTreasures.clone
        end
    end
end
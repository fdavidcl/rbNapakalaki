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

        def bringToLife
            @dead = false
        end
        
        def incrementLevels(l)
            @level += l
        end
        
        def decrementLevels(l)
            @level -= l
        end
        
        def setPendingBadConsequence(b)
            @pendingBadConsequence = b
        end
        
        def die
        end
        
        def discardNecklaceVisible
        end
        
        def dieIfNoTreasures
        end
        
        def computeGoldCoinsValue
        end
        
        def canIBuyLevels(l)
        end
        
        private
        def applyPrize(p)
        end
        
        def combat(m)
        end
        
        def applyBadConsequence(bad)
        end
        
        def makeTreasureVisible(t)
        end
        
        def canMakeTreasureVisible(t)
        end
        
        def discardVisibleTreasure(t)
            visibleTreasures.delete_at visibleTreasures.index(t)
        end
        
        def discardHiddenTreasure(t)
            hiddenTreasures.delete_at hiddenTreasures.index(t)
        end
        
        def buyLevels(visible,hidden)
        end
        
        def getCombatLevel
            @level
        end
        
        def validState
        end
        
        def initTreasures
        end
        
        def isDead
            @dead
        end
        
        def hasVisibleTreasures
        end
        
        def initialize(name)
            @dead = true
            @name = name
            @level = 0
            @hiddenTreasures = []
            @visibleTreasures = []
            @pendingBadConsequence = nil
        end

        
        def getVisibleTreasures
            @visibleTreasures.clone
        end
        
        def getHiddenTreasures
            @hiddenTreasures.clone
        end
    end
end
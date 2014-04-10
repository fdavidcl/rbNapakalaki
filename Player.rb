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
            @pendingBadConsequence = b.clone
        end
        
        def die
            @dead = true
        end
        
        def discardNecklaceVisible
            CardDealer.instance.giveTreasureBack @visibleTreasures.delete(NECKLACE)
        end
        
        def dieIfNoTreasures
            die if visibleTreasures.empty? && hiddenTreasures.empty?
        end
        
        def computeGoldCoinsValue(t)
            t.inject{|sum,x| sum += x.getGoldCoins} / 1000
        end
        
        def canIBuyLevels(l)
            @level + l < 10
        end
        
        public
        def applyPrize(p)
            incrementLevels (p.getLevels)
            
            for i in 1..[p.getLevels,4-hiddenTreasures.size].min
                hiddenTreasures << cardDealer.instance.nextTreasure
            end                
        end
        
        def combat(m)
        end
        
        def applyBadConsequence(bad)
            decrementLevels (bad.getLevels)
            pendingBad = bad.adjustToFitTreasureLists (visibleTreasures,hiddenTreasures)
            setPendingBadConsequence (pendingBadConsequence)
        end
        
        def makeTreasureVisible(t)
        end
        
        def canMakeTreasureVisible(t)
            if t == ONEHAND
                !@visibleTreasures.include?(BOTHHANDS) && @visibleTreasures.count(t) < 2
            elsif t == BOTHHANDS
                !@visibleTreasures.include?(ONEHAND) && !@visibleTreasures.include?(t)
            else
                !@visibleTreasures.include?(t)
            end
        end
        
        def discardVisibleTreasure(t)
            @visibleTreasures.delete_at @visibleTreasures.index(t)

            pendingBadConsequence.substractVisibleTreasure(t) if !validState

            CardDealer.instance.giveTreasureBack(t)

            dieIfNoTreasures
        end
        
        def discardHiddenTreasure(t)
            @hiddenTreasures.delete_at @hiddenTreasures.index(t)
        end
        
        def buyLevels(visible,hidden)
        end
        
        def getCombatLevel
            if @visibleTreasures.include?(NECKLACE)
                @visibleTreasures.inject(@level){ |sum,x| sum += x.getMaxBonus }
            else
                @visibleTreasures.inject(@level){ |sum,x| sum += x.getMinBonus }
            end
        end
        
        def validState
            @pendingBadConsequence.nil? || @pendingBadConsequence.isEmpty
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
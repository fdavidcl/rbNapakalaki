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
            @level = 1
            @hiddenTreasures = []
            @visibleTreasures = []
            @pendingBadConsequence = nil
        end

        private
        def bringToLife
            @dead = false
        end
        
        def incrementLevels(l)
            @level = [level+l,10].min
        end
        
        def decrementLevels(l)
            @level = [level-l, 1].max
        end
        
        def setPendingBadConsequence(b)
            # ¿Necesario clone?
            @pendingBadConsequence = b
        end
        
        def die
            visibleTreasures.map{|t| CardDealer.instance.giveTreasureBack t}
            visibleTreasures.clear
            hiddenTreasures.map{|t| CardDealer.instance.giveTreasureBack t}
            hiddenTreasures.clear
        end
        
        def discardNecklaceVisible
            visibleTreasures.each{|e| 
                if e.getType == NECKLACE
                    CardDealer.instance.giveTreasureBack e
                    visibleTreasures.delete(e)
                end
            }
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
            incrementLevels(p.getLevels)
            
            (1..[p.getTreasures,4-hiddenTreasures.size].min).each do
                hiddenTreasures << CardDealer.instance.nextTreasure
            end                
        end
        
        def combat(m)
            if getCombatLevel > m.getLevel
                prize = m.getPrize
                applyPrize(prize)
                result = level < 10 ? WIN : WINANDWINGAME
            elsif Dice.instance.nextNumber < 5
                bad = m.getBadConsequence
                if bad.kills 
                    die
                    result = LOSEANDDIE
                else 
                    applyBadConsequence(bad)
                    result = LOSE
                end
            else
                result = LOSEANDESCAPE
            end
            discardNecklaceVisible
            
            result
        end
        
        def applyBadConsequence(bad)
            decrementLevels bad.getLevels
            pendingBad = bad.adjustToFitTreasureLists(visibleTreasures,hiddenTreasures)
            setPendingBadConsequence pendingBadConsequence
        end
        
        def makeTreasureVisible(t)
            can = canMakeTreasureVisible t 
            @visibleTreasures << t if can
            can
        end
        
        def canMakeTreasureVisible(t)
            # Número mágico, debería haber una cte para cambiar el máximo de tesoros equipados
            vt = @visibleTreasures.collect{|e| e.getType}
            vt.size < 4 &&
            if t.getType == ONEHAND
                !vt.include?(BOTHHANDS) && vt.count(t.getType) < 2
            elsif t.getType == BOTHHANDS
                !vt.include?(ONEHAND) && !vt.include?(t.getType)
            else
                vt.include?(t.getType)
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
        
        def buyLevels(v,h)
            visible = v.clone
            hidden = h.clone
            
            levels = computeGoldCoinsValue(visible) + computeGoldCoinsValue(hidden)
            canI = canIBuyLevels(levels)
            
            if canI
                incrementLevels(levels)
                
                visible.map{|t| discardVisibleTreasure(t)}
                hidden.map{|t| discardHiddenTreasure(t)}
            end
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
            bringToLife
            number = Dice.instance.nextNumber
            
            if number == 1
                hiddenTreasures << CardDealer.instance.nextTreasure
            else
                limit = (number < 6 ? 2 : 3)
            
                limit.times {hiddenTreasures << CardDealer.instance.nextTreasure}
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
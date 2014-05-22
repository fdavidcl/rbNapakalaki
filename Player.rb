#!/usr/bin/env ruby
#encoding: utf-8

require_relative "Treasure"
require_relative "Dice"
require_relative "BadConsequence"
require_relative "CardDealer"
require_relative "CombatResult"

module Game
    # Clase que representa a un jugador
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
            @level = [@level+l,10].min
        end

        def decrementLevels(l)
            @level = [@level-l, 1].max
        end

        def setPendingBadConsequence(b)
            # ¿Necesario clone?
            @pendingBadConsequence = b
        end

        def die
            @level = 1
            @dead = true
            @visibleTreasures.map{|t| CardDealer.instance.giveTreasureBack t}
            @visibleTreasures.clear
            @hiddenTreasures.map{|t| CardDealer.instance.giveTreasureBack t}
            @hiddenTreasures.clear
        end

        def discardNecklaceIfVisible
            @visibleTreasures.each { |e|
                if e.getType == NECKLACE
                    CardDealer.instance.giveTreasureBack e
                    @visibleTreasures.delete(e)
                    break
                end
            }
        end

        def dieIfNoTreasures
            die if @visibleTreasures.empty? && @hiddenTreasures.empty?
        end

        def computeGoldCoinsValue(t)
            t.inject(0){|sum,x| sum += x.getGoldCoins} / 1000
        end

        def canIBuyLevels(l)
            @level + l < 10
        end

        def discardTreasure(list,t,m)
            if (i = list.index(t))
                list.delete_at i
                @pendingBadConsequence.method(m).call t if !validState
                CardDealer.instance.giveTreasureBack(t)
            end

            dieIfNoTreasures
        end

        public
        def applyPrize(p)
            incrementLevels(p.getLevels)

            [p.getTreasures,4-@hiddenTreasures.size].min.times do
                @hiddenTreasures << CardDealer.instance.nextTreasure
            end
        end

        def combat(m)
            if getCombatLevel > getOpponentLevel m
                prize = m.getPrize
                applyPrize(prize)
                result = @level < 10 ? WIN : WINANDWINGAME
            elsif Dice.instance.nextNumber < 5
                bad = m.getBadConsequence
                if bad.kills
                    die
                    result = LOSEANDDIE
                else
                    applyBadConsequence(bad)
                    result = (shouldConvert ? LOSEANDCONVERT : LOSE)
                end
            else
                result = LOSEANDESCAPE
            end
            discardNecklaceIfVisible

            result
        end

        def applyBadConsequence(bad)
            decrementLevels bad.getLevels
            pendingBad = bad.adjustToFitTreasureLists(@visibleTreasures, @hiddenTreasures)

            setPendingBadConsequence pendingBad
        end

        def makeTreasureVisible(t)
            can = canMakeTreasureVisible t
            if can
                @visibleTreasures << t
                discardHiddenTreasure t
            end
            can
        end

        def canMakeTreasureVisible(t)
            vt = @visibleTreasures.map(&:getType)

            @hiddenTreasures.member?(t) &&
                if t.getType == ONEHAND
                    !vt.include?(BOTHHANDS) && vt.count(ONEHAND) < 2
                elsif t.getType == BOTHHANDS
                    !vt.include?(ONEHAND) && !vt.include?(BOTHHANDS)
                else
                    !vt.include?(t.getType)
                end
        end

        def discardVisibleTreasure(t)
            discardTreasure(@visibleTreasures,t,:substractVisibleTreasure)
        end

        def discardHiddenTreasure(t)
            discardTreasure(@hiddenTreasures,t,:substractHiddenTreasure)
        end

        def buyLevels(v,h)
            visible = v.clone
            hidden = h.clone

            levels = computeGoldCoinsValue(visible) + computeGoldCoinsValue(hidden)
            canI = canIBuyLevels(levels)

            if canI
                incrementLevels(levels)

                visible.each {|t| discardVisibleTreasure(t)}
                hidden.each {|t| discardHiddenTreasure(t)}
            end

            canI
        end

        def getCombatLevel
            if @visibleTreasures.map(&:getType).include?(NECKLACE)
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

            if number > 1
                number < 6 ? 2 : 3
            else
                1
            end.times {@hiddenTreasures << CardDealer.instance.nextTreasure}
        end

        def isDead
            @dead
        end

        def getName
            @name
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
        
        def shouldConvert
            Dice.instance.nextNumber == 6
        end
        
        def getOpponentLevel(m)
            m.getBasicValue
        end
    end
end

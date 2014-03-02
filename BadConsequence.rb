#!/usr/bin/env ruby

require_relative "TreasureKind"

module Napakalaki
    class BadConsequence
        def initialize(text, second, nVisible = nil, nHidden = nil)
            @text = text

            if nVisible == nil && nHidden == nil
                @death = second
            else
                @levels = second
                @nVisibleTreasures = nVisible
                @nHiddenTreasures = nHidden
                @death = false
            end
        end

        def to_s
            result = text + ": "
            result += if death
                    "Death"
                else
                    "Levels = #{levels.to_s}, Visible treasures = #{nVisibleTreasures.to_s}, Hidden treasures = #{nHiddenTreasures.to_s}"
                end
        end

        attr_reader :text, :levels, :nVisibleTreasures, :nHiddenTreasures, :death 
    end
end
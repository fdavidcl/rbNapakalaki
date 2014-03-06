#!/usr/bin/env ruby -wKU

require_relative "TreasureKind"

module Napakalaki
    class BadConsequence
        def initialize(text, second, nVisible = nil, nHidden = nil)
            @text = text

            if nVisible == nil && nHidden == nil
                @death = second
                @levels = 0
                @visibleTreasures = 0
                @hiddenTreasures = 0
            else
                @levels = second
                @visibleTreasures = nVisible # Pueden ser enteros o arrays de símbolos (TreasureKind)
                @hiddenTreasures = nHidden
                @death = false
            end
        end

        def any_visible?
            visibleTreasures.class == [].class ? visibleTreasures.length > 0 : visibleTreasures > 0
        end

        def any_hidden?
            hiddenTreasures.class == [].class ? hiddenTreasures.length > 0 : hiddenTreasures > 0
        end

        def to_s
            result = text + ": "
            result += if death
                    "Muerte"
                else
                    # []*", " es un atajo para [].join(", ")
                    "Niveles: #{levels}, Tesoros visibles: " + (visibleTreasures.class == [].class ? visibleTreasures * ", " : visibleTreasures.to_s) +
                        ", Tesoros ocultos: " + (hiddenTreasures.class == [].class ? hiddenTreasures.join(", ") : hiddenTreasures.to_s)
                end
        end

        attr_reader :text, :levels, :visibleTreasures, :hiddenTreasures, :death 
    end
end
#!/usr/bin/env ruby -wKU

require_relative "TreasureKind"

module Napakalaki
    class BadConsequence
        def initialize(text, second, nVisible = nil, nHidden = nil)
            @text = text

            if nVisible == nil && nHidden == nil
                @death = second
            else
                @levels = second
                @visibleTreasures = nVisible # Pueden ser enteros o arrays de símbolos (TreasureKind)
                @hiddenTreasures = nHidden
                @death = false
            end
        end

        def to_s
            result = text + ": "
            result += if death
                    "Muerte"
                else
                    # []*", " es un atajo para [].join(", ")
                    "Niveles: #{levels}, Tesoros visibles: " + (visibleTreasures.class == [].class ? visibleTreasures * ", " : visibleTreasures) +
                        ", Tesoros ocultos: " + (hiddenTreasures.class == [].class ? hiddenTreasures.join(", ") : hiddenTreasures)
                end
        end

        attr_reader :text, :levels, :visibleTreasures, :hiddenTreasures, :death 
    end
end
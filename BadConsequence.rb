#!/usr/bin/env ruby -wKU

require_relative "TreasureKind"

module Napakalaki
    class BadConsequence
        def initialize(text, second, nVisible = 0, nHidden = 0)
            @text = text

            if nVisible == 0 && nHidden == 0
                @death = second
                @levels = 0
            else
                @levels = second
                @death = false
            end
            @visibleTreasures = nVisible # Pueden ser enteros o arrays de símbolos (TreasureKind)
            @hiddenTreasures = nHidden
        end

        def to_s
            result = text + ": "
            result += if death
                    "Muerte"
                else
                    # []*", " es un atajo para [].join(", ")  ----> Cambiados los dos a la primera forma        
                    "Niveles: #{levels}, Tesoros visibles: " + (visibleTreasures.class == [].class ? visibleTreasures * ", " : visibleTreasures.to_s) +
                    ", Tesoros ocultos: " + (hiddenTreasures.class == [].class ? hiddenTreasures * ", " : hiddenTreasures.to_s)
            end
        end

        attr_reader :text, :levels, :visibleTreasures, :hiddenTreasures, :death 
    end
end
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

            @visible_treasures = nVisible # Pueden ser enteros o arrays de símbolos (TreasureKind)
            @hidden_treasures = nHidden
        end

        def any_visible?
            visible_treasures.class == [].class ? visible_treasures.length > 0 : visible_treasures != 0
        end

        def any_hidden?
            hidden_treasures.class == [].class ? hidden_treasures.length > 0 : hidden_treasures != 0
        end

        def to_s
            result = text + ": "
            result += if death
                    "Muerte"
                else
                    visibles = visible_treasures.class == [].class ? visible_treasures * ", " : (visible_treasures > -1 ? visible_treasures.to_s : "Todos")
                    ocultos = hidden_treasures.class == [].class ? hidden_treasures * ", " : (hidden_treasures > -1 ? hidden_treasures.to_s : "Todos")
                    # []*", " es un atajo para [].join(", ")  ----> Cambiados los dos a la primera forma        
                    "Niveles: #{levels}, Tesoros visibles: #{visibles}, Tesoros ocultos: #{ocultos}"
                end
        end

        attr_reader :text, :levels, :visible_treasures, :hidden_treasures, :death 
    end
end
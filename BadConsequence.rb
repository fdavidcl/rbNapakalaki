#!/usr/bin/env ruby
#encoding: utf-8

requireRelative "TreasureKind"

module Game
    # Clase que representa el mal rollo de un monstruo
    class BadConsequence
        def initialize(text, death, levels, nVisible, nHidden, sVisible, sHidden)
            @text = text
            @death = death
            @levels = levels
            @nVisibleTreasures = nVisible
            @nHiddenTreasures = nHidden
            @specificVisibleTreasures = sVisible.clone
            @specificHiddenTreasures = sHidden.clone
        end

        # Constructor de malos rollos mortales
        def self.newDeathly(text)
            obj = allocate
            obj.send(:initialize, text, true, 0, 0, 0, [], [])
            obj
        end

        # Constructor de malos rollos con número de tesoros
        def self.newCount(text, levels, nVisible, nHidden)
            obj = allocate
            obj.send(:initialize, text, false, levels, nVisible, nHidden, [], [])
            obj
        end

        # Constructor de malos rollos con lista de tesoros
        def self.newKinds(text, levels, sVisible, sHidden)
            obj = allocate
            obj.send(:initialize, text, false, levels, 0, 0, sVisible, sHidden)
            obj
        end

        # Informa de si se pierde algún tesoro visible
        def isEmpty
            nVisibleTreasures == 0 && nHiddenTreasures == 0 &&
            specificVisibleTreasures.empty? && specificHiddenTreasures.empty?
        end

        def substractVisibleTreasure(t)
        end

        def substractHiddenTreasure(t)
        end

        def adjustToFitTreasureLists(v, h)
        end

        # Convierte el mal rollo en una cadena
        def to_s
            result = text + "; "
            result += 
                if death
                    "Muerte"
                else
                    visibles = 
                        if specificVisibleTreasures.any?
                            specificVisibleTreasures * ", "  # []*", " es un atajo para [].join(", ")
                        else
                            nVisibleTreasures == ALL_TREASURES ? "Todos" : nVisibleTreasures.toS
                        end
                    ocultos = 
                        if specificHiddenTreasures.any?
                            specificHiddenTreasures * ", "
                        else
                            nHiddenTreasures == ALL_TREASURES ? "Todos" : nHiddenTreasures.toS
                        end

                    "Niveles: #{levels}, Tesoros visibles: #{visibles}, Tesoros ocultos: #{ocultos}"
                end
        end

        attr_reader :text, :levels, :nVisibleTreasures, :nHiddenTreasures, :specificVisibleTreasures, :specificHiddenTreasures, :death
    end

    BadConsequence.instance_eval { undef :new }
end
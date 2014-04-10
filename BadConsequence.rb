#!/usr/bin/env ruby
#encoding: utf-8

require_relative "TreasureKind"

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

        # Informa de si el mal rollo está vacío
        def isEmpty
            @levels == 0 && !@death && @nVisibleTreasures == 0 && @nHiddenTreasures == 0 &&
            @specificVisibleTreasures.empty? && @specificHiddenTreasures.empty?
        end

        def kills
            @death
        end

        def getLevels
            @levels
        end
        
        def getNVisibleTreasures
            @nVisibleTreasures
        end
        
        def getNHiddenTreasures
            @nHiddenTreasures
        end
        
        def getSpecificHiddenTreasures
            @specificHiddenTreasures
        end
        
        def getSpecificVisibleTreasures
            @specificVisibleTreasures
        end
        
        def substractVisibleTreasure(t)
            specificVisibleTreasures.delete(t) ||
            (nVisibleTreasures -= 1 if !nVisibleTreasures.zero?)
        end

        def substractHiddenTreasure(t)
            specificHiddenTreasures.delete(t) || 
            (nHiddenTreasures -= 1 if !nHiddenTreasures.zero?)
        end

        def adjustToFitTreasureLists(vis, hid)
            lostvis = []
            losthid = []

            if specificVisibleTreasures.empty? && specificHiddenTreasures.empty?
                lostvis = vis[0 .. nVisibleTreasures - 1]
                losthid = hid[0 .. nHiddenTreasures - 1]
            else
                lostvis = vis.select { |e| specificVisibleTreasures.member? e }
                losthid = hid.select { |e| specificHiddenTreasures.member? e }
            end

            BadConsequence.newKinds(text, levels, lostvis, losthid)
        end

        # Convierte el mal rollo en una cadena
        def to_s
            result = @text + "; "
            result += 
                if kills
                    "Muerte"
                else
                    visibles = 
                        if @specificVisibleTreasures.any?
                            @specificVisibleTreasures * ", "  # []*", " es un atajo para [].join(", ")
                        else
                            @nVisibleTreasures < 0 ? "Todos" : @nVisibleTreasures.to_s
                        end
                    ocultos = 
                        if @specificHiddenTreasures.any?
                            @specificHiddenTreasures * ", "
                        else
                            @nHiddenTreasures < 0 ? "Todos" : @nHiddenTreasures.to_s
                        end

                    "Niveles: #{@levels}, Tesoros visibles: #{visibles}, Tesoros ocultos: #{ocultos}"
                end
        end
    end

    BadConsequence.instance_eval { undef :new }
end
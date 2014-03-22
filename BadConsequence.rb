#!/usr/bin/env ruby
#encoding: utf-8

require_relative "TreasureKind"

module Gams
    # Clase que representa el mal rollo de un monstruo
    class BadConsequence
        ALL_TREASURES = :all_treasures

        def initialize(text, death, levels, n_visible, n_hidden, s_visible, s_hidden)
            @text = text
            @death = death
            @levels = levels
            @n_visible_treasures = n_visible
            @n_hidden_treasures = n_hidden
            @specific_visible_treasures = s_visible.clone
            @specific_hidden_treasures = s_hidden.clone
        end

        # Constructor de malos rollos mortales
        def self.new_deathly(text)
            obj = allocate
            obj.send(:initialize, text, true, 0, 0, 0, [], [])
            obj
        end

        # Constructor de malos rollos con número de tesoros
        def self.new_count(text, levels, n_visible, n_hidden)
            obj = allocate
            obj.send(:initialize, text, false, levels, n_visible, n_hidden, [], [])
            obj
        end

        # Constructor de malos rollos con lista de tesoros
        def self.new_kinds(text, levels, s_visible, s_hidden)
            obj = allocate
            obj.send(:initialize, text, false, levels, 0, 0, s_visible, s_hidden)
            obj
        end

        # Informa de si se pierde algún tesoro visible
        def any_visible?
            n_visible_treasures != 0 or specific_visible_treasures.any?
        end

        # Informa de si se pierde algún tesoro oculto
        def any_hidden?
            n_hidden_treasures != 0 or specific_hidden_treasures.any?
        end

        # Convierte el mal rollo en una cadena
        def to_s
            result = text + "; "
            result += 
                if death
                    "Muerte"
                else
                    visibles = 
                        if specific_visible_treasures.any?
                            specific_visible_treasures * ", "  # []*", " es un atajo para [].join(", ")
                        else
                            n_visible_treasures == ALL_TREASURES ? "Todos" : n_visible_treasures.to_s
                        end
                    ocultos = 
                        if specific_hidden_treasures.any?
                            specific_hidden_treasures * ", "
                        else
                            n_hidden_treasures == ALL_TREASURES ? "Todos" : n_hidden_treasures.to_s
                        end

                    "Niveles: #{levels}, Tesoros visibles: #{visibles}, Tesoros ocultos: #{ocultos}"
                end
        end

        attr_reader :text, :levels, :n_visible_treasures, :n_hidden_treasures, :specific_visible_treasures, :specific_hidden_treasures, :death
        
    end

    BadConsequence.instance_eval { undef :new }
end
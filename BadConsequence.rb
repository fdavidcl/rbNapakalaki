#!/usr/bin/env ruby -wKU

require_relative "TreasureKind"

module Napakalaki
    class BadConsequence
        def initialize(text, second, n_visible = nil, n_hidden = nil)
            @text = text

            if n_visible.nil? && n_hidden.nil?
                @death = second
                @levels = 0
            else
                @levels = second
                @death = false
            end

            @visible_treasures = n_visible.nil? ? 0 : n_visible # Pueden ser enteros o arrays de símbolos de TreasureKind
            @hidden_treasures = n_hidden.nil? ? 0 : n_visible
        end

        def self.new_deathly(text)
            obj = allocate
            obj.send(:initialize, text, true)
            obj
        end

        def self.new_count(text, levels, n_visible, n_hidden)
            obj = allocate
            obj.send(:initialize, text, levels, n_visible, n_hidden)
            obj
        end

        def self.new_kinds(text, levels, n_visible, n_hidden)
            obj = allocate
            obj.send(:initialize, text, levels, n_visible, n_hidden)
            obj
        end

        def any_visible?
            (visible_treasures.class == [].class ? visible_treasures.length : visible_treasures) != 0
        end

        def any_hidden?
            (hidden_treasures.class == [].class ? hidden_treasures.length : hidden_treasures) != 0
        end

        def to_s
            result = text + ": "
            result += if death
                    "Muerte"
                else
                    # []*", " es un atajo para [].join(", ")
                    visibles = visible_treasures.class == [].class ? visible_treasures * ", " : (visible_treasures > -1 ? visible_treasures.to_s : "Todos")
                    ocultos = hidden_treasures.class == [].class ? hidden_treasures * ", " : (hidden_treasures > -1 ? hidden_treasures.to_s : "Todos")
                    "Niveles: #{levels}, Tesoros visibles: #{visibles}, Tesoros ocultos: #{ocultos}"
                end
        end

        attr_reader :text, :levels, :visible_treasures, :hidden_treasures, :death 
    end

    BadConsequence.instance_eval { undef :new }
end
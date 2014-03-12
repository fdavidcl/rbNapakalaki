#!/usr/bin/env ruby
#encoding: utf-8

require_relative "TreasureKind"

module Napakalaki
    TODOS = :todos
    class BadConsequence
        def initialize(text, second, n_visible = nil, n_hidden = nil)
            @text = text
            
            if not n_visible.nil? and not n_hidden.nil?
                @levels = second
                @death = false
                if n_visible.is_a?(Array) and n_hidden.is_a?(Array)
                    @n_visible_treasures = @n_hidden_treasures = 0
                    @specific_visible_treasures = n_visible
                    @specific_hidden_treasures = n_hidden
                else
                    @n_visible_treasures = n_visible
                    @n_hidden_treasures = n_hidden
                    @specific_visible_treasures = []
                    @specific_hidden_treasures = []
                end
            else
                @levels = 0
                @death = second
                @n_visible_treasures = @n_hidden_treasures = 0
                @specific_visible_treasures = []
                @specific_hidden_treasures = []
            end
            
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
            n_visible_treasures != 0 or specific_visible_treasures.any?
        end

        def any_hidden?
            n_hidden_treasures != 0 or specific_hidden_treasures.any?
        end

        def to_s
            result = text + ": "
            result += 
                if death
                    "Muerte"
                else
                    # []*", " es un atajo para [].join(", ")
                    visibles = 
                        if specific_visible_treasures.any?
                            specific_visible_treasures * ", "
                        else
                            (n_visible_treasures == TODOS ? "Todos" : n_visible_treasures.to_s)
                        end
                    ocultos = 
                        if specific_hidden_treasures.any?
                            specific_hidden_treasures * ", "
                        else
                            (n_hidden_treasures == TODOS ? "Todos" : n_hidden_treasures.to_s)
                        end
                    "Niveles: #{levels}, Tesoros visibles: #{visibles}, Tesoros ocultos: #{ocultos}"
                end
        end

        attr_reader :text, :levels, :n_visible_treasures, :n_hidden_treasures, :specific_visible_treasures, :specific_hidden_treasures, :death 
    end

    BadConsequence.instance_eval { undef :new }
end
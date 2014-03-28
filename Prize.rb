#!/usr/bin/env ruby
#encoding: utf-8

module Game
    # Clase que representa el buen rollo de un monstruo
    class Prize
        def initialize(treasures,levels)
            @treasures = treasures
            @levels = levels
        end
                
        def getTreasures
            @treasures
        end
        
        def getLevels
            @levels
        end
        
        # Pasa el buen rollo a una cadena de caracteres
        def to_s
            "Tesoros: #{getTreasures}, Niveles: #{getLevels}"
        end
        
    end
end
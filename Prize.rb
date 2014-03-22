#!/usr/bin/env ruby
#encoding: utf-8

module Game
    # Clase que representa el buen rollo de un monstruo
    class Prize
        def initialize(treasures,levels)
            @treasures = treasures
            @levels = levels
        end

        # Pasa el buen rollo a una cadena de caracteres
        def to_s
            "Tesoros: #{treasures}, Niveles: #{levels}"
        end
        
        attr_reader :treasures, :levels
        
        # Otra forma de implementar consultores:
        #
        # def treasures
        #     @treasures
        # end
        #
        # def levels
        #     @levels
        # end
    end
end
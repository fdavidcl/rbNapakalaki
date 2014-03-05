#!/usr/bin/env ruby -wKU

module Napakalaki
    class Prize
        def initialize(treasures,levels)
            @treasures = treasures
            @levels = levels
        end

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
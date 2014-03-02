#!/usr/bin/env ruby -wKU

require_relative "Prize.rb"
require_relative "BadConsequence.rb"
require_relative "Monster.rb"
require_relative "TreasureKind.rb"

module Napakalaki
    class PruebaNapakalaki
        #def self.main
            p=Prize.new(gets.to_i, gets.to_i)
            puts p.to_s
            m = BadConsequence.new "Muerte", true
            r = BadConsequence.new "Mal rollaco", 5, 0, 1
            puts m.to_s
            puts r.to_s

            # Falta prueba Monster
        #end
    end
end
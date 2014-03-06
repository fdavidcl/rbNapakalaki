#!/usr/bin/env ruby -wKU

require_relative "Prize.rb"
require_relative "BadConsequence.rb"
require_relative "Monster.rb"
require_relative "TreasureKind.rb"

module Napakalaki
    class PruebaNapakalaki

        def self.select_stronger(level, monsters)
            monsters.select { |m| m.level > level }
        end

        if __FILE__ == $0
            monsters = []
            vis_treasures = []
            hid_treasures = []

            vis_treasures.push HELMET
            monsters.push Monster.new("3 Byakhees de bonanza", 8, 
                BadConsequence.new("Pierdes tu armadura visible y otra oculta.",
                    0, vis_treasures, hid_treasures), 
                Prize.new(2, 1))
            monsters.push Monster.new("Test test", 12, 
                BadConsequence.new("Muertoooo", true), 
                Prize.new(2, 1))
            
            
            puts self.select_stronger(10, monsters)
        end
    end
end
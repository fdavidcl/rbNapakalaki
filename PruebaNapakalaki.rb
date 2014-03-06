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

        def self.select_level_takers(monsters)
            monsters.select { |m| 
                m.bad.levels > 0 and not m.bad.any_visible? and not m.bad.any_hidden?
            }
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
            monsters.push Monster.new("This guy takes levels", 11, 
                BadConsequence.new("Lotsa levels lost", 10, 0, 0), 
                Prize.new(0, 5))
            
            
            puts "*** Con nivel superior a 10 ***\n" + self.select_stronger(10, monsters) * "\n"
            puts "*** Solo restan niveles ***\n" + self.select_level_takers(monsters) * "\n"
        end
    end
end
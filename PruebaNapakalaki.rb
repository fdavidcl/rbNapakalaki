#!/usr/bin/env ruby -wKU

require_relative "Prize.rb"
require_relative "BadConsequence.rb"
require_relative "Monster.rb"
require_relative "TreasureKind.rb"

module Napakalaki
    class PruebaNapakalaki

        def self.filter_by_level(monsters, condition)
            filtered = []

            monsters.collect { |e| 
                if condition.call(e.level)
                    filtered.push(e)
                end
            }

            filtered
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
            
            puts self.filter_by_level(monsters, lambda{ |lv| lv > 10 })
        end
    end
end
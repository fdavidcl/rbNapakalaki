#!/usr/bin/env ruby
#encoding: utf-8

module Game
    # 
    class Treasure
        def initialize(name, gold, min, max, type)
            @name = name
            @goldCoins = gold
            @minBonus = @minBonus
            @maxBonus = @maxBonus
            @type = type
        end

        attr_reader :name, :goldCoins, :minBonus, :maxBonus, :type 
    end
end
#!/usr/bin/env ruby
#encoding: utf-8

module Game
	# 
	class Treasure
		def initialize(name, gold, min, max, type)
			@name = name
			@gold_coins = gold
			@min_bonus = @min_bonus
			@max_bonus = @max_bonus
			@type = type
		end

		attr_reader :name, :gold_coins, :min_bonus, :max_bonus, :type 
	end
end
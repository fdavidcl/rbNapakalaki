#!/usr/bin/env ruby
#encoding: utf-8

require "singleton"

module Game
    class CardDealer
    	include Singleton

    	def initialize
    		@unused_monsters = []
    		@used_monsters = []
    		@unused_treasures = []
    		@used_treasures = []
    	end

    	private
    	def init_treasure_card_deck
    	end

    	def init_monster_card_deck
    	end

    	def shuffle_treasures
    	end

    	def shuffle_monsters
    	end

    	public
    	def next_treasure
    	end

    	def next_monster
    	end

    	def give_treasure_back(t)
    	end

    	def give_monster_back(m)
    	end

    	def init_cards
    	end
	end
end
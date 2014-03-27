#!/usr/bin/env ruby
#encoding: utf-8

require_relative "Treasure", "Dice", "Bad_Consequence", "CardDealer", "CombatResult"
module "Game"

class Player
    def bring_to_life()
        dead = false
    end
    
    def incrementa_levels(l)
        level += l
    end
    
    def decrementa_levels(l)
        level -= l
    end
    
    def set_pending_bad_consequence(b)
        pending_bad_consequence=b
    end
    
    def die()
    end
    
    def discard_necklace_visible()
    end
    
    def die_if_no_treasures()
    end
    
    def compute_gold_coins_value()
    end
    
    def can_i_buy_levels(l)
    end
    
    private
    def apply_prize(p)
    end
    
    def combat (m)
    end
    
    def apply_bad_consequence(bad)
    end
    
    def make_treasure_visible(t)
    end
    
    def can_make_treasureVisible(t)
    end
    
    def discard_visible_treasure(t)
        visible_treasures.slice! visible_treasures.index(t)
    end
    
    def discard_hidden_treasure(t)
        hidden_treasures.slice! hidden_treasures.index(t)
    end
    
    def buy_levels(visible,hidden)
    end
    
    def get_combat_level()
        @level
    end
    
    def valid_state()
    end
    
    def init_treasures()
    end
    
    def isDead()
        @dead
    end
    
    def has_visible_treasures()
    end
    
    def initialize(name)
        @dead = true
        @name = name
        @level = 0
        @hidden_treasures = []
        @visible_treasures = []
        @pending_bad_consequence = nil
    end
    
    def get_visible_treasures()
        @visible_treasures.clone
    end
    
    def get_hidden_treasures()
        @hidden_treasures.clone
    end
end
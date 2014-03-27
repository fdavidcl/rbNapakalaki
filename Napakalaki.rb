#!/usr/bin/env ruby
#encoding: utf-8

require "singleton"

module Game
    # Clase 'singleton' que contiene el mecanismo del juego
    class Napakalaki
        include Singleton

        def initialize
            @current_monster = nil
            @current_player = nil
            @players = []
        end

        private
        def init_players(names)
        end

        def next_player
        end

        public
        def combat
        end

        def discard_visible_treasure(t)
        end

        def discard_hidden_treasure(t)
        end

        def make_treasure_visible(t)
        end

        def buy_levels(visible, hidden)
        end

        def init_game(players)
        end

        attr_reader :current_player, :current_monster

        def can_make_treasure_visible(t)
        end

        def visible_treasures
        end

        def hidden_treasures
        end

        def next_turn
        end

        def next_turn_allowed
        end

        def end_of_game(result)
        end
    end
end
#!/usr/bin/env ruby
#encoding: utf-8

require "singleton"

module Game
    # Clase 'singleton' que representa el dado
    class Dice
        include Singleton

        def next_number
            1 + Random.rand(6)
        end
    end
end
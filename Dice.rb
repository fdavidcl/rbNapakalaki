#!/usr/bin/env ruby
#encoding: utf-8

require "singleton"

module Game
    # Clase 'singleton' que representa el dado
    class Dice
        include Singleton

        def nextNumber
            Random.rand 1..6
        end
    end
end
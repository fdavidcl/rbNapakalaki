#!/usr/bin/env ruby
#encoding: utf-8

require_relative "Napakalaki"

module Game

    class Napakalaki_API   
        
        if __FILE__ == $0
            game = Napakalaki.instance
            
            # Descomentar
            #puts "Dame nombres de jugadores"
            #players = gets.chomp.split(" ")
            players = ["David","Nacho"]
            # Como mucho se permiten 3 jugadores (Guión Práctica 2)
            if players.empty? || players.size > 3
                raise "Necesito más de un jugador y menos de 4 para jugar"
            end
            
            game.initGame(players)
            
        end
    end
end

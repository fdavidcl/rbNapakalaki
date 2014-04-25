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
            
            # Como mucho se permiten 3 jugadores
            if players.empty? || players.size > 3
                raise "Necesito más de un jugador y menos de 4 para jugar"
            end
            
            
            game.initGame(players)
            
            begin
                puts "Jugador actual: #{game.getCurrentPlayer.instance_variable_get game.getCurrentPlayer.instance_variables[1]}"

                result = nil
            end while !game.endOfGame(result)
            
            
        end
    end
end

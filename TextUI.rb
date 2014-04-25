#!/usr/bin/env ruby
#encoding: utf-8

require_relative "Napakalaki"

module GameUI
    class TextUI
    	include Singleton
    	
    	private
    	def display
    		game = Game::Napakalaki.instance
    		puts "---- Napakalaki ----"
    		puts "Jugando: #{game.getCurrentPlayer.getName} (nivel #{game.getCurrentPlayer.getCombatLevel})"
    		puts "Luchando contra " + (game.getCurrentMonster ? 
    			"#{game.getCurrentMonster.getName} (nivel #{game.getCurrentMonster.getLevel})" : "Nadie")
    		
    		vis = game.getCurrentPlayer.getVisibleTreasures
    		if vis.empty?
    			puts "¡No tienes tesoros equipados!"
    		else
    			puts "Tienes estos tesoros equipados: #{vis}"
    		end

    		hid = game.getCurrentPlayer.getHiddenTreasures
    		if hid.empty?
    			puts "¡No tienes tesoros ocultos!"
    		else
    			puts "Tienes estos tesoros ocultos: #{game.getCurrentPlayer.getHiddenTreasures}"
    		end

    		puts "Si vences obtendrás: [#{game.getCurrentMonster.getPrize}]"
    		puts "Si pierdes: [#{game.getCurrentMonster.getBadConsequence}]"
    	end

    	public
        def play
            game = Game::Napakalaki.instance
            
# Descomentar
            #puts "Dame nombres de jugadores"
            #players = gets.chomp.split(" ")
            players = ["David","Nacho"]
            
            # Como mucho se permiten 3 jugadores
            if players.empty? || players.size > 3
                raise "Necesito entre 1 y 3 jugadores"
            end
            
            
            game.initGame(players)
            puts "---- Napakalaki ----\nLanzando los dados...\n\n"
            sleep 1

            begin
                display

	    		puts "¿Qué quieres hacer?"
	    		#options

                gets
                result = nil
            end while !game.endOfGame(result)
        end
    end

    
    TextUI.instance.play if __FILE__ == $0
end

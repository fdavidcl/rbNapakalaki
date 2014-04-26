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

        def inspectTreasures(treasures)
            treasures.each_with_index{ |t,i|
                puts " ¿Qué quieres saber del tesoro #{i}-ésimo: #{t.getName}? \n" +
                    " a) Monedas \n" +
                    " b) Bonus máximo\n" + 
                    " c) Bonus mínimo \n" +
                    " d) Tipo \n"
                
                while (what = gets)
                    what = what.chomp
                    
                    case what
                    when "a"
                        puts "Monedas: #{t.getGoldCoins}"
                    when "b"
                        puts "Bonus máximo: #{t.getMaxBonus}"
                    when "c"
                        puts "Bonus mínimo: #{t.getMinBonus}"
                    when "d"
                        puts "Tipo: #{t.getType}"
                    else
                        puts "Opción inválida"
                    end
                end
            }
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
                raise "Necesito más de un jugador y menos de 4 para jugar"
            end
            
            game.initGame(players)
            puts "---- Napakalaki ----\nLanzando los dados...\n\n"
            sleep 1
            
=begin
 Esquema de menú:
 
 Repite:
 
    Pide jugador
    Muestra opciones para dicho jugador:
        Ver tesoros visibles
        Ver tesoros invisibles
        Descartar tesoro visible
        Descartar tesoro invisible
        Comprar niveles
        Ver si puedes comprar niveles
    Lucha con monstruo
    Siguiente turno
 
 mientras jugador actual no haya ganado la partida
=end
            
            
            begin
            	player = game.getCurrentPlayer
            	
                display
                
                while true
                    puts "¿Qué quieres hacer? \n" + 
                        "a) Ver tesoros visibles \n" + 
                        "b) Ver tesoros invisibles \n" +
                        "c) Descartar tesoro visible \n" +
                        "d) Descartar tesoro invisible \n" +
                        "Opción:"
                    option = gets
                    option.nil? || option = option.chomp
                    
                    case option
                    when "a"
                        inspectTreasures player.getVisibleTreasures
                    when "b"
                        inspectTreasures player.getHiddenTreasures
                    when "c"
                        puts "Índice del tesoro a descartar"
                        i = gets.to_i
                        # Falta comprobación del índice
                        player.discardVisibleTreasure player.getVisibleTreasures[i]
                    when "d"
                        puts "Índice del tesoro a descartar"
                        i = gets.to_i
                        # Falta comprobación del índice
                        player.discardHiddenTreasure player.getHiddenTreasures[i]
                    else
                        break
                    end
                end
                
                result = nil
                
                if !game.endOfGame(result)
                    game.nextTurn
                else
                    puts "Ganador: #{name}"
                    break
                end
                
            end while true
            
        end
    end
    
    TextUI.instance.play if __FILE__ == $0
end

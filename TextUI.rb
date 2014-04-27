#!/usr/bin/env ruby
#encoding: utf-8

require_relative "Napakalaki"

module GameUI
    class TextUI
        include Singleton
        
        private
        def display(fight)
            game = Game::Napakalaki.instance
            puts "---- Napakalaki ----"
            puts "Jugando: #{game.getCurrentPlayer.getName} (nivel #{game.getCurrentPlayer.getCombatLevel})"
            
            if fight
                puts "Luchando contra " + (game.getCurrentMonster ? 
                                           "#{game.getCurrentMonster.getName} (nivel #{game.getCurrentMonster.getLevel})" : "Nadie")
                
                puts "Si vences obtendrás: [#{game.getCurrentMonster.getPrize}]"
                puts "Si pierdes: [#{game.getCurrentMonster.getBadConsequence}]"
            end
        end
        
        def inspectTreasures
            player = Game::Napakalaki.instance.getCurrentPlayer
            vis = player.getVisibleTreasures

            if vis.empty?
                puts "\t No tienes tesoros equipados!"
            else
                puts "\t Tienes estos tesoros equipados: #{vis}"
            end
            
            hid = player.getHiddenTreasures
            if hid.empty?
                puts "\t ¡No tienes tesoros ocultos!"
            else
                puts "\t Tienes estos tesoros ocultos: #{hid}"
            end
        end
        
        def discardTreasure(treasureList,method)
            begin
                print "\t Índice del tesoro a descartar: "
                i = gets.to_i
                
                raise "\t ¡Índice de tesoro inválido!" if i < 0 || i >= treasureList.size
                method.call treasureList[i]
                
            rescue Exception => e
                puts e.message
            end
        end
        
        def treasureSelect(treasures,type)
            result = []
            
            if !treasures.empty? 
                add_more = true
                
                while add_more
                    puts "\t ¿Qué tesoros #{type} quieres emplear? #{treasures}"
                    pattern = gets
                    
                    if !pattern.nil?
                        pattern.split(" ").each{|pattern|
                            result += treasures.select{|t| /#{pattern}/ =~ t.getName}
                            treasures -= result
                        }
                    end
                    
                    add_more = if treasures.empty?
                            false
                        else
                            print "\t Seleccionados hasta el momento: #{result}\n"\
                                  "\t ¿Quieres añadir más? (S/N): " 
                            /^S$/ === gets
                        end
                end    
            end
            
            result
        end
        
    	public
        def play
            game = Game::Napakalaki.instance
            
            puts "Dame nombres de jugadores"
            players = gets.chomp.split(" ")
            players = ["David","Nacho"]
            
            #Como mucho se permiten 3 jugadores
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
            
            game_over = false
            while !game_over
                player = game.getCurrentPlayer
                
                display(false)
                
                seguir = false
                while !seguir
                    puts "¿Qué quieres hacer? \n"\
                        " a) Ver inventario \n"\
                        " b) Descartar tesoro visible \n"\
                        " c) Descartar tesoro invisible \n"\
                        " d) Comprar niveles\n"\
                        " z) Seguir jugando\n"
                    print "Opción > "
                    option = gets
                    
                    option.nil? || option.chomp!
                    
                    case option
                    when "a"
                        inspectTreasures
                    when "b"
                        discardTreasure(player.getVisibleTreasures, game.method(:discardVisibleTreasure))
                    when "c"
                        discardTreasure(player.getHiddenTreasures, game.method(:discardHiddenTreasure))
                    when "d"
                        game.buyLevels(treasureSelect(player.getVisibleTreasures,"visibles"), 
                                       treasureSelect(player.getHiddenTreasures,"invisibles"))
                    when "z"
                    	seguir = true
                    else
                        puts "Opción #{option} inválida. Utiliza [z] para continuar jugando."
                    end
                end

                
                #game.buyLevels()

                #Comenzar lucha
                display(true)
                #...

                result = nil
                
                if !game.endOfGame(result)
                    game.nextTurn
                else
                    puts "Ganador: #{name}"
                    game_over = true
                end
                
            end
        end
    end
    
    TextUI.instance.play if __FILE__ == $0
end

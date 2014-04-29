#!/usr/bin/env ruby
#encoding: utf-8

require_relative "Napakalaki"

module GameUI
    class TextUI
        include Singleton
        
        private
        def getString
            print " > "
            gets
        end

        def getInt(min, max)
            begin
                print "(#{min}-#{max}) > "
                input = gets.to_i
            end until input >= min && input <= max
            input
        end

        def getChar(allowed)
            allowed.map!(&:upcase)
            begin
                print "(#{allowed*'/'}) > "
                input = gets.upcase[0]
            end until allowed.member?(input)
            input
        end

        def display(fight)
            game = Game::Napakalaki.instance

            system("clear") || system("cls") # Borramos la pantalla
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
                puts " ¡No tienes tesoros equipados!"
            else
                puts " Tienes estos tesoros equipados:\n\t" + vis*"\n\t"
            end
            
            hid = player.getHiddenTreasures
            if hid.empty?
                puts " ¡No tienes tesoros ocultos!"
            else
                puts " Tienes estos tesoros ocultos:\n\t" + hid*"\n\t"
            end
        end
        
        def discardTreasure(treasureList,method)
            print "\t Índice del tesoro a descartar: "
            i = getInt(1, treasureList.length) - 1
            
            method.call treasureList[i]
        end
        
        def treasureSelect(treasures,type)
            result = []
            
            add_more = !treasures.empty?
            
            while add_more
                puts "\t ¿Qué tesoros #{type} quieres emplear?"
                treasures.each_index { |i| puts "\t [#{i+1}] #{treasures[i]}"}
                    

=begin
                pattern = gets
                
                if !pattern.nil?
                    pattern.split(" ").each{|pattern|
# Esta técnica no es segura!! Estamos evaluando el patrón como regexp, esto puede dar fallos!
                        result += treasures.select{|t| /#{pattern}/ =~ t.getName}
                        treasures -= result
                    }
                end
=end                  

                index = getInt(1, treasures.length) - 1
                result << treasures.delete_at(index)

                add_more =
                    if treasures.empty?
                        false
                    else
                        puts "\t Seleccionados hasta el momento: #{result}\n"\
                              "\t ¿Quieres añadir más?" 
                        getChar(%w[s n]) == "S"
                    end
            end
            
            result
        end
        
    	public
        def play
            game = Game::Napakalaki.instance
            
            puts "Introduce los nombres de los jugadores (separados por espacios)"
            players = getString.chomp.split(" ")
            players = ["David","Nacho"]
            
            #Como mucho se permiten 3 jugadores
            raise "El número de jugadores debe estar entre 1 y 3." if players.empty? || players.size > 3
            
            game.initGame(players)
            #puts "---- Napakalaki ----\nLanzando los dados...\n\n"
            #sleep 1
            
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
        Hacer tesoro visible
    Lucha con monstruo
    Siguiente turno
 
 mientras jugador actual no haya ganado la partida
=end
            
            game_over = false
            while !game_over
                player = game.getCurrentPlayer
                
                seguir = false
                while !seguir
                    display(false)
                    puts "¿Qué quieres hacer? \n"\
                        " [1] Ver inventario \n"\
                        " [2] Descartar tesoro equipado \n"\
                        " [3] Descartar tesoro oculto \n"\
                        " [4] Comprar niveles\n"\
                        " [5] Equipar un tesoro\n"\
                        "*[0] Seguir jugando\n"
                    option = getInt(0,5)

                    case option
                    when 1
                        inspectTreasures
                    when 2
                        if player.getVisibleTreasures.any?
                            discardTreasure(player.getVisibleTreasures, game.method(:discardVisibleTreasure))
                        else
                            puts "¡No tienes tesoros equipados!"
                        end
                    when 3
                        discardTreasure(player.getHiddenTreasures, game.method(:discardHiddenTreasure))
                    when 4
                        game.buyLevels(treasureSelect(player.getVisibleTreasures,:equipados), 
                                       treasureSelect(player.getHiddenTreasures,:ocultos))
                    when 5
                        print "¿Qué tesoro oculto quieres equipar?"
                        # canMake it?
                        # ...
                    when 0
                    	seguir = true
                    else
                        puts "Opción #{option} inválida. Utiliza [0] para continuar jugando."
                    end

                    if !seguir
                        print "(Intro para continuar) > "
                        gets
                    end
                end

                
                #game.buyLevels()

                #Comenzar lucha
                display(true)
                    print " > "
                    gets
                game.combat

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

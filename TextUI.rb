#!/usr/bin/env ruby
#encoding: utf-8

require_relative "Napakalaki"

module GameUI
    class TextUI
        include Singleton
        
        private
        def getString
            print " > "
            gets || ""
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

        def pause
            print "(Intro para continuar) > "
            gets
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
        
        def discardTreasure(treasures,method,type)
            if treasures.empty?
                puts "¡No tienes tesoros #{type}!"
            else
                puts "\t Tesoros #{type}:"
                list treasures
                print "\t Índice del tesoro a descartar: "
                i = getInt(1, treasures.length) - 1
            
                method.call treasures[i]
            end
        end
        
        def treasureSelect(treasures,type)
            result = []
            
            add_more = !treasures.empty?
            
            while add_more
                puts "\t ¿Qué tesoros #{type} quieres emplear?"
                list treasures

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
        
        def makeVisible(treasures)
            game = Game::Napakalaki.instance
            
            if treasures.empty?
                puts "\t ¡No dispones de tesoros para equipar!"
            else
                list treasures
                print "\t Tesoro a equipar: "
                i = getInt(1,treasures.size) - 1
                
                # ¿Para qué sirve canMakeTreasureVisible, si makeTreasureVisible ya devuelve true o false?
                game.makeTreasureVisible treasures[i] or puts "\t No puedes hacer visible este tesoro"
            end
        end
        
        def list(treasures)
            treasures.each_with_index { |t,i| puts "\t [#{i+1}] #{t}"}
        end
        
        def printCombatResult(result)
            case result
            when Game::WINANDWINGAME
                puts "\t ---> Has ganado el juego"
            when Game::WIN
                puts "\t ---> Has ganado tu combate"
            when Game::LOSE
                puts "\t ---> Has perdido tu combate, tienes que cumplir un mal rollo"
            when Game::LOSEANDESCAPE
                puts "\t ---> Has perdido tu combate, pero has escapado a tiempo"
            when Game::LOSEANDDIE
                puts "\t ---> Has perdido tu combate, y el monstruo te ha matado"
            end 
        end
        
    	public
        def play
            game = Game::Napakalaki.instance
            
            puts "Introduce los nombres de los jugadores (separados por espacios)"
# Depuración
            #players = getString.chomp.split(" ")
# Depuración
            players = ["David","Nacho"]
            
            # Como mucho se permiten 3 jugadores
            raise "El número de jugadores debe estar entre 1 y 3." if players.empty? || players.size > 3
            
            game.initGame(players)

=begin
 Esquema de menú:
 
 Secuencia de juego según el guion:
    se lanzan los dados para conocer el primer jugador
    para cada jugador:
        (1er turno o muerto) lanza los dados para inicializar sus tesoros
        se obtiene el monstruo del mazo
            (nivel inferior) gana y se aplica el buen rollo
            (nivel superior) lanza el dado
                (sale 5/6) huye
                (sale <=4) pierde, se aplica el mal rollo
                    (muerte) pierde tesoros y queda con nivel 1
                    (no muerte) baja niveles y descarta tesoros
        (opt) descartar otros tesoros
        (opt) equipar tesoros
        (opt) comprar niveles
=end

            game_over = false
            while !game_over
                player = game.getCurrentPlayer
                
                fight = false
                while !fight
                    display(fight)
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
                        discardTreasure(player.getVisibleTreasures, game.method(:discardVisibleTreasure),:equipados)
                    when 3
                        discardTreasure(player.getHiddenTreasures, game.method(:discardHiddenTreasure),:ocultos)
                    when 4
                        game.buyLevels(treasureSelect(player.getVisibleTreasures,:equipados), 
                                       treasureSelect(player.getHiddenTreasures,:ocultos)) or 
                        puts "No puedes comprar tantos niveles"
                    when 5
                        makeVisible player.getHiddenTreasures
                    when 0
                    	fight = true
                    else
                        puts "Opción #{option} inválida. Utiliza [0] para continuar jugando."
                    end

                    if !fight
                        pause
                    end
                end

                #Comenzar lucha
                display(fight)
                    print " > "
                    gets
                    
                result = game.combat
                printCombatResult result
                pause
                
                if !game.endOfGame(result)
                    # ¿Qué debe hacer nextTurn si hay un mal rollo pendiente?
                    game.nextTurn
                else
                    puts "¡¡¡¡ Ganador: #{game.getCurrentPlayer.getName} !!!!"
                    game_over = true
                end
                
            end
        end
    end
    
    TextUI.instance.play if __FILE__ == $0
end

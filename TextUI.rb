#!/usr/bin/env ruby
#encoding: utf-8

require_relative "Napakalaki"

class String
    def bold
        "\e[1m#{self}\e[m"
    end
    
    def invert
        "\e[7m#{self}\e[m"
    end
    
    def red
        "\e[31m#{self}\e[m"
    end
end

module GameUI
    class TextUI
        include Singleton
        
        private
        def initialize
            @game = Game::Napakalaki.instance
        end
        
        def getString
            print " > "
            (gets || "").chomp
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
            print "\e[H\e[2J" # Secuencia de escape para borrar la pantalla
            puts "       Napakalaki       ".invert.bold
            puts "Jugando: #{game.getCurrentPlayer.getName} (nivel #{game.getCurrentPlayer.getCombatLevel})"
            
            if fight
                puts "Luchando contra " + (game.getCurrentMonster ? 
                                           "#{game.getCurrentMonster.getName} (nivel #{game.getCurrentMonster.getLevel})" : "Nadie")
                
                puts "Si vences obtendrás: [#{game.getCurrentMonster.getPrize}]"
                puts "Si pierdes: [#{game.getCurrentMonster.getBadConsequence}]"
            end
        end
        
        def inspectTreasures
            player = game.getCurrentPlayer
            treasures = {
                :equipados => player.getVisibleTreasures,
                :ocultos => player.getHiddenTreasures
            }

            treasures.each_key { |type|
                if treasures[type].empty?
                    puts "¡No tienes tesoros #{type}!"
                else
                    puts "Tienes estos tesoros #{type}:\n\t" + treasures[type]*"\n\t"
                end
            }
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
            
            if treasures.any?
                puts "¿Qué tesoros #{type} quieres emplear?".bold
                index = 1
                
                while index > 0
                    puts "Seleccionados hasta el momento: #{result}"
                    list treasures
                    puts "\t [0] Terminar selección"

                    index = getInt(0, treasures.length)
                    result << treasures.delete_at(index - 1) if index > 0
                end
            else
                puts "¡No tienes tesoros #{type}!"
            end
            
            result
        end
        
        def makeVisible(treasures)           
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
            puts "\t ---> " + 
                case result
                when Game::WINANDWINGAME
                    "Has ganado el juego" 
                when Game::WIN
                    "Has ganado tu combate" 
                when Game::LOSE
                    "Has perdido tu combate, tienes que cumplir un mal rollo" 
                when Game::LOSEANDESCAPE
                    "Has perdido tu combate, pero has escapado a tiempo"
                when Game::LOSEANDDIE
                    "Has perdido tu combate, y el monstruo te ha matado"
                end
        end
        
    	public
        def play
            
# Depuración
            #puts "Introduce los nombres de los jugadores (separados por espacios)"
            #players = getString.split(" ")
# Depuración
            players = ["David","Nacho"]
            
            # Como mucho se permiten 3 jugadores
            raise "El número de jugadores debe estar entre 1 y 3." if players.empty? || players.size > 3
            
            game.initGame(players)

            fight = false
            game_over = false
            
            while !game_over
                player = game.getCurrentPlayer

                # Pre-lucha: comprar niveles
                #while !fight
                    display(fight)
                    puts "Antes de luchar puedes comprar niveles."
                    if game.buyLevels(treasureSelect(player.getVisibleTreasures,:equipados), 
                                   treasureSelect(player.getHiddenTreasures,:ocultos))
                        puts "Has comprado los niveles"
                    else 
                        puts "No puedes comprar tantos niveles"
                    end
                    fight = true || getInt(0, 0) == 0

                #end

                # Comenzar lucha
                display(fight)
                    
                result = game.combat
                printCombatResult result
                pause

                # Post-lucha
                if !game.endOfGame(result)
                    while fight
                        display(!fight)
                        puts "¿Qué quieres hacer? \n"\
                            " [1] Ver inventario \n"\
                            " [2] Descartar tesoro equipado \n"\
                            " [3] Descartar tesoro oculto \n"\
                            " [4] Equipar un tesoro\n"\
                            "*[0] Seguir jugando\n"
                        option = getInt(0,4)

                        case option
                        when 1
                            inspectTreasures
                        when 2
                            discardTreasure(player.getVisibleTreasures, game.method(:discardVisibleTreasure),:equipados)
                        when 3
                            discardTreasure(player.getHiddenTreasures, game.method(:discardHiddenTreasure),:ocultos)
                        when 4
                            makeVisible player.getHiddenTreasures
                        when 0
                            fight = false
                        else
                            puts "Opción #{option} inválida. Utiliza [0] para continuar jugando."
                        end

                        if fight
                            pause
                        end
                    end
                    
                    while !game.nextTurn
                        # Estoy hasta la polla del puto mal rollo pendiente
                    end
                else
                    puts "¡¡¡¡ Ganador: #{game.getCurrentPlayer.getName} !!!!".bold
                    game_over = true
                end
            end
        end
        
        attr_reader:game
        
    end
    
    begin
        TextUI.instance.play if __FILE__ == $0
    rescue Interrupt =>e
        puts "\nEl juego se ha detenido".bold.red 
    end
        
end

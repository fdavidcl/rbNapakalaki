#!/usr/bin/env ruby
#encoding: utf-8

require_relative "Napakalaki"

module GameUI
    # Clase que proporciona la interfaz de usuario para el juego
    class TextUI
        include Singleton

        private
        def initialize
            @game = Game::Napakalaki.instance
        end

        def game
            @game
        end

        # Métodos de formato: Devuelven una string con el formato aplicado
        # a la inicial
        def bold(msg)
            "\e[1m#{msg}\e[m"
        end

        def invert(msg)
            "\e[7m#{msg}\e[m"
        end

        def red(msg)
            "\e[31m#{msg}\e[m"
        end

        # Métodos de entrada: Reciben una entrada válida del tipo especificado
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

        def pause
            print "(Intro para continuar) > "
            gets
        end

        # Mostrar estado del juego
        def display(fight)
            print "\e[H\e[2J" # Secuencia de escape para borrar la pantalla
            puts bold invert "       Napakalaki       "
            puts "Jugando: #{game.getCurrentPlayer.getName} (nivel "\
                "#{game.getCurrentPlayer.getCombatLevel})"

            if fight
                puts "Luchando contra #{game.getCurrentMonster.getName}"\
                    " (nivel #{game.getCurrentPlayer.getOpponentLevel(game.getCurrentMonster)})"

                puts "Si vences obtendrás: [#{game.getCurrentMonster.getPrize}]"
                puts "Si pierdes: [#{game.getCurrentMonster.getBadConsequence}]"
            end
        end

        # Métodos de consulta y modificación de tesoros
        def list(treasures)
            treasures.each_with_index { |t,i| puts "\t [#{i+1}] #{t}"}
        end

        def inspectTreasures
            player = game.getCurrentPlayer
            treasures = {
                :equipados => player.getVisibleTreasures,
                :ocultos => player.getHiddenTreasures
            }

            treasures.each_key{ |type|
                if treasures[type].empty?
                    puts "¡No tienes tesoros #{type}!"
                else
                    puts "Tienes estos tesoros #{type}:\n"
                    list treasures[type]
                end
            }
        end

        def selectTreasures(treasures, type, &condition)
            result = []

            if treasures.any?
                puts bold "¿Qué tesoros #{type} quieres emplear?"
                index = 1

                while index > 0 && treasures.any?
                    puts "Seleccionados hasta el momento: #{result}"
                    list treasures
                    puts "\t*[0] Terminar selección"

                    index = getInt(0, treasures.length)

                    if index > 0
                        if (condition.nil? || condition.call(treasures[index-1]))
                            result << treasures.delete_at(index - 1)
                        else
                            puts red "No puedes utilizar este tesoro."
                        end
                    end
                end
            else
                puts "¡No tienes tesoros #{type}!"
            end

            result
        end

        # Método de consulta de resultados de combate
        def combatResult(result)
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
            when Game::LOSEANDCONVERT
                "Has perdido tu combate, y te has convertido en sectario"
            end
        end

    	public

        # Permite probar AdjustToFitTreasureLists en varios casos
=begin
        def testAdjust
            b = Game::BadConsequence.newKinds(
                "Prueba Adjust v1", 0, [Game::ONEHAND,Game::ONEHAND,Game::ARMOR,Game::HELMET],
                [Game::ONEHAND,Game::ONEHAND])
            vis = [Game::Treasure.new("casco",0,0,0,Game::HELMET),
                Game::Treasure.new("mano",0,0,0,Game::ONEHAND)]
            hid = [Game::Treasure.new("mano",0,0,0,Game::ONEHAND)]
            puts b

            puts "Ajustando a... \nVisibles: #{vis} \nOcultos:#{hid}"
            # Debe haber sólo un onehand en visibles
            puts b.adjustToFitTreasureLists(vis,hid)

            hid << Game::Treasure.new("casco",0,0,0,Game::HELMET)
            hid << Game::Treasure.new("armadura",0,0,0,Game::ARMOR)

            puts "Ajustando a... \nVisibles: #{vis} \nOcultos:#{hid}"
            # El mal rollo quita menos tesoros visibles de los que tiene el jugador
            puts b.adjustToFitTreasureLists(vis,hid)

            hid = []
            puts "Ajustando a... \nVisibles: #{vis} \nOcultos:#{hid}"
            # El mal rollo no debe quitar tesoros visibles
            puts b.adjustToFitTreasureLists(vis,hid)

            vis = [Game::Treasure.new("dos manos",0,0,0,Game::BOTHHANDS)]
            hid = [Game::Treasure.new("dos manos",0,0,0,Game::BOTHHANDS)]
            puts "Ajustando a... \nVisibles: #{vis} \nOcultos:#{hid}"
            # El mal rollo debe quedar vacío
            puts b.adjustToFitTreasureLists(vis,hid)
        end
=end

        # Método de juego: Muestra menús e interactúa con el jugador
        def play
            puts "Introduce los nombres de los jugadores"
            players = []
            read = true

            # Como mucho se permiten 3 jugadores
            while read && players.length < 3
                name = getString
                if name != ""
                    players << name
                else
                    read = false
                end
            end

            raise "El número de jugadores debe estar entre 1 y 3." if players.empty?

            game.initGame(players)
            gameOver = false

            while !gameOver
                player = game.getCurrentPlayer

                # Pre-lucha: El jugador puede comprar niveles
                display false
                puts "Antes de luchar puedes comprar niveles."
                if !game.buyLevels(selectTreasures(player.getVisibleTreasures,:equipados),
                               selectTreasures(player.getHiddenTreasures,:ocultos))
                    puts "No puedes comprar tantos niveles"
                    pause
                end

                # Comenzar lucha
                display true

                result = game.combat
                puts "Resultado: " + bold(combatResult(result))
                pause

                # Post-lucha
                nextTurn = false

                if !game.endOfGame(result)
                    while !nextTurn
                        display false

                        # El jugador podría haber muerto tras descartarse tesoros
                        # o bien como resultado del combate
                        if player.isDead
                            puts (bold "¡Has muerto!") + " Revivirás en tu próximo turno "\
                                "con nuevos tesoros"
                            nextTurn = true
                            pause
                        else
                            # Mostramos un menú
                            puts (bold "¿Qué quieres hacer? \n") +
                                " [1] Ver inventario \n"\
                                " [2] Descartar tesoro equipado \n"\
                                " [3] Descartar tesoro oculto \n" +
                                (game.nextTurnAllowed ?
                                    " [4] Equipar un tesoro\n"\
                                    "*[0] Seguir jugando\n" :
                                    "*[0] Consultar mal rollo pendiente\n")

                            option = getInt(0, game.nextTurnAllowed ? 4 : 3)

                            case option
                            when 1 # Consulta de tesoros
                                inspectTreasures
                            when 2 # Descarte de tesoros equipados
                                selectTreasures(player.getVisibleTreasures, :equipados) { |t|
                                    game.discardVisibleTreasure t
                                    true # Para añadir el tesoro a la lista de seleccionados
                                }
                            when 3
                                selectTreasures(player.getHiddenTreasures, :equipados) { |t|
                                    game.discardHiddenTreasure t
                                    true
                                }
                            when 4 # Equipar un tesoro
                                if player.getHiddenTreasures.empty?
                                    puts "\t¡No dispones de tesoros para equipar!"
                                else
                                    selectTreasures(player.getHiddenTreasures, :ocultos) { |t|
                                        game.makeTreasureVisible(t)
                                    }
                                end
                            when 0 # Acción de continuar (si no hay mal rollo pendiente)
                                if game.nextTurnAllowed
                                    nextTurn = true
                                else
                                    puts "Mal rollo pendiente:\n\t#{game.getCurrentMonster.getBadConsequence}"
                                    puts bold "Descarta los tesoros correspondientes para poder seguir jugando."
                                end
                            else
                                puts "Opción #{option} inválida. Utiliza [0] para continuar jugando."
                            end

                            pause if !nextTurn
                        end
                    end

                    game.nextTurn
                else
                    puts bold "¡¡¡¡ Ganador: #{player.getName} !!!!"
                    gameOver = true
                end
            end
        end
    end

    begin
        TextUI.instance.play if __FILE__ == $0
    rescue Interrupt => e
        puts "\n\nEl juego se ha detenido"
    end

end

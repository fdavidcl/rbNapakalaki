#!/usr/bin/env ruby
#encoding: utf-8

require "singleton"
requireRelative "Monster", "Player", "CombatResult", "CardDealer"

module Game
    # Clase 'singleton' que contiene el mecanismo del juego
    class Napakalaki
        include Singleton

        def initialize
            @currentMonster = nil
            @currentPlayer = nil
            @players = []
        end

        private
        def initPlayers(names)
        end

        def nextPlayer
        end

        public
        def combat
        end

        def discardVisibleTreasure(t)
        end

        def discardHiddenTreasure(t)
        end

        def makeTreasureVisible(t)
        end

        def buyLevels(visible, hidden)
        end

        def initGame(players)
        end

        attr_reader :currentPlayer, :currentMonster

        def canMakeTreasureVisible?(t)
        end

        def visibleTreasures
        end

        def hiddenTreasures
        end

        def nextTurn
        end

        def nextTurnAllowed
        end

        def endOfGame(result)
        end
    end
    # Clase para el programa principal
    class PruebaNapakalaki
        # Muestra los monstruos de una lista por pantalla
        def self.display_monsters(monsters, msg)
            puts "\n*** #{msg} ***\n"
            puts monsters
        end

        # Devuelve los monstruos con nivel mayor que el especificado
        def self.stronger_than(level, monsters)
            monsters.select { |m| m.level > level }
        end
        
        # Devuelve los monstruos que solo restan niveles
        def self.level_takers(monsters)
            monsters.select { |m| 
                m.bad.levels > 0 and not m.bad.any_visible? and not m.bad.any_hidden?
            }
        end
        
        # Halla los monstruos que aportan un mínimo de niveles
        def self.prize_min_levels(min, monsters)
            monsters.select { |m| m.prize.levels >= min }
        end
        
        # Devuelve los monstruos que restan tesoros del tipo especificado
        def self.treasure_kind_takers(kind, monsters)
            monsters.select { |m|
                m.bad.specific_visible_treasures.member?(kind) or
                m.bad.specific_hidden_treasures.member?(kind)
            }
        end
        
        if __FILE__ == $0

            monsters = []
            treasures = []
            
            monsters << Monster.new("3 Byakhees de bonanza",8, BadConsequence.new_kinds(
                "Pierdes tu armadura visible y otra oculta",0,[ARMOR],[ARMOR]), Prize.new(2,1))
            
            monsters << Monster.new("Chibithulhu",2, 
                BadConsequence.new_kinds("Embobados con el lindo primigenio te descartas "\
                "de tu casco visible", 0, [HELMET], []), Prize.new(1,1))
                        
            monsters << Monster.new("El sopor de Dunwich",2, BadConsequence.new_kinds(
                "El primordial bostezo contagioso. Pierdes el calzado visible",0,
                [SHOE],[]), Prize.new(1,1))
            
            monsters << Monster.new("Ángeles de la noche ibicenca",14, BadConsequence.new_kinds(
                "Te atrapan para llevarte de fiesta y te dejan caer en mitad del vuelo. "\
                "Descarta 1 mano visible y 1 mano oculta", 0, [ONEHAND],[ONEHAND]), Prize.new(4,1))
            
            # ALL_TREASURES es una constante que identifica el caso de perder todos los niveles
            monsters << Monster.new("El gorrón en el umbral",10, BadConsequence.new_count(
                "Pierdes todos tus tesoros visibles",0,BadConsequence::ALL_TREASURES,0), Prize.new(3,1))
            
            monsters << Monster.new("H.P. Munchcraft",6, BadConsequence.new_kinds(
                "Pierdes la armadura visible",0,[ARMOR],[]), Prize.new(2,1))
            
            monsters << Monster.new("Bichgooth",2, BadConsequence.new_kinds(
                "Sientes bichos bajo la ropa. Descarta la armadura visible",0,[ARMOR],[]),
                Prize.new(1,1))
            
            monsters << Monster.new("El rey de rosa",13, BadConsequence.new_count(
                "Pierdes 5 niveles y 3 tesoros visibles",5,3,0), Prize.new(4,2))
            
            monsters << Monster.new("La que redacta en las sombras",3, BadConsequence.new_count(
                "Toses los pulmones y pierdes 2 niveles",2,0,0), Prize.new(1,1))
            
            monsters << Monster.new("Los hondos verdes",7, BadConsequence.new_deathly(
                "Estos monstruos resultan bastante superficiales y te aburren mortalmente. Estás muerto"),
                Prize.new(2,1))
            
            monsters << Monster.new("Semillas Cthulhu",4, BadConsequence.new_count(
                "Pierdes 2 niveles y 2 tesoros ocultos",2,0,2), Prize.new(2,1))
            
            monsters << Monster.new("Dameargo",1, BadConsequence.new_kinds(
                "Te intentas escaquear. Pierdes una mano visible",0,[ONEHAND],[]), 
                Prize.new(2,1))
            
            monsters << Monster.new("Pollipólipo volante",3, BadConsequence.new_count(
                "Da mucho asquito. Pierdes 3 niveles",3,0,0), Prize.new(1,1))
            
            monsters << Monster.new("Yskhtihyssg-Goth",12, BadConsequence.new_deathly(
                "No le hace gracia que pronuncien mal su nombre. Estás muerto"),
                Prize.new(3,1))
            
            monsters << Monster.new("Familia Feliz",1, BadConsequence.new_deathly(
                "La familia te atrapa. Estás muerto"), Prize.new(4,1))
            
            monsters << Monster.new("Roboggoth",8, BadConsequence.new_kinds(
                "La quinta directiva primaria te obliga a perder 2 niveles y un tesoro, 2 manos visible",
                0,[BOTHHANDS],[]), Prize.new(2,1))
            
            monsters << Monster.new("El espia ciego",4, BadConsequence.new_kinds(
                "Te asusta en la noche. Pierdes un casco visible",0,[HELMET],[]), 
                Prize.new(1,1))
            
            monsters << Monster.new("El lenguas",20, BadConsequence.new_count(
                "Menudo susto te llevas. Pierdes 2 niveles y 5 tesoros visibles",
                2,5,0), Prize.new(1,1))
            
            monsters << Monster.new("Bicéfalo",20, BadConsequence.new_count(
                "Te faltan manos para tanta cabeza. Pierdes 3 niveles y tus tesoros "\
                "visibles de las manos",3,BadConsequence::ALL_TREASURES,0), Prize.new(1,1))
            
            treasures << Treasure.new("¡Sí mi amo!",0,4,7,HELMET)
            treasures << Treasure.new("Botas de investigación",600,3,4,SHOE)
            treasures << Treasure.new("Capucha de Cthulhu",500,3,5,HELMET)
            treasures << Treasure.new("A prueba de babas verdes",400,3,5,ARMOR)
            treasures << Treasure.new("Botas de lluvia ácida", 800, 1, 1, BOTHHANDS)
            treasures << Treasure.new("Casco minero", 400, 2, 4, HELMET)
            treasures << Treasure.new("Ametralladora Thompson", 600, 4, 8, BOTHHANDS)
            treasures << Treasure.new("Camiseta de la UGR", 100, 1, 7, ARMOR)
            treasures << Treasure.new("Clavo de rail ferroviario", 400, 3, 6, ONEHAND)
            treasures << Treasure.new("Cuchillo de sushi arcano", 300, 2, 3, ONEHAND)
            treasures << Treasure.new("Fez alópodo", 700, 3, 5, HELMET)
            treasures << Treasure.new("Hacha prehistórica", 500, 2, 5, ONEHAND)
            treasures << Treasure.new("El aparato del Pr. Tesla", 900, 4, 8, ARMOR)
            treasures << Treasure.new("Gaita", 200, 1, 5, BOTHHANDS)
            treasures << Treasure.new("Insecticida", 300, 2, 3, ONEHAND)
            treasures << Treasure.new("Escopeta de 3 cañones", 700, 4, 6, BOTHHANDS)
            treasures << Treasure.new("Garabato místico", 300, 2, 2, ONEHAND)
            #treasures << Treasure.new("La fuerza de Mr.T", 1000, integer.MAX_VALUE, integer.MAX_VALUE, NECKLACE)
            treasures << Treasure.new("La rebeca metálica", 400, 2, 3, ARMOR)
            treasures << Treasure.new("Mazo de los antiguos", 200, 3, 4, ONEHAND)
            treasures << Treasure.new("Necro-playboycón", 300, 3, 5, ONEHAND)
            treasures << Treasure.new("Lanzallamas", 800, 4, 8, BOTHHANDS)
            treasures << Treasure.new("Necro-comicón", 100, 1, 1, ONEHAND)
            treasures << Treasure.new("Necronomicón", 800, 5, 7, BOTHHANDS)
            treasures << Treasure.new("Linterna a 2 manos", 400, 3, 6, BOTHHANDS)
            treasures << Treasure.new("Necro-gnomicón", 200, 2, 4, ONEHAND)
            treasures << Treasure.new("Necrotelecom", 300, 2, 3, HELMET)
            treasures << Treasure.new("Porra preternatural", 200, 2, 3, ONEHAND)
            treasures << Treasure.new("Tentáculo de pega", 200, 0, 1, HELMET)
            treasures << Treasure.new("Zapatilla deja-amigos", 500, 0, 1, SHOE)
            treasures << Treasure.new("Shogulador", 600, 1, 1, BOTHHANDS)
            treasures << Treasure.new("Varita de atizamiento", 400, 3, 4, ONEHAND)
            
            display_monsters(self.stronger_than(10, monsters),
                "Monstruos con nivel mayor que 10")
            display_monsters(self.level_takers(monsters),  
                "Monstruos que solo restan niveles")
            display_monsters(self.prize_min_levels(2, monsters),
                "Monstruos que dan mínimo 2 niveles")
            display_monsters(self.treasure_kind_takers(ARMOR, monsters),
                "Monstruos que quitan alguna armadura")
        end
    end
end
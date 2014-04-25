#!/usr/bin/env ruby
#encoding: utf-8

require "singleton"
require_relative "Treasure"

module Game
    class CardDealer
        include Singleton

        def initialize
            @unusedMonsters = []
            @usedMonsters = []
            @unusedTreasures = []
            @usedTreasures = []
        end

        private
        def initTreasureCardDeck
            @unusedTreasures << Treasure.new("¡Sí mi amo!",0,4,7,HELMET)
            @unusedTreasures << Treasure.new("Botas de investigación",600,3,4,SHOE)
            @unusedTreasures << Treasure.new("Capucha de Cthulhu",500,3,5,HELMET)
            @unusedTreasures << Treasure.new("A prueba de babas verdes",400,3,5,ARMOR)
            @unusedTreasures << Treasure.new("Botas de lluvia ácida", 800, 1, 1, BOTHHANDS)
            @unusedTreasures << Treasure.new("Casco minero", 400, 2, 4, HELMET)
            @unusedTreasures << Treasure.new("Ametralladora Thompson", 600, 4, 8, BOTHHANDS)
            @unusedTreasures << Treasure.new("Camiseta de la UGR", 100, 1, 7, ARMOR)
            @unusedTreasures << Treasure.new("Clavo de rail ferroviario", 400, 3, 6, ONEHAND)
            @unusedTreasures << Treasure.new("Cuchillo de sushi arcano", 300, 2, 3, ONEHAND)
            @unusedTreasures << Treasure.new("Fez alópodo", 700, 3, 5, HELMET)
            @unusedTreasures << Treasure.new("Hacha prehistórica", 500, 2, 5, ONEHAND)
            @unusedTreasures << Treasure.new("El aparato del Pr. Tesla", 900, 4, 8, ARMOR)
            @unusedTreasures << Treasure.new("Gaita", 200, 1, 5, BOTHHANDS)
            @unusedTreasures << Treasure.new("Insecticida", 300, 2, 3, ONEHAND)
            @unusedTreasures << Treasure.new("Escopeta de 3 cañones", 700, 4, 6, BOTHHANDS)
            @unusedTreasures << Treasure.new("Garabato místico", 300, 2, 2, ONEHAND)
            # Tesoro collar: No aporta niveles pero supone tomar el maxBonus de los demás
            @unusedTreasures << Treasure.new("La fuerza de Mr.T", 1000, 0, 0, NECKLACE)
            @unusedTreasures << Treasure.new("La rebeca metálica", 400, 2, 3, ARMOR)
            @unusedTreasures << Treasure.new("Mazo de los antiguos", 200, 3, 4, ONEHAND)
            @unusedTreasures << Treasure.new("Necro-playboycón", 300, 3, 5, ONEHAND)
            @unusedTreasures << Treasure.new("Lanzallamas", 800, 4, 8, BOTHHANDS)
            @unusedTreasures << Treasure.new("Necro-comicón", 100, 1, 1, ONEHAND)
            @unusedTreasures << Treasure.new("Necronomicón", 800, 5, 7, BOTHHANDS)
            @unusedTreasures << Treasure.new("Linterna a 2 manos", 400, 3, 6, BOTHHANDS)
            @unusedTreasures << Treasure.new("Necro-gnomicón", 200, 2, 4, ONEHAND)
            @unusedTreasures << Treasure.new("Necrotelecom", 300, 2, 3, HELMET)
            @unusedTreasures << Treasure.new("Porra preternatural", 200, 2, 3, ONEHAND)
            @unusedTreasures << Treasure.new("Tentáculo de pega", 200, 0, 1, HELMET)
            @unusedTreasures << Treasure.new("Zapatilla deja-amigos", 500, 0, 1, SHOE)
            @unusedTreasures << Treasure.new("Shogulador", 600, 1, 1, BOTHHANDS)
            @unusedTreasures << Treasure.new("Varita de atizamiento", 400, 3, 4, ONEHAND)
        end

        def initMonsterCardDeck
            @unusedMonsters << Monster.new("3 Byakhees de bonanza",8, BadConsequence.newKinds(
                "Pierdes tu armadura visible y otra oculta",0,[ARMOR],[ARMOR]), Prize.new(2,1))
            
            @unusedMonsters << Monster.new("Chibithulhu",2, 
                BadConsequence.newKinds("Embobados con el lindo primigenio te descartas "\
                "de tu casco visible", 0, [HELMET], []), Prize.new(1,1))
                        
            @unusedMonsters << Monster.new("El sopor de Dunwich",2, BadConsequence.newKinds(
                "El primordial bostezo contagioso. Pierdes el calzado visible",0,
                [SHOE],[]), Prize.new(1,1))
            
            @unusedMonsters << Monster.new("Ángeles de la noche ibicenca",14, BadConsequence.newKinds(
                "Te atrapan para llevarte de fiesta y te dejan caer en mitad del vuelo. "\
                "Descarta 1 mano visible y 1 mano oculta", 0, [ONEHAND],[ONEHAND]), Prize.new(4,1))
            
            @unusedMonsters << Monster.new("El gorrón en el umbral",10, BadConsequence.newCount(
                "Pierdes todos tus tesoros visibles",0, -1,0), Prize.new(3,1))
            
            @unusedMonsters << Monster.new("H.P. Munchcraft",6, BadConsequence.newKinds(
                "Pierdes la armadura visible",0,[ARMOR],[]), Prize.new(2,1))
            
            @unusedMonsters << Monster.new("Bichgooth",2, BadConsequence.newKinds(
                "Sientes bichos bajo la ropa. Descarta la armadura visible",0,[ARMOR],[]),
                Prize.new(1,1))
            
            @unusedMonsters << Monster.new("El rey de rosa",13, BadConsequence.newCount(
                "Pierdes 5 niveles y 3 tesoros visibles",5,3,0), Prize.new(4,2))
            
            @unusedMonsters << Monster.new("La que redacta en las sombras",3, BadConsequence.newCount(
                "Toses los pulmones y pierdes 2 niveles",2,0,0), Prize.new(1,1))
            
            @unusedMonsters << Monster.new("Los hondos verdes",7, BadConsequence.newDeathly(
                "Estos monstruos resultan bastante superficiales y te aburren mortalmente. Estás muerto"),
                Prize.new(2,1))
            
            @unusedMonsters << Monster.new("Semillas Cthulhu",4, BadConsequence.newCount(
                "Pierdes 2 niveles y 2 tesoros ocultos",2,0,2), Prize.new(2,1))
            
            @unusedMonsters << Monster.new("Dameargo",1, BadConsequence.newKinds(
                "Te intentas escaquear. Pierdes una mano visible",0,[ONEHAND],[]), 
                Prize.new(2,1))
            
            @unusedMonsters << Monster.new("Pollipólipo volante",3, BadConsequence.newCount(
                "Da mucho asquito. Pierdes 3 niveles",3,0,0), Prize.new(1,1))
            
            @unusedMonsters << Monster.new("Yskhtihyssg-Goth",12, BadConsequence.newDeathly(
                "No le hace gracia que pronuncien mal su nombre. Estás muerto"),
                Prize.new(3,1))
            
            @unusedMonsters << Monster.new("Familia Feliz",1, BadConsequence.newDeathly(
                "La familia te atrapa. Estás muerto"), Prize.new(4,1))
            
            @unusedMonsters << Monster.new("Roboggoth",8, BadConsequence.newKinds(
                "La quinta directiva primaria te obliga a perder 2 niveles y un tesoro, 2 manos visible",
                0,[BOTHHANDS],[]), Prize.new(2,1))
            
            @unusedMonsters << Monster.new("El espia ciego",4, BadConsequence.newKinds(
                "Te asusta en la noche. Pierdes un casco visible",0,[HELMET],[]), 
                Prize.new(1,1))
            
            @unusedMonsters << Monster.new("El lenguas",20, BadConsequence.newCount(
                "Menudo susto te llevas. Pierdes 2 niveles y 5 tesoros visibles",
                2,5,0), Prize.new(1,1))
            
            @unusedMonsters << Monster.new("Bicéfalo",20, BadConsequence.newCount(
                "Te faltan manos para tanta cabeza. Pierdes 3 niveles y tus tesoros "\
                "visibles de las manos",3, -1,0), Prize.new(1,1))
        end

        def shuffleTreasures
            @unusedTreasures.shuffle
        end

        def shuffleMonsters
            @unusedMonsters.shuffle
        end

        public
        def nextTreasure
            result = @unusedTreasures.shift
            @unusedTreasures, @usedTreasures = @usedTreasures, @unusedTreasures if @unusedTreasures.empty?
            # unusedTreasures = usedTreasures.slice!(0..usedTreasures.size-1) and shuffleTreasures if unusedTreasures.empty?
            result
        end

        def nextMonster
            result = @unusedMonsters.shift
            @unusedMonsters, @usedMonsters = @usedMonsters, @unusedMonsters if @unusedMonsters.empty?
            # unusedTreasures = usedT
            
            #@unusedMonsters = @usedMonsters.slice!(0..@usedMonsters.size-1) and shuffleMonsters if @unusedMonsters.empty?
            result
        end

        def giveTreasureBack(t)
            @usedTreasures << t
        end

        def giveMonsterBack(m)
            @usedMonsters << m
        end

        def initCards
            initMonsterCardDeck
            initTreasureCardDeck
        end
    end
end
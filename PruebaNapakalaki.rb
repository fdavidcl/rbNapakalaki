#!/usr/bin/env ruby -wKU

require_relative "Prize.rb"
require_relative "BadConsequence.rb"
require_relative "Monster.rb"
require_relative "TreasureKind.rb"

module Napakalaki
    class PruebaNapakalaki        
        def self.display_monsters(monsters, msg)
            puts "\n*** #{msg} ***\n"
            puts monsters
        end

        def self.stronger_than(level, monsters)
            monsters.select { |m| m.level > level }
        end
        
        def self.level_takers(monsters)
            monsters.select { |m| 
                m.bad.levels > 0 and not m.bad.any_visible? and not m.bad.any_hidden?
            }
        end
        
        def self.prize_min_levels(min, monsters)
            monsters.select { |m|
                m.prize.levels >= min
            }
        end
        
        def self.treasure_kind_takers(kind, monsters)
            monsters.select { |m|
                m.bad.visible_treasures.class == [].class && m.bad.visible_treasures.member?(kind) ||
                m.bad.hidden_treasures.class == [].class && m.bad.hidden_treasures.member?(kind)
            }

        end
        
        if __FILE__ == $0
            
            monsters = []

            monsters << Monster.new("Chibithulhu",2, 
                BadConsequence.new_kinds("Embobados con el lindo primigenio te descartas de tu casco visible",0,
                [HELMET],[]), Prize.new(1,1))
                        
            monsters << Monster.new("El sopor de Dunwich",2, BadConsequence.new_kinds(
                "El primordial bostezo contagioso. Pierdes el calzado visible",0,
                [SHOE],[]), Prize.new(1,1))
            
            monsters << Monster.new("Ángeles de la noche ibicenca",14, BadConsequence.new_kinds(
                "Te atrapan para llevarte de fiesta y te dejan caer en mitad del vuelo. Descarta 1 mano visible y 1 mano oculta",
                0, [ONEHAND],[ONEHAND]), Prize.new(4,1))
            
            # Nótese que perder totalidad tesoros == -1
            monsters << Monster.new("El gorrón en el umbral",10, BadConsequence.new_count(
                "Pierdes todos tus tesoros visibles",0,-1,0), Prize.new(3,1))
            
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
                "La familia te atrapa"), Prize.new(4,1))
            
            monsters << Monster.new("Roboggoth",8, BadConsequence.new_kinds(
                "La quinta directiva primaria te obliga a perder 2 niveles y un tesoro, 2 manos visible",
                0,[BOTHHANDS],[]), Prize.new(2,1))
            
            monsters << Monster.new("El espia ciego",3, BadConsequence.new_kinds(
                "Te asusta en la noche. Pierdes un casco visible",4,[HELMET],[]), 
                Prize.new(1,1))
            
            monsters << Monster.new("El lenguas",20, BadConsequence.new_count(
                "Menudo susto te llevas. Pierdes 2 niveles y 5 tesoros visibles",
                2,5,0), Prize.new(1,1))
            
            monsters << Monster.new("Bicéfalo",20, BadConsequence.new_kinds(
                "Te faltan manos para tanta cabeza. Pierdes 3 niveles y tus tesoros visibles de las manos",
                3,[BOTHHANDS],[]), Prize.new(1,1))
                
            display_monsters(self.stronger_than(10, monsters),
                "Monstruos con nivel mayor que 10")
            display_monsters(self.level_takers(monsters),  
                "Monstruos que solo restan niveles")
            display_monsters(self.prize_min_levels(2, monsters),
                "Monstruos que dan mínimo 2 niveles")
            display_monsters(self.treasure_kind_takers(:armor, monsters),
                "Monstruos que quitan alguna armadura")
        end
    end
end
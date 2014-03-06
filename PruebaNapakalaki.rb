#!/usr/bin/env ruby -wKU

require_relative "Prize.rb"
require_relative "BadConsequence.rb"
require_relative "Monster.rb"
require_relative "TreasureKind.rb"

module Napakalaki
    class PruebaNapakalaki
        
        def self.displayMonsters(monsters, msg)
            puts "\n*** #{msg} ***\n"
            puts monsters
        end
        
        #nombre de método modificado para coherencia con java
        def self.strongerThan(monsters, &condition)
            result = []
        
            # Collect se usa generalmente para modificar el array, mejor each
            monsters.each { |e| 
                if condition.call(e.level)
                    result.push(e)
                end
            }

            result
        end
        
        def self.levelTakers(monsters)
            result = []
            
            monsters.each { |e|
                bad=e.bad
                if ( bad.visibleTreasures.class==[].class ? 
                     (bad.visibleTreasures.length==0 and bad.hiddenTreasures.length==0)
                     : (bad.visibleTreasures==0 and bad.hiddenTreasures==0 and bad.levels>0) )      
                    
                    result.push(e)
                end
            }
            
            result
        end
        
        def self.prizeMinLevels(monsters, &condition)
            result = []
            
            monsters.each { |e|
                if condition.call(e.prize.levels)
                    result.push(e)
                end
            }
            
            result
        end
        
        def self.treasureTakers(monsters)
            result = []
            
            monsters.each{ |e|
                bad=e.bad;
                
                if ( bad.visibleTreasures.class==[].class ? 
                     (bad.visibleTreasures.length > 0 or bad.hiddenTreasures.length>0)
                     : (bad.visibleTreasures.class=="".class or bad.hiddenTreasures.class=="".class or
                        bad.visibleTreasures>0 or bad.hiddenTreasures>0 ))
                
                    result.push(e)
                end
            }
            
            result
        end
        
        if __FILE__ == $0
            
            monsters = []

            monsters.push(Monster.new("Chibithulhu",2, 
                BadConsequence.new("Embobados con el lindo primigenio te descartas de tu casco visible",0,
                [HELMET],[]), Prize.new(1,1))
            )
            
            monsters.push(Monster.new("El sopor de Dunwich",2, BadConsequence.new(
                "El primordial bostezo contagioso. Pierdes el calzado visible",0,
                [SHOE],[]), Prize.new(1,1))
            )
            monsters.push(Monster.new("Ángeles de la noche ibicenca",14, BadConsequence.new(
                "Te atrapan para llevarte de fiesta y te dejan caer en mitad del vuelo.
                 Descarta 1 mano visible y 1 mano oculta",0,
                [ONEHAND],[ONEHAND]), Prize.new(4,1))
            )
            # Nótese que perder totalidad tesoros == (string) "all"
            monsters.push(Monster.new("El gorrón en el umbral",10, BadConsequence.new(
                "Pierdes todos tus tesoros visibles",0,"all",0), Prize.new(3,1))
            )
            monsters.push(Monster.new("H.P. Munchcraft",6, BadConsequence.new(
                "Pierdes la armadura visible",0,[ARMOR],[]), Prize.new(2,1))
            )
            monsters.push(Monster.new("Bichgooth",2, BadConsequence.new(
                "Sientes bichos bajo la ropa. Descarta la armadura visible",0,[ARMOR],[]),
                    Prize.new(1,1))
            )
            monsters.push(Monster.new("El rey de rosa",13, BadConsequence.new(
                "Pierdes 5 niveles y 3 tesoros visibles",5,3,0), Prize.new(4,2))
            )
            monsters.push(Monster.new("La que redacta en las sombras",3, BadConsequence.new(
                "Toses los pulmones y pierdes 2 niveles",2,0,0), Prize.new(1,1))
            )
            monsters.push(Monster.new("Los hondos verdes",7, BadConsequence.new(
                "Estos monstruos resultan bastante superficiales y te aburren mortalmente.
                Estás muerto",true), Prize.new(2,1))
            )
            monsters.push(Monster.new("Semillas Cthulhu",4, BadConsequence.new(
                "Pierdes 2 niveles y 2 tesoros ocultos",2,0,2), Prize.new(2,1))
            )
            monsters.push(Monster.new("Dameargo",1, BadConsequence.new(
                "Te intentas escaquear. Pierdes una mano visible",0,[ONEHAND],[]), 
                Prize.new(2,1))
            )
            monsters.push(Monster.new("Pollipólipo volante",3, BadConsequence.new(
                "Da mucho asquito. Pierdes 3 niveles",3,0,0), Prize.new(1,1))
            )
            monsters.push(Monster.new("Yskhtihyssg-Goth",12, BadConsequence.new(
                "No le hace gracia que pronuncien mal su nombre. Estás muerto",true),
                Prize.new(3,1))
            )
            monsters.push(Monster.new("Familia Feliz",1, BadConsequence.new(
                "La familia te atrapa",true), Prize.new(4,1))
            )
            monsters.push(Monster.new("Roboggoth",8, BadConsequence.new(
                "La quinta directiva primaria te obliga a perder 2 niveles y un
                tesoro, 2 manos visible",0,[BOTHHANDS],[]), Prize.new(2,1))
            )
            monsters.push(Monster.new("El espia ciego",3, BadConsequence.new(
                "Te asusta en la noche. Pierdes un casco visible",4,[HELMET],[]), 
                Prize.new(1,1))
            )
            monsters.push(Monster.new("El lenguas",20, BadConsequence.new(
                "Menudo susto te llevas. Pierdes 2 niveles y 5 tesoros visibles",
                2,5,0), Prize.new(1,1))
            )
            monsters.push(Monster.new("Bicéfalo",20, BadConsequence.new(
                "Te faltan manos para tanta cabeza. Pierdes 3 niveles y tus tesoros
                visibles de las manos",3,[BOTHHANDS],[]), Prize.new(1,1))
            )
                
            displayMonsters(self.strongerThan(monsters) { |lv| lv > 10 },
                "Monstruos con nivel mayor que")
            displayMonsters(self.levelTakers(monsters),  
                "Monstruos que solo restan niveles")
            levels=10
            displayMonsters(self.prizeMinLevels(monsters) { |lv| lv >= levels },
                "Monstruos que dan mínimo #{levels} niveles")
            displayMonsters(self.treasureTakers(monsters),
                "Monstruos que quitan algún tesoro")
        end
    end
end
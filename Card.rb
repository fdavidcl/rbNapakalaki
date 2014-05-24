#!/usr/bin/env ruby
#encoding: utf-8

module Game
    module Card
        # Módulo que simula una interfaz:
        # Lanza una excepción si faltan métodos al incluir el módulo
        def self.included(klass)
            [:getBasicValue, :getSpecialValue].each { |m|
                raise NotImplementedError if !klass.method_defined?(m)
            }
        end
    end
end

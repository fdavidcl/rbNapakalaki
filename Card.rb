#!/usr/bin/env ruby
#encoding: utf-8

module Game
    module Card
        def getBasicValue
            raise NotImplementedError
        end

        def getSpecialValue
            raise NotImplementedError
        end
    end
end

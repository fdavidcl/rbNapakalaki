#!/usr/bin/env ruby
#encoding: utf-8

module Card
    def getBasicValue
        raise NotImplementedError
    end
    
    def getSpecialValue
        raise NotImplementedError
    end
end

#!/usr/bin/env ruby
#encoding: utf-8

module Card
    def getBasicValue
        raise new NotImplementedError
    end
    
    def getSpecialValue
        raise new NotImplementedError
    end
end

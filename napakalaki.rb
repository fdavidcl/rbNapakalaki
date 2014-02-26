class BadConsequence
  @text
  @levels
  @nVisibleTreasures
  @nHiddenTreasures
  @@death

  def initialize (text,leves=nil,nVisible=nil,nHidden=nil,death=nil)
    @text=text
    @levels=levels
    @nVisibleTreasures=nVisible
    @nHiddenTreasures=nHidden
    @death=death
  end

  attr_reader :text, :levels, :nVisibleTreasures, :nHiddenTreasures, :death
  
end


###############
class Prize
  @treasures
  @levels
  
  def initialize(treasures,levels)
    @treasures=treasures
    @levels=levels
  end
  
  attr_reader :treasures, :levels
  
end

###############

class TreasureKind
  AMOR=0
  ONEHAND=1
  BOTHHANDS=2
  HELMET=3
  SHOE=4
  NECKLACE=5
end


###############

p=Prize.new(gets.to_i, gets.to_i)
puts(p.levels + " niveles, " + p.treasures + " tesoros")

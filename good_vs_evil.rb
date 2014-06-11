#===============================================================================
# Good VS Evil --- RMXP Version
#===============================================================================
# Written by Synthesize
# Version 1.0.0
# January 26, 2008
#===============================================================================
#                            * RMXP Version *
#===============================================================================
module GoodVSEvil
  # The initial Alignment for actors
  Alignment_initial = {1 => 2, 2 => 3, 3 => -5}
  Alignment_initial.default = 0
  # The names of the alignments
  Alignment_names = ["Very Good", "Good", "Neutral", "Evil", "Devil Child"]
  # maximum amount of points
  Maximum_alignment = 100
  # Maximum amount of evil points
  Maximum_evil_alignment = -100
  # Format = {value => amount to check}
  Rates = {0 => 50, 1 => 25, 3 => -25, 4 => 50}
  # Rates configure how many Alignment points a character needs to have
  # there alignment 'upgrade'
  # $alignment commands:
  # $alignment.add(value, member)   # Adds value of alignment
  # $alignment.remove(value, member)   # Removes value from member
  # $alignment.checksum(amount, member)   # Check value of points then return
  # $alignment.checkname(member, name)   # Check if the alignment level is =name
end
#-------------------------------------------------------------------------------
# Create and set alignment points
#-------------------------------------------------------------------------------
class Game_Actor < Game_Battler
  attr_accessor :alignment
  attr_accessor :alignment_name
  alias syn_gve_setup setup
  #-----------------------------------------------------------------------------
  # Setup Actor Alignment
  #-----------------------------------------------------------------------------
  def setup(actor_id)
    syn_gve_setup(actor_id)
    @alignment = GoodVSEvil::Alignment_initial[actor_id]
    @alignment_name = "Neutral"
  end
  #-----------------------------------------------------------------------------
  # Return Alignment Values
  #-----------------------------------------------------------------------------
  def alignment_value
    @alignment = GoodVSEvil::Maximum_alignment if @alignment > GoodVSEvil::Maximum_alignment
    @alignment = GoodVSEvil::Maximum_evil_alignment if @alignment < GoodVSEvil::Maximum_evil_alignment
    if @alignment >= GoodVSEvil::Rates[1]
      @alignment_name = GoodVSEvil::Alignment_names[1]
      @alignment_name = GoodVSEvil::Alignment_names[0] if @alignment > GoodVSEvil::Rates[0]
      return @alignment_name
    elsif @alignment <= GoodVSEvil::Rates[3]
      @alignment_name = GoodVSEvil::Alignment_names[3]
      @alignment_name = GoodVSEvil::Alignment_names[4] if @alignment >= GoodVSEvil::Rates[4]
      return @alignment_name
    else
      @alignment_name = GoodVSEvil::Alignment_names[2]
      return @alignment_name
    end
  end
end
#-------------------------------------------------------------------------------
# Window_MenuStatus add-on
#-------------------------------------------------------------------------------
class Window_Status < Window_Base
  alias syn_gve_refresh refresh
  def refresh
    syn_gve_refresh
    self.contents.font.color = system_color
    self.contents.draw_text(330, 400, 120, 32, "Alignment:")
    self.contents.font.color = normal_color
    self.contents.draw_text(450, 400, 120, 32, @actor.alignment_value)
  end
end
#-------------------------------------------------------------------------------
# Alignment Management
#-------------------------------------------------------------------------------
class Alignment_Management
  def add(value, member)
    $game_party.actors[member].alignment += value
  end
  def remove(value, member)
    $game_party.actors[member].alignment -= value
  end
  def checksum(amount, member)
    if $game_party.actors[member].alignment >= amount
      return true
    else
      return false
    end
  end
  def checkname(member, name)
    if $game_party.actors[member].alignment_name == name
      return true
    else
      return false
    end
  end
end
#-------------------------------------------------------------------------------
# Scene_Title:: Create the Global Variable
#-------------------------------------------------------------------------------
class Scene_Title
  alias syn_gve_newgame command_new_game
  def command_new_game
    syn_gve_newgame
    $alignment = Alignment_Management.new
  end
end
#===============================================================================
#             * This script will not work with RPG Maker VX *
#===============================================================================
# Written by Synthesize
# Version 1.0.0
# January 26, 2008
#===============================================================================
# Good VS Evil --- RMXP Version
#===============================================================================
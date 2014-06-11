#===============================================================================
# Alignment Management Patch
#===============================================================================
# Written by Synthesize
# Version 1.0.0
# March 1, 2008
#===============================================================================
# GoodVSEvil is required for this to work
#===============================================================================
# What is it?
#-------------------------------------------------------------------------------
# This rewrites the Alignment Management class fixing a checksum bug and adding
# additional commands. I am doing it this way because I am much to lazy to make
# a new demo.
# $alignment.commands:
#   $alignment.
#             add_points(value, member, string)
#             remove_points(value, member)
#             check_points(amount, member, sign)
#             check_name(member, name, sign)
# Where:
# Value = numerical value (0-9) OR "all"
# Member = Party member position -1
# Amount = Value to check
# Sign = ">", "<", "=", "!"
# Name = string of information to check (ie."This is a string")
#===============================================================================
class Alignment_Management
  #-----------------------------------------------------------------------------
  # Add_Points:: Add points to the specified member. Use "all" for all members
  #-----------------------------------------------------------------------------
  def add_points(value, member)
    if member == "all"
      for i in 0...$game_party.members.size
        $game_party.members[i].alignment += value
      end
    else
      $game_party.members[member].alignment += value
    end
  end
  #-----------------------------------------------------------------------------
  # Remove Points
  #-----------------------------------------------------------------------------
  def remove_points(value, member)
    if member == "all"
      for i in 0...$game_party.members.size
        $game_party.members[i].alignmnt -= value
      end
    else
      add_points(-value, member)
    end
  end
  #-----------------------------------------------------------------------------
  # Checksum:: Check the values and return the outcome
  #-----------------------------------------------------------------------------
  def check_points(amount, member, sign)
    case sign
    when "="
      if $game_party.members[member].alignment == amount
        return true
      else
        return false
      end
    when ">"
      if $game_party.members[member].alignment >= amount
        return true
      else
        return false
      end
    when "<"
      if $game_party.members[member].alignment <= amount
        return true
      else
        return false
      end
    when "!"
      if $game_party.members[member].alignment != amount
        return true
      else
        return false
      end
    end
  end
  #-----------------------------------------------------------------------------
  # Check Name:: Check the alignment name
  #-----------------------------------------------------------------------------
  def check_name(member, name, sign)
    if name.is_a(Numeral)
      p "Please turn you numeral into a string ("")"
    end
    case sign
    when "="
      if $game_party.members[member].alignment_name == name
        return true
      else
        return false
      end
    when "!"
      if $game_party.memebrs[member].alignment_name != name
        return true
      else
        return false
      end
    end
  end
end
#===============================================================================
# This Alignment patch applies for RPG Maker VX
#===============================================================================
# Written by Synthesize
# Version 1.0.0
# March 1, 2008
#===============================================================================
# Alignment Management Patch
#===============================================================================
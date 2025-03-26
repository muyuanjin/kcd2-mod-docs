StashInventoryGenerator = {}

-- =========================================================
-- This function can only parse data collected by `StashInventoryCollector.GetStashInformation(stash)`
function StashInventoryGenerator.GetInventoryFromData(data)
   local result = ""

   if data.isMasterStash then
      return ""   -- hard exit, stashes shouldn't have inventory presets
   end

   if data.model.matches("") then
      result = "inventory_defaultJunk" -- everything has at least defaultJunk inventory
   end

   if data.contextLabel.matches("empty") then
      return "inventory_empty"   -- hard exit, stashes with empty label shouldn't have generated inventories
   end

-- =====EVERY STASH DEFAULT JUNK======

   if data.model.matches("chest_rustic_a") or data.model.matches("chest_rustic_b") or data.model.matches("chest_shabby_a") then

      result = "inventory_defaultJunk_default"
   end
   if data.model.matches("stash_pile_corner_a") or data.model.matches("stash_pile_corner_b") or data.model.matches("stash_pile_corner_c") or data.model.matches("stash_pile_wall_a") or data.model.matches("stash_pile_wall_b") or
      data.model.matches("stash_pile_wall_c") then

      result = "inventory_defaultJunk_pile"
   end
   if data.model.matches("sack_a") or data.model.matches("sack_a_interactive") or data.model.matches("sack_b") or data.model.matches("sack_b_interactive") or
      data.model.matches("barrel_a") or data.model.matches("barrel_a_interactive") or data.model.matches("barrel_b") or data.model.matches("barrel_b_interactive") or
      data.model.matches("barrel_c") or data.model.matches("barrel_c_interactive") then

      result = "inventory_defaultJunk_sack"

      if data.owners.containFactionID("kutnohorsko_settlements_kutnaHora") and
      (data.owners.containSocialClass("townsman") or data.owners.containSocialClass("nobleman") or data.owners.containSocialClass("merchant")
      or data.owners.containSocialClass("tailor") or data.owners.containSocialClass("horsetrader") or data.owners.containSocialClass("saddler") or data.owners.containSocialClass("innkeeper")) then

         result = "inventory_defaultJunk_junkBurgherSack"
      end
      if data.owners.containSocialClass("blacksmith") or data.owners.containSocialClass("weaponsmith") or data.owners.containSocialClass("armorer") then

         result = "inventory_defaultJunk_sackCrafter"
      end
      if data.owners.containSocialClass("apothecary") or data.owners.containSocialClass("healer") or data.owners.containSocialClass("herbalist") then

         result = "inventory_defaultJunk_sackHealer"
      end
   end
   if data.model.matches("stash_shelf_rustic_a") or data.model.matches("stash_shelf_shabby_e") then

      result = "inventory_defaultJunk_shelf"
      if data.owners.containSocialClass("blacksmith") or data.owners.containSocialClass("weaponsmith") or data.owners.containSocialClass("armorer") then

         result = "inventory_defaultJunk_shelfCrafter"
      end
      if data.owners.containSocialClass("apothecary") or data.owners.containSocialClass("healer") or data.owners.containSocialClass("herbalist") then

         result = "inventory_defaultJunk_shelfHealer"
      end
      if data.owners.containSocialClass("tailor") then

         result = "inventory_defaultJunk_shelfTailor"
      end
      if data.owners.containSocialClass("horsetrader") or data.owners.containSocialClass("saddler") then

         result = "inventory_defaultJunk_shelfHorseCarer"
      end
      if data.owners.containSocialClass("innkeeper") or data.owners.containSocialClass("bathhouseMaid") or data.owners.containSocialClass("bathhouseAbbess") or data.owners.containSocialClass("bartender") then

         result = "inventory_defaultJunk_shelfGastro"
      end
   end
   if data.model.matches("chest_fancy_a") or data.model.matches("chest_fancy_b") or data.model.matches("chest_fancy_c") or data.model.matches("chest_rustic_c") or data.model.matches("chest_rustic_d") then

      result = "inventory_defaultJunk_mid"
   end
   if data.model.matches("cabinet_rustic_e_heart") or data.model.matches("cabinet_rustic_a") or data.model.matches("cabinet_rustic_b") or data.model.matches("cabinet_rustic_c") or data.model.matches("cabinet_rustic_d") or
      data.model.matches("cabinet_rustic_f") or data.model.matches("cabinet_fancy_d") or data.model.matches("cabinet_fancy_d_wide") then

      result = "inventory_defaultJunk_noneChest_mid"
   end
   if data.model.matches("chest_fancy_d")  then
      result = "inventory_defaultJunk_high"
   end
   if data.model.matches("cabinet_fancy_c") or data.model.matches("cabinet_fancy_f") or data.model.matches("cabinet_fancy_g") then
      result = "inventory_defaultJunk_noneChest_high"
   end
   if data.model.matches("chest_royal_a") then

      result = "inventory_defaultJunk_highRoyal"
   end
   if data.model.matches("small") or data.model.matches("cabinet_fancy_a") or data.model.matches("cabinet_hanging_a")  or data.model.matches("crate_short_for_silver") or data.model.matches("cabinet_fancy_b")then

      result = "inventory_smallBox"
   end

-- =====ATTIC CONTEXT LABEL======
   if data.contextLabel.matches("attic") then
      if data.model.matches("") then

         result = "inventory_noneChest_attic"
      end
      if data.model.matches("chest_rustic_a") or data.model.matches("chest_rustic_b") or data.model.matches("chest_shabby_a") then

         result = "inventory_attic"
      end
      if data.model.matches("chest_fancy_a") or data.model.matches("chest_fancy_b") or data.model.matches("chest_fancy_c") or data.model.matches("chest_rustic_c") or data.model.matches("chest_rustic_d") then

         result = "inventory_attic_mid"
      end
      if data.model.matches("barrel_b") or data.model.matches("barrel_b_interactive") or data.model.matches("cabinet_rustic_a") or data.model.matches("cabinet_rustic_b") or
         data.model.matches("cabinet_rustic_c") or data.model.matches("cabinet_rustic_d") or data.model.matches("cabinet_rustic_f") or data.model.matches("cabinet_fancy_b") or
         data.model.matches("cabinet_fancy_d") or data.model.matches("cabinet_fancy_d_wide") or data.model.matches("sack_a") or data.model.matches("sack_a_interactive") or
         data.model.matches("stash_pile_wall_a") or data.model.matches("stash_pile_wall_b") or data.model.matches("stash_pile_wall_c") or data.model.matches("stash_shelf_rustic_a") or
         data.model.matches("stash_shelf_shabby_e") then

         result = "inventory_attic_noneChest_mid"
      end
      if data.model.matches("cabinet_fancy_c") or data.model.matches("cabinet_fancy_f") or data.model.matches("cabinet_fancy_g") then

         result = "inventory_attic_noneChest_high"
      end
      if data.model.matches("chest_royal_a") or data.model.matches("chest_fancy_d") then 

         result = "inventory_attic_high"
      end
    end
-- =====BARN CONTEXT LABEL======
   if data.contextLabel.matches("barn") then
      if data.model.matches("") then

         result = "inventory_noneChest_barn"
      end
      if data.model.matches("chest_rustic_a") or data.model.matches("chest_rustic_b") or data.model.matches("chest_shabby_a") then

         result = "inventory_barn"
      end
      if data.model.matches("chest_fancy_a") or data.model.matches("chest_fancy_b") or data.model.matches("chest_fancy_c") or data.model.matches("chest_rustic_c") or data.model.matches("chest_rustic_d") then

         result = "inventory_barn_mid"
      end
      if data.model.matches("barrel_b") or data.model.matches("barrel_b_interactive") or data.model.matches("cabinet_rustic_a") or data.model.matches("cabinet_rustic_b") or
         data.model.matches("cabinet_rustic_c") or data.model.matches("cabinet_rustic_d") or data.model.matches("cabinet_rustic_f") or data.model.matches("cabinet_fancy_b") or
         data.model.matches("cabinet_fancy_d") or data.model.matches("cabinet_fancy_d_wide") or data.model.matches("sack_a") or data.model.matches("sack_a_interactive") or
         data.model.matches("stash_pile_wall_a") or data.model.matches("stash_pile_wall_b") or data.model.matches("stash_pile_wall_c") or data.model.matches("stash_shelf_rustic_a") or
         data.model.matches("stash_shelf_shabby_e") or data.model.matches("stash_pile_corner_a") or data.model.matches("stash_pile_corner_b") or data.model.matches("stash_pile_corner_c") or
         data.model.matches("barrel_a") or data.model.matches("barrel_a_interactive") then

         result = "inventory_barn_noneChest_mid"
      end
      if data.model.matches("cabinet_fancy_c") or data.model.matches("cabinet_fancy_f") or data.model.matches("cabinet_fancy_g") then

         result = "inventory_household_noneChest_high"
      end
      if data.model.matches("chest_royal_a") or data.model.matches("chest_fancy_d") then 

         result = "inventory_barn_high"
      end
    end
-- =====BEDSIDE CONTEXT LABEL======
   if data.contextLabel.matches("bedside") then
      if data.model.matches("") then

         result = "inventory_bedside_noneChest"
      end
      if data.model.matches("chest_rustic_a") or data.model.matches("chest_rustic_b") or data.model.matches("chest_shabby_a") then

         result = "inventory_bedside"
      end
      if data.model.matches("chest_rustic_c") or data.model.matches("chest_rustic_d") then
         
         result = "inventory_bedsideRusticNice"
      end
      if data.model.matches("chest_fancy_b") or data.model.matches("chest_fancy_c") or data.model.matches("cabinet_rustic_e_heart") then
         
         result = "inventory_bedsideFancyRough"
      end
      if data.model.matches("chest_fancy_a") then
         
         result = "inventory_bedsideFancyNice"
      end
      if data.model.matches("chest_fancy_d") then
         
         result = "inventory_bedsideNobleMetal"
      end
      if data.model.matches("chest_royal_a") then
         
         result = "inventory_bedsideNobleRoyal"
      end
      if data.model.matches("cabinet_rustic_a") or data.model.matches("cabinet_rustic_b") or data.model.matches("cabinet_rustic_c") or data.model.matches("cabinet_rustic_d") or
      data.model.matches("cabinet_rustic_f") or data.model.matches("cabinet_fancy_b") or data.model.matches("cabinet_fancy_d") or data.model.matches("cabinet_fancy_d_wide") or
      data.model.matches("cabinet_fancy_c") or data.model.matches("cabinet_fancy_f") or data.model.matches("cabinet_fancy_g") then
         
         result = "inventory_bedsideFancyNiceNoWeapon"
      end
      if data.owners.containFactionID("zidovska") then
         
         result = "inventory_bedsideFancyRoughJewish"
      end
      if data.owners.containSocialClass("beggar") then
         
         result = "inventory_bedside_noneChest"
      end
      if data.owners.containFactionID("trosecko_outskirts") or data.owners.containFactionID("kutnohorsko_outskirts") or data.owners.containFactionID("trosecko_millers") or
      data.owners.containFactionID("kutnohorsko_millers") or data.owners.containFactionID("trosecko_settlements_slatejov")  or data.owners.containFactionID("kutnohorsko_settlements_certovka_commonFolk") then
         
         result = "inventory_bedside_loner"
      end
      if  data.model.matches("chest_") and (data.owners.containSocialClass("bandit") or data.owners.containSocialClass("ruffian") or data.owners.containSocialClass("cuman")) then
         
         result = "inventory_bedside_bandits"
      end
    end

-- =====CELLAR CONTEXT LABEL======
   if data.contextLabel.matches("cellar") then
      if data.model.matches("") then

         result = "inventory_noneChest_cellar"
      end
      if data.model.matches("chest_rustic_a") or data.model.matches("chest_rustic_b") or data.model.matches("chest_shabby_a") then

         result = "inventory_cellar"
      end
      if data.model.matches("barrel_b") or data.model.matches("barrel_b_interactive") or data.model.matches("chest_fancy_a") or data.model.matches("chest_fancy_b") or
         data.model.matches("chest_fancy_c") or data.model.matches("chest_rustic_c") or data.model.matches("chest_rustic_d") then

         result = "inventory_cellar_mid"
      end
      if data.model.matches("sack_b") or data.model.matches("sack_b_interactive") or data.model.matches("sack_a") or data.model.matches("sack_a_interactive") or data.model.matches("stash_pile_corner_a") or
         data.model.matches("stash_pile_corner_b") or data.model.matches("stash_pile_corner_c") or data.model.matches("stash_pile_wall_a") or data.model.matches("stash_pile_wall_b") or data.model.matches("stash_pile_wall_c") or
         data.model.matches("stash_shelf_rustic_a") or data.model.matches("stash_shelf_shabby_e") or data.model.matches("barrel_b") or data.model.matches("barrel_b_interactive") or
         data.model.matches("barrel_a") or data.model.matches("barrel_a_interactive") then

         result = "inventory_cellar_mid_sack"
      end
      if data.model.matches("cabinet_rustic_e_heart") or data.model.matches("cabinet_rustic_a") or data.model.matches("cabinet_rustic_b") or data.model.matches("cabinet_rustic_c") or
         data.model.matches("cabinet_rustic_d") or data.model.matches("cabinet_rustic_f") or data.model.matches("cabinet_fancy_b") or data.model.matches("cabinet_fancy_d") or
         data.model.matches("cabinet_fancy_d_wide") or data.model.matches("cabinet_fancy_c") or data.model.matches("cabinet_fancy_f") or data.model.matches("cabinet_fancy_g") then

         result = "inventory_cellar_cabinets"
      end
      if data.model.matches("chest_royal_a") or data.model.matches("chest_fancy_d") then 

         result = "inventory_cellar_high"
      end
      if data.model.matches("small") or data.model.matches("cabinet_fancy_a") or data.model.matches("cabinet_hanging_a") or data.model.matches("crate_short_for_silver") then 

         result = "inventory_smallBox_spices"
      end
    end
-- =====HOUSEHOLD CONTEXT LABEL======
   if data.contextLabel.matches("household") then
      if data.model.matches("") then

         result = "inventory_noneChest_household"
      end
      if data.model.matches("chest_rustic_a") or data.model.matches("chest_rustic_b") or data.model.matches("chest_shabby_a") then

         result = "inventory_household"
      end
      if data.model.matches("chest_fancy_a") or data.model.matches("chest_fancy_b") or data.model.matches("chest_fancy_c") or data.model.matches("chest_rustic_c") or data.model.matches("chest_rustic_d") then

         result = "inventory_household_mid"
      end
      if data.model.matches("cabinet_rustic_a") or data.model.matches("cabinet_rustic_b") or data.model.matches("cabinet_rustic_c") or data.model.matches("cabinet_rustic_d") or
         data.model.matches("cabinet_rustic_f") or data.model.matches("cabinet_fancy_d") or data.model.matches("cabinet_fancy_d_wide") or data.model.matches("cabinet_rustic_e_heart") then

         result = "inventory_household_noneChest_mid"
      end
      if data.model.matches("chest_royal_a") or data.model.matches("chest_fancy_d") then

         result = "inventory_household_high"
      end
      if data.model.matches("cabinet_fancy_c") or data.model.matches("cabinet_fancy_f") or data.model.matches("cabinet_fancy_g") then

         result = "inventory_household_noneChest_high"
      end
      if data.model.matches("sack_b") or data.model.matches("sack_b_interactive") or data.model.matches("sack_a") or data.model.matches("sack_a_interactive") then

         result = "inventory_householdJunkSmall"
      end
      if data.model.matches("stash_pile_corner_a") or data.model.matches("stash_pile_corner_b") or data.model.matches("stash_pile_corner_c") or data.model.matches("stash_pile_wall_a") or data.model.matches("stash_pile_wall_b") or
         data.model.matches("stash_pile_wall_c") or data.model.matches("stash_shelf_rustic_a") or data.model.matches("stash_shelf_shabby_e") then

         result = "inventory_householdJunk"
      end
      if data.model.matches("barrel_a") or data.model.matches("barrel_a_interactive") or data.model.matches("barrel_b") or data.model.matches("barrel_b_interactive") or data.model.matches("barrel_c") or
         data.model.matches("barrel_c_interactive") then
        
         result = "inventory_cellar_mid_sack" --meat in sacks is weired, same as meat in barrels in warmer environment as is here
      end
      if data.model.matches("small") or data.model.matches("cabinet_fancy_a") or data.model.matches("cabinet_hanging_a")  or data.model.matches("crate_short_for_silver") or data.model.matches("cabinet_fancy_b")then

         result = "inventory_noneChest_household_smallBox"
      end
            --  cabinet_fancy_b statys as preset for small boxes
    end
-- =====KITCHEN CONTEXT LABEL======
   if data.contextLabel.matches("kitchen") then
      if data.model.matches("") then

         result = "inventory_noneChest_kitchen"
      end
      if data.model.matches("chest_rustic_a") or data.model.matches("chest_rustic_b") or data.model.matches("chest_shabby_a") then

         result = "inventory_kitchen"
      end
      if data.model.matches("chest_fancy_a") or data.model.matches("chest_fancy_b") or data.model.matches("chest_fancy_c") or data.model.matches("chest_rustic_c") or data.model.matches("chest_rustic_d") then

         result = "inventory_kitchen_mid"
      end
      if data.model.matches("barrel_b") or data.model.matches("barrel_b_interactive") or data.model.matches("cabinet_rustic_a") or data.model.matches("cabinet_rustic_b") or
         data.model.matches("cabinet_rustic_c") or data.model.matches("cabinet_rustic_d") or data.model.matches("cabinet_rustic_f") or data.model.matches("cabinet_fancy_b") or
         data.model.matches("cabinet_fancy_d") or data.model.matches("cabinet_fancy_d_wide") then

         result = "inventory_kitchen_noneChest_mid"
      end
      if data.model.matches("barrel_a") or data.model.matches("barrel_a_interactive") or data.model.matches("cabinet_fancy_c") or data.model.matches("cabinet_fancy_f") or data.model.matches("cabinet_fancy_g") then

         result = "inventory_kitchen_high"
      end
      if data.model.matches("sack_b") or data.model.matches("sack_b_interactive") then

         result = "inventory_kitchen_sacks"
      end
      if data.model.matches("sack_a") or data.model.matches("sack_a_interactive") then

         result = "inventory_kitchen_mid_sacksPiles"
      end
      if data.model.matches("stash_pile_wall_a") or data.model.matches("stash_pile_wall_b") or data.model.matches("stash_pile_wall_c") or data.model.matches("stash_shelf_rustic_a") or
         data.model.matches("stash_shelf_shabby_e") or data.model.matches("stash_pile_corner_a") or data.model.matches("stash_pile_corner_b") or data.model.matches("stash_pile_corner_c") then

         result = "inventory_kitchen_high_sacksPiles"
      end
      if data.model.matches("chest_royal_a") or data.model.matches("chest_fancy_d") then

         result = "inventory_pantry_noble" -- taking from pantry presets
      end
      if data.model.matches("small") or data.model.matches("cabinet_fancy_a") or data.model.matches("cabinet_hanging_a") or data.model.matches("crate_short_for_silver") then

         result = "inventory_smallBox_spices"
      end
    end
-- =====LOOT CONTEXT LABEL======
   if data.contextLabel.matches("loot") then
      if data.model.matches("") then

         result = "inventory_noneChest_loot"
      end
      if data.model.matches("chest_rustic_a") or data.model.matches("chest_rustic_b") or data.model.matches("chest_shabby_a") then

         result = "inventory_loot"
      end
      if data.model.matches("stash_pile_corner_a") or data.model.matches("stash_pile_corner_b") or data.model.matches("stash_pile_corner_c") or data.model.matches("stash_pile_wall_a") or data.model.matches("stash_pile_wall_b") or
         data.model.matches("stash_pile_wall_c") or data.model.matches("stash_shelf_rustic_a") or data.model.matches("stash_shelf_shabby_e") or data.model.matches("barrel_b") or
         data.model.matches("barrel_b_interactive") or data.model.matches("barrel_a") or data.model.matches("barrel_a_interactive") then

         result = "inventory_lootLarge"
      end
      if data.model.matches("chest_fancy_a") or data.model.matches("chest_fancy_b") or data.model.matches("chest_fancy_c") or data.model.matches("chest_rustic_c") or data.model.matches("chest_rustic_d") then

         result = "inventory_loot_mid"
      end
      if data.model.matches("cabinet_rustic_a") or data.model.matches("cabinet_rustic_b") or data.model.matches("cabinet_rustic_c") or data.model.matches("cabinet_rustic_d") or
         data.model.matches("cabinet_rustic_f") or data.model.matches("cabinet_fancy_d") or data.model.matches("cabinet_fancy_d_wide") then

         result = "inventory_loot_noneChest_mid"
      end
      if data.model.matches("chest_fancy_d") then

         result = "inventory_loot_high"
      end
      if data.model.matches("chest_royal_a") then

         result = "inventory_loot_highRoyal"
      end
      if data.model.matches("cabinet_fancy_c") or data.model.matches("cabinet_fancy_f") or data.model.matches("cabinet_fancy_g") or data.model.matches("small") or data.model.matches("cabinet_fancy_a") or data.model.matches("cabinet_hanging_a") or data.model.matches("crate_short_for_silver") or data.model.matches("cabinet_fancy_b") then

         result = "inventory_smallBox_loot"
      end
    end
-- =====OFFICE CONTEXT LABEL======
   if data.contextLabel.matches("office") then
      if data.model.matches("") then

         result = "inventory_noneChest_office"
      end
      if data.model.matches("chest_rustic_a") or data.model.matches("chest_rustic_b") or data.model.matches("chest_shabby_a") then

         result = "inventory_office"
      end
      if data.model.matches("chest_fancy_a") or data.model.matches("chest_fancy_b") or data.model.matches("chest_fancy_c") or data.model.matches("chest_rustic_c") or data.model.matches("chest_rustic_d") then

         result = "inventory_office_mid"
      end
      if data.model.matches("cabinet_rustic_a") or data.model.matches("cabinet_rustic_b") or data.model.matches("cabinet_rustic_c") or data.model.matches("cabinet_rustic_d") or
         data.model.matches("cabinet_rustic_f") or data.model.matches("cabinet_fancy_b") or data.model.matches("cabinet_fancy_d") or data.model.matches("cabinet_fancy_d_wide") then

         result = "inventory_office_noneChest_mid"
      end
      if data.model.matches("chest_royal_a") or data.model.matches("chest_fancy_d") then

         result = "inventory_office_high"
      end
      if data.model.matches("cabinet_fancy_c") or data.model.matches("cabinet_fancy_f") or data.model.matches("cabinet_fancy_g") then

         result = "inventory_office_noneChest_high"
      end
      if data.model.matches("small") or data.model.matches("cabinet_fancy_a") or data.model.matches("cabinet_hanging_a") or data.model.matches("crate_short_for_silver") then

         result = "inventory_smallBox_office"
      end

      -- barrels, sacks piles do not have office preset and so should have the defaultJunk presets from the EVERY STASH DEFAULT JUNK rules
    end
-- =====PANTRY CONTEXT LABEL======
   if data.contextLabel.matches("pantry") then
      if data.model.matches("") then

         result = "inventory_noneChest_pantry"
      end
      if data.model.matches("chest_rustic_a") or data.model.matches("chest_rustic_b") or data.model.matches("chest_shabby_a") then

         result = "inventory_pantry"
      end
      if data.model.matches("chest_fancy_a") or data.model.matches("chest_fancy_b") or data.model.matches("chest_fancy_c") or data.model.matches("chest_rustic_c") or data.model.matches("chest_rustic_d") then

         result = "inventory_pantry_mid"
      end
      if data.model.matches("barrel_b") or data.model.matches("barrel_b_interactive") then

         result = "inventory_pantry_noneChest_mid"
      end
      if data.model.matches("barrel_a") or data.model.matches("barrel_a_interactive") then

         result = "inventory_pantry_high"
      end
      if data.model.matches("cabinet_fancy_c") or data.model.matches("cabinet_fancy_f") or data.model.matches("cabinet_fancy_g") or data.model.matches("cabinet_rustic_a") or
         data.model.matches("cabinet_rustic_b") or data.model.matches("cabinet_rustic_c") or data.model.matches("cabinet_rustic_d") or data.model.matches("cabinet_rustic_f") or
         data.model.matches("cabinet_fancy_b") or data.model.matches("cabinet_fancy_d") or data.model.matches("cabinet_fancy_d_wide") or data.model.matches("cabinet_rustic_e_heart") then

         result = "inventory_pantry_cabinets"
      end
      if data.model.matches("sack_a") or data.model.matches("sack_a_interactive") or data.model.matches("sack_b") or data.model.matches("sack_b_interactive") or data.model.matches("stash_pile_corner_a") or
         data.model.matches("stash_pile_corner_b") or data.model.matches("stash_pile_corner_c") or data.model.matches("stash_pile_wall_a") or data.model.matches("stash_pile_wall_b") or data.model.matches("stash_pile_wall_c") or
         data.model.matches("stash_shelf_rustic_a") or data.model.matches("stash_shelf_shabby_e") then

         result = "inventory_pantry_sacksPiles"
      end
      if data.model.matches("chest_royal_a") or data.model.matches("chest_fancy_d") then

         result = "inventory_pantry_noble"
      end
      if data.model.matches("small") or data.model.matches("cabinet_fancy_a") or data.model.matches("cabinet_hanging_a") or data.model.matches("crate_short_for_silver") then

         result = "inventory_smallBox_spices"
      end
    end
-- =====WORKSHOP CONTEXT LABEL======
   if data.contextLabel.matches("workshop") then
      if data.model.matches("") then

         result = "inventory_noneChest_workshop"
      end
      if data.model.matches("chest_rustic_a") or data.model.matches("chest_rustic_b") or data.model.matches("chest_shabby_a") then

         result = "inventory_workshop"
      end
      if data.model.matches("barrel_c") or data.model.matches("barrel_c_interactive") then

         result = "inventory_workshop_barrel"
      end
      if data.model.matches("chest_fancy_a") or data.model.matches("chest_fancy_b") or data.model.matches("chest_fancy_c") or data.model.matches("chest_rustic_c") or data.model.matches("chest_rustic_d") then

         result = "inventory_workshop_mid"
      end
      if data.model.matches("cabinet_rustic_a") or data.model.matches("cabinet_rustic_b") or data.model.matches("cabinet_rustic_c") or data.model.matches("cabinet_rustic_d") or
         data.model.matches("cabinet_rustic_f") or data.model.matches("cabinet_fancy_b") or data.model.matches("cabinet_fancy_d") or data.model.matches("cabinet_fancy_d_wide") or
         data.model.matches("stash_pile_wall_a") or data.model.matches("stash_pile_wall_b") or data.model.matches("stash_pile_wall_c") or data.model.matches("stash_shelf_rustic_a") or
         data.model.matches("stash_shelf_shabby_e") or data.model.matches("sack_a") or data.model.matches("sack_a_interactive") then

         result = "inventory_workshop_noneChest_mid"
      end
      if data.model.matches("barrel_b") or data.model.matches("barrel_b_interactive") then

         result = "inventory_workshop_mid_barrel"
      end
      if data.model.matches("cabinet_fancy_c") or data.model.matches("cabinet_fancy_f") or data.model.matches("cabinet_fancy_g") or data.model.matches("stash_pile_corner_a") or
         data.model.matches("stash_pile_corner_b") or data.model.matches("stash_pile_corner_c") then

         result = "inventory_workshop_noneChest_high"
      end
      if data.model.matches("barrel_a") or data.model.matches("barrel_a_interactive") then

         result = "inventory_workshop_high_barrel"
      end
      if data.model.matches("chest_royal_a") or data.model.matches("chest_fancy_d") then

         result = "inventory_workshop_noble"
      end
      if data.model.matches("small") or data.model.matches("cabinet_fancy_a") or data.model.matches("cabinet_hanging_a") or data.model.matches("crate_short_for_silver") then

         result = "inventory_smallBox_workshop"
      end
      if data.owners.containSocialClass("apothecary") or data.owners.containSocialClass("herbalist") or data.owners.containSocialClass("healer") then

         result = "inventory_workshop_potionStorage"

         if data.model.matches("sack_b") or data.model.matches("sack_b_interactive") or data.model.matches("stash_pile_corner_a") or data.model.matches("stash_pile_corner_b") or
         data.model.matches("stash_pile_wall_a") or data.model.matches("stash_pile_wall_b") or data.model.matches("stash_pile_wall_c") or data.model.matches("stash_shelf_rustic_a") or
         data.model.matches("stash_shelf_shabby_e") or data.model.matches("sack_a") or data.model.matches("sack_a_interactive") or data.model.matches("stash_pile_corner_c") then

            result = "inventory_workshop_herbalStorage"
         end
      end
      if data.owners.containSocialClass("tailor") then

         result = "inventory_workshop_tailorStorage"

         if data.model.matches("small") or data.model.matches("cabinet_fancy_a") or data.model.matches("cabinet_hanging_a") or data.model.matches("crate_short_for_silver") then

            result = "inventory_smallBox_office"
         end
      end
    end
-- =====SATCHELS======
   if data.model.matches("horse_saddle_bag_a") or data.model.matches("yellow_bag") then

      result = "inventory_satchel"
   end
-- =====VASES======
   if data.model.matches("dose_a") or data.model.matches("dose_b") or data.model.matches("jug_c_mead") or data.model.matches("jug_d") or data.model.matches("jug_e") or data.model.matches("jug_h") or
      data.model.matches("jug_i") or data.model.matches("vase_a") or data.model.matches("vase_b") or data.model.matches("vase_e") or data.model.matches("vase_f") then

      result = "inventory_vase"
   end

   return result

end

-- =========================================================
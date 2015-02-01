//Procedures in this file: Generic ribcage opening steps, Removing alien embryo, Fixing internal organs.
//////////////////////////////////////////////////////////////////
//				GENERIC	RIBCAGE SURGERY							//
//////////////////////////////////////////////////////////////////
/datum/surgery_step/ribcage
	priority = 2
	can_infect = 1
	blood_level = 1
	can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		return target_zone == "chest"

/datum/surgery_step/ribcage/saw_ribcage
	allowed_tools = list(
	/obj/item/weapon/circular_saw = 100, \
	/obj/item/weapon/hatchet = 75
	)

	min_duration = 50
	max_duration = 70

	can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		if (!ishuman(target))
			return 0
		var/datum/organ/external/affected = target.get_organ(target_zone)
		return ..() && target.op_stage.ribcage == 0 && affected.open >= 2

	begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		user.visible_message("[user] begins to cut through [target]'s ribcage with \the [tool].", \
		"You begin to cut through [target]'s ribcage with \the [tool].")
		target.custom_pain("Something hurts horribly in your chest!",1)
		..()

	end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		user.visible_message("\blue [user] has cut through [target]'s ribcage open with \the [tool].",		\
		"\blue You have cut through [target]'s ribcage open with \the [tool].")
		target.op_stage.ribcage = 1

	fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		user.visible_message("\red [user]'s hand slips, cracking [target]'s ribcage with \the [tool]!" , \
		"\red Your hand slips, cracking [target]'s ribcage with \the [tool]!" )
		var/datum/organ/external/affected = target.get_organ(target_zone)
		affected.createwound(CUT, 20)
		affected.fracture()


/datum/surgery_step/ribcage/retract_ribcage
	allowed_tools = list(
	/obj/item/weapon/retractor = 100, 	\
	/obj/item/weapon/crowbar = 75,	\
	/obj/item/weapon/kitchen/utensil/fork = 20
	)

	min_duration = 30
	max_duration = 40

	can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		return ..() && target.op_stage.ribcage == 1

	begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		var/msg = "[user] starts to force open the ribcage in [target]'s torso with \the [tool]."
		var/self_msg = "You start to force open the ribcage in [target]'s torso with \the [tool]."
		user.visible_message(msg, self_msg)
		target.custom_pain("Something hurts horribly in your chest!",1)
		..()

	end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		var/msg = "\blue [user] forces open [target]'s ribcage with \the [tool]."
		var/self_msg = "\blue You force open [target]'s ribcage with \the [tool]."
		user.visible_message(msg, self_msg)
		target.op_stage.ribcage = 2

		// Whoops!
		if(prob(10))
			var/datum/organ/external/affected = target.get_organ(target_zone)
			affected.fracture()

	fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		var/msg = "\red [user]'s hand slips, breaking [target]'s ribcage!"
		var/self_msg = "\red Your hand slips, breaking [target]'s ribcage!"
		user.visible_message(msg, self_msg)
		var/datum/organ/external/affected = target.get_organ(target_zone)
		affected.createwound(BRUISE, 20)
		affected.fracture()

/datum/surgery_step/ribcage/close_ribcage
	allowed_tools = list(
	/obj/item/weapon/retractor = 100, 	\
	/obj/item/weapon/crowbar = 75,	\
	/obj/item/weapon/kitchen/utensil/fork = 20
	)


	min_duration = 20
	max_duration = 40

	can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		return ..() && target.op_stage.ribcage == 2

	begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		var/msg = "[user] starts bending [target]'s ribcage back into place with \the [tool]."
		var/self_msg = "You start bending [target]'s ribcage back into place with \the [tool]."
		user.visible_message(msg, self_msg)
		target.custom_pain("Something hurts horribly in your chest!",1)
		..()

	end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		var/msg = "\blue [user] bends [target]'s ribcage back into place with \the [tool]."
		var/self_msg = "\blue You bend [target]'s ribcage back into place with \the [tool]."
		user.visible_message(msg, self_msg)

		target.op_stage.ribcage = 1

	fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		var/msg = "\red [user]'s hand slips, bending [target]'s ribcage in a wrong shape!"
		var/self_msg = "\red Your hand slips, bending [target]'s ribcage in a wrong shape!"
		user.visible_message(msg, self_msg)
		var/datum/organ/external/chest/affected = target.get_organ("chest")
		affected.createwound(BRUISE, 20)
		affected.fracture()
		if (prob(40))
			user.visible_message("\red Rib pierces the lung!")
			target.rupture_lung()

/datum/surgery_step/ribcage/mend_ribcage
	allowed_tools = list(
	/obj/item/weapon/bonegel = 100,	\
	/obj/item/weapon/screwdriver = 75
	)

	min_duration = 20
	max_duration = 40

	can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		return ..() && target.op_stage.ribcage == 1

	begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		var/msg = "[user] starts applying \the [tool] to [target]'s ribcage."
		var/self_msg = "You start applying \the [tool] to [target]'s ribcage."
		user.visible_message(msg, self_msg)
		target.custom_pain("Something hurts horribly in your chest!",1)
		..()

	end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		var/msg = "\blue [user] applied \the [tool] to [target]'s ribcage."
		var/self_msg = "\blue You applied \the [tool] to [target]'s ribcage."
		user.visible_message(msg, self_msg)

		target.op_stage.ribcage = 0
		
//////////////////////////////////////////////////////////////////
//					ALIEN EMBRYO SURGERY						//
//////////////////////////////////////////////////////////////////
/datum/surgery_step/ribcage/remove_embryo
	allowed_tools = list(
	/obj/item/weapon/hemostat = 100,	\
	/obj/item/weapon/wirecutters = 75,	\
	/obj/item/weapon/kitchen/utensil/fork = 20
	)
	blood_level = 2

	min_duration = 80
	max_duration = 100

	can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		var/embryo = 0
		for(var/obj/item/alien_embryo/A in target)
			embryo = 1
			break
		return ..() && embryo && target.op_stage.ribcage == 2

	begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		var/msg = "[user] starts to pull something out from [target]'s ribcage with \the [tool]."
		var/self_msg = "You start to pull something out from [target]'s ribcage with \the [tool]."
		user.visible_message(msg, self_msg)
		target.custom_pain("Something hurts horribly in your chest!",1)
		..()

	end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		user.visible_message("\red [user] rips the larva out of [target]'s ribcage!",
							 "You rip the larva out of [target]'s ribcage!")

		for(var/obj/item/alien_embryo/A in target)
			A.loc = A.loc.loc

//////////////////////////////////////////////////////////////////
//				CHEST INTERNAL ORGAN SURGERY					//
//////////////////////////////////////////////////////////////////
/datum/surgery_step/ribcage/fix_chest_internal
	allowed_tools = list(
	/obj/item/stack/medical/advanced/bruise_pack= 100,		\
	/obj/item/stack/medical/bruise_pack = 20,	\
	/obj/item/stack/medical/bruise_pack/tajaran = 70, 		\
	)

	min_duration = 70
	max_duration = 90

	can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		if (!ishuman(target))
			return 0
		var/is_chest_organ_damaged = 0
		var/datum/organ/external/chest/chest = target.get_organ("chest")
		for(var/datum/organ/internal/I in chest.internal_organs)
			if(I.damage > 0)
				is_chest_organ_damaged = 1
				break
		return ..() && is_chest_organ_damaged && target.op_stage.ribcage == 2

	begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		var/datum/organ/internal/heart/heart = target.internal_organs_by_name["heart"]
		var/datum/organ/internal/lungs/lungs = target.internal_organs_by_name["lungs"]
		var/datum/organ/internal/liver/liver = target.internal_organs_by_name["liver"]
		var/datum/organ/internal/liver/kidney = target.internal_organs_by_name["kidney"]

		if (istype(tool, /obj/item/stack/medical/advanced/bruise_pack))
			if(lungs.damage > 0)
				user.visible_message("[user] starts sealing the rupture in [target]'s lungs with regenerative membrane.", \
				"You start mending the rupture in [target]'s lungs with regenerative membrane." )
			if(heart.damage > 0)
				if(!heart.desc == "Mechanical")
					user.visible_message("[user] starts mending the bruises on [target]'s heart with regenerative membrane.", \
					"You start mending the bruises on [target]'s heart with regenerative membrane." )
				else
					user.visible_message("\blue [user] attempts to repair [target]'s mechanical heart with regenerative membrane...", \
					"\blue You attempt to repair [target]'s heart with regenerative membrane...")
			if(liver.damage > 0)
				user.visible_message("[user] starts mending the bruises on [target]'s liver with regenerative membrane.", \
				"You start mending the bruises on [target]'s liver with regenerative membrane." )
			if(kidney.damage > 0)
				user.visible_message("[user] starts mending the bruises on [target]'s kidney with regenerative membrane.", \
				"You start mending the bruises on [target]'s kidney with regenerative membrane." )
		if (istype(tool, /obj/item/stack/medical/bruise_pack))
			if (istype(tool, /obj/item/stack/medical/bruise_pack/tajaran/))
				if(lungs.damage > 0)
					user.visible_message("[user] starts covering the rupture in [target]'s lungs with the poultice.", \
					"You start covering the rupture in [target]'s lungs with the poultice." )
				if(heart.damage > 0)
					if(!heart.desc == "Mechanical")
						user.visible_message("[user] starts mending the bruises on [target]'s heart with the poultice.", \
						"You start mending the bruises on [target]'s heart with the poultice." )
					else
						user.visible_message("\blue [user] attempts to repair [target]'s mechanical heart with \the [tool]...", \
						"\blue You attempt to repair [target]'s heart with \the [tool]...")
				if(liver.damage > 0)
					user.visible_message("[user] starts putting the poultice to the bruises on [target]'s liver.", \
					"You start putting the poultice to the bruises on [target]'s liver." )
				if(kidney.damage > 0)
					user.visible_message("[user] starts putting the poultice to the bruises on [target]'s kidney.", \
					"You start putting the poultice to the bruises on [target]'s kidney." )
				if(lungs.damage > 0)
					user.visible_message("[user] starts mending the rupture in [target]'s lungs with \the [tool].", \
					"You start mending the rupture in [target]'s lungs \the [tool]." )
			else
				if(heart.damage > 0)
					if(!heart.desc == "Mechanical")
						user.visible_message("[user] starts mending the bruises on [target]'s heart with \the [tool].", \
						"You start mending the bruises on [target]'s heart with \the [tool]." )
					else
						user.visible_message("\blue [user] attempts to repair [target]'s mechanical heart with \the [tool]...", \
						"\blue You attempt to repair [target]'s heart with \the [tool]...")
				if(liver.damage > 0)
					user.visible_message("[user] starts mending the bruises on [target]'s liver with \the [tool].", \
					"You start mending the bruises on [target]'s liver with \the [tool]." )
				if(kidney.damage > 0)
					user.visible_message("[user] starts mending the bruises on [target]'s kidney with \the [tool].", \
					"You start mending the bruises on [target]'s kidney with \the [tool]." )
		target.custom_pain("The pain in your chest is living hell!",1)
		..()

	end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		var/datum/organ/internal/heart/heart = target.internal_organs_by_name["heart"]
		var/datum/organ/internal/lungs/lungs = target.internal_organs_by_name["lungs"]
		var/datum/organ/internal/liver/liver = target.internal_organs_by_name["liver"]
		var/datum/organ/internal/liver/kidney = target.internal_organs_by_name["kidney"]

		if(lungs.damage > 0)
			user.visible_message("\blue [user] mends the rupture in [target]'s lungs with \the [tool].", \
			"\blue You mend the rupture in [target]'s lungs with \the [tool]." )
			lungs.damage = 0

		if(heart.damage > 0)
			if(heart.desc == "Mechanical")
				user.visible_message("\blue [user] pokes [target]'s mechanical heart with \the [tool].", \
				"\red [target]'s heart is not organic, you cannot operate on it with \the [tool]!")
			else
				user.visible_message("\blue [user] treats the bruises on [target]'s heart with \the [tool].", \
				"\blue You treat the bruises on [target]'s heart with \the [tool]." )
				heart.damage = 0

		if(liver.damage > 0)
			user.visible_message("\blue [user] treats the bruises on [target]'s liver with \the [tool].", \
			"\blue You treats the bruises on [target]'s liver with \the [tool]." )
			liver.damage = 0

		if(kidney.damage > 0)
			user.visible_message("\blue [user] treats the bruises on [target]'s kidney with \the [tool].", \
			"\blue You treats the bruises on [target]'s kidney with \the [tool]." )
			kidney.damage = 0

	fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		var/datum/organ/internal/heart/heart = target.internal_organs_by_name["heart"]
		var/datum/organ/internal/lungs/lungs = target.internal_organs_by_name["lungs"]
		var/datum/organ/internal/liver/liver = target.internal_organs_by_name["liver"]
		var/datum/organ/internal/liver/kidney = target.internal_organs_by_name["kidney"]
		var/datum/organ/external/chest/affected = target.get_organ("chest")
		user.visible_message("\red [user]'s hand slips, getting mess and tearing the inside of [target]'s chest with \the [tool]!", \
		"\red Your hand slips, getting mess and tearing the inside of [target]'s chest with \the [tool]!")
		switch(tool)
			if(/obj/item/stack/medical/advanced/bruise_pack)
				if(heart.damage > 0)
					heart.take_damage(2, 0)
				if(liver.damage > 0)
					liver.take_damage(2, 0)
				if(kidney.damage > 0)
					kidney.take_damage(2, 0)
				if(lungs.damage > 0)
					lungs.take_damage(2, 0)
				target.adjustToxLoss(5)
			if(/obj/item/stack/medical/bruise_pack/tajaran)
				if(heart.damage > 0)
					heart.take_damage(2, 0)
				if(liver.damage > 0)
					liver.take_damage(2, 0)
				if(kidney.damage > 0)
					kidney.take_damage(2, 0)
				if(lungs.damage > 0)
					lungs.take_damage(2, 0)
				target.adjustToxLoss(7)
			if(/obj/item/stack/medical/bruise_pack)
				if(heart.damage > 0)
					heart.take_damage(5, 0)
				if(liver.damage > 0)
					liver.take_damage(5, 0)
				if(kidney.damage > 0)
					kidney.take_damage(5, 0)
				if(lungs.damage > 0)
					lungs.take_damage(5, 0)
				target.adjustToxLoss(10)
				affected.createwound(CUT, 5)


/datum/surgery_step/ribcage/fix_chest_internal_robot //For artificial organs
	allowed_tools = list(
	/obj/item/stack/nanopaste = 100,		\
	/obj/item/weapon/bonegel = 30, 		\
	/obj/item/weapon/screwdriver = 70,	\
	)

	min_duration = 70
	max_duration = 90

	can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		var/is_chest_organ_damaged = 0
		var/datum/organ/external/chest/chest = target.get_organ("chest")
		for(var/datum/organ/internal/I in chest.internal_organs) if(I.damage > 0)
			is_chest_organ_damaged = 1
			break
		return ..() && is_chest_organ_damaged && target.op_stage.ribcage == 2

	begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		var/datum/organ/internal/heart/heart = target.internal_organs_by_name["heart"]

		if(heart.damage > 0)
			if(heart.desc == "Mechanical")
				user.visible_message("[user] starts mending the mechanisms on [target]'s heart with \the [tool].", \
				"You start mending the mechanisms on [target]'s heart with \the [tool]." )
			else
				user.visible_message("[user] cannot mend an organic heart with this!")
				return
		target.custom_pain("The pain in your chest is living hell!",1)
		..()

	end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		var/datum/organ/internal/heart/heart = target.internal_organs_by_name["heart"]
		if(heart.damage > 0)
			if(heart.desc == "Mechanical")
				user.visible_message("\blue [user] repairs [target]'s heart with \the [tool].", \
				"\blue You repair [target]'s heart with \the [tool]." )
				heart.damage = 0

	fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		var/datum/organ/internal/heart/heart = target.internal_organs_by_name["heart"]
		user.visible_message("\red [user]'s hand slips, smearing [tool] in the incision in [target]'s heart, gumming it up!!" , \
		"\red Your hand slips, smearing [tool] in the incision in [target]'s heart, gumming it up!")
		heart.take_damage(5, 0)
		target.adjustToxLoss(5)

//////////////////////////////////////////////////////////////////
//						HEART SURGERY							//
//////////////////////////////////////////////////////////////////

/datum/surgery_step/ribcage/heart/cut
	allowed_tools = list(
	/obj/item/weapon/scalpel = 100,		\
	/obj/item/weapon/kitchenknife = 75,	\
	/obj/item/weapon/shard = 50, 		\
	)

	min_duration = 30
	max_duration = 40

	can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		return ..() && target.op_stage.ribcage == 2


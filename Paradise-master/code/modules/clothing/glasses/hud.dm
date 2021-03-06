/obj/item/clothing/glasses/hud
	name = "HUD"
	desc = "A heads-up display that provides important info in (almost) real time."
	flags = null //doesn't protect eyes because it's a monocle, duh
	origin_tech = "magnets=3;biotech=2"
	var/list/icon/current = list() //the current hud icons

	proc
		process_hud(var/mob/M)	return



/obj/item/clothing/glasses/hud/health
	name = "Health Scanner HUD"
	desc = "A heads-up display that scans the humans in view and provides accurate data about their health status."
	icon_state = "healthhud"

/obj/item/clothing/glasses/hud/health_advanced
	name = "Advanced Health Scanner HUD"
	desc = "A heads-up display that scans the humans in view and provides accurate data about their health status.  Includes anti-flash filter."
	icon_state = "advmedhud"

/obj/item/clothing/glasses/hud/health/night
	name = "Night Vision Health Scanner HUD"
	desc = "An advanced medical head-up display that allows doctors to find patients in complete darkness."
	icon_state = "healthhudnight"
	item_state = "glasses"
	darkness_view = 8

/obj/item/clothing/glasses/hud/health/process_hud(var/mob/M)
	process_med_hud(M,1)

/obj/item/clothing/glasses/hud/health_advanced/process_hud(var/mob/M)
	process_med_hud(M,1)


/obj/item/clothing/glasses/hud/security
	name = "Security HUD"
	desc = "A heads-up display that scans the humans in view and provides accurate data about their ID status and security records."
	icon_state = "securityhud"
	var/global/list/jobs[0]

/obj/item/clothing/glasses/hud/security/jensenshades
	name = "Augmented shades"
	desc = "Polarized bioneural eyewear, designed to augment your vision."
	icon_state = "jensenshades"
	item_state = "jensenshades"
	vision_flags = SEE_MOBS
	invisa_view = 2

/obj/item/clothing/glasses/hud/security/night
	name = "Night Vision Security HUD"
	desc = "An advanced heads-up display which provides id data and vision in complete darkness."
	icon_state = "securityhudnight"
	darkness_view = 8

/obj/item/clothing/glasses/hud/security/process_hud(var/mob/M)

	if(!M)	return
	if(!M.client)	return
	var/client/C = M.client
	for(var/mob/living/carbon/human/perp in view(get_turf(M)))
		if(M.see_invisible < perp.invisibility)
			continue
		if(!C) continue
		C.images += perp.hud_list[ID_HUD]
		C.images += perp.hud_list[WANTED_HUD]
		C.images += perp.hud_list[IMPTRACK_HUD]
		C.images += perp.hud_list[IMPLOYAL_HUD]
		C.images += perp.hud_list[IMPCHEM_HUD]

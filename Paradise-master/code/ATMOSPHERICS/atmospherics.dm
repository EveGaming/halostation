/*
Quick overview:

Pipes combine to form pipelines
Pipelines and other atmospheric objects combine to form pipe_networks
	Note: A single pipe_network represents a completely open space

Pipes -> Pipelines
Pipelines + Other Objects -> Pipe network

*/
/obj/machinery/atmospherics
	anchored = 1
	idle_power_usage = 0
	active_power_usage = 0
	power_channel = ENVIRON
	var/nodealert = 0
	
	layer = 2.4 //under wires with their 2.44	

	var/connect_types[] = list(1) //1=regular, 2=supply, 3=scrubber
	var/connected_to = 1 //same as above, currently not used for anything
	var/icon_connect_type = "" //"-supply" or "-scrubbers"
	
	var/initialize_directions = 0
	var/pipe_color
	
	var/global/datum/pipe_icon_manager/icon_manager

/obj/machinery/atmospherics/New()
	if(!icon_manager)
		icon_manager = new()
	
	if(!pipe_color)
		pipe_color = color
	color = null
	
	if(!pipe_color_check(pipe_color))
		pipe_color = null
	..()

/obj/machinery/atmospherics/attackby(atom/A, mob/user as mob)
	if(istype(A, /obj/item/device/pipe_painter))
		return
	..()

/obj/machinery/atmospherics/proc/add_underlay(var/turf/T, var/obj/machinery/atmospherics/node, var/direction, var/icon_connect_type)
	if(node)
		if(T.intact && node.level == 1 && istype(node, /obj/machinery/atmospherics/pipe))
			//underlays += icon_manager.get_atmos_icon("underlay_down", direction, color_cache_name(node))
			underlays += icon_manager.get_atmos_icon("underlay", direction, color_cache_name(node), "down" + icon_connect_type)
		else
			//underlays += icon_manager.get_atmos_icon("underlay_intact", direction, color_cache_name(node))
			underlays += icon_manager.get_atmos_icon("underlay", direction, color_cache_name(node), "intact" + icon_connect_type)
	else
		//underlays += icon_manager.get_atmos_icon("underlay_exposed", direction, pipe_color)
		underlays += icon_manager.get_atmos_icon("underlay", direction, color_cache_name(node), "exposed" + icon_connect_type)

/obj/machinery/atmospherics/proc/update_underlays()
	if(check_icon_cache())
		return 1
	else
		return 0

obj/machinery/atmospherics/proc/check_connect_types(obj/machinery/atmospherics/atmos1, obj/machinery/atmospherics/atmos2)
	var/i
	var/list1[] = atmos1.connect_types
	var/list2[] = atmos2.connect_types
	for(i=1,i<=list1.len,i++)
		var/j
		for(j=1,j<=list2.len,j++)
			if(list1[i] == list2[j])
				var/n = list1[i]
				return n
	return 0

obj/machinery/atmospherics/proc/check_connect_types_construction(obj/machinery/atmospherics/atmos1, obj/item/pipe/pipe2)
	var/i
	var/list1[] = atmos1.connect_types
	var/list2[] = pipe2.connect_types
	for(i=1,i<=list1.len,i++)
		var/j
		for(j=1,j<=list2.len,j++)
			if(list1[i] == list2[j])
				var/n = list1[i]
				return n
	return 0		
		
/obj/machinery/atmospherics/proc/check_icon_cache(var/safety = 0)
	if(!istype(icon_manager))
		if(!safety) //to prevent infinite loops
			icon_manager = new()
			check_icon_cache(1)
		return 0
	
	return 1

/obj/machinery/atmospherics/proc/color_cache_name(var/obj/machinery/atmospherics/node)
	//Don't use this for standard pipes
	if(!istype(node))
		return null
	
	return node.pipe_color

/obj/machinery/atmospherics/process()
	build_network()

/obj/machinery/atmospherics/proc/network_expand(datum/pipe_network/new_network, obj/machinery/atmospherics/pipe/reference)
	// Check to see if should be added to network. Add self if so and adjust variables appropriately.
	// Note don't forget to have neighbors look as well!

	return null

/obj/machinery/atmospherics/proc/build_network()
	// Called to build a network from this node

	return null

/obj/machinery/atmospherics/proc/return_network(obj/machinery/atmospherics/reference)
	// Returns pipe_network associated with connection to reference
	// Notes: should create network if necessary
	// Should never return null

	return null

/obj/machinery/atmospherics/proc/reassign_network(datum/pipe_network/old_network, datum/pipe_network/new_network)
	// Used when two pipe_networks are combining

/obj/machinery/atmospherics/proc/return_network_air(datum/network/reference)
	// Return a list of gas_mixture(s) in the object
	//		associated with reference pipe_network for use in rebuilding the networks gases list
	// Is permitted to return null

/obj/machinery/atmospherics/proc/disconnect(obj/machinery/atmospherics/reference)

/obj/machinery/atmospherics/update_icon()
	return null
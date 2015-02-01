/mob/living/verb/pray(msg as text)
	set category = "IC"
	set name = "Pray"

	msg = copytext(sanitize(msg), 1, MAX_MESSAGE_LEN)
	if(!msg)	return

	if(usr.client)
		if(usr.client.prefs.muted & MUTE_PRAY)
			usr << "\red You cannot pray (muted)."
			return
		if(src.client.handle_spam_prevention(msg,MUTE_PRAY))
			return

	var/image/cross = image('icons/obj/storage.dmi',"bible")
	msg = "\blue \icon[cross] <b><font color=purple>PRAY: </font>[key_name(src, 1)] (<A HREF='?_src_=holder;adminmoreinfo=\ref[src]'>?</A>) (<A HREF='?_src_=holder;adminplayeropts=\ref[src]'>PP</A>) (<A HREF='?_src_=vars;Vars=\ref[src]'>VV</A>) (<A HREF='?_src_=holder;subtlemessage=\ref[src]'>SM</A>) (<A HREF='?_src_=holder;adminplayerobservejump=\ref[src]'>JMP</A>) (<A HREF='?_src_=holder;secretsadmin=check_antagonist'>CA</A>) (<A HREF='?_src_=holder;adminspawncookie=\ref[src]'>SC</a>):</b> [msg]"

	var/list/eventholders = list()
	var/list/banholders = list()

	for(var/client/X in admins)
		if(R_EVENT & X.holder.rights)
			eventholders += X
		if(R_BAN & X.holder.rights)
			banholders += X

	if(eventholders.len)
		for(var/client/C in eventholders)
			if(C.prefs.toggles & CHAT_PRAYER)
				C << msg
	else if (banholders.len)
		for(var/client/C in banholders)
			if(C.prefs.toggles & CHAT_PRAYER)
				C << msg

	usr << "Your prayers have been received by the gods."

	feedback_add_details("admin_verb","PR") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	//log_admin("HELP: [key_name(src)]: [msg]")

/proc/Centcomm_announce(var/text , var/mob/Sender)
	var/msg = copytext(sanitize(text), 1, MAX_MESSAGE_LEN)
	msg = "\blue <b><font color=orange>CENTCOMM:</font>[key_name(Sender, 1)] (<A HREF='?_src_=holder;adminplayeropts=\ref[Sender]'>PP</A>) (<A HREF='?_src_=vars;Vars=\ref[Sender]'>VV</A>) (<A HREF='?_src_=holder;subtlemessage=\ref[Sender]'>SM</A>) (<A HREF='?_src_=holder;adminplayerobservejump=\ref[Sender]'>JMP</A>) (<A HREF='?_src_=holder;secretsadmin=check_antagonist'>CA</A>) (<A HREF='?_src_=holder;BlueSpaceArtillery=\ref[Sender]'>BSA</A>) (<A HREF='?_src_=holder;CentcommReply=\ref[Sender]'>RPLY</A>):</b> [msg]"

	var/list/eventholders = list()
	var/list/banholders = list()

	for(var/client/X in admins)
		if(R_EVENT & X.holder.rights)
			eventholders += X
		if(R_BAN & X.holder.rights)
			banholders += X

	if(eventholders.len)
		for(var/client/C in eventholders)
			C << msg
			return
	else if (banholders.len)
		for(var/client/C in banholders)
			C << msg
			return

/proc/Syndicate_announce(var/text , var/mob/Sender)
	var/msg = copytext(sanitize(text), 1, MAX_MESSAGE_LEN)
	msg = "\blue <b><font color=crimson>SYNDICATE:</font>[key_name(Sender, 1)] (<A HREF='?_src_=holder;adminplayeropts=\ref[Sender]'>PP</A>) (<A HREF='?_src_=vars;Vars=\ref[Sender]'>VV</A>) (<A HREF='?_src_=holder;subtlemessage=\ref[Sender]'>SM</A>) (<A HREF='?_src_=holder;adminplayerobservejump=\ref[Sender]'>JMP</A>) (<A HREF='?_src_=holder;secretsadmin=check_antagonist'>CA</A>) (<A HREF='?_src_=holder;BlueSpaceArtillery=\ref[Sender]'>BSA</A>) (<A HREF='?_src_=holder;SyndicateReply=\ref[Sender]'>RPLY</A>):</b> [msg]"

	var/list/eventholders = list()
	var/list/banholders = list()

	for(var/client/X in admins)
		if(R_EVENT & X.holder.rights)
			eventholders += X
		if(R_BAN & X.holder.rights)
			banholders += X

	if(eventholders.len)
		for(var/client/C in eventholders)
			C << msg
			return
	else if (banholders.len)
		for(var/client/C in banholders)
			C << msg
			return

/proc/HONK_announce(var/text , var/mob/Sender)
	var/msg = copytext(sanitize(text), 1, MAX_MESSAGE_LEN)
	msg = "\blue <b><font color=pink>HONK:</font>[key_name(Sender, 1)] (<A HREF='?_src_=holder;adminplayeropts=\ref[Sender]'>PP</A>) (<A HREF='?_src_=vars;Vars=\ref[Sender]'>VV</A>) (<A HREF='?_src_=holder;subtlemessage=\ref[Sender]'>SM</A>) (<A HREF='?_src_=holder;adminplayerobservejump=\ref[Sender]'>JMP</A>) (<A HREF='?_src_=holder;secretsadmin=check_antagonist'>CA</A>) (<A HREF='?_src_=holder;BlueSpaceArtillery=\ref[Sender]'>BSA</A>) (<A HREF='?_src_=holder;HONKReply=\ref[Sender]'>RPLY</A>):</b> [msg]"

	var/list/eventholders = list()
	var/list/banholders = list()

	for(var/client/X in admins)
		if(R_EVENT & X.holder.rights)
			eventholders += X
		if(R_BAN & X.holder.rights)
			banholders += X

	if(eventholders.len)
		for(var/client/C in eventholders)
			C << msg
			return
	else if (banholders.len)
		for(var/client/C in banholders)
			C << msg
			return
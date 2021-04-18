minetest.register_chatcommand("sudo", {
	description = "Force other players to run commands",
	params = "<player> <command> <arguments...>",
	privs = {server = true},
	func = function(name, param)
		local target = param:split(" ")[1]
		local command = param:split(" ")[2]
		local argumentsdisp
		local cmddef = minetest.chatcommands
		local _, _, arguments = string.match(param, "([^ ]+) ([^ ]+) (.+)")
		if not arguments then arguments = "" end
		if target and command then
			if cmddef[command] then
				if minetest.get_player_by_name(target) then
					if arguments == "" then argumentsdisp = arguments else argumentsdisp = " " .. arguments end
					local rs, rt = cmddef[command].func(target, arguments)
					minetest.chat_send_player(target, name .. "used the `sudo` command on you.")
					minetest.chat_send_player(target, "Command returns: " .. (tostring(rt) or "No return texts"))
					return rs, "Command returns: " .. (tostring(rt) or "No return texts")
				else
					return false, minetest.colorize("#FF0000", "Invalid Player.")
				end
			else
				return false, minetest.colorize("#FF0000", "Nonexistant Command.")
			end
		else
			return false, minetest.colorize("#FF0000", "Invalid Usage.")
		end
	end
})

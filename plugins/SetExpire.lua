local function check_member_superrem2(cb_extra, success, result)
  local receiver = cb_extra.receiver
  local data = cb_extra.data
  local msg = cb_extra.msg
  for k,v in pairs(result) do
    local member_id = v.id
    if member_id ~= our_id then
	  -- Group configuration removal
      data[tostring(msg.to.id)] = nil
      save_data(_config.moderation.data, data)
      local groups = 'groups'
      if not data[tostring(groups)] then
        data[tostring(groups)] = nil
        save_data(_config.moderation.data, data)
      end
      data[tostring(groups)][tostring(msg.to.id)] = nil
      save_data(_config.moderation.data, data)
	  --chat_del_user(get_receiver(msg), 'user#id'..235431064, ok_cb, false)
	  leave_channel(get_receiver(msg), ok_cb, false)
    end
  end
end

local function superrem2(msg)
	local data = load_data(_config.moderation.data)
    local receiver = get_receiver(msg)
    channel_get_users(receiver, check_member_superrem2,{receiver = receiver, data = data, msg = msg})
end
local function pre_process(msg)
	local timetoexpire = 'unknown'
	local expiretime = redis:hget ('expiretime', get_receiver(msg))
	local now = tonumber(os.time())
	if expiretime then    
		timetoexpire = math.floor((tonumber(expiretime) - tonumber(now)) / 86400) + 1
		if tonumber("0") > tonumber(timetoexpire) then
		if get_receiver(msg) then
		redis:del('expiretime', get_receiver(msg))
		rem_mutes(msg.to.id)
		superrem2(msg)
		return send_large_msg(get_receiver(msg), '⏰ تاریخ انقضای گروه شما به پایان رسید . برای تمدید به گروه پشتیبانی مراجعه کنید.\n https://telegram.me/joinchat/DZ-9fkBn_Zh7QndXIKqS6Q')
		else
			return
		end
	end
	if tonumber(timetoexpire) == 0 then
			if redis:hget('expires0',msg.to.id) then return msg end
		local user = "user#id"..228572542
		local text = "⌛️ تاریخ انقضای گروه مورد نظر به پایان رسیده است ."
			local text12 = 0
			local data = load_data(_config.moderation.data)
			local group_owner = data[tostring(msg.to.id)]['set_owner']
			if not group_owner then
group_owner = "---"
end
			local group_link = data[tostring(msg.to.id)]['settings']['set_link']
			if not group_link then
group_link = "---"
end
local exppm = '💢اتمام تاریخ انقضا\n'
..'----------------------------------\n'
..'👥نام گروه : <b>'..msg.to.title..' </b>\n'
..'🆔آیدی گروه : <b>'..msg.to.id..' </b>\n'
..'🏅صاحب گروه :  <code> '..group_owner..' </code> \n'
..'➰لینک گروه : '..group_link..'\n'
..'----------------------------------\n'
..'🔋شارژ برای یک ماه :\n'
..'setexp_'..msg.to.id..'_30\n'
..'🔋شارژ برای سه ماه :\n'
..'setexp_'..msg.to.id..'_90\n'
..'🔋شارژ نامحدود :\n'
..'setexp_'..msg.to.id..'_999\n'
..'----------------------------------\n'
			local sends = send_msg(user, exppm, ok_cb, false)   
			send_large_msg(get_receiver(msg), '🕰 تاریخ انقضای گروه شما فردا به پایان میرسد !')
   redis:hset('expires0',msg.to.id,'0')
	end
	if tonumber(timetoexpire) == 1 then
			if redis:hget('expires1',msg.to.id) then return msg end
      local user = "user#id"..250877155
			local text2 = "تاریخ انقضای گروه ارسال شده 1 روز دیگر به پایان میرسد"
			local text13 = 1
			local data = load_data(_config.moderation.data)
			local group_owner = data[tostring(msg.to.id)]['set_owner']
			if not group_owner then
group_owner = "---"
end
			local group_link = data[tostring(msg.to.id)]['settings']['set_link']
			if not group_link then
group_link = "Unset"
end
local exppm = '💢پایان تاریخ انقضا\n'
..'----------------------------------\n'
..'👥نام گروه : <b>'..msg.to.title..' </b>\n'
..'🆔آیدی گروه : <b>'..msg.to.id..' </b>\n'
..'🏅صاحب گروه :  <code> '..group_owner..' </code> \n'
..'➰لینک گروه : '..group_link..'\n'
..'----------------------------------\n'
..'🔋شارژ برای یک ماه :\n'
..'setexp_'..msg.to.id..'_30\n'
..'🔋شارژ برای سه ماه :\n'
..'setexp_'..msg.to.id..'_90\n'
..'🔋شارژ نامحدود :\n'
..'setexp_'..msg.to.id..'_999\n'
..'----------------------------------\n'
		local sends = send_msg(user, exppm, ok_cb, false)
			send_large_msg(get_receiver(msg), '🕰 تاریخ انقضای گروه شما <b>1 </b> روز دیگر به پایان میرسد .\n برای تمدید به گروه پشتیبانی مراجعه کنید.\n https://telegram.me/joinchat/DZ-9fkBn_Zh7QndXIKqS6Q')
		redis:hset('expires1',msg.to.id,'1')
	end
	if tonumber(timetoexpire) == 2 then
		if redis:hget('expires2',msg.to.id) then return msg end
			send_large_msg(get_receiver(msg), '🕰 تاریخ انقضای گروه شما <b>2 </b> روز دیگر به پایان میرسد .\n برای تمدید به گروه پشتیبانی مراجعه کنید.\n https://telegram.me/joinchat/DZ-9fkBn_Zh7QndXIKqS6Q')
		redis:hset('expires2',msg.to.id,'2')
	end
	if tonumber(timetoexpire) == 3 then
					if redis:hget('expires3',msg.to.id) then return msg end
			send_large_msg(get_receiver(msg), '🕰 تاریخ انقضای گروه شما <b>3 </b> روز دیگر به پایان میرسد .\n برای تمدید به گروه پشتیبانی مراجعه کنید.\n https://telegram.me/joinchat/DZ-9fkBn_Zh7QndXIKqS6Q')
			redis:hset('expires3',msg.to.id,'3')
	end
	if tonumber(timetoexpire) == 4 then
					if redis:hget('expires4',msg.to.id) then return msg end
			send_large_msg(get_receiver(msg), '🕰 تاریخ انقضای گروه شما <b>4 </b> روز دیگر به پایان میرسد .\n برای تمدید به گروه پشتیبانی مراجعه کنید.\n https://telegram.me/joinchat/DZ-9fkBn_Zh7QndXIKqS6Q')
		redis:hset('expires4',msg.to.id,'4')
	end
	if tonumber(timetoexpire) == 5 then
					if redis:hget('expires5',msg.to.id) then return msg end
			send_large_msg(get_receiver(msg), '🕰 تاریخ انقضای گروه شما <b>5 </b> روز دیگر به پایان میرسد .\n برای تمدید به گروه پشتیبانی مراجعه کنید.\n https://telegram.me/joinchat/DZ-9fkBn_Zh7QndXIKqS6Q')
		redis:hset('expires5',msg.to.id,'5')
	end
end
return msg
end
function run(msg, matches)
	if matches[1]:lower() == 'setexpire' and is_sudo(msg) then
		local time = os.time()
		local buytime = tonumber(os.time())
		local timeexpire = tonumber(buytime) + (tonumber(matches[2]) * 86400)
		redis:hset('expiretime',get_receiver(msg),timeexpire)
		local text = "⏱ گروه <b>"..msg.to.title.." </b>برای <b>"..matches[2].." </b>روز شارژ شد !"
		return reply_msg(msg.id, text, ok_cb, false)
	end
	
	if matches[1]:lower() == 'setexp' and is_sudo(msg) then
    local expgp = "channel#id"..matches[2]
		local time = os.time()
		local buytime = tonumber(os.time())
		local timeexpire = tonumber(buytime) + (tonumber(matches[3]) * 86400)
		redis:hset('expiretime',expgp,timeexpire)
		return "تاریخ انقضای گروه:\nبه "..matches[3].. " روز دیگر تنظیم شد."
	end
	if matches[1]:lower() == 'expire' then
		local expiretime = redis:hget ('expiretime', get_receiver(msg))
		if not expiretime then return 'تاریخ ست نشده است' else
			local now = tonumber(os.time())
			local text = (math.floor((tonumber(expiretime) - tonumber(now)) / 86400) + 1)
			return (math.floor((tonumber(expiretime) - tonumber(now)) / 86400) + 1) .. " "
		
		end
		end
			if matches[1]:lower() == 'charge' and is_owner(msg) then
			local expiretime = redis:hget ('expiretime', get_receiver(msg))
			local now = tonumber(os.time())
			local text4 = (math.floor((tonumber(expiretime) - tonumber(now)) / 86400) + 1)
			if not expiretime then 
				expiretime = "-"
				end
local text3 = "🔋 صاحب گروه درخواست شارژ گروه را دارد !"
local user = "user#id"..250877155
local data = load_data(_config.moderation.data)
local group_owner = data[tostring(msg.to.id)]['set_owner']
if not group_owner then
group_owner = "--"
end
local group_link = data[tostring(msg.to.id)]['settings']['set_link']
if not group_link then
group_link = "Unset"
end
local exppm = '💢Req Charge\n'
..'----------------------------------\n'
..'👥نام گروه : <b>'..msg.to.title..' </b>\n'
..'🆔آیدی گروه : <b>'..msg.to.id..' </b>\n'
..'🏅صاحب گروه :  <code> '..group_owner..' </code> \n'
..'➰لینک گروه : '..group_link..'\n'
..'----------------------------------\n'
..'🔋شارژ برای یک ماه :\n'
..'setexp_'..msg.to.id..'_30\n'
..'🔋شارژ برای سه ماه :\n'
..'setexp_'..msg.to.id..'_90\n'
..'🔋شارژ نامحدود :\n'
..'/setexp_'..msg.to.id..'_999\n'
..'----------------------------------\n'
			--local sends = send_msg(user, exppm, ok_cb, false)
			send_large_msg("channel#id"..228572542, exppm)
		return "درخواست شما برای شارژ مجدد گروه ارسال شد"
end
end
return {
  patterns = {
    "^([Ss][Ee][Tt][Ee][Xx][Pp][Ii][Rr][Ee]) (.*)$",
    "^(setexp)_(.*)_(.*)$",
    "^([Ee][Xx][Pp][Ii][Rr][Ee][Tt][Ii][Mm][Ee])$",
    "^([Cc][Hh][Aa][Rr][Gg][Ee])$",
  },
  run = run,
  pre_process = pre_process
}

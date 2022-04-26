--[[

--]]
URL     = require("./libs/url")
JSON    = require("./libs/dkjson")
serpent = require("libs/serpent")
json = require('libs/json')
Redis = require('libs/redis').connect('127.0.0.1', 6379)
http  = require("socket.http")
https   = require("ssl.https")
local Methods = io.open("./luatele.lua","r")
if Methods then
URL.tdlua_CallBack()
end
SshId = io.popen("echo $SSH_CLIENT ┃ awk '{ print $1}'"):read('*a')
luatele = require 'luatele'
local FileInformation = io.open("./Information.lua","r")
if not FileInformation then
if not Redis:get(SshId.."Info:Redis:Token") then
io.write('\27[1;31mارســل لــي تــوكــن الــبــوت الان \nSend Me a Bot Token Now ⇧⇩\n\27[0;39;49m')
local TokenBot = io.read()
if TokenBot and TokenBot:match('(%d+):(.*)') then
local url , res = https.request('https://api.telegram.org/bot'..TokenBot..'/getMe')
local Json_Info = JSON.decode(url)
if res ~= 200 then
print('\27[1;34mعــذرا تــوكــن الــبــوت خــطــأ تــحــقــق مــنــه وارســلــه مــره اخــره \nBot Token is Wrong\n')
else
io.write('\27[1;34mتــم حــفــظ التــوكــن بــنــجــاح \nThe token been saved successfully \n\27[0;39;49m')
TheTokenBot = TokenBot:match("(%d+)")
os.execute('sudo rm -fr .CallBack-Bot/'..TheTokenBot)
Redis:set(SshId.."Info:Redis:Token",TokenBot)
Redis:set(SshId.."Info:Redis:Token:User",Json_Info.result.username)
end 
else
print('\27[1;34mلــم يــتــم حــفــظ الــتــوكــن جــرب مــره اخــره \nToken not saved, try again')
end 
os.execute('lua MEZO.lua')
end
if not Redis:get(SshId.."Info:Redis:User") then
io.write('\27[1;31mارســل مــعــرف الــمــطــور الاســاســي الان \nDeveloper UserName saved ⇧⇩\n\27[0;39;49m')
local UserSudo = io.read():gsub('@','')
if UserSudo ~= '' then
io.write('\n\27[1;34mتــم حــفــظ مــعــرف الــمــطــور \nDeveloper UserName saved \n\n\27[0;39;49m')
Redis:set(SshId.."Info:Redis:User",UserSudo)
else
print('\n\27[1;34mلــم يــتــم حــفــظ مــعــرف الــمــطــور الاســاســي \nDeveloper UserName not saved\n')
end 
os.execute('lua MEZO.lua')
end
if not Redis:get(SshId.."Info:Redis:User:ID") then
io.write('\27[1;31mارســل ايــدي الــمــطــور الاســاســي الان \nDeveloper ID saved ⇧⇩\n\27[0;39;49m')
local UserId = io.read()
if UserId and UserId:match('(%d+)') then
io.write('\n\27[1;34mتــم حــفــظ ايــدي الــمــطــور الاســاســي \nDeveloper ID saved \n\n\27[0;39;49m')
Redis:set(SshId.."Info:Redis:User:ID",UserId)
else
print('\n\27[1;34mلم يتم حفظ ايــدي الــمــطــور الاســاســي \nDeveloper ID not saved\n')
end 
os.execute('lua MEZO.lua')
end
local Informationlua = io.open("Information.lua", 'w')
Informationlua:write([[
return {
Token = "]]..Redis:get(SshId.."Info:Redis:Token")..[[",
UserBot = "]]..Redis:get(SshId.."Info:Redis:Token:User")..[[",
UserSudo = "]]..Redis:get(SshId.."Info:Redis:User")..[[",
SudoId = ]]..Redis:get(SshId.."Info:Redis:User:ID")..[[
}
]])
Informationlua:close()
Redis:del(SshId.."Info:Redis:User:ID");Redis:del(SshId.."Info:Redis:User");Redis:del(SshId.."Info:Redis:Token:User");Redis:del(SshId.."Info:Redis:Token")
os.execute('chmod +x MEZO;chmod +x Run;./Run')
end
Information = dofile('./Information.lua')
Sudo_Id = Information.SudoId
UserSudo = Information.UserSudo
Token = Information.Token
UserBot = Information.UserBot
MEZO = Token:match("(%d+)")
os.execute('sudo rm -fr .CallBack-Bot/'..MEZO)
LuaTele = luatele.set_config{api_id=2692371,api_hash='fe85fff033dfe0f328aeb02b4f784930',session_name=MEZO,token=Token}
function getbio(User)
local var = "لايوجد"
local url , res = https.request("https://api.telegram.org/bot"..Token.."/getchat?chat_id="..User);
data = json:decode(url)
if data.result.bio then
var = data.result.bio
end
return var
end
function var(value)  
print(serpent.block(value, {comment=false}))   
end 
function chat_type(ChatId)
if ChatId then
local id = tostring(ChatId)
if id:match("-100(%d+)") then
Chat_Type = 'GroupBot' 
elseif id:match("^(%d+)") then
Chat_Type = 'UserBot' 
else
Chat_Type = 'GroupBot' 
end
end
return Chat_Type
end
function The_ControllerAll(UserId)
ControllerAll = false
local ListSudos ={Sudo_Id,1001132193,1833610203,1825122580,99999999999999,77777777777777}  
for k, v in pairs(ListSudos) do
if tonumber(UserId) == tonumber(v) then
ControllerAll = true
end
end
return ControllerAll
end
function Controller(ChatId,UserId)
Status = 0
DevelopersQ = Redis:sismember(MEZO.."MEZO:DevelopersQ:Groups",UserId) 
Developers = Redis:sismember(MEZO.."MEZO:Developers:Groups",UserId) 
TheBasics = Redis:sismember(MEZO.."MEZO:TheBasics:Group"..ChatId,UserId) 
TheBasicsQ = Redis:sismember(MEZO.."MEZO:TheBasicsQ:Group"..ChatId,UserId) 
Originators = Redis:sismember(MEZO.."MEZO:Originators:Group"..ChatId,UserId)
Managers = Redis:sismember(MEZO.."MEZO:Managers:Group"..ChatId,UserId)
Addictive = Redis:sismember(MEZO.."MEZO:Addictive:Group"..ChatId,UserId)
Distinguished = Redis:sismember(MEZO.."MEZO:Distinguished:Group"..ChatId,UserId)
StatusMember = LuaTele.getChatMember(ChatId,UserId).status.luatele
if UserId == 1001132193 then
Status = 'DEV • BARLO'
elseif UserId == 1833610203 then  
Status = 'DEV • CRISTIN'
elseif UserId == 1825122580 then  
Status = 'بارلو باشا'
elseif UserId == 99999999999999 then  
Status = 'جوو'
elseif UserId == 77777777777777 then  
Status = 'كومندا'
elseif UserId == Sudo_Id then  
Status = 'المطور الاساسي'
elseif UserId == MEZO then
Status = 'البوت'
elseif Developers then
Status = Redis:get(MEZO.."MEZO:Developer:Bot:Reply"..ChatId) or 'المطور'
elseif DevelopersQ then
Status = Redis:get(MEZO.."MEZO:DevelopersQ:Groups"..ChatId) or 'المطور الثانوي'
elseif TheBasicsQ then
Status = Redis:get(MEZO.."MEZO:PresidentQ:Group:Reply"..ChatId) or 'المالك'
elseif TheBasics then
Status = Redis:get(MEZO.."MEZO:President:Group:Reply"..ChatId) or 'المنشئ الاساسي'
elseif Originators then
Status = Redis:get(MEZO.."MEZO:Constructor:Group:Reply"..ChatId) or 'المنشئ'
elseif Managers then
Status = Redis:get(MEZO.."MEZO:Manager:Group:Reply"..ChatId) or 'المدير'
elseif Addictive then
Status = Redis:get(MEZO.."MEZO:Admin:Group:Reply"..ChatId) or 'الادمن'
elseif StatusMember == "chatMemberStatusCreator" then
Status = 'مالك المجموعه'
elseif StatusMember == "chatMemberStatusAdministrator" then
Status = 'ادمن المجموعه'
elseif Distinguished then
Status = Redis:get(MEZO.."MEZO:Vip:Group:Reply"..ChatId) or 'المميز'
else
Status = Redis:get(MEZO.."MEZO:Mempar:Group:Reply"..ChatId) or 'العضو'
end  
return Status
end 
function Controller_Num(Num)
Status = 0
if tonumber(Num) == 1 then  
Status = 'المطور الاساسي'
elseif tonumber(Num) == 2 then  
Status = 'المطور الثانوي'
elseif tonumber(Num) == 3 then  
Status = 'المطور'
elseif tonumber(Num) == 44 then  
Status = 'المالك'
elseif tonumber(Num) == 4 then  
Status = 'المنشئ الاساسي'
elseif tonumber(Num) == 5 then  
Status = 'المنشئ'
elseif tonumber(Num) == 6 then  
Status = 'المدير'
elseif tonumber(Num) == 7 then  
Status = 'الادمن'
else
Status = 'المميز'
end  
return Status
end 
function GetAdminsSlahe(ChatId,UserId,user2,MsgId,t1,t2,t3,t4,t5,t6)
local GetMemberStatus = LuaTele.getChatMember(ChatId,user2).status
if GetMemberStatus.can_change_info then
change_info = '【 ✅ 】' else change_info = '【 ❌ 】'
end
if GetMemberStatus.can_delete_messages then
delete_messages = '【 ✅ 】' else delete_messages = '【 ❌ 】'
end
if GetMemberStatus.can_invite_users then
invite_users = '【 ✅ 】' else invite_users = '【 ❌ 】'
end
if GetMemberStatus.can_pin_messages then
pin_messages = '【 ✅ 】' else pin_messages = '【 ❌ 】'
end
if GetMemberStatus.can_restrict_members then
restrict_members = '【 ✅ 】' else restrict_members = '【 ❌ 】'
end
if GetMemberStatus.can_promote_members then
promote = '【 ✅ 】' else promote = '【 ❌ 】'
end
local reply_markupp = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍┃ تغيير معلومات المجموعه'..(t1 or change_info), data = UserId..'/groupNum1//'..user2}, 
},
{
{text = '❍┃ تثبيت الرسائل '..(t2 or pin_messages), data = UserId..'/groupNum2//'..user2}, 
},
{
{text = '❍┃ حظر المستخدمين '..(t3 or restrict_members), data = UserId..'/groupNum3//'..user2}, 
},
{
{text = '❍┃ دعوة المستخدمين '..(t4 or invite_users), data = UserId..'/groupNum4//'..user2}, 
},
{
{text = '❍┃ حذف الرسائل '..(t5 or delete_messages), data = UserId..'/groupNum5//'..user2}, 
},
{
{text = '❍┃ اضافة مشرفين '..(t6 or promote), data = UserId..'/groupNum6//'..user2}, 
},
}
}
LuaTele.editMessageText(ChatId,MsgId,"* ❍┃ صلاحيات الادمن*", 'md', false, false, reply_markupp)
end
function GetAdminsNum(ChatId,UserId)
local GetMemberStatus = LuaTele.getChatMember(ChatId,UserId).status
if GetMemberStatus.can_change_info then
change_info = 1 else change_info = 0
end
if GetMemberStatus.can_delete_messages then
delete_messages = 1 else delete_messages = 0
end
if GetMemberStatus.can_invite_users then
invite_users = 1 else invite_users = 0
end
if GetMemberStatus.can_pin_messages then
pin_messages = 1 else pin_messages = 0
end
if GetMemberStatus.can_restrict_members then
restrict_members = 1 else restrict_members = 0
end
if GetMemberStatus.can_promote_members then
promote = 1 else promote = 0
end
return{
promote = promote,
restrict_members = restrict_members,
invite_users = invite_users,
pin_messages = pin_messages,
delete_messages = delete_messages,
change_info = change_info
}
end
function GetSetieng(ChatId)
if Redis:get(MEZO.."MEZO:lockpin"..ChatId) then    
lock_pin = "【 ✅ 】"
else 
lock_pin = "【 ❌ 】"    
end
if Redis:get(MEZO.."MEZO:Lock:tagservr"..ChatId) then    
lock_tagservr = "【 ✅ 】"
else 
lock_tagservr = "【 ❌ 】"
end
if Redis:get(MEZO.."MEZO:Lock:text"..ChatId) then    
lock_text = "【 ✅ 】"
else 
lock_text = "【 ❌ 】 "    
end
if Redis:get(MEZO.."MEZO:Lock:AddMempar"..ChatId) == "kick" then
lock_add = "【 ✅ 】"
else 
lock_add = "【 ❌ 】 "    
end    
if Redis:get(MEZO.."MEZO:Lock:Join"..ChatId) == "kick" then
lock_join = "【 ✅ 】"
else 
lock_join = "【 ❌ 】 "    
end    
if Redis:get(MEZO.."MEZO:Lock:edit"..ChatId) then    
lock_edit = "【 ✅ 】"
else 
lock_edit = "【 ❌ 】 "    
end
if Redis:get(MEZO.."MEZO:Chek:Welcome"..ChatId) then
welcome = "【 ✅ 】"
else 
welcome = "【 ❌ 】 "    
end
if Redis:hget(MEZO.."MEZO:Spam:Group:User"..ChatId, "Spam:User") == "kick" then     
flood = "بالطرد "     
elseif Redis:hget(MEZO.."MEZO:Spam:Group:User"..ChatId,"Spam:User") == "keed" then     
flood = "بالتقيد "     
elseif Redis:hget(MEZO.."MEZO:Spam:Group:User"..ChatId,"Spam:User") == "mute" then     
flood = "بالكتم "           
elseif Redis:hget(MEZO.."MEZO:Spam:Group:User"..ChatId,"Spam:User") == "del" then     
flood = "【 ✅ 】"
else     
flood = "【 ❌ 】 "     
end
if Redis:get(MEZO.."MEZO:Lock:Photo"..ChatId) == "del" then
lock_photo = "【 ✅ 】" 
elseif Redis:get(MEZO.."MEZO:Lock:Photo"..ChatId) == "ked" then 
lock_photo = "بالتقيد "   
elseif Redis:get(MEZO.."MEZO:Lock:Photo"..ChatId) == "ktm" then 
lock_photo = "بالكتم "    
elseif Redis:get(MEZO.."MEZO:Lock:Photo"..ChatId) == "kick" then 
lock_photo = "بالطرد "   
else
lock_photo = "【 ❌ 】 "   
end    
if Redis:get(MEZO.."MEZO:Lock:Contact"..ChatId) == "del" then
lock_phon = "【 ✅ 】" 
elseif Redis:get(MEZO.."MEZO:Lock:Contact"..ChatId) == "ked" then 
lock_phon = "بالتقيد "    
elseif Redis:get(MEZO.."MEZO:Lock:Contact"..ChatId) == "ktm" then 
lock_phon = "بالكتم "    
elseif Redis:get(MEZO.."MEZO:Lock:Contact"..ChatId) == "kick" then 
lock_phon = "بالطرد "    
else
lock_phon = "【 ❌ 】 "    
end    
if Redis:get(MEZO.."MEZO:Lock:Link"..ChatId) == "del" then
lock_links = "【 ✅ 】"
elseif Redis:get(MEZO.."MEZO:Lock:Link"..ChatId) == "ked" then
lock_links = "بالتقيد "    
elseif Redis:get(MEZO.."MEZO:Lock:Link"..ChatId) == "ktm" then
lock_links = "بالكتم "    
elseif Redis:get(MEZO.."MEZO:Lock:Link"..ChatId) == "kick" then
lock_links = "بالطرد "    
else
lock_links = "【 ❌ 】 "    
end
if Redis:get(MEZO.."MEZO:Lock:Cmd"..ChatId) == "del" then
lock_cmds = "【 ✅ 】"
elseif Redis:get(MEZO.."MEZO:Lock:Cmd"..ChatId) == "ked" then
lock_cmds = "بالتقيد "    
elseif Redis:get(MEZO.."MEZO:Lock:Cmd"..ChatId) == "ktm" then
lock_cmds = "بالكتم "   
elseif Redis:get(MEZO.."MEZO:Lock:Cmd"..ChatId) == "kick" then
lock_cmds = "بالطرد "    
else
lock_cmds = "【 ❌ 】 "    
end
if Redis:get(MEZO.."MEZO:Lock:User:Name"..ChatId) == "del" then
lock_user = "【 ✅ 】"
elseif Redis:get(MEZO.."MEZO:Lock:User:Name"..ChatId) == "ked" then
lock_user = "بالتقيد "    
elseif Redis:get(MEZO.."MEZO:Lock:User:Name"..ChatId) == "ktm" then
lock_user = "بالكتم "    
elseif Redis:get(MEZO.."MEZO:Lock:User:Name"..ChatId) == "kick" then
lock_user = "بالطرد "    
else
lock_user = "【 ❌ 】 "    
end
if Redis:get(MEZO.."MEZO:Lock:hashtak"..ChatId) == "del" then
lock_hash = "【 ✅ 】"
elseif Redis:get(MEZO.."MEZO:Lock:hashtak"..ChatId) == "ked" then 
lock_hash = "بالتقيد "    
elseif Redis:get(MEZO.."MEZO:Lock:hashtak"..ChatId) == "ktm" then 
lock_hash = "بالكتم "    
elseif Redis:get(MEZO.."MEZO:Lock:hashtak"..ChatId) == "kick" then 
lock_hash = "بالطرد "    
else
lock_hash = "【 ❌ 】 "    
end
if Redis:get(MEZO.."MEZO:Lock:vico"..ChatId) == "del" then
lock_muse = "【 ✅ 】"
elseif Redis:get(MEZO.."MEZO:Lock:vico"..ChatId) == "ked" then 
lock_muse = "بالتقيد "    
elseif Redis:get(MEZO.."MEZO:Lock:vico"..ChatId) == "ktm" then 
lock_muse = "بالكتم "    
elseif Redis:get(MEZO.."MEZO:Lock:vico"..ChatId) == "kick" then 
lock_muse = "بالطرد "    
else
lock_muse = "【 ❌ 】 "    
end 
if Redis:get(MEZO.."MEZO:Lock:Video"..ChatId) == "del" then
lock_ved = "【 ✅ 】"
elseif Redis:get(MEZO.."MEZO:Lock:Video"..ChatId) == "ked" then 
lock_ved = "بالتقيد "    
elseif Redis:get(MEZO.."MEZO:Lock:Video"..ChatId) == "ktm" then 
lock_ved = "بالكتم "    
elseif Redis:get(MEZO.."MEZO:Lock:Video"..ChatId) == "kick" then 
lock_ved = "بالطرد "    
else
lock_ved = "【 ❌ 】 "    
end
if Redis:get(MEZO.."MEZO:Lock:Animation"..ChatId) == "del" then
lock_gif = "【 ✅ 】"
elseif Redis:get(MEZO.."MEZO:Lock:Animation"..ChatId) == "ked" then 
lock_gif = "بالتقيد "    
elseif Redis:get(MEZO.."MEZO:Lock:Animation"..ChatId) == "ktm" then 
lock_gif = "بالكتم "    
elseif Redis:get(MEZO.."MEZO:Lock:Animation"..ChatId) == "kick" then 
lock_gif = "بالطرد "    
else
lock_gif = "【 ❌ 】 "    
end
if Redis:get(MEZO.."MEZO:Lock:Sticker"..ChatId) == "del" then
lock_ste = "【 ✅ 】"
elseif Redis:get(MEZO.."MEZO:Lock:Sticker"..ChatId) == "ked" then 
lock_ste = "بالتقيد "    
elseif Redis:get(MEZO.."MEZO:Lock:Sticker"..ChatId) == "ktm" then 
lock_ste = "بالكتم "    
elseif Redis:get(MEZO.."MEZO:Lock:Sticker"..ChatId) == "kick" then 
lock_ste = "بالطرد "    
else
lock_ste = "【 ❌ 】 "    
end
if Redis:get(MEZO.."MEZO:Lock:geam"..ChatId) == "del" then
lock_geam = "【 ✅ 】"
elseif Redis:get(MEZO.."MEZO:Lock:geam"..ChatId) == "ked" then 
lock_geam = "بالتقيد "    
elseif Redis:get(MEZO.."MEZO:Lock:geam"..ChatId) == "ktm" then 
lock_geam = "بالكتم "    
elseif Redis:get(MEZO.."MEZO:Lock:geam"..ChatId) == "kick" then 
lock_geam = "بالطرد "    
else
lock_geam = "【 ❌ 】 "    
end    
if Redis:get(MEZO.."MEZO:Lock:vico"..ChatId) == "del" then
lock_vico = "【 ✅ 】"
elseif Redis:get(MEZO.."MEZO:Lock:vico"..ChatId) == "ked" then 
lock_vico = "بالتقيد "    
elseif Redis:get(MEZO.."MEZO:Lock:vico"..ChatId) == "ktm" then 
lock_vico = "بالكتم "    
elseif Redis:get(MEZO.."MEZO:Lock:vico"..ChatId) == "kick" then 
lock_vico = "بالطرد "    
else
lock_vico = "【 ❌ 】 "    
end    
if Redis:get(MEZO.."MEZO:Lock:Keyboard"..ChatId) == "del" then
lock_inlin = "【 ✅ 】"
elseif Redis:get(MEZO.."MEZO:Lock:Keyboard"..ChatId) == "ked" then 
lock_inlin = "بالتقيد "
elseif Redis:get(MEZO.."MEZO:Lock:Keyboard"..ChatId) == "ktm" then 
lock_inlin = "بالكتم "    
elseif Redis:get(MEZO.."MEZO:Lock:Keyboard"..ChatId) == "kick" then 
lock_inlin = "بالطرد "
else
lock_inlin = "【 ❌ 】 "
end
if Redis:get(MEZO.."MEZO:Lock:forward"..ChatId) == "del" then
lock_fwd = "【 ✅ 】"
elseif Redis:get(MEZO.."MEZO:Lock:forward"..ChatId) == "ked" then 
lock_fwd = "بالتقيد "    
elseif Redis:get(MEZO.."MEZO:Lock:forward"..ChatId) == "ktm" then 
lock_fwd = "بالكتم "    
elseif Redis:get(MEZO.."MEZO:Lock:forward"..ChatId) == "kick" then 
lock_fwd = "بالطرد "    
else
lock_fwd = "【 ❌ 】 "    
end    
if Redis:get(MEZO.."MEZO:Lock:Document"..ChatId) == "del" then
lock_file = "【 ✅ 】"
elseif Redis:get(MEZO.."MEZO:Lock:Document"..ChatId) == "ked" then 
lock_file = "بالتقيد "    
elseif Redis:get(MEZO.."MEZO:Lock:Document"..ChatId) == "ktm" then 
lock_file = "بالكتم "    
elseif Redis:get(MEZO.."MEZO:Lock:Document"..ChatId) == "kick" then 
lock_file = "بالطرد "    
else
lock_file = "【 ❌ 】 "    
end    
if Redis:get(MEZO.."MEZO:Lock:Unsupported"..ChatId) == "del" then
lock_self = "【 ✅ 】"
elseif Redis:get(MEZO.."MEZO:Lock:Unsupported"..ChatId) == "ked" then 
lock_self = "بالتقيد "    
elseif Redis:get(MEZO.."MEZO:Lock:Unsupported"..ChatId) == "ktm" then 
lock_self = "بالكتم "    
elseif Redis:get(MEZO.."MEZO:Lock:Unsupported"..ChatId) == "kick" then 
lock_self = "بالطرد "    
else
lock_self = "【 ❌ 】 "    
end
if Redis:get(MEZO.."MEZO:Lock:Bot:kick"..ChatId) == "del" then
lock_bots = "【 ✅ 】"
elseif Redis:get(MEZO.."MEZO:Lock:Bot:kick"..ChatId) == "ked" then
lock_bots = "بالتقيد "   
elseif Redis:get(MEZO.."MEZO:Lock:Bot:kick"..ChatId) == "kick" then
lock_bots = "بالطرد "    
else
lock_bots = "【 ❌ 】 "    
end
if Redis:get(MEZO.."MEZO:Lock:Markdaun"..ChatId) == "del" then
lock_mark = "【 ✅ 】"
elseif Redis:get(MEZO.."MEZO:Lock:Markdaun"..ChatId) == "ked" then 
lock_mark = "بالتقيد "    
elseif Redis:get(MEZO.."MEZO:Lock:Markdaun"..ChatId) == "ktm" then 
lock_mark = "بالكتم "    
elseif Redis:get(MEZO.."MEZO:Lock:Markdaun"..ChatId) == "kick" then 
lock_mark = "بالطرد "    
else
lock_mark = "【 ❌ 】 "    
end
if Redis:get(MEZO.."MEZO:Lock:Spam"..ChatId) == "del" then    
lock_spam = "【 ✅ 】"
elseif Redis:get(MEZO.."MEZO:Lock:Spam"..ChatId) == "ked" then 
lock_spam = "بالتقيد "    
elseif Redis:get(MEZO.."MEZO:Lock:Spam"..ChatId) == "ktm" then 
lock_spam = "بالكتم "    
elseif Redis:get(MEZO.."MEZO:Lock:Spam"..ChatId) == "kick" then 
lock_spam = "بالطرد "    
else
lock_spam = "【 ❌ 】 "    
end        
return{
lock_pin = lock_pin,
lock_tagservr = lock_tagservr,
lock_text = lock_text,
lock_add = lock_add,
lock_join = lock_join,
lock_edit = lock_edit,
flood = flood,
lock_photo = lock_photo,
lock_phon = lock_phon,
lock_links = lock_links,
lock_cmds = lock_cmds,
lock_mark = lock_mark,
lock_user = lock_user,
lock_hash = lock_hash,
lock_muse = lock_muse,
lock_ved = lock_ved,
lock_gif = lock_gif,
lock_ste = lock_ste,
lock_geam = lock_geam,
lock_vico = lock_vico,
lock_inlin = lock_inlin,
lock_fwd = lock_fwd,
lock_file = lock_file,
lock_self = lock_self,
lock_bots = lock_bots,
lock_spam = lock_spam
}
end
function Total_message(Message)  
local MsgText = ''  
if tonumber(Message) < 100 then 
MsgText = 'غير متفاعل 😡' 
elseif tonumber(Message) < 200 then 
MsgText = 'بده يتحسن 😒'
elseif tonumber(Message) < 400 then 
MsgText = 'شبه متفاعل 😊' 
elseif tonumber(Message) < 700 then 
MsgText = 'متفاعل 😍' 
elseif tonumber(Message) < 1200 then 
MsgText = 'متفاعل قوي 🥰' 
elseif tonumber(Message) < 2000 then 
MsgText = 'متفاعل جدا ❤️' 
elseif tonumber(Message) < 3500 then 
MsgText = 'اقوى تفاعل 💋'  
elseif tonumber(Message) < 4000 then 
MsgText = 'متفاعل نار 🥳' 
elseif tonumber(Message) < 4500 then 
MsgText = 'قمة التفاعل ❤️‍🔥' 
elseif tonumber(Message) < 5500 then 
MsgText = 'اقوى متفاعل 🤩' 
elseif tonumber(Message) < 7000 then 
MsgText = 'ملك التفاعل 😎' 
elseif tonumber(Message) < 9500 then 
MsgText = 'زعيم التفاعل 😻' 
elseif tonumber(Message) < 10000000000 then 
MsgText = 'امبروطور التفاعل 👍'  
end 
return MsgText 
end
function Getpermissions(ChatId)
local Get_Chat = LuaTele.getChat(ChatId)
if Get_Chat.permissions.can_add_web_page_previews then
web = true else web = false
end
if Get_Chat.permissions.can_change_info then
info = true else info = false
end
if Get_Chat.permissions.can_invite_users then
invite = true else invite = false
end
if Get_Chat.permissions.can_pin_messages then
pin = true else pin = false
end
if Get_Chat.permissions.can_send_media_messages then
media = true else media = false
end
if Get_Chat.permissions.can_send_messages then
messges = true else messges = false
end
if Get_Chat.permissions.can_send_other_messages then
other = true else other = false
end
if Get_Chat.permissions.can_send_polls then
polls = true else polls = false
end
return{
web = web,
info = info,
invite = invite,
pin = pin,
media = media,
messges = messges,
other = other,
polls = polls
}
end
function Get_permissions(ChatId,UserId,MsgId)
local Get_Chat = LuaTele.getChat(ChatId)
if Get_Chat.permissions.can_add_web_page_previews then
web = '【 ✅ 】' else web = '【 ❌ 】'
end
if Get_Chat.permissions.can_change_info then
info = '【 ✅ 】' else info = '【 ❌ 】'
end
if Get_Chat.permissions.can_invite_users then
invite = '【 ✅ 】' else invite = '【 ❌ 】'
end
if Get_Chat.permissions.can_pin_messages then
pin = '【 ✅ 】' else pin = '【 ❌ 】'
end
if Get_Chat.permissions.can_send_media_messages then
media = '【 ✅ 】' else media = '【 ❌ 】'
end
if Get_Chat.permissions.can_send_messages then
messges = '【 ✅ 】' else messges = '【 ❌ 】'
end
if Get_Chat.permissions.can_send_other_messages then
other = '【 ✅ 】' else other = '【 ❌ 】'
end
if Get_Chat.permissions.can_send_polls then
polls = '【 ✅ 】' else polls = '【 ❌ 】'
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍┃ ارسال الويب : '..web, data = UserId..'/web'}, 
},
{
{text = '❍┃ تغيير معلومات المجموعه : '..info, data = UserId.. '/info'}, 
},
{
{text = '❍┃ اضافه مستخدمين : '..invite, data = UserId.. '/invite'}, 
},
{
{text = '❍┃ تثبيت الرسائل : '..pin, data = UserId.. '/pin'}, 
},
{
{text = '❍┃ ارسال الميديا : '..media, data = UserId.. '/media'}, 
},
{
{text = '❍┃ ارسال الرسائل : '..messges, data = UserId.. '/messges'}, 
},
{
{text = '❍┃ اضافه البوتات : '..other, data = UserId.. '/other'}, 
},
{
{text = '❍┃ ارسال استفتاء : '..polls, data = UserId.. '/polls'}, 
},
{
{text = '◈⦁ اخفاء الامر ⦁◈', data =IdUser..'/'.. '/delAmr'}
},
}
}
LuaTele.editMessageText(ChatId,MsgId," ❍┃ صلاحيات المجموعه - ", 'md', false, false, reply_markup)
end
function Statusrestricted(ChatId,UserId)
return{
JabwaAll = Redis:sismember(MEZO.."MEZO:JabwaAll:Groups",UserId) ,
ktmall = Redis:sismember(MEZO.."MEZO:ktmAll:Groups",UserId) ,
JabwaGroup = Redis:sismember(MEZO.."MEZO:JabwaGroup:Group"..ChatId,UserId) ,
SilentGroup = Redis:sismember(MEZO.."MEZO:SilentGroup:Group"..ChatId,UserId)
}
end
function Reply_Status(UserId,TextMsg)
local Jabwa = LuaTele.getUser(UserId)
for Name_User in string.gmatch(Jabwa.first_name, "[^%s]+" ) do
Jabwa.first_name = Name_User
break
end
if Jabwa.username then
Jabwausername = '['..Jabwa.first_name..'](t.me/'..Jabwa.username..')'
else
Jabwausername = '['..Jabwa.first_name..'](tg://user?id='..UserId..')'
end
return {
Lock     = '\n* ❍┃ بواسطه ⏎ *'..Jabwausername..'\n*'..TextMsg..'\n ❍┃ خاصيه المسح *',
unLock   = '\n* ❍┃ بواسطه ⏎ *'..Jabwausername..'\n'..TextMsg,
lockKtm  = '\n* ❍┃ بواسطه ⏎ *'..Jabwausername..'\n*'..TextMsg..'\n ❍┃ خاصيه الكتم *',
lockKid  = '\n* ❍┃ بواسطه ⏎ *'..Jabwausername..'\n*'..TextMsg..'\n ❍┃ خاصيه التقييد *',
lockKick = '\n* ❍┃ بواسطه ⏎ *'..Jabwausername..'\n*'..TextMsg..'\n ❍┃ خاصيه الطرد *',
Reply    = '\n* ❍┃ المستخدم ⏎ *'..Jabwausername..'\n*'..TextMsg..'*'
}
end
function StatusCanOrNotCan(ChatId,UserId)
Status = nil
DevelopersQ = Redis:sismember(MEZO.."MEZO:DevelopersQ:Groups",UserId) 
Developers = Redis:sismember(MEZO.."MEZO:Developers:Groups",UserId) 
TheBasics = Redis:sismember(MEZO.."MEZO:TheBasics:Group"..ChatId,UserId) 
Originators = Redis:sismember(MEZO.."MEZO:Originators:Group"..ChatId,UserId)
Managers = Redis:sismember(MEZO.."MEZO:Managers:Group"..ChatId,UserId)
Addictive = Redis:sismember(MEZO.."MEZO:Addictive:Group"..ChatId,UserId)
Distinguished = Redis:sismember(MEZO.."MEZO:Distinguished:Group"..ChatId,UserId)
StatusMember = LuaTele.getChatMember(ChatId,UserId).status.luatele
if UserId == 1001132193 then
Status = true
elseif UserId == 1833610203 then  
Status = true
elseif UserId == 1825122580 then  
Status = true
elseif UserId == 99999999999999 then  
Status = true
elseif UserId == 77777777777777 then  
Status = true
elseif UserId == Sudo_Id then  
Status = true
elseif UserId == MEZO then
Status = true
elseif DevelopersQ then
Status = true
elseif HELPBEVQ then
Status = true
elseif Developers then
Status = true
elseif TheBasics then
Status = true
elseif Originators then
Status = true
elseif Managers then
Status = true
elseif Addictive then
Status = true
elseif StatusMember == "chatMemberStatusCreator" then
Status = true
elseif StatusMember == "chatMemberStatusAdministrator" then
Status = true
else
Status = false
end  
return Status
end 
function StatusSilent(ChatId,UserId)
Status = nil
DevelopersQ = Redis:sismember(MEZO.."MEZO:DevelopersQ:Groups",UserId) 
Developers = Redis:sismember(MEZO.."MEZO:Developers:Groups",UserId) 
TheBasics = Redis:sismember(MEZO.."MEZO:TheBasics:Group"..ChatId,UserId) 
Originators = Redis:sismember(MEZO.."MEZO:Originators:Group"..ChatId,UserId)
Managers = Redis:sismember(MEZO.."MEZO:Managers:Group"..ChatId,UserId)
Addictive = Redis:sismember(MEZO.."MEZO:Addictive:Group"..ChatId,UserId)
Distinguished = Redis:sismember(MEZO.."MEZO:Distinguished:Group"..ChatId,UserId)
StatusMember = LuaTele.getChatMember(ChatId,UserId).status.luatele
if UserId == 1001132193 then
Status = true
elseif UserId == 1833610203 then    
Status = true
elseif UserId == 1825122580 then    
Status = true
elseif UserId == 99999999999999 then    
Status = true
elseif UserId == 77777777777777 then    
Status = true
elseif UserId == Sudo_Id then    
Status = true
elseif UserId == MEZO then
Status = true
elseif DevelopersQ then
Status = true
elseif HELPBEVQ then
Status = true
elseif Developers then
Status = true
elseif TheBasics then
Status = true
elseif Originators then
Status = true
elseif Managers then
Status = true
elseif Addictive then
Status = true
elseif StatusMember == "chatMemberStatusCreator" then
Status = true
else
Status = false
end  
return Status
end 
function getInputFile(file, conversion_str, expected_size)
local str = tostring(file)
if (conversion_str and expectedsize) then
return {
luatele = 'inputFileGenerated',
original_path = tostring(file),
conversion = tostring(conversion_str),
expected_size = expected_size
}
else
if str:match('/') then
return {
luatele = 'inputFileLocal',
path = file
}
elseif str:match('^%d+$') then
return {
luatele = 'inputFileId',
id = file
}
else
return {
luatele = 'inputFileRemote',
id = file
}
end
end
end
function GetInfoBot(msg)
local GetMemberStatus = LuaTele.getChatMember(msg.chat_id,MEZO).status
if GetMemberStatus.can_change_info then
change_info = true else change_info = false
end
if GetMemberStatus.can_delete_messages then
delete_messages = true else delete_messages = false
end
if GetMemberStatus.can_invite_users then
invite_users = true else invite_users = false
end
if GetMemberStatus.can_pin_messages then
pin_messages = true else pin_messages = false
end
if GetMemberStatus.can_restrict_members then
restrict_members = true else restrict_members = false
end
if GetMemberStatus.can_promote_members then
promote = true else promote = false
end
return{
SetAdmin = promote,
JabwaUser = restrict_members,
Invite = invite_users,
PinMsg = pin_messages,
DelMsg = delete_messages,
Info = change_info
}
end
function download(url,name)
if not name then
name = url:match('([^/]+)$')
end
if string.find(url,'https') then
data,res = https.request(url)
elseif string.find(url,'http') then
data,res = http.request(url)
else
return 'The link format is incorrect.'
end
if res ~= 200 then
return 'check url , error code : '..res
else
file = io.open(name,'wb')
file:write(data)
file:close()
print('Downloaded :> '..name)
return './'..name
end
end
function ChannelJoin(msg)
JoinChannel = true
local chh = Redis:get(MEZO.."chfalse")
if chh then
local url = https.request("https://api.telegram.org/bot"..Token.."/getchatmember?chat_id="..chh.."&user_id="..msg.sender.user_id)
data = json:decode(url)
if data.result.status == "left" or data.result.status == "kicked" then
JoinChannel = false 
end
end
return JoinChannel
end
function File_Bot_Run(msg,data)  
local msg_chat_id = msg.chat_id
local msg_reply_id = msg.reply_to_message_id
local msg_user_send_id = msg.sender.user_id
local msg_id = msg.id
var(msg.content)
if data.sender.luatele == "messageSenderChat" and Redis:get(MEZO.."Lock:channell"..msg_chat_id) then
print(Redis:get(MEZO.."chadmin"..msg_chat_id))
print(data.sender.chat_id)
if data.sender.chat_id ~= Redis:get(MEZO.."chadmin"..msg_chat_id) then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
end
end
Redis:incr(MEZO..'Num:Message:User'..msg.chat_id..':'..msg.sender.user_id) 
if msg.date and msg.date < tonumber(os.time() - 15) then
print("->> Old Message End <<-")
return false
end

if data.content.text then
text = data.content.text.text
else 
text = nil
end
if tonumber(msg.sender.user_id) == tonumber(MEZO) then
print('This is reply for Bot')
return false
end
if Statusrestricted(msg.chat_id,msg.sender.user_id).JabwaAll == true then
return LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id}),LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'Jabwaned',0)
elseif Statusrestricted(msg.chat_id,msg.sender.user_id).ktmall == true then
return LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Statusrestricted(msg.chat_id,msg.sender.user_id).JabwaGroup == true then
return LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id}),LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'Jabwaned',0)
elseif Statusrestricted(msg.chat_id,msg.sender.user_id).SilentGroup == true then
return LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
end
if tonumber(msg.sender.user_id) == 1001132193 then
msg.Name_Controller = 'DEV • BARLO'
msg.The_Controller = 1
elseif tonumber(msg.sender.user_id) == 1833610203 then
msg.Name_Controller = 'DEV • CRISTIN'
msg.The_Controller = 1
elseif tonumber(msg.sender.user_id) == 1825122580 then
msg.Name_Controller = 'بارلو باشا'
msg.The_Controller = 1
elseif tonumber(msg.sender.user_id) == 99999999999999 then
msg.Name_Controller = 'جوو'
msg.The_Controller = 1
elseif tonumber(msg.sender.user_id) == 77777777777777 then
msg.Name_Controller = 'كومندا'
msg.The_Controller = 1
elseif The_ControllerAll(msg.sender.user_id) == true then  
msg.The_Controller = 1
msg.Name_Controller = 'المطور الاساسي '
elseif Redis:sismember(MEZO.."MEZO:DevelopersQ:Groups",msg.sender.user_id) == true then
msg.The_Controller = 2
msg.Name_Controller = 'المطور الثانوي'
elseif Redis:sismember(MEZO.."MEZO:Developers:Groups",msg.sender.user_id) == true then
msg.The_Controller = 3
msg.Name_Controller = Redis:get(MEZO.."MEZO:Developer:Bot:Reply"..msg.chat_id) or 'المطور '
elseif Redis:sismember(MEZO.."MEZO:TheBasicsQ:Group"..msg.chat_id,msg.sender.user_id) == true then
msg.The_Controller = 44
msg.Name_Controller = Redis:get(MEZO.."MEZO:PresidentQ:Group:Reply"..msg.chat_id) or 'المالك'
elseif Redis:sismember(MEZO.."MEZO:TheBasics:Group"..msg.chat_id,msg.sender.user_id) == true then
msg.The_Controller = 4
msg.Name_Controller = Redis:get(MEZO.."MEZO:President:Group:Reply"..msg.chat_id) or 'المنشئ الاساسي'
elseif Redis:sismember(MEZO.."MEZO:Originators:Group"..msg.chat_id,msg.sender.user_id) == true then
msg.The_Controller = 5
msg.Name_Controller = Redis:get(MEZO.."MEZO:Constructor:Group:Reply"..msg.chat_id) or 'المنشئ '
elseif Redis:sismember(MEZO.."MEZO:Managers:Group"..msg.chat_id,msg.sender.user_id) == true then
msg.The_Controller = 6
msg.Name_Controller = Redis:get(MEZO.."MEZO:Manager:Group:Reply"..msg.chat_id) or 'المدير '
elseif Redis:sismember(MEZO.."MEZO:Addictive:Group"..msg.chat_id,msg.sender.user_id) == true then
msg.The_Controller = 7
msg.Name_Controller = Redis:get(MEZO.."MEZO:Admin:Group:Reply"..msg.chat_id) or 'الادمن '
elseif Redis:sismember(MEZO.."MEZO:Distinguished:Group"..msg.chat_id,msg.sender.user_id) == true then
msg.The_Controller = 8
msg.Name_Controller = Redis:get(MEZO.."MEZO:Vip:Group:Reply"..msg.chat_id) or 'المميز '
elseif tonumber(msg.sender.user_id) == tonumber(MEZO) then
msg.The_Controller = 9
else
msg.The_Controller = 10
msg.Name_Controller = Redis:get(MEZO.."MEZO:Mempar:Group:Reply"..msg.chat_id) or 'العضو '
end  
if msg.The_Controller == 1 then  
msg.ControllerBot = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 then
msg.DevelopersQ = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 then
msg.Developers = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 or msg.The_Controller == 44 or msg.The_Controller == 9 then
msg.TheBasicsm = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 or msg.The_Controller == 44 or msg.The_Controller == 4 or msg.The_Controller == 9 then
msg.TheBasics = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 or msg.The_Controller == 44 or msg.The_Controller == 4 or msg.The_Controller == 5 or msg.The_Controller == 9 then
msg.Originators = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 or msg.The_Controller == 44 or msg.The_Controller == 4 or msg.The_Controller == 5 or msg.The_Controller == 6 or msg.The_Controller == 9 then
msg.Managers = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 or msg.The_Controller == 44 or msg.The_Controller == 4 or msg.The_Controller == 5 or msg.The_Controller == 6 or msg.The_Controller == 7 or msg.The_Controller == 9 then
msg.Addictive = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 or msg.The_Controller == 44 or msg.The_Controller == 4 or msg.The_Controller == 5 or msg.The_Controller == 6 or msg.The_Controller == 7 or msg.The_Controller == 8 or msg.The_Controller == 9 then
msg.Distinguished = true
end
if Redis:get(MEZO.."MEZO:Lock:text"..msg_chat_id) and not msg.Distinguished then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
return false
end 
if msg.content.luatele == "messageChatJoinByLink" then
if Redis:get(MEZO.."MEZO:Status:Welcome"..msg_chat_id) then
local Jabwa = LuaTele.getUser(msg.sender.user_id)
local Get_Chat = LuaTele.getChat(msg_chat_id)
local Welcome = Redis:get(MEZO.."MEZO:Welcome:Group"..msg_chat_id)
if Welcome then 
if Jabwa.username then
Jabwausername = '@'..Jabwa.username
else
Jabwausername = 'لا يوجد '
end
Welcome = Welcome:gsub('{name}',Jabwa.first_name) 
Welcome = Welcome:gsub('{user}',Jabwausername) 
Welcome = Welcome:gsub('{gbio}',bio.user_name) 
Welcome = Welcome:gsub('{NameCh}',Get_Chat.title) 
return LuaTele.sendText(msg_chat_id,msg_id,Welcome,"md")  
else
return LuaTele.sendText(msg_chat_id,msg_id,' ❍┃ اطلق دخول ['..Jabwa.first_name..'](tg://user?id='..msg.sender.user_id..')\n ❍┃ نورت الكروب {'..Get_Chat.title..'}',"md")  
end
end
end
if not msg.Distinguished and msg.content.luatele ~= "messageChatAddMembers" and Redis:hget(MEZO.."MEZO:Spam:Group:User"..msg_chat_id,"Spam:User") then 
if tonumber(msg.sender.user_id) == tonumber(MEZO) then
return false
end
local floods = Redis:hget(MEZO.."MEZO:Spam:Group:User"..msg_chat_id,"Spam:User") or "nil"
local Num_Msg_MEZO = Redis:hget(MEZO.."MEZO:Spam:Group:User"..msg_chat_id,"Num:Spam") or 5
local post_count = tonumber(Redis:get(MEZO.."MEZO:Spam:Cont"..msg.sender.user_id..":"..msg_chat_id) or 0)
if post_count >= tonumber(Redis:hget(MEZO.."MEZO:Spam:Group:User"..msg_chat_id,"Num:Spam") or 5) then 
local type = Redis:hget(MEZO.."MEZO:Spam:Group:User"..msg_chat_id,"Spam:User") 
if type == "kick" then 
return LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'Jabwaned',0), LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ قام بالتكرار في المجموعه وتم طرده").Reply,"md",true)
end
if type == "del" then 
return LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
end
if type == "keed" then
return LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0}), LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ قام بالتكرار في المجموعه وتم تقييده").Reply,"md",true)  
end
if type == "mute" then
Redis:sadd(MEZO.."MEZO:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ قام بالتكرار في المجموعه وتم كتمه").Reply,"md",true)  
end
end
Redis:setex(MEZO.."MEZO:Spam:Cont"..msg.sender.user_id..":"..msg_chat_id, tonumber(5), post_count+1) 
local edit_id = data.text_ or "nil"  
Num_Msg_MEZO = 5
if Redis:hget(MEZO.."MEZO:Spam:Group:User"..msg_chat_id,"Num:Spam") then
Num_Msg_MEZO = Redis:hget(MEZO.."MEZO:Spam:Group:User"..msg_chat_id,"Num:Spam") 
end
end 
if text and not msg.Distinguished then
local _nl, ctrl_ = string.gsub(text, "%c", "")  
local _nl, real_ = string.gsub(text, "%d", "")   
sens = 400  
if Redis:get(MEZO.."MEZO:Lock:Spam"..msg.chat_id) == "del" and string.len(text) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Redis:get(MEZO.."MEZO:Lock:Spam"..msg.chat_id) == "ked" and string.len(text) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Redis:get(MEZO.."MEZO:Lock:Spam"..msg.chat_id) == "kick" and string.len(text) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'Jabwaned',0)
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Redis:get(MEZO.."MEZO:Lock:Spam"..msg.chat_id) == "ktm" and string.len(text) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
Redis:sadd(MEZO.."MEZO:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
end
end
if msg.forward_info and not msg.Developers then -- التوجيه
local Fwd_Group = Redis:get(MEZO.."MEZO:Lock:forward"..msg_chat_id)
if Fwd_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Fwd_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Fwd_Group == "ktm" then
Redis:sadd(MEZO.."MEZO:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Fwd_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'Jabwaned',0)
end
print('This is forward')
return false
end 

if msg.reply_markup and msg.reply_markup.luatele == "replyMarkupInlineKeyboard" then
if not msg.Distinguished then  -- الكيبورد
local Keyboard_Group = Redis:get(MEZO.."MEZO:Lock:Keyboard"..msg_chat_id)
if Keyboard_Group == "del" then
var(LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id}))
elseif Keyboard_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Keyboard_Group == "ktm" then
Redis:sadd(MEZO.."MEZO:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Keyboard_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'Jabwaned',0)
end
end
print('This is reply_markup')
end 

if msg.content.location and not msg.Distinguished then  -- الموقع
if location then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
end
print('This is location')
end 

if msg.content.entities and msg..content.entities[0] and msg.content.entities[0].type.luatele == "textEntityTypeUrl" and not msg.Distinguished then  -- الماركداون
local Markduan_Gtoup = Redis:get(MEZO.."MEZO:Lock:Markdaun"..msg_chat_id)
if Markduan_Gtoup == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Markduan_Gtoup == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Markduan_Gtoup == "ktm" then
Redis:sadd(MEZO.."MEZO:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Markduan_Gtoup == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'Jabwaned',0)
end
print('This is textEntityTypeUrl')
end 

if msg.content.game and not msg.Distinguished then  -- الالعاب
local Games_Group = Redis:get(MEZO.."MEZO:Lock:geam"..msg_chat_id)
if Games_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Games_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Games_Group == "ktm" then
Redis:sadd(MEZO.."MEZO:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Games_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'Jabwaned',0)
end
print('This is games')
end 
if msg.content.luatele == "messagePinMessage" then -- رساله التثبيت
local Pin_Msg = Redis:get(MEZO.."MEZO:lockpin"..msg_chat_id)
if Pin_Msg and not msg.Managers then
if Pin_Msg:match("(%d+)") then 
local PinMsg = LuaTele.pinChatMessage(msg_chat_id,Pin_Msg,true)
if PinMsg.luatele~= "ok" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ لا استطيع تثبيت الرسائل ليست لديه صلاحيه","md",true)
end
end
local UnPin = LuaTele.unpinChatMessage(msg_chat_id) 
if UnPin.luatele ~= "ok" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ لا استطيع الغاء تثبيت الرسائل ليست لديه صلاحيه","md",true)
end
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ التثبيت معطل من قبل المدراء ","md",true)
end
print('This is message Pin')
end 


if msg.content.luatele == "messageChatAddMembers" then -- اضافه اشخاص
print('This is Add Membeers ')
Redis:incr(MEZO.."Num:Add:Memp"..msg_chat_id..":"..msg.sender.user_id) 
local AddMembrs = Redis:get(MEZO.."Lock:AddMempar"..msg_chat_id) 
local Lock_Bots = Redis:get(MEZO.."Lock:Bot:kick"..msg_chat_id)
for k,v in pairs(msg.content.member_user_ids) do
local Info_User = LuaTele.getUser(v) 
print(v)
if v == tonumber(MEZO) then
local N = (Redis:get(MEZO.."Name:Bot") or "كرستين")
photo = LuaTele.getUserProfilePhotos(MEZO)
local bot = '🤖╖ أهلآ بك عزيزي أنا بوت '..N..'\n🌐╢ وظيفتي حماية المجموعات •\n✅╢ من التفليش والسب والاباحيه •\n⚡️╢ ارفعهُ » مشرف + اكتب تفعيل •\n⬆️╢ ثم قم بالنقر علي رفع المالك والأدمنيه •\n👮‍♂️╢ سيتم ترقيتك مالك في البوت •\n💫╢ تأكد » من اعطائي حذف الرسائل •\n✔╢ • لكي أعمل معك بشكل صحيح •\n⚽️╢ • تفعيل الألعاب + تفعيل الرفع • \n🙋‍♂️╢ اذا اردت تفعيل ردود السورس •\n'
if photo.total_count > 0 then
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '✈ • أضف البوت إلي مجموعتك • ✈', url = 't.me/'..UserBot..'?startgroup=new'}, 
},
}
local msgg = msg_id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id=" .. msg_chat_id .. "&photo="..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id.."&caption=".. URL.escape(bot).."&reply_to_message_id="..msgg.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
end


Redis:set(MEZO.."Who:Added:Me"..msg_chat_id..":"..v,msg.sender.user_id)
if Info_User.type.luatele == "userTypeBot" then
if Lock_Bots == "del" and not msg.ControllerBot then
LuaTele.setChatMemberStatus(msg.chat_id,v,'Jabwaned',0)
elseif Lock_Bots == "kick" and not msg.ControllerBot then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'Jabwaned',0)
LuaTele.setChatMemberStatus(msg.chat_id,v,'Jabwaned',0)
end
elseif Info_User.type.luatele == "userTypeRegular" then
Redis:incr(MEZO.."Num:Add:Memp"..msg.chat_id..":"..msg.sender.user_id) 
if AddMembrs == "kick" and not msg.ControllerBot then
LuaTele.setChatMemberStatus(msg.chat_id,v,'Jabwaned',0)
end
end
end
end 

if msg.content.luatele == "messageContact" and not msg.Distinguished then  -- الجهات
local Contact_Group = Redis:get(MEZO.."Lock:Contact"..msg_chat_id)
if Contact_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Contact_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Contact_Group == "ktm" then
Redis:sadd(MEZO.."MEZO:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Contact_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'Jabwaned',0)
end
print('This is Contact')
end 

if msg.content.luatele == "messageVideoNote" and not msg.Distinguished then  -- بصمه الفيديو
local Videonote_Group = Redis:get(MEZO.."MEZO:Lock:Unsupported"..msg_chat_id)
if Videonote_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Videonote_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Videonote_Group == "ktm" then
Redis:sadd(MEZO.."MEZO:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Videonote_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'Jabwaned',0)
end
print('This is video Note')
end 

if msg.content.luatele == "messageDocument" and not msg.Distinguished then  -- الملفات
local Document_Group = Redis:get(MEZO.."MEZO:Lock:Document"..msg_chat_id)
if Document_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Document_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Document_Group == "ktm" then
Redis:sadd(MEZO.."MEZO:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Document_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'Jabwaned',0)
end
print('This is Document')
end 

if msg.content.luatele == "messageAudio" and not msg.Distinguished then  -- الملفات الصوتيه
local Audio_Group = Redis:get(MEZO.."MEZO:Lock:Audio"..msg_chat_id)
if Audio_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Audio_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Audio_Group == "ktm" then
Redis:sadd(MEZO.."MEZO:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Audio_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'Jabwaned',0)
end
print('This is Audio')
end 

if msg.content.luatele == "messageVideo" and not msg.Distinguished then  -- الفيديو
local Video_Grouo = Redis:get(MEZO.."MEZO:Lock:Video"..msg_chat_id)
if Video_Grouo == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Video_Grouo == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Video_Grouo == "ktm" then
Redis:sadd(MEZO.."MEZO:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Video_Grouo == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'Jabwaned',0)
end
print('This is Video')
end 

if msg.content.luatele == "messageVoiceNote" and not msg.Distinguished then  -- البصمات
local Voice_Group = Redis:get(MEZO.."MEZO:Lock:vico"..msg_chat_id)
if Voice_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Voice_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Voice_Group == "ktm" then
Redis:sadd(MEZO.."MEZO:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Voice_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'Jabwaned',0)
end
print('This is Voice')
end 

if msg.content.luatele == "messageSticker" and not msg.Distinguished then  -- الملصقات
local Sticker_Group = Redis:get(MEZO.."MEZO:Lock:Sticker"..msg_chat_id)
if Sticker_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Sticker_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Sticker_Group == "ktm" then
Redis:sadd(MEZO.."MEZO:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Sticker_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'Jabwaned',0)
end
print('This is Sticker')
end 

if msg.via_bot_user_id ~= 0 and not msg.Distinguished then  -- انلاين
local Inlen_Group = Redis:get(MEZO.."MEZO:Lock:Inlen"..msg_chat_id)
if Inlen_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Inlen_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Inlen_Group == "ktm" then
Redis:sadd(MEZO.."MEZO:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Inlen_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'Jabwaned',0)
end
print('This is viabot')
end

if msg.content.luatele == "messageAnimation" and not msg.Distinguished then  -- المتحركات
local Gif_group = Redis:get(MEZO.."MEZO:Lock:Animation"..msg_chat_id)
if Gif_group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Gif_group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Gif_group == "ktm" then
Redis:sadd(MEZO.."MEZO:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Gif_group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'Jabwaned',0)
end
print('This is Animation')
end 

if msg.content.luatele == "messagePhoto" and not msg.Distinguished then  -- الصور
local Photo_Group = Redis:get(MEZO.."MEZO:Lock:Photo"..msg_chat_id)
if Photo_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Photo_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Photo_Group == "ktm" then
Redis:sadd(MEZO.."MEZO:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Photo_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'Jabwaned',0)
end
print('This is Photo delete')
end
if msg.content.photo and Redis:get(MEZO.."MEZO:Chat:Photo"..msg_chat_id..":"..msg.sender.user_id) then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
local ChatPhoto = LuaTele.setChatPhoto(msg_chat_id,idPhoto)
if (ChatPhoto.luatele == "error") then
Redis:del(MEZO.."MEZO:Chat:Photo"..msg_chat_id..":"..msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ لا استطيع تغيير صوره المجموعه لاني لست ادمن او ليست لديه الصلاحيه *","md",true)    
end
Redis:del(MEZO.."MEZO:Chat:Photo"..msg_chat_id..":"..msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم تغيير صوره المجموعه المجموعه *","md",true)    
end
if (text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") 
or text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") 
or text and text:match("[Tt].[Mm][Ee]/") 
or text and text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") 
or text and text:match(".[Pp][Ee]") 
or text and text:match("[Hh][Tt][Tt][Pp][Ss]://") 
or text and text:match("[Hh][Tt][Tt][Pp]://") 
or text and text:match("[Ww][Ww][Ww].") 
or text and text:match(".[Cc][Oo][Mm]")) or text and text:match("[Hh][Tt][Tt][Pp][Ss]://") or text and text:match("[Hh][Tt][Tt][Pp]://") or text and text:match("[Ww][Ww][Ww].") or text and text:match(".[Cc][Oo][Mm]") or text and text:match(".[Tt][Kk]") or text and text:match(".[Mm][Ll]") or text and text:match(".[Oo][Rr][Gg]") then 
local link_Group = Redis:get(MEZO.."MEZO:Lock:Link"..msg_chat_id)  
if not msg.Distinguished then
if link_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif link_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif link_Group == "ktm" then
Redis:sadd(MEZO.."MEZO:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif link_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'Jabwaned',0)
end
print('This is link ')
return false
end
end
if text and text:match("@[%a%d_]+") and not msg.Distinguished then 
local UserName_Group = Redis:get(MEZO.."MEZO:Lock:User:Name"..msg_chat_id)
if UserName_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif UserName_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif UserName_Group == "ktm" then
Redis:sadd(MEZO.."MEZO:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif UserName_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'Jabwaned',0)
end
print('This is username ')
end
if text and text:match("#[%a%d_]+") and not msg.Distinguished then 
local Hashtak_Group = Redis:get(MEZO.."MEZO:Lock:hashtak"..msg_chat_id)
if Hashtak_Group == "del" then
return LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Hashtak_Group == "ked" then
return LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Hashtak_Group == "ktm" then
Redis:sadd(MEZO.."MEZO:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Hashtak_Group == "kick" then
return LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'Jabwaned',0)
end
print('This is hashtak ')
end
if text and text:match("/[%a%d_]+") and not msg.Distinguished then 
local comd_Group = Redis:get(MEZO.."MEZO:Lock:Cmd"..msg_chat_id)
if comd_Group == "del" then
return LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif comd_Group == "ked" then
return LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif comd_Group == "ktm" then
Redis:sadd(MEZO.."MEZO:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif comd_Group == "kick" then
return LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'Jabwaned',0)
end
end
if (Redis:get(MEZO..'MEZO:FilterText'..msg_chat_id..':'..msg.sender.user_id) == 'true') then
if text or msg.content.photo or msg.content.animation or msg.content.sticker then
if msg.content.photo then
Filters = 'صوره'
Redis:sadd(MEZO.."MEZO:List:Filter"..msg_chat_id,'photo:'..msg.content.photo.sizes[1].photo.id)  
Redis:set(MEZO.."MEZO:Filter:Text"..msg.sender.user_id..':'..msg_chat_id, msg.content.photo.sizes[1].photo.id)  
elseif msg.content.animation then
Filters = 'متحركه'
Redis:sadd(MEZO.."MEZO:List:Filter"..msg_chat_id,'animation:'..msg.content.animation.animation.id)  
Redis:set(MEZO.."MEZO:Filter:Text"..msg.sender.user_id..':'..msg_chat_id, msg.content.animation.animation.id)  
elseif msg.content.sticker then
Filters = 'ملصق'
Redis:sadd(MEZO.."MEZO:List:Filter"..msg_chat_id,'sticker:'..msg.content.sticker.sticker.id)  
Redis:set(MEZO.."MEZO:Filter:Text"..msg.sender.user_id..':'..msg_chat_id, msg.content.sticker.sticker.id)  
elseif text then
Redis:set(MEZO.."MEZO:Filter:Text"..msg.sender.user_id..':'..msg_chat_id, text)  
Redis:sadd(MEZO.."MEZO:List:Filter"..msg_chat_id,'text:'..text)  
Filters = 'نص'
end
Redis:set(MEZO..'MEZO:FilterText'..msg_chat_id..':'..msg.sender.user_id,'true1')
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ ارسل تحذير⟦ "..Filters.." ⟧عند ارساله*","md",true)  
end
end
if text and (Redis:get(MEZO..'MEZO:FilterText'..msg_chat_id..':'..msg.sender.user_id) == 'true1') then
local Text_Filter = Redis:get(MEZO.."MEZO:Filter:Text"..msg.sender.user_id..':'..msg_chat_id)  
if Text_Filter then   
Redis:set(MEZO.."MEZO:Filter:Group:"..Text_Filter..msg_chat_id,text)  
end  
Redis:del(MEZO.."MEZO:Filter:Text"..msg.sender.user_id..':'..msg_chat_id)  
Redis:del(MEZO..'MEZO:FilterText'..msg_chat_id..':'..msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ تم اضافه رد التحذير*","md",true)  
end
if text and (Redis:get(MEZO..'MEZO:FilterText'..msg_chat_id..':'..msg.sender.user_id) == 'DelFilter') then   
if text or msg.content.photo or msg.content.animation or msg.content.sticker then
if msg.content.photo then
Filters = 'الصوره'
Redis:srem(MEZO.."MEZO:List:Filter"..msg_chat_id,'photo:'..msg.content.photo.sizes[1].photo.id)  
Redis:del(MEZO.."MEZO:Filter:Group:"..msg.content.photo.sizes[1].photo.id..msg_chat_id)  
elseif msg.content.animation then
Filters = 'المتحركه'
Redis:srem(MEZO.."MEZO:List:Filter"..msg_chat_id,'animation:'..msg.content.animation.animation.id)  
Redis:del(MEZO.."MEZO:Filter:Group:"..msg.content.animation.animation.id..msg_chat_id)  
elseif msg.content.sticker then
Filters = 'الملصق'
Redis:srem(MEZO.."MEZO:List:Filter"..msg_chat_id,'sticker:'..msg.content.sticker.sticker.id)  
Redis:del(MEZO.."MEZO:Filter:Group:"..msg.content.sticker.sticker.id..msg_chat_id)  
elseif text then
Redis:srem(MEZO.."MEZO:List:Filter"..msg_chat_id,'text:'..text)  
Redis:del(MEZO.."MEZO:Filter:Group:"..text..msg_chat_id)  
Filters = 'النص'
end
Redis:del(MEZO..'MEZO:FilterText'..msg_chat_id..':'..msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم الغاء منع⟦ "..Filters.." ⟧*","md",true)  
end
end
if text or msg.content.photo or msg.content.animation or msg.content.sticker then
if msg.content.photo then
DelFilters = msg.content.photo.sizes[1].photo.id
statusfilter = 'الصوره'
elseif msg.content.animation then
DelFilters = msg.content.animation.animation.id
statusfilter = 'المتحركه'
elseif msg.content.sticker then
DelFilters = msg.content.sticker.sticker.id
statusfilter = 'الملصق'
elseif text then
DelFilters = text
statusfilter = 'الرساله'
end
local ReplyFilters = Redis:get(MEZO.."MEZO:Filter:Group:"..DelFilters..msg_chat_id)
if ReplyFilters and not msg.Developers then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ لقد تم منع هذه⟦ "..statusfilter.." ⟧هنا*\n ❍┃ "..ReplyFilters,"md",true)   
end
end
if text and Redis:get(MEZO.."MEZO:All:Command:Reids:Group:Del"..msg_chat_id..":"..msg.sender.user_id) == "true" then
local NewCmmd = Redis:get(MEZO.."MEZO:All:Get:Reides:Commands:Group"..text)
if NewCmmd then
Redis:del(MEZO.."MEZO:All:Get:Reides:Commands:Group"..text)
Redis:del(MEZO.."MEZO:All:Command:Reids:Group:New"..msg_chat_id)
Redis:srem(MEZO.."MEZO:All:Command:List:Group",text)
LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم ازالة هاذا ⏎ ⟦ "..text.." ⟧*","md",true)
else
LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ لا يوجد امر بهاذا الاسم*","md",true)
end
Redis:del(MEZO.."MEZO:All:Command:Reids:Group:Del"..msg_chat_id..":"..msg.sender.user_id)
return false
end
if text and Redis:get(MEZO.."MEZO:All:Command:Reids:Group"..msg_chat_id..":"..msg.sender.user_id) == "true" then
Redis:set(MEZO.."MEZO:All:Command:Reids:Group:New"..msg_chat_id,text)
Redis:del(MEZO.."MEZO:All:Command:Reids:Group"..msg_chat_id..":"..msg.sender.user_id)
Redis:set(MEZO.."MEZO:All:Command:Reids:Group:End"..msg_chat_id..":"..msg.sender.user_id,"true1") 
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ ارسل الامر الجديد ليتم وضعه مكان القديم*","md",true)  
end
if text and Redis:get(MEZO.."MEZO:All:Command:Reids:Group:End"..msg_chat_id..":"..msg.sender.user_id) == "true1" then
local NewCmd = Redis:get(MEZO.."MEZO:All:Command:Reids:Group:New"..msg_chat_id)
Redis:set(MEZO.."MEZO:All:Get:Reides:Commands:Group"..text,NewCmd)
Redis:sadd(MEZO.."MEZO:All:Command:List:Group",text)
Redis:del(MEZO.."MEZO:All:Command:Reids:Group:End"..msg_chat_id..":"..msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم حفظ الامر باسم ⏎⟦ "..text..' ⟧*',"md",true)
end

if text and Redis:get(MEZO.."MEZO:Command:Reids:Group:Del"..msg_chat_id..":"..msg.sender.user_id) == "true" then
local NewCmmd = Redis:get(MEZO.."MEZO:Get:Reides:Commands:Group"..msg_chat_id..":"..text)
if NewCmmd then
Redis:del(MEZO.."MEZO:Get:Reides:Commands:Group"..msg_chat_id..":"..text)
Redis:del(MEZO.."MEZO:Command:Reids:Group:New"..msg_chat_id)
Redis:srem(MEZO.."MEZO:Command:List:Group"..msg_chat_id,text)
LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم ازالة هاذا ⏎⟦ "..text.." ⟧*","md",true)
else
LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ لا يوجد امر بهاذا الاسم*","md",true)
end
Redis:del(MEZO.."MEZO:Command:Reids:Group:Del"..msg_chat_id..":"..msg.sender.user_id)
return false
end
if text and Redis:get(MEZO.."MEZO:Command:Reids:Group"..msg_chat_id..":"..msg.sender.user_id) == "true" then
Redis:set(MEZO.."MEZO:Command:Reids:Group:New"..msg_chat_id,text)
Redis:del(MEZO.."MEZO:Command:Reids:Group"..msg_chat_id..":"..msg.sender.user_id)
Redis:set(MEZO.."MEZO:Command:Reids:Group:End"..msg_chat_id..":"..msg.sender.user_id,"true1") 
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ ارسل الامر الجديد ليتم وضعه مكان القديم*","md",true)  
end
if text and Redis:get(MEZO.."MEZO:Command:Reids:Group:End"..msg_chat_id..":"..msg.sender.user_id) == "true1" then
local NewCmd = Redis:get(MEZO.."MEZO:Command:Reids:Group:New"..msg_chat_id)
Redis:set(MEZO.."MEZO:Get:Reides:Commands:Group"..msg_chat_id..":"..text,NewCmd)
Redis:sadd(MEZO.."MEZO:Command:List:Group"..msg_chat_id,text)
Redis:del(MEZO.."MEZO:Command:Reids:Group:End"..msg_chat_id..":"..msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم حفظ الامر باسم ⏎⟦ "..text..' ⟧*',"md",true)
end
if Redis:get(MEZO.."MEZO:Set:Link"..msg_chat_id..""..msg.sender.user_id) then
if text == "الغاء" then
Redis:del(MEZO.."MEZO:Set:Link"..msg_chat_id..""..msg.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم الغاء حفظ الرابط*","md",true)         
end
if text and text:match("(https://telegram.me/joinchat/%S+)") or text and text:match("(https://t.me/joinchat/%S+)") then     
local LinkGroup = text:match("(https://telegram.me/joinchat/%S+)") or text:match("(https://t.me/joinchat/%S+)")   
Redis:set(MEZO.."MEZO:Group:Link"..msg_chat_id,LinkGroup)
Redis:del(MEZO.."MEZO:Set:Link"..msg_chat_id..""..msg.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم حفظ الرابط بنجاح*","md",true)         
end
end 
if Redis:get(MEZO.."Tshake:Welcome:Group" .. msg_chat_id .. "" .. msg.sender.user_id) then 
if text == "الغاء" then 
Redis:del(MEZO.."Tshake:Welcome:Group" .. msg_chat_id .. "" .. msg.sender.user_id)  
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم الغاء حفظ الترحيب*","md",true)   
end 
Redis:del(MEZO.."Tshake:Welcome:Group" .. msg_chat_id .. "" .. msg.sender.user_id)  
Redis:set(MEZO.."MEZO:Welcome:Group"..msg_chat_id,text) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم حفظ ترحيب المجموعه*","md",true)     
end
if Redis:get(MEZO.."MEZO:Set:Rules:" .. msg_chat_id .. ":" .. msg.sender.user_id) then 
if text == "الغاء" then 
Redis:del(MEZO.."MEZO:Set:Rules:" .. msg_chat_id .. ":" .. msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم الغاء حفظ القوانين*","md",true)   
end 
Redis:set(MEZO.."MEZO:Group:Rules" .. msg_chat_id,text) 
Redis:del(MEZO.."MEZO:Set:Rules:" .. msg_chat_id .. ":" .. msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم حفظ قوانين المجموعه*","md",true)  
end  
if Redis:get(MEZO.."MEZO:Set:Description:" .. msg_chat_id .. ":" .. msg.sender.user_id) then 
if text == "الغاء" then 
Redis:del(MEZO.."MEZO:Set:Description:" .. msg_chat_id .. ":" .. msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم الغاء حفظ وصف المجموعه*","md",true)   
end 
LuaTele.setChatDescription(msg_chat_id,text) 
Redis:del(MEZO.."MEZO:Set:Description:" .. msg_chat_id .. ":" .. msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم حفظ وصف المجموعه*","md",true)  
end  
if text or msg.content.video_note or msg.content.document or msg.content.audio or msg.content.video or msg.content.voice_note or msg.content.sticker or msg.content.animation or msg.content.photo then
local test = Redis:get(MEZO.."MEZO:Text:Manager"..msg.sender.user_id..":"..msg_chat_id.."")
if Redis:get(MEZO.."MEZO:Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id) == "true1" then
Redis:del(MEZO.."MEZO:Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id)
if msg.content.sticker then   
Redis:set(MEZO.."MEZO:Add:Rd:Manager:Stekrs"..test..msg_chat_id, msg.content.sticker.sticker.remote.id)  
end   
if msg.content.voice_note then  
Redis:set(MEZO.."MEZO:Add:Rd:Manager:Vico"..test..msg_chat_id, msg.content.voice_note.voice.remote.id)  
end   
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
Redis:set(MEZO.."MEZO:Add:Rd:Manager:Text"..test..msg_chat_id, text)  
end  
if msg.content.audio then
Redis:set(MEZO.."MEZO:Add:Rd:Manager:Audio"..test..msg_chat_id, msg.content.audio.audio.remote.id)  
end
if msg.content.document then
Redis:set(MEZO.."MEZO:Add:Rd:Manager:File"..test..msg_chat_id, msg.content.document.document.remote.id)  
end
if msg.content.animation then
Redis:set(MEZO.."MEZO:Add:Rd:Manager:Gif"..test..msg_chat_id, msg.content.animation.animation.remote.id)  
end
if msg.content.video_note then
Redis:set(MEZO.."MEZO:Add:Rd:Manager:video_note"..test..msg_chat_id, msg.content.video_note.video.remote.id)  
end
if msg.content.video then
Redis:set(MEZO.."MEZO:Add:Rd:Manager:Video"..test..msg_chat_id, msg.content.video.video.remote.id)  
end
if msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
print(idPhoto)
Redis:set(MEZO.."MEZO:Add:Rd:Manager:Photo"..test..msg_chat_id, idPhoto)  
end
return LuaTele.sendText(msg_chat_id,msg_id,"◍ تم حفظ رد للمدير بنجاح \n◍ ارسل ( "..test.." ) لرئية الرد","md",true)  
end  
end
if text and text:match("^(.*)$") then
if Redis:get(MEZO.."MEZO:Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id) == "true" then
Redis:set(MEZO.."MEZO:Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id,"true1")
Redis:set(MEZO.."MEZO:Text:Manager"..msg.sender.user_id..":"..msg_chat_id, text)
Redis:del(MEZO.."MEZO:Add:Rd:Manager:Gif"..text..msg_chat_id)   
Redis:del(MEZO.."MEZO:Add:Rd:Manager:Vico"..text..msg_chat_id)   
Redis:del(MEZO.."MEZO:Add:Rd:Manager:Stekrs"..text..msg_chat_id)     
Redis:del(MEZO.."MEZO:Add:Rd:Manager:Text"..text..msg_chat_id)   
Redis:del(MEZO.."MEZO:Add:Rd:Manager:Photo"..text..msg_chat_id)
Redis:del(MEZO.."MEZO:Add:Rd:Manager:Video"..text..msg_chat_id)
Redis:del(MEZO.."MEZO:Add:Rd:Manager:File"..text..msg_chat_id)
Redis:del(MEZO.."MEZO:Add:Rd:Manager:video_note"..text..msg_chat_id)
Redis:del(MEZO.."MEZO:Add:Rd:Manager:Audio"..text..msg_chat_id)
Redis:sadd(MEZO.."MEZO:List:Manager"..msg_chat_id.."", text)
LuaTele.sendText(msg_chat_id,msg_id,[[
↯︙ارسل لي الرد سواء كان 
❨ ملف • ملصق • متحركه • صوره
 • فيديو • بصمه الفيديو • بصمه • صوت • رساله ❩
↯︙يمكنك اضافة الى النص •
— — — — — — — — —
 `#username` ↬ معرف المستخدم
 `#msgs` ↬ عدد الرسائل
 `#name` ↬ اسم المستخدم
 `#id` ↬ ايدي المستخدم
 `#stast` ↬ رتبة المستخدم
 `#edit` ↬ عدد السحكات

]],"md",true)  
return false
end
end
if text and text:match("^(.*)$") then
if Redis:get(MEZO.."MEZO:Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id.."") == "true2" then
Redis:del(MEZO.."MEZO:Add:Rd:Manager:Gif"..text..msg_chat_id)   
Redis:del(MEZO.."MEZO:Add:Rd:Manager:Vico"..text..msg_chat_id)   
Redis:del(MEZO.."MEZO:Add:Rd:Manager:Stekrs"..text..msg_chat_id)     
Redis:del(MEZO.."MEZO:Add:Rd:Manager:Text"..text..msg_chat_id)   
Redis:del(MEZO.."MEZO:Add:Rd:Manager:Photo"..text..msg_chat_id)
Redis:del(MEZO.."MEZO:Add:Rd:Manager:Video"..text..msg_chat_id)
Redis:del(MEZO.."MEZO:Add:Rd:Manager:File"..text..msg_chat_id)
Redis:del(MEZO.."MEZO:Add:Rd:Manager:Audio"..text..msg_chat_id)
Redis:del(MEZO.."MEZO:Add:Rd:Manager:video_note"..text..msg_chat_id)
Redis:del(MEZO.."MEZO:Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id)
Redis:srem(MEZO.."MEZO:List:Manager"..msg_chat_id.."", text)
LuaTele.sendText(msg_chat_id,msg_id,"◍ تم حذف الرد من ردود المدير ","md",true)  
return false
end
end
if text and Redis:get(MEZO.."MEZO:Status:ReplySudo"..msg_chat_id) then
local anemi = Redis:get(MEZO.."MEZO:Add:Rd:Sudo:Gif"..text)   
local veico = Redis:get(MEZO.."MEZO:Add:Rd:Sudo:vico"..text)   
local stekr = Redis:get(MEZO.."MEZO:Add:Rd:Sudo:stekr"..text)     
local Text = Redis:get(MEZO.."MEZO:Add:Rd:Sudo:Text"..text)   
local photo = Redis:get(MEZO.."MEZO:Add:Rd:Sudo:Photo"..text)
local video = Redis:get(MEZO.."MEZO:Add:Rd:Sudo:Video"..text)
local document = Redis:get(MEZO.."MEZO:Add:Rd:Sudo:File"..text)
local audio = Redis:get(MEZO.."MEZO:Add:Rd:Sudo:Audio"..text)
local video_note = Redis:get(MEZO.."MEZO:Add:Rd:Sudo:video_note"..text)
if Text then 
local UserInfo = LuaTele.getUser(msg.sender.user_id)
local NumMsg = Redis:get(MEZO..'MEZO:Num:Message:User'..msg_chat_id..':'..msg.sender.user_id) or 0
local TotalMsg = Total_message(NumMsg)
local Status_Gps = msg.Name_Controller
local NumMessageEdit = Redis:get(MEZO..'MEZO:Num:Message:Edit'..msg_chat_id..msg.sender.user_id) or 0
local Text = Text:gsub('#username',(UserInfo.username or 'لا يوجد')) 
local Text = Text:gsub('#name',UserInfo.first_name)
local Text = Text:gsub('#id',msg.sender.user_id)
local Text = Text:gsub('#edit',NumMessageEdit)
local Text = Text:gsub('#msgs',NumMsg)
local Text = Text:gsub('#stast',Status_Gps)
LuaTele.sendText(msg_chat_id,msg_id,Text,"md",true)  
end
if video_note then
LuaTele.sendVideoNote(msg_chat_id, msg.id, video_note)
end
if photo then
LuaTele.sendPhoto(msg.chat_id, msg.id, photo,'')
end  
if stekr then 
LuaTele.sendSticker(msg_chat_id, msg.id, stekr)
end
if veico then 
LuaTele.sendVoiceNote(msg_chat_id, msg.id, veico, '', 'md')
end
if video then 
LuaTele.sendVideo(msg_chat_id, msg.id, video, '', "md")
end
if anemi then 
LuaTele.sendAnimation(msg_chat_id,msg.id, anemi, '', 'md')
end
if document then
LuaTele.sendDocument(msg_chat_id, msg.id, document, '', 'md')
end  
if audio then
LuaTele.sendAudio(msg_chat_id, msg.id, audio, '', "md") 
end
end
if text and Redis:get(MEZO.."MEZO:Status:Reply"..msg_chat_id) then
local anemi = Redis:get(MEZO.."MEZO:Add:Rd:Manager:Gif"..text..msg_chat_id)   
local veico = Redis:get(MEZO.."MEZO:Add:Rd:Manager:Vico"..text..msg_chat_id)   
local stekr = Redis:get(MEZO.."MEZO:Add:Rd:Manager:Stekrs"..text..msg_chat_id)     
local Texingt = Redis:get(MEZO.."MEZO:Add:Rd:Manager:Text"..text..msg_chat_id)   
local photo = Redis:get(MEZO.."MEZO:Add:Rd:Manager:Photo"..text..msg_chat_id)
local video = Redis:get(MEZO.."MEZO:Add:Rd:Manager:Video"..text..msg_chat_id)
local document = Redis:get(MEZO.."MEZO:Add:Rd:Manager:File"..text..msg_chat_id)
local audio = Redis:get(MEZO.."MEZO:Add:Rd:Manager:Audio"..text..msg_chat_id)
local video_note = Redis:get(MEZO.."MEZO:Add:Rd:Manager:video_note"..text..msg_chat_id)
if Texingt then 
local UserInfo = LuaTele.getUser(msg.sender.user_id)
local NumMsg = Redis:get(MEZO..'MEZO:Num:Message:User'..msg_chat_id..':'..msg.sender.user_id) or 0
local TotalMsg = Total_message(NumMsg) 
local Status_Gps = msg.Name_Controller
local NumMessageEdit = Redis:get(MEZO..'MEZO:Num:Message:Edit'..msg_chat_id..msg.sender.user_id) or 0
local Texingt = Texingt:gsub('#username',(UserInfo.username or 'لا يوجد')) 
local Texingt = Texingt:gsub('#name',UserInfo.first_name)
local Texingt = Texingt:gsub('#id',msg.sender.user_id)
local Texingt = Texingt:gsub('#edit',NumMessageEdit)
local Texingt = Texingt:gsub('#msgs',NumMsg)
local Texingt = Texingt:gsub('#stast',Status_Gps)
LuaTele.sendText(msg_chat_id,msg_id,Texingt,"md",true)  
end
if video_note then
LuaTele.sendVideoNote(msg_chat_id, msg.id, video_note)
end
if photo then
LuaTele.sendPhoto(msg.chat_id, msg.id, photo,'')
end  
if stekr then 
LuaTele.sendSticker(msg_chat_id, msg.id, stekr)
end
if veico then 
LuaTele.sendVoiceNote(msg_chat_id, msg.id, veico, '', 'md')
end
if video then 
LuaTele.sendVideo(msg_chat_id, msg.id, video, '', "md")
end
if anemi then 
LuaTele.sendAnimation(msg_chat_id,msg.id, anemi, '', 'md')
end
if document then
LuaTele.sendDocument(msg_chat_id, msg.id, document, '', 'md')
end  
if audio then
LuaTele.sendAudio(msg_chat_id, msg.id, audio, '', "md") 
end
end
if text or msg.content.video_note or msg.content.document or msg.content.audio or msg.content.video or msg.content.voice_note or msg.content.sticker or msg.content.animation or msg.content.photo then
local test = Redis:get(MEZO.."MEZO:Text:Sudo:Bot"..msg.sender.user_id..":"..msg_chat_id)
if Redis:get(MEZO.."MEZO:Set:Rd"..msg.sender.user_id..":"..msg_chat_id) == "true1" then
Redis:del(MEZO.."MEZO:Set:Rd"..msg.sender.user_id..":"..msg_chat_id)
if msg.content.sticker then   
Redis:set(MEZO.."MEZO:Add:Rd:Sudo:stekr"..test, msg.content.sticker.sticker.remote.id)  
end   
if msg.content.voice_note then  
Redis:set(MEZO.."MEZO:Add:Rd:Sudo:vico"..test, msg.content.voice_note.voice.remote.id)  
end   
if msg.content.animation then   
Redis:set(MEZO.."MEZO:Add:Rd:Sudo:Gif"..test, msg.content.animation.animation.remote.id)  
end  
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
Redis:set(MEZO.."MEZO:Add:Rd:Sudo:Text"..test, text)  
end  
if msg.content.audio then
Redis:set(MEZO.."MEZO:Add:Rd:Sudo:Audio"..test, msg.content.audio.audio.remote.id)  
end
if msg.content.document then
Redis:set(MEZO.."MEZO:Add:Rd:Sudo:File"..test, msg.content.document.document.remote.id)  
end
if msg.content.video then
Redis:set(MEZO.."MEZO:Add:Rd:Sudo:Video"..test, msg.content.video.video.remote.id)  
end
if msg.content.video_note then
Redis:set(MEZO.."MEZO:Add:Rd:Sudo:video_note"..test..msg_chat_id, msg.content.video_note.video.remote.id)  
end
if msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
Redis:set(MEZO.."MEZO:Add:Rd:Sudo:Photo"..test, idPhoto)  
end
LuaTele.sendText(msg_chat_id,msg_id,"◍ تم حفظ رد للمطور \n◍ ارسل ( "..test.." ) لرئية الرد","md",true)  
return false
end  
end
if text and text:match("^(.*)$") then
if Redis:get(MEZO.."MEZO:Set:Rd"..msg.sender.user_id..":"..msg_chat_id) == "true" then
Redis:set(MEZO.."MEZO:Set:Rd"..msg.sender.user_id..":"..msg_chat_id, "true1")
Redis:set(MEZO.."MEZO:Text:Sudo:Bot"..msg.sender.user_id..":"..msg_chat_id, text)
Redis:sadd(MEZO.."MEZO:List:Rd:Sudo", text)
LuaTele.sendText(msg_chat_id,msg_id,[[
↯︙ارسل لي الرد سواء كان 
❨ ملف • ملصق • متحركه • صوره
 • فيديو • بصمه الفيديو • بصمه • صوت • رساله ❩
↯︙يمكنك اضافة الى النص •
— — — — — — — — —
 `#username` ↬ معرف المستخدم
 `#msgs` ↬ عدد الرسائل
 `#name` ↬ اسم المستخدم
 `#id` ↬ ايدي المستخدم
 `#stast` ↬ رتبة المستخدم
 `#edit` ↬ عدد السحكات

]],"md",true)  
return false
end
end
if text and text:match("^(.*)$") then
if Redis:get(MEZO.."MEZO:Set:On"..msg.sender.user_id..":"..msg_chat_id) == "true" then
list = {"Add:Rd:Sudo:video_note","Add:Rd:Sudo:Audio","Add:Rd:Sudo:File","Add:Rd:Sudo:Video","Add:Rd:Sudo:Photo","Add:Rd:Sudo:Text","Add:Rd:Sudo:stekr","Add:Rd:Sudo:vico","Add:Rd:Sudo:Gif"}
for k,v in pairs(list) do
Redis:del(MEZO..'MEZO:'..v..text)
end
Redis:del(MEZO.."MEZO:Set:On"..msg.sender.user_id..":"..msg_chat_id)
Redis:srem(MEZO.."MEZO:List:Rd:Sudo", text)
return LuaTele.sendText(msg_chat_id,msg_id,"◍ تم حذف الرد من ردود المطور","md",true)  
end
end
if Redis:get(MEZO.."MEZO:Broadcasting:Groups:Pin" .. msg_chat_id .. ":" .. msg.sender.user_id) then 
if text == "الغاء" or text == '❌ •《الغاء الامر》• ❌' then   
Redis:del(MEZO.."MEZO:Broadcasting:Groups:Pin" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id, "\n* ❍┃ تم الغاء الاذاعه بالتثبيت*","md",true)  
end 
local list = Redis:smembers(MEZO.."MEZO:ChekBotAdd") 
if msg.content.video_note then
for k,v in pairs(list) do 
LuaTele.sendVideoNote(v, 0, msg.content.video_note.video.remote.id)
Redis:set(MEZO.."MEZO:PinMsegees:"..v,msg.content.video_note.video.remote.id)
end
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
for k,v in pairs(list) do 
LuaTele.sendPhoto(v, 0, idPhoto,'')
Redis:set(MEZO.."MEZO:PinMsegees:"..v,idPhoto)
end
elseif msg.content.sticker then 
for k,v in pairs(list) do 
LuaTele.sendSticker(v, 0, msg.content.sticker.sticker.remote.id)
Redis:set(MEZO.."MEZO:PinMsegees:"..v,msg.content.sticker.sticker.remote.id)
end
elseif msg.content.voice_note then 
for k,v in pairs(list) do 
LuaTele.sendVoiceNote(v, 0, msg.content.voice_note.voice.remote.id, '', 'md')
Redis:set(MEZO.."MEZO:PinMsegees:"..v,msg.content.voice_note.voice.remote.id)
end
elseif msg.content.video then 
for k,v in pairs(list) do 
LuaTele.sendVideo(v, 0, msg.content.video.video.remote.id, '', "md")
Redis:set(MEZO.."MEZO:PinMsegees:"..v,msg.content.video.video.remote.id)
end
elseif msg.content.animation then 
for k,v in pairs(list) do 
LuaTele.sendAnimation(v,0, msg.content.animation.animation.remote.id, '', 'md')
Redis:set(MEZO.."MEZO:PinMsegees:"..v,msg.content.animation.animation.remote.id)
end
elseif msg.content.document then
for k,v in pairs(list) do 
LuaTele.sendDocument(v, 0, msg.content.document.document.remote.id, '', 'md')
Redis:set(MEZO.."MEZO:PinMsegees:"..v,msg.content.document.document.remote.id)
end
elseif msg.content.audio then
for k,v in pairs(list) do 
LuaTele.sendAudio(v, 0, msg.content.audio.audio.remote.id, '', "md") 
Redis:set(MEZO.."MEZO:PinMsegees:"..v,msg.content.audio.audio.remote.id)
end
elseif text then
for k,v in pairs(list) do 
LuaTele.sendText(v,0,text,"md",true)
Redis:set(MEZO.."MEZO:PinMsegees:"..v,text)
end
end
LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم التثبيت ⟦"..#list.." ⟧ جرب في البوت *","md",true)      
Redis:del(MEZO.."MEZO:Broadcasting:Groups:Pin" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return false
end
if Redis:get(MEZO.."Broadcasting:Users:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id) then 
if text == "الغاء" or text == '❌ •《الغاء الامر》• ❌' then   
Redis:del(MEZO.."Broadcasting:Users:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id, "\n* ❍┃ تم الغاء الاذاعه بالتوجيه للخاص*","md",true)    
end 
if msg.forward_info then 
local list = Redis:smembers(MEZO.."MEZO:Num:User:Pv") 
LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم التوجيه الى ⟦"..#list.." ⟧ مشترك ف البوت *","md",true)      
for k,v in pairs(list) do  
LuaTele.forwardMessages(v, msg_chat_id, msg_id,0,0,true,false,false)
end   
Redis:del(MEZO.."Broadcasting:Users:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id) 
end 
return false
end
if Redis:get(MEZO.."Broadcasting:Users" .. msg_chat_id .. ":" .. msg.sender.user_id) then 
if text == "الغاء" or text == '❌ •《الغاء الامر》• ❌' then   
Redis:del(MEZO.."Broadcasting:Users" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id, "\n* ❍┃ تم الغاء الاذاعه للخاص*","md",true)  
end 
local list = Redis:smembers(MEZO.."MEZO:Num:User:Pv") 
if msg.content.voice_chats then
for k,v in pairs(list) do 
LuaTele.sendVideoNote(v, 0, msg.content.voice_chats.video.remote.id)
end
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
for k,v in pairs(list) do 
LuaTele.sendPhoto(v, 0, idPhoto,'')
end
elseif msg.content.sticker then 
for k,v in pairs(list) do 
LuaTele.sendSticker(v, 0, msg.content.sticker.sticker.remote.id)
end
elseif msg.content.voice_note then 
for k,v in pairs(list) do 
LuaTele.sendVoiceNote(v, 0, msg.content.voice_note.voice.remote.id, '', 'md')
end
elseif msg.content.video then 
for k,v in pairs(list) do 
LuaTele.sendVideo(v, 0, msg.content.video.video.remote.id, '', "md")
end
elseif msg.content.animation then 
for k,v in pairs(list) do 
LuaTele.sendAnimation(v,0, msg.content.animation.animation.remote.id, '', 'md')
end
elseif msg.content.document then
for k,v in pairs(list) do 
LuaTele.sendDocument(v, 0, msg.content.document.document.remote.id, '', 'md')
end
elseif msg.content.audio then
for k,v in pairs(list) do 
LuaTele.sendAudio(v, 0, msg.content.audio.audio.remote.id, '', "md") 
end
elseif text then
for k,v in pairs(list) do 
LuaTele.sendText(v,0,text,"md",true)
end
end
LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تمت الاذاعه الى ⟦"..#list.." ⟧ عضو في البوت *","md",true)      
Redis:del(MEZO.."Broadcasting:Users" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return false
end
if Redis:get(MEZO.."Broadcasting:Groups" .. msg_chat_id .. ":" .. msg.sender.user_id) then 
if text == "الغاء" or text == '❌ •《الغاء الامر》• ❌' then   
Redis:del(MEZO.."Broadcasting:Groups" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id, "\n* ❍┃ تم الغاء الاذاعه للمجموعات*","md",true)  
end 
local list = Redis:smembers(MEZO.."MEZO:ChekBotAdd") 
if msg.content.voice_chats then
for k,v in pairs(list) do 
LuaTele.sendVideoNote(v, 0, msg.content.voice_chats.video.remote.id)
end
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
for k,v in pairs(list) do 
LuaTele.sendPhoto(v, 0, idPhoto,'')
end
elseif msg.content.sticker then 
for k,v in pairs(list) do 
LuaTele.sendSticker(v, 0, msg.content.sticker.sticker.remote.id)
end
elseif msg.content.voice_note then 
for k,v in pairs(list) do 
LuaTele.sendVoiceNote(v, 0, msg.content.voice_note.voice.remote.id, '', 'md')
end
elseif msg.content.video then 
for k,v in pairs(list) do 
LuaTele.sendVideo(v, 0, msg.content.video.video.remote.id, '', "md")
end
elseif msg.content.animation then 
for k,v in pairs(list) do 
LuaTele.sendAnimation(v,0, msg.content.animation.animation.remote.id, '', 'md')
end
elseif msg.content.document then
for k,v in pairs(list) do 
LuaTele.sendDocument(v, 0, msg.content.document.document.remote.id, '', 'md')
end
elseif msg.content.audio then
for k,v in pairs(list) do 
LuaTele.sendAudio(v, 0, msg.content.audio.audio.remote.id, '', "md") 
end
elseif text then
for k,v in pairs(list) do 
LuaTele.sendText(v,0,text,"md",true)
end
end
LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تمت الاذاعه الى ⟦"..#list.." ⟧ جروب في البوت* ","md",true)      
Redis:del(MEZO.."Broadcasting:Groups" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return false
end
------------------------------------------------------------------------------------------------------------
if Redis:get(MEZO.."Broadcasting:Groups:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id) then 
if text == "الغاء" or text == '❌ •《الغاء الامر》• ❌' then   
Redis:del(MEZO.."Broadcasting:Groups:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id, "\n* ❍┃ تم الغاء الاذاعه بالتوجيه للمجموعات*","md",true)    
end 
if msg.forward_info then 
local list = Redis:smembers(MEZO.."MEZO:ChekBotAdd")   
LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃  تم التوجيه الى ⟦"..#list.." ⟧ جروب في البوت*","md",true)      
for k,v in pairs(list) do  
LuaTele.forwardMessages(v, msg_chat_id, msg_id,0,0,true,false,false)
end   
Redis:del(MEZO.."Broadcasting:Groups:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id) 
end 
return false
end
if text and Redis:get(MEZO..'MEZO:GetTexting:DevMEZO'..msg_chat_id..':'..msg.sender.user_id) then
if text == 'الغاء' or text == '❌ •《الغاء الامر》• ❌' then 
Redis:del(MEZO..'MEZO:GetTexting:DevMEZO'..msg_chat_id..':'..msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,' ❍┃ تم الغاء حفظ كليشة المطور')
end
Redis:set(MEZO..'MEZO:Texting:DevMEZO',text)
Redis:del(MEZO..'MEZO:GetTexting:DevMEZO'..msg_chat_id..':'..msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,' ❍┃ تم حفظ كليشة المطور')
end
if Redis:get(MEZO.."MEZO:Redis:Id:Groups"..msg.chat_id..""..msg.sender.user_id) then 
if text == 'الغاء' then 
LuaTele.sendText(msg_chat_id,msg_id, "\n ❍┃ تم الغاء امر تعين الايدي عام","md",true)  
Redis:del(MEZO.."MEZO:Redis:Id:Groups"..msg.chat_id..""..msg.sender.user_id) 
return false  
end 
Redis:del(MEZO.."MEZO:Redis:Id:Groups"..msg.chat_id..""..msg.sender.user_id) 
Redis:set(MEZO.."MEZO:Set:Id:Groups",text:match("(.*)"))
LuaTele.sendText(msg_chat_id,msg_id,' ❍┃ تم تعين الايدي عام',"md",true)  
end
if Redis:get(MEZO.."MEZO:Redis:Id:Group"..msg.chat_id..""..msg.sender.user_id) then 
if text == 'الغاء' then 
LuaTele.sendText(msg_chat_id,msg_id, "\n ❍┃ تم الغاء امر تعين الايدي","md",true)  
Redis:del(MEZO.."MEZO:Redis:Id:Group"..msg.chat_id..""..msg.sender.user_id) 
return false  
end 
Redis:del(MEZO.."MEZO:Redis:Id:Group"..msg.chat_id..""..msg.sender.user_id) 
Redis:set(MEZO.."MEZO:Set:Id:Group"..msg.chat_id,text:match("(.*)"))
LuaTele.sendText(msg_chat_id,msg_id,' ❍┃ تم تعين الايدي الجديد',"md",true)  
end
if Redis:get(MEZO.."MEZO:Change:MEZO:Name:Bot"..msg.sender.user_id) then 
if text == "الغاء" or text == '❌ •《الغاء الامر》• ❌' then   
Redis:del(MEZO.."MEZO:Change:MEZO:Name:Bot"..msg.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id, "\n ❍┃ تم الغاء امر تغير اسم البوت","md",true)  
end 
Redis:del(MEZO.."MEZO:Change:MEZO:Name:Bot"..msg.sender.user_id) 
Redis:set(MEZO.."MEZO:Name:Bot",text) 
return LuaTele.sendText(msg_chat_id,msg_id, " ❍┃ تم تغير اسم البوت الى - "..text,"md",true)    
end 
if Redis:get(MEZO.."MEZO:Change:Start:Bot"..msg.sender.user_id) then 
if text == "الغاء" or text == '❌ •《الغاء الامر》• ❌' then   
Redis:del(MEZO.."MEZO:Change:Start:Bot"..msg.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id, "\n ❍┃ تم الغاء امر تغير كليشه start","md",true)  
end 
Redis:del(MEZO.."MEZO:Change:Start:Bot"..msg.sender.user_id) 
Redis:set(MEZO.."MEZO:Start:Bot",text) 
return LuaTele.sendText(msg_chat_id,msg_id, " ❍┃ تم تغيير كليشه start - "..text,"md",true)    
end 
if Redis:get(MEZO.."MEZO:Game:Smile"..msg.chat_id) then
if text == Redis:get(MEZO.."MEZO:Game:Smile"..msg.chat_id) then
Redis:incrby(MEZO.."MEZO:Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
Redis:del(MEZO.."MEZO:Game:Smile"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ لقد فزت في اللعبه \n ❍┃ اللعب مره اخره وارسل - سمايل او سمايلات","md",true)  
else
Redis:del(MEZO.."MEZO:Game:Smile"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ لقد خسرت حضا اوفر في المره القادمه\n ❍┃ اللعب مره اخره وارسل - سمايل او سمايلات","md",true)  
end
end 
if Redis:get(MEZO.."MEZO:Game:Monotonous"..msg.chat_id) then
if text == Redis:get(MEZO.."MEZO:Game:Monotonous"..msg.chat_id) then
Redis:del(MEZO.."MEZO:Game:Monotonous"..msg.chat_id)
Redis:incrby(MEZO.."MEZO:Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ لقد فزت في اللعبه \n ❍┃ اللعب مره اخره وارسل - الاسرع او ترتيب","md",true)  
else
Redis:del(MEZO.."MEZO:Game:Monotonous"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ لقد خسرت حضا اوفر في المره القادمه\n ❍┃ اللعب مره اخره وارسل - الاسرع او ترتيب","md",true)  
end
end 
if Redis:get(MEZO.."MEZO:Game:Alam"..msg.chat_id) then
if text == Redis:get(MEZO.."MEZO:Game:Alam"..msg.chat_id) then
Redis:del(MEZO.."MEZO:Game:Alam"..msg.chat_id)
Redis:incrby(MEZO.."MEZO:Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ لقد فزت في اللعبه \n ❍┃ اللعب مره اخره وارسل - اعلام او الاعلام","md",true)  
else
Redis:del(MEZO.."MEZO:Game:Alam"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ لقد خسرت حضا اوفر في المره القادمه\n ❍┃ اللعب مره اخره وارسل - اعلام او الاعلام","md",true)  
end
end 
if Redis:get(MEZO.."MEZO:Game:Riddles"..msg.chat_id) then
if text == Redis:get(MEZO.."MEZO:Game:Riddles"..msg.chat_id) then
Redis:incrby(MEZO.."MEZO:Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
Redis:del(MEZO.."MEZO:Game:Riddles"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ لقد فزت في اللعبه \n ❍┃ اللعب مره اخره وارسل - حزوره","md",true)  
else
Redis:del(MEZO.."MEZO:Game:Riddles"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ لقد خسرت حضا اوفر في المره القادمه\n ❍┃ اللعب مره اخره وارسل - حزوره","md",true)  
end
end
if Redis:get(MEZO.."MEZO:Game:Meaningof"..msg.chat_id) then
if text == Redis:get(MEZO.."MEZO:Game:Meaningof"..msg.chat_id) then
Redis:incrby(MEZO.."MEZO:Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
Redis:del(MEZO.."MEZO:Game:Meaningof"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ لقد فزت في اللعبه \n ❍┃ اللعب مره اخره وارسل - معاني","md",true)  
else
Redis:del(MEZO.."MEZO:Game:Meaningof"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ لقد خسرت حضا اوفر في المره القادمه\n ❍┃ اللعب مره اخره وارسل - معاني","md",true)  
end
end
if Redis:get(MEZO.."MEZO:Game:Reflection"..msg.chat_id) then
if text == Redis:get(MEZO.."MEZO:Game:Reflection"..msg.chat_id) then
Redis:incrby(MEZO.."MEZO:Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
Redis:del(MEZO.."MEZO:Game:Reflection"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ لقد فزت في اللعبه \n ❍┃ اللعب مره اخره وارسل - العكس","md",true)  
else
Redis:del(MEZO.."MEZO:Game:Reflection"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ لقد خسرت حضا اوفر في المره القادمه\n ❍┃ اللعب مره اخره وارسل - العكس","md",true)  
end
end
if Redis:get(MEZO.."MEZO:Game:Estimate"..msg.chat_id..msg.sender.user_id) then  
if text and text:match("^(%d+)$") then
local NUM = text:match("^(%d+)$")
if tonumber(NUM) > 20 then
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ عذرا لا يمكنك تخمين عدد اكبر من ال { 20 } خمن رقم ما بين ال{ 1 و 20 }\n","md",true)  
end 
local GETNUM = Redis:get(MEZO.."MEZO:Game:Estimate"..msg.chat_id..msg.sender.user_id)
if tonumber(NUM) == tonumber(GETNUM) then
Redis:del(MEZO.."MEZO:SADD:NUM"..msg.chat_id..msg.sender.user_id)
Redis:del(MEZO.."MEZO:Game:Estimate"..msg.chat_id..msg.sender.user_id)
Redis:incrby(MEZO.."MEZO:Num:Add:Games"..msg.chat_id..msg.sender.user_id,5)  
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ مبروك فزت ويانه وخمنت الرقم الصحيح\n🚸┃تم اضافة { 5 } من النقاط \n","md",true)  
elseif tonumber(NUM) ~= tonumber(GETNUM) then
Redis:incrby(MEZO.."MEZO:SADD:NUM"..msg.chat_id..msg.sender.user_id,1)
if tonumber(Redis:get(MEZO.."MEZO:SADD:NUM"..msg.chat_id..msg.sender.user_id)) >= 3 then
Redis:del(MEZO.."MEZO:SADD:NUM"..msg.chat_id..msg.sender.user_id)
Redis:del(MEZO.."MEZO:Game:Estimate"..msg.chat_id..msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ اوبس لقد خسرت في اللعبه \n ❍┃ حظآ اوفر في المره القادمه \n ❍┃ كان الرقم الذي تم تخمينه { "..GETNUM.." }","md",true)  
else
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ اوبس تخمينك غلط \n ❍┃ ارسل رقم تخمنه مره اخرى ","md",true)  
end
end
end
end
if Redis:get(MEZO.."MEZO:Game:Difference"..msg.chat_id) then
if text == Redis:get(MEZO.."MEZO:Game:Difference"..msg.chat_id) then 
Redis:del(MEZO.."MEZO:Game:Difference"..msg.chat_id)
Redis:incrby(MEZO.."MEZO:Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ لقد فزت في اللعبه \n ❍┃ اللعب مره اخره وارسل - المختلف","md",true)  
else
Redis:del(MEZO.."MEZO:Game:Difference"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ لقد خسرت حضا اوفر في المره القادمه\n ❍┃ اللعب مره اخره وارسل - المختلف","md",true)  
end
end
if Redis:get(MEZO.."MEZO:Game:Example"..msg.chat_id) then
if text == Redis:get(MEZO.."MEZO:Game:Example"..msg.chat_id) then 
Redis:del(MEZO.."MEZO:Game:Example"..msg.chat_id)
Redis:incrby(MEZO.."MEZO:Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ لقد فزت في اللعبه \n ❍┃ اللعب مره اخره وارسل - امثله","md",true)  
else
Redis:del(MEZO.."MEZO:Game:Example"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ لقد خسرت حضا اوفر في المره القادمه\n ❍┃ اللعب مره اخره وارسل - امثله","md",true)  
end
end
if text then
local NewCmmd = Redis:get(MEZO.."MEZO:All:Get:Reides:Commands:Group"..text) or Redis:get(MEZO.."MEZO:Get:Reides:Commands:Group"..msg_chat_id..":"..text)
if NewCmmd then
text = (NewCmmd or text)
end
end
if Redis:get(MEZO.."ch:addd"..msg.sender.user_id) == "on" then
Redis:set(MEZO.."ch:addd"..msg.sender.user_id,"off")
local m = https.request("http://api.telegram.org/bot"..Token.."/getchat?chat_id="..text)
data = json:decode(m)
if data.result.invite_link then
local ch = data.result.id
LuaTele.sendText(msg_chat_id,msg_id,' ❍┃  تم حفظ القناه ',"md",true)  
Redis:del(MEZO.."chfalse")
Redis:set(MEZO.."chfalse",ch)
Redis:del(MEZO.."ch:admin")
Redis:set(MEZO.."ch:admin",data.result.invite_link)
else
LuaTele.sendText(msg_chat_id,msg_id,' ❍┃  المعرف خطأ او البوت ليس مشرف في القناه ',"md",true)  
end
end
if text == "تعيين قناه الاشتراك" then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص⟧'..Controller_Num(1)..' ⟧* ',"md",true)  
end
Redis:set(MEZO.."ch:addd"..msg.sender.user_id,"on")
LuaTele.sendText(msg_chat_id,msg_id,' ❍┃  ارسل الان معرف القناه ',"md",true)  
end
if text == "حذف قناه الاشتراك" then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص⟧'..Controller_Num(1)..' ⟧* ',"md",true)  
end
Redis:del(MEZO.."ch:admin")
Redis:del(MEZO.."chfalse")
LuaTele.sendText(msg_chat_id,msg_id,' ❍┃  تم حذف القناه ',"md",true)  
end
if text == 'رفع النسخه العامه' and msg.reply_to_message_id ~= 0 or text == 'رفع النسخه العامه' and msg.reply_to_message_id ~= 0 then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍︙ هاذا الامر يخص 〘 '..Controller_Num(1)..' 〙* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
if Message_Reply.content.document then
local File_Id = Message_Reply.content.document.document.remote.id
local Name_File = Message_Reply.content.document.file_name
if Name_File ~= UserBot..'.json' then
return LuaTele.sendText(msg_chat_id,msg_id,' ❍︙ عذرا هاذا الملف غير مطابق مع البوت يرجى جلب النسخه الحقيقيه')
end -- end Namefile
local File = json:decode(https.request('https://api.telegram.org/bot'..Token..'/getfile?file_id='..File_Id)) 
local download_ = download('https://api.telegram.org/file/bot'..Token..'/'..File.result.file_path,''..Name_File) 
local Get_Info = io.open(download_,"r"):read('*a')
local FilesJson = JSON.decode(Get_Info)
if tonumber(MEZO) ~= tonumber(FilesJson.BotId) then
return LuaTele.sendText(msg_chat_id,msg_id,' ❍︙ عذرا هاذا الملف غير مطابق مع البوت يرجى جلب النسخه الحقيقيه')
end -- end botid
LuaTele.sendText(msg_chat_id,msg_id,' ❍︙ جاري استرجاع المشتركين والكروبات ...')
Y = 0
for k,v in pairs(FilesJson.UsersBot) do
Y = Y + 1
Redis:sadd(MEZO..'MEZO:Num:User:Pv',v)  
end
X = 0
for GroupId,ListGroup in pairs(FilesJson.GroupsBot) do
X = X + 1
Redis:sadd(MEZO.."MEZO:ChekBotAdd",GroupId) 
if ListGroup.President then
for k,v in pairs(ListGroup.President) do
Redis:sadd(MEZO.."MEZO:TheBasics:Group"..GroupId,v)
end
end
if ListGroup.Constructor then
for k,v in pairs(ListGroup.Constructor) do
Redis:sadd(MEZO.."MEZO:Originators:Group"..GroupId,v)
end
end
if ListGroup.Manager then
for k,v in pairs(ListGroup.Manager) do
Redis:sadd(MEZO.."MEZO:Managers:Group"..GroupId,v)
end
end
if ListGroup.Admin then
for k,v in pairs(ListGroup.Admin) do
Redis:sadd(MEZO.."MEZO:Addictive:Group"..GroupId,v)
end
end
if ListGroup.Vips then
for k,v in pairs(ListGroup.Vips) do
Redis:sadd(MEZO.."MEZO:Distinguished:Group"..GroupId,v)
end
end 
end
return LuaTele.sendText(msg_chat_id,msg_id,' ❍︙ تم استرجاع {'..X..'} مجموعه \n ❍︙ واسترجاع {'..Y..'} مشترك في البوت')
end
end
if text == 'رفع نسخه تشاكي' and msg.reply_to_message_id ~= 0 then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍︙ هاذا الامر يخص 〘 '..Controller_Num(1)..' 〙* ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
if Message_Reply.content.document then
local File_Id = Message_Reply.content.document.document.remote.id
local Name_File = Message_Reply.content.document.file_name
if tonumber(Name_File:match('(%d+)')) ~= tonumber(MEZO) then 
return LuaTele.sendText(msg_chat_id,msg_id,' ❍︙ عذرا هاذا الملف غير مطابق مع البوت يرجى جلب النسخه الحقيقيه')
end -- end Namefile
local File = json:decode(https.request('https://api.telegram.org/bot'..Token..'/getfile?file_id='..File_Id)) 
local download_ = download('https://api.telegram.org/file/bot'..Token..'/'..File.result.file_path,''..Name_File) 
local Get_Info = io.open(download_,"r"):read('*a')
local All_Groups = JSON.decode(Get_Info)
if All_Groups.GP_BOT then
for idg,v in pairs(All_Groups.GP_BOT) do
Redis:sadd(MEZO.."MEZO:ChekBotAdd",idg) 
if v.MNSH then
for k,idmsh in pairs(v.MNSH) do
Redis:sadd(MEZO.."MEZO:Originators:Group"..idg,idmsh)
end;end
if v.MDER then
for k,idmder in pairs(v.MDER) do
Redis:sadd(MEZO.."MEZO:Managers:Group"..idg,idmder)  
end;end
if v.MOD then
for k,idmod in pairs(v.MOD) do
Redis:sadd(MEZO.."MEZO:Addictive:Group"..idg,idmod)
end;end
if v.ASAS then
for k,idASAS in pairs(v.ASAS) do
Redis:sadd(MEZO.."MEZO:TheBasics:Group"..idg,idASAS)
end;end
end
return LuaTele.sendText(msg_chat_id,msg_id,' ❍︙ تم استرجاع المجموعات من نسخه تشاكي')
else
return LuaTele.sendText(msg_chat_id,msg_id,' ❍︙ الملف لا يدعم هاذا البوت')
end
end
end
if text == 'تحديث السورس' or text == '♻️ تحديث السورس ♻️' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ◉ هاذا الامر يخص 『 '..Controller_Num(1)..' 』* ',"md",true)  
end
--os.execute('rm -rf MEZO.lua')
--download('https://raw.githubusercontent.com/PaythoneCR/server/main/MEZO.lua')
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ◉ تم تحديث السورس * ',"md",true)  
end
if text == '📢 تعطيل الاذاعه 📢' or text == 'تعطيل الاذاعه' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(MEZO.."MEZO:SendBcBot") 
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم تعطيل الاذاعه ","md",true)
end
if text == '📢 تفعيل الاذاعه 📢' or text == 'تفعيل الاذاعه' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:SendBcBot",true) 
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم تفعيل الاذاعه للمطورين ","md",true)
end
if text == '✈ تعطيل المغادره ✈' or text == 'تعطيل المغادره' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(MEZO.."MEZO:LeftBot") 
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم تعطيل المغادره ","md",true)
end
if text == '✈ تفعيل المغادره ✈' or text == 'تفعيل المغادره' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:LeftBot",true) 
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم تفعيل المغادره للمطورين ","md",true)
end
if (Redis:get(MEZO.."MEZO:AddSudosNew"..msg_chat_id) == 'true') then
if text == "الغاء" or text == '❌ •《الغاء الامر》• ❌' then   
Redis:del(MEZO.."MEZO:AddSudosNew"..msg_chat_id)
return LuaTele.sendText(msg_chat_id,msg_id, "\n ❍┃ تم الغاء امر تغيير المطور الاساسي","md",true)    
end 
Redis:del(MEZO.."MEZO:AddSudosNew"..msg_chat_id)
if text and text:match("^@[%a%d_]+$") then
local UserId_Info = LuaTele.searchPublicChat(text)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName[2]:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام معرف البوت ","md",true)  
end
local Informationlua = io.open("Information.lua", 'w')
Informationlua:write([[
return {
Token = "]]..Token..[[",
UserBot = "]]..UserBot..[[",
UserSudo = "]]..text:gsub('@','')..[[",
SudoId = ]]..UserId_Info.id..[[
}
]])
Informationlua:close()
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ تم تغيير المطور الاساسي اصبح على : [@"..text:gsub('@','').."]","md",true)  
end
end
if text == 'تغيير المطور الاساسي' or text == '🔄 تغيير المطور الاساسي 🔄' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
Redis:set(MEZO.."MEZO:AddSudosNew"..msg_chat_id,true)
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ ارسل معرف المطور الاساسي مع @","md",true)
end
if text == '📉 جلب النسخه العامه 📈' or text == 'جلب النسخه العامه' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Groups = Redis:smembers(MEZO..'MEZO:ChekBotAdd')  
local UsersBot = Redis:smembers(MEZO..'MEZO:Num:User:Pv')  
local Get_Json = '{"BotId": '..MEZO..','  
if #UsersBot ~= 0 then 
Get_Json = Get_Json..'"UsersBot":['  
for k,v in pairs(UsersBot) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..']'
end
Get_Json = Get_Json..',"GroupsBot":{'
for k,v in pairs(Groups) do   
local President = Redis:smembers(MEZO.."MEZO:TheBasics:Group"..v)
local Constructor = Redis:smembers(MEZO.."MEZO:Originators:Group"..v)
local Manager = Redis:smembers(MEZO.."MEZO:Managers:Group"..v)
local Admin = Redis:smembers(MEZO.."MEZO:Addictive:Group"..v)
local Vips = Redis:smembers(MEZO.."MEZO:Distinguished:Group"..v)
if k == 1 then
Get_Json = Get_Json..'"'..v..'":{'
else
Get_Json = Get_Json..',"'..v..'":{'
end
if #President ~= 0 then 
Get_Json = Get_Json..'"President":['
for k,v in pairs(President) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Constructor ~= 0 then
Get_Json = Get_Json..'"Constructor":['
for k,v in pairs(Constructor) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Manager ~= 0 then
Get_Json = Get_Json..'"Manager":['
for k,v in pairs(Manager) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Admin ~= 0 then
Get_Json = Get_Json..'"Admin":['
for k,v in pairs(Admin) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Vips ~= 0 then
Get_Json = Get_Json..'"Vips":['
for k,v in pairs(Vips) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
Get_Json = Get_Json..'"Dev":"bar_lo0o0"}'
end
Get_Json = Get_Json..'}}'
local File = io.open('./'..UserBot..'.json', "w")
File:write(Get_Json)
File:close()
return LuaTele.sendDocument(msg_chat_id,msg_id,'./'..UserBot..'.json', '* ❍┃ تم جلب النسخه العامه\n ❍┃ احصائيات⟦ '..#Groups..' ⟧المجموعات \n ❍┃ احصائيات⟦ '..#UsersBot..' ⟧المشتركين *\n', 'md')
end
if text and text:match("^تعين عدد الاعضاء (%d+)$") then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO..'MEZO:Num:Add:Bot',text:match("تعين عدد الاعضاء (%d+)$") ) 
LuaTele.sendText(msg_chat_id,msg_id,'* ❍┃ تم تعيين عدد اعضاء تفعيل البوت اكثر من : '..text:match("تعين عدد الاعضاء (%d+)$")..' عضو *',"md",true)  
elseif text == 'الاحصائيات' or text == '📊 الاحصائيات 📊' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ⦁ هاذا الامر يخص 『 '..Controller_Num(2)..' 』* ',"md",true)  
end
local photo = LuaTele.getUserProfilePhotos(MEZO)
local UserInfo = LuaTele.getUser(MEZO)
for Name_User in string.gmatch(UserInfo.first_name, "[^%s]+" ) do
UserInfo.first_name = Name_User
break
end 
NamesBot = (Redis:get(MEZO.."MEZO:Name:Bot") or "كرستين")
Groups = (Redis:scard(MEZO..'MEZO:ChekBotAdd') or 0)
Users = (Redis:scard(MEZO..'MEZO:Num:User:Pv') or 0)
if photo.total_count > 0 then
local Jabwa = 'اسم بوت -› '..NamesBot..''
local Grosupsw = 'الجروبات -› '..Groups..''
local Usperos = 'المشتركين -› '..Users..''
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = Jabwa, url = 't.me/cristin_so'}, 
},
{
{text = Grosupsw, url = 't.me/cristin_so'}, 
},
{
{text = Usperos, url = 't.me/cristin_so'}, 
},
}
msgg = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id=" .. msg_chat_id .. "&photo="..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id.."&photo=".. URL.escape(NamesBots).."&reply_to_message_id="..msgg.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
end
if text == "🔎 جلب التوكن 🔍" then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,Token,"html",true)  
end
if text == 'تفعيل' and msg.Developers then
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*◍ عذرآ البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local Get_Chat = LuaTele.getChat(msg_chat_id)
local Info_Chats = LuaTele.getSupergroupFullInfo(msg_chat_id)
if Redis:sismember(MEZO.."MEZO:ChekBotAdd",msg_chat_id) then
if tonumber(Info_Chats.member_count) < tonumber((Redis:get(MEZO..'MEZO:Num:Add:Bot') or 0)) and not msg.ControllerBot then
return LuaTele.sendText(msg_chat_id,msg_id,'◍ عدد الاعضاء قليل لا يمكن تفعيل المجموعه  يجب ان يكوم اكثر من :'..Redis:get(MEZO..'MEZO:Num:Add:Bot'),"md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,'\n*◍ المجموعه : {*['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')*}\n◍ تم تفعيلها مسبقا *',"md",true)  
else
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ ترقيه المالك والادمنيه ❍', data = msg.sender.user_id..'/addAdmins@'..msg_chat_id},
},
{
{text = '❍ قفل جميع الاوامر ❍', data =msg.sender.user_id..'/LockAllGroup@'..msg_chat_id},
},
{
{text = '❍ فتح جميع الاوامر ❍', data =msg.sender.user_id..'/openorders@'..msg_chat_id},
},
{
{text = '❍ اوامر الحمايه المجموعه ❍', data =msg.sender.user_id..'/listallAddorr@'..msg_chat_id},
},
}
}
if not msg.ControllerBot then
local UserInfo = LuaTele.getUser(msg.sender.user_id)
for Name_User in string.gmatch(UserInfo.first_name, "[^%s]+" ) do
UserInfo.first_name = Name_User
break
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '‹ مغادرة المجموعه ›', data = '/leftgroup@'..msg_chat_id}, 
},
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
LuaTele.sendText(Sudo_Id,0,'*\n◍ تم تفعيل مجموعه جديده \n◍ من قام بتفعيلها : {*['..UserInfo.first_name..'](tg://user?id='..msg.sender.user_id..')*} \n◍ معلومات المجموعه :\n◍ عدد الاعضاء : '..Info_Chats.member_count..'\n◍ عدد الادمنيه : '..Info_Chats.administrator_count..'\n◍ عدد المطرودين : '..Info_Chats.banned_count..'\n🔕┃عدد المقيدين : '..Info_Chats.restricted_count..'*',"md",true, false, false, false, reply_markup)
end
Redis:sadd(MEZO.."MEZO:ChekBotAdd",msg_chat_id)
Redis:set(MEZO.."MEZO:Status:Id"..msg_chat_id,true) ;Redis:set(MEZO.."MEZO:Status:Reply"..msg_chat_id,true) ;Redis:set(MEZO.."MEZO:Status:ReplySudo"..msg_chat_id,true) ;Redis:set(MEZO.."MEZO:Status:BanId"..msg_chat_id,true) ;Redis:set(MEZO.."MEZO:Status:SetId"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*◍ المجموعه : {*['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')*}\n◍ تم تفعيل المجموعه *','md', true, false, false, false, reply_markup)
end
end 
if text == 'تفعيل' and not msg.Developers then
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*◍ عذرآ البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local StatusMember = LuaTele.getChatMember(msg_chat_id,msg.sender.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
local AddedBot = true
elseif (StatusMember == "chatMemberStatusAdministrator") then
local AddedBot = true
else
local AddedBot = false
end
if AddedBot == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*◍ عذرا انته لست ادمن او مالك المجموعه *","md",true)  
end
if not Redis:get(MEZO.."MEZO:BotFree") then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*◍ الوضع الخدمي تم تعطيله من قبل مطور البوت *","md",true)  
end
local Get_Chat = LuaTele.getChat(msg_chat_id)
local Info_Chats = LuaTele.getSupergroupFullInfo(msg_chat_id)
if Redis:sismember(MEZO.."MEZO:ChekBotAdd",msg_chat_id) then
if tonumber(Info_Chats.member_count) < tonumber((Redis:get(MEZO..'MEZO:Num:Add:Bot') or 0)) and not msg.ControllerBot then
return LuaTele.sendText(msg_chat_id,msg_id,'◍ عدد الاعضاء قليل لا يمكن تفعيل المجموعه  يجب ان يكوم اكثر من :'..Redis:get(MEZO..'MEZO:Num:Add:Bot'),"md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,'\n*◍ المجموعه : {*['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')*}\n◍ تم تفعيلها مسبقا *',"md",true)  
else
if not msg.ControllerBot then
local UserInfo = LuaTele.getUser(msg.sender.user_id)
for Name_User in string.gmatch(UserInfo.first_name, "[^%s]+" ) do
UserInfo.first_name = Name_User
break
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
{
{text = '❍ مغادرة المجموعه ❍', data = '/Zxchq'..msg_chat_id}, 
},
}
}
LuaTele.sendText(Sudo_Id,0,'*\n◍ تم تفعيل مجموعه جديده \n◍ من قام بتفعيلها : {*['..UserInfo.first_name..'](tg://user?id='..msg.sender.user_id..')*} \n◍ معلومات المجموعه :\n◍ عدد الاعضاء : '..Info_Chats.member_count..'\n◍ عدد الادمنيه : '..Info_Chats.administrator_count..'\n◍ عدد المطرودين : '..Info_Chats.banned_count..'\n🔕┃عدد المقيدين : '..Info_Chats.restricted_count..'*',"md",true, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ ترقيه المالك والادمنيه ❍', data = msg.sender.user_id..'/addAdmins@'..msg_chat_id},
},
{
{text = '❍ قفل جميع الاوامر ❍', data =msg.sender.user_id..'/LockAllGroup@'..msg_chat_id},
},
{
{text = '❍ فتح جميع الاوامر ❍', data =msg.sender.user_id..'/openorders@'..msg_chat_id},
},
{
{text = '❍ اوامر الحمايه المجموعه ❍', data =msg.sender.user_id..'/listallAddorr@'..msg_chat_id},
},
}
}
Redis:sadd(MEZO.."MEZO:ChekBotAdd",msg_chat_id)
Redis:set(MEZO.."MEZO:Status:Id"..msg_chat_id,true) ;Redis:set(MEZO.."MEZO:Status:Reply"..msg_chat_id,true) ;Redis:set(MEZO.."MEZO:Status:ReplySudo"..msg_chat_id,true) ;Redis:set(MEZO.."MEZO:Status:BanId"..msg_chat_id,true) ;Redis:set(MEZO.."MEZO:Status:SetId"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*◍ المجموعه : {*['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')*}\n◍ تم تفعيل المجموعه *','md', true, false, false, false, reply_markup)
end
end
if text == 'تفعيل' and not msg.Developers then
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local StatusMember = LuaTele.getChatMember(msg_chat_id,msg.sender.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
local AddedBot = true
elseif (StatusMember == "chatMemberStatusAdministrator") then
local AddedBot = true
else
local AddedBot = false
end
if AddedBot == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا انته لست ادمن او مالك المجموعه *","md",true)  
end
local Get_Chat = LuaTele.getChat(msg_chat_id)
local Info_Chats = LuaTele.getSupergroupFullInfo(msg_chat_id)
if Redis:sismember(MEZO.."MEZO:ChekBotAdd",msg_chat_id) then
if tonumber(Info_Chats.member_count) < tonumber((Redis:get(MEZO..'MEZO:Num:Add:Bot') or 0)) and not msg.ControllerBot then
return LuaTele.sendText(msg_chat_id,msg_id,' ❍┃ عدد الاعضاء قليل لا يمكن تفعيل المجموعه  يجب ان يكوم اكثر من :'..Redis:get(MEZO..'MEZO:Num:Add:Bot'),"md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ اسم المجموعه -›⟦*['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')*⟧\n ❍┃ تم التفعيل من قبل *',"md",true)  
else
if not msg.ControllerBot then
local UserInfo = LuaTele.getUser(msg.sender.user_id)
for Name_User in string.gmatch(UserInfo.first_name, "[^%s]+" ) do
UserInfo.first_name = Name_User
break
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
{
{text = '❍ مغادرة المجموعه ❍', data = '/Zxchq'..msg_chat_id}, 
},
}
}
LuaTele.sendText(Sudo_Id,0,'*\n* ❍┃ تم تفعيل مجموعه جديده *\n* ❍┃ المستخدم -›⟦*['..UserInfo.first_name..'](tg://user?id='..msg.sender.user_id..')*⟧\n* ❍┃ معلومات المجموعه -› *\n* ❍┃ عدد الاعضاء -› *'..Info_Chats.member_count..'\n* ❍┃ عدد الادمنيه -› *'..Info_Chats.administrator_count..'\n* ❍┃ عدد المطرودين -› *'..Info_Chats.Jabwaned_count..'\n* ❍┃ عدد المقيدين -› *'..Info_Chats.restricted_count..'*',"md",true, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ ترقيه المالك والادمنيه ❍', data = msg.sender.user_id..'/addAdmins@'..msg_chat_id},
},
{
{text = '❍ قفل جميع الاوامر ❍', data =msg.sender.user_id..'/LockAllGroup@'..msg_chat_id},
},
{
{text = '❍ فتح جميع الاوامر ❍', data =msg.sender.user_id..'/openorders@'..msg_chat_id},
},
{
{text = '❍ اوامر الحمايه المجموعه ❍', data =msg.sender.user_id..'/listallAddorr@'..msg_chat_id},
},
}
}
Redis:sadd(MEZO.."MEZO:ChekBotAdd",msg_chat_id)
Redis:set(MEZO.."MEZO:Status:Id"..msg_chat_id,true) ;Redis:set(MEZO.."MEZO:Status:Reply"..msg_chat_id,true) ;Redis:set(MEZO.."MEZO:Status:ReplySudo"..msg_chat_id,true) ;Redis:set(MEZO.."MEZO:Status:JabwaId"..msg_chat_id,true) ;Redis:set(MEZO.."MEZO:Status:SetId"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ اسم المجموعه -›⟦*['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')*⟧\n ❍┃ تم تفعيل المجموعه *','md', true, false, false, false, reply_markup)
end
end
if text == 'تعطيل' and msg.Developers then
local Get_Chat = LuaTele.getChat(msg_chat_id)
local Info_Chats = LuaTele.getSupergroupFullInfo(msg_chat_id)
if not Redis:sismember(MEZO.."MEZO:ChekBotAdd",msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*◍ المجموعه : {*['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')*}\n◍ تم تعطيلها مسبقا *',"md",true)  
else
if not msg.ControllerBot then
local UserInfo = LuaTele.getUser(msg.sender.user_id)
for Name_User in string.gmatch(UserInfo.first_name, "[^%s]+" ) do
UserInfo.first_name = Name_User
break
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
{
{text = '❍ مغادرة المجموعه ❍', data = '/Zxchq'..msg_chat_id}, 
},
}
}
LuaTele.sendText(Sudo_Id,0,'*\n◍ تم تعطيل مجموعه جديده \n◍ من قام بتعطيلها : {*['..UserInfo.first_name..'](tg://user?id='..msg.sender.user_id..')*} \n◍ معلومات المجموعه :\n◍ عدد الاعضاء : '..Info_Chats.member_count..'\n◍ عدد الادمنيه : '..Info_Chats.administrator_count..'\n◍ عدد المطرودين : '..Info_Chats.banned_count..'\n🔕┃عدد المقيدين : '..Info_Chats.restricted_count..'*',"md",true, false, false, false, reply_markup)
end
Redis:srem(MEZO.."MEZO:ChekBotAdd",msg_chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,'\n*◍ المجموعه : {*['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')*}\n◍ تم تعطيلها بنجاح *','md',true)
end
end
if text == 'تعطيل' and not msg.Developers then
local StatusMember = LuaTele.getChatMember(msg_chat_id,msg.sender.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
local AddedBot = true
elseif (StatusMember == "chatMemberStatusAdministrator") then
local AddedBot = true
else
local AddedBot = false
end
if AddedBot == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*◍ عذرا انته لست ادمن او مالك المجموعه *","md",true)  
end
local Get_Chat = LuaTele.getChat(msg_chat_id)
local Info_Chats = LuaTele.getSupergroupFullInfo(msg_chat_id)
if not Redis:sismember(MEZO.."MEZO:ChekBotAdd",msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*◍ المجموعه : {*['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')*}\n◍ تم تعطيلها مسبقا *',"md",true)  
else
if not msg.ControllerBot then
local UserInfo = LuaTele.getUser(msg.sender.user_id)
for Name_User in string.gmatch(UserInfo.first_name, "[^%s]+" ) do
UserInfo.first_name = Name_User
break
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
{
{text = '❍ مغادرة المجموعه ❍', data = '/Zxchq'..msg_chat_id}, 
},
}
}
LuaTele.sendText(Sudo_Id,0,'*\n◍ تم تعطيل مجموعه جديده \n◍ من قام بتعطيلها : {*['..UserInfo.first_name..'](tg://user?id='..msg.sender.user_id..')*} \n◍ معلومات المجموعه :\n◍ عدد الاعضاء : '..Info_Chats.member_count..'\n◍ عدد الادمنيه : '..Info_Chats.administrator_count..'\n◍ عدد المطرودين : '..Info_Chats.banned_count..'\n◍ عدد المقيدين : '..Info_Chats.restricted_count..'*',"md",true, false, false, false, reply_markup)
end
Redis:srem(MEZO.."MEZO:ChekBotAdd",msg_chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,'\n*◍ المجموعه : {*['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')*}\n◍ تم تعطيلها بنجاح *','md',true)
end
end
if chat_type(msg.chat_id) == "GroupBot" and Redis:sismember(MEZO.."MEZO:ChekBotAdd",msg_chat_id) then
if text == "ايدي" or text == "الايدي" or text == "Id" or text == "ID" and msg.reply_to_message_id == 0 then
if not Redis:get(MEZO.."MEZO:Status:Id"..msg_chat_id) then
return false
end
local Jabwa = LuaTele.getUser(msg.sender.user_id)
local photo = LuaTele.getUserProfilePhotos(msg.sender.user_id)
local UserId = msg.sender.user_id
local RinkBot = msg.Name_Controller
local TotalMsg = Redis:get(MEZO..'Num:Message:User'..msg_chat_id..':'..msg.sender.user_id) or 0
local TotalPhoto = photo.total_count or 0
local TotalEdit = Redis:get(MEZO..'Num:Message:Edit'..msg_chat_id..msg.sender.user_id) or 0
local TotalMsgT = Total_message(TotalMsg) 
local NumberGames = Redis:get(MEZO.."Num:Add:Games"..msg.chat_id..msg.sender.user_id) or 0
local NumAdd = Redis:get(MEZO.."Num:Add:Memp"..msg.chat_id..":"..msg.sender.user_id) or 0
local Texting = {'〈 جمالك ده طبيعي يولا 🙈💗 〉',"〈 غير بقاا صورتك يا قمر 😻🤍 〉 ","〈 يخرشي علي العسل ده 🥺💔 〉","〈 صورتك ولا صورت القمر 🌙💕 〉","〈 صورتك عثل ينوحيي 🙈🌝 〉",}
local Description = Texting[math.random(#Texting)]
if Jabwa.username then
Jabwausername = '@'..Jabwa.username..''
else
Jabwausername = 'لا يوجد'
end
if Jabwa.first_name then
news = " "..Jabwa.first_name.." "
else
news = " لا يوجد"
end
Get_Is_Id = Redis:get(MEZO.."MEZO:Set:Id:Groups") or Redis:get(MEZO.."Set:Id:Group"..msg_chat_id)
if Redis:get(MEZO.."MEZO:Status:IdPhoto"..msg_chat_id) then
if Get_Is_Id then
local Get_Is_Id = Get_Is_Id:gsub('#AddMem',NumAdd) 
local Get_Is_Id = Get_Is_Id:gsub('#id',msg.sender.user_id) 
local Get_Is_Id = Get_Is_Id:gsub('#username',Jabwausername) 
local Get_Is_Id = Get_Is_Id:gsub('#msgs',TotalMsg) 
local Get_Is_Id = Get_Is_Id:gsub('#edit',TotalEdit) 
local Get_Is_Id = Get_Is_Id:gsub('#stast',RinkBot) 
local Get_Is_Id = Get_Is_Id:gsub('#auto',TotalMsgT) 
local Get_Is_Id = Get_Is_Id:gsub('#Description',Description) 
local Get_Is_Id = Get_Is_Id:gsub('#game',NumberGames) 
local Get_Is_Id = Get_Is_Id:gsub('#photos',TotalPhoto) 
if photo.total_count > 0 then
return LuaTele.sendPhoto(msg.chat_id, msg.id, photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id,Get_Is_Id)
else
return LuaTele.sendText(msg_chat_id,msg_id,Get_Is_Id,"md",true) 
end
else
if photo.total_count > 0 then
local Jabwa_ns ='\n* '..Description..'\n❍ ᴜѕᴇ -› '..Jabwausername..'\n❍ ѕᴛᴀ -›  '..RinkBot..'\n❍ ɪᴅ -› '..UserId..'\n❍ ᴍѕɢ -›  '..TotalMsg..'\n❍ ᴛᴘᴅʏʟᴀᴛᴋ -›  '..TotalEdit..'\n❍ ᴛғᴀᴘʟᴋ -›  '..TotalMsgT..'\n❍ ʙɪᴏ -› '..getbio(UserId)..'*'
data = {} 
data.inline_keyboard = {
{
{text =news,url = "https://t.me/"..Jabwa.username..""}, 
},
}
msgg = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id=" .. msg_chat_id .. "&photo="..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id.."&caption=".. URL.escape(Jabwa_ns).."&reply_to_message_id="..msgg.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(data))
else
local Jabwa_ns ='\n*❍ ᴜѕᴇ -› '..Jabwausername..'\n❍ ѕᴛᴀ -›  '..RinkBot..'\n❍ ɪᴅ -› '..UserId..'\n❍ ᴍѕɢ -›  '..TotalMsg..'\n❍ ᴛᴘᴅʏʟᴀᴛᴋ -›  '..TotalEdit..'\n❍ ᴛғᴀᴘʟᴋ -›  '..TotalMsgT..'\n❍ ʙɪᴏ -› '..getbio(UserId)..'*'
data = {} 
data.inline_keyboard = {
{
{text =news,url = "https://t.me/"..Jabwa.username..""}, 
},
}
msgg = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendMessage?chat_id=" .. msg_chat_id .. "&text=".. URL.escape(Jabwa_ns).."&reply_to_message_id="..msgg.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(data))
end
end
else
if Get_Is_Id then
local Get_Is_Id = Get_Is_Id:gsub('#AddMem',NumAdd) 
local Get_Is_Id = Get_Is_Id:gsub('#id',msg.sender.user_id) 
local Get_Is_Id = Get_Is_Id:gsub('#username',Jabwausername) 
local Get_Is_Id = Get_Is_Id:gsub('#msgs',TotalMsg) 
local Get_Is_Id = Get_Is_Id:gsub('#edit',TotalEdit) 
local Get_Is_Id = Get_Is_Id:gsub('#stast',RinkBot) 
local Get_Is_Id = Get_Is_Id:gsub('#auto',TotalMsgT)
local Get_Is_Id = Get_Is_Id:gsub('#Description',Description)
local Get_Is_Id = Get_Is_Id:gsub('#game',NumberGames) 
local Get_Is_Id = Get_Is_Id:gsub('#photos',TotalPhoto) 
return LuaTele.sendText(msg_chat_id,msg_id,'['..Get_Is_Id..']',"md",true) 
else
local Jabwa_ns ='\n*❍ ᴜѕᴇ -› '..Jabwausername..'\n❍ ѕᴛᴀ -›  '..RinkBot..'\n❍ ɪᴅ -› '..UserId..'\n❍ ᴍѕɢ -›  '..TotalMsg..'\n❍ ᴛᴘᴅʏʟᴀᴛᴋ -›  '..TotalEdit..'\n❍ ᴛғᴀᴘʟᴋ -›  '..TotalMsgT..'\n❍ ʙɪᴏ -› '..getbio(UserId)..'*'
data = {} 
data.inline_keyboard = {
{
{text =news,url = "https://t.me/"..Jabwa.username..""}, 
},
}
msgg = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendMessage?chat_id=" .. msg_chat_id .. "&text=".. URL.escape(Jabwa_ns).."&reply_to_message_id="..msgg.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(data))
end
end
end
if text == 'ككشف' or text == 'كشف'  and msg.reply_to_message_id ~= 0 then
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.username then
UserInfousername = '@'..UserInfo.username..''
else
UserInfousername = 'لا يوجد'
end
local Name = UserInfo.first_name
local UserId = Message_Reply.sender.user_id
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{{text = Name , url = 'tg://user?id='..UserId }},
}
}
local RinkBot = Controller(msg_chat_id,UserId)
local TotalMsg = Redis:get(MEZO..'MEZO:Num:Message:User'..msg_chat_id..':'..UserId) or 0
local TotalEdit = Redis:get(MEZO..'MEZO:Num:Message:Edit'..msg_chat_id..UserId) or 0
local TotalMsgT = Total_message(TotalMsg) 
local NumAdd = Redis:get(MEZO.."MEZO:Num:Add:Memp"..msg.chat_id..":"..UserId) or 0
local NumberGames = Redis:get(MEZO.."MEZO:Num:Add:Games"..msg.chat_id..UserId) or 0
if Get_Is_Id then
local Get_Is_Id = Get_Is_Id:gsub('#AddMem',NumAdd) 
local Get_Is_Id = Get_Is_Id:gsub('#username',(Jabwa.username or 'لا يوجد')) 
local Get_Is_Id = Get_Is_Id:gsub('#id',UserId) 
local Get_Is_Id = Get_Is_Id:gsub('#username',UserInfousername) 
local Get_Is_Id = Get_Is_Id:gsub('#msgs',TotalMsg) 
local Get_Is_Id = Get_Is_Id:gsub('#edit',TotalEdit) 
local Get_Is_Id = Get_Is_Id:gsub('#stast',RinkBot) 
local Get_Is_Id = Get_Is_Id:gsub('#auto',TotalMsgT)  
local Get_Is_Id = Get_Is_Id:gsub('#game',NumberGames) 
return LuaTele.sendText(msg_chat_id,msg_id,Get_Is_Id,"md",true) 
else
return LuaTele.sendText(msg_chat_id,msg_id,
'\n*❍ ᴜѕᴇ -› '..UserInfousername..
'\n❍ ɪᴅ -› '..UserId..
'\n❍ ѕᴛᴀ -› '..RinkBot..
'\n❍ ᴍѕɢ -› '..TotalMsg..
'\n❍ ᴛᴘᴅʏʟᴀᴛᴋ -› '..TotalEdit..
'\n❍ ᴛғᴀᴘʟᴋ -› '..TotalMsgT..
'\n❍ ʙɪᴏ -› '..getbio(UserId)..
'*',"md",false, false, false, false, reply_markup) 
end
end
if text and text:match('^ايدي @(%S+)$') or text and text:match('^كشف @(%S+)$') then
local UserName = text:match('^ايدي @(%S+)$') or text:match('^كشف @(%S+)$')
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا لا يوجد حساب بهاذا المعرف *","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا لا تستطيع استخدام معرف قناة او كروب *","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا لا تستطيع استخدام معرف البوت *","md",true)  
end
local UserId = UserId_Info.id
local RinkBot = Controller(msg_chat_id,UserId_Info.id)
local TotalMsg = Redis:get(MEZO..'MEZO:Num:Message:User'..msg_chat_id..':'..UserId) or 0
local TotalEdit = Redis:get(MEZO..'MEZO:Num:Message:Edit'..msg_chat_id..UserId) or 0
local TotalMsgT = Total_message(TotalMsg) 
local NumAdd = Redis:get(MEZO.."MEZO:Num:Add:Memp"..msg.chat_id..":"..UserId) or 0
local NumberGames = Redis:get(MEZO.."MEZO:Num:Add:Games"..msg.chat_id..UserId) or 0
if Get_Is_Id then
local Get_Is_Id = Get_Is_Id:gsub('#AddMem',NumAdd) 
local Get_Is_Id = Get_Is_Id:gsub('#id',UserId) 
local Get_Is_Id = Get_Is_Id:gsub('#username','@'..UserName) 
local Get_Is_Id = Get_Is_Id:gsub('#msgs',TotalMsg) 
local Get_Is_Id = Get_Is_Id:gsub('#edit',TotalEdit) 
local Get_Is_Id = Get_Is_Id:gsub('#stast',RinkBot) 
local Get_Is_Id = Get_Is_Id:gsub('#auto',TotalMsgT)  
local Get_Is_Id = Get_Is_Id:gsub('#game',NumberGames) 
return LuaTele.sendText(msg_chat_id,msg_id,Get_Is_Id,"md",true) 
else
return LuaTele.sendText(msg_chat_id,msg_id,
'\n*❍ ᴜѕᴇ -› @'..UserName..
'\n❍ ɪᴅ -› '..UserId..
'\n❍ ѕᴛᴀ -› '..RinkBot..
'\n❍ ᴍѕɢ -› '..TotalMsg..
'\n❍ ᴛᴘᴅʏʟᴀᴛᴋ -› '..TotalEdit..
'\n❍ ᴛғᴀᴘʟᴋ -› '..TotalMsgT..
'\n❍ ʙɪᴏ -› '..getbio(UserId)..
'*',"md",true) 
end
end
if text == 'انا مين' then
local ban = LuaTele.getUser(msg.sender.user_id)
local news = 'انت يرحقلبي • 🌝❤ -› '..msg.Name_Controller
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{{text =news,url = "https://t.me/"..ban.username..""}, },}}
return LuaTele.sendText(msg_chat_id, msg_id, news, 'md', false, false, false, false, reply_markup)
end
if text == 'رتبتي' then
local Jabwa = LuaTele.getUser(msg.sender.user_id)
local news = '🌝🖤 رتبتك في البوت -› '..msg.Name_Controller
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{{text =news,url = "https://t.me/"..Jabwa.username..""}, },}}
return LuaTele.sendText(msg_chat_id, msg_id, news, 'md', false, false, false, false, reply_markup)
end
if text == 'اسمي' then
local user_info = LuaTele.getUser(msg.sender.user_id)
local first_n = user_info.first_name
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{{text =user_info.first_name,url = "https://t.me/"..user_info.username..""}, },}}
return LuaTele.sendText(msg_chat_id, msg_id, 'اسمك -› '..first_n, 'md', false, false, false, false, reply_markup)
end
if text == "معرفي" or text == "يوزري" then
local ban = LuaTele.getUser(msg.sender.user_id)
if ban.username then
banusername = '[@'..ban.username..']'
else
banusername = 'لا يوجد'
end
return LuaTele.sendText(msg_chat_id,msg_id,banusername,"md",true) 
end
if text == 'التاريخ' then
local user_info = LuaTele.getUser(msg.sender.user_id)
local first_n = os.date("%Y/%m/%d")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{{text =user_info.first_name,url = "https://t.me/"..user_info.username..""}, },}}
return LuaTele.sendText(msg_chat_id, msg_id, 'التاريخ -› '..first_n, 'md', false, false, false, false, reply_markup)
end
if text == 'ايديي' then
return LuaTele.sendText(msg_chat_id,msg_id,'\nايديك -› '..msg.sender.user_id,"md",true)  
end
if text == "بايو" or text == "البايو" then
return LuaTele.sendText(msg_chat_id,msg_id,getbio(msg.sender.user_id),"md",true) 
end
if text == 'معلوماتي' or text == 'موقعي' then
local Jabwa = LuaTele.getUser(msg.sender.user_id)
var(LuaTele.getChatMember(msg_chat_id,msg.sender.user_id))
local StatusMember = LuaTele.getChatMember(msg_chat_id,msg.sender.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
StatusMemberChat = 'مالك المجموعه'
elseif (StatusMember == "chatMemberStatusAdministrator") then
StatusMemberChat = 'مشرف المجموعه'
else
StatusMemberChat = 'عظو في المجموعه'
end
local UserId = msg.sender.user_id
local RinkBot = msg.Name_Controller
local TotalMsg = Redis:get(MEZO..'MEZO:Num:Message:User'..msg_chat_id..':'..msg.sender.user_id) or 0
local TotalEdit = Redis:get(MEZO..'MEZO:Num:Message:Edit'..msg_chat_id..msg.sender.user_id) or 0
local TotalMsgT = Total_message(TotalMsg) 
if Jabwa.username then
Jabwausername = '@'..Jabwa.username..''
else
Jabwausername = 'لا يوجد'
end
if StatusMemberChat == 'مشرف المجموعه' then 
local GetMemberStatus = LuaTele.getChatMember(msg_chat_id,msg.sender.user_id).status
if GetMemberStatus.can_change_info then
change_info = '【 ✅ 】' else change_info = '【 ❌ 】'
end
if GetMemberStatus.can_delete_messages then
delete_messages = '【 ✅ 】' else delete_messages = '【 ❌ 】'
end
if GetMemberStatus.can_invite_users then
invite_users = '【 ✅ 】' else invite_users = '【 ❌ 】'
end
if GetMemberStatus.can_pin_messages then
pin_messages = '【 ✅ 】' else pin_messages = '【 ❌ 】'
end
if GetMemberStatus.can_restrict_members then
restrict_members = '【 ✅ 】' else restrict_members = '【 ❌ 】'
end
if GetMemberStatus.can_promote_members then
promote = '【 ✅ 】' else promote = '【 ❌ 】'
end
PermissionsUser = '*\n ❍┃ صلاحيات المستخدم :\n— — — — — — — — —'..'\n ❍┃ تغيير المعلومات : '..change_info..'\n ❍┃ تثبيت الرسائل : '..pin_messages..'\n ❍┃ اضافه مستخدمين : '..invite_users..'\n ❍┃ مسح الرسائل : '..delete_messages..'\n ❍┃ حظر المستخدمين : '..restrict_members..'\n ❍┃ اضافه المشرفين : '..promote..'\n\n*'
end
return LuaTele.sendText(msg_chat_id,msg_id,
'\n*❍ ɪᴅ -› '..UserId..
'\n❍ ᴜѕᴇ -› '..Jabwausername..
'\n❍ ѕᴛᴀ -› '..RinkBot..
'\n❍ ѕᴛᴀ ɢʀᴏᴜᴘ -› '..StatusMemberChat..
'\n❍ ᴍѕɢ -› '..TotalMsg..
'\n❍ ᴛᴘᴅʏʟᴀᴛᴋ -› '..TotalEdit..
'\n❍ ᴛғᴀᴘʟᴋ -› '..TotalMsgT..
'*'..(PermissionsUser or '') ,"md",true) 
end
if text == 'كشف البوت' then 
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(6)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local StatusMember = LuaTele.getChatMember(msg_chat_id,MEZO).status.luatele
if (StatusMember ~= "chatMemberStatusAdministrator") then
return LuaTele.sendText(msg_chat_id,msg_id,' ❍┃ البوت عضو في المجموعه ',"md",true) 
end
local GetMemberStatus = LuaTele.getChatMember(msg_chat_id,MEZO).status
if GetMemberStatus.can_change_info then
change_info = '【 ✅ 】' else change_info = '【 ❌ 】'
end
if GetMemberStatus.can_delete_messages then
delete_messages = '【 ✅ 】' else delete_messages = '【 ❌ 】'
end
if GetMemberStatus.can_invite_users then
invite_users = '【 ✅ 】' else invite_users = '【 ❌ 】'
end
if GetMemberStatus.can_pin_messages then
pin_messages = '【 ✅ 】' else pin_messages = '【 ❌ 】'
end
if GetMemberStatus.can_restrict_members then
restrict_members = '【 ✅ 】' else restrict_members = '【 ❌ 】'
end
if GetMemberStatus.can_promote_members then
promote = '【 ✅ 】' else promote = '【 ❌ 】'
end
PermissionsUser = '*\n ❍┃ صلاحيات البوت في المجموعه :\n— — — — — — — — —'..'\n ❍┃ تغيير المعلومات : '..change_info..'\n ❍┃ تثبيت الرسائل : '..pin_messages..'\n ❍┃ اضافه مستخدمين : '..invite_users..'\n ❍┃ مسح الرسائل : '..delete_messages..'\n ❍┃ حظر المستخدمين : '..restrict_members..'\n ❍┃ اضافه المشرفين : '..promote..'\n\n*'
return LuaTele.sendText(msg_chat_id,msg_id,PermissionsUser,"md",true) 
end

if text and text:match('^مسح (%d+)$') then
local NumMessage = text:match('^مسح (%d+)$')
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(6)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).Delmsg == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ البوت ليس لديه صلاحيه حذف الرسائل* ',"md",true)  
end
if tonumber(NumMessage) > 1000 then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ العدد اكثر من 1000 لا تستطيع الحذف',"md",true)  
end
local Message = msg.id
for i=1,tonumber(NumMessage) do
local deleteMessages = LuaTele.deleteMessages(msg.chat_id,{[1]= Message})
var(deleteMessages)
Message = Message - 1048576
end
LuaTele.sendText(msg_chat_id, msg_id, "❍┃ تم تنظيف⟦ "..NumMessage.. ' ⟧رساله', 'md')
end

if text and text:match('^تنزيل (.*) @(%S+)$') then
local UserName = {text:match('^تنزيل (.*) @(%S+)$')}
local UserId_Info = LuaTele.searchPublicChat(UserName[2])
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName[2]:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام معرف البوت ","md",true)  
end
if UserName[1] == "كرستين" then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(MEZO.."MEZO:DevelopersQ:Groups",UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"* ❍┃ تم تنزيله مطور ثانوي مسبقا *").Reply,"md",true)  
else
Redis:srem(MEZO.."MEZO:DevelopersQ:Groups",UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"* ❍┃ تم تنزيله مطور ثانوي *").Reply,"md",true)  
end
end
if UserName[1] == "مطور" then
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(2)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(MEZO.."MEZO:Developers:Groups",UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ❍┃ تم تنزيله مطور مسبقا ").Reply,"md",true)  
else
Redis:srem(MEZO.."MEZO:Developers:Groups",UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ❍┃ تم تنزيله مطور ").Reply,"md",true)  
end
end
if UserName[1] == "مالك" then
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(3)..' ⟧* ',"md",true)  
end
if not Redis:sismember(MEZO.."MEZO:TheBasicsQ:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ❍┃ تم تنزيله مالك مسبقا ").Reply,"md",true)  
else
Redis:srem(MEZO.."MEZO:TheBasicsQ:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ❍┃ تم تنزيله مالك ").Reply,"md",true)  
end
end
if UserName[1] == "منشئ اساسي" then
if not msg.TheBasicsm then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(MEZO.."MEZO:TheBasics:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ❍┃ تم تنزيله منشئ اساسي مسبقا ").Reply,"md",true)  
else
Redis:srem(MEZO.."MEZO:TheBasics:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ❍┃ تم تنزيله منشئ اساسي ").Reply,"md",true)  
end
end
if UserName[1] == "منشئ" then
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(4)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(MEZO.."MEZO:Originators:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ❍┃ تم تنزيله من المنشئين مسبقا ").Reply,"md",true)  
else
Redis:srem(MEZO.."MEZO:Originators:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ❍┃ تم تنزيله من المنشئين ").Reply,"md",true)  
end
end
if UserName[1] == "مدير" then
if not msg.Originators then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(5)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(MEZO.."MEZO:Managers:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ❍┃ تم تنزيله من المدراء مسبقا ").Reply,"md",true)  
else
Redis:srem(MEZO.."MEZO:Managers:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ❍┃ تم تنزيله من المدراء ").Reply,"md",true)  
end
end
if UserName[1] == "ادمن" then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(6)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(MEZO.."MEZO:Addictive:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ❍┃ تم تنزيله من الادمنيه مسبقا ").Reply,"md",true)  
else
Redis:srem(MEZO.."MEZO:Addictive:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ❍┃ تم تنزيله من الادمنيه ").Reply,"md",true)  
end
end
if UserName[1] == "مميز" then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(MEZO.."MEZO:Distinguished:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ❍┃ تم تنزيله من المميزين مسبقا ").Reply,"md",true)  
else
Redis:srem(MEZO.."MEZO:Distinguished:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ❍┃ تم تنزيله من المميزبن ").Reply,"md",true)  
end
end
end
if text and text:match("^تنزيل (.*)$") and msg.reply_to_message_id ~= 0 then
local TextMsg = text:match("^تنزيل (.*)$")
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local Jabwa = LuaTele.getUser(Message_Reply.sender.user_id)
if Jabwa.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if Jabwa and Jabwa.type and Jabwa.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام الامر على البوت ","md",true)  
end
if TextMsg == 'كرستين' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(MEZO.."MEZO:DevelopersQ:Groups",Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ❍┃ تم تنزيله مطور ثانوي مسبقا ").Reply,"md",true)  
else
Redis:srem(MEZO.."MEZO:DevelopersQ:Groups",Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ❍┃ تم تنزيله مطور ثانوي").Reply,"md",true)  
end
end
if TextMsg == 'مطور' then
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(2)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(MEZO.."MEZO:Developers:Groups",Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ❍┃ تم تنزيله مطور مسبقا ").Reply,"md",true)  
else
Redis:srem(MEZO.."MEZO:Developers:Groups",Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ❍┃ تم تنزيله مطور ").Reply,"md",true)  
end
end
if TextMsg == "مالك" then
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(3)..' ⟧* ',"md",true)  
end
if not Redis:sismember(MEZO.."MEZO:TheBasicsQ:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ❍┃ تم تنزيله مالك مسبقا ").Reply,"md",true)  
else
Redis:srem(MEZO.."MEZO:TheBasicsQ:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ❍┃ تم تنزيله مالك ").Reply,"md",true)  
end
end
if TextMsg == "منشئ اساسي" then
if not msg.TheBasicsm then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(MEZO.."MEZO:TheBasics:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ❍┃ تم تنزيله منشئ اساسي مسبقا ").Reply,"md",true)  
else
Redis:srem(MEZO.."MEZO:TheBasics:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ❍┃ تم تنزيله منشئ اساسي ").Reply,"md",true)  
end
end
if TextMsg == "منشئ" then
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(4)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(MEZO.."MEZO:Originators:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ❍┃ تم تنزيله من المنشئين مسبقا ").Reply,"md",true)  
else
Redis:srem(MEZO.."MEZO:Originators:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ❍┃ تم تنزيله من المنشئين ").Reply,"md",true)  
end
end
if TextMsg == "مدير" then
if not msg.Originators then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(5)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(MEZO.."MEZO:Managers:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ❍┃ تم تنزيله من المدراء مسبقا ").Reply,"md",true)  
else
Redis:srem(MEZO.."MEZO:Managers:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ❍┃ تم تنزيله من المدراء ").Reply,"md",true)  
end
end
if TextMsg == "ادمن" then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(6)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(MEZO.."MEZO:Addictive:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ❍┃ تم تنزيله من الادمنيه مسبقا ").Reply,"md",true)  
else
Redis:srem(MEZO.."MEZO:Addictive:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ❍┃ تم تنزيله من الادمنيه ").Reply,"md",true)  
end
end
if TextMsg == "مميز" then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(MEZO.."MEZO:Distinguished:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ❍┃ تم تنزيله من المميزين مسبقا ").Reply,"md",true)  
else
Redis:srem(MEZO.."MEZO:Distinguished:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ❍┃ تم تنزيله من المميزبن ").Reply,"md",true)  
end
end
end


if text and text:match('^تنزيل (.*) (%d+)$') then
local UserId = {text:match('^تنزيل (.*) (%d+)$')}
local Jabwa = LuaTele.getUser(UserId[2])
if Jabwa.luatele == "error" and Jabwa.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if Jabwa.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if Jabwa and Jabwa.type and Jabwa.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام الامر على البوت ","md",true)  
end
if UserId[1] == 'كرستين' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(MEZO.."MEZO:DevelopersQ:Groups",UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"* ❍┃ تم تنزيله مطور ثانوي مسبقا *").Reply,"md",true)  
else
Redis:srem(MEZO.."MEZO:DevelopersQ:Groups",UserId) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"* ❍┃ تم تنزيله مطور ثانوي *").Reply,"md",true)  
end
end
if UserId[1] == 'مطور' then
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(2)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(MEZO.."MEZO:Developers:Groups",UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId," ❍┃ تم تنزيله مطور مسبقا ").Reply,"md",true)  
else
Redis:srem(MEZO.."MEZO:Developers:Groups",UserId) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId," ❍┃ تم تنزيله مطور ").Reply,"md",true)  
end
end
if UserId[1] == "مالك" then
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(3)..' ⟧* ',"md",true)  
end
if not Redis:sismember(MEZO.."MEZO:TheBasicsQ:Group"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2]," ❍┃ تم تنزيله مالك مسبقا ").Reply,"md",true)  
else
Redis:srem(MEZO.."MEZO:TheBasicsQ:Group"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2]," ❍┃ تم تنزيله مالك ").Reply,"md",true)  
end
end
if UserId[1] == "منشئ اساسي" then
if not msg.TheBasicsm then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(MEZO.."MEZO:TheBasics:Group"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2]," ❍┃ تم تنزيله منشئ اساسي مسبقا ").Reply,"md",true)  
else
Redis:srem(MEZO.."MEZO:TheBasics:Group"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2]," ❍┃ تم تنزيله منشئ اساسي ").Reply,"md",true)  
end
end
if UserId[1] == "منشئ" then
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(4)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(MEZO.."MEZO:Originators:Group"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2]," ❍┃ تم تنزيله من المنشئين مسبقا ").Reply,"md",true)  
else
Redis:srem(MEZO.."MEZO:Originators:Group"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2]," ❍┃ تم تنزيله من المنشئين ").Reply,"md",true)  
end
end
if UserId[1] == "مدير" then
if not msg.Originators then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(5)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(MEZO.."MEZO:Managers:Group"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2]," ❍┃ تم تنزيله من المدراء مسبقا ").Reply,"md",true)  
else
Redis:srem(MEZO.."MEZO:Managers:Group"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2]," ❍┃ تم تنزيله من المدراء ").Reply,"md",true)  
end
end
if UserId[1] == "ادمن" then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(6)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(MEZO.."MEZO:Addictive:Group"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2]," ❍┃ تم تنزيله من الادمنيه مسبقا ").Reply,"md",true)  
else
Redis:srem(MEZO.."MEZO:Addictive:Group"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2]," ❍┃ تم تنزيله من الادمنيه ").Reply,"md",true)  
end
end
if UserId[1] == "مميز" then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(MEZO.."MEZO:Distinguished:Group"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2]," ❍┃ تم تنزيله من المميزين مسبقا ").Reply,"md",true)  
else
Redis:srem(MEZO.."MEZO:Distinguished:Group"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2]," ❍┃ تم تنزيله من المميزبن ").Reply,"md",true)  
end
end
end
if text and text:match('^رفع (.*) @(%S+)$') then
local UserName = {text:match('^رفع (.*) @(%S+)$')}
local UserId_Info = LuaTele.searchPublicChat(UserName[2])
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName[2]:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام معرف البوت ","md",true)  
end
if UserName[1] == "كرستين" then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(MEZO.."MEZO:DevelopersQ:Groups",UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ❍┃ تم ترقيته مطور ثانوي مسبقا ").Reply,"md",true)  
else
Redis:sadd(MEZO.."MEZO:DevelopersQ:Groups",UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ❍┃ تم ترقيته مطور ثانوي").Reply,"md",true)  
end
end
if UserName[1] == "مطور" then
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(2)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(MEZO.."MEZO:Developers:Groups",UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ❍┃ تم ترقيته مطور مسبقا ").Reply,"md",true)  
else
Redis:sadd(MEZO.."MEZO:Developers:Groups",UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ❍┃ تم ترقيته مطور ").Reply,"md",true)  
end
end
if UserName[1] == "مالك" then
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(3)..' ⟧* ',"md",true)  
end
if Redis:sismember(MEZO.."MEZO:TheBasicsQ:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ❍┃ تم ترقيته مالك مسبقا ").Reply,"md",true)  
else
Redis:sadd(MEZO.."MEZO:TheBasicsQ:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ❍┃ تم ترقيته مالك ").Reply,"md",true)  
end
end
if UserName[1] == "منشئ اساسي" then
if not msg.TheBasicsm then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(MEZO.."MEZO:TheBasics:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ❍┃ تم ترقيته منشئ اساسي مسبقا ").Reply,"md",true)  
else
Redis:sadd(MEZO.."MEZO:TheBasics:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ❍┃ تم ترقيته منشئ اساسي ").Reply,"md",true)  
end
end
if UserName[1] == "منشئ" then
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(4)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(MEZO.."MEZO:Originators:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ❍┃ تم ترقيته منشئ  مسبقا ").Reply,"md",true)  
else
Redis:sadd(MEZO.."MEZO:Originators:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ❍┃ تم ترقيته منشئ  ").Reply,"md",true)  
end
end
if UserName[1] == "مدير" then
if not msg.Originators then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(5)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(MEZO.."MEZO:Managers:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ❍┃ تم ترقيته مدير  مسبقا ").Reply,"md",true)  
else
Redis:sadd(MEZO.."MEZO:Managers:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ❍┃ تم ترقيته مدير  ").Reply,"md",true)  
end
end
if UserName[1] == "ادمن" then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(6)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not msg.Originators and not Redis:get(MEZO.."MEZO:Status:SetId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم تعطيل (الرفع) من قبل المنشئين","md",true)
end 
if Redis:sismember(MEZO.."MEZO:Addictive:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ❍┃ تم ترقيته ادمن  مسبقا ").Reply,"md",true)  
else
Redis:sadd(MEZO.."MEZO:Addictive:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ❍┃ تم ترقيته ادمن  ").Reply,"md",true)  
end
end
if UserName[1] == "مميز" then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not msg.Originators and not Redis:get(MEZO.."MEZO:Status:SetId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم تعطيل (الرفع) من قبل المنشئين","md",true)
end 
if Redis:sismember(MEZO.."MEZO:Distinguished:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ❍┃ تم ترقيته مميز  مسبقا ").Reply,"md",true)  
else
Redis:sadd(MEZO.."MEZO:Distinguished:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ❍┃ تم ترقيته مميز  ").Reply,"md",true)  
end
end
end
if text and text:match("^رفع (.*)$") and msg.reply_to_message_id ~= 0 then
local TextMsg = text:match("^رفع (.*)$")
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local Jabwa = LuaTele.getUser(Message_Reply.sender.user_id)
if Jabwa.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if Jabwa and Jabwa.type and Jabwa.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام الامر على البوت ","md",true)  
end
if TextMsg == 'كرستين' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(MEZO.."MEZO:DevelopersQ:Groups",Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ❍┃ تم ترقيته مطور ثانوي مسبقا ").Reply,"md",true)  
else
Redis:sadd(MEZO.."MEZO:DevelopersQ:Groups",Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ❍┃ تم ترقيته مطور ثانوي").Reply,"md",true)  
end
end
if TextMsg == 'مطور' then
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(2)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(MEZO.."MEZO:Developers:Groups",Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ❍┃ تم ترقيته مطور مسبقا ").Reply,"md",true)  
else
Redis:sadd(MEZO.."MEZO:Developers:Groups",Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ❍┃ تم ترقيته مطور ").Reply,"md",true)  
end
end
if TextMsg == "مالك" then
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(3)..' ⟧* ',"md",true)  
end
if Redis:sismember(MEZO.."MEZO:TheBasicsQ:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ❍┃ تم ترقيته مالك مسبقا ").Reply,"md",true)  
else
Redis:sadd(MEZO.."MEZO:TheBasicsQ:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ❍┃ تم ترقيته مالك ").Reply,"md",true)  
end
end
if TextMsg == "منشئ اساسي" then
if not msg.TheBasicsm then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(MEZO.."MEZO:TheBasics:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ❍┃ تم ترقيته منشئ اساسي مسبقا ").Reply,"md",true)  
else
Redis:sadd(MEZO.."MEZO:TheBasics:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ❍┃ تم ترقيته منشئ اساسي ").Reply,"md",true)  
end
end
if TextMsg == "منشئ" then
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(4)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(MEZO.."MEZO:Originators:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ❍┃ تم ترقيته منشئ  مسبقا ").Reply,"md",true)  
else
Redis:sadd(MEZO.."MEZO:Originators:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ❍┃ تم ترقيته منشئ  ").Reply,"md",true)  
end
end
if TextMsg == "مدير" then
if not msg.Originators then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(5)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(MEZO.."MEZO:Managers:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ❍┃ تم ترقيته مدير  مسبقا ").Reply,"md",true)  
else
Redis:sadd(MEZO.."MEZO:Managers:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ❍┃ تم ترقيته مدير  ").Reply,"md",true)  
end
end
if TextMsg == "ادمن" then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(6)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not msg.Originators and not Redis:get(MEZO.."MEZO:Status:SetId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم تعطيل (الرفع) من قبل المنشئين","md",true)
end 
if Redis:sismember(MEZO.."MEZO:Addictive:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ❍┃ تم ترقيته ادمن  مسبقا ").Reply,"md",true)  
else
Redis:sadd(MEZO.."MEZO:Addictive:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ❍┃ تم ترقيته ادمن  ").Reply,"md",true)  
end
end
if TextMsg == "مميز" then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not msg.Originators and not Redis:get(MEZO.."MEZO:Status:SetId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم تعطيل (الرفع) من قبل المنشئين","md",true)
end 
if Redis:sismember(MEZO.."MEZO:Distinguished:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ❍┃ تم ترقيته مميز  مسبقا ").Reply,"md",true)  
else
Redis:sadd(MEZO.."MEZO:Distinguished:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ❍┃ تم ترقيته مميز  ").Reply,"md",true)  
end
end
end
if text and text:match('^رفع (.*) (%d+)$') then
local UserId = {text:match('^رفع (.*) (%d+)$')}
local Jabwa = LuaTele.getUser(UserId[2])
if Jabwa.luatele == "error" and Jabwa.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if Jabwa.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if Jabwa and Jabwa.type and Jabwa.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام الامر على البوت ","md",true)  
end
if UserId[1] == 'كرستين' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(MEZO.."MEZO:DevelopersQ:Groups",UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId," ❍┃ تم ترقيته مطور ثانوي مسبقا ").Reply,"md",true)  
else
Redis:sadd(MEZO.."MEZO:DevelopersQ:Groups",UserId) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId," ❍┃ تم ترقيته مطور ثانوي").Reply,"md",true)  
end
end
if UserId[1] == 'مطور' then
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(2)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(MEZO.."MEZO:Developers:Groups",UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId," ❍┃ تم ترقيته مطور مسبقا ").Reply,"md",true)  
else
Redis:sadd(MEZO.."MEZO:Developers:Groups",UserId) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId," ❍┃ تم ترقيته مطور ").Reply,"md",true)  
end
end
if UserId[1] == "مالك" then
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(3)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(MEZO.."MEZO:TheBasicsQ:Group"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2]," ❍┃ تم ترقيته مالك مسبقا ").Reply,"md",true)  
else
Redis:sadd(MEZO.."MEZO:TheBasicsQ:Group"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2]," ❍┃ تم ترقيته مالك ").Reply,"md",true)  
end
end
if UserId[1] == "منشئ اساسي" then
if not msg.TheBasicsm then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(MEZO.."MEZO:TheBasics:Group"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2]," ❍┃ تم ترقيته منشئ اساسي مسبقا ").Reply,"md",true)  
else
Redis:sadd(MEZO.."MEZO:TheBasics:Group"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2]," ❍┃ تم ترقيته منشئ اساسي ").Reply,"md",true)  
end
end
if UserId[1] == "منشئ" then
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(4)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(MEZO.."MEZO:Originators:Group"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2]," ❍┃ تم ترقيته منشئ  مسبقا ").Reply,"md",true)  
else
Redis:sadd(MEZO.."MEZO:Originators:Group"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2]," ❍┃ تم ترقيته منشئ  ").Reply,"md",true)  
end
end
if UserId[1] == "مدير" then
if not msg.Originators then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(5)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(MEZO.."MEZO:Managers:Group"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2]," ❍┃ تم ترقيته مدير  مسبقا ").Reply,"md",true)  
else
Redis:sadd(MEZO.."MEZO:Managers:Group"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2]," ❍┃ تم ترقيته مدير  ").Reply,"md",true)  
end
end
if UserId[1] == "ادمن" then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(6)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not msg.Originators and not Redis:get(MEZO.."MEZO:Status:SetId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم تعطيل (الرفع) من قبل المنشئين","md",true)
end 
if Redis:sismember(MEZO.."MEZO:Addictive:Group"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2]," ❍┃ تم ترقيته ادمن  مسبقا ").Reply,"md",true)  
else
Redis:sadd(MEZO.."MEZO:Addictive:Group"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2]," ❍┃ تم ترقيته ادمن  ").Reply,"md",true)  
end
end
if UserId[1] == "مميز" then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not msg.Originators and not Redis:get(MEZO.."MEZO:Status:SetId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم تعطيل (الرفع) من قبل المنشئين","md",true)
end 
if Redis:sismember(MEZO.."MEZO:Distinguished:Group"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2]," ❍┃ تم ترقيته مميز  مسبقا ").Reply,"md",true)  
else
Redis:sadd(MEZO.."MEZO:Distinguished:Group"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2]," ❍┃ تم ترقيته مميز  ").Reply,"md",true)  
end
end
end
if text and text:match("^تغير رد المطور (.*)$") then
local Teext = text:match("^تغير رد المطور (.*)$") 
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(6)..' ⟧* ',"md",true)  
end
Redis:set(MEZO.."MEZO:Developer:Bot:Reply"..msg.chat_id,Teext)
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم تغير رد المطور الى :"..Teext)
elseif text and text:match("^تغير رد المنشئ الاساسي (.*)$") then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(6)..' ⟧* ',"md",true)  
end
local Teext = text:match("^تغير رد المنشئ الاساسي (.*)$") 
Redis:set(MEZO.."MEZO:President:Group:Reply"..msg.chat_id,Teext)
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم تغير رد المنشئ الاساسي الى :"..Teext)
elseif text and text:match("^تغير رد المنشئ (.*)$") then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(6)..' ⟧* ',"md",true)  
end
local Teext = text:match("^تغير رد المنشئ (.*)$") 
Redis:set(MEZO.."MEZO:Constructor:Group:Reply"..msg.chat_id,Teext)
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم تغير رد المنشئ الى :"..Teext)
elseif text and text:match("^تغير رد المالك (.*)$") then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(6)..' ⟧* ',"md",true)  
end
local Teext = text:match("^تغير رد المالك (.*)$") 
Redis:set(MEZO.."MEZO:PresidentQ:Group:Reply"..msg.chat_id,Teext)
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم تغير رد المالك الى :"..Teext)
elseif text and text:match("^تغير رد المدير (.*)$") then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(6)..' ⟧* ',"md",true)  
end
local Teext = text:match("^تغير رد المدير (.*)$") 
Redis:set(MEZO.."MEZO:Manager:Group:Reply"..msg.chat_id,Teext) 
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم تغير رد المدير الى :"..Teext)
elseif text and text:match("^تغير رد الادمن (.*)$") then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(6)..' ⟧* ',"md",true)  
end
local Teext = text:match("^تغير رد الادمن (.*)$") 
Redis:set(MEZO.."MEZO:Admin:Group:Reply"..msg.chat_id,Teext)
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم تغير رد الادمن الى :"..Teext)
elseif text and text:match("^تغير رد المميز (.*)$") then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(6)..' ⟧* ',"md",true)  
end
local Teext = text:match("^تغير رد المميز (.*)$") 
Redis:set(MEZO.."MEZO:Vip:Group:Reply"..msg.chat_id,Teext)
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم تغير رد المميز الى :"..Teext)
elseif text and text:match("^تغير رد العضو (.*)$") then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(6)..' ⟧* ',"md",true)  
end
local Teext = text:match("^تغير رد العضو (.*)$") 
Redis:set(MEZO.."MEZO:Mempar:Group:Reply"..msg.chat_id,Teext)
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم تغير رد العضو الى :"..Teext)
elseif text == 'حذف رد المطور' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(6)..' ⟧* ',"md",true)  
end
Redis:del(MEZO.."MEZO:Developer:Bot:Reply"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم حدف رد المطور")
elseif text == 'حذف رد المنشئ الاساسي' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(6)..' ⟧* ',"md",true)  
end
Redis:del(MEZO.."MEZO:President:Group:Reply"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم حذف رد المنشئ الاساسي ")
elseif text == 'حذف رد المالك' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(6)..' ⟧* ',"md",true)  
end
Redis:del(MEZO.."MEZO:PresidentQ:Group:Reply"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم حذف رد المالك ")
elseif text == 'حذف رد المنشئ' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(6)..' ⟧* ',"md",true)  
end
Redis:del(MEZO.."MEZO:Constructor:Group:Reply"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم حذف رد المنشئ ")
elseif text == 'حذف رد المدير' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(6)..' ⟧* ',"md",true)  
end
Redis:del(MEZO.."MEZO:Manager:Group:Reply"..msg.chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم حذف رد المدير ")
elseif text == 'حذف رد الادمن' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(6)..' ⟧* ',"md",true)  
end
Redis:del(MEZO.."MEZO:Admin:Group:Reply"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم حذف رد الادمن ")
elseif text == 'حذف رد المميز' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(6)..' ⟧* ',"md",true)  
end
Redis:del(MEZO.."MEZO:Vip:Group:Reply"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم حذف رد المميز")
elseif text == 'حذف رد العضو' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(6)..' ⟧* ',"md",true)  
end
Redis:del(MEZO.."MEZO:Mempar:Group:Reply"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم حذف رد العضو")
end
if text == 'الثانوين' or text == 'المطورين الثانوين' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(MEZO.."MEZO:DevelopersQ:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ لا يوجد مطورين ثانوين في البوت*","md",true)  
end
ListMembers = '\n* قائمه المطورين الثانوين ⇧⇩* \n— — — — — — — — —\n'
for k, v in pairs(Info_Members) do
local Jabwa = LuaTele.getUser(v)
if Jabwa and Jabwa.username and Jabwa.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..Jabwa.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '❍ مسح الثانوين ❍', data = msg.sender.user_id..'/DevelopersQ'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المطورين' then
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(2)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(MEZO.."MEZO:Developers:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ لا يوجد مطورين في البوت*","md",true)  
end
ListMembers = '\n* ❍┃ قائمه مطورين البوت ⇧⇩*\n— — — — — — — — —\n'
for k, v in pairs(Info_Members) do
local Jabwa = LuaTele.getUser(v)
if Jabwa and Jabwa.username and Jabwa.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..Jabwa.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '❍ مسح المطورين ❍', data = msg.sender.user_id..'/Developers'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المالكين' then
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(3)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(MEZO.."MEZO:TheBasicsQ:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ لا يوجد مالكين في البوت *","md",true)  
end
ListMembers = '\n* ❍┃ قائمه المالكين في البوت ⇧⇩*\n— — — — — — — — —\n'
for k, v in pairs(Info_Members) do
local Jabwa = LuaTele.getUser(v)
if Jabwa and Jabwa.username and Jabwa.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..Jabwa.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '❍ مسح المالكين ❍', data = msg.sender.user_id..'/TheBasicsQ'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المنشئين الاساسيين' then
if not msg.TheBasicsm then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(MEZO.."MEZO:TheBasics:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ لا يوجد منشئين اساسيين في البوت *","md",true)  
end
ListMembers = '\n* ❍┃ قائمه المنشئين الاساسيين ⇧⇩*\n— — — — — — — — —\n'
for k, v in pairs(Info_Members) do
local Jabwa = LuaTele.getUser(v)
if Jabwa and Jabwa.username and Jabwa.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..Jabwa.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '❍ مسح المنشئين الاساسيين ❍', data = msg.sender.user_id..'/TheBasics'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المنشئين' then
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(4)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(MEZO.."MEZO:Originators:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ لا يوجد منشئين في البوت *","md",true)  
end
ListMembers = '\n* ❍┃ قائمه المنشئين في البوت ⇧⇩*\n— — — — — — — — —\n'
for k, v in pairs(Info_Members) do
local Jabwa = LuaTele.getUser(v)
if Jabwa and Jabwa.username and Jabwa.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..Jabwa.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '❍ مسح المنشئين ❍', data = msg.sender.user_id..'/Originators'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المدراء' then
if not msg.Originators then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(5)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(MEZO.."MEZO:Managers:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ لا يوجد مدراء في البوت *","md",true)  
end
ListMembers = '\n* ❍┃ قائمه المدراء في البوت ⇧⇩*\n— — — — — — — — —\n'
for k, v in pairs(Info_Members) do
local Jabwa = LuaTele.getUser(v)
if Jabwa and Jabwa.username and Jabwa.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..Jabwa.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '❍ مسح المدراء ❍', data = msg.sender.user_id..'/Managers'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'الادمنيه' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(6)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(MEZO.."MEZO:Addictive:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ لا يوجد ادمنيه في البوت *","md",true)  
end
ListMembers = '\n* ❍┃ قائمه الادمنيه في البوت ⇧⇩*\n— — — — — — — — —\n'
for k, v in pairs(Info_Members) do
local Jabwa = LuaTele.getUser(v)
if Jabwa and Jabwa.username and Jabwa.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..Jabwa.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '❍ مسح الادمنيه ❍', data = msg.sender.user_id..'/Addictive'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المميزين' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(MEZO.."MEZO:Distinguished:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ لا يوجد مميزين في البوت *","md",true)  
end
ListMembers = '\n* ❍┃ قائمه المميزين في البوت ⇧⇩*\n⩹┉┉┉┉⊶❲𖥳 𝐒𝐀??𝐃𝐈 𖥳❳⊷┉┉┉┉⩺\n'
for k, v in pairs(Info_Members) do
local Jabwa = LuaTele.getUser(v)
if Jabwa and Jabwa.username and Jabwa.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..Jabwa.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '❍ مسح المميزين ❍', data = msg.sender.user_id..'/DelDistinguished'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المحظورين عام' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(MEZO.."MEZO:JabwaAll:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ لا يوجد محظورين عام في البوت *","md",true)  
end
ListMembers = '\n* ❍┃ قائمه المحظورين عام ⇧⇩*\n— — — — — — — — —\n'
for k, v in pairs(Info_Members) do
local Jabwa = LuaTele.getUser(v)
if Jabwa and Jabwa.username and Jabwa.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..Jabwa.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '❍ مسح المحظورين عام ❍', data = msg.sender.user_id..'/JabwaAll'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المكتومين عام' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(MEZO.."MEZO:ktmAll:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ لا يوجد مكتومين عام في البوت ","md",true)  
end
ListMembers = '\n* ❍┃ قائمه المكتومين عام ⇧⇩*\n— — — — — — — — —\n'
for k, v in pairs(Info_Members) do
local Jabwa = LuaTele.getUser(v)
if Jabwa and Jabwa.username and Jabwa.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..Jabwa.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '❍ مسح المكتومين عام ❍', data = msg.sender.user_id..'/ktmAll'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المحظورين' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(MEZO.."MEZO:JabwaGroup:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ لا يوجد محظورين في البوت *","md",true)  
end
ListMembers = '\n* ❍┃ قائمه المحظورين في البوت ⇧⇩*\n⩹┉┉┉┉⊶❲𖥳 𝐒𝐀?????? 𖥳❳⊷┉┉┉┉⩺\n'
for k, v in pairs(Info_Members) do
local Jabwa = LuaTele.getUser(v)
if Jabwa and Jabwa.username and Jabwa.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..Jabwa.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '❍ مسح المحظورين ❍', data = msg.sender.user_id..'/JabwaGroup'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المكتومين' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(MEZO.."MEZO:SilentGroup:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ لا يوجد مكتومين في البوت *","md",true)  
end
ListMembers = '\n* ❍┃ قائمه المكتومين في البوت ⇧⇩*\n— — — — — — — — —\n'
for k, v in pairs(Info_Members) do
local Jabwa = LuaTele.getUser(v)
if Jabwa and Jabwa.username and Jabwa.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..Jabwa.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '❍ مسح المكتومين ❍', data = msg.sender.user_id..'/SilentGroupGroup'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text and text:match("^تفعيل (.*)$") and msg.reply_to_message_id == 0 then
local TextMsg = text:match("^تفعيل (.*)$")
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if TextMsg == 'الرابط' then
Redis:set(MEZO.."MEZO:Status:Link"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم تفعيل الرابط *","md",true)
end
if TextMsg == 'الترحيب' then
Redis:set(MEZO.."MEZO:Status:Welcome"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم تفعيل الترحيب *","md",true)
end
if TextMsg == 'الايدي' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(6)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Status:Id"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم تفعيل الايدي *","md",true)
end
if TextMsg == 'الايدي بالصوره' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(6)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Status:IdPhoto"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم تفعيل الايدي بالصوره *","md",true)
end
if TextMsg == 'الردود المضافه' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(6)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Status:Reply"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم تفعيل الردود *","md",true)
end
if TextMsg == 'الردود العامه' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(6)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Status:ReplySudo"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم تفعيل الردود العامه *","md",true)
end
if TextMsg == 'الحظر' or TextMsg == 'الطرد' or TextMsg == 'التقييد' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(6)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Status:JabwaId"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم تفعيل الحظر , الطرد , التقييد*","md",true)
end
if TextMsg == 'الرفع' then
if not msg.Originators then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(5)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Status:SetId"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم تفعيل الرفع *","md",true)
end
if TextMsg == 'الالعاب' then
Redis:set(MEZO.."MEZO:Status:Games"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم تفعيل الالعاب *","md",true)
end
if TextMsg == 'التحقق' then
Redis:set(MEZO.."MEZO:Status:joinet"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم تفعيل التحقق *","md",true)
end
if TextMsg == 'اطردني' then
Redis:set(MEZO.."MEZO:Status:KickMe"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم تفعيل اطردني *","md",true)
end
if TextMsg == 'صورتي' then
Redis:set(MEZO.."Status:photo"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم تفعيل صورتي ","md",true)
end
if TextMsg == 'قول' then
Redis:set(MEZO.."Status:kool"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم تفعيل امر قول ","md",true)
end
if TextMsg == 'جمالي' then
Redis:set(MEZO.."Status:gamle"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم تفعيل جمالي ","md",true)
end
if TextMsg == 'ردود السورس' then
Redis:set(MEZO.."MEZO:Sasa:Jeka"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم تفعيل ردود السورس *","md",true)
end
if TextMsg == 'نزلني' then
Redis:set(MEZO.."MEZO:Status:remMe"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم تفعيل نزلني *","md",true)
end
if TextMsg == 'البوت الخدمي' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:BotFree",true) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم تفعيل البوت الخدمي *","md",true)
end
if TextMsg == 'التواصل' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:TwaslBot",true) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم تفعيل التواصل داخل البوت *","md",true)
end

end

if text and text:match("^(.*)$") then
if Redis:get(MEZO.."MEZO1:Set:Rd"..msg.sender.user_id..":"..msg.chat_id) == "true" then
Redis:set(MEZO.."MEZO1:Set:Rd"..msg.sender.user_id..":"..msg.chat_id, "true1")
Redis:set(MEZO.."MEZO1:Text:Sudo:Bot"..msg.sender.user_id..":"..msg.chat_id, text)
Redis:sadd(MEZO.."MEZO1:List:Rd:Sudo"..msg.chat_id, text)
return  LuaTele.sendText(msg_chat_id,msg_id, '\nارسل لي الكلمه الان ') 
end
end
if text and text:match("^(.*)$") then
if Redis:get(MEZO.."MEZO1:Set:On"..msg.sender.user_id..":"..msg.chat_id) == "true" then
Redis:del(MEZO..'MEZO1:Add:Rd:Sudo:Text'..text..msg.chat_id)
Redis:del(MEZO..'MEZO1:Add:Rd:Sudo:Text1'..text..msg.chat_id)
Redis:del(MEZO..'MEZO1:Add:Rd:Sudo:Text2'..text..msg.chat_id)
Redis:del(MEZO.."MEZO1:Set:On"..msg.sender.user_id..":"..msg.chat_id)
Redis:srem(MEZO.."MEZO1:List:Rd:Sudo"..msg.chat_id, text)
return  LuaTele.sendText(msg_chat_id,msg_id,"تم حذف الرد من ردود المتعدده")
end
end
if text == "مسح الردود المتعدده" or text == "مسح ردود المتعدده" or text ==  "مسح الردود المتعدد" or text == "مسح ردود متعدد" then     
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص⟦ '..Controller_Num(6)..' }* ',"md",true)  
end
local list = Redis:smembers(MEZO.."MEZO1:List:Rd:Sudo"..msg.chat_id)
for k,v in pairs(list) do  
Redis:del(MEZO.."MEZO1:Add:Rd:Sudo:Text"..v..msg.chat_id) 
Redis:del(MEZO.."MEZO1:Add:Rd:Sudo:Text1"..v..msg.chat_id) 
Redis:del(MEZO.."MEZO1:Add:Rd:Sudo:Text2"..v..msg.chat_id) 
Redis:del(MEZO.."MEZO1:List:Rd:Sudo"..msg.chat_id)
end
 LuaTele.sendText(msg_chat_id,msg_id,"تم حذف ردود المتعدده")
end
if text == "الردود المتعدده" or text == "ردود المتعدده" or text ==  "الردود المتعدد" or text == "ردود متعدد" then    
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص⟦ '..Controller_Num(6)..' }* ',"md",true)  
end
local list = Redis:smembers(MEZO.."MEZO1:List:Rd:Sudo"..msg.chat_id)
text = "\nقائمه الردود المتعدده ⇧⇩\n— — — — — — — — —\n"
for k,v in pairs(list) do
db = "رساله "
text = text..""..k.." -›⟦ "..v.." ⟧-›⟦ "..db.." ⟧\n"
end
if #list == 0 then
text = "لا توجد ردود متعدده"
end
 LuaTele.sendText(msg_chat_id,msg_id," "..text.." ")
end
if text == "اضف رد متعدد" or text == "ضع رد متعدد" then   
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص⟦ '..Controller_Num(6)..' ⟧* ',"md",true)  
end
Redis:set(MEZO.."MEZO1:Set:Rd"..msg.sender.user_id..":"..msg.chat_id,true)
return  LuaTele.sendText(msg_chat_id,msg_id,"ارسل الرد الذي اريد اضافته")
end
if text == "حذف ردم متعدد" or text == "مسح رد متعدد" then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص⟦ '..Controller_Num(6)..' ⟧* ',"md",true)  
end
Redis:set(MEZO.."MEZO1:Set:On"..msg.sender.user_id..":"..msg.chat_id,true)
return  LuaTele.sendText(msg_chat_id,msg_id,"ارسل الان الكلمه لحذفها ")
end
if text then  
local test = Redis:get(MEZO.."MEZO1:Text:Sudo:Bot"..msg.sender.user_id..":"..msg.chat_id)
if Redis:get(MEZO.."MEZO1:Set:Rd"..msg.sender.user_id..":"..msg.chat_id) == "true1" then
Redis:set(MEZO.."MEZO1:Set:Rd"..msg.sender.user_id..":"..msg.chat_id,'rd1')
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
Redis:set(MEZO.."MEZO1:Add:Rd:Sudo:Text"..test..msg.chat_id, text)  
end  
 LuaTele.sendText(msg_chat_id,msg_id,"تم حفظ الرد الاول ارسل الرد الثاني")
return false  
end  
end
if text then  
local test = Redis:get(MEZO.."MEZO1:Text:Sudo:Bot"..msg.sender.user_id..":"..msg.chat_id)
if Redis:get(MEZO.."MEZO1:Set:Rd"..msg.sender.user_id..":"..msg.chat_id) == "rd1" then
Redis:set(MEZO.."MEZO1:Set:Rd"..msg.sender.user_id..":"..msg.chat_id,'rd2')
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
Redis:set(MEZO.."MEZO1:Add:Rd:Sudo:Text1"..test..msg.chat_id, text)  
end  
 LuaTele.sendText(msg_chat_id,msg_id,"تم حفظ الرد الثاني ارسل الرد الثالث")
return false  
end  
end
if text then  
local test = Redis:get(MEZO.."MEZO1:Text:Sudo:Bot"..msg.sender.user_id..":"..msg.chat_id)
if Redis:get(MEZO.."MEZO1:Set:Rd"..msg.sender.user_id..":"..msg.chat_id) == "rd2" then
Redis:set(MEZO.."MEZO1:Set:Rd"..msg.sender.user_id..":"..msg.chat_id,'rd3')
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
Redis:set(MEZO.."MEZO1:Add:Rd:Sudo:Text2"..test..msg.chat_id, text)  
end  
 LuaTele.sendText(msg_chat_id,msg_id,"تم حفظ الرد")
return false  
end  
end
if text then
local Text = Redis:get(MEZO.."MEZO1:Add:Rd:Sudo:Text"..text..msg.chat_id)   
local Text1 = Redis:get(MEZO.."MEZO1:Add:Rd:Sudo:Text1"..text..msg.chat_id)   
local Text2 = Redis:get(MEZO.."MEZO1:Add:Rd:Sudo:Text2"..text..msg.chat_id)   
if Text or Text1 or Text2 then 
local texting = {
Text,
Text1,
Text2
}
Textes = math.random(#texting)
 LuaTele.sendText(msg_chat_id,msg_id,texting[Textes])
end
end
if text and text:match("^(.*)$") then
if Redis:get(MEZO.."MEZO11:Set:Rd"..msg.sender.user_id..":"..msg.chat_id) == "true" then
 LuaTele.sendText(msg_chat_id,msg_id, '\nارسل لي الكلمه الان ')
Redis:set(MEZO.."MEZO11:Set:Rd"..msg.sender.user_id..":"..msg.chat_id, "true1")
Redis:set(MEZO.."MEZO11:Text:Sudo:Bot"..msg.sender.user_id..":"..msg.chat_id, text)
Redis:sadd(MEZO.."MEZO11:List:Rd:Sudo", text)
return false end
end
if text and text:match("^(.*)$") then
if Redis:get(MEZO.."MEZO11:Set:On"..msg.sender.user_id..":"..msg.chat_id) == "true" then
 LuaTele.sendText(msg_chat_id,msg_id,"تم حذف الرد من ردود المتعدده")
Redis:del(MEZO..'MEZO11:Add:Rd:Sudo:Text'..text)
Redis:del(MEZO..'MEZO11:Add:Rd:Sudo:Text1'..text)
Redis:del(MEZO..'MEZO11:Add:Rd:Sudo:Text2'..text)
Redis:del(MEZO.."MEZO11:Set:On"..msg.sender.user_id..":"..msg.chat_id)
Redis:srem(MEZO.."MEZO11:List:Rd:Sudo", text)
return false
end
end
if text == "مسح الردود المتعدده عام" or text == "مسح ردود المتعدده عام" or text ==  "مسح الردود المتعدد عام" or text == "مسح ردود متعدد عام" then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
local list = Redis:smembers(MEZO.."MEZO11:List:Rd:Sudo")
for k,v in pairs(list) do  
Redis:del(MEZO.."MEZO11:Add:Rd:Sudo:Text"..v) 
Redis:del(MEZO.."MEZO11:Add:Rd:Sudo:Text1"..v) 
Redis:del(MEZO.."MEZO11:Add:Rd:Sudo:Text2"..v)   
Redis:del(MEZO.."MEZO11:List:Rd:Sudo")
end
 LuaTele.sendText(msg_chat_id,msg_id,"تم حذف ردود المتعدده")
end
if text == "الردود المتعدده عام" or text == "ردود المتعدده عام" or text ==  "الردود المتعدد عام" or text == "ردود متعدد عام" then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
local list = Redis:smembers(MEZO.."MEZO11:List:Rd:Sudo")
text = "\nقائمه الردود المتعدده عام ⇧⇩\n— — — — — — — — —\n"
for k,v in pairs(list) do
db = "رساله "
text = text..""..k.." -›⟦ "..v.." ⟧-›⟦ "..db.." ⟧\n"
end
if #list == 0 then
text = "لا توجد ردود متعدده عام"
end
 LuaTele.sendText(msg_chat_id,msg_id," "..text.." ")
end
if text == "اضف رد متعدد عام" or text == "وضع رد متعدد عام" then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
Redis:set(MEZO.."MEZO11:Set:Rd"..msg.sender.user_id..":"..msg.chat_id,true)
return  LuaTele.sendText(msg_chat_id,msg_id,"ارسل الرد الذي اريد اضافته")
end
if text == "حذف رد متعدد عام" or text == "حذف رد متعدد عام" then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
Redis:set(MEZO.."MEZO11:Set:On"..msg.sender.user_id..":"..msg.chat_id,true)
return  LuaTele.sendText(msg_chat_id,msg_id,"ارسل الان الكلمه لحذفها ")
end
if text then  
local test = Redis:get(MEZO.."MEZO11:Text:Sudo:Bot"..msg.sender.user_id..":"..msg.chat_id)
if Redis:get(MEZO.."MEZO11:Set:Rd"..msg.sender.user_id..":"..msg.chat_id) == "true1" then
Redis:set(MEZO.."MEZO11:Set:Rd"..msg.sender.user_id..":"..msg.chat_id,'rd1')
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
Redis:set(MEZO.."MEZO11:Add:Rd:Sudo:Text"..test, text)  
end  
 LuaTele.sendText(msg_chat_id,msg_id,"تم حفظ الرد الاول ارسل الرد الثاني")
return false  
end  
end
if text then  
local test = Redis:get(MEZO.."MEZO11:Text:Sudo:Bot"..msg.sender.user_id..":"..msg.chat_id)
if Redis:get(MEZO.."MEZO11:Set:Rd"..msg.sender.user_id..":"..msg.chat_id) == "rd1" then
Redis:set(MEZO.."MEZO11:Set:Rd"..msg.sender.user_id..":"..msg.chat_id,'rd2')
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
Redis:set(MEZO.."MEZO11:Add:Rd:Sudo:Text1"..test, text)  
end  
 LuaTele.sendText(msg_chat_id,msg_id,"تم حفظ الرد الثاني ارسل الرد الثالث")
return false  
end  
end
if text then  
local test = Redis:get(MEZO.."MEZO11:Text:Sudo:Bot"..msg.sender.user_id..":"..msg.chat_id)
if Redis:get(MEZO.."MEZO11:Set:Rd"..msg.sender.user_id..":"..msg.chat_id) == "rd2" then
Redis:set(MEZO.."MEZO11:Set:Rd"..msg.sender.user_id..":"..msg.chat_id,'rd3')
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
Redis:set(MEZO.."MEZO11:Add:Rd:Sudo:Text2"..test, text)  
end  
 LuaTele.sendText(msg_chat_id,msg_id,"تم حفظ الرد")
return false  
end  
end
if text then
local Text = Redis:get(MEZO.."MEZO11:Add:Rd:Sudo:Text"..text)   
local Text1 = Redis:get(MEZO.."MEZO11:Add:Rd:Sudo:Text1"..text)   
local Text2 = Redis:get(MEZO.."MEZO11:Add:Rd:Sudo:Text2"..text)   
if Text or Text1 or Text2 then 
local texting = {
Text,
Text1,
Text2
}
Textes = math.random(#texting)
 LuaTele.sendText(msg_chat_id,msg_id,texting[Textes])
end
end
 
if msg.content.video_note or msg.content.document or msg.content.audio or msg.content.video or msg.content.voice_note or msg.content.sticker or msg.content.animation or msg.content.photo then      
Redis:sadd(MEZO.."MEZO:allM"..msg.chat_id, msg.id)
if Redis:get(MEZO.."MEZO:Status:Del:Media"..msg.chat_id) then    
local gmedia = Redis:scard(MEZO.."MEZO:allM"..msg.chat_id)  
if gmedia >= 200 then
local liste = Redis:smembers(MEZO.."MEZO:allM"..msg.chat_id)
for k,v in pairs(liste) do
local Mesge = v
if Mesge then
t = " ❍┃ تم مسح "..k.." من الوسائط تلقائيا\n ❍┃ يمكنك تعطيل الميزه بستخدام الامر ( `تعطيل المسح التلقائي` )"
LuaTele.deleteMessages(msg.chat_id,{[1]= Mesge})
end
end
LuaTele.sendText(msg_chat_id,msg_id, t)
Redis:del(MEZO.."MEZO:allM"..msg.chat_id)
end
end
end

if text == "مسح الميديا" then  
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(4)..' ⟧* ',"md",true)  
end
local list = Redis:smembers(MEZO.."MEZO:allM"..msg.chat_id)
for k,v in pairs(list) do
local Message = v
if Message then
t = " ❍┃ تم مسح "..k.." من الوسائط الموجوده"
LuaTele.deleteMessages(msg.chat_id,{[1]= Message})
Redis:del(MEZO.."MEZO:allM"..msg.chat_id)
end
end
if #list == 0 then
t = " ❍┃ لا يوجد ميديا في المجموعه"
end
 LuaTele.sendText(msg_chat_id,msg_id, t)
end
if text == "عدد الميديا" then  
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(4)..' ⟧* ',"md",true)  
end
local gmria = Redis:scard(MEZO.."MEZO:allM"..msg.chat_id)  
 LuaTele.sendText(msg_chat_id,msg_id,"❍┃ عدد الميديا الموجود هو⟦* "..gmria.." *⟧","md")
end
if text == "زخرفه" or text == "زخرف"  then
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*𖥔 عذرآ البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '🖌️ زخرفه ',  data ='/leftz@'},
},
}
}
return LuaTele.sendText(msg.chat_id,msg.id,'*\nاليك القوائم الزخرف  اضفط وزخرف*',"md",false, false, false, false, reply_markup)
end
if text == "تعطيل المسح التلقائي" then        
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(4)..' ⟧* ',"md",true)  
end
Redis:del(MEZO.."MEZO:Status:Del:Media"..msg.chat_id)
 LuaTele.sendText(msg_chat_id,msg_id,' ❍┃ تم تعطيل المسح التلقائي للميديا')
return false
end 
if text == "تفعيل المسح التلقائي" then        
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(4)..' ⟧* ',"md",true)  
end
Redis:set(MEZO.."MEZO:Status:Del:Media"..msg.chat_id,true)
LuaTele.sendText(msg_chat_id,msg_id,' ❍┃ تم تفعيل المسح التلقائي للميديا')
return false
end 
if text == "تعطيل اليوتيوب" then        
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(6)..' ⟧* ',"md",true)  
end
Redis:del(MEZO.."MEZO:Status:yt"..msg.chat_id)
 LuaTele.sendText(msg_chat_id,msg_id,' ❍┃ تم تعطيل المسح اليوتيوب')
return false
end 
if text == "تفعيل اليوتيوب" then        
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(6)..' ⟧* ',"md",true)  
end
Redis:set(MEZO.."MEZO:Status:yt"..msg.chat_id,true)
LuaTele.sendText(msg_chat_id,msg_id,' ❍┃ تم تفعيل اليوتيوب')
return false
end 
if text and text:match('^بحث (.*)$') then
local search = text:match('^بحث (.*)$')
https.request("https://core1.tk/apies/youtube/script.php?token="..Token.."&chat="..msg_chat_id.."&text="..URL.escape(search))
end

if text == "يوتيوب" then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'تحميل صوت', data = msg.sender.user_id..'/mp3'..msg_id}, {text = 'تحميل فيديو', data = msg.sender.user_id..'/mp4'..msg_id}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id, [[*
◍ اختر كيف تريد التحميل
*]],"md",false, false, false, false, reply_markup)
end

---زخرفة ----
if Redis:get(TheMEZO.."zhrfa"..msg.sender.user_id) == "sendzh" then
zh = https.request('https://apiabs.ml/zrf.php?abs='..URL.escape(text)..'')
zx = JSON.decode(zh)
t = "\n* ✧ قائمه الزخرفه ⇧⇩*\n*⩹┉┉┉┉⊶❲𖥳 𝙏𝙃𝙊𝙍 𓅔 𖥳❳⊷┉┉┉┉⩺*\n* أضغط علي الاسم لا يتم النسخ ✧ *\n"
i = 0
for k,v in pairs(zx.ok) do
i = i + 1
t = t..i.."- "..v.." \n"
end
LuaTele.sendText(msg_chat_id,msg_id,t,"md",true) 
Redis:del(TheMEZO.."zhrfa"..msg.sender.user_id) 
end
if text == "زخرفه" or text == "زخرفة" then
LuaTele.sendText(msg_chat_id,msg_id,"* ✧ ارسل الكلمه لزخرفتها عربي او انجلش*","md",true) 
Redis:set(TheMEZO.."zhrfa"..msg.sender.user_id,"sendzh") 
end
if text and text:match("^زخرفه (.*)$") then
local TextZhrfa = text:match("^زخرفه (.*)$")
zh = https.request('https://apiabs.ml/zrf.php?abs='..URL.escape(TextZhrfa)..'')
zx = JSON.decode(zh)
t = "\n* ✧ قائمه الزخرفه ⇧⇩*\n*⩹┉┉┉┉⊶❲𖥳𝙏𝙃𝙊𝙍 𓅔 𖥳❳⊷┉┉┉┉⩺*\n* أضغط علي الاسم لا يتم النسخ ✧ *\n"
i = 0
for k,v in pairs(zx.ok) do
i = i + 1
t = t..i.."- "..v.." \n"
end
LuaTele.sendText(msg_chat_id,msg_id,t,"md",true) 
end


if text and text:match("^تعطيل (.*)$") and msg.reply_to_message_id == 0 then
local TextMsg = text:match("^تعطيل (.*)$")
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if TextMsg == 'الرابط' then
Redis:del(MEZO.."MEZO:Status:Link"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم تعطيل الرابط *","md",true)
end
if TextMsg == 'الترحيب' then
Redis:del(MEZO.."MEZO:Status:Welcome"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم تعطيل الترحيب *","md",true)
end
if TextMsg == 'الايدي' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(6)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(MEZO.."MEZO:Status:Id"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم تعطيل الايدي *","md",true)
end
if TextMsg == 'الايدي بالصوره' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(6)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(MEZO.."MEZO:Status:IdPhoto"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم تعطيل الايدي بالصوره *","md",true)
end
if TextMsg == 'الردود المضافه' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(6)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(MEZO.."MEZO:Status:Reply"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم تعطيل الردود *","md",true)
end
if TextMsg == 'الردود العامه' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(6)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(MEZO.."MEZO:Status:ReplySudo"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم تعطيل الردود العامه *","md",true)
end
if TextMsg == 'الحظر' or TextMsg == 'الطرد' or TextMsg == 'التقييد' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(6)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(MEZO.."MEZO:Status:JabwaId"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم تعطيل الحظر , الطرد , التقييد*","md",true)
end
if TextMsg == 'الرفع' then
if not msg.Originators then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(5)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(MEZO.."MEZO:Status:SetId"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم تعطيل الرفع *","md",true)
end
if TextMsg == 'الالعاب' then
Redis:del(MEZO.."MEZO:Status:Games"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم تعطيل الالعاب *","md",true)
end
if TextMsg == 'التحقق' then
Redis:del(MEZO.."MEZO:Status:joinet"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم تعطيل التحقق *","md",true)
end
if TextMsg == 'اطردني' then
Redis:del(MEZO.."MEZO:Status:KickMe"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم تعطيل اطردني *","md",true)
end
if TextMsg == 'صورتي' then
Redis:del(MEZO.."Status:photo"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم تعطيل صورتي ","md",true)
end
if TextMsg == 'قول' then
Redis:del(MEZO.."Status:kool"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم تعطيل امر قول ","md",true)
end
if TextMsg == 'جمالي' then
Redis:del(MEZO.."Status:gamle"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم تعطيل جمالي ","md",true)
end
if TextMsg == 'ردود السورس' then
Redis:del(MEZO.."MEZO:Sasa:Jeka"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم تعطيل ردود السورس *","md",true)
end
if TextMsg == 'نزلني' then
Redis:del(MEZO.."MEZO:Status:remMe"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم تعطيل نزلني *","md",true)
end
if TextMsg == 'البوت الخدمي' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(MEZO.."MEZO:BotFree") 
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم تعطيل البوت الخدمي *","md",true)
end
if TextMsg == 'التواصل' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(MEZO.."MEZO:TwaslBot") 
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم تعطيل التواصل داخل البوت *","md",true)
end

end

if text and text:match('^حظر عام @(%S+)$') then
local UserName = text:match('^حظر عام @(%S+)$')
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(2)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام معرف البوت ","md",true)  
end
if Controller(msg_chat_id,UserId_Info.id) == 'المطور الاساسي' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا لا تستطيع حظر عام⟦ "..Controller(msg_chat_id,UserId_Info.id).." ⟧*","md",true)  
end
if Controller(msg_chat_id,UserId_Info.id) == 'المطور الثانوي' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا لا تستطيع حظر عام⟦ "..Controller(msg_chat_id,UserId_Info.id).." ⟧*","md",true)  
end
if Controller(msg_chat_id,UserId_Info.id) == 'DEV • BARLO' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا لا تستطيع حظر عام⟦ "..Controller(msg_chat_id,UserId_Info.id).." ⟧*","md",true)  
end
if Controller(msg_chat_id,UserId_Info.id) == 'بارلو باشا' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا لا تستطيع حظر عام⟦ "..Controller(msg_chat_id,UserId_Info.id).." ⟧*","md",true)  
end
if Controller(msg_chat_id,UserId_Info.id) == 'DEV • CRISTIN' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا لا تستطيع حظر عام⟦ "..Controller(msg_chat_id,UserId_Info.id).." ⟧*","md",true)  
end
if Controller(msg_chat_id,UserId_Info.id) == 'كومندا' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا لا تستطيع حظر عام⟦ "..Controller(msg_chat_id,UserId_Info.id).." ⟧*","md",true)  
end
if Controller(msg_chat_id,UserId_Info.id) == 'جوو' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا لا تستطيع حظر عام⟦ "..Controller(msg_chat_id,UserId_Info.id).." ⟧*","md",true)  
end
if Redis:sismember(MEZO.."MEZO:JabwaAll:Groups",UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ❍┃ تم حظره عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:sadd(MEZO.."MEZO:JabwaAll:Groups",UserId_Info.id) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'Jabwaned',0)
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"* ❍┃ تم حظره عام من المجموعات *").Reply,"md",true)  
end
end
if text and text:match('^الغاء العام @(%S+)$') then
local UserName = text:match('^الغاء العام @(%S+)$')
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(2)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام معرف البوت ","md",true)  
end
if not Redis:sismember(MEZO.."MEZO:JabwaAll:Groups",UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ❍┃ تم الغاء حظره عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:srem(MEZO.."MEZO:JabwaAll:Groups",UserId_Info.id) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,1,1,1,1,1,1,1,1})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ❍┃ تم الغاء حظره عام من المجموعات  ").Reply,"md",true)  
end
end
if text and text:match('^كتم عام @(%S+)$') then
local UserName = text:match('^كتم عام @(%S+)$')
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(2)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام معرف البوت ","md",true)  
end
if Controller(msg_chat_id,UserId_Info.id) == 'المطور الاساسي' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا لا تستطيع كتم عام⟦ "..Controller(msg_chat_id,UserId_Info.id).." ⟧*","md",true)  
end
if Controller(msg_chat_id,UserId_Info.id) == 'المطور الثانوي' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا لا تستطيع كتم عام⟦ "..Controller(msg_chat_id,UserId_Info.id).." ⟧*","md",true)  
end
if Controller(msg_chat_id,UserId_Info.id) == 'DEV • BARLO' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا لا تستطيع كتم عام⟦ "..Controller(msg_chat_id,UserId_Info.id).." ⟧*","md",true)  
end
if Controller(msg_chat_id,UserId_Info.id) == 'بارلو باشا' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا لا تستطيع كتم عام⟦ "..Controller(msg_chat_id,UserId_Info.id).." ⟧*","md",true)  
end
if Controller(msg_chat_id,UserId_Info.id) == 'DEV • CRISTIN' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا لا تستطيع كتم عام⟦ "..Controller(msg_chat_id,UserId_Info.id).." ⟧*","md",true)  
end
if Controller(msg_chat_id,UserId_Info.id) == 'جوو' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا لا تستطيع كتم عام⟦ "..Controller(msg_chat_id,UserId_Info.id).." ⟧*","md",true)  
end
if Controller(msg_chat_id,UserId_Info.id) == 'كومندا' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا لا تستطيع كتم عام⟦ "..Controller(msg_chat_id,UserId_Info.id).." ⟧*","md",true)  
end
if Redis:sismember(MEZO.."MEZO:ktmAll:Groups",UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ❍┃ تم كتمه عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:sadd(MEZO.."MEZO:ktmAll:Groups",UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ❍┃ تم كتمه عام من المجموعات ").Reply,"md",true)  
end
end
if text and text:match('^الغاء كتم عام @(%S+)$') then
local UserName = text:match('^الغاء كتم عام @(%S+)$')
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(2)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام معرف البوت ","md",true)  
end
if not Redis:sismember(MEZO.."MEZO:ktmAll:Groups",UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ❍┃ تم الغاء كتمه عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:srem(MEZO.."MEZO:ktmAll:Groups",UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ❍┃ تم الغاء كتمه عام من المجموعات  ").Reply,"md",true)  
end
end
if text and text:match('^طرد @(%S+)$') then
local UserName = text:match('^طرد @(%S+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/uu_MEZO'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرآ البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).JabwaUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Originators and not Redis:get(MEZO.."MEZO:Status:JabwaId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرآ لا تستطيع استخدام معرف قناة او جروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId_Info.id).." } *","md",true)  
end
if Redis:sismember(MEZO.."MEZO:JabwaGroup:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ❍┃ تم طرده من المجموعه مسبقا ").Reply,"md",true)  
else
Redis:sadd(MEZO.."MEZO:JabwaGroup:Group"..msg_chat_id,UserId_Info.id) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'Jabwaned',0)
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ❍┃ تم طرده من المجموعه ").Reply,"md",true)  
end
end
if text and text:match('^الغاء الطرد @(%S+)$') then
local UserName = text:match('^الغاء الطرد @(%S+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/uu_MEZO'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرآ البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).JabwaUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرآ لا تستطيع استخدام معرف قناة او جروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if not Redis:sismember(MEZO.."MEZO:JabwaGroup:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ❍┃ تم الغاء طرده من المجموعه مسبقا ").Reply,"md",true)  
else
Redis:srem(MEZO.."MEZO:JabwaGroup:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ❍┃ تم الغاء طرده من المجموعه  ").Reply,"md",true)  
end
end
if text and text:match('^حظر @(%S+)$') then
local UserName = text:match('^حظر @(%S+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).JabwaUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Originators and not Redis:get(MEZO.."MEZO:Status:JabwaId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم تعطيل ⟦الحظر : الطرد : التقييد⟧ من قبل المدراء","md",true)
end 
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام معرف البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا لا تستطيع حظر⟦ "..Controller(msg_chat_id,UserId_Info.id).." ⟧*","md",true)  
end
if Redis:sismember(MEZO.."MEZO:JabwaGroup:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ❍┃ تم حظره من المجموعه مسبقا ").Reply,"md",true)  
else
Redis:sadd(MEZO.."MEZO:JabwaGroup:Group"..msg_chat_id,UserId_Info.id) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'Jabwaned',0)
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ❍┃ تم حظره من المجموعه ").Reply,"md",true)  
end
end
if text and text:match('^الغاء حظر @(%S+)$') then
local UserName = text:match('^الغاء حظر @(%S+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).JabwaUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام معرف البوت ","md",true)  
end
if not Redis:sismember(MEZO.."MEZO:JabwaGroup:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ❍┃ تم الغاء حظره من المجموعه مسبقا ").Reply,"md",true)  
else
Redis:srem(MEZO.."MEZO:JabwaGroup:Group"..msg_chat_id,UserId_Info.id) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,1,1,1,1,1,1,1,1})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ❍┃ تم الغاء حظره من المجموعه  ").Reply,"md",true)  
end
end

if text and text:match('^كتم @(%S+)$') then
local UserName = text:match('^كتم @(%S+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if GetInfoBot(msg).Delmsg == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ البوت ليس لديه صلاحيه حذف الرسائل* ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام معرف البوت ","md",true)  
end
if StatusSilent(msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا لا تستطيع كتم⟦ "..Controller(msg_chat_id,UserId_Info.id).." ⟧*","md",true)  
end
if Redis:sismember(MEZO.."MEZO:SilentGroup:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ❍┃ تم كتمه في المجموعه مسبقا ").Reply,"md",true)  
else
Redis:sadd(MEZO.."MEZO:SilentGroup:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ❍┃ تم كتمه في المجموعه  ").Reply,"md",true)  
end
end
if text and text:match('^الغاء كتم @(%S+)$') then
local UserName = text:match('^الغاء كتم @(%S+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام معرف البوت ","md",true)  
end
if not Redis:sismember(MEZO.."MEZO:SilentGroup:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ❍┃ تم الغاء كتمه من المجموعه ").Reply,"md",true)  
else
Redis:srem(MEZO.."MEZO:SilentGroup:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ❍┃ تم الغاء كتمه من المجموعه ").Reply,"md",true)  
end
end
if text and text:match('^تقييد (%d+) (.*) @(%S+)$') then
local UserName = {text:match('^تقييد (%d+) (.*) @(%S+)$') }
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).JabwaUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Originators and not Redis:get(MEZO.."MEZO:Status:JabwaId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم تعطيل ⟦الحظر : الطرد : التقييد⟧ من قبل المدراء","md",true)
end 
local UserId_Info = LuaTele.searchPublicChat(UserName[3])
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName[3] and UserName[3]:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام معرف البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا لا تستطيع تقييد⟦ "..Controller(msg_chat_id,UserId_Info.id).." ⟧*","md",true)  
end
if UserName[2] == 'يوم' then
Time_Restrict = UserName[1]:match('(%d+)')
Time = Time_Restrict * 86400
end
if UserName[2] == 'ساعه' then
Time_Restrict = UserName[1]:match('(%d+)')
Time = Time_Restrict * 3600
end
if UserName[2] == 'دقيقه' then
Time_Restrict = UserName[1]:match('(%d+)')
Time = Time_Restrict * 60
end
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,0,0,0,0,0,0,0,0,tonumber(msg.date+Time)})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ❍┃ تم تقييده في المجموعه \n ❍┃ لمدة : "..UserName[1]..' '..UserName[2]).Reply,"md",true)  
end

if text and text:match('^تقييد (%d+) (.*)$') and msg.reply_to_message_id ~= 0 then
local TimeKed = {text:match('^تقييد (%d+) (.*)$') }
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).JabwaUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Originators and not Redis:get(MEZO.."MEZO:Status:JabwaId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم تعطيل ⟦الحظر : الطرد : التقييد⟧ من قبل المدراء","md",true)
end 
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local Jabwa = LuaTele.getUser(Message_Reply.sender.user_id)
if Jabwa.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if Jabwa and Jabwa.type and Jabwa.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام الامر على البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا لا تستطيع تقييد⟦"..Controller(msg_chat_id,Message_Reply.sender.user_id).." ⟧*","md",true)  
end
if TimeKed[2] == 'يوم' then
Time_Restrict = TimeKed[1]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TimeKed[2] == 'ساعه' then
Time_Restrict = TimeKed[1]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TimeKed[2] == 'دقيقه' then
Time_Restrict = TimeKed[1]:match('(%d+)')
Time = Time_Restrict * 60
end
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0,tonumber(msg.date+Time)})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ❍┃ تم تقييده في المجموعه \n ❍┃ لمدة : "..TimeKed[1]..' '..TimeKed[2]).Reply,"md",true)  
end

if text and text:match('^تقييد (%d+) (.*) (%d+)$') then
local UserId = {text:match('^تقييد (%d+) (.*) (%d+)$') }
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).JabwaUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Originators and not Redis:get(MEZO.."MEZO:Status:JabwaId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم تعطيل ⟦الحظر : الطرد : التقييد⟧ من قبل المدراء","md",true)
end 
local Jabwa = LuaTele.getUser(UserId[3])
if Jabwa.luatele == "error" and Jabwa.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId[3]) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا لا تستطيع تقييد ⟦ "..Controller(msg_chat_id,UserId[3]).." ⟧*","md",true)  
end
if UserId[2] == 'يوم' then
Time_Restrict = UserId[1]:match('(%d+)')
Time = Time_Restrict * 86400
end
if UserId[2] == 'ساعه' then
Time_Restrict = UserId[1]:match('(%d+)')
Time = Time_Restrict * 3600
end
if UserId[2] == 'دقيقه' then
Time_Restrict = UserId[1]:match('(%d+)')
Time = Time_Restrict * 60
end
LuaTele.setChatMemberStatus(msg.chat_id,UserId[3],'restricted',{1,0,0,0,0,0,0,0,0,tonumber(msg.date+Time)})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[3],"\n ❍┃ تم تقييده في المجموعه \n ❍┃ لمدة : "..UserId[1]..' ' ..UserId[2]).Reply,"md",true)  
end
if text and text:match('^تقييد @(%S+)$') then
local UserName = text:match('^تقييد @(%S+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if not msg.Originators and not Redis:get(MEZO.."MEZO:Status:JabwaId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم تعطيل ⟦الحظر : الطرد : التقييد⟧ من قبل المدراء","md",true)
end 
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام معرف البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا لا تستطيع تقييد⟦ "..Controller(msg_chat_id,UserId_Info.id).." ⟧*","md",true)  
              end
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,0,0,0,0,0,0,0,0})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ❍┃ تم تقييده في المجموعه ").Reply,"md",true)  
end

if text and text:match('^الغاء التقييد @(%S+)$') then
local UserName = text:match('^الغاء التقييد @(%S+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).JabwaUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام معرف البوت ","md",true)  
end
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,1,1,1,1,1,1,1})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ❍┃ تم الغاء تقييده من المجموعه").Reply,"md",true)  
end

if text == ('حظر عام') and msg.reply_to_message_id ~= 0 then
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(2)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local Jabwa = LuaTele.getUser(Message_Reply.sender.user_id)
if Jabwa.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if Jabwa and Jabwa.type and Jabwa.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام الامر على البوت ","md",true)  
end
if Controller(msg_chat_id,Message_Reply.sender.user_id) == 'المطور الاساسي' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا لا تستطيع حظر عام⟦ "..Controller(msg_chat_id,Message_Reply.sender.user_id).." ⟧*","md",true)  
end
if Controller(msg_chat_id,Message_Reply.sender.user_id) == 'المطور الثانوي' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا لا تستطيع حظر عام⟦ "..Controller(msg_chat_id,Message_Reply.sender.user_id).." ⟧*","md",true)  
end
if Controller(msg_chat_id,Message_Reply.sender.user_id) == 'DEV • BARLO' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا لا تستطيع حظر عام⟦ "..Controller(msg_chat_id,Message_Reply.sender.user_id).." ⟧*","md",true)  
end
if Controller(msg_chat_id,Message_Reply.sender.user_id) == 'DEV • CRISTIN' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا لا تستطيع حظر عام⟦ "..Controller(msg_chat_id,Message_Reply.sender.user_id).." ⟧*","md",true)  
end
if Controller(msg_chat_id,Message_Reply.sender.user_id) == 'بارلو باشا' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا لا تستطيع حظر عام⟦ "..Controller(msg_chat_id,Message_Reply.sender.user_id).." ⟧*","md",true)  
end
if Controller(msg_chat_id,Message_Reply.sender.user_id) == 'جوو' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا لا تستطيع حظر عام⟦ "..Controller(msg_chat_id,Message_Reply.sender.user_id).." ⟧*","md",true)  
end
if Controller(msg_chat_id,Message_Reply.sender.user_id) == 'كومندا' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا لا تستطيع حظر عام⟦ "..Controller(msg_chat_id,Message_Reply.sender.user_id).." ⟧*","md",true)  
end
if Redis:sismember(MEZO.."MEZO:JabwaAll:Groups",Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ❍┃ تم حظره عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:sadd(MEZO.."MEZO:JabwaAll:Groups",Message_Reply.sender.user_id) 
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'Jabwaned',0)
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ❍┃ تم حظره عام من المجموعات ").Reply,"md",true)  
end
end
if text == ('الغاء العام') and msg.reply_to_message_id ~= 0 then
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(2)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local Jabwa = LuaTele.getUser(Message_Reply.sender.user_id)
if Jabwa.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if Jabwa and Jabwa.type and Jabwa.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام الامر على البوت ","md",true)  
end
if not Redis:sismember(MEZO.."MEZO:JabwaAll:Groups",Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ❍┃ تم الغاء حظره عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:srem(MEZO.."MEZO:JabwaAll:Groups",Message_Reply.sender.user_id) 
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'restricted',{1,1,1,1,1,1,1,1,1})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ❍┃ تم الغاء حظره عام من المجموعات  ").Reply,"md",true)  
end
end
if text == ('كتم عام') and msg.reply_to_message_id ~= 0 then
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(2)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local Jabwa = LuaTele.getUser(Message_Reply.sender.user_id)
if Jabwa.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if Jabwa and Jabwa.type and Jabwa.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام الامر على البوت ","md",true)  
end
if Controller(msg_chat_id,Message_Reply.sender.user_id) == 'المطور الاساسي' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا لا تستطيع كتم عام⟦ "..Controller(msg_chat_id,Message_Reply.sender.user_id).." ⟧*","md",true)  
end
if Controller(msg_chat_id,Message_Reply.sender.user_id) == 'المطور الثانوي' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا لا تستطيع كتم عام⟦ "..Controller(msg_chat_id,Message_Reply.sender.user_id).." ⟧*","md",true)  
end
if Controller(msg_chat_id,Message_Reply.sender.user_id) == 'DEV • BARLO' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا لا تستطيع كتم عام⟦ "..Controller(msg_chat_id,Message_Reply.sender.user_id).." ⟧*","md",true)  
end
if Controller(msg_chat_id,Message_Reply.sender.user_id) == 'بارلو باشا' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا لا تستطيع كتم عام⟦ "..Controller(msg_chat_id,Message_Reply.sender.user_id).." ⟧*","md",true)  
end
if Controller(msg_chat_id,Message_Reply.sender.user_id) == 'DEV • CRISTIN' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا لا تستطيع كتم عام⟦ "..Controller(msg_chat_id,Message_Reply.sender.user_id).." ⟧*","md",true)  
end
if Controller(msg_chat_id,Message_Reply.sender.user_id) == 'كومندا' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا لا تستطيع كتم عام⟦ "..Controller(msg_chat_id,Message_Reply.sender.user_id).." ⟧*","md",true)  
end
if Controller(msg_chat_id,Message_Reply.sender.user_id) == 'جوو' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا لا تستطيع كتم عام⟦ "..Controller(msg_chat_id,Message_Reply.sender.user_id).." ⟧*","md",true)  
end
if Redis:sismember(MEZO.."MEZO:ktmAll:Groups",Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ❍┃ تم كتمه عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:sadd(MEZO.."MEZO:ktmAll:Groups",Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ❍┃ تم كتمه عام من المجموعات ").Reply,"md",true)  
end
end
if text == ('الغاء كتم عام') and msg.reply_to_message_id ~= 0 then
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(2)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local Jabwa = LuaTele.getUser(Message_Reply.sender.user_id)
if Jabwa.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if Jabwa and Jabwa.type and Jabwa.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام الامر على البوت ","md",true)  
end
if not Redis:sismember(MEZO.."MEZO:ktmAll:Groups",Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ❍┃ تم الغاء كتمه عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:srem(MEZO.."MEZO:ktmAll:Groups",Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ❍┃ تم الغاء كتمه عام من المجموعات  ").Reply,"md",true)  
end
end
if text == ('حظر') and msg.reply_to_message_id ~= 0 then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).JabwaUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Originators and not Redis:get(MEZO.."MEZO:Status:JabwaId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم تعطيل ⟦الحظر : الطرد : التقييد⟧ من قبل المدراء","md",true)
end 
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local Jabwa = LuaTele.getUser(Message_Reply.sender.user_id)
if Jabwa.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if Jabwa and Jabwa.type and Jabwa.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام الامر على البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا لا تستطيع حظر⟦ "..Controller(msg_chat_id,Message_Reply.sender.user_id).." ⟧*","md",true)  
end
if Redis:sismember(MEZO.."MEZO:JabwaGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ❍┃ تم حظره من المجموعه مسبقا ").Reply,"md",true)  
else
Redis:sadd(MEZO.."MEZO:JabwaGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) 
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'Jabwaned',0)
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ❍┃ تم حظره من المجموعه ").Reply,"md",true)  
end
end
if text == ('الغاء حظر') and msg.reply_to_message_id ~= 0 then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local Jabwa = LuaTele.getUser(Message_Reply.sender.user_id)
if Jabwa.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if Jabwa and Jabwa.type and Jabwa.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام الامر على البوت ","md",true)  
end
if not Redis:sismember(MEZO.."MEZO:JabwaGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ❍┃ تم الغاء حظره من المجموعه مسبقا ").Reply,"md",true)  
else
Redis:srem(MEZO.."MEZO:JabwaGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) 
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'restricted',{1,1,1,1,1,1,1,1,1})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ❍┃ تم الغاء حظره من المجموعه  ").Reply,"md",true)  
end
end

if text == ('كتم') or text == ('اخرص') and msg.reply_to_message_id ~= 0 then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if GetInfoBot(msg).Delmsg == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ البوت ليس لديه صلاحيه حذف الرسائل* ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local Jabwa = LuaTele.getUser(Message_Reply.sender.user_id)
if Jabwa.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if Jabwa and Jabwa.type and Jabwa.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام الامر على البوت ","md",true)  
end
if StatusSilent(msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا لا تستطيع كتم⟦ "..Controller(msg_chat_id,Message_Reply.sender.user_id).." ⟧*","md",true)  
end
if Redis:sismember(MEZO.."MEZO:SilentGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ❍┃ تم كتمه في المجموعه مسبقا ").Reply,"md",true)  
else
Redis:sadd(MEZO.."MEZO:SilentGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ❍┃ تم كتمه في المجموعه  ").Reply,"md",true)  
end
end
if text == ('الغاء كتم') and msg.reply_to_message_id ~= 0 then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local Jabwa = LuaTele.getUser(Message_Reply.sender.user_id)
if Jabwa.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if Jabwa and Jabwa.type and Jabwa.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام الامر على البوت ","md",true)  
end
if not Redis:sismember(MEZO.."MEZO:SilentGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ❍┃ تم الغاء كتمه من المجموعه ").Reply,"md",true)  
else
Redis:srem(MEZO.."MEZO:SilentGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ❍┃ تم الغاء كتمه من المجموعه ").Reply,"md",true)  
end
end

if text == ('تقييد') and msg.reply_to_message_id ~= 0 then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).JabwaUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Originators and not Redis:get(MEZO.."MEZO:Status:JabwaId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم تعطيل ⟦الحظر : الطرد : التقييد⟧ من قبل المدراء","md",true)
end 
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local Jabwa = LuaTele.getUser(Message_Reply.sender.user_id)
if Jabwa.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if Jabwa and Jabwa.type and Jabwa.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام الامر على البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا لا تستطيع تقييد⟦"..Controller(msg_chat_id,Message_Reply.sender.user_id).." ⟧*","md",true)  
end
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ❍┃ تم تقييده في المجموعه ").Reply,"md",true)  
end

if text == ('الغاء التقييد') and msg.reply_to_message_id ~= 0 then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).JabwaUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local Jabwa = LuaTele.getUser(Message_Reply.sender.user_id)
if Jabwa.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if Jabwa and Jabwa.type and Jabwa.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام الامر على البوت ","md",true)  
end
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'restricted',{1,1,1,1,1,1,1,1})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ❍┃ تم الغاء تقييده من المجموعه").Reply,"md",true)  
end

if text == ('طرد') and msg.reply_to_message_id ~= 0 then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/AKJA0'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Originators and not Redis:get(MEZO.."MEZO:Status:BanId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام الامر على البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا لا تستطيع طرد⟦ "..Controller(msg_chat_id,Message_Reply.sender.user_id).." ⟧*","md",true)  
end
if Redis:sismember(MEZO.."MEZO:MosTafa:Ahmed"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ❍┃ تم طرد من المجموعه مسبقا ").Reply,"md",true)  
else
Redis:sadd(MEZO.."MEZO:MosTafa:Ahmed"..msg_chat_id,Message_Reply.sender.user_id) 
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'banned',0)
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"* ❍┃ تم طرده من المجموعه *").Reply,"md",true)  
end
end

if text == ('الغاء طرد') and msg.reply_to_message_id ~= 0 then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/AKJA0'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام الامر على البوت ","md",true)  
end
if not Redis:sismember(MEZO.."MEZO:MosTafa:Ahmed"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ❍┃ تم الغاء طردن من المجموعه مسبقا ").Reply,"md",true)  
else
Redis:srem(MEZO.."MEZO:MosTafa:Ahmed"..msg_chat_id,Message_Reply.sender.user_id) 
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'restricted',{1,1,1,1,1,1,1,1,1})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ❍┃ تم الغاء طرده من المجموعه  ").Reply,"md",true)  
end
end

if text and text:match('^حظر عام (%d+)$') then
local UserId = text:match('^حظر عام (%d+)$')
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(2)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Jabwa = LuaTele.getUser(UserId)
if Jabwa.luatele == "error" and Jabwa.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام ايدي خطأ ","md",true)  
end 
if Controller(msg_chat_id,UserId) == 'المطور الاساسي' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا لا تستطيع حظر عام⟦ "..Controller(msg_chat_id,UserId).." ⟧*","md",true)  
end
if Controller(msg_chat_id,UserId) == 'المطور الثانوي' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا لا تستطيع حظر عام⟦ "..Controller(msg_chat_id,UserId).." ⟧*","md",true)  
end
if Controller(msg_chat_id,UserId) == 'DEV • BARLO' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا لا تستطيع حظر عام⟦ "..Controller(msg_chat_id,UserId).." ⟧*","md",true)  
end
if Controller(msg_chat_id,UserId) == 'بارلو باشا' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا لا تستطيع حظر عام⟦ "..Controller(msg_chat_id,UserId).." ⟧*","md",true)  
end
if Controller(msg_chat_id,UserId) == 'DEV • CRISTIN' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا لا تستطيع حظر عام⟦ "..Controller(msg_chat_id,UserId).." ⟧*","md",true)  
end
if Controller(msg_chat_id,UserId) == 'جوو' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا لا تستطيع حظر عام⟦ "..Controller(msg_chat_id,UserId).." ⟧*","md",true)  
end
if Controller(msg_chat_id,UserId) == 'كومندا' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا لا تستطيع حظر عام⟦ "..Controller(msg_chat_id,UserId).." ⟧*","md",true)  
end
if Redis:sismember(MEZO.."MEZO:JabwaAll:Groups",UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId," ❍┃ تم حظره عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:sadd(MEZO.."MEZO:JabwaAll:Groups",UserId) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId,'Jabwaned',0)
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId," ❍┃ تم حظره عام من المجموعات ").Reply,"md",true)  
end
end
if text and text:match('^الغاء العام (%d+)$') then
local UserId = text:match('^الغاء العام (%d+)$')
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(2)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Jabwa = LuaTele.getUser(UserId)
if Jabwa.luatele == "error" and Jabwa.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if not Redis:sismember(MEZO.."MEZO:JabwaAll:Groups",UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId," ❍┃ تم الغاء حظره عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:srem(MEZO.."MEZO:JabwaAll:Groups",UserId) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId,'restricted',{1,1,1,1,1,1,1,1,1})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId," ❍┃ تم الغاء حظره عام من المجموعات  ").Reply,"md",true)  
end
end
if text and text:match('^كتم عام (%d+)$') then
local UserId = text:match('^كتم عام (%d+)$')
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(2)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Jabwa = LuaTele.getUser(UserId)
if Jabwa.luatele == "error" and Jabwa.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام ايدي خطأ ","md",true)  
end 
if Controller(msg_chat_id,UserId) == 'المطور الاساسي' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا لا تستطيع كتم  عام⟦ "..Controller(msg_chat_id,UserId).." ⟧*","md",true)  
end
if Controller(msg_chat_id,UserId) == 'المطور الثانوي' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا لا تستطيع كتم  عام⟦ "..Controller(msg_chat_id,UserId).." ⟧*","md",true)  
end
if Controller(msg_chat_id,UserId) == 'DEV • BARLO' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا لا تستطيع كتم عام⟦ "..Controller(msg_chat_id,UserId).." ⟧*","md",true)  
end
if Controller(msg_chat_id,UserId) == 'بارلو باشا' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*  ❍┃ عذرا لا تستطيع كتم عام⟦ "..Controller(msg_chat_id,UserId).." ⟧*","md",true)  
end
if Controller(msg_chat_id,UserId) == 'DEV • CRISTIN' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*  ❍┃ عذرا لا تستطيع كتم عام⟦ "..Controller(msg_chat_id,UserId).." ⟧*","md",true)  
end
if Controller(msg_chat_id,UserId) == 'جوو' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*  ❍┃ عذرا لا تستطيع كتم عام⟦ "..Controller(msg_chat_id,UserId).." ⟧*","md",true)  
end
if Controller(msg_chat_id,UserId) == 'كومندا' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*  ❍┃ عذرا لا تستطيع كتم عام⟦ "..Controller(msg_chat_id,UserId).." ⟧*","md",true)  
end
if Redis:sismember(MEZO.."MEZO:ktmAll:Groups",UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId," ❍┃ تم كتمه عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:sadd(MEZO.."MEZO:ktmAll:Groups",UserId) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId," ❍┃ تم كتمه عام من المجموعات ").Reply,"md",true)  
end
end
if text and text:match('^الغاء كتم عام (%d+)$') then
local UserId = text:match('^الغاء كتم عام (%d+)$')
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(2)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Jabwa = LuaTele.getUser(UserId)
if Jabwa.luatele == "error" and Jabwa.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if not Redis:sismember(MEZO.."MEZO:ktmAll:Groups",UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId," ❍┃ تم الغاء كتمه عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:srem(MEZO.."MEZO:ktmAll:Groups",UserId) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId," ❍┃ تم الغاء كتمه عام من المجموعات  ").Reply,"md",true)  
end
end
if text and text:match('^حظر (%d+)$') then
local UserId = text:match('^حظر (%d+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).JabwaUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Originators and not Redis:get(MEZO.."MEZO:Status:JabwaId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم تعطيل ⟦الحظر : الطرد : التقييد⟧ من قبل المدراء","md",true)
end 
local Jabwa = LuaTele.getUser(UserId)
if Jabwa.luatele == "error" and Jabwa.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*  ❍┃ عذرا لا تستطيع حظر⟦ "..Controller(msg_chat_id,UserId).." ⟧*","md",true)  
end
if Redis:sismember(MEZO.."MEZO:JabwaGroup:Group"..msg_chat_id,UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId," ❍┃ تم حظره من المجموعه مسبقا ").Reply,"md",true)  
else
Redis:sadd(MEZO.."MEZO:JabwaGroup:Group"..msg_chat_id,UserId) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId,'Jabwaned',0)
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId," ❍┃ تم حظره من المجموعه ").Reply,"md",true)  
end
end
if text and text:match('^الغاء حظر (%d+)$') then
local UserId = text:match('^الغاء حظر (%d+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).JabwaUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
local Jabwa = LuaTele.getUser(UserId)
if Jabwa.luatele == "error" and Jabwa.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if not Redis:sismember(MEZO.."MEZO:JabwaGroup:Group"..msg_chat_id,UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId," ❍┃ تم الغاء حظره من المجموعه مسبقا ").Reply,"md",true)  
else
Redis:srem(MEZO.."MEZO:JabwaGroup:Group"..msg_chat_id,UserId) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId,'restricted',{1,1,1,1,1,1,1,1,1})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId," ❍┃ تم الغاء حظره من المجموعه  ").Reply,"md",true)  
end
end
if text and text:match('^طرد (%d+)$') then
local UserId = text:match('^طرد (%d+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/uu_MEZO'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرآ البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).JabwaUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Originators and not Redis:get(MEZO.."MEZO:Status:JabwaId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local Jabwa = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId).." } *","md",true)  
end
if Redis:sismember(MEZO.."MEZO:JabwaGroup:Group"..msg_chat_id,UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId," ❍┃ تم طرده من المجموعه مسبقا ").Reply,"md",true)  
else
Redis:sadd(MEZO.."MEZO:JabwaGroup:Group"..msg_chat_id,UserId) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId,'Jabwaned',0)
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId," ❍┃ تم طرده من المجموعه ").Reply,"md",true)  
end
end
if text and text:match('^الغاء الطرد (%d+)$') then
local UserId = text:match('^الغاء الطرد (%d+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/uu_MEZO'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرآ البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).JabwaUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
local Jabwa = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if not Redis:sismember(MEZO.."MEZO:JabwaGroup:Group"..msg_chat_id,UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId," ❍┃ تم الغاء طرده من المجموعه مسبقا ").Reply,"md",true)  
else
Redis:srem(MEZO.."MEZO:JabwaGroup:Group"..msg_chat_id,UserId) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId,'restricted',{1,1,1,1,1,1,1,1,1})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId," ❍┃ تم الغاء طرده من المجموعه  ").Reply,"md",true)  
end
end
if text and text:match('^كتم (%d+)$') then
local UserId = text:match('^كتم (%d+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if GetInfoBot(msg).Delmsg == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ البوت ليس لديه صلاحيه حذف الرسائل* ',"md",true)  
end
local Jabwa = LuaTele.getUser(UserId)
if Jabwa.luatele == "error" and Jabwa.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if StatusSilent(msg_chat_id,UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*  ❍┃ عذرا لا تستطيع كتم⟦ "..Controller(msg_chat_id,UserId).." ⟧*","md",true)  
end
if Redis:sismember(MEZO.."MEZO:SilentGroup:Group"..msg_chat_id,UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId," ❍┃ تم كتمه في المجموعه مسبقا ").Reply,"md",true)  
else
Redis:sadd(MEZO.."MEZO:SilentGroup:Group"..msg_chat_id,UserId) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId," ❍┃ تم كتمه في المجموعه  ").Reply,"md",true)  
end
end
if text and text:match('^الغاء كتم (%d+)$') then
local UserId = text:match('^الغاء كتم (%d+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Jabwa = LuaTele.getUser(UserId)
if Jabwa.luatele == "error" and Jabwa.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if not Redis:sismember(MEZO.."MEZO:SilentGroup:Group"..msg_chat_id,UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId," ❍┃ تم الغاء كتمه من المجموعه ").Reply,"md",true)  
else
Redis:srem(MEZO.."MEZO:SilentGroup:Group"..msg_chat_id,UserId) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId," ❍┃ تم الغاء كتمه من المجموعه ").Reply,"md",true)  
end
end

if text and text:match('^تقييد (%d+)$') then
local UserId = text:match('^تقييد (%d+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).JabwaUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Originators and not Redis:get(MEZO.."MEZO:Status:JabwaId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم تعطيل ⟦الحظر : الطرد : التقييد⟧ من قبل المدراء","md",true)
end 
local Jabwa = LuaTele.getUser(UserId)
if Jabwa.luatele == "error" and Jabwa.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*  ❍┃ عذرا لا تستطيع تقييد⟦ "..Controller(msg_chat_id,UserId).." ⟧*","md",true)  
end
LuaTele.setChatMemberStatus(msg.chat_id,UserId,'restricted',{1,0,0,0,0,0,0,0,0})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId," ❍┃ تم تقييده في المجموعه ").Reply,"md",true)  
end

if text and text:match('^الغاء التقييد (%d+)$') then
local UserId = text:match('^الغاء التقييد (%d+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).JabwaUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
local Jabwa = LuaTele.getUser(UserId)
if Jabwa.luatele == "error" and Jabwa.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام ايدي خطأ ","md",true)  
end
LuaTele.setChatMemberStatus(msg.chat_id,UserId,'restricted',{1,1,1,1,1,1,1,1})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId," ❍┃ تم الغاء تقييده من المجموعه").Reply,"md",true)  
end

if text == "نزلني" then
if not Redis:get(MEZO.."MEZO:Status:remMe"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ امر نزلني تم تعطيله من قبل المدراء *","md",true)  
end
if The_ControllerAll(msg.sender.user_id) == true then
Rink = 1
elseif Redis:sismember(MEZO.."MEZO:HELPBEVQ:Groups",msg.sender.user_id)  then
Rink = 1
elseif Redis:sismember(MEZO.."MEZO:DevelopersQ:Groups",msg.sender.user_id)  then
Rink = 2
elseif Redis:sismember(MEZO.."MEZO:Developers:Groups",msg.sender.user_id)  then
Rink = 3
elseif Redis:sismember(MEZO.."MEZO:TheBasicsQ:Group"..msg_chat_id, msg.sender.user_id) then
Rink = 4
elseif Redis:sismember(MEZO.."MEZO:TheBasics:Group"..msg_chat_id, msg.sender.user_id) then
Rink = 5
elseif Redis:sismember(MEZO.."MEZO:Originators:Group"..msg_chat_id, msg.sender.user_id) then
Rink = 6
elseif Redis:sismember(MEZO.."MEZO:Managers:Group"..msg_chat_id, msg.sender.user_id) then
Rink = 7
elseif Redis:sismember(MEZO.."MEZO:Addictive:Group"..msg_chat_id, msg.sender.user_id) then
Rink = 8
elseif Redis:sismember(MEZO.."MEZO:Distinguished:Group"..msg_chat_id, msg.sender.user_id) then
Rink = 9
else
Rink = 10
end
if Rink == 10 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ ليس لديك رتب عزيزي *","md",true)  
end
if Rink <= 7  then
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ استطيع تنزيل الادمنيه والمميزين فقط","md",true) 
else
Redis:srem(MEZO.."MEZO:Addictive:Group"..msg_chat_id, msg.sender.user_id)
Redis:srem(MEZO.."MEZO:Distinguished:Group"..msg_chat_id, msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم تنزيلك من الادمنيه والمميزين ","md",true) 
end
end

if text == "اطردني" or text == "طلعني" or text == "خرجني" then 
if not Redis:get(MEZO.."MEZO:Status:KickMe"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ امر اطردني تم تعطيله من قبل المدراء *","md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرآ البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).JabwaUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if StatusCanOrNotCan(msg_chat_id,msg.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا لا تستطيع استخدام الامر على⟦ "..Controller(msg_chat_id,msg.sender.user_id).." ⟧ *","md",true)  
end
local StatusMember = LuaTele.getChatMember(msg_chat_id,msg.sender.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
KickMe = true
elseif (StatusMember == "chatMemberStatusAdministrator") then
KickMe = true
else
KickMe = false
end
if KickMe == true then
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ عذرا لا استطيع طرد ادمنيه ومنشئين المجموعه*","md",true)    
end
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'Jabwaned',0)
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ❍┃ ").Reply,"md",true)  
end
if text == 'ادمنيه الكروب' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(6)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Administrators", "*", 0, 200)
listAdmin = '\n* ❍┃ قائمه الادمنيه \n— — — — — — — — —*\n'
local List_Members = Info_Members.members
for k, v in pairs(List_Members) do
if Info_Members.members[k].status.luatele == "chatMemberStatusCreator" then
Creator = '→ *{ المالك }*'
else
Creator = ""
end
local Jabwa = LuaTele.getUser(v.member_id.user_id)
if Jabwa.username ~= "" then
listAdmin = listAdmin.."*"..k.." - @cristin_so"..Creator.."\n"
else
listAdmin = listAdmin.."*"..k.." - *["..Jabwa.id.."](tg://user?id="..Jabwa.id..") "..Creator.."\n"
end
end
LuaTele.sendText(msg_chat_id,msg_id,listAdmin,"md",true)  
end

if text == 'رفع الادمنيه' or text == 'ترقيه الادمنيه' or text == 'رفع المالك' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(6)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Administrators", "*", 0, 200)
local List_Members = Info_Members.members
x = 0
y = 0
for k, v in pairs(List_Members) do
if Info_Members.members[k].bot_info == nil then
if Info_Members.members[k].status.luatele == "chatMemberStatusCreator" then
Redis:sadd(MEZO.."MEZO:TheBasics:Group"..msg_chat_id,v.member_id.user_id) 
x = x + 1
else
Redis:sadd(MEZO.."MEZO:Addictive:Group"..msg_chat_id,v.member_id.user_id) 
y = y + 1
end
end
end
LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ تم ترقيه - ('..y..') ادمنيه *',"md",true)  
end

if text == 'المالك' or text == 'المنشئ' then
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*✘︙ عذرآ البوت ليس ادمن في  الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/'..Redis:get(MEZO ..'Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n✘︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Administrators", "*", 0, 200)
local List_Members = Info_Members.members
for k, v in pairs(List_Members) do
if Info_Members.members[k].status.luatele == "chatMemberStatusCreator" then
local  ban = LuaTele.getUser(v.member_id.user_id)
if  ban.first_name == "" then
LuaTele.sendText(msg_chat_id,msg_id,"*✘︙ اوبس , المالك حسابه محذوف *","md",true)  
return false
end 
local photo = LuaTele.getUserProfilePhotos( ban.id)
local  bain = LuaTele.getUserFullInfo(Sudo_Id)
if  bain.bio then
Bio =  bain.bio
else
Bio = 'لا يوجد'
end
if ban.username then
Creator = "* "..ban.first_name.."*\n"
else
Creator = "* ["..ban.first_name.."](tg://user?id="..ban.id..")*\n"
end
if ban.first_name then
Creat = " "..ban.first_name.." "
else
Creat = " Developers Bot \n"
end
if photo.total_count > 0 then
local TestText = "  ‹[ Owner Groups ]›\n— — — — — — — — —\n ✘︙*Owner Name* :  [".. ban.first_name.."](tg://user?id=".. ban.id..")\n✘︙ *Owner Bio* : [‹[ "..Bio.." ]›]"
keyboardd = {} 
keyboardd.inline_keyboard = {
{
{text = Creat, url = "https://t.me/"..ban.username..""},
},
}
local msg_id = msg.id/2097152/0.5 
return https.request("https://api.telegram.org/bot"..Token..'/sendPhoto?chat_id='..msg.chat_id..'&caption='..URL.escape(TestText)..'&photo='..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id..'&reply_to_message_id='..msg_id..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboardd))
else
local TestText = "- معلومات المالك : \n\n- [".. ban.first_name.."](tg://user?id=".. ban.id..")\n \n ["..Bio.."]"
local msg_id = msg.id/2097152/0.5 
return https.request("https://api.telegram.org/bot"..Token..'/sendMessage?chat_id=' .. msg.chat_id .. '&text=' .. URL.escape(TestText).."&reply_to_message_id="..msg_id.."&parse_mode=markdown")
end
end
end
end
if text == 'المطور' or text == 'مطور البوت' then   
local  ban = LuaTele.getUser(Sudo_Id) 
local  bain = LuaTele.getUserFullInfo(Sudo_Id)
local Get_Chat = LuaTele.getChat(msg_chat_id)
local Info_Chats = LuaTele.getSupergroupFullInfo(msg_chat_id)
local bains = LuaTele.getUser(msg.sender.user_id)
if  bain.bio then
Bio =  bain.bio
else
Bio = 'لا يوجد'
end
if bains.first_name then
klajq = '*['..bains.first_name..'](tg://user?id='..bains.id..')*'
else
klajq = 'لا يوجد'
end
if bains.username then
basgk = ' '..bains.username..' '
else
basgk = 'لا يوجد'
end
if ban.username then
Creator = "* "..ban.first_name.."*\n"
else
Creator = "* ["..ban.first_name.."](tg://user?id="..ban.id..")*\n"
end
if ban.first_name then
Creat = " "..ban.first_name.." "
else
Creat = " Developers Bot \n"
end
local photo = LuaTele.getUserProfilePhotos(Sudo_Id)
if photo.total_count > 0 then
local TestText = "  ❲ Developers Bot ❳\n— — — — — — — — —\n 𖥔*Dev Name* :  [".. ban.first_name.."](tg://user?id="..Sudo_Id..")\n𖥔 *Dev Bio* : ["..Bio.." ]\n"
keyboardd = {} 
keyboardd.inline_keyboard = {
{
{text = Creat, url = "https://t.me/"..ban.username..""},
},
}
local msg_id = msg.id/2097152/0.5 
 https.request("https://api.telegram.org/bot"..Token..'/sendPhoto?chat_id='..msg.chat_id..'&caption='..URL.escape(TestText)..'&photo='..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id..'&reply_to_message_id='..msg_id..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboardd))
else
local TestText = "  ❲ Developers MEZO  ❳\n— — — — — — — — —\n 𖥔*Dev Name* :  [".. ban.first_name.."](tg://user?id="..Sudo_Id..")\n𖥔 *Dev Bio* : [❲ "..Bio.." ❳]"
local msg_id = msg.id/2097152/0.5 
 https.request("https://api.telegram.org/bot"..Token..'/sendMessage?chat_id=' .. msg.chat_id .. '&text=' .. URL.escape(TestText).."&reply_to_message_id="..msg_id.."&parse_mode=markdown")
end
end

if text == 'كشف البوتات' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(6)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Bots", "*", 0, 200)
local List_Members = Info_Members.members
listBots = '\n* ❍┃ قائمه البوتات \n— — — — — — — — —*\n'
x = 0
for k, v in pairs(List_Members) do
local Jabwa = LuaTele.getUser(v.member_id.user_id)
if Info_Members.members[k].status.luatele == "chatMemberStatusAdministrator" then
x = x + 1
Admin = '→ *{ ادمن }*'
else
Admin = ""
end
listBots = listBots.."*"..k.." - @"..Jabwa.username.."* "..Admin.."\n"
end
LuaTele.sendText(msg_chat_id,msg_id,listBots.."*\n⩹┉┉┉┉⊶❲𖥳 ??𝐀𝐈𝐃𝐈 𖥳❳⊷┉┉┉┉⩺\n ❍┃ عدد البوتات التي هي ادمن ⟦ "..x.." )*","md",true)  
end
if text == 'طرد البوتات' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(6)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).JabwaUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Bots", "*", 0, 200)
local List_Members = Info_Members.members
x = 0
for k, v in pairs(List_Members) do
local Jabwa_Bots = LuaTele.setChatMemberStatus(msg.chat_id,v.member_id.user_id,'Jabwaned',0)
if Jabwa_Bots.luatele == "ok" then
x = x + 1
end
end
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عدد البوتات الموجوده : "..#List_Members.."\n* ❍┃ عدد البوتات الموجوده : "..#List_Members.."\n ❍┃ تم طرد ⟦ "..x.." ⟧بوت من المجموعه *","md",true)  
end

 
if text == 'المقيدين' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(6)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Recent", "*", 0, 200)
local List_Members = Info_Members.members
x = 0
y = nil
restricted = '\n* ❍┃ قائمه المقيديين \n— — — — — — — — —*\n'
for k, v in pairs(List_Members) do
if Info_Members.members[k].status.is_member == true and Info_Members.members[k].status.luatele == "chatMemberStatusRestricted" then
y = true
x = x + 1
local Jabwa = LuaTele.getUser(v.member_id.user_id)
if Jabwa.username ~= "" then
restricted = restricted.."*"..x.." - @"..Jabwa.username.."*\n"
else
restricted = restricted.."*"..x.." - *["..Jabwa.id.."](tg://user?id="..Jabwa.id..") \n"
end
end
end
if y == true then
LuaTele.sendText(msg_chat_id,msg_id,restricted,"md",true)  
end
end

if msg.content.photo then
if msg.content.caption.text and msg.content.caption.text:match("^all (.*)$") then
local ttag = msg.content.caption.text:match("^all (.*)$") 
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
local Info_Members = LuaTele.searchChatMembers(msg_chat_id, "*", 500)
x = 0 
tags = 0 
local list = Info_Members.members
for k, v in pairs(list) do 
local data = LuaTele.getUser(v.member_id.user_id)
if x == 10 or x == tags or k == 0 then 
tags = x + 10 
if ttag then
t = "#all "..ttag.."" 
else
t = "#all "
end
end 
x = x + 1 
tagname = data.first_name
tagname = tagname:gsub("]","") 
tagname = tagname:gsub("[[]","") 
t = t..", ["..tagname.."](tg://user?id="..v.member_id.user_id..")" 
if x == 10 or x == tags or k == 0 then 
if ttag then
Text = t:gsub('#all '..ttag..',','#all '..ttag..'\n') 
else 
Text = t:gsub('#all,','#all\n')
end
LuaTele.sendPhoto(msg.chat_id, 0, idPhoto,Text,"md")
end 
end 
end
end
if text == "تاك للكل" or text == "all" or text == "@all" or text == "All" then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
local Info_Members = LuaTele.searchChatMembers(msg_chat_id, "*", 500)
x = 0
tags = 0
local list = Info_Members.members
for k, v in pairs(list) do
local UserInfo = LuaTele.getUser(v.member_id.user_id)
if x == 10 or x == tags or k == 0 then
tags = x + 10
listall = ""
end
x = x + 1
if UserInfo.first_name ~= '' then
listall = listall.." ["..UserInfo.first_name.."](tg://user?id="..UserInfo.id.."),"
end
if x == 10 or x == tags or k == 0 then
LuaTele.sendText(msg_chat_id,msg_id,listall,"md",true)  
end
end
end
if text == "تاك للزوجات" or text == "الزوجات" then
local zwgat_list = Redis:smembers(MEZO..msg_chat_id.."zwgat:")
if #zwgat_list == 0 then 
return LuaTele.sendText(msg_chat_id,msg_id,'* ❍┃ لايوجد زوجات*',"md",true) 
end 
local zwga_list = "* ❍┃ قائمة الزوجات *"..#zwgat_list.."\n*— — — — — — — — —*\n"
for k, v in pairs(zwgat_list) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
zwga_list = zwga_list.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
zwga_list = zwga_list.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
return LuaTele.sendText(msg_chat_id,msg_id,zwga_list,"md",true) 
end
if text == "تاك للمتوحدين" or text == "المتوحدين" then
local lonely_list = Redis:smembers(MEZO..msg_chat_id.."lonely:")
if #lonely_list == 0 then 
return LuaTele.sendText(msg_chat_id,msg_id,'* ❍┃ لايوجد متوحدين *',"md",true) 
end 
local lone_list = "* ❍┃ قائمة متوحدين الجروب *"..#lonely_list.."\n*— — — — — — — — —*\n"
for k, v in pairs(lonely_list) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
lone_list = lone_list.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
lone_list = lone_list.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
return LuaTele.sendText(msg_chat_id,msg_id,lone_list,"md",true) 
end
if text == "تاك للمطلقات" or text == "المطلقات" then
local mutlqat_list = Redis:smembers(MEZO..msg_chat_id.."mutlqat:")
if #mutlqat_list == 0 then 
return LuaTele.sendText(msg_chat_id,msg_id,'* ❍┃ لايوجد مطلقات*',"md",true) 
end 
local mutlqa_list = "* ❍┃ قائمة المطلقات *"..#mutlqat_list.."\n*— — — — — — — — —*\n"
for k, v in pairs(mutlqat_list) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
mutlqa_list = mutlqa_list.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
mutlqa_list = mutlqa_list.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
return LuaTele.sendText(msg_chat_id,msg_id,mutlqa_list,"md",true) 
end
if text == "تاك للكلاب" or text == "الكلاب" then
local klbklb_list = Redis:smembers(MEZO..msg_chat_id.."klbklb:")
if #klbklb_list == 0 then 
return LuaTele.sendText(msg_chat_id,msg_id,'* ❍┃ لايوجد الكلاب *',"md",true) 
end 
local klbk_list = "* ❍┃ قائمة الكلاب الجروب *"..#klbklb_list.."\n*— — — — — — — — —*\n"
for k, v in pairs(klbklb_list) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
klbk_list = klbk_list.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
klbk_list = klbk_list.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
return LuaTele.sendText(msg_chat_id,msg_id,klbk_list,"md",true) 
end

if text == "القناه المضافه" then
return LuaTele.sendText(msg_chat_id,msg_id,Redis:get(MEZO.."chadmin"..msg_chat_id),"md",true)  
end
if text == "اضف قناه" then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
Redis:set(MEZO.."addchannel"..msg.sender.user_id,"on") 
LuaTele.sendText(msg_chat_id,msg_id," ❍┃  ارسل ايدي القناه","md",true)  
end
if text == "قفل القناه" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(MEZO.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."Lock:channell"..msg_chat_id,true) 
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل القنوات").Lock,"md",true)  
return false
end 
if text == "قفل الدردشه" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:text"..msg_chat_id,true) 
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل الدردشه").Lock,"md",true)  
return false
end 
if text == "قفل الاضافه" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:set(MEZO.."MEZO:Lock:AddMempar"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل اضافة الاعضاء").Lock,"md",true)  
return false
end 
if text == "قفل الدخول" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:set(MEZO.."MEZO:Lock:Join"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل دخول الاعضاء").Lock,"md",true)  
return false
end 
if text == "قفل البوتات" then 
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:set(MEZO.."MEZO:Lock:Bot:kick"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل البوتات").Lock,"md",true)  
return false
end 
if text == "قفل البوتات بالطرد" then 
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:set(MEZO.."MEZO:Lock:Bot:kick"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل البوتات").lockKick,"md",true)  
return false
end 
if text == "قفل الاشعارات" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end  
Redis:set(MEZO.."MEZO:Lock:tagservr"..msg_chat_id,true)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل الاشعارات").Lock,"md",true)  
return false
end 
if text == "تعطيل all" or text == "تعطيل @all" then 
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص⟦ '..Controller_Num(6)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(MEZO.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end  
Redis:set(MEZO.."lockalllll"..msg_chat_id,"off")
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل @all هنا").Lock,"md",true)  
return false
end 
if text == "تفعيل all" or text == "تفعيل @all" then 
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص⟦ '..Controller_Num(6)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(MEZO.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end  
Redis:set(MEZO.."lockalllll"..msg_chat_id,"on")
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم فتح @all هنا").Lock,"md",true)  
return false
end 
if text == "قفل التثبيت" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end  
Redis:set(MEZO.."MEZO:lockpin"..msg_chat_id,(LuaTele.getChatPinnedMessage(msg_chat_id).id or true)) 
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل التثبيت هنا").Lock,"md",true)  
return false
end 
if text == "قفل التعديل" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:set(MEZO.."MEZO:Lock:edit"..msg_chat_id,true) 
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل تعديل").Lock,"md",true)  
return false
end 
if text == "قفل تعديل الميديا" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:set(MEZO.."MEZO:Lock:edit"..msg_chat_id,true) 
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل تعديل").Lock,"md",true)  
return false
end 
if text == "قفل الكل" then 
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end  
Redis:set(MEZO.."MEZO:Lock:tagservrbot"..msg_chat_id,true)   
list ={"Lock:Bot:kick","Lock:User:Name","Lock:hashtak","Lock:Cmd","Lock:Link","Lock:forward","Lock:Keyboard","Lock:geam","Lock:Photo","Lock:Animation","Lock:Video","Lock:Audio","Lock:vico","Lock:Sticker","Lock:Document","Lock:Unsupported","Lock:Markdaun","Lock:Contact","Lock:Spam"}
for i,lock in pairs(list) do 
Redis:set(MEZO..'MEZO:'..lock..msg_chat_id,"del")    
end
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل جميع الاوامر").Lock,"md",true)  
return false
end 


--------------------------------------------------------------------------------------------------------------
if text == "فتح الاضافه" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:del(MEZO.."MEZO:Lock:AddMempar"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم فتح اضافة الاعضاء").unLock,"md",true)  
return false
end 
if text == "فتح القناه" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(MEZO.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:del(MEZO.."Lock:channell"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم فتح القنوات").unLock,"md",true)  
return false
end 
if text and text:match("^وضع تكرار (%d+)$") then 
local Num = text:match("وضع تكرار (.*)")
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
Redis:hset(MEZO.."Spam:Group:User"..msg_chat_id ,"Num:Spam" ,Num) 
LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃  تم وضع عدد تكرار '..Num..'* ',"md",true)  
end
if text == "فتح الدردشه" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:del(MEZO.."MEZO:Lock:text"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم فتح الدردشه").unLock,"md",true)  
return false
end 
if text == "فتح الدخول" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:del(MEZO.."MEZO:Lock:Join"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم فتح دخول الاعضاء").unLock,"md",true)  
return false
end 
if text == "فتح البوتات" then 
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:del(MEZO.."MEZO:Lock:Bot:kick"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم فـتح البوتات").unLock,"md",true)  
return false
end 
if text == "فتح البوتات " then 
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:del(MEZO.."MEZO:Lock:Bot:kick"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم فـتح البوتات").unLock,"md",true)  
return false
end 
if text == "فتح الاشعارات" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end  
Redis:del(MEZO.."MEZO:Lock:tagservr"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم فـتح الاشعارات").unLock,"md",true)  
return false
end 
if text == "فتح التثبيت" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:del(MEZO.."MEZO:lockpin"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم فـتح التثبيت هنا").unLock,"md",true)  
return false
end 
if text == "فتح التعديل" then 
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:del(MEZO.."MEZO:Lock:edit"..msg_chat_id) 
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم فـتح تعديل").unLock,"md",true)  
return false
end 
if text == "فتح التعديل الميديا" then 
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:del(MEZO.."MEZO:Lock:edit"..msg_chat_id) 
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم فـتح تعديل").unLock,"md",true)  
return false
end 
if text == "فتح الكل" then 
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:del(MEZO.."MEZO:Lock:tagservrbot"..msg_chat_id)   
list ={"Lock:Bot:kick","Lock:User:Name","Lock:hashtak","Lock:Cmd","Lock:Link","Lock:forward","Lock:Keyboard","Lock:geam","Lock:Photo","Lock:Animation","Lock:Video","Lock:Audio","Lock:vico","Lock:Sticker","Lock:Document","Lock:Unsupported","Lock:Markdaun","Lock:Contact","Lock:Spam"}
for i,lock in pairs(list) do 
Redis:del(MEZO..'MEZO:'..lock..msg_chat_id)    
end
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم فـتح جميع الاوامر").unLock,"md",true)  
return false
end 
--------------------------------------------------------------------------------------------------------------
if text == "قفل التكرار" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:hset(MEZO.."MEZO:Spam:Group:User"..msg_chat_id ,"Spam:User","del")  
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل التكرار").Lock,"md",true)  
elseif text == "قفل التكرار بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:hset(MEZO.."MEZO:Spam:Group:User"..msg_chat_id ,"Spam:User","keed")  
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل التكرار").lockKid,"md",true)  
elseif text == "قفل التكرار بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:hset(MEZO.."MEZO:Spam:Group:User"..msg_chat_id ,"Spam:User","mute")  
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل التكرار").lockKtm,"md",true)  
elseif text == "قفل التكرار بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:hset(MEZO.."MEZO:Spam:Group:User"..msg_chat_id ,"Spam:User","kick")  
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل التكرار").lockKick,"md",true)  
elseif text == "فتح التكرار" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:hdel(MEZO.."MEZO:Spam:Group:User"..msg_chat_id ,"Spam:User")  
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم فتح التكرار").unLock,"md",true)  
end
if text == "قفل الروابط" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:Link"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل الروابط").Lock,"md",true)  
return false
end 
if text == "قفل الروابط بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:Link"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل الروابط").lockKid,"md",true)  
return false
end 
if text == "قفل الروابط بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:Link"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل الروابط").lockKtm,"md",true)  
return false
end 
if text == "قفل الروابط بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:Link"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل الروابط").lockKick,"md",true)  
return false
end 
if text == "فتح الروابط" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(MEZO.."MEZO:Lock:Link"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم فتح الروابط").unLock,"md",true)  
return false
end 
if text == "قفل المعرفات" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:User:Name"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل المعرفات").Lock,"md",true)  
return false
end 
if text == "قفل المعرفات بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:User:Name"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل المعرفات").lockKid,"md",true)  
return false
end 
if text == "قفل المعرفات بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:User:Name"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل المعرفات").lockKtm,"md",true)  
return false
end 
if text == "قفل المعرفات بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:User:Name"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل المعرفات").lockKick,"md",true)  
return false
end 
if text == "فتح المعرفات" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(MEZO.."MEZO:Lock:User:Name"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم فتح المعرفات").unLock,"md",true)  
return false
end 
if text == "قفل التاك" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:hashtak"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل التاك").Lock,"md",true)  
return false
end 
if text == "قفل التاك بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:hashtak"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل التاك").lockKid,"md",true)  
return false
end 
if text == "قفل التاك بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:hashtak"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل التاك").lockKtm,"md",true)  
return false
end 
if text == "قفل التاك بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:hashtak"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل التاك").lockKick,"md",true)  
return false
end 
if text == "فتح التاك" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(MEZO.."MEZO:Lock:hashtak"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم فتح التاك").unLock,"md",true)  
return false
end 
if text == "قفل الشارحه" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:Cmd"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل الشارحه").Lock,"md",true)  
return false
end 
if text == "قفل الشارحه بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:Cmd"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل الشارحه").lockKid,"md",true)  
return false
end 
if text == "قفل الشارحه بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:Cmd"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل الشارحه").lockKtm,"md",true)  
return false
end 
if text == "قفل الشارحه بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:Cmd"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل الشارحه").lockKick,"md",true)  
return false
end 
if text == "فتح الشارحه" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(MEZO.."MEZO:Lock:Cmd"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم فتح الشارحه").unLock,"md",true)  
return false
end 
if text == "قفل الصور"then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:Photo"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل الصور").Lock,"md",true)  
return false
end 
if text == "قفل الصور بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:Photo"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل الصور").lockKid,"md",true)  
return false
end 
if text == "قفل الصور بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:Photo"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل الصور").lockKtm,"md",true)  
return false
end 
if text == "قفل الصور بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:Photo"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل الصور").lockKick,"md",true)  
return false
end 
if text == "فتح الصور" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(MEZO.."MEZO:Lock:Photo"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم فتح الصور").unLock,"md",true)  
return false
end 
if text == "قفل الفيديو" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:Video"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل الفيديو").Lock,"md",true)  
return false
end 
if text == "قفل الفيديو بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:Video"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل الفيديو").lockKid,"md",true)  
return false
end 
if text == "قفل الفيديو بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:Video"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل الفيديو").lockKtm,"md",true)  
return false
end 
if text == "قفل الفيديو بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:Video"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل الفيديو").lockKick,"md",true)  
return false
end 
if text == "فتح الفيديو" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(MEZO.."MEZO:Lock:Video"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم فتح الفيديو").unLock,"md",true)  
return false
end 
if text == "قفل المتحركه" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:Animation"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل المتحركه").Lock,"md",true)  
return false
end 
if text == "قفل المتحركه بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:Animation"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل المتحركه").lockKid,"md",true)  
return false
end 
if text == "قفل المتحركه بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:Animation"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل المتحركه").lockKtm,"md",true)  
return false
end 
if text == "قفل المتحركه بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:Animation"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل المتحركه").lockKick,"md",true)  
return false
end 
if text == "فتح المتحركه" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(MEZO.."MEZO:Lock:Animation"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم فتح المتحركه").unLock,"md",true)  
return false
end 
if text == "قفل الالعاب" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end 
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:geam"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل الالعاب").Lock,"md",true)  
return false
end 
if text == "قفل الالعاب بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:geam"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل الالعاب").lockKid,"md",true)  
return false
end 
if text == "قفل الالعاب بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:geam"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل الالعاب").lockKtm,"md",true)  
return false
end 
if text == "قفل الالعاب بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:geam"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل الالعاب").lockKick,"md",true)  
return false
end 
if text == "فتح الالعاب" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(MEZO.."MEZO:Lock:geam"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم فتح الالعاب").unLock,"md",true)  
return false
end 
if text == "قفل الاغاني" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:Audio"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل الاغاني").Lock,"md",true)  
return false
end 
if text == "قفل الاغاني بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:Audio"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل الاغاني").lockKid,"md",true)  
return false
end 
if text == "قفل الاغاني بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:Audio"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل الاغاني").lockKtm,"md",true)  
return false
end 
if text == "قفل الاغاني بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:Audio"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل الاغاني").lockKick,"md",true)  
return false
end 
if text == "فتح الاغاني" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(MEZO.."MEZO:Lock:Audio"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم فتح الاغاني").unLock,"md",true)  
return false
end 
if text == "قفل الصوت" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:vico"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل الصوت").Lock,"md",true)  
return false
end 
if text == "قفل الصوت بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:vico"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل الصوت").lockKid,"md",true)  
return false
end 
if text == "قفل الصوت بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:vico"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل الصوت").lockKtm,"md",true)  
return false
end 
if text == "قفل الصوت بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:vico"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل الصوت").lockKick,"md",true)  
return false
end 
if text == "فتح الصوت" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(MEZO.."MEZO:Lock:vico"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم فتح الصوت").unLock,"md",true)  
return false
end 
if text == "قفل الكيبورد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:Keyboard"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل الكيبورد").Lock,"md",true)  
return false
end 
if text == "قفل الكيبورد بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:Keyboard"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل الكيبورد").lockKid,"md",true)  
return false
end 
if text == "قفل الكيبورد بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:Keyboard"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل الكيبورد").lockKtm,"md",true)  
return false
end 
if text == "قفل الكيبورد بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:Keyboard"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل الكيبورد").lockKick,"md",true)  
return false
end 
if text == "فتح الكيبورد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(MEZO.."MEZO:Lock:Keyboard"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم فتح الكيبورد").unLock,"md",true)  
return false
end 
if text == "قفل الملصقات" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:Sticker"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل الملصقات").Lock,"md",true)  
return false
end 
if text == "قفل الملصقات بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:Sticker"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل الملصقات").lockKid,"md",true)  
return false
end 
if text == "قفل الملصقات بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:Sticker"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل الملصقات").lockKtm,"md",true)  
return false
end 
if text == "قفل الملصقات بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:Sticker"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل الملصقات").lockKick,"md",true)  
return false
end 
if text == "فتح الملصقات" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(MEZO.."MEZO:Lock:Sticker"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم فتح الملصقات").unLock,"md",true)  
return false
end 
if text == "قفل التوجيه" then 
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:forward"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل التوجيه").Lock,"md",true)  
return false
end 
if text == "قفل التوجيه بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:forward"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل التوجيه").lockKid,"md",true)  
return false
end 
if text == "قفل التوجيه بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:forward"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل التوجيه").lockKtm,"md",true)  
return false
end 
if text == "قفل التوجيه بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:forward"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل التوجيه").lockKick,"md",true)  
return false
end 
if text == "فتح التوجيه" then 
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(MEZO.."MEZO:Lock:forward"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم فتح التوجيه").unLock,"md",true)  
return false
end 
if text == "قفل الملفات" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:Document"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل الملفات").Lock,"md",true)  
return false
end 
if text == "قفل الملفات بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:Document"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل الملفات").lockKid,"md",true)  
return false
end 
if text == "قفل الملفات بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:Document"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل الملفات").lockKtm,"md",true)  
return false
end 
if text == "قفل الملفات بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:Document"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل الملفات").lockKick,"md",true)  
return false
end 
if text == "فتح الملفات" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(MEZO.."MEZO:Lock:Document"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم فتح الملفات").unLock,"md",true)  
return false
end 
if text == "قفل السيلفي" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:Unsupported"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل السيلفي").Lock,"md",true)  
return false
end 
if text == "قفل السيلفي بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:Unsupported"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل السيلفي").lockKid,"md",true)  
return false
end 
if text == "قفل السيلفي بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:Unsupported"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل السيلفي").lockKtm,"md",true)  
return false
end 
if text == "قفل السيلفي بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:Unsupported"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل السيلفي").lockKick,"md",true)  
return false
end 
if text == "فتح السيلفي" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(MEZO.."MEZO:Lock:Unsupported"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم فتح السيلفي").unLock,"md",true)  
return false
end 
if text == "قفل الماركداون" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:Markdaun"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل الماركداون").Lock,"md",true)  
return false
end 
if text == "قفل الماركداون بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:Markdaun"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل الماركداون").lockKid,"md",true)  
return false
end 
if text == "قفل الماركداون بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:Markdaun"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل الماركداون").lockKtm,"md",true)  
return false
end 
if text == "قفل الماركداون بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:Markdaun"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل الماركداون").lockKick,"md",true)  
return false
end 
if text == "فتح الماركداون" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(MEZO.."MEZO:Lock:Markdaun"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم فتح الماركداون").unLock,"md",true)  
return false
end 
if text == "قفل الجهات" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:Contact"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل الجهات").Lock,"md",true)  
return false
end 
if text == "قفل الجهات بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:Contact"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل الجهات").lockKid,"md",true)  
return false
end 
if text == "قفل الجهات بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:Contact"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل الجهات").lockKtm,"md",true)  
return false
end 
if text == "قفل الجهات بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:Contact"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل الجهات").lockKick,"md",true)  
return false
end 
if text == "فتح الجهات" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(MEZO.."MEZO:Lock:Contact"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم فتح الجهات").unLock,"md",true)  
return false
end 
if text == "قفل الكلايش" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:Spam"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل الكلايش").Lock,"md",true)  
return false
end 
if text == "قفل الكلايش بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:Spam"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل الكلايش").lockKid,"md",true)  
return false
end 
if text == "قفل الكلايش بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:Spam"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل الكلايش").lockKtm,"md",true)  
return false
end 
if text == "قفل الكلايش بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:Spam"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل الكلايش").lockKick,"md",true)  
return false
end 
if text == "فتح الكلايش" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(MEZO.."MEZO:Lock:Spam"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم فتح الكلايش").unLock,"md",true)  
return false
end 
if text == "قفل الانلاين" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:Inlen"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل الانلاين").Lock,"md",true)  
return false
end 
if text == "قفل الانلاين بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:Inlen"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل الانلاين").lockKid,"md",true)  
return false
end 
if text == "قفل الانلاين بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:Inlen"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل الانلاين").lockKtm,"md",true)  
return false
end 
if text == "قفل الانلاين بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Lock:Inlen"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم قفـل الانلاين").lockKick,"md",true)  
return false
end 
if text == "فتح الانلاين" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(MEZO.."MEZO:Lock:Inlen"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ❍┃ تم فتح الانلاين").unLock,"md",true)  
return false
end 
if text == "ضع رابط" or text == "وضع رابط" then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(MEZO.."MEZO:Set:Link"..msg_chat_id..""..msg.sender.user_id,120,true) 
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ ارسل رابط المجموعه او رابط قناة المجموعه","md",true)  
end
if text == "مسح الرابط" or text == "حذف الرابط" then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(MEZO.."MEZO:Group:Link"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم مسح الرابط ","md",true)             
end
if text == "الرابط" or text == "رابط" or text == "الينك" then
if not Redis:get(MEZO.."MEZO:Status:Link"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم تعطيل جلب الرابط من قبل الادمنيه*","md",true)
end 
local Get_Chat = LuaTele.getChat(msg_chat_id)
local GetLink = Redis:get(MEZO.."Group:Link"..msg_chat_id) 
if GetLink then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{{text =Get_Chat.title, url = GetLink}, },}}
return LuaTele.sendText(msg_chat_id, msg_id, "* ❍┃ Link Group : * \n["..Get_Chat.title.. ']('..GetLink..')', 'md', true, false, false, false, reply_markup)
else 
local LinkGroup = LuaTele.generateChatInviteLink(msg_chat_id,'Hussain',tonumber(msg.date+86400),0,true)
if LinkGroup.code == 3 then
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃  لا استطيع جلب الرابط بسبب ليس لدي صلاحيه دعوه مستخدمين من خلال الرابط *","md",true)
end
url = https.request('http://api.telegram.org/bot'..Token..'/getchat?chat_id='..msg_chat_id..'')
json = JSON.decode(url)
local txt = "* ❍┃ Link Group : * \n["..Get_Chat.title.. ']('..LinkGroup.invite_link..')'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = Get_Chat.title, url=LinkGroup.invite_link},
},
}
local rep = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id="..msg.chat_id.."&reply_to_message_id="..rep.."&photo=t.me/"..json.result.username.."&caption="..URL.escape(txt).."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
end
if text == "اسم الجروب" or text == "اسم البار" then
local Get_Chat = LuaTele.getChat(msg_chat_id)
local GetLink = Redis:get(MEZO.."MEZO:Group:Link"..msg_chat_id) 
if GetLink then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{{text =Get_Chat.title, url = GetLink}, },}}
return LuaTele.sendText(msg_chat_id, msg_id, " \n["..Get_Chat.title.. ']('..GetLink..')', 'md', true, false, false, false, reply_markup)
else 
local LinkGroup = LuaTele.generateChatInviteLink(msg_chat_id,'Hussain',tonumber(msg.date+86400),0,true)
if LinkGroup.code == 3 then
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ لا استطيع جلب اسم الجروب بسبب ليس لدي صلاحيه دعوه مستخدمين من خلال اسم الجروب ","md",true)
end
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{{text = Get_Chat.title, url = LinkGroup.invite_link},},}}
return LuaTele.sendText(msg_chat_id, msg_id, " \n["..Get_Chat.title.. ']('..LinkGroup.invite_link..')', 'md', true, false, false, false, reply_markup)
end
end
if text == "ضع ترحيب" or text == "وضع ترحيب" then  
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(MEZO.."Tshake:Welcome:Group" .. msg_chat_id .. "" .. msg.sender.user_id, 120, true)  
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ ارسل لي الترحيب الان".."\n ❍┃ تستطيع اضافة مايلي !\n ❍┃ دالة عرض الاسم ‹-{`name`}\n ❍┃ دالة عرض المعرف ‹-{`user`}\n ❍┃ دالة عرض اسم المجموعه ‹-{`NameCh`}","md",true)   
end
if text == "الترحيب" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:get(MEZO.."MEZO:Status:Welcome"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم تعطيل الترحيب من قبل الادمنيه","md",true)
end 
local Welcome = Redis:get(MEZO.."MEZO:Welcome:Group"..msg_chat_id)
if Welcome then 
return LuaTele.sendText(msg_chat_id,msg_id,Welcome,"md",true)   
else 
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ لم يتم تعيين ترحيب للمجموعه","md",true)   
end 
end
if text == "مسح الترحيب" or text == "حذف الترحيب" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(MEZO.."MEZO:Welcome:Group"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم ازالة ترحيب المجموعه","md",true)   
end
if text == "ضع قوانين" or text == "وضع قوانين" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(MEZO.."MEZO:Set:Rules:" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ ارسل لي القوانين الان","md",true)  
end
if text == "مسح القوانين" or text == "حذف القوانين" then  
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(MEZO.."MEZO:Group:Rules"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم ازالة قوانين المجموعه","md",true)    
end
if text == "القوانين" then 
local Rules = Redis:get(MEZO.."MEZO:Group:Rules" .. msg_chat_id)   
if Rules then     
return LuaTele.sendText(msg_chat_id,msg_id,Rules,"md",true)     
else      
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ لا توجد قوانين هنا","md",true)     
end    
end
if text == "ضع وصف" or text == "وضع وصف" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).Info == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ البوت ليس لديه صلاحيه تغيير المعلومات* ',"md",true)  
end
Redis:setex(MEZO.."MEZO:Set:Description:" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ ارسل لي وصف المجموعه الان","md",true)  
end
if text == "مسح الوصف" or text == "حذف الوصف" then  
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).Info == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ البوت ليس لديه صلاحيه تغيير المعلومات* ',"md",true)  
end
LuaTele.setChatDescription(msg_chat_id, '') 
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم ازالة قوانين المجموعه","md",true)    
end

if text and text:match("^ضع اسم (.*)") or text and text:match("^وضع اسم (.*)") then 
local NameChat = text:match("^ضع اسم (.*)") or text:match("^وضع اسم (.*)") 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).Info == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ البوت ليس لديه صلاحيه تغيير المعلومات* ',"md",true)  
end
LuaTele.setChatTitle(msg_chat_id,NameChat)
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم تغيير اسم المجموعه الى : "..NameChat,"md",true)    
end

if text == ("ضع صوره") then  
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if GetInfoBot(msg).Info == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ البوت ليس لديه صلاحيه تغيير المعلومات* ',"md",true)  
end
Redis:set(MEZO.."MEZO:Chat:Photo"..msg_chat_id..":"..msg.sender.user_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ ارسل الصوره لوضعها","md",true)    
end

if text == "مسح قائمه المنع" then   
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(MEZO.."MEZO:List:Filter"..msg_chat_id)  
if #list == 0 then  
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ لا يوجد كلمات ممنوعه هنا *","md",true)   
end  
for k,v in pairs(list) do  
v = v:gsub('photo:',"") 
v = v:gsub('sticker:',"") 
v = v:gsub('animation:',"") 
v = v:gsub('text:',"") 
Redis:del(MEZO.."MEZO:Filter:Group:"..v..msg_chat_id)  
Redis:srem(MEZO.."MEZO:List:Filter"..msg_chat_id,v)  
end  
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم مسح ("..#list..") كلمات ممنوعه *","md",true)   
end
if text == "قائمه المنع" then   
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(MEZO.."MEZO:List:Filter"..msg_chat_id)  
if #list == 0 then  
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ لا يوجد كلمات ممنوعه هنا *","md",true)   
end  
Filter = '\n* ❍┃ قائمه المنع \n— — — — — — — — —*\n'
for k,v in pairs(list) do  
print(v)
if v:match('photo:(.*)') then
ver = 'صوره'
elseif v:match('animation:(.*)') then
ver = 'متحركه'
elseif v:match('sticker:(.*)') then
ver = 'ملصق'
elseif v:match('text:(.*)') then
ver = v:gsub('text:',"") 
end
v = v:gsub('photo:',"") 
v = v:gsub('sticker:',"") 
v = v:gsub('animation:',"") 
v = v:gsub('text:',"") 
local Text_Filter = Redis:get(MEZO.."MEZO:Filter:Group:"..v..msg_chat_id)   
Filter = Filter.."*"..k.."- "..ver.." ‹- { "..Text_Filter.." }*\n"    
end  
LuaTele.sendText(msg_chat_id,msg_id,Filter,"md",true)  
end  
if text == "منع" then       
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO..'MEZO:FilterText'..msg_chat_id..':'..msg.sender.user_id,'true')
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ ارسل الان { ملصق ,متحركه ,صوره ,رساله } *',"md",true)  
end    
if text == "الغاء منع" then    
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO..'MEZO:FilterText'..msg_chat_id..':'..msg.sender.user_id,'DelFilter')
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ ارسل الان { ملصق ,متحركه ,صوره ,رساله } *',"md",true)  
end

if text == "اضف امر عام" then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:All:Command:Reids:Group"..msg_chat_id..":"..msg.sender.user_id,"true") 
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ الان ارسل لي الامر القديم ...","md",true)
end
if text == "حذف امر عام" or text == "مسح امر عام" then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:All:Command:Reids:Group:Del"..msg_chat_id..":"..msg.sender.user_id,"true") 
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ ارسل الان الامر الذي قمت بوضعه مكان الامر القديم","md",true)
end
if text == "حذف الاوامر المضافه العامه" or text == "مسح الاوامر المضافه العامه" then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(MEZO.."MEZO:All:Command:List:Group")
for k,v in pairs(list) do
Redis:del(MEZO.."MEZO:All:Get:Reides:Commands:Group"..v)
Redis:del(MEZO.."MEZO:All:Command:List:Group")
end
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم مسح جميع الاوامر التي تم اضافتها في العام","md",true)
end
if text == "الاوامر المضافه العامه" then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(MEZO.."MEZO:All:Command:List:Group")
Command = " ❍┃ قائمه الاوامر المضافه العامه  \n— — — — — — — — —\n"
for k,v in pairs(list) do
Commands = Redis:get(MEZO.."MEZO:All:Get:Reides:Commands:Group"..v)
if Commands then 
Command = Command..""..k..": ("..v..") ⏎ ⟦ "..Commands.." ⟧\n"
else
Command = Command..""..k..": ("..v..") \n"
end
end
if #list == 0 then
Command = " ❍┃ لا توجد اوامر اضافيه عامه"
end
return LuaTele.sendText(msg_chat_id,msg_id,Command,"md",true)
end


if text == "اضف امر" then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Command:Reids:Group"..msg_chat_id..":"..msg.sender.user_id,"true") 
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ الان ارسل لي الامر القديم ...","md",true)
end
if text == "حذف امر" or text == "مسح امر" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Command:Reids:Group:Del"..msg_chat_id..":"..msg.sender.user_id,"true") 
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ ارسل الان الامر الذي قمت بوضعه مكان الامر القديم","md",true)
end
if text == "حذف الاوامر المضافه" or text == "مسح الاوامر المضافه" then 
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(6)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(MEZO.."MEZO:Command:List:Group"..msg_chat_id)
for k,v in pairs(list) do
Redis:del(MEZO.."MEZO:Get:Reides:Commands:Group"..msg_chat_id..":"..v)
Redis:del(MEZO.."MEZO:Command:List:Group"..msg_chat_id)
end
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم مسح جميع الاوامر التي تم اضافتها","md",true)
end
if text == "الاوامر المضافه" then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(6)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(MEZO.."MEZO:Command:List:Group"..msg_chat_id.."")
Command = " ❍┃ قائمه الاوامر المضافه  \n— — — — — — — — —\n"
for k,v in pairs(list) do
Commands = Redis:get(MEZO.."MEZO:Get:Reides:Commands:Group"..msg_chat_id..":"..v)
if Commands then 
Command = Command..""..k..": ("..v..") ⏎ ⟦ "..Commands.." ⟧\n"
else
Command = Command..""..k..": ("..v..") \n"
end
end
if #list == 0 then
Command = " ❍┃ لا توجد اوامر اضافيه"
end
return LuaTele.sendText(msg_chat_id,msg_id,Command,"md",true)
end

if text == "تثبيت" and msg.reply_to_message_id ~= 0 then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).PinMsg == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ البوت ليس لديه صلاحيه تثبيت الرسائل* ',"md",true)  
end
LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ تم تثبيت الرساله","md",true)
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local PinMsg = LuaTele.pinChatMessage(msg_chat_id,Message_Reply.id,true)
end
if text == 'الغاء التثبيت' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).PinMsg == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ البوت ليس لديه صلاحيه تثبيت الرسائل* ',"md",true)  
end
LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ تم الغاء تثبيت الرساله","md",true)
LuaTele.unpinChatMessage(msg_chat_id) 
end
if text == 'الغاء تثبيت الكل' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(6)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).PinMsg == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ البوت ليس لديه صلاحيه تثبيت الرسائل* ',"md",true)  
end
LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ تم الغاء تثبيت كل الرسائل","md",true)
LuaTele.unpinAllChatMessages(msg_chat_id)
end
if text == "الحمايه" then    
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'تعطيل الرابط', data = msg.sender.user_id..'/'.. 'unmute_link'},{text = 'تفعيل الرابط', data = msg.sender.user_id..'/'.. 'mute_link'},
},
{
{text = 'تعطيل الترحيب', data = msg.sender.user_id..'/'.. 'unmute_welcome'},{text = 'تفعيل الترحيب', data = msg.sender.user_id..'/'.. 'mute_welcome'},
},
{
{text = 'تعطيل الايدي', data = msg.sender.user_id..'/'.. 'unmute_Id'},{text = 'تفعيل الايدي', data = msg.sender.user_id..'/'.. 'mute_Id'},
},
{
{text = 'تعطيل الايدي بالصوره', data = msg.sender.user_id..'/'.. 'unmute_IdPhoto'},{text = 'تفعيل الايدي بالصوره', data = msg.sender.user_id..'/'.. 'mute_IdPhoto'},
},
{
{text = 'تعطيل الردود المضافه', data = msg.sender.user_id..'/'.. 'unmute_ryple'},{text = 'تفعيل الردود المضافه', data = msg.sender.user_id..'/'.. 'mute_ryple'},
},
{
{text = 'تعطيل الردود العامه', data = msg.sender.user_id..'/'.. 'unmute_ryplesudo'},{text = 'تفعيل ردود العامه', data = msg.sender.user_id..'/'.. 'mute_ryplesudo'},
},
{
{text = 'تعطيل ردود السورس', data = IdUser..'/'.. 'madeson_belal'},{text = 'تفعيل ردود السورس', data = IdUser..'/'.. 'belal_madeson'},
},
{
{text = 'تعطيل الرفع', data = msg.sender.user_id..'/'.. 'unmute_setadmib'},{text = 'تفعيل الرفع', data = msg.sender.user_id..'/'.. 'mute_setadmib'},
},
{
{text = 'تعطيل الطرد', data = msg.sender.user_id..'/'.. 'unmute_kickmembars'},{text = 'تفعيل الطرد', data = msg.sender.user_id..'/'.. 'mute_kickmembars'},
},
{
{text = 'تعطيل الالعاب', data = msg.sender.user_id..'/'.. 'unmute_games'},{text = 'تفعيل الالعاب', data = msg.sender.user_id..'/'.. 'mute_games'},
},
{
{text = 'تعطيل اطردني', data = msg.sender.user_id..'/'.. 'unmute_kickme'},{text = 'تفعيل اطردني', data = msg.sender.user_id..'/'.. 'mute_kickme'},
},
{
{text = '◈⦁ اخفاء الامر ⦁◈', data =msg.sender.user_id..'/'.. 'delAmr'}
},
}
}
return LuaTele.sendText(msg_chat_id, msg_id, ' ❍┃ اوامر التفعيل والتعطيل ', 'md', false, false, false, false, reply_markup)
end  
if text == 'اعدادات الحمايه' then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:get(MEZO.."MEZO:Status:Link"..msg.chat_id) then
Statuslink = '【 ✅ 】' else Statuslink = '【 ❌ 】'
end
if Redis:get(MEZO.."MEZO:Status:Welcome"..msg.chat_id) then
StatusWelcome = '【 ✅ 】' else StatusWelcome = '【 ❌ 】'
end
if Redis:get(MEZO.."MEZO:Status:Id"..msg.chat_id) then
StatusId = '【 ✅ 】' else StatusId = '【 ❌ 】'
end
if Redis:get(MEZO.."MEZO:Status:IdPhoto"..msg.chat_id) then
StatusIdPhoto = '【 ✅ 】' else StatusIdPhoto = '【 ❌ 】'
end
if Redis:get(MEZO.."MEZO:Status:Reply"..msg.chat_id) then
StatusReply = '【 ✅ 】' else StatusReply = '【 ❌ 】'
end
if Redis:get(MEZO.."MEZO:Status:ReplySudo"..msg.chat_id) then
StatusReplySudo = '【 ✅ 】' else StatusReplySudo = '【 ❌ 】'
end
if Redis:get(MEZO.."MEZO:Status:JabwaId"..msg.chat_id)  then
StatusJabwaId = '【 ✅ 】' else StatusJabwaId = '【 ❌ 】'
end
if Redis:get(MEZO.."MEZO:Status:SetId"..msg.chat_id) then
StatusSetId = '【 ✅ 】' else StatusSetId = '【 ❌ 】'
end
if Redis:get(MEZO.."MEZO:Status:Games"..msg.chat_id) then
StatusGames = '【 ✅ 】' else StatusGames = '【 ❌ 】'
end
if Redis:get(MEZO.."MEZO:Status:KickMe"..msg.chat_id) then
Statuskickme = '【 ✅ 】' else Statuskickme = '【 ❌ 】'
end
if Redis:get(MEZO.."MEZO:Status:AddMe"..msg.chat_id) then
StatusAddme = '【 ✅ 】' else StatusAddme = '【 ❌ 】'
end
local protectionGroup = '\n* ❍┃ اعدادات حمايه المجموعه\n— — — — — — — — —\n'
..'\n ❍┃ جلب الرابط⏎ '..Statuslink
..'\n ❍┃ جلب الترحيب⏎ '..StatusWelcome
..'\n ❍┃ الايدي⏎ '..StatusId
..'\n ❍┃ الايدي بالصوره⏎ '..StatusIdPhoto
..'\n ❍┃ الردود المضافه⏎ '..StatusReply
..'\n ❍┃ الردود العامه⏎ '..StatusReplySudo
..'\n ❍┃ الرفع⏎ '..StatusSetId
..'\n ❍┃ الحظر - الطرد⏎ '..StatusJabwaId
..'\n ❍┃ الالعاب⏎ '..StatusGames
..'\n ❍┃ امر اطردني⏎ '..Statuskickme..'*\n\n'
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ 𓏶 𝒄𝒓𝒊𝒔𝒕𝒊𝒏 • 𝒔𝒐𝒖𝒓𝒄𝒆 𓏶 ❍', url = 't.me/cristin_so'}, 
},
}
}
return LuaTele.sendText(msg_chat_id, msg_id,protectionGroup,'md', false, false, false, false, reply_markup)
end
if text == "الاعدادات" then    
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Text = "*\n ❍┃ اعدادات المجموعه ".."\n✅┃علامة صح تعني انا الامر مفتوح".."\n❌┃علامة غلط تعني انا الامر مقفول*"
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = GetSetieng(msg_chat_id).lock_links, data = '&'},{text = 'الروابط -› ', data =msg.sender.user_id..'/'.. 'Status_link'},
},
{
{text = GetSetieng(msg_chat_id).lock_spam, data = '&'},{text = 'الكلايش -› ', data =msg.sender.user_id..'/'.. 'Status_spam'},
},
{
{text = GetSetieng(msg_chat_id).lock_inlin, data = '&'},{text = 'الكيبورد -› ', data =msg.sender.user_id..'/'.. 'Status_keypord'},
},
{
{text = GetSetieng(msg_chat_id).lock_vico, data = '&'},{text = 'الاغاني -› ', data =msg.sender.user_id..'/'.. 'Status_voice'},
},
{
{text = GetSetieng(msg_chat_id).lock_gif, data = '&'},{text = 'المتحركه -› ', data =msg.sender.user_id..'/'.. 'Status_gif'},
},
{
{text = GetSetieng(msg_chat_id).lock_file, data = '&'},{text = 'الملفات -› ', data =msg.sender.user_id..'/'.. 'Status_files'},
},
{
{text = GetSetieng(msg_chat_id).lock_text, data = '&'},{text = 'الدردشه -› ', data =msg.sender.user_id..'/'.. 'Status_text'},
},
{
{text = GetSetieng(msg_chat_id).lock_ved, data = '&'},{text = 'الفيديو -› ', data =msg.sender.user_id..'/'.. 'Status_video'},
},
{
{text = GetSetieng(msg_chat_id).lock_photo, data = '&'},{text = 'الصور -› ', data =msg.sender.user_id..'/'.. 'Status_photo'},
},
{
{text = GetSetieng(msg_chat_id).lock_user, data = '&'},{text = 'المعرفات -› ', data =msg.sender.user_id..'/'.. 'Status_username'},
},
{
{text = GetSetieng(msg_chat_id).lock_hash, data = '&'},{text = 'التاك -› ', data =msg.sender.user_id..'/'.. 'Status_tags'},
},
{
{text = GetSetieng(msg_chat_id).lock_bots, data = '&'},{text = 'البوتات -› ', data =msg.sender.user_id..'/'.. 'Status_bots'},
},
{
{text = '◈⦁ القائمه الثانيه ⦁◈', data =msg.sender.user_id..'/'.. 'NextSeting'}
},
{
{text = '◈⦁ اخفاء الامر ⦁◈', data =msg.sender.user_id..'/'.. 'delAmr'}
},
}
}
return LuaTele.sendText(msg_chat_id, msg_id, Text, 'md', false, false, false, false, reply_markup)
end  


if text == 'المجموعه' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local Info_Chats = LuaTele.getSupergroupFullInfo(msg_chat_id)
local Get_Chat = LuaTele.getChat(msg_chat_id)
if Get_Chat.permissions.can_add_web_page_previews then
web = '【 ✅ 】' else web = '【 ❌ 】'
end
if Get_Chat.permissions.can_change_info then
info = '【 ✅ 】' else info = '【 ❌ 】'
end
if Get_Chat.permissions.can_invite_users then
invite = '【 ✅ 】' else invite = '【 ❌ 】'
end
if Get_Chat.permissions.can_pin_messages then
pin = '【 ✅ 】' else pin = '【 ❌ 】'
end
if Get_Chat.permissions.can_send_media_messages then
media = '【 ✅ 】' else media = '【 ❌ 】'
end
if Get_Chat.permissions.can_send_messages then
messges = '【 ✅ 】' else messges = '【 ❌ 】'
end
if Get_Chat.permissions.can_send_other_messages then
other = '【 ✅ 】' else other = '【 ❌ 】'
end
if Get_Chat.permissions.can_send_polls then
polls = '【 ✅ 】' else polls = '【 ❌ 】'
end
local permissions = '*\n ❍┃ صلاحيات المجموعه :\n— — — — — — — — —'..'\n ❍┃ ارسال الويب : '..web..'\n ❍┃ تغيير معلومات المجموعه : '..info..'\n ❍┃ اضافه مستخدمين : '..invite..'\n ❍┃ تثبيت الرسائل : '..pin..'\n ❍┃ ارسال الميديا : '..media..'\n ❍┃ ارسال الرسائل : '..messges..'\n ❍┃ اضافه البوتات : '..other..'\n ❍┃ ارسال استفتاء : '..polls..'*\n\n'
local TextChat = '*\n ❍┃ معلومات المجموعه :\n— — — — — — — — —'..' \n ❍┃ عدد الادمنيه : ❬ '..Info_Chats.administrator_count..' ❭\n ❍┃ عدد المحظورين : ❬ '..Info_Chats.Jabwaned_count..' ❭\n ❍┃ عدد الاعضاء : ❬ '..Info_Chats.member_count..' ❭\n ❍┃ عدد المقيديين : ❬ '..Info_Chats.restricted_count..' ❭\n ❍┃ اسم المجموعه : ❬* ['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')* ❭*'
return LuaTele.sendText(msg_chat_id,msg_id, TextChat..permissions,"md",true)
end
if text == 'صلاحيات المجموعه' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(6)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local Get_Chat = LuaTele.getChat(msg_chat_id)
if Get_Chat.permissions.can_add_web_page_previews then
web = '【 ✅ 】' else web = '【 ❌ 】'
end
if Get_Chat.permissions.can_change_info then
info = '【 ✅ 】' else info = '【 ❌ 】'
end
if Get_Chat.permissions.can_invite_users then
invite = '【 ✅ 】' else invite = '【 ❌ 】'
end
if Get_Chat.permissions.can_pin_messages then
pin = '【 ✅ 】' else pin = '【 ❌ 】'
end
if Get_Chat.permissions.can_send_media_messages then
media = '【 ✅ 】' else media = '【 ❌ 】'
end
if Get_Chat.permissions.can_send_messages then
messges = '【 ✅ 】' else messges = '【 ❌ 】'
end
if Get_Chat.permissions.can_send_other_messages then
other = '【 ✅ 】' else other = '【 ❌ 】'
end
if Get_Chat.permissions.can_send_polls then
polls = '【 ✅ 】' else polls = '【 ❌ 】'
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍┃ ارسال الويب : '..web, data = msg.sender.user_id..'/web'}, 
},
{
{text = '❍┃ تغيير معلومات المجموعه : '..info, data =msg.sender.user_id..  '/info'}, 
},
{
{text = '❍┃ اضافه مستخدمين : '..invite, data =msg.sender.user_id..  '/invite'}, 
},
{
{text = '❍┃ تثبيت الرسائل : '..pin, data =msg.sender.user_id..  '/pin'}, 
},
{
{text = '❍┃ ارسال الميديا : '..media, data =msg.sender.user_id..  '/media'}, 
},
{
{text = '❍┃ ارسال الرسائل : '..messges, data =msg.sender.user_id..  '/messges'}, 
},
{
{text = '❍┃ اضافه البوتات : '..other, data =msg.sender.user_id..  '/other'}, 
},
{
{text = '❍┃ ارسال استفتاء : '..polls, data =msg.sender.user_id.. '/polls'}, 
},
{
{text = '◈⦁ اخفاء الامر ⦁◈', data =msg.sender.user_id..'/'.. '/delAmr'}
},
}
}
return LuaTele.sendText(msg_chat_id, msg_id, " ❍┃ الصلاحيات - ", 'md', false, false, false, false, reply_markup)
end
if text == 'تنزيل الكل' and msg.reply_to_message_id ~= 0 then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local Jabwa = LuaTele.getUser(Message_Reply.sender.user_id)
if Jabwa.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if Jabwa and Jabwa.type and Jabwa.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام الامر على البوت ","md",true)  
end
if Redis:sismember(MEZO.."MEZO:Developers:Groups",Message_Reply.sender.user_id) then
dev = "المطور ،" else dev = "" end
if Redis:sismember(MEZO.."MEZO:TheBasics:Group"..msg_chat_id, Message_Reply.sender.user_id) then
crr = "منشئ اساسي ،" else crr = "" end
if Redis:sismember(MEZO..'MEZO:Originators:Group'..msg_chat_id, Message_Reply.sender.user_id) then
cr = "منشئ ،" else cr = "" end
if Redis:sismember(MEZO..'MEZO:Managers:Group'..msg_chat_id, Message_Reply.sender.user_id) then
own = "مدير ،" else own = "" end
if Redis:sismember(MEZO..'MEZO:Addictive:Group'..msg_chat_id, Message_Reply.sender.user_id) then
mod = "ادمن ،" else mod = "" end
if Redis:sismember(MEZO..'MEZO:Distinguished:Group'..msg_chat_id, Message_Reply.sender.user_id) then
vip = "مميز ،" else vip = ""
end
if The_ControllerAll(Message_Reply.sender.user_id) == true then
Rink = 1
elseif Redis:sismember(MEZO.."MEZO:Developers:Groups",Message_Reply.sender.user_id)  then
Rink = 2
elseif Redis:sismember(MEZO.."MEZO:TheBasics:Group"..msg_chat_id, Message_Reply.sender.user_id) then
Rink = 3
elseif Redis:sismember(MEZO.."MEZO:Originators:Group"..msg_chat_id, Message_Reply.sender.user_id) then
Rink = 4
elseif Redis:sismember(MEZO.."MEZO:Managers:Group"..msg_chat_id, Message_Reply.sender.user_id) then
Rink = 5
elseif Redis:sismember(MEZO.."MEZO:Addictive:Group"..msg_chat_id, Message_Reply.sender.user_id) then
Rink = 6
elseif Redis:sismember(MEZO.."MEZO:Distinguished:Group"..msg_chat_id, Message_Reply.sender.user_id) then
Rink = 7
else
Rink = 8
end
if StatusCanOrNotCan(msg_chat_id,Message_Reply.sender.user_id) == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ ليس لديه اي رتبه هنا *","md",true)  
end
if msg.ControllerBot then
if Rink == 1 or Rink < 1 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(MEZO.."MEZO:Developers:Groups",Message_Reply.sender.user_id)
Redis:srem(MEZO.."MEZO:TheBasics:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(MEZO.."MEZO:Originators:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(MEZO.."MEZO:Managers:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(MEZO.."MEZO:Addictive:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(MEZO.."MEZO:Distinguished:Group"..msg_chat_id, Message_Reply.sender.user_id)
elseif msg.Developers then
if Rink == 2 or Rink < 2 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(MEZO.."MEZO:TheBasics:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(MEZO.."MEZO:Originators:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(MEZO.."MEZO:Managers:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(MEZO.."MEZO:Addictive:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(MEZO.."MEZO:Distinguished:Group"..msg_chat_id, Message_Reply.sender.user_id)
elseif msg.TheBasics then
if Rink == 3 or Rink < 3 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(MEZO.."MEZO:Originators:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(MEZO.."MEZO:Managers:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(MEZO.."MEZO:Addictive:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(MEZO.."MEZO:Distinguished:Group"..msg_chat_id, Message_Reply.sender.user_id)
elseif msg.Originators then
if Rink == 4 or Rink < 4 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(MEZO.."MEZO:Managers:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(MEZO.."MEZO:Addictive:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(MEZO.."MEZO:Distinguished:Group"..msg_chat_id, Message_Reply.sender.user_id)
elseif msg.Managers then
if Rink == 5 or Rink < 5 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(MEZO.."MEZO:Addictive:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(MEZO.."MEZO:Distinguished:Group"..msg_chat_id, Message_Reply.sender.user_id)
elseif msg.Addictive then
if Rink == 6 or Rink < 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(MEZO.."MEZO:Distinguished:Group"..msg_chat_id, Message_Reply.sender.user_id)
end
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ تم تنزيل الشخص من الرتب التاليه { "..dev..""..crr..""..cr..""..own..""..mod..""..vip.." *}","md",true)  
end

if text and text:match('^تنزيل الكل @(%S+)$') then
local UserName = text:match('^تنزيل الكل @(%S+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام معرف البوت ","md",true)  
end
if Redis:sismember(MEZO.."MEZO:Developers:Groups",UserId_Info.id) then
dev = "المطور ،" else dev = "" end
if Redis:sismember(MEZO.."MEZO:TheBasics:Group"..msg_chat_id, UserId_Info.id) then
crr = "منشئ اساسي ،" else crr = "" end
if Redis:sismember(MEZO..'MEZO:Originators:Group'..msg_chat_id, UserId_Info.id) then
cr = "منشئ ،" else cr = "" end
if Redis:sismember(MEZO..'MEZO:Managers:Group'..msg_chat_id, UserId_Info.id) then
own = "مدير ،" else own = "" end
if Redis:sismember(MEZO..'MEZO:Addictive:Group'..msg_chat_id, UserId_Info.id) then
mod = "ادمن ،" else mod = "" end
if Redis:sismember(MEZO..'MEZO:Distinguished:Group'..msg_chat_id, UserId_Info.id) then
vip = "مميز ،" else vip = ""
end
if The_ControllerAll(UserId_Info.id) == true then
Rink = 1
elseif Redis:sismember(MEZO.."MEZO:Developers:Groups",UserId_Info.id)  then
Rink = 2
elseif Redis:sismember(MEZO.."MEZO:TheBasics:Group"..msg_chat_id, UserId_Info.id) then
Rink = 3
elseif Redis:sismember(MEZO.."MEZO:Originators:Group"..msg_chat_id, UserId_Info.id) then
Rink = 4
elseif Redis:sismember(MEZO.."MEZO:Managers:Group"..msg_chat_id, UserId_Info.id) then
Rink = 5
elseif Redis:sismember(MEZO.."MEZO:Addictive:Group"..msg_chat_id, UserId_Info.id) then
Rink = 6
elseif Redis:sismember(MEZO.."MEZO:Distinguished:Group"..msg_chat_id, UserId_Info.id) then
Rink = 7
else
Rink = 8
end
if StatusCanOrNotCan(msg_chat_id,UserId_Info.id) == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ ليس لديه اي رتبه هنا *","md",true)  
end
if msg.ControllerBot then
if Rink == 1 or Rink < 1 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(MEZO.."MEZO:Developers:Groups",UserId_Info.id)
Redis:srem(MEZO.."MEZO:TheBasics:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(MEZO.."MEZO:Originators:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(MEZO.."MEZO:Managers:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(MEZO.."MEZO:Addictive:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(MEZO.."MEZO:Distinguished:Group"..msg_chat_id, UserId_Info.id)
elseif msg.Developers then
if Rink == 2 or Rink < 2 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(MEZO.."MEZO:TheBasics:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(MEZO.."MEZO:Originators:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(MEZO.."MEZO:Managers:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(MEZO.."MEZO:Addictive:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(MEZO.."MEZO:Distinguished:Group"..msg_chat_id, UserId_Info.id)
elseif msg.TheBasics then
if Rink == 3 or Rink < 3 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(MEZO.."MEZO:Originators:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(MEZO.."MEZO:Managers:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(MEZO.."MEZO:Addictive:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(MEZO.."MEZO:Distinguished:Group"..msg_chat_id, UserId_Info.id)
elseif msg.Originators then
if Rink == 4 or Rink < 4 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(MEZO.."MEZO:Managers:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(MEZO.."MEZO:Addictive:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(MEZO.."MEZO:Distinguished:Group"..msg_chat_id, UserId_Info.id)
elseif msg.Managers then
if Rink == 5 or Rink < 5 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(MEZO.."MEZO:Addictive:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(MEZO.."MEZO:Distinguished:Group"..msg_chat_id, UserId_Info.id)
elseif msg.Addictive then
if Rink == 6 or Rink < 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(MEZO.."MEZO:Distinguished:Group"..msg_chat_id, UserId_Info.id)
end
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ تم تنزيل الشخص من الرتب التاليه { "..dev..""..crr..""..cr..""..own..""..mod..""..vip.." *}","md",true)  
end

if text and text:match('اضف لقب (.*)') and msg.reply_to_message_id ~= 0 then
local CustomTitle = text:match('اضف لقب (.*)')
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(4)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).SetAdmin == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ البوت ليس لديه صلاحيه اضافة مشرفين* ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local Jabwa = LuaTele.getUser(Message_Reply.sender.user_id)
if Jabwa.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if Jabwa and Jabwa.type and Jabwa.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام الامر على البوت ","md",true)  
end
local SetCustomTitle = https.request("https://api.telegram.org/bot"..Token.."/setChatAdministratorCustomTitle?chat_id="..msg_chat_id.."&user_id="..Message_Reply.sender.user_id.."&custom_title="..CustomTitle)
local SetCustomTitle_ = JSON.decode(SetCustomTitle)
if SetCustomTitle_.result == true then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ❍┃ تم وضع له لقب : "..CustomTitle).Reply,"md",true)  
else
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا هناك خطا تاكد من البوت ومن الشخص","md",true)  
end 
end
if text and text:match('^اضف لقب @(%S+) (.*)$') then
local UserName = {text:match('^اضف لقب @(%S+) (.*)$')}
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(4)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).SetAdmin == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ البوت ليس لديه صلاحيه اضافة مشرفين* ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName[1])
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName[1]:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام معرف البوت ","md",true)  
end
local SetCustomTitle = https.request("https://api.telegram.org/bot"..Token.."/setChatAdministratorCustomTitle?chat_id="..msg_chat_id.."&user_id="..UserId_Info.id.."&custom_title="..UserName[2])
local SetCustomTitle_ = JSON.decode(SetCustomTitle)
if SetCustomTitle_.result == true then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ❍┃ تم وضع له لقب : "..UserName[2]).Reply,"md",true)  
else
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا هناك خطا تاكد من البوت ومن الشخص","md",true)  
end 
end 
if text == ('رفع مشرف') and msg.reply_to_message_id ~= 0 then
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(4)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).SetAdmin == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ البوت ليس لديه صلاحيه اضافة مشرفين* ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local Jabwa = LuaTele.getUser(Message_Reply.sender.user_id)
if Jabwa.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if Jabwa and Jabwa.type and Jabwa.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام الامر على البوت ","md",true)  
end
local SetAdmin = LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'administrator',{1 ,1, 0, 0, 0, 0, 0 , 0, 0, 0, 0, 0, ''})
if SetAdmin.code == 3 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ لا يمكنني رفعه ليس لدي صلاحيات *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ تعديل الصلاحيات ❍ ', data = msg.sender.user_id..'/groupNumseteng//'..Message_Reply.sender.user_id}, 
},
}
}
return LuaTele.sendText(msg_chat_id, msg_id, " ❍┃ صلاحيات المستخدم - ", 'md', false, false, false, false, reply_markup)
end
if text and text:match('^رفع مشرف @(%S+)$') then
local UserName = text:match('^رفع مشرف @(%S+)$')
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(4)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).SetAdmin == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ البوت ليس لديه صلاحيه اضافة مشرفين* ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام معرف البوت ","md",true)  
end
local SetAdmin = LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'administrator',{1 ,1, 0, 0, 0, 0, 0 , 0, 0, 0, 0, 0, ''})
var(SetAdmin)
if SetAdmin.code == 3 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ لا يمكنني رفعه ليس لدي صلاحيات *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ تعديل الصلاحيات ❍ ', data = msg.sender.user_id..'/groupNumseteng//'..UserId_Info.id}, 
},
}
}
return LuaTele.sendText(msg_chat_id, msg_id, " ❍┃ صلاحيات المستخدم - ", 'md', false, false, false, false, reply_markup)
end 
if text == ('تنزيل مشرف') and msg.reply_to_message_id ~= 0 then
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(4)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).SetAdmin == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ البوت ليس لديه صلاحيه اضافة مشرفين* ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local Jabwa = LuaTele.getUser(Message_Reply.sender.user_id)
if Jabwa.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if Jabwa and Jabwa.type and Jabwa.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام الامر على البوت ","md",true)  
end
local SetAdmin = LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'administrator',{0 ,0, 0, 0, 0, 0, 0 ,0, 0})
if SetAdmin.code == 400 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ لست انا من قام برفعه *","md",true)  
end
if SetAdmin.code == 3 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ لا يمكنني تنزيله ليس لدي صلاحيات *","md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ❍┃ تم تنزيله من المشرفين ").Reply,"md",true)  
end
if text and text:match('^تنزيل مشرف @(%S+)$') then
local UserName = text:match('^تنزيل مشرف @(%S+)$')
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(4)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).SetAdmin == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ البوت ليس لديه صلاحيه اضافة مشرفين* ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام معرف البوت ","md",true)  
end
local SetAdmin = LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'administrator',{0 ,0, 0, 0, 0, 0, 0 ,0, 0})
if SetAdmin.code == 400 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ لست انا من قام برفعه *","md",true)  
end
if SetAdmin.code == 3 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ لا يمكنني تنزيله ليس لدي صلاحيات *","md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ❍┃ تم تنزيله من المشرفين ").Reply,"md",true)  
end 
if text == 'مسح رسائلي' then
Redis:del(MEZO..'MEZO:Num:Message:User'..msg.chat_id..':'..msg.sender.user_id)
LuaTele.sendText(msg_chat_id,msg_id,'* ❍┃ تم مسح جميع رسائلك *',"md",true)  
elseif text == 'مسح سحكاتي' or text == 'مسح تعديلاتي' then
Redis:del(MEZO..'MEZO:Num:Message:Edit'..msg.chat_id..':'..msg.sender.user_id)
LuaTele.sendText(msg_chat_id,msg_id,'* ❍┃ تم مسح جميع تعديلاتك *',"md",true)  
elseif text == 'مسح جهاتي' then
Redis:del(MEZO..'MEZO:Num:Add:Memp'..msg.chat_id..':'..msg.sender.user_id)
LuaTele.sendText(msg_chat_id,msg_id,'* ❍┃ تم مسح جميع جهاتك المضافه *',"md",true)  
elseif text == 'رسائلي' then
LuaTele.sendText(msg_chat_id,msg_id,'* ❍┃ عدد رسائلك هنا ⏎ '..(Redis:get(MEZO..'MEZO:Num:Message:User'..msg.chat_id..':'..msg.sender.user_id) or 1)..'*',"md",true)  
elseif text == 'سحكاتي' or text == 'تعديلاتي' then
LuaTele.sendText(msg_chat_id,msg_id,'* ❍┃ عدد التعديلات هنا ⏎ '..(Redis:get(MEZO..'MEZO:Num:Message:Edit'..msg.chat_id..msg.sender.user_id) or 0)..'*',"md",true)  
elseif text == 'جهاتي' then
LuaTele.sendText(msg_chat_id,msg_id,'* ❍┃ عدد جهاتك يبشا ⏎ '..(Redis:get(MEZO.."MEZO:Num:Add:Memp"..msg.chat_id..":"..msg.sender.user_id) or 1)..'*',"md",true)  
elseif text == 'مسح' and msg.reply_to_message_id ~= 0 and msg.Addictive then
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if GetInfoBot(msg).Delmsg == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ البوت ليس لديه صلاحيه حذف الرسائل* ',"md",true)  
end
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.reply_to_message_id})
LuaTele.deleteMessages(msg.chat_id,{[1]= msg_id})
end
if text == 'تعين الايدي عام' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(MEZO.."MEZO:Redis:Id:Groups"..msg.chat_id..""..msg.sender.user_id,240,true)  
return LuaTele.sendText(msg_chat_id,msg_id,[[
 ❍┃ ارسل الان النص
 ❍┃ يمكنك اضافه :
 ❍┃ `#username` ‹- اسم المستخدم
 ❍┃ `#msgs` ‹- عدد الرسائل
 ❍┃ `#photos` ‹- عدد الصور
 ❍┃ `#id` ‹- ايدي المستخدم
 ❍┃ `#auto` ‹- نسبة التفاعل
 ❍┃ `#stast` ‹- رتبة المستخدم 
 ❍┃ `#edit` ‹- عدد السحكات
 ❍┃ `#game` ‹- عدد المجوهرات
 ❍┃ `#AddMem` ‹- عدد الجهات
 ❍┃ `#Description` ‹- تعليق الصوره
]],"md",true)    
end 
if text == 'حذف الايدي عام' or text == 'مسح الايدي عام' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(MEZO.."MEZO:Set:Id:Groups")
return LuaTele.sendText(msg_chat_id,msg_id, ' ❍┃ تم ازالة كليشة الايدي العامه',"md",true)  
end

if text == 'تعين الايدي' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(MEZO.."MEZO:Redis:Id:Group"..msg.chat_id..""..msg.sender.user_id,240,true)  
return LuaTele.sendText(msg_chat_id,msg_id,[[
 ❍┃ ارسل الان النص
 ❍┃ يمكنك اضافه :
 ❍┃ `#username` ‹- اسم المستخدم
 ❍┃ `#msgs` ‹- عدد الرسائل
 ❍┃ `#photos` ‹- عدد الصور
 ❍┃ `#id` ‹- ايدي المستخدم
 ❍┃ `#auto` ‹- نسبة التفاعل
 ❍┃ `#stast` ‹- رتبة المستخدم 
 ❍┃ `#edit` ‹- عدد السحكات
 ❍┃ `#game` ‹- عدد المجوهرات
 ❍┃ `#AddMem` ‹- عدد الجهات
 ❍┃ `#Description` ‹- تعليق الصوره
]],"md",true)    
end 
if text == 'حذف الايدي' or text == 'مسح الايدي' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(MEZO.."MEZO:Set:Id:Group"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id, ' ❍┃ تم ازالة كليشة الايدي ',"md",true)  
end
if text and text:match("^مسح (.*)$") and msg.reply_to_message_id == 0 then
local TextMsg = text:match("^مسح (.*)$")
if TextMsg == 'المطورين الثانوين' or TextMsg == 'المطورين الثانويين' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(MEZO.."MEZO:DevelopersQ:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ لا يوجد مطورين ثانوين في البوت ","md",true)  
end
Redis:del(MEZO.."MEZO:DevelopersQ:Groups") 
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم مسح ⟦ "..#Info_Members.." ⟧ من المطورين الثانويين*","md",true)
end
if TextMsg == 'المطورين' then
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(2)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(MEZO.."MEZO:Developers:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ لا يوجد مطورين في البوت ","md",true)  
end
Redis:del(MEZO.."MEZO:Developers:Groups") 
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم مسح ⟦ "..#Info_Members.." ⟧ من المطورين *","md",true)
end
if TextMsg == 'المنشئين الاساسيين' then
if not msg.TheBasicsm then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(MEZO.."MEZO:TheBasics:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ لا يوجد منشئين اساسيين في البوت ","md",true)  
end
Redis:del(MEZO.."MEZO:TheBasics:Group"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم مسح ⟦ "..#Info_Members.." ⟧ من المنشؤين الاساسيين *","md",true)
end
if TextMsg == 'المالكين' then
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(3)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(MEZO.."MEZO:TheBasics:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ لا يوجد مالكين في البوت ","md",true)  
end
Redis:del(MEZO.."MEZO:TheBasics:Group"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم مسح ⟦ "..#Info_Members.." ⟧ من المالكين *","md",true)
end
if TextMsg == 'المنشئين' then
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(4)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(MEZO.."MEZO:Originators:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ لا يوجد منشئين في البوت ","md",true)  
end
Redis:del(MEZO.."MEZO:Originators:Group"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم مسح ⟦ "..#Info_Members.." ⟧ من المنشئين *","md",true)
end
if TextMsg == 'المدراء' then
if not msg.Originators then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(5)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(MEZO.."MEZO:Managers:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ لا يوجد مدراء في البوت ","md",true)  
end
Redis:del(MEZO.."MEZO:Managers:Group"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم مسح ⟦ "..#Info_Members.." ⟧ من المدراء *","md",true)
end
if TextMsg == 'الادمنيه' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(6)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(MEZO.."MEZO:Addictive:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ لا يوجد ادمنيه في البوت ","md",true)  
end
Redis:del(MEZO.."MEZO:Addictive:Group"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم مسح ⟦ "..#Info_Members.." ⟧ من الادمنيه *","md",true)
end
if TextMsg == 'المميزين' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(MEZO.."MEZO:Distinguished:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ لا يوجد مميزين في البوت ","md",true)  
end
Redis:del(MEZO.."MEZO:Distinguished:Group"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم مسح ⟦ "..#Info_Members.." ⟧ من المميزين *","md",true)
end
if TextMsg == 'المحظورين عام' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(MEZO.."MEZO:JabwaAll:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ لا يوجد محظورين عام في البوت ","md",true)  
end
Redis:del(MEZO.."MEZO:JabwaAll:Groups") 
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم مسح ⟦ "..#Info_Members.." ⟧ من المحظورين عام *","md",true)
end
if TextMsg == 'المكتومين عام' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(MEZO.."MEZO:JabwaAll:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ لا يوجد مكتومين عام في البوت ","md",true)  
end
Redis:del(MEZO.."MEZO:ktmAll:Groups") 
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم مسح ⟦ "..#Info_Members.." ⟧ من المكتومين عام *","md",true)
end
if TextMsg == 'المحظورين' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(MEZO.."MEZO:JabwaGroup:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ لا يوجد محظورين في البوت ","md",true)  
end
Redis:del(MEZO.."MEZO:JabwaGroup:Group"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم مسح ⟦ "..#Info_Members.." ⟧ من المحظورين *","md",true)
end
if TextMsg == 'المطوردين' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(MEZO.."MEZO:MosTafa:Ahmed"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ لا يوجد مطردين في المجموعه ","md",true)  
end
Redis:del(MEZO.."MEZO:MosTafa:Ahmed"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم مسح ⟦ "..#Info_Members.." ⟧ من المطرودين *","md",true)
end
if TextMsg == 'المكتومين' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(MEZO.."MEZO:SilentGroup:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ لا يوجد مكتومين في البوت ","md",true)  
end
Redis:del(MEZO.."MEZO:SilentGroup:Group"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم مسح ⟦ "..#Info_Members.." ⟧ من المكتومين *","md",true)
end
if TextMsg == 'المقيدين' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if GetInfoBot(msg).JabwaUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Recent", "*", 0, 200)
local List_Members = Info_Members.members
x = 0
for k, v in pairs(List_Members) do
if Info_Members.members[k].status.is_member == true and Info_Members.members[k].status.luatele == "chatMemberStatusRestricted" then
LuaTele.setChatMemberStatus(msg.chat_id,v.member_id.user_id,'restricted',{1,1,1,1,1,1,1,1})
x = x + 1
end
end
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم مسح ⟦ "..x.." ⟧ من المقيديين *","md",true)
end
if TextMsg == 'المطرودين' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(6)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).JabwaUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Jabwaned", "*", 0, 200)
x = 0
local List_Members = Info_Members.members
for k, v in pairs(List_Members) do
UNJabwa_Bots = LuaTele.setChatMemberStatus(msg.chat_id,v.member_id.user_id,'restricted',{1,1,1,1,1,1,1,1,1})
if UNJabwa_Bots.luatele == "ok" then
x = x + 1
end
end
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عدد المطرودين في الموجوده : "..#List_Members.."\n ❍┃ تم الغاء طرد عن ⟦ "..x.." ⟧من الاشخاص*","md",true)  
end
if TextMsg == 'المحذوفين' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(6)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).JabwaUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
local Info_Members = LuaTele.searchChatMembers(msg_chat_id, "*", 200)
local List_Members = Info_Members.members
x = 0
for k, v in pairs(List_Members) do
local Jabwa = LuaTele.getUser(v.member_id.user_id)
if Jabwa.type.luatele == "userTypeDeleted" then
local userTypeDeleted = LuaTele.setChatMemberStatus(msg.chat_id,v.member_id.user_id,'Jabwaned',0)
if userTypeDeleted.luatele == "ok" then
x = x + 1
end
end
end
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ تم طرد ⟦ "..x.." ⟧حساب محذوف *","md",true)  
end
end

if text == "مسح الردود" or text == "حذف ردود" or text == "مسح ردود" then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(6)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(MEZO.."MEZO:List:Manager"..msg_chat_id.."")
for k,v in pairs(list) do
Redis:del(MEZO.."MEZO:Add:Rd:Manager:Gif"..v..msg_chat_id)   
Redis:del(MEZO.."MEZO:Add:Rd:Manager:Vico"..v..msg_chat_id)   
Redis:del(MEZO.."MEZO:Add:Rd:Manager:Stekrs"..v..msg_chat_id)     
Redis:del(MEZO.."MEZO:Add:Rd:Manager:Text"..v..msg_chat_id)   
Redis:del(MEZO.."MEZO:Add:Rd:Manager:Photo"..v..msg_chat_id)
Redis:del(MEZO.."MEZO:Add:Rd:Manager:Video"..v..msg_chat_id)
Redis:del(MEZO.."MEZO:Add:Rd:Manager:File"..v..msg_chat_id)
Redis:del(MEZO.."MEZO:Add:Rd:Manager:video_note"..v..msg_chat_id)
Redis:del(MEZO.."MEZO:Add:Rd:Manager:Audio"..v..msg_chat_id)
Redis:del(MEZO.."MEZO:List:Manager"..msg_chat_id)
end
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم مسح قائمه الردود *","md",true)  
end
if text == "الردود" or text == "قائمه ردود" or text == "قائمه الردود" then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(6)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(MEZO.."MEZO:List:Manager"..msg_chat_id.."")
text = " ❍┃ قائمه الردود ⇧⇩\n— — — — — — — — —\n"
for k,v in pairs(list) do
if Redis:get(MEZO.."MEZO:Add:Rd:Manager:Gif"..v..msg_chat_id) then
db = "متحركه 🎭"
elseif Redis:get(MEZO.."MEZO:Add:Rd:Manager:Vico"..v..msg_chat_id) then
db = "بصمه 📢"
elseif Redis:get(MEZO.."MEZO:Add:Rd:Manager:Stekrs"..v..msg_chat_id) then
db = "ملصق 🃏"
elseif Redis:get(MEZO.."MEZO:Add:Rd:Manager:Text"..v..msg_chat_id) then
db = "رساله ✉"
elseif Redis:get(MEZO.."MEZO:Add:Rd:Manager:Photo"..v..msg_chat_id) then
db = "صوره 🎇"
elseif Redis:get(MEZO.."MEZO:Add:Rd:Manager:Video"..v..msg_chat_id) then
db = "فيديو 📹"
elseif Redis:get(MEZO.."MEZO:Add:Rd:Manager:File"..v..msg_chat_id) then
db = "ملف ❍┃ "
elseif Redis:get(MEZO.."MEZO:Add:Rd:Manager:Audio"..v..msg_chat_id) then
db = "اغنيه 🎵"
elseif Redis:get(MEZO.."MEZO:Add:Rd:Manager:video_note"..v..msg_chat_id) then
db = "بصمه فيديو 🎥"
end
text = text..""..k.." -›⟦ "..v.." ⟧-›⟦ "..db.." ⟧\n"
end
if #list == 0 then
text = " ❍┃ لا يوجد ردود في المجموعه"
end
return LuaTele.sendText(msg_chat_id,msg_id,"["..text.."]","md",true)  
end
if text == "اضف رد" then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id,true)
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ ارسل الان الكلمه لاضافتها في ردود *","md",true)  
end
if text == "حذف رد" then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id,"true2")
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ ارسل الان الكلمه لحذفها من ردود *","md",true)  
end
if text == "مسح الردود العامه" or text == "حذف الردود العامه" or text == "مسح الردود العامه" then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(MEZO.."MEZO:List:Rd:Sudo")
for k,v in pairs(list) do
Redis:del(MEZO.."MEZO:Add:Rd:Sudo:Gif"..v)   
Redis:del(MEZO.."MEZO:Add:Rd:Sudo:vico"..v)   
Redis:del(MEZO.."MEZO:Add:Rd:Sudo:stekr"..v)     
Redis:del(MEZO.."MEZO:Add:Rd:Sudo:Text"..v)   
Redis:del(MEZO.."MEZO:Add:Rd:Sudo:Photo"..v)
Redis:del(MEZO.."MEZO:Add:Rd:Sudo:Video"..v)
Redis:del(MEZO.."MEZO:Add:Rd:Sudo:File"..v)
Redis:del(MEZO.."MEZO:Add:Rd:Sudo:Audio"..v)
Redis:del(MEZO.."MEZO:Add:Rd:Sudo:video_note"..v)
Redis:del(MEZO.."MEZO:List:Rd:Sudo")
end
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم حذف قائمه الردود العامه *","md",true)  
end
if text == "الردود العامه" or text == "الردود العامه" or text == "ردود عامه" then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(MEZO.."MEZO:List:Rd:Sudo")
text = "\n ❍┃ قائمة الردود العامه ⇧⇩\n— — — — — — — — —\n"
for k,v in pairs(list) do
if Redis:get(MEZO.."MEZO:Add:Rd:Sudo:Gif"..v) then
db = "متحركه 🎭"
elseif Redis:get(MEZO.."MEZO:Add:Rd:Sudo:vico"..v) then
db = "بصمه 📢"
elseif Redis:get(MEZO.."MEZO:Add:Rd:Sudo:stekr"..v) then
db = "ملصق 🃏"
elseif Redis:get(MEZO.."MEZO:Add:Rd:Sudo:Text"..v) then
db = "رساله ✉"
elseif Redis:get(MEZO.."MEZO:Add:Rd:Sudo:Photo"..v) then
db = "صوره 🎇"
elseif Redis:get(MEZO.."MEZO:Add:Rd:Sudo:Video"..v) then
db = "فيديو 📹"
elseif Redis:get(MEZO.."MEZO:Add:Rd:Sudo:File"..v) then
db = "ملف ❍┃ "
elseif Redis:get(MEZO.."MEZO:Add:Rd:Sudo:Audio"..v) then
db = "اغنيه 🎵"
elseif Redis:get(MEZO.."MEZO:Add:Rd:Sudo:video_note"..v) then
db = "بصمه فيديو 🎥"
end
text = text..""..k.." -›⟦ "..v.." ⟧-›⟦ "..db.." ⟧\n"
end
if #list == 0 then
text = " ❍┃ لا توجد ردود عامه"
end
return LuaTele.sendText(msg_chat_id,msg_id,"["..text.."]","md",true)  
end
if text == "اضف رد عام" then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Set:Rd"..msg.sender.user_id..":"..msg_chat_id,true)
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ ارسل الان الكلمه لاضافتها في الردود العامه *","md",true)  
end
if text == "حذف رد عام" or text == "مسح رد عام" then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Set:On"..msg.sender.user_id..":"..msg_chat_id,true)
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ ارسل الان الكلمه لحذفها من الردود العامه *","md",true)  
end
if text=="اذاعه خاص" then 
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص⟦ '..Controller_Num(2)..' ⟧* ',"md",true)  
end
if not msg.ControllerBot and not Redis:set(MEZO.."SendBcBot") then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ الاذاعه معطله من قبل المطور الاساسي *',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(MEZO.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(MEZO.."Broadcasting:Users" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
LuaTele.sendText(msg_chat_id,msg_id,[[*
 ❍┃ ارسل اذاعتك لنشرها في أعضاء خاص البوت 
 ❍┃ للخروج من الامر ارسل ⟦الغاء⟧
*]],"md",true)  
return false
end

if text=="اذاعه" then 
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص⟦ '..Controller_Num(2)..' ⟧* ',"md",true)  
end
if not msg.ControllerBot and not Redis:set(MEZO.."SendBcBot") then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ الاذاعه معطله من قبل المطور الاساسي *',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(MEZO.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(MEZO.."Broadcasting:Groups" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
LuaTele.sendText(msg_chat_id,msg_id,[[*
 ❍┃ ارسل اذاعتك لنشرها في الجروبات 
 ❍┃ للخروج من الامر ارسل ⟦الغاء⟧
*]],"md",true)  
return false
end

if text=="اذاعه بالتثبيت" then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(MEZO.."MEZO:Broadcasting:Groups:Pin" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
LuaTele.sendText(msg_chat_id,msg_id,[[
 ❍┃ ارسل اذاعتك لتثبيت في الجروبات 
 ❍┃ للخروج من الامر ارسل ⟦الغاء⟧
]],"md",true)  
return false
end

if text=="اذاعه بالتوجيه" then 
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص⟦ '..Controller_Num(2)..' ⟧* ',"md",true)  
end
if not msg.ControllerBot and not Redis:set(MEZO.."SendBcBot") then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ الاذاعه معطله من قبل المطور الاساسي *',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(MEZO.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(MEZO.."Broadcasting:Groups:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ ارسل لي التوجيه الان*\n* ❍┃ ليتم نشره في المجموعات*\n* ❍┃ للخروج من الامر ارسل⟦الغاء⟧*","md",true)  
return false
end

if text=="اذاعه بالتوجيه خاص" then 
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص⟦ '..Controller_Num(2)..' ⟧* ',"md",true)  
end
if not msg.ControllerBot and not Redis:set(MEZO.."SendBcBot") then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ الاذاعه معطله من قبل المطور الاساسي *',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(MEZO.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(MEZO.."Broadcasting:Users:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ ارسل لي التوجيه الان*\n* ❍┃ ليتم نشره الى اضاء خاص البوت*\n* ❍┃ للخروج من الامر ارسل⟦الغاء⟧*","md",true)  
return false
end
if text and text:match("(.*)(مين ضافني)(.*)") then
local StatusMember = LuaTele.getChatMember(msg_chat_id,msg.sender.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ انت منشئ المجموعه*","md",true) 
end
local Added_Me = Redis:get(MEZO.."Who:Added:Me"..msg_chat_id..':'..msg.sender.user_id)
if Added_Me then 
UserInfo = LuaTele.getUser(Added_Me)
local Name = '['..UserInfo.first_name..'](tg://user?id='..Added_Me..')'
Text = ' ❍┃ الشخص الذي قام باضافتك هو -› '..Name
return LuaTele.sendText(msg_chat_id,msg_id,Text,"md",true) 
else
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ انت دخلت عبر الرابط محدش ضافك*","md",true) 
end
end
if text == 'بيقول اي' or text == "قال اي" or text == "يقول اي" or text == "وش يقول" then  
if tonumber(msg.reply_to_message_id) > 0 then 
local result = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id) 
if result.content.voice_note then  
local rep = msg.id/2097152/0.5 
https.request("https://api.medooo.ml/leomedo/voiceRecognise?token="..Token.."&chat_id="..msg_chat_id.."&file_id="..result.content.voice_note.voice.remote.id.."&msg_id="..rep) 
end 
end 
end
if Redis:get(MEZO.."youtube"..msg.sender.user_id..msg_chat_id) == "mp3" then
local rep = msg.id/2097152/0.5
local m = rep +1
https.request("https://api.telegram.org/bot"..Token.."/sendAnimation?chat_id="..msg_chat_id.."&animation=https://t.me/youtube7odabot/7951&reply_to_message_id="..rep)
https.request("https://api.medooo.ml/leomedo/yt?text="..URL.escape(text).."&token="..Token.."&msg_id="..rep.."&chat_id="..msg_chat_id.."&type=mp3")
https.request("https://api.telegram.org/bot"..Token.."/deleteMessage?chat_id="..msg_chat_id.."&message_id="..m)
Redis:del(MEZO.."youtube"..msg.sender.user_id..msg_chat_id)
end
if Redis:get(MEZO.."youtube"..msg.sender.user_id..msg_chat_id) == "mp4" then
local rep = msg.id/2097152/0.5
local m = rep +1
https.request("https://api.telegram.org/bot"..Token.."/sendAnimation?chat_id="..msg_chat_id.."&animation=https://t.me/youtube7odabot/7951&reply_to_message_id="..rep)
https.request("https://api.medooo.ml/leomedo/yt?text="..URL.escape(text).."&token="..Token.."&msg_id="..rep.."&chat_id="..msg_chat_id.."&type=mp4")
https.request("https://api.telegram.org/bot"..Token.."/deleteMessage?chat_id="..msg_chat_id.."&message_id="..m)
Redis:del(MEZO.."youtube"..msg.sender.user_id..msg_chat_id)
end
if text == "مواقيت الصلاه" then
slwat = https.request("https://mahmoudm50.xyz/anubis/pray.php?city=cairo")
salawat = JSON.decode(slwat)
pray_times = salawat['results']['datetime'][1]['times']
Fajr = pray_times['Fajr']
Dhuhr = pray_times['Dhuhr']
Asr = pray_times['Asr']
Maghrib = pray_times['Maghrib']
Isha = pray_times['Isha']
return LuaTele.sendText(msg_chat_id,msg_id, "* ❍┃ مواقيت الصلاه *\n* ▁ ▂ ▉ ▄ ▅ ▆ ▇ ▅ ▆ ▇ █ ▉ ▂ ▁*\n".."* الفجر -› *"..Fajr.."\n* الظهر -› *"..Dhuhr.."\n* العصر -› *"..Asr.."\n* المغرب -› *"..Maghrib.."\n* العشاء -› *"..Isha.."\n* ▁ ▂ ▉ ▄ ▅ ▆ ▇ ▅ ▆ ▇ █ ▉ ▂ ▁*\n* حسب التوقيت المحلي لمدينه القاهره*","md",true)
end

time = os.date("*t")
hour = time.hour
min = time.min
sec = time.sec
local_time = hour..":"..min
list_zkr = Redis:smembers(MEZO.."ChekBotAdd")

if local_time then
if local_time == "0:0" and not Redis:get(MEZO.."0:done") then -- الساعه 12 منتصف الليل 
for k,v in pairs(list_zkr) do 
LuaTele.sendText(v,0, "اشهد ان لا اله الا الله وان سيدنا محمد رسول الله","md",true)  
end
Redis:set(MEZO.."0:done", true)
for i = 1 , 23 ,1 do 
Redis:del(MEZO..i..":done")
end
end
if local_time == "1:0" and not Redis:get(MEZO.."1:done") then -- الساعه 1 بعد منتصف الليل
for k,v in pairs(list_zkr) do 
LuaTele.sendText(v,0, "اشهد ان لا اله الا الله وان سيدنا محمد رسول الله","md",true)  
end
Redis:set(MEZO.."1:done", true)
end
if local_time == "2:0" and not Redis:get(MEZO.."2:done") then -- الساعه 2 بعد منتصف الليل
for k,v in pairs(list_zkr) do 
LuaTele.sendText(v,0, "اشهد ان لا اله الا الله وان سيدنا محمد رسول الله","md",true)  
end
Redis:set(MEZO.."2:done", true)
end
if local_time == "3:0" and not Redis:get(MEZO.."3:done") then -- الساعه 3 بعد منتصف الليل
for k,v in pairs(list_zkr) do 
LuaTele.sendText(v,0, "اشهد ان لا اله الا الله وان سيدنا محمد رسول الله","md",true)  
end
Redis:set(MEZO.."3:done", true)
end
if local_time == "4:0" and not Redis:get(MEZO.."4:done") then -- الساعه 4 بعد منتصف الليل
for k,v in pairs(list_zkr) do 
LuaTele.sendText(v,0, "اشهد ان لا اله الا الله وان سيدنا محمد رسول الله","md",true)  
end
Redis:set(MEZO.."4:done", true)
end
if local_time == "5:0" and not Redis:get(MEZO.."5:done") then -- الساعه 5 صباحا
for k,v in pairs(list_zkr) do 
LuaTele.sendText(v,0, "اشهد ان لا اله الا الله وان سيدنا محمد رسول الله","md",true)  
end
Redis:set(MEZO.."5:done", true)
end
if local_time == "6:0" and not Redis:get(MEZO.."6:done") then -- الساعه 6 صباحا
for k,v in pairs(list_zkr) do 
LuaTele.sendText(v,0, "اشهد ان لا اله الا الله وان سيدنا محمد رسول الله","md",true)  
end
Redis:set(MEZO.."6:done", true)
end
if local_time == "7:0" and not Redis:get(MEZO.."7:done") then -- الساعه 7 صباحا
for k,v in pairs(list_zkr) do 
LuaTele.sendText(v,0, "اشهد ان لا اله الا الله وان سيدنا محمد رسول الله","md",true)  
end
Redis:set(MEZO.."7:done", true)
end
if local_time == "8:0" and not Redis:get(MEZO.."8:done") then -- الساعه 8 صباحا
for k,v in pairs(list_zkr) do 
LuaTele.sendText(v,0, "اشهد ان لا اله الا الله وان سيدنا محمد رسول الله","md",true)  
end
Redis:set(MEZO.."8:done", true)
end
if local_time == "9:0" and not Redis:get(MEZO.."9:done") then -- الساعه 9 صباحا
for k,v in pairs(list_zkr) do 
LuaTele.sendText(v,0, "اشهد ان لا اله الا الله وان سيدنا محمد رسول الله","md",true)  
end
Redis:set(MEZO.."8:done", true)
end
if local_time == "10:0" and not Redis:get(MEZO.."10:done") then -- الساعه 10 صباحا
for k,v in pairs(list_zkr) do 
LuaTele.sendText(v,0, "اشهد ان لا اله الا الله وان سيدنا محمد رسول الله","md",true)  
end
Redis:set(MEZO.."10:done", true)
end
if local_time == "11:0" and not Redis:get(MEZO.."11:done") then -- الساعه 11 صباحا
for k,v in pairs(list_zkr) do 
LuaTele.sendText(v,0, "اشهد ان لا اله الا الله وان سيدنا محمد رسول الله","md",true)  
end
Redis:set(MEZO.."11:done", true)
end
if local_time == "12:0" and not Redis:get(MEZO.."12:done") then -- الساعه 12 ظهرا
for k,v in pairs(list_zkr) do 
LuaTele.sendText(v,0, "اشهد ان لا اله الا الله وان سيدنا محمد رسول الله","html",true)  
end
Redis:set(MEZO.."12:done", true)
end
if local_time == "13:0" and not Redis:get(MEZO.."13:done") then -- الساعه 1 مسائا
for k,v in pairs(list_zkr) do
LuaTele.sendText(v,0, "اشهد ان لا اله الا الله وان سيدنا محمد رسول الله","md",true)  
end
Redis:set(MEZO.."13:done", true)
end
if local_time == "14:0" and not Redis:get(MEZO.."14:done") and not Redis:get(MEZO.."14:done") then -- الساعه 2 مسائا
for k,v in pairs(list_zkr) do 
LuaTele.sendText(v,0, "اشهد ان لا اله الا الله وان سيدنا محمد رسول الله","md",true)
end
Redis:set(MEZO.."14:done", true)
end
if local_time == "15:0" and not Redis:get(MEZO.."15:done") then -- الساعه 3 مسائا
for k,v in pairs(list_zkr) do 
LuaTele.sendText(v,0, "اشهد ان لا اله الا الله وان سيدنا محمد رسول الله","md",true)  
end
Redis:set(MEZO.."15:done", true)
end
if local_time == "16:0" and not Redis:get(MEZO.."16:done") then -- الساعه 4 مسائا
for k,v in pairs(list_zkr) do 
LuaTele.sendText(v,0, "اشهد ان لا اله الا الله وان سيدنا محمد رسول الله","md",true)  
end
Redis:set(MEZO.."16:done", true)
end
if local_time == "17:0" and not Redis:get(MEZO.."17:done") then -- الساعه 5 مسائا
for k,v in pairs(list_zkr) do 
LuaTele.sendText(v,0, "اشهد ان لا اله الا الله وان سيدنا محمد رسول الله","md",true)  
end
Redis:set(MEZO.."17:done", true)
end
if local_time == "18:0" and not Redis:get(MEZO.."18:done") then -- الساعه 6 مسائا
for k,v in pairs(list_zkr) do 
LuaTele.sendText(v,0, "اشهد ان لا اله الا الله وان سيدنا محمد رسول الله","md",true)  
end
Redis:set(MEZO.."18:done", true)
end
if local_time == "19:0" and not Redis:get(MEZO.."19:done") then -- الساعه 7 مسائا
for k,v in pairs(list_zkr) do 
LuaTele.sendText(v,0, "اشهد ان لا اله الا الله وان سيدنا محمد رسول الله","md",true)  
end
Redis:set(MEZO.."19:done", true)
end
if local_time == "20:0" and not Redis:get(MEZO.."20:done") then -- الساعه 8 مسائا
for k,v in pairs(list_zkr) do 
LuaTele.sendText(v,0, "اشهد ان لا اله الا الله وان سيدنا محمد رسول الله","md",true)  
end
Redis:set(MEZO.."20:done", true)
end
if local_time == "21:0" and not Redis:get(MEZO.."21:done") then -- الساعه 9 مسائا
for k,v in pairs(list_zkr) do 
LuaTele.sendText(v,0, "اشهد ان لا اله الا الله وان سيدنا محمد رسول الله","md",true)  
end
Redis:set(MEZO.."21:done", true)
end
if local_time == "22:0" and not Redis:get(MEZO.."22:done") then -- الساعه 10 مسائا
for k,v in pairs(list_zkr) do 
LuaTele.sendText(v,0, "اشهد ان لا اله الا الله وان سيدنا محمد رسول الله","md",true)  
end
Redis:set(MEZO.."22:done", true)
end
if local_time == "23:0" and not Redis:get(MEZO.."23:done") then -- الساعه 11 مسائا
for k,v in pairs(list_zkr) do 
LuaTele.sendText(v,0, "اشهد ان لا اله الا الله وان سيدنا محمد رسول الله","md",true)  
end
Redis:set(MEZO.."23:done", true)
end
end
if text == 'كشف القيود' and msg.reply_to_message_id ~= 0 then
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local Jabwa = LuaTele.getUser(Message_Reply.sender.user_id)
if Jabwa.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if Jabwa and Jabwa.type and Jabwa.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام الامر على البوت ","md",true)  
end
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local GetMemberStatus = LuaTele.getChatMember(msg_chat_id,Message_Reply.sender.user_id).status
if GetMemberStatus.luatele == "chatMemberStatusRestricted" then
Restricted = 'مقيد'
else
Restricted = 'غير مقيد'
end
if Statusrestricted(msg_chat_id,Message_Reply.sender.user_id).JabwaAll == true then
JabwaAll = 'محظور عام'
else
JabwaAll = 'غير محظور عام'
end
if Statusrestricted(msg_chat_id,Message_Reply.sender.user_id).JabwaGroup == true then
JabwaGroup = 'محظور'
else
JabwaGroup = 'غير محظور'
end
if Statusrestricted(msg_chat_id,Message_Reply.sender.user_id).SilentGroup == true then
SilentGroup = 'مكتوم'
else
SilentGroup = 'غير مكتوم'
end
LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ معلومات الكشف \n— — — — — — — — —"..'\n ❍┃ الحظر العام : '..JabwaAll..'\n ❍┃ الحظر : '..JabwaGroup..'\n ❍┃ الكتم : '..SilentGroup..'\n ❍┃ التقييد : '..Restricted..'*',"md",true)  
end
if text and text:match('^كشف القيود @(%S+)$') then
local UserName = text:match('^كشف القيود @(%S+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام معرف البوت ","md",true)  
end
local GetMemberStatus = LuaTele.getChatMember(msg_chat_id,UserId_Info.id).status
if GetMemberStatus.luatele == "chatMemberStatusRestricted" then
Restricted = 'مقيد'
else
Restricted = 'غير مقيد'
end
if Statusrestricted(msg_chat_id,UserId_Info.id).JabwaAll == true then
JabwaAll = 'محظور عام'
else
JabwaAll = 'غير محظور عام'
end
if Statusrestricted(msg_chat_id,UserId_Info.id).JabwaGroup == true then
JabwaGroup = 'محظور'
else
JabwaGroup = 'غير محظور'
end
if Statusrestricted(msg_chat_id,UserId_Info.id).SilentGroup == true then
SilentGroup = 'مكتوم'
else
SilentGroup = 'غير مكتوم'
end
LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ معلومات الكشف \n— — — — — — — — —"..'\n ❍┃ الحظر العام : '..JabwaAll..'\n ❍┃ الحظر : '..JabwaGroup..'\n ❍┃ الكتم : '..SilentGroup..'\n ❍┃ التقييد : '..Restricted..'*',"md",true)  
end
if text == 'رفع القيود' and msg.reply_to_message_id ~= 0 then
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local Jabwa = LuaTele.getUser(Message_Reply.sender.user_id)
if Jabwa.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if Jabwa and Jabwa.type and Jabwa.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام الامر على البوت ","md",true)  
end
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local GetMemberStatus = LuaTele.getChatMember(msg_chat_id,Message_Reply.sender.user_id).status
if GetMemberStatus.luatele == "chatMemberStatusRestricted" then
Restricted = 'مقيد'
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'restricted',{1,1,1,1,1,1,1,1})
else
Restricted = ''
end
if Statusrestricted(msg_chat_id,Message_Reply.sender.user_id).JabwaAll == true and msg.ControllerBot then
JabwaAll = 'محظور عام ,'
Redis:srem(MEZO.."MEZO:JabwaAll:Groups",Message_Reply.sender.user_id) 
else
JabwaAll = ''
end
if Statusrestricted(msg_chat_id,Message_Reply.sender.user_id).JabwaGroup == true then
JabwaGroup = 'محظور ,'
Redis:srem(MEZO.."MEZO:JabwaGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) 
else
JabwaGroup = ''
end
if Statusrestricted(msg_chat_id,Message_Reply.sender.user_id).SilentGroup == true then
SilentGroup = 'مكتوم ,'
Redis:srem(MEZO.."MEZO:SilentGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) 
else
SilentGroup = ''
end
LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ تم رفع القيود عنه : ⟦ "..JabwaAll..JabwaGroup..SilentGroup..Restricted..'}*',"md",true)  
end
if text and text:match('^رفع القيود @(%S+)$') then
local UserName = text:match('^رفع القيود @(%S+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ عذرا البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام معرف البوت ","md",true)  
end
local GetMemberStatus = LuaTele.getChatMember(msg_chat_id,UserId_Info.id).status
if GetMemberStatus.luatele == "chatMemberStatusRestricted" then
Restricted = 'مقيد'
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,1,1,1,1,1,1,1})
else
Restricted = ''
end
if Statusrestricted(msg_chat_id,UserId_Info.id).JabwaAll == true and msg.ControllerBot then
JabwaAll = 'محظور عام ,'
Redis:srem(MEZO.."MEZO:JabwaAll:Groups",UserId_Info.id) 
else
JabwaAll = ''
end
if Statusrestricted(msg_chat_id,UserId_Info.id).JabwaGroup == true then
JabwaGroup = 'محظور ,'
Redis:srem(MEZO.."MEZO:JabwaGroup:Group"..msg_chat_id,UserId_Info.id) 
else
JabwaGroup = ''
end
if Statusrestricted(msg_chat_id,UserId_Info.id).SilentGroup == true then
SilentGroup = 'مكتوم ,'
Redis:srem(MEZO.."MEZO:SilentGroup:Group"..msg_chat_id,UserId_Info.id) 
else
SilentGroup = ''
end
LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ تم رفع القيود عنه : ⟦ "..JabwaAll..JabwaGroup..SilentGroup..Restricted..'}*',"md",true)  
end

if text == 'وضع كليشه المطور' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO..'MEZO:GetTexting:DevMEZO'..msg_chat_id..':'..msg.sender.user_id,true)
return LuaTele.sendText(msg_chat_id,msg_id,' ❍┃ ارسل لي الكليشه الان')
end
if text == 'مسح كليشة المطور' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(MEZO..'MEZO:Texting:DevMEZO')
return LuaTele.sendText(msg_chat_id,msg_id,' ❍┃ تم حذف كليشه المطور')
end
if text == 'جمالي' or text == 'نسبه جمالي' then
if not Redis:get(MEZO.."Status:gamle"..msg_chat_id) then
return false
end
local Jabwa = LuaTele.getUser(msg.sender.user_id)
local photo = LuaTele.getUserProfilePhotos(msg.sender.user_id)
local nspp = {"10","20","30","35","75","34","66","82","23","19","55","80","63","32","27","89","99","98","79","100","8","3","6","0",}
local rdbhoto = nspp[math.random(#nspp)]
if photo.total_count > 0 then
data = {} 
data.inline_keyboard = {
{
{text = 'نسبه جمالك يا قمر '..rdbhoto..' 🥺♥️',url = "https://t.me/"..Jabwa.username..""}, 
},
}
local msgg = msg_id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id=" .. msg_chat_id .. "&photo="..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id.."&photo=".. URL.escape(rdbhoto).."&reply_to_message_id="..msgg.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(data))
end
end
if text == "صورتي" then
if Redis:get(MEZO.."Status:photo"..msg.chat_id) then
local photo = LuaTele.getUserProfilePhotos(msg.sender.user_id)
local ban = LuaTele.getUser(msg.sender.user_id)
local ban_ns = '🔎•●•●•●•●صورك●•●•●•●•🔍'
if photo.total_count > 0 then
data = {} 
data.inline_keyboard = {
{
{text = '- اخفاء الامر ', callback_data = msg.sender.user_id..'/ban88'}, 
},
{
{text = '📈 • صورتك القادمه • 📉', callback_data= msg.sender.user_id..'/ban1'}, 
},
}
local msgg = msg_id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id=" .. msg_chat_id .. "&photo="..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id.."&caption=".. URL.escape(ban_ns).."&reply_to_message_id="..msgg.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(data))
end
end
end

if text == "غنيلي" or text == "غني" then
local t = "*اليك اغنيه عشوائيه من البوت*"
Num = math.random(8,83)
Mhm = math.random(108,143)
Mhhm = math.random(166,179)
Mmhm = math.random(198,216)
Mhmm = math.random(257,626)
local Texting = {Num,Mhm,Mhhm,Mmhm,Mhmm}
local Rrr = Texting[math.random(#Texting)]
local m = "https://t.me/mmsst13/"..Rrr..""
local rep = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendaudio?chat_id="..msg_chat_id.."&caption="..URL.escape(t).."&audio="..m.."&reply_to_message_id="..rep.."&parse_mode=Markdown")
end
if text == "استوري" then
Rrr = math.random(4,50)
local m = "https://t.me/Qapplu/"..Rrr..""
local t = "اليك استوري عشوائي من البوت 🖇️🌚"
local rep = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendaudio?chat_id="..msg_chat_id.."&caption="..URL.escape(t).."&audio="..m.."&reply_to_message_id="..rep.."&parse_mode=Markdown")
end
if text == "غنيلي فيديو" or text == "غنيلي بفيديو" then
Rrr = math.random(1,31)
local m = "https://t.me/ghanilyp/"..Rrr..""
local t = "اليك اغنيه ب فيديو🏴‍☠️♥️"
local rep = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendaudio?chat_id="..msg_chat_id.."&caption="..URL.escape(t).."&audio="..m.."&reply_to_message_id="..rep.."&parse_mode=Markdown")
end
if text == 'Barloo' then
local UserId_Info = LuaTele.searchPublicChat("bar_lo0o0")
if UserId_Info.id then
local UserInfo = LuaTele.getUser(UserId_Info.id)
local InfoUser = LuaTele.getUserFullInfo(UserId_Info.id)
if InfoUser.bio then
Bio = InfoUser.bio
else
Bio = ''
end
local photo = LuaTele.getUserProfilePhotos(UserId_Info.id)
if photo.total_count > 0 then
local TestText = "  \n\n- ["..UserInfo.first_name.."](tg://user?id="..UserId_Info.id..")\n\n ["..Bio.."]"
local msg_id = msg.id/2097152/0.5 
return https.request("https://api.telegram.org/bot"..Token..'/sendPhoto?chat_id='..msg.chat_id..'&caption='..URL.escape(TestText)..'&photo='..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id..'&reply_to_message_id='..msg_id..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboardd))
else
local TestText = "  \\nn- ["..UserInfo.first_name.."](tg://user?id="..UserId_Info.id..")\n\n ["..Bio.."]"
local msg_id = msg.id/2097152/0.5 
return https.request("https://api.telegram.org/bot"..Token..'/sendMessage?chat_id=' .. msg.chat_id .. '&text=' .. URL.escape(TestText).."&reply_to_message_id="..msg_id..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboardd))
end
end
end
if text == "ميمز" or text == "ميمزز" then 
Abs = math.random(2,140); 
local Text ='*᥀︙تم اختيار الميمز لك*'
local MsgId = msg.id/2097152/0.5
local MSGID = string.gsub(MsgId,'.0','')
https.request("https://api.telegram.org/bot"..Token..'/sendVoice?chat_id=' .. msg.chat_id .. '&voice=https://t.me/MemzDavid/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..MsgId.."&parse_mode=markdown") 
end
if text == "فلم" or text == "افلام" then 
Abs = math.random(2,140); 
local Text ='*᥀︙تم اختيار الفلم لك*'
local MsgId = msg.id/2097152/0.5
local MSGID = string.gsub(MsgId,'.0','')
https.request("https://api.telegram.org/bot"..Token..'/sendphoto?chat_id=' .. msg.chat_id .. '&photo=https://t.me/MoviesDavid/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..MsgId.."&parse_mode=markdown") 
end
if text == "انمي" or text == "انمى" then 
Abs = math.random(2,140); 
local Text ='*᥀︙تم اختيار انمي لك*'
local MsgId = msg.id/2097152/0.5
local MSGID = string.gsub(MsgId,'.0','')
https.request("https://api.telegram.org/bot"..Token..'/sendphoto?chat_id=' .. msg.chat_id .. '&photo=https://t.me/AnimeDavid/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..MsgId.."&parse_mode=markdown") 
end
if text == "صوره" or text == "صورة" then 
Abs = math.random(2,140); 
local Text ='*᥀︙تم اختيار صوره لك*'
local MsgId = msg.id/2097152/0.5
local MSGID = string.gsub(MsgId,'.0','')
https.request("https://api.telegram.org/bot"..Token..'/sendphoto?chat_id=' .. msg.chat_id .. '&photo=https://t.me/PhotosDavid/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..MsgId.."&parse_mode=markdown") 
end
if text == "متحركه" or text == "متحركة" then 
Abs = math.random(2,140); 
local Text ='*᥀︙تم اختيار متحركه لك*'
local MsgId = msg.id/2097152/0.5
local MSGID = string.gsub(MsgId,'.0','')
https.request("https://api.telegram.org/bot"..Token..'/sendanimation?chat_id=' .. msg.chat_id .. '&animation=https://t.me/GifDavid/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..MsgId.."&parse_mode=markdown") 
end
if text == "ريمكس" or text == "ريماكس" then 
Abs = math.random(2,140); 
local Text ='*᥀︙تم اختيار ريمكس لك*'
local MsgId = msg.id/2097152/0.5
local MSGID = string.gsub(MsgId,'.0','')
https.request("https://api.telegram.org/bot"..Token..'/sendVoice?chat_id=' .. msg.chat_id .. '&voice=https://t.me/RemixDavid/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..MsgId.."&parse_mode=markdown") 
end
if text == "شعر" then
Abs = math.random(2,140); 
local Text ='*✘︙︙تم اختيار الشعر لك فقط*'
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '-  •●•●• .',url="t.me/cristin_so"}},
}
local msg_id = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendVoice?chat_id=' .. msg.chat_id .. '&voice=https://t.me/QQNNSX/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
if text == 'السورس' or text == 'سورس' or text == 'يا سورس' or text == 'source' then
video = "https://t.me/swry00/35"
local T =[[
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
 [🚨╎𝚆𝙴𝙻𝙲𝙾𝙼𝙴 𝚃𝙾 𝚂𝙾𝚄𝚁𝙲𝙴 𝘤𝘳𝘪𝘴𝘵𝘪𝘯](t.me/cristin_so)

 [⚙╎𝚃𝙷𝙴 𝙱𝙴𝚂𝚃 𝚂𝙾𝚄𝚁𝙲𝙴 𝙾𝙽 𝙴𝙶𝚈𝙿𝚃](t.me/cristin_so)
 
  [⚡╎𝚁𝚄𝙽 𝚈𝙾𝚄𝚁 𝙱𝙾𝚃 𝚆𝙸𝚃𝙷 𝚄𝚂 𝙽𝙾𝚆](t.me/cristin_so)
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
 [◍ 𝐶𝐻 " 𝘊𝘙𝘐𝘚𝘛𝘐𝘕 𝘚𝘖𝘜𝘙𝘊𝘌 ◍](t.me/cristin_so)
 ──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '• ¹𝘋𝘌𝘝 𝘊𝘙𝘐𝘚𝘛𝘐𝘕 •', url = "https://t.me/O0o_marshmloo_o0O"},{text = '• ²𝘋𝘌𝘝 𝘉𝘈𝘙𝘓𝘖 •', url = "https://t.me/bar_lo0o0"}
},
{
{text = 'ঌ ᴄʀɪѕᴛɪɴ • ʙᴏᴛ ঌ', url = "https://t.me/Anossnn_bot"},{text = 'ঌ ʙᴀʀʟᴏ • ʙᴏᴛ ঌ', url = "https://t.me/barlo0o_bot"}
},
{
{text = '⧫ 𝘊𝘙𝘐𝘚𝘛𝘐𝘕 • 𝘚𝘖𝘜𝘙𝘊𝘌 ⧫', url = "https://t.me/cristin_so"}
},
}
local msgg = msg_id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendvideo?chat_id=" .. msg_chat_id .. "&video="..video.."&caption=".. URL.escape(T).."&reply_to_message_id="..msgg.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
elseif text == 'بارلو' or text == 'DEV • BARLO' or text == 'مطور السورس' or text == 'المطور بارلو' then
photo = "https://t.me/bar_lo0o0"
local Name = 'ᴘʀᴏɢʀᴀᴍᴍᴇʀ • 𝘋𝘌𝘝 𝘉𝘈𝘙𝘓𝘖 • \n ᴛᴏ ᴄᴏᴍᴍụɴɪᴄᴀᴛᴇ ᴛᴏɢᴇᴛʜᴇʀ, \nғᴏʟʟᴏᴡ ᴛʜᴇ ʙụᴛᴛᴏɴѕ ʟᴏᴡᴇʀ 𝅘𝅥𝅯 '
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '◈ ℻ᗪEᐯ • ᗷᗩᖇᒪO℻ ◈', url = "https://t.me/bar_lo0o0"}
},
}
local msgg = msg_id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id=" .. msg_chat_id .. "&photo="..photo.."&caption=".. URL.escape(Name).."&reply_to_message_id="..msgg.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
elseif text == 'كرستين' or text == 'جيرسي' or text == 'كرستينا' then
photo = "https://t.me/O0o_marshmloo_o0O"
local Name = 'ᴘʀᴏɢʀᴀᴍᴍᴇʀ ঌ ᴄʀɪѕᴛɪɴ • ঌ ᴄᴏᴍᴍụɴɪᴄᴀᴛᴇ ᴛᴏɢᴇᴛʜᴇʀ, \nғᴏʟʟᴏᴡ ᴛʜᴇ ʙụᴛᴛᴏɴѕ ʟᴏᴡᴇʀ 💅💛 '
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '◈ ℻ᗪEᐯ • ᑕᖇI𝘚TIᑎ℻ ◈', url = "https://t.me/O0o_marshmloo_o0O"}
},
}
local msgg = msg_id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id=" .. msg_chat_id .. "&photo="..photo.."&caption=".. URL.escape(Name).."&reply_to_message_id="..msgg.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
elseif text == 'باقي الاستكمال' or text == 'باقي الاستكمال' then
photo = "https://t.me/S_A_S_A_1"
local Name = '𝑾𝑬𝑳𝑪𝑶𝑴𝑬 𝑻𝑶 𝒀𝑶𝒁𝑨𝑹𝑻 𝐒𝐀𝐒𝐀‌🏴‍☠️ '
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '℻ 𝐒𝐀𝐒𝐀‌ ➪🏴‍☠️ ℻', url = "https://t.me/S_A_S_A_1"}
},
}
local msgg = msg_id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id=" .. msg_chat_id .. "&photo="..photo.."&caption=".. URL.escape(Name).."&reply_to_message_id="..msgg.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
elseif text == 'باقي الاسنكمال' or text == 'باقي الاستكمال' then
photo = "https://t.me/UU_GO"
local Name = '𝑾𝑬𝑳𝑪𝑶𝑴𝑬 𝑻𝑶 𝒀𝑶𝒁𝑨𝑹𝑻 𝐉𝐎𝐎🏴‍☠️ '
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𝐉𝐎𝐎 ➪🏴‍☠️', url = "https://t.me/UU_GO"}
},
}
local msgg = msg_id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id=" .. msg_chat_id .. "&photo="..photo.."&caption=".. URL.escape(Name).."&reply_to_message_id="..msgg.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
elseif text == 'باقي الاستكمال' or text == 'باقي الاستكمال' then
photo = "https://t.me/Killer_Bbb"
local Name = '𝑾𝑬𝑳𝑪𝑶𝑴𝑬 𝑻𝑶 𝒀𝑶𝒁𝑨??𝑻 𝐊𝐎𝐌𝐀𝐍𝐃𝐀🏴‍☠️ '
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '𝐊𝐎𝐌𝐀𝐍𝐃𝐀 ➪🏴‍☠️', url = "https://t.me/Killer_Bbb"}
},
}
local msgg = msg_id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id=" .. msg_chat_id .. "&photo="..photo.."&caption=".. URL.escape(Name).."&reply_to_message_id="..msgg.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
elseif text == 'بوت حذف' or text == 'خذف حسابي' or text == 'بوت الحذف' then
photo = "https://t.me/LC6BOT"
local Name = 'بــوت حــذف حــســابــات '
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'اضغط لدخول للبوت', url = "https://t.me/LC6BOT"}
},
}
local msgg = msg_id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id=" .. msg_chat_id .. "&photo="..photo.."&caption=".. URL.escape(Name).."&reply_to_message_id="..msgg.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
elseif text == 'الاوامر' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '‹ اوامر المطورين ›', data = msg.sender.user_id..'/help1'}, {text = '‹ اوامر التسليه ›', data = msg.sender.user_id..'/help2'}, 
},
{
{text = '‹ اوامر الاعضاء ›', data = msg.sender.user_id..'/help3'}, {text = '‹ اوامر الحذف ›', data = msg.sender.user_id..'/help4'}, 
},
{
{text = '‹ تفعيل ℘ تعطيل ›', data = msg.sender.user_id..'/listallAddorrem'}, {text = '‹ قفل ℘ فتح ›', data = msg.sender.user_id..'/NoNextSeting'}, 
},
{
{text = '❍ 𓏶 𝒄𝒓𝒊𝒔𝒕𝒊𝒏 • 𝒔𝒐𝒖𝒓𝒄𝒆 𓏶 ❍', url = 't.me/cristin_so'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id, [[*
🔻╎ نورت #يرحقلبي • ♡ • ~
🔺️╎ اهلا بك في { قسم } الاوامر • ~
🔻╎ اختار الاوامر الي انت عايزها • ~
🔺️╎ من خلال الأزرار بالأسفل 👇 • ~

— — — — — — — — —
(t.me/cristin_so)
*]],"md",false, false, false, false, reply_markup)
elseif text == 'ردود السورس' or text == 'تحكم الردود' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- تفعيل ردود السورس ♡.', data = msg.sender.user_id..'/belal_madeson'},
},
{
{text = '- تعطيل ردود السورس ♡.', data = msg.sender.user_id..'/madeson_belal'},
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id, [[*
❍┃اليك اوامر تفعيل وتعطيل ردود السورس⚡♥️
*]],"md",false, false, false, false, reply_markup)
elseif text == 'الالعاب' or text == 'الالعاب التسليه' or text == 'الاضافات' or text == 'الالعاب الالكترونيه' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ الالعاب التسليه ❍', data = msg.sender.user_id..'/helma1'},
},
{
{text = '❍ الالعاب الالكترونيه ❍', data = msg.sender.user_id..'/degm'}, 
},
{
{text = '❍ 𓏶 𝒄𝒓𝒊𝒔𝒕𝒊𝒏 • 𝒔𝒐𝒖𝒓𝒄𝒆 𓏶 ❍', url = 't.me/cristin_so'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,' ❍┃ اليك قسم الالعاب من سورس كرستين ',"md",false, false, false, false, reply_markup)
end
if text == "الابراج" or text == "برجي" then
LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ ارسل البرج الان لعرض التوقعات*","md",true) 
Redis:set(MEZO.."brgi"..msg.sender.user_id,"sendbr") 
end
if text and text:match("^برج (.*)$") then
local Textbrj = text:match("^برج (.*)$")
gk = https.request('https://apiabs.ml/brg.php?brg='..URL.escape(Textbrj)..'')
br = JSON.decode(gk)
i = 0
for k,v in pairs(br.ok) do
i = i + 1
t = v.."\n"
end
LuaTele.sendText(msg_chat_id,msg_id,t,"md",true) 
end 
if text and text:match("^معني (.*)$") then
local TextName = text:match("^معني (.*)$")
as = http.request('http://167.71.14.2/Mean.php?Name='..URL.escape(TextName)..'')
mn = JSON.decode(as)
k = mn.meaning
LuaTele.sendText(msg_chat_id,msg_id,k,"md",true) 
end
if text and text:match("^احسب (.*)$") then
local Textage = text:match("^احسب (.*)$")
ge = https.request('https://boyka-api.ml/Calculateage.php?age='..URL.escape(Textage)..'')
ag = JSON.decode(ge)
i = 0
for k,v in pairs(ag.ok) do
i = i + 1
t = v.."\n"
end
LuaTele.sendText(msg_chat_id,msg_id,t,"md",true) 
end
if Redis:get(MEZO.."zhrfa"..msg.sender.user_id) == "sendzh" then
zh = https.request('https://apiabs.ml/zrf.php?abs='..URL.escape(text)..'')
zx = JSON.decode(zh)
t = "\n 𖥔قائمه الزخرفه \n⩹━━━━𖥕MEZO𖥕━━━━⩺\n"
i = 0
for k,v in pairs(zx.ok) do
i = i + 1
t = t..i.."- `"..v.."` \n"
end
LuaTele.sendText(msg_chat_id,msg_id,t,"md",true) 
Redis:del(MEZO.."zhrfa"..msg.sender.user_id) 
end
if text and text:match("^قول (.*)$")then
local m = text:match("^قول (.*)$")
if Redis:get(MEZO.."Status:kool"..msg.chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,m,"md",true) 
end
end
if text == "زواج" or text == "رفع زوجتي" or text == "رفع زوجي" and msg.reply_to_message_id ~= 0 then
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if tonumber(Message_Reply.sender.user_id) == tonumber(msg.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"*الحق الود تعبان عوز يتجوز نفسه 😂*","md",true)  
end
if tonumber(Message_Reply.sender.user_id) == tonumber(MEZO) then
return LuaTele.sendText(msg_chat_id,msg_id,"*شوفلك كلبه غير البوت يبنوسخه 😒*","md",true)  
end
if Redis:sismember(MEZO..msg_chat_id.."zwgat:",Message_Reply.sender.user_id) then
local rd_mtzwga = {
"الا تصلح انت تكون متجوزه 😹",
"المزه متجوزه مسبقا 😒",
"عذرا لا تصلح للجواز 😢💔",
"انها متناكه من قبل عزيزي 😅??",
"شوفلك كلبه غير دي 😒😂",
}
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,rd_mtzwga[math.random(#rd_mtzwga)]).Reply,"md",true)  
else
local rd_zwag = {
"تم الزواج مبروك 💑🎊",
"تم الزواج الف مبروك 🎉🎀",
"زواجنا مبروكة والحمد لله 🙊💗",
"تم الزواج من المزه الجامده 💋💞",
"تم الزواج امتاا الدخله 😅😂",
}
if Redis:sismember(MEZO..msg_chat_id.."mutlqat:",Message_Reply.sender.user_id) then 
Redis:srem(MEZO..msg_chat_id.."mutlqat:",Message_Reply.sender.user_id)
end
Redis:sadd(MEZO..msg_chat_id.."zwgat:",Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,rd_zwag[math.random(#rd_zwag)]).Reply,"md",true)  
end
end
if text == "طلاق" or text == "تنزيل زوجتي" or text == "تزيل زوجي" and msg.reply_to_message_id ~= 0 then
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if tonumber(Message_Reply.sender.user_id) == tonumber(msg.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"احا هو انت كنت اتجوزت نفسك عشان تطلق","md",true)  
end
if tonumber(Message_Reply.sender.user_id) == tonumber(MEZO) then
return LuaTele.sendText(msg_chat_id,msg_id,"هو احنا كنا اتجوزنا يروح خالتك عشان نطلق","md",true)  
end
if Redis:sismember(MEZO..msg_chat_id.."zwgat:",Message_Reply.sender.user_id) then
Redis:srem(MEZO..msg_chat_id.."zwgat:",Message_Reply.sender.user_id)
Redis:sadd(MEZO..msg_chat_id.."mutlqat:",Message_Reply.sender.user_id) 
local rd_tmtlaq = {
"تم الطلاق وخربان البيت 😂",
"تم الطلاق وده الشطان 😹",
"تم الطلاق بنجاح 😅😂",
}
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,rd_tmtlaq[math.random(#rd_tmtlaq)]).Reply,"md",true)  
else
local rd_tlaq = {
"لم يتم الجواز من قبل 😹",
"بايره محدش اتجوزها 😅😂",
"لم يتم التكاثر من المزه 😂",
}
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,rd_tlaq[math.random(#rd_tlaq)]).Reply,"md",true)  
end
end
if text == "رفع متوحد" or text == "متوحد" and msg.reply_to_message_id ~= 0 then
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if tonumber(Message_Reply.sender.user_id) == tonumber(MEZO) then
return LuaTele.sendText(msg_chat_id,msg_id,"*لا استطيع استخدام الأمر علي البوت ❍┃ *","md",true)  
end
if Redis:sismember(MEZO..msg_chat_id.."lonely:",Message_Reply.sender.user_id) then
local rd_mtzwga = {"تم رفعه متوحد مسبقا 😂",
}
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,rd_mtzwga[math.random(#rd_mtzwga)]).Reply,"md",true)  
else
local rd_zwag = {"تم رفعه متوحد في الجروب 😂",
}
if Redis:sismember(MEZO..msg_chat_id.."mutlqat:",Message_Reply.sender.user_id) then 
Redis:srem(MEZO..msg_chat_id.."mutlqat:",Message_Reply.sender.user_id)
end
Redis:sadd(MEZO..msg_chat_id.."lonely:",Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,rd_zwag[math.random(#rd_zwag)]).Reply,"md",true)  
end
end
if text == "تنزيل متوحد" or text == "تنزل المتوحد" and msg.reply_to_message_id ~= 0 then
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if tonumber(Message_Reply.sender.user_id) == tonumber(MEZO) then
return LuaTele.sendText(msg_chat_id,msg_id,"*لا استطيع استخدام الأمر علي البوت ❍┃ *","md",true)  
end
if Redis:sismember(MEZO..msg_chat_id.."lonely:",Message_Reply.sender.user_id) then
Redis:srem(MEZO..msg_chat_id.."lonely:",Message_Reply.sender.user_id)
Redis:sadd(MEZO..msg_chat_id.."mutlqat:",Message_Reply.sender.user_id) 
local rd_tlaq = {"😂 تم تنزيله متوحد",
}
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,rd_tmtlaq[math.random(#rd_tmtlaq)]).Reply,"md",true)  
else
local rd_tmtlaq = {"😂 تم تنزيله متوحد مسبقا",
}
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,rd_tlaq[math.random(#rd_tlaq)]).Reply,"md",true)  
end
end
if text == "رفع كلب" or text == "كلب" and msg.reply_to_message_id ~= 0 then
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if tonumber(Message_Reply.sender.user_id) == tonumber(MEZO) then
return LuaTele.sendText(msg_chat_id,msg_id,"*لا استطيع استخدام الأمر علي البوت ❍┃ *","md",true)  
end
if Redis:sismember(MEZO..msg_chat_id.."klbklb:",Message_Reply.sender.user_id) then
local rd_mtzwga = {"تم رفعه كلب مسبقا 😂",
}
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,rd_mtzwga[math.random(#rd_mtzwga)]).Reply,"md",true)  
else
local rd_zwag = {"تم رفعه كلب في الجروب 😂",
}
if Redis:sismember(MEZO..msg_chat_id.."mutlqat:",Message_Reply.sender.user_id) then 
Redis:srem(MEZO..msg_chat_id.."mutlqat:",Message_Reply.sender.user_id)
end
Redis:sadd(MEZO..msg_chat_id.."klbklb:",Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,rd_zwag[math.random(#rd_zwag)]).Reply,"md",true)  
end
end
if text == "تنزيل كلب" or text == "تنزل الكلب" and msg.reply_to_message_id ~= 0 then
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if tonumber(Message_Reply.sender.user_id) == tonumber(MEZO) then
return LuaTele.sendText(msg_chat_id,msg_id,"*لا استطيع استخدام الأمر علي البوت ❍┃ *","md",true)  
end
if Redis:sismember(MEZO..msg_chat_id.."klbklb:",Message_Reply.sender.user_id) then
Redis:srem(MEZO..msg_chat_id.."klbklb:",Message_Reply.sender.user_id)
Redis:sadd(MEZO..msg_chat_id.."mutlqat:",Message_Reply.sender.user_id) 
local rd_tlaq = {"😂 تم تنزيله كلب",
}
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,rd_tmtlaq[math.random(#rd_tmtlaq)]).Reply,"md",true)  
else
local rd_tmtlaq = {"😂 تم تنزيله كلب مسبقا",
}
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,rd_tlaq[math.random(#rd_tlaq)]).Reply,"md",true)  
end
end
if text == "تخ" or text == "تخخ" and msg.reply_to_message_id ~= 0 then
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if tonumber(Message_Reply.sender.user_id) == tonumber(msg.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"*الحق الود تعبان عايز يموت نفسه 😂*","md",true)  
end
if tonumber(Message_Reply.sender.user_id) == tonumber(MEZO) then
return LuaTele.sendText(msg_chat_id,msg_id,"*شوفلك حد غير البوت يبنوسخه 😒*","md",true)  
end
if Redis:sismember(MEZO..msg_chat_id.."zwgat:",Message_Reply.sender.user_id) then
local rd_mtzwga = {
"مااااتتتت خلااااصصصص😹💔 ",
"ده اتدفن يعم شوف حد تاني نقتلو🥲",
"هو دهه في روحح عشان نقتلو اصلا😹💔",
"ربنا يرحمو كان طيب🥲",
}
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,rd_mtzwga[math.random(#rd_mtzwga)]).Reply,"md",true)  
else
local rd_zwag = {
"تم القتل بنجاح😈",
"تم القتل بنجاح😈",
}
if Redis:sismember(MEZO..msg_chat_id.."mutlqat:",Message_Reply.sender.user_id) then 
Redis:srem(MEZO..msg_chat_id.."mutlqat:",Message_Reply.sender.user_id)
end
Redis:sadd(MEZO..msg_chat_id.."zwgat:",Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,rd_zwag[math.random(#rd_zwag)]).Reply,"md",true)  
end
end
-- time & date
if text == "الوقت" then
local date = os.date('*t')
local time = os.date("*t")
local hour = time.hour
local min = time.min
local sec = time.sec
return LuaTele.sendText(msg_chat_id,msg_id,"التاريخ : "..os.date("%A, %d %B %Y").."\nالساعه : "..os.date("%I:%M:%S %p"),"md",true)
end
if text == "تتجوزيني"  then
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local ban = LuaTele.getUser(Message_Reply.sender.user_id)
local bain = LuaTele.getUser(msg.sender.user_id)
if ban.first_name then
baniusername = '*طلب :- *['..bain.first_name..'](tg://user?id='..bain.id..')*\nالزواج من  :- *['..ban.first_name..'](tg://user?id='..ban.id..')*\nهل العروسه موافقه علي هذا\n*'
else
baniusername = 'لا يوجد'
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'موافقه 👰', data = Message_Reply.sender.user_id..'/zog1'},{text = 'مش موافقه😩', data = Message_Reply.sender.user_id..'/zog2'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,baniusername,"md",false, false, false, false, reply_markup)
end
if text == 'هاي' or text == 'هيي' then
if not Redis:get(MEZO.."MEZO:Sasa:Jeka"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ ردود السورس معطلة*","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ 𓏶 𝒄𝒓𝒊𝒔𝒕𝒊𝒏 • 𝒔𝒐𝒖𝒓𝒄𝒆 𓏶 ❍', url = 't.me/cristin_so'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'*خالتك جرت ورايا 😹💔*',"md",false, false, false, false, reply_markup)
end
if text == 'سلام عليكم' or text == 'السلام عليكم' then
if not Redis:get(MEZO.."MEZO:Sasa:Jeka"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ ردود السورس معطلة*","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ 𓏶 𝒄𝒓𝒊𝒔𝒕𝒊𝒏 • 𝒔𝒐𝒖𝒓𝒄𝒆 𓏶 ❍', url = 't.me/cristin_so'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'*وعليكم السلام 🌝💜*',"md",false, false, false, false, reply_markup)
end
if text == 'سلام' or text == 'مع سلامه' then
if not Redis:get(MEZO.."MEZO:Sasa:Jeka"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ 𓏶 𝒄𝒓𝒊𝒔𝒕𝒊𝒏 • 𝒔𝒐𝒖𝒓𝒄𝒆 𓏶 ❍', url = 't.me/cristin_so'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'*مع الف سلامه يقلبي متجيش تاني 😹💔🎶*',"md",false, false, false, false, reply_markup)
end
if text == 'برايفت' or text == 'تع برايفت' then
if not Redis:get(MEZO.."MEZO:Sasa:Jeka"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ 𓏶 𝒄𝒓𝒊𝒔𝒕𝒊𝒏 • 𝒔𝒐𝒖𝒓𝒄𝒆 𓏶 ❍', url = 't.me/cristin_so'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'*خدوني معاكم برايفت والنبي 🥺💔*',"md",false, false, false, false, reply_markup)
end
if text == 'النبي' or text == 'صلي علي النبي' then
if not Redis:get(MEZO.."MEZO:Sasa:Jeka"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ 𓏶 𝒄𝒓𝒊𝒔𝒕𝒊𝒏 • 𝒔𝒐𝒖𝒓𝒄𝒆 𓏶 ❍', url = 't.me/cristin_so'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'*عليه الصلاه والسلام 🌝💛*',"md",false, false, false, false, reply_markup)
end
if text == 'نعم' or text == 'يا نعم' then
if not Redis:get(MEZO.."MEZO:Sasa:Jeka"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ 𓏶 𝒄𝒓𝒊𝒔𝒕𝒊𝒏 • 𝒔𝒐𝒖𝒓𝒄𝒆 𓏶 ❍', url = 't.me/cristin_so'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'*نعم الله عليك 🌚❤️*',"md",false, false, false, false, reply_markup)
end
if text == '🙄' or text == '🙄🙄' then
if not Redis:get(MEZO.."MEZO:Sasa:Jeka"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ 𓏶 𝒄𝒓𝒊𝒔𝒕𝒊𝒏 • 𝒔𝒐𝒖𝒓𝒄𝒆 𓏶 ❍', url = 't.me/cristin_so'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'* نزل عينك تحت كدا علشان هتخاد علي قفاك 😒❤️*',"md",false, false, false, false, reply_markup)
end
if text == '🙄' or text == '🙄🙄' then
if not Redis:get(MEZO.."MEZO:Sasa:Jeka"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ 𓏶 𝒄𝒓𝒊𝒔𝒕𝒊𝒏 • 𝒔𝒐𝒖𝒓𝒄𝒆 𓏶 ❍', url = 't.me/cristin_so'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'*نزل عينك تحت كدا علشان هتخاد علي قفاك 😒❤️*',"md",false, false, false, false, reply_markup)
end
if text == '😂' or text == '😂😂' then
if not Redis:get(MEZO.."MEZO:Sasa:Jeka"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ 𓏶 𝒄𝒓𝒊𝒔𝒕𝒊𝒏 • 𝒔𝒐𝒖𝒓𝒄𝒆 𓏶 ❍', url = 't.me/cristin_so'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'*ضحكتك عثل زيكك ينوحيي 🌝❤️*',"md",false, false, false, false, reply_markup)
end
if text == '😹' or text == '😹' then
if not Redis:get(MEZO.."MEZO:Sasa:Jeka"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ 𓏶 𝒄𝒓𝒊𝒔𝒕𝒊𝒏 • 𝒔𝒐𝒖𝒓𝒄𝒆 𓏶 ❍', url = 't.me/cristin_so'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'*ضحكتك عثل زيكك ينوحيي 🌝❤️*',"md",false, false, false, false, reply_markup)
end
if text == '🤔' or text == '🤔🤔' then
if not Redis:get(MEZO.."MEZO:Sasa:Jeka"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ 𓏶 𝒄𝒓𝒊𝒔𝒕𝒊𝒏 • 𝒔𝒐𝒖𝒓𝒄𝒆 𓏶 ❍', url = 't.me/cristin_so'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'* بتفكر في اي 🤔*',"md",false, false, false, false, reply_markup)
end
if text == '🌚' or text == '🌝' then
if not Redis:get(MEZO.."MEZO:Sasa:Jeka"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ 𓏶 𝒄𝒓𝒊𝒔𝒕𝒊𝒏 • 𝒔𝒐𝒖𝒓𝒄𝒆 𓏶 ❍', url = 't.me/cristin_so'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'*القمر ده شبهك 🙂❤️*',"md",false, false, false, false, reply_markup)
end
if text == '💋' or text == '💋💋' then
if not Redis:get(MEZO.."MEZO:Sasa:Jeka"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ 𓏶 𝒄𝒓𝒊𝒔𝒕𝒊𝒏 • 𝒔𝒐𝒖𝒓𝒄𝒆 𓏶 ❍', url = 't.me/cristin_so'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'*انا عايز مح انا كمان 🥺💔*',"md",false, false, false, false, reply_markup)
end
if text == '😭' or text == '😭😭' then
if not Redis:get(MEZO.."MEZO:Sasa:Jeka"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ 𓏶 𝒄𝒓𝒊𝒔𝒕𝒊𝒏 • 𝒔𝒐𝒖𝒓𝒄𝒆 𓏶 ❍', url = 't.me/cristin_so'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'*بتعيط تيب لي طيب 😥*',"md",false, false, false, false, reply_markup)
end
if text == '🥺' or text == '🥺🥺' then
if not Redis:get(MEZO.."MEZO:Sasa:Jeka"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ 𓏶 𝒄𝒓𝒊𝒔𝒕𝒊𝒏 • 𝒔𝒐𝒖𝒓𝒄𝒆 𓏶 ❍', url = 't.me/cristin_so'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'*متزعلش بحبك 😻🤍*',"md",false, false, false, false, reply_markup)
end
if text == '😒' or text == '😒😒' then
if not Redis:get(MEZO.."MEZO:Sasa:Jeka"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ 𓏶 𝒄𝒓𝒊𝒔𝒕𝒊𝒏 • 𝒔𝒐𝒖𝒓𝒄𝒆 𓏶 ❍', url = 't.me/cristin_so'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'*عدل وشك ونت بتكلمني 😒🙄*',"md",false, false, false, false, reply_markup)
end
if text == 'بحبك' or text == 'حبق' then
if not Redis:get(MEZO.."MEZO:Sasa:Jeka"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ 𓏶 𝒄𝒓𝒊𝒔𝒕𝒊𝒏 • 𝒔𝒐𝒖𝒓𝒄𝒆 𓏶 ❍', url = 't.me/cristin_so'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'*وانا كمان بعشقك يا روحي 🤗🥰*',"md",false, false, false, false, reply_markup)
end
if text == 'مح' or text == 'هات مح' then
if not Redis:get(MEZO.."MEZO:Sasa:Jeka"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ 𓏶 𝒄𝒓𝒊𝒔𝒕𝒊𝒏 • 𝒔𝒐𝒖𝒓𝒄𝒆 𓏶 ❍', url = 't.me/cristin_so'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'*محات حياتي يروحي 🌝❤️*',"md",false, false, false, false, reply_markup)
end
if text == 'هلا' or text == 'هلا وغلا' then
if not Redis:get(MEZO.."MEZO:Sasa:Jeka"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ 𓏶 𝒄𝒓𝒊𝒔𝒕𝒊𝒏 • 𝒔𝒐𝒖𝒓𝒄𝒆 𓏶 ❍', url = 't.me/cristin_so'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'*هلا بيك ياروحي 👋*',"md",false, false, false, false, reply_markup)
end
if text == 'هشش' or text == 'هششخرص' then
if not Redis:get(MEZO.."MEZO:Sasa:Jeka"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ 𓏶 𝒄𝒓𝒊𝒔𝒕𝒊𝒏 • 𝒔𝒐𝒖𝒓𝒄𝒆 𓏶 ❍', url = 't.me/cristin_so'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'*بنهش كتاكيت احنا هنا ولا اي ??😹*',"md",false, false, false, false, reply_markup)
end
if text == 'الحمد الله' or text == 'بخير الحمد الله' then
if not Redis:get(MEZO.."MEZO:Sasa:Jeka"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ 𓏶 𝒄𝒓𝒊𝒔𝒕𝒊𝒏 • 𝒔𝒐𝒖𝒓𝒄𝒆 𓏶 ❍', url = 't.me/cristin_so'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'*دايما ياحبيبي 🌝❤️*',"md",false, false, false, false, reply_markup)
end
if text == 'بف' or text == 'بص بف' then
if not Redis:get(MEZO.."MEZO:Sasa:Jeka"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ 𓏶 𝒄𝒓𝒊𝒔𝒕𝒊𝒏 • 𝒔𝒐𝒖𝒓𝒄𝒆 𓏶 ❍', url = 't.me/cristin_so'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'*وحيات امك ياكبتن خدوني معاكو بيف 🥺💔*',"md",false, false, false, false, reply_markup)
end
if text == 'خاص' or text == 'بص خاص' then
if not Redis:get(MEZO.."MEZO:Sasa:Jeka"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ 𓏶 𝒄𝒓𝒊𝒔𝒕𝒊𝒏 • 𝒔𝒐𝒖𝒓𝒄𝒆 𓏶 ❍', url = 't.me/cristin_so'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'*ونجيب اشخاص 😂👻*',"md",false, false, false, false, reply_markup)
end
if text == 'صباح الخير' or text == 'مساء الخير' then
if not Redis:get(MEZO.."MEZO:Sasa:Jeka"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ 𓏶 𝒄𝒓𝒊𝒔𝒕𝒊𝒏 • 𝒔𝒐𝒖𝒓𝒄𝒆 𓏶 ❍', url = 't.me/cristin_so'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'*انت الخير يعمري 🌝❤️*',"md",false, false, false, false, reply_markup)
end
if text == 'صباح النور' or text == 'باح الخير' then
if not Redis:get(MEZO.."MEZO:Sasa:Jeka"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ 𓏶 𝒄𝒓𝒊𝒔𝒕𝒊𝒏 • 𝒔𝒐𝒖𝒓𝒄𝒆 𓏶 ❍', url = 't.me/cristin_so'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'*صباح العسل 😻🤍*',"md",false, false, false, false, reply_markup)
end
if text == 'حصل' or text == 'حثل' then
if not Redis:get(MEZO.."MEZO:Sasa:Jeka"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ 𓏶 𝒄𝒓𝒊𝒔𝒕𝒊𝒏 • 𝒔𝒐𝒖𝒓𝒄𝒆 𓏶 ❍', url = 't.me/cristin_so'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'*خخخ امال 😹*',"md",false, false, false, false, reply_markup)
end
if text == 'اه' or text == 'اها' then
if not Redis:get(MEZO.."MEZO:Sasa:Jeka"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ 𓏶 𝒄𝒓𝒊𝒔𝒕𝒊𝒏 • 𝒔𝒐𝒖𝒓𝒄𝒆 𓏶 ❍', url = 't.me/cristin_so'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'*اه اي يا قدع عيب 😹💔*',"md",false, false, false, false, reply_markup)
end
if text == 'كسم' or text == 'كسمك' then
if not Redis:get(MEZO.."MEZO:Sasa:Jeka"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ 𓏶 𝒄𝒓𝒊𝒔𝒕𝒊𝒏 • 𝒔𝒐𝒖𝒓𝒄𝒆 𓏶 ❍', url = 't.me/cristin_so'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'*عيب ياوسخ 🙄💔*',"md",false, false, false, false, reply_markup)
end
if text == 'بوتي' or text == 'يا بوتي' then
if not Redis:get(MEZO.."MEZO:Sasa:Jeka"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ 𓏶 𝒄𝒓𝒊𝒔𝒕𝒊𝒏 • 𝒔𝒐𝒖𝒓𝒄𝒆 𓏶 ❍', url = 't.me/cristin_so'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'روح وعقل بوتك 🥺💔',"md",false, false, false, false, reply_markup)
end
if text == 'متيجي' or text == 'تع' then
if not Redis:get(MEZO.."MEZO:Sasa:Jeka"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ 𓏶 𝒄𝒓𝒊𝒔𝒕𝒊𝒏 • 𝒔𝒐𝒖??𝒄𝒆 𓏶 ❍', url = 't.me/cristin_so'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'*لا عيب بتكسف 😹💔*',"md",false, false, false, false, reply_markup)
end
if text == 'هيح' or text == 'لسه صاحي' then
if not Redis:get(MEZO.."MEZO:Sasa:Jeka"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ 𓏶 𝒄𝒓𝒊𝒔𝒕𝒊𝒏 • 𝒔𝒐𝒖𝒓𝒄𝒆 𓏶 ❍', url = 't.me/cristin_so'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'*صح النوم 😹💔*',"md",false, false, false, false, reply_markup)
end
if text == 'منور' or text == 'نورت' then
if not Redis:get(MEZO.."MEZO:Sasa:Jeka"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ 𓏶 𝒄𝒓𝒊𝒔𝒕𝒊𝒏 • 𝒔𝒐𝒖𝒓𝒄𝒆 𓏶 ❍', url = 't.me/cristin_so'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'*ده نورك ي قلبي 🌝💙*',"md",false, false, false, false, reply_markup)
end
if text == 'باي' or text == 'انا ماشي' then
if not Redis:get(MEZO.."MEZO:Sasa:Jeka"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ 𓏶 𝒄𝒓𝒊𝒔𝒕𝒊𝒏 • 𝒔𝒐𝒖𝒓𝒄𝒆 𓏶 ❍', url = 't.me/cristin_so'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'*ع فين لوين رايح وسايبنى 🥺💔*',"md",false, false, false, false, reply_markup)
end
if text == 'ويت' or text == 'ويت يحب' then
if not Redis:get(MEZO.."MEZO:Sasa:Jeka"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ 𓏶 𝒄𝒓𝒊𝒔𝒕𝒊𝒏 • 𝒔𝒐𝒖𝒓𝒄𝒆 𓏶 ❍', url = 't.me/cristin_so'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'*اي الثقافه دي 😒😹*',"md",false, false, false, false, reply_markup)
end
if text == 'خخخ' or text == 'خخخخخ' then
if not Redis:get(MEZO.."MEZO:Sasa:Jeka"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ 𓏶 𝒄𝒓𝒊𝒔𝒕𝒊𝒏 • 𝒔𝒐𝒖𝒓𝒄𝒆 𓏶 ❍', url = 't.me/cristin_so'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'*اهدا يوحش ميصحش كدا 😒??*',"md",false, false, false, false, reply_markup)
end
if text == 'شكرا' or text == 'مرسي' then
if not Redis:get(MEZO.."MEZO:Sasa:Jeka"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ 𓏶 𝒄𝒓𝒊𝒔𝒕𝒊𝒏 • 𝒔𝒐𝒖𝒓𝒄𝒆 𓏶 ❍', url = 't.me/cristin_so'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'*العفو ياروحي 🙈🌝*',"md",false, false, false, false, reply_markup)
end
if text == 'حلوه' or text == 'حلو' then
if not Redis:get(MEZO.."MEZO:Sasa:Jeka"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ 𓏶 𝒄𝒓𝒊𝒔𝒕𝒊𝒏 • 𝒔𝒐𝒖𝒓𝒄𝒆 𓏶 ❍', url = 't.me/cristin_so'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'*انت الي حلو ياقمر 🤤🌝*',"md",false, false, false, false, reply_markup)
end
if text == 'بموت' or text == 'هموت' then
if not Redis:get(MEZO.."MEZO:Sasa:Jeka"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ 𓏶 𝒄𝒓𝒊𝒔𝒕𝒊𝒏 • 𝒔𝒐𝒖𝒓𝒄𝒆 𓏶 ❍', url = 't.me/cristin_so'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'*موت بعيد م ناقصين مصايب 😑😂*',"md",false, false, false, false, reply_markup)
end
if text == 'اي' or text == 'ايه' then
if not Redis:get(MEZO.."MEZO:Sasa:Jeka"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ 𓏶 𝒄𝒓𝒊𝒔𝒕𝒊𝒏 • 𝒔𝒐𝒖𝒓𝒄𝒆 𓏶 ❍', url = 't.me/cristin_so'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'*جتك اوهه م سامع ولا ايي 😹👻*',"md",false, false, false, false, reply_markup)
end
if text == 'طيب' or text == 'تيب' then
if not Redis:get(MEZO.."MEZO:Sasa:Jeka"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ 𓏶 𝒄𝒓𝒊𝒔𝒕𝒊𝒏 • 𝒔𝒐𝒖𝒓𝒄𝒆 𓏶 ❍', url = 't.me/cristin_so'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'*فرح خالتك قريب 😹💋💃🏻*',"md",false, false, false, false, reply_markup)
end
if text == 'حاضر' or text == 'حتر' then
if not Redis:get(MEZO.."MEZO:Sasa:Jeka"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ 𓏶 𝒄𝒓𝒊𝒔𝒕𝒊𝒏 • 𝒔𝒐𝒖𝒓𝒄𝒆 𓏶 ❍', url = 't.me/cristin_so'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'*حضرلك الخير يارب 🙂❤️*',"md",false, false, false, false, reply_markup)
end
if text == 'جيت' or text == 'انا جيت' then
if not Redis:get(MEZO.."MEZO:Sasa:Jeka"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ 𓏶 𝒄𝒓𝒊𝒔𝒕𝒊𝒏 • 𝒔𝒐𝒖𝒓𝒄𝒆 𓏶 ❍', url = 't.me/cristin_so'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'* لف ورجع تانى مشحوار 😂🚶‍♂👻*',"md",false, false, false, false, reply_markup)
end
if text == 'بخ' or text == 'عو' then
if not Redis:get(MEZO.."MEZO:Sasa:Jeka"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ 𓏶 𝒄𝒓𝒊𝒔𝒕𝒊𝒏 • 𝒔𝒐𝒖𝒓𝒄𝒆 𓏶 ❍', url = 't.me/cristin_so'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'*يوه خضتني ياسمك اي 🥺💔*',"md",false, false, false, false, reply_markup)
end
if text == 'حبيبي' or text == 'حبيبتي' then
if not Redis:get(MEZO.."MEZO:Sasa:Jeka"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ 𓏶 𝒄𝒓𝒊𝒔𝒕𝒊𝒏 • 𝒔𝒐𝒖𝒓𝒄𝒆 𓏶 ❍', url = 't.me/cristin_so'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'*اوه ياه 🌝😂*',"md",false, false, false, false, reply_markup)
end
if text == 'تمام' or text == 'تمم' then
if not Redis:get(MEZO.."MEZO:Sasa:Jeka"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ 𓏶 𝒄𝒓𝒊𝒔𝒕𝒊𝒏 • 𝒔𝒐𝒖𝒓𝒄𝒆 𓏶 ❍', url = 't.me/cristin_so'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'* امك اسمها احلام 😹😹*',"md",false, false, false, false, reply_markup)
end
if text == 'خلاص' or text == 'خلص' then
if not Redis:get(MEZO.."MEZO:Sasa:Jeka"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ 𓏶 𝒄𝒓𝒊𝒔𝒕𝒊𝒏 • 𝒔𝒐𝒖𝒓𝒄𝒆 𓏶 ❍', url = 't.me/cristin_so'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'*خلصتت روحكك يبعيد 😹💔*',"md",false, false, false, false, reply_markup)
end
if text == 'سي في' or text == 'سيفي' then
if not Redis:get(MEZO.."MEZO:Sasa:Jeka"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ 𓏶 𝒄𝒓𝒊𝒔𝒕𝒊𝒏 • 𝒔𝒐𝒖𝒓𝒄𝒆 𓏶 ❍', url = 't.me/cristin_so'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'*كفيه شقط سيب حاجه لغيرك 😎😂*',"md",false, false, false, false, reply_markup)
end
if text == 'السيرفر' or text == 'معلومات السيرفر' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(MEZO.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
ioserver = io.popen([[
linux_version=`lsb_release -ds`
memUsedPrc=`free -m | awk 'NR==2{printf "%sMB/%sMB {%.2f%}\n", $3,$2,$3*100/$2 }'`
HardDisk=`df -lh | awk '{if ($6 == "/") { print $3"/"$2" ~ {"$5"}" }}'`
CPUPer=`top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4}'`
uptime=`uptime | awk -F'( |,|:)+' '{if ($7=="min") m=$6; else {if ($7~/^day/) {d=$6;h=$8;m=$9} else {h=$6;m=$7}}} {print d+0,"days,",h+0,"hours,",m+0,"minutes."}'`
echo '❍┃⟦ نظام التشغيل ⟧❍┃\n* '"$linux_version"'*' 
echo '— — — — — — — — —\n 🌐⟦ الذاكره العشوائيه ⟧  ⏎\n⟦* '"$memUsedPrc"'*⟧'
echo '— — — — — — — — —\n 🌐⟦ وحـده الـتـخـزيـن ⟧  ⏎\n⟦* '"$HardDisk"'*⟧'
echo '— — — — — — — — —\n 🌐⟦ موقـع الـسـيـرفـر ⟧ ⏎\n⟦*‹-‹- '`curl http://th3boss.com/ip/location`'*⟧'
echo '— — — — — — — — —\n 🌐⟦ الـمــعــالــج ⟧  ⏎\n⟦* '"`grep -c processor /proc/cpuinfo`""Core ~ ⟦$CPUPer%⟧ "'*⟧'
echo '— — — — — — — — —\n 🌐⟦ الــدخــول ⟧  ⏎\n⟦* '`whoami`'*⟧'
echo '— — — — — — — — —\n 🌐⟦ مـده تـشغيـل الـسـيـرفـر ⟧ ⏎\n⟦* '"$uptime"'*⟧'
 ]]):read('*all')
LuaTele.sendText(msg_chat_id,msg_id,ioserver,"md",true)
end
if text == 'تحديث الملفات' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
print('Chat Id : '..msg_chat_id)
print('User Id : '..msg_user_send_id)
LuaTele.sendText(msg_chat_id,msg_id, "* ❍┃ تم تحديث الملفات*","md",true)
dofile('MEZO.lua')  
end
if text == "تغير اسم البوت" then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(MEZO.."MEZO:Change:MEZO:Name:Bot"..msg.sender.user_id,300,true) 
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ ارسل لي الاسم الان ","md",true)  
end
if text == "حذف اسم البوت" then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(MEZO.."MEZO:Name:Bot") 
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم حذف اسم البوت ","md",true)   
end
if text == "بوت" or text == "البوت" or text == "bot" or text == "Bot" then
local photo = LuaTele.getUserProfilePhotos(MEZO)
local ban = LuaTele.getUser(MEZO)
for Name_User in string.gmatch(ban.first_name, "[^%s]+" ) do
ban.first_name = Name_User
break
end 
local NamesBot = (Redis:get(MEZO.."MEZO:Name:Bot") or "براديس •")
local BotName = {
'اسمي '..NamesBot..' يا قلبي 😍💜',
'اسمي '..NamesBot..' يا روحي 🙈❤️',
'اسمي '..NamesBot..' يا عمري 🥰🤍',
'اسمي '..NamesBot..' يا قمر 🐼💚',
'اسمي بوت '..NamesBot..' 😻❤️',
'اسمي '..NamesBot..' يا مزه 😘🍒',
'اسمي '..NamesBot..' يعم 😒',
'مقولت اسمي '..NamesBot..' في اي 🙄',
'اسمي '..NamesBot..' الكيوت 🌝💙',
'اسمي '..NamesBot..' يا حياتي 🌚❤️',
'اسمي '..NamesBot..' يوتكه 🙈💔',
}
NamesBots = BotName[math.random(#BotName)]
if photo.total_count > 0 then
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = NamesBots, url = 't.me/cristin_so'}, 
},
{
{text = '✈ • أضف البوت إلي مجموعتك • ✈', url = 't.me/'..UserBot..'?startgroup=new'},
},
}
msgg = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id=" .. msg_chat_id .. "&photo="..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id.."&photo=".. URL.escape(NamesBots).."&reply_to_message_id="..msgg.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
end
if text == (Redis:get(MEZO.."MEZO:Name:Bot") or "براديس •") then
local photo = LuaTele.getUserProfilePhotos(MEZO)
local ban = LuaTele.getUser(MEZO)
for Name_User in string.gmatch(ban.first_name, "[^%s]+" ) do
ban.first_name = Name_User
break
end 
local NamesBot = (Redis:get(MEZO.."MEZO:Name:Bot") or "براديس •")
local BotName = {
'نعم يروحي 🌝💙',
'نعم يا قلب '..NamesBot..'',
'عوز اي مني '..NamesBot..'',
'موجود '..NamesBot..'',
'بتشقط وجي ويت 🤪',
'ايوا جاي 😹',
'يعم هتسحر واجي 😾',
'طب متصلي على النبي كدا 🙂💜',
'تع اشرب شاي 🌝💙',
'اي قمر انت 🌝💙',
'اي قلبي 🤍😻',
'ياض خش نام 😂',
'انا '..NamesBot..' احسن البوتات 🌝💙',
'نعم 🍒🤍'
}
NamesBots = BotName[math.random(#BotName)]
if photo.total_count > 0 then
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = NamesBots, url = 't.me/cristin_so'}, 
},
{
{text = '✈ • أضف البوت إلي مجموعتك • ✈', url = 't.me/'..UserBot..'?startgroup=new'},
},
}
msgg = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id=" .. msg_chat_id .. "&photo="..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id.."&photo=".. URL.escape(NamesBots).."&reply_to_message_id="..msgg.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
end
if text == "غادر" or text == "بوت غادر" or text == "مغادره" then 
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(3)..' ⟧* ',"md",true)  
end
if not msg.ControllerBot and not Redis:set(MEZO.."MEZO:LeftBot") then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ امر المغادره معطل من قبل الاساسي *',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'تنفيذ الامر', data = '/Zxchq'..msg_chat_id}, {text = 'الغاء الامر', data = msg.sender.user_id..'/Redis'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'* ❍┃ برجاء تأكيد الأمر أولا • 👇*',"md",false, false, false, false, reply_markup)
end
if text == 'تنظيف المشتركين' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(MEZO.."MEZO:Num:User:Pv")   
local x = 0
for k,v in pairs(list) do  
local Get_Chat = LuaTele.getChat(v)
local ChatAction = LuaTele.sendChatAction(v,'Typing')
if ChatAction.luatele ~= "ok" then
x = x + 1
Redis:srem(MEZO..'MEZO:Num:User:Pv',v)
end
end
if x ~= 0 then
return LuaTele.sendText(msg_chat_id,msg_id,'* ❍┃ العدد الكلي { '..#list..' }\n ❍┃ تم العثور على { '..x..' } من المشتركين حاظرين البوت*',"md")
else
return LuaTele.sendText(msg_chat_id,msg_id,'* ❍┃ العدد الكلي { '..#list..' }\n ❍┃ لم يتم العثور على وهميين*',"md")
end
end
if text == 'تنظيف المجموعات' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(MEZO.."MEZO:ChekBotAdd")   
local x = 0
for k,v in pairs(list) do  
local Get_Chat = LuaTele.getChat(v)
if Get_Chat.id then
local statusMem = LuaTele.getChatMember(Get_Chat.id,MEZO)
if statusMem.status.luatele == "chatMemberStatusMember" then
x = x + 1
LuaTele.sendText(Get_Chat.id,0,'* ❍┃ البوت عضو في المجموعه سوف اغادر ويمكنك تفعيلي مره اخره *',"md")
Redis:srem(MEZO..'MEZO:ChekBotAdd',Get_Chat.id)
local keys = Redis:keys(MEZO..'*'..Get_Chat.id)
for i = 1, #keys do
Redis:del(keys[i])
end
LuaTele.leaveChat(Get_Chat.id)
end
else
x = x + 1
local keys = Redis:keys(MEZO..'*'..v)
for i = 1, #keys do
Redis:del(keys[i])
end
Redis:srem(MEZO..'MEZO:ChekBotAdd',v)
LuaTele.leaveChat(v)
end
end
if x ~= 0 then
return LuaTele.sendText(msg_chat_id,msg_id,'* ❍┃ العدد الكلي { '..#list..' } للمجموعات \n ❍┃ تم العثور على { '..x..' } مجموعات البوت ليس ادمن \n ❍┃ تم تعطيل المجموعه ومغادره البوت من الوهمي *',"md")
else
return LuaTele.sendText(msg_chat_id,msg_id,'* ❍┃ العدد الكلي { '..#list..' } للمجموعات \n ❍┃ لا توجد مجموعات وهميه*',"md")
end
end
if text == "سمايلات" or text == "سمايل" then
if Redis:get(MEZO.."MEZO:Status:Games"..msg.chat_id) then
Random = {"🍏","🍎","🍐","🍊","🍋","🍉","🍇","🍓","🍈","🍒","🍑","🍍","🥥","🥝","🍅","🍆","🥑","🥦","🥒","🌶","🌽","🥕","🥔","🥖","🥐","🍞","🥨","🍟","🧀","🥚","🍳","🥓","🥩","🍗","??","🌭","🍔","🍠","🍕","🥪","🥙","☕️","🥤","🍶","🍺","🍻","🏀","⚽️","🏈","⚾️","🎾","🏐","🏉","🎱","🏓","🏸","🥅","🎰","🎮","🎳","🎯","🎲","🎻","🎸","🎺","🥁","🎹","🎼","🎧","🎤","🎬","??","🎭","🎪","🎟","🎫","🎗","🏵","🎖","🏆","🥌","🛷","🚗","🚌","🏎","🚓","🚑","🚚","🚛","🚜","⚔","🛡","🔮","??","💣"," ❍┃ ","📍","📓","📗","📂","📅","📪","📫"," ❍┃ ","📭","⏰","📺","🎚","☎️","📡"}
SM = Random[math.random(#Random)]
Redis:set(MEZO.."MEZO:Game:Smile"..msg.chat_id,SM)
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ اسرع واحد يدز هاذا السمايل ? ~ {`"..SM.."`}","md",true)  
end
end
if text == "تويت" or text == "كت تويت" then
if Redis:get(MEZO.."MEZO:Status:Games"..msg.chat_id) then
local texting = {"اخر افلام شاهدتها", 
"اخر افلام شاهدتها", 
"ما هي وظفتك الحياه", 
"اعز اصدقائك ?", 
"اخر اغنية سمعتها ?", 
"تكلم عن نفسك", 
"ليه انت مش سالك", 
"ما هيا عيوب سورس كرستين؟ ", 
"اخر كتاب قرآته", 
"روايتك المفضله ?", 
"اخر اكله اكلتها", 
"اخر كتاب قرآته", 
"ليش حسين ذكي؟ ", 
"افضل يوم ف حياتك", 
"ليه مضيفتش كل جهاتك", 
"حكمتك ف الحياه", 
"لون عيونك", 
"كتابك المفضل", 
"هوايتك المفضله", 
"علاقتك مع اهلك", 
" ما السيء في هذه الحياة ؟ ", 
"أجمل شيء حصل معك خلال هذا الاسبوع ؟ ", 
"سؤال ينرفزك ؟ ", 
" هل يعجبك سورس كرستين؟؟ ", 
" اكثر ممثل تحبه ؟ ", 
"قد تخيلت شي في بالك وصار ؟ ", 
"شيء عندك اهم من الناس ؟ ", 
"تفضّل النقاش الطويل او تحب الاختصار ؟ ", 
"وش أخر شي ضيعته؟ ", 
"اي رايك في سورس كرستين؟ ", 
"كم مره حبيت؟ ", 
" اكثر المتابعين عندك باي برنامج؟", 
" آخر مره ضربت عشره كانت متى ؟", 
" نسبه الندم عندك للي وثقت فيهم ؟", 
"تحب ترتبط بكيرفي ولا فلات؟", 
" جربت شعور احد يحبك بس انت مو قادر تحبه؟", 
" تجامل الناس ولا اللي بقلبك على لسانك؟", 
" عمرك ضحيت باشياء لاجل شخص م يسوى ؟", 
"مغني تلاحظ أن صوته يعجب الجميع إلا أنت؟ ", 
" آخر غلطات عمرك؟ ", 
" مسلسل كرتوني له ذكريات جميلة عندك؟ ", 
" ما أكثر تطبيق تقضي وقتك عليه؟ ", 
" أول شيء يخطر في بالك إذا سمعت كلمة نجوم ؟ ", 
" قدوتك من الأجيال السابقة؟ ", 
" أكثر طبع تهتم بأن يتواجد في شريك/ة حياتك؟ ", 
"أكثر حيوان تخاف منه؟ ", 
" ما هي طريقتك في الحصول على الراحة النفسية؟ ", 
" إيموجي يعبّر عن مزاجك الحالي؟ ", 
" أكثر تغيير ترغب أن تغيّره في نفسك؟ ", 
"أكثر شيء أسعدك اليوم؟ ", 
"اي رايك في الدنيا دي ؟ ", 
"ما هو أفضل حافز للشخص؟ ", 
"ما الذي يشغل بالك في الفترة الحالية؟", 
"آخر شيء ندمت عليه؟ ", 
"شاركنا صورة احترافية من تصويرك؟ ", 
"تتابع انمي؟ إذا نعم ما أفضل انمي شاهدته ", 
"يرد عليك متأخر على رسالة مهمة وبكل برود، موقفك؟ ", 
"نصيحه تبدا ب -لا- ؟ ", 
"كتاب أو رواية تقرأها هذه الأيام؟ ", 
"فيلم عالق في ذهنك لا تنساه مِن روعته؟ ", 
"يوم لا يمكنك نسيانه؟ ", 
"شعورك الحالي في جملة؟ ", 
"كلمة لشخص بعيد؟ ", 
"صفة يطلقها عليك الشخص المفضّل؟ ", 
"أغنية عالقة في ذهنك هاليومين؟ ", 
"أكلة مستحيل أن تأكلها؟ ", 
"كيف قضيت نهارك؟ ", 
"تصرُّف ماتتحمله؟ ", 
"موقف غير حياتك؟ ", 
"اكثر مشروب تحبه؟ ", 
"القصيدة اللي تأثر فيك؟ ", 
"متى يصبح الصديق غريب ", 
"وين نلقى السعاده برايك؟ ", 
"تاريخ ميلادك؟ ", 
"قهوه و لا شاي؟ ", 
"من محبّين الليل أو الصبح؟ ", 
"حيوانك المفضل؟ ", 
"كلمة غريبة ومعناها؟ ", 
"كم تحتاج من وقت لتثق بشخص؟ ", 
"اشياء نفسك تجربها؟ ", 
"يومك ضاع على؟ ", 
"كل شيء يهون الا ؟ ", 
"اسم ماتحبه ؟ ", 
"وقفة إحترام للي إخترع ؟ ", 
"أقدم شيء محتفظ فيه من صغرك؟ ", 
"كلمات ماتستغني عنها بسوالفك؟ ", 
"وش الحب بنظرك؟ ", 
"حب التملك في شخصِيـتك ولا ؟ ", 
"تخطط للمستقبل ولا ؟ ", 
"موقف محرج ماتنساه ؟ ", 
"من طلاسم لهجتكم ؟ ", 
"اعترف باي حاجه ؟ ", 
"عبّر عن مودك بصوره ؟ ",
"آخر مره ضربت عشره كانت متى ؟", 
"اسم دايم ع بالك ؟ ", 
"اشياء تفتخر انك م سويتها ؟ ", 
" لو بكيفي كان ؟ ", 
  "أكثر جملة أثرت بك في حياتك؟ ",
  "إيموجي يوصف مزاجك حاليًا؟ ",
  "أجمل اسم بنت بحرف الباء؟ ",
  "كيف هي أحوال قلبك؟ ",
  "أجمل مدينة؟ ",
  "كيف كان أسبوعك؟ ",
  "شيء تشوفه اكثر من اهلك ؟ ",
  "اخر مره فضفضت؟ ",
  "قد كرهت احد بسبب اسلوبه؟ ",
  "قد حبيت شخص وخذلك؟ ",
  "كم مره حبيت؟ ",
  "اكبر غلطة بعمرك؟ ",
  "نسبة النعاس عندك حاليًا؟ ",
  "شرايكم بمشاهير التيك توك؟ ",
  "ما الحاسة التي تريد إضافتها للحواس الخمسة؟ ",
  "اسم قريب لقلبك؟ ",
  "مشتاق لمطعم كنت تزوره قبل الحظر؟ ",
  "أول شيء يخطر في بالك إذا سمعت كلمة (ابوي يبيك)؟ ",
  "ما أول مشروع تتوقع أن تقوم بإنشائه إذا أصبحت مليونير؟ ",
  "أغنية عالقة في ذهنك هاليومين؟ ",
  "متى اخر مره قريت قرآن؟ ",
  "كم صلاة فاتتك اليوم؟ ",
  "تفضل التيكن او السنقل؟ ",
  "وش أفضل بوت برأيك؟ ",
"كم لك بالتلي؟ ",
"وش الي تفكر فيه الحين؟ ",
"كيف تشوف الجيل ذا؟ ",
"منشن شخص وقوله، تحبني؟ ",
"لو جاء شخص وعترف لك كيف ترده؟ ",
"مر عليك موقف محرج؟ ",
"وين تشوف نفسك بعد سنتين؟ ",
"لو فزعت/ي لصديق/ه وقالك مالك دخل وش بتسوي/ين؟ ",
"وش اجمل لهجة تشوفها؟ ",
"قد سافرت؟ ",
"افضل مسلسل عندك؟ ",
"افضل فلم عندك؟ ",
"مين اكثر يخون البنات/العيال؟ ",
"متى حبيت؟ ",
  "بالعادة متى تنام؟ ",
  "شيء من صغرك ماتغير فيك؟ ",
  "شيء بسيط قادر يعدل مزاجك بشكل سريع؟ ",
  "تشوف الغيره انانيه او حب؟ ",
"حاجة تشوف نفسك مبدع فيها؟ ",
  "مع او ضد : يسقط جمال المراة بسبب قبح لسانها؟ ",
  "عمرك بكيت على شخص مات في مسلسل ؟ ",
  "‏- هل تعتقد أن هنالك من يراقبك بشغف؟ ",
  "تدوس على قلبك او كرامتك؟ ",
  "اكثر لونين تحبهم مع بعض؟ ",
  "مع او ضد : النوم افضل حل لـ مشاكل الحياة؟ ",
  "سؤال دايم تتهرب من الاجابة عليه؟ ",
  "تحبني ولاتحب الفلوس؟ ",
  "العلاقه السريه دايماً تكون حلوه؟ ",
  "لو أغمضت عينيك الآن فما هو أول شيء ستفكر به؟ ",
"كيف ينطق الطفل اسمك؟ ",
  "ما هي نقاط الضعف في شخصيتك؟ ",
  "اكثر كذبة تقولها؟ ",
  "تيكن ولا اضبطك؟ ",
  "اطول علاقة كنت فيها مع شخص؟ ",
  "قد ندمت على شخص؟ ",
  "وقت فراغك وش تسوي؟ ",
  "عندك أصحاب كثير؟ ولا ينعد بالأصابع؟ ",
  "حاط نغمة خاصة لأي شخص؟ ",
  "وش اسم شهرتك؟ ",
  "أفضل أكلة تحبه لك؟ ",
"عندك شخص تسميه ثالث والدينك؟ ",
  "عندك شخص تسميه ثالث والدينك؟ ",
  "اذا قالو لك تسافر أي مكان تبيه وتاخذ معك شخص واحد وين بتروح ومين تختار؟ ",
  "أطول مكالمة كم ساعة؟ ",
  "تحب الحياة الإلكترونية ولا الواقعية؟ ",
  "كيف حال قلبك ؟ بخير ولا مكسور؟ ",
  "أطول مدة نمت فيها كم ساعة؟ ",
  "تقدر تسيطر على ضحكتك؟ ",
  "أول حرف من اسم الحب؟ ",
  "تحب تحافظ على الذكريات ولا تمسحه؟ ",
  "اسم اخر شخص زعلك؟ ",
"وش نوع الأفلام اللي تحب تتابعه؟ ",
  "أنت انسان غامض ولا الكل يعرف عنك؟ ",
  "لو الجنسية حسب ملامحك وش بتكون جنسيتك؟ ",
  "عندك أخوان او خوات من الرضاعة؟ ",
  "إختصار تحبه؟ ",
  "إسم شخص وتحس أنه كيف؟ ",
  "وش الإسم اللي دايم تحطه بالبرامج؟ ",
  "وش برجك؟ ",
  "لو يجي عيد ميلادك تتوقع يجيك هدية؟ ",
  "اجمل هدية جاتك وش هو؟ ",
  "الصداقة ولا الحب؟ ",
"الصداقة ولا الحب؟ ",
  "الغيرة الزائدة شك؟ ولا فرط الحب؟ ",
  "قد حبيت شخصين مع بعض؟ وانقفطت؟ ",
  "وش أخر شي ضيعته؟ ",
  "قد ضيعت شي ودورته ولقيته بيدك؟ ",
  "تؤمن بمقولة اللي يبيك مايحتار فيك؟ ",
  "سبب وجوك بالتليجرام؟ ",
  "تراقب شخص حاليا؟ ",
  "عندك معجبين ولا محد درا عنك؟ ",
  "لو نسبة جمالك بتكون بعدد شحن جوالك كم بتكون؟ ",
  "أنت محبوب بين الناس؟ ولاكريه؟ ",
"كم عمرك؟ ",
  "لو يسألونك وش اسم امك تجاوبهم ولا تسفل فيهم؟ ",
  "تؤمن بمقولة الصحبة تغنيك الحب؟ ",
  "وش مشروبك المفضل؟ ",
  "قد جربت الدخان بحياتك؟ وانقفطت ولا؟ ",
  "أفضل وقت للسفر؟ الليل ولا النهار؟ ",
  "انت من النوع اللي تنام بخط السفر؟ ",
  "عندك حس فكاهي ولا نفسية؟ ",
  "تبادل الكراهية بالكراهية؟ ولا تحرجه بالطيب؟ ",
  "أفضل ممارسة بالنسبة لك؟ ",
  "لو قالو لك تتخلى عن شي واحد تحبه بحياتك وش يكون؟ ",
"لو احد تركك وبعد فتره يحاول يرجعك بترجع له ولا خلاص؟ ",
  "برأيك كم العمر المناسب للزواج؟ ",
  "اذا تزوجت بعد كم بتخلف عيال؟ ",
  "فكرت وش تسمي أول اطفالك؟ ",
  "من الناس اللي تحب الهدوء ولا الإزعاج؟ ",
  "الشيلات ولا الأغاني؟ ",
  "عندكم شخص مطوع بالعايلة؟ ",
  "تتقبل النصيحة من اي شخص؟ ",
  "اذا غلطت وعرفت انك غلطان تحب تعترف ولا تجحد؟ ",
  "جربت شعور احد يحبك بس انت مو قادر تحبه؟ ",
  "دايم قوة الصداقة تكون بإيش؟ ",
"أفضل البدايات بالعلاقة بـ وش؟ ",
  "وش مشروبك المفضل؟ او قهوتك المفضلة؟ ",
  "تحب تتسوق عبر الانترنت ولا الواقع؟ ",
  "انت من الناس اللي بعد ماتشتري شي وتروح ترجعه؟ ",
  "أخر مرة بكيت متى؟ وليش؟ ",
  "عندك الشخص اللي يقلب الدنيا عشان زعلك؟ ",
  "أفضل صفة تحبه بنفسك؟ ",
  "كلمة تقولها للوالدين؟ ",
  "أنت من الناس اللي تنتقم وترد الاذى ولا تحتسب الأجر وتسامح؟ ",
  "كم عدد سنينك بالتليجرام؟ ",
  "تحب تعترف ولا تخبي؟ ",
"انت من الناس الكتومة ولا تفضفض؟ ",
  "أنت بعلاقة حب الحين؟ ",
  "عندك اصدقاء غير جنسك؟ ",
  "أغلب وقتك تكون وين؟ ",
  "لو المقصود يقرأ وش بتكتب له؟ ",
  "تحب تعبر بالكتابة ولا بالصوت؟ ",
  "عمرك كلمت فويس احد غير جنسك؟ ",
  "لو خيروك تصير مليونير ولا تتزوج الشخص اللي تحبه؟ ",
  "لو عندك فلوس وش السيارة اللي بتشتريها؟ ",
  "كم أعلى مبلغ جمعته؟ ",
  "اذا شفت احد على غلط تعلمه الصح ولا تخليه بكيفه؟ ",
"قد جربت تبكي فرح؟ وليش؟ ",
"تتوقع إنك بتتزوج اللي تحبه؟ ",
  "ما هو أمنيتك؟ ",
  "وين تشوف نفسك بعد خمس سنوات؟ ",
  "لو خيروك تقدم الزمن ولا ترجعه ورا؟ ",
  "لعبة قضيت وقتك فيه بالحجر المنزلي؟ ",
  "تحب تطق الميانة ولا ثقيل؟ ",
  "باقي معاك للي وعدك ما بيتركك؟ ",
  "اول ماتصحى من النوم مين تكلمه؟ ",
  "عندك الشخص اللي يكتب لك كلام كثير وانت نايم؟ ",
  "قد قابلت شخص تحبه؟ وولد ولا بنت؟ ",
   "هل انت تحب كرستين؟",
      "هل انت تحب كومندا؟",
         "هل انت تحب جوو؟",
   "هل انت تحب كرستينن؟",
   "هل انت تحب بارلو؟ ",
"اذا قفطت احد تحب تفضحه ولا تستره؟ ",
  "كلمة للشخص اللي يسب ويسطر؟ ",
  "آية من القران تؤمن فيه؟ ",
  "تحب تعامل الناس بنفس المعاملة؟ ولا تكون أطيب منهم؟ ",
"حاجة ودك تغيرها هالفترة؟ ",
  "كم فلوسك حاليا وهل يكفيك ام لا؟ ",
  "وش لون عيونك الجميلة؟ ",
  "من الناس اللي تتغزل بالكل ولا بالشخص اللي تحبه بس؟ ",
  "اذكر موقف ماتنساه بعمرك؟ ",
  "وش حاب تقول للاشخاص اللي بيدخل حياتك؟ ",
  "ألطف شخص مر عليك بحياتك؟ ",
"انت من الناس المؤدبة ولا نص نص؟ ",
  "كيف الصيد معاك هالأيام ؟ وسنارة ولاشبك؟ ",
  "لو الشخص اللي تحبه قال بدخل حساباتك بتعطيه ولا تكرشه؟ ",
  "أكثر شي تخاف منه بالحياه وش؟ ",
  "اكثر المتابعين عندك باي برنامج؟ ",
  "متى يوم ميلادك؟ ووش الهدية اللي نفسك فيه؟ ",
  "قد تمنيت شي وتحقق؟ ",
  "قلبي على قلبك مهما صار لمين تقولها؟ ",
  "وش نوع جوالك؟ واذا بتغيره وش بتأخذ؟ ",
  "كم حساب عندك بالتليجرام؟ ",
  "متى اخر مرة كذبت؟ ",
"كذبت في الاسئلة اللي مرت عليك قبل شوي؟ ",
  "تجامل الناس ولا اللي بقلبك على لسانك؟ ",
  "قد تمصلحت مع أحد وليش؟ ",
  "وين تعرفت على الشخص اللي حبيته؟ ",
  "قد رقمت او احد رقمك؟ ",
  "وش أفضل لعبته بحياتك؟ ",
  "أخر شي اكلته وش هو؟ ",
  "حزنك يبان بملامحك ولا صوتك؟ ",
  "لقيت الشخص اللي يفهمك واللي يقرا افكارك؟ ",
  "فيه شيء م تقدر تسيطر عليه ؟ ",
  "منشن شخص متحلطم م يعجبه شيء؟ ",
"اكتب تاريخ مستحيل تنساه ",
  "شيء مستحيل انك تاكله ؟ ",
  "تحب تتعرف على ناس جدد ولا مكتفي باللي عندك ؟ ",
  "انسان م تحب تتعامل معاه ابداً ؟ ",
  "شيء بسيط تحتفظ فيه؟ ",
  "فُرصه تتمنى لو أُتيحت لك ؟ ",
  "شيء مستحيل ترفضه ؟. ",
  "لو زعلت بقوة وش بيرضيك ؟ ",
  "تنام بـ اي مكان ، ولا بس غرفتك ؟ ",
  "ردك المعتاد اذا أحد ناداك ؟ ",
  "مين الي تحب يكون مبتسم دائما ؟ ",
" إحساسك في هاللحظة؟ ",
  "وش اسم اول شخص تعرفت عليه فالتلقرام ؟ ",
  "اشياء صعب تتقبلها بسرعه ؟ ",
  "شيء جميل صار لك اليوم ؟ ",
  "اذا شفت شخص يتنمر على شخص قدامك شتسوي؟ ",
  "يهمك ملابسك تكون ماركة ؟ ",
  "ردّك على شخص قال (أنا بطلع من حياتك)؟. ",
  "مين اول شخص تكلمه اذا طحت بـ مصيبة ؟ ",
  "تشارك كل شي لاهلك ولا فيه أشياء ما تتشارك؟ ",
  "كيف علاقتك مع اهلك؟ رسميات ولا ميانة؟ ",
  "عمرك ضحيت باشياء لاجل شخص م يسوى ؟ ",
"اكتب سطر من اغنية او قصيدة جا فـ بالك ؟ ",
  "شيء مهما حطيت فيه فلوس بتكون مبسوط ؟ ",
  "مشاكلك بسبب ؟ ",
  "نسبه الندم عندك للي وثقت فيهم ؟ ",
  "اول حرف من اسم شخص تقوله? بطل تفكر فيني ابي انام؟ ",
  "اكثر شيء تحس انه مات ف مجتمعنا؟ ",
  "لو صار سوء فهم بينك وبين شخص هل تحب توضحه ولا تخليه كذا  لان مالك خلق توضح ؟ ",
  "كم عددكم بالبيت؟ ",
  "عادي تتزوج من برا القبيلة؟ ",
  "أجمل شي بحياتك وش هو؟ ",
} 
return LuaTele.sendText(msg_chat_id,msg_id,texting[math.random(#texting)],'md')
end
end
if text == "كتبات" or text == "حكمه" or text == "قصيده" then 
if Redis:get(MEZO.."MEZO:Status:Games"..msg.chat_id) then
local texting = {"‏من ترك أمرهُ لله، أعطاه الله فوق ما يتمنَّاه💙 ", 
"‏من علامات جمال المرأة .. بختها المايل ! ",
"‏ انك الجميع و كل من احتل قلبي🫀🤍",
"‏ ‏ لقد تْعَمقتُ بكَ كَثيراً والمِيمُ لام .♥️",
"‏ ‏ممكن اكون اختارت غلط بس والله حبيت بجد🖇️",
"‏ علينا إحياء زَمن الرّسائل الورقيّة وسط هذه الفوضى الالكترونية العَارمة. ❍┃ 💜",
"‏ يجي اي الصاروخ الصيني ده جمب الصاروخ المصري لما بيلبس العبايه السوده.🤩♥️",
"‏ كُنت أرقّ من أن أتحمّل كُل تلك القَسوة من عَينيك .🍍",
"‏أَكَان عَلَيَّ أَنْ أغْرَس انيابي فِي قَلْبِك لتشعر بِي ؟.",
"‏ : كُلما أتبع قلبي يدلني إليك .",
"‏ : أيا ليت من تَهواه العينُ تلقاهُ .",
"‏ ‏: رغبتي في مُعانقتك عميقة جداً .??",
"ويُرهقني أنّي مليء بما لا أستطيع قوله.✨",
"‏ من مراتب التعاسه إطالة الندم ع شيء إنتهى. ❍┃ ",
"‏ ‏كل العالم يهون بس الدنيا بينا تصفي 💙",
"‏ بعض الاِعتذارات يجب أن تُرفَضّ.",
"‏ ‏تبدأ حياتك محاولاً فهم كل شيء، وتنهيها محاولاً النجاة من كل ما فهمت.",
"‏ إن الأمر ينتهي بِنا إلى أعتياد أي شيء.",
"‏ هل كانت كل الطرق تؤدي إليكِ، أم أنني كنتُ أجعلها كذلك.",
"‏ ‏هَتفضل تواسيهُم واحد ورا التاني لكن أنتَ هتتنسي ومحدِش هَيواسيك.",
"‏ جَبَرَ الله قلوبِكُم ، وقَلبِي .🍫",
"‏ بس لما أنا ببقى فايق، ببقى أبكم له ودان.💖",
"‏ ‏مقدرش عالنسيان ولو طال الزمن 🖤",
"‏ أنا لستُ لأحد ولا احد لي ، أنا إنسان غريب أساعد من يحتاجني واختفي.",
"‏ ‏أحببتك وأنا منطفئ، فما بالك وأنا في كامل توهجي ؟",
"‏ لا تعودني على دفء شمسك، إذا كان في نيتك الغروب .َ",
"‏ وانتهت صداقة الخمس سنوات بموقف.",
"‏ ‏لا تحب أحداً لِدرجة أن تتقبّل أذاه.",
"‏ إنعدام الرّغبة أمام الشّيء الّذي أدمنته ، انتصار.",
"‏مش جايز , ده اكيد التأخير وارهاق القلب ده وراه عوضاً عظيماً !?? ",
" مش جايز , ده اكيد التأخير وارهاق القلب ده وراه عوضاً عظيماً !💙",
"فـ بالله صبر  وبالله يسر وبالله عون وبالله كل شيئ ♥️. ",
"أنا بعتز بنفسي جداً كصاحب وشايف اللي بيخسرني ، بيخسر أنضف وأجدع شخص ممكن يشوفه . ",
"فجأه جاتلى قافله ‏خلتنى مستعد أخسر أي حد من غير ما أندم عليه . ",
"‏اللهُم قوني بك حين يقِل صبري... ",
"‏يارب سهِل لنا كُل حاجة شايلين هَمها 💙‏ ",
"انا محتاج ايام حلوه بقي عشان مش نافع كدا ! ",
"المشكله مش اني باخد قررات غلط المشكله اني بفكر كويس فيها قبل ما اخدها .. ",
"تخيل وانت قاعد مخنوق كدا بتفكر فالمزاكره اللي مزكرتهاش تلاقي قرار الغاء الدراسه .. ",
" مكانوش يستحقوا المعافرة بأمانه.",
"‏جمل فترة في حياتي، كانت مع اكثر الناس الذين أذتني نفسيًا. ",
" ‏إحنا ليه مبنتحبش يعني فينا اي وحش!",
"أيام مُمله ومستقبل مجهول ونومٌ غير منتظموالأيامُ تمرُ ولا شيَ يتغير ", 
"عندما تهب ريح المصلحه سوف ياتي الجميع رتكدون تحت قدمك ❤️. ",
"عادي مهما تعادي اختك قد الدنيا ف عادي ❤. ",
"بقيت لوحدي بمعنا اي انا اصلا من زمان لوحدي.❤️ ",
"- ‏تجري حياتنا بما لاتشتهي أحلامنا ! ",
"تحملين كل هذا الجمال، ‏ألا تتعبين؟",
"البدايات للكل ، والثبات للصادقين ",
"مُؤخرًا اقتنعت بالجملة دي جدا : Private life always wins. ",
" الافراط في التسامح بيخللي الناس تستهين بيك🍍",
"مهما كنت كويس فـَ إنت معرض لـِ الاستبدال.. ",
"فخوره بنفسي جدًا رغم اني معملتش حاجه فـ حياتي تستحق الذكر والله . ",
"‏إسمها ليلة القدر لأنها تُغير الأقدار ,اللهُمَّ غير قدري لحالٍ تُحبه وعوضني خير .. ",
"فى احتمال كبير انها ليلة القدر ادعوا لنفسكم كتير وأدعو ربنا يشفى كل مريض. 💙 ",
"أنِر ظُلمتي، وامحُ خطيئتي، واقبل توبتي وأعتِق رقبتي يا اللّٰه. إنكَ عفوٌّ تُحِبُّ العفوَ؛ فاعفُ عني 💛 ",
} 
return LuaTele.sendText(msg_chat_id,msg_id,texting[math.random(#texting)],'md')
end
end
if text == "نكته" or text == "قولي نكته" or text == "عايز اضحك" then 
if Redis:get(MEZO.."MEZO:Status:Games"..msg.chat_id) then
local texting = {" مرة واحد مصري دخل سوبر ماركت في الكويت عشان يشتري ولاعة راح عشان يحاسب بيقوله الولاعة ديه بكام قاله دينار قاله منا عارف ان هي نار بس بكام 😂",
"بنت حبت تشتغل مع رئيس عصابة شغلها في غسيل الأموال 😂",
"واحد بيشتكي لصاحبه بيقوله أنا مافيش حد بيحبني ولا يفتكرني أبدًا، ومش عارف أعمل إيه قاله سهلة استلف من الناس فلوس هيسألوا عليك كل يوم 😂",
"ﻣﺮه واﺣﺪ ﻣﺴﻄﻮل ﻣﺎﺷﻰ ﻓﻰ اﻟﺸﺎرع ﻟﻘﻰ مذﻳﻌﻪ ﺑﺘﻘﻮﻟﻪ ﻟﻮ ﺳﻤﺤﺖ ﻓﻴﻦ اﻟﻘﻤﺮ؟ ﻗﺎﻟﻬﺎ اﻫﻮه ﻗﺎﻟﺘﻠﻮ ﻣﺒﺮوك ﻛﺴﺒﺖ ﻋﺸﺮﻳﻦ ﺟﻨﻴﻪ ﻗﺎﻟﻬﺎ ﻓﻰ واﺣﺪ ﺗﺎﻧﻰ ﻫﻨﺎك اﻫﻮه 😂",
"واحده ست سايقه على الجي بي اي قالها انحرفي قليلًا قلعت الطرحة 😂",
"مرة واحد غبي معاه عربية قديمة جدًا وبيحاول يبيعها وماحدش راضي يشتريها.. راح لصاحبه حكاله المشكلة صاحبه قاله عندي لك فكرة جهنمية هاتخليها تتباع الصبح أنت تجيب علامة مرسيدس وتحطها عليها. بعد أسبوعين صاحبه شافه صدفة قاله بعت العربية ولا لاء؟ قاله انت  مجنون حد يبيع مرسيدس ??",
"مره واحد بلديتنا كان بيدق مسمار فى الحائط فالمسمار وقع منه فقال له :تعالى ف مجاش, فقال له: تعالي ف مجاش. فراح بلديتنا رامي على المسمار شوية مسمامير وقال: هاتوه 😂",
"واحدة عملت حساب وهمي ودخلت تكلم جوزها منه ومبسوطة أوي وبتضحك سألوها بتضحكي على إيه قالت لهم أول مرة يقول لي كلام حلو من ساعة ما اتجوزنا 😂",
"بنت حبت تشتغل مع رئيس عصابة شغلها في غسيل الأموال 😂",
"مره واحد اشترى فراخ علشان يربيها فى قفص صدره 😂",
"مرة واحد من الفيوم مات اهله صوصوا عليه 😂",
"ﻣﺮه واﺣﺪ ﻣﺴﻄﻮل ﻣﺎﺷﻰ ﻓﻰ اﻟﺸﺎرع ﻟﻘﻰ مذﻳﻌﻪ ﺑﺘﻘﻮﻟﻪ ﻟﻮ ﺳﻤﺤﺖ ﻓﻴﻦ اﻟﻘﻤﺮ ﻗﺎﻟﻬﺎ اﻫﻮه ﻗﺎﻟﺘﻠﻮ ﻣﺒﺮوك ﻛﺴﺒﺖ ﻋﺸﺮﻳﻦ ﺟﻨﻴﻪ ﻗﺎﻟﻬﺎ ﻓﻰ واﺣﺪ ﺗﺎﻧﻰ ﻫﻨﺎك اﻫﻮه 😂",
"مره واحد شاط كرة فى المقص اتخرمت. 😂",
"مرة واحد رايح لواحد صاحبهفا البواب وقفه بيقول له انت طالع لمين قاله طالع أسمر شوية لبابايا قاله يا أستاذ طالع لمين في العماره 😂",
} 
return LuaTele.sendText(msg_chat_id,msg_id,texting[math.random(#texting)],'md')
end
end
if text == "خيرني" or text == "لو خيروك" or text == "خيروك" then 
if Redis:get(MEZO.."MEZO:Status:Games"..msg.chat_id) then
local texting = {"لو خيروك |  بين الإبحار لمدة أسبوع كامل أو السفر على متن طائرة لـ 3 أيام متواصلة؟ ",
"لو خيروك |  بين شراء منزل صغير أو استئجار فيلا كبيرة بمبلغ معقول؟ ",
"لو خيروك |  أن تعيش قصة فيلم هل تختار الأكشن أو الكوميديا؟ ",
"لو خيروك |  بين تناول البيتزا وبين الايس كريم وذلك بشكل دائم؟ ",
"لو خيروك |  بين إمكانية تواجدك في الفضاء وبين إمكانية تواجدك في البحر؟ ",
"لو خيروك |  بين تغيير وظيفتك كل سنة أو البقاء بوظيفة واحدة طوال حياتك؟ ",
"لو خيروك |  أسئلة محرجة أسئلة صراحة ماذا ستختار؟ ",
"لو خيروك |  بين الذهاب إلى الماضي والعيش مع جدك أو بين الذهاب إلى المستقبل والعيش مع أحفادك؟ ",
"لو كنت شخص اخر هل تفضل البقاء معك أم أنك ستبتعد عن نفسك؟ ",
"لو خيروك |  بين الحصول على الأموال في عيد ميلادك أو على الهدايا؟ ",
"لو خيروك |  بين القفز بمظلة من طائرة أو الغوص في أعماق البحر؟ ",
"لو خيروك |  بين الاستماع إلى الأخبار الجيدة أولًا أو الاستماع إلى الأخبار السيئة أولًا؟ ",
"لو خيروك |  بين أن تكون رئيس لشركة فاشلة أو أن تكون موظف في شركة ناجحة؟ ",
"لو خيروك |  بين أن يكون لديك جيران صاخبون أو أن يكون لديك جيران فضوليون؟ ",
"لو خيروك |  بين أن تكون شخص مشغول دائمًا أو أن تكون شخص يشعر بالملل دائمًا؟ ",
"لو خيروك |  بين قضاء يوم كامل مع الرياضي الذي تشجعه أو نجم السينما الذي تحبه؟ ",
"لو خيروك |  بين استمرار فصل الشتاء دائمًا أو بقاء فصل الصيف؟ ",
"لو خيروك |  بين العيش في القارة القطبية أو العيش في الصحراء؟ ",
"لو خيروك |  بين أن تكون لديك القدرة على حفظ كل ما تسمع أو تقوله وبين القدرة على حفظ كل ما تراه أمامك؟ ",
"لو خيروك |  بين أن يكون طولك 150 سنتي متر أو أن يكون 190 سنتي متر؟ ",
"لو خيروك |  بين إلغاء رحلتك تمامًا أو بقائها ولكن فقدان الأمتعة والأشياء الخاص بك خلالها؟ ",
"لو خيروك |  بين أن تكون اللاعب الأفضل في فريق كرة فاشل أو أن تكون لاعب عادي في فريق كرة ناجح؟ ",
"لو خيروك |  بين ارتداء ملابس البيت لمدة أسبوع كامل أو ارتداء البدلة الرسمية لنفس المدة؟ ",
"لو خيروك |  بين امتلاك أفضل وأجمل منزل ولكن في حي سيء أو امتلاك أسوأ منزل ولكن في حي جيد وجميل؟ ",
"لو خيروك |  بين أن تكون غني وتعيش قبل 500 سنة، أو أن تكون فقير وتعيش في عصرنا الحالي؟ ",
"لو خيروك |  بين ارتداء ملابس الغوص ليوم كامل والذهاب إلى العمل أو ارتداء ملابس جدك/جدتك؟ ",
"لو خيروك |  بين قص شعرك بشكل قصير جدًا أو صبغه باللون الوردي؟ ",
"لو خيروك |  بين أن تضع الكثير من الملح على كل الطعام بدون علم أحد، أو أن تقوم بتناول شطيرة معجون أسنان؟ ",
"لو خيروك |  بين قول الحقيقة والصراحة الكاملة مدة 24 ساعة أو الكذب بشكل كامل مدة 3 أيام؟ ",
"لو خيروك |  بين تناول الشوكولا التي تفضلها لكن مع إضافة رشة من الملح والقليل من عصير الليمون إليها أو تناول ليمونة كاملة كبيرة الحجم؟ ",
"لو خيروك |  بين وضع أحمر الشفاه على وجهك ما عدا شفتين أو وضع ماسكارا على شفتين فقط؟ ",
"لو خيروك |  بين الرقص على سطح منزلك أو الغناء على نافذتك؟ ",
"لو خيروك |  بين تلوين شعرك كل خصلة بلون وبين ارتداء ملابس غير متناسقة لمدة أسبوع؟ ",
"لو خيروك |  بين تناول مياه غازية مجمدة وبين تناولها ساخنة؟ ",
"لو خيروك |  بين تنظيف شعرك بسائل غسيل الأطباق وبين استخدام كريم الأساس لغسيل الأطباق؟ ",
"لو خيروك |  بين تزيين طبق السلطة بالبرتقال وبين إضافة البطاطا لطبق الفاكهة؟ ",
"لو خيروك |  بين اللعب مع الأطفال لمدة 7 ساعات أو الجلوس دون فعل أي شيء لمدة 24 ساعة؟ ",
"لو خيروك |  بين شرب كوب من الحليب أو شرب كوب من شراب عرق السوس؟ ",
"لو خيروك |  بين الشخص الذي تحبه وصديق الطفولة؟ ",
"لو خيروك |  بين أمك وأبيك؟ ",
"لو خيروك |  بين أختك وأخيك؟ ",
"لو خيروك |  بين نفسك وأمك؟ ",
"لو خيروك |  بين صديق قام بغدرك وعدوك؟ ",
"لو خيروك |  بين خسارة حبيبك/حبيبتك أو خسارة أخيك/أختك؟ ",
"لو خيروك |  بإنقاذ شخص واحد مع نفسك بين أمك أو ابنك؟ ",
"لو خيروك |  بين ابنك وابنتك؟ ",
"لو خيروك |  بين زوجتك وابنك/ابنتك؟ ",
"لو خيروك |  بين جدك أو جدتك؟ ",
"لو خيروك |  بين زميل ناجح وحده أو زميل يعمل كفريق؟ ",
"لو خيروك |  بين لاعب كرة قدم مشهور أو موسيقي مفضل بالنسبة لك؟ ",
"لو خيروك |  بين مصور فوتوغرافي جيد وبين مصور سيء ولكنه عبقري فوتوشوب؟ ",
"لو خيروك |  بين سائق سيارة يقودها ببطء وبين سائق يقودها بسرعة كبيرة؟ ",
"لو خيروك |  بين أستاذ اللغة العربية أو أستاذ الرياضيات؟ ",
"لو خيروك |  بين أخيك البعيد أو جارك القريب؟ ",
"لو خيروك |  يبن صديقك البعيد وبين زميلك القريب؟ ",
"لو خيروك |  بين رجل أعمال أو أمير؟ ",
"لو خيروك |  بين نجار أو حداد؟ ",
"لو خيروك |  بين طباخ أو خياط؟ ",
"لو خيروك |  بين أن تكون كل ملابس بمقاس واحد كبير الحجم أو أن تكون جميعها باللون الأصفر؟ ",
"لو خيروك |  بين أن تتكلم بالهمس فقط طوال الوقت أو أن تصرخ فقط طوال الوقت؟ ",
"لو خيروك |  بين أن تمتلك زر إيقاف موقت للوقت أو أن تمتلك أزرار للعودة والذهاب عبر الوقت؟ ",
"لو خيروك |  بين أن تعيش بدون موسيقى أبدًا أو أن تعيش بدون تلفاز أبدًا؟ ",
"لو خيروك |  بين أن تعرف متى سوف تموت أو أن تعرف كيف سوف تموت؟ ",
"لو خيروك |  بين العمل الذي تحلم به أو بين إيجاد شريك حياتك وحبك الحقيقي؟ ",
"لو خيروك |  بين معاركة دب أو بين مصارعة تمساح؟ ",
"لو خيروك |  بين إما الحصول على المال أو على المزيد من الوقت؟ ",
"لو خيروك |  بين امتلاك قدرة التحدث بكل لغات العالم أو التحدث إلى الحيوانات؟ ",
"لو خيروك |  بين أن تفوز في اليانصيب وبين أن تعيش مرة ثانية؟ ",
"لو خيروك |  بأن لا يحضر أحد إما لحفل زفافك أو إلى جنازتك؟ ",
"لو خيروك |  بين البقاء بدون هاتف لمدة شهر أو بدون إنترنت لمدة أسبوع؟ ",
"لو خيروك |  بين العمل لأيام أقل في الأسبوع مع زيادة ساعات العمل أو العمل لساعات أقل في اليوم مع أيام أكثر؟ ",
"لو خيروك |  بين مشاهدة الدراما في أيام السبعينيات أو مشاهدة الأعمال الدرامية للوقت الحالي؟ ",
"لو خيروك |  بين التحدث عن كل شيء يدور في عقلك وبين عدم التحدث إطلاقًا؟ ",
"لو خيروك |  بين مشاهدة فيلم بمفردك أو الذهاب إلى مطعم وتناول العشاء بمفردك؟ ",
"لو خيروك |  بين قراءة رواية مميزة فقط أو مشاهدتها بشكل فيلم بدون القدرة على قراءتها؟ ",
"لو خيروك |  بين أن تكون الشخص الأكثر شعبية في العمل أو المدرسة وبين أن تكون الشخص الأكثر ذكاءً؟ ",
"لو خيروك |  بين إجراء المكالمات الهاتفية فقط أو إرسال الرسائل النصية فقط؟ ",
"لو خيروك |  بين إنهاء الحروب في العالم أو إنهاء الجوع في العالم؟ ",
"لو خيروك |  بين تغيير لون عينيك أو لون شعرك؟ ",
"لو خيروك |  بين امتلاك كل عين لون وبين امتلاك نمش على خديك؟ ",
"لو خيروك |  بين الخروج بالمكياج بشكل مستمر وبين الحصول على بشرة صحية ولكن لا يمكن لك تطبيق أي نوع من المكياج؟ ",
"لو خيروك |  بين أن تصبحي عارضة أزياء وبين ميك اب أرتيست؟ ",
"لو خيروك |  بين مشاهدة كرة القدم أو متابعة الأخبار؟ ",
"لو خيروك |  بين موت شخصية بطل الدراما التي تتابعينها أو أن يبقى ولكن يكون العمل الدرامي سيء جدًا؟ ",
"لو خيروك |  بين العيش في دراما قد سبق وشاهدتها ماذا تختارين بين الكوميديا والتاريخي؟ ",
"لو خيروك |  بين امتلاك القدرة على تغيير لون شعرك متى تريدين وبين الحصول على مكياج من قبل خبير تجميل وذلك بشكل يومي؟ ",
"لو خيروك |  بين نشر تفاصيل حياتك المالية وبين نشر تفاصيل حياتك العاطفية؟ ",
"لو خيروك |  بين البكاء والحزن وبين اكتساب الوزن؟ ",
"لو خيروك |  بين تنظيف الأطباق كل يوم وبين تحضير الطعام؟ ",
"لو خيروك |  بين أن تتعطل سيارتك في نصف الطريق أو ألا تتمكنين من ركنها بطريقة صحيحة؟ ",
"لو خيروك |  بين إعادة كل الحقائب التي تملكينها أو إعادة الأحذية الجميلة الخاصة بك؟ ",
"لو خيروك |  بين قتل حشرة أو متابعة فيلم رعب؟ ",
"لو خيروك |  بين امتلاك قطة أو كلب؟ ",
"لو خيروك |  بين الصداقة والحب ",
"لو خيروك |  بين تناول الشوكولا التي تحبين طوال حياتك ولكن لا يمكنك الاستماع إلى الموسيقى وبين الاستماع إلى الموسيقى ولكن لا يمكن لك تناول الشوكولا أبدًا؟ ",
"لو خيروك |  بين مشاركة المنزل مع عائلة من الفئران أو عائلة من الأشخاص المزعجين الفضوليين الذين يتدخلون في كل كبيرة وصغيرة؟ ",
} 
return LuaTele.sendText(msg_chat_id,msg_id,texting[math.random(#texting)],'md')
end
end
if text == "حروف" or text == "حرف" or text == "الحروف" then 
if Redis:get(MEZO.."MEZO:Status:Games"..msg.chat_id) then
local texting = {" جماد بحرف ⏎ ر  ", 
" مدينة بحرف ⏎ ع  ",
" حيوان ونبات بحرف ⏎ خ  ", 
" اسم بحرف ⏎ ح  ", 
" اسم ونبات بحرف ⏎ م  ", 
" دولة عربية بحرف ⏎ ق  ", 
" جماد بحرف ⏎ ي  ", 
" نبات بحرف ⏎ ج  ", 
" اسم بنت بحرف ⏎ ع  ", 
" اسم ولد بحرف ⏎ ع  ", 
" اسم بنت وولد بحرف ⏎ ث  ", 
" جماد بحرف ⏎ ج  ",
" حيوان بحرف ⏎ ص  ",
" دولة بحرف ⏎ س  ",
" نبات بحرف ⏎ ج  ",
" مدينة بحرف ⏎ ب  ",
" نبات بحرف ⏎ ر  ",
" اسم بحرف ⏎ ك  ",
" حيوان بحرف ⏎ ظ  ",
" جماد بحرف ⏎ ذ  ",
" مدينة بحرف ⏎ و  ",
" اسم بحرف ⏎ م  ",
" اسم بنت بحرف ⏎ خ  ",
" اسم و نبات بحرف ⏎ ر  ",
" نبات بحرف ⏎ و  ",
" حيوان بحرف ⏎ س  ",
" مدينة بحرف ⏎ ك  ",
" اسم بنت بحرف ⏎ ص  ",
" اسم ولد بحرف ⏎ ق  ",
" نبات بحرف ⏎ ز  ",
"  جماد بحرف ⏎ ز  ",
"  مدينة بحرف ⏎ ط  ",
"  جماد بحرف ⏎ ن  ",
"  مدينة بحرف ⏎ ف  ",
"  حيوان بحرف ⏎ ض  ",
"  اسم بحرف ⏎ ك  ",
"  نبات و حيوان و مدينة بحرف ⏎ س  ", 
"  اسم بنت بحرف ⏎ ج  ", 
"  مدينة بحرف ⏎ ت  ", 
"  جماد بحرف ⏎ ه  ", 
"  اسم بنت بحرف ⏎ ر  ", 
" اسم ولد بحرف ⏎ خ  ", 
" جماد بحرف ⏎ ع  ",
" حيوان بحرف ⏎ ح  ",
" نبات بحرف ⏎ ف  ",
" اسم بنت بحرف ⏎ غ  ",
" اسم ولد بحرف ⏎ و  ",
" نبات بحرف ⏎ ل  ",
"مدينة بحرف ⏎ ع  ",
"دولة واسم بحرف ⏎ ب  ",
} 
return LuaTele.sendText(msg_chat_id,msg_id,texting[math.random(#texting)],'md')
end
end
if text == "الاسرع" or tect == "ترتيب" then
if Redis:get(MEZO.."MEZO:Status:Games"..msg.chat_id) then
KlamSpeed = {"سحور","سياره","استقبال","قنفه","ايفون","بزونه","مطبخ","كرستيانو","دجاجه","مدرسه","الوان","غرفه","ثلاجه","كهوه","سفينه","العراق","محطه","طياره","رادار","منزل","مستشفى","كهرباء","تفاحه","اخطبوط","سلمون","فرنسا","برتقاله","تفاح","مطرقه","بتيته","لهانه","شباك","باص","سمكه","ذباب","تلفاز","حاسوب","انترنيت","ساحه","جسر"};
name = KlamSpeed[math.random(#KlamSpeed)]
Redis:set(MEZO.."MEZO:Game:Monotonous"..msg.chat_id,name)
name = string.gsub(name,"سحور","س ر و ح")
name = string.gsub(name,"سياره","ه ر س ي ا")
name = string.gsub(name,"استقبال","ل ب ا ت ق س ا")
name = string.gsub(name,"قنفه","ه ق ن ف")
name = string.gsub(name,"ايفون","و ن ف ا")
name = string.gsub(name,"بزونه","ز و ه ن")
name = string.gsub(name,"مطبخ","خ ب ط م")
name = string.gsub(name,"كرستيانو","س ت ا ن و ك ر ي")
name = string.gsub(name,"دجاجه","ج ج ا د ه")
name = string.gsub(name,"مدرسه","ه م د ر س")
name = string.gsub(name,"الوان","ن ا و ا ل")
name = string.gsub(name,"غرفه","غ ه ر ف")
name = string.gsub(name,"ثلاجه","ج ه ت ل ا")
name = string.gsub(name,"كهوه","ه ك ه و")
name = string.gsub(name,"سفينه","ه ن ف ي س")
name = string.gsub(name,"العراق","ق ع ا ل ر ا")
name = string.gsub(name,"محطه","ه ط م ح")
name = string.gsub(name,"طياره","ر ا ط ي ه")
name = string.gsub(name,"رادار","ر ا ر ا د")
name = string.gsub(name,"منزل","ن ز م ل")
name = string.gsub(name,"مستشفى","ى ش س ف ت م")
name = string.gsub(name,"كهرباء","ر ب ك ه ا ء")
name = string.gsub(name,"تفاحه","ح ه ا ت ف")
name = string.gsub(name,"اخطبوط","ط ب و ا خ ط")
name = string.gsub(name,"سلمون","ن م و ل س")
name = string.gsub(name,"فرنسا","ن ف ر س ا")
name = string.gsub(name,"برتقاله","ر ت ق ب ا ه ل")
name = string.gsub(name,"تفاح","ح ف ا ت")
name = string.gsub(name,"مطرقه","ه ط م ر ق")
name = string.gsub(name,"بتيته","ب ت ت ي ه")
name = string.gsub(name,"لهانه","ه ن ل ه ل")
name = string.gsub(name,"شباك","ب ش ا ك")
name = string.gsub(name,"باص","ص ا ب")
name = string.gsub(name,"سمكه","ك س م ه")
name = string.gsub(name,"ذباب","ب ا ب ذ")
name = string.gsub(name,"تلفاز","ت ف ل ز ا")
name = string.gsub(name,"حاسوب","س ا ح و ب")
name = string.gsub(name,"انترنيت","ا ت ن ر ن ي ت")
name = string.gsub(name,"ساحه","ح ا ه س")
name = string.gsub(name,"جسر","ر ج س")
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ اسرع واحد يرتبها ~ ⟦ "..name.." ⟧","md",true)  
end
end
if text == "اعلام" or tect == "الاعلام" then
if Redis:get(MEZO.."MEZO:Status:Games"..msg.chat_id) then
AlamSpeed = {"انجلترا","البرازيل","مصر","كندا","فرنسا","اسبانيا","الارجنتين","اليمن","تونس","العراق","فلسطين","امريكا","سوريا","روسيا","البحرين","قطر","الاردن","الصين","ليبيا","السعوديه","الجزائر","لبنان","كوريا","ايطاليا","تركيا","البرتغال","المكسيك","سويسرا","نيجيريا","كرواتيا","السودان","الكاميرون","النيجر","المغرب"};
name = AlamSpeed[math.random(#AlamSpeed)]
Redis:set(MEZO.."MEZO:Game:Alam"..msg.chat_id,name)
name = string.gsub(name,"انجلترا","🇦🇺")
name = string.gsub(name,"البرازيل","🇧🇷")
name = string.gsub(name,"مصر","🇪🇬")
name = string.gsub(name,"كندا","🇨🇦")
name = string.gsub(name,"فرنسا","🏴‍☠️")
name = string.gsub(name,"اسبانيا","🇪🇦")
name = string.gsub(name,"الارجنتين","🇦🇷")
name = string.gsub(name,"اليمن","🇾🇪")
name = string.gsub(name,"تونس","🇹🇳")
name = string.gsub(name,"العراق","🇮🇶")
name = string.gsub(name,"فلسطين","🇵🇸")
name = string.gsub(name,"امريكا","🇺🇸")
name = string.gsub(name,"سوريا","🇸🇾")
name = string.gsub(name,"روسيا","🇷🇺")
name = string.gsub(name,"البحرين","🇧🇭")
name = string.gsub(name,"قطر","🇶🇦")
name = string.gsub(name,"الاردن","🇯🇴")
name = string.gsub(name,"الصين","🇨🇳")
name = string.gsub(name,"ليبيا","🇱🇾")
name = string.gsub(name,"السعوديه","🇸🇦")
name = string.gsub(name,"الجزائر","🇩🇿")
name = string.gsub(name,"لبنان","🇱🇧")
name = string.gsub(name,"كوريا","🇰🇷")
name = string.gsub(name,"ايطاليا","🇮🇹")
name = string.gsub(name,"تركيا","🇹🇷")
name = string.gsub(name,"البرتغال","🇵🇹")
name = string.gsub(name,"المكسيك","🇲🇽")
name = string.gsub(name,"سويسرا","🇨🇭")
name = string.gsub(name,"كرواتيا","🇭🇷")
name = string.gsub(name,"السودان","🇸🇩")
name = string.gsub(name,"الكاميرون","🇨🇲")
name = string.gsub(name,"النيجر","🇳🇪")
name = string.gsub(name,"المغرب","🇲🇦")
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ اسرع واحد يكتب اسم العلم ~ ⟦ "..name.." ⟧","md",true)  
end
end
if text == "حزوره" then
if Redis:get(MEZO.."MEZO:Status:Games"..msg.chat_id) then
Hzora = {"الجرس","عقرب الساعه","السمك","المطر","5","الكتاب","البسمار","7","الكعبه","بيت الشعر","لهانه","انا","امي","الابره","الساعه","22","غلط","كم الساعه","البيتنجان","البيض","المرايه","الضوء","الهواء","الضل","العمر","القلم","المشط","الحفره","البحر","الثلج","الاسفنج","الصوت","بلم"};
name = Hzora[math.random(#Hzora)]
Redis:set(MEZO.."MEZO:Game:Riddles"..msg.chat_id,name)
name = string.gsub(name,"الجرس","شيئ اذا لمسته صرخ ما هوه ؟")
name = string.gsub(name,"عقرب الساعه","اخوان لا يستطيعان تمضيه اكثر من دقيقه معا فما هما ؟")
name = string.gsub(name,"السمك","ما هو الحيوان الذي لم يصعد الى سفينة نوح عليه السلام ؟")
name = string.gsub(name,"المطر","شيئ يسقط على رأسك من الاعلى ولا يجرحك فما هو ؟")
name = string.gsub(name,"5","ما العدد الذي اذا ضربته بنفسه واضفت عليه 5 يصبح ثلاثين ")
name = string.gsub(name,"الكتاب","ما الشيئ الذي له اوراق وليس له جذور ؟")
name = string.gsub(name,"البسمار","ما هو الشيئ الذي لا يمشي الا بالضرب ؟")
name = string.gsub(name,"7","عائله مؤلفه من 6 بنات واخ لكل منهن .فكم عدد افراد العائله ")
name = string.gsub(name,"الكعبه","ما هو الشيئ الموجود وسط مكة ؟")
name = string.gsub(name,"بيت الشعر","ما هو البيت الذي ليس فيه ابواب ولا نوافذ ؟ ")
name = string.gsub(name,"لهانه","وحده حلوه ومغروره تلبس مية تنوره .من هيه ؟ ")
name = string.gsub(name,"انا","ابن امك وابن ابيك وليس باختك ولا باخيك فمن يكون ؟")
name = string.gsub(name,"امي","اخت خالك وليست خالتك من تكون ؟ ")
name = string.gsub(name,"الابره","ما هو الشيئ الذي كلما خطا خطوه فقد شيئا من ذيله ؟ ")
name = string.gsub(name,"الساعه","ما هو الشيئ الذي يقول الصدق ولكنه اذا جاع كذب ؟")
name = string.gsub(name,"22","كم مره ينطبق عقربا الساعه على بعضهما في اليوم الواحد ")
name = string.gsub(name,"غلط","ما هي الكلمه الوحيده التي تلفض غلط دائما ؟ ")
name = string.gsub(name,"كم الساعه","ما هو السؤال الذي تختلف اجابته دائما ؟")
name = string.gsub(name,"البيتنجان","جسم اسود وقلب ابيض وراس اخظر فما هو ؟")
name = string.gsub(name,"البيض","ماهو الشيئ الذي اسمه على لونه ؟")
name = string.gsub(name,"المرايه","ارى كل شيئ من دون عيون من اكون ؟ ")
name = string.gsub(name,"الضوء","ما هو الشيئ الذي يخترق الزجاج ولا يكسره ؟")
name = string.gsub(name,"الهواء","ما هو الشيئ الذي يسير امامك ولا تراه ؟")
name = string.gsub(name,"الضل","ما هو الشيئ الذي يلاحقك اينما تذهب ؟ ")
name = string.gsub(name,"العمر","ما هو الشيء الذي كلما طال قصر ؟ ")
name = string.gsub(name,"القلم","ما هو الشيئ الذي يكتب ولا يقرأ ؟")
name = string.gsub(name,"المشط","له أسنان ولا يعض ما هو ؟ ")
name = string.gsub(name,"الحفره","ما هو الشيئ اذا أخذنا منه ازداد وكبر ؟")
name = string.gsub(name,"البحر","ما هو الشيئ الذي يرفع اثقال ولا يقدر يرفع مسمار ؟")
name = string.gsub(name,"الثلج","انا ابن الماء فان تركوني في الماء مت فمن انا ؟")
name = string.gsub(name,"الاسفنج","كلي ثقوب ومع ذالك احفض الماء فمن اكون ؟")
name = string.gsub(name,"الصوت","اسير بلا رجلين ولا ادخل الا بالاذنين فمن انا ؟")
name = string.gsub(name,"بلم","حامل ومحمول نصف ناشف ونصف مبلول فمن اكون ؟ ")
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ اسرع واحد يحل الحزوره ↓\n ⟦ "..name.." ⟧","md",true)  
end
end
if text == "معاني" then
if Redis:get(MEZO.."MEZO:Status:Games"..msg.chat_id) then
Redis:del(MEZO.."MEZO:Set:Maany"..msg.chat_id)
Maany_Rand = {"قرد","دجاجه","بطريق","ضفدع","بومه","نحله","ديك","جمل","بقره","دولفين","تمساح","قرش","نمر","اخطبوط","سمكه","خفاش","اسد","فأر","ذئب","فراشه","عقرب","زرافه","قنفذ","تفاحه","باذنجان"}
name = Maany_Rand[math.random(#Maany_Rand)]
Redis:set(MEZO.."MEZO:Game:Meaningof"..msg.chat_id,name)
name = string.gsub(name,"قرد","🐒")
name = string.gsub(name,"دجاجه","🐔")
name = string.gsub(name,"بطريق","🐧")
name = string.gsub(name,"ضفدع","🐸")
name = string.gsub(name,"بومه","🦉")
name = string.gsub(name,"نحله","🐝")
name = string.gsub(name,"ديك","🐓")
name = string.gsub(name,"جمل","🐫")
name = string.gsub(name,"بقره","🐄")
name = string.gsub(name,"دولفين","🐬")
name = string.gsub(name,"تمساح","🐊")
name = string.gsub(name,"قرش","🦈")
name = string.gsub(name,"نمر","🐅")
name = string.gsub(name,"اخطبوط","🐙")
name = string.gsub(name,"سمكه","🐟")
name = string.gsub(name,"خفاش","🦇")
name = string.gsub(name,"اسد","🦁")
name = string.gsub(name,"فأر","🐭")
name = string.gsub(name,"ذئب","🐺")
name = string.gsub(name,"فراشه","🦋")
name = string.gsub(name,"عقرب","🦂")
name = string.gsub(name,"زرافه","🦒")
name = string.gsub(name,"قنفذ","🦔")
name = string.gsub(name,"تفاحه","🍎")
name = string.gsub(name,"باذنجان","🍆")
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ اسرع واحد يدز معنى السمايل ~ ⟦ "..name.." ⟧","md",true)  
end
end
if text == "العكس" then
if Redis:get(MEZO.."MEZO:Status:Games"..msg.chat_id) then
Redis:del(MEZO.."MEZO:Set:Aks"..msg.chat_id)
katu = {"باي","فهمت","موزين","اسمعك","احبك","موحلو","نضيف","حاره","ناصي","جوه","سريع","ونسه","طويل","سمين","ضعيف","شريف","شجاع","رحت","عدل","نشيط","شبعان","موعطشان","خوش ولد","اني","هادئ"}
name = katu[math.random(#katu)]
Redis:set(MEZO.."MEZO:Game:Reflection"..msg.chat_id,name)
name = string.gsub(name,"باي","هلو")
name = string.gsub(name,"فهمت","مافهمت")
name = string.gsub(name,"موزين","زين")
name = string.gsub(name,"اسمعك","ماسمعك")
name = string.gsub(name,"احبك","ماحبك")
name = string.gsub(name,"موحلو","حلو")
name = string.gsub(name,"نضيف","وصخ")
name = string.gsub(name,"حاره","بارده")
name = string.gsub(name,"ناصي","عالي")
name = string.gsub(name,"جوه","فوك")
name = string.gsub(name,"سريع","بطيء")
name = string.gsub(name,"ونسه","ضوجه")
name = string.gsub(name,"طويل","قزم")
name = string.gsub(name,"سمين","ضعيف")
name = string.gsub(name,"ضعيف","قوي")
name = string.gsub(name,"شريف","كواد")
name = string.gsub(name,"شجاع","جبان")
name = string.gsub(name,"رحت","اجيت")
name = string.gsub(name,"عدل","ميت")
name = string.gsub(name,"نشيط","كسول")
name = string.gsub(name,"شبعان","جوعان")
name = string.gsub(name,"موعطشان","عطشان")
name = string.gsub(name,"خوش ولد","موخوش ولد")
name = string.gsub(name,"اني","مطي")
name = string.gsub(name,"هادئ","عصبي")
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ اسرع واحد يدز العكس ~ ⟦ "..name.." ⟧","md",true)  
end
end
if text == "بات" or text == "محيبس" then   
if Redis:get(MEZO.."MEZO:Status:Games"..msg.chat_id) then 
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '⟦ ❶ ‹- 👊 ⟧', data = '/Mahibes1'}, {text = '⟦ ❷ ‹- 👊 ⟧', data = '/Mahibes2'}, 
},
{
{text = '⟦ ❸ ‹- 👊 ⟧', data = '/Mahibes3'}, {text = '⟦ ❹ ‹- 👊 ⟧', data = '/Mahibes4'}, 
},
{
{text = '⟦ ❺ ‹- 👊 ⟧', data = '/Mahibes5'}, {text = '⟦ ❻ ‹- 👊 ⟧', data = '/Mahibes6'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id, [[*
╗•لعبه المحيبس هي لعبة الحظ ⦁
╣•جرب حظك ويه البوت واتونس ⦁
╣•كل ما عليك هوا الضغط على ⦁
╝•احدى العضمات في الازرار ⦁
*]],"md",false, false, false, false, reply_markup)
end
end
if text == "خمن" or text == "تخمين" then   
if Redis:get(MEZO.."MEZO:Status:Games"..msg.chat_id) then
Num = math.random(1,20)
Redis:set(MEZO.."MEZO:Game:Estimate"..msg.chat_id..msg.sender.user_id,Num)  
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ اهلا بك عزيزي في لعبة التخمين :\nٴ━━━━━━━━━━\n".." ❍┃ ملاحظه لديك { 3 } محاولات فقط فكر قبل ارسال تخمينك \n\n".." ❍┃ سيتم تخمين عدد ما بين ال {1 و 20} اذا تعتقد انك تستطيع الفوز جرب واللعب الان ؟ ","md",true)  
end
end
if text == "المختلف" then
if Redis:get(MEZO.."MEZO:Status:Games"..msg.chat_id) then
mktlf = {"😸","☠","🐼","🐇","🌑","🌚","⭐️","✨","⛈","🌥","⛄️","👨‍🔬","👨‍💻","👨‍🔧","🧚‍♀","??‍♂","🧝‍♂","🙍‍♂","🧖‍♂","👬","🕒","🕤","⌛️","📅",};
name = mktlf[math.random(#mktlf)]
Redis:set(MEZO.."MEZO:Game:Difference"..msg.chat_id,name)
name = string.gsub(name,"😸","😹😹😹😹😹😹😹😹😸😹😹😹😹")
name = string.gsub(name,"☠","💀💀💀💀💀💀💀☠💀💀💀💀💀")
name = string.gsub(name,"🐼","👻👻👻🐼👻👻👻👻👻👻👻")
name = string.gsub(name,"🐇","🕊??🕊🕊🕊🐇🕊🕊🕊🕊")
name = string.gsub(name,"🌑","🌚🌚🌚🌚🌚🌑🌚🌚🌚")
name = string.gsub(name,"🌚","🌑🌑🌑🌑🌑🌚🌑🌑🌑")
name = string.gsub(name,"⭐️","??🌟🌟🌟🌟🌟🌟🌟⭐️🌟🌟🌟")
name = string.gsub(name,"✨","💫💫💫💫💫✨💫💫💫💫")
name = string.gsub(name,"⛈","🌨🌨🌨🌨🌨⛈🌨🌨🌨🌨")
name = string.gsub(name,"🌥","⛅️⛅️⛅️⛅️⛅️⛅️🌥⛅️⛅️⛅️⛅️")
name = string.gsub(name,"⛄️","☃☃☃☃☃☃⛄️☃☃☃☃")
name = string.gsub(name,"👨‍🔬","??‍??👩‍🔬👩‍🔬👩‍🔬👩‍🔬👩‍🔬👩‍🔬👩‍🔬👨‍🔬👩‍🔬👩‍🔬👩‍🔬")
name = string.gsub(name,"👨‍💻","👩‍💻👩‍‍💻👩‍‍💻👨‍💻💻👩‍💻👩‍💻")
name = string.gsub(name,"👨‍🔧","👩‍🔧👩‍🔧👩‍🔧👩‍🔧👩‍🔧👩‍🔧👨‍🔧👩‍🔧")
name = string.gsub(name,"👩‍🍳","👨‍🍳👨‍🍳👨‍🍳👨‍🍳??‍🍳👩‍🍳👨‍🍳👨‍🍳👨‍🍳")
name = string.gsub(name,"🧚‍♀","🧚‍♂🧚‍♂🧚‍♂🧚‍♂🧚‍♀🧚‍♂🧚‍♂")
name = string.gsub(name,"🧜‍♂","🧜‍♀🧜‍♀🧜‍♀🧜‍♀🧜‍♀🧚‍♂🧜‍♀🧜‍♀🧜‍♀")
name = string.gsub(name,"🧝‍♂","🧝‍♀🧝‍♀🧝‍♀🧝‍♀🧝‍♀🧝‍♂🧝‍♀🧝‍♀🧝‍♀")
name = string.gsub(name,"🙍‍♂️","🙎‍♂️🙎‍♂️🙎‍♂️🙎‍♂️🙎‍♂️🙍‍♂️🙎‍♂️🙎‍♂️🙎‍♂️")
name = string.gsub(name,"🧖‍♂️","🧖‍♀️🧖‍♀️♀️🧖‍♀️🧖‍♀️🧖‍♂️🧖‍♀️🧖‍♀️🧖‍♀️🧖‍♀️")
name = string.gsub(name,"👬","👭👭👭👭👭👬👭👭👭")
name = string.gsub(name,"👨‍👨‍👧","👨‍👨‍👦👨‍👨‍👦👨‍👨‍👦👨‍👨‍👦👨‍👨‍👧👨‍👨‍👦??‍👨‍👦")
name = string.gsub(name,"??","🕒🕒🕒🕒🕒🕒🕓🕒🕒🕒")
name = string.gsub(name,"🕤","🕥🕥🕥🕥🕥🕤🕥🕥🕥")
name = string.gsub(name,"⌛️","⏳⏳⏳⏳⏳⏳⌛️⏳⏳")
name = string.gsub(name,"??","📆📆📆📆📆📆📅📆📆")
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ اسرع واحد يدز الاختلاف ~ ⟦ "..name.." ⟧","md",true)  
end
end
if text == "امثله" then
if Redis:get(MEZO.."MEZO:Status:Games"..msg.chat_id) then
mthal = {"جوز","ضراطه","الحبل","الحافي","شقره","بيدك","سلايه","النخله","الخيل","حداد","المبلل","يركص","قرد","العنب","العمه","الخبز","بالحصاد","شهر","شكه","يكحله",};
name = mthal[math.random(#mthal)]
Redis:set(MEZO.."MEZO:Game:Example"..msg.chat_id,name)
name = string.gsub(name,"جوز","ينطي____للماعده سنون")
name = string.gsub(name,"ضراطه","الي يسوق المطي يتحمل___")
name = string.gsub(name,"بيدك","اكل___محد يفيدك")
name = string.gsub(name,"الحافي","تجدي من___نعال")
name = string.gsub(name,"شقره","مع الخيل يا___")
name = string.gsub(name,"النخله","الطول طول___والعقل عقل الصخلة")
name = string.gsub(name,"سلايه","بالوجه امراية وبالظهر___")
name = string.gsub(name,"الخيل","من قلة___شدو على الچلاب سروج")
name = string.gsub(name,"حداد","موكل من صخم وجهه كال آني___")
name = string.gsub(name,"المبلل","___ما يخاف من المطر")
name = string.gsub(name,"الحبل","اللي تلدغة الحية يخاف من جرة___")
name = string.gsub(name,"يركص","المايعرف___يكول الكاع عوجه")
name = string.gsub(name,"العنب","المايلوح___يكول حامض")
name = string.gsub(name,"العمه","___إذا حبت الچنة ابليس يدخل الجنة")
name = string.gsub(name,"الخبز","انطي___للخباز حتى لو ياكل نصه")
name = string.gsub(name,"باحصاد","اسمة___ومنجله مكسور")
name = string.gsub(name,"شهر","امشي__ولا تعبر نهر")
name = string.gsub(name,"شكه","يامن تعب يامن__يا من على الحاضر لكة")
name = string.gsub(name,"القرد","__بعين امه غزال")
name = string.gsub(name,"يكحله","اجه___عماها")
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ اسرع واحد يكمل المثل ~ ⟦ "..name.." ⟧","md",true)  
end
end
if text and text:match("^بيع نقاطي (%d+)$") then
local NumGame = text:match("^بيع نقاطي (%d+)$") 
if tonumber(NumGame) == tonumber(0) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ❍┃ لا استطيع البيع اقل من 1 *","md",true)  
end
local NumberGame = Redis:get(MEZO.."MEZO:Num:Add:Games"..msg.chat_id..msg.sender.user_id)
if tonumber(NumberGame) == tonumber(0) then
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ ليس لديك جواهر من الالعاب \n ❍┃ اذا كنت تريد ربح الجواهر \n ❍┃ ارسل الالعاب وابدأ اللعب ! ","md",true)  
end
if tonumber(NumGame) > tonumber(NumberGame) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ ليس لديك جواهر بهاذا العدد \n ❍┃ لزيادة مجوهراتك في اللعبه \n ❍┃ ارسل الالعاب وابدأ اللعب !","md",true)   
end
local NumberGet = (NumGame * 50)
Redis:decrby(MEZO.."MEZO:Num:Add:Games"..msg.chat_id..msg.sender.user_id,NumGame)  
Redis:incrby(MEZO.."MEZO:Num:Message:User"..msg.chat_id..":"..msg.sender.user_id,NumGame)  
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم خصم *~ { "..NumGame.." }* من مجوهراتك \n ❍┃ وتم اضافة* ~ { "..(NumGame * 50).." } رساله الى رسالك *","md",true)  
end 
if text and text:match("^اضف مجوهرات (%d+)$") and msg.reply_to_message_id ~= 0 then
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local Jabwa = LuaTele.getUser(Message_Reply.sender.user_id)
if Jabwa.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if Jabwa and Jabwa.type and Jabwa.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام الامر على البوت ","md",true)  
end
Redis:incrby(MEZO.."MEZO:Num:Add:Games"..msg.chat_id..Message_Reply.sender.user_id, text:match("^اضف مجوهرات (%d+)$"))  
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ❍┃ تم اضافه له { "..text:match("^اضف مجوهرات (%d+)$").." } من المجوهرات").Reply,"md",true)  
end
if text and text:match("^اضف رسائل (%d+)$") and msg.reply_to_message_id ~= 0 then
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(7)..' ⟧* ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local Jabwa = LuaTele.getUser(Message_Reply.sender.user_id)
if Jabwa.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if Jabwa and Jabwa.type and Jabwa.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ❍┃ عذرا لا تستطيع استخدام الامر على البوت ","md",true)  
end
Redis:incrby(MEZO.."MEZO:Num:Message:User"..msg.chat_id..":"..Message_Reply.sender.user_id, text:match("^اضف رسائل (%d+)$"))  
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ❍┃ تم اضافه له { "..text:match("^اضف رسائل (%d+)$").." } من الرسائل").Reply,"md",true)  
end
if text == "نقاطي" then 
local Num = Redis:get(MEZO.."MEZO:Num:Add:Games"..msg.chat_id..msg.sender.user_id) or 0
if Num == 0 then 
return LuaTele.sendText(msg_chat_id,msg_id, " ❍┃ لم تفز بأي نقطه ","md",true)  
else
return LuaTele.sendText(msg_chat_id,msg_id, " ❍┃ عدد الجواهر التي ربحتها *⏎ "..Num.." *","md",true)  
end
end

if text == 'ترتيب الاوامر' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*◍ هاذا الامر يخص { '..Controller_Num(6)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/'..Redis:get(MEZO..'MEZO:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n◍ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Get:Reides:Commands:Group"..msg_chat_id..":"..'تعط','تعطيل الايدي بالصوره')
Redis:set(MEZO.."MEZO:Get:Reides:Commands:Group"..msg_chat_id..":"..'تفع','تفعيل الايدي بالصوره')
Redis:set(MEZO.."MEZO:Get:Reides:Commands:Group"..msg_chat_id..":"..'ا','ايدي')
Redis:set(MEZO.."MEZO:Get:Reides:Commands:Group"..msg_chat_id..":"..'م','رفع مميز')
Redis:set(MEZO.."MEZO:Get:Reides:Commands:Group"..msg_chat_id..":"..'اد', 'رفع ادمن')
Redis:set(MEZO.."MEZO:Get:Reides:Commands:Group"..msg_chat_id..":"..'مد','رفع مدير')
Redis:set(MEZO.."MEZO:Get:Reides:Commands:Group"..msg_chat_id..":"..'من', 'رفع منشئ')
Redis:set(MEZO.."MEZO:Get:Reides:Commands:Group"..msg_chat_id..":"..'اس', 'رفع منشئ اساسي')
Redis:set(MEZO.."MEZO:Get:Reides:Commands:Group"..msg_chat_id..":"..'مط','رفع مطور')
Redis:set(MEZO.."MEZO:Get:Reides:Commands:Group"..msg_chat_id..":"..'تك','تنزيل الكل')
Redis:set(MEZO.."MEZO:Get:Reides:Commands:Group"..msg_chat_id..":"..'ر','الرابط')
Redis:set(MEZO.."MEZO:Get:Reides:Commands:Group"..msg_chat_id..":"..'رر','ردود المدير')
Redis:set(MEZO.."MEZO:Get:Reides:Commands:Group"..msg_chat_id..":"..'،،','مسح المكتومين')
Redis:set(MEZO.."MEZO:Get:Reides:Commands:Group"..msg_chat_id..":"..'رد','اضف رد')
Redis:set(MEZO.."MEZO:Get:Reides:Commands:Group"..msg_chat_id..":"..'سح','مسح سحكاتي')
Redis:set(MEZO.."MEZO:Get:Reides:Commands:Group"..msg_chat_id..":"..'غ','غنيلي')
Redis:set(MEZO.."MEZO:Get:Reides:Commands:Group"..msg_chat_id..":"..'رس','رسائلي')
Redis:set(MEZO.."MEZO:Get:Reides:Commands:Group"..msg_chat_id..":"..'ثانوي','رفع مطور ثانوي')

return LuaTele.sendText(msg_chat_id,msg_id,[[*
◍ تم ترتيب الاوامر بالشكل التالي ~
◍  ايدي - ا .
◍  رفع مميز - م .
◍ رفع ادمن - اد .
◍  رفع مدير - مد . 
◍  رفع منشى - من . 
◍  رفع منشئ الاساسي - اس  .
◍  رفع مطور - مط .
◍ رفع مطور ثانوي - ثانوي .
◍  تنزيل الكل - تك .
◍  تعطيل الايدي بالصوره - تعط .
◍  تفعيل الايدي بالصوره - تفع .
◍  الرابط - ر .
◍  ردود المدير - رر .
◍  مسح المكتومين - ،، .
◍  اضف رد - رد .
◍  مسح سحكاتي - سح .
◍  مسح رسائلي - رس .
◍  غنيلي - غ .
*]],"md")
end

end -- GroupBot
if chat_type(msg.chat_id) == "UserBot" then 
if text == '♻️ تحديث الملفات ♻️' or text == 'تحديث الملفات' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
print('Chat Id : '..msg_chat_id)
print('User Id : '..msg_user_send_id)
LuaTele.sendText(msg_chat_id,msg_id, "* ❍┃ تم تحديث الملفات *","md",true)
dofile('MEZO.lua')  
end
if text == '/start' then
local photo = LuaTele.getUserProfilePhotos(MEZO)
local ban = LuaTele.getUser(MEZO)
local bain = LuaTele.getUser(msg.sender.user_id)
Redis:sadd(MEZO..'Num:User:Pv',msg.sender.user_id)  
if not msg.ControllerBot then
if not Redis:get(MEZO.."Start:Bot") then
if bain.username then
banusername = '[@'..bain.username..']'
else
banusername = 'لا يوجد'
end
if bain.first_name then
baniusername = '*['..bain.first_name..'](tg://user?id='..bain.id..')*'
else
baniusername = 'لا يوجد'
end
local CmdStart = '*\n🤖╖   أهلآ بك عزيزي أنا بوت'..(Redis:get(MEZO.."MEZO:Name:Bot") or "كرستين")..
'\n🌐╢ وظيفتي حماية المجموعات'..
'\n✅╢ لتفعيل البوت عليك اتباع مايلي.'..
'\n🔘╢ أضِف البوت إلى مجموعتك'..
'\n⚡️╢ ارفعهُ » مشرف + اكتب تفعيل'..
'\n⬆️╢ سيتم ترقيتك مالك في البوت'..
'\n💫╢ تأكد » من اعطائي حذف الرسائل'..
'\n✔╢ • لكي أعمل معك بشكل صحيح'.. 
'\nمـطـور الـبـوت 🔰{@'..UserSudo..'}*'
if photo.total_count > 0 then
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '•ᴍʏ ᴄʜᴀɴɴᴇʟ♪', url = 't.me/cristin_so'}, 
},
{
{text = '✈ • أضف البوت إلي مجموعتك • ✈', url = 't.me/'..UserBot..'?startgroup=new'}, 
},
}
local msgg = msg_id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id=" .. msg_chat_id .. "&photo="..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id.."&caption=".. URL.escape(CmdStart).."&reply_to_message_id="..msgg.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
LuaTele.sendText(Sudo_Id,0,'*\n𖥔 دخل شخص إلى البوت \n⩹━━━━𖥕MEZO𖥕━━━━⩺\n𖥔 اسمه :- '..baniusername..' \n𖥔 ايديه :-  : '..msg.sender.user_id..'\n𖥔 - معرفة '..banusername..' \n*',"md")
else
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '•ᴍʏ ᴄʜᴀɴɴᴇʟ♪', url = 't.me/cristin_so'}, 
},
{
{text = '✈ • أضف البوت إلي مجموعتك • ✈', url = 't.me/'..UserBot..'?startgroup=new'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,Redis:get(MEZO.."Start:Bot"),"md",false, false, false, false, reply_markup)
end
end
else
local reply_markup = LuaTele.replyMarkup{type = 'keyboard',resize = true,is_personal = true,
data = {
{
{text = '📍تفعيل التواصل📍',type = 'text'},{text = '📍تعطيل التواصل📍', type = 'text'},
},
{
{text = '🔓 تعيين الاشتراك 🔓',type = 'text'},{text = '🔒 حذف الاشتراك 🔒', type = 'text'},
},
{
{text = 'تفعيل البوت الخدمي ⚙',type = 'text'},{text = 'تعطيل البوت الخدمي ⚙', type = 'text'},
},
{
{text = '📣 اذاعه جروبات 📣',type = 'text'},{text = '📣 اذاعه خاص 📣', type = 'text'},
},
{
{text = '📣 اذاعه بالتوجيه 📣',type = 'text'},{text = '📣 اذاعه توجيه خاص 📣', type = 'text'},
},
{
{text = '📣 اذاعه بالتثبيت 📣',type = 'text'},
},
{
{text = '👮‍♂️الثانوين👮‍♂️',type = 'text'},{text = '👮‍♂️المطورين👮‍♂️',type = 'text'},{text = '🏴‍☠️ قائمه العام 🏴‍☠️', type = 'text'},
},
{
{text = 'مسح مطورين 🚨',type = 'text'},{text = 'مسح العام 🚨',type = 'text'},{text = 'مسح ثانويين 🚨', type = 'text'},
},
{
{text = '🤖تغيير اسم البوت🤖',type = 'text'},{text = '🗑حذف اسم البوت🗑', type = 'text'},
},
{
{text = '📊 الاحصائيات 📊',type = 'text'},{text = '🔎 جلب التوكن 🔍', type = 'text'},
},
{
{text = '📢 تعطيل الاذاعه 📢',type = 'text'},{text = '📢 تفعيل الاذاعه 📢',type = 'text'},
},
{
{text = '✈ تعطيل المغادره ✈',type = 'text'},{text = '✈ تفعيل المغادره ✈',type = 'text'},
},
{
{text = '🔄 تغيير المطور الاساسي 🔄',type = 'text'} 
},
{
{text = 'تغير كليشه المطور 🚷',type = 'text'},{text = 'حذف كليشه المطور 🚷', type = 'text'},
},
{
{text = 'تغيير كليشه ستارت 🚫',type = 'text'},{text = 'حذف كليشه ستارت 🚫', type = 'text'},
},
{
{text = '🗑تنظيف المجموعات🗑',type = 'text'},{text = '🗑تنظيف المشتركين🗑', type = 'text'},
},
{
{text = '📉 جلب النسخه العامه 📈',type = 'text'},
},
{
{text = '🌐 اضف رد عام 🌐',type = 'text'},{text = '🌐 حذف رد عام 🌐', type = 'text'},
},
{
{text = '💫 الردود العامه 💫',type = 'text'},{text = '💫 مسح الردود العامه 💫', type = 'text'},
},
{
{text = '♻️ تحديث الملفات ♻️',type = 'text'},{text = '♻️ تحديث السورس ♻️', type = 'text'},
},
{
{text = '❌ •《الغاء الامر》• ❌',type = 'text'},
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'* ❍┃ اهلا بك عزيزي المطور الاساسي *', 'md', false, false, false, false, reply_markup)
end
end

if text == '🗑تنظيف المشتركين🗑' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(MEZO.."MEZO:Num:User:Pv")   
local x = 0
for k,v in pairs(list) do  
local Get_Chat = LuaTele.getChat(v)
local ChatAction = LuaTele.sendChatAction(v,'Typing')
if ChatAction.luatele ~= "ok" then
x = x + 1
Redis:srem(MEZO..'MEZO:Num:User:Pv',v)
end
end
if x ~= 0 then
return LuaTele.sendText(msg_chat_id,msg_id,'* ❍┃ العدد الكلي { '..#list..' }\n ❍┃ تم العثور على { '..x..' } من المشتركين حاظرين البوت*',"md")
else
return LuaTele.sendText(msg_chat_id,msg_id,'* ❍┃ العدد الكلي { '..#list..' }\n ❍┃ لم يتم العثور على وهميين*',"md")
end
end
if text == '🗑تنظيف المجموعات🗑' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(MEZO.."MEZO:ChekBotAdd")   
local x = 0
for k,v in pairs(list) do  
local Get_Chat = LuaTele.getChat(v)
if Get_Chat.id then
local statusMem = LuaTele.getChatMember(Get_Chat.id,MEZO)
if statusMem.status.luatele == "chatMemberStatusMember" then
x = x + 1
LuaTele.sendText(Get_Chat.id,0,'* ❍┃ البوت عظو في المجموعه سوف اغادر ويمكنك تفعيلي مره اخره *',"md")
Redis:srem(MEZO..'MEZO:ChekBotAdd',Get_Chat.id)
local keys = Redis:keys(MEZO..'*'..Get_Chat.id)
for i = 1, #keys do
Redis:del(keys[i])
end
LuaTele.leaveChat(Get_Chat.id)
end
else
x = x + 1
local keys = Redis:keys(MEZO..'*'..v)
for i = 1, #keys do
Redis:del(keys[i])
end
Redis:srem(MEZO..'MEZO:ChekBotAdd',v)
LuaTele.leaveChat(v)
end
end
if x ~= 0 then
return LuaTele.sendText(msg_chat_id,msg_id,'* ❍┃ العدد الكلي { '..#list..' } للمجموعات \n ❍┃ تم العثور على { '..x..' } مجموعات البوت ليس ادمن \n ❍┃ تم تعطيل المجموعه ومغادره البوت من الوهمي *',"md")
else
return LuaTele.sendText(msg_chat_id,msg_id,'* ❍┃ العدد الكلي { '..#list..' } للمجموعات \n ❍┃ لا توجد مجموعات وهميه*',"md")
end
end
if text == 'تغيير كليشه ستارت 🚫' then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(MEZO.."MEZO:Change:Start:Bot"..msg.sender.user_id,300,true) 
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ ارسل لي كليشه Start الان ","md",true)  
end
if text == 'حذف كليشه ستارت 🚫' then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(MEZO.."MEZO:Start:Bot") 
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم حذف كليشه Start ","md",true)   
end
if text == '🤖تغيير اسم البوت🤖' then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(MEZO.."MEZO:Change:MEZO:Name:Bot"..msg.sender.user_id,300,true) 
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ ارسل لي الاسم الان ","md",true)  
end
if text == '🗑حذف اسم البوت🗑' then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(MEZO.."MEZO:Name:Bot") 
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم حذف اسم البوت ","md",true)   
end
if text and text:match("^تعين عدد الاعضاء (%d+)$") then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO..'MEZO:Num:Add:Bot',text:match("تعين عدد الاعضاء (%d+)$") ) 
LuaTele.sendText(msg_chat_id,msg_id,'* ❍┃ تم تعيين عدد اعضاء تفعيل البوت اكثر من : '..text:match("تعين عدد الاعضاء (%d+)$")..' عضو *',"md",true)  
elseif text == 'تغير كليشه المطور 🚷' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO..'MEZO:GetTexting:DevMEZO'..msg_chat_id..':'..msg.sender.user_id,true)
return LuaTele.sendText(msg_chat_id,msg_id,' ❍┃ ارسل لي الكليشه الان')
end
if text == 'حذف كليشه المطور 🚷' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(MEZO..'MEZO:Texting:DevMEZO')
return LuaTele.sendText(msg_chat_id,msg_id,' ❍┃ تم حذف كليشه المطور')
end
if text == '🌐 اضف رد عام 🌐' then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Set:Rd"..msg.sender.user_id..":"..msg_chat_id,true)
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ ارسل الان الكلمه لاضافتها في الردود العامه ","md",true)  
end
if text == '🌐 حذف رد عام 🌐' then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:Set:On"..msg.sender.user_id..":"..msg_chat_id,true)
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ ارسل الان الكلمه لحذفها من الردود العامه","md",true)  
end
if text=='📣 اذاعه خاص 📣' then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص⟦ '..Controller_Num(2)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(MEZO.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(MEZO.."Broadcasting:Users" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
LuaTele.sendText(msg_chat_id,msg_id,[[*
 ❍┃ ارسل اذاعتك لنشرها في أعضاء خاص البوت 
 ❍┃ للخروج من الامر ارسل⟦الغاء⟧
*]],"md",true)  
return false
end

if text=='📣 اذاعه جروبات 📣' then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص⟦ '..Controller_Num(2)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(MEZO.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(MEZO.."Broadcasting:Groups" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
LuaTele.sendText(msg_chat_id,msg_id,[[*
 ❍┃ ارسل اذاعتك لنشرها في الجروبات
 ❍┃ للخروج من الامر ارسل⟦الغاء⟧
*]],"md",true)  
return false
end

if text=="📣 اذاعه بالتثبيت 📣" then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص⟦ '..Controller_Num(2)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(MEZO.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(MEZO.."Bc:Grops:Pin" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
LuaTele.sendText(msg_chat_id,msg_id,[[*
 ❍┃ ارسل اذاعتك لتثبيت في الجروبات
 ❍┃ للخروج من الامر ارسل⟦الغاء⟧
*]],"md",true)  
return false
end

if text=="📣 اذاعه بالتوجيه 📣" then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص⟦ '..Controller_Num(2)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(MEZO.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(MEZO.."Broadcasting:Groups:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ ارسل لي التوجيه الان*\n* ❍┃ ليتم نشره في المجموعات*\n* ❍┃ للخروج من الامر ارسل⟦الغاء⟧*","md",true)  
return false
end

if text=='📣 اذاعه توجيه خاص 📣' then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص⟦ '..Controller_Num(2)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(MEZO.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(MEZO.."Broadcasting:Users:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ ارسل لي التوجيه الان*\n* ❍┃ ليتم نشره الى اضاء خاص البوت*\n* ❍┃ للخروج من الامر ارسل⟦الغاء⟧*","md",true)  
return false
end

if text == ("💫 الردود العامه 💫") then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(MEZO.."MEZO:List:Rd:Sudo")
text = "\nقائمة الردود العامه ⇧⇩ \n— — — — — — — — —\n"
for k,v in pairs(list) do
if Redis:get(MEZO.."MEZO:Add:Rd:Sudo:Gif"..v) then
db = "متحركه"
elseif Redis:get(MEZO.."MEZO:Add:Rd:Sudo:vico"..v) then
db = "رساله صوتيه "
elseif Redis:get(MEZO.."MEZO:Add:Rd:Sudo:stekr"..v) then
db = "ملصق"
elseif Redis:get(MEZO.."MEZO:Add:Rd:Sudo:Text"..v) then
db = "رساله"
elseif Redis:get(MEZO.."MEZO:Add:Rd:Sudo:Photo"..v) then
db = "صوره"
elseif Redis:get(MEZO.."MEZO:Add:Rd:Sudo:Video"..v) then
db = "فيديو"
elseif Redis:get(MEZO.."MEZO:Add:Rd:Sudo:File"..v) then
db = "ملف"
elseif Redis:get(MEZO.."MEZO:Add:Rd:Sudo:Audio"..v) then
db = "اغنيه"
elseif Redis:get(MEZO.."MEZO:Add:Rd:Sudo:video_note"..v) then
db = "رسالة فيديو"
end
text = text..""..k.." -›⟦ "..v.." ⟧-›⟦ "..db.." ⟧\n"
end
if #list == 0 then
text = " ❍┃ لا توجد ردود عامه"
end
return LuaTele.sendText(msg_chat_id,msg_id,"["..text.."]","md",true)  
end
if text == ("💫 مسح الردود العامه 💫") then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(MEZO.."MEZO:List:Rd:Sudo")
for k,v in pairs(list) do
Redis:del(MEZO.."MEZO:Add:Rd:Sudo:Gif"..v)   
Redis:del(MEZO.."MEZO:Add:Rd:Sudo:vico"..v)   
Redis:del(MEZO.."MEZO:Add:Rd:Sudo:stekr"..v)     
Redis:del(MEZO.."MEZO:Add:Rd:Sudo:Text"..v)   
Redis:del(MEZO.."MEZO:Add:Rd:Sudo:Photo"..v)
Redis:del(MEZO.."MEZO:Add:Rd:Sudo:Video"..v)
Redis:del(MEZO.."MEZO:Add:Rd:Sudo:File"..v)
Redis:del(MEZO.."MEZO:Add:Rd:Sudo:Audio"..v)
Redis:del(MEZO.."MEZO:Add:Rd:Sudo:video_note"..v)
Redis:del(MEZO.."MEZO:List:Rd:Sudo")
end
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم حذف الردود العامه *","md",true)  
end
if text == 'مسح مطورين 🚨' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(MEZO.."MEZO:Developers:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ لا يوجد مطورين في البوت ","md",true)  
end
Redis:del(MEZO.."MEZO:Developers:Groups") 
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم مسح ⟦ "..#Info_Members.." ⟧ من المطورين *","md",true)
end
if text == 'مسح ثانويين 🚨' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(MEZO.."MEZO:DevelopersQ:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ لا يوجد مطورين في البوت ","md",true)  
end
Redis:del(MEZO.."MEZO:DevelopersQ:Groups") 
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم مسح ⟦ "..#Info_Members.." ⟧ من المطورين *","md",true)
end
if text == 'مسح العام 🚨' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(MEZO.."MEZO:JabwaAll:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ لا يوجد محظورين عام في البوت ","md",true)  
end
Redis:del(MEZO.."MEZO:JabwaAll:Groups") 
return LuaTele.sendText(msg_chat_id,msg_id,"* ❍┃ تم مسح ⟦ "..#Info_Members.." ⟧ من المحظورين عام *","md",true)
end
if text == 'تعطيل البوت الخدمي ⚙' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(MEZO.."MEZO:BotFree") 
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم تعطيل البوت الخدمي ","md",true)
end
if text == '📍تعطيل التواصل📍' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(MEZO.."MEZO:TwaslBot") 
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم تعطيل التواصل داخل البوت ","md",true)
end
if text == 'تفعيل البوت الخدمي ⚙' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:BotFree",true) 
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم تفعيل البوت الخدمي ","md",true)
end
if text == '🔓 تعيين الاشتراك 🔓' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
Redis:set(MEZO.."ch:addd"..msg.sender.user_id,"on")
LuaTele.sendText(msg_chat_id,msg_id,' ❍┃ ارسل الان معرف القناه ',"md",true)  
end
if text == '🔒 حذف الاشتراك 🔒' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
Redis:del(MEZO.."ch:admin")
Redis:del(MEZO.."chfalse")
LuaTele.sendText(msg_chat_id,msg_id,' ❍┃ تم حذف القناه ',"md",true)  
end
if text == '📍تفعيل التواصل📍' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(MEZO.."MEZO:TwaslBot",true) 
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ تم تفعيل التواصل داخل البوت ","md",true)
end
if text == '🏴‍☠️ قائمه العام 🏴‍☠️' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(MEZO.."MEZO:JabwaAll:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ لا يوجد محظورين عام في البوت ","md",true)  
end
ListMembers = '\n* ❍┃ قائمه المحظورين عام  \n— — — — — — — — —*\n'
for k, v in pairs(Info_Members) do
local Jabwa = LuaTele.getUser(v)
var(v)
if Jabwa and Jabwa.username and Jabwa.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..Jabwa.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '❍ مسح المحظورين عام ❍', data = msg.sender.user_id..'/JabwaAll'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == '👮‍♂️المطورين👮‍♂️' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(MEZO.."MEZO:Developers:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ لا يوجد مطورين في البوت ","md",true)  
end
ListMembers = '\n* ❍┃ قائمه مطورين البوت \n— — — — — — — — —*\n'
for k, v in pairs(Info_Members) do
local Jabwa = LuaTele.getUser(v)
if Jabwa and Jabwa.username and Jabwa.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..Jabwa.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '❍ مسح المطورين ❍', data = msg.sender.user_id..'/Developers'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == '👮‍♂️الثانوين👮‍♂️' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ❍┃ هاذا الامر يخص ⟦ '..Controller_Num(1)..' ⟧* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cristin_so'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ❍┃ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(MEZO.."MEZO:DevelopersQ:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id," ❍┃ لا يوجد مطورين في البوت ","md",true)  
end
ListMembers = '\n* ❍┃ قائمه مطورين البوت \n— — — — — — — — —*\n'
for k, v in pairs(Info_Members) do
local Jabwa = LuaTele.getUser(v)
if Jabwa and Jabwa.username and Jabwa.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..Jabwa.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '❍ مسح الثانوين ❍', data = msg.sender.user_id..'/Developers'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if not msg.ControllerBot then
if Redis:get(MEZO.."MEZO:TwaslBot") and not Redis:sismember(MEZO.."MEZO:Jabwa:In:Tuasl",msg.sender.user_id) then
local ListGet = {Sudo_Id,msg.sender.user_id}
local IdSudo = LuaTele.getChat(ListGet[1]).id
local IdUser = LuaTele.getChat(ListGet[2]).id
local FedMsg = LuaTele.sendForwarded(IdSudo, 0, IdUser, msg_id)
Redis:setex(MEZO.."MEZO:Twasl:UserId"..msg.date,172800,IdUser)
if FedMsg.content.luatele == "messageSticker" then
LuaTele.sendText(IdSudo,0,Reply_Status(IdUser,' ❍┃ قام بارسال الملصق').Reply,"md",true)  
end
return LuaTele.sendText(IdUser,msg_id,Reply_Status(IdUser,' ❍┃ تم ارسال رسالتك الى المطور').Reply,"md",true)  
end
else 
if msg.reply_to_message_id ~= 0 then
local Message_Get = LuaTele.getMessage(msg_chat_id, msg.reply_to_message_id)
if Message_Get.forward_info then
local Info_User = Redis:get(MEZO.."MEZO:Twasl:UserId"..Message_Get.forward_info.date) or 46899864
if text == 'حظر' then
Redis:sadd(MEZO..'MEZO:Jabwa:In:Tuasl',Info_User)  
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Info_User,' ❍┃ تم حظره من تواصل البوت ').Reply,"md",true)  
end 
if text =='الغاء الحظر' or text =='الغاء حظر' then
Redis:srem(MEZO..'MEZO:Jabwa:In:Tuasl',Info_User)  
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Info_User,' ❍┃ تم الغاء حظره من تواصل البوت ').Reply,"md",true)  
end 
local ChatAction = LuaTele.sendChatAction(Info_User,'Typing')
if not Info_User or ChatAction.message == "USER_IS_BLOCKED" then
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Info_User,' ❍┃ قام بحظر البوت لا استطيع ارسال رسالتك ').Reply,"md",true)  
end
if msg.content.video_note then
LuaTele.sendVideoNote(Info_User, 0, msg.content.video_note.video.remote.id)
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
LuaTele.sendPhoto(Info_User, 0, idPhoto,'')
elseif msg.content.sticker then 
LuaTele.sendSticker(Info_User, 0, msg.content.sticker.sticker.remote.id)
elseif msg.content.voice_note then 
LuaTele.sendVoiceNote(Info_User, 0, msg.content.voice_note.voice.remote.id, '', 'md')
elseif msg.content.video then 
LuaTele.sendVideo(Info_User, 0, msg.content.video.video.remote.id, '', "md")
elseif msg.content.animation then 
LuaTele.sendAnimation(Info_User,0, msg.content.animation.animation.remote.id, '', 'md')
elseif msg.content.document then
LuaTele.sendDocument(Info_User, 0, msg.content.document.document.remote.id, '', 'md')
elseif msg.content.audio then
LuaTele.sendAudio(Info_User, 0, msg.content.audio.audio.remote.id, '', "md") 
elseif text then
LuaTele.sendText(Info_User,0,text,"md",true)
end 
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Info_User,' ❍┃ تم ارسال رسالتك اليه ').Reply,"md",true)  
end
end
end 
end --UserBot
end -- File_Bot_Run


function CallBackLua(data) --- هذا الكالباك بي الابديت
--var(data)
if data and data.luatele and data.luatele == "updateSupergroup" then
local Get_Chat = LuaTele.getChat('-100'..data.supergroup.id)
if data.supergroup.status.luatele == "chatMemberStatusJabwaned" then
Redis:srem(MEZO.."MEZO:ChekBotAdd",'-100'..data.supergroup.id)
local keys = Redis:keys(MEZO..'*'..'-100'..data.supergroup.id..'*')
Redis:del(MEZO.."MEZO:List:Manager"..'-100'..data.supergroup.id)
Redis:del(MEZO.."MEZO:Command:List:Group"..'-100'..data.supergroup.id)
for i = 1, #keys do 
Redis:del(keys[i])
end
return LuaTele.sendText(Sudo_Id,0,'*\n ❍┃ تم طرد البوت من مجموعه جديده \n ❍┃ اسم المجموعه : '..Get_Chat.title..'\n ❍┃ ايدي المجموعه :*`-100'..data.supergroup.id..'`\n ❍┃ تم مسح جميع البيانات المتعلقه بالمجموعه',"md")
end
elseif data and data.luatele and data.luatele == "updateMessageSendSucceeded" then
local msg = data.message
local Chat = msg.chat_id
if msg.content.text then
text = msg.content.text.text
end
if msg.content.video_note then
if msg.content.video_note.video.remote.id == Redis:get(MEZO.."MEZO:PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
Redis:del(MEZO.."MEZO:PinMsegees:"..msg.chat_id)
end
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
if idPhoto == Redis:get(MEZO.."MEZO:PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
Redis:del(MEZO.."MEZO:PinMsegees:"..msg.chat_id)
end
elseif msg.content.sticker then 
if msg.content.sticker.sticker.remote.id == Redis:get(MEZO.."MEZO:PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
Redis:del(MEZO.."MEZO:PinMsegees:"..msg.chat_id)
end
elseif msg.content.voice_note then 
if msg.content.voice_note.voice.remote.id == Redis:get(MEZO.."MEZO:PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
Redis:del(MEZO.."MEZO:PinMsegees:"..msg.chat_id)
end
elseif msg.content.video then 
if msg.content.video.video.remote.id == Redis:get(MEZO.."MEZO:PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
Redis:del(MEZO.."MEZO:PinMsegees:"..msg.chat_id)
end
elseif msg.content.animation then 
if msg.content.animation.animation.remote.id ==  Redis:get(MEZO.."MEZO:PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
Redis:del(MEZO.."MEZO:PinMsegees:"..msg.chat_id)
end
elseif msg.content.document then
if msg.content.document.document.remote.id == Redis:get(MEZO.."MEZO:PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
Redis:del(MEZO.."MEZO:PinMsegees:"..msg.chat_id)
end
elseif msg.content.audio then
if msg.content.audio.audio.remote.id == Redis:get(MEZO.."MEZO:PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
Redis:del(MEZO.."MEZO:PinMsegees:"..msg.chat_id)
end
elseif text then
if text == Redis:get(MEZO.."MEZO:PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
Redis:del(MEZO.."MEZO:PinMsegees:"..msg.chat_id)
end
end
elseif data and data.luatele and data.luatele == "updateNewMessage" then
if data.message.content.luatele == "messageChatDeleteMember" or data.message.content.luatele == "messageChatAddMembers" or data.message.content.luatele == "messagePinMessage" or data.message.content.luatele == "messageChatChangeTitle" or data.message.content.luatele == "messageChatJoinByLink" then
if Redis:get(MEZO.."MEZO:Lock:tagservr"..data.message.chat_id) then
LuaTele.deleteMessages(data.message.chat_id,{[1]= data.message.id})
end
end 
if tonumber(data.message.sender.user_id) == tonumber(MEZO) then
return false
end
if data.message.content.luatele == "messageChatJoinByLink" and Redis:get(MEZO..'MEZO:Status:joinet'..data.message.chat_id) == 'true' then
    local reply_markup = LuaTele.replyMarkup{
    type = 'inline',
    data = {
    {
    {text = '⟦ انا لست بوت ⟧', data = data.message.sender.user_id..'/UnKed'},
    },
    }
    } 
    LuaTele.setChatMemberStatus(data.message.chat_id,data.message.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
    return LuaTele.sendText(data.message.chat_id, data.message.id, ' ❍┃ عليك اختيار انا لست بوت لتخطي نضام التحقق', 'md',false, false, false, false, reply_markup)
    end
File_Bot_Run(data.message,data.message)
elseif data and data.luatele and data.luatele == "updateMessageEdited" then
-- data.chat_id -- data.message_id
local Message_Edit = LuaTele.getMessage(data.chat_id, data.message_id)
if Message_Edit.sender.user_id == MEZO then
print('This is Edit for Bot')
return false
end
File_Bot_Run(Message_Edit,Message_Edit)
Redis:incr(MEZO..'MEZO:Num:Message:Edit'..data.chat_id..Message_Edit.sender.user_id)
if Message_Edit.content.luatele == "messageContact" or Message_Edit.content.luatele == "messageVideoNote" or Message_Edit.content.luatele == "messageDocument" or Message_Edit.content.luatele == "messageAudio" or Message_Edit.content.luatele == "messageVideo" or Message_Edit.content.luatele == "messageVoiceNote" or Message_Edit.content.luatele == "messageAnimation" or Message_Edit.content.luatele == "messagePhoto" then
if Redis:get(MEZO.."MEZO:Lock:edit"..data.chat_id) then
LuaTele.deleteMessages(data.chat_id,{[1]= data.message_id})
end
end
elseif data and data.luatele and data.luatele == "updateNewCallbackQuery" then
-- data.chat_id
-- data.payload.data
-- data.sender_user_id
Text = LuaTele.base64_decode(data.payload.data)
IdUser = data.sender_user_id
ChatId = data.chat_id
Msg_id = data.message_id
if Text and Text:match('(%d+)/UnKed') then
    local UserId = Text:match('(%d+)/UnKed')
    if tonumber(UserId) ~= tonumber(IdUser) then
    return LuaTele.answerCallbackQuery(data.id, " ❍┃ الامر لا يخصك", true)
    end
    LuaTele.setChatMemberStatus(ChatId,UserId,'restricted',{1,1,1,1,1,1,1,1})
    return LuaTele.editMessageText(ChatId,Msg_id," ❍┃ تم التحقق منك اجابتك صحيحه يمكنك الدردشه الان", 'md', false)
    end
if Text and Text:match('(%d+)/delamrredis') then
local listYt = Text:match('(%d+)/delamrredis')
if tonumber(listYt) == tonumber(IdUser) then
Redis:del(MEZO.."MEZO:Redis:Id:Group"..ChatId..""..IdUser) 
Redis:del(MEZO.."MEZO1:Set:Rd"..IdUser..":"..ChatId)
Redis:del(MEZO.."MEZO:Set:Manager:rd"..IdUser..":"..ChatId)
Redis:del(MEZO.."MEZO:Set:Rd"..IdUser..":"..ChatId)
LuaTele.editMessageText(ChatId,Msg_id," ❍┃  تم الغاء الامر", 'md')
end
end   
if Text and Text:match('(%d+)/chengreplygg') then
local listYt = Text:match('(%d+)/chengreplygg')
if tonumber(listYt) == tonumber(IdUser) then
Redis:set(MEZO.."MEZO1:Set:Rd"..IdUser..":"..ChatId, "true")
LuaTele.editMessageText(ChatId,Msg_id," ❍┃  ارسل لي الرد الان", 'md', true)
end
end
if Text and Text:match('(%d+)/chengreplyg') then
local listYt = Text:match('(%d+)/chengreplyg')
if tonumber(listYt) == tonumber(IdUser) then
Redis:set(MEZO.."MEZO:Set:Manager:rd"..IdUser..":"..ChatId,"true")
LuaTele.editMessageText(ChatId,Msg_id," ❍┃  ارسل لي الرد الان", 'md', true)
end
end
if Text and Text:match('(%d+)/chengreplys') then
local listYt = Text:match('(%d+)/chengreplys')
if tonumber(listYt) == tonumber(IdUser) then
Redis:set(MEZO.."MEZO:Set:Rd"..IdUser..":"..ChatId,true)
LuaTele.editMessageText(ChatId,Msg_id," ❍┃  ارسل لي الرد الان", 'md', true)
end
end

if Text and Text:match('(%d+)/ban0') then
local UserId = Text:match('(%d+)/ban0')
if tonumber(IdUser) == tonumber(UserId) then
local photo = LuaTele.getUserProfilePhotos(IdUser)
local ban = LuaTele.getUser(IdUser)
if photo.total_count > 0 then
local ban_ns = '🔎•●•●•●•●صورك●•●•●•●•🔍'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '- اخفاء الامر ', callback_data =IdUser..'/delAmr'}, 
},
{
{text = '📈 • صورتك القادمه • 📉', callback_data =IdUser..'/ban1'},{text = '📈 • صورتك السابقه • 📉 ', callback_data =IdUser..'/delAmr'}, 
},
}
LuaTele.deleteMessages(ChatId,{[1]= Msg_id})
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id=" .. ChatId .. "&photo="..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id.."&caption=".. URL.escape(ban_ns).."&reply_to_message_id=0&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
return LuaTele.sendText(ChatId,Msg_id,'*𖥔 لا توجد صوره ف حسابك*',"md",true) 
end
end
end
if Text and Text:match('(%d+)/ban89') then
local UserId = Text:match('(%d+)/ban89')
if tonumber(IdUser) == tonumber(UserId) then
local photo = LuaTele.getUserProfilePhotos(IdUser)
local ban_ns = '🔎•●•●•●•●صورك●•●•●•●•🔍'
if photo.total_count > 1 then
GH = '* '..photo.photos[2].sizes[#photo.photos[1].sizes].photo.remote.id..'* '
ban = JSON.encode(GH)
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '- اخفاء الامر ', callback_data =IdUser..'/delAmr'}, 
},
}
https.request("https://api.telegram.org/bot"..Token.."/editMessageMedia?chat_id="..ChatId.."&reply_to_message_id=0&media="..ban.."&caption=".. URL.escape(ban_ns).."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
return LuaTele.sendText(ChatId,Msg_id,'*𖥔 لا توجد صوره ف حسابك*',"md",true) 
end
end
end
if Text and Text:match('(%d+)/ban1') then
local UserId = Text:match('(%d+)/ban1')
if tonumber(IdUser) == tonumber(UserId) then
local photo = LuaTele.getUserProfilePhotos(IdUser)
local ban = LuaTele.getUser(IdUser)
if photo.total_count > 1 then
local ban_ns = '🔎•●•●•●•●صورك●•●•●•●•🔍'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '- اخفاء الامر ', callback_data =IdUser..'/delAmr'}, 
},
{
{text = '📈 • صورتك القادمه • 📉', callback_data =IdUser..'/ban2'},{text = '📈 • صورتك السابقه • 📉 ', callback_data =IdUser..'/ban0'}, 
},
}
LuaTele.deleteMessages(ChatId,{[1]= Msg_id})
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id=" .. ChatId .. "&photo="..photo.photos[2].sizes[#photo.photos[1].sizes].photo.remote.id.."&caption=".. URL.escape(ban_ns).."&reply_to_message_id=0&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
return LuaTele.sendText(ChatId,Msg_id,'*𖥔 لا توجد صوره ف حسابك*',"md",true) 
end
end
end
if Text and Text:match('(%d+)/ban2') then
local UserId = Text:match('(%d+)/ban2')
if tonumber(IdUser) == tonumber(UserId) then
local photo = LuaTele.getUserProfilePhotos(IdUser)
local ban = LuaTele.getUser(IdUser)
if photo.total_count > 1 then
local ban_ns = '🔎•●•●•●•●صورك●•●•●•●•🔍'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '- اخفاء الامر ', callback_data =IdUser..'/delAmr'}, 
},
{
{text = '📈 • صورتك القادمه • 📉', callback_data =IdUser..'/ban3'},{text = '📈 • صورتك السابقه • 📉 ', callback_data =IdUser..'/ban1'}, 
},
}
LuaTele.deleteMessages(ChatId,{[1]= Msg_id})
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id=" .. ChatId .. "&photo="..photo.photos[3].sizes[#photo.photos[1].sizes].photo.remote.id.."&caption=".. URL.escape(ban_ns).."&reply_to_message_id=0&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
return LuaTele.sendText(ChatId,Msg_id,'*𖥔 لا توجد صوره ف حسابك*',"md",true) 
end
end
end
if Text and Text:match('(%d+)/ban3') then
local UserId = Text:match('(%d+)/ban3')
if tonumber(IdUser) == tonumber(UserId) then
local photo = LuaTele.getUserProfilePhotos(IdUser)
local ban = LuaTele.getUser(IdUser)
if photo.total_count > 1 then
local ban_ns = '🔎•●•●•●•●صورك●•●•●•●•🔍'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '- اخفاء الامر ', callback_data =IdUser..'/delAmr'}, 
},
{
{text = '📈 • صورتك القادمه • 📉', callback_data =IdUser..'/ban4'},{text = '📈 • صورتك السابقه • 📉 ', callback_data =IdUser..'/ban2'}, 
},
}
LuaTele.deleteMessages(ChatId,{[1]= Msg_id})
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id=" .. ChatId .. "&photo="..photo.photos[4].sizes[#photo.photos[1].sizes].photo.remote.id.."&caption=".. URL.escape(ban_ns).."&reply_to_message_id=0&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
return LuaTele.sendText(ChatId,Msg_id,'*𖥔 لا توجد صوره ف حسابك*',"md",true) 
end
end
end
if Text and Text:match('(%d+)/ban4') then
local UserId = Text:match('(%d+)/ban4')
if tonumber(IdUser) == tonumber(UserId) then
local photo = LuaTele.getUserProfilePhotos(IdUser)
local ban = LuaTele.getUser(IdUser)
if photo.total_count > 1 then
local ban_ns = '🔎•●•●•●•●صورك●•●•●•●•🔍'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '- اخفاء الامر ', callback_data =IdUser..'/delAmr'}, 
},
{
{text = '📈 • صورتك القادمه • 📉', callback_data =IdUser..'/ban5'},{text = '📈 • صورتك السابقه • 📉 ', callback_data =IdUser..'/ban3'}, 
},
}
LuaTele.deleteMessages(ChatId,{[1]= Msg_id})
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id=" .. ChatId .. "&photo="..photo.photos[5].sizes[#photo.photos[1].sizes].photo.remote.id.."&caption=".. URL.escape(ban_ns).."&reply_to_message_id=0&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
return LuaTele.sendText(ChatId,Msg_id,'*𖥔 لا توجد صوره ف حسابك*',"md",true) 
end
end
end
if Text and Text:match('(%d+)/ban5') then
local UserId = Text:match('(%d+)/ban5')
if tonumber(IdUser) == tonumber(UserId) then
local photo = LuaTele.getUserProfilePhotos(IdUser)
local ban = LuaTele.getUser(IdUser)
if photo.total_count > 1 then
local ban_ns = '𝚑𝚎??𝚎 𝚊𝚛𝚎 𝚢𝚘𝚞𝚛 𝚙𝚑𝚘𝚝𝚘𝚜'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '- اخفاء الامر ', callback_data =IdUser..'/delAmr'}, 
},
{
{text = '📈 • صورتك القادمه • 📉', callback_data =IdUser..'/ban6'},{text = '📈 • صورتك السابقه • 📉 ', callback_data =IdUser..'/ban4'}, 
},
}
LuaTele.deleteMessages(ChatId,{[1]= Msg_id})
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id=" .. ChatId .. "&photo="..photo.photos[6].sizes[#photo.photos[1].sizes].photo.remote.id.."&caption=".. URL.escape(ban_ns).."&reply_to_message_id=0&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
return LuaTele.sendText(ChatId,Msg_id,'*𖥔 لا توجد صوره ف حسابك*',"md",true) 
end
end
end
if Text and Text:match('(%d+)/ban6') then
local UserId = Text:match('(%d+)/ban6')
if tonumber(IdUser) == tonumber(UserId) then
local photo = LuaTele.getUserProfilePhotos(IdUser)
local ban = LuaTele.getUser(IdUser)
if photo.total_count > 1 then
local ban_ns = '🔎•●•●•●•●صورك●•●•●•●•🔍'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '- اخفاء الامر ', callback_data =IdUser..'/delAmr'}, 
},
{
{text = '📈 • صورتك القادمه • 📉', callback_data =IdUser..'/ban7'},{text = '📈 • صورتك السابقه • 📉 ', callback_data =IdUser..'/ban5'}, 
},
}
LuaTele.deleteMessages(ChatId,{[1]= Msg_id})
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id=" .. ChatId .. "&photo="..photo.photos[7].sizes[#photo.photos[1].sizes].photo.remote.id.."&caption=".. URL.escape(ban_ns).."&reply_to_message_id=0&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
return LuaTele.sendText(ChatId,Msg_id,'*𖥔 لا توجد صوره ف حسابك*',"md",true) 
end
end
end

if Text and Text:match('(%d+)/ban7') then
local UserId = Text:match('(%d+)/ban7')
if tonumber(IdUser) == tonumber(UserId) then
local photo = LuaTele.getUserProfilePhotos(IdUser)
local ban = LuaTele.getUser(IdUser)
if photo.total_count > 1 then
local ban_ns = '🔎•●•●•●•●صورك●•●•●•●•🔍'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '- اخفاء الامر ', callback_data =IdUser..'/delAmr'}, 
},
{
{text = '📈 • صورتك السابقه • 📉 ', callback_data =IdUser..'/ban0'}, 
},
}
LuaTele.deleteMessages(ChatId,{[1]= Msg_id})
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id=" .. ChatId .. "&photo="..photo.photos[8].sizes[#photo.photos[1].sizes].photo.remote.id.."&caption=".. URL.escape(ban_ns).."&reply_to_message_id=0&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
return LuaTele.sendText(ChatId,Msg_id,'*𖥔 لا توجد صوره ف حسابك*',"md",true) 
end
end
end

if Text and Text:match('/Mahibes(%d+)') then
local GetMahibes = Text:match('/Mahibes(%d+)') 
local NumMahibes = math.random(1,6)
if tonumber(GetMahibes) == tonumber(NumMahibes) then
Redis:incrby(MEZO.."MEZO:Num:Add:Games"..ChatId..IdUser, 1)  
MahibesText = '* ❍┃ الف مبروك حظك حلو اليوم\n ❍┃ فزت ويانه وطلعت المحيبس بل عظمه رقم⟦'..NumMahibes..'⟧*'
else
MahibesText = '* ❍┃ للاسف لقد خسرت المحيبس بالعظمه رقم ⟦'..NumMahibes..'⟧\n ❍┃ جرب حضك ويانه مره اخره*'
end
if NumMahibes == 1 then
Mahibes1 = '🤚' else Mahibes1 = '👊'
end
if NumMahibes == 2 then
Mahibes2 = '🤚' else Mahibes2 = '👊'
end
if NumMahibes == 3 then
Mahibes3 = '🤚' else Mahibes3 = '👊' 
end
if NumMahibes == 4 then
Mahibes4 = '🤚' else Mahibes4 = '??'
end
if NumMahibes == 5 then
Mahibes5 = '🤚' else Mahibes5 = '👊'
end
if NumMahibes == 6 then
Mahibes6 = '🤚' else Mahibes6 = '👊'
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '⟦ ❶ -› '..Mahibes1..' ⟧', data = '/*'}, {text = '⟦ ❷ -› '..Mahibes2..' ⟧', data = '/*'}, 
},
{
{text = '⟦ ❸ -› '..Mahibes3..' ⟧', data = '/*'}, {text = '⟦ ❹ -› '..Mahibes4..' ⟧', data = '/*'}, 
},
{
{text = '⟦ ❺ -› '..Mahibes5..' ⟧', data = '/*'}, {text = '⟦ ❻ -› '..Mahibes6..' ⟧', data = '/*'}, 
},
{
{text = '⟦ اللعب مره اخرى ⟧', data = '/MahibesAgane'},
},
}
}
return LuaTele.editMessageText(ChatId,Msg_id,MahibesText, 'md', true, false, reply_markup)
end
if Text == "/MahibesAgane" then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '⟦ ❶ -› 👊 ⟧', data = '/Mahibes1'}, {text = '⟦ ❷ -› 👊 ⟧', data = '/Mahibes2'}, 
},
{
{text = '⟦ ❸ -› 👊 ⟧', data = '/Mahibes3'}, {text = '⟦ ❹ -› 👊 ⟧', data = '/Mahibes4'}, 
},
{
{text = '⟦ ❺ -› 👊 ⟧', data = '/Mahibes5'}, {text = '⟦ ❻ -› 👊 ⟧', data = '/Mahibes6'}, 
},
}
}
local TextMahibesAgane = [[*
╗•لعبه المحيبس هي لعبة الحظ ⦁
╣•جرب حظك ويه البوت واتونس ⦁
╣•كل ما عليك هوا الضغط على ⦁
╝•احدى العضمات في الازرار ⦁
*]]
return LuaTele.editMessageText(ChatId,Msg_id,TextMahibesAgane, 'md', true, false, reply_markup)
end
if Text and Text:match('(%d+)/mp3(.*)') then
local UserId = {Text:match('(%d+)/mp3(.*)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '‹ cristina source ›', url = 't.me/cristin_so'}, 
},
}
}
local TextHelp = [[*
◍ ارسل ما تريد تحميله
*]]
Redis:set(MEZO.."youtube"..IdUser..ChatId,'mp3')
LuaTele.editMessageText(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/mp4(.*)') then
local UserId = {Text:match('(%d+)/mp4(.*)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '‹ cristina source ›', url = 't.me/cristin_so'}, 
},
}
}
local TextHelp = [[*
◍ ارسل ما تريد تحميله
*]]
Redis:set(MEZO.."youtube"..IdUser..ChatId,'mp4')
LuaTele.editMessageText(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/help1') then
local UserId = Text:match('(%d+)/help1')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '‹ اوامر المطورين ›', data = IdUser..'/helpo1'}, {text = '‹ اوامر الثانويين ›', data = IdUser..'/helpo2'}, 
},
{
{text = '‹ اوامر المطور الاساسي ›', data = IdUser..'/helpo3'}, 
},
{
{text = '❍ • القائمه الرئيسيه • ❍', data = IdUser..'/helpall'}, 
},
{
{text = '❍ 𓏶 𝒄𝒓𝒊𝒔𝒕𝒊𝒏 • 𝒔𝒐𝒖𝒓𝒄𝒆 𓏶 ❍', url = 't.me/cristin_so'}, 
},
}
}
local TextHelp = [[*
🔻╎ نورت #يرحقلبي • ♡ • ~
🔺️╎ اهلا بك في معرفه اوامر الرتب • ~
🔻╎ اختر اوامر الرتب • ~ `
🔺️╎ من خلال الأزرار بالأسفل 👇 • ~

●━•◉•⟞⟦ ℻ 𝒄𝒓𝒊𝒔𝒕𝒊𝒏 ℻ ⟧⟝•◉•━●
(t.me/cristin_so)
*]]
LuaTele.editMessageText(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/helpo1') then
local UserId = Text:match('(%d+)/helpo1')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ اوامر المطور ❍', data = IdUser..'/helpo1'}, {text = '❍ اوامر المطور الثانوي ❍', data = IdUser..'/helpo2'}, 
},
{
{text = '❍ اوامر المطور الاساسي ❍', data = IdUser..'/helpo3'},
},
{
{text = '❍ القائمه الرئيسيه ❍', data = IdUser..'/helpall'}, 
},
{
{text = '❍ 𓏶 𝒄𝒓𝒊𝒔𝒕𝒊𝒏 • 𝒔𝒐𝒖𝒓𝒄𝒆 𓏶 ❍', url = 't.me/cristin_so'}, 
},
}
}
local TextHelp = [[*
⟦ اوامر مطور البوت ⟧
— — — — — — — — —
❍ حظر ❍
❍ كتم ❍
❍ المحظورين ❍
❍ المكتومين ❍
❍ المقيدين ❍
❍ المطرودين ❍
❍ المحذوفين ❍
❍ اضف رد ❍
❍ مسح رد ❍
❍ مسح الردود المضافه ❍
❍ الردود المضافه ❍
❍ بوت غادر ❍
— — — — — — — — —
❍ الحمايه ❍
❍ اعدادات الحمايه ❍
❍ الاعدادات ❍
❍ المجموعه ❍
❍ صلاحيات المجموعه ❍
❍ المالكين ❍
❍ المنشئين الاساسيين ❍
❍ المنشئين ❍
❍ المدراء ❍
❍ الادمنيه ❍
❍ المميزين ❍
— — — — — — — — —
❍ رفع + تنزيل ❍
❍ مالك ❍
❍ منشئ اساسي ❍
❍ منشئ ❍
❍ مدير ❍
❍ مشرف ❍
❍ ادمن ❍
❍ مميز ❍
— — — — — — — — —
❍ اضف رد عام ❍
❍ مسح رد عام ❍
❍ الردود العامه ❍
❍ اذاعه ❍
❍ اذاعه بالتثبيت ❍
❍ اذاعه خاص ❍
❍ اذاعه بالتوجيه ❍
❍ اذاعه بالتوجيه خاص ❍
— — — — — — — — —
*]]
LuaTele.editMessageText(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/helpo2') then
local UserId = Text:match('(%d+)/helpo2')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ اوامر المطور ❍', data = IdUser..'/helpo1'}, {text = '❍ اوامر المطور الثانوي ❍', data = IdUser..'/helpo2'}, 
},
{
{text = '❍ اوامر المطور الاساسي ❍', data = IdUser..'/helpo3'}, 
},
{
{text = '❍ القائمه الرئيسيه ❍', data = IdUser..'/helpall'},
},
{
{text = '❍ 𓏶 𝒄𝒓𝒊𝒔𝒕𝒊𝒏 • 𝒔𝒐𝒖𝒓𝒄𝒆 𓏶 ❍', url = 't.me/cristin_so'}, 
},
}
}
local TextHelp = [[*
⟦ اوامر مطور ثانوي البوت ⟧
— — — — — — — — —
❍ رفع مطور ❍
❍ تنزيل مطور ❍
❍ المطورين ❍
❍ مسح المطورين ❍
❍ حظر عام ❍
❍  الغاء العام ❍
❍ كتم عام ❍
❍ الغاء كتم عام ❍
❍ المكتومين ❍
❍ مسح المكتومين ❍
❍ غادر ❍
❍ الاحصائيات ❍
— — — — — — — — —
❍ تفعيل الردود العامه ❍
❍ تعطيل الردود العامه ❍
❍ اضف رد متعدد ❍
❍ حذف رد متعدد ❍
❍ الردود المتعدده ❍
❍ مسح الردود المتعدده ❍
❍ اضف رد ❍
❍ مسح رد ❍
— — — — — — — — —
❍ اضف رد عام ❍
❍ مسح رد عام ❍
❍ الردود العامه ❍
❍ مسح الردود العامه ❍
❍ اذاعه ❍
❍ اذاعه بالتثبيت ❍
❍ اذاعه خاص ❍
❍ اذاعه بالتوجيه ❍
❍ اذاعه بالتوجيه خاص ❍
— — — — — — — — —
*]]
LuaTele.editMessageText(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/helpo3') then
local UserId = Text:match('(%d+)/helpo3')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ اوامر المطور ❍', data = IdUser..'/helpo1'}, {text = '❍ اوامر المطور الثانوي ❍', data = IdUser..'/helpo2'}, 
},
{
{text = '❍ اوامر المطور الاساسي ❍', data = IdUser..'/helpo3'}, 
},
{
{text = '❍ القائمه الرئيسيه ❍', data = IdUser..'/helpall'}, 
},
{
{text = '❍ 𓏶 𝒄𝒓𝒊𝒔𝒕𝒊𝒏 • 𝒔𝒐??𝒓𝒄𝒆 𓏶 ❍', url = 't.me/cristin_so'}, 
},
}
}
local TextHelp = [[*
⟦ اوامر مطور البوت الاساسي ⟧
— — — — — — — — —
❍ حظر عام ❍
❍ كتم عام ❍
❍ قائمه العام ❍
❍ مسح قائمه العام ❍
❍ المطورين ❍
❍ مسح المطورين ❍
❍ الثانوين ❍
❍ مسح الثانوين ❍
❍ تحديث الملفات ❍
— — — — — — — — —
❍ تحديث السورس ❍
❍ تفعيل البوت الخدمي ❍
❍ تعيطل البوت الخدمي ❍
❍ تفعيل المغادره ❍
❍ تعطيل المغادره ❍
❍ بوت غادر ❍
❍ رفع مطور ❍
❍ تنزيل مطور ❍
❍ رفع كرستين ❍
❍ تنزيل كرستين ❍
— — — — — — — — —
❍ تفعيل الردود العامه ❍
❍ تعطيل الردود العامه ❍
❍ اضف رد متعدد ❍
❍ حذف رد متعدد ❍
❍ الردود المتعدده ❍
❍ مسح الردود المتعدده ❍
❍ اضف رد متعدد عام ❍
❍ حذف رد متعدد عام ❍
❍ مسح الردود المتعدده عام ❍
❍ اضف رد ❍
❍ مسح رد ❍
❍ اضف رد عام ❍
❍ مسح رد عام ❍
❍ الردود العامه ❍
❍ مسح الردود العامه ❍
— — — — — — — — —
❍ الملفات ❍
❍ مسح جميع الملفات ❍
 ❍ المتجر ❍
❍ الاحصائيات ❍
❍ جلب النسخه العامه ❍
❍ رفع النسخه العامه ❍
❍ اذاعه ❍
❍ اذاعه بالتثبيت ❍
❍ اذاعه خاص ❍
❍ اذاعه بالتوجيه ❍
❍ اذاعه بالتوجيه خاص ❍
— — — — — — — — —
*]]
LuaTele.editMessageText(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/help2') then
local UserId = Text:match('(%d+)/help2')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '‹ اوامر المطور ›', data = IdUser..'/help1'}, {text = '‹ اوامر التسليه ›', data = IdUser..'/help2'}, 
},
{
{text = '‹ اوامر الاعضاء ›', data = IdUser..'/help3'}, {text = '‹ اوامر الحذف ›', data = IdUser..'/help4'}, 
},
{
{text = '‹ تفعيل ℘ تعطيل ›', data = IdUser..'/listallAddorrem'}, {text = '‹ قفل ℘ فتح ›', data = IdUser..'/NoNextSeting'}, 
},
{
{text = '❍ 𓏶 𝒄𝒓𝒊𝒔𝒕𝒊𝒏 • 𝒔??𝒖𝒓𝒄𝒆 𓏶 ❍', url = 't.me/cristin_so'}, 
},
}
}
local TextHelp = [[*
⟦ اوامر التسليه ⟧
◈ رفع ⇔ تنزيل + الامر ◈
 ▁ ▂ ▃ ▄ ▅ ▆ ▇ █ ▉
◈ رفع + تنزيل -› متوحد ◈
◈ تاك للمتوحدين ◈
 ▁ ▂ ▉ ▄ ▅ ▆ ▇ ▅ ▆ ▇ █ ▉ ▂ ▁
◈ رفع + تنزيل -› كلب ◈
◈ تاك للكلاب ??
 ▁ ▂ ▉ ▄ ▅ ▆ ▇ ▅ ▆ ▇ █ ▉ ▂ ▁
◈ رفع + تنزيل -› قرد ◈
◈ تاك للقرود ◈
 ▁ ▂ ▉ ▄ ▅ ▆ ▇ ▅ ▆ ▇ █ ▉ ▂ ▁
◈ رفع + تنزيل -› زوجتي ◈
◈ تاك للزوجات ◈
 ▁ ▂ ▉ ▄ ▅ ▆ ▇ ▅ ▆ ▇ █ ▉ ▂ ▁
◈ رفع + تنزيل -› قلبي ◈
◈ تاك لقلبي ◈
 ▁ ▂ ▉ ▄ ▅ ▆ ▇ ▅ ▆ ▇ █ ▉ ▂ ▁
◈ رفع + تنزيل -› بقره ◈
◈ تاك للبقرات ◈
 ▁ ▂ ▉ ▄ ▅ ▆ ▇ ▅ ▆ ▇ █ ▉ ▂ ▁
◈ رفع + تنزيل -› ارمله ◈
◈ تاك للارامل ◈
 ▁ ▂ ▉ ▄ ▅ ▆ ▇ ▅ ▆ ▇ █ ▉ ▂ ▁
◈ رفع + تنزيل -› خول ◈
◈ تاك للخولات ◈
 ▁ ▂ ▉ ▄ ▅ ▆ ▇ ▅ ▆ ▇ █ ▉ ▂ ▁
◈ رفع + تنزيل -› حمار ◈
◈ تاك للحمير ◈
 ▁ ▂ ▉ ▄ ▅ ▆ ▇ ▅ ▆ ▇ █ ▉ ▂ ▁
◈ رفع + تنزيل -› مزه ◈
◈ تاك للمزز ◈
 ▁ ▂ ▉ ▄ ▅ ▆ ▇ ▅ ▆ ▇ █ ▉ ▂ ▁
◈ رفع + تنزيل -› وتكه ◈
◈ تاك للوتكات ◈
 ▁ ▂ ▉ ▄ ▅ ▆ ▇ ▅ ▆ ▇ █ ▉ ▂ ▁
◈ رفع + تنزيل -› ابني ◈
◈ تاك لولادي ◈
 ▁ ▂ ▉ ▄ ▅ ▆ ▇ ▅ ▆ ▇ █ ▉ ▂ ▁
◈ رفع + تنزيل -› بنتي ◈
◈ تاك لبناتي ◈
 ▁ ▂ ▉ ▄ ▅ ▆ ▇ ▅ ▆ ▇ █ ▉ ▂ ▁
◈ رفع + تنزيل -› خاين ◈
◈ تاك للخاينين ◈
 ▁ ▂ ▉ ▄ ▅ ▆ ▇ ▅ ▆ ▇ █ ▉ ▂ ▁
*]]
LuaTele.editMessageText(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/help3') then
local UserId = Text:match('(%d+)/help3')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '‹ اوامر المطور ›', data = IdUser..'/help1'}, {text = '‹ اوامر التسليه ›', data = IdUser..'/help2'}, 
},
{
{text = '‹ اوامر الاعضاء ›', data = IdUser..'/help3'}, {text = '‹ اوامر الحذف ›', data = IdUser..'/help4'}, 
},
{
{text = '‹ تفعيل ℘ تعطيل ›', data = IdUser..'/listallAddorrem'}, {text = '‹ قفل ℘ فتح ›', data = IdUser..'/NoNextSeting'}, 
},
{
{text = '❍ 𓏶 𝒄𝒓𝒊𝒔𝒕𝒊𝒏 • 𝒔𝒐𝒖𝒓𝒄𝒆 𓏶 ❍', url = 't.me/cristin_so'}, 
},
}
}
local TextHelp = [[*
┄─┅═ـ═┅─┄
↫ ❬ • أوامر الأعضاء • ❭
┄─┅═ـ═┅─┄     
🔺️╿❬ أسـمـي ❭ ◍
🔻│❬ صــورتـي ❭ ◍
🔺️│❬ رتــبـتــي ❭ ◍
🔻│❬ انــا مـيـن ❭ ◍
🔺️│❬ ايـــــدي ❭ ◍
🔻│❬ لو خــيــروك ❭ ◍
🔺️│❬ تــويـت ❭ ◍
🔻│❬ تـويــت بالصــور ❭ ◍
🔺️│❬ هــل تـعـلـم ❭ ◍
🔻│❬ صــراحــه ❭ ◍
┄─┅═ـ═┅─┄     
🔺️│❬ نسـبـه جـمـالــي ❭ ◍
🔻│❬ نسـبـه الحــب ❭ ◍
🔺️│❬ نسـبـه الكـــره ❭ ◍
🔻│❬ نسـبـه الرجـوله ❭ ◍
🔺️│❬ نسـبـه الانوثــه ❭ ◍
🔻│❬ صـلاحـيـاتــي ❭ ◍
🔺️│❬ جــهـاتـــــي ❭ ◍
🔻│❬ ســــــــورس ❭ ◍
🔺️│❬ بــــــــــوت ❭ ◍
🔻│❬ المــــطـــــور ❭ ◍
🔺️│❬ كـــــشــــف ❭ ◍
🔻│❬ الــــرابـــــط ❭ ◍
┄─┅═ـ═┅─┄     
🔺️│❬ بــوت حـــذف ❭ ◍
🔻│❬ روابــط حــذف ❭ ◍
🔺️│❬ رســـائــلـــي ❭ ◍
🔻│❬ مـسـح رسـائـلي ❭ ◍
🔺️│❬ زخــــرفــــه ❭ ◍
🔻│❬ قــول + الكلـمـه ❭  ◍
🔺️│❬ حـــــــروف ❭ ◍
🔻│❬ اطـــردنـــي ❭ ◍
🔺️│❬ انـصـحـنــي ❭ ◍
🔻│❬ كــتــبــاتـ ❭ ◍
🔺️│❬ غــنــيــلـي ❭ ◍
🔻│❬ مــسـتقبـلـي ❭ ◍
— — — — — — — — —
*]]
LuaTele.editMessageText(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/help4') then
local UserId = Text:match('(%d+)/help4')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '◗المنشئين الاساسيين◖', data = IdUser..'/TheBasics'}, {text = '◖مسح المالكين', data = IdUser..'/TheBasicsQ'}, 
},
{
{text = 'مسح الثانويين', data = IdUser..'/DevelopersQ'}, {text = 'مسح المطورين', data = IdUser..'/Developers'}, 
},
{
{text = '❍ مسح المميزين ❍', data = IdUser..'/DelDistinguished'}, {text = '❍ مسح المنشئين ❍', data = IdUser..'/Originators'}, 
},
{
{text = '❍ مسح المدراء ❍', data = IdUser..'/Managers'}, {text = '❍ مسح الادمنيه ❍', data = IdUser..'/Addictive'}, 
},
{
{text = '❍ مسح المكتومين ❍', data = IdUser..'/SilentGroupGroup'}, {text = '❍ مسح المحظورين ❍', data = IdUser..'/JabwaGroup'}, 
},
{
{text = '❍ مسح المكتومين عام ❍', data = IdUser..'/SASAII'}, {text = '❍ مسح المحظورين عام ❍', data = IdUser..'/Redisa'}, 
},
{
{text = '❍ القائمه الرئيسيه ❍', data =IdUser..'/'.. 'helpall'}
},
{
{text = '❍ اخفاء الاوامر ❍', data =IdUser..'/'.. '/delAmr'}
},
}
}
local TextHelp = [[*
🔻╎ نورت #يرحقلبي • ♡ • ~
🔺️╎ اهلا بك في قسم { اوامر الحذف } • ~
🔻╎ اختار نوع الحذف ااي تحتاجه • ~
🔺️╎ من خلال الأزرار بالأسفل 👇 • ~

— — — — — — — — —
*]]
LuaTele.editMessageText(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/helpall') then
local UserId = Text:match('(%d+)/helpall')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '‹ اوامر المطور ›', data = IdUser..'/help1'}, {text = '‹ اوامر التسليه ›', data = IdUser..'/help2'}, 
},
{
{text = '‹ اوامر الاعضاء ›', data = IdUser..'/help3'}, {text = '‹ اوامر الحذف ›', data = IdUser..'/help4'}, 
},
{
{text = '‹ تفعيل ℘ تعطيل ›', data = IdUser..'/listallAddorrem'}, {text = '‹ قفل ℘ فتح ›', data = IdUser..'/NoNextSeting'}, 
},
{
{text = '❍ 𓏶 𝒄𝒓𝒊𝒔𝒕𝒊𝒏 • 𝒔𝒐𝒖𝒓𝒄𝒆 𓏶 ❍', url = 't.me/cristin_so'}, 
},
}
}
local TextHelp = [[*
╗⦁❶⦁ ‹ اوامر المطورين ›
╣⦁❷⦁ ‹ اوامر التسليه ›
╣⦁❸⦁ ‹ اوامر الاعضاء ›
╣⦁❹⦁ ‹ اوامر المسح ›
╣⦁❺⦁ ‹ اوامر التفعيل والتعطيل ›
╝⦁❻⦁ ‹ اوامر الفتح والقفل ›
*]]
LuaTele.editMessageText(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/helma1') then
local UserId = Text:match('(%d+)/helma1')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ 𝘊𝘏 • 𝘊𝘙𝘐𝘚𝘛𝘐𝘕 ❍', url = "https://t.me/cristin_so"},
},
{
{text = '𝒃𝒂𝒄𝒌↺ ', data =IdUser..'/'.. '/helpall'},
},
}
}
local TextHelp = [[*
🏴‍☠️ الالعاب الخاصه بالسورس
— — — — — — — — —
⚙️╖ لتفعيل الالعاب او تعطيلها ارسل ⇊
🔰╜ تعطيل الالعاب ࿗ تفعيل الالعاب
— — — — — — — — —
🖥️╖  لمشاهده الفيديو ࿗ ❬استوري❭
??╖  لمسع الأغاني ࿗ ❬غنيلي❭
🖼️╢ لعبة كت تويت ❬تويت بالصوره❭
🎎╢ لعبة لو خيروك  ❬لو خيروك بالصوره❭
💎╢ كت تويت :- تويت❭
👀╢ لعبة المختلف ↵ المختلف❭
🧾╢ لعبة بوستات ↵ كتبات❭
🧮╢ لعبة الاحرف ↵ حروف❭
⚖️╢ لعبة النصائح ↵ انصحني❭
🤣╢ لعبة الضحك ↵ نكته❭
🎩╢ لعبة اختار بينا ↵ لو خيروك❭
🤹‍♂️╢ لعبة الامثله ↵ امثله❭
🏤╢ لعبة العكس ↵ العكس❭
‌🏜⁩╢ لعبة الحزوره ↵ حزوره❭
🎰╢ لعبة المعاني ↵ معاني❭
🌐╢ لعبة البات ↵ بات❭
🎎╢ لعبة التخمين ↵ خمن❭
‌♻️⁩╢ لعبه الاسرع ↵ الاسرع❭
🤔╢لعبة السمايلات ↵ سمايلات❭
🎬╜ لعبة الاعلام والدول ↵ اعلام❭
— — — — — — — — —
𖥔 نقاطي ↵ لعرض عدد الارباح
𖥔 بيع نقاطي ↵ ⦗ العدد  ⦘↵ لبيع كل نقطه مقابل {50} رساله
*]]
LuaTele.editMessageText(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/degm') then
local UserId = Text:match('(%d+)/degm')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ 𝘊𝘏 • 𝘊𝘙𝘐𝘚𝘛𝘐𝘕 ❍', url = "https://t.me/cristin_so"},
},
{
{text = '𝒃𝒂𝒄𝒌↺ ', data =IdUser..'/'.. '/helpall'},
},
}
}
local TextHelp = [[*
{{text = 'فلابي بيرد', url="https://t.me/awesomebot?game=FlappyBird"},{text = 'تحداني فالرياضيات',url="https://t.me/gamebot?game=MathBattle"}},   
{{text = 'لعبه دراجات', url="https://t.me/gamee?game=MotoFX"},{text = 'سباق سيارات', url="https://t.me/gamee?game=F1Racer"}}, 
{{text = 'تشابه', url="https://t.me/gamee?game=DiamondRows"},{text = 'كره القدم', url="https://t.me/gamee?game=FootballStar"}}, 
{{text = 'ورق', url="https://t.me/gamee?game=Hexonix"},{text = 'لعبه 2048', url="https://t.me/awesomebot?game=g2048"}}, 
{{text = 'SQUARES', url="https://t.me/gamee?game=Squares"},{text = 'ATOMIC', url="https://t.me/gamee?game=AtomicDrop1"}}, 
{{text = 'CORSAIRS', url="https://t.me/gamebot?game=Corsairs"},{text = 'LumberJack', url="https://t.me/gamebot?game=LumberJack"}}, 
{{text = 'LittlePlane', url="https://t.me/gamee?game=LittlePlane"},{text = 'RollerDisco', url="https://t.me/gamee?game=RollerDisco"}},  
{{text = 'كره القدم 2', url="https://t.me/gamee?game=PocketWorldCup"},{text = 'جمع المياه', url="https://t.me/gamee?game=BlockBuster"}},  
{{text = 'لا تجعلها تسقط', url="https://t.me/gamee?game=Touchdown"},{text = 'GravityNinja', url="https://t.me/gamee?game=GravityNinjaEmeraldCity"}},  
{{text = 'Astrocat', url="https://t.me/gamee?game=Astrocat"},{text = 'Skipper', url="https://t.me/gamee?game=Skipper"}},  
{{text = 'WorldCup', url="https://t.me/gamee?game=PocketWorldCup"},{text = 'GeometryRun', url="https://t.me/gamee?game=GeometryRun"}},  
{{text = 'Ten2One', url="https://t.me/gamee?game=Ten2One"},{text = 'NeonBlast2', url="https://t.me/gamee?game=NeonBlast2"}},  
{{text = 'Paintio', url="https://t.me/gamee?game=Paintio"},{text = 'onetwothree', url="https://t.me/gamee?game=onetwothree"}},  
{{text = 'BrickStacker', url="https://t.me/gamee?game=BrickStacker"},{text = 'StairMaster3D', url="https://t.me/gamee?game=StairMaster3D"}},  
{{text = 'LoadTheVan', url="https://t.me/gamee?game=LoadTheVan"},{text = 'BasketBoyRush', url="https://t.me/gamee?game=BasketBoyRush"}},  
{{text = 'GravityNinja21', url="https://t.me/gamee?game=GravityNinja21"},{text = 'MarsRover', url="https://t.me/gamee?game=MarsRover"}},  
{{text = 'LoadTheVan', url="https://t.me/gamee?game=LoadTheVan"},{text = 'GroovySki', url="https://t.me/gamee?game=GroovySki"}},  
{{text = 'PaintioTeams', url="https://t.me/gamee?game=PaintioTeams"},{text = 'KeepItUp', url="https://t.me/gamee?game=KeepItUp"}},  
{{text = 'SunshineSolitaire', url="https://t.me/gamee?game=SunshineSolitaire"},{text = 'Qubo', url="https://t.me/gamee?game=Qubo"}},  
{{text = 'PenaltyShooter2', url="https://t.me/gamee?game=PenaltyShooter2"},{text = 'Getaway', url="https://t.me/gamee?game=Getaway"}},  
{{text = 'PaintioTeams', url="https://t.me/gamee?game=PaintioTeams"},{text = 'SpikyFish2', url="https://t.me/gamee?game=SpikyFish2"}},  
{{text = 'GroovySki', url="https://t.me/gamee?game=GroovySki"},{text = 'KungFuInc', url="https://t.me/gamee?game=KungFuInc"}},  
{{text = 'SpaceTraveler', url="https://t.me/gamee?game=SpaceTraveler"},{text = 'RedAndBlue', url="https://t.me/gamee?game=RedAndBlue"}},  
{{text = 'SkodaHockey1 ', url="https://t.me/gamee?game=SkodaHockey1"},{text = 'SummerLove', url="https://t.me/gamee?game=SummerLove"}},  
{{text = 'SmartUpShark', url="https://t.me/gamee?game=SmartUpShark"},{text = 'SpikyFish3', url="https://t.me/gamee?game=SpikyFish3"}},  
}
}
*]]
LuaTele.editMessageText(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/helpall1') then
local UserId = Text:match('(%d+)/helpall1')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❍ الالعاب التسليه ❍', data = msg.sender.user_id..'/helma1'},
},
{
{text = '❍ الالعاب الالكترونيه ❍', data = msg.sender.user_id..'/degm'}, 
},
{
{text = '❍ 𓏶 𝒄𝒓𝒊𝒔𝒕𝒊𝒏 • 𝒔𝒐𝒖𝒓𝒄𝒆 𓏶 ❍', url = 't.me/cristin_so'}, 
},
}
}
local TextHelp = [[*
❍┃ اليك قسم الالعاب من سورس كرستين🏴‍☠️
*]]
LuaTele.editMessageText(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/zog1') then
local UserId = Text:match('(%d+)/zog1')
if tonumber(IdUser) == tonumber(UserId) then
local bain = LuaTele.getUser(IdUser)
if bain.first_name then
baniusername = '*تم الزواج بنجاح \nمبروك يا  :- *['..bain.first_name..'](tg://user?id='..bain.id..')*\n*'
else
baniusername = 'لا يوجد'
end
LuaTele.editMessageText(ChatId,Msg_id,baniusername, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/zog2') then
local UserId = Text:match('(%d+)/zog2')
if tonumber(IdUser) == tonumber(UserId) then
LuaTele.editMessageText(ChatId,Msg_id,"*𖥔 تم رفض الزواج من الزوجه*","md",true) 
end
end
if Text == '/leftz@' then
LuaTele.editMessageText(ChatId,Msg_id,"*𖥔 ارسل الكلمه لزخرفتها عربي او انجلش*","md",true) 
Redis:set(MEZO.."zhrfa"..IdUser,"sendzh") 
end 
if Text == '/leftz@' then
LuaTele.editMessageText(ChatId,Msg_id,"*𖥔 ارسل الكلمه لزخرفتها عربي او انجلش*","md",true) 
Redis:set(MEZO.."zhrfa"..IdUser,"sendzh") 
end 
if Text and Text:match('(%d+)/lock_link') then
local UserId = Text:match('(%d+)/lock_link')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:Link"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل الروابط").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_spam') then
local UserId = Text:match('(%d+)/lock_spam')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:Spam"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل الكلايش").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_keypord') then
local UserId = Text:match('(%d+)/lock_keypord')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:Keyboard"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل الكيبورد").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_voice') then
local UserId = Text:match('(%d+)/lock_voice')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:vico"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل الاغاني").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_gif') then
local UserId = Text:match('(%d+)/lock_gif')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:Animation"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل المتحركات").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_files') then
local UserId = Text:match('(%d+)/lock_files')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:Document"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل الملفات").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_text') then
local UserId = Text:match('(%d+)/lock_text')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:text"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل الدردشه").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_video') then
local UserId = Text:match('(%d+)/lock_video')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:Video"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل الفيديو").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_photo') then
local UserId = Text:match('(%d+)/lock_photo')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:Photo"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل الصور").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_username') then
local UserId = Text:match('(%d+)/lock_username')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:User:Name"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل المعرفات").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_tags') then
local UserId = Text:match('(%d+)/lock_tags')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:hashtak"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل التاك").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_bots') then
local UserId = Text:match('(%d+)/lock_bots')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:Bot:kick"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل البوتات").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_fwd') then
local UserId = Text:match('(%d+)/lock_fwd')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:forward"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل التوجيه").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_audio') then
local UserId = Text:match('(%d+)/lock_audio')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:Audio"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل الصوت").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_stikear') then
local UserId = Text:match('(%d+)/lock_stikear')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:Sticker"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل الملصقات").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_phone') then
local UserId = Text:match('(%d+)/lock_phone')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:Contact"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل الجهات").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_joine') then
local UserId = Text:match('(%d+)/lock_joine')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:Join"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل الدخول").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_addmem') then
local UserId = Text:match('(%d+)/lock_addmem')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:AddMempar"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل الاضافه").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_videonote') then
local UserId = Text:match('(%d+)/lock_videonote')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:Unsupported"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل بصمه الفيديو").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_pin') then
local UserId = Text:match('(%d+)/lock_pin')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:lockpin"..ChatId,(LuaTele.getChatPinnedMessage(ChatId).id or true)) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل التثبيت").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_tgservir') then
local UserId = Text:match('(%d+)/lock_tgservir')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:tagservr"..ChatId,true)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل الاشعارات").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_markdaun') then
local UserId = Text:match('(%d+)/lock_markdaun')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:Markdaun"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل الماركدون").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_edits') then
local UserId = Text:match('(%d+)/lock_edits')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:edit"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل التعديل").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_games') then
local UserId = Text:match('(%d+)/lock_games')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:geam"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل الالعاب").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_flood') then
local UserId = Text:match('(%d+)/lock_flood')
if tonumber(IdUser) == tonumber(UserId) then
Redis:hset(MEZO.."MEZO:Spam:Group:User"..ChatId ,"Spam:User","del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل التكرار").Lock, 'md', true, false, reply_markup)
end
end

if Text and Text:match('(%d+)/lock_linkkid') then
local UserId = Text:match('(%d+)/lock_linkkid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:Link"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل الروابط").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_spamkid') then
local UserId = Text:match('(%d+)/lock_spamkid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:Spam"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل الكلايش").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_keypordkid') then
local UserId = Text:match('(%d+)/lock_keypordkid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:Keyboard"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل الكيبورد").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_voicekid') then
local UserId = Text:match('(%d+)/lock_voicekid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:vico"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل الاغاني").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_gifkid') then
local UserId = Text:match('(%d+)/lock_gifkid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:Animation"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل المتحركات").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_fileskid') then
local UserId = Text:match('(%d+)/lock_fileskid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:Document"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل الملفات").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_videokid') then
local UserId = Text:match('(%d+)/lock_videokid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:Video"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل الفيديو").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_photokid') then
local UserId = Text:match('(%d+)/lock_photokid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:Photo"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل الصور").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_usernamekid') then
local UserId = Text:match('(%d+)/lock_usernamekid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:User:Name"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل المعرفات").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_tagskid') then
local UserId = Text:match('(%d+)/lock_tagskid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:hashtak"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل التاك").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_fwdkid') then
local UserId = Text:match('(%d+)/lock_fwdkid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:forward"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل التوجيه").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_audiokid') then
local UserId = Text:match('(%d+)/lock_audiokid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:Audio"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل الصوت").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_stikearkid') then
local UserId = Text:match('(%d+)/lock_stikearkid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:Sticker"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل الملصقات").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_phonekid') then
local UserId = Text:match('(%d+)/lock_phonekid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:Contact"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل الجهات").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_videonotekid') then
local UserId = Text:match('(%d+)/lock_videonotekid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:Unsupported"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل بصمه الفيديو").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_markdaunkid') then
local UserId = Text:match('(%d+)/lock_markdaunkid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:Markdaun"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل الماركدون").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_gameskid') then
local UserId = Text:match('(%d+)/lock_gameskid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:geam"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل الالعاب").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_floodkid') then
local UserId = Text:match('(%d+)/lock_floodkid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:hset(MEZO.."MEZO:Spam:Group:User"..ChatId ,"Spam:User","keed")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل التكرار").lockKid, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/lock_linkktm') then
local UserId = Text:match('(%d+)/lock_linkktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:Link"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل الروابط").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_spamktm') then
local UserId = Text:match('(%d+)/lock_spamktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:Spam"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل الكلايش").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_keypordktm') then
local UserId = Text:match('(%d+)/lock_keypordktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:Keyboard"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل الكيبورد").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_voicektm') then
local UserId = Text:match('(%d+)/lock_voicektm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:vico"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل الاغاني").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_gifktm') then
local UserId = Text:match('(%d+)/lock_gifktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:Animation"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل المتحركات").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_filesktm') then
local UserId = Text:match('(%d+)/lock_filesktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:Document"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل الملفات").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_videoktm') then
local UserId = Text:match('(%d+)/lock_videoktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:Video"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل الفيديو").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_photoktm') then
local UserId = Text:match('(%d+)/lock_photoktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:Photo"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل الصور").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_usernamektm') then
local UserId = Text:match('(%d+)/lock_usernamektm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:User:Name"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل المعرفات").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_tagsktm') then
local UserId = Text:match('(%d+)/lock_tagsktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:hashtak"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل التاك").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_fwdktm') then
local UserId = Text:match('(%d+)/lock_fwdktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:forward"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل التوجيه").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_audioktm') then
local UserId = Text:match('(%d+)/lock_audioktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:Audio"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل الصوت").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_stikearktm') then
local UserId = Text:match('(%d+)/lock_stikearktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:Sticker"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل الملصقات").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_phonektm') then
local UserId = Text:match('(%d+)/lock_phonektm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:Contact"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل الجهات").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_videonotektm') then
local UserId = Text:match('(%d+)/lock_videonotektm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:Unsupported"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل بصمه الفيديو").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_markdaunktm') then
local UserId = Text:match('(%d+)/lock_markdaunktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:Markdaun"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل الماركدون").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_gamesktm') then
local UserId = Text:match('(%d+)/lock_gamesktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:geam"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل الالعاب").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_floodktm') then
local UserId = Text:match('(%d+)/lock_floodktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:hset(MEZO.."MEZO:Spam:Group:User"..ChatId ,"Spam:User","mute")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل التكرار").lockKtm, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/lock_linkkick') then
local UserId = Text:match('(%d+)/lock_linkkick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:Link"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل الروابط").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_spamkick') then
local UserId = Text:match('(%d+)/lock_spamkick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:Spam"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل الكلايش").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_keypordkick') then
local UserId = Text:match('(%d+)/lock_keypordkick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:Keyboard"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل الكيبورد").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_voicekick') then
local UserId = Text:match('(%d+)/lock_voicekick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:vico"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل الاغاني").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_gifkick') then
local UserId = Text:match('(%d+)/lock_gifkick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:Animation"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل المتحركات").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_fileskick') then
local UserId = Text:match('(%d+)/lock_fileskick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:Document"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل الملفات").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_videokick') then
local UserId = Text:match('(%d+)/lock_videokick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:Video"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل الفيديو").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_photokick') then
local UserId = Text:match('(%d+)/lock_photokick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:Photo"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل الصور").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_usernamekick') then
local UserId = Text:match('(%d+)/lock_usernamekick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:User:Name"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل المعرفات").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_tagskick') then
local UserId = Text:match('(%d+)/lock_tagskick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:hashtak"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل التاك").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_fwdkick') then
local UserId = Text:match('(%d+)/lock_fwdkick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:forward"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل التوجيه").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_audiokick') then
local UserId = Text:match('(%d+)/lock_audiokick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:Audio"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل الصوت").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_stikearkick') then
local UserId = Text:match('(%d+)/lock_stikearkick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:Sticker"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل الملصقات").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_phonekick') then
local UserId = Text:match('(%d+)/lock_phonekick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:Contact"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل الجهات").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_videonotekick') then
local UserId = Text:match('(%d+)/lock_videonotekick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:Unsupported"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل بصمه الفيديو").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_markdaunkick') then
local UserId = Text:match('(%d+)/lock_markdaunkick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:Markdaun"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل الماركدون").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_gameskick') then
local UserId = Text:match('(%d+)/lock_gameskick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Lock:geam"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل الالعاب").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_floodkick') then
local UserId = Text:match('(%d+)/lock_floodkick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:hset(MEZO.."MEZO:Spam:Group:User"..ChatId ,"Spam:User","kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم قفـل التكرار").lockKick, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/unmute_link') then
local UserId = Text:match('(%d+)/unmute_link')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(MEZO.."MEZO:Status:Link"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم تعطيل امر الرابط").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_welcome') then
local UserId = Text:match('(%d+)/unmute_welcome')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(MEZO.."MEZO:Status:Welcome"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم تعطيل امر الترحيب").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_Id') then
local UserId = Text:match('(%d+)/unmute_Id')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(MEZO.."MEZO:Status:Id"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم تعطيل امر الايدي").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_IdPhoto') then
local UserId = Text:match('(%d+)/unmute_IdPhoto')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(MEZO.."MEZO:Status:IdPhoto"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم تعطيل امر الايدي بالصوره").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_ryple') then
local UserId = Text:match('(%d+)/unmute_ryple')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(MEZO.."MEZO:Status:Reply"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم تعطيل امر الردود المضافه").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_ryplesudo') then
local UserId = Text:match('(%d+)/unmute_ryplesudo')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(MEZO.."MEZO:Status:ReplySudo"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم تعطيل امر الردود العامه").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/madeson_belal') then
local UserId = Text:match('(%d+)/madeson_belal')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(MEZO.."MEZO:Sasa:Jeka"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'belalmadeson'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"* ❍┃ تم تعطيل ردود السورس *").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_setadmib') then
local UserId = Text:match('(%d+)/unmute_setadmib')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(MEZO.."MEZO:Status:SetId"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم تعطيل امر الرفع").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_kickmembars') then
local UserId = Text:match('(%d+)/unmute_kickmembars')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(MEZO.."MEZO:Status:JabwaId"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم تعطيل امر الطرد - الحظر").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_games') then
local UserId = Text:match('(%d+)/unmute_games')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(MEZO.."MEZO:Status:Games"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم تعطيل امر الالعاب").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_kickme') then
local UserId = Text:match('(%d+)/unmute_kickme')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(MEZO.."MEZO:Status:KickMe"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم تعطيل امر اطردني").unLock, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/mute_link') then
local UserId = Text:match('(%d+)/mute_link')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Status:Link"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم تفعيل امر الرابط").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_welcome') then
local UserId = Text:match('(%d+)/mute_welcome')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Status:Welcome"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم تفعيل امر الترحيب").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_Id') then
local UserId = Text:match('(%d+)/mute_Id')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Status:Id"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم تفعيل امر الايدي").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_IdPhoto') then
local UserId = Text:match('(%d+)/mute_IdPhoto')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Status:IdPhoto"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم تفعيل امر الايدي بالصوره").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_ryple') then
local UserId = Text:match('(%d+)/mute_ryple')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Status:Reply"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم تفعيل امر الردود المضافه").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_ryplesudo') then
local UserId = Text:match('(%d+)/mute_ryplesudo')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Status:ReplySudo"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم تفعيل امر الردود العامه").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/belal_madeson') then
local UserId = Text:match('(%d+)/belal_madeson')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Sasa:Jeka"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'belalmadeson'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"* ❍┃ تم تفعيل ردود السورس *").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_setadmib') then
local UserId = Text:match('(%d+)/mute_setadmib')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Status:SetId"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم تفعيل امر الرفع").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_kickmembars') then
local UserId = Text:match('(%d+)/mute_kickmembars')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Status:JabwaId"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم تفعيل امر الطرد - الحظر").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_games') then
local UserId = Text:match('(%d+)/mute_games')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Status:Games"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم تفعيل امر الالعاب").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_kickme') then
local UserId = Text:match('(%d+)/mute_kickme')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(MEZO.."MEZO:Status:KickMe"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser," ❍┃ تم تفعيل امر اطردني").unLock, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/addAdmins@(.*)') then
local UserId = {Text:match('(%d+)/addAdmins@(.*)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
local Info_Members = LuaTele.getSupergroupMembers(UserId[2], "Administrators", "*", 0, 200)
local List_Members = Info_Members.members
x = 0
y = 0
for k, v in pairs(List_Members) do
if Info_Members.members[k].bot_info == nil then
if Info_Members.members[k].status.luatele == "chatMemberStatusCreator" then
Redis:sadd(MEZO.."MEZO:TheBasics:Group"..UserId[2],v.member_id.user_id) 
x = x + 1
else
Redis:sadd(MEZO.."MEZO:Addictive:Group"..UserId[2],v.member_id.user_id) 
y = y + 1
end
end
end
LuaTele.answerCallbackQuery(data.id, " ❍┃ تم ترقيه ⟦ "..y.." ⟧ ادمنيه \n ❍┃ تم ترقية المالك ", true)
end
end
if Text and Text:match('(%d+)/LockAllGroup@(.*)') then
local UserId = {Text:match('(%d+)/LockAllGroup@(.*)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
Redis:set(MEZO.."MEZO:Lock:tagservrbot"..UserId[2],true)   
list ={"Lock:Bot:kick","Lock:User:Name","Lock:hashtak","Lock:Cmd","Lock:Link","Lock:forward","Lock:Keyboard","Lock:geam","Lock:Photo","Lock:Animation","Lock:Video","Lock:Audio","Lock:vico","Lock:Sticker","Lock:Document","Lock:Unsupported","Lock:Markdaun","Lock:Contact","Lock:Spam"}
for i,lock in pairs(list) do 
Redis:set(MEZO..'MEZO:'..lock..UserId[2],"del")    
end
LuaTele.answerCallbackQuery(data.id, " ❍┃ تم قفل جميع الاوامر بنجاح  ", true)
end
end
if Text and Text:match('(%d+)/openorders@(.*)') then
local UserId = {Text:match('(%d+)/openorders@(.*)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
Redis:set(MEZO.."MEZO:Lock:tagservrbot"..UserId[2],true)   
list ={"Lock:Bot:kick","Lock:User:Name","Lock:hashtak","Lock:Cmd","Lock:Link","Lock:forward","Lock:Keyboard","Lock:geam","Lock:Photo","Lock:Animation","Lock:Video","Lock:Audio","Lock:vico","Lock:Sticker","Lock:Document","Lock:Unsupported","Lock:Markdaun","Lock:Contact","Lock:Spam"}
for i,lock in pairs(list) do 
Redis:set(MEZO..'MEZO:'..lock..UserId[2],"del")    
end
LuaTele.answerCallbackQuery(data.id, " ❍┃ تم فتح جميع الاوامر بنجاح ", true)
end
end
if Text and Text:match('/Zxchq(.*)') then
local UserId = Text:match('/Zxchq(.*)')
LuaTele.answerCallbackQuery(data.id, " ❍┃ تم مغادره البوت من المجموعه", true)
LuaTele.leaveChat(UserId)
end
if Text and Text:match('(%d+)/Redis') then
local UserId = Text:match('(%d+)/Redis')
LuaTele.answerCallbackQuery(data.id, " ❍┃ تم الغاء الامر بنجاح", true)
if tonumber(IdUser) == tonumber(UserId) then
return LuaTele.deleteMessages(ChatId,{[1]= Msg_id})
end
end

if Text and Text:match('(%d+)/groupNumseteng//(%d+)') then
local UserId = {Text:match('(%d+)/groupNumseteng//(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
return GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id)
end
end
if Text and Text:match('(%d+)/groupNum1//(%d+)') then
local UserId = {Text:match('(%d+)/groupNum1//(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if tonumber(GetAdminsNum(ChatId,UserId[2]).change_info) == 1 then
LuaTele.answerCallbackQuery(data.id, " ❍┃ تم تعطيل صلاحيه تغيير المعلومات", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,'【 ❌ 】',nil,nil,nil,nil,nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,0, 0, 0, 0,0,0,1,0})
else
LuaTele.answerCallbackQuery(data.id, " ❍┃ تم تفعيل صلاحيه تغيير المعلومات", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,'【 ✅ 】',nil,nil,nil,nil,nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,1, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, GetAdminsNum(ChatId,UserId[2]).invite_users, GetAdminsNum(ChatId,UserId[2]).restrict_members ,GetAdminsNum(ChatId,UserId[2]).pin_messages, GetAdminsNum(ChatId,UserId[2]).promote})
end
end
end
if Text and Text:match('(%d+)/groupNum2//(%d+)') then
local UserId = {Text:match('(%d+)/groupNum2//(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if tonumber(GetAdminsNum(ChatId,UserId[2]).pin_messages) == 1 then
LuaTele.answerCallbackQuery(data.id, " ❍┃ تم تعطيل صلاحيه التثبيت", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,'【 ❌ 】',nil,nil,nil,nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, GetAdminsNum(ChatId,UserId[2]).invite_users, GetAdminsNum(ChatId,UserId[2]).restrict_members ,0, GetAdminsNum(ChatId,UserId[2]).promote})
else
LuaTele.answerCallbackQuery(data.id, " ❍┃ تم تفعيل صلاحيه التثبيت", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,'【 ✅ 】',nil,nil,nil,nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, GetAdminsNum(ChatId,UserId[2]).invite_users, GetAdminsNum(ChatId,UserId[2]).restrict_members ,1, GetAdminsNum(ChatId,UserId[2]).promote})
end
end
end
if Text and Text:match('(%d+)/groupNum3//(%d+)') then
local UserId = {Text:match('(%d+)/groupNum3//(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if tonumber(GetAdminsNum(ChatId,UserId[2]).restrict_members) == 1 then
LuaTele.answerCallbackQuery(data.id, " ❍┃ تم تعطيل صلاحيه الحظر", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,nil,'【 ❌ 】',nil,nil,nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, GetAdminsNum(ChatId,UserId[2]).invite_users, 0 ,GetAdminsNum(ChatId,UserId[2]).pin_messages, GetAdminsNum(ChatId,UserId[2]).promote})
else
LuaTele.answerCallbackQuery(data.id, " ❍┃ تم تفعيل صلاحيه الحظر", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,nil,'【 ✅ 】',nil,nil,nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, GetAdminsNum(ChatId,UserId[2]).invite_users, 1 ,GetAdminsNum(ChatId,UserId[2]).pin_messages, GetAdminsNum(ChatId,UserId[2]).promote})
end
end
end
if Text and Text:match('(%d+)/groupNum4//(%d+)') then
local UserId = {Text:match('(%d+)/groupNum4//(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if tonumber(GetAdminsNum(ChatId,UserId[2]).invite_users) == 1 then
LuaTele.answerCallbackQuery(data.id, " ❍┃ تم تعطيل صلاحيه دعوه المستخدمين", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,nil,nil,'【 ❌ 】',nil,nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, 0, GetAdminsNum(ChatId,UserId[2]).restrict_members ,GetAdminsNum(ChatId,UserId[2]).pin_messages, GetAdminsNum(ChatId,UserId[2]).promote})
else
LuaTele.answerCallbackQuery(data.id, " ❍┃ تم تفعيل صلاحيه دعوه المستخدمين", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,nil,nil,'【 ✅ 】',nil,nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, 1, GetAdminsNum(ChatId,UserId[2]).restrict_members ,GetAdminsNum(ChatId,UserId[2]).pin_messages, GetAdminsNum(ChatId,UserId[2]).promote})
end
end
end
if Text and Text:match('(%d+)/groupNum5//(%d+)') then
local UserId = {Text:match('(%d+)/groupNum5//(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if tonumber(GetAdminsNum(ChatId,UserId[2]).delete_messages) == 1 then
LuaTele.answerCallbackQuery(data.id, " ❍┃ تم تعطيل صلاحيه مسح الرسائل", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,nil,nil,nil,'【 ❌ 】',nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, 0, GetAdminsNum(ChatId,UserId[2]).invite_users, GetAdminsNum(ChatId,UserId[2]).restrict_members ,GetAdminsNum(ChatId,UserId[2]).pin_messages, GetAdminsNum(ChatId,UserId[2]).promote})
else
LuaTele.answerCallbackQuery(data.id, " ❍┃ تم تفعيل صلاحيه مسح الرسائل", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,nil,nil,nil,'【 ✅ 】',nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, 1, GetAdminsNum(ChatId,UserId[2]).invite_users, GetAdminsNum(ChatId,UserId[2]).restrict_members ,GetAdminsNum(ChatId,UserId[2]).pin_messages, GetAdminsNum(ChatId,UserId[2]).promote})
end
end
end
if Text and Text:match('(%d+)/groupNum6//(%d+)') then
local UserId = {Text:match('(%d+)/groupNum6//(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if tonumber(GetAdminsNum(ChatId,UserId[2]).promote) == 1 then
LuaTele.answerCallbackQuery(data.id, " ❍┃ تم تعطيل صلاحيه اضافه مشرفين", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,nil,nil,nil,nil,'【 ❌ 】')
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, GetAdminsNum(ChatId,UserId[2]).invite_users, GetAdminsNum(ChatId,UserId[2]).restrict_members ,GetAdminsNum(ChatId,UserId[2]).pin_messages, 0})
else
LuaTele.answerCallbackQuery(data.id, " ❍┃ تم تفعيل صلاحيه اضافه مشرفين", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,nil,nil,nil,nil,'【 ✅ 】')
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, GetAdminsNum(ChatId,UserId[2]).invite_users, GetAdminsNum(ChatId,UserId[2]).restrict_members ,GetAdminsNum(ChatId,UserId[2]).pin_messages, 1})
end
end
end

if Text and Text:match('(%d+)/web') then
local UserId = Text:match('(%d+)/web')
if tonumber(IdUser) == tonumber(UserId) then
if Getpermissions(ChatId).web == true then
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, false, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
else
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, true, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
end
Get_permissions(ChatId,IdUser,Msg_id)
end
elseif Text and Text:match('(%d+)/info') then
local UserId = Text:match('(%d+)/info')
if tonumber(IdUser) == tonumber(UserId) then
if Getpermissions(ChatId).info == true then
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, false, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
else
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, true, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
end
Get_permissions(ChatId,IdUser,Msg_id)
end
elseif Text and Text:match('(%d+)/invite') then
local UserId = Text:match('(%d+)/invite')
if tonumber(IdUser) == tonumber(UserId) then
if Getpermissions(ChatId).invite == true then
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, false, Getpermissions(ChatId).pin)
else
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, true, Getpermissions(ChatId).pin)
end
Get_permissions(ChatId,IdUser,Msg_id)
end
elseif Text and Text:match('(%d+)/pin') then
local UserId = Text:match('(%d+)/pin')
if tonumber(IdUser) == tonumber(UserId) then
if Getpermissions(ChatId).pin == true then
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, false)
else
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, true)
end
Get_permissions(ChatId,IdUser,Msg_id)
end
elseif Text and Text:match('(%d+)/media') then
local UserId = Text:match('(%d+)/media')
if tonumber(IdUser) == tonumber(UserId) then
if Getpermissions(ChatId).media == true then
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, false, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
else
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, true, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
end
Get_permissions(ChatId,IdUser,Msg_id)
end
elseif Text and Text:match('(%d+)/messges') then
local UserId = Text:match('(%d+)/messges')
if tonumber(IdUser) == tonumber(UserId) then
if Getpermissions(ChatId).messges == true then
LuaTele.setChatPermissions(ChatId, false, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
else
LuaTele.setChatPermissions(ChatId, true, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
end
Get_permissions(ChatId,IdUser,Msg_id)
end
elseif Text and Text:match('(%d+)/other') then
local UserId = Text:match('(%d+)/other')
if tonumber(IdUser) == tonumber(UserId) then
if Getpermissions(ChatId).other == true then
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, false, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
else
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, true, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
end
Get_permissions(ChatId,IdUser,Msg_id)
end
elseif Text and Text:match('(%d+)/polls') then
local UserId = Text:match('(%d+)/polls')
if tonumber(IdUser) == tonumber(UserId) then
if Getpermissions(ChatId).polls == true then
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, false, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
else
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, true, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
end
Get_permissions(ChatId,IdUser,Msg_id)
end
end
if Text and Text:match('(%d+)/listallAddorrem') then
local UserId = Text:match('(%d+)/listallAddorrem')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'تعطيل الرابط', data = IdUser..'/'.. 'unmute_link'},{text = 'تفعيل الرابط', data = IdUser..'/'.. 'mute_link'},
},
{
{text = 'تعطيل الترحيب', data = IdUser..'/'.. 'unmute_welcome'},{text = 'تفعيل الترحيب', data = IdUser..'/'.. 'mute_welcome'},
},
{
{text = 'تعطيل الايدي', data = IdUser..'/'.. 'unmute_Id'},{text = 'تفعيل الايدي', data = IdUser..'/'.. 'mute_Id'},
},
{
{text = 'تعطيل الايدي بالصوره', data = IdUser..'/'.. 'unmute_IdPhoto'},{text = 'تفعيل الايدي بالصوره', data = IdUser..'/'.. 'mute_IdPhoto'},
},
{
{text = 'تعطيل الردود المضافه', data = IdUser..'/'.. 'unmute_ryple'},{text = 'تفعيل الردود المضافه', data = IdUser..'/'.. 'mute_ryple'},
},
{
{text = 'تعطيل الردود العامه', data = IdUser..'/'.. 'unmute_ryplesudo'},{text = 'تفعيل الردود العامه', data = IdUser..'/'.. 'mute_ryplesudo'},
},
{
{text = 'تعطيل ردود السورس', data = IdUser..'/'.. 'madeson_belal'},{text = 'تفعيل ردود السورس', data = IdUser..'/'.. 'belal_madeson'},
},
{
{text = 'تعطيل الرفع', data = IdUser..'/'.. 'unmute_setadmib'},{text = 'تفعيل الرفع', data = IdUser..'/'.. 'mute_setadmib'},
},
{
{text = 'تعطيل الطرد', data = IdUser..'/'.. 'unmute_kickmembars'},{text = 'تفعيل الطرد', data = IdUser..'/'.. 'mute_kickmembars'},
},
{
{text = 'تعطيل الالعاب', data = IdUser..'/'.. 'unmute_games'},{text = 'تفعيل الالعاب', data = IdUser..'/'.. 'mute_games'},
},
{
{text = 'تعطيل اطردني', data = IdUser..'/'.. 'unmute_kickme'},{text = 'تفعيل اطردني', data = IdUser..'/'.. 'mute_kickme'},
},
{
{text = '◈⦁ القائمه الرئيسيه ⦁◈ ', data = IdUser..'/helpall'},
},
{
{text = '◈⦁ اخفاء الاوامر ⦁◈', data =IdUser..'/'.. 'delAmr'}
},
}
}
return LuaTele.editMessageText(ChatId,Msg_id,' ❍┃ اوامر التفعيل والتعطيل ', 'md', false, false, reply_markup)
end
end
if Text and Text:match('(%d+)/belalmadeson') then
local UserId = Text:match('(%d+)/belalmadeson')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- تفعيل ردود السورس ♡.', data = IdUser..'/'.. 'belal_madeson'},
},
{
{text = '- تعطيل ردود السورس ♡.', data = IdUser..'/'.. 'madeson_belal'},
},
}
}
return LuaTele.editMessageText(ChatId,Msg_id,'* ❍┃اليك اوامر تفعيل وتعطيل ردود السورس⚡♥️ *', 'md', false, false, reply_markup)
end
end
if Text and Text:match('(%d+)/listallAddorr') then
local UserId = Text:match('(%d+)/listallAddorr')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'تعطيل الرابط', data = IdUser..'/'.. 'unmute_link'},{text = 'تفعيل الرابط', data = IdUser..'/'.. 'mute_link'},
},
{
{text = 'تعطيل الترحيب', data = IdUser..'/'.. 'unmute_welcome'},{text = 'تفعيل الترحيب', data = IdUser..'/'.. 'mute_welcome'},
},
{
{text = 'تعطيل الايدي', data = IdUser..'/'.. 'unmute_Id'},{text = 'تفعيل الايدي', data = IdUser..'/'.. 'mute_Id'},
},
{
{text = 'تعطيل الايدي بالصوره', data = IdUser..'/'.. 'unmute_IdPhoto'},{text = 'تفعيل الايدي بالصوره', data = IdUser..'/'.. 'mute_IdPhoto'},
},
{
{text = 'تعطيل الردود المضافه', data = IdUser..'/'.. 'unmute_ryple'},{text = 'تفعيل الردود المضافه', data = IdUser..'/'.. 'mute_ryple'},
},
{
{text = 'تعطيل الردود العامه', data = IdUser..'/'.. 'unmute_ryplesudo'},{text = 'تفعيل الردود العامه', data = IdUser..'/'.. 'mute_ryplesudo'},
},
{
{text = 'تعطيل ردود السورس', data = IdUser..'/'.. 'madeson_belal'},{text = 'تفعيل ردود السورس', data = IdUser..'/'.. 'belal_madeson'},
},
{
{text = 'تعطيل الرفع', data = IdUser..'/'.. 'unmute_setadmib'},{text = 'تفعيل الرفع', data = IdUser..'/'.. 'mute_setadmib'},
},
{
{text = 'تعطيل الطرد', data = IdUser..'/'.. 'unmute_kickmembars'},{text = 'تفعيل الطرد', data = IdUser..'/'.. 'mute_kickmembars'},
},
{
{text = 'تعطيل الالعاب', data = IdUser..'/'.. 'unmute_games'},{text = 'تفعيل الالعاب', data = IdUser..'/'.. 'mute_games'},
},
{
{text = 'تعطيل اطردني', data = IdUser..'/'.. 'unmute_kickme'},{text = 'تفعيل اطردني', data = IdUser..'/'.. 'mute_kickme'},
},
{
{text = '◈⦁ اخفاء الاوامر ⦁◈', data =IdUser..'/'.. 'delAmr'}
},
}
}
return LuaTele.editMessageText(ChatId,Msg_id,'* ❍┃ اوامر حماية المجموعه *', 'md', false, false, reply_markup)
end
end
if Text and Text:match('(%d+)/NextSeting') then
local UserId = Text:match('(%d+)/NextSeting')
if tonumber(IdUser) == tonumber(UserId) then
local Text = "*\n ❍┃ اعدادات المجموعه ".."\n✅┃علامة صح تعني ان الامر مقفول".."\n❌┃علامة غلط تعني ان الامر مفتوح*"
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = GetSetieng(ChatId).lock_fwd, data = '&'},{text = 'التوجبه -› ', data =IdUser..'/'.. 'Status_fwd'},
},
{
{text = GetSetieng(ChatId).lock_muse, data = '&'},{text = 'الصوت -› ', data =IdUser..'/'.. 'Status_audio'},
},
{
{text = GetSetieng(ChatId).lock_ste, data = '&'},{text = 'الملصقات -› ', data =IdUser..'/'.. 'Status_stikear'},
},
{
{text = GetSetieng(ChatId).lock_phon, data = '&'},{text = 'الجهات -› ', data =IdUser..'/'.. 'Status_phone'},
},
{
{text = GetSetieng(ChatId).lock_join, data = '&'},{text = 'الدخول -› ', data =IdUser..'/'.. 'Status_joine'},
},
{
{text = GetSetieng(ChatId).lock_add, data = '&'},{text = 'الاضافه -› ', data =IdUser..'/'.. 'Status_addmem'},
},
{
{text = GetSetieng(ChatId).lock_self, data = '&'},{text = 'بصمه فيديو -› ', data =IdUser..'/'.. 'Status_videonote'},
},
{
{text = GetSetieng(ChatId).lock_pin, data = '&'},{text = 'التثبيت -› ', data =IdUser..'/'.. 'Status_pin'},
},
{
{text = GetSetieng(ChatId).lock_tagservr, data = '&'},{text = 'الاشعارات -› ', data =IdUser..'/'.. 'Status_tgservir'},
},
{
{text = GetSetieng(ChatId).lock_mark, data = '&'},{text = 'الماركدون -› ', data =IdUser..'/'.. 'Status_markdaun'},
},
{
{text = GetSetieng(ChatId).lock_edit, data = '&'},{text = 'التعديل -› ', data =IdUser..'/'.. 'Status_edits'},
},
{
{text = GetSetieng(ChatId).lock_geam, data = '&'},{text = 'الالعاب -› ', data =IdUser..'/'.. 'Status_games'},
},
{
{text = GetSetieng(ChatId).flood, data = '&'},{text = 'التكرار -› ', data =IdUser..'/'.. 'Status_flood'},
},
{
{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =IdUser..'/'.. 'NoNextSeting'}
},
{
{text = '◈⦁ القائمه الرئيسيه ⦁◈ ', data = IdUser..'/helpall'},
},
{
{text = '◈⦁ اخفاء الاوامر ⦁◈', data =IdUser..'/'.. '/delAmr'}
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,Text, 'md', false, false, reply_markup)
end
end
if Text and Text:match('(%d+)/NoNextSeting') then
local UserId = Text:match('(%d+)/NoNextSeting')
if tonumber(IdUser) == tonumber(UserId) then
local Text = "*\n ❍┃ اعدادات المجموعه ".."\n✅┃علامة صح تعني ان الامر مقفول".."\n❌┃علامة غلط تعني ان الامر مفتوح*"
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = GetSetieng(ChatId).lock_links, data = '&'},{text = 'الروابط -› ', data =IdUser..'/'.. 'Status_link'},
},
{
{text = GetSetieng(ChatId).lock_spam, data = '&'},{text = 'الكلايش -› ', data =IdUser..'/'.. 'Status_spam'},
},
{
{text = GetSetieng(ChatId).lock_inlin, data = '&'},{text = 'الكيبورد -› ', data =IdUser..'/'.. 'Status_keypord'},
},
{
{text = GetSetieng(ChatId).lock_vico, data = '&'},{text = 'الاغاني -› ', data =IdUser..'/'.. 'Status_voice'},
},
{
{text = GetSetieng(ChatId).lock_gif, data = '&'},{text = 'المتحركه -› ', data =IdUser..'/'.. 'Status_gif'},
},
{
{text = GetSetieng(ChatId).lock_file, data = '&'},{text = 'الملفات -› ', data =IdUser..'/'.. 'Status_files'},
},
{
{text = GetSetieng(ChatId).lock_text, data = '&'},{text = 'الدردشه -› ', data =IdUser..'/'.. 'Status_text'},
},
{
{text = GetSetieng(ChatId).lock_ved, data = '&'},{text = 'الفيديو -› ', data =IdUser..'/'.. 'Status_video'},
},
{
{text = GetSetieng(ChatId).lock_photo, data = '&'},{text = 'الصور -› ', data =IdUser..'/'.. 'Status_photo'},
},
{
{text = GetSetieng(ChatId).lock_user, data = '&'},{text = 'المعرفات -› ', data =IdUser..'/'.. 'Status_username'},
},
{
{text = GetSetieng(ChatId).lock_hash, data = '&'},{text = 'التاك -› ', data =IdUser..'/'.. 'Status_tags'},
},
{
{text = GetSetieng(ChatId).lock_bots, data = '&'},{text = 'البوتات -› ', data =IdUser..'/'.. 'Status_bots'},
},
{
{text = '◈⦁ القائمه الثانيه ⦁◈', data =IdUser..'/'.. 'NextSeting'}
},
{
{text = '◈⦁ القائمه الرئيسيه ⦁◈ ', data = IdUser..'/helpall'},
},
{
{text = '◈⦁ اخفاء الاوامر ⦁◈', data =IdUser..'/'.. 'delAmr'}
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,Text, 'md', false, false, reply_markup)
end
end 
if Text and Text:match('(%d+)/delAmr') then
local UserId = Text:match('(%d+)/delAmr')
if tonumber(IdUser) == tonumber(UserId) then
return LuaTele.deleteMessages(ChatId,{[1]= Msg_id})
end
end
if Text and Text:match('(%d+)/Status_link') then
local UserId = Text:match('(%d+)/Status_link')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الروابط', data =UserId..'/'.. 'lock_link'},{text = 'قفل الروابط بالكتم', data =UserId..'/'.. 'lock_linkktm'},
},
{
{text = 'قفل الروابط بالطرد', data =UserId..'/'.. 'lock_linkkick'},{text = 'قفل الروابط بالتقييد', data =UserId..'/'.. 'lock_linkkid'},
},
{
{text = 'فتح الروابط', data =UserId..'/'.. 'unlock_link'},
},
{
{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id," ❍┃ عليك اختيار نوع القفل او الفتح على امر الروابط", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_spam') then
local UserId = Text:match('(%d+)/Status_spam')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الكلايش', data =UserId..'/'.. 'lock_spam'},{text = 'قفل الكلايش بالكتم', data =UserId..'/'.. 'lock_spamktm'},
},
{
{text = 'قفل الكلايش بالطرد', data =UserId..'/'.. 'lock_spamkick'},{text = 'قفل الكلايش بالتقييد', data =UserId..'/'.. 'lock_spamid'},
},
{
{text = 'فتح الكلايش', data =UserId..'/'.. 'unlock_spam'},
},
{
{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id," ❍┃ عليك اختيار نوع القفل او الفتح على امر الكلايش", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_keypord') then
local UserId = Text:match('(%d+)/Status_keypord')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الكيبورد', data =UserId..'/'.. 'lock_keypord'},{text = 'قفل الكيبورد بالكتم', data =UserId..'/'.. 'lock_keypordktm'},
},
{
{text = 'قفل الكيبورد بالطرد', data =UserId..'/'.. 'lock_keypordkick'},{text = 'قفل الكيبورد بالتقييد', data =UserId..'/'.. 'lock_keypordkid'},
},
{
{text = 'فتح الكيبورد', data =UserId..'/'.. 'unlock_keypord'},
},
{
{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id," ❍┃ عليك اختيار نوع القفل او الفتح على امر الكيبورد", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_voice') then
local UserId = Text:match('(%d+)/Status_voice')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الاغاني', data =UserId..'/'.. 'lock_voice'},{text = 'قفل الاغاني بالكتم', data =UserId..'/'.. 'lock_voicektm'},
},
{
{text = 'قفل الاغاني بالطرد', data =UserId..'/'.. 'lock_voicekick'},{text = 'قفل الاغاني بالتقييد', data =UserId..'/'.. 'lock_voicekid'},
},
{
{text = 'فتح الاغاني', data =UserId..'/'.. 'unlock_voice'},
},
{
{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id," ❍┃ عليك اختيار نوع القفل او الفتح على امر الاغاني", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_gif') then
local UserId = Text:match('(%d+)/Status_gif')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل المتحركه', data =UserId..'/'.. 'lock_gif'},{text = 'قفل المتحركه بالكتم', data =UserId..'/'.. 'lock_gifktm'},
},
{
{text = 'قفل المتحركه بالطرد', data =UserId..'/'.. 'lock_gifkick'},{text = 'قفل المتحركه بالتقييد', data =UserId..'/'.. 'lock_gifkid'},
},
{
{text = 'فتح المتحركه', data =UserId..'/'.. 'unlock_gif'},
},
{
{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id," ❍┃ عليك اختيار نوع القفل او الفتح على امر المتحركات", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_files') then
local UserId = Text:match('(%d+)/Status_files')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الملفات', data =UserId..'/'.. 'lock_files'},{text = 'قفل الملفات بالكتم', data =UserId..'/'.. 'lock_filesktm'},
},
{
{text = 'قفل النلفات بالطرد', data =UserId..'/'.. 'lock_fileskick'},{text = 'قفل الملقات بالتقييد', data =UserId..'/'.. 'lock_fileskid'},
},
{
{text = 'فتح الملقات', data =UserId..'/'.. 'unlock_files'},
},
{
{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id," ❍┃ عليك اختيار نوع القفل او الفتح على امر الملفات", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_text') then
local UserId = Text:match('(%d+)/Status_text')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الدردشه', data =UserId..'/'.. 'lock_text'},
},
{
{text = 'فتح الدردشه', data =UserId..'/'.. 'unlock_text'},
},
{
{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id," ❍┃ عليك اختيار نوع القفل او الفتح على امر الدردشه", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_video') then
local UserId = Text:match('(%d+)/Status_video')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الفيديو', data =UserId..'/'.. 'lock_video'},{text = 'قفل الفيديو بالكتم', data =UserId..'/'.. 'lock_videoktm'},
},
{
{text = 'قفل الفيديو بالطرد', data =UserId..'/'.. 'lock_videokick'},{text = 'قفل الفيديو بالتقييد', data =UserId..'/'.. 'lock_videokid'},
},
{
{text = 'فتح الفيديو', data =UserId..'/'.. 'unlock_video'},
},
{
{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id," ❍┃ عليك اختيار نوع القفل او الفتح على امر الفيديو", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_photo') then
local UserId = Text:match('(%d+)/Status_photo')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الصور', data =UserId..'/'.. 'lock_photo'},{text = 'قفل الصور بالكتم', data =UserId..'/'.. 'lock_photoktm'},
},
{
{text = 'قفل الصور بالطرد', data =UserId..'/'.. 'lock_photokick'},{text = 'قفل الصور بالتقييد', data =UserId..'/'.. 'lock_photokid'},
},
{
{text = 'فتح الصور', data =UserId..'/'.. 'unlock_photo'},
},
{
{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id," ❍┃ عليك اختيار نوع القفل او الفتح على امر الصور", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_username') then
local UserId = Text:match('(%d+)/Status_username')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل المعرفات', data =UserId..'/'.. 'lock_username'},{text = 'قفل المعرفات بالكتم', data =UserId..'/'.. 'lock_usernamektm'},
},
{
{text = 'قفل المعرفات بالطرد', data =UserId..'/'.. 'lock_usernamekick'},{text = 'قفل المعرفات بالتقييد', data =UserId..'/'.. 'lock_usernamekid'},
},
{
{text = 'فتح المعرفات', data =UserId..'/'.. 'unlock_username'},
},
{
{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id," ❍┃ عليك اختيار نوع القفل او الفتح على امر المعرفات", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_tags') then
local UserId = Text:match('(%d+)/Status_tags')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل التاك', data =UserId..'/'.. 'lock_tags'},{text = 'قفل التاك بالكتم', data =UserId..'/'.. 'lock_tagsktm'},
},
{
{text = 'قفل التاك بالطرد', data =UserId..'/'.. 'lock_tagskick'},{text = 'قفل التاك بالتقييد', data =UserId..'/'.. 'lock_tagskid'},
},
{
{text = 'فتح التاك', data =UserId..'/'.. 'unlock_tags'},
},
{
{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id," ❍┃ عليك اختيار نوع القفل او الفتح على امر التاك", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_bots') then
local UserId = Text:match('(%d+)/Status_bots')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل البوتات', data =UserId..'/'.. 'lock_bots'},{text = 'قفل البوتات بالطرد', data =UserId..'/'.. 'lock_botskick'},
},
{
{text = 'فتح البوتات', data =UserId..'/'.. 'unlock_bots'},
},
{
{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id," ❍┃ عليك اختيار نوع القفل او الفتح على امر البوتات", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_fwd') then
local UserId = Text:match('(%d+)/Status_fwd')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل التوجيه', data =UserId..'/'.. 'lock_fwd'},{text = 'قفل التوجيه بالكتم', data =UserId..'/'.. 'lock_fwdktm'},
},
{
{text = 'قفل التوجيه بالطرد', data =UserId..'/'.. 'lock_fwdkick'},{text = 'قفل التوجيه بالتقييد', data =UserId..'/'.. 'lock_fwdkid'},
},
{
{text = 'فتح التوجيه', data =UserId..'/'.. 'unlock_link'},
},
{
{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id," ❍┃ عليك اختيار نوع القفل او الفتح على امر التوجيه", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_audio') then
local UserId = Text:match('(%d+)/Status_audio')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الصوت', data =UserId..'/'.. 'lock_audio'},{text = 'قفل الصوت بالكتم', data =UserId..'/'.. 'lock_audioktm'},
},
{
{text = 'قفل الصوت بالطرد', data =UserId..'/'.. 'lock_audiokick'},{text = 'قفل الصوت بالتقييد', data =UserId..'/'.. 'lock_audiokid'},
},
{
{text = 'فتح الصوت', data =UserId..'/'.. 'unlock_audio'},
},
{
{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id," ❍┃ عليك اختيار نوع القفل او الفتح على امر الصوت", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_stikear') then
local UserId = Text:match('(%d+)/Status_stikear')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الملصقات', data =UserId..'/'.. 'lock_stikear'},{text = 'قفل الملصقات بالكتم', data =UserId..'/'.. 'lock_stikearktm'},
},
{
{text = 'قفل الملصقات بالطرد', data =UserId..'/'.. 'lock_stikearkick'},{text = 'قفل الملصقات بالتقييد', data =UserId..'/'.. 'lock_stikearkid'},
},
{
{text = 'فتح الملصقات', data =UserId..'/'.. 'unlock_stikear'},
},
{
{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id," ❍┃ عليك اختيار نوع القفل او الفتح على امر الملصقات", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_phone') then
local UserId = Text:match('(%d+)/Status_phone')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الجهات', data =UserId..'/'.. 'lock_phone'},{text = 'قفل الجهات بالكتم', data =UserId..'/'.. 'lock_phonektm'},
},
{
{text = 'قفل الجهات بالطرد', data =UserId..'/'.. 'lock_phonekick'},{text = 'قفل الجهات بالتقييد', data =UserId..'/'.. 'lock_phonekid'},
},
{
{text = 'فتح الجهات', data =UserId..'/'.. 'unlock_phone'},
},
{
{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id," ❍┃ عليك اختيار نوع القفل او الفتح على امر الجهات", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_joine') then
local UserId = Text:match('(%d+)/Status_joine')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الدخول', data =UserId..'/'.. 'lock_joine'},
},
{
{text = 'فتح الدخول', data =UserId..'/'.. 'unlock_joine'},
},
{
{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id," ❍┃ عليك اختيار نوع القفل او الفتح على امر الدخول", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_addmem') then
local UserId = Text:match('(%d+)/Status_addmem')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الاضافه', data =UserId..'/'.. 'lock_addmem'},
},
{
{text = 'فتح الاضافه', data =UserId..'/'.. 'unlock_addmem'},
},
{
{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id," ❍┃ عليك اختيار نوع القفل او الفتح على امر الاضافه", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_videonote') then
local UserId = Text:match('(%d+)/Status_videonote')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل السيلفي', data =UserId..'/'.. 'lock_videonote'},{text = 'قفل السيلفي بالكتم', data =UserId..'/'.. 'lock_videonotektm'},
},
{
{text = 'قفل السيلفي بالطرد', data =UserId..'/'.. 'lock_videonotekick'},{text = 'قفل السيلفي بالتقييد', data =UserId..'/'.. 'lock_videonotekid'},
},
{
{text = 'فتح السيلفي', data =UserId..'/'.. 'unlock_videonote'},
},
{
{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"* ❍┃ عليك اختيار نوع القفل او الفتح على امر بصمه الفيديو *", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_pin') then
local UserId = Text:match('(%d+)/Status_pin')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل التثبيت', data =UserId..'/'.. 'lock_pin'},
},
{
{text = 'فتح التثبيت', data =UserId..'/'.. 'unlock_pin'},
},
{
{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"* ❍┃ عليك اختيار نوع القفل او الفتح على امر التثبيت *", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_tgservir') then
local UserId = Text:match('(%d+)/Status_tgservir')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الاشعارات', data =UserId..'/'.. 'lock_tgservir'},
},
{
{text = 'فتح الاشعارات', data =UserId..'/'.. 'unlock_tgservir'},
},
{
{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"* ❍┃ عليك اختيار نوع القفل او الفتح على امر الاشعارات *", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_markdaun') then
local UserId = Text:match('(%d+)/Status_markdaun')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الماركداون', data =UserId..'/'.. 'lock_markdaun'},{text = 'قفل الماركداون بالكتم', data =UserId..'/'.. 'lock_markdaunktm'},
},
{
{text = 'قفل الماركداون بالطرد', data =UserId..'/'.. 'lock_markdaunkick'},{text = 'قفل الماركداون بالتقييد', data =UserId..'/'.. 'lock_markdaunkid'},
},
{
{text = 'فتح الماركداون', data =UserId..'/'.. 'unlock_markdaun'},
},
{
{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"* ❍┃ عليك اختيار نوع القفل او الفتح على امر الماركدون *", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_edits') then
local UserId = Text:match('(%d+)/Status_edits')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل التعديل', data =UserId..'/'.. 'lock_edits'},
},
{
{text = 'فتح التعديل', data =UserId..'/'.. 'unlock_edits'},
},
{
{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id," ❍┃ عليك اختيار نوع القفل او الفتح على امر التعديل", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_games') then
local UserId = Text:match('(%d+)/Status_games')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الالعاب', data =UserId..'/'.. 'lock_games'},{text = 'قفل الالعاب بالكتم', data =UserId..'/'.. 'lock_gamesktm'},
},
{
{text = 'قفل الالعاب بالطرد', data =UserId..'/'.. 'lock_gameskick'},{text = 'قفل الالعاب بالتقييد', data =UserId..'/'.. 'lock_gameskid'},
},
{
{text = 'فتح الالعاب', data =UserId..'/'.. 'unlock_games'},
},
{
{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id," ❍┃ عليك اختيار نوع القفل او الفتح على امر الالعاب", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_flood') then
local UserId = Text:match('(%d+)/Status_flood')
if tonumber(IdUser) == tonumber(UserId) then

local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل التكرار', data =UserId..'/'.. 'lock_flood'},{text = 'قفل التكرار بالكتم', data =UserId..'/'.. 'lock_floodktm'},
},
{
{text = 'قفل التكرار بالطرد', data =UserId..'/'.. 'lock_floodkick'},{text = 'قفل التكرار بالتقييد', data =UserId..'/'.. 'lock_floodkid'},
},
{
{text = 'فتح التكرار', data =UserId..'/'.. 'unlock_flood'},
},
{
{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"* ❍┃ عليك اختيار نوع القفل او الفتح على امر التكرار *", 'md', true, false, reply_markup)
end



elseif Text and Text:match('(%d+)/unlock_link') then
local UserId = Text:match('(%d+)/unlock_link')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(MEZO.."MEZO:Lock:Link"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"* ❍┃ تم فتح الروابط *").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_spam') then
local UserId = Text:match('(%d+)/unlock_spam')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(MEZO.."MEZO:Lock:Spam"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"* ❍┃ تم فتح الكلايش *").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_keypord') then
local UserId = Text:match('(%d+)/unlock_keypord')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(MEZO.."MEZO:Lock:Keyboard"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"* ❍┃ تم فتح الكيبورد *").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_voice') then
local UserId = Text:match('(%d+)/unlock_voice')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(MEZO.."MEZO:Lock:vico"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"* ❍┃ تم فتح الاغاني *").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_gif') then
local UserId = Text:match('(%d+)/unlock_gif')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(MEZO.."MEZO:Lock:Animation"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"* ❍┃ تم فتح المتحركات *").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_files') then
local UserId = Text:match('(%d+)/unlock_files')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(MEZO.."MEZO:Lock:Document"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"* ❍┃ تم فتح الملفات *").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_text') then
local UserId = Text:match('(%d+)/unlock_text')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(MEZO.."MEZO:Lock:text"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"* ❍┃ تم فتح الدردشه *").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_video') then
local UserId = Text:match('(%d+)/unlock_video')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(MEZO.."MEZO:Lock:Video"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"* ❍┃ تم فتح الفيديو *").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_photo') then
local UserId = Text:match('(%d+)/unlock_photo')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(MEZO.."MEZO:Lock:Photo"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"* ❍┃ تم فتح الصور *").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_username') then
local UserId = Text:match('(%d+)/unlock_username')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(MEZO.."MEZO:Lock:User:Name"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"* ❍┃ تم فتح المعرفات *").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_tags') then
local UserId = Text:match('(%d+)/unlock_tags')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(MEZO.."MEZO:Lock:hashtak"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"* ❍┃ تم فتح التاك *").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_bots') then
local UserId = Text:match('(%d+)/unlock_bots')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(MEZO.."MEZO:Lock:Bot:kick"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"* ❍┃ تم فتح البوتات *").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_fwd') then
local UserId = Text:match('(%d+)/unlock_fwd')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(MEZO.."MEZO:Lock:forward"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"* ❍┃ تم فتح التوجيه *").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_audio') then
local UserId = Text:match('(%d+)/unlock_audio')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(MEZO.."MEZO:Lock:Audio"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"* ❍┃ تم فتح الصوت *").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_stikear') then
local UserId = Text:match('(%d+)/unlock_stikear')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(MEZO.."MEZO:Lock:Sticker"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"* ❍┃ تم فتح الملصقات *").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_phone') then
local UserId = Text:match('(%d+)/unlock_phone')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(MEZO.."MEZO:Lock:Contact"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"* ❍┃ تم فتح الجهات *").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_joine') then
local UserId = Text:match('(%d+)/unlock_joine')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(MEZO.."MEZO:Lock:Join"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"* ❍┃ تم فتح الدخول *").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_addmem') then
local UserId = Text:match('(%d+)/unlock_addmem')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(MEZO.."MEZO:Lock:AddMempar"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"* ❍┃ تم فتح الاضافه *").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_videonote') then
local UserId = Text:match('(%d+)/unlock_videonote')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(MEZO.."MEZO:Lock:Unsupported"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"* ❍┃ تم فتح بصمه الفيديو *").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_pin') then
local UserId = Text:match('(%d+)/unlock_pin')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(MEZO.."MEZO:lockpin"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"* ❍┃ تم فتح التثبيت *").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_tgservir') then
local UserId = Text:match('(%d+)/unlock_tgservir')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(MEZO.."MEZO:Lock:tagservr"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"* ❍┃ تم فتح الاشعارات *").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_markdaun') then
local UserId = Text:match('(%d+)/unlock_markdaun')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(MEZO.."MEZO:Lock:Markdaun"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"* ❍┃ تم فتح الماركدون *").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_edits') then
local UserId = Text:match('(%d+)/unlock_edits')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(MEZO.."MEZO:Lock:edit"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"* ❍┃ تم فتح التعديل *").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_games') then
local UserId = Text:match('(%d+)/unlock_games')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(MEZO.."MEZO:Lock:geam"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"* ❍┃ تم فتح الالعاب *").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_flood') then
local UserId = Text:match('(%d+)/unlock_flood')
if tonumber(IdUser) == tonumber(UserId) then
Redis:hdel(MEZO.."MEZO:Spam:Group:User"..ChatId ,"Spam:User")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"* ❍┃ تم فتح التكرار *").unLock, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/Developers') then
local UserId = Text:match('(%d+)/Developers')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(MEZO.."MEZO:Developers:Groups") 
LuaTele.editMessageText(ChatId,Msg_id,"* ❍┃ تم مسح مطورين البوت *", 'md', false)
end
elseif Text and Text:match('(%d+)/DevelopersQ') then
local UserId = Text:match('(%d+)/DevelopersQ')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(MEZO.."MEZO:DevelopersQ:Groups") 
LuaTele.editMessageText(ChatId,Msg_id,"* ❍┃ تم مسح مطورين الثانوين من البوت *", 'md', false)
end
elseif Text and Text:match('(%d+)/TheBasics') then
local UserId = Text:match('(%d+)/TheBasics')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(MEZO.."MEZO:TheBasics:Group"..ChatId) 
LuaTele.editMessageText(ChatId,Msg_id,"* ❍┃ تم مسح المنشئين الاساسيين *", 'md', false)
end
elseif Text and Text:match('(%d+)/TheBasicsQ') then
local UserId = Text:match('(%d+)/TheBasicsQ')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(MEZO.."MEZO:TheBasicsQ:Group"..ChatId) 
LuaTele.editMessageText(ChatId,Msg_id,"* ❍┃ تم مسح المالكين *", 'md', false)
end
elseif Text and Text:match('(%d+)/Originators') then
local UserId = Text:match('(%d+)/Originators')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(MEZO.."MEZO:Originators:Group"..ChatId) 
LuaTele.editMessageText(ChatId,Msg_id,"* ❍┃ تم مسح منشئين المجموعه *", 'md', false)
end
elseif Text and Text:match('(%d+)/Managers') then
local UserId = Text:match('(%d+)/Managers')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(MEZO.."MEZO:Managers:Group"..ChatId) 
LuaTele.editMessageText(ChatId,Msg_id,"* ❍┃ تم مسح المدراء *", 'md', false)
end
elseif Text and Text:match('(%d+)/Addictive') then
local UserId = Text:match('(%d+)/Addictive')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(MEZO.."MEZO:Addictive:Group"..ChatId) 
LuaTele.editMessageText(ChatId,Msg_id,"* ❍┃ تم مسح ادمنيه المجموعه *", 'md', false)
end
elseif Text and Text:match('(%d+)/DelDistinguished') then
local UserId = Text:match('(%d+)/DelDistinguished')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(MEZO.."MEZO:Distinguished:Group"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '•✠|𝙱𝙰𝙲𝙺|✠•', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,"* ❍┃ تم مسح المميزين *", 'md', false)
end
elseif Text and Text:match('(%d+)/Redisa') then
local UserId = Text:match('(%d+)/Redisa')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(MEZO.."MEZO:Redisa:Groups") 
LuaTele.editMessageText(ChatId,Msg_id,"* ❍┃ تم مسح المحظورين عام *", 'md', false)
end
elseif Text and Text:match('(%d+)/ktmAll') then
local UserId = Text:match('(%d+)/ktmAll')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(MEZO.."MEZO:ktmAll:Groups") 
LuaTele.editMessageText(ChatId,Msg_id,"* ❍┃ تم مسح المكتومين عام *", 'md', false)
end
elseif Text and Text:match('(%d+)/JabwaGroup') then
local UserId = Text:match('(%d+)/JabwaGroup')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(MEZO.."MEZO:JabwaGroup:Group"..ChatId) 
LuaTele.editMessageText(ChatId,Msg_id,"* ❍┃ تم مسح المحظورين *", 'md', false)
end
elseif Text and Text:match('(%d+)/SilentGroupGroup') then
local UserId = Text:match('(%d+)/SilentGroupGroup')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(MEZO.."MEZO:SilentGroup:Group"..ChatId) 
LuaTele.editMessageText(ChatId,Msg_id,"* ❍┃ تم مسح المكتومين *", 'md', false)
end
end
end
end


luatele.run(CallBackLua)
 






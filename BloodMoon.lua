--init a plugin
--Author Lorain.Li
g_Plugin = nil
function Initialize(a_Plugin)
	a_Plugin:SetName("BloodMoon")
	a_Plugin:SetVersion(1)
	g_Plugin = a_Plugin
	cPluginManager:AddHook(cPluginManager.HOOK_WORLD_TICK, MyOnWorldTick)
	cPluginManager:AddHook(cPluginManager.HOOK_SPAWNED_MONSTER, MyOnSpawnedMonster)
	LOG("BloodMoon v" .. g_Plugin:GetVersion() .. " is loaded")
	return true
end

function OnDisable()
	LOG("BloodMoon v" .. g_Plugin:GetVersion() .. " is disabling")
end

function MyOnWorldTick(a_World, a_TimeDelta)
	if(a_World:GetTimeOfDay() ~= 12000) then
		return false
	else 
		if(math.random() % 100 < 5) then 
			DoBloodMoon(a_World)
		end
	end
end

function DoBloodMoon(a_World)
	a_World:SetWeather(wThunderstorm)
	a_World:ForEachPlayer(
		function (a_Player)
			a_Player:SendMessage("BloodMoon is rising, please be careful!")
			a_Player:SendMessage("BloodMoon is rising, please be careful!")
			a_Player:SendMessage("BloodMoon is rising, please be careful!")
		end
		)
end

tMonster = {mtBlaze, mtCaveSpider, mtCreeper, mtEnderman, mtGiant, mtMagmaCube, mtSkeleton, mtSlime, mtSpider, mtWitch, mtZombie}

function MyOnSpawnedMonster(a_World, a_Monster)
	if(a_World:GetWeather() == wThunderstorm) then
		for i=1,5 do
			a_World:SpawnMob(a_Monster:GetPosX(), a_Monster:GetPosY, a_Monster:GetPosZ, tMonster[math.random() % #Monster], math.random() % 2 == 0)
		end
	end
end
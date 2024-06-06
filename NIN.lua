local profile = {};

local sets = {
    Idle_Priority = {
		Ammo = 'Happy Egg',
        Head = 'Arh. Jinpachi +1',
        Neck = 'Peacock Amulet',
        Ear1 = 'Merman\'s Earring',
        Ear2 = 'Merman\'s Earring',
        Body = 'Arhat\'s Gi +1',
        Hands = 'Dst. Mittens +1',
        Ring1 = 'Bomb Queen Ring',
        Ring2 = 'Merman\'s Ring',
        Back = 'Gigant Mantle',
        Waist = 'Warwolf Belt',
        Legs = 'Dst. Subligar +1',
        Feet = 'Ninja Kyahan',
    },
	
	Resting_Priority = {

	},
		
	TP_Priority = {
		Ammo = 'Bomb Core',
        Head = 'Panther Mask', --2%
        Neck = 'Peacock Amulet',
        Ear1 = 'Brutal Earring',
        Ear2 = 'Stealth Earring',
        Body = 'Haubergeon',
        Hands = 'Dusk Gloves', --3%
        Ring1 = 'Toreador\'s Ring',
        Ring2 = 'Rajas Ring',
        Back = 'Forager\'s Mantle',
        Waist = 'Swift Belt', --4%
        Legs = 'Byakko\'s Haidate', --5%
        Feet = 'Fuma Sune-Ate', --3%
    },
	
	TankingTP_Priority = {
        Head = 'Arh. Jinpachi +1',
        Neck = 'Peacock Amulet',
        Ear1 = 'Novia Earring',
        Ear2 = 'Ethereal Earring',
        Body = 'Scorpion Harness',
        Hands = 'Dusk Gloves',
        Ring1 = 'Toreador\'s Ring',
        Ring2 = 'Rajas Ring',
        Back = 'Gigant Mantle',
        Waist = 'Koga Sarashi',
        Legs = 'Dst. Subligar +1',
        Feet = 'Dst. Leggings +1',
    },
	
	WS_Priority = {
		Ammo = 'Bomb Core',
        Head = 'Shr.Znr.Kabuto',
        Neck = 'Peacock Amulet',
        Ear1 = 'Brutal Earring',
        Ear2 = 'Merman\'s Earring',
        Body = 'Haubergeon',
        Hands = 'Horomusha Kote',
        Ring1 = 'Flame Ring',
        Ring2 = 'Rajas Ring',
        Back = 'Forager\'s Mantle',
        Waist = 'Warwolf Belt',
        Legs = 'Byakko\'s Haidate',
        Feet = 'Luisant Sollerets',
    },
	
	Precast_Priority = {

	},

    SIRD_Priority = {
        Head = 'Panther Mask',
		Body = 'Arhat\'s Gi +1',
		Hands = 'Dusk Gloves',
        Ear1 = 'Novia Earring',
        Ear2 = 'Ethereal Earring',
        Waist = 'Koga Sarashi',
        Legs = 'Byakko\'s Haidate',
		Feet = 'Fuma Sune-Ate',
	},
	
	Nuke_Priority = {
		Ammo = 'Phtm. Tathlum',
		Head = 'Yasha Jinpachi',
		Neck = 'Uggalepih Pendant', --gotta remember to spend down mp
		Body = 'Kirin\'s Osode',
		Hands = 'Koga Tekko',
        Ear1 = 'Moldavite Earring',
        Ear2 = 'Novio Earring',
		Ring1 = 'Snow Ring',
		Ring2 = 'Snow Ring',
        Waist = 'Koga Sarashi',
		Legs = 'Yasha Hakama',
		Feet = 'Ysh. Sune-Ate +1',
	},
	
	Enmity_Priority = {
		Head = 'Arh. Jinpachi +1',
		Neck = 'Harmonia\'s Torque',
		Body = 'Arhat\'s Gi +1',
		Hands = 'Yasha Tekko +1',
		Ear1 = 'Eris\' Earring',
		Ear2 = 'Eris\' Earring',
		Ring1 = 'Mermaid Ring',
		Back = 'Toreador\'s Cape',
		Waist = 'Warwolf Belt',
		Legs = 'Yasha Hakama',
		Feet = 'Ysh. Sune-Ate +1',
	},
	
	Sneak = {
		Feet = 'Dream Boots +1',
    },
	
	Invisible = {
		Hands = 'Dream Mittens +1',
    },
	
	Movement = {
        Feet = 'Ninja Kyahan',
	},
	
    Regen_Priority = {
	
    },
	
};

profile.Sets = sets;

profile.OnLoad = function()
	gSettings.AllowAddSet = true
	
	local player = gData.GetPlayer();
    AshitaCore:GetChatManager():QueueCommand(1, '/macro book 5');
    AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1');
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /nin /lac fwd');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind F9 /nin tankingMode');
end

profile.OnUnload = function()
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias delete /nin /lac fwd');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind F9');
end

local Settings = {
	player = gData.GetPlayer(),
	tankingMode = 1,
	CurrentLevel = 0,
};


profile.HandleCommand = function(args)

	--Tanking Mode Toggle
    if (args[1] == 'tankingMode') then
        if (Settings.tankingMode == 1) then
            gFunc.Echo(158, "Tanking Mode OFF")
            Settings.tankingMode = 0
        else
            gFunc.Echo(158, "Tanking Mode ON")
            Settings.tankingMode = 1
        end
    end	
	
end

profile.HandleDefault = function()
	local player = gData.GetPlayer();
	local myLevel = AshitaCore:GetMemoryManager():GetPlayer():GetMainJobLevel();
    if (myLevel ~= Settings.CurrentLevel) then
        gFunc.EvaluateLevels(profile.Sets, myLevel);
        Settings.CurrentLevel = myLevel;
    end

	
	--Level Sync handler
	local myLevel = player.MainJobSync;
    if (myLevel ~= Settings.CurrentLevel) then
        gFunc.EvaluateLevels(sets, myLevel);
        Settings.CurrentLevel = myLevel;
    end	

	--Gear change setups
    if player.Status == 'Engaged' then
        if (Settings.tankingMode == 1) then
			gFunc.EquipSet(sets.TankingTP);
		elseif (Settings.tankingMode == 0) then
			gFunc.EquipSet(sets.TP);
		end
    elseif (player.Status == 'Resting') then
        gFunc.EquipSet(sets.Resting);
	elseif (player.HPP < 100) then
		gFunc.EquipSet(gFunc.Combine(sets.Idle,sets.Regen));
	else
		gFunc.EquipSet(sets.Idle);
    end
	
	if (player.IsMoving == true) then
		gFunc.EquipSet(sets.Movement);
	end
	
	if (player.SubJob == 'WHM') or (player.SubJob == 'RDM') then
		if (player.MPP < 100 ) then
			gFunc.Equip('Ear2', 'Ethereal Earring');	
		end
	end
	
end

profile.HandleAbility = function()
	local ability = gData.GetAction();

    if (ability.Name == 'Provoke') then
        gFunc.EquipSet(sets.Enmity);
	elseif (ability.Name == 'Yonin') then
        gFunc.EquipSet(sets.Enmity);
	-- elseif (ability.Name == 'Jump') then
        -- gFunc.EquipSet(sets.Jump);
	-- elseif (ability.Name == 'Spirit Link') then
        -- gFunc.EquipSet(sets.SpiritLink);
	-- elseif (ability.Name == 'High Jump') then
        -- gFunc.EquipSet(sets.HighJump);
	-- elseif (ability.Name == 'Steady Wing') then
        -- gFunc.EquipSet(sets.SteadyWing);
	-- elseif (ability.Name == 'Angon') then
        -- gFunc.EquipSet(sets.Angon);
    end
	
end

profile.HandleItem = function()
    local item = gData.GetAction();

	if string.match(item.Name, 'Silent Oil') then 
		gFunc.EquipSet(sets.Sneak);
	elseif string.match(item.Name, 'Prism Powder') then 
		gFunc.EquipSet(sets.Invisible);
	end
end

profile.HandlePrecast = function()
    local spell = gData.GetAction();
    
	gFunc.EquipSet(sets.Precast);
	
end

profile.HandleMidcast = function()
    local spell = gData.GetAction();
	local target = gData.GetActionTarget();
    local me = gData.GetPlayer().Name
	local NinNukes = T{'Katon: Ichi', 'Katon: Ni', 'Hyoton: Ichi', 'Hyoton: Ni', 'Huton: Ichi', 'Huton: Ni', 'Doton: Ichi', 'Doton: Ni', 'Raiton: Ichi', 'Raiton: Ni', 'Suiton: Ichi', 'Suiton: Ni'}

    if spell.Skill == 'Ninjutsu' then
		--add complexity
        if (NinNukes:contains(spell.Name)) then
            gFunc.EquipSet(sets.Nuke);
		elseif string.match(spell.Name, 'Monomi: Ichi') and (target.Name == me) then
            gFunc.EquipSet(sets.Sneak)
		elseif string.match(spell.Name, 'Tonko: Ichi') and (target.Name == me) then
            gFunc.EquipSet(sets.Invisible);
		else
			gFunc.EquipSet(sets.SIRD);
        end
	elseif spell.Skill == 'Enhancing Magic' then
		if string.match(spell.Name, 'Sneak') and (target.Name == me) then
		    gFunc.EquipSet(sets.Sneak);
		elseif string.match(spell.Name, 'Invisible') and (target.Name == me) then
            gFunc.EquipSet(sets.Invisible);
		else 
			gFunc.EquipSet(sets.SIRD);
        end
	else
		gFunc.EquipSet(sets.SIRD);
    end
	
end

profile.HandlePreshot = function() 

end

profile.HandleMidshot = function()

end

profile.HandleWeaponskill = function()
	local ws = gData.GetAction();
    
    -- if (ws.Name == "Wheeling Thrust") then
		-- gFunc.EquipSet(sets.Wheeling)
	-- elseif (ws.Name == "Impulse Drive") then
		-- gFunc.EquipSet(sets.Impulse)
	-- else
		gFunc.EquipSet(sets.WS)
	-- end
	
end

return profile;
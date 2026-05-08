# Functions

Catalog of TES Script (Morrowind) built-in functions extracted from "Morrowind Scripting For Dummies 9.0", pp. 35–159.

Notation:
- `[fix: yes]`     — function supports/expects `Object->Function` (target) syntax
- `[fix: no]`      — `[no fix]` in the PDF — global/PC-only, cannot be targeted via `->`
- `[fix: optional]`— works either as global or `Object->Function`
- `(local var)`    — actually a special local short variable, not a function call (but written like one)
- `(global var)`   — special global variable
- `(dialog)`       — only callable in dialogue speaker conditions, not in scripts
- Names are written in canonical case as they appear in the PDF.

## Working with inventory items

- **AddItem** "ObjectID", count — add item(s) to the calling actor/container inventory [fix: yes]
- **RemoveItem** "ObjectID", count — remove item(s) from inventory [fix: yes]
- **Drop** "ObjectID", count — drop item from inventory to the ground [fix: yes]
- **OnPCAdd** (local short var) — set to 1 when PC adds the calling object [fix: no]
- **OnPCDrop** (local short var) — set to 1 when PC drops the calling object [fix: no]
- **OnPCSoulGemUse** (local short var) — set to 1 when PC uses calling soulgem [fix: no]
- **Equip** "ObjectID" [count] — force-equip item on the actor [fix: yes]
- **OnPCEquip** (local short var) — set to 1 while PC equips calling item [fix: no]
- **PCSkipEquip** (local short var) — when 1, blocks equipping of calling item [fix: no]
- **GetItemCount** "ObjectID" — number of items of given ID in inventory; returns short [fix: yes]
- **OnPCRepair** (local short var) — set to 1 when PC repairs the calling object [fix: no]
- **RepairedOnMe** "ObjectID" — true if calling item is repaired by item of given ID; returns short [fix: yes]
- **OnRepair** — broken; intended to flag any repair attempt [fix: yes]
- **GetWeaponType** — returns weapon type of equipped weapon (-1..13); returns short [fix: yes]
- **GetArmorType** armorPart — returns armor weight class for given slot; returns short [fix: yes]
- **HasItemEquipped** "item_ID" — 1 if actor has the given item equipped; returns short [fix: yes]
- **UsedOnMe** "ObjectID" — broken; true if given item was used on calling object; returns short [fix: yes]

## Moving and placing objects

- **Move** axis, units/sec — move along object's local axis [fix: yes]
- **MoveWorld** axis, units/sec — move along world axis [fix: yes]
- **CellUpdate** — broken; was meant to refresh object's cell tracking [fix: yes]
- **SetPos** axis, value — set position along axis (also works on actors) [fix: yes]
- **SetAtStart** — reset object to its editor-defined starting position [fix: yes]
- **PlaceAtPC** "ObjectID", count, distance, direction — place new ref near the player [fix: no]
- **PlaceAtMe** "ItemID", count, distance, direction — place new ref near calling object [fix: yes]
- **PlaceItem** "ObjectID", X, Y, Z, ZRot — place new ref at world coords in current cell [fix: no]
- **PlaceItemCell** "ObjectID", "cellID", X, Y, Z, ZRot — place new ref in named cell [fix: no]
- **Position** X, Y, Z, ZRot — teleport calling object to outdoor coords [fix: yes]
- **PositionCell** X, Y, Z, ZRot, "cellID" — teleport calling object to coords in named cell [fix: yes]
- **Rotate** axis, angle/sec — rotate around local axis (speed) [fix: yes]
- **RotateWorld** axis, angle/sec — rotate around world axis (speed) [fix: yes]
- **SetAngle** axis, degrees — set absolute world angle on axis [fix: yes]
- **GetAngle** axis — get current world angle on axis; returns float [fix: yes]
- **GetPos** axis — get current world position on axis; returns float [fix: yes]
- **GetStartingAngle** axis — editor-original angle on axis; returns float [fix: yes]
- **GetStartingPos** axis — editor-original position on axis; returns float [fix: yes] (used in samples)

## Scale

- **GetScale** — returns float, current scale [fix: yes]
- **SetScale** newScale — set scale (0..10) [fix: yes]
- **ModScale** delta — modify scale by delta [fix: yes]

## Location, distance, cell tracking

- **GetInterior** — 1 if PC is in an interior cell; returns short [fix: no]
- **GetPCCell** "Cell_ID" — 1 if player is in (partially-matching) cell; returns short [fix: no]
- **GetDistance** "ObjectID" — distance in units between calling object and named object; returns float [fix: yes]
- **GetLOS** "ObjectID" — 1 if calling actor has line-of-sight to target; returns short [fix: yes]
- **GetLineOfSight** — undocumented alias of GetLOS; returns short [fix: yes]
- **GetDetected** "ActorID" — 1 if the actor can detect target; returns short [fix: no]
- **CellChanged** — 1 for one frame when PC enters new cell; returns short [fix: no]
- **GetPCTraveling** — 1 if PC is on a transport (silt strider/boat); returns short [fix: no]
- **GetStandingPC** — 1 if PC is standing on calling object; returns short [fix: yes]
- **GetStandingActor** — 1 if any actor stands on calling object; returns short [fix: yes]
- **HurtStandingActor** float_HP/s — damage actors standing on calling object [fix: yes]
- **GetCollidingPC** — 1 if PC currently colliding with calling object; returns short [fix: yes]
- **GetCollidingActor** — 1 if any non-PC actor colliding with calling object; returns short [fix: yes]
- **HurtCollidingActor** damage — damage colliding actors [fix: yes]
- **GetWaterLevel** — water level of current interior cell; returns float [fix: no]
- **SetWaterLevel** newLevel — set water level (interiors only) [fix: no]
- **ModWaterLevel** delta — change water level by delta [fix: no]

## Activation

- **OnActivate** — 1 for one frame when activated [fix: yes]
- **Activate** — perform standard action of calling object (or activate PC remotely with `Activate, player`) [fix: yes]

## Locks

- **Lock** lockLevel — lock door/container at given level (0–100) [fix: yes]
- **Unlock** — remove any lock [fix: yes]
- **GetLocked** — 1 if calling object is locked; returns short [fix: yes]

## Animation

- **PlayGroup** GroupName, [Flags] — play named animation group [fix: yes]
- **LoopGroup** GroupName, count, [Flags] — loop animation group N times [fix: yes]
- **SkipAnim** — suppress current animation for one frame [fix: yes]

## Enable / Disable / Delete

- **Enable** — make calling object visible & active [fix: yes]
- **Disable** — make calling object invisible & inactive [fix: yes]
- **GetDisabled** — 1 if disabled; returns short [fix: yes]
- **SetDelete** flag — mark/unmark reference for deletion (use with Disable) [fix: no]
- **DontSaveObject** — exclude object's modifications from savegame [fix: yes]
- **FixMe** — reload current cell to refresh collision after disable/enable [fix: yes]

## NPC AI and movement

- **AITravel** X, Y, Z, [reset] — make NPC walk to coords [fix: yes]
- **GetAIPackageDone** — 1 for one frame when current AI package finishes; returns short [fix: yes]
- **Face** x, y — turn actor to face coords [fix: yes]
- **AIWander** range, duration, time, [idle1..idle9], [reset] — random wander; idleN are chances [fix: yes]
- **AIActivate** "ObjectID", [reset] — make NPC activate object [fix: yes]
- **AIFollow** "ActorID", duration, X, Y, Z, [reset] — follow target [fix: yes]
- **AIFollowCell** "ActorID", "CellID", duration, X, Y, Z, [reset] — follow into specific cell [fix: yes]
- **AIEscort** "ActorID", duration, X, Y, Z, [reset] — escort target to coords [fix: yes]
- **AIEscortCell** "ActorID", "CellID", duration, X, Y, Z, [reset] — escort into named cell [fix: yes]
- **GetCurrentAIPackage** — current AI package (-1..5); returns short [fix: yes]
- **ForceSneak** — force calling actor into sneak mode [fix: yes]
- **ClearForceSneak** — cancel forced sneak [fix: yes]
- **GetForceSneak** — 1 if forced sneak active; returns short [fix: yes]
- **ForceRun** — force the actor to always run when moving [fix: yes]
- **ClearForceRun** — cancel forced run [fix: yes]
- **GetForceRun** — 1 if forced run active; returns short [fix: yes]
- **ForceJump** — force the actor to constantly jump [fix: yes]
- **ClearForceJump** — cancel [fix: yes]
- **GetForceJump** — returns short [fix: yes]
- **ForceMoveJump** — force jump while moving [fix: yes]
- **ClearForceMoveJump** — cancel [fix: yes]
- **GetForceMoveJump** — returns short [fix: yes]
- **GetPCSneaking** — 1 if PC is sneaking; returns short [fix: no]
- **GetPCRunning** — 1 if PC is running; returns short [fix: no]
- **GetPCJumping** — 1 if PC is jumping; returns short [fix: no]
- **GetWeaponDrawn** — 1 if actor's weapon is out; returns short [fix: yes]
- **GetSpellReadied** — 1 if actor has a spell readied; returns short [fix: yes]
- **Fall** — apply a downward nudge to actor (also for flying creatures) [fix: yes]

## Companions (Tribunal/Bloodmoon)

- **companion** (local short var) — set to 1 to enable equipment-share [fix: no]
- **minimumprofit** (local float var) — tracks mercenary profit margin [fix: no]
- **StayOutside** (local short var) — 1 makes companion wait outside interiors [fix: no]

## Race, faction, rank

- **GetRace** "RaceID" — 1 if calling object is given race; returns short [fix: yes]
- **GetPCRank** "FactionID" — PC's rank in given faction (or NPC's if omitted); returns short [fix: no]
- **GetPCFacRep** ["FactionID"] — broken; was meant to return PC faction rep; returns short [fix: no]
- **SameFaction** — 1 if PC shares faction with calling NPC; returns short [fix: yes]
- **PCExpelled** ["factionID"] — 1 if PC is expelled from faction; returns short [fix: yes]
- **PCJoinFaction** ["FactionID"] — make PC member of faction [fix: no]
- **LowerRank** ["FactionID"] — lower calling NPC's rank [fix: yes]
- **RaiseRank** ["FactionID"] — raise calling NPC's rank [fix: yes]
- **PCLowerRank** ["FactionID"] — lower PC's rank in NPC's faction [fix: no]
- **PCRaiseRank** ["FactionID"] — raise PC's rank in NPC's faction [fix: no]
- **PCExpell** ["FactionID"] — expel PC from NPC's faction (note PDF's spelling) [fix: no]
- **PCClearExpelled** ["FactionID"] — clear expelled flag [fix: no]
- **ModPCFacRep** value, ["FactionID"] — modify PC's reputation modifier with faction [fix: no]
- **SetPCFacRep** value, ["FactionID"] — set PC's reputation modifier with faction [fix: no]
- **ModFactionReaction** "factionID1", "factionID2", value — modify inter-faction reaction [fix: yes]
- **SetFactionReaction** "factionID1", "factionID2", value — set inter-faction reaction [fix: yes]
- **GetReputation** / **ModReputation** / **SetReputation** [value] — actor reputation [fix: yes]
- **GetDisposition** / **ModDisposition** / **SetDisposition** [value] — NPC disposition [fix: yes]

## Werewolf (Bloodmoon)

- **SetWerewolfAcrobatics** — switch actor's stats to werewolf profile [fix: yes]
- **TurnMoonWhite** — recolor Secunda to white [fix: no]
- **TurnMoonRed** — recolor Secunda to red [fix: no]
- **GetWerewolfKills** — kills made while werewolf; returns short [fix: no]
- **IsWerewolf** — 1 if target is in werewolf form [fix: yes]
- **BecomeWerewolf** — change target into werewolf form [fix: yes]
- **UndoWerewolf** — revert target to human form [fix: yes]
- **PCKnownWerewolf** (global short var) — flag if PC is a known werewolf [fix: no]
- **PCWerewolf** (global short var) — -1/0/1 werewolf state of PC [fix: no]
- **WerewolfClawMult** (global float var) — claw damage multiplier [fix: no]
- **AllowWerewolfForceGreeting** (local short var) — allows ForceGreeting on werewolf PC [fix: no]

## Text and dialogue

- **MessageBox** "Message", [var1], [var2], ["button1"], ["button2"] — display message/prompt [fix: no]
- **GetButtonPressed** — index of pressed button (-1 until press); returns short [fix: no]
- **AddTopic** "Topic" — add topic to player's known topics [fix: no]
- **ForceGreeting** — open dialogue with calling actor immediately [fix: yes]
- **Goodbye** — force end of dialogue (used in dialog result fields) [fix: no]
- **Choice** "choice 1", choice1_enum, ["choice 2", choice2_enum, ...] — dialogue branching [fix: no]
- **Journal** "Journal_ID", index — add journal entry [fix: no]
- **SetJournalIndex** "Journal_ID", index — set journal index without entry text [fix: no]
- **GetJournalIndex** "JournalID" — current journal index for topic; returns short [fix: no]
- **ClearInfoActor** — suppress current dialogue line from journal Topics [fix: no]
- **Say** "filename", "text" — make object play voice file with subtitle [fix: yes]
- **SayDone** — 1 if calling object is not currently saying something; returns short [fix: yes]
- **GetHello** / **ModHello** / **SetHello** [value] — actor's hello distance setting [fix: yes]

### Dialogue-only conditions (not callable from scripts)

- **PC Sex** (dialog) — 0 male, 1 female
- **Talked to PC** (dialog) — 1 if speaker has spoken with PC
- **Rank Requirement** (dialog) — 0..3 qualification flag for next rank
- **PC Clothing Modifier** (dialog) — total worn equipment value
- **Friend Hit** (dialog) — count of times PC hit a friend
- **Nolore**, **NoIdle**, **NoFlee**, **NoHello** (local short vars) — block specific NPC speech

## Stats: attributes / skills / health / mana

Generic family — use **Get/Mod/SetXxx** form. Each entry below has all three of Get/Mod/Set unless noted.

### Attributes

- **GetStrength**, **ModStrength**, **SetStrength** — Strength [fix: yes]
- **GetIntelligence**, **ModIntelligence**, **SetIntelligence** [fix: yes]
- **GetWillpower**, **ModWillpower**, **SetWillpower** [fix: yes]
- **GetAgility**, **ModAgility**, **SetAgility** [fix: yes]
- **GetSpeed**, **ModSpeed**, **SetSpeed** [fix: yes]
- **GetEndurance**, **ModEndurance**, **SetEndurance** [fix: yes]
- **GetPersonality**, **ModPersonality**, **SetPersonality** [fix: yes]
- **GetLuck**, **ModLuck**, **SetLuck** [fix: yes]

### Vitals

- **GetHealth**, **ModHealth**, **SetHealth** [fix: yes]
- **GetMagicka**, **ModMagicka**, **SetMagicka** [fix: yes]
- **GetFatigue**, **ModFatigue**, **SetFatigue** [fix: yes]
- **ModCurrentHealth** delta — modify current HP only (no max change) [fix: yes]
- **ModCurrentMagicka** delta [fix: yes]
- **ModCurrentFatigue** delta [fix: yes]
- **GetHealthGetRatio** — current/max HP ratio (0..1); returns float [fix: yes]

### Skills

- **GetBlock**, **ModBlock**, **SetBlock** [fix: yes]
- **GetArmorer**, **ModArmorer**, **SetArmorer** [fix: yes]
- **GetMediumArmor**, **ModMediumArmor**, **SetMediumArmor** [fix: yes]
- **GetHeavyArmor**, **ModHeavyArmor**, **SetHeavyArmor** [fix: yes]
- **GetBluntWeapon**, **ModBluntWeapon**, **SetBluntWeapon** [fix: yes]
- **GetLongBlade**, **ModLongBlade**, **SetLongBlade** [fix: yes]
- **GetAxe**, **ModAxe**, **SetAxe** [fix: yes]
- **GetSpear**, **ModSpear**, **SetSpear** [fix: yes]
- **GetAthletics**, **ModAthletics**, **SetAthletics** [fix: yes]
- **GetEnchant**, **ModEnchant**, **SetEnchant** [fix: yes]
- **GetDestruction**, **ModDestruction**, **SetDestruction** [fix: yes]
- **GetAlteration**, **ModAlteration**, **SetAlteration** [fix: yes]
- **GetIllusion**, **ModIllusion**, **SetIllusion** [fix: yes]
- **GetConjuration**, **ModConjuration**, **SetConjuration** [fix: yes]
- **GetMysticism**, **ModMysticism**, **SetMysticism** [fix: yes]
- **GetRestoration**, **ModRestoration**, **SetRestoration** [fix: yes]
- **GetAlchemy**, **ModAlchemy**, **SetAlchemy** [fix: yes]
- **GetUnarmored**, **ModUnarmored**, **SetUnarmored** [fix: yes]
- **GetSecurity**, **ModSecurity**, **SetSecurity** [fix: yes]
- **GetSneak**, **ModSneak**, **SetSneak** [fix: yes]
- **GetAcrobatics**, **ModAcrobatics**, **SetAcrobatics** [fix: yes]
- **GetLightArmor**, **ModLightArmor**, **SetLightArmor** [fix: yes]
- **GetShortBlade**, **ModShortBlade**, **SetShortBlade** [fix: yes]
- **GetMarksman**, **ModMarksman**, **SetMarksman** [fix: yes]
- **GetMercantile**, **ModMercantile**, **SetMercantile** [fix: yes]
- **GetSpeechcraft**, **ModSpeechcraft**, **SetSpeechcraft** [fix: yes]
- **GetHandToHand**, **ModHandToHand**, **SetHandToHand** [fix: yes]

### Level

- **GetLevel**, **ModLevel**, **SetLevel** — actor level (Set only, no auto-leveling effects) [fix: yes]

## Combat

- **StartCombat** "ActorID" — make calling actor attack target [fix: yes]
- **StopCombat** — stop combat for all actors involved [fix: yes]
- **OnPCHitMe** (local short var) — set to 1 when PC hits/crime against calling actor [fix: no]
- **GetAttacked** — 1 if actor has ever been attacked; returns short [fix: yes]
- **GetTarget** "ActorID" — 1 if target is in actor's focus/crosshair; returns short [fix: yes]
- **HitOnMe** "Weapon ID" — true 1 frame if hit by given weapon; returns short [fix: yes]
- **HitAttemptOnMe** "Weapon ID" — true if hit attempted with weapon; returns short [fix: yes]
- **GetFight**, **ModFight**, **SetFight** — actor's fight AI value [fix: yes]
- **GetFlee**, **ModFlee**, **SetFlee** — actor's flee AI value [fix: yes]
- **GetAlarm**, **ModAlarm**, **SetAlarm** — actor's alarm AI value [fix: yes]
- **OnDeath** — 1 for one frame when actor dies; returns short [fix: yes]
- **OnMurder** — 1 for one frame when actor is murdered (and seen); returns short [fix: yes]
- **OnKnockout** — 1 for one frame when actor is knocked unconscious; returns short [fix: yes]
- **GetDeadCount** "ActorID" — number of references of given ID killed; returns short [fix: no]
- **Resurrect** — bring dead actor back to life [fix: yes]

## Crime

- **GetPCCrimeLevel**, **ModPCCrimeLevel**, **SetPCCrimeLevel** — PC's bounty (PC only) [fix: no]
- **GoToJail** — send PC to nearest prison [fix: no]
- **PayFine** — clear PC's bounty and remove stolen items [fix: no]
- **PayFineThief** — clear PC's bounty without removing stolen items [fix: no]
- **GetPCInJail** — 1 if PC is in jail; returns short [fix: no]

## Magic

- **DisableTeleporting** — block teleport magic effects [fix: no]
- **EnableTeleporting** — re-enable teleport magic effects [fix: no]
- **EnableLevitation** — re-enable levitation [fix: no]
- **DisableLevitation** — disable levitation [fix: no]
- **HasSoulGem** "CreatureID" — 1 if PC has soulgem with given soul; returns short [fix: yes]
- **RemoveSoulGem** "CreatureID", count — remove soulgem with given soul from inventory [fix: yes]
- **AddSoulGem** "creatureID", "soulgemID" — add soulgem with given soul [fix: yes] (used `Player->` style optional)
- **DropSoulGem** "CreatureID" — broken (crashes); intended to drop soulgem [fix: yes]
- **AddSpell** "SpellID" — add spell/effect to actor [fix: yes]
- **RemoveSpell** "SpellID" — remove spell/effect from actor [fix: yes]
- **Cast** SpellID, "TargetID" — cast spell on target (Spell ID literal, target string) [fix: yes]
- **ExplodeSpell** "spellName" — make calling object cast a touch spell at itself [fix: yes]
- **GetSpell** "Spell_ID" — 1 if actor has spell in list; returns short [fix: yes]
- **GetSpellEffects** "Spell_ID" — 1 if Spell_ID is currently affecting actor; returns short [fix: yes]
- **RemoveSpellEffects** "Spell_ID" — remove active effects of given spell [fix: yes]
- **GetEffect** Effect_ID — 1 if actor is being affected by effect; returns short [fix: yes]
- **RemoveEffects** Effect_ID — remove all spells containing the given effect [fix: yes]
- **GetBlightDisease** — 1 if actor has blight; returns short [fix: yes]
- **GetCommonDisease** — 1 if actor has common disease; returns short [fix: yes]
- **GetResistMagicka**, **ModResistMagicka**, **SetResistMagicka** [fix: yes]
- **GetResistFire**, **ModResistFire**, **SetResistFire** [fix: yes]
- **GetResistFrost**, **ModResistFrost**, **SetResistFrost** [fix: yes]
- **GetResistShock**, **ModResistShock**, **SetResistShock** [fix: yes]
- **GetResistDisease**, **ModResistDisease**, **SetResistDisease** [fix: yes]
- **GetResistBlight**, **ModResistBlight**, **SetResistBlight** [fix: yes]
- **GetResistCorprus**, **ModResistCorprus**, **SetResistCorprus** [fix: yes]
- **GetResistPoison**, **ModResistPoison**, **SetResistPoison** [fix: yes]
- **GetResistParalysis**, **ModResistParalysis**, **SetResistParalysis** [fix: yes]
- **GetResistNormalWeapons**, **ModResistNormalWeapons**, **SetResistNormalWeapons** [fix: yes]
- **GetWaterBreathing**, **ModWaterBreathing**, **SetWaterBreathing** [fix: yes]
- **GetChameleon**, **ModChameleon**, **SetChameleon** [fix: yes]
- **GetWaterWalking**, **ModWaterWalking**, **SetWaterWalking** [fix: yes]
- **GetSwimSpeed**, **ModSwimSpeed**, **SetSwimSpeed** [fix: yes]
- **GetSuperJump**, **ModSuperJump**, **SetSuperJump** [fix: yes]
- **GetFlying**, **ModFlying**, **SetFlying** [fix: yes]
- **GetArmorBonus**, **ModArmorBonus**, **SetArmorBonus** [fix: yes]
- **GetCastPenalty**, **ModCastPenalty**, **SetCastPenalty** [fix: yes]
- **GetSilence**, **ModSilence**, **SetSilence** [fix: yes]
- **GetBlindness**, **ModBlindness**, **SetBlindness** [fix: yes]
- **GetParalysis**, **ModParalysis**, **SetParalysis** — paralysis is reference-counted [fix: yes]
- **GetInvisibile**, **ModInvisibile**, **SetInvisibile** — original misspelled form [fix: yes]
- **GetInvisible**, **ModInvisible**, **SetInvisible** — corrected form (later patches) [fix: yes]
- **GetAttackBonus**, **ModAttackBonus**, **SetAttackBonus** [fix: yes]
- **GetDefendBonus**, **ModDefendBonus**, **SetDefendBonus** — sanctuary effect [fix: yes]

## Sound and music

- **StreamMusic** "filename.ext" — play file (mp3/MIDI) as current music [fix: no]
- **PlaySound** "sound ID" — play UI/full-volume sound [fix: no]
- **PlaySoundVP** "sound ID", volume, pitch — sound with volume/pitch [fix: no]
- **PlaySound3D** "sound ID" — directional 3D sound from calling object [fix: yes]
- **PlaySound3DVP** "sound ID", volume, pitch — 3D sound with volume/pitch [fix: yes]
- **PlayLoopSound3D** "sound ID" — looped 3D sound [fix: yes] (used in samples)
- **PlayLoopSound3DVP** "sound ID", volume, pitch — looped 3D sound with V/P [fix: yes]
- **StopSound** "Sound ID" — stop given sound on calling object [fix: yes]
- **GetSoundPlaying** "sound ID" — 1 if sound currently playing on object; returns short [fix: yes]

## Time

- **GetSecondsPasssed** — seconds since last frame; returns float [fix: no] (note: PDF spells `GetSecondsPassed`)
- **GetSecondsPassed** — canonical name; returns float [fix: no]
- **GetCurrentTime** — current in-game hour (0..24); returns float [fix: no]
- **GameHour** (global float var) — current in-game hour
- **Day** (global short var) — current day-of-month
- **Month** (global short var) — current month index
- **Year** (global short var) — current year
- **DaysPassed** (global short var) — days since game start (must be declared in your mod for non-Tribunal)
- **GetMasserPhase** — phase of Masser (0..4); returns short [fix: no]
- **GetSecundaPhase** — phase of Secunda (0..4); returns short [fix: no]

## Weather

- **ChangeWeather** "RegionID", typeEnum — force weather in region [fix: no]
- **ModRegion** "RegionID", clear, [cloudy], [foggy], [overcast], [rain], [thunder], [ash], [blight], [snow], [blizzard] — set weather chances [fix: no]
- **GetCurrentWeather** — current weather typeEnum; returns short [fix: no]
- **GetWindSpeed** — wind speed (0 indoors); returns float [fix: no]

## Sleep / rest

- **ShowRestMenu** — open rest menu (allow sleep) [fix: no]
- **GetPCSleep** — 1 if PC is sleeping; returns short [fix: no]
- **WakeUpPC** — make PC wake up early [fix: no]

## Player control / interface

- **DisablePlayerControls** — disable most player input [fix: no]
- **DisablePlayerFighting** — disable melee/ranged use [fix: no]
- **DisablePlayerMagic** — disable spellcasting [fix: no]
- **DisablePlayerJumping** [fix: no]
- **DisablePlayerLooking** [fix: no]
- **DisablePlayerViewSwitch** [fix: no]
- **DisableVanityMode** [fix: no]
- **EnablePlayerControls** [fix: no]
- **EnablePlayerJumping** [fix: no]
- **EnablePlayerFighting** [fix: no]
- **EnablePlayerLooking** [fix: no]
- **EnablePlayerMagic** [fix: no]
- **EnablePlayerViewSwitch** [fix: no]
- **EnableRest** [fix: no]
- **EnableVanityMode** [fix: no]
- **EnableLevelUpMenu** — show level-up menu [fix: no]
- **GetPlayerControlsDisabled** — 1 if disabled; returns short [fix: no]
- **GetPlayerFightingDisabled** — returns short [fix: no]
- **GetPlayerJumpingDisabled** — returns short [fix: no]
- **GetPlayerMagicDisabled** — returns short [fix: no]
- **GetPlayerLookingDisabled** — returns short [fix: no]
- **GetPlayerViewSwitch** — broken; should report disabled state [fix: no]
- **GetVanityModeDisabled** — returns short [fix: no]
- **PCGet3rdPerson** — 1 if PC in 3rd-person view; returns short [fix: no]
- **PCForce3rdPerson** — force 3rd-person view [fix: no]
- **PCForce1stPerson** — force 1st-person view [fix: no]

### CharGen / in-game menus

- **EnableBirthMenu** [fix: no]
- **EnableClassMenu** [fix: no]
- **EnableRaceMenu** [fix: no]
- **EnableNameMenu** [fix: no]
- **EnableMagicMenu** [fix: no]
- **EnableMapMenu** [fix: no]
- **EnableInventoryMenu** [fix: no]
- **EnableStatsMenu** [fix: no]
- **MenuMode** — 1 if any menu/dialog is open; returns short [fix: no]
- **MenuTest** [, short_enum] — open/close certain menus (0=close, 3=stats, 4=inventory, 5=spell, 6=map) [fix: no]

## Miscellaneous

- **Return** — finish processing this frame, restart from top next frame [fix: no]
- **StartScript** "ScriptName" — start a global/targeted script [fix: optional] (`Object->StartScript` for targeted)
- **StopScript** "ScriptName" — stop a running global/targeted script [fix: optional]
- **ScriptRunning** "ScriptName" — 1 if named script is running; returns short [fix: no]
- **FadeIn** seconds — fade screen from black [fix: no]
- **FadeOut** seconds — fade screen to black [fix: no]
- **FadeTo** alpha, seconds — fade to specific brightness [fix: no]
- **ShowMap** "cellID" — reveal cell(s) on world map; partial-match supported [fix: no]
- **Random** maxValue — random short 0..maxValue-1 [fix: no]
- **Random100** (global short var) — random 0..100 each frame
- **PlayBink** "filename" flag — pause game, play Bink video; flag toggles escape [fix: no]
- **AddToLevCreature** "levcreaname", "creature_ID", level — add pair to leveled creature list [fix: no]
- **AddToLevItem** "levitemname", "item_Id", level — add pair to leveled item list [fix: no]
- **RemoveFromLevCreature** "levcreaname", "creature_ID", level — remove pair (use level=-1 to wipe) [fix: no]
- **RemoveFromLevItem** "levitemname", "item_ID", level — remove pair from leveled item list [fix: no]
- **GetSquareRoot** number — square root of number; returns float [fix: no]

## Crime / cleansing globals (referenced by name)

These are predeclared global short variables used by Bethesda's crime system:
- **CrimeGoldDiscount** — gold needed for thieves-guild discounted fine
- **CrimeGoldTurnIn** — reduced fee on self-turn-in
- **PCHasCrimeGold** — 1 if PC has enough to pay current crime
- **PCHasGoldDiscount** — 1 if PC has enough for discounted fine
- **PCHasGoldTurnIn** — 1 if PC has enough for turn-in fine

## Possible additional keywords

Items below are judgment calls beyond your existing keyword list. Use them as you see fit when authoring grammar/highlighting.

- **Begin**, **End** — already in your list (script delimiters).
- **If**, **Elseif**, **Else**, **Endif** — control flow (also lowercase forms `endif`, `elseif` are accepted).
- **While**, **EndWhile** — loop, with `endwhile` accepted lowercase.
- **Return** — also a function (no fix), terminates this frame.
- **Set**, **to** — assignment syntax (`set var to expr`).
- **short**, **long**, **float** — variable type declarations.
- **StartScript**, **StopScript**, **ScriptRunning** — these are functions, but `StartScript`/`StopScript` are commonly seen at the top level, very keyword-like.
- **Activate** — function (treated as command). Not a keyword.
- **MessageBox**, **Choice**, **Journal**, **AddTopic**, **Goodbye**, **ForceGreeting**, **ClearInfoActor**, **MenuTest**, **ShowMap**, **PlaySound**, **StreamMusic**, **FadeIn**, **FadeOut**, **FadeTo**, **PlayBink** — all are **functions** (not keywords). They take arguments comma- or space-separated; treat as identifiers in the function namespace.
- **Goodbye** — function used in dialogue result fields, can also be called from script while a dialog window is open. Not a keyword.

### Special syntactic features worth highlighting

- The **fix arrow** `->` (also written `.` in some sources, but Morrowind uses `->`): forms `ObjectID->Function` or `"ObjectID"->Function`. Both bare and quoted IDs are accepted.
- Comments start with `;` and run to end of line.
- String literals are double-quoted: `"itemID"`.
- Float literals must have leading digit (`0.2` not `.2`).
- The **^** prefix introduces text-defines (placeholders) inside dialogue strings/MessageBox: `^PCName`, `^PCClass`, `^PCRace`, `^PCRank`, `^NextPCRank`, `^Cell`, `^Global`, `^Name`, `^Race`, `^Class`, `^Faction`, `^Rank`, `^GameHour`. These are not script keywords but should be highlighted inside string literals.
- The **%** in MessageBox format strings introduces variable substitutions: `%g`, `%G`, `%f`, `%.2f`, `%.0f`, `%S`, etc. Highlight inside string literals.
- The colon-prefix on idents (e.g. `_underscore`) is **not** allowed: object names starting with `_` cause runtime errors when used as targets of the fix arrow (per the PDF "Pitfalls" section).
- There is **no goto/label**. Bethesda recommends using state variables instead.
- Commas between arguments are **optional**; whitespace/parens are also optional. Both `Function arg1, arg2` and `Function arg1 arg2` and `Function, arg1, arg2` parse, with caveats.
- `Player` is a magic identifier (the player reference) usable everywhere with `->`.

### Reserved-word notes from the editor (per MWEdit)

The compiler refuses these as variable names: `end`, `X`, `Y`, `Z`, etc. Treat single-letter axis tokens (`x`, `y`, `z`, `X`, `Y`, `Z`) and any function/keyword as reserved when validating local variable declarations.

### Special "game variables" (declared as locals but read like functions)

These look like function calls in `if (Foo == 1)` but must be **declared** as `short Foo` in the script first. They are not callable; they just reflect engine state on the calling object:

- **OnPCAdd**, **OnPCDrop**, **OnPCSoulGemUse**
- **OnPCEquip**, **PCSkipEquip**, **OnPCRepair**
- **OnPCHitMe**
- **CellChanged**
- **companion**, **minimumprofit**, **StayOutside**
- **AllowWerewolfForceGreeting**
- **Nolore**, **NoIdle**, **NoFlee**, **NoHello**

For grammar purposes, these can be treated either as built-in identifiers (when read) or as locally-declared variables (when on the LHS of `set`).

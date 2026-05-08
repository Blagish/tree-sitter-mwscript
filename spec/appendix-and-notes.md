# Morrowind Script — Appendix & Community Notes Reference

Source 1: *Morrowind Scripting For Dummies 9.0*, Appendix (PDF pages 208–225).
Source 2: Project Tamriel Wiki, *Morrowind Scripting for Dummies* (errata page, archived 2023-10-20, rev 3089).

---

## Tribunal additions

Index of new Tribunal Script Functions (and engine fixes/changes):

Changes / fixes to Morrowind scripting introduced by Tribunal:
- `SetPos` now accepts variables (float) as arguments.
- `SetAngle` now accepts variables (float) as arguments.
- `Equip` now works as intended and forces NPC to equip (put on) armor and clothing.
- `AIActivate` was apparently fixed.

Functions:

- AddToLevCreature
- AddToLevItem
- ClearForceJump
- ClearForceMoveJump
- ClearForceRun
- DaysPassed (variable)
- DisableLevitation
- EnableLevitation
- ExplodeSpell
- ForceJump
- ForceMoveJump
- ForceRun
- GetArmorType
- GetCollidingActor
- GetCollidingPC
- GetForceJump
- GetForceMoveJump
- GetForceRun
- GetPCJumping
- GetPCRunning
- GetPCSneaking
- GetScale
- GetSpellReadied
- GetSquareRoot
- GetWaterLevel
- GetWeaponDrawn
- GetWeaponType
- HasItemEquipped
- HurtCollidingActor
- ModScale
- ModWaterLevel
- PlaceItem
- RemoveFromLevCreature
- RemoveFromLevItem
- SetDelete
- SetJournalIndex (?)
- SetScale
- SetWaterLevel

Tribunal-introduced local "variable-type functions":
- `Float minimumProfit` — local variable set by the game (Tribunal).
- `Short Companion` — local flag (Tribunal).
- `Short StayOutside` — local flag (Tribunal).

---

## Bloodmoon additions

Index of new Bloodmoon Script Functions and variables:

- AllowWereWolfForceGreeting
- BecomeWerewolf
- GetPCInJail
- GetPCTraveling
- GetWerewolfKills
- IsWerewolf
- PCKnownWerewolf
- PlaceAtMe
- SetWerewolfAcrobatics
- TurnMoonRed
- TurnMoonWhite
- UndoWerewolf

`ChangeWeather` `TypeEnum` values 8 and 9 (snowy weather, blizzard) are added by Bloodmoon.

---

## Undocumented functions

Functions not documented in the original CS helpfile (per Soralis & XPCagey, Hex-edited from the TES-CS .exe):

Undocumented in Helpfile:
- PayFineThief
- EnableStatReviewMenu
- GetFactionReaction
- ShowMap
- EnableBirthMenu
- EnableClassMenu
- EnableRaceMenu
- EnableNameMenu
- RemoveEffects
- EnableMagicMenu
- EnableMapMenu
- EnableInventoryMenu
- EnableStatsMenu
- GetInterior
- GetLineOfSight (alias for GetLOS)
- GetWindSpeed
- GetCurrentTime
- ResetActors
- OutputRefInfo
- MenuTest

Functions which are spelled differently than documented (XPCagey; actual syntax on the right):
- `getHealthRatio` -> `getHealthGetRatio`
- `getInvisible` -> `getInvisibile`  *(per HTML notes: this rename is outdated/possibly fixed in Tribunal)*
- `setInvisible` -> `setInvisibile`
- `modInvisible` -> `modInvisibile`
- `getSecundusPhase` -> `getSecundaPhase`

Listed but don't work:
- `getPlayerViewSwitch` -> can't be used
- `OnRepair` -> not in string tables
- `UsedOnMe` -> not in string tables
- `name` -> not in string tables

Note: most console commands can also be compiled as functions by the Construction Set (see console-commands list); these are also largely not listed by the helpfile.

---

## Special globals

Some globals hold special significance. Since they are globals, they don't need to be declared.

| Name | Type | Purpose |
|---|---|---|
| NPCVoiceDistance (750) | Short | Used as a distance when Following NPCs call after you to wait for them (e.g. see DandsaScript) |
| GameHour | Float | Holds the current hour of the day (0–23). Float, so 10:30 = 10.5. |
| Day | Short | Holds the current day of the month (1–30) |
| Month | Short | Holds the current Month of the year (0–11) |
| Year (427) | Short | Holds the current year |
| TimeScale (30) | Float | Sets the ratio of real-time / game-time |
| Random100 | Short | Randomly set between 0–100 (set by main script when out of menumode) |
| PCRace | Short | Player's Race (1=Argonian, 2=Breton, 3=Dark Elf, 4=High Elf, 5=Imperial, 6=Khajiit, 7=Nord, 8=Orc, 9=Redguard, 10=Woodelf). Custom race remains 0 by default. |
| PCVampire | Short | Vampire status: 0=Normal, 1=Vampire, -1=cured |
| VampClan | Short | If PC is vampire, indicates clan: 1=Aundae, 2=Berne, 3=Quarra |
| DaysPassed | Short | Number of days since game started. Requires explicit declaration (present in Tribunal, not Morrowind/Bloodmoon). |
| PCWerewolf | Short | Werewolf status: 0=Normal, 1=Werewolf, -1=Cured |
| WerewolfClawMult (25.00) | Float | Increased during Werewolf quests to make claw attack more powerful |
| PCHasGoldDiscount | Short | Dialogue. Set to 1 if player has enough gold to pay thieves guild discount on "price on your head" |
| PCHasTurnIn | Short | Dialogue. Set to 1 if player has enough gold to pay reduced fee for turning yourself in |
| PCHasCrimeGold | Short | Dialogue. Set to 1 if player has enough gold to pay the crime fee |
| CrimeGoldTurnIn | Short | Gold needed for reduced crime fee |
| CrimeGoldDiscount | (untyped in source) | Gold needed for thieves guild discount crime fee |

Local variables set by the game (must be declared `Short` unless noted):
- OnPCEquip
- OnPCAdd
- OnPCDrop
- OnPCRepair
- OnPCSoulGemUse
- OnPCHitMe
- minimumProfit (Float, Tribunal)

Local variables you can set as a flag (declare as `Short`):
- Companion (Tribunal)
- StayOutside (Tribunal)
- PCSkipEquip

---

## Magic effects

Numeric ID -> string ID. Use the string with `GetEffect` (e.g. `GetEffect sEffectWaterBreathing`); use the integer with `RemoveEffects` (e.g. `RemoveEffects, 0`).

```
0   => sEffectWaterBreathing
1   => sEffectSwiftSwim
2   => sEffectWaterWalking
3   => sEffectShield
4   => sEffectFireShield
5   => sEffectLightningShield
6   => sEffectFrostShield
7   => sEffectBurden
8   => sEffectFeather
9   => sEffectJump
10  => sEffectLevitate
11  => sEffectSlowFall
12  => sEffectLock
13  => sEffectOpen
14  => sEffectFireDamage
15  => sEffectShockDamage
16  => sEffectFrostDamage
17  => sEffectDrainAttribute
18  => sEffectDrainHealth
19  => sEffectDrainSpellpoints
20  => sEffectDrainFatigue
21  => sEffectDrainSkill
22  => sEffectDamageAttribute
23  => sEffectDamageHealth
24  => sEffectDamageMagicka
25  => sEffectDamageFatigue
26  => sEffectDamageSkill
27  => sEffectPoison
28  => sEffectWeaknessToFire
29  => sEffectWeaknessToFrost
30  => sEffectWeaknessToShock
31  => sEffectWeaknessToMagicka
32  => sEffectWeaknessToCommonDisease
33  => sEffectWeaknessToBlightDisease
34  => sEffectWeaknessToCorprusDisease
35  => sEffectWeaknessToPoison
36  => sEffectWeaknessToNormalWeapons
37  => sEffectDisintegrateWeapon
38  => sEffectDisintegrateArmor
39  => sEffectInvisibility
40  => sEffectChameleon
41  => sEffectLight
42  => sEffectSanctuary
43  => sEffectNightEye
44  => sEffectCharm
45  => sEffectParalyze
46  => sEffectSilence
47  => sEffectBlind
48  => sEffectSound
49  => sEffectCalmHumanoid
50  => sEffectCalmCreature
51  => sEffectFrenzyHumanoid
52  => sEffectFrenzyCreature
53  => sEffectDemoralizeHumanoid
54  => sEffectDemoralizeCreature
55  => sEffectRallyHumanoid
56  => sEffectRallyCreature
57  => sEffectDispel
58  => sEffectSoultrap
59  => sEffectTelekinesis
60  => sEffectMark
61  => sEffectRecall
62  => sEffectDivineIntervention
63  => sEffectAlmsiviIntervention
64  => sEffectDetectAnimal
65  => sEffectDetectEnchantment
66  => sEffectDetectKey
67  => sEffectSpellAbsorption
68  => sEffectReflect
69  => sEffectCureCommonDisease
70  => sEffectCureBlightDisease
71  => sEffectCureCorprusDisease
72  => sEffectCurePoison
73  => sEffectCureParalyzation
74  => sEffectRestoreAttribute
75  => sEffectRestoreHealth
76  => sEffectRestoreSpellPoints
77  => sEffectRestoreFatigue
78  => sEffectRestoreSkill
79  => sEffectFortifyAttribute
80  => sEffectFortifyHealth
81  => sEffectFortifySpellpoints
82  => sEffectFortifyFatigue
83  => sEffectFortifySkill
84  => sEffectFortifyMagickaMultiplier
85  => sEffectAbsorbAttribute
86  => sEffectAbsorbHealth
87  => sEffectAbsorbSpellPoints
88  => sEffectAbsorbFatigue
89  => sEffectAbsorbSkill
90  => sEffectResistFire
91  => sEffectResistFrost
92  => sEffectResistShock
93  => sEffectResistMagicka
94  => sEffectResistCommonDisease
95  => sEffectResistBlightDisease
96  => sEffectResistCorprusDisease
97  => sEffectResistPoison
98  => sEffectResistNormalWeapons
99  => sEffectResistParalysis
100 => sEffectRemoveCurse
101 => sEffectTurnUndead
102 => sEffectSummonScamp
103 => sEffectSummonClannfear
104 => sEffectSummonDaedroth
105 => sEffectSummonDremora
106 => sEffectSummonAncestralGhost
107 => sEffectSummonSkeletalMinion
108 => sEffectSummonLeastBonewalker
109 => sEffectSummonGreaterBonewalker
110 => sEffectSummonBonelord
111 => sEffectSummonWingedTwilight
112 => sEffectSummonHunger
113 => sEffectSummonGoldensaint
114 => sEffectSummonFlameAtronach
115 => sEffectSummonFrostAtronach
116 => sEffectSummonStormAtronach
117 => sEffectFortifyAttackBonus
118 => sEffectCommandCreatures
119 => sEffectCommandHumanoids
120 => sEffectBoundDagger
121 => sEffectBoundLongsword
122 => sEffectBoundMace
123 => sEffectBoundBattleAxe
124 => sEffectBoundSpear
125 => sEffectBoundLongbow
126 => sEffectExtraSpell
127 => sEffectBoundCuirass
128 => sEffectBoundHelm
129 => sEffectBoundBoots
130 => sEffectBoundShield
131 => sEffectBoundGloves
132 => sEffectCorpus
133 => sEffectVampirism
134 => sEffectSummonCenturionSphere
135 => sEffectSunDamage
136 => sEffectStuntedMagicka
```

---

## Console commands

Console (in-game-only commands). Most are useful for debugging/testing only, but some (marked with `*`) CAN be used in scripts.

| Command | Short | In scripts? |
|---|---|---|
| CenterOnCell, "Cell_ID" | COC | * |
| CenterOnExterior, X, Y | COE | * |
| CreateMaps "Filename.esp" | | |
| (BetaComment) | BC | |
| FillJournal | | |
| FillMap | | * |
| FixMe | | * |
| GetFactionReaction, "factionID", "factionID", amount | | |
| Help | | |
| MoveOneToOne | MOTO | |
| ObjectReferenceInfo | ORI | |
| OutputObjCounts | | |
| OutputRefCounts | | |
| (PurgeTextures) | PT | |
| Show *global_var* | | |
| ShowVars | SV | |
| StopCellTest | SCT | |
| TestCells | | |
| TestInteriorCells | | |
| TestThreadCells | | |
| TestModels | T3D | |
| ToggleAI | TA | * |
| ToggleBorders | TB | |
| ToggleCombatStats | TCS | |
| ToggleCollision | TCL | * |
| ToggleCollisionBoxes | TCB | |
| ToggleCollisionGrid | TCG | |
| ToggleDebugText | TDT | |
| ToggleDialogueStats | TDS | |
| ToggleFogOfWar | TFOW | * |
| ToggleFullHelp | TFH | |
| ToggleGodMode | TGM | * |
| ToggleGrid | TG | |
| ToggleKillStats | TKS | |
| ToggleLights | | |
| ToggleLoadFade | | |
| ToggleMagicStats | TMS | |
| ToggleMenus | TM | * |
| ToggleScripts | | |
| ToggleScriptOutput | TSO | |
| ToggleStats | TST | |
| ToggleSky | TS | * |
| ToggleTextureString | TTS | |
| ToggleWater | | |
| ToggleWorld | TW | * |
| ToggleWireframe | TWF | |
| TogglePathGrid | TPG | |
| ToggleVanityMode | TVM | * |
| (ShowAnimation) | SA | |
| ShowGroup | SG | |
| (ShowTargetGroup) | ST | |
| ShowScenegraph | SSG | |

---

## Game settings (GMSTs)

Numerical GMSTs (string entries omitted). Names begin with `f` (float) or `i` (integer); string GMSTs begin with `s` and aren't listed here.

```
fRepairMult
fRepairAmountMult
fSpellValueMult
fSpellMakingValueMult
fEnchantmentValueMult
fTravelMult
fTravelTimeMult
fMagesGuildTravel
fWortChanceValue
fMinWalkSpeed
fMaxWalkSpeed
fMinWalkSpeedCreature
fMaxWalkSpeedCreature
fEncumberedMoveEffect
fBaseRunMultiplier
fAthleticsRunBonus
fJumpAcrobaticsBase
fJumpAcroMultiplier
fJumpEncumbranceBase
fJumpEncumbranceMultiplier
fJumpRunMultiplier
fJumpMoveBase
fJumpMoveMult
fSwimWalkBase
fSwimRunBase
fSwimWalkAthleticsMult
fSwimRunAthleticsMult
fSwimHeightScale
fHoldBreathTime
fHoldBreathEndMult
fSuffocationDamage
fMinFlySpeed
fMaxFlySpeed
fStromWindSpeed
fStromWalkMult
fFallDamageDistanceMin
fFallDistanceBase
fFallDistanceMult
fFallAcroBase
fFallAcroMult
iMaxActivateDist
iMaxInfoDist
fVanityDelay
fMaxHeadTrackDistance
fInteriorHeadTrackMult
iHelmWeight
iPauldronWeight
iCuirassWeight
iGauntletWeight
iGreavesWeight
iBootsWeight
iShieldWeight
fLightMaxMod
fMedMaxMod
fUnarmoredBase1
fUnarmoredBase2
iBaseArmorSkill
fBlockStillBonus
fDamageStrengthBase
fDamageStrengthMult
fSwingBlockBase
fSwingBlockMult
fFatigueBase
fFatigueMult
fFatigueReturnBase
fFatigueReturnMult
fFatigueAttackBase
fFatigueAttackMult
fWeaponFatigueMult
fFatigueBlockBase
fFatigueBlockMult
fWeaponFatigueBlockMult
fFatigueRunBase
fFatigueRunMult
fFatigueJumpBase
fFatigueJumpMult
fFatigueSwimWalkBase
fFatigueSwimRunBase
fFatigueSwimWalkMult
fFatigueSwimRunMult
fFatigueSneakBase
fFatigueSneakMult
fMinHandToHandMult
fMaxHandToHandMult
fHandtoHandHealthPer
fCombatInvisoMult
fCombatKODamageMult
fCombatCriticalStrikeMult
iBlockMinChance
iBlockMaxChance
fLevelUpHealthEndMult
fSoulGemMult
fEffectCostMult
fSpellPriceMult
fFatigueSpellBase
fFatigueSpellMult
fFatigueSpellCostMult
fPotionStrengthMult
fPotionT1MagMult
fPotionT1DurMult
fPotionMinUsefulDuration
fPotionT4BaseStrengthMult
fPotionT4EquipStrengthMult
fIngredientMult
fMagicItemCostMult
fMagicItemPriceMult
fMagicItemOnceMult
fMagicItemUsedMult
fMagicItemStrikeMult
fMagicItemConstantMult
fEnchantmentMult
fEnchantmentChanceMult
fPCbaseMagickaMult
fNPCbaseMagickaMult
fAutoSpellChance
fAutoPCSpellChance
iAutoSpellTimesCanCast
iAutoSpellAttSkillMin
iAutoSpellAlterationMax
iAutoSpellConjurationMax
iAutoSpellDestructionMax
iAutoSpellIllusionMax
iAutoSpellMysticismMax
iAutoSpellRestorationMax
iAutoPCSpellMax
iAutoRepFacMod
iAutoRepLevMod
iMagicItemChargeOnce
iMagicItemChargeConst
iMagicItemChargeUse
iMagicItemChargeStrike
iMonthsToRespawn
fCorpseClearDelay
fCorpseRespawnDelay
fBarterGoldResetDelay
fEncumbranceStrMult
fPickLockMult
fTrapCostMult
fMessageTimePerChar
fMagicItemRechargePerSecond
i1stPersonSneakDelta
iBarterSuccessDisposition
iBarterFailDisposition
iLevelupTotal
iLevelupMajorMult
iLevelupMinorMult
iLevelupMajorMultAttribute
iLevelupMinorMultAttribute
iLevelupMiscMultAttriubte
iLevelupSpecialization
iLevelUp01Mult
iLevelUp02Mult
iLevelUp03Mult
iLevelUp04Mult
iLevelUp05Mult
iLevelUp06Mult
iLevelUp07Mult
iLevelUp08Mult
iLevelUp09Mult
iLevelUp10Mult
iSoulAmountForConstantEffect
fConstantEffectMult
fEnchantmentConstantDurationMult
fEnchantmentConstantChanceMult
fWeaponDamageMult
fSeriousWoundMult
fKnockDownMult
iKnockDownOddsBase
iKnockDownOddsMult
fCombatArmorMinMult
fHandToHandReach
fVoiceIdleOdds
iVoiceAttackOdds
iVoiceHitOdds
fProjectileMinSpeed
fProjectileMaxSpeed
fThrownWeaponMinSpeed
fThrownWeaponMaxSpeed
fTargetSpellMaxSpeed
fProjectileThrownStoreChance
iPickMinChance
iPickMaxChance
fDispRaceMod
fDispPersonalityMult
fDispPersonalityBase
fDispFactionMod
fDispFactionRankBase
fDispFactionRankMult
fDispCrimeMod
fDispDiseaseMod
fDispAttackMod
fDispWeaponDrawn
fDispBargainSuccessMod
fDispBargainFailMod
fDispPickPocketMod
iDaysinPrisonMod
fDispAttacking
fDispStealing
iDispTresspass
iDispKilling
iTrainingMod
iAlchemyMod
fBargainOfferBase
fBargainOfferMulti
fDispositionMod
fPersonalityMod
fLuckMod
fReputationMod
fLevelMod
fBribe10Mod
fBribe100Mod
fBribe1000Mod
fPerDieRollMult
fPerTempMult
iPerMinChance
iPerMinChange
fSpecialSkillBonus
fMajorSkillBonus
fMinorSkillBonus
fMiscSkillBonus
iAlarmKilling
iAlarmAttack
iAlarmStealing
iAlarmPickPocket
iAlarmTresspass
fAlarmRadius
iCrimeKilling
iCrimeAttack
iCrimeStealing
iCrimePickPocket
iCrimeTresspass
iCrimeThreshold
iCrimeThresholdMultiplier
fCrimeGoldDiscountMult
fCrimeGoldTurnInMult
iFightAttack
iFightAttacking
iFightDistanceBase
fFightDistanceMultiplier
iFightAlarmMult
fFightDispMult
fFightStealing
iFightPickpocket
iFightTresspass
iFightKilling
iFlee
iGreetDistanceMultiplier
iGreetDuration
fGreetDistanceReset
fIdleChanceMultiplier
fSneakUseDist
fSneakUseDelay
fSneakDistanceBase
fSneakDistanceMultiplier
fSneakSpeedMultiplier
fSneakViewMult
fSneakNoViewMult
fSneakSkillMult
fSneakBootMult
fCombatDistance
fCombatAngleXY
fCombatAngleZ
fCombatForceSideAngle
fCombatTorsoSideAngle
fCombatTorsoStartPercent
fCombatTorsoStopPercent
fCombatBlockLeftAngle
fCombatBlockRightAngle
fCombatDelayCreature
fCombatDelayNPC
fAIMeleeWeaponMult
fAIRangeMeleeWeaponMult
fAIMagicSpellMult
fAIRangeMagicSpellMult
fAIMeleeArmorMult
fAIMeleeSummWeaponMult
fAIFleeHealthMult
fAIFleeFleeMult
fPickPocketMod
fSleepRandMod
fSleepRestMod
iNumberCreatures
fAudioDefaultMinDistance
fAudioDefaultMaxDistance
fAudioVoiceDefaultMinDistance
fAudioVoiceDefaultMaxDistance
fAudioMinDistanceMult
fAudioMaxDistanceMult
fNPCHealthBarTime
fNPCHealthBarFade
fDifficultyMult
fMagicDetectRefreshRate
fMagicStartIconBlink
fMagicCreatureCastDelay
fDiseaseXferChance
fElementalShieldMult
fMagicSunBlockedMult
fWereWolfRunMult
fWereWolfSilverWeaponDamageMult
iWereWolfBounty
fWereWolfStrength
fWereWolfAgility
fWereWolfEndurance
fWereWolfSpeed
fWereWolfHandtoHand
fWereWolfUnarmored
fWereWolfAthletics
fWereWolfAcrobatics
fWereWolfInteligence
fWereWolfWillPower
fWereWolfPersonality
fWereWolfLuck
fWereWolfBlock
fWereWolfArmoror
fWereWolfMediumArmor
fWereWolfHeavyARmor
fWereWolfBluntWeapon
fWereWolfLongBlade
fWereWolfAxe
fWereWolfSpear
fWereWolfDestruction
fWereWolfAlteration
fWereWolfIllusion
fWereWolfConjuration
fWereWolfMysticism
fWereWolfRestoration
fWereWolfEnchant
fWereWolfAlchemy
fWereWolfSecurity
fWereWolfSneak
fWereWolfLightArmor
fWereWolfShortBlade
fWereWolfMarksman
fWereWolfSpeechcraft
iWereWolfLevelToAttack
iWereWolfFightMod
iWereWolfFleeMod
fWereWolfHealth
fWereWolfFatigue
fWereWolfMagica
fCombatDistaceWereWolfMod
fFleeDistance
```

(In MSFD, these names appear quoted in tables, e.g. `"fRepairMult"`. For grammar purposes the bare identifier is what occurs in source code; they are used as global identifiers without declaration.)

---

## Derived attribute formulas

(From DinkumThinkum, p213. PCs; NPCs largely the same when auto-calc enabled.)

- **Maximum Fatigue** = current Strength + current Endurance + current Willpower + current Agility.
- **Maximum Magicka** = current Intelligence × character's magicka multiplier (race/birthsign-dependent; NPC default multiplier 2 via `fNPCbaseMagickaMult`; race apparently doesn't affect NPC mult).
- **Maximum Encumbrance** = 5 × current Strength.
- **Maximum Health (player, level 1)** = (Strength + Endurance) / 2. On level-up: + 10% × Endurance (`fLevelUpHealthEndMult`). Strength only sets starting value; Endurance changes don't retroactively recalculate prior gains.
- **Maximum Health (NPC, level 1)** = (STR + END) / 2 with auto-calc. Higher levels: per-level increase factor is constant within three brackets (before STR maxes, between STR-max and END-max, after both max).

## Game units

- 1 game unit = 0.56 inches = 1.42 cm
- 50 = 28 inches
- 500 = 23.3 feet
- 5000 = 233.3 feet
- 8192 = 385 feet = 116.33 meters = 1 game cell (exterior)
- Morrowind island: 5.00 km N–S, 4.65 km E–W.

---

## Pitfalls and grammar edge cases

Each item below describes a quirk relevant to a tree-sitter grammar / Zed highlighter for mwscript. The "Why it matters" line tells the parser/highlighter author what to actually account for.

- **Function names are case-insensitive.** Documented spellings differ from actual TES-CS spellings (`getInvisibile` vs `getInvisible`, `getSecundaPhase` vs `getSecundusPhase`, `getHealthGetRatio` vs `getHealthRatio`). Mods and reference docs use both forms freely.
  *Why it matters for the parser/highlighter*: function-name highlighting must be case-insensitive; the keyword/function lists need both spellings as accepted aliases.

- **Console commands can compile inside scripts.** Many "console-only" commands (`COC`, `COE`, `TGM`, `FixMe`, `ToggleAI`, `ToggleSky`, `ToggleWorld`, `ToggleMenus`, `FillMap`, `ToggleCollision`, `ToggleFogOfWar`, `ToggleVanityMode`) are accepted by the CS compiler.
  *Why it matters*: the function token category should accept these short forms (`TGM`, `TCL`, `TFOW`, `MOTO`, …) as identifiers — they aren't reserved keywords but are recognized callables.

- **`->` (arrow) is a member-call operator on object IDs.** Forms: `"objectID"->Function`, `objectID->Function`, `player->AddItem "thing" 1`. The token can have whitespace around it: `"foo" -> Activate`. The dot form `RefObject.Variable` is also valid for variable access, and `RefObject->Function` and `RefObject.Variable` coexist on the same identifier.
  *Why it matters*: tokenize `->` as a single multi-char operator allowing surrounding whitespace; allow it after a quoted string, a bareword identifier, or `player`. Don't confuse it with a binary operator.

- **Activate's "extra" argument is silently ignored.** `->Activate, player` is parsed but the `, player` is discarded by the engine.
  *Why it matters*: the grammar should still allow trailing comma-separated arguments on `Activate` rather than rejecting them.

- **`SetAngle X, Y` argument count is variable** — `SetAngle` accepts `axis, value` style but `Position`/`PositionCell` etc. take a fixed positional signature with NO local variables permitted (per HTML notes). Many functions accept variables only in specific argument slots.
  *Why it matters*: don't assume "variable in any arg slot" is grammatically valid for every function — but the syntactic grammar should accept it; semantic validation is out of scope.

- **`Position` and `PositionCell` cannot take variables, local or not.** Only literals.
  *Why it matters*: a strict grammar might want a "literal-only" arg list for these; pragmatically, accept identifiers (validation = engine's job).

- **`SetPos`/`SetAngle` accept variables only since Tribunal.** Pre-Tribunal scripts use literals; Tribunal+ scripts may pass `float` variables.
  *Why it matters*: grammar should accept either form.

- **Comments start with `;`** and run to end-of-line. There are no block comments. Keep in mind that lines can have inline comments after code: `set foo to 1 ; my note`.
  *Why it matters*: comment rule is line-based, single character. No multi-line comment form.

- **String literals are double-quoted.** No escape sequences are documented; quote characters cannot appear inside strings. Strings cannot span multiple lines (each script line is independent in the tokenizer).
  *Why it matters*: string regex is essentially `"[^"\n]*"`. Don't add backslash-escape handling.

- **`%g`/`%G` format specifiers in `MessageBox` strings.** The digit/precision designation IS used (per HTML errata correcting MSFD). The format follows C `printf` semantics for `g`/`G`.
  *Why it matters*: if you want to highlight format specifiers inside `MessageBox` strings, they follow C printf rules.

- **Text-define tokens inside strings begin with `^` or `%`.** Examples: `^Cell`, `^Class`, `^Faction`, `^Gamehour`, `^Global`, `^Name`, `^NextPCRank`, `^PCClass`, `^PCName`, `^PCRace`, `^PCRank`, `^Race`, `^Rank`. Plus `%g`, `%G`, etc. for variables.
  *Why it matters*: these are interpolation markers; a highlighter may want to color them within string literals.

- **Identifier rules** (empirical, from CS tooling):
  - Object IDs may contain letters, digits, underscores, and (in some forms) hyphens.
  - Object IDs in script function calls are typically wrapped in quotes when they contain special characters or start with a digit; bareword IDs are accepted otherwise.
  - Cell names can contain spaces (must be quoted): `PositionCell 0 0 0 0 "Ghostgate, Tower of Dusk"`.
  - Cell names previously errored when over 51 characters (fixed by MCP).
  *Why it matters*: an `ID` token allows letters/digits/underscores; quoted-string-as-identifier appears in the same syntactic slot as a bareword.

- **Compiler cannot resolve `"objectID".variable` self-reference until the variable exists.** Workaround: comment out, compile, uncomment, recompile. Same for self-terminating scripts using `StopScript`.
  *Why it matters*: parser doesn't need to model this, but the form `"selfID".var` and `selfID.var` should both parse identically to other dot-access.

- **`Set MyObject.variable to expr`** is valid; **`Set local_var to MyObject.variable`** is also valid (errata corrects MSFD). The dot can appear on either side.
  *Why it matters*: dot-access goes in expression position generally; not just lvalue.

- **`Return` can appear inside `if/elseif/else/endif` blocks** and "rewinds" the script for that frame; the engine still parses subsequent lines but skips them. Multiple `Return`s anywhere are legal.
  *Why it matters*: `return` is a regular statement, no special placement constraint.

- **`Else if`** is one keyword spelled `Elseif` (not `else if`). The doc index also writes `Elseif`.
  *Why it matters*: tokenize `elseif` as a single keyword; `else if` (two tokens) is *not* equivalent.

- **`While` / `EndWhile`** loop keywords — note both halves end with the prefix-less keyword (no underscore, no space).

- **`If` / `Endif`** — note `Endif` is one word, not `End if`.

- **34th local variable bug** — the engine had a parser error with the 34th declared local variable until MCP "Script expression parser fix". This is engine-only; parsers don't need to enforce it.

- **Eval errors** — "RightEval"/"LeftEval" runtime errors come from type mismatches in expressions (e.g. function expecting one object type given another). MSFD prints them with no space; search docs for "RightEval"/"LeftEval" not "Right Eval".
  *Why it matters*: not a parsing concern, but identifiers appear as `LeftEval`/`RightEval` in error contexts.

- **Square brackets `[ ]` are NOT a syntax form — they appear ONLY in documentation to denote optional arguments** (e.g. `[reset]` for AI functions). In actual scripts the value is just passed literally, e.g. `AiTravel ... 1`.
  *Why it matters*: do NOT treat `[`/`]` as syntactic — they should not parse in real source.

- **AI function `[reset]` is an undocumented optional trailing argument.** Any value works (0 or 1). Applies to `AiTravel`, `AiActivate`, `AiFollow`, `AiEscort`, `AiWander`, `AiFollowCell`, `AiEscortCell`. (For `AiActivate`, supplying it makes the function fail.)
  *Why it matters*: AI function arg lists have a variable-length tail; grammar should accept extra trailing args.

- **`AiWander` argument count varies.** `AIWander, 0, 0, 0` (3 args) and `AIWander, 0, 0, 0, 0, 60, 20, 10, 10, 0, 0, 0, 0` (13 args, 8 idle chances) are both valid.
  *Why it matters*: variable-arity is normal here.

- **Comma vs whitespace separator in args.** Both `Func, a, b` and `Func a b` are accepted. The CS compiler treats commas as optional whitespace separators.
  *Why it matters*: argument separator should be `( WHITESPACE | COMMA )+`. Don't require commas.

- **`MessageBox`** has `MessageBox "text" [%g %g ...] ["choice 1" "choice 2" ...]`. Multiple choice strings appended directly; up to ~3-4 buttons typical.
  *Why it matters*: string-list-after-string-list is grammatically odd; MessageBox basically is `string (literal)* (string)*`.

- **`Choice`** function uses positional `"label" returnValue "label" returnValue …` pairs. Should not be used in Persuasion results.
  *Why it matters*: argument list alternates string/integer.

- **Quoted vs unquoted in script-function arg.** Object IDs in args may or may not be quoted: `AddItem gold_001 100`, `AddItem "gold_001" 100`. Both compile.
  *Why it matters*: ID and string literal occupy the same syntactic position in arg lists.

- **`set ... to`** assignment uses literal keyword `to`. The expression on the right may be a math expression with operator precedence (`+ - * /`, parens, comparisons, `AND`/`OR`).

- **Boolean operators are spelled `AND`, `OR`** (case-insensitive). Comparisons: `==`, `!=`, `<`, `<=`, `>`, `>=`. Alternative wordings appear in docs ("Equal to", "Greater than", etc.) but the tokens are the symbolic ones.

- **Variable type keywords**: `short`, `long`, `float`. Strings are not first-class variables.
  *Why it matters*: only these three type keywords; no `int`, `bool`, `string` declarations exist.

- **`global` / `local` are not reserved keywords** in declarations — local variables are declared by `short var`, globals by separately declared global records. The keyword `global` does NOT appear in scripts to declare; it appears in functions like `Show`/`SetGlobal`.

- **Begin / End**: a script starts with `Begin scriptname` and ends with `End scriptname` (the trailing name is technically optional; `End` alone works too). The script name on `Begin` is a bareword identifier (no quotes).

- **Scripts have one `Begin … End` per file.** No nesting.

- **`StartScript` invocations from dialogue results: `"Object_ID"->StartScript "Script_ID"`** is valid (errata correcting MSFD). The arrow target on the left can be any object instance, not just the dialogue speaker.

- **Whitespace**: tabs and spaces are interchangeable; indentation is purely cosmetic. Each statement is one line; no statement separator other than newline.

- **Line continuation**: there is NO line-continuation syntax (no `\` at end of line). Long argument lists must fit on one line.
  *Why it matters*: lines are atomic; treat newline as a hard statement terminator.

- **`;` inside a string?** Untested in source but engineering-wise `"foo;bar"` is treated as a single string token because the tokenizer scans strings before comments. Implement comment scanning so it ignores `;` inside `"..."`.
  *Why it matters*: order matters in your scanner — string-first, comment-second.

- **Numeric literals**: integers and floats. Floats use `.` as separator (`10.5`, `0.7`). No scientific notation in standard scripts. Negative numbers can appear as unary minus or as part of literal.

- **`Float` time-of-day** — `GameHour` is a float; `10:30` is `10.5`. Confirms the engine parses fractional floats as one token.

- **Persistent references**: object instances need "References persist" flag in the CS to be referenced by ID from scripts. From a parsing standpoint this is irrelevant, but appears in many error discussions.

- **`PCRank`/`NextPCRank` text defines** belong on the same restricted list as `Faction`/`Rank`: not usable in script messageboxes (errata).

- **`Idle` animation groups** without spaces work with `PlayGroup`/`LoopGroup`. Groups WITH spaces (e.g. weapon attacks, weapon follow) cannot be invoked.
  *Why it matters*: the animation-group argument is a bareword identifier; if you want to highlight valid groups, only no-space identifiers are callable.

- **`Float` literal precision** in args — the digit/precision designation in `%g` is honored (printf semantics). Arbitrary float precision in script source is fine.

- **Reserved-ish words appearing in identifier index**: `if`, `endif`, `else`, `elseif`, `while`, `endwhile`, `return`, `set`, `to`, `begin`, `end`, `short`, `long`, `float`, `AND`, `OR`. Plus comparison phrases ("Equal to" etc.) appear in docs but are not source tokens.

---

## Additional functions / keywords from HTML

Functions/keywords mentioned in the HTML notes that are commonly seen but not always listed in the PDF appendix (or carry community-discovered behavior):

- `GetStandingActor`, `GetStandingPC`, `HurtStandingActor` — pair to `GetCollidingActor`/`GetCollidingPC`/`HurtCollidingActor` for top-of-object collisions (mentioned as the "see also" pointers in the Colliding section).
- `OnRepair` — listed in PDF as "in undocumented (doesn't work)" but appears in mods.
- `RepairedOnMe` — index entry.
- `UsedOnMe` — listed as "doesn't work" but appears in source.
- `CellChanged` — "control variable" set by engine on cell transitions.
- `CellUpdate` — index entry.
- `LeftEval`, `RightEval`, `INFIX to POSTFIX`, `EXPRESSION` — internal compiler error labels that may show up in CS error dialogs (not source tokens, but seen in error contexts).
- `Setparalysis` (note: lowercase form documented; case-insensitive) — used in `PlayGroup` paralysis-freeze trick.
- `SetHealth` — listed under script index; properties-recording side-effect documented.
- `Mod/SetFight`, `Mod/SetHello`, `Mod/SetFlee`, `Mod/SetAlarm` — separate Get/Mod/Set forms each exist as distinct function names: `GetFight`, `ModFight`, `SetFight`, etc.
- `AddSpell`, `RemoveSpell` — both record full actor properties into the save (cleanup hazard, but valid syntax).
- `GetSkill`, `SetSkill`, `ModSkill` — counterparts to `GetStat`/`SetStat`/`ModStat`. The `GetStat`/`ModStat`/`SetStat` family is treated as a generic over attributes/skills.
- `Get/Mod/Set*` family is huge — each attribute/skill has its own triple; from the PDF index these include:
  Acrobatics, Agility, Alarm, Alchemy, Alteration, ArmorBonus, Armorer, Athletics, AttackBonus, Axe, Blindness, Block, BluntWeapon, CastPenalty, Conjuration, DefendBonus, Destruction, Disposition, Enchant, Endurance, Fatigue, Fight, Flee, FlyMode (Flying), HandToHand, Health, HeavyArmor, Hello, Illusion, Intelligence, Invisibile, LightArmor, Level, LongBlade, Luck, Magicka, Marksman, MediumArmor, Mercantile, Mysticism, PCCrimeLevel, Personality, Reputation, ResistBlight, ResistCorprus, ResistDisease, ResistFire, ResistFrost, ResistMagicka, ResistNormalWeapons, ResistParalysis, ResistPoison, ResistShock, Restoration, Security, ShortBlade, Silence, Sneak, Spear, Speechcraft, Speed, Strength, SuperJump, SwimSpeed, Unarmored, WaterBreathing, WaterWalking, Willpower.
- `ModCurrentFatigue`, `ModCurrentHealth`, `ModCurrentMagicka` — the "Current" versions modify the active value (vs base). Companions to `ModFatigue` etc.
- `Stopcombat`, `StartCombat`, `StopScript`, `ScriptRunning` — control-flow-related script management functions.
- `SetFight`, `Setfight` — case-insensitive (note both casings appear in the wiki).
- `Disable`/`Enable` — fundamental object lifecycle.
- `Activate`, `OnActivate`, `AiActivate` — activate triple.
- `MessageBox`, `Journal`, `Choice`, `AddTopic`, `Goodbye`, `ForceGreeting` — dialogue/UI functions.
- `PayFine`, `PayFineThief`, `GotoJail` — crime-system functions.
- `KnockOut`, `KnockDown` — animation groups (not functions; passed as identifiers to `PlayGroup`/`LoopGroup`).
- `companion` — local-variable name with engine-meaning (set to 1 enables inventory sharing, including when knocked out).
- `Friend Hit` — dialogue filter, not a script function.
- `Equip` — bypasses beast-race restrictions; quirks under MenuMode.
- `MenuMode`, `ScriptRunning`, `GetCurrentTime`, `GetSecondsPassed`, `GetCurrentAiPackage`, `GetCurrentWeather`, `GetMasserPhase`, `GetSecundaPhase` — engine-state query functions.
- `Lock`, `Unlock`, `GetLocked` — lock-system.
- `Drop`, `DropSoulgem`, `RemoveSoulgem`, `AddSoulGem`, `HasSoulgem` — soul-gem & inventory.
- `PlaySound`, `PlaySound3D`, `PlaySound3DVP`, `PlaySoundVP`, `StopSound`, `GetSoundPlaying`, `StreamMusic` — audio.
- `Say`, `SayDone` — voice playback.
- `FadeIn`, `FadeOut`, `FadeTo` — screen fade.
- `PlayBink` — Bink video playback.

(These are present either explicitly in MSFD's index or referenced by the HTML notes; reproducing the full alphabetized index from the PDF would duplicate p226–230 of the source.)

### Bugs/features fixed by recent MCP (per HTML, may matter for grammar scope only as context, not parsing)

- `CellChanged` not returning 1 on scripted/magic teleporting — fixed.
- `CellChanged` failing for OnActivate-load-doors (Vivec Arena bug) — fixed.
- `RemoveItem` weight-encumbrance bug — fixed.
- `PlayGroup`/`LoopGroup` upper/lower body desync — fixed.
- `Random` returning >1100 for values 65–84 / crashing on multiples of 256 — fixed.
- `PlaceItem`/`PlaceItemCell` NPC-disappearing-on-reload — fixed by MCP "PlaceItem fix".
- Player blight-immunity bug — fixed.
- 34th local-variable parser bug — fixed by "Script expression parser fix".
- `GetPCCell` eval errors for cell names >51 chars — fixed.
- `GetWeaponType` returning 0 for lockpick/probe — MCP makes it return -2/-3 instead.

These are runtime/engine fixes, not grammar concerns, but a Zed extension might want to surface MCP-related notes in hover docs.

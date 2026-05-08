; ===========================================================================
;  MWScript highlight queries.
;  Order matters: more specific patterns first; later @function rules below
;  catch the long lists of built-in identifiers.
; ===========================================================================

; ---- Comments, strings, numbers --------------------------------------------

(comment) @comment

(string) @string
(number) @number
(signed_number) @number

; ---- Keywords --------------------------------------------------------------

[
  "begin"
  "end"
] @keyword

[
  "short"
  "long"
  "float"
] @type

"set" @keyword
"to" @keyword.operator

[
  "if"
  "elseif"
  "else"
  "endif"
] @keyword.conditional

[
  "while"
  "endwhile"
] @keyword.repeat

"return" @keyword.return

; ---- Operators -------------------------------------------------------------

(binary_expression
  op: _ @operator)

(unary_expression
  op: _ @operator)

"->" @operator
"." @punctuation.delimiter
"," @punctuation.delimiter

; ---- Structural ------------------------------------------------------------

(script_header name: (script_name) @function)
(script_footer name: (script_name) @function)

(declaration name: (identifier) @variable)

(assignment lhs: (identifier) @variable)
(assignment lhs: (member_access member: (identifier) @property))

(member_access object: (identifier) @variable)
(member_access object: (string) @string.special)
(member_access member: (identifier) @property)

; ---- Calls -----------------------------------------------------------------

; Targeted call:  "obj"->Func   or   ObjID->Func
(call
  target: (string) @string.special
  function: (identifier) @function.method)

(call
  target: (identifier) @variable.builtin
  function: (identifier) @function.method
  (#match? @variable.builtin "^([Pp][Ll][Aa][Yy][Ee][Rr])$"))

(call
  target: (identifier) @variable
  function: (identifier) @function.method)

; Bare function call (no target).
(call function: (identifier) @function)

; ---- Built-in highlight bands ---------------------------------------------
;
; Long lists of recognized identifiers are appended below by the build script
; from spec/lists/. These rules use #match? with a single big alternation
; regex, which is far cheaper than dozens of #eq? predicates.
;
; The order means: an identifier first matched as @function will keep that
; capture; the bands below promote certain names to more specific scopes
; (@function.builtin, @variable.builtin, @constant.builtin).
;
; Placeholders below get rewritten in-place by `scripts/build-highlights.sh`
; once we have the lists. Until then they're inert no-ops.

;; >>> begin auto-generated builtin bands
; --- engine_locals (21 names) ---
((call function: (identifier) @variable.builtin)
  (#match? @variable.builtin "(?i)^(allowwerewolfforcegreeting|cellchanged|companion|menumode|minimumprofit|noflee|nohello|noidle|nolore|onactivate|ondeath|onknockout|onmurder|onpcadd|onpcdrop|onpcequip|onpchitme|onpcrepair|onpcsoulgemuse|pcskipequip|stayoutside)$"))

; --- special_globals (19 names) ---
((call function: (identifier) @variable.builtin)
  (#match? @variable.builtin "(?i)^(crimegolddiscount|crimegoldturnin|day|dayspassed|gamehour|month|npcvoicedistance|pchascrimegold|pchasgolddiscount|pchasturnin|pcknownwerewolf|pcrace|pcvampire|pcwerewolf|random100|timescale|vampclan|werewolfclawmult|year)$"))

; --- console_commands (22 names) ---
((call function: (identifier) @function.builtin)
  (#match? @function.builtin "(?i)^(centeroncell|centeronexterior|coc|coe|fillmap|fixme|ta|tcl|tfow|tgm|tm|toggleai|togglecollision|togglefogofwar|togglegodmode|togglemenus|togglesky|togglevanitymode|toggleworld|ts|tvm|tw)$"))

; --- builtin_functions (450 names) ---
((call function: (identifier) @function.builtin)
  (#match? @function.builtin "(?i)^(activate|additem|addsoulgem|addspell|addtolevcreature|addtolevitem|addtopic|aiactivate|aiescort|aiescortcell|aifollow|aifollowcell|aitravel|aiwander|becomewerewolf|cast|cellupdate|changeweather|choice|clearforcejump|clearforcemovejump|clearforcerun|clearforcesneak|clearinfoactor|disable|disablelevitation|disableplayercontrols|disableplayerfighting|disableplayerjumping|disableplayerlooking|disableplayermagic|disableplayerviewswitch|disableteleporting|disablevanitymode|dontsaveobject|drop|dropsoulgem|enable|enablebirthmenu|enableclassmenu|enableinventorymenu|enablelevelupmenu|enablelevitation|enablemagicmenu|enablemapmenu|enablenamemenu|enableplayercontrols|enableplayerfighting|enableplayerjumping|enableplayerlooking|enableplayermagic|enableplayerviewswitch|enableracemenu|enablerest|enablestatreviewmenu|enablestatsmenu|enableteleporting|enablevanitymode|equip|explodespell|face|fadein|fadeout|fadeto|fall|fixme|forcegreeting|forcejump|forcemovejump|forcerun|forcesneak|getacrobatics|getagility|getaipackagedone|getalarm|getalchemy|getalteration|getangle|getarmorbonus|getarmorer|getarmortype|getathletics|getattackbonus|getattacked|getaxe|getblightdisease|getblindness|getblock|getbluntweapon|getbuttonpressed|getcastpenalty|getchameleon|getcollidingactor|getcollidingpc|getcommondisease|getconjuration|getcurrentaipackage|getcurrenttime|getcurrentweather|getdeadcount|getdefendbonus|getdestruction|getdetected|getdisabled|getdisposition|getdistance|geteffect|getenchant|getendurance|getfactionreaction|getfatigue|getfight|getflee|getflying|getforcejump|getforcemovejump|getforcerun|getforcesneak|gethandtohand|gethealth|gethealthgetratio|getheavyarmor|gethello|getillusion|getintelligence|getinterior|getinvisibile|getinvisible|getitemcount|getjournalindex|getlevel|getlightarmor|getlineofsight|getlocked|getlongblade|getlos|getluck|getmagicka|getmarksman|getmasserphase|getmediumarmor|getmercantile|getmysticism|getparalysis|getpccell|getpccrimelevel|getpcfacrep|getpcinjail|getpcjumping|getpcrank|getpcrunning|getpcsleep|getpcsneaking|getpctraveling|getpersonality|getplayercontrolsdisabled|getplayerfightingdisabled|getplayerjumpingdisabled|getplayerlookingdisabled|getplayermagicdisabled|getplayerviewswitch|getpos|getrace|getreputation|getresistblight|getresistcorprus|getresistdisease|getresistfire|getresistfrost|getresistmagicka|getresistnormalweapons|getresistparalysis|getresistpoison|getresistshock|getrestoration|getscale|getsecondspassed|getsecondspasssed|getsecundaphase|getsecurity|getshortblade|getsilence|getsneak|getsoundplaying|getspear|getspeechcraft|getspeed|getspell|getspelleffects|getspellreadied|getsquareroot|getstandingactor|getstandingpc|getstartingangle|getstartingpos|getstrength|getsuperjump|getswimspeed|gettarget|getunarmored|getvanitymodedisabled|getwaterbreathing|getwaterlevel|getwaterwalking|getweapondrawn|getweapontype|getwerewolfkills|getwillpower|getwindspeed|goodbye|gotojail|hasitemequipped|hassoulgem|hitattemptonme|hitonme|hurtcollidingactor|hurtstandingactor|iswerewolf|journal|lock|loopgroup|lowerrank|menutest|messagebox|modacrobatics|modagility|modalarm|modalchemy|modalteration|modarmorbonus|modarmorer|modathletics|modattackbonus|modaxe|modblindness|modblock|modbluntweapon|modcastpenalty|modchameleon|modconjuration|modcurrentfatigue|modcurrenthealth|modcurrentmagicka|moddefendbonus|moddestruction|moddisposition|modenchant|modendurance|modfactionreaction|modfatigue|modfight|modflee|modflying|modhandtohand|modhealth|modheavyarmor|modhello|modillusion|modintelligence|modinvisibile|modinvisible|modlevel|modlightarmor|modlongblade|modluck|modmagicka|modmarksman|modmediumarmor|modmercantile|modmysticism|modparalysis|modpccrimelevel|modpcfacrep|modpersonality|modregion|modreputation|modresistblight|modresistcorprus|modresistdisease|modresistfire|modresistfrost|modresistmagicka|modresistnormalweapons|modresistparalysis|modresistpoison|modresistshock|modrestoration|modscale|modsecurity|modshortblade|modsilence|modsneak|modspear|modspeechcraft|modspeed|modstrength|modsuperjump|modswimspeed|modunarmored|modwaterbreathing|modwaterlevel|modwaterwalking|modwillpower|move|moveworld|onactivate|ondeath|onknockout|onmurder|onrepair|outputrefinfo|payfine|payfinethief|pcclearexpelled|pcexpell|pcexpelled|pcforce1stperson|pcforce3rdperson|pcget3rdperson|pcjoinfaction|pclowerrank|pcraiserank|placeatme|placeatpc|placeitem|placeitemcell|playbink|playgroup|playloopsound3d|playloopsound3dvp|playsound|playsound3d|playsound3dvp|playsoundvp|position|positioncell|raiserank|random|removeeffects|removefromlevcreature|removefromlevitem|removeitem|removesoulgem|removespell|removespelleffects|repairedonme|resetactors|resurrect|rotate|rotateworld|samefaction|say|saydone|scriptrunning|setacrobatics|setagility|setalarm|setalchemy|setalteration|setangle|setarmorbonus|setarmorer|setathletics|setatstart|setattackbonus|setaxe|setblindness|setblock|setbluntweapon|setcastpenalty|setchameleon|setconjuration|setdefendbonus|setdelete|setdestruction|setdisposition|setenchant|setendurance|setfactionreaction|setfatigue|setfight|setflee|setflying|sethandtohand|sethealth|setheavyarmor|sethello|setillusion|setintelligence|setinvisibile|setinvisible|setjournalindex|setlevel|setlightarmor|setlongblade|setluck|setmagicka|setmarksman|setmediumarmor|setmercantile|setmysticism|setparalysis|setpccrimelevel|setpcfacrep|setpersonality|setpos|setreputation|setresistblight|setresistcorprus|setresistdisease|setresistfire|setresistfrost|setresistmagicka|setresistnormalweapons|setresistparalysis|setresistpoison|setresistshock|setrestoration|setscale|setsecurity|setshortblade|setsilence|setsneak|setspear|setspeechcraft|setspeed|setstrength|setsuperjump|setswimspeed|setunarmored|setwaterbreathing|setwaterlevel|setwaterwalking|setwerewolfacrobatics|setwillpower|showmap|showrestmenu|skipanim|startcombat|startscript|stopcombat|stopscript|stopsound|streammusic|turnmoonred|turnmoonwhite|undowerewolf|unlock|usedonme|wakeuppc)$"))

; --- special_globals (bare identifier reads) ---
((identifier) @variable.builtin
  (#match? @variable.builtin "(?i)^(crimegolddiscount|crimegoldturnin|day|dayspassed|gamehour|month|npcvoicedistance|pchascrimegold|pchasgolddiscount|pchasturnin|pcknownwerewolf|pcrace|pcvampire|pcwerewolf|random100|timescale|vampclan|werewolfclawmult|year)$"))
;; <<< end auto-generated builtin bands

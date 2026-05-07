; The CMD file.
;
; Two parts: 1. Command definition and  2. State entry
; (state entry is after the commands def section)
;
; 1. Command definition
; ---------------------
; Note: The commands are CASE-SENSITIVE, and so are the command names.
; The eight directions are:
;   B, DB, D, DF, F, UF, U, UB     (all CAPS)
;   corresponding to back, down-back, down, downforward, etc.
; The six buttons are:
;   a, b, c, x, y, z               (all lower case)
;   In default key config, abc are are the bottom, and xyz are on the
;   top row. For 2 button characters, we recommend you use a and b.
;   For 6 button characters, use abc for kicks and xyz for punches.
;
; Each [Command] section defines a command that you can use for
; state entry, as well as in the CNS file.
; The command section should look like:
;
;   [Command]
;   name = some_name
;   command = the_command
;   time = time (optional)
;   buffer.time = time (optional)
;
; - some_name
;   A name to give that command. You'll use this name to refer to
;   that command in the state entry, as well as the CNS. It is case-
;   sensitive (QCB_a is NOT the same as Qcb_a or QCB_A).
;
; - command
;   list of buttons or directions, separated by commas. Each of these
;   buttons or directions is referred to as a "symbol".
;   Directions and buttons can be preceded by special characters:
;   slash (/) - means the key must be held down
;          egs. command = /D       ;hold the down direction
;               command = /DB, a   ;hold down-back while you press a
;   tilde (~) - to detect key releases
;          egs. command = ~a       ;release the a button
;               command = ~D, F, a ;release down, press fwd, then a
;          If you want to detect "charge moves", you can specify
;          the time the key must be held down for (in game-ticks)
;          egs. command = ~30a     ;hold a for at least 30 ticks, then release
;   dollar ($) - Direction-only: detect as 4-way
;          egs. command = $D       ;will detect if D, DB or DF is held
;               command = $B       ;will detect if B, DB or UB is held
;   plus (+) - Buttons only: simultaneous press
;          egs. command = a+b      ;press a and b at the same time
;               command = x+y+z    ;press x, y and z at the same time
;   greater-than (>) - means there must be no other keys pressed or released
;                      between the previous and the current symbol.
;          egs. command = a, >~a   ;press a and release it without having hit
;                                  ;or released any other keys in between
;   You can combine the symbols:
;     eg. command = ~30$D, a+b     ;hold D, DB or DF for 30 ticks, release,
;                                  ;then press a and b together
;
;   Note: Successive direction symbols are always expanded in a manner similar
;         to this example:
;           command = F, F
;         is expanded when MUGEN reads it, to become equivalent to:
;           command = F, >~F, >F
;
;   It is recommended that for most "motion" commads, eg. quarter-circle-fwd,
;   you start off with a "release direction". This makes the command easier
;   to do.
;
; - time (optional)
;   Time allowed to do the command, given in game-ticks. The default
;   value for this is set in the [Defaults] section below. A typical
;   value is 15.
;
; - buffer.time (optional)
;   Time that the command will be buffered for. If the command is done
;   successfully, then it will be valid for this time. The simplest
;   case is to set this to 1. That means that the command is valid
;   only in the same tick it is performed. With a higher value, such
;   as 3 or 4, you can get a "looser" feel to the command. The result
;   is that combos can become easier to do because you can perform
;   the command early. Attacks just as you regain control (eg. from
;   getting up) also become easier to do. The side effect of this is
;   that the command is continuously asserted, so it will seem as if
;   you had performed the move rapidly in succession during the valid
;   time. To understand this, try setting buffer.time to 30 and hit
;   a fast attack, such as KFM's light punch.
;   The default value for this is set in the [Defaults] section below. 
;   This parameter does not affect hold-only commands (eg. /F). It
;   will be assumed to be 1 for those commands.
;
; If you have two or more commands with the same name, all of them will
; work. You can use it to allow multiple motions for the same move.
;
; Some common commands examples are given below.
;
; [Command] ;Quarter circle forward + x
; name = "QCF_x"
; command = ~D, DF, F, x
;
; [Command] ;Half circle back + a
; name = "HCB_a"
; command = ~F, DF, D, DB, B, a
;
; [Command] ;Two quarter circles forward + y
; name = "2QCF_y"
; command = ~D, DF, F, D, DF, F, y
;
; [Command] ;Tap b rapidly
; name = "5b"
; command = b, b, b, b, b
; time = 30
;
; [Command] ;Charge back, then forward + z
; name = "charge_B_F_z"
; command = ~60$B, F, z
; time = 10
;
; [Command] ;Charge down, then up + c
; name = "charge_D_U_c"
; command = ~60$D, U, c
; time = 10


;-| Button Remapping |-----------------------------------------------------
; This section lets you remap the player's buttons (to easily change the
; button configuration). The format is:
;   old_button = new_button
; If new_button is left blank, the button cannot be pressed.
[Remap]
x = x
y = y
z = z
a = a
b = b
c = c
s = s

;-| Default Values |-------------------------------------------------------
[Defaults]
; Default value for the "time" parameter of a Command. Minimum 1.
command.time = 15

; Default value for the "buffer.time" parameter of a Command. Minimum 1,
; maximum 30.
command.buffer.time = 1

;-| Super Motions |--------------------------------------------------------
;The following two have the same name, but different motion.
;Either one will be detected by a "command = TripleKFPalm" trigger.
;Time is set to 20 (instead of default of 15) to make the move
;easier to do.
;

[Command]
name = "LP Combo Breaker"
command = ~F, D, DF, x

[Command]
name = "MP Combo Breaker"
command = ~F, D, DF, y

[Command]
name = "HP Combo Breaker"
command = ~F, D, DF, z

[Command]
name = "LK Combo Breaker"
command = ~F, D, DF, a

[Command]
name = "MK Combo Breaker"
command = ~F, D, DF, b

[Command]
name = "HK Combo Breaker"
command = ~F, D, DF, c

[Command]
name = "Ultra"
command = ~DF, D, DB, a
buffer.time = 4
time = 20

[Command]
name = "Super Tiger Fury"
command = ~D, DB, B, DB, D, DF, F, z
buffer.time = 6
time = 30

[Command]
name = "Super Wind Kick"
command = ~DF, D, DB, F, b
buffer.time = 6
time = 30

[Command]
name = "Super Endokouken"
command = ~F, DF, D, DB, B, x
buffer.time = 4
time = 25

[Command]
name = "Super Endokouken"
command = ~F, DF, D, DB, B, ~x
buffer.time = 4
time = 25

;-| Special Motions |------------------------------------------------------
[Command]
name = "MP Laser Blade"
command = ~DF, D, DB, y
buffer.time = 4
time = 15

[Command]
name = "MP Laser Blade"
command = ~DF, D, DB, ~y
buffer.time = 4
time = 15

[Command]
name = "HP Laser Blade"
command = ~DF, D, DB, z
buffer.time = 4
time = 15

[Command]
name = "HP Laser Blade"
command = ~DF, D, DB, ~z
buffer.time = 4
time = 15

[Command]
name = "LK Wind Kick"
command = ~DF, D, DB, a
buffer.time = 4
time = 15

[Command]
name = "LK Wind Kick"
command = ~DF, D, DB, ~a
buffer.time = 4
time = 15

[Command]
name = "MK Wind Kick"
command = ~DF, D, DB, b
buffer.time = 4
time = 15

[Command]
name = "MK Wind Kick"
command = ~DF, D, DB, ~b
buffer.time = 4
time = 15

[Command]
name = "HK Wind Kick"
command = ~DF, D, DB, c
buffer.time = 4
time = 15

[Command]
name = "HK Wind Kick"
command = ~DF, D, DB, ~c
buffer.time = 4
time = 15

[Command]
name = "LP Tiger Fury"
command = ~F, D, DF, x
buffer.time = 4
time = 15

[Command]
name = "LP Tiger Fury"
command = ~F, D, DF,~x
buffer.time = 4
time = 15

[Command]
name = "MP Tiger Fury"
command = ~F, D, DF, y
buffer.time = 4
time = 15

[Command]
name = "MP Tiger Fury"
command = ~F, D, DF, ~y
buffer.time = 4
time = 15

[Command]
name = "HP Tiger Fury"
command = ~F, D, DF, z
buffer.time = 4
time = 15

[Command]
name = "HP Tiger Fury"
command = ~F, D, DF, ~x
buffer.time = 4
time = 15

[Command]
name = "LP Endokouken"
command = ~D, DF, F, x
buffer.time = 4
time = 15

[Command]
name = "LP Endokouken"
command = ~D, DF, F, ~x
buffer.time = 4
time = 15

[Command]
name = "MP Endokouken"
command = ~D, DF, F, y
buffer.time = 4
time = 15

[Command]
name = "MP Endokouken"
command = ~D, DF, F, ~y
buffer.time = 4
time = 15

[Command]
name = "HP Endokouken"
command = ~D, DF, F, z
buffer.time = 4
time = 15                                                                                                 7

[Command]
name = "HP Endokouken Release"
command = ~D, DF, F, ~z
buffer.time = 4
time = 15

[Command]
name = "Fake Endokouken"
command = ~D, DF, F, a
buffer.time = 4
time = 15

;-| Double Tap |-----------------------------------------------------------
[Command]
name = "FF"     ;Required (do not remove)
command = F, F
time = 10

[Command]
name = "BB"     ;Required (do not remove)
command = B, B
time = 10

;-| 2/3 Button Combination |-----------------------------------------------
[Command]
name = "recovery";Required (do not remove)
command = x+y
time = 1

;-| Dir + Button |---------------------------------------------------------
[Command]
name = "down_a"
command = /$D,a
time = 1

[Command]
name = "down_b"
command = /$D,b
time = 1

[Command]
name = "Follow Up"
command = /$F,z
buffer.time = 8

[Command]
name = "Follow Up"
command = /$F,~z
buffer.time = 8

;-| Single Button |---------------------------------------------------------
[Command]
name = "a"
command = a
time = 1

[Command]
name = "as"
command = a
time = 4
buffer.time = 8

[Command]
name = "b"
command = b
time = 1

[Command]
name = "c"
command = c
time = 1

[Command]
name = "x"
command = x
time = 1

[Command]
name = "xs"
command = x
time = 1
buffer.time = 8

[Command]
name = "y"
command = y
time = 1

[Command]
name = "ys"
command = y
time = 1
buffer.time = 12

[Command]
name = "z"
command = z
time = 1

[Command]
name = "hold x"
command = /x
time = 1

[Command]
name = "start"
command = s
time = 1

;-| Hold Dir |--------------------------------------------------------------
[Command]
name = "holdfwd";Required (do not remove)
command = /$F
time = 1

[Command]
name = "holdback";Required (do not remove)
command = /$B
time = 1

[Command]
name = "holdup" ;Required (do not remove)
command = /$U
time = 1

[Command]
name = "holddown";Required (do not remove)
command = /$D
time = 1

;---------------------------------------------------------------------------
; 2. State entry
; --------------
; This is where you define what commands bring you to what states.
;
; Each state entry block looks like:
;   [State -1, Label]           ;Change Label to any name you want to use to
;                               ;identify the state with.
;   type = ChangeState          ;Don't change this
;   value = new_state_number
;   trigger1 = command = command_name
;   . . .  (any additional triggers)
;
; - new_state_number is the number of the state to change to
; - command_name is the name of the command (from the section above)
; - Useful triggers to know:
;   - statetype
;       S, C or A : current state-type of player (stand, crouch, air)
;   - ctrl
;       0 or 1 : 1 if player has control. Unless "interrupting" another
;                move, you'll want ctrl = 1
;   - stateno
;       number of state player is in - useful for "move interrupts"
;   - movecontact
;       0 or 1 : 1 if player's last attack touched the opponent
;                useful for "move interrupts"
;
; Note: The order of state entry is important.
;   State entry with a certain command must come before another state
;   entry with a command that is the subset of the first.
;   For example, command "fwd_a" must be listed before "a", and
;   "fwd_ab" should come before both of the others.
;
; For reference on triggers, see CNS documentation.
;
; Just for your information (skip if you're not interested):
; This part is an extension of the CNS. "State -1" is a special state
; that is executed once every game-tick, regardless of what other state
; you are in.


; Don't remove the following line. It's required by the CMD standard.
[Statedef -1]

;===========================================================================
;---------------------------------------------------------------------------

;Run Fwd
[State -1, Run Fwd]
type = ChangeState
value = 100
trigger1 = command = "FF"
trigger1 = statetype = S
trigger1 = ctrl

;---------------------------------------------------------------------------
;Run Back
[State -1, Run Back]
type = ChangeState
value = 105
trigger1 = command = "BB"
trigger1 = statetype = S
trigger1 = ctrl

;---------------------------------------------------------------------------

[State -1, ultra]
type = changestate
value = 10000
triggerall = command = "Ultra"
triggerall = p2statetype != a
triggerall = p2life <= 150
triggerall = statetype != a
triggerall = var(59) > 0
triggerall = p2name != "Gill"
trigger1 = var(4)
trigger2 = movehit && hitcount = 2 && stateno = 370 && p2statetype != a

;[State -1, lp combo breaker]
;type = changestate
;value = 8500
;triggerall = command = "LP Combo Breaker"
;triggerall = command = "x"
;triggerall = statetype = s
;triggerall = p2statetype = s || p2statetype = c
;triggerall = p2movetype = a
;triggerall = (enemynear, hitdefattr = SC, NA, SA)
;triggerall = life > 1
;triggerall = gethitvar(animtype) = 0
;triggerall = var(21) > 1
;triggerall = stateno = 5000
;triggerall = p2dist x < 85
;trigger1 = gethitvar(groundtype) = 1
;trigger2 = gethitvar(groundtype) = 0

[State -1, PPP combo breaker]
type = changestate
value = 8500
triggerall = ctrl = 0
triggerall = movetype = H
triggerall = life > 100
triggerall = power >= 666
triggerall = var(21) > 1
trigger1 = command = "LP Combo Breaker"&& statetype = S
trigger2 = command = "MP Combo Breaker"&& statetype = S
trigger3 = command = "HP Combo Breaker"&& statetype = S
trigger4 = command = "LP Combo Breaker"&& statetype = C
trigger5 = command = "MP Combo Breaker"&& statetype = C
trigger6 = command = "HP Combo Breaker"&& statetype = C
;triggerall triggerall = var(21) > 1
;triggerall = command = "y"
;triggerall = statetype = s
;triggerall = p2statetype = s || p2statetype = c
;triggerall = p2movetype = a
;triggerall = life > 1
;triggerall = gethitvar(animtype) = 1
;triggerall = var(21) > 1
;triggerall = stateno = 5000
;triggerall = p2dist x < 85
;triggerall = (enemynear, hitdefattr = SC, NA, SA)
;trigger1 = gethitvar(groundtype) = 1
;trigger2 = gethitvar(groundtype) = 0

;[State -1, hp combo breaker]
;type = changestate
;value = 8500
;triggerall = command = "HP Combo Breaker"
;triggerall = command = "z"
;triggerall = statetype = s
;triggerall = p2statetype = s || p2statetype = c
;triggerall = p2movetype = a
;triggerall = (enemy, movehit)
;triggerall = life > 1
;triggerall = !hitover
;triggerall = gethitvar(animtype) = 2
;triggerall = var(21) > 1
;triggerall = stateno = 5000
;triggerall = p2dist x < 85
;triggerall = (enemynear, hitdefattr = SC, NA, SA)
;trigger1 = gethitvar(groundtype) = 1
;trigger2 = gethitvar(groundtype) = 0

[State -1, lk combo breaker]
type = changestate
value = 8500
triggerall = command = "LK Combo Breaker"
;triggerall = command = "a"
triggerall = statetype = s
triggerall = p2statetype = s || p2statetype = c
triggerall = p2movetype = a
triggerall = life > 1
triggerall = !hitover
triggerall = gethitvar(animtype) = 0
triggerall = var(21) > 1
triggerall = stateno = 5000
triggerall = p2dist x < 85
triggerall = (enemynear, hitdefattr = SC, NA, SA)
trigger1 = gethitvar(groundtype) = 2
trigger2 = gethitvar(groundtype) = 3

[State -1, mk combo breaker]
type = changestate
value = 8500
triggerall = command = "MK Combo Breaker"
;triggerall = command = "b"
triggerall = statetype = s
triggerall = p2statetype = s || p2statetype = c
triggerall = p2movetype = a
triggerall = life > 1
triggerall = !hitover
triggerall = gethitvar(animtype) = 1
triggerall = var(21) > 1
triggerall = stateno = 5000
triggerall = p2dist x < 85
triggerall = (enemynear, hitdefattr = SC, NA, SA)
trigger1 = gethitvar(groundtype) = 2
trigger2 = gethitvar(groundtype) = 3

[State -1, hk combo breaker]
type = changestate
value = 8500
triggerall = command = "HK Combo Breaker"
;triggerall = command = "c"
triggerall = statetype = s
triggerall = p2statetype = s || p2statetype = c
triggerall = p2movetype = a
triggerall = life > 1
triggerall = gethitvar(animtype) = 2
triggerall = var(21) > 1
triggerall = stateno = 5000
triggerall = p2dist x < 85
triggerall = (enemynear, hitdefattr = SC, NA, SA)
trigger1 = gethitvar(groundtype) = 2
trigger2 = gethitvar(groundtype) = 3

[State -1, Super Tiger Fury Cancel]
type = changestate
value = 3201
triggerall = stateno != 3201
triggerall = command = "Super Tiger Fury"
triggerall = statetype != a
triggerall = power >= 1000
trigger1 = movecontact && stateno = [210, 220]
trigger2 = movecontact && stateno = [260, 270]
trigger3 = movecontact && stateno = [300, 340]
trigger4 = movehit && hitcount = 2 && stateno = [360, 370]
trigger5 = movecontact && stateno = [410, 420]
trigger6 = movecontact && stateno = 460
trigger7 = var(4)
trigger8 = movehit && hitcount = 3 && stateno = 2200
trigger9 = var(34)

[State -1, Super Tiger Fury Standalone]
type = changestate
value = 3200
triggerall = command = "Super Tiger Fury"
triggerall = statetype != a
triggerall = power >= 1000
triggerall = stateno != 3200
trigger1 = ctrl
trigger2 = stateno = 1005 && time > 14
trigger3 = stateno = 52
trigger4 = stateno = 1501


[State -1, Super Endokouken]
type = changestate
value = 3100
triggerall = stateno != 3100
triggerall = command = "Super Endokouken"
triggerall = statetype != a
triggerall = power >= 667
trigger1 = movecontact && stateno = [210, 220]
trigger2 = movecontact && stateno = [260, 270]
trigger3 = movecontact && stateno = [300, 340]
trigger4 = movehit && hitcount = 2 && stateno = [360, 370]
trigger5 = movecontact && stateno = [410, 420]
trigger6 = movecontact && stateno = 460
trigger7 = var(4)
trigger8 = ctrl
trigger9 = stateno = 52
trigger10 = stateno = 1501
trigger11 = stateno = 1005 && time > 14
trigger12 = movehit && hitcount = 3 && stateno = 2200

[State -1, Super Wind Kick Linker]
type = changestate
value = 2000
triggerall = command = "Super Wind Kick"
triggerall = statetype != a
triggerall = p2statetype != a
triggerall = p2bodydist x < 35
triggerall = power >= 500
trigger1 = var(5) > 1 && var(4)
trigger2 = movehit && hitcount = 2 && stateno = 370
trigger3 = movehit && hitcount = 2 && stateno = 1310
trigger4 = movehit && hitcount = 3 && stateno = 2200

[State -1, Super Wind Kick Standalone]
type = changestate
value = 3000
triggerall = command = "Super Wind Kick"
triggerall = statetype != a
triggerall = power >= 500
trigger1 = ctrl

[State -1, Hidden Ender]
type = changestate
value = 1740
triggerall = command = "MP Tiger Fury"
triggerall = statetype != a
triggerall = p2statetype != a
triggerall = p2bodydist x < 35
triggerall = var(45) && var(46) && var(47) && var(48)
trigger1 = var(5) > 1 && var(4)
trigger2 = movehit && hitcount = 2 && stateno = 370
trigger3 = movehit && hitcount = 2 && stateno = 1310
trigger4 = movehit && hitcount = 3 && stateno = 2200
trigger5 = var(35)

[State -1, Laser Blade Ender]
type = changestate
value = 3100
triggerall = command = "HP Laser Blade"
triggerall = statetype != a
triggerall = p2statetype != a
triggerall = p2bodydist x < 35
trigger1 = var(5) > 1 && var(4)
trigger2 = movehit && hitcount = 2 && stateno = 370
trigger3 = movehit && hitcount = 2 && stateno = 1310
trigger4 = movehit && hitcount = 3 && stateno = 2200
trigger5 = var(35)

[State -1, Wind Kick Ender]
type = changestate
value = 1720 + var(45) + var(46) + var(48)
triggerall = command = "HK Wind Kick"
triggerall = statetype != a
triggerall = p2statetype != a
triggerall = p2bodydist x < 35
trigger1 = var(5) > 1 && var(4)
trigger2 = movehit && hitcount = 2 && stateno = 370
trigger3 = movehit && hitcount = 2 && stateno = 1310
trigger4 = movehit && hitcount = 3 && stateno = 2200
trigger5 = var(35)

[State -1, Tiger Fury Ender]
type = changestate
value = 1710 + var(45) + var(47) + var(48)
triggerall = command = "HP Tiger Fury"
triggerall = statetype != a
triggerall = p2statetype != a
triggerall = p2bodydist x < 35
trigger1 = var(5) > 1 && var(4)
trigger2 = movehit && hitcount = 2 && stateno = 370
trigger3 = movehit && hitcount = 2 && stateno = 1310
trigger4 = movehit && hitcount = 3 && stateno = 2200
trigger5 = var(35)

[State -1, Endokouken Ender]
type = changestate
value = 1700 + var(46) + var(47) + var(48)
triggerall = command = "HP Endokouken"
triggerall = statetype != a
triggerall = p2statetype != a
triggerall = p2bodydist x < 35
trigger1 = var(5) > 1 && var(4)
trigger2 = movehit && hitcount = 2 && stateno = 370
trigger3 = movehit && hitcount = 2 && stateno = 1310
trigger4 = movehit && hitcount = 3 && stateno = 2200
trigger5 = var(35)

[State -1, HP Laser Blade]
type = changestate
value = 1310
triggerall = stateno != [1300, 1310]
triggerall = command = "HP Laser Blade"
triggerall = statetype != a
trigger1 = movecontact && stateno = [210, 220]
;trigger2 = movecontact && stateno = [260, 270]
trigger2 = movecontact && stateno = [300, 340]
trigger3 = movehit && hitcount = 2 && stateno = [360, 370]
trigger4 = movecontact && stateno = [410, 420]
trigger5 = movecontact && stateno = 460
trigger6 = var(4)
trigger7 = ctrl
trigger8 = stateno = 52
trigger9 = stateno = 1501
trigger10 = stateno = 1005 && time > 14

[State -1, MP Laser Blade]
type = changestate
value = 1300
triggerall = stateno != [1300, 1310]
triggerall = command = "MP Laser Blade"
triggerall = statetype != a
trigger1 = movecontact && stateno = [210, 220]
;trigger2 = movecontact && stateno = [260, 270]
trigger2 = movecontact && stateno = [300, 340]
trigger3 = movehit && hitcount = 2 && stateno = [360, 370]
trigger4 = movecontact && stateno = [410, 420]
trigger5 = movecontact && stateno = 460
trigger6 = var(4)
trigger7 = ctrl
trigger8 = stateno = 52
trigger9 = stateno = 1501
trigger10 = stateno = 1005 && time > 14

[State -1, HK Air Double]
type = changestate
value = 1250
triggerall = command = "HK Wind Kick"
triggerall = statetype = a
triggerall = p2statetype = a
;triggerall = p2bodydist x < 25
trigger1 = movehit && stateno = 600
trigger2 = movehit && stateno = 650

[State -1, HK Wind Kick]
type = changestate
value = 1220
triggerall = stateno != [1200, 1250]
triggerall = command = "HK Wind Kick"
triggerall = statetype != a
trigger1 = movecontact && stateno = [210, 220]
;trigger2 = movecontact && stateno = [260, 270]
trigger2 = movecontact && stateno = [300, 340]
trigger3 = movehit && hitcount = 2 && stateno = [360, 370]
trigger4 = movecontact && stateno = [410, 420]
trigger5 = movecontact && stateno = 460
trigger6 = var(4)
trigger7 = ctrl
trigger8 = stateno = 52
trigger9 = stateno = 1501
trigger10 = stateno = 1005 && time > 14

[State -1, CCA Wind Kick]
type = changestate
value = 2200
triggerall = command = "MK Wind Kick"
triggerall = statetype != a
trigger1 = stateno = 1501

[State -1, MK Air Double]
type = changestate
value = 1250
triggerall = command = "MK Wind Kick"
triggerall = statetype = a
triggerall = p2statetype = a
;triggerall = p2bodydist x < 25
trigger1 = movehit && stateno = 620
trigger2 = movehit && stateno = 670

[State -1, MK Wind Kick]
type = changestate
value = 1210
triggerall = stateno != [1200, 1250]
triggerall = command = "MK Wind Kick"
triggerall = statetype != a
trigger1 = movecontact && stateno = [210, 220]
;trigger2 = movecontact && stateno = [260, 270]
trigger2 = movecontact && stateno = [300, 340]
trigger3 = movehit && hitcount = 2 && stateno = [360, 370]
trigger4 = movecontact && stateno = [410, 420]
trigger5 = movecontact && stateno = 460
trigger6 = var(4)
trigger7 = ctrl
trigger8 = stateno = 52
trigger9 = stateno = 1005 && time > 14

[State -1, LK Air Double]
type = changestate
value = 1250
triggerall = command = "LK Wind Kick"
triggerall = statetype = a
triggerall = p2statetype = a
;triggerall = p2bodydist x < 25
trigger1 = movehit && stateno = 610
trigger2 = movehit && stateno = 660

[State -1, LK Wind Kick]
type = changestate
value = 1200
triggerall = stateno != [1200, 1250]
triggerall = command = "LK Wind Kick"
triggerall = statetype != a
trigger1 = movecontact && stateno = [210, 220]
;trigger2 = movecontact && stateno = [260, 270]
trigger = movecontact && stateno = [300, 340]
trigger4 = movehit && hitcount = 2 && stateno = [360, 370]
trigge5 = movecontact && stateno = [410, 420]
trigger6 = movecontact && stateno = 460
trigger7 = var(4)
trigger8 = ctrl
trigger9 = stateno = 52
trigger10 = stateno = 1501
trigger11 = stateno = 1005 && time > 14

[State -1, HP Tiger Fury]
type = changestate
value = 1120
triggerall = command = "HP Tiger Fury"
triggerall = statetype != a
trigger1 = movecontact && stateno = [210, 220]
;trigger2 = movecontact && stateno = [260, 270]
trigger2 = movecontact && stateno = [300, 340]
trigger3 = movehit && hitcount = 2 && stateno = [360, 370]
trigger4 = movecontact && stateno = [410, 420]
trigger5 = movecontact && stateno = 460
trigger6 = var(4)
trigger7 = ctrl
trigger8 = stateno = 52
trigger9 = stateno = 1501
trigger10 = stateno = 1005 && time > 14
trigger11 = movehit && hitcount = 3 && stateno = 2200

[State -1, MP Tiger Fury]
type = changestate
value = 1110
triggerall = command = "MP Tiger Fury"
triggerall = statetype != a
trigger1 = movecontact && stateno = [210, 220]
;trigger2 = movecontact && stateno = [260, 270]
trigger2 = movecontact && stateno = [300, 340]
trigger3 = movehit && hitcount = 2 && stateno = [360, 370]
trigger4 = movecontact && stateno = [410, 420]
trigger5 = movecontact && stateno = 460
trigger6 = var(4)
trigger7 = ctrl
trigger8 = stateno = 52
trigger9 = stateno = 1501
trigger10 = stateno = 1005 && time > 14
trigger11 = movehit && hitcount = 3 && stateno = 2200

[State -1, LP Tiger Fury]
type = changestate
value = 1100
triggerall = command = "LP Tiger Fury"
triggerall = statetype != a
trigger1 = movecontact && stateno = [210, 220]
;trigger2 = movecontact && stateno = [260, 270]
trigger2 = movecontact && stateno = [300, 340]
trigger3 = movehit && hitcount = 2 && stateno = [360, 370]
trigger4 = movecontact && stateno = [410, 420]
trigger5 = movecontact && stateno = 460
trigger6 = var(4)
trigger7 = ctrl
trigger8 = stateno = 52
trigger9 = stateno = 1501
trigger10 = stateno = 1005 && time > 14
trigger11 = movehit && hitcount = 3 && stateno = 2200

[State -1, endokouken quick start]
type = changestate
value = 1075
triggerall = command = "HP Endokouken Release"
triggerall = statetype != a
trigger1 = movecontact && stateno = [210, 220]
trigger2 = movecontact && stateno = [260, 270]
trigger3 = movecontact && stateno = [300, 340]
trigger4 = movehit && hitcount = 2 && stateno = [360, 370]
trigger5 = moveguarded && stateno = 370
trigger6 = movecontact && stateno = [410, 420]
trigger7 = movecontact && stateno = 460
trigger8 = movehit && hitcount = 3 && stateno = 2200
;trigger8 = var(4)

[State -1, endokouken quick start]
type = changestate
value = 1050
triggerall = command = "HP Endokouken" || command = "MP Endokouken" || command = "LP Endokouken"
triggerall = statetype != a
trigger1 = movecontact && stateno = [210, 220]
trigger2 = movecontact && stateno = [260, 270]
trigger3 = movecontact && stateno = [300, 340]
trigger4 = movehit && hitcount = 2 && stateno = [360, 370]
trigger5 = moveguarded && stateno = 370
trigger6 = movecontact && stateno = [410, 420]
trigger7 = movecontact && stateno = 460
trigger8 = movehit && hitcount = 3 && stateno = 2200
;trigger8 = var(4)

[State -1, hp endokouken release]
type = changestate
value = 1025
triggerall = command = "HP Endokouken Release"
triggerall = statetype != a
trigger1 = ctrl
trigger2 = stateno = 52
trigger3 = stateno = 1501
trigger4 = stateno = 1005 && time > 14

[State -1, hp endokouken]
type = changestate
value = 1020
triggerall = command = "HP Endokouken"
triggerall = statetype != a
trigger1 = ctrl
trigger2 = stateno = 52
trigger3 = stateno = 1501
trigger4 = stateno = 1005 && time > 14

[State -1, mp endokouken]
type = changestate
value = 1010
triggerall = command = "MP Endokouken"
triggerall = statetype != a
trigger1 = ctrl
trigger2 = stateno = 52
trigger3 = stateno = 1501
trigger4 = stateno = 1005 && time > 14

[State -1, lp endokouken]
type = changestate
value = 1000
triggerall = command = "LP Endokouken"
triggerall = statetype != a
trigger1 = ctrl
trigger2 = stateno = 52
trigger3 = stateno = 1501
trigger4 = stateno = 1005 && time > 14

[State -1, fake endokouken]
type = changestate
value = 1005
triggerall = command = "Fake Endokouken"
triggerall = statetype != a
trigger1 = ctrl
trigger2 = stateno = 52
trigger3 = stateno = 1501


;------ auto-doubles ------

[State -1, lp auto-double]
type = changestate
value = 800
triggerall = command = "x"
triggerall = command != "holddown"
triggerall = p2bodydist x < 20
triggerall = statetype = s
triggerall = p2statetype != a
triggerall = var(5) < 4
trigger1 = var(0) = 1

[State -1, lk auto-double]
type = changestate
value = 820
triggerall = command = "a"
triggerall = command != "holddown"
triggerall = p2bodydist x < 40
triggerall = statetype = s
triggerall = p2statetype != a
triggerall = var(5) < 4
trigger1 = var(0) = 1

[State -1, mp auto-double]
type = changestate
value = 810
triggerall = command = "y"
triggerall = command != "holddown"
triggerall = p2bodydist x < 20
triggerall = p2statetype != a
triggerall = statetype = s
triggerall = var(5) < 4
trigger1 = var(1) = 1

[State -1, mk auto-double]
type = changestate
value = 830
triggerall = command = "b"
triggerall = command != "holddown"
triggerall = p2bodydist x < 20
triggerall = pos y >= 0
triggerall = var(5) < 4
trigger1 = var(1) = 1

[State -1, hp auto-double]
type = changestate
value = 840
triggerall = command = "z"
triggerall = command != "holddown"
triggerall = p2bodydist x < 20
triggerall = statetype = s
triggerall = var(5) < 4
trigger1 = var(3) = 1

[State -1, hk auto-double]
type = changestate
value = 850
triggerall = command = "c"
triggerall = command != "holddown"
triggerall = p2bodydist x < 20
triggerall = statetype = s
triggerall = var(5) < 4
trigger1 = var(3) = 1

;;------ air normals ------

[State -1, j. lp]
type = changestate
value = 600
triggerall = command = "x"
triggerall = statetype = a
trigger1 = ctrl

[State -1, j. mp]
type = changestate
value = 610
triggerall = command = "y"
triggerall = statetype = a
trigger1 = ctrl

[State -1, j. hp]
type = changestate
value = 620
triggerall = command = "z"
triggerall = statetype = a
trigger1 = ctrl

[State -1, j. lk]
type = changestate
value = 650
triggerall = command = "a"
triggerall = statetype = a
trigger1 = ctrl

[State -1, j. mk]
type = changestate
value = 660
triggerall = command = "b"
triggerall = statetype = a
trigger1 = ctrl

[State -1, j. lp]
type = changestate
value = 670
triggerall = command = "c"
triggerall = statetype = a
trigger1 = ctrl

;
;;------ crouching normals ------

[State -1, cr. mk]
type = changestate
value = 470
triggerall = command = "c"
triggerall = command = "holddown"
triggerall = statetype = c
trigger1 = ctrl

[State -1, cr. mk]
type = changestate
value = 460
triggerall = command = "b"
triggerall = command = "holddown"
triggerall = statetype = c
trigger1 = ctrl

[State -1, cr. lk]
type = changestate
value = 450
triggerall = command = "a"
triggerall = command = "holddown"
triggerall = statetype = c
trigger1 = ctrl

[State -1, cr. lk follow-up]
type = changestate
value = 455
triggerall = command = "as"
triggerall = command = "holddown"
triggerall = statetype = c
trigger1 = stateno = 450 && time > 9

[State -1, cr. lk follow-up]
type = changestate
value = 455
triggerall = command = "as"
triggerall = command = "holddown"
triggerall = statetype = c
trigger1 = stateno = 455 && time > 11

[State -1, cr. hp]
type = changestate
value = 420
triggerall = command = "z"
triggerall = command = "holddown"
triggerall = statetype = c
trigger1 = ctrl

[State -1, cr. mp]
type = changestate
value = 410
triggerall = command = "y"
triggerall = command = "holddown"
triggerall = statetype = c
trigger1 = ctrl

[State -1, cr. lp]
type = changestate
value = 400
triggerall = command = "x"
triggerall = command = "holddown"
triggerall = statetype = c
trigger1 = ctrl

[State -1, cr. lp follow-up 1]
type = changestate
value = 405
triggerall = command = "xs"
triggerall = command = "holddown"
triggerall = statetype = c
trigger1 = stateno = 400 && time >= 16

[State -1, cr. lp follow-up 2]
type = changestate
value = 400
triggerall = command = "xs"
triggerall = command = "holddown"
triggerall = statetype = c
trigger1 = stateno = 405 && time >= 12

;;------ direction + button ------
[State -1, f + hk]
type = changestate
value = 370
triggerall = command = "c"
triggerall = command = "holdfwd"
triggerall = command != "holddown"
triggerall = statetype = s
trigger1 = ctrl
trigger2 = stateno = 52
trigger3 = stateno = 1501
trigger4 = movehit && stateno = [1210, 1300];wind kick and single blade
trigger5 = movehit && hitcount = 2 && stateno = 1310;double blade
trigger6 = movehit && stateno = 3002;super wind kick
trigger7 = movehit && hitcount = 5 && stateno = 2000;wind kick link
trigger8 = stateno = 1005 && time > 14

[State -1, b + hk]
type = changestate
value = 360
triggerall = command = "c"
triggerall = command = "holdback"
triggerall = command != "holddown"
triggerall = statetype = s
trigger1 = ctrl
trigger2 = stateno = 52
trigger3 = stateno = 1501
trigger4 = stateno = 1005 && time > 14

[State -1, b + hp]
type = changestate
value = 350
triggerall = command = "z"
triggerall = command != "holddown"
triggerall = command = "holdback"
triggerall = statetype = s
trigger1 = ctrl
trigger2 = stateno = 52
trigger3 = stateno = 1501
trigger4 = stateno = 1005 && time > 14

;;------ standing normals ------
;
[State -1, juggle throw]
type = changestate
value = 950
triggerall = command = "z"
triggerall = command = "holdfwd"
triggerall = p2statetype = s || p2statetype = c
triggerall = p2bodydist x < 40
triggerall = statetype = s
trigger1 = var(4)
;
[State -1, throw]
type = changestate
value = 900
triggerall = command = "z"
triggerall = command = "holdfwd"
triggerall = p2statetype = s || p2statetype = c
triggerall = p2bodydist x < 8
triggerall = statetype = s
triggerall = p2stateno != [5000, 5100]
trigger1 = ctrl
trigger2 = stateno = 1501
trigger3 = stateno = 1312
trigger4 = stateno = 1005 && time > 14

[State -1, close mp]
type = changestate
value = 340
triggerall = command = "y"
triggerall = command != "holddown"
triggerall = p2bodydist x < 25
triggerall = statetype = s
triggerall = p2statetype != a
trigger1 = ctrl
trigger2 = stateno = 52
trigger3 = stateno = 1501
trigger4 = movecontact && stateno = 330
trigger5 = stateno = 1005 && time > 14
trigger6 = movecontact && stateno = 320
trigger7 = movecontact && stateno = 270
trigger8 = movecontact && stateno = 220

[State -1, close hk]
type = changestate
value = 330
triggerall = command = "c"
triggerall = command != "holddown"
triggerall = p2bodydist x < 17
triggerall = statetype = s
triggerall = p2statetype != a
trigger1 = ctrl
trigger2 = stateno = 52
trigger3 = stateno = 1501
trigger4 = hitcount = 2 && stateno = [800, 850]
trigger5 = stateno = 1005 && time > 14

[State -1, close hp]
type = changestate
value = 320
triggerall = command = "z"
triggerall = command != "holddown"
triggerall = p2bodydist x < 13
triggerall = statetype = s
triggerall = p2statetype != a
trigger1 = ctrl
trigger2 = stateno = 52
trigger3 = stateno = 1501
trigger4 = hitcount = 2 && stateno = [800, 850]
trigger5 = stateno = 1005 && time > 14

[State -1, close mk]
type = changestate
value = 310
triggerall = command = "b"
triggerall = command != "holddown"
triggerall = p2bodydist x < 26
triggerall = statetype = s
triggerall = p2statetype != a
trigger1 = ctrl
trigger2 = stateno = 52
trigger3 = movecontact && stateno = 330
trigger4 = stateno = 1501
trigger5 = stateno = 1005 && time > 14
trigger6 = movecontact && stateno = 320
trigger7 = movecontact && stateno = 330
trigger8 = movecontact && stateno = 220

[State -1, close lk]
type = changestate
value = 300
triggerall = command = "a"
triggerall = command != "holddown"
triggerall = p2bodydist x < 11
triggerall = statetype = s
triggerall = p2statetype != a
trigger1 = ctrl
trigger2 = stateno = 52
trigger3 = stateno = 1501
trigger4 = stateno = 1005 && time > 14

[State -1, st. lk]
type = changestate
value = 250
triggerall = command = "a"
triggerall = command != "holddown"
triggerall = statetype = s
trigger1 = ctrl
trigger2 = stateno = 52
trigger3 = stateno = 1501
trigger4 = stateno = 1005 && time > 14

[State -1, st. lk follow-up 1]
type = changestate
value = 255
triggerall = command = "as"
triggerall = command != "holddown"
triggerall = statetype = s
trigger1 = stateno = 250 && time > 12

[State -1, st. lk follow-up 2]
type = changestate
value = 255
triggerall = command = "as"
triggerall = command != "holddown"
triggerall = statetype = s
trigger1 = stateno = 255 && time > 11
trigger2 = stateno = 300 && time > 13

[State -1, st. mk]
type = changestate
value = 260
triggerall = command = "b"
triggerall = command != "holddown"
triggerall = statetype = s
trigger1 = ctrl
trigger2 = stateno = 52
trigger3 = stateno = 1501
trigger4 = stateno = 1005 && time > 14
trigger5 = movecontact && stateno = 320
trigger6 = movecontact && stateno = 330
trigger7 = movecontact && stateno = 270
trigger8 = movecontact && stateno = 220

[State -1, st. hk]
type = changestate
value = 270
triggerall = command = "c"
triggerall = command != "holddown"
triggerall = statetype = s
trigger1 = ctrl
trigger2 = stateno = 52
trigger3 = stateno = 1501
trigger4 = stateno = 1005 && time > 14

[State -1, st. lp]
type = ChangeState
value = 200
triggerall = command = "x"
triggerall = command != "holddown"
triggerall = statetype = S
trigger1 = ctrl
trigger2 = stateno = 52
trigger3 = stateno = 1501
trigger4 = stateno = 1005 && time > 14

[State -1, st. lp follow-up 1]
type = ChangeState
value = 205
triggerall = command = "xs"
triggerall = command != "holddown"
triggerall = statetype = S
trigger1 = stateno = 200 && time > 8

[State -1, st. lp, follow-up 2]
type = ChangeState
value = 200
triggerall = command = "xs"
triggerall = command != "holddown"
triggerall = statetype = S
trigger1 = stateno = 205 && time > 14

[State -1, st. mp]
type = ChangeState
value = 210
triggerall = command = "y"
triggerall = command != "holddown"
triggerall = statetype = S
trigger1 = ctrl
trigger2 = stateno = 52
trigger3 = stateno = 1501
trigger4 = stateno = 1005 && time > 14
trigger5 = movecontact && stateno = 320
trigger6 = movecontact && stateno = 330
trigger7 = movecontact && stateno = 270
trigger8 = movecontact && stateno = 220

[State -1, st. mp follow-up]
type = ChangeState
value = 215
triggerall = command = "ys"
triggerall = command != "holddown"
triggerall = statetype = S
trigger1 = stateno = 210 && time > 20
trigger2 = stateno = 340 && time > 18
trigger3 = stateno = 216 && time > 10

[State -1, st. mp follow-up 2]
type = changestate
value = 216
triggerall = command = "ys"
triggerall = command != "holddown"
triggerall = statetype = s
trigger1 = stateno = 215 && time > 20

[State -1, st. hp]
type = ChangeState
value = 220
triggerall = command = "z"
triggerall = command != "holddown"
triggerall = statetype = s
trigger1 = ctrl
trigger2 = stateno = 52
trigger3 = stateno = 1501
trigger4 = stateno = 1005 && time > 14
trigger5 = movehit && stateno = [350, 351]

[State -1, crouch from stand]
type = changestate
value = 0
triggerall = stateno = 52 || stateno = 1202
triggerall = statetype = s
trigger1 = command = "holddown"
trigger2 = command = "holdup"
ctrl = 1

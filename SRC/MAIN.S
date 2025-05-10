	include		"src/system/macros.i"
	include		"src/system/equates.i"
	include		"src/system/vectors.s"
	include		"src/system/error.s"
	include		"src/system/interrupt.s"
	include		"sound/src/tb.lib"
	include		"sound/src/eq.lib"
	include		"sound/src/mcr.lib"
	
	include		"src/init.s"
	
.loop:
	jsr		VSync
	btst	#bitL,	JOYPADPRESS
	bne.s	.sub1
	btst	#bitR,	JOYPADPRESS
	bne.s	.add1
	btst	#bitUp,	JOYPADPRESS
	bne.s	.add10
	btst	#bitDn,	JOYPADPRESS
	bne.s	.sub10
	btst	#bitB,	JOYPADPRESS
	bne.s	.stopSnd
	move.b	JOYPADPRESS,	d0
	and.b	#btnA+btnC,	d0
	tst.b	d0
	bne.s	.playSnd
	bra.s	.loop
	
.sub1
	sub.b	#1,	HEXADDR
	bsr.w	DispHex
	bra.s	.loop
.add1
	add.b	#1,	HEXADDR
	bsr.w	DispHex
	bra.s	.loop
.sub10
	sub.b	#$10,	HEXADDR
	bsr.w	DispHex
	bra.s	.loop
.add10
	add.b	#$10,	HEXADDR
	bsr.w	DispHex
	bra.s	.loop
.playSnd
	move.b	HEXADDR,sound_ram+buf1
	bra.w	.loop
.stopSnd
	move.b	#$E0,	sound_ram+buf1
	bra.w	.loop
	
	DefTXT	ASCIITXT1,	'SEGA SOUND SOURCE SOUND PLAYER'
	DefTXT	ASCIITXT2,	'SOUND HEX: XX'
	DefTXT	ASCIITXT3,	'SOUND DEC: XXX'
	DefTXT	ASCIITXT4,	'PRESS A OR C TO PLAY SOUND'
	DefTXT	ASCIITXT5,	'PRESS B TO STOP ALL SOUND'
	DefTXT	ASCIITXT6,	'PRESS LR TO SWITCH SOUND BY 1'
	DefTXT	ASCIITXT7,	'PRESS UD TO SWITCH SOUND BY 10 (16)'
	DefTXT	ASCIITXT8,	'CREATED BY MDTRAVIS'
	
	include		"src/system/vsync.s"
	include		"src/system/joypad.s"
	include		"src/sub/bcd.s"
	include		"src/sub/disphex.s"
	include		"src/sub/ascii.s"
	include		"src/sub/loadart.s"
ascii:	incbin	"art/ascii.art"
	ascii_end:
hex:	incbin	"art/hex.art"
	hex_end:

	align		$1000
	include		"sound/sound.s"
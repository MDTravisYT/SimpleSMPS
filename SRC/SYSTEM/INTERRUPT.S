VInt:
    movem.l d0-a6,-(sp)
	move.b	#0,	VSWAIT
	jsr		READJOYPADS
	jsr		sound
    movem.l (sp)+,d0-a6
HInt:
	rte
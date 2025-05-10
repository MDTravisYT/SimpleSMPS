;=======================================================;
;			*$$SNG81.S	(Song Data)						;
;						ORG. MDSNG111.S					;
;				'Sound-Source'							;
;				 for Mega Drive (68K)					;
;						Ver  1.0 / 2024.05.24			;
;									  By  MDTravis		;
;=======================================================;

;		public	S83

;		list off
;		include	mdEQ11.LIB
;		include	mdMCR11.LIB
;		include	mdTB11.LIB
;		list on

		even

;===============================================;
;												;
;					 ASSIGN						;
;												;
;===============================================;
;=====< S83 CHANNEL TOTAL >=====;
FM83	EQU		6				; FM Channel Total
PSG83	EQU		3				; PSG Channel Total
;=========< S83 TEMPO >=========;
TP83	EQU		1				; Tempo
DL83	EQU		3				; Delay
;==========< S83 BIAS >=========;
FB830	EQU		-12				; FM 0ch
FB831	EQU		0				; FM 1ch
FB832	EQU		-12				; FM 2ch
FB834	EQU		-12				; FM 4ch
FB835	EQU		-12				; FM 5ch
FB836	EQU		0				; FM 6ch (if don't use PCM drum)
PB838	EQU		-12*4			; PSG 80ch
PB83A	EQU		-12*4			; PSG A0ch
PB83C	EQU		0				; PSG C0ch
;==========< S83 VOLM >=========;
FA830	EQU		12H				; FM 0ch
FA831	EQU		0BH				; FM 1ch
FA832	EQU		14H				; FM 2ch
FA834	EQU		08H				; FM 4ch
FA835	EQU		20H				; FM 5ch
FA836	EQU		00H				; FM 6ch (if don't use PCM drum)
PA838	EQU		01H				; PSG 80ch
PA83A	EQU		03H				; PSG A0ch
PA83C	EQU		03H				; PSG C0ch
;==========< S83 ENVE >=========;
PE838	EQU		3				; PSG 80ch
PE83A	EQU		6				; PSG A0ch
PE83C	EQU		4				; PSG C0ch
;===========< VOICE >===========;
LOWBASS	EQU		4				;
MARINBA	EQU		19				;
BASS	EQU		23				;
LEAD	EQU		26				;
STRING1	EQU		28				;
STRING2	EQU		38				;
NEWV	EQU		2				;

;===============================================;
;												;
;					 HEADER						;
;												;
;===============================================;
S83:
		TDW		TIMB83,S83				; Voice Top Address
		DC.B	FM83,PSG83,TP83,DL83	; FM Total,PSG Total,Tempo,Delay

		TDW		TAB83D,S83				; PCM Drum Table Pointer
		DC.B	0,0						; Bias,Volm (Dummy)

		TDW		TAB830,S83				; FM 0ch Table Pointer
		DC.B	FB830,FA830				; Bias,Volm

		TDW		TAB831,S83				; FM 1ch Table Pointer
		DC.B	FB831,FA831				; Bias,Volm

		TDW		TAB832,S83				; FM 2ch Table Pointer
		DC.B	FB832,FA832				; Bias,Volm

		TDW		TAB834,S83				; FM 4ch Table Pointer
		DC.B	FB834,FA834				; Bias,Volm

		TDW		TAB835,S83				; FM 5ch Table Pointer
		DC.B	FB835,FA835				; Bias,Volm

		TDW		TAB838,S83				; PSG 80ch Table Pointer
		DC.B	PB838,PA838,0,PE838		; Bias,Volm,Dummy,Enve

		TDW		TAB83A,S83				; PSG A0ch Table Pointer
		DC.B	PB83A,PA83A,0,PE83A		; Bias,Volm,Dummy,Enve

		TDW		TAB83C,S83				; PSG C0ch Table Pointer
		DC.B	PB83C,PA83C,0,PE83C		; Bias,Volm,Dummy,Enve

;===============================================;
;												;
;				   SONG TABLE					;
;												;
;===============================================;
;===============================================;
;					 FM 0ch						;
;===============================================;
TAB830	EQU		*
		DC.B	FEV,MARINBA
		DC.B	LRPAN,RSET
		DC.B	CMCALL
		JDW		T830B
T830A	EQU		*
		DC.B	LRPAN,LSET
		DC.B	EN7,L8_3
		DC.B	LRPAN,RSET
		DC.B	CN7
		DC.B	CMVADD,1
		DC.B	CMREPT,0,14
		JDW		T830A
		DC.B	EN7,L8_3,NL,20
		DC.B	CMVADD,-21
		DC.B	LRPAN,LRSET
		DC.B	NL,L1+L4+L8_3,NL,NL,NL,NL,NL
T8300	EQU		*
		DC.B	FEV,LEAD
		DC.B	FVR,13,1,7,4
		DC.B	CMBIAS,-12
		DC.B	NL,L2
		DC.B	CMCALL
		JDW		T830C
		DC.B	CN6,L1+L4_3
		DC.B	CMCALL
		JDW		T830C
		DC.B	CN6,L4_3,L4_3,EN6
		DC.B	CMBIAS,12
		DC.B	FEV,LEAD
		DC.B	CMBIAS,-12
		DC.B	DN6,L1+L8_3,CMTAB,L1+L8_3,CN6,L4_3,DN6,EN6,L1+L4_3,CMTAB,L1+L4_3
		DC.B	CN6,L4_3,CN6,EN6,EF6,L1+L8_3,CMTAB,L1+L8_3,CN6,L4_3,EF6,DN6,L2+L8_3,CMTAB,L2+L8_3
		DC.B	FEV,STRING2
		DC.B	CMBIAS,-12
		DC.B	CMVADD,10
		DC.B	NL,L4_3,EN7,L4,NL,L8_3,CMGATE,11,EN7,L4_3,FN7,EN7,GN7,CMGATE,20,EN7,L4_3+L4_3,CMGATE,11,CN7,L4_3
		DC.B	CMGATE,0,CMVADD,-10
		DC.B	CMBIAS,12*2
		DC.B	NL,L4_3
		DC.B	CMJUMP
		JDW		T8300
T830B	EQU		*
		DC.B	AN6,L8_3,FN6,AN6,FN6,BN6,GN6,BN6,GN6,CN7,AN6,CN7,AN6,DN7,BN6,DN7,BN6
		DC.B	CMRET
T830C	EQU		*
		DC.B	CN7,L4_3,AN6,L4_3+L4_3,CN7,L4_3,BN6,L4_3+L4_3,CN7,L4_3,BN6,L4_3+L4_3
		DC.B	GN6,L1,AN6,L4_3,EN7,DN7,L4_3+L4_3,CN7,L4_3,BN6,L4_3+L4_3,CN7,L4_3
		DC.B	BN6,L4_3+L4_3,GN6,L1+L4_3,CN7,L4_3,AN6,L4_3+L4_3,CN7,L4_3,BN6,L4_3+L4_3
		DC.B	CN7,L4_3,BN6,L4_3+L4_3,GN6,L1,AN6,L4_3,L4_3,FN6,L4_3+L4_3,AN6,L4_3
		DC.B	GN6,L4_3+L4_3,AN6,L4_3,GN6,L4_3+L4_3
		DC.B	CMRET
;===============================================;
;					 FM 1ch						;
;===============================================;
TAB831	EQU		*
		DC.B	FEV,BASS
		DC.B	SET_TFLG,1
		DC.B	NL,L4_3,AN2,AN3,AN2,AS2,AS3,BN2,BN3
		DC.B	CMGATE,4
		DC.B	FEV,LOWBASS
T831A	EQU		*
		DC.B	CN3,L4_3
		DC.B	CMREPT,0,24
		JDW		T831A
		DC.B	CMGATE,0
		DC.B	CN3,L8_3,NL,CN3,L4_3,AN2,L8_3,NL,AN2,L4_3,AS2,L8_3,NL,AS2,L4_3,BN2,L8_3,NL,BN2,L4_3
		DC.B	CMGATE,4
T831B	EQU		*
		DC.B	CN3,L4_3
		DC.B	CMREPT,0,29
		JDW		T831B
		DC.B	CMGATE,0
		DC.B	CN3,DN3,EN3
T8310	EQU		*
		DC.B	FEV,LOWBASS
		DC.B	CMCALL
		JDW		T831C
		DC.B	CMCALL
		JDW		T831D
		DC.B	CN3,DN3,EN3
		DC.B	CMCALL
		JDW		T831C
		DC.B	CMCALL
		JDW		T831D
		DC.B	CN3,CN3,CN3
		DC.B	CMGATE,0,FEV,BASS
		DC.B	BF2,L2,AN2,GN2,FN2,EN2,L4_3,NL,DN2,NL,AN2,L2,BN2,CN3,DN3,EN3,L4_3,NL,AN3,NL,AF3,L2
		DC.B	GN3,FN3,EF3,DN3,L4_3,NL,CN3,NL,GN2,L2,DN3,GN2,GN3,L4_3,EN2,EN3,FN2,FN3,GN2,GN3
		DC.B	CMGATE,4,SET_TFLG,1
		DC.B	CMJUMP
		JDW		T8310
T831C	EQU		*
		DC.B	CMGATE,4,FN3,L4_3,FN3,FN3,FN3,FN3,FN3,FN3
		DC.B	CMGATE,0,FN3
		DC.B	CMGATE,4,EN3,EN3,EN3,EN3,EN3
		DC.B	CMGATE,0,CN3,DN3,EN3
		DC.B	CMGATE,4,FN3,FN3,FN3,FN3,FN3,FN3,FN3
		DC.B	CMGATE,0,FN3
		DC.B	CMGATE,4,EN3,EN3,EN3,EN3,EN3
		DC.B	CMGATE,0,CN3,DN3,EN3
		DC.B	CMRET
T831D	EQU		*
		DC.B	CMGATE,4,FN3,FN3,FN3,FN3,FN3,FN3,FN3
		DC.B	CMGATE,0,FN3
		DC.B	CMGATE,4,EN3,EN3,EN3,EN3,EN3,EN3,EN3
		DC.B	CMGATE,0,EN3
		DC.B	CMGATE,4,DN3,DN3,DN3,DN3,DN3,DN3,DN3
		DC.B	CMGATE,0,DN3
		DC.B	CMGATE,4,CN3,CN3,CN3,CN3,CN3
		DC.B	CMRET

;===============================================;
;					 FM 2ch						;
;===============================================;
TAB832	EQU		*
		DC.B	FEV,MARINBA
		DC.B	LRPAN,LSET
		DC.B	CMCALL
		JDW		T830B
		DC.B	FEV,STRING2
		DC.B	LRPAN,LRSET
		DC.B	CMBIAS,-12*2
		DC.B	CMVADD,-2
		DC.B	NL,L32_3
T832A	EQU		*
		DC.B	CN6,L32_3,CMTAB,BN5,L4+L16,NL,L4_3,AS5,L32_3,CMTAB,AN5,L4+L16,NL,L4_3
		DC.B	CMREPT,0,2
		JDW		T832A
		DC.B	CN6,L32_3,CMTAB,BN5,L8+L32_3,NL,L4_3,AS5,L32_3,CMTAB,AN5,L8+L32_3
		DC.B	NL,L4_3,CS6,L32_3,CMTAB,CN6,L4+L16,NL,L4_3,CN6,L32_3,CMTAB
		DC.B	BN5,L4+L16,NL,L4_3,AS5,L32_3,CMTAB,AN5,L4_3+L4_3,CMTAB,L1+L4-L32_3,NL,L8_3
T832B	EQU		*
		DC.B	AN5,L32_3,CMTAB,AN5,L4+L16,NL,L4_3,CN6,L32_3,CMTAB,BN5,L4+L16
		DC.B	NL,L4_3,CS6,L32_3,CMTAB,CN6,L8+L32_3,NL,L4_3
		DC.B	CMREPT,0,2
		JDW		T832B
		DC.B	CS6,L32_3,CMTAB,CN6,L4+L16,NL,L4_3,CN6,L32_3,CMTAB,BN5,L1-L4_3,CMTAB,L1+L4+L16_3
		DC.B	CMVADD,2
		DC.B	CMBIAS,12*2
T8320	EQU		*
		DC.B	FEV,STRING2
		DC.B	CMBIAS,-12*2
		DC.B	CMCALL
		JDW		T832C
		DC.B	AN6
		DC.B	CMCALL
		JDW		T832C
		DC.B	EN7
		DC.B	CMCALL
		JDW		T832C
		DC.B	AN6,NL,LF2,NL
		DC.B	CN7,L8_3,NL,L4,AN6,L4_3+L4_3,GN6,L8_3,NL,AN6,NL,CN7,NL,VROFF
		DC.B	CMCALL
		JDW		T832D
		DC.B	GN6,L8_3,AN6,CN7,L4_3,AN6
		DC.B	CMCALL
		JDW		T832D
		DC.B	GN6,L8_3,AN6,CN7,L4_3,EN7
		DC.B	CMCALL
		JDW		T832D
		DC.B	GN6,L8_3,AN6,CN7,L4_3,AN6
		DC.B	CMVADD,6
		DC.B	CN5,AN4,L8_3,NL,L2-L16_3,NL
		DC.B	CMVADD,-6
		DC.B	EN7,L4_3,NL,CN7,NL,AN6,AN6,AN6,L8_3,NL,CN7,NL,EN7,NL
		DC.B	FEV,STRING2,LRPAN,LRSET,CMGATE,30,CMVADD,6
		DC.B	FN5,L2,L2,L2,L2,L4_3,NL,FN5,NL,EN5,L2,L2,L2,L2,L4_3,NL,EN5,NL
		DC.B	EF5,L2,L2,L2,L2,L4_3,NL,EF5,NL,AN5,L2,L2,L2,L2,L4_3,NL,AN5,NL
		DC.B	CMVADD,-6,CMGATE,0,CMBIAS,12*2
		DC.B	CMJUMP
		JDW		T8320
T832C	EQU		*
		DC.B	NL,L1+L8_3,NL,GN6,L8_3,AN6,CN7,L4_3
		DC.B	CMRET
T832D	EQU		*
		DC.B	CMVADD,6
		DC.B	EN5,L4_3,CN5,L8_3,NL,LF4,NL,EN5,L4_3,CN5,L8_3,NL,DN5,L4_3,BN4,L8_3,NL,L4+L16_3,NL
		DC.B	CMVADD,-6
		DC.B	CMRET
		
;===============================================;
;					 FM 4ch						;
;===============================================;
TAB834	EQU		*
		DC.B	FEV,STRING2
		DC.B	NL,LF2-L8_3,NL
		DC.B	LRPAN,LSET
		DC.B	CMBIAS,-12*2
		DC.B	CMVADD,10
T834A	EQU		*
		DC.B	AF5,L32_3,CMTAB,GN5,L4+L16,NL,L4_3,FS5,L32_3,CMTAB,FN5,L4+L16,NL,L4_3
		DC.B	CMREPT,0,2
		JDW		T834A
		DC.B	AF5,L32_3,CMTAB,GN5,L8+L32_3,NL,L4_3,FS5,L32_3,CMTAB,FN5,L8+L32_3
		DC.B	NL,L4_3,BF5,L32_3,CMTAB,AN5,L4+L16,NL,L4_3,AF5,L32_3,CMTAB
		DC.B	GN5,L4+L16,NL,L4_3,FS5,L32_3,CMTAB,FN5,L4_3+L4_3,CMTAB,L1+L4-L32_3,NL,L8_3
T834B	EQU		*
		DC.B	FS5,L32_3,CMTAB,FN5,L4+L16,NL,L4_3,AF5,L32_3,CMTAB,GN5,L4+L16
		DC.B	NL,L4_3,BF5,L32_3,CMTAB,AN5,L8+L32_3,NL,L4_3
		DC.B	CMREPT,0,2
		JDW		T834B
		DC.B	BF5,L32_3,CMTAB,AN5,L4+L16,NL,L4_3,AF5,L32_3,CMTAB,GN5,L1-L4_3,CMTAB,L1+L4+L16
		DC.B	CMVADD,-10
		DC.B	CMBIAS,12*2
T8340	EQU		*
		DC.B	FEV,STRING2
		DC.B	CMBIAS,-12*2
		DC.B	CMVADD,24
		DC.B	LRPAN,LSET
		DC.B	CMVADD,-3
		DC.B	CMCALL
		JDW		T834C
		DC.B	DN5,DN5,EN5,EN5,CN5,CN5,AN4,AN4,FN4,FN4,DN5,DN5,BN4,BN4,GN4,GN4,DN5,DN5
		DC.B	CMCALL
		JDW		T834C
		DC.B	EN4,EN4,CN5,CN5,AN4,AN4,FN4,FN4,DN4,DN4,BN4,BN4
		DC.B	CMVADD,-10
		DC.B	CMBIAS,12*2
		DC.B	CMBIAS,-12
		DC.B	FEV,STRING1
		DC.B	GN6,L4_3+L4_3,AN6,BN6
		DC.B	CMVADD,-7
		DC.B	CN7,L1-L4_3,CMTAB,L1-L4_3,DN7,L4_3+L4_3,BN6,GN6
		DC.B	CN7,L1-L4_3,CMTAB,L1-L4_3,BN6,L4_3+L4_3,GN6,BN6
		DC.B	CN7,L1-L4_3,CMTAB,L1-L4_3,DN7,L4_3+L4_3,BN6,GN6
		DC.B	CN7,L1+L4+L8_3,CMTAB,L1+L4+L8_3
		DC.B	CMBIAS,-12,CMVADD,7,CMVADD,-24,FEV,STRING2,CMGATE,30,LRPAN,LRSET,CMVADD,18
		DC.B	DN5,L2,L2,L2,L2,L4_3,NL,DN5,NL,CN5,L2,L2,L2,L2,L4_3,NL,CN5,NL
		DC.B	CN5,L2,L2,L2,L2,L4_3,NL,CN5,NL,FN5,L2,L2,L2,L2,L4_3,NL,FN5,NL
		DC.B	CMVADD,-5,CMGATE,0,CMBIAS,12*2
		DC.B	CMJUMP
		JDW		T8340
T834C	EQU		*
		DC.B	EN5,L4_3,EN5,CN5,CN5,AN4,AN4,FN4,FN4,DN5,DN5,BN4,BN4,GN4,GN4
		DC.B	CMRET
		
;===============================================;
;					 FM 5ch						;
;===============================================;
TAB835	EQU		*
		DC.B	FEV,STRING2
		DC.B	NL,LF2-L8_3,NL
		DC.B	LRPAN,RSET
		DC.B	CMBIAS,-12*2
		DC.B	CMVADD,-14
T835A	EQU		*
		DC.B	FN5,L32_3,CMTAB,EN5,L4+L16,NL,L4_3,EF5,L32_3,CMTAB,DN5,L4+L16,NL,L4_3
		DC.B	CMREPT,0,2
		JDW		T835A
		DC.B	FN5,L32_3,CMTAB,EN5,L8+L32_3,NL,L4_3,EF5,L32_3,CMTAB,DN5,L8+L32_3
		DC.B	NL,L4_3,FS5,L32_3,CMTAB,FN5,L4+L16,NL,L4_3,FN5,L32_3,CMTAB
		DC.B	EN5,L4+L16,NL,L4_3,EF5,L32_3,CMTAB,DN5,L4_3+L4_3,CMTAB,L1+L4-L32_3,NL,L8_3
T835B	EQU		*
		DC.B	EF5,L32_3,CMTAB,DN5,L4+L16,NL,L4_3,FN6,L32_3,CMTAB,EN5,L4+L16
		DC.B	NL,L4_3,FS5,L32_3,CMTAB,FN5,L8+L32_3,NL,L4_3
		DC.B	CMREPT,0,2
		JDW		T835B
		DC.B	FS5,L32_3,CMTAB,FN5,L4+L16,NL,L4_3,FN5,L32_3,CMTAB,EN5,L1-L4_3,CMTAB,L1+L4+L16
		DC.B	CMBIAS,12*2
		DC.B	CMVADD,14
T8350	EQU		*
		DC.B	FEV,STRING2
		DC.B	CMBIAS,-12*2
		DC.B	LRPAN,RSET
		DC.B	CMVADD,-3
		DC.B	CMCALL
		JDW		T835G
		DC.B	DN5,DN5,EN5,EN5,CN5,CN5,AN4,AN4,FN4,FN4,DN5,DN5,BN4,BN4,GN4,GN4,DN5,DN5
		DC.B	CMCALL
		JDW		T835G
		DC.B	EN4,EN4,CN5,CN5,AN4,AN4,FN4,FN4,DN4,DN4,BN4,BN4
		DC.B	CMVADD,-10
		DC.B	CMBIAS,12*2
		DC.B	CMBIAS,-12
		DC.B	FEV,STRING1
		DC.B	GN6,L4_3+L4_3,AN6,BN6
		DC.B	CMVADD,-7
		DC.B	CN7,L1-L4_3,CMTAB,L1-L4_3,DN7,L4_3+L4_3,BN6,GN6
		DC.B	CN7,L1-L4_3,CMTAB,L1-L4_3,BN6,L4_3+L4_3,GN6,BN6
		DC.B	CN7,L1-L4_3,CMTAB,L1-L4_3,DN7,L4_3+L4_3,BN6,GN6
		DC.B	CN7,L1+L4+L8_3,CMTAB,L1+L4+L8_3
		DC.B	CMBIAS,12,CMGATE,0,FEV,STRING1,CMBIAS,-12,CMVADD,-6
T835C	EQU		*
		DC.B	BF6,L4_3,FN6,DN6,FN6,BF6,FN6,DN7,FN6,CMREPT,0,2
		JDW		T835C
T835D	EQU		*
		DC.B	AN6,EN6,CN7,EN6,AN6,EN6,CN7,EN6,CMREPT,0,2
		JDW		T835D
T835E	EQU		*
		DC.B	AF6,EF6,CN7,EF6,AF6,EF6,CN7,EF6,CMREPT,0,2
		JDW		T835E
T835F	EQU		*
		DC.B	CN7,AN6,EN7,AN6,CN7,AN6,EN7,AN6,CMREPT,0,2
		JDW		T835F
		DC.B	CMVADD,26,CMBIAS,12
		DC.B	CMJUMP
		JDW		T8350
T835G	EQU		*
		DC.B	EN5,L4_3,EN5,CN5,CN5,AN4,AN4,FN4,FN4,DN5,DN5,BN4,BN4,GN4,GN4
		DC.B	CMRET
		
;===============================================;
;					 PSG 80ch					;
;===============================================;
TAB838	EQU		*
		DC.B	EV,5
		DC.B	FVR,14,1,1,3
		DC.B	NL,L1+LF4-L16_3
		DC.B	CMGATE,16
		DC.B	EN5,L2,DN5,EN5,DN5,EN5,L4_3,NL,DN5,NL,FN5,L2,EN5
		DC.B	CMGATE,0
		DC.B	DN5,L1-L4_3,CMTAB,L1-L4_3
		DC.B	CMGATE,16
		DC.B	DN5,L2,EN5,FN5,L4+L8_3,DN5,L2,EN5,FN5,L4+L8_3,L2
		DC.B	CMGATE,0
		DC.B	EN5,L1+L8_3,CMTAB,L1+L8_3,VROFF
T8380	EQU		*
		DC.B	EV,1
T838A	EQU		*
		DC.B	NL,L4_3+L4_3,CN6,L8_3,NL,L2-L8_3,CN6,L4_3,NL,LF2-L8_3,BN5,L8_3,NL,L2-L8_3,BN5,L4_3,NL,L4_3+L4_3
		DC.B	CMREPT,1,3
		JDW		T838A
		DC.B	NL,L4_3+L4_3,AN5,L8_3,NL,L2-L8_3,AN5,L4_3,NL,LF2-L8_3,GN5,L8_3,NL,L2-L8_3,GN5,L4_3,NL,L4_3+L4_3
		DC.B	CMREPT,0,2
		JDW		T8380
		DC.B	EV,5
		DC.B	BF6,L2,AN6,GN6,FN6,EN6,L4_3,NL,DN6,NL,AN5,L2,BN5,CN6,DN6,EN6,L4_3,NL,AN6,NL,AF6,L2,GN6,FN6
		DC.B	EF6,DN6,L4_3+L4_3,CN6,L4_3,NL,NL,L4_3,GN6,AN6,GN6,L4_3+L4_3,L4_3,AN6,NL,L4_3+L4_3
		DC.B	PVADD,1
		DC.B	AN5,L2,L4_3,NL,AN5,NL
		DC.B	PVADD,-1
		DC.B	CMJUMP
		JDW		T8380

;===============================================;
;					 PSG A0ch					;
;===============================================;
TAB83A	EQU		*
		DC.B	NL,L1+LF4-L16_3
		DC.B	PVADD,-2
T83AA	EQU		*
		DC.B	CMGATE,6
		DC.B	CN7,L4_3,BN6,AN6,GN6,CN7,BN6,AN6,GN6
		DC.B	CMREPT,0,8
		JDW		T83AA
		DC.B	CMGATE,0
		
T83A0	EQU		*
		DC.B	EV,1
T83AB	EQU		*
		DC.B	NL,L4_3+L4_3,EN6,L8_3,NL,L2-L8_3,EN6,L4_3,NL,LF2-L8_3,DN6,L8_3,NL,L2-L8_3,DN6,L4_3,NL,L4_3+L4_3
		DC.B	CMREPT,1,3
		JDW		T83AB
		DC.B	NL,L4_3+L4_3,CN6,L8_3,NL,L2-L8_3,CN6,L4_3,NL,LF2-L8_3,BN5,L8_3,NL,L2-L8_3,BN5,L4_3,NL,L4_3+L4_3
		DC.B	CMREPT,0,2
		JDW		T83A0
		DC.B	DN6,L1+L8_3,CMTAB,L1+L8_3,CN6,L4_3,DN6,EN6,L1+L4_3,CMTAB,L1+L4_3,CN6
		DC.B	L4_3,CN6,EN6,EF6,L1+L8_3,CMTAB,L1+L8_3,CN6,L4_3,EF6,DN6
		DC.B	EV,5
		DC.B	CN6,L2,L2,L2,L2,L4_3,NL,CN5,NL
		DC.B	CMJUMP
		JDW		T83A0

;===============================================;
;					 PSG C0ch					;
;===============================================;
TAB83C	EQU		*
		DC.B	CMNOIS,NOIS7
		DC.B	CMGATE,6
		DC.B	0C6H,LF4-L16_3,LF4-L16_3,LF4-L16_3
T83C0	EQU		*
		DC.B	L4_3
		DC.B	CMJUMP
		JDW		T83C0

;===============================================;
;					 PCM DRUM					;
;===============================================;
TAB83D	EQU		*
		DC.B	NL,L4_3,B,S,B,B,S,S,S
T83DA	EQU		*
		DC.B	B,L4+L8_3,S,L4_3,B,L4+L8_3,L4_3,S,L4+L8_3
		DC.B	CMREPT,0,7
		JDW		T83DA
		DC.B	B,L4+L8_3,S,L4_3,B,L4+L8_3,S,L4_3,L4_3,L4_3
T83D0	EQU		*
		DC.B	B,L4_3+L4_3,S,L4_3,B,L4_3+L4_3,L4_3,S,L4_3+L4_3
		DC.B	CMREPT,0,7
		JDW		T83D0
		DC.B	B,L4_3+L4_3,S,L4_3,B,L4_3+L4_3,S,L4_3,L4_3,L4_3
		DC.B	CMREPT,1,2
		JDW		T83D0
		DC.B	CMJUMP
		JDW		T83D0
		
;===============================================;
;												;
;					  VOICE						;
;												;
;===============================================;
TIMB83	EQU		*
fev8200:
;----------------< @000 (  ) >----------------
fev9200:
	CNF	2,7
	MD	12,3,15,4,1,3,3,2
	RSAR	0,31,3,31,0,31,2,31
	D1R	12,2,12,5
	D2R	4,4,4,7
	RRL	15,1,15,15,15,0,15,2
	TL	32,57,30,0
;----------------< @001 (  ) >----------------
fev9201:
	CNF	1,5
	MD	2,1,2,1,8,5,2,5
	RSAR	0,31,0,31,0,31,0,31
	D1R	0,0,0,0
	D2R	0,0,0,0
	RRL	15,0,15,0,15,0,15,0
	TL	30,33,13,0
;----------------< @002 (  ) >----------------
fev9202:
	CNF	2,7
	MD	2,4,10,4,2,3,2,4
	RSAR	1,28,1,19,1,28,1,13
	D1R	7,9,7,4
	D2R	0,0,0,0
	RRL	15,1,15,3,15,1,15,0
	TL	27,24,51,0
;----------------< @003 (  ) >----------------
fev9203:
	CNF	2,7
	MD	1,6,12,3,4,1,1,3
	RSAR	2,28,3,27,2,28,3,26
	D1R	4,9,4,3
	D2R	3,1,3,0
	RRL	15,1,15,0,15,0,15,10
	TL	33,71,49,0
;----------------< @004 (  ) >----------------
fev9204:
	CNF	0,4
	MD	6,6,5,6,0,6,1,6
	RSAR	3,31,3,31,2,31,2,31
	D1R	7,6,9,6
	D2R	7,6,6,8
	RRL	15,2,15,1,15,1,15,15
	TL	28,58,22,0
;----------------< @005 (  ) >----------------
fev9205:
	CNF	5,7
	MD	5,6,8,2,2,0,1,6
	RSAR	3,31,0,31,0,31,0,31
	D1R	18,4,15,15
	D2R	0,0,0,0
	RRL	15,2,15,0,15,0,15,0
	TL	39,17,27,0
;----------------< @006 (  ) >----------------
fev9206:
	CNF	4,0
	MD	8,0,4,0,0,1,0,4
	RSAR	2,20,2,16,2,18,2,18
	D1R	2,2,2,2
	D2R	0,0,0,0
	RRL	15,0,15,0,15,0,15,0
	TL	31,27,31,0
;----------------< @007 (  ) >----------------
fev9207:
	CNF	3,7
	MD	6,0,6,3,3,6,3,3
	RSAR	3,31,1,20,3,16,2,15
	D1R	9,7,11,4
	D2R	3,0,0,0
	RRL	15,14,15,15,15,2,15,0
	TL	40,51,38,0
;----------------< @008 (  ) >----------------
fev9208:
	CNF	2,7
	MD	1,6,9,6,2,6,4,6
	RSAR	3,25,3,28,1,22,1,20
	D1R	11,12,0,6
	D2R	0,12,0,0
	RRL	15,1,15,5,15,1,15,0
	TL	31,40,50,0
;----------------< @009 (  ) >----------------
fev9209:
	CNF	3,7
	MD	1,3,2,3,4,3,1,3
	RSAR	1,31,0,19,1,31,1,19
	D1R	0,11,15,15
	D2R	0,0,0,0
	RRL	15,0,15,4,15,0,15,0
	TL	39,36,51,0
;----------------< @011 (  ) >----------------
fev920A:
	CNF	2,7
	MD	12,3,15,4,1,3,3,2
	RSAR	0,31,3,31,0,31,2,31
	D1R	12,2,12,5
	D2R	4,4,4,7
	RRL	15,1,15,15,15,0,15,2
	TL	32,57,30,0
;----------------< @013 (  ) >----------------
fev920B:
	CNF	4,7
	MD	1,2,1,4,3,5,1,1
	RSAR	3,31,2,25,3,31,2,25
	D1R	0,7,0,8
	D2R	8,7,8,6
	RRL	15,4,15,3,15,4,15,3
	TL	32,10,28,0
;----------------< @021 (  ) >----------------
fev920C:
	CNF	2,7
	MD	2,3,6,5,2,3,2,4
	RSAR	2,13,1,15,0,21,1,18
	D1R	6,8,7,4
	D2R	2,0,0,0
	RRL	15,1,15,1,15,2,15,2
	TL	25,32,42,0
;----------------< @023 (  ) >----------------
fev920D:
	CNF	2,7
	MD	1,3,7,3,1,3,1,3
	RSAR	2,13,2,13,2,14,1,19
	D1R	14,14,14,3
	D2R	0,0,0,0
	RRL	15,1,15,15,15,1,15,0
	TL	23,40,38,0
;----------------< @024 (  ) >----------------
fev920E:
	CNF	2,7
	MD	1,4,5,4,1,3,1,4
	RSAR	1,25,1,25,1,28,1,14
	D1R	10,11,13,4
	D2R	0,0,0,0
	RRL	15,1,15,5,15,2,15,0
	TL	29,15,48,0
;----------------< @027 (  ) >----------------
fev920F:
	CNF	4,3
	MD	15,6,1,3,1,3,1,3
	RSAR	2,31,3,27,2,30,1,30
	D1R	15,7,6,6
	D2R	8,10,11,0
	RRL	15,8,15,8,15,15,15,15
	TL	25,32,42,0
;----------------< @030 (  ) ( BASS ) >----------------
fev9210:
	CNF	0,4
	MD	6,6,5,6,0,6,1,6
	RSAR	3,31,3,31,2,31,2,31
	D1R	7,6,9,6
	D2R	7,6,6,8
	RRL	15,2,15,1,15,1,15,15
	TL	28,58,22,0
;----------------< @034 (  ) >----------------
fev9211:
	CNF	7,3
	MD	6,1,1,6,3,0,2,5
	RSAR	0,28,2,31,0,31,0,31
	D1R	18,15,15,15
	D2R	0,0,0,0
	RRL	15,15,15,0,15,0,15,0
	TL	17,10,10,0
;----------------< @037 (  ) >----------------
fev9212:
	CNF	3,7
	MD	6,0,6,3,3,6,3,3
	RSAR	3,31,1,20,3,16,2,15
	D1R	9,7,11,4
	D2R	3,0,0,0
	RRL	15,14,15,15,15,2,15,0
	TL	40,51,38,0
;----------------< @040 (  ) >----------------
fev9213:
	CNF	4,3
	MD	11,6,1,3,7,3,1,0
	RSAR	3,31,3,30,1,31,3,30
	D1R	14,9,16,7
	D2R	0,7,5,4
	RRL	15,15,15,1,15,10,15,1
	TL	33,21,23,0
;----------------< @043 (  ) >----------------
fev9214:
	CNF	0,7
	MD	3,6,4,6,1,6,1,6
	RSAR	3,26,3,29,3,28,3,31
	D1R	8,5,4,10
	D2R	5,4,2,3
	RRL	15,2,15,1,15,3,15,1
	TL	30,30,30,0
;----------------< @059 (  ) >----------------
fev9215:
	CNF	3,7
	MD	15,2,8,2,7,3,2,3
	RSAR	0,31,0,31,0,31,0,31
	D1R	21,21,21,19
	D2R	19,12,13,16
	RRL	15,2,15,2,15,3,15,2
	TL	0,35,20,0
;----------------< @067 (  ) >----------------
fev9216:
	CNF	3,7
	MD	6,0,6,3,3,6,2,3
	RSAR	3,31,1,20,3,16,2,15
	D1R	9,7,11,4
	D2R	3,0,0,0
	RRL	15,14,15,15,15,2,15,0
	TL	40,41,28,0
;----------------< @070 (  ) >----------------
fev9217:
	CNF	0,7
	MD	10,3,0,3,0,3,0,3
	RSAR	0,31,0,31,1,31,1,31
	D1R	18,14,10,10
	D2R	0,4,4,3
	RRL	15,2,15,2,15,2,15,2
	TL	36,45,18,0
;----------------< @073 (  ) >----------------
fev9218:
	CNF	6,7
	MD	2,4,2,4,2,3,2,6
	RSAR	0,31,0,31,1,31,1,31
	D1R	21,14,15,15
	D2R	21,11,23,10
	RRL	15,15,15,15,15,5,15,6
	TL	0,0,0,0
;----------------< @079 (  ) >----------------
fev9219:
	CNF	6,2
	MD	5,3,3,3,0,3,0,3
	RSAR	0,31,0,31,0,31,0,31
	D1R	12,11,10,8
	D2R	4,2,3,5
	RRL	15,1,15,15,15,0,15,2
	TL	28,35,15,25
;----------------< @080 (  ) >----------------
fev921A:
	CNF	4,0
	MD	2,7,2,4,2,3,2,3
	RSAR	0,18,0,18,0,18,0,18
	D1R	0,0,0,0
	D2R	0,0,0,0
	RRL	15,0,15,0,15,0,15,0
	TL	35,0,35,0
;----------------< @088 (  ) >----------------
fev921B:
	CNF	5,5
	MD	1,4,1,4,2,4,2,4
	RSAR	0,20,0,20,0,20,0,20
	D1R	10,10,10,10
	D2R	0,0,2,0
	RRL	15,1,15,2,15,3,15,2
	TL	33,16,16,16
;----------------< @090 (  ) >----------------
fev921C:
	CNF	4,5
	MD	2,7,8,7,4,3,4,3
	RSAR	0,31,0,18,0,31,0,18
	D1R	0,10,0,10
	D2R	0,0,0,0
	RRL	15,0,15,1,15,0,15,1
	TL	22,16,23,16
;----------------< @091 (  ) >----------------
fev921D:
	CNF	4,7
	MD	2,3,2,3,1,7,2,4
	RSAR	0,31,0,24,0,31,0,30
	D1R	7,31,7,31
	D2R	0,0,0,0
	RRL	15,1,15,0,15,1,15,0
	TL	30,16,12,16
;----------------< @093 (  ) >----------------
fev921E:
	CNF	4,6
	MD	3,3,1,4,14,7,4,7
	RSAR	1,27,2,31,1,31,0,31
	D1R	4,7,7,8
	D2R	0,0,0,0
	RRL	15,15,15,15,15,14,15,15
	TL	35,16,41,23
;----------------< @097 (  ) >----------------
fev921F:
	CNF	0,7
	MD	3,6,1,3,1,3,1,3
	RSAR	0,16,0,19,0,26,0,27
	D1R	14,0,0,0
	D2R	0,0,0,0
	RRL	15,3,15,0,15,0,15,0
	TL	26,25,26,0
;----------------< @098 (  ) >----------------
fev9220:
	CNF	6,7
	MD	15,6,0,3,0,3,0,3
	RSAR	0,31,0,31,0,31,0,31
	D1R	13,17,17,12
	D2R	5,10,4,9
	RRL	15,2,15,5,15,10,15,8
	TL	0,3,4,8
;----------------< @099 (  ) >----------------
fev9221:
	CNF	3,7
	MD	2,3,4,0,6,6,4,0
	RSAR	1,29,1,29,1,29,1,10
	D1R	0,0,0,0
	D2R	0,0,0,0
	RRL	15,0,15,0,15,0,15,0
	TL	30,30,40,9
;----------------< @103 (  ) >----------------
fev9222:
	CNF	0,0
	MD	0,6,2,3,2,3,0,3
	RSAR	0,6,0,6,0,8,0,14
	D1R	6,0,0,4
	D2R	2,0,0,4
	RRL	15,3,15,2,15,2,15,4
	TL	16,25,26,0
;----------------< @104 (  ) >----------------
fev9223:
	CNF	1,7
	MD	4,0,2,0,4,0,2,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	0,0,0,0
	D2R	0,0,0,0
	RRL	15,0,15,0,15,0,15,0
	TL	27,50,40,0
;----------------< @105 (  ) >----------------
fev9224:
	CNF	4,5
	MD	4,7,2,7,4,3,2,3
	RSAR	0,31,0,18,0,31,0,31
	D1R	0,10,0,10
	D2R	0,4,0,4
	RRL	15,0,15,1,15,0,15,1
	TL	22,16,23,16
;----------------< @107 (  ) >----------------
fev9225:
	CNF	2,7
	MD	0,6,7,6,0,6,1,6
	RSAR	0,31,2,20,0,31,0,31
	D1R	15,16,5,13
	D2R	7,6,6,7
	RRL	15,2,15,4,15,1,15,5
	TL	33,18,52,0
;----------------< @108 (  ) >----------------
fev9226:
	CNF	4,5
	MD	4,7,4,7,4,3,4,3
	RSAR	0,31,0,18,0,31,0,31
	D1R	0,0,0,0
	D2R	0,1,0,1
	RRL	15,0,15,3,15,0,15,3
	TL	22,00,23,0
;----------------< @109 (  ) >----------------
fev9227:
	CNF	4,7
	MD	8,7,8,7,4,3,4,3
	RSAR	0,31,0,18,0,31,0,31
	D1R	0,15,0,15
	D2R	0,1,0,1
	RRL	15,0,15,3,15,0,15,3
	TL	33,16,24,7
;----------------< @110 (  ) >----------------
fev9228:
	CNF	4,7
	MD	8,7,8,7,4,3,4,3
	RSAR	0,31,0,18,0,31,0,31
	D1R	0,15,0,15
	D2R	0,9,0,9
	RRL	15,0,15,3,15,0,15,3
	TL	33,16,24,7
;----------------< @111 (  ) >----------------
fev9229:
	CNF	4,5
	MD	2,7,2,7,2,3,2,3
	RSAR	0,31,0,18,0,31,0,31
	D1R	0,15,0,15
	D2R	0,9,0,9
	RRL	15,0,15,3,15,0,15,3
	TL	21,16,20,16
;----------------< @112 (  ) >----------------
fev922A:
	CNF	2,7
	MD	0,6,7,6,0,6,1,6
	RSAR	0,31,2,20,0,31,0,31
	D1R	15,16,5,8
	D2R	7,6,6,7
	RRL	15,2,15,4,15,1,15,5
	TL	33,18,52,0
;----------------< @116 (  ) >----------------
fev922B:
	CNF	4,5
	MD	3,7,3,7,4,3,4,3
	RSAR	0,31,0,18,0,31,0,31
	D1R	0,15,0,15
	D2R	0,1,0,1
	RRL	15,0,15,3,15,0,15,3
	TL	22,0,23,0
;----------------< @118 (  ) >----------------
fev922C:
	CNF	4,7
	MD	8,7,8,7,4,3,4,3
	RSAR	0,31,0,18,0,31,0,31
	D1R	0,14,0,14
	D2R	0,12,0,12
	RRL	15,0,15,3,15,0,15,3
	TL	33,16,24,7
;----------------< @119 (  ) >----------------
fev922D:
	CNF	2,5
	MD	1,2,9,3,1,3,4,7
	RSAR	0,30,0,31,0,31,0,31
	D1R	23,27,2,3
	D2R	0,8,3,11
	RRL	15,3,15,3,15,0,15,6
	TL	28,18,41,16
;----------------< @121 (  ) >----------------
fev922E:
	CNF	4,6
	MD	4,3,11,4,4,7,15,7
	RSAR	1,27,2,31,1,31,0,31
	D1R	4,7,7,8
	D2R	0,0,0,0
	RRL	15,15,15,15,15,14,15,15
	TL	35,16,41,0
;----------------< @130 (  ) >----------------
fev922F:
	CNF	2,7
	MD	0,6,6,6,0,6,1,6
	RSAR	0,31,2,20,0,31,0,31
	D1R	15,16,5,13
	D2R	7,6,6,7
	RRL	15,2,15,4,15,1,15,5
	TL	33,20,40,0
;----------------< @131 (  ) >----------------
fev9230:
	CNF	0,7
	MD	10,6,10,3,1,7,1,3
	RSAR	0,20,0,20,0,16,0,14
	D1R	5,8,2,8
	D2R	0,0,0,0
	RRL	15,0,15,0,15,0,15,0
	TL	40,51,29,0
;----------------< @152 (  ) >----------------
fev9231:
	CNF	3,7
	MD	15,7,15,7,0,3,1,3
	RSAR	3,31,0,31,0,31,3,31
	D1R	0,0,0,1
	D2R	0,0,0,2
	RRL	15,0,15,0,15,1,15,10
	TL	34,34,0,0
;----------------< @159 (  ) >----------------
fev9232:
	CNF	2,7
	MD	1,7,12,0,3,3,1,0
	RSAR	2,28,2,22,1,29,2,15
	D1R	4,9,4,9
	D2R	0,1,3,0
	RRL	15,1,15,1,15,1,15,10
	TL	37,47,37,0
;----------------< @164 (  ) >----------------
fev9233:
	CNF	3,7
	MD	3,0,1,0,0,3,1,0
	RSAR	0,28,3,28,3,28,1,30
	D1R	29,19,15,12
	D2R	12,5,10,7
	RRL	15,10,15,10,15,5,15,6
	TL	22,17,17,0
;----------------< @165 (  ) >----------------
fev9234:
	CNF	2,7
	MD	0,0,4,0,0,0,1,7
	RSAR	0,18,0,18,0,18,0,30
	D1R	0,0,0,8
	D2R	0,0,0,0
	RRL	15,0,15,3,15,0,15,1
	TL	36,47,42,0
;----------------< @170 (  ) >----------------
fev9235:
	CNF	2,7
	MD	8,3,10,4,0,4,1,3
	RSAR	0,31,3,31,0,31,2,31
	D1R	12,10,12,15
	D2R	4,4,4,10
	RRL	15,1,15,15,15,0,15,3
	TL	32,65,13,0
;----------------< @171 (  ) >----------------
fev9236:
	CNF	2,7
	MD	1,7,12,0,3,3,1,0
	RSAR	1,28,1,22,1,29,1,31
	D1R	4,9,4,10
	D2R	0,1,3,0
	RRL	15,1,15,1,15,1,15,10
	TL	37,47,25,0
;----------------< @172 (  ) >----------------
fev9237:
	CNF	1,0
	MD	7,0,0,0,0,0,0,0
	RSAR	0,31,0,31,0,31,0,31
	D1R	20,10,14,31
	D2R	0,0,0,0
	RRL	15,5,15,5,15,10,15,0
	TL	30,20,23,0
;----------------< @173 (  ) >----------------
fev9238:
	CNF	4,5
	MD	4,7,2,7,4,3,2,3
	RSAR	0,13,0,21,0,13,0,21
	D1R	0,10,0,10
	D2R	0,4,0,4
	RRL	15,0,15,2,15,0,15,2
	TL	14,16,14,16
;----------------< @175 (  ) >----------------
fev9239:
	CNF	4,5
	MD	3,7,3,7,4,3,4,3
	RSAR	0,31,0,18,0,31,0,31
	D1R	0,15,0,15
	D2R	0,1,0,1
	RRL	15,0,15,3,15,0,15,3
	TL	42,16,1,16
;----------------< @198 (  ) ( BASS ) >----------------
fev923A:
	CNF	4,7
	MD	2,5,6,3,3,6,2,5
	RSAR	3,31,1,25,3,15,2,10
	D1R	10,10,1,5
	D2R	20,20,10,20
	RRL	15,10,15,5,15,10,15,5
	TL	30,5,40,2
;----------------< @199 (  ) >----------------
fev923B:
	CNF	0,7
	MD	0,2,2,6,0,7,0,3
	RSAR	0,20,0,18,0,10,0,10
	D1R	14,14,9,31
	D2R	0,0,0,0
	RRL	15,5,15,5,15,10,15,0
	TL	28,40,20,5
;----------------< @218 (  ) >----------------
fev923C:
	CNF	2,7
	MD	12,3,15,4,1,3,3,2
	RSAR	0,31,3,31,0,31,2,31
	D1R	12,2,12,5
	D2R	4,4,4,7
	RRL	15,1,15,15,15,0,15,2
	TL	32,57,30,0

; vim: set ft=asm68k sw=4 ts=4 noet:

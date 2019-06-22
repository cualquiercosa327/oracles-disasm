; Main file for Oracle of Seasons, US version

.include "include/rominfo.s"
.include "include/emptyfill.s"
.include "include/constants.s"
.include "include/structs.s"
.include "include/wram.s"
.include "include/hram.s"
.include "include/macros.s"
.include "include/script_commands.s"
.include "include/simplescript_commands.s"
.include "include/movementscript_commands.s"

.include "objects/macros.s"
.include "include/gfxDataMacros.s"
.include "include/musicMacros.s"

.include "build/textDefines.s"


.BANK $00 SLOT 0
.ORG 0


	add a			; $0000
	pop hl			; $0001
	add l			; $0002
	ld l,a			; $0003
	jr nc,_label_00_000	; $0004
	inc h			; $0006
_label_00_000:
	ldi a,(hl)		; $0007
	ld h,(hl)		; $0008
	ld l,a			; $0009
	jp hl			; $000a
	nop			; $000b
	nop			; $000c
	nop			; $000d
	nop			; $000e
	nop			; $000f
	add l			; $0010
	ld l,a			; $0011
	ret nc			; $0012
	inc h			; $0013
	ret			; $0014
	nop			; $0015
	nop			; $0016
	nop			; $0017
	push bc			; $0018
	ld c,a			; $0019
	ld b,$00		; $001a
	add hl,bc		; $001c
	add hl,bc		; $001d
	pop bc			; $001e
	ret			; $001f
	nop			; $0020
	nop			; $0021
	nop			; $0022
	nop			; $0023
	nop			; $0024
	nop			; $0025
	nop			; $0026
	nop			; $0027
	nop			; $0028
	nop			; $0029
	nop			; $002a
	nop			; $002b
	nop			; $002c
	nop			; $002d
	nop			; $002e
	nop			; $002f
	nop			; $0030
	nop			; $0031
	nop			; $0032
	nop			; $0033
	nop			; $0034
	nop			; $0035
	nop			; $0036
	nop			; $0037
	nop			; $0038
	nop			; $0039
	nop			; $003a
	pop hl			; $003b
	pop de			; $003c
	pop bc			; $003d
	pop af			; $003e
	reti			; $003f
	push af			; $0040
	push bc			; $0041
	push de			; $0042
	push hl			; $0043
	jp vblankInterrupt		; $0044
	nop			; $0047
	push af			; $0048
	push hl			; $0049
	jp lcdInterrupt		; $004a
	nop			; $004d
	nop			; $004e
	nop			; $004f
	ei			; $0050
	push af			; $0051
	push bc			; $0052
	push de			; $0053
	push hl			; $0054
	jp timerInterrupt		; $0055
	push af			; $0058
	jp serialInterrupt		; $0059
	nop			; $005c
	nop			; $005d
	nop			; $005e
	nop			; $005f
	reti			; $0060
	nop			; $0061
	nop			; $0062
	nop			; $0063
	nop			; $0064
	nop			; $0065
	nop			; $0066
	nop			; $0067

addAToDe:
	add e			; $0068
	ld e,a			; $0069
	ret nc			; $006a
	inc d			; $006b
	ret			; $006c

addAToBc:
	add c			; $006d
	ld c,a			; $006e
	ret nc			; $006f
	inc b			; $0070
	ret			; $0071

addDoubleIndexToDe:
	push hl			; $0072
	add a			; $0073
	ld l,a			; $0074
	ld a,$00		; $0075
	adc a			; $0077
	ld h,a			; $0078
	add hl,de		; $0079
	ld e,l			; $007a
	ld d,h			; $007b
	pop hl			; $007c
	ret			; $007d

addDoubleIndexToBc:
	push hl			; $007e
	add a			; $007f
	ld l,a			; $0080
	ld a,$00		; $0081
	adc a			; $0083
	ld h,a			; $0084
	add hl,bc		; $0085
	ld c,l			; $0086
	ld b,h			; $0087
	pop hl			; $0088
	ret			; $0089

interBankCall:
	ld a,($ff97)		; $008a
	push af			; $008d
	ld a,e			; $008e
	ld ($ff97),a		; $008f
	ld ($2222),a		; $0092
	call jpHl		; $0095
	pop af			; $0098
	ld ($ff97),a		; $0099
	ld ($2222),a		; $009c
	ret			; $009f

jpHl:
	jp hl			; $00a0

secretSymbols:
	.asc "BDFGHJLM"
	.db $13 $bd $12 $11 $23
	.asc "NQRSTWY!"
	.db $10 $7e $7f $2b $2d
	.asc "bdfghjm$*/:~"
	.asc "nqrstwy?%&<=>"
	.asc "23456789"
	.db $15 $16 $17 $18 $40

	.db $00 ; Null terminator

; Filler?
	.DB         $00 $00 $00 $00 $00 $ff	; $00e2
	.DB $00 $00 $00 $00 $00 $00 $00 $00	; $00e8
	.DB $00 $00 $00 $00 $00 $00 $00 $00	; $00f0

bitTable:
	.db $01 $02 $04 $08 $10 $20 $40 $80	; $00f8

; Entry point
	nop			; $0100
	jp begin		; $0101


; ROM title / manufacturer code
.ORGA $134
	.asc "ZELDA DIN" 0 0
	.asc "AZ7E"


.ORGA $150

begin:
	nop			; $0150
	di			; $0151
	cp $11			; $0152
	ld a,$00		; $0154
	jr nz,_label_00_003	; $0156
	inc a			; $0158
	bit 0,b			; $0159
	jr z,_label_00_003	; $015b
	ld a,$ff		; $015d
_label_00_003:
	ldh (<hGameboyType),a	; $015f
	ld a,$37		; $0161
	ldh (<hRng1),a	; $0163
	ld a,$0d		; $0165
	ldh (<hRng2),a	; $0167

resetGame:
	ld sp,$c110		; $0169
	ld a,$03		; $016c
	ldh (<hRomBank),a	; $016e
	ld ($2222),a		; $0170
	jp $4000		; $0173

getNumSetBits:
	ld b,$00		; $0176
_label_00_004:
	add a			; $0178
	jr nc,_label_00_005	; $0179
	inc b			; $017b
_label_00_005:
	or a			; $017c
	jr nz,_label_00_004	; $017d
_label_00_006:
	ld a,b			; $017f
	ret			; $0180

addDecimalToHlRef:
	ld a,(hl)		; $0181
	add c			; $0182
	daa			; $0183
	ldi (hl),a		; $0184
	ld a,(hl)		; $0185
	adc b			; $0186
	daa			; $0187
	ldd (hl),a		; $0188
	ret nc			; $0189
	ld a,$63		; $018a
	ldi (hl),a		; $018c
	ldd (hl),a		; $018d
	ret			; $018e

subDecimalFromHlRef:
	ld a,(hl)		; $018f
	sub c			; $0190
	daa			; $0191
	ldi (hl),a		; $0192
	ld a,(hl)		; $0193
	sbc b			; $0194
	daa			; $0195
	ldd (hl),a		; $0196
	ret nc			; $0197
	xor a			; $0198
	ldi (hl),a		; $0199
	ldd (hl),a		; $019a
	scf			; $019b
	ret			; $019c

multiplyAByC:
	ld e,$08		; $019d
	ld b,$00		; $019f
	ld l,b			; $01a1
	ld h,b			; $01a2
_label_00_007:
	add hl,hl		; $01a3
	add a			; $01a4
	jr nc,_label_00_008	; $01a5
	add hl,bc		; $01a7
_label_00_008:
	dec e			; $01a8
	jr nz,_label_00_007	; $01a9
	ret			; $01ab

multiplyABy16:
	swap a			; $01ac
	ld b,a			; $01ae
	and $f0			; $01af
	ld c,a			; $01b1
	ld a,b			; $01b2
	and $0f			; $01b3
	ld b,a			; $01b5
	ret			; $01b6

multiplyABy8:
	swap a			; $01b7
	rrca			; $01b9
	ld b,a			; $01ba
	and $f8			; $01bb
	ld c,a			; $01bd
	ld a,b			; $01be
	and $07			; $01bf
	ld b,a			; $01c1
	ret			; $01c2

multiplyABy4:
	ld b,$00		; $01c3
	add a			; $01c5
	rl b			; $01c6
	add a			; $01c8
	rl b			; $01c9
	ld c,a			; $01cb
	ret			; $01cc

s8ToS16:
	ld b,$ff		; $01cd
	bit 7,a			; $01cf
	jr nz,_label_00_009	; $01d1
	inc b			; $01d3
_label_00_009:
	ld c,a			; $01d4
	ret			; $01d5

compareHlToBc:
	ld a,h			; $01d6
	cp b			; $01d7
	jr c,_label_00_010	; $01d8
	jr nz,_label_00_011	; $01da
	ld a,l			; $01dc
	cp c			; $01dd
	jr c,_label_00_010	; $01de
	jr nz,_label_00_011	; $01e0
	xor a			; $01e2
	ret			; $01e3
_label_00_010:
	ld a,$ff		; $01e4
	ret			; $01e6
_label_00_011:
	ld a,$01		; $01e7
	ret			; $01e9

getHighestSetBit:
	or a			; $01ea
	ret z			; $01eb
	push bc			; $01ec
	ld c,$ff		; $01ed
_label_00_012:
	inc c			; $01ef
	srl a			; $01f0
	jr nz,_label_00_012	; $01f2
	ld a,c			; $01f4
	pop bc			; $01f5
	scf			; $01f6
	ret			; $01f7

getLowestSetBit:
	or a			; $01f8
	ret z			; $01f9
	push bc			; $01fa
	ld c,$08		; $01fb
_label_00_013:
	dec c			; $01fd
	add a			; $01fe
	jr nz,_label_00_013	; $01ff
	ld a,c			; $0201
	pop bc			; $0202
	scf			; $0203
	ret			; $0204

checkFlag:
	push hl			; $0205
	push bc			; $0206
	call _flagHlpr		; $0207
	and (hl)		; $020a
	pop bc			; $020b
	pop hl			; $020c
	ret			; $020d

setFlag:
	push hl			; $020e
	push bc			; $020f
	call _flagHlpr		; $0210
	or (hl)			; $0213
	ld (hl),a		; $0214
	pop bc			; $0215
	pop hl			; $0216
	ret			; $0217

unsetFlag:
	push hl			; $0218
	push bc			; $0219
	call _flagHlpr		; $021a
	cpl			; $021d
	and (hl)		; $021e
	ld (hl),a		; $021f
	pop bc			; $0220
	pop hl			; $0221
	ret			; $0222

_flagHlpr:
	ld b,a			; $0223
	and $f8			; $0224
	rlca			; $0226
	swap a			; $0227
	ld c,a			; $0229
	ld a,b			; $022a
	ld b,$00		; $022b
	add hl,bc		; $022d
	and $07			; $022e
	ld bc,bitTable		; $0230
	add c			; $0233
	ld c,a			; $0234
	ld a,(bc)		; $0235
	ret			; $0236

decHlRef16WithCap:
	inc hl			; $0237
	ldd a,(hl)		; $0238
	or (hl)			; $0239
	ret z			; $023a
	ld a,(hl)		; $023b
	sub $01			; $023c
	ldi (hl),a		; $023e
	ld a,(hl)		; $023f
	sbc $00			; $0240
	ldd (hl),a		; $0242
	or (hl)			; $0243
	ret			; $0244

incHlRefWithCap:
	inc (hl)		; $0245
	ret nz			; $0246
	ld (hl),$ff		; $0247
	ret			; $0249

incHlRef16WithCap:
	inc (hl)		; $024a
	ret nz			; $024b
	inc hl			; $024c
	inc (hl)		; $024d
	jr z,_label_00_014	; $024e
	dec hl			; $0250
	ret			; $0251
_label_00_014:
	push af			; $0252
	ld a,$ff		; $0253
	ldd (hl),a		; $0255
	ld (hl),a		; $0256
	pop af			; $0257
	ret			; $0258

hexToDec:
	ld bc,$0000		; $0259
_label_00_015:
	cp $64			; $025c
	jr c,_label_00_016	; $025e
	sub $64			; $0260
	inc b			; $0262
	jr _label_00_015		; $0263
_label_00_016:
	cp $0a			; $0265
	ret c			; $0267
	sub $0a			; $0268
	inc c			; $026a
	jr _label_00_016		; $026b

pollInput:
	ld c,$00		; $026d
	ld a,$20		; $026f
	ld ($ff00+c),a		; $0271
	ld a,($ff00+c)		; $0272
	ld a,($ff00+c)		; $0273
	ld a,($ff00+c)		; $0274
	ld b,a			; $0275
	ld a,$10		; $0276
	ld ($ff00+c),a		; $0278
	ld a,b			; $0279
	and $0f			; $027a
	swap a			; $027c
	ld b,a			; $027e
	ld hl,$c481		; $027f
	ldd a,(hl)		; $0282
	ldi (hl),a		; $0283
	cpl			; $0284
	ld (hl),a		; $0285
	ld a,($ff00+c)		; $0286
	ld a,($ff00+c)		; $0287
	and $0f			; $0288
	or b			; $028a
	cpl			; $028b
	ld b,(hl)		; $028c
	ldi (hl),a		; $028d
	and b			; $028e
	ld (hl),a		; $028f
	ld a,$30		; $0290
	ld ($ff00+c),a		; $0292
	ret			; $0293

getInputWithAutofire:
	push hl			; $0294
	push bc			; $0295
	ld a,($c481)		; $0296
	and $f0			; $0299
	ld b,a			; $029b
	ld hl,$c483		; $029c
	ld a,(hl)		; $029f
	and b			; $02a0
	ld a,b			; $02a1
	ldi (hl),a		; $02a2
	jr z,_label_00_017	; $02a3
	inc (hl)		; $02a5
	ld a,(hl)		; $02a6
	cp $28			; $02a7
	jr c,_label_00_018	; $02a9
	and $1f			; $02ab
	or $80			; $02ad
	ld (hl),a		; $02af
	and $03			; $02b0
	jr nz,_label_00_018	; $02b2
	ld a,($c481)		; $02b4
	jr _label_00_019		; $02b7
_label_00_017:
	xor a			; $02b9
	ld (hl),a		; $02ba
_label_00_018:
	ld a,($c482)		; $02bb
_label_00_019:
	pop bc			; $02be
	pop hl			; $02bf
	ret			; $02c0

disableLcd:
	ld a,($ff00+$40)	; $02c1
	rlca			; $02c3
	ret nc			; $02c4
	push bc			; $02c5
	ld a,($ff00+$ff)	; $02c6
	ld b,a			; $02c8
	and $fe			; $02c9
	ld ($ff00+$ff),a	; $02cb
_label_00_020:
	ld a,($ff00+$44)	; $02cd
	cp $91			; $02cf
	jr c,_label_00_020	; $02d1
	ld a,$03		; $02d3
	ldh (<hNextLcdInterruptBehaviour),a	; $02d5
	xor a			; $02d7
	ld ($c497),a		; $02d8
	ld ($c48b),a		; $02db
	ld ($c485),a		; $02de
	ld ($ff00+$40),a	; $02e1
	ld ($ff00+$0f),a	; $02e3
	ld a,b			; $02e5
	ld ($ff00+$ff),a	; $02e6
	pop bc			; $02e8
	ret			; $02e9

loadGfxRegisterStateIndex:
	ld l,a			; $02ea
	add a			; $02eb
	add l			; $02ec
	add a			; $02ed
	ld hl,gfxRegisterStates		; $02ee
	rst_addDoubleIndex			; $02f1
	ld b,$0c		; $02f2
	ld de,$c485		; $02f4
_label_00_021:
	ldi a,(hl)		; $02f7
	ld (de),a		; $02f8
	inc e			; $02f9
	dec b			; $02fa
	jr nz,_label_00_021	; $02fb
	ld a,($c485)		; $02fd
	ld ($c497),a		; $0300
	ld ($ff00+$40),a	; $0303
	ret			; $0305

gfxRegisterStates:
	jp $0000		; $0306
	rst_jumpTable			; $0309
	rst_jumpTable			; $030a
	rst_jumpTable			; $030b
	jp $0000		; $030c
	rst_jumpTable			; $030f
	rst_jumpTable			; $0310
	rst_jumpTable			; $0311
	rst_jumpTable			; $0312
	nop			; $0313
	nop			; $0314
	rst_jumpTable			; $0315
	rst_jumpTable			; $0316
	rst_jumpTable			; $0317
	nop			; $0318
	nop			; $0319
	nop			; $031a
	rst_jumpTable			; $031b
	rst_jumpTable			; $031c
	rst_jumpTable			; $031d
	rst $28			; $031e
	ld a,($ff00+$00)	; $031f
	adc a			; $0321
	adc a			; $0322
	rrca			; $0323
	rst $20			; $0324
	nop			; $0325
	nop			; $0326
	rst_jumpTable			; $0327
	rst_jumpTable			; $0328
	rst_jumpTable			; $0329
	rst $28			; $032a
	ld a,($ff00+$00)	; $032b
	stop			; $032d
	rst_jumpTable			; $032e
	rrca			; $032f
	rst $30			; $0330
	ld a,($ff00+$00)	; $0331
	stop			; $0333
	rst_jumpTable			; $0334
	ld (hl),l		; $0335
	rst_jumpTable			; $0336
	nop			; $0337
	nop			; $0338
	rst_jumpTable			; $0339
	rst_jumpTable			; $033a
	rst_jumpTable			; $033b
	nop			; $033c
	nop			; $033d
	nop			; $033e
	rst_jumpTable			; $033f
	rst_jumpTable			; $0340
	rst_jumpTable			; $0341
	rst $8			; $0342
	nop			; $0343
	nop			; $0344
	rst_jumpTable			; $0345
	rst_jumpTable			; $0346
	rst_jumpTable			; $0347
	nop			; $0348
	nop			; $0349
	nop			; $034a
	rst_jumpTable			; $034b
	rst_jumpTable			; $034c
	rst_jumpTable			; $034d
	and a			; $034e
	nop			; $034f
	or b			; $0350
	rst_jumpTable			; $0351
	rst_jumpTable			; $0352
	rra			; $0353
	adc a			; $0354
_label_00_022:
	nop			; $0355
	nop			; $0356
	rst_jumpTable			; $0357
	rst_jumpTable			; $0358
	rst_jumpTable			; $0359
	rst_jumpTable			; $035a
	nop			; $035b
	nop			; $035c
	rst_jumpTable			; $035d
	rst_jumpTable			; $035e
	rst_jumpTable			; $035f
	nop			; $0360
	nop			; $0361
	nop			; $0362
	rst_jumpTable			; $0363
	rst_jumpTable			; $0364
	rst_jumpTable			; $0365
	and a			; $0366
	nop			; $0367
	nop			; $0368
	sub b			; $0369
	rlca			; $036a
	nop			; $036b
	and a			; $036c
_label_00_023:
	ld b,b			; $036d
	nop			; $036e
	sub b			; $036f
	rlca			; $0370
	rst_jumpTable			; $0371
	rst_jumpTable			; $0372
	ld (hl),b		; $0373
	nop			; $0374
	rst_jumpTable			; $0375
	rst_jumpTable			; $0376
	rst_jumpTable			; $0377
	rst_jumpTable			; $0378
	nop			; $0379
	nop			; $037a
	rst_jumpTable			; $037b
	rst_jumpTable			; $037c
	rst_jumpTable			; $037d
	rst $8			; $037e
	ld (hl),b		; $037f
	nop			; $0380
	rst_jumpTable			; $0381
	rst_jumpTable			; $0382
	rst_jumpTable			; $0383
	rst $8			; $0384
	nop			; $0385
	nop			; $0386
	rst_jumpTable			; $0387
	rst_jumpTable			; $0388
	rst_jumpTable			; $0389
	rst $8			; $038a
	nop			; $038b
	jr nz,_label_00_022	; $038c
	rst_jumpTable			; $038e
	rst_jumpTable			; $038f
	rst $8			; $0390
	nop			; $0391
	nop			; $0392
	rst_jumpTable			; $0393
	rst_jumpTable			; $0394
	rst_jumpTable			; $0395
	and a			; $0396
	nop			; $0397
	nop			; $0398
	ld a,b			; $0399
	rlca			; $039a
	daa			; $039b
	xor a			; $039c
	ld a,($ff00+$00)	; $039d
	ld a,b			; $039f
	rlca			; $03a0
	rst_jumpTable			; $03a1
	rst_jumpTable			; $03a2
	stop			; $03a3
	jr nc,_label_00_023	; $03a4
	rst_jumpTable			; $03a6
	rst_jumpTable			; $03a7
	rst_jumpTable			; $03a8
	nop			; $03a9
	nop			; $03aa
	rst_jumpTable			; $03ab
	rst_jumpTable			; $03ac
	rst_jumpTable			; $03ad
	rst $20			; $03ae
	ld bc,$4c00		; $03af
	ld c,h			; $03b2
	rst_jumpTable			; $03b3
	rst_jumpTable			; $03b4
_label_00_024:
	nop			; $03b5
	nop			; $03b6
	rst_jumpTable			; $03b7
	rst_jumpTable			; $03b8
	rst_jumpTable			; $03b9
	xor a			; $03ba
_label_00_025:
	ld a,($ff00+$00)	; $03bb
	stop			; $03bd
	rlca			; $03be
	rla			; $03bf
	rst $30			; $03c0
	ld a,($ff00+$00)	; $03c1
	stop			; $03c3
	rst_jumpTable			; $03c4
	ld d,a			; $03c5
	or a			; $03c6
	ld a,($ff00+$00)	; $03c7
	stop			; $03c9
	rlca			; $03ca
	rra			; $03cb
	rst $30			; $03cc
	ld a,($ff00+$00)	; $03cd
	stop			; $03cf
	rst_jumpTable			; $03d0
	ld b,a			; $03d1
	rst $28			; $03d2
	ld a,($ff00+$00)	; $03d3
	adc a			; $03d5
	adc a			; $03d6
	rrca			; $03d7
	rst $20			; $03d8
	nop			; $03d9
	nop			; $03da
	ld b,b			; $03db
	ld d,a			; $03dc
	rst_jumpTable			; $03dd
	rst $28			; $03de
	ld a,($ff00+$00)	; $03df
	adc a			; $03e1
	adc a			; $03e2
	rrca			; $03e3
	rst $20			; $03e4
	nop			; $03e5
	nop			; $03e6
	sub b			; $03e7
	ld b,a			; $03e8
	rst_jumpTable			; $03e9
	rst $20			; $03ea
	nop			; $03eb
	jr z,_label_00_024	; $03ec
	rst_jumpTable			; $03ee
	rst_jumpTable			; $03ef
	rst $20			; $03f0
	nop			; $03f1
	jr z,_label_00_025	; $03f2
	rst_jumpTable			; $03f4
	rst_jumpTable			; $03f5
	rst $28			; $03f6
	ld a,($ff00+$00)	; $03f7
	adc a			; $03f9
	adc a			; $03fa
	nop			; $03fb
	rst $20			; $03fc
	nop			; $03fd
	nop			; $03fe
	rst_jumpTable			; $03ff
	rst_jumpTable			; $0400
	rst_jumpTable			; $0401
	rst $20			; $0402
	nop			; $0403
	nop			; $0404
	rst_jumpTable			; $0405
	rst_jumpTable			; $0406
	rst_jumpTable			; $0407
	rst $20			; $0408
	nop			; $0409
	nop			; $040a
	rst_jumpTable			; $040b
	rst_jumpTable			; $040c
	rst_jumpTable			; $040d
	rst $38			; $040e
	jr nc,_label_00_026	; $040f
_label_00_026:
	ld h,b			; $0411
	rlca			; $0412
	jr -$01			; $0413
	jr nc,_label_00_027	; $0415
_label_00_027:
	ld h,b			; $0417
	rlca			; $0418
	rst_jumpTable			; $0419

getRandomNumber:
	push hl			; $041a
	push bc			; $041b
	ldh a,(<hRng1)	; $041c
	ld l,a			; $041e
	ld c,a			; $041f
	ldh a,(<hRng2)	; $0420
	ld h,a			; $0422
	ld b,a			; $0423
	add hl,hl		; $0424
	add hl,bc		; $0425
	ld a,h			; $0426
	ldh (<hRng2),a	; $0427
	add c			; $0429
	ldh (<hRng1),a	; $042a
	pop bc			; $042c
	pop hl			; $042d
	ret			; $042e

getRandomNumber_noPreserveVars:
	ldh a,(<hRng1)	; $042f
	ld l,a			; $0431
	ld c,a			; $0432
	ldh a,(<hRng2)	; $0433
	ld h,a			; $0435
	ld b,a			; $0436
	add hl,hl		; $0437
	add hl,bc		; $0438
	ld a,h			; $0439
	ldh (<hRng2),a	; $043a
	add c			; $043c
	ldh (<hRng1),a	; $043d
	ret			; $043f

getRandomIndexFromProbabilityDistribution:
	ld b,$00		; $0440
	call getRandomNumber		; $0442
_label_00_028:
	sub (hl)		; $0445
	ret c			; $0446
	inc hl			; $0447
	inc b			; $0448
	jr _label_00_028		; $0449

clearMemory:
	xor a			; $044b
_label_00_029:

fillMemory:
	ldi (hl),a		; $044c
	dec b			; $044d
	jr nz,_label_00_029	; $044e
	ret			; $0450
_label_00_030:

clearMemoryBc:
	xor a			; $0451

fillMemoryBc:
	ld e,a			; $0452
_label_00_031:
	ld a,e			; $0453
	ldi (hl),a		; $0454
	dec bc			; $0455
	ld a,c			; $0456
	or b			; $0457
	jr nz,_label_00_031	; $0458
	ret			; $045a
_label_00_032:

copyMemoryReverse:
	ld a,(de)		; $045b
	ldi (hl),a		; $045c
	inc de			; $045d
	dec b			; $045e
	jr nz,_label_00_032	; $045f
	ret			; $0461
_label_00_033:

copyMemory:
	ldi a,(hl)		; $0462
	ld (de),a		; $0463
	inc de			; $0464
	dec b			; $0465
	jr nz,_label_00_033	; $0466
	ret			; $0468
_label_00_034:

copyMemoryBcReverse:
	ld a,(de)		; $0469
	ldi (hl),a		; $046a
	inc de			; $046b
	dec bc			; $046c
	ld a,b			; $046d
	or c			; $046e
	jr nz,_label_00_034	; $046f
	ret			; $0471
_label_00_035:

copyMemoryBc:
	ldi a,(hl)		; $0472
	ld (de),a		; $0473
	inc de			; $0474
	dec bc			; $0475
	ld a,b			; $0476
	or c			; $0477
	jr nz,_label_00_035	; $0478
	ret			; $047a

clearOam:
	xor a			; $047b
	ldh (<hOamTail),a	; $047c
	ld h,$cb		; $047e
	ld b,$e0		; $0480
_label_00_036:
	ld l,a			; $0482
	ld (hl),b		; $0483
	add $04			; $0484
	cp $a0			; $0486
	jr c,_label_00_036	; $0488
	ret			; $048a

clearVram:
	call disableLcd		; $048b
	call clearOam		; $048e
	ld a,$01		; $0491
	ld ($ff00+$4f),a	; $0493
	ld hl,$8000		; $0495
	ld bc,$2000		; $0498
	call clearMemoryBc		; $049b
	xor a			; $049e
	ld ($ff00+$4f),a	; $049f
	ld hl,$8000		; $04a1
	ld bc,$2000		; $04a4
	jr _label_00_030		; $04a7

initializeVramMaps:
	call initializeVramMap1		; $04a9

initializeVramMap0:
	call disableLcd		; $04ac
	ld a,$01		; $04af
	ld ($ff00+$4f),a	; $04b1
	ld hl,$9800		; $04b3
	ld bc,$0400		; $04b6
	ld a,$80		; $04b9
	call fillMemoryBc		; $04bb
	xor a			; $04be
	ld ($ff00+$4f),a	; $04bf
	ld hl,$9800		; $04c1
	ld bc,$0400		; $04c4
	jr _label_00_030		; $04c7

initializeVramMap1:
	call disableLcd		; $04c9
	ld a,$01		; $04cc
	ld ($ff00+$4f),a	; $04ce
	ld hl,$9c00		; $04d0
	ld bc,$0400		; $04d3
	ld a,$80		; $04d6
	call fillMemoryBc		; $04d8
	xor a			; $04db
	ld ($ff00+$4f),a	; $04dc
	ld hl,$9c00		; $04de
	ld bc,$0400		; $04e1
	jp clearMemoryBc		; $04e4

loadPaletteHeader:
	push de			; $04e7
	ld l,a			; $04e8
	ld a,($ff00+$70)	; $04e9
	ld c,a			; $04eb
	ldh a,(<hRomBank)	; $04ec
	ld b,a			; $04ee
	push bc			; $04ef
	ld a,$02		; $04f0
	ld ($ff00+$70),a	; $04f2
	ld a,$01		; $04f4
	ldh (<hRomBank),a	; $04f6
	ld ($2222),a		; $04f8
	ld a,l			; $04fb
	ld hl,$6290		; $04fc
	rst_addDoubleIndex			; $04ff
	ldi a,(hl)		; $0500
	ld h,(hl)		; $0501
	ld l,a			; $0502
_label_00_037:
	ld a,$01		; $0503
	ldh (<hRomBank),a	; $0505
	ld ($2222),a		; $0507
	ld a,(hl)		; $050a
	and $07			; $050b
	inc a			; $050d
	ld b,a			; $050e
	ld a,(hl)		; $050f
	rlca			; $0510
	swap a			; $0511
	and $07			; $0513
	ld de,bitTable		; $0515
	add e			; $0518
	ld e,a			; $0519
	ld a,(de)		; $051a
	ld c,a			; $051b
	xor a			; $051c
_label_00_038:
	or c			; $051d
	dec b			; $051e
	jr z,_label_00_039	; $051f
	rlca			; $0521
	jr _label_00_038		; $0522
_label_00_039:
	ld b,a			; $0524
	ld c,$a4		; $0525
	bit 6,(hl)		; $0527
	jr z,_label_00_040	; $0529
	ld c,$a5		; $052b
_label_00_040:
	ld a,($ff00+c)		; $052d
	or b			; $052e
	ld ($ff00+c),a		; $052f
	ld a,(hl)		; $0530
	and $78			; $0531
	add $80			; $0533
	ld e,a			; $0535
	ld d,$de		; $0536
	ld a,(hl)		; $0538
	and $07			; $0539
	inc a			; $053b
	ld b,a			; $053c
	ldi a,(hl)		; $053d
	rlca			; $053e
	ldi a,(hl)		; $053f
	ld c,a			; $0540
	ldi a,(hl)		; $0541
	push hl			; $0542
	ld l,c			; $0543
	ld h,a			; $0544
	ld a,$16		; $0545
	ldh (<hRomBank),a	; $0547
	ld ($2222),a		; $0549
_label_00_041:
	ld c,$08		; $054c
_label_00_042:
	ldi a,(hl)		; $054e
	ld (de),a		; $054f
	inc e			; $0550
	dec c			; $0551
	jr nz,_label_00_042	; $0552
	dec b			; $0554
	jr nz,_label_00_041	; $0555
	pop hl			; $0557
	jr c,_label_00_037	; $0558
	pop bc			; $055a
	ld a,b			; $055b
	ldh (<hRomBank),a	; $055c
	ld ($2222),a		; $055e
	ld a,c			; $0561
	ld ($ff00+$70),a	; $0562
	pop de			; $0564
	ret			; $0565

queueDmaTransfer:
	ld a,($ff00+$40)	; $0566
	rlca			; $0568
	jr nc,_label_00_043	; $0569
	push de			; $056b
	push hl			; $056c
	ld h,$c4		; $056d
	ldh a,(<hVBlankFunctionQueueTail)	; $056f
	ld l,a			; $0571
	ld a,(vblankDmaFunctionOffset)		; $0572
	ldi (hl),a		; $0575
	ld a,c			; $0576
	ldi (hl),a		; $0577
	pop de			; $0578
	ld a,d			; $0579
	ldi (hl),a		; $057a
	ld a,e			; $057b
	ldi (hl),a		; $057c
	pop de			; $057d
	ld a,e			; $057e
	ldi (hl),a		; $057f
	ld a,d			; $0580
	ldi (hl),a		; $0581
	ld a,e			; $0582
	ldi (hl),a		; $0583
	ld a,b			; $0584
	ldi (hl),a		; $0585
	ld a,l			; $0586
	ldh (<hVBlankFunctionQueueTail),a	; $0587
	scf			; $0589
	ret			; $058a
_label_00_043:
	ldh a,(<hRomBank)	; $058b
	push af			; $058d
	ld a,($ff00+$70)	; $058e
	push af			; $0590
	push de			; $0591
	push hl			; $0592
	ld a,c			; $0593
	ld ($ff00+$70),a	; $0594
	ldh (<hRomBank),a	; $0596
	ld ($2222),a		; $0598
	pop de			; $059b
	ld hl,$ff51		; $059c
	ld (hl),d		; $059f
	inc l			; $05a0
	ld (hl),e		; $05a1
	inc l			; $05a2
	pop de			; $05a3
	ld a,e			; $05a4
	ld ($ff00+$4f),a	; $05a5
	ld (hl),d		; $05a7
	inc l			; $05a8
	ldi (hl),a		; $05a9
	ld (hl),b		; $05aa
	pop af			; $05ab
	ld ($ff00+$70),a	; $05ac
	pop af			; $05ae
	ldh (<hRomBank),a	; $05af
	ld ($2222),a		; $05b1
	xor a			; $05b4
	ret			; $05b5

loadUncompressedGfxHeader:
	ld e,a			; $05b6
	ld a,($ff00+$70)	; $05b7
	ld c,a			; $05b9
	ldh a,(<hRomBank)	; $05ba
	ld b,a			; $05bc
	push bc			; $05bd
	ld a,$01		; $05be
	ldh (<hRomBank),a	; $05c0
	ld ($2222),a		; $05c2
	ld a,e			; $05c5
	ld hl,$66d0		; $05c6
	rst_addDoubleIndex			; $05c9
	ldi a,(hl)		; $05ca
	ld h,(hl)		; $05cb
	ld l,a			; $05cc
_label_00_044:
	ldi a,(hl)		; $05cd
	ld c,a			; $05ce
	ldi a,(hl)		; $05cf
	ld d,a			; $05d0
	ldi a,(hl)		; $05d1
	ld e,a			; $05d2
	push de			; $05d3
	ldi a,(hl)		; $05d4
	ld d,a			; $05d5
	ldi a,(hl)		; $05d6
	ld e,a			; $05d7
	ld a,(hl)		; $05d8
	and $7f			; $05d9
	ld b,a			; $05db
	ld a,l			; $05dc
	ldh (<hFF90),a	; $05dd
	ld a,h			; $05df
	ldh (<hFF91),a	; $05e0
	pop hl			; $05e2
	call queueDmaTransfer		; $05e3
	ld a,$01		; $05e6
	ldh (<hRomBank),a	; $05e8
	ld ($2222),a		; $05ea
	ldh a,(<hFF90)	; $05ed
	ld l,a			; $05ef
	ldh a,(<hFF91)	; $05f0
	ld h,a			; $05f2
	ldi a,(hl)		; $05f3
	add a			; $05f4
	jr c,_label_00_044	; $05f5
	pop bc			; $05f7
	ld a,b			; $05f8
	ldh (<hRomBank),a	; $05f9
	ld ($2222),a		; $05fb
	ld a,c			; $05fe
	ld ($ff00+$70),a	; $05ff
	ret			; $0601

loadGfxHeader:
	ld e,a			; $0602
	ld a,($ff00+$70)	; $0603
	ld c,a			; $0605
	ldh a,(<hRomBank)	; $0606
	ld b,a			; $0608
	push bc			; $0609
	ld a,$01		; $060a
	ldh (<hRomBank),a	; $060c
	ld ($2222),a		; $060e
	ld a,e			; $0611
	ld hl,$6926		; $0612
	rst_addDoubleIndex			; $0615
	ldi a,(hl)		; $0616
	ld h,(hl)		; $0617
	ld l,a			; $0618
_label_00_045:
	ldi a,(hl)		; $0619
	ld c,a			; $061a
	ldi a,(hl)		; $061b
	ld d,a			; $061c
	ldi a,(hl)		; $061d
	ld e,a			; $061e
	push de			; $061f
	ldi a,(hl)		; $0620
	ld d,a			; $0621
	ldi a,(hl)		; $0622
	ld e,a			; $0623
	ld a,(hl)		; $0624
	and $7f			; $0625
	ld b,a			; $0627
	ld a,l			; $0628
	ldh (<hFF90),a	; $0629
	ld a,h			; $062b
	ldh (<hFF91),a	; $062c
	pop hl			; $062e
	call decompressGraphics		; $062f
	ld a,$01		; $0632
	ldh (<hRomBank),a	; $0634
	ld ($2222),a		; $0636
	ldh a,(<hFF90)	; $0639
	ld l,a			; $063b
	ldh a,(<hFF91)	; $063c
	ld h,a			; $063e
	ldi a,(hl)		; $063f
	add a			; $0640
	jr c,_label_00_045	; $0641
	pop bc			; $0643
	ld a,b			; $0644
	ldh (<hRomBank),a	; $0645
	ld ($2222),a		; $0647
	ld a,c			; $064a
	ld ($ff00+$70),a	; $064b
	ret			; $064d

decompressGraphics:
	ld a,e			; $064e
	and $0f			; $064f
	ld ($ff00+$4f),a	; $0651
	ld ($ff00+$70),a	; $0653
	xor e			; $0655
	ld e,a			; $0656
	ld a,c			; $0657
	and $3f			; $0658
	ldh (<hRomBank),a	; $065a
	ld ($2222),a		; $065c
	inc b			; $065f
	ld a,c			; $0660
	and $c0			; $0661
	jp z,func_06e0		; $0663
	cp $c0			; $0666
	jr z,_label_00_057	; $0668
	cp $40			; $066a
	jr z,_label_00_058	; $066c
	ld a,b			; $066e
_label_00_046:
	push af			; $066f
	call func_069c		; $0670
	pop af			; $0673
	dec a			; $0674
	jr nz,_label_00_046	; $0675
	ret			; $0677

func_069c:
	call readByteSequential		; $0678
	ld c,a			; $067b
	call readByteSequential		; $067c
	ldh (<hFF8A),a	; $067f
	or c			; $0681
	jr nz,_label_00_048	; $0682
	ld b,$10		; $0684
_label_00_047:
	call readByteSequential		; $0686
	ld (de),a		; $0689
	inc de			; $068a
	dec b			; $068b
	jr nz,_label_00_047	; $068c
	ret			; $068e
_label_00_048:
	call readByteSequential		; $068f
	ldh (<hFF8B),a	; $0692
	ld b,$08		; $0694
_label_00_049:
	rl c			; $0696
	jr c,_label_00_050	; $0698
	call readByteSequential		; $069a
	jr _label_00_051		; $069d
_label_00_050:
	ldh a,(<hFF8B)	; $069f
_label_00_051:
	ld (de),a		; $06a1
	inc de			; $06a2
	dec b			; $06a3
	jr nz,_label_00_049	; $06a4
	ldh a,(<hFF8A)	; $06a6
	ld c,a			; $06a8
	ld b,$08		; $06a9
_label_00_052:
	rl c			; $06ab
	jr c,_label_00_053	; $06ad
	call readByteSequential		; $06af
	jr _label_00_054		; $06b2
_label_00_053:
	ldh a,(<hFF8B)	; $06b4
_label_00_054:
	ld (de),a		; $06b6
	inc de			; $06b7
	dec b			; $06b8
	jr nz,_label_00_052	; $06b9
	ret			; $06bb
_label_00_055:

func_06e0:
	ld c,$10		; $06bc
_label_00_056:
	call readByteSequential		; $06be
	ld (de),a		; $06c1
	inc de			; $06c2
	dec c			; $06c3
	jr nz,_label_00_056	; $06c4
	dec b			; $06c6
	jr nz,_label_00_055	; $06c7
	ret			; $06c9
_label_00_057:
	ld a,$ff		; $06ca
	jr _label_00_059		; $06cc
_label_00_058:
	xor a			; $06ce
	ldh (<hFF93),a	; $06cf
_label_00_059:
	ldh (<hFF8E),a	; $06d1
	swap b			; $06d3
	ld a,b			; $06d5
	and $f0			; $06d6
	ld c,a			; $06d8
	xor b			; $06d9
	ld b,a			; $06da
	ld a,$01		; $06db
	ldh (<hFF8B),a	; $06dd
_label_00_060:
	ldh a,(<hFF8B)	; $06df
	dec a			; $06e1
	ldh (<hFF8B),a	; $06e2
	jr nz,_label_00_061	; $06e4
	ld a,$08		; $06e6
	ldh (<hFF8B),a	; $06e8
	ldi a,(hl)		; $06ea
	ldh (<hFF8A),a	; $06eb
	call _adjustHLSequential		; $06ed
_label_00_061:
	ldh a,(<hFF8A)	; $06f0
	add a			; $06f2
	ldh (<hFF8A),a	; $06f3
	jr c,_label_00_062	; $06f5
	call copyByteSequential		; $06f7
	jr nz,_label_00_060	; $06fa
	ret			; $06fc
_label_00_062:
	ldh a,(<hFF8E)	; $06fd
	or a			; $06ff
	jr nz,_label_00_063	; $0700
	ld a,(hl)		; $0702
	and $1f			; $0703
	ldh (<hFF92),a	; $0705
	xor (hl)		; $0707
	jr z,_label_00_064	; $0708
	swap a			; $070a
	rrca			; $070c
	inc a			; $070d
	jr _label_00_065		; $070e
_label_00_063:
	ldi a,(hl)		; $0710
	ldh (<hFF92),a	; $0711
	call _adjustHLSequential		; $0713
	ld a,(hl)		; $0716
	and $07			; $0717
	ldh (<hFF93),a	; $0719
	xor (hl)		; $071b
	jr z,_label_00_064	; $071c
	rrca			; $071e
	rrca			; $071f
	rrca			; $0720
	add $02			; $0721
	jr _label_00_065		; $0723
_label_00_064:
	inc hl			; $0725
	call _adjustHLSequential		; $0726
	ld a,(hl)		; $0729
_label_00_065:
	ldh (<hFF8F),a	; $072a
	inc hl			; $072c
	call _adjustHLSequential		; $072d
	push hl			; $0730
	ldh a,(<hFF92)	; $0731
	cpl			; $0733
	ld l,a			; $0734
	ldh a,(<hFF93)	; $0735
	cpl			; $0737
	ld h,a			; $0738
	add hl,de		; $0739
_label_00_066:
	ldi a,(hl)		; $073a
	ld (de),a		; $073b
	inc de			; $073c
	dec bc			; $073d
	ld a,b			; $073e
	or c			; $073f
	jr z,_label_00_067	; $0740
	ldh a,(<hFF8F)	; $0742
	dec a			; $0744
	ldh (<hFF8F),a	; $0745
	jr nz,_label_00_066	; $0747
	pop hl			; $0749
	jr _label_00_060		; $074a
_label_00_067:
	pop hl			; $074c
	ret			; $074d

copyByteSequential:
	ldi a,(hl)		; $074e
	ld (de),a		; $074f
	inc de			; $0750
	dec bc			; $0751

_adjustHLSequential:
	ld a,h			; $0752
	cp $80			; $0753
	jr nz,_label_00_068	; $0755
	ld h,$40		; $0757
	ldh a,(<hRomBank)	; $0759
	inc a			; $075b
	ldh (<hRomBank),a	; $075c
	ld ($2222),a		; $075e
_label_00_068:
	ld a,b			; $0761
	or c			; $0762
	ret			; $0763

readByteSequential:
	ldi a,(hl)		; $0764
	bit 7,h			; $0765
	ret z			; $0767
	push af			; $0768
	ld h,$40		; $0769
	ldh a,(<hRomBank)	; $076b
	inc a			; $076d
	ldh (<hRomBank),a	; $076e
	ld ($2222),a		; $0770
	pop af			; $0773
	ret			; $0774

loadTileset:
	ld e,a			; $0775
	ld a,($ff00+$70)	; $0776
	ld c,a			; $0778
	ldh a,(<hRomBank)	; $0779
	ld b,a			; $077b
	push bc			; $077c
	ld a,$01		; $077d
	ldh (<hRomBank),a	; $077f
	ld ($2222),a		; $0781
	ld a,e			; $0784
	ld hl,$7964		; $0785
	rst_addDoubleIndex			; $0788
	ldi a,(hl)		; $0789
	ld h,(hl)		; $078a
	ld l,a			; $078b
_label_00_069:
	ldi a,(hl)		; $078c
	push hl			; $078d
	ld hl,$794e		; $078e
	rst_addDoubleIndex			; $0791
	ldi a,(hl)		; $0792
	ld h,(hl)		; $0793
	ld l,a			; $0794
	ldi a,(hl)		; $0795
	ldh (<hFF8F),a	; $0796
	ldi a,(hl)		; $0798
	ldh (<hFF91),a	; $0799
	ldi a,(hl)		; $079b
	ldh (<hFF90),a	; $079c
	pop hl			; $079e
	ldi a,(hl)		; $079f
	ldh (<hFF8E),a	; $07a0
	ldi a,(hl)		; $07a2
	ld d,a			; $07a3
	ldi a,(hl)		; $07a4
	ld e,a			; $07a5
	push de			; $07a6
	ldi a,(hl)		; $07a7
	ld d,a			; $07a8
	ldi a,(hl)		; $07a9
	ld e,a			; $07aa
	ldi a,(hl)		; $07ab
	and $7f			; $07ac
	ldh (<hFF8D),a	; $07ae
	ldd a,(hl)		; $07b0
	ldh (<hFF8C),a	; $07b1
	ld a,h			; $07b3
	ldh (<hFF93),a	; $07b4
	ld a,l			; $07b6
	ldh (<hFF92),a	; $07b7
	pop hl			; $07b9
	call loadTilesetHlpr		; $07ba
	ld a,$01		; $07bd
	ldh (<hRomBank),a	; $07bf
	ld ($2222),a		; $07c1
	ldh a,(<hFF93)	; $07c4
	ld h,a			; $07c6
	ldh a,(<hFF92)	; $07c7
	ld l,a			; $07c9
	ldi a,(hl)		; $07ca
	inc hl			; $07cb
	add a			; $07cc
	jr c,_label_00_069	; $07cd
	pop bc			; $07cf
	ld a,b			; $07d0
	ldh (<hRomBank),a	; $07d1
	ld ($2222),a		; $07d3
	ld a,c			; $07d6
	ld ($ff00+$70),a	; $07d7
	ret			; $07d9

loadTilesetHlpr:
	ld a,e			; $07da
	and $0f			; $07db
	ld ($ff00+$4f),a	; $07dd
	ld ($ff00+$70),a	; $07df
	xor e			; $07e1
	ld e,a			; $07e2
_label_00_070:
	ldh a,(<hFF8E)	; $07e3
	ldh (<hRomBank),a	; $07e5
	ld ($2222),a		; $07e7
	ldi a,(hl)		; $07ea
	ldh (<hFF8B),a	; $07eb
	ld b,$08		; $07ed
_label_00_071:
	ldh a,(<hFF8E)	; $07ef
	ldh (<hRomBank),a	; $07f1
	ld ($2222),a		; $07f3
	ldh a,(<hFF8B)	; $07f6
	rrca			; $07f8
	ldh (<hFF8B),a	; $07f9
	jr c,_label_00_072	; $07fb
	ldi a,(hl)		; $07fd
	ld (de),a		; $07fe
	inc de			; $07ff
	call dec16_ff8c		; $0800
	ret z			; $0803
	dec b			; $0804
	jr nz,_label_00_071	; $0805
	jr _label_00_070		; $0807
_label_00_072:
	push bc			; $0809
	ldh a,(<hFF8F)	; $080a
	bit 7,a			; $080c
	jr nz,_label_00_073	; $080e
	ldi a,(hl)		; $0810
	ld c,a			; $0811
	ldi a,(hl)		; $0812
	ldh (<hFF8A),a	; $0813
	and $0f			; $0815
	ld b,a			; $0817
	ldh a,(<hFF8A)	; $0818
	swap a			; $081a
	and $0f			; $081c
	add $03			; $081e
	ldh (<hFF8A),a	; $0820
	jr _label_00_074		; $0822
_label_00_073:
	ldi a,(hl)		; $0824
	ldh (<hFF8A),a	; $0825
	ldi a,(hl)		; $0827
	ld c,a			; $0828
	ldi a,(hl)		; $0829
	ld b,a			; $082a
_label_00_074:
	push hl			; $082b
	ld hl,$ff90		; $082c
	ldi a,(hl)		; $082f
	ld h,(hl)		; $0830
	ld l,a			; $0831
	add hl,bc		; $0832
	ldh a,(<hFF8A)	; $0833
	ld b,a			; $0835
	ldh a,(<hFF8F)	; $0836
	and $3f			; $0838
	ldh (<hRomBank),a	; $083a
	ld ($2222),a		; $083c
_label_00_075:
	ldi a,(hl)		; $083f
	ld (de),a		; $0840
	inc de			; $0841
	call dec16_ff8c		; $0842
	jr z,_label_00_076	; $0845
	dec b			; $0847
	jr nz,_label_00_075	; $0848
	pop hl			; $084a
	pop bc			; $084b
	dec b			; $084c
	jr nz,_label_00_071	; $084d
	jr _label_00_070		; $084f
_label_00_076:
	pop hl			; $0851
	pop bc			; $0852
	ret			; $0853

dec16_ff8c:
	push hl			; $0854
	ld hl,$ff8c		; $0855
	call decHlRef16WithCap		; $0858
	pop hl			; $085b
	ret			; $085c

enableIntroInputs:
	ldh a,(<hIntroInputsEnabled)	; $085d
	bit 7,a			; $085f
	ret nz			; $0861
	ld a,$01		; $0862
	ldh (<hIntroInputsEnabled),a	; $0864
	ret			; $0866

threadFunc_088b:
	push hl			; $0867
	ld l,a			; $0868
	ld h,$c2		; $0869
	set 7,(hl)		; $086b
	pop hl			; $086d
	ret			; $086e

threadFunc_0893:
	push hl			; $086f
	ld l,a			; $0870
	ld h,$c2		; $0871
	res 7,(hl)		; $0873
	pop hl			; $0875
	ret			; $0876

threadStop:
	push hl			; $0877
	ld l,a			; $0878
	ld h,$c2		; $0879
	ld (hl),$00		; $087b
	pop hl			; $087d
	ret			; $087e

threadRestart:
	push hl			; $087f
	push de			; $0880
	push bc			; $0881
	ld e,a			; $0882
	add $04			; $0883
	ld c,a			; $0885
	ld d,$00		; $0886
	ld hl,$08a8		; $0888
	add hl,de		; $088b
	ld d,$c2		; $088c
	ld b,$08		; $088e
_label_00_077:
	ldi a,(hl)		; $0890
	ld (de),a		; $0891
	inc e			; $0892
	dec b			; $0893
	jr nz,_label_00_077	; $0894
	ld l,c			; $0896
	ld h,d			; $0897
	pop bc			; $0898
	ld (hl),c		; $0899
	inc l			; $089a
	ld (hl),b		; $089b
	pop de			; $089c
	pop hl			; $089d
	ret			; $089e

restartThisThread:
	push bc			; $089f
	ldh a,(<hActiveThread)	; $08a0
	ld e,a			; $08a2
	add $04			; $08a3
	ld c,a			; $08a5
	ld d,$00		; $08a6
	ld hl,$08a8		; $08a8
	add hl,de		; $08ab
	ld d,$c2		; $08ac
	ld b,$08		; $08ae
_label_00_078:
	ldi a,(hl)		; $08b0
	ld (de),a		; $08b1
	inc e			; $08b2
	dec b			; $08b3
	jr nz,_label_00_078	; $08b4
	ld l,c			; $08b6
	ld h,d			; $08b7
	pop bc			; $08b8
	ld (hl),c		; $08b9
	inc l			; $08ba
	ld (hl),b		; $08bb
	jr _label_00_079		; $08bc

stubThreadStart:
	ldh a,(<hActiveThread)	; $08be
	ld l,a			; $08c0
	ld h,$c2		; $08c1
	ld (hl),$00		; $08c3
	jr _label_00_079		; $08c5

resumeThreadNextFrameAndSaveBank:
	ld a,$01		; $08c7
	push bc			; $08c9
	ld b,a			; $08ca
	ldh a,(<hRomBank)	; $08cb
	ld c,a			; $08cd
	ld a,b			; $08ce
	call resumeThreadInAFrames		; $08cf
	ld a,c			; $08d2
	ldh (<hRomBank),a	; $08d3
	ld ($2222),a		; $08d5
	pop bc			; $08d8
	ret			; $08d9

resumeThreadNextFrame:
	ld a,$01		; $08da

resumeThreadInAFrames:
	push hl			; $08dc
	push de			; $08dd
	push bc			; $08de
	ld b,a			; $08df
	ldh a,(<hActiveThread)	; $08e0
	ld l,a			; $08e2
	ld h,$c2		; $08e3
	ld a,$01		; $08e5
	ldi (hl),a		; $08e7
	ld (hl),b		; $08e8
	inc l			; $08e9
	ld ($ff92),sp		; $08ea
	ldh a,(<hFF92)	; $08ed
	ldi (hl),a		; $08ef
	ldh a,(<hFF93)	; $08f0
	ld (hl),a		; $08f2
_label_00_079:

_nextThread:
	ld sp,$c110		; $08f3
	ld h,$c2		; $08f6
	ld a,$01		; $08f8
	ld ($ff00+$70),a	; $08fa
	jr _label_00_084		; $08fc

startGame:
	ld sp,$c110		; $08fe
	ld hl,_initialThreadStates		; $0901
	ld de,$c2e0		; $0904
	ld b,$20		; $0907
_label_00_080:
	ldi a,(hl)		; $0909
	ld (de),a		; $090a
	inc e			; $090b
	dec b			; $090c
	jr nz,_label_00_080	; $090d
_label_00_081:

_mainLoop:
	call pollInput		; $090f
	ldh a,(<hIntroInputsEnabled)	; $0912
	add a			; $0914
	jr z,_label_00_082	; $0915
	ld a,($c481)		; $0917
	sub $0f			; $091a
	jp z,resetGame		; $091c
_label_00_082:
	ld a,$10		; $091f
	ldh (<hOamTail),a	; $0921
	ld h,$c2		; $0923
	ld a,$e0		; $0925
	ldh (<hActiveThread),a	; $0927
_label_00_083:
	ld l,a			; $0929
	ld a,(hl)		; $092a
	dec a			; $092b
	jr z,_label_00_088	; $092c
	dec a			; $092e
	jr z,_label_00_089	; $092f
_label_00_084:

_mainLoop_nextThread:
	ldh a,(<hActiveThread)	; $0931
	add $08			; $0933
	ldh (<hActiveThread),a	; $0935
	cp $00			; $0937
	jr nz,_label_00_083	; $0939
	ld a,$3f		; $093b
	ldh (<hRomBank),a	; $093d
	ld ($2222),a		; $093f
	call $4016		; $0942
	xor a			; $0945
	ld ($ff00+$70),a	; $0946
	ld hl,$c49e		; $0948
	inc (hl)		; $094b
	ld hl,$c485		; $094c
	ld de,$c497		; $094f
	ld b,$06		; $0952
_label_00_085:
	ldi a,(hl)		; $0954
	ld (de),a		; $0955
_label_00_086:
	inc e			; $0956
	dec b			; $0957
	jr nz,_label_00_085	; $0958
	ld hl,$c49d		; $095a
	ld (hl),$ff		; $095d
_label_00_087:
	halt			; $095f
	nop			; $0960
	bit 7,(hl)		; $0961
	jr nz,_label_00_087	; $0963
	jr _label_00_081		; $0965
_label_00_088:

_countdownToRunThread:
	inc l			; $0967
	dec (hl)		; $0968
	jr nz,_label_00_084	; $0969
	dec l			; $096b
	ld a,$03		; $096c
	ldi (hl),a		; $096e
	inc l			; $096f
	ldi a,(hl)		; $0970
	ld h,(hl)		; $0971
	ld l,a			; $0972
	ld sp,hl		; $0973
	pop bc			; $0974
	pop de			; $0975
	pop hl			; $0976
	ret			; $0977
_label_00_089:

_initializeThread:
	ld a,$03		; $0978
	ldi (hl),a		; $097a
	inc l			; $097b
	ldi a,(hl)		; $097c
	ld e,a			; $097d
	ldi a,(hl)		; $097e
	ld d,a			; $097f
	ldi a,(hl)		; $0980
	ld b,(hl)		; $0981
	ld c,a			; $0982
	ld l,e			; $0983
	ld h,d			; $0984
	ld sp,hl		; $0985
	push bc			; $0986
	ret			; $0987

_initialThreadStates:
	ld (bc),a		; $0988
	nop			; $0989
	add b			; $098a
	pop bc			; $098b
	ld c,(hl)		; $098c
	inc l			; $098d
	nop			; $098e
	nop			; $098f
	ld (bc),a		; $0990
	nop			; $0991
	jr nz,_label_00_086	; $0992
	cp (hl)			; $0994
	ld ($0000),sp		; $0995
	ld (bc),a		; $0998
	nop			; $0999
	ld (hl),b		; $099a
	jp nz,stubThreadStart		; $099b
	nop			; $099e
	nop			; $099f
	ld (bc),a		; $09a0
	nop			; $09a1
	ret nz			; $09a2
	jp nz,paletteFadeThreadStart		; $09a3
	nop			; $09a6
	nop			; $09a7

flagLocationGroupTable:
	rst_jumpTable			; $09a8
	ret z			; $09a9
	ret z			; $09aa
	ret z			; $09ab
	ret			; $09ac
	jp z,$cac9		; $09ad

initializeFile:
	ld c,$00		; $09b0
	jr _label_00_090		; $09b2

saveFile:
	ld c,$01		; $09b4
	jr _label_00_090		; $09b6

loadFile:
	ld c,$02		; $09b8
	jr _label_00_090		; $09ba

eraseFile:
	ld c,$03		; $09bc
_label_00_090:
	ldh a,(<hRomBank)	; $09be
	push af			; $09c0
	ld a,$07		; $09c1
	ldh (<hRomBank),a	; $09c3
	ld ($2222),a		; $09c5
	call $4000		; $09c8
	ld c,a			; $09cb
	pop af			; $09cc
	ldh (<hRomBank),a	; $09cd
	ld ($2222),a		; $09cf
	ld a,c			; $09d2
	ret			; $09d3

vblankInterrupt:
	ldh a,(<hNextLcdInterruptBehaviour)	; $09d4
	ldh (<hLcdInterruptBehaviour),a	; $09d6
	xor a			; $09d8
	ldh (<hLcdInterruptCounter),a	; $09d9
	ld hl,$ffb5		; $09db
	set 7,(hl)		; $09de
	ld hl,$c497		; $09e0
	ldi a,(hl)		; $09e3
	ld ($ff00+$40),a	; $09e4
	ldi a,(hl)		; $09e6
	ld ($ff00+$42),a	; $09e7
	ldi a,(hl)		; $09e9
	ld ($ff00+$43),a	; $09ea
	ldi a,(hl)		; $09ec
	ld ($ff00+$4a),a	; $09ed
	ldi a,(hl)		; $09ef
	ld ($ff00+$4b),a	; $09f0
	ldi a,(hl)		; $09f2
	ld ($ff00+$45),a	; $09f3
	inc (hl)		; $09f5
	jr nz,_label_00_091	; $09f6
	ld de,$c48b		; $09f8
	ld l,$91		; $09fb
	ld a,(de)		; $09fd
	ldi (hl),a		; $09fe
	inc e			; $09ff
	ld a,(de)		; $0a00
	ldi (hl),a		; $0a01
	inc e			; $0a02
	ld a,(de)		; $0a03
	ldi (hl),a		; $0a04
	inc e			; $0a05
	ld a,(de)		; $0a06
	ldi (hl),a		; $0a07
	inc e			; $0a08
	ld a,(de)		; $0a09
	ldi (hl),a		; $0a0a
	inc e			; $0a0b
	ld a,(de)		; $0a0c
	ldi (hl),a		; $0a0d
	ld a,($ff00+$4f)	; $0a0e
	ld b,a			; $0a10
	ld a,($ff00+$70)	; $0a11
	ld c,a			; $0a13
	push bc			; $0a14
	ldh a,(<hVBlankFunctionQueueTail)	; $0a15
	or a			; $0a17
	call nz,runVBlankFunctions		; $0a18
	call updateDirtyPalettes		; $0a1b
	di			; $0a1e
	call $ff80		; $0a1f
	pop bc			; $0a22
	ld a,c			; $0a23
	ld ($ff00+$70),a	; $0a24
	ld a,b			; $0a26
	ld ($ff00+$4f),a	; $0a27
	ld hl,$c49f		; $0a29
	ldi a,(hl)		; $0a2c
	ld ($c4a5),a		; $0a2d
	ldi a,(hl)		; $0a30
	ld ($c4a6),a		; $0a31
	ldi a,(hl)		; $0a34
	ld ($c4a7),a		; $0a35
_label_00_091:
	ld hl,$ffb5		; $0a38
	res 7,(hl)		; $0a3b
	ldh a,(<hRomBank)	; $0a3d
	bit 0,(hl)		; $0a3f
	jr z,_label_00_092	; $0a41
	ld a,($ff00+$d8)	; $0a43
_label_00_092:
	ld ($2222),a		; $0a45
	pop hl			; $0a48
	pop de			; $0a49
	pop bc			; $0a4a
	pop af			; $0a4b
	reti			; $0a4c

runVBlankFunctions:
	ld hl,$c400		; $0a4d
_label_00_093:
	ldi a,(hl)		; $0a50
	push hl			; $0a51
	ld c,a			; $0a52
	ld b,$00		; $0a53
	ld hl,vblankFunction0a8e		; $0a55
	add hl,bc		; $0a58
	jp hl			; $0a59
_label_00_094:

vblankFunctionRet:
	ldh a,(<hVBlankFunctionQueueTail)	; $0a5a
	cp l			; $0a5c
	jr nz,_label_00_093	; $0a5d
	xor a			; $0a5f
	ldh (<hVBlankFunctionQueueTail),a	; $0a60
	ret			; $0a62

vblankFunctionOffset0:
	nop			; $0a63

vblankRunBank4FunctionOffset:
	ld (de),a		; $0a64

vblankCopyTileFunctionOffset:
	add hl,hl		; $0a65

vblankFunctionOffset3:
	ld c,e			; $0a66

vblankFunctionOffset4:
	ld c,e			; $0a67

vblankFunctionOffset5:
	ld a,(de)		; $0a68

vblankDmaFunctionOffset:
	ld e,l			; $0a69

vblankFunctionsStart:

vblankFunction0a8e:
	pop hl			; $0a6a
	ldi a,(hl)		; $0a6b
	ld ($ff00+$4f),a	; $0a6c
	ldi a,(hl)		; $0a6e
	ld e,a			; $0a6f
	ldi a,(hl)		; $0a70
	ld d,a			; $0a71
	ldi a,(hl)		; $0a72
	ld b,a			; $0a73
_label_00_095:
	ldi a,(hl)		; $0a74
	ld (de),a		; $0a75
	inc de			; $0a76
	dec b			; $0a77
	jr nz,_label_00_095	; $0a78
	jr _label_00_094		; $0a7a

vblankRunBank4Function:
	ld a,$04		; $0a7c
	ld ($2222),a		; $0a7e
	jp $45c0		; $0a81

vblankFunction0aa8:
	pop hl			; $0a84
	ldi a,(hl)		; $0a85
	ld c,a			; $0a86
	ldi a,(hl)		; $0a87
	push hl			; $0a88
	ld l,c			; $0a89
	ld h,a			; $0a8a
	ld bc,$0a90		; $0a8b
	push bc			; $0a8e
	jp hl			; $0a8f
	pop hl			; $0a90
	jr _label_00_094		; $0a91

vblankCopyTileFunction:
	pop hl			; $0a93
	ld de,vblankFunctionRet		; $0a94
	push de			; $0a97
	xor a			; $0a98
	ld ($ff00+$4f),a	; $0a99
	ldi a,(hl)		; $0a9b
	ld e,a			; $0a9c
	ldi a,(hl)		; $0a9d
	ld d,a			; $0a9e
	ld c,e			; $0a9f
	call $0aa8		; $0aa0
	ld e,c			; $0aa3
	ld a,$01		; $0aa4
	ld ($ff00+$4f),a	; $0aa6
	ldi a,(hl)		; $0aa8
	ld (de),a		; $0aa9
	inc e			; $0aaa
	ldi a,(hl)		; $0aab
	ld (de),a		; $0aac
	ldi a,(hl)		; $0aad
	ld e,a			; $0aae
	ldi a,(hl)		; $0aaf
	ld (de),a		; $0ab0
	inc e			; $0ab1
	ldi a,(hl)		; $0ab2
	ld (de),a		; $0ab3
	ret			; $0ab4

vblankFunction0ad9:
	pop hl			; $0ab5
	ldi a,(hl)		; $0ab6
	ld ($ff00+$4f),a	; $0ab7
	ldi a,(hl)		; $0ab9
	ld e,a			; $0aba
	ldi a,(hl)		; $0abb
	ld d,a			; $0abc
	ldi a,(hl)		; $0abd
	ld b,a			; $0abe
_label_00_096:
	ldi a,(hl)		; $0abf
	ld (de),a		; $0ac0
	inc de			; $0ac1
	dec b			; $0ac2
	jr nz,_label_00_096	; $0ac3
	jr _label_00_094		; $0ac5

vblankDmaFunction:
	pop hl			; $0ac7
	ldi a,(hl)		; $0ac8
	ld ($ff00+$70),a	; $0ac9
	ld ($2222),a		; $0acb
	ldi a,(hl)		; $0ace
	ld ($ff00+$51),a	; $0acf
	ldi a,(hl)		; $0ad1
	ld ($ff00+$52),a	; $0ad2
	ldi a,(hl)		; $0ad4
	ld ($ff00+$4f),a	; $0ad5
	ldi a,(hl)		; $0ad7
	ld ($ff00+$53),a	; $0ad8
	ldi a,(hl)		; $0ada
	ld ($ff00+$54),a	; $0adb
	ldi a,(hl)		; $0add
	ld ($ff00+$55),a	; $0ade
	jp vblankFunctionRet		; $0ae0

updateDirtyPalettes:
	ld a,$02		; $0ae3
	ld ($ff00+$70),a	; $0ae5
	ldh a,(<hDirtyBgPalettes)	; $0ae7
	ld d,a			; $0ae9
	xor a			; $0aea
	ldh (<hDirtyBgPalettes),a	; $0aeb
	ld c,$68		; $0aed
	ld hl,$df00		; $0aef
	call $0aff		; $0af2
	ldh a,(<hDirtySprPalettes)	; $0af5
	ld d,a			; $0af7
	xor a			; $0af8
	ldh (<hDirtySprPalettes),a	; $0af9
	ld c,$6a		; $0afb
	ld l,$40		; $0afd
_label_00_097:
	srl d			; $0aff
	jr nc,_label_00_098	; $0b01
	ld a,l			; $0b03
	or $80			; $0b04
	ld ($ff00+c),a		; $0b06
	inc c			; $0b07
	ldi a,(hl)		; $0b08
	ld ($ff00+c),a		; $0b09
	ldi a,(hl)		; $0b0a
	ld ($ff00+c),a		; $0b0b
	ldi a,(hl)		; $0b0c
	ld ($ff00+c),a		; $0b0d
	ldi a,(hl)		; $0b0e
	ld ($ff00+c),a		; $0b0f
	ldi a,(hl)		; $0b10
	ld ($ff00+c),a		; $0b11
	ldi a,(hl)		; $0b12
	ld ($ff00+c),a		; $0b13
	ldi a,(hl)		; $0b14
	ld ($ff00+c),a		; $0b15
	ldi a,(hl)		; $0b16
	ld ($ff00+c),a		; $0b17
	dec c			; $0b18
	jr _label_00_097		; $0b19
_label_00_098:
	ret z			; $0b1b
	ld a,l			; $0b1c
	add $08			; $0b1d
	ld l,a			; $0b1f
	jr _label_00_097		; $0b20

lcdInterrupt:
	ldh a,(<hLcdInterruptBehaviour)	; $0b22
	cp $02			; $0b24
	jr nc,_label_00_102	; $0b26
	or a			; $0b28
	ld a,($ff00+$44)	; $0b29
	ld l,a			; $0b2b
	ld h,$c3		; $0b2c
	ldi a,(hl)		; $0b2e
	jr nz,_label_00_099	; $0b2f
	ld ($ff00+$43),a	; $0b31
	jr _label_00_100		; $0b33
_label_00_099:
	ld ($ff00+$42),a	; $0b35
_label_00_100:
	ld a,l			; $0b37
	cp $90			; $0b38
	jr nc,_label_00_101	; $0b3a
	ld ($ff00+$45),a	; $0b3c
_label_00_101:
	pop hl			; $0b3e
	pop af			; $0b3f
	reti			; $0b40
_label_00_102:
	push bc			; $0b41
	ld c,$03		; $0b42
	ldh a,(<hLcdInterruptCounter)	; $0b44
	or a			; $0b46
	jr nz,_label_00_105	; $0b47
	ld hl,$c491		; $0b49
_label_00_103:
	ld a,($ff00+$41)	; $0b4c
	and c			; $0b4e
	jr nz,_label_00_103	; $0b4f
	ldi a,(hl)		; $0b51
	ld ($ff00+$40),a	; $0b52
	ldi a,(hl)		; $0b54
	ld ($ff00+$42),a	; $0b55
	ldi a,(hl)		; $0b57
	ld ($ff00+$43),a	; $0b58
	ldi a,(hl)		; $0b5a
	ld ($ff00+$4a),a	; $0b5b
	ldi a,(hl)		; $0b5d
	ld ($ff00+$4b),a	; $0b5e
	ldi a,(hl)		; $0b60
	ld ($ff00+$45),a	; $0b61
	ldh a,(<hLcdInterruptBehaviour)	; $0b63
	cp $02			; $0b65
	jr nz,_label_00_104	; $0b67
	xor a			; $0b69
	ldh (<hLcdInterruptBehaviour),a	; $0b6a
_label_00_104:
	ld a,$01		; $0b6c
	ldh (<hLcdInterruptCounter),a	; $0b6e
	jr _label_00_112		; $0b70
_label_00_105:
	ldh a,(<hLcdInterruptBehaviour)	; $0b72
	cp $07			; $0b74
	jr nc,_label_00_111	; $0b76
	rst_jumpTable			; $0b78
	cp (hl)			; $0b79
	dec bc			; $0b7a
	cp (hl)			; $0b7b
	dec bc			; $0b7c
	cp (hl)			; $0b7d
	dec bc			; $0b7e
	add a			; $0b7f
	dec bc			; $0b80
	cp b			; $0b81
	dec bc			; $0b82
	sub d			; $0b83
	dec bc			; $0b84
	add $0b			; $0b85
_label_00_106:

lcdInterrupt_setLcdcToA7:
	ld a,($ff00+$41)	; $0b87
	and c			; $0b89
	jr nz,_label_00_106	; $0b8a
	ld a,$a7		; $0b8c
	ld ($ff00+$40),a	; $0b8e
	jr _label_00_111		; $0b90
_label_00_107:

lcdInterrupt_ringMenu:
	ld a,($ff00+$41)	; $0b92
	and c			; $0b94
	jr nz,_label_00_107	; $0b95
	ld ($ff00+$43),a	; $0b97
	ld a,$87		; $0b99
	ld ($ff00+$40),a	; $0b9b
	ldh a,(<hLcdInterruptCounter)	; $0b9d
	dec a			; $0b9f
	jr nz,_label_00_109	; $0ba0
	ld a,($cbd3)		; $0ba2
	or a			; $0ba5
	jr z,_label_00_108	; $0ba6
	ld a,$87		; $0ba8
	ld ($ff00+$45),a	; $0baa
_label_00_108:
	ld a,$02		; $0bac
	ldh (<hLcdInterruptCounter),a	; $0bae
	jr _label_00_112		; $0bb0
_label_00_109:
	ld a,$80		; $0bb2
	ld ($ff00+$42),a	; $0bb4
	jr _label_00_110		; $0bb6
_label_00_110:

lcdInterrupt_clearWXY:
	ld a,$c7		; $0bb8
	ld ($ff00+$4a),a	; $0bba
	ld ($ff00+$4b),a	; $0bbc
_label_00_111:

lcdInterrupt_clearLYC:
	ld a,$c7		; $0bbe
	ld ($ff00+$45),a	; $0bc0
_label_00_112:

_lcdInterruptEnd:
	pop bc			; $0bc2
	pop hl			; $0bc3
	pop af			; $0bc4
	reti			; $0bc5
_label_00_113:

lcdInterrupt_0bea:
	ld a,($ff00+$41)	; $0bc6
	and c			; $0bc8
	jr nz,_label_00_113	; $0bc9
	ld hl,$c4a5		; $0bcb
	ldi a,(hl)		; $0bce
	ld ($ff00+$40),a	; $0bcf
	ldi a,(hl)		; $0bd1
	ld ($ff00+$42),a	; $0bd2
	ldi a,(hl)		; $0bd4
	ld ($ff00+$43),a	; $0bd5
	jr _label_00_111		; $0bd7

data_0bfd:
	nop			; $0bd9
	ld b,b			; $0bda
	ld l,$40		; $0bdb
	ld e,h			; $0bdd
	ld b,b			; $0bde
	adc d			; $0bdf
	ld b,b			; $0be0
	cp b			; $0be1
	ld b,b			; $0be2
	and $40			; $0be3
	inc d			; $0be5
	ld b,c			; $0be6
	ld b,d			; $0be7
	ld b,c			; $0be8
	ld (hl),b		; $0be9
	ld b,c			; $0bea
	sbc (hl)		; $0beb
	ld b,c			; $0bec
	call z,$fa41		; $0bed
	ld b,c			; $0bf0
	jr z,$42		; $0bf1
	ld d,(hl)		; $0bf3
	ld b,d			; $0bf4
	add h			; $0bf5
	ld b,d			; $0bf6
	or d			; $0bf7
	ld b,d			; $0bf8
	ld ($ff00+$42),a	; $0bf9
	ld c,$43		; $0bfb
	inc a			; $0bfd
	ld b,e			; $0bfe
	ld l,d			; $0bff
	ld b,e			; $0c00
	sbc b			; $0c01
	ld b,e			; $0c02
	add $43			; $0c03
.DB $f4				; $0c05
	ld b,e			; $0c06
	ldi (hl),a		; $0c07
	ld b,h			; $0c08
	ld d,b			; $0c09
	ld b,h			; $0c0a
	ld a,(hl)		; $0c0b
	ld b,h			; $0c0c
	xor h			; $0c0d
	ld b,h			; $0c0e
	jp c,$0844		; $0c0f
	ld b,l			; $0c12
	ld (hl),$45		; $0c13
	ld h,h			; $0c15
	ld b,l			; $0c16
	sub d			; $0c17
	ld b,l			; $0c18

serialInterrupt:
	ldh a,(<hSerialInterruptBehaviour)	; $0c19
	or a			; $0c1b
	jr z,_label_00_114	; $0c1c
	ld a,($ff00+$01)	; $0c1e
	ldh (<hSerialByte),a	; $0c20
	xor a			; $0c22
	ld ($ff00+$01),a	; $0c23
	inc a			; $0c25
	ldh (<hSerialRead),a	; $0c26
	pop af			; $0c28
	reti			; $0c29
_label_00_114:
	ld a,($ff00+$01)	; $0c2a
	cp $e1			; $0c2c
	jr z,_label_00_115	; $0c2e
	cp $e0			; $0c30
	jr nz,_label_00_116	; $0c32
_label_00_115:
	ldh (<hSerialInterruptBehaviour),a	; $0c34
	xor a			; $0c36
	ld ($ff00+$01),a	; $0c37
	pop af			; $0c39
	reti			; $0c3a
_label_00_116:
	ld a,$e1		; $0c3b
	ld ($ff00+$01),a	; $0c3d
	ld a,$80		; $0c3f
	call writeToSC		; $0c41
	pop af			; $0c44
	reti			; $0c45
_label_00_117:

writeToSC:
	push af			; $0c46
	and $01			; $0c47
	ld ($ff00+$02),a	; $0c49
	pop af			; $0c4b
	ld ($ff00+$02),a	; $0c4c
	ret			; $0c4e

serialFunc_0c73:
	xor a			; $0c4f
	ldh (<hFFBD),a	; $0c50
	ld a,$e0		; $0c52
	ld ($ff00+$01),a	; $0c54
	ld a,$81		; $0c56
	jr _label_00_117		; $0c58

serialFunc_0c7e:
	xor a			; $0c5a
	ldh (<hSerialInterruptBehaviour),a	; $0c5b
	ld ($ff00+$01),a	; $0c5d
	jr _label_00_117		; $0c5f

serialFunc_0c85:
	ld hl,$44ac		; $0c61
	ld e,$15		; $0c64
	jp interBankCall		; $0c66

serialFunc_0c8d:
	push de			; $0c69
	ld hl,$4000		; $0c6a
	ld e,$15		; $0c6d
	call interBankCall		; $0c6f
	pop de			; $0c72
	ret			; $0c73

playSound:
	or a			; $0c74
	ret z			; $0c75
	ld h,a			; $0c76
	ldh a,(<hFFB7)	; $0c77
	bit 3,a			; $0c79
	ret nz			; $0c7b
	ldh a,(<hMusicQueueTail)	; $0c7c
	ld l,a			; $0c7e
	ld a,h			; $0c7f
	ld h,$c0		; $0c80
	ldi (hl),a		; $0c82
	ld a,l			; $0c83
	and $af			; $0c84
	ldh (<hMusicQueueTail),a	; $0c86
	ret			; $0c88

setMusicVolume:
	or $80			; $0c89
	ldh (<hMusicVolume),a	; $0c8b
	ret			; $0c8d

restartSound:
	ld bc,$4009		; $0c8e
	jr _label_00_118		; $0c91

initSound:
	ld bc,$4000		; $0c93
_label_00_118:

_startSound:
	push de			; $0c96
	ldh a,(<hRomBank)	; $0c97
	push af			; $0c99
	call disableTimer		; $0c9a
	ld a,$39		; $0c9d
	ld ($ff00+$d9),a	; $0c9f
	ld ($ff00+$d8),a	; $0ca1
	ldh (<hRomBank),a	; $0ca3
	ld ($2222),a		; $0ca5
	call jpBc		; $0ca8
	call enableTimer		; $0cab
	pop af			; $0cae
	ldh (<hRomBank),a	; $0caf
	ld ($2222),a		; $0cb1
	pop de			; $0cb4
	ret			; $0cb5

jpBc:
	ld l,c			; $0cb6
	ld h,b			; $0cb7
	jp hl			; $0cb8

disableTimer:
	ld hl,$ffb5		; $0cb9
	set 0,(hl)		; $0cbc
	xor a			; $0cbe
	ld ($ff00+$07),a	; $0cbf
	ret			; $0cc1

enableTimer:
	xor a			; $0cc2
	ld ($ff00+$07),a	; $0cc3
	ld a,$a0		; $0cc5
	ldh (<hMusicQueueTail),a	; $0cc7
	ldh (<hMusicQueueHead),a	; $0cc9
	ld a,($ff00+$4d)	; $0ccb
	rlca			; $0ccd
	ld a,$77		; $0cce
	jr c,_label_00_119	; $0cd0
	ld a,$bb		; $0cd2
_label_00_119:
	ld hl,$ff05		; $0cd4
	ldi (hl),a		; $0cd7
	ldi (hl),a		; $0cd8
	xor a			; $0cd9
	ld (hl),a		; $0cda
	set 2,(hl)		; $0cdb
	ld hl,$ffb5		; $0cdd
	res 0,(hl)		; $0ce0
	ret			; $0ce2

timerInterrupt:
	ld hl,$ffb5		; $0ce3
	bit 7,(hl)		; $0ce6
	jr nz,_label_00_124	; $0ce8
	bit 0,(hl)		; $0cea
	jr nz,_label_00_124	; $0cec
	set 0,(hl)		; $0cee
	inc l			; $0cf0
	dec (hl)		; $0cf1
	jr nz,_label_00_120	; $0cf2
	ld (hl),$07		; $0cf4
	ld a,($ff00+$06)	; $0cf6
	dec a			; $0cf8
	ld ($ff00+$05),a	; $0cf9
_label_00_120:
	ld a,$39		; $0cfb
	ld ($2222),a		; $0cfd
	ldh a,(<hMusicVolume)	; $0d00
	bit 7,a			; $0d02
	jr z,_label_00_121	; $0d04
	and $03			; $0d06
	ldh (<hMusicVolume),a	; $0d08
	call $4010		; $0d0a
_label_00_121:
	ldh a,(<hMusicQueueTail)	; $0d0d
	ld b,a			; $0d0f
	ldh a,(<hMusicQueueHead)	; $0d10
	cp b			; $0d12
	jr z,_label_00_123	; $0d13
	ld h,$c0		; $0d15
_label_00_122:
	ld l,a			; $0d17
	ldi a,(hl)		; $0d18
	push bc			; $0d19
	push hl			; $0d1a
	call $4006		; $0d1b
	pop hl			; $0d1e
	pop bc			; $0d1f
	ld a,l			; $0d20
	and $af			; $0d21
	cp b			; $0d23
	jr nz,_label_00_122	; $0d24
	ldh (<hMusicQueueHead),a	; $0d26
_label_00_123:
	call $4003		; $0d28
	ld hl,$ffb5		; $0d2b
	res 0,(hl)		; $0d2e
	ldh a,(<hRomBank)	; $0d30
	ld ($2222),a		; $0d32
_label_00_124:
	pop hl			; $0d35
	pop de			; $0d36
	pop bc			; $0d37
	pop af			; $0d38
	reti			; $0d39

addSpritesToOam:
	ld bc,$0000		; $0d3a

addSpritesToOam_withOffset:
	ldh a,(<hOamTail)	; $0d3d
	cp $a0			; $0d3f
	ret nc			; $0d41
	ld e,a			; $0d42
	ld d,$cb		; $0d43
	ldi a,(hl)		; $0d45
	or a			; $0d46
	ret z			; $0d47
_label_00_125:
	ldh (<hFF8B),a	; $0d48
	ldi a,(hl)		; $0d4a
	add b			; $0d4b
	cp $a0			; $0d4c
	jr nc,_label_00_128	; $0d4e
	ld (de),a		; $0d50
	ldi a,(hl)		; $0d51
	add c			; $0d52
	cp $a8			; $0d53
	jr nc,_label_00_129	; $0d55
	inc e			; $0d57
	ld (de),a		; $0d58
	inc e			; $0d59
	ldi a,(hl)		; $0d5a
	ld (de),a		; $0d5b
	inc e			; $0d5c
	ldi a,(hl)		; $0d5d
	ld (de),a		; $0d5e
	inc e			; $0d5f
	ld a,e			; $0d60
	cp $a0			; $0d61
	jr nc,_label_00_127	; $0d63
_label_00_126:
	ldh a,(<hFF8B)	; $0d65
	dec a			; $0d67
	jr nz,_label_00_125	; $0d68
	ld a,e			; $0d6a
_label_00_127:
	ldh (<hOamTail),a	; $0d6b
	ret			; $0d6d
_label_00_128:
	inc hl			; $0d6e
_label_00_129:
	inc hl			; $0d6f
	inc hl			; $0d70
	ld a,$e0		; $0d71
	ld (de),a		; $0d73
	jr _label_00_126		; $0d74

drawAllSprites:
	ld hl,$c4b6		; $0d76
	bit 0,(hl)		; $0d79
	ret nz			; $0d7b
	ld (hl),$ff		; $0d7c

drawAllSpritesUnconditionally:
	ldh a,(<hRomBank)	; $0d7e
	push af			; $0d80
	call queueDrawEverything		; $0d81
	ld de,$d000		; $0d84
	ld b,$0b		; $0d87
	ld a,($cbae)		; $0d89
	and $04			; $0d8c
	jr z,_label_00_130	; $0d8e
	call objectQueueDraw		; $0d90
	jr _label_00_131		; $0d93
_label_00_130:
	call objectQueueDraw		; $0d95
	inc d			; $0d98
	ld a,d			; $0d99
	cp $d6			; $0d9a
	jr c,_label_00_130	; $0d9c
_label_00_131:
	ld a,$13		; $0d9e
	ldh (<hRomBank),a	; $0da0
	ld ($2222),a		; $0da2
	ld a,(wFrameCounter)		; $0da5
	add a			; $0da8
	swap a			; $0da9
	and $03			; $0dab
	ld hl,$405f		; $0dad
	rst_addDoubleIndex			; $0db0
	ldi a,(hl)		; $0db1
	ld ($c4ba),a		; $0db2
	ldi a,(hl)		; $0db5
	ld ($c4bb),a		; $0db6
	ld hl,$c4b7		; $0db9
	ld a,$c3		; $0dbc
	ldi (hl),a		; $0dbe
	ld a,$50		; $0dbf
	ldi (hl),a		; $0dc1
	ld (hl),$0f		; $0dc2
	ld a,($cd00)		; $0dc4
	cp $08			; $0dc7
	jr nz,_label_00_133	; $0dc9
	ld a,$0f		; $0dcb
	ldd (hl),a		; $0dcd
	ld (hl),$8f		; $0dce
	xor a			; $0dd0
	ld b,a			; $0dd1
	inc a			; $0dd2
	ldh (<hFF8A),a	; $0dd3
	ld a,($cc4a)		; $0dd5
	or a			; $0dd8
	jr z,_label_00_132	; $0dd9
	ld a,$04		; $0ddb
_label_00_132:
	ld c,a			; $0ddd
	ld a,($cd02)		; $0dde
	add c			; $0de1
	add a			; $0de2
	add a			; $0de3
	ld c,a			; $0de4
	ld hl,data_1058		; $0de5
	add hl,bc		; $0de8
	ldi a,(hl)		; $0de9
	ldh (<hFF90),a	; $0dea
	ldi a,(hl)		; $0dec
	ldh (<hFF91),a	; $0ded
	ldi a,(hl)		; $0def
	ldh (<hFF92),a	; $0df0
	ldi a,(hl)		; $0df2
	ldh (<hFF93),a	; $0df3
_label_00_133:
	ld hl,$c500		; $0df5
_label_00_134:
	ld a,(hl)		; $0df8
	or a			; $0df9
	call nz,$0e3b		; $0dfa
	inc l			; $0dfd
	inc l			; $0dfe
	bit 7,l			; $0dff
	jr z,_label_00_134	; $0e01
	ld hl,$c4c0		; $0e03
	ldh a,(<hTerrainEffectsBufferUsedSize)	; $0e06
	rrca			; $0e08
	srl a			; $0e09
	ld b,a			; $0e0b
	jr z,_label_00_136	; $0e0c
_label_00_135:
	push bc			; $0e0e
	ldi a,(hl)		; $0e0f
	ldh (<hFF8C),a	; $0e10
	ldi a,(hl)		; $0e12
	ldh (<hFF8D),a	; $0e13
	ldi a,(hl)		; $0e15
	push hl			; $0e16
	ld h,(hl)		; $0e17
	ld l,a			; $0e18
	call func_0eda		; $0e19
	pop hl			; $0e1c
	inc l			; $0e1d
	pop bc			; $0e1e
	dec b			; $0e1f
	jr nz,_label_00_135	; $0e20
_label_00_136:
	ldh a,(<hOamTail)	; $0e22
	cp $a0			; $0e24
	jr nc,_label_00_138	; $0e26
	ld h,$cb		; $0e28
	ld b,$e0		; $0e2a
_label_00_137:
	ld l,a			; $0e2c
	ld (hl),b		; $0e2d
	add $04			; $0e2e
	cp $a0			; $0e30
	jr c,_label_00_137	; $0e32
_label_00_138:
	pop af			; $0e34
	ldh (<hRomBank),a	; $0e35
	ld ($2222),a		; $0e37
	ret			; $0e3a
	push hl			; $0e3b
	inc l			; $0e3c
	ld h,(hl)		; $0e3d
	ld l,a			; $0e3e
	call $c4b7		; $0e3f
	jr nc,_label_00_141	; $0e42
	ldi a,(hl)		; $0e44
	ldh (<hFF8F),a	; $0e45

	; Object.oamTileIndexBase
	ldi a,(hl)		; $0e47
	ldh (<hFF8E),a	; $0e48

	; Object.oamDataAddress
	ldi a,(hl)		; $0e4a
	ld h,(hl)		; $0e4b
	ld l,a			; $0e4c

	; Get address, bank of animation frame data
	ld a,h			; $0e4d
	and $c0			; $0e4e
	rlca			; $0e50
	rlca			; $0e51
	add $12			; $0e52
	ldh (<hRomBank),a	; $0e54
	ld ($2222),a		; $0e56
	set 6,h			; $0e59
	res 7,h			; $0e5b
	ldi a,(hl)		; $0e5d
	or a			; $0e5e
	jr z,_label_00_141	; $0e5f
	ld c,a			; $0e61
	ldh a,(<hOamTail)	; $0e62
	ld e,a			; $0e64
	ld a,$a0		; $0e65
	sub e			; $0e67
	jr z,_label_00_141	; $0e68
	rrca			; $0e6a
	rrca			; $0e6b
	ld b,a			; $0e6c
	ld d,$cb		; $0e6d
_label_00_139:
	ldh a,(<hFF8C)	; $0e6f
	add (hl)		; $0e71
	inc hl			; $0e72
	cp $a0			; $0e73
	jr nc,_label_00_142	; $0e75
	ld (de),a		; $0e77
	ldh a,(<hFF8D)	; $0e78
	add (hl)		; $0e7a
	cp $a8			; $0e7b
	jr nc,_label_00_142	; $0e7d
	inc e			; $0e7f
	ld (de),a		; $0e80
	inc hl			; $0e81
	inc e			; $0e82
	ldh a,(<hFF8E)	; $0e83
	add (hl)		; $0e85
	ld (de),a		; $0e86
	inc hl			; $0e87
	inc e			; $0e88
	ldh a,(<hFF8F)	; $0e89
	xor (hl)		; $0e8b
	ld (de),a		; $0e8c
	inc hl			; $0e8d
	inc e			; $0e8e
	dec b			; $0e8f
	jr z,_label_00_140	; $0e90
	dec c			; $0e92
	jr nz,_label_00_139	; $0e93
_label_00_140:
	ld a,e			; $0e95
	ldh (<hOamTail),a	; $0e96
_label_00_141:
	pop hl			; $0e98
	ld (hl),$00		; $0e99
	ret			; $0e9b
_label_00_142:
	inc hl			; $0e9c
	inc hl			; $0e9d
	inc hl			; $0e9e
	dec c			; $0e9f
	jr nz,_label_00_139	; $0ea0
	jr _label_00_140		; $0ea2

func_0eda:
	ld a,$13		; $0ea4
	ldh (<hRomBank),a	; $0ea6
	ld ($2222),a		; $0ea8
	ldh a,(<hOamTail)	; $0eab
	ld e,a			; $0ead
	ldi a,(hl)		; $0eae
	ld c,a			; $0eaf
	add a			; $0eb0
	add a			; $0eb1
	add e			; $0eb2
	cp $a1			; $0eb3
	jr nc,_label_00_144	; $0eb5
	ld d,$cb		; $0eb7
_label_00_143:
	ldh a,(<hFF8C)	; $0eb9
	add (hl)		; $0ebb
	ld (de),a		; $0ebc
	inc hl			; $0ebd
	inc e			; $0ebe
	ldh a,(<hFF8D)	; $0ebf
	add (hl)		; $0ec1
	ld (de),a		; $0ec2
	inc hl			; $0ec3
	inc e			; $0ec4
	ldi a,(hl)		; $0ec5
	ld (de),a		; $0ec6
	inc e			; $0ec7
	ldi a,(hl)		; $0ec8
	ld (de),a		; $0ec9
	inc e			; $0eca
	dec c			; $0ecb
	jr nz,_label_00_143	; $0ecc
	ld a,e			; $0ece
	ldh (<hOamTail),a	; $0ecf
_label_00_144:
	ret			; $0ed1

_drawObjectTerrainEffects:
	ld a,($cc50)		; $0ed2
	and $20			; $0ed5
	ret nz			; $0ed7
	ld a,b			; $0ed8
	cp $97			; $0ed9
	ret nc			; $0edb
	bit 7,e			; $0edc
	jr z,_label_00_145	; $0ede
	ld a,(wFrameCounter)		; $0ee0
	xor h			; $0ee3
	rrca			; $0ee4
	ret nc			; $0ee5
	push hl			; $0ee6
	ldh a,(<hTerrainEffectsBufferUsedSize)	; $0ee7
	add $c0			; $0ee9
	ld l,a			; $0eeb
	ld h,$c4		; $0eec
	ldh a,(<hFF8C)	; $0eee
	ldi (hl),a		; $0ef0
	ldh a,(<hFF8D)	; $0ef1
	ldi (hl),a		; $0ef3
	ld a,$00		; $0ef4
	ldi (hl),a		; $0ef6
	ld a,$40		; $0ef7
	ldi (hl),a		; $0ef9
	ld a,l			; $0efa
	sub $c0			; $0efb
	ldh (<hTerrainEffectsBufferUsedSize),a	; $0efd
	pop hl			; $0eff
	ret			; $0f00
_label_00_145:
	ld a,($cd00)		; $0f01
	cp $08			; $0f04
	ret z			; $0f06
	push hl			; $0f07
	ld a,l			; $0f08
	and $c0			; $0f09
	add $0b			; $0f0b
	ld l,a			; $0f0d
	ldi a,(hl)		; $0f0e
	ld b,a			; $0f0f
	add $05			; $0f10
	and $f0			; $0f12
	ld c,a			; $0f14
	inc l			; $0f15
	ld l,(hl)		; $0f16
	ld a,l			; $0f17
	xor b			; $0f18
	ld h,a			; $0f19
	ld a,l			; $0f1a
	and $f0			; $0f1b
	swap a			; $0f1d
	or c			; $0f1f
	ld c,a			; $0f20
	ld b,$cf		; $0f21
	ld a,(bc)		; $0f23
	cp $f8			; $0f24
	jr c,_label_00_149	; $0f26
	cp $fd			; $0f28
	jr nc,_label_00_149	; $0f2a
	cp $fa			; $0f2c
	jr c,_label_00_146	; $0f2e
	inc e			; $0f30
	ld hl,$c4ba		; $0f31
	ldi a,(hl)		; $0f34
	ld h,(hl)		; $0f35
	ld l,a			; $0f36
	jr _label_00_148		; $0f37
_label_00_146:
	bit 2,h			; $0f39
	ld a,($cc52)		; $0f3b
	jr z,_label_00_147	; $0f3e
	add $24			; $0f40
_label_00_147:
	ld c,a			; $0f42
	ld b,$00		; $0f43
	ld hl,$4005		; $0f45
	add hl,bc		; $0f48
_label_00_148:
	push de			; $0f49
	call func_0eda		; $0f4a
	pop de			; $0f4d
_label_00_149:
	pop hl			; $0f4e
	ret			; $0f4f

_getObjectPositionOnScreen:
	ldh a,(<hCameraX)	; $0f50
	ld c,a			; $0f52
	ldh a,(<hCameraY)	; $0f53
	ld b,a			; $0f55
	ldi a,(hl)		; $0f56
	sub b			; $0f57
	add $10			; $0f58
	ldh (<hFF8C),a	; $0f5a
	ld d,a			; $0f5c
	inc l			; $0f5d
	ldi a,(hl)		; $0f5e
	sub c			; $0f5f
_label_00_150:
	ldh (<hFF8D),a	; $0f60
	inc l			; $0f62
	ld e,(hl)		; $0f63
	ld a,l			; $0f64
	and $c0			; $0f65
	add $1a			; $0f67
	ld l,a			; $0f69
	ld a,(hl)		; $0f6a
	rlca			; $0f6b
	ret nc			; $0f6c
	rlca			; $0f6d
	call c,_drawObjectTerrainEffects		; $0f6e
	ld a,d			; $0f71
	add e			; $0f72
	ldh (<hFF8C),a	; $0f73
	ld a,l			; $0f75
	and $c0			; $0f76
	add $1c			; $0f78
	ld l,a			; $0f7a
	scf			; $0f7b
	ret			; $0f7c
_label_00_151:
	ldh a,(<hCameraX)	; $0f7d
	ld c,a			; $0f7f
	ldh a,(<hCameraY)	; $0f80
	ld b,a			; $0f82
	ldi a,(hl)		; $0f83
	sub b			; $0f84
	add $10			; $0f85
	ldh (<hFF8C),a	; $0f87
	ld d,a			; $0f89
	inc l			; $0f8a
	ldi a,(hl)		; $0f8b
	sub c			; $0f8c
	jr _label_00_150		; $0f8d

_getObjectPositionOnScreen_duringScreenTransition:
	ld d,h			; $0f8f
	ld a,l			; $0f90
	and $c0			; $0f91
	ld e,a			; $0f93
	ld a,(de)		; $0f94
	and $03			; $0f95
	cp $03			; $0f97
	jr z,_label_00_151	; $0f99
	ld d,$00		; $0f9b
	ldi a,(hl)		; $0f9d
	add $10			; $0f9e
	ld c,a			; $0fa0
	ld a,d			; $0fa1
	adc a			; $0fa2
	ld b,a			; $0fa3
	inc l			; $0fa4
	ldi a,(hl)		; $0fa5
	ld e,a			; $0fa6
	push hl			; $0fa7
	ld a,l			; $0fa8
	and $c0			; $0fa9
	ld l,a			; $0fab
	ldh a,(<hFF8A)	; $0fac
	and (hl)		; $0fae
	jr z,_label_00_152	; $0faf
	ld hl,$ff90		; $0fb1
	ldi a,(hl)		; $0fb4
	add c			; $0fb5
	ld c,a			; $0fb6
	ldi a,(hl)		; $0fb7
	adc b			; $0fb8
	ld b,a			; $0fb9
	ldi a,(hl)		; $0fba
	add e			; $0fbb
	ld e,a			; $0fbc
	ldi a,(hl)		; $0fbd
	adc d			; $0fbe
	ld d,a			; $0fbf
_label_00_152:
	ld hl,$ffa8		; $0fc0
	ld a,c			; $0fc3
	sub (hl)		; $0fc4
	ld c,a			; $0fc5
	inc l			; $0fc6
	ld a,b			; $0fc7
	sbc (hl)		; $0fc8
	ld b,a			; $0fc9
	jr z,_label_00_153	; $0fca
	inc a			; $0fcc
	jr nz,_label_00_157	; $0fcd
	ld a,c			; $0fcf
	cp $e0			; $0fd0
	jr c,_label_00_157	; $0fd2
	jr _label_00_154		; $0fd4
_label_00_153:
	ld a,c			; $0fd6
	cp $b0			; $0fd7
	jr nc,_label_00_157	; $0fd9
_label_00_154:
	ldh (<hFF8C),a	; $0fdb
	ld b,a			; $0fdd
	inc l			; $0fde
	ld a,e			; $0fdf
	sub (hl)		; $0fe0
	ld e,a			; $0fe1
	inc l			; $0fe2
	ld a,d			; $0fe3
	sbc (hl)		; $0fe4
	ld d,a			; $0fe5
	jr z,_label_00_155	; $0fe6
	inc a			; $0fe8
	jr nz,_label_00_157	; $0fe9
	ld a,e			; $0feb
	cp $e8			; $0fec
	jr c,_label_00_157	; $0fee
	jr _label_00_156		; $0ff0
_label_00_155:
	ld a,e			; $0ff2
	cp $b8			; $0ff3
	jr nc,_label_00_157	; $0ff5
_label_00_156:
	ldh (<hFF8D),a	; $0ff7
	ld d,b			; $0ff9
	pop hl			; $0ffa
	inc l			; $0ffb
	ld e,(hl)		; $0ffc
	ld a,l			; $0ffd
	and $c0			; $0ffe
	add $1a			; $1000
	ld l,a			; $1002
	ld a,(hl)		; $1003
	rlca			; $1004
	ret nc			; $1005
	rlca			; $1006
	call c,_drawObjectTerrainEffects		; $1007
	ld a,d			; $100a
	add e			; $100b
	ldh (<hFF8C),a	; $100c
	ld a,l			; $100e
	and $c0			; $100f
	add $1c			; $1011
	ld l,a			; $1013
	scf			; $1014
	ret			; $1015
_label_00_157:
	pop hl			; $1016
	ld a,l			; $1017
	and $c0			; $1018
	ld l,a			; $101a
	bit 1,(hl)		; $101b
	jr z,_label_00_158	; $101d
	or $1a			; $101f
	ld l,a			; $1021
	ld (hl),$00		; $1022
_label_00_158:
	xor a			; $1024
	ret			; $1025

data_1058:
	add b			; $1026
	rst $38			; $1027
	nop			; $1028
	nop			; $1029
	nop			; $102a
	nop			; $102b
	and b			; $102c
	nop			; $102d
	add b			; $102e
	nop			; $102f
	nop			; $1030
	nop			; $1031
	nop			; $1032
	nop			; $1033
	ld h,b			; $1034
	rst $38			; $1035
	ld d,b			; $1036
	rst $38			; $1037
	nop			; $1038
	nop			; $1039
	nop			; $103a
	nop			; $103b
	ld a,($ff00+$00)	; $103c
	or b			; $103e
	nop			; $103f
	nop			; $1040
	nop			; $1041
	nop			; $1042
	nop			; $1043
	stop			; $1044
	rst $38			; $1045

queueDrawEverything:
	ld hl,$ff9e		; $1046
	xor a			; $1049
	ldi (hl),a		; $104a
	ldi (hl),a		; $104b
	ldi (hl),a		; $104c
	ldi (hl),a		; $104d
	ldi (hl),a		; $104e
	ld de,$d600		; $104f
	ld b,$0b		; $1052
	call $106c		; $1054
	ld de,$d080		; $1057
	ld b,$8b		; $105a
	call $106c		; $105c
	ld de,$d0c0		; $105f
	ld b,$cb		; $1062
	call $106c		; $1064
	ld de,$d040		; $1067
	ld b,$4b		; $106a
_label_00_159:
	call objectQueueDraw		; $106c
	inc d			; $106f
	ld a,d			; $1070
	cp $e0			; $1071
	jr c,_label_00_159	; $1073
	ret			; $1075

objectQueueDraw:
	ld a,(de)		; $1076
	or a			; $1077
	ret z			; $1078
	ld a,e			; $1079
	or $1a			; $107a
	ld l,a			; $107c
	ld h,d			; $107d
	ld a,(hl)		; $107e
	bit 7,a			; $107f
	ret z			; $1081
	and $03			; $1082
	ld h,a			; $1084
	add $9f			; $1085
	ld c,a			; $1087
	ld a,($ff00+c)		; $1088
	cp $10			; $1089
	ret nc			; $108b
	inc a			; $108c
	ld ($ff00+c),a		; $108d
	dec a			; $108e
	swap h			; $108f
	add h			; $1091
	add a			; $1092
	ld l,a			; $1093
	ld h,$c5		; $1094
	ld a,b			; $1096
	ldi (hl),a		; $1097
	ld (hl),d		; $1098
	ret			; $1099

getChestData:
	ldh a,(<hRomBank)	; $109a
	push af			; $109c
	ld a,$15		; $109d
	ldh (<hRomBank),a	; $109f
	ld ($2222),a		; $10a1
	ld a,($cc49)		; $10a4
	ld hl,$4f6c		; $10a7
	rst_addDoubleIndex			; $10aa
	ldi a,(hl)		; $10ab
	ld h,(hl)		; $10ac
	ld l,a			; $10ad
	ld a,($cc4c)		; $10ae
	ld b,a			; $10b1
_label_00_160:
	ldi a,(hl)		; $10b2
	ld e,a			; $10b3
	inc a			; $10b4
	jr z,_label_00_162	; $10b5
	ldi a,(hl)		; $10b7
	cp b			; $10b8
	jr z,_label_00_161	; $10b9
	inc hl			; $10bb
	inc hl			; $10bc
	jr _label_00_160		; $10bd
_label_00_161:
	ld b,(hl)		; $10bf
	inc hl			; $10c0
	ld c,(hl)		; $10c1
	jr _label_00_163		; $10c2
_label_00_162:
	ld bc,$2800		; $10c4
_label_00_163:
	pop af			; $10c7
	ldh (<hRomBank),a	; $10c8
	ld ($2222),a		; $10ca
	ret			; $10cd

setDeathRespawnPoint:
	ld hl,$c62b		; $10ce
	ld a,($cc49)		; $10d1
	ldi (hl),a		; $10d4
	ld a,($cc4c)		; $10d5
	ldi (hl),a		; $10d8
	ld a,($cc4e)		; $10d9
	ldi (hl),a		; $10dc
	ld a,($d008)		; $10dd
	ldi (hl),a		; $10e0
	ld a,($d00b)		; $10e1
	ldi (hl),a		; $10e4
	ld a,($d00d)		; $10e5
	ldi (hl),a		; $10e8
	ld a,($cc40)		; $10e9
	ldi (hl),a		; $10ec
	ld a,($cc41)		; $10ed
	ldi (hl),a		; $10f0
	ld a,($cc42)		; $10f1
	ldi (hl),a		; $10f4
	ld a,($cc48)		; $10f5
_label_00_164:
	ldi (hl),a		; $10f8
	inc l			; $10f9
	ld a,($cc43)		; $10fa
	ldi (hl),a		; $10fd
	ld a,($cc44)		; $10fe
	ldi (hl),a		; $1101
	ret			; $1102

func_1135:
	xor a			; $1103
	ld ($c632),a		; $1104
	ret			; $1107

updateLinkLocalRespawnPosition:
	ld a,($cc48)		; $1108
	ld h,a			; $110b
	ld l,$08		; $110c
	ld a,(hl)		; $110e
	ld ($cc3f),a		; $110f
	ld l,$0b		; $1112
	ld a,(hl)		; $1114
	ld ($cc3d),a		; $1115
	ld l,$0d		; $1118
	ld a,(hl)		; $111a
	ld ($cc3e),a		; $111b
	ret			; $111e

updateRoomFlagsForBrokenTile:
	push af			; $111f
	ld hl,_unknownTileCollisionTable		; $1120
	call lookupCollisionTable		; $1123
	call c,addToGashaMaturity		; $1126
	pop af			; $1129
	ld hl,_tileUpdateRoomFlagsOnBreakTable		; $112a
	call lookupCollisionTable		; $112d
	ret nc			; $1130
	bit 7,a			; $1131
	jp nz,setRoomFlagsForUnlockedKeyDoor		; $1133
	bit 6,a			; $1136
	jp nz,setRoomFlagsForUnlockedKeyDoor_overworldOnly		; $1138
	and $0f			; $113b
	ld bc,bitTable		; $113d
	add c			; $1140
	ld c,a			; $1141
	ld a,($cc49)		; $1142
	ld hl,flagLocationGroupTable		; $1145
	rst_addAToHl			; $1148
	ld h,(hl)		; $1149
	ld a,($cc4c)		; $114a
	ld l,a			; $114d
	ld a,(bc)		; $114e
	or (hl)			; $114f
	ld (hl),a		; $1150
	ret			; $1151

_tileUpdateRoomFlagsOnBreakTable:
	ld e,(hl)		; $1152
	ld de,$1166		; $1153
	ld l,h			; $1156
	ld de,$116d		; $1157
	halt			; $115a
	ld de,$1186		; $115b
	add $07			; $115e
	pop bc			; $1160
	rlca			; $1161
	jp nz,$e307		; $1162
	rlca			; $1165
	ld ($ff00+c),a		; $1166
	rlca			; $1167
	rlc a			; $1168
	push bc			; $116a
	rlca			; $116b
	nop			; $116c
	jr nc,_label_00_165	; $116d
_label_00_165:
	ld sp,$3244		; $116f
	ld (bc),a		; $1172
	inc sp			; $1173
	ld c,h			; $1174
	nop			; $1175
	jr nc,_label_00_164	; $1176
	ld sp,$3284		; $1178
	adc b			; $117b
	inc sp			; $117c
	adc h			; $117d
	jr c,-$80		; $117e
	add hl,sp		; $1180
	add h			; $1181
	ldd a,(hl)		; $1182
	adc b			; $1183
	dec sp			; $1184
	adc h			; $1185
	nop			; $1186

_unknownTileCollisionTable:
	sub e			; $1187
	ld de,$1199		; $1188
	sbc a			; $118b
	ld de,$11a0		; $118c
	xor c			; $118f
	ld de,$11b9		; $1190

	add $32			; $1193
	jp nz,$e332		; $1195
	ldd (hl),a		; $1198

	ld ($ff00+c),a		; $1199
	ldd (hl),a		; $119a
	rr (hl)			; $119b
	push bc			; $119d
	ld e,$00		; $119e
	jr nc,_label_00_167	; $11a0
	ld sp,$3264		; $11a2
	ld h,h			; $11a5
	inc sp			; $11a6
	ld h,h			; $11a7
	nop			; $11a8
	jr nc,$32		; $11a9
	ld sp,$3232		; $11ab
	ldd (hl),a		; $11ae
	inc sp			; $11af
	ldd (hl),a		; $11b0
	jr c,_label_00_168	; $11b1
	add hl,sp		; $11b3
	ld h,h			; $11b4
	ldd a,(hl)		; $11b5
	ld h,h			; $11b6
	dec sp			; $11b7
	ld h,h			; $11b8
	nop			; $11b9

setRoomFlagsForUnlockedKeyDoor:
	and $0f			; $11ba
	ld de,_adjacentRoomsData		; $11bc
	call addAToDe		; $11bf
	ld a,($cc55)		; $11c2
	cp $ff			; $11c5
	jr z,_label_00_166	; $11c7
	call getActiveRoomFromDungeonMapPosition		; $11c9
	call $11da		; $11cc
	inc de			; $11cf
	ld a,($cc56)		; $11d0
	ld l,a			; $11d3
	ld a,(de)		; $11d4
	add l			; $11d5
	call getRoomInDungeon		; $11d6
	inc de			; $11d9
	ld c,a			; $11da
	ld a,($cc59)		; $11db
	ld b,a			; $11de
	ld a,(de)		; $11df
	ld l,a			; $11e0
	ld a,(bc)		; $11e1
	or l			; $11e2
	ld (bc),a		; $11e3
	ret			; $11e4
_label_00_166:
	call getThisRoomFlags		; $11e5
	ld a,(de)		; $11e8
	or (hl)			; $11e9
	ld (hl),a		; $11ea
	ret			; $11eb

_adjacentRoomsData:
	ld bc,$04f8		; $11ec
	nop			; $11ef
	ld (bc),a		; $11f0
	ld bc,$0008		; $11f1
	inc b			; $11f4
	ld ($0001),sp		; $11f5
	ld ($02ff),sp		; $11f8
	nop			; $11fb

setRoomFlagsForUnlockedKeyDoor_overworldOnly:
	and $0f			; $11fc
	ld hl,_adjacentRoomsData		; $11fe
	rst_addAToHl			; $1201
	ld a,($cc4c)		; $1202
	ld c,a			; $1205
_label_00_167:
	ld b,$c8		; $1206
	ld a,(bc)		; $1208
	or (hl)			; $1209
	ld (bc),a		; $120a
	inc hl			; $120b
	ldi a,(hl)		; $120c
	add c			; $120d
	ld c,a			; $120e
	ld a,(bc)		; $120f
	or (hl)			; $1210
	ld (bc),a		; $1211
	ret			; $1212

checkAndUpdateLinkOnChest:
	ld a,($ccb9)		; $1213
	or a			; $1216
_label_00_168:
	jr nz,_label_00_169	; $1217
	ld a,($ccb4)		; $1219
	cp $f1			; $121c
	ret nz			; $121e
	ld a,($ccb3)		; $121f
	ld ($ccb9),a		; $1222
	ld l,a			; $1225
	ld h,$ce		; $1226
	ld (hl),$00		; $1228
	ret			; $122a
_label_00_169:
	ld c,a			; $122b
	ld a,($ccb3)		; $122c
	cp c			; $122f
	ret z			; $1230
	ld b,$cf		; $1231
	ld a,(bc)		; $1233
	call retrieveTileCollisionValue		; $1234
	dec b			; $1237
	ld (bc),a		; $1238
	xor a			; $1239
	ld ($ccb9),a		; $123a
	ret			; $123d

interactWithTileBeforeLink:
	ldh a,(<hRomBank)	; $123e
	push af			; $1240
	ld a,$06		; $1241
	ldh (<hRomBank),a	; $1243
	ld ($2222),a		; $1245
	call $4000		; $1248
	rl c			; $124b
	pop af			; $124d
	ldh (<hRomBank),a	; $124e
	ld ($2222),a		; $1250
	srl c			; $1253
	ret			; $1255

func_1298:
	ldh a,(<hRomBank)	; $1256
	push af			; $1258
	ld a,$06		; $1259
	ldh (<hRomBank),a	; $125b
	ld ($2222),a		; $125d
	ld a,$09		; $1260
	call $42e6		; $1262
	pop af			; $1265
	ldh (<hRomBank),a	; $1266
	ld ($2222),a		; $1268
	ret			; $126b

updateCamera:
	ld a,($cd00)		; $126c
	and $05			; $126f
	ret z			; $1271
	ldh a,(<hRomBank)	; $1272
	push af			; $1274
	ld a,$01		; $1275
	ldh (<hRomBank),a	; $1277
	ld ($2222),a		; $1279
	call $41bf		; $127c
	call $4289		; $127f
	call $423b		; $1282
	pop af			; $1285
	ldh (<hRomBank),a	; $1286
	ld ($2222),a		; $1288
	ret			; $128b

resetCamera:
	ldh a,(<hRomBank)	; $128c
	push af			; $128e
	ld a,$01		; $128f
	ldh (<hRomBank),a	; $1291
	ld ($2222),a		; $1293
	call $4214		; $1296
	call $4289		; $1299
	pop af			; $129c
	ldh (<hRomBank),a	; $129d
	ld ($2222),a		; $129f
	ret			; $12a2

setCameraFocusedObject:
	ldh a,(<hActiveObject)	; $12a3
	ld ($cd17),a		; $12a5
	ldh a,(<hActiveObjectType)	; $12a8
	ld ($cd16),a		; $12aa
	ret			; $12ad

setCameraFocusedObjectToLink:
	ld a,($cc48)		; $12ae
	ld ($cd17),a		; $12b1
	ld a,$00		; $12b4
	ld ($cd16),a		; $12b6
	ret			; $12b9

reloadTileMap:
	ldh a,(<hRomBank)	; $12ba
	push af			; $12bc
	xor a			; $12bd
	ld ($cd08),a		; $12be
	ld ($cd09),a		; $12c1
	ld a,$10		; $12c4
	call loadUncompressedGfxHeader		; $12c6
	ld a,$01		; $12c9
	ldh (<hRomBank),a	; $12cb
	ld ($2222),a		; $12cd
	call $40f5		; $12d0
	call $4289		; $12d3
	pop af			; $12d6
	ldh (<hRomBank),a	; $12d7
	ld ($2222),a		; $12d9
	ret			; $12dc

func_131f:
	xor a			; $12dd
	ld ($cd08),a		; $12de
	ld ($cd09),a		; $12e1
	ldh a,(<hRomBank)	; $12e4
	push af			; $12e6
	ld a,$01		; $12e7
	ldh (<hRomBank),a	; $12e9
	ld ($2222),a		; $12eb
	call $4027		; $12ee
	call $40f5		; $12f1
	call loadTilesetAndRoomLayout		; $12f4
	call loadRoomCollisions		; $12f7
	call generateVramTilesWithRoomChanges		; $12fa
	ld a,$10		; $12fd
	call loadUncompressedGfxHeader		; $12ff
	ld a,($cd22)		; $1302
	ld ($cd29),a		; $1305
	ld a,($cd20)		; $1308
	ld ($cd28),a		; $130b
	pop af			; $130e
	ldh (<hRomBank),a	; $130f
	ld ($2222),a		; $1311
	ret			; $1314

loadAreaAnimation:
	ld a,($cd2b)		; $1315
	ld b,a			; $1318
	ld a,($cd25)		; $1319
	cp b			; $131c
	ret z			; $131d
	ld ($cd2b),a		; $131e
	jp loadAnimationData		; $1321

func_1383:
	push de			; $1324
	ld ($cc4c),a		; $1325
	ld a,b			; $1328
	ld ($cd02),a		; $1329
	ld a,($ff00+$70)	; $132c
	ld c,a			; $132e
	ldh a,(<hRomBank)	; $132f
	ld b,a			; $1331
	push bc			; $1332
	ld a,$08		; $1333
	ld ($cd00),a		; $1335
	ld a,$03		; $1338
	ld ($cd04),a		; $133a
	xor a			; $133d
	ld ($cd05),a		; $133e
	ld ($cd06),a		; $1341
	ld a,$01		; $1344
	ldh (<hRomBank),a	; $1346
	ld ($2222),a		; $1348
	call $4956		; $134b
	call $4964		; $134e
	call loadScreenMusic		; $1351
	call loadAreaData		; $1354
	ld a,($cc4c)		; $1357
	ld ($cc4b),a		; $135a
	call loadTilesetAndRoomLayout		; $135d
	call loadRoomCollisions		; $1360
	call generateVramTilesWithRoomChanges		; $1363
	pop bc			; $1366
	ld a,b			; $1367
	ldh (<hRomBank),a	; $1368
	ld ($2222),a		; $136a
	ld a,c			; $136d
	ld ($ff00+$70),a	; $136e
	pop de			; $1370
	ret			; $1371

initWaveScrollValues:
	ldh (<hFF93),a	; $1372
	ld a,($ff00+$70)	; $1374
	ld c,a			; $1376
	ldh a,(<hRomBank)	; $1377
	ld b,a			; $1379
	push bc			; $137a
	ld a,$01		; $137b
	ldh (<hRomBank),a	; $137d
	ld ($2222),a		; $137f
	ldh a,(<hFF93)	; $1382
	ld c,a			; $1384
	call $474f		; $1385
	pop bc			; $1388
	ld a,b			; $1389
	ldh (<hRomBank),a	; $138a
	ld ($2222),a		; $138c
	ld a,c			; $138f
	ld ($ff00+$70),a	; $1390
	ret			; $1392

loadBigBufferScrollValues:
	ldh (<hFF93),a	; $1393
	ld a,($ff00+$70)	; $1395
	ld c,a			; $1397
	ldh a,(<hRomBank)	; $1398
	ld b,a			; $139a
	push bc			; $139b
	ld a,$01		; $139c
	ldh (<hRomBank),a	; $139e
	ld ($2222),a		; $13a0
	ldh a,(<hFF93)	; $13a3
	ld b,a			; $13a5
	call $47ab		; $13a6
	pop bc			; $13a9
	ld a,b			; $13aa
	ldh (<hRomBank),a	; $13ab
	ld ($2222),a		; $13ad
	ld a,c			; $13b0
	ld ($ff00+$70),a	; $13b1
	ret			; $13b3

func_13c6:
	ldh a,(<hRomBank)	; $13b4
	push af			; $13b6
	ld a,$02		; $13b7
	ld ($ff00+$70),a	; $13b9
	push de			; $13bb
	push bc			; $13bc
	ld de,$da00		; $13bd
	call extractColorComponents		; $13c0
	pop hl			; $13c3
	ld de,$db00		; $13c4
	call extractColorComponents		; $13c7
	pop de			; $13ca
	pop af			; $13cb
	ldh (<hRomBank),a	; $13cc
	ld ($2222),a		; $13ce
	xor a			; $13d1
	ld ($ff00+$70),a	; $13d2
	jp startFadeBetweenTwoPalettes		; $13d4

extractColorComponents:
	ldh a,(<hRomBank)	; $13d7
	push af			; $13d9
	ld a,$16		; $13da
	ldh (<hRomBank),a	; $13dc
	ld ($2222),a		; $13de
	ld b,$30		; $13e1
_label_00_170:
	ld c,(hl)		; $13e3
	inc hl			; $13e4
	ld a,(hl)		; $13e5
	sla c			; $13e6
	rla			; $13e8
	rl c			; $13e9
	rla			; $13eb
	rl c			; $13ec
	rla			; $13ee
	and $1f			; $13ef
	ld (de),a		; $13f1
	inc e			; $13f2
	ldd a,(hl)		; $13f3
	rra			; $13f4
	rra			; $13f5
	and $1f			; $13f6
	ld (de),a		; $13f8
	inc e			; $13f9
	ldi a,(hl)		; $13fa
	and $1f			; $13fb
	ld (de),a		; $13fd
	inc e			; $13fe
	inc hl			; $13ff
	dec b			; $1400
	jr nz,_label_00_170	; $1401
	pop af			; $1403
	ldh (<hRomBank),a	; $1404
	ld ($2222),a		; $1406
	ret			; $1409

setTileWithoutGfxReload:
	ld b,$cf		; $140a
	ld (bc),a		; $140c
	call retrieveTileCollisionValue		; $140d
	ld b,$ce		; $1410
	ld (bc),a		; $1412
	ret			; $1413

setTileInRoomLayoutBuffer:
	ld a,($ff00+$70)	; $1414
	push af			; $1416
	ld a,$03		; $1417
	ld ($ff00+$70),a	; $1419
	ld a,b			; $141b
	ld b,$df		; $141c
	ld (bc),a		; $141e
	pop af			; $141f
	ld ($ff00+$70),a	; $1420
	ret			; $1422

objectGetRelativeTile:
	ldh a,(<hActiveObjectType)	; $1423
	or $0b			; $1425
	ld l,a			; $1427
	ld h,d			; $1428
	ldi a,(hl)		; $1429
	add b			; $142a
	ld b,a			; $142b
	inc l			; $142c
	ldi a,(hl)		; $142d
	add c			; $142e
	ld c,a			; $142f
	jr _label_00_171		; $1430

objectGetTileAtPosition:
	call objectGetPosition		; $1432
_label_00_171:

getTileAtPosition:
	ld a,c			; $1435
	and $f0			; $1436
	swap a			; $1438
	ld l,a			; $143a
	ld a,b			; $143b
	and $f0			; $143c
	or l			; $143e
	ld l,a			; $143f
	ld h,$cf		; $1440
	ld a,(hl)		; $1442
	ret			; $1443

objectGetRelativePositionOfTile:
	ldh (<hFF8B),a	; $1444
	call objectGetShortPosition		; $1446
	ld e,a			; $1449
	ld h,$cf		; $144a
	ld a,$f0		; $144c
	call $146f		; $144e
	ld a,$00		; $1451
	ret z			; $1453
	ld a,$01		; $1454
	call $146f		; $1456
	ld a,$01		; $1459
	ret z			; $145b
	ld a,$10		; $145c
	call $146f		; $145e
	ld a,$02		; $1461
	ret z			; $1463
	ld a,$ff		; $1464
	call $146f		; $1466
	ld a,$03		; $1469
	ret z			; $146b
	ld a,$ff		; $146c
	ret			; $146e
	add e			; $146f
	ld l,a			; $1470
	ldh a,(<hFF8B)	; $1471
	cp (hl)			; $1473
	ret			; $1474

objectCheckSimpleCollision:
	ldh a,(<hActiveObjectType)	; $1475
	or $0b			; $1477
	ld l,a			; $1479
	ld h,d			; $147a
	ld b,(hl)		; $147b
	inc l			; $147c
	inc l			; $147d
	ld c,(hl)		; $147e
	ld a,b			; $147f
	and $f0			; $1480
	ld l,a			; $1482
	ld a,c			; $1483
	swap a			; $1484
	and $0f			; $1486
	or l			; $1488
	ld l,a			; $1489
	ld h,$ce		; $148a
	ld a,(hl)		; $148c
	bit 3,b			; $148d
	jr nz,_label_00_172	; $148f
	rrca			; $1491
	rrca			; $1492
_label_00_172:
	bit 3,c			; $1493
	jr nz,_label_00_173	; $1495
	rrca			; $1497
_label_00_173:
	and $01			; $1498
	ret			; $149a

objectGetTileCollisions:
	ldh a,(<hActiveObjectType)	; $149b
	or $0b			; $149d
	ld l,a			; $149f
	ld h,d			; $14a0
	ld b,(hl)		; $14a1
	inc l			; $14a2
	inc l			; $14a3
	ld c,(hl)		; $14a4

getTileCollisionsAtPosition:
	ld a,b			; $14a5
	and $f0			; $14a6
	ld l,a			; $14a8
	ld a,c			; $14a9
	swap a			; $14aa
	and $0f			; $14ac
	or l			; $14ae
	ld l,a			; $14af
	ld h,$ce		; $14b0
	ld a,(hl)		; $14b2
	or a			; $14b3
	ret			; $14b4

objectCheckTileCollision_allowHoles:
	ldh a,(<hActiveObjectType)	; $14b5
	or $0b			; $14b7
	ld l,a			; $14b9
	ld h,d			; $14ba
	ld b,(hl)		; $14bb
	inc l			; $14bc
	inc l			; $14bd
	ld c,(hl)		; $14be

checkTileCollisionAt_allowHoles:
	ld a,b			; $14bf
	and $f0			; $14c0
	ld l,a			; $14c2
	ld a,c			; $14c3
	swap a			; $14c4
	and $0f			; $14c6
	or l			; $14c8
	ld l,a			; $14c9

checkTileCollision_allowHoles:
	ld h,$ce		; $14ca
	ld a,(hl)		; $14cc

checkGivenCollision_allowHoles:
	cp $10			; $14cd
	jr c,_label_00_174	; $14cf
	ld hl,$14d6		; $14d1
	jr _label_00_177		; $14d4
	nop			; $14d6
	jp $c003		; $14d7
	nop			; $14da
	jp $00c3		; $14db
	nop			; $14de
	jp $c003		; $14df
	ret nz			; $14e2
	pop bc			; $14e3
	rst $38			; $14e4
	nop			; $14e5

objectCheckTileCollision_disallowHoles:
	ldh a,(<hActiveObjectType)	; $14e6
	or $0b			; $14e8
	ld l,a			; $14ea
	ld h,d			; $14eb
	ld b,(hl)		; $14ec
	inc l			; $14ed
	inc l			; $14ee
	ld c,(hl)		; $14ef

checkTileCollisionAt_disallowHoles:
	ld a,b			; $14f0
	and $f0			; $14f1
	ld l,a			; $14f3
	ld a,c			; $14f4
	swap a			; $14f5
	and $0f			; $14f7
	or l			; $14f9
	ld l,a			; $14fa

checkTileCollision_disallowHoles:
	ld h,$ce		; $14fb
	ld a,(hl)		; $14fd

checkGivenCollision_disallowHoles:
	cp $10			; $14fe
	jr c,_label_00_174	; $1500
	ld hl,$1507		; $1502
	jr _label_00_177		; $1505
	rst $38			; $1507
	jp $c003		; $1508
	nop			; $150b
	jp $00c3		; $150c
	nop			; $150f
	jp $c003		; $1510
	pop bc			; $1513
	pop bc			; $1514
	rst $38			; $1515
	rst $38			; $1516

checkCollisionPosition_disallowSmallBridges:
	ld h,$ce		; $1517
	ld a,(hl)		; $1519
	cp $10			; $151a
	jr c,_label_00_174	; $151c
	ld hl,$1523		; $151e
	jr _label_00_177		; $1521
	nop			; $1523
	rst $38			; $1524
	inc bc			; $1525
	ret nz			; $1526
	jp $c3c3		; $1527
	nop			; $152a
	nop			; $152b
	rst $38			; $152c
	inc bc			; $152d
	ret nz			; $152e
	pop bc			; $152f
	pop bc			; $1530
	rst $38			; $1531
	nop			; $1532
_label_00_174:

_simpleCollision:
	bit 3,b			; $1533
	jr nz,_label_00_175	; $1535
	rrca			; $1537
	rrca			; $1538
_label_00_175:
	bit 3,c			; $1539
	jr nz,_label_00_176	; $153b
	rrca			; $153d
_label_00_176:
	rrca			; $153e
	ret			; $153f
_label_00_177:

_complexCollision:
	push de			; $1540
	and $0f			; $1541
	ld e,a			; $1543
	ld d,$00		; $1544
	add hl,de		; $1546
	ld e,(hl)		; $1547
	cp $08			; $1548
	ld a,b			; $154a
	jr nc,_label_00_178	; $154b
	ld a,c			; $154d
_label_00_178:
	rrca			; $154e
	and $07			; $154f
	ld hl,bitTable		; $1551
	add l			; $1554
	ld l,a			; $1555
	ld a,(hl)		; $1556
	and e			; $1557
	pop de			; $1558
	ret z			; $1559
	scf			; $155a
	ret			; $155b

retrieveTileCollisionValue:
	ld h,$db		; $155c
	ld l,a			; $155e
	ld a,$03		; $155f
	ld ($ff00+$70),a	; $1561
	ld l,(hl)		; $1563
	xor a			; $1564
	ld ($ff00+$70),a	; $1565
	ld a,l			; $1567
	ret			; $1568

loadRoomCollisions:
	ld a,$03		; $1569
	ld ($ff00+$70),a	; $156b
	ld d,$db		; $156d
	ld hl,$cf00		; $156f
	ld b,$b0		; $1572
_label_00_179:
	ld a,(hl)		; $1574
	ld e,a			; $1575
	ld a,(de)		; $1576
	dec h			; $1577
	ldi (hl),a		; $1578
	inc h			; $1579
	dec b			; $157a
	jr nz,_label_00_179	; $157b
	call $1584		; $157d
	xor a			; $1580
	ld ($ff00+$70),a	; $1581
	ret			; $1583
	ld hl,$cef0		; $1584
	call $15a4		; $1587
	ld hl,$ce0f		; $158a
	call $15ad		; $158d
	ld a,($cc49)		; $1590
	cp $04			; $1593
	jr c,_label_00_180	; $1595
	ld l,$b0		; $1597
	jr _label_00_181		; $1599
_label_00_180:
	ld l,$80		; $159b
	call $15a4		; $159d
	ld l,$0a		; $15a0
	jr _label_00_183		; $15a2
_label_00_181:
	ld a,$ff		; $15a4
	ld b,$10		; $15a6
_label_00_182:
	ldi (hl),a		; $15a8
	dec b			; $15a9
	jr nz,_label_00_182	; $15aa
	ret			; $15ac
_label_00_183:
	ld b,$0b		; $15ad
	ld c,$ff		; $15af
_label_00_184:
	ld (hl),c		; $15b1
	ld a,l			; $15b2
	add $10			; $15b3
	ld l,a			; $15b5
	dec b			; $15b6
	jr nz,_label_00_184	; $15b7
	ret			; $15b9

findTileInRoom:
	ld h,$cf		; $15ba
	ld l,$bf		; $15bc
_label_00_185:

backwardsSearch:
	cp (hl)			; $15be
	ret z			; $15bf
	dec l			; $15c0
	jr nz,_label_00_185	; $15c1
	cp (hl)			; $15c3
	ret			; $15c4

getTileIndexFromRoomLayoutBuffer:
	ld c,a			; $15c5

getTileIndexFromRoomLayoutBuffer_paramC:
	ld a,($ff00+$70)	; $15c6
	push af			; $15c8
	ld a,$03		; $15c9
	ld ($ff00+$70),a	; $15cb
	ld b,$df		; $15cd
	ld a,(bc)		; $15cf
	ld e,a			; $15d0
	ld a,$03		; $15d1
	ld ($ff00+$70),a	; $15d3
	ld l,e			; $15d5
	ld h,$db		; $15d6
	ld b,(hl)		; $15d8
	pop af			; $15d9
	ld ($ff00+$70),a	; $15da
	ld a,b			; $15dc
	cp $10			; $15dd
	jr nc,_label_00_186	; $15df
	or a			; $15e1
	jr z,_label_00_186	; $15e2
	scf			; $15e4
	ld a,e			; $15e5
	ret			; $15e6
_label_00_186:
	ld a,e			; $15e7
	ret			; $15e8

interactionInitGraphics:
	ldh a,(<hRomBank)	; $15e9
	push af			; $15eb
	ld a,$3f		; $15ec
	ldh (<hRomBank),a	; $15ee
	ld ($2222),a		; $15f0
	call $4404		; $15f3
	ld c,a			; $15f6
	pop af			; $15f7
	ldh (<hRomBank),a	; $15f8
	ld ($2222),a		; $15fa
	ld a,c			; $15fd
	jp interactionSetAnimation		; $15fe

func_1613:
	ld a,($cc17)		; $1601
	or a			; $1604
	ret z			; $1605

refreshObjectGfx:
	ldh a,(<hRomBank)	; $1606
	push af			; $1608
	ld a,$3f		; $1609
	ldh (<hRomBank),a	; $160b
	ld ($2222),a		; $160d
	call $4154		; $1610
	xor a			; $1613
	ld ($cc17),a		; $1614
	pop af			; $1617
	ldh (<hRomBank),a	; $1618
	ld ($2222),a		; $161a
	ret			; $161d

reloadObjectGfx:
	ldh a,(<hRomBank)	; $161e
	push af			; $1620
	ld a,$3f		; $1621
	ldh (<hRomBank),a	; $1623
	ld ($2222),a		; $1625
	call $4125		; $1628
	pop af			; $162b
	ldh (<hRomBank),a	; $162c
	ld ($2222),a		; $162e
	ret			; $1631

loadObjectGfxHeaderToSlot4:
	ldh a,(<hRomBank)	; $1632
	push af			; $1634
	ld a,$3f		; $1635
	ldh (<hRomBank),a	; $1637
	ld ($2222),a		; $1639
	call $41ec		; $163c
	pop af			; $163f
	ldh (<hRomBank),a	; $1640
	ld ($2222),a		; $1642
	ret			; $1645

loadTreeGfx:
	ld e,a			; $1646
	ldh a,(<hRomBank)	; $1647
	push af			; $1649
	ld a,$3f		; $164a
	ldh (<hRomBank),a	; $164c
	ld ($2222),a		; $164e
	call $41f5		; $1651
	pop af			; $1654
	ldh (<hRomBank),a	; $1655
	ld ($2222),a		; $1657
	ret			; $165a

loadWeaponGfx:
	ld e,a			; $165b
	ldh a,(<hRomBank)	; $165c
	push af			; $165e
	ld a,$3f		; $165f
	ldh (<hRomBank),a	; $1661
	ld ($2222),a		; $1663
	call $445b		; $1666
	pop af			; $1669
	ldh (<hRomBank),a	; $166a
	ld ($2222),a		; $166c
	ret			; $166f

loadNpcGfx:
	ld d,b			; $1670
	ld e,$00		; $1671
	ldi a,(hl)		; $1673

loadNpcGfx2:
	ld c,a			; $1674
	ldi a,(hl)		; $1675
	ld l,(hl)		; $1676
	and $7f			; $1677
	ld h,a			; $1679
	push de			; $167a
	ld a,($cc06)		; $167b
	xor $ff			; $167e
	ld ($cc06),a		; $1680
	ld de,$dc04		; $1683
	jr nz,_label_00_187	; $1686
	ld de,$de04		; $1688
_label_00_187:
	push de			; $168b
	ld b,$1f		; $168c
	call decompressGraphics		; $168e
	pop hl			; $1691
	pop de			; $1692
	ld c,$04		; $1693
	ld a,$01		; $1695
	ld ($ff00+$70),a	; $1697
	ld a,$3f		; $1699
	ldh (<hRomBank),a	; $169b
	ld ($2222),a		; $169d
	ld b,$1f		; $16a0
	jp queueDmaTransfer		; $16a2

loadTreasureDisplayData:
	ld l,a			; $16a5
	ldh a,(<hRomBank)	; $16a6
	push af			; $16a8
	ld a,$3f		; $16a9
	ldh (<hRomBank),a	; $16ab
	ld ($2222),a		; $16ad
	call $46fe		; $16b0
	pop af			; $16b3
	ldh (<hRomBank),a	; $16b4
	ld ($2222),a		; $16b6
	ret			; $16b9

func_16eb:
	ld c,a			; $16ba
	ldh a,(<hRomBank)	; $16bb
	push af			; $16bd
	ld a,$3f		; $16be
	ldh (<hRomBank),a	; $16c0
	ld ($2222),a		; $16c2
	call $4757		; $16c5
	pop af			; $16c8
	ldh (<hRomBank),a	; $16c9
	ld ($2222),a		; $16cb
	ld a,c			; $16ce
	cp $ff			; $16cf
	ret			; $16d1

func_1703:
	ld c,a			; $16d2
	ldh a,(<hRomBank)	; $16d3
	push af			; $16d5
	ld a,$3f		; $16d6
	ldh (<hRomBank),a	; $16d8
	ld ($2222),a		; $16da
	ld a,c			; $16dd
	call $4795		; $16de
	pop af			; $16e1
	ldh (<hRomBank),a	; $16e2
	ld ($2222),a		; $16e4
	ld a,c			; $16e7
	cp $ff			; $16e8
	ret			; $16ea

giveTreasure:
	ld b,a			; $16eb
	ldh a,(<hRomBank)	; $16ec
	push af			; $16ee
	ld a,$3f		; $16ef
	ldh (<hRomBank),a	; $16f1
	ld ($2222),a		; $16f3
	call $44c8		; $16f6
	pop af			; $16f9
	ldh (<hRomBank),a	; $16fa
	ld ($2222),a		; $16fc
	ld a,b			; $16ff
	or a			; $1700
	ret			; $1701

loseTreasure:
	ld b,a			; $1702
	ldh a,(<hRomBank)	; $1703
	push af			; $1705
	ld a,$3f		; $1706
	ldh (<hRomBank),a	; $1708
	ld ($2222),a		; $170a
	call $44a1		; $170d
	pop af			; $1710
	ldh (<hRomBank),a	; $1711
	ld ($2222),a		; $1713
	ret			; $1716

checkTreasureObtained:
	push hl			; $1717
	ld l,a			; $1718
	or a			; $1719
	jr z,_label_00_188	; $171a
	ldh a,(<hRomBank)	; $171c
	push af			; $171e
	ld a,$3f		; $171f
	ldh (<hRomBank),a	; $1721
	ld ($2222),a		; $1723
	call $446d		; $1726
	pop af			; $1729
	ldh (<hRomBank),a	; $172a
	ld ($2222),a		; $172c
	ld a,l			; $172f
	srl h			; $1730
_label_00_188:
	pop hl			; $1732
	ret			; $1733

cpOreChunkValue:
	ld hl,$c6a7		; $1734
	jr _label_00_189		; $1737

cpRupeeValue:
	ld hl,$c6a5		; $1739
_label_00_189:
	call getRupeeValue		; $173c
	ldi a,(hl)		; $173f
	ld h,(hl)		; $1740
	ld l,a			; $1741
	call compareHlToBc		; $1742
	inc a			; $1745
	jr nz,_label_00_190	; $1746
	inc a			; $1748
	ret			; $1749
_label_00_190:
	xor a			; $174a
	ret			; $174b

removeOreChunkValue:
	ld hl,$c6a7		; $174c
	jr _label_00_191		; $174f

removeRupeeValue:
	ld hl,$c6a5		; $1751
_label_00_191:
	call getRupeeValue		; $1754
	jp subDecimalFromHlRef		; $1757

getRupeeValue:
	push hl			; $175a
	cp $14			; $175b
	jr c,_label_00_192	; $175d
	ld a,$14		; $175f
_label_00_192:
	ld hl,$176a		; $1761
	rst_addDoubleIndex			; $1764
	ldi a,(hl)		; $1765
	ld b,(hl)		; $1766
	ld c,a			; $1767
	pop hl			; $1768
	ret			; $1769
	nop			; $176a
	nop			; $176b
	ld bc,$0200		; $176c
	nop			; $176f
	dec b			; $1770
	nop			; $1771
	stop			; $1772
	nop			; $1773
	jr nz,_label_00_193	; $1774
_label_00_193:
	ld b,b			; $1776
	nop			; $1777
	jr nc,_label_00_194	; $1778
_label_00_194:
	ld h,b			; $177a
	nop			; $177b
	ld (hl),b		; $177c
	nop			; $177d
	dec h			; $177e
	nop			; $177f
	ld d,b			; $1780
	nop			; $1781
	nop			; $1782
	ld bc,$0200		; $1783
	nop			; $1786
	inc b			; $1787
	ld d,b			; $1788
	ld bc,$0300		; $1789
	nop			; $178c
	dec b			; $178d
	nop			; $178e
	add hl,bc		; $178f
	add b			; $1790
	nop			; $1791
	sbc c			; $1792
	add hl,bc		; $1793

decNumActiveSeeds:
	and $07			; $1794
	ld hl,$c6b5		; $1796
	rst_addAToHl			; $1799
	jr _label_00_195		; $179a

decNumBombchus:
	ld hl,$c6ad		; $179c
	jr _label_00_195		; $179f

decNumBombs:
	ld hl,$c6aa		; $17a1
_label_00_195:
	ld a,(hl)		; $17a4
	or a			; $17a5
	ret z			; $17a6
	call setStatusBarNeedsRefreshBit1		; $17a7
	ld a,(hl)		; $17aa
	sub $01			; $17ab
	daa			; $17ad
	ld (hl),a		; $17ae
	or h			; $17af
	ret			; $17b0

setStatusBarNeedsRefreshBit1:
	push hl			; $17b1
	ld hl,$cbea		; $17b2
	set 1,(hl)		; $17b5
	pop hl			; $17b7
	ret			; $17b8

getRandomRingOfGivenTier:
	ldh a,(<hRomBank)	; $17b9
	push af			; $17bb
	ld a,$3f		; $17bc
	ldh (<hRomBank),a	; $17be
	ld ($2222),a		; $17c0
	ld b,$01		; $17c3
	ld a,c			; $17c5
	cp $04			; $17c6
	jr z,_label_00_196	; $17c8
	ld b,$07		; $17ca
_label_00_196:
	ld hl,$47b1		; $17cc
	rst_addDoubleIndex			; $17cf
	ldi a,(hl)		; $17d0
	ld h,(hl)		; $17d1
	ld l,a			; $17d2
	call getRandomNumber		; $17d3
	and b			; $17d6
	ld c,a			; $17d7
	ld b,$00		; $17d8
	add hl,bc		; $17da
	ld c,(hl)		; $17db
	pop af			; $17dc
	ldh (<hRomBank),a	; $17dd
	ld ($2222),a		; $17df
	ld a,$2d		; $17e2
	ret			; $17e4

refillSeedSatchel:
	ld e,$20		; $17e5
_label_00_197:
	ld a,e			; $17e7
	call checkTreasureObtained		; $17e8
	jr nc,_label_00_198	; $17eb
	ld a,e			; $17ed
	ld c,$99		; $17ee
	call giveTreasure		; $17f0
_label_00_198:
	inc e			; $17f3
	ld a,e			; $17f4
	cp $25			; $17f5
	jr c,_label_00_197	; $17f7
	ret			; $17f9

addToGashaMaturity:
	push hl			; $17fa
	ld hl,$c65c		; $17fb
	add (hl)		; $17fe
	ldi (hl),a		; $17ff
	jr nc,_label_00_199	; $1800
	inc (hl)		; $1802
	jr nz,_label_00_199	; $1803
	ld a,$ff		; $1805
	ldd (hl),a		; $1807
	ld (hl),a		; $1808
_label_00_199:
	pop hl			; $1809
	ret			; $180a

makeActiveObjectFollowLink:
	ldh a,(<hRomBank)	; $180b
	push af			; $180d
	ld a,$01		; $180e
	ldh (<hRomBank),a	; $1810
	ld ($2222),a		; $1812
	call $489d		; $1815
	pop af			; $1818
	ldh (<hRomBank),a	; $1819
	ld ($2222),a		; $181b
	ret			; $181e

clearFollowingLinkObject:
	ld hl,$ccfd		; $181f
	xor a			; $1822
	ldi (hl),a		; $1823
	ld (hl),a		; $1824
	ret			; $1825

stopTextThread:
	xor a			; $1826
	ld ($cba0),a		; $1827
	ld ($cbae),a		; $182a
	ld a,$f0		; $182d
	jp threadStop		; $182f

retIfTextIsActive:
	ld a,($cba0)		; $1832
	or a			; $1835
	ret z			; $1836
	pop af			; $1837
	ret			; $1838

showTextOnInventoryMenu:
	ld a,($cbae)		; $1839
	set 0,a			; $183c
	ld ($cbae),a		; $183e
	ld l,$00		; $1841
	ld e,$02		; $1843
	jr _label_00_201		; $1845

showTextNonExitable:
	ld l,$02		; $1847
	jr _label_00_200		; $1849

showText:
	ld l,$00		; $184b
_label_00_200:
	ld e,$00		; $184d
_label_00_201:
	ld a,($cbae)		; $184f
	or l			; $1852
	ld ($cbae),a		; $1853
	ld a,b			; $1856
	add $04			; $1857
	ld b,a			; $1859
	ld hl,$cba1		; $185a
	ld (hl),e		; $185d
	inc l			; $185e
	ld (hl),c		; $185f
	inc l			; $1860
	ld a,b			; $1861
	ldi (hl),a		; $1862
	ldi (hl),a		; $1863
	ld (hl),$ff		; $1864
	inc l			; $1866
	ld (hl),$02		; $1867
	inc l			; $1869
	ld (hl),$98		; $186a
	ld a,$01		; $186c
	ld ($cba0),a		; $186e
	ld bc,textThreadStart		; $1871
	ld a,$f0		; $1874
	jp threadRestart		; $1876

textThreadStart:
	ld a,($cd00)		; $1879
	or a			; $187c
	jr z,_label_00_202	; $187d
	and $01			; $187f
	jr nz,_label_00_202	; $1881
	xor a			; $1883
	ld ($cba0),a		; $1884
	ld ($cbae),a		; $1887
	jp stubThreadStart		; $188a
_label_00_202:
	ld a,$3f		; $188d
	ldh (<hRomBank),a	; $188f
	ld ($2222),a		; $1891
	call $4b26		; $1894
_label_00_203:
	ld a,$3f		; $1897
	ldh (<hRomBank),a	; $1899
	ld ($2222),a		; $189b
	call $4b4e		; $189e
	call resumeThreadNextFrame		; $18a1
	jr _label_00_203		; $18a4

retrieveTextCharacter:
	push hl			; $18a6
	push de			; $18a7
	push bc			; $18a8
	call multiplyABy16		; $18a9
	ld a,($d0d2)		; $18ac
	ld hl,$18d0		; $18af
	rst_addDoubleIndex			; $18b2
	ldi a,(hl)		; $18b3
	ld h,(hl)		; $18b4
	ld l,a			; $18b5
	add hl,bc		; $18b6
	pop bc			; $18b7
	ld a,$1c		; $18b8
	ldh (<hRomBank),a	; $18ba
	ld ($2222),a		; $18bc
	call $18d6		; $18bf
	ld a,$3f		; $18c2
	ldh (<hRomBank),a	; $18c4
	ld ($2222),a		; $18c6
	xor a			; $18c9
	ld ($d0d2),a		; $18ca
	pop de			; $18cd
	pop hl			; $18ce
	ret			; $18cf
	jr nz,_label_00_209	; $18d0
	nop			; $18d2
	ld b,b			; $18d3
	nop			; $18d4
	ld b,(hl)		; $18d5
	ld e,$10		; $18d6
	ld a,h			; $18d8
	cp $48			; $18d9
	jr nz,_label_00_204	; $18db
	ld a,l			; $18dd
	cp $60			; $18de
	jr z,_label_00_207	; $18e0
_label_00_204:
	ld a,($cba6)		; $18e2
	and $0f			; $18e5
	or a			; $18e7
	jr z,_label_00_206	; $18e8
	dec a			; $18ea
	jr z,_label_00_207	; $18eb
	dec a			; $18ed
	jr z,_label_00_208	; $18ee
	ld e,$20		; $18f0
_label_00_205:
	ldi a,(hl)		; $18f2
	ld (bc),a		; $18f3
	inc bc			; $18f4
	dec e			; $18f5
	jr nz,_label_00_205	; $18f6
	ld a,($cba6)		; $18f8
	and $f0			; $18fb
	swap a			; $18fd
	ld ($cba6),a		; $18ff
	ret			; $1902
_label_00_206:
	ldi a,(hl)		; $1903
	ld (bc),a		; $1904
	inc c			; $1905
	ld (bc),a		; $1906
	inc bc			; $1907
	dec e			; $1908
	jr nz,_label_00_206	; $1909
	ret			; $190b
_label_00_207:
	ld a,$ff		; $190c
	ld (bc),a		; $190e
	inc c			; $190f
	ldi a,(hl)		; $1910
	ld (bc),a		; $1911
	inc bc			; $1912
	dec e			; $1913
	jr nz,_label_00_207	; $1914
	ret			; $1916
_label_00_208:
	ldi a,(hl)		; $1917
	ld (bc),a		; $1918
_label_00_209:
	inc c			; $1919
	ld a,$ff		; $191a
	ld (bc),a		; $191c
	inc bc			; $191d
	dec e			; $191e
	jr nz,_label_00_208	; $191f
	ret			; $1921

readByteFromW7ActiveBank:
	push bc			; $1922
	ld a,($d0d4)		; $1923
	ldh (<hRomBank),a	; $1926
	ld ($2222),a		; $1928
	ld b,(hl)		; $192b
	ld a,$3f		; $192c
	ldh (<hRomBank),a	; $192e
	ld ($2222),a		; $1930
	ld a,b			; $1933
	pop bc			; $1934
	ret			; $1935

readByteFromW7TextTableBank:
	ldh a,(<hRomBank)	; $1936
	push af			; $1938
	ld a,($d0f2)		; $1939
	bit 7,h			; $193c
	jr z,_label_00_210	; $193e
	res 7,h			; $1940
	set 6,h			; $1942
	inc a			; $1944
_label_00_210:
	ldh (<hRomBank),a	; $1945
	ld ($2222),a		; $1947
	ldi a,(hl)		; $194a
	ldh (<hFF8B),a	; $194b
	pop af			; $194d
	ldh (<hRomBank),a	; $194e
	ld ($2222),a		; $1950
	ldh a,(<hFF8B)	; $1953
	ret			; $1955

getThisRoomFlags:
	ld a,($cc4c)		; $1956
	push bc			; $1959
	ld b,a			; $195a
	ld a,($cc49)		; $195b
	call getRoomFlags		; $195e
	pop bc			; $1961
	ret			; $1962

getRoomFlags:
	ld hl,flagLocationGroupTable		; $1963
	rst_addAToHl			; $1966
	ld h,(hl)		; $1967
	ld l,b			; $1968
	ld a,(hl)		; $1969
	ret			; $196a

checkIsLinkedGame:
	ld a,($cc01)		; $196b
	or a			; $196e
	ret			; $196f

setWarpDestVariables:
	push de			; $1970
	ld de,$cc63		; $1971
	ld b,$05		; $1974
	call copyMemory		; $1976
	pop de			; $1979
	ret			; $197a

setInstrumentsDisabledCounterAndScrollMode:
	ld a,$08		; $197b
	ld ($cc85),a		; $197d
	ld a,$01		; $1980
	ld ($cd00),a		; $1982
	ret			; $1985

clearAllItemsAndPutLinkOnGround:
	push de			; $1986
	call clearAllParentItems		; $1987
	call dropLinkHeldItem		; $198a
	xor a			; $198d
	ld ($ccf1),a		; $198e
	ld de,$d600		; $1991
_label_00_211:
	ld h,d			; $1994
	ld l,e			; $1995
	ld b,$40		; $1996
	call clearMemory		; $1998
	inc d			; $199b
	ld a,d			; $199c
	cp $e0			; $199d
	jr c,_label_00_211	; $199f
	pop de			; $19a1
	jp putLinkOnGround		; $19a2

copyTextCharacterGfx:
	push hl			; $19a5
	push bc			; $19a6
	ld hl,$4000		; $19a7
	bit 0,c			; $19aa
	jr nz,_label_00_212	; $19ac
	ld hl,$4720		; $19ae
	cp $0e			; $19b1
	jr nc,_label_00_212	; $19b3
	ld a,$20		; $19b5
_label_00_212:
	call multiplyABy16		; $19b7
	add hl,bc		; $19ba
	ldh a,(<hRomBank)	; $19bb
	push af			; $19bd
	ld a,$1c		; $19be
	ldh (<hRomBank),a	; $19c0
	ld ($2222),a		; $19c2
	ld a,($cbba)		; $19c5
	ld c,a			; $19c8
	ld b,$10		; $19c9
_label_00_213:
	ldi a,(hl)		; $19cb
	xor c			; $19cc
	ld (de),a		; $19cd
	inc de			; $19ce
	ld (de),a		; $19cf
	inc de			; $19d0
	dec b			; $19d1
	jr nz,_label_00_213	; $19d2
	pop af			; $19d4
	ldh (<hRomBank),a	; $19d5
	ld ($2222),a		; $19d7
	pop bc			; $19da
	pop hl			; $19db
	ret			; $19dc

fileSelectThreadStart:
	ld hl,$cbb3		; $19dd
	ld b,$10		; $19e0
	call clearMemory		; $19e2
_label_00_214:
	ld a,$02		; $19e5
	ldh (<hRomBank),a	; $19e7
	ld ($2222),a		; $19e9
	call $40ee		; $19ec
	call resumeThreadNextFrame		; $19ef
	jr _label_00_214		; $19f2

secretFunctionCaller:
	ldh a,(<hRomBank)	; $19f4
	push af			; $19f6
	ld a,$03		; $19f7
	ldh (<hRomBank),a	; $19f9
	ld ($2222),a		; $19fb
	call $4836		; $19fe
	pop af			; $1a01
	ldh (<hRomBank),a	; $1a02
	ld ($2222),a		; $1a04
	ld a,b			; $1a07
	or a			; $1a08
	ret			; $1a09

openSecretInputMenu:
	ld ($cca2),a		; $1a0a
	ld a,$01		; $1a0d
	ld ($cca3),a		; $1a0f
	ld a,$06		; $1a12
	jp openMenu		; $1a14

updateMenus:
	ld a,($ff00+$70)	; $1a17
	ld c,a			; $1a19
	ldh a,(<hRomBank)	; $1a1a
	ld b,a			; $1a1c
	push bc			; $1a1d
	ld a,$02		; $1a1e
	ldh (<hRomBank),a	; $1a20
	ld ($2222),a		; $1a22
	call $4f90		; $1a25
	pop bc			; $1a28
	ld a,b			; $1a29
	ldh (<hRomBank),a	; $1a2a
	ld ($2222),a		; $1a2c
	ld a,c			; $1a2f
	ld ($ff00+$70),a	; $1a30
	ld a,($cbcb)		; $1a32
	or a			; $1a35
	ret			; $1a36

checkReloadStatusBarGraphics:
	ld hl,$cbea		; $1a37
	ld a,(hl)		; $1a3a
	or a			; $1a3b
	ret z			; $1a3c
	ld (hl),$00		; $1a3d
	rrca			; $1a3f
	ld a,$02		; $1a40
	jr c,_label_00_215	; $1a42
	ld a,$03		; $1a44
_label_00_215:
	jp loadUncompressedGfxHeader		; $1a46

copy20BytesFromBank:
	ldh a,(<hRomBank)	; $1a49
	push af			; $1a4b
	ld a,b			; $1a4c
	ldh (<hRomBank),a	; $1a4d
	ld ($2222),a		; $1a4f
	ld b,$20		; $1a52
	call copyMemory		; $1a54
	pop af			; $1a57
	ldh (<hRomBank),a	; $1a58
	ld ($2222),a		; $1a5a
	ret			; $1a5d

loadCommonGraphics:
	ld h,$00		; $1a5e
	jr _label_00_216		; $1a60

updateStatusBar:
	ld h,$01		; $1a62
	jr _label_00_216		; $1a64

hideStatusBar:
	ld h,$02		; $1a66
	jr _label_00_216		; $1a68

showStatusBar:
	ld h,$03		; $1a6a
	jr _label_00_216		; $1a6c

saveGraphicsOnEnterMenu:
	ld h,$04		; $1a6e
	jr _label_00_216		; $1a70

reloadGraphicsOnExitMenu:
	ld h,$05		; $1a72
	jr _label_00_216		; $1a74

openMenu:
	ld h,$06		; $1a76
	jr _label_00_216		; $1a78

copyW2AreaBgPalettesToW4PaletteData:
	ld h,$07		; $1a7a
	jr _label_00_216		; $1a7c

copyW4PaletteDataToW2AreaBgPalettes:
	ld h,$08		; $1a7e
_label_00_216:
	ld l,a			; $1a80
	ld a,($ff00+$70)	; $1a81
	ld c,a			; $1a83
	ldh a,(<hRomBank)	; $1a84
	ld b,a			; $1a86
	push bc			; $1a87
	ld a,$02		; $1a88
	ldh (<hRomBank),a	; $1a8a
	ld ($2222),a		; $1a8c
	call $4ed8		; $1a8f
	pop bc			; $1a92
	ld a,b			; $1a93
	ldh (<hRomBank),a	; $1a94
	ld ($2222),a		; $1a96
	ld a,c			; $1a99
	ld ($ff00+$70),a	; $1a9a
	ret			; $1a9c

getRoomDungeonProperties:
	ldh a,(<hRomBank)	; $1a9d
	push af			; $1a9f
	ld a,$01		; $1aa0
	ldh (<hRomBank),a	; $1aa2
	ld ($2222),a		; $1aa4
	ld a,($cc49)		; $1aa7
	and $01			; $1aaa
	ld hl,$4d3d		; $1aac
	rst_addDoubleIndex			; $1aaf
	ldi a,(hl)		; $1ab0
	ld h,(hl)		; $1ab1
	ld l,a			; $1ab2
	ld a,b			; $1ab3
	rst_addAToHl			; $1ab4
	ld b,(hl)		; $1ab5
	pop af			; $1ab6
	ldh (<hRomBank),a	; $1ab7
	ld ($2222),a		; $1ab9
	ret			; $1abc

copy8BytesFromRingMapToCec0:
	ldh a,(<hRomBank)	; $1abd
	push af			; $1abf
	ld a,$1c		; $1ac0
	ldh (<hRomBank),a	; $1ac2
	ld ($2222),a		; $1ac4
	ld de,$cec0		; $1ac7
	ld b,$08		; $1aca
	call copyMemory		; $1acc
	pop af			; $1acf
	ldh (<hRomBank),a	; $1ad0
	ld ($2222),a		; $1ad2
	ret			; $1ad5

thread_1b10:
	ld hl,$cbb3		; $1ad6
	ld b,$10		; $1ad9
	call clearMemory		; $1adb
	ld a,$01		; $1ade
	ld ($cbb4),a		; $1ae0
_label_00_217:
	ld a,$02		; $1ae3
	ldh (<hRomBank),a	; $1ae5
	ld ($2222),a		; $1ae7
	call $72b1		; $1aea
	call resumeThreadNextFrame		; $1aed
	jr _label_00_217		; $1af0

objectAddToAButtonSensitiveObjectList:
	xor a			; $1af2
	ld (de),a		; $1af3
	ld hl,$ccca		; $1af4
_label_00_218:
	ldi a,(hl)		; $1af7
	or (hl)			; $1af8
	jr z,_label_00_219	; $1af9
	inc l			; $1afb
	ld a,l			; $1afc
	cp $ea			; $1afd
	jr c,_label_00_218	; $1aff
	ret			; $1b01
_label_00_219:
	ld a,e			; $1b02
	ldd (hl),a		; $1b03
	ld (hl),d		; $1b04
	scf			; $1b05
	ret			; $1b06

objectRemoveFromAButtonSensitiveObjectList:
	push de			; $1b07
	ld a,e			; $1b08
	and $c0			; $1b09
	ld e,a			; $1b0b
	ld hl,$ccca		; $1b0c
_label_00_220:
	ldi a,(hl)		; $1b0f
	cp d			; $1b10
	jr nz,_label_00_221	; $1b11
	ld a,(hl)		; $1b13
	and $c0			; $1b14
	sub e			; $1b16
	jr nz,_label_00_221	; $1b17
	ldd (hl),a		; $1b19
	ldi (hl),a		; $1b1a
_label_00_221:
	inc l			; $1b1b
	ld a,l			; $1b1c
	cp $ea			; $1b1d
	jr c,_label_00_220	; $1b1f
	pop de			; $1b21
	ret			; $1b22

linkInteractWithAButtonSensitiveObjects:
	ld a,($cc46)		; $1b23
	and $01			; $1b26
	ret z			; $1b28
	ld a,($ccea)		; $1b29
	or a			; $1b2c
	jr nz,_label_00_222	; $1b2d
	ld a,($cc75)		; $1b2f
	or a			; $1b32
	ret nz			; $1b33
_label_00_222:
	push de			; $1b34
	ld e,$08		; $1b35
	ld a,(de)		; $1b37
	ld hl,$1b99		; $1b38
	rst_addDoubleIndex			; $1b3b
	ld e,$0b		; $1b3c
	ld a,(de)		; $1b3e
	add (hl)		; $1b3f
	ldh (<hFF8D),a	; $1b40
	inc hl			; $1b42
	ld e,$0d		; $1b43
	ld a,(de)		; $1b45
	add (hl)		; $1b46
	ldh (<hFF8C),a	; $1b47
	ld de,$ccca		; $1b49
_label_00_223:
	ld a,(de)		; $1b4c
	ld h,a			; $1b4d
	inc e			; $1b4e
	ld a,(de)		; $1b4f
	ld l,a			; $1b50
	or h			; $1b51
	jr z,_label_00_224	; $1b52
	push hl			; $1b54
	ldh a,(<hFF8D)	; $1b55
	ld b,a			; $1b57
	ldh a,(<hFF8C)	; $1b58
	ld c,a			; $1b5a
	call objectHCheckContainsPoint		; $1b5b
	pop hl			; $1b5e
	jr nc,_label_00_224	; $1b5f
	bit 0,(hl)		; $1b61
	jr z,_label_00_225	; $1b63
_label_00_224:
	inc e			; $1b65
	ld a,e			; $1b66
	cp $ea			; $1b67
	jr c,_label_00_223	; $1b69
	pop de			; $1b6b
	ret			; $1b6c
_label_00_225:
	set 0,(hl)		; $1b6d
	ld hl,$d02b		; $1b6f
	ld a,(hl)		; $1b72
	or a			; $1b73
	ld a,$fc		; $1b74
	jr z,_label_00_227	; $1b76
	bit 7,(hl)		; $1b78
	jr nz,_label_00_226	; $1b7a
	ld a,$04		; $1b7c
	cp (hl)			; $1b7e
	jr c,_label_00_228	; $1b7f
	jr _label_00_227		; $1b81
_label_00_226:

	cp (hl)			; $1b83
	jr nc,_label_00_228	; $1b84
_label_00_227:
	ld (hl),a		; $1b86
_label_00_228:

	ld a,$08		; $1b87
	ld ($cc71),a		; $1b89
	ld a,$80		; $1b8c
	ld ($cc81),a		; $1b8e
	ld hl,$cc7b		; $1b91
	set 7,(hl)		; $1b94
	scf			; $1b96
	pop de			; $1b97
	ret			; $1b98

	or $00			; $1b99
	nop			; $1b9b
	ld a,(bc)		; $1b9c
	ld a,(bc)		; $1b9d
	nop			; $1b9e
	nop			; $1b9f
	.db $f6


objectCheckContainsPoint:
	ld h,d			; $1ba1
	ldh a,(<hActiveObjectType)	; $1ba2
	ld l,a			; $1ba4
	jr _label_00_229		; $1ba5

interactionCheckContainsPoint:
	ld h,d			; $1ba7
	ld l,$40		; $1ba8
_label_00_229:

objectHCheckContainsPoint:
	ld a,l			; $1baa
	and $c0			; $1bab
	add $0b			; $1bad
	ld l,a			; $1baf
	ldi a,(hl)		; $1bb0
	sub b			; $1bb1
	jr nc,_label_00_230	; $1bb2
	cpl			; $1bb4
	inc a			; $1bb5
_label_00_230:
	ld b,a			; $1bb6
	inc l			; $1bb7
	ld a,(hl)		; $1bb8
	sub c			; $1bb9
	jr nc,_label_00_231	; $1bba
	cpl			; $1bbc
	inc a			; $1bbd
_label_00_231:
	ld c,a			; $1bbe
	ld a,l			; $1bbf
	add $19			; $1bc0
	ld l,a			; $1bc2
	ld a,b			; $1bc3
	sub (hl)		; $1bc4
	ret nc			; $1bc5
	inc l			; $1bc6
	ld a,c			; $1bc7
	sub (hl)		; $1bc8
	ret			; $1bc9
_label_00_232:

checkObjectsCollidedFromVariables:
	ld a,b			; $1bca
	ldh (<hFF8D),a	; $1bcb
	ld a,c			; $1bcd
	ldh (<hFF8C),a	; $1bce
	ld a,(de)		; $1bd0
	add (hl)		; $1bd1
	ld b,a			; $1bd2
	ldh a,(<hFF8F)	; $1bd3
	ld c,a			; $1bd5
	ldh a,(<hFF8D)	; $1bd6
	sub c			; $1bd8
	add b			; $1bd9
	sla b			; $1bda
	cp b			; $1bdc
	ret nc			; $1bdd
	inc e			; $1bde
	inc hl			; $1bdf
	ld a,(de)		; $1be0
	add (hl)		; $1be1
	ld b,a			; $1be2
	ldh a,(<hFF8E)	; $1be3
	ld c,a			; $1be5
	ldh a,(<hFF8C)	; $1be6
	sub c			; $1be8
	add b			; $1be9
	sla b			; $1bea
	cp b			; $1bec
	ret			; $1bed

func_1c28:
	ld a,($cc75)		; $1bee
	and $be			; $1bf1
	ret nz			; $1bf3
_label_00_233:

objectCheckCollidedWithLink_notDead:
	ld a,($cc34)		; $1bf4
	or a			; $1bf7
	ret nz			; $1bf8
	jr _label_00_234		; $1bf9

objectCheckCollidedWithLink_onGround:
	ld a,($cc77)		; $1bfb
	or a			; $1bfe
	ret nz			; $1bff
	ld a,($d00f)		; $1c00
	or a			; $1c03
	ret nz			; $1c04
	jr _label_00_233		; $1c05
_label_00_234:

objectCheckCollidedWithLink:
	ldh a,(<hActiveObjectType)	; $1c07
	add $0f			; $1c09
	ld l,a			; $1c0b
	ld h,d			; $1c0c

_checkCollidedWithLink:
	ld a,($cc48)		; $1c0d
	ld b,a			; $1c10
	ld c,$0f		; $1c11
	ld a,(bc)		; $1c13
	sub (hl)		; $1c14
	add $07			; $1c15
	cp $0e			; $1c17
	ret nc			; $1c19
	dec l			; $1c1a
	dec l			; $1c1b
_label_00_235:
	ldd a,(hl)		; $1c1c
	ldh (<hFF8E),a	; $1c1d
	dec l			; $1c1f
	ld a,(hl)		; $1c20
	ldh (<hFF8F),a	; $1c21
	ld a,l			; $1c23
	add $1b			; $1c24
	ld e,a			; $1c26
	ld a,($cc48)		; $1c27
	ld h,a			; $1c2a
	ld l,$0b		; $1c2b
	ld b,(hl)		; $1c2d
	ld l,$0d		; $1c2e
	ld c,(hl)		; $1c30
	ld l,$26		; $1c31
	jr _label_00_232		; $1c33

objectCheckCollidedWithLink_ignoreZ:
	ldh a,(<hActiveObjectType)	; $1c35
	add $0d			; $1c37
	ld l,a			; $1c39
	ld h,d			; $1c3a
	jr _label_00_235		; $1c3b

hObjectCheckCollidedWithLink:
	push de			; $1c3d
	ld d,h			; $1c3e
	ld a,l			; $1c3f
	and $c0			; $1c40
	add $0f			; $1c42
	ld l,a			; $1c44
	call _checkCollidedWithLink		; $1c45
	pop de			; $1c48
	ret			; $1c49

func_1c84:
	ld a,($dc00)		; $1c4a
	or a			; $1c4d
	ret nz			; $1c4e

objectHCheckCollisionWithLink:
	push de			; $1c4f
	push hl			; $1c50
	call _getLinkPositionPlusDirectionOffset		; $1c51
	pop hl			; $1c54
	ld a,l			; $1c55
	and $c0			; $1c56
	call _checkCollisionWithHAndD		; $1c58
	pop de			; $1c5b
	ret			; $1c5c

checkGrabbableObjects:
	ld a,($dc00)		; $1c5d
	or a			; $1c60
	ret nz			; $1c61
	push de			; $1c62
	call _getLinkPositionPlusDirectionOffset		; $1c63
	ld hl,$cc8e		; $1c66
_label_00_236:
	inc l			; $1c69
	bit 7,(hl)		; $1c6a
	jr z,_label_00_237	; $1c6c
	push hl			; $1c6e
	dec l			; $1c6f
	ldi a,(hl)		; $1c70
	ld h,(hl)		; $1c71
	call _checkCollisionWithHAndD		; $1c72
	jr c,_label_00_238	; $1c75
	pop hl			; $1c77
_label_00_237:
	inc l			; $1c78
	ld a,l			; $1c79
	cp $9e			; $1c7a
	jr c,_label_00_236	; $1c7c
	pop de			; $1c7e
	xor a			; $1c7f
	ret			; $1c80
_label_00_238:
	pop af			; $1c81
	ld e,$19		; $1c82
	ld a,h			; $1c84
	ld (de),a		; $1c85
	dec e			; $1c86
	ld a,l			; $1c87
	and $c0			; $1c88
	ld (de),a		; $1c8a
	ld l,a			; $1c8b
	set 1,(hl)		; $1c8c
	add $04			; $1c8e
	ld l,a			; $1c90
	ld (hl),$02		; $1c91
	inc l			; $1c93
	ld (hl),$00		; $1c94
	pop de			; $1c96
	scf			; $1c97
	ret			; $1c98

_getLinkPositionPlusDirectionOffset:
	ld a,($d008)		; $1c99
	ld hl,$1cb6		; $1c9c
	rst_addDoubleIndex			; $1c9f
	ld de,$d00b		; $1ca0
	ld a,(de)		; $1ca3
	add (hl)		; $1ca4
	ldh (<hFF8F),a	; $1ca5
	inc hl			; $1ca7
	ld e,$0d		; $1ca8
	ld a,(de)		; $1caa
	add (hl)		; $1cab
	ldh (<hFF8E),a	; $1cac
	ld e,$0f		; $1cae
	ld a,(de)		; $1cb0
	sub $03			; $1cb1
	ldh (<hFF91),a	; $1cb3
	ret			; $1cb5
	ld a,($0000)		; $1cb6
	dec b			; $1cb9
	dec b			; $1cba
	nop			; $1cbb
	nop			; $1cbc
	.db $fa

_checkCollisionWithHAndD:
	add $2a		; $1cbe
	ld l,a			; $1cc0
	bit 7,(hl)		; $1cc1
	ret nz			; $1cc3
	sub $1b			; $1cc4
	ld l,a			; $1cc6
	ldh a,(<hFF91)	; $1cc7
	sub (hl)		; $1cc9
	add $07			; $1cca
	cp $0e			; $1ccc
	ret nc			; $1cce
	dec l			; $1ccf
	dec l			; $1cd0
	ldd a,(hl)		; $1cd1
	dec l			; $1cd2
	ld b,(hl)		; $1cd3
	ld c,a			; $1cd4
	ld a,l			; $1cd5
	add $1b			; $1cd6
	ld l,a			; $1cd8
	ld e,$26		; $1cd9
	jp checkObjectsCollidedFromVariables		; $1cdb

checkLinkID0AndControlNormal:
	ld a,($d001)		; $1cde
	or a			; $1ce1
	jr z,_label_00_239	; $1ce2
	xor a			; $1ce4
	ret			; $1ce5
_label_00_239:

checkLinkVulnerable:
	ld hl,$d02a		; $1ce6
	ldi a,(hl)		; $1ce9
	or (hl)			; $1cea
	ld l,$2d		; $1ceb
	or (hl)			; $1ced
	jr nz,_label_00_240	; $1cee

checkLinkCollisionsEnabled:
	ld a,($d024)		; $1cf0
	rlca			; $1cf3
	jr nc,_label_00_240	; $1cf4
	ld a,($cc34)		; $1cf6
	or a			; $1cf9
	jr nz,_label_00_240	; $1cfa
	ld a,($cbca)		; $1cfc
	or a			; $1cff
	jr nz,_label_00_240	; $1d00
	ld a,($cc02)		; $1d02
	or a			; $1d05
	jr nz,_label_00_240	; $1d06
	ld a,($ccaf)		; $1d08
	rlca			; $1d0b
	jr c,_label_00_240	; $1d0c
	ld a,($cc77)		; $1d0e
	rlca			; $1d11
	jr c,_label_00_240	; $1d12
	scf			; $1d14
	ret			; $1d15
_label_00_240:
	xor a			; $1d16
	ret			; $1d17

checkObjectsCollided:
	ld a,l			; $1d18
	and $c0			; $1d19
	ld l,a			; $1d1b
	push hl			; $1d1c
	ld h,d			; $1d1d
	ldh a,(<hActiveObjectType)	; $1d1e
	add $0b			; $1d20
	ld l,a			; $1d22
	ldi a,(hl)		; $1d23
	ldh (<hFF8F),a	; $1d24
	inc l			; $1d26
	ld a,(hl)		; $1d27
	ldh (<hFF8E),a	; $1d28
	ld a,l			; $1d2a
	add $19			; $1d2b
	ld e,a			; $1d2d
	pop hl			; $1d2e
	ld a,l			; $1d2f
	add $0b			; $1d30
	ld l,a			; $1d32
	ld b,(hl)		; $1d33
	inc l			; $1d34
	inc l			; $1d35
	ld c,(hl)		; $1d36
	add $1b			; $1d37
	ld l,a			; $1d39
	jp checkObjectsCollidedFromVariables		; $1d3a

preventObjectHFromPassingObjectD:
	ld a,l			; $1d3d
	and $c0			; $1d3e
	ldh (<hFF8B),a	; $1d40
	call checkObjectsCollided		; $1d42
	ret nc			; $1d45
	call $1d69		; $1d46
	jr nc,_label_00_241	; $1d49
	ld b,$0b		; $1d4b
	ldh a,(<hFF8D)	; $1d4d
	ld c,a			; $1d4f
	jr _label_00_242		; $1d50
_label_00_241:
	ld b,$0d		; $1d52
	ldh a,(<hFF8C)	; $1d54
	ld c,a			; $1d56
	jr _label_00_242		; $1d57
_label_00_242:
	call $1d9c		; $1d59
	ld a,(de)		; $1d5c
	sub (hl)		; $1d5d
	ld a,c			; $1d5e
	jr c,_label_00_243	; $1d5f
	cpl			; $1d61
	inc a			; $1d62
_label_00_243:
	ld b,a			; $1d63
	ld a,(de)		; $1d64
	add b			; $1d65
	ld (hl),a		; $1d66
	scf			; $1d67
	ret			; $1d68
	ld b,$0b		; $1d69
	call $1d9c		; $1d6b
	ld a,(de)		; $1d6e
	sub (hl)		; $1d6f
	jr nc,_label_00_244	; $1d70
	cpl			; $1d72
	inc a			; $1d73
_label_00_244:
	ld c,a			; $1d74
	ld b,$26		; $1d75
	call $1d9c		; $1d77
	ld a,(de)		; $1d7a
	add (hl)		; $1d7b
	ldh (<hFF8D),a	; $1d7c
	sub c			; $1d7e
	ldh (<hFF8F),a	; $1d7f
	ld b,$0d		; $1d81
	call $1d9c		; $1d83
	ld a,(de)		; $1d86
	sub (hl)		; $1d87
	jr nc,_label_00_245	; $1d88
	cpl			; $1d8a
	inc a			; $1d8b
_label_00_245:
	ld c,a			; $1d8c
	ld b,$27		; $1d8d
	call $1d9c		; $1d8f
	ld a,(de)		; $1d92
	add (hl)		; $1d93
	ldh (<hFF8C),a	; $1d94
	sub c			; $1d96
	ld b,a			; $1d97
	ldh a,(<hFF8F)	; $1d98
	cp b			; $1d9a
	ret			; $1d9b
	ldh a,(<hActiveObjectType)	; $1d9c
	or b			; $1d9e
	ld e,a			; $1d9f
	ldh a,(<hFF8B)	; $1da0
	or b			; $1da2
	ld l,a			; $1da3
	ret			; $1da4

checkEnemyAndPartCollisionsIfTextInactive:
	call retIfTextIsActive		; $1da5
	ldh a,(<hRomBank)	; $1da8
	push af			; $1daa
	ld a,$07		; $1dab
	ldh (<hRomBank),a	; $1dad
	ld ($2222),a		; $1daf
	call $41b9		; $1db2
	pop af			; $1db5
	ldh (<hRomBank),a	; $1db6
	ld ($2222),a		; $1db8
	ret			; $1dbb

findRoomSpecificData:
	ld e,a			; $1dbc
	ld a,($cc49)		; $1dbd
	rst_addDoubleIndex			; $1dc0
	ldi a,(hl)		; $1dc1
	ld h,(hl)		; $1dc2
	ld l,a			; $1dc3
_label_00_246:

lookupKey:
	ldi a,(hl)		; $1dc4
	or a			; $1dc5
	ret z			; $1dc6
	cp e			; $1dc7
	ldi a,(hl)		; $1dc8
	jr nz,_label_00_246	; $1dc9
	scf			; $1dcb
	ret			; $1dcc

findByteInGroupTable:
	ld e,a			; $1dcd
	ld a,($cc49)		; $1dce
	rst_addDoubleIndex			; $1dd1
	ldi a,(hl)		; $1dd2
	ld h,(hl)		; $1dd3
	ld l,a			; $1dd4
_label_00_247:

findByteAtHl:
	ldi a,(hl)		; $1dd5
	or a			; $1dd6
	ret z			; $1dd7
	cp e			; $1dd8
	jr nz,_label_00_247	; $1dd9
	scf			; $1ddb
	ret			; $1ddc

lookupCollisionTable:
	ld e,a			; $1ddd

lookupCollisionTable_paramE:
	ld a,($cc4f)		; $1dde
	rst_addDoubleIndex			; $1de1
	ldi a,(hl)		; $1de2
	ld h,(hl)		; $1de3
	ld l,a			; $1de4
	jr _label_00_246		; $1de5

findByteInCollisionTable:
	ld e,a			; $1de7

findByteInCollisionTable_paramE:
	ld a,($cc4f)		; $1de8
	rst_addDoubleIndex			; $1deb
	ldi a,(hl)		; $1dec
	ld h,(hl)		; $1ded
	ld l,a			; $1dee
	jr _label_00_247		; $1def

objectSetVisiblec0:
	ldh a,(<hActiveObjectType)	; $1df1
	add $1a			; $1df3
	ld e,a			; $1df5
	ld a,$c0		; $1df6
	ld (de),a		; $1df8
	ret			; $1df9

objectSetVisiblec1:
	ldh a,(<hActiveObjectType)	; $1dfa
	add $1a			; $1dfc
	ld e,a			; $1dfe
	ld a,$c1		; $1dff
	ld (de),a		; $1e01
	ret			; $1e02

objectSetVisiblec2:
	ldh a,(<hActiveObjectType)	; $1e03
	add $1a			; $1e05
	ld e,a			; $1e07
	ld a,$c2		; $1e08
	ld (de),a		; $1e0a
	ret			; $1e0b

objectSetVisiblec3:
	ldh a,(<hActiveObjectType)	; $1e0c
	add $1a			; $1e0e
	ld e,a			; $1e10
	ld a,$c3		; $1e11
	ld (de),a		; $1e13
	ret			; $1e14

objectSetVisible80:
	ldh a,(<hActiveObjectType)	; $1e15
	add $1a			; $1e17
	ld e,a			; $1e19
	ld a,$80		; $1e1a
	ld (de),a		; $1e1c
	ret			; $1e1d

objectSetVisible81:
	ldh a,(<hActiveObjectType)	; $1e1e
	add $1a			; $1e20
	ld e,a			; $1e22
	ld a,$81		; $1e23
	ld (de),a		; $1e25
	ret			; $1e26

objectSetVisible82:
	ldh a,(<hActiveObjectType)	; $1e27
	add $1a			; $1e29
	ld e,a			; $1e2b
	ld a,$82		; $1e2c
	ld (de),a		; $1e2e
	ret			; $1e2f

objectSetVisible83:
	ldh a,(<hActiveObjectType)	; $1e30
	add $1a			; $1e32
	ld e,a			; $1e34
	ld a,$83		; $1e35
	ld (de),a		; $1e37
	ret			; $1e38

objectSetInvisible:
	ldh a,(<hActiveObjectType)	; $1e39
	add $1a			; $1e3b
	ld l,a			; $1e3d
	ld h,d			; $1e3e
	res 7,(hl)		; $1e3f
	ret			; $1e41

objectSetVisible:
	ldh a,(<hActiveObjectType)	; $1e42
	add $1a			; $1e44
	ld l,a			; $1e46
	ld h,d			; $1e47
	set 7,(hl)		; $1e48
	ret			; $1e4a

objectSetReservedBit1:
	ldh a,(<hActiveObjectType)	; $1e4b
	ld l,a			; $1e4d
	ld h,d			; $1e4e
	set 1,(hl)		; $1e4f
	ret			; $1e51

objectGetAngleTowardEnemyTarget:
	ldh a,(<hEnemyTargetY)	; $1e52
	ld b,a			; $1e54
	ldh a,(<hEnemyTargetX)	; $1e55
	ld c,a			; $1e57
	jr _label_00_248		; $1e58

objectGetLinkRelativeAngle:
	ld a,($d00b)		; $1e5a
	ld b,a			; $1e5d
	ld a,($d00d)		; $1e5e
	ld c,a			; $1e61
_label_00_248:

objectGetRelativeAngle:
	ldh a,(<hActiveObjectType)	; $1e62
	or $0b			; $1e64
	ld e,a			; $1e66
	ld a,(de)		; $1e67
	ldh (<hFF8F),a	; $1e68
	inc e			; $1e6a
	inc e			; $1e6b
	ld a,(de)		; $1e6c
	ldh (<hFF8E),a	; $1e6d

objectGetRelativeAngleWithTempVars:
	ld e,$08		; $1e6f
	ld a,b			; $1e71
	add e			; $1e72
	ld b,a			; $1e73
	ld a,c			; $1e74
	add e			; $1e75
	ld c,a			; $1e76
	ld e,$00		; $1e77
	ldh a,(<hFF8F)	; $1e79
	add $08			; $1e7b
	sub b			; $1e7d
	jr nc,_label_00_249	; $1e7e
	cpl			; $1e80
	inc a			; $1e81
	ld e,$04		; $1e82
_label_00_249:
	ld h,a			; $1e84
	ldh a,(<hFF8E)	; $1e85
	add $08			; $1e87
	sub c			; $1e89
	jr nc,_label_00_250	; $1e8a
	cpl			; $1e8c
	inc a			; $1e8d
	inc e			; $1e8e
	inc e			; $1e8f
_label_00_250:
	cp h			; $1e90
	jr nc,_label_00_251	; $1e91
	inc e			; $1e93
	ld l,a			; $1e94
	ld a,h			; $1e95
	ld h,l			; $1e96
_label_00_251:
	ld c,e			; $1e97
	ld b,$00		; $1e98
	srl a			; $1e9a
	srl a			; $1e9c
	srl a			; $1e9e
	add a			; $1ea0
	ld l,a			; $1ea1
	cp h			; $1ea2
	jr nc,_label_00_252	; $1ea3
	inc b			; $1ea5
	add l			; $1ea6
	cp h			; $1ea7
	jr nc,_label_00_252	; $1ea8
	inc b			; $1eaa
	add l			; $1eab
	cp h			; $1eac
	jr nc,_label_00_252	; $1ead
	inc b			; $1eaf
	add l			; $1eb0
	cp h			; $1eb1
	jr nc,_label_00_252	; $1eb2
	inc b			; $1eb4
_label_00_252:
	ld a,c			; $1eb5
	add a			; $1eb6
	add a			; $1eb7
	add a			; $1eb8
	add b			; $1eb9
	ld c,a			; $1eba
	ld b,$00		; $1ebb
	ld hl,pushDirectionData		; $1ebd
	add hl,bc		; $1ec0
	ld a,(hl)		; $1ec1
	ret			; $1ec2

pushDirectionData:
	jr $19			; $1ec3
	ld a,(de)		; $1ec5
	dec de			; $1ec6
	inc e			; $1ec7
	nop			; $1ec8
	nop			; $1ec9
	nop			; $1eca
	nop			; $1ecb
	rra			; $1ecc
	ld e,$1d		; $1ecd
	inc e			; $1ecf
	nop			; $1ed0
	nop			; $1ed1
	nop			; $1ed2
	ld ($0607),sp		; $1ed3
	dec b			; $1ed6
	inc b			; $1ed7
	nop			; $1ed8
	nop			; $1ed9
	nop			; $1eda
	nop			; $1edb
	ld bc,$0302		; $1edc
	inc b			; $1edf
	nop			; $1ee0
	nop			; $1ee1
	nop			; $1ee2
	jr _label_00_253		; $1ee3
	ld d,$15		; $1ee5
	inc d			; $1ee7
	nop			; $1ee8
	nop			; $1ee9
	nop			; $1eea
	stop			; $1eeb
	ld de,$1312		; $1eec
	inc d			; $1eef
	nop			; $1ef0
	nop			; $1ef1
	nop			; $1ef2
	ld ($0a09),sp		; $1ef3
	dec bc			; $1ef6
	inc c			; $1ef7
	nop			; $1ef8
	nop			; $1ef9
	nop			; $1efa
	stop			; $1efb
_label_00_253:
	rrca			; $1efc
	ld c,$0d		; $1efd
	inc c			; $1eff
	nop			; $1f00
	nop			; $1f01
	nop			; $1f02

objectUpdateSpeedZ:
	ld c,a			; $1f03

objectUpdateSpeedZ_paramC:
	ldh a,(<hActiveObjectType)	; $1f04
	add $0e			; $1f06
	ld e,a			; $1f08
	add $06			; $1f09
	ld l,a			; $1f0b
	ld h,d			; $1f0c
	call add16BitRefs		; $1f0d
	bit 7,a			; $1f10
	jr z,_label_00_254	; $1f12
	dec l			; $1f14
	ld a,c			; $1f15
	add (hl)		; $1f16
	ldi (hl),a		; $1f17
	ld a,$00		; $1f18
	adc (hl)		; $1f1a
	ld (hl),a		; $1f1b
	or d			; $1f1c
	ret			; $1f1d
_label_00_254:
	xor a			; $1f1e
	ld (de),a		; $1f1f
	dec e			; $1f20
	ld (de),a		; $1f21
	xor a			; $1f22
	ret			; $1f23

objectUpdateSpeedZ_sidescroll:
	ld b,$06		; $1f24

objectUpdateSpeedZ_sidescroll_givenYOffset:
	ldh (<hFF8B),a	; $1f26
	ldh a,(<hActiveObjectType)	; $1f28
	add $15			; $1f2a
	ld l,a			; $1f2c
	ld h,d			; $1f2d
	bit 7,(hl)		; $1f2e
	jr nz,_label_00_255	; $1f30
	add $f6			; $1f32
	ld l,a			; $1f34
	ldi a,(hl)		; $1f35
	add b			; $1f36
	ld b,a			; $1f37
	inc l			; $1f38
	ld a,(hl)		; $1f39
	sub $04			; $1f3a
	ld c,a			; $1f3c
	call checkTileCollisionAt_allowHoles		; $1f3d
	ret c			; $1f40
	ld a,c			; $1f41
	add $07			; $1f42
	ld c,a			; $1f44
	call checkTileCollisionAt_allowHoles		; $1f45
	ret c			; $1f48
_label_00_255:
	ldh a,(<hActiveObjectType)	; $1f49
	add $0a			; $1f4b
	ld e,a			; $1f4d
	add $0a			; $1f4e
	ld l,a			; $1f50
	ld h,d			; $1f51
	call add16BitRefs		; $1f52
	dec l			; $1f55
	ldh a,(<hFF8B)	; $1f56
	add (hl)		; $1f58
	ldi (hl),a		; $1f59
	ld a,$00		; $1f5a
	adc (hl)		; $1f5c
	ld (hl),a		; $1f5d
	or d			; $1f5e
	ret			; $1f5f

objectCheckLinkWithinDistance:
	ldh a,(<hActiveObjectType)	; $1f60
	add $0b			; $1f62
	ld l,a			; $1f64
	ld h,d			; $1f65
	ld e,$04		; $1f66
	ld a,($d00b)		; $1f68
	sub (hl)		; $1f6b
	jr nc,_label_00_256	; $1f6c
	cpl			; $1f6e
	inc a			; $1f6f
	ld e,$00		; $1f70
_label_00_256:
	ld b,a			; $1f72
	ld a,c			; $1f73
	sub b			; $1f74
	ccf			; $1f75
	ret nc			; $1f76
	ld c,a			; $1f77
	inc l			; $1f78
	inc l			; $1f79
	set 5,e			; $1f7a
	ld a,($d00d)		; $1f7c
	sub (hl)		; $1f7f
	jr nc,_label_00_257	; $1f80
	cpl			; $1f82
	inc a			; $1f83
	set 6,e			; $1f84
_label_00_257:
	cp c			; $1f86
	ret nc			; $1f87
	cp b			; $1f88
	jr c,_label_00_258	; $1f89
	swap e			; $1f8b
_label_00_258:
	ld a,e			; $1f8d
	and $06			; $1f8e
	scf			; $1f90
	ret			; $1f91

objectNudgeAngleTowards:
	ld c,a			; $1f92
	ldh a,(<hActiveObjectType)	; $1f93
	add $09			; $1f95
	ld e,a			; $1f97
	ld a,(de)		; $1f98
	ld b,a			; $1f99
	sub c			; $1f9a
	jr z,_label_00_260	; $1f9b
	and $1f			; $1f9d
	cp $10			; $1f9f
	jr nc,_label_00_259	; $1fa1
	dec b			; $1fa3
	jr _label_00_260		; $1fa4
_label_00_259:
	inc b			; $1fa6
_label_00_260:
	ld a,b			; $1fa7
	and $1f			; $1fa8
	ld (de),a		; $1faa
	ret			; $1fab

objectCheckCenteredWithLink:
	ld c,b			; $1fac
	sla c			; $1fad
	inc c			; $1faf
	ld h,d			; $1fb0
	ldh a,(<hActiveObjectType)	; $1fb1
	add $0b			; $1fb3
	ld l,a			; $1fb5
	ld a,($d00b)		; $1fb6
	sub (hl)		; $1fb9
	add b			; $1fba
	cp c			; $1fbb
	ret c			; $1fbc
	inc l			; $1fbd
	inc l			; $1fbe
	ld a,($d00d)		; $1fbf
	sub (hl)		; $1fc2
	add b			; $1fc3
	cp c			; $1fc4
	ret			; $1fc5

objectApplyComponentSpeed:
	ldh a,(<hActiveObjectType)	; $1fc6
	add $0a			; $1fc8
	ld l,a			; $1fca
	add $06			; $1fcb
	ld e,a			; $1fcd
	ld h,d			; $1fce
	call $1fd3		; $1fcf
	inc e			; $1fd2
	ld a,(de)		; $1fd3
	add (hl)		; $1fd4
	ldi (hl),a		; $1fd5
	inc e			; $1fd6
	ld a,(de)		; $1fd7
	adc (hl)		; $1fd8
	ldi (hl),a		; $1fd9
	ret			; $1fda

objectApplySpeed:
	ld h,d			; $1fdb
	ldh a,(<hActiveObjectType)	; $1fdc
	add $09			; $1fde
	ld e,a			; $1fe0
	ld l,a			; $1fe1
	ld c,(hl)		; $1fe2
	add $07			; $1fe3
	ld l,a			; $1fe5
	ld b,(hl)		; $1fe6

objectApplyGivenSpeed:
	call getPositionOffsetForVelocity		; $1fe7
	ret z			; $1fea
	inc e			; $1feb
	ld a,(de)		; $1fec
	add (hl)		; $1fed
	ld (de),a		; $1fee
	inc e			; $1fef
	inc l			; $1ff0
	ld a,(de)		; $1ff1
	adc (hl)		; $1ff2
	ld (de),a		; $1ff3
	inc e			; $1ff4
	inc l			; $1ff5
	ld a,(de)		; $1ff6
	add (hl)		; $1ff7
	ld (de),a		; $1ff8
	inc e			; $1ff9
	inc l			; $1ffa
	ld a,(de)		; $1ffb
	adc (hl)		; $1ffc
	ld (de),a		; $1ffd
	ret			; $1ffe

getPositionOffsetForVelocity:
	bit 7,c			; $1fff
	jr nz,_label_00_261	; $2001
	swap b			; $2003
	jr z,_label_00_261	; $2005
	ld a,b			; $2007
	ld hl,$404b		; $2008
	sla c			; $200b
	ld b,$00		; $200d
	add hl,bc		; $200f
	ld b,a			; $2010
	and $f0			; $2011
	ld c,a			; $2013
	ld a,b			; $2014
	and $0f			; $2015
	ld b,a			; $2017
	add hl,bc		; $2018
	ldh a,(<hRomBank)	; $2019
	push af			; $201b
	ld a,$03		; $201c
	ldh (<hRomBank),a	; $201e
	ld ($2222),a		; $2020
	ld bc,$cec0		; $2023
	ldi a,(hl)		; $2026
	ld (bc),a		; $2027
	inc c			; $2028
	ldi a,(hl)		; $2029
	ld (bc),a		; $202a
	inc c			; $202b
	ld a,$0e		; $202c
	rst_addAToHl			; $202e
	ldi a,(hl)		; $202f
	ld (bc),a		; $2030
	inc c			; $2031
	ldi a,(hl)		; $2032
	ld (bc),a		; $2033
	pop af			; $2034
	ldh (<hRomBank),a	; $2035
	ld ($2222),a		; $2037
	ld hl,$cec0		; $203a
	or h			; $203d
	ret			; $203e
_label_00_261:
	ld hl,$cec3		; $203f
	xor a			; $2042
	ldd (hl),a		; $2043
	ldd (hl),a		; $2044
	ldd (hl),a		; $2045
	ld (hl),a		; $2046
	ret			; $2047

objectGetPosition:
	ldh a,(<hActiveObjectType)	; $2048
	add $0b			; $204a
	ld e,a			; $204c
	ld a,(de)		; $204d
	ld b,a			; $204e
	inc e			; $204f
	inc e			; $2050
	ld a,(de)		; $2051
	ld c,a			; $2052
	ret			; $2053

objectGetShortPosition:
	ldh a,(<hActiveObjectType)	; $2054
	add $0b			; $2056
	ld e,a			; $2058

getShortPositionFromDE:
	ld a,(de)		; $2059
_label_00_262:
	and $f0			; $205a
	ld b,a			; $205c
	inc e			; $205d
	inc e			; $205e
	ld a,(de)		; $205f
	swap a			; $2060
	and $0f			; $2062
	or b			; $2064
	ret			; $2065

objectGetShortPosition_withYOffset:
	ld b,a			; $2066
	ldh a,(<hActiveObjectType)	; $2067
	add $0b			; $2069
	ld e,a			; $206b
	ld a,(de)		; $206c
	add b			; $206d
	jr _label_00_262		; $206e

objectMakeTileSolid:
	call objectGetTileCollisions		; $2070
	ld (hl),$0f		; $2073
	ret			; $2075

setShortPosition:
	ld c,a			; $2076
_label_00_263:

setShortPosition_paramC:
	push bc			; $2077
	call convertShortToLongPosition_paramC		; $2078
	ld (hl),b		; $207b
	inc l			; $207c
	inc l			; $207d
	ld (hl),c		; $207e
	pop bc			; $207f
	ret			; $2080

objectSetShortPosition:
	ld h,d			; $2081
	ldh a,(<hActiveObjectType)	; $2082
	add $0b			; $2084
	ld l,a			; $2086
	jr _label_00_263		; $2087

convertShortToLongPosition:
	ld c,a			; $2089

convertShortToLongPosition_paramC:
	ld a,c			; $208a
	and $f0			; $208b
	or $08			; $208d
	ld b,a			; $208f
	ld a,c			; $2090
	swap a			; $2091
	and $f0			; $2093
	or $08			; $2095
	ld c,a			; $2097
	ret			; $2098

objectCenterOnTile:
	ldh a,(<hActiveObjectType)	; $2099
	add $0a			; $209b
	ld l,a			; $209d
	ld h,d			; $209e

centerCoordinatesOnTile:
	xor a			; $209f
	ldi (hl),a		; $20a0
	ld a,(hl)		; $20a1
	and $f0			; $20a2
	or $08			; $20a4
	ldi (hl),a		; $20a6
	xor a			; $20a7
	ldi (hl),a		; $20a8
	ld a,(hl)		; $20a9
	and $f0			; $20aa
	or $08			; $20ac
	ld (hl),a		; $20ae
	ret			; $20af

checkBPartSlotsAvailable:
	ld hl,$d0c0		; $20b0
	jr _label_00_264		; $20b3

checkBEnemySlotsAvailable:
	ld hl,$d080		; $20b5
_label_00_264:
	call $20c2		; $20b8
	jr c,_label_00_264	; $20bb
	ret nz			; $20bd
	dec b			; $20be
	jr nz,_label_00_264	; $20bf
	ret			; $20c1
	ld a,(hl)		; $20c2
	inc h			; $20c3
	or a			; $20c4
	ret z			; $20c5
	ld a,h			; $20c6
	cp $e0			; $20c7
	ret c			; $20c9
	or h			; $20ca
	ret			; $20cb

objectSetPositionInCircleArc:
	push bc			; $20cc
	ld h,d			; $20cd
	ld l,e			; $20ce
	ld c,(hl)		; $20cf
	ld b,$28		; $20d0
	call getScaledPositionOffsetForVelocity		; $20d2
	pop bc			; $20d5
	ldh a,(<hActiveObjectType)	; $20d6
	add $0b			; $20d8
	ld e,a			; $20da
	ld a,($cec1)		; $20db
	add b			; $20de
	ld (de),a		; $20df
	inc e			; $20e0
	inc e			; $20e1
	ld a,($cec3)		; $20e2
	add c			; $20e5
	ld (de),a		; $20e6
	ret			; $20e7

getScaledPositionOffsetForVelocity:
	ldh (<hFF8B),a	; $20e8
	call getPositionOffsetForVelocity		; $20ea
	call $20f1		; $20ed
	inc l			; $20f0
	push hl			; $20f1
	ldi a,(hl)		; $20f2
	ld c,a			; $20f3
	ld b,(hl)		; $20f4
	ld e,$08		; $20f5
	ld hl,$0000		; $20f7
	ldh a,(<hFF8B)	; $20fa
_label_00_265:
	add hl,hl		; $20fc
	rlca			; $20fd
	jr nc,_label_00_266	; $20fe
	add hl,bc		; $2100
_label_00_266:
	dec e			; $2101
	jr nz,_label_00_265	; $2102
	ld a,l			; $2104
	ld b,h			; $2105
	pop hl			; $2106
	ldi (hl),a		; $2107
	ld (hl),b		; $2108
	ret			; $2109

objectSetComponentSpeedByScaledVelocity:
	call getScaledPositionOffsetForVelocity		; $210a
	ldh a,(<hActiveObjectType)	; $210d
	or $13			; $210f
	ld e,a			; $2111
	ldd a,(hl)		; $2112
	ld (de),a		; $2113
	dec e			; $2114
	ldd a,(hl)		; $2115
	ld (de),a		; $2116
	dec e			; $2117
	ldd a,(hl)		; $2118
	ld (de),a		; $2119
	dec e			; $211a
	ld a,(hl)		; $211b
	ld (de),a		; $211c
	ret			; $211d

objectGetRelatedObject1Var:
	ld l,$16		; $211e
	jr _label_00_267		; $2120

objectGetRelatedObject2Var:
	ld l,$18		; $2122
_label_00_267:
	ld h,a			; $2124
	ldh a,(<hActiveObjectType)	; $2125
	add l			; $2127
	ld e,a			; $2128
	ld a,(de)		; $2129
	add h			; $212a
	ld l,a			; $212b
	inc e			; $212c
	ld a,(de)		; $212d
	ld h,a			; $212e
	ret			; $212f

objectGetZAboveScreen:
	ldh a,(<hActiveObjectType)	; $2130
	add $0b			; $2132
	ld e,a			; $2134
	ld a,(de)		; $2135
	ld b,a			; $2136
	ldh a,(<hCameraY)	; $2137
	sub b			; $2139
	sub $08			; $213a
	cp $80			; $213c
	ret nc			; $213e
	ld a,$80		; $213f
	ret			; $2141

objectCheckWithinScreenBoundary:
	ldh a,(<hCameraY)	; $2142
	ld b,a			; $2144
	ldh a,(<hCameraX)	; $2145
	ld c,a			; $2147
	ldh a,(<hActiveObjectType)	; $2148
	add $0b			; $214a
	ld e,a			; $214c
	ld a,(de)		; $214d
	sub b			; $214e
	add $07			; $214f
	cp $8f			; $2151
	ret nc			; $2153
	inc e			; $2154
	inc e			; $2155
	ld a,(de)		; $2156
	sub c			; $2157
	add $07			; $2158
	cp $af			; $215a
	ret			; $215c

objectCheckWithinRoomBoundary:
	ldh a,(<hActiveObjectType)	; $215d
	add $0b			; $215f
	ld e,a			; $2161
	ld hl,$cca0		; $2162
	ld a,(de)		; $2165
	cp (hl)			; $2166
	ret nc			; $2167
	inc e			; $2168
	inc e			; $2169
	inc l			; $216a
	ld a,(de)		; $216b
	cp (hl)			; $216c
	ret			; $216d

objectReplaceWithID:
	ld h,d			; $216e
	push bc			; $216f
	ldh a,(<hActiveObjectType)	; $2170
	ld l,a			; $2172
	ld b,(hl)		; $2173
	add $0b			; $2174
	ld l,a			; $2176
	ld c,(hl)		; $2177
	push bc			; $2178
	inc l			; $2179
	inc l			; $217a
	ld b,(hl)		; $217b
	inc l			; $217c
	inc l			; $217d
	ld c,(hl)		; $217e
	push bc			; $217f
	call objectDelete_useActiveObjectType		; $2180
	pop bc			; $2183
	ld h,d			; $2184
	ldh a,(<hActiveObjectType)	; $2185
	add $0f			; $2187
	ld l,a			; $2189
	ld (hl),c		; $218a
	dec l			; $218b
	dec l			; $218c
	ld (hl),b		; $218d
	pop bc			; $218e
	dec l			; $218f
	dec l			; $2190
	ld (hl),c		; $2191
	ldh a,(<hActiveObjectType)	; $2192
	ld l,a			; $2194
	ld a,b			; $2195
	and $03			; $2196
	ldi (hl),a		; $2198
	pop bc			; $2199
	ld (hl),b		; $219a
	inc l			; $219b
	ld (hl),c		; $219c
	ret			; $219d

objectDelete_useActiveObjectType:
	ldh a,(<hActiveObjectType)	; $219e
	ld e,a			; $21a0

objectDelete_de:
	ld a,e			; $21a1
	and $c0			; $21a2
	ld e,a			; $21a4
	ld l,a			; $21a5
	ld h,d			; $21a6
	ld b,$10		; $21a7
	xor a			; $21a9
_label_00_268:
	ldi (hl),a		; $21aa
	ldi (hl),a		; $21ab
	ldi (hl),a		; $21ac
	ldi (hl),a		; $21ad
	dec b			; $21ae
	jr nz,_label_00_268	; $21af
	jp objectRemoveFromAButtonSensitiveObjectList		; $21b1

checkLinkIsOverHazard:
	ld a,($cc48)		; $21b4
	ld d,a			; $21b7
	ldh (<hActiveObject),a	; $21b8
	xor a			; $21ba
	ldh (<hActiveObjectType),a	; $21bb
	ld e,$01		; $21bd
	ld a,(de)		; $21bf
	sub $0c			; $21c0
	ret z			; $21c2
	push bc			; $21c3
	push hl			; $21c4
	call objectCheckIsOverHazard		; $21c5
	pop hl			; $21c8
	pop bc			; $21c9
	ret			; $21ca

objectCheckIsOnHazard:
	ldh a,(<hActiveObjectType)	; $21cb
	add $0f			; $21cd
	ld e,a			; $21cf
	ld a,(de)		; $21d0
	and $80			; $21d1
	ret nz			; $21d3

objectCheckIsOverHazard:
	ld bc,$0500		; $21d4
	call objectGetRelativeTile		; $21d7
	ld hl,hazardCollisionTable		; $21da
	jp lookupCollisionTable		; $21dd

objectReplaceWithAnimationIfOnHazard:
	call objectCheckIsOnHazard		; $21e0
	ret nc			; $21e3
	rrca			; $21e4
	jr c,_label_00_270	; $21e5
	rrca			; $21e7
	jr c,_label_00_269	; $21e8
	ld b,$04		; $21ea
	jr _label_00_271		; $21ec
_label_00_269:

objectReplaceWithFallingDownHoleInteraction:
	call objectCreateFallingDownHoleInteraction		; $21ee
	jr _label_00_272		; $21f1
_label_00_270:

objectReplaceWithSplash:
	ld b,$03		; $21f3
_label_00_271:
	call objectCreateInteractionWithSubid00		; $21f5
_label_00_272:
	call objectDelete_useActiveObjectType		; $21f8
	scf			; $21fb
	ret			; $21fc

objectCopyPosition:
	ldh a,(<hActiveObjectType)	; $21fd
	add $0b			; $21ff
	ld e,a			; $2201

objectCopyPosition_rawAddress:
	ld a,l			; $2202
	and $c0			; $2203
	add $0b			; $2205
	ld l,a			; $2207
	ld a,(de)		; $2208
	ldi (hl),a		; $2209
	inc e			; $220a
	inc e			; $220b
	inc l			; $220c
	ld a,(de)		; $220d
	ldi (hl),a		; $220e
	inc e			; $220f
	inc e			; $2210
	inc l			; $2211
	ld a,(de)		; $2212
	ldi (hl),a		; $2213
	ret			; $2214

objectCopyPositionWithOffset:
	ldh a,(<hActiveObjectType)	; $2215
	add $0b			; $2217
	ld e,a			; $2219
	ld a,l			; $221a
	and $c0			; $221b
	add $0b			; $221d
	ld l,a			; $221f
	ld a,(de)		; $2220
	add b			; $2221
	ldi (hl),a		; $2222
	inc e			; $2223
	inc e			; $2224
	inc l			; $2225
	ld a,(de)		; $2226
	add c			; $2227
	ldi (hl),a		; $2228
	inc e			; $2229
	inc e			; $222a
	inc l			; $222b
	ld a,(de)		; $222c
	ldi (hl),a		; $222d
	ret			; $222e

objectTakePosition:
	ld bc,$0000		; $222f

objectTakePositionWithOffset:
	ldh a,(<hActiveObjectType)	; $2232
	add $0b			; $2234
	ld e,a			; $2236
	ld a,l			; $2237
	and $c0			; $2238
	add $0b			; $223a
	ld l,a			; $223c
	ldi a,(hl)		; $223d
	add b			; $223e
	ld (de),a		; $223f
	inc e			; $2240
	inc e			; $2241
	inc l			; $2242
	ldi a,(hl)		; $2243
	add c			; $2244
	ld (de),a		; $2245
	inc e			; $2246
	inc e			; $2247
	inc l			; $2248
	ld a,(hl)		; $2249
	ld (de),a		; $224a
	ret			; $224b

breakCrackedFloor:
	push bc			; $224c
	call setTile		; $224d
	pop bc			; $2250
	ld a,$b3		; $2251
	call playSound		; $2253
	call getFreeInteractionSlot		; $2256
	ret nz			; $2259
	ld (hl),$0f		; $225a
	inc l			; $225c
	ld (hl),$80		; $225d
	ld l,$4b		; $225f
	jp setShortPosition_paramC		; $2261

objectCheckTileAtPositionIsWater:
	call objectGetTileAtPosition		; $2264
	sub $fa			; $2267
	cp $04			; $2269
	ret			; $226b

checkTileAtPositionIsWater:
	call getTileAtPosition		; $226c
	sub $fa			; $226f
	cp $04			; $2271
	ret			; $2273

findItemWithID:
	ld h,$d6		; $2274
_label_00_273:
	ld l,$01		; $2276
	ld a,(hl)		; $2278
	cp c			; $2279
	ret z			; $227a

findItemWithID_startingAfterH:
	inc h			; $227b
	ld a,h			; $227c
	cp $e0			; $227d
	jr c,_label_00_273	; $227f
	or h			; $2281
	ret			; $2282

objectFindSameTypeObjectWithID:
	ldh a,(<hActiveObject)	; $2283
	and $f0			; $2285
	ld h,a			; $2287
	ldh a,(<hActiveObjectType)	; $2288
	inc a			; $228a
	ld l,a			; $228b
_label_00_274:
	ld a,(hl)		; $228c
	cp c			; $228d
	ret z			; $228e
	inc h			; $228f
	ld a,h			; $2290
	cp $e0			; $2291
	jr c,_label_00_274	; $2293
	or h			; $2295
	ret			; $2296

objectSetPriorityRelativeToLink:
	ld c,$80		; $2297
	jr _label_00_275		; $2299

objectSetPriorityRelativeToLink_withTerrainEffects:
	ld c,$c0		; $229b
_label_00_275:
	call $22a9		; $229d
	ldh a,(<hActiveObjectType)	; $22a0
	add $1a			; $22a2
	ld e,a			; $22a4
	ld a,c			; $22a5
	or b			; $22a6
	ld (de),a		; $22a7
	ret			; $22a8
	ldh a,(<hActiveObjectType)	; $22a9
	add $0f			; $22ab
	ld e,a			; $22ad
	ld a,(de)		; $22ae
	dec a			; $22af
	ld b,$03		; $22b0
	cp $10			; $22b2
	ret c			; $22b4
	dec b			; $22b5
	ld a,e			; $22b6
	add $fc			; $22b7
	ld e,a			; $22b9
	ld a,(de)		; $22ba
	ld e,a			; $22bb
	ld a,($cc48)		; $22bc
	ld h,a			; $22bf
	ld l,$0b		; $22c0
	ld a,(hl)		; $22c2
	add $0b			; $22c3
	cp e			; $22c5
	ret nc			; $22c6
	dec b			; $22c7
	ret			; $22c8

objectPushLinkAwayOnCollision:
	ld a,($cc48)		; $22c9
	ld h,a			; $22cc
	ld l,$00		; $22cd
	call checkObjectsCollided		; $22cf
	ret nc			; $22d2
	call objectGetAngleTowardEnemyTarget		; $22d3
	ld c,a			; $22d6
	ld b,$28		; $22d7

updateLinkPositionGivenVelocity:
	ldh a,(<hRomBank)	; $22d9
	push af			; $22db
	ld a,$05		; $22dc
	ldh (<hRomBank),a	; $22de
	ld ($2222),a		; $22e0
	push de			; $22e3
	ld a,($cc48)		; $22e4
	ld d,a			; $22e7
	ld e,$00		; $22e8
	call $5c90		; $22ea
	pop de			; $22ed
	pop af			; $22ee
	ldh (<hRomBank),a	; $22ef
	ld ($2222),a		; $22f1
	scf			; $22f4
	ret			; $22f5

objectMimicBgTile:
	call getTileMappingData		; $22f6
	ld h,d			; $22f9
	ldh a,(<hActiveObjectType)	; $22fa
	add $1b			; $22fc
	ld l,a			; $22fe
	ld a,$0e		; $22ff
	ldi (hl),a		; $2301
	ldi (hl),a		; $2302
	ld (hl),c		; $2303
	ld a,b			; $2304
	and $07			; $2305
	swap a			; $2307
	rrca			; $2309
	ld bc,$de80		; $230a
	call addAToBc		; $230d
	ld a,($ff00+$70)	; $2310
	push af			; $2312
	ld a,$02		; $2313
	ld ($ff00+$70),a	; $2315
	ld hl,$def0		; $2317
	ld e,$08		; $231a
_label_00_276:
	ld a,(bc)		; $231c
	ldi (hl),a		; $231d
	inc c			; $231e
	dec e			; $231f
	jr nz,_label_00_276	; $2320
	ld hl,$ffa5		; $2322
	set 6,(hl)		; $2325
	pop af			; $2327
	ld ($ff00+$70),a	; $2328
	ret			; $232a

objectUpdateSpeedZAndBounce:
	call objectUpdateSpeedZ_paramC		; $232b
	ret nz			; $232e

objectNegateAndHalveSpeedZ:
	ld h,d			; $232f
	ldh a,(<hActiveObjectType)	; $2330
	or $14			; $2332
	ld l,a			; $2334
	ldi a,(hl)		; $2335
	cpl			; $2336
	ld c,a			; $2337
	ld a,(hl)		; $2338
	cpl			; $2339
	ld b,a			; $233a
	inc bc			; $233b
	sra b			; $233c
	rr c			; $233e
	ld hl,$ff80		; $2340
	call compareHlToBc		; $2343
	inc a			; $2346
	scf			; $2347
	ret z			; $2348
	ldh a,(<hActiveObjectType)	; $2349
	or $14			; $234b
	ld e,a			; $234d
	ld a,c			; $234e
	ld (de),a		; $234f
	inc e			; $2350
	ld a,b			; $2351
	ld (de),a		; $2352
	or c			; $2353
	scf			; $2354
	ret z			; $2355
	xor a			; $2356
	ret			; $2357

objectSetSpeedZ:
	ldh a,(<hActiveObjectType)	; $2358
	add $14			; $235a
	ld l,a			; $235c
	ld h,d			; $235d
	ld (hl),c		; $235e
	inc l			; $235f
	ld (hl),b		; $2360
	ret			; $2361

add16BitRefs:
	ld a,(de)		; $2362
	add (hl)		; $2363
	ld (de),a		; $2364
	inc e			; $2365
	inc hl			; $2366
	ld a,(de)		; $2367
	adc (hl)		; $2368
	ld (de),a		; $2369
	ret			; $236a

cpActiveRing:
	push hl			; $236b
	ld hl,$c6c5		; $236c
	cp (hl)			; $236f
	pop hl			; $2370
	ret			; $2371

disableActiveRing:
	push hl			; $2372
	ld hl,$c6c5		; $2373
	set 6,(hl)		; $2376
	pop hl			; $2378
	ret			; $2379

enableActiveRing:
	push hl			; $237a
	ld hl,$c6c5		; $237b
	ld a,(hl)		; $237e
	cp $ff			; $237f
	jr z,_label_00_277	; $2381
	res 6,(hl)		; $2383
_label_00_277:
	pop hl			; $2385
	ret			; $2386

interactionDecCounter1:
	ld h,d			; $2387
	ld l,$46		; $2388
	dec (hl)		; $238a
	ret			; $238b

interactionDecCounter2:
	ld h,d			; $238c
	ld l,$47		; $238d
	dec (hl)		; $238f
	ret			; $2390

itemDecCounter1:
	ld h,d			; $2391
	ld l,$06		; $2392
	dec (hl)		; $2394
	ret			; $2395

itemDecCounter2:
	ld h,d			; $2396
	ld l,$07		; $2397
	dec (hl)		; $2399
	ret			; $239a

interactionIncState:
	ld h,d			; $239b
	ld l,$44		; $239c
	inc (hl)		; $239e
	ret			; $239f

interactionIncState2:
	ld h,d			; $23a0
	ld l,$45		; $23a1
	inc (hl)		; $23a3
	ret			; $23a4

itemIncState:
	ld h,d			; $23a5
	ld l,$04		; $23a6
	inc (hl)		; $23a8
	ret			; $23a9

itemIncState2:
	ld h,d			; $23aa
	ld l,$05		; $23ab
	inc (hl)		; $23ad
	ret			; $23ae

cpInteractionState:
	ld h,d			; $23af
	ld l,$44		; $23b0
	cp (hl)			; $23b2
	ret			; $23b3

cpInteractionState2:
	ld h,d			; $23b4
	ld l,$45		; $23b5
	cp (hl)			; $23b7
	ret			; $23b8

checkInteractionState:
	ld e,$44		; $23b9
	ld a,(de)		; $23bb
	or a			; $23bc
	ret			; $23bd

checkInteractionState2:
	ld e,$45		; $23be
	ld a,(de)		; $23c0
	or a			; $23c1
	ret			; $23c2

hazardCollisionTable:
	rst $8			; $23c3
	inc hl			; $23c4
	ld ($1823),a		; $23c5
	inc h			; $23c8
	add hl,de		; $23c9
	inc h			; $23ca
	add hl,de		; $23cb
	inc h			; $23cc
	ldd a,(hl)		; $23cd
	inc h			; $23ce
	di			; $23cf
	ld (bc),a		; $23d0
.DB $fd				; $23d1
	ld bc,$01fe		; $23d2
	rst $38			; $23d5
	ld bc,$01d1		; $23d6
	jp nc,$d301		; $23d9
	ld bc,$01d4		; $23dc
	ld a,e			; $23df
	inc b			; $23e0
	ld a,h			; $23e1
	inc b			; $23e2
	ld a,l			; $23e3
	inc b			; $23e4
	ld a,(hl)		; $23e5
	inc b			; $23e6
	ld a,a			; $23e7
	inc b			; $23e8
	nop			; $23e9
	di			; $23ea
	ld (bc),a		; $23eb
.DB $f4				; $23ec
	ld (bc),a		; $23ed
	ld a,e			; $23ee
	inc b			; $23ef
	ld a,h			; $23f0
	inc b			; $23f1
	ld a,l			; $23f2
	inc b			; $23f3
	ld a,(hl)		; $23f4
	inc b			; $23f5
	ld a,a			; $23f6
	inc b			; $23f7
	ret nz			; $23f8
	inc b			; $23f9
	pop bc			; $23fa
	inc b			; $23fb
	jp nz,$c304		; $23fc
	inc b			; $23ff
	call nz,$c504		; $2400
	inc b			; $2403
	add $04			; $2404
	rst_jumpTable			; $2406
	inc b			; $2407
	ret z			; $2408
	inc b			; $2409
	ret			; $240a
	inc b			; $240b
	jp z,$cb04		; $240c
	inc b			; $240f
	call z,$cd04		; $2410
	inc b			; $2413
	adc $04			; $2414
	rst $8			; $2416
	inc b			; $2417
	nop			; $2418
	di			; $2419
	ld (bc),a		; $241a
.DB $f4				; $241b
	ld (bc),a		; $241c
	push af			; $241d
	ld (bc),a		; $241e
	or $02			; $241f
	rst $30			; $2421
	ld (bc),a		; $2422
	ld c,b			; $2423
	ld (bc),a		; $2424
	ld c,c			; $2425
	ld (bc),a		; $2426
	ld c,d			; $2427
	ld (bc),a		; $2428
	ld c,e			; $2429
	ld (bc),a		; $242a
	ret nc			; $242b
	ld b,d			; $242c
	ld h,c			; $242d
	inc b			; $242e
	ld h,d			; $242f
	inc b			; $2430
	ld h,e			; $2431
	inc b			; $2432
	ld h,h			; $2433
	inc b			; $2434
	ld h,l			; $2435
	inc b			; $2436
.DB $fd				; $2437
	ld bc,$0c00		; $2438
	inc b			; $243b
	dec c			; $243c
	inc b			; $243d
	ld c,$04		; $243e
	ld a,(de)		; $2440
	ld bc,$011b		; $2441
	inc e			; $2444
	ld bc,$011d		; $2445
	ld e,$01		; $2448
	rra			; $244a
	.db $01 $00

slideAngleTable:
	.db $80			; $244d
	add b			; $244e
	ld bc,$0202		; $244f
	ld (bc),a		; $2452
	inc bc			; $2453
	inc h			; $2454
	inc h			; $2455
	inc h			; $2456
	dec b			; $2457
	ld b,$06		; $2458
	ld b,$07		; $245a
	ld c,b			; $245c
	ld c,b			; $245d
	ld c,b			; $245e
	add hl,bc		; $245f
	ld a,(bc)		; $2460
	ld a,(bc)		; $2461
	ld a,(bc)		; $2462
	dec bc			; $2463
	inc e			; $2464
	inc e			; $2465
	inc e			; $2466
	dec c			; $2467
	ld c,$0e		; $2468
	ld c,$0f		; $246a
	add b			; $246c

angleTable:
	nop			; $246d
	nop			; $246e
	nop			; $246f
	ld bc,$0101		; $2470
	ld (bc),a		; $2473
	ld (bc),a		; $2474
	ld (bc),a		; $2475
	ld (bc),a		; $2476
	ld (bc),a		; $2477
	inc bc			; $2478
	inc bc			; $2479
	inc bc			; $247a
	inc b			; $247b
	inc b			; $247c
	inc b			; $247d
	inc b			; $247e
	inc b			; $247f
	dec b			; $2480
	dec b			; $2481
	dec b			; $2482
	ld b,$06		; $2483
	ld b,$06		; $2485
	ld b,$07		; $2487
	rlca			; $2489
	rlca			; $248a
	nop			; $248b
	nop			; $248c

objectSetCollideRadius:
	push bc			; $248d
	ld b,a			; $248e
	ld c,a			; $248f
	call objectSetCollideRadii		; $2490
	pop bc			; $2493
	ret			; $2494

objectSetCollideRadii:
	ldh a,(<hActiveObjectType)	; $2495
	add $26			; $2497
	ld l,a			; $2499
	ld h,d			; $249a
	ld (hl),b		; $249b
	inc l			; $249c
	ld (hl),c		; $249d
	ret			; $249e

decNumEnemies:
	ld hl,$cc30		; $249f
	ld a,(hl)		; $24a2
	or a			; $24a3
	ret z			; $24a4
	dec (hl)		; $24a5
	ret			; $24a6

setScreenShakeCounter:
	ld hl,$cd18		; $24a7
	ldi (hl),a		; $24aa
	ld (hl),a		; $24ab
	ret			; $24ac

objectCreatePuff:
	ld b,$05		; $24ad

objectCreateInteractionWithSubid00:
	ld c,$00		; $24af

objectCreateInteraction:
	call getFreeInteractionSlot		; $24b1
	ret nz			; $24b4
	ld (hl),b		; $24b5
	inc l			; $24b6
	ld (hl),c		; $24b7
	call objectCopyPosition		; $24b8
	xor a			; $24bb
	ret			; $24bc

objectCreateFallingDownHoleInteraction:
	call getFreeInteractionSlot		; $24bd
	ret nz			; $24c0
	ld (hl),$0f		; $24c1
	ld l,$46		; $24c3
	ldh a,(<hActiveObjectType)	; $24c5
	ldi (hl),a		; $24c7
	add $01			; $24c8
	ld e,a			; $24ca
	ld a,(de)		; $24cb
	ld (hl),a		; $24cc
	call objectCopyPosition		; $24cd
	xor a			; $24d0
	ret			; $24d1

_interactionActuallyRunScript:
	ldh a,(<hRomBank)	; $24d2
	push af			; $24d4
	ld a,$0b		; $24d5
	ldh (<hRomBank),a	; $24d7
	ld ($2222),a		; $24d9
_label_00_278:
	ld a,(hl)		; $24dc
	or a			; $24dd
	jr z,_label_00_279	; $24de
	call $4000		; $24e0
	jr c,_label_00_278	; $24e3
	pop af			; $24e5
	ldh (<hRomBank),a	; $24e6
	ld ($2222),a		; $24e8
	xor a			; $24eb
	ret			; $24ec
_label_00_279:
	pop af			; $24ed
	ldh (<hRomBank),a	; $24ee
	ld ($2222),a		; $24f0
	scf			; $24f3
	ret			; $24f4

interactionSetHighTextIndex:
	ld e,$73		; $24f5
	ld (de),a		; $24f7
	ld e,$70		; $24f8
	set 7,a			; $24fa
	ld (de),a		; $24fc
	ret			; $24fd

interactionSetScript:
	ld e,$58		; $24fe
	ld a,l			; $2500
	ld (de),a		; $2501
	inc e			; $2502
	ld a,h			; $2503
	ld (de),a		; $2504
	ld h,d			; $2505
	ld l,$46		; $2506
	xor a			; $2508
	ldi (hl),a		; $2509
	ldi (hl),a		; $250a
	ret			; $250b

interactionRunScript:
	ld a,($cc34)		; $250c
	or a			; $250f
	ret nz			; $2510
	ld a,($cba0)		; $2511
	add a			; $2514
	jr c,_label_00_280	; $2515
	ret nz			; $2517
_label_00_280:
	ld h,d			; $2518
	ld l,$46		; $2519
	ld a,(hl)		; $251b
	or a			; $251c
	jr z,_label_00_281	; $251d
	dec (hl)		; $251f
	ret nz			; $2520
_label_00_281:
	ld l,$47		; $2521
	ld a,(hl)		; $2523
	or a			; $2524
	jr z,_label_00_282	; $2525
	dec (hl)		; $2527
	call nz,objectApplySpeed		; $2528
	xor a			; $252b
	ret			; $252c
_label_00_282:
	ld h,d			; $252d
	ld l,$58		; $252e
	ldi a,(hl)		; $2530
	ld h,(hl)		; $2531
	ld l,a			; $2532
	call _interactionActuallyRunScript		; $2533
	jr c,_label_00_283	; $2536
	call _interactionSaveScriptAddress		; $2538
	xor a			; $253b
	ret			; $253c
_label_00_283:
	call _interactionSaveScriptAddress		; $253d
	scf			; $2540
	ret			; $2541

_interactionSaveScriptAddress:
	ld e,$58		; $2542
	ld a,l			; $2544
	ld (de),a		; $2545
	inc e			; $2546
	ld a,h			; $2547
	ld (de),a		; $2548
	ret			; $2549

scriptCmd_asmCall:
	pop hl			; $254a
	call _scriptFunc_setupAsmCall		; $254b
	jr _label_00_284		; $254e

scriptCmd_asmCallWithParam:
	pop hl			; $2550
	call _scriptFunc_setupAsmCall		; $2551
	ldi a,(hl)		; $2554
	ld e,a			; $2555
_label_00_284:
	ldh a,(<hRomBank)	; $2556
	push af			; $2558
	ld a,d			; $2559
	ldh (<hRomBank),a	; $255a
	ld ($2222),a		; $255c
	push hl			; $255f
	ld hl,_scriptCmd_asmRetFunc		; $2560
	push hl			; $2563
	ldh a,(<hActiveObject)	; $2564
	ld d,a			; $2566
	ld h,b			; $2567
	ld l,c			; $2568
	ld a,e			; $2569
	jp hl			; $256a

_scriptCmd_asmRetFunc:
	pop hl			; $256b
	pop af			; $256c
	ldh (<hRomBank),a	; $256d
	ld ($2222),a		; $256f
	ldh a,(<hActiveObject)	; $2572
	ld d,a			; $2574
	scf			; $2575
	ret			; $2576

_scriptFunc_setupAsmCall:
	inc hl			; $2577
	ld d,$15		; $2578
	ldi a,(hl)		; $257a
	ld c,a			; $257b
	ldi a,(hl)		; $257c
	ld b,a			; $257d
	ret			; $257e

scriptFunc_jump_scf:
	scf			; $257f
	jr _label_00_285		; $2580

scriptFunc_jump:
	xor a			; $2582
_label_00_285:
	ldi a,(hl)		; $2583
	ld h,(hl)		; $2584
	ld l,a			; $2585
	ldh a,(<hActiveObject)	; $2586
	ld d,a			; $2588
	ret			; $2589

scriptFunc_add3ToHl_scf:
	scf			; $258a

scriptFunc_add3ToHl:
	inc hl			; $258b
	inc hl			; $258c
	inc hl			; $258d
	ret			; $258e

scriptCmd_loadScript:
	pop hl			; $258f
	inc hl			; $2590
	ldi a,(hl)		; $2591
	ld e,a			; $2592
	ldi a,(hl)		; $2593
	ld c,a			; $2594
	ldi a,(hl)		; $2595
	ld b,a			; $2596
	ldh a,(<hRomBank)	; $2597
	push af			; $2599
	ld a,e			; $259a
	ldh (<hRomBank),a	; $259b
	ld ($2222),a		; $259d
	ld h,b			; $25a0
	ld l,c			; $25a1
	ld de,$c300		; $25a2
	ld b,$00		; $25a5
	call copyMemory		; $25a7
	pop af			; $25aa
	ldh (<hRomBank),a	; $25ab
	ld ($2222),a		; $25ad
	ldh a,(<hActiveObject)	; $25b0
	ld d,a			; $25b2
	ld hl,$c300		; $25b3
	scf			; $25b6
	ret			; $25b7

interactionUpdateAnimCounter:
	ld h,d			; $25b8
	ld l,$60		; $25b9
	dec (hl)		; $25bb
	ret nz			; $25bc
	ldh a,(<hRomBank)	; $25bd
	push af			; $25bf
	ld a,$14		; $25c0
	ldh (<hRomBank),a	; $25c2
	ld ($2222),a		; $25c4
	ld l,$62		; $25c7
	jr _label_00_286		; $25c9

interactionSetAnimation:
	add a			; $25cb
	ld c,a			; $25cc
	ld b,$00		; $25cd
	ldh a,(<hRomBank)	; $25cf
	push af			; $25d1
	ld a,$14		; $25d2
	ldh (<hRomBank),a	; $25d4
	ld ($2222),a		; $25d6
	ld e,$41		; $25d9
	ld a,(de)		; $25db
	ld hl,$5325		; $25dc
	rst_addDoubleIndex			; $25df
	ldi a,(hl)		; $25e0
	ld h,(hl)		; $25e1
	ld l,a			; $25e2
	add hl,bc		; $25e3
_label_00_286:

_interactionNextAnimationFrame:
	ldi a,(hl)		; $25e4
	ld h,(hl)		; $25e5
	ld l,a			; $25e6
	ldi a,(hl)		; $25e7
	cp $ff			; $25e8
	jr nz,_label_00_287	; $25ea
	ld b,a			; $25ec
	ld c,(hl)		; $25ed
	add hl,bc		; $25ee
	ldi a,(hl)		; $25ef
_label_00_287:
	ld e,$60		; $25f0
	ld (de),a		; $25f2
	ldi a,(hl)		; $25f3
	ld c,a			; $25f4
	ld b,$00		; $25f5
	inc e			; $25f7
	ldi a,(hl)		; $25f8
	ld (de),a		; $25f9
	inc e			; $25fa
	ld a,l			; $25fb
	ld (de),a		; $25fc
	inc e			; $25fd
	ld a,h			; $25fe
	ld (de),a		; $25ff
	ld e,$41		; $2600
	ld a,(de)		; $2602
	ld hl,$54f5		; $2603
	rst_addDoubleIndex			; $2606
	ldi a,(hl)		; $2607
	ld h,(hl)		; $2608
	ld l,a			; $2609
	add hl,bc		; $260a
	ld e,$5e		; $260b
	ldi a,(hl)		; $260d
	ld (de),a		; $260e
	inc e			; $260f
	ldi a,(hl)		; $2610
	and $3f			; $2611
	or $40			; $2613
	ld (de),a		; $2615
	pop af			; $2616
	ldh (<hRomBank),a	; $2617
	ld ($2222),a		; $2619
	ret			; $261c

objectPreventLinkFromPassing:
	ld a,($cca6)		; $261d
	or a			; $2620
	ret nz			; $2621
	ld l,a			; $2622
	ld a,($cc48)		; $2623
	ld h,a			; $2626
	call preventObjectHFromPassingObjectD		; $2627
	push af			; $262a
	ld hl,$d101		; $262b
	ld a,(hl)		; $262e
	cp $0c			; $262f
	jr nz,_label_00_288	; $2631
	ld l,$04		; $2633
	ld a,(hl)		; $2635
	cp $02			; $2636
	jr nz,_label_00_288	; $2638
	call preventObjectHFromPassingObjectD		; $263a
	jr nc,_label_00_288	; $263d
	ld a,$01		; $263f
	ld ($cc37),a		; $2641
_label_00_288:
	pop af			; $2644
	ret			; $2645

npcAnimate_followLink:
	ld e,$6c		; $2646
	ld a,$01		; $2648
	ld (de),a		; $264a
	ld e,$6b		; $264b
	ld a,(de)		; $264d
	or a			; $264e
	jr nz,_label_00_290	; $264f
	ld c,$28		; $2651
	call objectCheckLinkWithinDistance		; $2653
	jr c,_label_00_289	; $2656
	ld l,$6c		; $2658
	dec (hl)		; $265a
	ld a,$04		; $265b
_label_00_289:
	ld b,a			; $265d
	add a			; $265e
	add a			; $265f
	ld h,d			; $2660
	ld l,$49		; $2661
	cp (hl)			; $2663
	jr z,_label_00_291	; $2664
	ld (hl),a		; $2666
	srl b			; $2667
	call seasonsFunc_2678		; $2669
	ld a,b			; $266c
	call interactionSetAnimation		; $266d
	ld e,$6b		; $2670
	ld a,$1e		; $2672
_label_00_290:
	dec a			; $2674
	ld (de),a		; $2675
	jr _label_00_291		; $2676

seasonsFunc_2678:
	ld e,$41		; $2678
	ld a,(de)		; $267a
	sub $24			; $267b
	cp $24			; $267d
	ret nc			; $267f
	ld e,$77		; $2680
	ld a,(de)		; $2682
	add b			; $2683
	ld b,a			; $2684
	ret			; $2685
_label_00_291:

npcAnimate_staticDirection:
	call interactionUpdateAnimCounter		; $2686

npcAnimate_someVariant:
	call objectPreventLinkFromPassing		; $2689
	jp objectSetPriorityRelativeToLink_withTerrainEffects		; $268c

returnIfScrollMode01Unset:
	ld a,($cd00)		; $268f
	and $01			; $2692
	ret nz			; $2694
	pop hl			; $2695
	ret			; $2696

interactionDeleteAndRetIfEnabled02:
	ld e,$40		; $2697
	ld a,(de)		; $2699
	and $03			; $269a
	cp $02			; $269c
	ret nz			; $269e
	pop hl			; $269f
	jp interactionDelete		; $26a0

convertAngleDeToDirection:
	ld a,(de)		; $26a3

convertAngleToDirection:
	add $04			; $26a4
	add a			; $26a6
	swap a			; $26a7
	and $03			; $26a9
	ret			; $26ab

interactionSetEnabledBit7:
	ld h,d			; $26ac
	ld l,$40		; $26ad
	set 7,(hl)		; $26af
	ret			; $26b1

objectCheckLinkPushingAgainstCenter:
	ld a,($d001)		; $26b2
	or a			; $26b5
	ret nz			; $26b6
	ld a,($cc47)		; $26b7
	cp $ff			; $26ba
	ret z			; $26bc
	ld a,($cc45)		; $26bd
	and $03			; $26c0
	ret nz			; $26c2
	ld b,$04		; $26c3
	jp objectCheckCenteredWithLink		; $26c5

interactionCheckAdjacentTileIsSolid:
	ld e,$49		; $26c8
	ld a,(de)		; $26ca
	call convertAngleDeToDirection		; $26cb
	jr _label_00_292		; $26ce

interactionCheckAdjacentTileIsSolid_viaDirection:
	ld e,$48		; $26d0
	ld a,(de)		; $26d2
	sra a			; $26d3
_label_00_292:
	ld hl,$26e3		; $26d5
	rst_addAToHl			; $26d8
	call objectGetShortPosition		; $26d9
	add (hl)		; $26dc
	ld h,$ce		; $26dd
	ld l,a			; $26df
	ld a,(hl)		; $26e0
	or a			; $26e1
	ret			; $26e2
	ld a,($ff00+$01)	; $26e3
	stop			; $26e5
	rst $38			; $26e6

objectOscillateZ:
	ldh a,(<hRomBank)	; $26e7
	push af			; $26e9
	ld a,$08		; $26ea
	ldh (<hRomBank),a	; $26ec
	ld ($2222),a		; $26ee
	call $50f6		; $26f1
	pop af			; $26f4
	ldh (<hRomBank),a	; $26f5
	ld ($2222),a		; $26f7
	ret			; $26fa

giveRingToLink:
	call createRingTreasure		; $26fb
	ret nz			; $26fe
	push de			; $26ff
	ld de,$d00b		; $2700
	call objectCopyPosition_rawAddress		; $2703
	pop de			; $2706
	xor a			; $2707
	ret			; $2708

createRingTreasure:
	call getFreeInteractionSlot		; $2709
	ret nz			; $270c
	ld (hl),$60		; $270d
	inc l			; $270f
	ld (hl),$2d		; $2710
	inc l			; $2712
	ld (hl),c		; $2713
	ld l,$78		; $2714
	set 6,b			; $2716
	ld (hl),b		; $2718
	xor a			; $2719
	ret			; $271a

createTreasure:
	call getFreeInteractionSlot		; $271b
	ret nz			; $271e
	ld (hl),$60		; $271f
	inc l			; $2721
	ld (hl),b		; $2722
	inc l			; $2723
	ld (hl),c		; $2724
	xor a			; $2725
	ret			; $2726

objectCreateExclamationMark:
	ldh (<hFF8B),a	; $2727
	ldh a,(<hRomBank)	; $2729
	push af			; $272b
	ld a,$0a		; $272c
	ldh (<hRomBank),a	; $272e
	ld ($2222),a		; $2730
	ldh a,(<hFF8B)	; $2733
	call $4315		; $2735
	pop af			; $2738
	ldh (<hRomBank),a	; $2739
	ld ($2222),a		; $273b
	ret			; $273e

objectCreateFloatingSnore:
	ldh (<hFF8B),a	; $273f
	ld a,$00		; $2741
	jr _label_00_293		; $2743

objectCreateFloatingMusicNote:
	ldh (<hFF8B),a	; $2745
	ld a,$01		; $2747
_label_00_293:
	ldh (<hFF8D),a	; $2749
	ldh a,(<hRomBank)	; $274b
	push af			; $274d
	ld a,$0a		; $274e
	ldh (<hRomBank),a	; $2750
	ld ($2222),a		; $2752
	call $432d		; $2755
	pop af			; $2758
	ldh (<hRomBank),a	; $2759
	ld ($2222),a		; $275b
	ret			; $275e

enemyAnimate:
	ld h,d			; $275f
	ld l,$a0		; $2760
	dec (hl)		; $2762
	ret nz			; $2763
	ldh a,(<hRomBank)	; $2764
	push af			; $2766
	ld a,$0c		; $2767
	ldh (<hRomBank),a	; $2769
	ld ($2222),a		; $276b
	ld l,$a2		; $276e
	jr _label_00_294		; $2770

enemySetAnimation:
	add a			; $2772
	ld c,a			; $2773
	ld b,$00		; $2774
	ldh a,(<hRomBank)	; $2776
	push af			; $2778
	ld a,$0c		; $2779
	ldh (<hRomBank),a	; $277b
	ld ($2222),a		; $277d
	ld e,$81		; $2780
	ld a,(de)		; $2782
	ld hl,$6df7		; $2783
	rst_addDoubleIndex			; $2786
	ldi a,(hl)		; $2787
	ld h,(hl)		; $2788
	ld l,a			; $2789
	add hl,bc		; $278a
_label_00_294:

_enemyNextAnimationFrame:
	ldi a,(hl)		; $278b
	ld h,(hl)		; $278c
	ld l,a			; $278d
	ldi a,(hl)		; $278e
	cp $ff			; $278f
	jr nz,_label_00_295	; $2791
	ld b,a			; $2793
	ld c,(hl)		; $2794
	add hl,bc		; $2795
	ldi a,(hl)		; $2796
_label_00_295:
	ld e,$a0		; $2797
	ld (de),a		; $2799
	ldi a,(hl)		; $279a
	ld c,a			; $279b
	ld b,$00		; $279c
	inc e			; $279e
	ldi a,(hl)		; $279f
	ld (de),a		; $27a0
	inc e			; $27a1
	ld a,l			; $27a2
	ld (de),a		; $27a3
	inc e			; $27a4
	ld a,h			; $27a5
	ld (de),a		; $27a6
	ld e,$81		; $27a7
	ld a,(de)		; $27a9
	ld hl,$6ef7		; $27aa
	rst_addDoubleIndex			; $27ad
	ldi a,(hl)		; $27ae
	ld h,(hl)		; $27af
	ld l,a			; $27b0
	add hl,bc		; $27b1
	ld e,$9e		; $27b2
	ldi a,(hl)		; $27b4
	ld (de),a		; $27b5
	inc e			; $27b6
	ldi a,(hl)		; $27b7
	and $3f			; $27b8
	ld (de),a		; $27ba
	pop af			; $27bb
	ldh (<hRomBank),a	; $27bc
	ld ($2222),a		; $27be
	ret			; $27c1

enemyDie_uncounted_withoutItemDrop:
	ld b,$80		; $27c2
	jr _label_00_296		; $27c4

enemyDie_withoutItemDrop:
	ld b,$81		; $27c6
	jr _label_00_296		; $27c8

enemyDie_uncounted:
	ld b,$00		; $27ca
	jr _label_00_296		; $27cc

enemyDie:
	ld b,$01		; $27ce
_label_00_296:
	call $281a		; $27d0
	bit 0,b			; $27d3
	call nz,markEnemyAsKilledInRoom		; $27d5
	ld a,$00		; $27d8
	call checkGlobalFlag		; $27da
	jr nz,_label_00_297	; $27dd
	ld l,$20		; $27df
	call incHlRef16WithCap		; $27e1
	ldi a,(hl)		; $27e4
	ld h,(hl)		; $27e5
	ld l,a			; $27e6
	ld bc,$03e8		; $27e7
	call compareHlToBc		; $27ea
	rlca			; $27ed
	ld a,$00		; $27ee
	call nc,setGlobalFlag		; $27f0
_label_00_297:
	ld hl,$c63e		; $27f3
	call incHlRefWithCap		; $27f6
	ld a,$3a		; $27f9
	call cpActiveRing		; $27fb
	ld a,$ff		; $27fe
	jr z,_label_00_298	; $2800
	xor a			; $2802
_label_00_298:
	ld l,$4c		; $2803
	ld c,$10		; $2805
_label_00_299:
	rlca			; $2807
	call c,incHlRefWithCap		; $2808
	call incHlRefWithCap		; $280b
	inc l			; $280e
	dec c			; $280f
	jr nz,_label_00_299	; $2810
	ld a,$03		; $2812
	call addToGashaMaturity		; $2814
	jp enemyDelete		; $2817
	ld e,$bf		; $281a
	ld a,(de)		; $281c
	rlca			; $281d
	jp c,decNumEnemies		; $281e
	call getFreePartSlot		; $2821
	ret nz			; $2824
	ld e,$80		; $2825
	ld a,(de)		; $2827
	and $03			; $2828
	dec l			; $282a
	ldi (hl),a		; $282b
	ld (hl),$02		; $282c
	inc l			; $282e
	ld e,$81		; $282f
	ld a,(de)		; $2831
	ld (hl),a		; $2832
	ld l,$ed		; $2833
	ld e,$ad		; $2835
	ld a,(de)		; $2837
	ld (hl),a		; $2838
	call objectCopyPosition		; $2839
	ld l,$c7		; $283c
	ld (hl),b		; $283e
	ld a,$73		; $283f
	jp playSound		; $2841

enemyFunc28fd:
	ld h,d			; $2844
	ld l,$84		; $2845
	ld a,(hl)		; $2847
	or a			; $2848
	jr z,_label_00_301	; $2849
	ld l,$aa		; $284b
	bit 7,(hl)		; $284d
	jr nz,_label_00_302	; $284f
	ld e,$ad		; $2851
	ld a,(de)		; $2853
	and $7f			; $2854
	jr nz,_label_00_303	; $2856
	dec l			; $2858
	ld a,(hl)		; $2859
	or a			; $285a
	jr z,_label_00_304	; $285b
	inc e			; $285d
	ld a,(de)		; $285e
	or a			; $285f
	jr nz,_label_00_305	; $2860
_label_00_300:
	ld c,$00		; $2862
	ret			; $2864
_label_00_301:
	ld hl,$4368		; $2865
	ld e,$3f		; $2868
	call interBankCall		; $286a
	call getRandomNumber_noPreserveVars		; $286d
	ld e,$bd		; $2870
	ld (de),a		; $2872
	inc e			; $2873
	ld a,$01		; $2874
	ld (de),a		; $2876
	jr _label_00_300		; $2877
_label_00_302:
	ld c,$04		; $2879
	ret			; $287b
_label_00_303:
	ld l,e			; $287c
	dec (hl)		; $287d
	ld c,$05		; $287e
	ret			; $2880
_label_00_304:
	ld l,$bf		; $2881
	bit 1,(hl)		; $2883
	jr nz,_label_00_300	; $2885
	ld c,$03		; $2887
	ret			; $2889
_label_00_305:
	ld a,(wFrameCounter)		; $288a
	rrca			; $288d
	jr nc,_label_00_306	; $288e
	ld l,e			; $2890
	dec (hl)		; $2891
	ld a,(hl)		; $2892
	cp $1e			; $2893
	jr nc,_label_00_306	; $2895
	rrca			; $2897
	jr nc,_label_00_306	; $2898
	ld l,$8d		; $289a
	ld a,(hl)		; $289c
	xor $01			; $289d
	ld (hl),a		; $289f
_label_00_306:
	ld l,$84		; $28a0
	ld a,(hl)		; $28a2
	cp $08			; $28a3
	jr c,_label_00_307	; $28a5
	ld l,$8f		; $28a7
	ld a,(hl)		; $28a9
	dec a			; $28aa
	cp $08			; $28ab
	jr c,_label_00_307	; $28ad
	ld c,$20		; $28af
	call objectUpdateSpeedZAndBounce		; $28b1
	jr nc,_label_00_308	; $28b4
	ld h,d			; $28b6
_label_00_307:
	ld l,$94		; $28b7
	xor a			; $28b9
	ldi (hl),a		; $28ba
	ld (hl),a		; $28bb
_label_00_308:
	ld c,$02		; $28bc
	ret			; $28be

partUpdateAnimCounter:
	ld h,d			; $28bf
	ld l,$e0		; $28c0
	dec (hl)		; $28c2
	ret nz			; $28c3
	ld a,$15		; $28c4
	ldh (<hRomBank),a	; $28c6
	ld ($2222),a		; $28c8
	ld l,$e2		; $28cb
	jr _label_00_309		; $28cd

partSetAnimation:
	add a			; $28cf
	ld c,a			; $28d0
	ld b,$00		; $28d1
	ld a,$15		; $28d3
	ldh (<hRomBank),a	; $28d5
	ld ($2222),a		; $28d7
	ld e,$c1		; $28da
	ld a,(de)		; $28dc
	ld hl,$718f		; $28dd
	rst_addDoubleIndex			; $28e0
	ldi a,(hl)		; $28e1
	ld h,(hl)		; $28e2
	ld l,a			; $28e3
	add hl,bc		; $28e4
_label_00_309:

_partNextAnimationFrame:
	ldi a,(hl)		; $28e5
	ld h,(hl)		; $28e6
	ld l,a			; $28e7
	ldi a,(hl)		; $28e8
	cp $ff			; $28e9
	jr nz,_label_00_310	; $28eb
	ld b,a			; $28ed
	ld c,(hl)		; $28ee
	add hl,bc		; $28ef
	ldi a,(hl)		; $28f0
_label_00_310:
	ld e,$e0		; $28f1
	ld (de),a		; $28f3
	ldi a,(hl)		; $28f4
	ld c,a			; $28f5
	ld b,$00		; $28f6
	inc e			; $28f8
	ldi a,(hl)		; $28f9
	ld (de),a		; $28fa
	inc e			; $28fb
	ld a,l			; $28fc
	ld (de),a		; $28fd
	inc e			; $28fe
	ld a,h			; $28ff
	ld (de),a		; $2900
	ld e,$c1		; $2901
	ld a,(de)		; $2903
	ld hl,$7237		; $2904
	rst_addDoubleIndex			; $2907
	ldi a,(hl)		; $2908
	ld h,(hl)		; $2909
	ld l,a			; $290a
	add hl,bc		; $290b
	ld e,$de		; $290c
	ldi a,(hl)		; $290e
	ld (de),a		; $290f
	inc e			; $2910
	ldi a,(hl)		; $2911
	and $3f			; $2912
	or $40			; $2914
	ld (de),a		; $2916
	ld a,$10		; $2917
	ldh (<hRomBank),a	; $2919
	ld ($2222),a		; $291b
	ret			; $291e

createEnergySwirlGoingIn:
	ld l,a			; $291f
	ldh a,(<hRomBank)	; $2920
	push af			; $2922
	ld a,$10		; $2923
	ldh (<hRomBank),a	; $2925
	ld ($2222),a		; $2927
	call $5e5a		; $292a
	pop af			; $292d
	ldh (<hRomBank),a	; $292e
	ld ($2222),a		; $2930
	ret			; $2933

createEnergySwirlGoingOut:
	ld l,a			; $2934
	ldh a,(<hRomBank)	; $2935
	push af			; $2937
	ld a,$10		; $2938
	ldh (<hRomBank),a	; $293a
	ld ($2222),a		; $293c
	call $5e56		; $293f
	pop af			; $2942
	ldh (<hRomBank),a	; $2943
	ld ($2222),a		; $2945
	ret			; $2948

convertLinkAngleToDirectionButtons:
	ld a,($cc47)		; $2949
	add a			; $294c
	jr c,_label_00_311	; $294d
	add a			; $294f
	swap a			; $2950
	push hl			; $2952
	ld hl,$295c		; $2953
	rst_addAToHl			; $2956
	ld a,(hl)		; $2957
	pop hl			; $2958
	ret			; $2959
_label_00_311:
	xor a			; $295a
	ret			; $295b
	ld b,b			; $295c
	ld d,b			; $295d
	stop			; $295e
	sub b			; $295f
	add b			; $2960
	and b			; $2961
	jr nz,_label_00_315	; $2962

setSimulatedInputAddress:
	ld de,$cbc6		; $2964
	ld (de),a		; $2967
	inc e			; $2968
	ld a,l			; $2969
	ld (de),a		; $296a
	inc e			; $296b
	ld a,h			; $296c
	ld (de),a		; $296d
	ld e,$c5		; $296e
	xor a			; $2970
	ld (de),a		; $2971
	dec e			; $2972
	ld (de),a		; $2973
	dec e			; $2974
	inc a			; $2975
	ld (de),a		; $2976
	jp clearPegasusSeedCounter		; $2977

getSimulatedInput:
	ld a,($c4ab)		; $297a
	or a			; $297d
	ret nz			; $297e
	ld a,($cbc3)		; $297f
	rlca			; $2982
	jr c,_label_00_314	; $2983
	ld hl,$cbc4		; $2985
	call decHlRef16WithCap		; $2988
	jr nz,_label_00_314	; $298b
	ldh a,(<hRomBank)	; $298d
	push af			; $298f
	ld hl,$cbc6		; $2990
	ldi a,(hl)		; $2993
	ldh (<hRomBank),a	; $2994
	ld ($2222),a		; $2996
	ldi a,(hl)		; $2999
	ld h,(hl)		; $299a
	ld l,a			; $299b
	ldi a,(hl)		; $299c
	ld ($cbc4),a		; $299d
	ldi a,(hl)		; $29a0
	ld ($cbc5),a		; $29a1
	bit 7,a			; $29a4
	jr z,_label_00_312	; $29a6
	ld a,$ff		; $29a8
	ld ($cbc3),a		; $29aa
	jr _label_00_313		; $29ad
_label_00_312:
	ldi a,(hl)		; $29af
	ld ($cbc9),a		; $29b0
_label_00_313:
	pop af			; $29b3
	ldh (<hRomBank),a	; $29b4
	ld ($2222),a		; $29b6
	ld a,l			; $29b9
	ld ($cbc7),a		; $29ba
	ld a,h			; $29bd
	ld ($cbc8),a		; $29be
_label_00_314:
	ld a,($cbc9)		; $29c1
_label_00_315:
	ret			; $29c4

itemSetState:
	ld h,d			; $29c5
	ld l,$04		; $29c6
	ldi (hl),a		; $29c8
	ld (hl),$00		; $29c9
	ret			; $29cb

clearPegasusSeedCounter:
	ld hl,$cc86		; $29cc
	xor a			; $29cf
	ldi (hl),a		; $29d0
	ld (hl),a		; $29d1
	ret			; $29d2

putLinkOnGround:
	ld a,($cc48)		; $29d3
	rrca			; $29d6
	ret c			; $29d7
	push de			; $29d8
	xor a			; $29d9
	ld ($cc77),a		; $29da
	ld hl,$d014		; $29dd
	ldi (hl),a		; $29e0
	ldi (hl),a		; $29e1
	ld l,$0e		; $29e2
	ldi (hl),a		; $29e4
	ldi (hl),a		; $29e5
	ld l,$01		; $29e6
	ld a,(hl)		; $29e8
	or a			; $29e9
	jr nz,_label_00_316	; $29ea
	ld d,h			; $29ec
	ld a,$10		; $29ed
	call specialObjectSetAnimation		; $29ef
_label_00_316:
	pop de			; $29f2
	ret			; $29f3

setLinkForceStateToState08:
	xor a			; $29f4

setLinkForceStateToState08_withParam:
	push hl			; $29f5
	ld hl,$cc6b		; $29f6
	ldd (hl),a		; $29f9
	ld (hl),$08		; $29fa
	pop hl			; $29fc
	ret			; $29fd

linkApplyDamage:
	push de			; $29fe
	ldh a,(<hRomBank)	; $29ff
	push af			; $2a01
	ld d,$d0		; $2a02
	ld a,$05		; $2a04
	ldh (<hRomBank),a	; $2a06
	ld ($2222),a		; $2a08
	call $422e		; $2a0b
	pop af			; $2a0e
	ldh (<hRomBank),a	; $2a0f
	ld ($2222),a		; $2a11
	pop de			; $2a14
	ret			; $2a15

setLinkIDOverride:
	or $80			; $2a16
	ld ($cc72),a		; $2a18
	ld hl,$d002		; $2a1b
	jr _label_00_317		; $2a1e

setLinkID:
	ld hl,$d001		; $2a20
	ldi (hl),a		; $2a23
_label_00_317:
	xor a			; $2a24
	ldi (hl),a		; $2a25
	ldi (hl),a		; $2a26
	ldi (hl),a		; $2a27
	ldi (hl),a		; $2a28
	ret			; $2a29

respawnLink:
	ld a,$02		; $2a2a
	ld ($cc6a),a		; $2a2c
	ld a,$02		; $2a2f
	ld ($cc6c),a		; $2a31
	or d			; $2a34
	ret			; $2a35

specialObjectAnimate:
	ld h,d			; $2a36
	ld l,$20		; $2a37
	dec (hl)		; $2a39
	ret nz			; $2a3a
	ldh a,(<hRomBank)	; $2a3b
	push af			; $2a3d
	ld a,$06		; $2a3e
	ldh (<hRomBank),a	; $2a40
	ld ($2222),a		; $2a42
	ld l,$22		; $2a45
	call $4428		; $2a47
	pop af			; $2a4a
	ldh (<hRomBank),a	; $2a4b
	ld ($2222),a		; $2a4d
	ret			; $2a50

specialObjectSetAnimation:
	ld e,$30		; $2a51
	ld (de),a		; $2a53
	add a			; $2a54
	ld c,a			; $2a55
	ld b,$00		; $2a56
	ldh a,(<hRomBank)	; $2a58
	push af			; $2a5a
	ld a,$06		; $2a5b
	ldh (<hRomBank),a	; $2a5d
	ld ($2222),a		; $2a5f
	call $441d		; $2a62
	pop af			; $2a65
	ldh (<hRomBank),a	; $2a66
	ld ($2222),a		; $2a68
	ret			; $2a6b

loadLinkAndCompanionAnimationFrame:
	ldh a,(<hRomBank)	; $2a6c
	push af			; $2a6e
	ld a,$06		; $2a6f
	ldh (<hRomBank),a	; $2a71
	ld ($2222),a		; $2a73
	call $44bf		; $2a76
	pop af			; $2a79
	ldh (<hRomBank),a	; $2a7a
	ld ($2222),a		; $2a7c
	ret			; $2a7f

checkLinkPushingAgainstWall:
	push hl			; $2a80
	ld a,($d008)		; $2a81
	ld hl,$2a9c		; $2a84
	rst_addDoubleIndex			; $2a87
	ld a,($d033)		; $2a88
	and (hl)		; $2a8b
	cp (hl)			; $2a8c
	jr nz,_label_00_318	; $2a8d
	inc hl			; $2a8f
	ld a,($cc45)		; $2a90
	and (hl)		; $2a93
	jr z,_label_00_318	; $2a94
	pop hl			; $2a96
	scf			; $2a97
	ret			; $2a98
_label_00_318:
	pop hl			; $2a99
	xor a			; $2a9a
	ret			; $2a9b

	.db $c0 $40 $03 $10 $30 $80 $0c $20

updateCompanionDirectionFromAngle:
	.db $c5			; $2aa4
	push hl			; $2aa5
	ld hl,$d108		; $2aa6
	jr _label_00_319		; $2aa9

updateLinkDirectionFromAngle:
	push bc			; $2aab
	push hl			; $2aac
	ld hl,$d008		; $2aad
_label_00_319:
	ld b,(hl)		; $2ab0
	ld a,($cc47)		; $2ab1
	cp $ff			; $2ab4
	jr z,_label_00_321	; $2ab6
	and $1c			; $2ab8
	rrca			; $2aba
	rrca			; $2abb
	rra			; $2abc
	jr nc,_label_00_320	; $2abd
	ld c,a			; $2abf
	sub b			; $2ac0
	inc a			; $2ac1
	and $02			; $2ac2
	jr z,_label_00_321	; $2ac4
	ld a,c			; $2ac6
_label_00_320:
	cp (hl)			; $2ac7
	jr z,_label_00_321	; $2ac8
	ld (hl),a		; $2aca
	ld b,a			; $2acb
	scf			; $2acc
_label_00_321:
	ld a,b			; $2acd
	pop hl			; $2ace
	pop bc			; $2acf
	ret			; $2ad0

specialObjectSetCoordinatesToRespawnYX:
	ld h,d			; $2ad1
	ld l,$08		; $2ad2
	ld a,($cc3f)		; $2ad4
	ldi (hl),a		; $2ad7
	ld a,$ff		; $2ad8
	ldi (hl),a		; $2ada
	ld ($ccfc),a		; $2adb
	ld l,$0b		; $2ade
	ld a,($cc3d)		; $2ae0
	ldi (hl),a		; $2ae3
	inc l			; $2ae4
	ld a,($cc3e)		; $2ae5
	ldi (hl),a		; $2ae8
	xor a			; $2ae9
	ldi (hl),a		; $2aea
	ldi (hl),a		; $2aeb
	ld l,$2d		; $2aec
	ld (hl),a		; $2aee
	ret			; $2aef

resetLinkInvincibility:
	ld hl,$d01b		; $2af0
	ldi a,(hl)		; $2af3
	ld (hl),a		; $2af4
	ld l,$24		; $2af5
	xor a			; $2af7
	ldi (hl),a		; $2af8
	ldi (hl),a		; $2af9
	ld l,$28		; $2afa
	ldi (hl),a		; $2afc
	inc l			; $2afd
	ldi (hl),a		; $2afe
	ldi (hl),a		; $2aff
	ldi (hl),a		; $2b00
	ldi (hl),a		; $2b01
	ldi (hl),a		; $2b02
	ret			; $2b03

decPegasusSeedCounter:
	ld hl,$cc87		; $2b04
	res 7,(hl)		; $2b07
	dec l			; $2b09
	ld b,$00		; $2b0a
	ld c,$07		; $2b0c
	ld a,$11		; $2b0e
	call cpActiveRing		; $2b10
	jr z,_label_00_322	; $2b13
	ld c,$0f		; $2b15
	call decHlRef16WithCap		; $2b17
	ret z			; $2b1a
	ld a,(hl)		; $2b1b
	and c			; $2b1c
	jr nz,_label_00_322	; $2b1d
	ld b,$80		; $2b1f
_label_00_322:
	call decHlRef16WithCap		; $2b21
	ret z			; $2b24
	ldi a,(hl)		; $2b25
	and c			; $2b26
	jr nz,_label_00_323	; $2b27
	ld b,$80		; $2b29
_label_00_323:
	ld a,(hl)		; $2b2b
	or b			; $2b2c
	ldd (hl),a		; $2b2d
	ret			; $2b2e

checkPegasusSeedCounter:
	ld hl,$cc86		; $2b2f
	ldi a,(hl)		; $2b32
	or (hl)			; $2b33
	ldd a,(hl)		; $2b34
	ret			; $2b35

itemTryToBreakTile:
	ld h,d			; $2b36
	ld l,$0b		; $2b37
	ld b,(hl)		; $2b39
	ld l,$0d		; $2b3a
	ld c,(hl)		; $2b3c

tryToBreakTile:
	ldh (<hFF8F),a	; $2b3d
	ldh a,(<hRomBank)	; $2b3f
	push af			; $2b41
	ld a,$06		; $2b42
	ldh (<hRomBank),a	; $2b44
	ld ($2222),a		; $2b46
	call $4713		; $2b49
	rl e			; $2b4c
	pop af			; $2b4e
	ldh (<hRomBank),a	; $2b4f
	ld ($2222),a		; $2b51
	rr e			; $2b54
	ret			; $2b56

clearAllParentItems:
	ld c,$00		; $2b57
	jr _label_00_324		; $2b59

updateParentItemButtonAssignment:
	ld c,$01		; $2b5b
	jr _label_00_324		; $2b5d

checkUseItems:
	ld c,$02		; $2b5f
_label_00_324:
	ldh a,(<hRomBank)	; $2b61
	push af			; $2b63
	ld a,:b6_checkUseItems		; $2b64
	ldh (<hRomBank),a	; $2b66
	ld ($2222),a		; $2b68
	call $4822		; $2b6b
	pop af			; $2b6e
	ldh (<hRomBank),a	; $2b6f
	ld ($2222),a		; $2b71
	ret			; $2b74

objectAddToGrabbableObjectBuffer:
	ld hl,$cc8e		; $2b75
_label_00_325:
	inc l			; $2b78
	bit 7,(hl)		; $2b79
	jr z,_label_00_326	; $2b7b
	inc l			; $2b7d
	ld a,l			; $2b7e
	cp $9e			; $2b7f
	jr c,_label_00_325	; $2b81
	ret			; $2b83
_label_00_326:
	ld a,d			; $2b84
	ldd (hl),a		; $2b85
	ldh a,(<hActiveObjectType)	; $2b86
	ld (hl),a		; $2b88
	ret			; $2b89

dropLinkHeldItem:
	ld a,($ccea)		; $2b8a
	or a			; $2b8d
	jr nz,_label_00_327	; $2b8e
	ld a,($cc75)		; $2b90
	and $07			; $2b93
	sub $02			; $2b95
	cp $02			; $2b97
	jr nc,_label_00_327	; $2b99
	ld hl,$d018		; $2b9b
	ldi a,(hl)		; $2b9e
	ld h,(hl)		; $2b9f
	add $04			; $2ba0
	ld l,a			; $2ba2
	ldi a,(hl)		; $2ba3
	cp $02			; $2ba4
	jr nz,_label_00_327	; $2ba6
	ld a,$03		; $2ba8
	ld (hl),a		; $2baa
	ld a,l			; $2bab
	add $04			; $2bac
	ld l,a			; $2bae
	ld (hl),$ff		; $2baf
_label_00_327:
	xor a			; $2bb1
	ld ($cc75),a		; $2bb2
	ld (wLinkGrabState2),a		; $2bb5
	ret			; $2bb8

clearVar3fForParentItems:
	ld hl,$d23f		; $2bb9
_label_00_328:
	ld (hl),$00		; $2bbc
	inc h			; $2bbe
	ld a,h			; $2bbf
	cp $d6			; $2bc0
	jr c,_label_00_328	; $2bc2
	ret			; $2bc4

linkCreateSplash:
	ld b,$03		; $2bc5
	ld a,($cc78)		; $2bc7
	bit 6,a			; $2bca
	jr z,_label_00_329	; $2bcc
	inc b			; $2bce
_label_00_329:
	ld a,($cc50)		; $2bcf
	and $20			; $2bd2
	jp z,objectCreateInteractionWithSubid00		; $2bd4
	call getFreeInteractionSlot		; $2bd7
	ret nz			; $2bda
	ld (hl),b		; $2bdb
	ld bc,$fd00		; $2bdc
	jp objectCopyPositionWithOffset		; $2bdf

clearVariousLinkVariables:
	xor a			; $2be2
	ld ($d036),a		; $2be3
	ld ($d010),a		; $2be6
	ld ($d03e),a		; $2be9
	ld ($d012),a		; $2bec
	dec a			; $2bef
	ld ($d009),a		; $2bf0
	ret			; $2bf3

linkState07:
	ld e,$05		; $2bf4
	ld a,(de)		; $2bf6
	rst_jumpTable			; $2bf7
	cp $2b			; $2bf8
	ld (hl),$2a		; $2bfa
	dec d			; $2bfc
	inc l			; $2bfd
	call $4ded		; $2bfe
	call itemIncState2		; $2c01
	xor a			; $2c04
	ld l,$24		; $2c05
	ld (hl),a		; $2c07
	call clearVariousLinkVariables		; $2c08
	ld a,$80		; $2c0b
	ld ($cc77),a		; $2c0d
	ld a,$03		; $2c10
	jp specialObjectSetAnimation		; $2c12
	xor a			; $2c15
	ld ($cc77),a		; $2c16
	ld a,$05		; $2c19
	ld ($cc65),a		; $2c1b
	ld e,$0b		; $2c1e
	ld a,(de)		; $2c20
	add $04			; $2c21
	ld (de),a		; $2c23
	ld a,$0a		; $2c24
	jp $5471		; $2c26

itemDelete:
	ld h,d			; $2c29
	ld l,$00		; $2c2a
	ld b,$10		; $2c2c
	xor a			; $2c2e
_label_00_330:
	ldi (hl),a		; $2c2f
	ldi (hl),a		; $2c30
	ldi (hl),a		; $2c31
	ldi (hl),a		; $2c32
	dec b			; $2c33
	jr nz,_label_00_330	; $2c34
	ret			; $2c36

itemUpdateAngle:
	ld h,d			; $2c37
	ld l,$08		; $2c38
	ldi a,(hl)		; $2c3a
	swap a			; $2c3b
	rrca			; $2c3d
	ldd (hl),a		; $2c3e
	ret			; $2c3f

getFreeItemSlot:
	ld hl,$d700		; $2c40
_label_00_331:
	ld a,(hl)		; $2c43
	or a			; $2c44
	ret z			; $2c45
	inc h			; $2c46
	ld a,h			; $2c47
	cp $dc			; $2c48
	jr c,_label_00_331	; $2c4a
	or h			; $2c4c
	ret			; $2c4d
_label_00_332:

introThreadStart:
	ld hl,$cbb7		; $2c4e
	inc (hl)		; $2c51
	ld a,$03		; $2c52
	ldh (<hRomBank),a	; $2c54
	ld ($2222),a		; $2c56
	call $4cc9		; $2c59
	call resumeThreadNextFrame		; $2c5c
	jr _label_00_332		; $2c5f

intro_cinematic:
	ldh a,(<hRomBank)	; $2c61
	push af			; $2c63
	ld a,$03		; $2c64
	ldh (<hRomBank),a	; $2c66
	ld ($2222),a		; $2c68
	call $4e8e		; $2c6b
	ld a,$05		; $2c6e
	ldh (<hRomBank),a	; $2c70
	ld ($2222),a		; $2c72
	call $4000		; $2c75
	call loadLinkAndCompanionAnimationFrame		; $2c78
	ld a,$04		; $2c7b
	ldh (<hRomBank),a	; $2c7d
	ld ($2222),a		; $2c7f
	call $575e		; $2c82
	call updateInteractionsAndDrawAllSprites		; $2c85
	pop af			; $2c88
	ldh (<hRomBank),a	; $2c89
	ld ($2222),a		; $2c8b
	ret			; $2c8e

func_2d48:
	ldh a,(<hRomBank)	; $2c8f
	push af			; $2c91
	ld a,$03		; $2c92
	ldh (<hRomBank),a	; $2c94
	ld ($2222),a		; $2c96
	ld a,b			; $2c99
	ld hl,$54e0		; $2c9a
	rst_addAToHl			; $2c9d
	ld b,(hl)		; $2c9e
	pop af			; $2c9f
	ldh (<hRomBank),a	; $2ca0
	ld ($2222),a		; $2ca2
	ret			; $2ca5

clearFadingPalettes:
	ldh a,(<hRomBank)	; $2ca6
	push af			; $2ca8
	ld a,$03		; $2ca9
	ldh (<hRomBank),a	; $2cab
	ld ($2222),a		; $2cad
	call $51e0		; $2cb0
	pop af			; $2cb3
	ldh (<hRomBank),a	; $2cb4
	ld ($2222),a		; $2cb6
	ret			; $2cb9

func_2d73:
	ldh a,(<hRomBank)	; $2cba
	push af			; $2cbc
	ld a,$03		; $2cbd
	ldh (<hRomBank),a	; $2cbf
	ld ($2222),a		; $2cc1
	call $51b4		; $2cc4
	ld b,$01		; $2cc7
	jr nz,_label_00_333	; $2cc9
	dec b			; $2ccb
_label_00_333:
	pop af			; $2ccc
	ldh (<hRomBank),a	; $2ccd
	ld ($2222),a		; $2ccf
	ld a,b			; $2cd2
	or a			; $2cd3
	ret			; $2cd4

specialObjectCode_companionCutscene:
	ldh a,(<hRomBank)	; $2cd5
	push af			; $2cd7
	ld a,$06		; $2cd8
	ldh (<hRomBank),a	; $2cda
	ld ($2222),a		; $2cdc
	call $69c9		; $2cdf
	pop af			; $2ce2
	ldh (<hRomBank),a	; $2ce3
	ld ($2222),a		; $2ce5
	ret			; $2ce8

specialObjectCode_linkInCutscene:
	ldh a,(<hRomBank)	; $2ce9
	push af			; $2ceb
	ld a,$06		; $2cec
	ldh (<hRomBank),a	; $2cee
	ld ($2222),a		; $2cf0
	call $6dec		; $2cf3
	pop af			; $2cf6
	ldh (<hRomBank),a	; $2cf7
	ld ($2222),a		; $2cf9
	ret			; $2cfc

loadDungeonLayout:
	ld a,($cc50)		; $2cfd
	and $08			; $2d00
	ret z			; $2d02
	ldh a,(<hRomBank)	; $2d03
	push af			; $2d05
	ld a,$01		; $2d06
	ldh (<hRomBank),a	; $2d08
	ld ($2222),a		; $2d0a
	call $54c1		; $2d0d
	pop af			; $2d10
	ldh (<hRomBank),a	; $2d11
	ld ($2222),a		; $2d13
	ret			; $2d16

initializeDungeonStuff:
	xor a			; $2d17
	ld ($cc31),a		; $2d18
	ld ($cc32),a		; $2d1b
	ld ($cc33),a		; $2d1e
	jp loadStaticObjects		; $2d21

setVisitedRoomFlag:
	call getThisRoomFlags		; $2d24
	set 4,(hl)		; $2d27
	ret			; $2d29

getThisRoomDungeonProperties:
	ldh a,(<hRomBank)	; $2d2a
	push af			; $2d2c
	ld a,$01		; $2d2d
	ldh (<hRomBank),a	; $2d2f
	ld ($2222),a		; $2d31
	ld a,($cc49)		; $2d34
	sub $04			; $2d37
	and $01			; $2d39
	ld hl,$4d3d		; $2d3b
	rst_addDoubleIndex			; $2d3e
	ldi a,(hl)		; $2d3f
	ld h,(hl)		; $2d40
	ld l,a			; $2d41
	ld a,($cc4c)		; $2d42
	ld b,$00		; $2d45
	ld c,a			; $2d47
	add hl,bc		; $2d48
	ld a,(hl)		; $2d49
	ld ($cc58),a		; $2d4a
	pop af			; $2d4d
	ldh (<hRomBank),a	; $2d4e
	ld ($2222),a		; $2d50
	ret			; $2d53

getDungeonLayoutAddress:
	push bc			; $2d54
	push de			; $2d55
	ld a,($cc57)		; $2d56
	ld c,$40		; $2d59
	call multiplyAByC		; $2d5b
	ld bc,$dc00		; $2d5e
	add hl,bc		; $2d61
	pop de			; $2d62
	pop bc			; $2d63
	ret			; $2d64

getActiveRoomFromDungeonMapPosition:
	ld a,($cc56)		; $2d65

getRoomInDungeon:
	ldh (<hFF8B),a	; $2d68
	ld a,$02		; $2d6a
	ld ($ff00+$70),a	; $2d6c
	call getDungeonLayoutAddress		; $2d6e
	ldh a,(<hFF8B)	; $2d71
	rst_addAToHl			; $2d73
	ld l,(hl)		; $2d74
	xor a			; $2d75
	ld ($ff00+$70),a	; $2d76
	ld a,l			; $2d78
	ret			; $2d79

objectFunc_3035:
	ldh a,(<hRomBank)	; $2d7a
	push af			; $2d7c
	ld a,$0d		; $2d7d
	ldh (<hRomBank),a	; $2d7f
	ld ($2222),a		; $2d81
	call $798f		; $2d84
	pop af			; $2d87
	ldh (<hRomBank),a	; $2d88
	ld ($2222),a		; $2d8a
	ret			; $2d8d

objectFunc_3049:
	ldh a,(<hRomBank)	; $2d8e
	push af			; $2d90
	ld a,$0d		; $2d91
	ldh (<hRomBank),a	; $2d93
	ld ($2222),a		; $2d95
	call $79ae		; $2d98
	pop af			; $2d9b
	ldh (<hRomBank),a	; $2d9c
	ld ($2222),a		; $2d9e
	ret			; $2da1

decCbb3:
	ld hl,$cbb3		; $2da2
	dec (hl)		; $2da5
	ret			; $2da6

incCbc1:
	ld hl,$cbc1		; $2da7
	inc (hl)		; $2daa
	ret			; $2dab

incCbc2:
	ld hl,$cbc2		; $2dac
	inc (hl)		; $2daf
	ret			; $2db0

func_306c:
	ldh a,(<hRomBank)	; $2db1
	push af			; $2db3
	ld a,$03		; $2db4
	ldh (<hRomBank),a	; $2db6
	ld ($2222),a		; $2db8
	call $54ec		; $2dbb
	pop af			; $2dbe
	ldh (<hRomBank),a	; $2dbf
	ld ($2222),a		; $2dc1
	ret			; $2dc4

getEntryFromObjectTable1:
	ldh a,(<hRomBank)	; $2dc5
	push af			; $2dc7
	ld a,$11		; $2dc8
	ldh (<hRomBank),a	; $2dca
	ld ($2222),a		; $2dcc
	ld a,b			; $2dcf
	ld hl,$5744		; $2dd0
	rst_addDoubleIndex			; $2dd3
	ldi a,(hl)		; $2dd4
	ld h,(hl)		; $2dd5
	ld l,a			; $2dd6
	pop af			; $2dd7
	ldh (<hRomBank),a	; $2dd8
	ld ($2222),a		; $2dda
	ret			; $2ddd

fileSelect_redrawDecorations:
	ldh a,(<hRomBank)	; $2dde
	push af			; $2de0
	ld a,$02		; $2de1
	ldh (<hRomBank),a	; $2de3
	ld ($2222),a		; $2de5
	call $4c97		; $2de8
	pop af			; $2deb
	ldh (<hRomBank),a	; $2dec
	ld ($2222),a		; $2dee
	xor a			; $2df1
	ld ($ff00+$70),a	; $2df2
	ret			; $2df4

addSpritesFromBankToOam_withOffset:
	ldh a,(<hRomBank)	; $2df5
	push af			; $2df7
	ld a,e			; $2df8
	ldh (<hRomBank),a	; $2df9
	ld ($2222),a		; $2dfb
	call addSpritesToOam_withOffset		; $2dfe
	pop af			; $2e01
	ldh (<hRomBank),a	; $2e02
	ld ($2222),a		; $2e04
	ret			; $2e07

getFreeEnemySlot:
	call getFreeEnemySlot_uncounted		; $2e08
	ret nz			; $2e0b
	ld a,($cc30)		; $2e0c
	inc a			; $2e0f
	ld ($cc30),a		; $2e10
	xor a			; $2e13
	ret			; $2e14

getFreeEnemySlot_uncounted:
	ld hl,$d080		; $2e15
_label_00_334:
	ld a,(hl)		; $2e18
	or a			; $2e19
	jr z,_label_00_335	; $2e1a
	inc h			; $2e1c
	ld a,h			; $2e1d
	cp $e0			; $2e1e
	jr c,_label_00_334	; $2e20
	or h			; $2e22
	ret			; $2e23
_label_00_335:
	inc a			; $2e24
	ldi (hl),a		; $2e25
	xor a			; $2e26
	ret			; $2e27

enemyDelete:
	ld e,$80		; $2e28
	call objectRemoveFromAButtonSensitiveObjectList		; $2e2a
	ld l,e			; $2e2d
	ld h,d			; $2e2e
	ld b,$10		; $2e2f
	xor a			; $2e31
_label_00_336:
	ldi (hl),a		; $2e32
	ldi (hl),a		; $2e33
	ldi (hl),a		; $2e34
	ldi (hl),a		; $2e35
	dec b			; $2e36
	jr nz,_label_00_336	; $2e37
	ret			; $2e39

enemyReplaceWithID:
	ld h,d			; $2e3a
	push bc			; $2e3b
	ld l,$80		; $2e3c
	ld b,(hl)		; $2e3e
	ld l,$8b		; $2e3f
	ld c,(hl)		; $2e41
	push bc			; $2e42
	ld l,$8d		; $2e43
	ld b,(hl)		; $2e45
	ld l,$8f		; $2e46
	ld c,(hl)		; $2e48
	push bc			; $2e49
	call enemyDelete		; $2e4a
	pop bc			; $2e4d
	ld l,$8f		; $2e4e
	ld (hl),c		; $2e50
	ld l,$8d		; $2e51
	ld (hl),b		; $2e53
	pop bc			; $2e54
	ld l,$8b		; $2e55
	ld (hl),c		; $2e57
	ld l,$80		; $2e58
	ld a,b			; $2e5a
	and $73			; $2e5b
	ldi (hl),a		; $2e5d
	pop bc			; $2e5e
	ld (hl),b		; $2e5f
	inc l			; $2e60
	ld (hl),c		; $2e61
	ret			; $2e62
_label_00_337:

_updateEnemiesIfStateIsZero:
	ld a,$80		; $2e63
	ldh (<hActiveObjectType),a	; $2e65
	ld d,$d0		; $2e67
	ld a,d			; $2e69
_label_00_338:
	ldh (<hActiveObject),a	; $2e6a
	ld h,d			; $2e6c
	ld l,$80		; $2e6d
	ld a,(hl)		; $2e6f
	or a			; $2e70
	jr z,_label_00_339	; $2e71
	ld l,$84		; $2e73
	ldi a,(hl)		; $2e75
	or (hl)			; $2e76
	call z,updateEnemy		; $2e77
	ld e,$9b		; $2e7a
	ld a,(de)		; $2e7c
	inc e			; $2e7d
	ld (de),a		; $2e7e
_label_00_339:
	inc d			; $2e7f
	ld a,d			; $2e80
	cp $e0			; $2e81
	jr c,_label_00_338	; $2e83
	ret			; $2e85

updateEnemies:
	ld a,($cd00)		; $2e86
	and $0e			; $2e89
	jr nz,_label_00_337	; $2e8b
	ld a,($cba0)		; $2e8d
	or a			; $2e90
	jr nz,_label_00_337	; $2e91
	ld a,($cca4)		; $2e93
	and $84			; $2e96
	jr nz,_label_00_337	; $2e98
	ld a,($c4ab)		; $2e9a
	or a			; $2e9d
	jr nz,_label_00_337	; $2e9e
	ld a,$80		; $2ea0
	ldh (<hActiveObjectType),a	; $2ea2
	ld d,$d0		; $2ea4
	ld a,d			; $2ea6
_label_00_340:
	ldh (<hActiveObject),a	; $2ea7
	ld e,$80		; $2ea9
	ld a,(de)		; $2eab
	or a			; $2eac
	jr z,_label_00_344	; $2ead
	call updateEnemy		; $2eaf
	ld h,d			; $2eb2
	ld l,$aa		; $2eb3
	res 7,(hl)		; $2eb5
	inc l			; $2eb7
	ld a,(hl)		; $2eb8
	or a			; $2eb9
	jr z,_label_00_343	; $2eba
	rlca			; $2ebc
	jr c,_label_00_342	; $2ebd
	dec (hl)		; $2ebf
	jr z,_label_00_343	; $2ec0
	ld a,(wFrameCounter)		; $2ec2
	bit 2,a			; $2ec5
	jr nz,_label_00_343	; $2ec7
	ld b,$05		; $2ec9
	ld l,$9b		; $2ecb
	ldi a,(hl)		; $2ecd
	and $07			; $2ece
	cp b			; $2ed0
	jr nz,_label_00_341	; $2ed1
	ld b,$02		; $2ed3
_label_00_341:
	ld a,(hl)		; $2ed5
	and $f8			; $2ed6
	or b			; $2ed8
	ld (hl),a		; $2ed9
	jr _label_00_344		; $2eda
_label_00_342:
	inc (hl)		; $2edc
_label_00_343:
	ld l,$9b		; $2edd
	ldi a,(hl)		; $2edf
	ld (hl),a		; $2ee0
_label_00_344:
	inc d			; $2ee1
	ld a,d			; $2ee2
	cp $e0			; $2ee3
	jr c,_label_00_340	; $2ee5
	ret			; $2ee7

updateEnemy:
	call enemyFunc28fd		; $2ee8
	ld e,$81		; $2eeb
	ld a,(de)		; $2eed
	ld b,$0f		; $2eee
	cp $08			; $2ef0
	jr c,_label_00_345	; $2ef2
	dec b			; $2ef4
	cp $70			; $2ef5
	jr nc,_label_00_345	; $2ef7
	dec b			; $2ef9
	cp $30			; $2efa
	jr nc,_label_00_345	; $2efc
	dec b			; $2efe
_label_00_345:
	ld e,a			; $2eff
	ld a,b			; $2f00
	ldh (<hRomBank),a	; $2f01
	ld ($2222),a		; $2f03
	ld a,e			; $2f06
	add a			; $2f07
	add $16			; $2f08
	ld l,a			; $2f0a
	ld a,$00		; $2f0b
	adc $2f			; $2f0d
	ld h,a			; $2f0f
	ldi a,(hl)		; $2f10
	ld h,(hl)		; $2f11
	ld l,a			; $2f12
	ld a,c			; $2f13
	or a			; $2f14
	jp hl			; $2f15

enemyCodeTable:
	.dw enemyCode00
	.dw enemyCode01
	.dw enemyCode02
	.dw enemyCode03
	.dw enemyCode04
	.dw enemyCode05
	.dw enemyCode06
	.dw enemyCode07
	.dw enemyCode08
	.dw enemyCode09
	.dw enemyCode0a
	.dw enemyCode0b
	.dw enemyCode0c
	.dw enemyCode0d
	.dw enemyCode0e
	.dw enemyCode0f
	.dw enemyCode10
	.dw enemyCode11
	.dw enemyCode12
	.dw enemyCode13
	.dw enemyCode14
	.dw enemyCode15
	.dw enemyCode16
	.dw enemyCode17
	.dw enemyCode18
	.dw enemyCode19
	.dw enemyCode1a
	.dw enemyCode1b
	.dw enemyCode1c
	.dw enemyCode1d
	.dw enemyCode1e
	.dw enemyCodeNil
	.dw enemyCode20
	.dw enemyCode21
	.dw enemyCode22
	.dw enemyCode23
	.dw enemyCode24
	.dw enemyCode25
	.dw enemyCodeNil
	.dw enemyCode27
	.dw enemyCode28
	.dw enemyCode29
	.dw enemyCode2a
	.dw enemyCode2b
	.dw enemyCode2c
	.dw enemyCode2d
	.dw enemyCode2e
	.dw enemyCode2f
	.dw enemyCode30
	.dw enemyCode31
	.dw enemyCode32
	.dw enemyCode33
	.dw enemyCode34
	.dw enemyCode35
	.dw enemyCode36
	.dw enemyCode37
	.dw enemyCode38
	.dw enemyCode39
	.dw enemyCode3a
	.dw enemyCode3b
	.dw enemyCode3c
	.dw enemyCode3d
	.dw enemyCode3e
	.dw enemyCodeNil
	.dw enemyCode40
	.dw enemyCode41
	.dw enemyCodeNil
	.dw enemyCode43
	.dw enemyCodeNil
	.dw enemyCode45
	.dw enemyCode46
	.dw enemyCode47
	.dw enemyCode48
	.dw enemyCode49
	.dw enemyCode4a
	.dw enemyCode4b
	.dw enemyCode4c
	.dw enemyCode4d
	.dw enemyCode4e
	.dw enemyCode4f
	.dw enemyCode50
	.dw enemyCode51
	.dw enemyCode52
	.dw enemyCode53
	.dw enemyCode54
	.dw enemyCode55
	.dw enemyCode56
	.dw enemyCodeNil
	.dw enemyCode58
	.dw enemyCode59
	.dw enemyCode5a
	.dw enemyCode5b
	.dw enemyCode5c
	.dw enemyCode5d
	.dw enemyCode5e
	.dw enemyCode5f
	.dw enemyCode60
	.dw enemyCodeNil
	.dw enemyCodeNil
	.dw enemyCodeNil
	.dw enemyCodeNil
	.dw enemyCodeNil
	.dw enemyCodeNil
	.dw enemyCodeNil
	.dw enemyCodeNil
	.dw enemyCodeNil
	.dw enemyCodeNil
	.dw enemyCodeNil
	.dw enemyCodeNil
	.dw enemyCodeNil
	.dw enemyCodeNil
	.dw enemyCodeNil
	.dw enemyCode70
	.dw enemyCode71
	.dw enemyCode72
	.dw enemyCode73
	.dw enemyCode74
	.dw enemyCode75
	.dw enemyCode76
	.dw enemyCode77
	.dw enemyCode78
	.dw enemyCode79
	.dw enemyCode7a
	.dw enemyCode7b
	.dw enemyCode7c
	.dw enemyCode7d
	.dw enemyCode7e
	.dw enemyCode7f


enemyCodeNil:
	ret			; $3016


initializeRoom:
	call refreshObjectGfx		; $3017
	ldh a,(<hRomBank)	; $301a
	push af			; $301c
	ld a,$10		; $301d
	ldh (<hRomBank),a	; $301f
	ld ($2222),a		; $3021
	call $5ea0		; $3024
	call $5ed0		; $3027
	call $5f86		; $302a
	ld a,$11		; $302d
	ldh (<hRomBank),a	; $302f
	ld ($2222),a		; $3031
	call $58b5		; $3034
	ld a,$15		; $3037
	ldh (<hRomBank),a	; $3039
	ld ($2222),a		; $303b
	call $4e35		; $303e
	pop af			; $3041
	ldh (<hRomBank),a	; $3042
	ld ($2222),a		; $3044
	ret			; $3047

parseGivenObjectData:
	ldh a,(<hRomBank)	; $3048
	push af			; $304a
	ld a,$11		; $304b
	ldh (<hRomBank),a	; $304d
	ld ($2222),a		; $304f
	push de			; $3052
	ld d,h			; $3053
	ld e,l			; $3054
	call $58df		; $3055
	pop de			; $3058
	pop af			; $3059
	ldh (<hRomBank),a	; $305a
	ld ($2222),a		; $305c
	ret			; $305f

loadStaticObjects:
	ldh a,(<hRomBank)	; $3060
	push af			; $3062
	ld a,$15		; $3063
	ldh (<hRomBank),a	; $3065
	ld ($2222),a		; $3067
	push de			; $306a
	call $4ea4		; $306b
	pop de			; $306e
	pop af			; $306f
	ldh (<hRomBank),a	; $3070
	ld ($2222),a		; $3072
	ret			; $3075

clearStaticObjects:
	ld hl,$cd80		; $3076
	ld b,$80		; $3079
	jp clearMemory		; $307b

findFreeStaticObjectSlot:
	ld hl,$cd80		; $307e
_label_00_347:
	ld a,(hl)		; $3081
	or a			; $3082
	ret z			; $3083
	ld a,$08		; $3084
	add l			; $3086
	ld l,a			; $3087
	jr nz,_label_00_347	; $3088
	or h			; $308a
	ret			; $308b

objectDeleteRelatedObj1AsStaticObject:
	ldh a,(<hActiveObjectType)	; $308c
	add $16			; $308e
	ld l,a			; $3090
	ld h,d			; $3091
	ldi a,(hl)		; $3092
	ld h,(hl)		; $3093
	ld e,l			; $3094
	ld l,a			; $3095
	or h			; $3096
	ret z			; $3097
	xor a			; $3098
	ld (de),a		; $3099
	dec e			; $309a
	ld (de),a		; $309b
	ld e,$08		; $309c
_label_00_348:
	ldi (hl),a		; $309e
	dec e			; $309f
	jr nz,_label_00_348	; $30a0
	ret			; $30a2

objectSaveAsStaticObject:
	ld (hl),a		; $30a3
	ldh a,(<hActiveObjectType)	; $30a4
	add $16			; $30a6
	ld e,a			; $30a8
	ld a,l			; $30a9
	ld (de),a		; $30aa
	inc e			; $30ab
	ld a,h			; $30ac
	ld (de),a		; $30ad
	ld a,($cc4c)		; $30ae
	inc hl			; $30b1
	ldi (hl),a		; $30b2
	ldh a,(<hActiveObjectType)	; $30b3
	inc a			; $30b5
	ld e,a			; $30b6
	ld a,(de)		; $30b7
	ldi (hl),a		; $30b8
	inc e			; $30b9
	ld a,(de)		; $30ba
	ldi (hl),a		; $30bb
	ld a,e			; $30bc
	add $09			; $30bd
	ld e,a			; $30bf
	ld a,(de)		; $30c0
	ldi (hl),a		; $30c1
	inc e			; $30c2
	inc e			; $30c3
	ld a,(de)		; $30c4
	ldi (hl),a		; $30c5
	ret			; $30c6

checkGlobalFlag:
	ld hl,$c6ca		; $30c7
	jp checkFlag		; $30ca

setGlobalFlag:
	ld hl,$c6ca		; $30cd
	jp setFlag		; $30d0

unsetGlobalFlag:
	ld hl,$c6ca		; $30d3
	jp unsetFlag		; $30d6

clearEnemiesKilledList:
	ld h,$00		; $30d9
	jp $30f7		; $30db

addRoomToEnemiesKilledList:
	ld h,$01		; $30de
	jp $30f7		; $30e0

markEnemyAsKilledInRoom:
	ld h,$02		; $30e3
	jp $30f7		; $30e5

func_3211:
	ld h,$03		; $30e8
	jp $30f7		; $30ea

generateRandomBuffer:
	ld h,$04		; $30ed
	jp $30f7		; $30ef

getRandomPositionForEnemy:
	ld h,$05		; $30f2
	jp $30f7		; $30f4
	ld l,a			; $30f7
	ldh a,(<hRomBank)	; $30f8
	push af			; $30fa
	ld a,$10		; $30fb
	ldh (<hRomBank),a	; $30fd
	ld ($2222),a		; $30ff
	call $5fbc		; $3102
	rl c			; $3105
	pop af			; $3107
	ldh (<hRomBank),a	; $3108
	ld ($2222),a		; $310a
	srl c			; $310d
	ret			; $310f

clearPaletteFadeVariablesAndRefreshPalettes:
	ld a,$ff		; $3110
	ldh (<hDirtyBgPalettes),a	; $3112
	ldh (<hDirtySprPalettes),a	; $3114

clearPaletteFadeVariables:
	xor a			; $3116
	ld ($c4ab),a		; $3117
	ld ($c2ff),a		; $311a
	ldh (<hBgPaletteSources),a	; $311d
	ldh (<hSprPaletteSources),a	; $311f
	ld ($c4ad),a		; $3121
	ld ($c4b5),a		; $3124
	ld hl,$c4b1		; $3127
	ldi (hl),a		; $312a
	ldi (hl),a		; $312b
	ldi (hl),a		; $312c
	ld (hl),a		; $312d
	ret			; $312e

fadeoutToWhiteWithDelay:
	call setPaletteThreadDelay		; $312f
	ld a,$09		; $3132
	ld ($c4ab),a		; $3134
	ld a,$01		; $3137
	jr _label_00_349		; $3139

fastFadeoutToWhite:
	ld a,$01		; $313b
	ld ($c4ab),a		; $313d
	ld a,$03		; $3140
	jr _label_00_349		; $3142

fadeoutToWhite:
	ld a,$01		; $3144
	ld ($c4ab),a		; $3146
	ld a,$01		; $3149
_label_00_349:
	ld ($c4ac),a		; $314b
	xor a			; $314e
	ld ($c2ff),a		; $314f

makeAllPaletteUseFading:
	ld a,$ff		; $3152
	ld hl,$c4b1		; $3154
	ldi (hl),a		; $3157
	ldi (hl),a		; $3158
	ldi (hl),a		; $3159
	ld (hl),a		; $315a
	ret			; $315b

fadeinFromWhiteWithDelay:
	call setPaletteThreadDelay		; $315c
	ld a,$0a		; $315f
	ld ($c4ab),a		; $3161
	ld a,$01		; $3164
	jr _label_00_350		; $3166

fastFadeinFromWhite:
	ld a,$02		; $3168
	ld ($c4ab),a		; $316a
	ld a,$03		; $316d
	jr _label_00_350		; $316f

fadeinFromWhite:
	ld a,$02		; $3171
	ld ($c4ab),a		; $3173
	ld a,$01		; $3176
_label_00_350:
	ld ($c4ac),a		; $3178
	ld a,$20		; $317b
	ld ($c2ff),a		; $317d
	jp makeAllPaletteUseFading		; $3180

fadeoutToBlackWithDelay:
	call setPaletteThreadDelay		; $3183
	ld a,$0b		; $3186
	ld ($c4ab),a		; $3188
	ld a,$01		; $318b
	jr _label_00_351		; $318d

fastFadeoutToBlack:
	ld a,$03		; $318f
	ld ($c4ab),a		; $3191
	ld a,$03		; $3194
	jr _label_00_351		; $3196

fadeoutToBlack:
	ld a,$03		; $3198
	ld ($c4ab),a		; $319a
	ld a,$01		; $319d
_label_00_351:
	ld ($c4ac),a		; $319f
	xor a			; $31a2
	ld ($c2ff),a		; $31a3
	jp makeAllPaletteUseFading		; $31a6

fadeinFromBlackWithDelay:
	call setPaletteThreadDelay		; $31a9
	ld a,$0c		; $31ac
	ld ($c4ab),a		; $31ae
	ld a,$01		; $31b1
	jr _label_00_352		; $31b3

fastFadeinFromBlack:
	ld a,$04		; $31b5
	ld ($c4ab),a		; $31b7
	ld a,$03		; $31ba
	jr _label_00_352		; $31bc

fadeinFromBlack:
	ld a,$04		; $31be
	ld ($c4ab),a		; $31c0
	ld a,$01		; $31c3
_label_00_352:
	ld ($c4ac),a		; $31c5
	ld a,$e0		; $31c8
	ld ($c2ff),a		; $31ca
	jp makeAllPaletteUseFading		; $31cd

darkenRoomLightly:
	ld b,$f7		; $31d0
	jr _label_00_353		; $31d2

darkenRoom:
	ld b,$f0		; $31d4
_label_00_353:

_darkenRoomHelper:
	ld a,$05		; $31d6
	ld ($c4ab),a		; $31d8
_label_00_354:
	ld a,($c4ae)		; $31db

_setDarkeningVariables:
	ld ($c2ff),a		; $31de
	ld a,b			; $31e1
	ld ($c4ae),a		; $31e2
	ld a,$01		; $31e5
	ld ($c4ac),a		; $31e7
	ld a,$fc		; $31ea
	ld hl,$c4b1		; $31ec
	ldi (hl),a		; $31ef
	ld (hl),$00		; $31f0
	inc l			; $31f2
	ldi (hl),a		; $31f3
	ld (hl),$00		; $31f4
	ret			; $31f6

brightenRoomLightly:
	ld b,$f7		; $31f7
	jr _label_00_355		; $31f9

brightenRoom:
	ld b,$00		; $31fb
_label_00_355:
	ld a,$06		; $31fd
	ld ($c4ab),a		; $31ff
	jr _label_00_354		; $3202

fastFadeinFromWhiteToRoom:
	call fastFadeinFromWhite		; $3204
	ld a,$1e		; $3207
	ld ($c2ff),a		; $3209
_label_00_356:
	ld a,$07		; $320c
	ld ($c4ab),a		; $320e
	ret			; $3211

fadeinFromWhiteToRoom:
	call fadeinFromWhite		; $3212
	jr _label_00_356		; $3215

startFadeBetweenTwoPalettes:
	ld a,$08		; $3217
	ld ($c4ab),a		; $3219
	ld a,$20		; $321c
	ld ($c2ff),a		; $321e
	ret			; $3221

setPaletteThreadDelay:
	ld ($c4b0),a		; $3222
	ld a,$01		; $3225
	ld ($c4af),a		; $3227
	ret			; $322a
_label_00_357:

paletteFadeThreadStart:
	ld a,$02		; $322b
	ld ($ff00+$70),a	; $322d
	ld a,$01		; $322f
	ldh (<hRomBank),a	; $3231
	ld ($2222),a		; $3233
	call $554f		; $3236
	call $5766		; $3239
	ld a,($c4ad)		; $323c
	or a			; $323f
	jr nz,_label_00_358	; $3240
	inc a			; $3242
_label_00_358:
	call resumeThreadInAFrames		; $3243
	jr _label_00_357		; $3246

mainThreadStart:
	call restartSound		; $3248
	call stopTextThread		; $324b
_label_00_359:
	ld hl,$c622		; $324e
	inc (hl)		; $3251
	ldi a,(hl)		; $3252
	ld (wFrameCounter),a		; $3253
	jr nz,_label_00_360	; $3256
	inc (hl)		; $3258
	jr nz,_label_00_360	; $3259
	inc l			; $325b
	inc (hl)		; $325c
	jr nz,_label_00_360	; $325d
	inc l			; $325f
	inc (hl)		; $3260
_label_00_360:
	ld a,$01		; $3261
	ldh (<hRomBank),a	; $3263
	ld ($2222),a		; $3265
	call $57b1		; $3268
	call drawAllSprites		; $326b
	call checkReloadStatusBarGraphics		; $326e
	call resumeThreadNextFrame		; $3271
	jr _label_00_359		; $3274

seasonsFunc_3276:
	ldh a,(<hRomBank)	; $3276
	push af			; $3278
	ld a,$04		; $3279
	ldh (<hRomBank),a	; $327b
	ld ($2222),a		; $327d
	call $575e		; $3280
	pop af			; $3283
	ldh (<hRomBank),a	; $3284
	ld ($2222),a		; $3286
	ret			; $3289

loadScreenMusic:
	ldh a,(<hRomBank)	; $328a
	push af			; $328c
	ld a,$04		; $328d
	ldh (<hRomBank),a	; $328f
	ld ($2222),a		; $3291
	ld a,($cc49)		; $3294
	ld hl,$483c		; $3297
	rst_addDoubleIndex			; $329a
	ldi a,(hl)		; $329b
	ld h,(hl)		; $329c
	ld l,a			; $329d
	ld a,($cc4c)		; $329e
	rst_addAToHl			; $32a1
	ldi a,(hl)		; $32a2
	ld ($cc62),a		; $32a3
	ld a,($cc49)		; $32a6
	or a			; $32a9
	jr nz,_label_00_361	; $32aa
	ld a,($cc4c)		; $32ac
	ld hl,$473c		; $32af
	rst_addAToHl			; $32b2
	ldi a,(hl)		; $32b3
	ld ($cc61),a		; $32b4
_label_00_361:
	pop af			; $32b7
	ldh (<hRomBank),a	; $32b8
	ld ($2222),a		; $32ba
	ret			; $32bd

applyWarpDest:
	ldh a,(<hRomBank)	; $32be
	push af			; $32c0
	ld a,$04		; $32c1
	ldh (<hRomBank),a	; $32c3
	ld ($2222),a		; $32c5
	call $45d0		; $32c8
	ld a,$01		; $32cb
	ldh (<hRomBank),a	; $32cd
	ld ($2222),a		; $32cf
	call $578d		; $32d2
	pop af			; $32d5
	ldh (<hRomBank),a	; $32d6
	ld ($2222),a		; $32d8
	ret			; $32db

loadScreenMusicAndSetRoomPack:
	call loadScreenMusic		; $32dc
	ld a,($cc4c)		; $32df
	ld ($cc4b),a		; $32e2
	ld a,($cc49)		; $32e5
	or a			; $32e8
	ret nz			; $32e9
	ld a,($cc61)		; $32ea
	ld ($cc4d),a		; $32ed
	ret			; $32f0

dismountCompanionAndSetRememberedPositionToScreenCenter:
	ldh a,(<hRomBank)	; $32f1
	push af			; $32f3
	ld a,$05		; $32f4
	ldh (<hRomBank),a	; $32f6
	ld ($2222),a		; $32f8
	ld de,$d100		; $32fb
	ld a,e			; $32fe
	ldh (<hActiveObjectType),a	; $32ff
	ld a,d			; $3301
	ldh (<hActiveObject),a	; $3302
	call $45f5		; $3304
	call $4641		; $3307
	ld a,$38		; $330a
	ld ($cc43),a		; $330c
	ld a,$50		; $330f
	ld ($cc44),a		; $3311
	pop af			; $3314
	ldh (<hRomBank),a	; $3315
	ld ($2222),a		; $3317
	ret			; $331a

seasonsFunc_331b:
	ldh a,(<hRomBank)	; $331b
	push af			; $331d
	ld a,$0f		; $331e
	ldh (<hRomBank),a	; $3320
	ld ($2222),a		; $3322
	call $6f75		; $3325
	pop af			; $3328
	ldh (<hRomBank),a	; $3329
	ld ($2222),a		; $332b
	ret			; $332e

seasonsFunc_332f:
	ldh a,(<hRomBank)	; $332f
	push af			; $3331
	ld a,$0f		; $3332
	ldh (<hRomBank),a	; $3334
	ld ($2222),a		; $3336
	call $704d		; $3339
	call $7182		; $333c
	pop af			; $333f
	ldh (<hRomBank),a	; $3340
	ld ($2222),a		; $3342
	ret			; $3345

seasonsFunc_3346:
	ldh a,(<hRomBank)	; $3346
	push af			; $3348
	ld a,$03		; $3349
	ldh (<hRomBank),a	; $334b
	ld ($2222),a		; $334d
	call $6dfd		; $3350
	pop af			; $3353
	ldh (<hRomBank),a	; $3354
	ld ($2222),a		; $3356
	ret			; $3359

seasonsFunc_335a:
	ldh a,(<hRomBank)	; $335a
	push af			; $335c
	ld a,$03		; $335d
	ldh (<hRomBank),a	; $335f
	ld ($2222),a		; $3361
	call $6e05		; $3364
	pop af			; $3367
	ldh (<hRomBank),a	; $3368
	ld ($2222),a		; $336a
	ret			; $336d

seasonsFunc_336e:
	ldh a,(<hRomBank)	; $336e
	push af			; $3370
	ld a,$03		; $3371
	ldh (<hRomBank),a	; $3373
	ld ($2222),a		; $3375
	call $6e0d		; $3378
	pop af			; $337b
	ldh (<hRomBank),a	; $337c
	ld ($2222),a		; $337e
	ret			; $3381

updateAllObjects:
	ldh a,(<hRomBank)	; $3382
	push af			; $3384
	ld a,$05		; $3385
	ldh (<hRomBank),a	; $3387
	ld ($2222),a		; $3389
	call $4000		; $338c
	ld a,:updateItems		; $338f
	ldh (<hRomBank),a	; $3391
	ld ($2222),a		; $3393
	call updateItems		; $3396
	call setEnemyTargetToLinkPosition		; $3399
	ld a,$00		; $339c
	ldh (<hRomBank),a	; $339e
	ld ($2222),a		; $33a0
	call updateEnemies		; $33a3
	ld a,$10		; $33a6
	ldh (<hRomBank),a	; $33a8
	ld ($2222),a		; $33aa
	call $61dc		; $33ad
	ld a,$00		; $33b0
	ldh (<hRomBank),a	; $33b2
	ld ($2222),a		; $33b4
	call updateInteractions		; $33b7
	ld a,$01		; $33ba
	ldh (<hRomBank),a	; $33bc
	ld ($2222),a		; $33be
	call $4000		; $33c1
	ld a,$05		; $33c4
	ldh (<hRomBank),a	; $33c6
	ld ($2222),a		; $33c8
	ld a,($cc48)		; $33cb
	rrca			; $33ce
	call c,$40f1		; $33cf
	ld a,$06		; $33d2
	ldh (<hRomBank),a	; $33d4
	ld ($2222),a		; $33d6
	ld a,($cc75)		; $33d9
	rlca			; $33dc
	call c,$5429		; $33dd
	call loadLinkAndCompanionAnimationFrame		; $33e0
	ld a,$07		; $33e3
	ldh (<hRomBank),a	; $33e5
	ld ($2222),a		; $33e7
	call $4902		; $33ea
	ld a,$01		; $33ed
	ldh (<hRomBank),a	; $33ef
	ld ($2222),a		; $33f1
	call $48da		; $33f4
	ld a,$00		; $33f7
	ldh (<hRomBank),a	; $33f9
	ld ($2222),a		; $33fb
	call updateCamera		; $33fe
	ld a,$04		; $3401
	ldh (<hRomBank),a	; $3403
	ld ($2222),a		; $3405
	call $6b25		; $3408
	ld a,$04		; $340b
	ldh (<hRomBank),a	; $340d
	ld ($2222),a		; $340f
	call $575e		; $3412
	xor a			; $3415
	ld ($c4b6),a		; $3416
	pop af			; $3419
	ldh (<hRomBank),a	; $341a
	ld ($2222),a		; $341c
	ret			; $341f

updateSpecialObjectsAndInteractions:
	ldh a,(<hRomBank)	; $3420
	push af			; $3422
	ld a,$05		; $3423
	ldh (<hRomBank),a	; $3425
	ld ($2222),a		; $3427
	call $4000		; $342a
	ld a,$00		; $342d
	ldh (<hRomBank),a	; $342f
	ld ($2222),a		; $3431
	call updateInteractions		; $3434
	call loadLinkAndCompanionAnimationFrame		; $3437
	xor a			; $343a
	ld ($c4b6),a		; $343b
	pop af			; $343e
	ldh (<hRomBank),a	; $343f
	ld ($2222),a		; $3441
	ret			; $3444

updateInteractionsAndDrawAllSprites:
	ldh a,(<hRomBank)	; $3445
	push af			; $3447
	ld a,$00		; $3448
	ldh (<hRomBank),a	; $344a
	ld ($2222),a		; $344c
	call updateInteractions		; $344f
	call drawAllSprites		; $3452
	xor a			; $3455
	ld ($c4b6),a		; $3456
	pop af			; $3459
	ldh (<hRomBank),a	; $345a
	ld ($2222),a		; $345c
	ret			; $345f

func_3539:
	ldh a,(<hRomBank)	; $3460
	push af			; $3462
	ld a,$05		; $3463
	ldh (<hRomBank),a	; $3465
	ld ($2222),a		; $3467
	call $4000		; $346a
	ld a,$00		; $346d
	ldh (<hRomBank),a	; $346f
	ld ($2222),a		; $3471
	call updateEnemies		; $3474
	ld a,$00		; $3477
	ldh (<hRomBank),a	; $3479
	ld ($2222),a		; $347b
	call updateInteractions		; $347e
	ld a,$00		; $3481
	ldh (<hRomBank),a	; $3483
	ld ($2222),a		; $3485
	call loadLinkAndCompanionAnimationFrame		; $3488
	ld a,$04		; $348b
	ldh (<hRomBank),a	; $348d
	ld ($2222),a		; $348f
	call $575e		; $3492
	xor a			; $3495
	ld ($c4b6),a		; $3496
	pop af			; $3499
	ldh (<hRomBank),a	; $349a
	ld ($2222),a		; $349c
	ret			; $349f

seasonsFunc_34a0:
	ldh a,(<hRomBank)	; $34a0
	push af			; $34a2
	ld a,$05		; $34a3
	ldh (<hRomBank),a	; $34a5
	ld ($2222),a		; $34a7
	call $4000		; $34aa
	ld a,:updateItems		; $34ad
	ldh (<hRomBank),a	; $34af
	ld ($2222),a		; $34b1
	call updateItems		; $34b4
	ld a,$00		; $34b7
	ldh (<hRomBank),a	; $34b9
	ld ($2222),a		; $34bb
	call updateEnemies		; $34be
	ld a,$10		; $34c1
	ldh (<hRomBank),a	; $34c3
	ld ($2222),a		; $34c5
	call $61dc		; $34c8
	ld a,$00		; $34cb
	ldh (<hRomBank),a	; $34cd
	ld ($2222),a		; $34cf
	call updateInteractions		; $34d2
	ld a,$0f		; $34d5
	ldh (<hRomBank),a	; $34d7
	ld ($2222),a		; $34d9
	call $7159		; $34dc
	ld a,$06		; $34df
	ldh (<hRomBank),a	; $34e1
	ld ($2222),a		; $34e3
	ld a,($cc75)		; $34e6
	rlca			; $34e9
	call c,$5429		; $34ea
	call loadLinkAndCompanionAnimationFrame		; $34ed
	ld a,$07		; $34f0
	ldh (<hRomBank),a	; $34f2
	ld ($2222),a		; $34f4
	call $4902		; $34f7
	ld a,$0f		; $34fa
	ldh (<hRomBank),a	; $34fc
	ld ($2222),a		; $34fe
	call $7182		; $3501
	ld a,$04		; $3504
	ldh (<hRomBank),a	; $3506
	ld ($2222),a		; $3508
	call $6b25		; $350b
	xor a			; $350e
	ld ($c4b6),a		; $350f
	pop af			; $3512
	ldh (<hRomBank),a	; $3513
	ld ($2222),a		; $3515
	ret			; $3518

clearWramBank1:
	xor a			; $3519
	ld ($ff00+$70),a	; $351a
	ld hl,$d000		; $351c
	ld bc,$1000		; $351f
	jp clearMemoryBc		; $3522

clearScreenVariablesAndWramBank1:
	call clearWramBank1		; $3525

clearScreenVariables:
	ld hl,$cd00		; $3528
	ld b,$30		; $352b
	call clearMemory		; $352d
	ld a,$ff		; $3530
	ld ($cd28),a		; $3532
	ld ($cd2a),a		; $3535
	ld ($cd2b),a		; $3538
	ret			; $353b

clearLinkObject:
	ld hl,$d000		; $353c
	ld b,$40		; $353f
	jp clearMemory		; $3541

clearReservedInteraction0:
	ld hl,$d040		; $3544
	ld b,$40		; $3547
	call clearMemory		; $3549

clearReservedInteraction1:
	ld hl,$d140		; $354c
	ld b,$40		; $354f
	jp clearMemory		; $3551

clearDynamicInteractions:
	ld de,$d240		; $3554
_label_00_362:
	ld h,d			; $3557
	ld l,$40		; $3558
	ld b,$40		; $355a
	call clearMemory		; $355c
	inc d			; $355f
	ld a,d			; $3560
	cp $e0			; $3561
	jr c,_label_00_362	; $3563
	ret			; $3565

clearItems:
	ld de,$d600		; $3566
_label_00_363:
	ld h,d			; $3569
	ld l,$00		; $356a
	ld b,$40		; $356c
	call clearMemory		; $356e
	inc d			; $3571
	ld a,d			; $3572
	cp $e0			; $3573
	jr c,_label_00_363	; $3575
	ret			; $3577

clearEnemies:
	ld de,$d080		; $3578
_label_00_364:
	ld h,d			; $357b
	ld l,$80		; $357c
	ld b,$40		; $357e
	call clearMemory		; $3580
	inc d			; $3583
	ld a,d			; $3584
	cp $e0			; $3585
	jr c,_label_00_364	; $3587
	ret			; $3589

clearParts:
	ld de,$d0c0		; $358a
_label_00_365:
	ld h,d			; $358d
	ld l,$c0		; $358e
	ld b,$40		; $3590
	call clearMemory		; $3592
	inc d			; $3595
	ld a,d			; $3596
	cp $e0			; $3597
	jr c,_label_00_365	; $3599
	ret			; $359b

setEnemyTargetToLinkPosition:
	ld a,($cc48)		; $359c
	ld h,a			; $359f
	ld l,$0b		; $35a0
	ldi a,(hl)		; $35a2
	ldh (<hEnemyTargetY),a	; $35a3
	inc l			; $35a5
	ld a,(hl)		; $35a6
	ldh (<hEnemyTargetX),a	; $35a7
	ld a,($ccf0)		; $35a9
	or a			; $35ac
	ret nz			; $35ad
	ld l,$0b		; $35ae
	ldi a,(hl)		; $35b0
	ldh (<hFFB2),a	; $35b1
	inc l			; $35b3
	ld a,(hl)		; $35b4
	ldh (<hFFB3),a	; $35b5
	ret			; $35b7

seasonsFunc_35b8:
	ldh a,(<hRomBank)	; $35b8
	push af			; $35ba
	ld a,$03		; $35bb
	ldh (<hRomBank),a	; $35bd
	ld ($2222),a		; $35bf
	call $72ff		; $35c2
	pop af			; $35c5
	ldh (<hRomBank),a	; $35c6
	ld ($2222),a		; $35c8
	ret			; $35cb
	ld a,($ff00+$70)	; $35cc
	ld c,a			; $35ce
	ldh a,(<hRomBank)	; $35cf
	ld b,a			; $35d1
	push bc			; $35d2
	ld a,$02		; $35d3
	ld ($ff00+$70),a	; $35d5
	ld a,$01		; $35d7
	ldh (<hRomBank),a	; $35d9
	ld ($2222),a		; $35db
	call $5683		; $35de
	pop bc			; $35e1
	ld a,b			; $35e2
	ldh (<hRomBank),a	; $35e3
	ld ($2222),a		; $35e5
	ld a,c			; $35e8
	ld ($ff00+$70),a	; $35e9
	ret			; $35eb
	ldh a,(<hRomBank)	; $35ec
	push af			; $35ee
	ld a,$01		; $35ef
	ldh (<hRomBank),a	; $35f1
	ld ($2222),a		; $35f3
	call $565d		; $35f6
	pop af			; $35f9
	ldh (<hRomBank),a	; $35fa
	ld ($2222),a		; $35fc
	ret			; $35ff

loadAnimationData:
	ld b,a			; $3600
	ldh a,(<hRomBank)	; $3601
	push af			; $3603
	ld a,$04		; $3604
	ldh (<hRomBank),a	; $3606
	ld ($2222),a		; $3608
	ld a,b			; $360b
	ld hl,$59b0		; $360c
	rst_addDoubleIndex			; $360f
	ldi a,(hl)		; $3610
	ld h,(hl)		; $3611
	ld l,a			; $3612
	ldi a,(hl)		; $3613
	ld ($cd30),a		; $3614
	push de			; $3617
	ld de,$cd31		; $3618
	call $363f		; $361b
	ld de,$cd34		; $361e
	call $363f		; $3621
	ld de,$cd37		; $3624
	call $363f		; $3627
	ld de,$cd3a		; $362a
	call $363f		; $362d
	pop de			; $3630
	pop af			; $3631
	ldh (<hRomBank),a	; $3632
	ld ($2222),a		; $3634
	xor a			; $3637
	ld ($ccfa),a		; $3638
	ld ($ccfb),a		; $363b
	ret			; $363e
	push hl			; $363f
	ldi a,(hl)		; $3640
	ld h,(hl)		; $3641
	ld l,a			; $3642
	ldi a,(hl)		; $3643
	ld (de),a		; $3644
	inc de			; $3645
	ld a,l			; $3646
	ld (de),a		; $3647
	inc de			; $3648
	ld a,h			; $3649
	ld (de),a		; $364a
	pop hl			; $364b
	inc hl			; $364c
	inc hl			; $364d
	ret			; $364e

roomTileChangesAfterLoad02:
	ldh a,(<hRomBank)	; $364f
	push af			; $3651
	ld a,$09		; $3652
	ldh (<hRomBank),a	; $3654
	ld ($2222),a		; $3656
	call $53f0		; $3659
	pop af			; $365c
	ldh (<hRomBank),a	; $365d
	ld ($2222),a		; $365f
	ret			; $3662

getIndexOfGashaSpotInRoom:
	ld c,a			; $3663
	ldh a,(<hRomBank)	; $3664
	push af			; $3666
	ld a,$04		; $3667
	ldh (<hRomBank),a	; $3669
	ld ($2222),a		; $366b
	ld a,c			; $366e
	call $66cc		; $366f
	push af			; $3672
	pop bc			; $3673
	pop af			; $3674
	ldh (<hRomBank),a	; $3675
	ld ($2222),a		; $3677
	ret			; $367a

vramBgMapTable:
	nop			; $367b
	sbc b			; $367c
	ld b,b			; $367d
	sbc b			; $367e
	add b			; $367f
	sbc b			; $3680
	ret nz			; $3681
	sbc b			; $3682
	nop			; $3683
	sbc c			; $3684
	ld b,b			; $3685
	sbc c			; $3686
	add b			; $3687
	sbc c			; $3688
	ret nz			; $3689
	sbc c			; $368a
	nop			; $368b
	sbc d			; $368c
	ld b,b			; $368d
	sbc d			; $368e
	add b			; $368f
	sbc d			; $3690
	ret nz			; $3691
	sbc d			; $3692
	nop			; $3693
	sbc e			; $3694
	ld b,b			; $3695
	sbc e			; $3696
	add b			; $3697
	sbc e			; $3698
	ret nz			; $3699
	sbc e			; $369a

func_36f6:
	and $03			; $369b
	ld ($cc4e),a		; $369d
	ld a,b			; $36a0
	ld ($cc49),a		; $36a1
	ld a,c			; $36a4
	ld ($cc4c),a		; $36a5
	call loadScreenMusicAndSetRoomPack		; $36a8
	call loadAreaData		; $36ab
	call loadAreaGraphics		; $36ae
	call loadTilesetAndRoomLayout		; $36b1
	jp generateVramTilesWithRoomChanges		; $36b4

loadAreaTileset:
	ld a,($cd23)		; $36b7
	call loadTileset		; $36ba
	ld a,$17		; $36bd
	ldh (<hRomBank),a	; $36bf
	ld ($2222),a		; $36c1
	ld a,$03		; $36c4
	ld ($ff00+$70),a	; $36c6
	ld hl,$dc00		; $36c8
	ld de,$d000		; $36cb
	ld b,$00		; $36ce
_label_00_366:
	push bc			; $36d0
	call $36dc		; $36d1
	pop bc			; $36d4
	dec b			; $36d5
	jr nz,_label_00_366	; $36d6
	xor a			; $36d8
	ld ($ff00+$70),a	; $36d9
	ret			; $36db
	ldi a,(hl)		; $36dc
	ld c,a			; $36dd
	ldi a,(hl)		; $36de
	ld b,a			; $36df
	push hl			; $36e0
	ld hl,$4004		; $36e1
	add hl,bc		; $36e4
	add hl,bc		; $36e5
	add hl,bc		; $36e6
	ldi a,(hl)		; $36e7
	ld c,a			; $36e8
	ld a,(hl)		; $36e9
	swap a			; $36ea
	and $0f			; $36ec
	ld b,a			; $36ee
	push hl			; $36ef
	ld hl,$4000		; $36f0
	ldi a,(hl)		; $36f3
	ld h,(hl)		; $36f4
	ld l,a			; $36f5
	add hl,bc		; $36f6
	add hl,bc		; $36f7
	add hl,bc		; $36f8
	add hl,bc		; $36f9
	ld b,$04		; $36fa
	call copyMemory		; $36fc
	pop hl			; $36ff
	ldi a,(hl)		; $3700
	and $0f			; $3701
	ld b,a			; $3703
	ld c,(hl)		; $3704
	ld hl,$4002		; $3705
	ldi a,(hl)		; $3708
	ld h,(hl)		; $3709
	ld l,a			; $370a
	add hl,bc		; $370b
	add hl,bc		; $370c
	add hl,bc		; $370d
	add hl,bc		; $370e
	ld b,$04		; $370f
	call copyMemory		; $3711
	pop hl			; $3714
	ret			; $3715

loadUniqueGfxHeader:
	and $7f			; $3716
	ld b,a			; $3718
	ldh a,(<hRomBank)	; $3719
	push af			; $371b
	ld a,$04		; $371c
	ldh (<hRomBank),a	; $371e
	ld ($2222),a		; $3720
	ld a,b			; $3723
	ld hl,$595e		; $3724
	rst_addDoubleIndex			; $3727
	ldi a,(hl)		; $3728
	ld ($cd10),a		; $3729
	ld a,(hl)		; $372c
	ld ($cd11),a		; $372d
	pop af			; $3730
	ldh (<hRomBank),a	; $3731
	ld ($2222),a		; $3733
	ret			; $3736

loadAreaGraphics:
	ldh a,(<hRomBank)	; $3737
	push af			; $3739
	ld a,($cd21)		; $373a
	call loadGfxHeader		; $373d
	ld a,($cd22)		; $3740
	call loadPaletteHeader		; $3743
	call loadAreaUniqueGfx		; $3746
	ld a,$04		; $3749
	ldh (<hRomBank),a	; $374b
	ld ($2222),a		; $374d
	call $574c		; $3750
	ld a,($cd20)		; $3753
	ld ($cd28),a		; $3756
	ld a,($cd22)		; $3759
	ld ($cd29),a		; $375c
	ld a,($cd25)		; $375f
	ld ($cd2b),a		; $3762
	pop af			; $3765
	ldh (<hRomBank),a	; $3766
	ld ($2222),a		; $3768
	ret			; $376b

updateAreaUniqueGfx:
	ld a,($cd20)		; $376c
	or a			; $376f
	ret z			; $3770
	ld b,a			; $3771
	ld a,($cd28)		; $3772
	cp b			; $3775
	ret z			; $3776
	ldh a,(<hRomBank)	; $3777
	push af			; $3779
	ld hl,$cd10		; $377a
	ldi a,(hl)		; $377d
	ld h,(hl)		; $377e
	ld l,a			; $377f
	ld a,$04		; $3780
	ldh (<hRomBank),a	; $3782
	ld ($2222),a		; $3784
	call loadUniqueGfxHeaderEntry		; $3787
	ld c,a			; $378a
	ld a,l			; $378b
	ld ($cd10),a		; $378c
	ld a,h			; $378f
	ld ($cd11),a		; $3790
	pop af			; $3793
	ldh (<hRomBank),a	; $3794
	ld ($2222),a		; $3796
	ld a,c			; $3799
	add a			; $379a
	ret			; $379b

uniqueGfxFunc_380b:
	ld b,a			; $379c
	ldh a,(<hRomBank)	; $379d
	push af			; $379f
	ld a,$04		; $37a0
	ldh (<hRomBank),a	; $37a2
	ld ($2222),a		; $37a4
	ld a,b			; $37a7
	ld hl,$595e		; $37a8
	rst_addDoubleIndex			; $37ab
	ldi a,(hl)		; $37ac
	ld h,(hl)		; $37ad
	ld l,a			; $37ae
	call loadUniqueGfxHeaderEntry		; $37af
	pop af			; $37b2
	ldh (<hRomBank),a	; $37b3
	ld ($2222),a		; $37b5
	ret			; $37b8

loadAreaUniqueGfx:
	ld a,$04		; $37b9
	ldh (<hRomBank),a	; $37bb
	ld ($2222),a		; $37bd
	ld a,($cd20)		; $37c0
	and $7f			; $37c3
	ret z			; $37c5
	ld hl,$595e		; $37c6
	rst_addDoubleIndex			; $37c9
	ldi a,(hl)		; $37ca
	ld h,(hl)		; $37cb
	ld l,a			; $37cc
_label_00_367:
	call loadUniqueGfxHeaderEntry		; $37cd
	add a			; $37d0
	jr c,_label_00_367	; $37d1
	ret			; $37d3

loadUniqueGfxHeaderEntry:
	ldi a,(hl)		; $37d4
	or a			; $37d5
	jr z,_label_00_368	; $37d6
	ld c,a			; $37d8
	ldh (<hFF8C),a	; $37d9
	ldi a,(hl)		; $37db
	ld b,a			; $37dc
	ldi a,(hl)		; $37dd
	ld c,a			; $37de
	ldi a,(hl)		; $37df
	ld d,a			; $37e0
	ldi a,(hl)		; $37e1
	ld e,a			; $37e2
	ld a,(hl)		; $37e3
	and $7f			; $37e4
	ldh (<hFF8D),a	; $37e6
	push hl			; $37e8
	push de			; $37e9
	ld l,c			; $37ea
	ld h,b			; $37eb
	ld b,a			; $37ec
	ldh a,(<hFF8C)	; $37ed
	ld c,a			; $37ef
	ld de,$d807		; $37f0
	call decompressGraphics		; $37f3
	pop de			; $37f6
	ld hl,$d800		; $37f7
	ld c,$07		; $37fa
	ldh a,(<hFF8D)	; $37fc
	ld b,a			; $37fe
	call queueDmaTransfer		; $37ff
	pop hl			; $3802
	ld a,$00		; $3803
	ld ($ff00+$70),a	; $3805
	ld a,$04		; $3807
	ldh (<hRomBank),a	; $3809
	ld ($2222),a		; $380b
	ldi a,(hl)		; $380e
	ret			; $380f
_label_00_368:
	push hl			; $3810
	ld a,(hl)		; $3811
	and $7f			; $3812
	call loadPaletteHeader		; $3814
	pop hl			; $3817
	ldi a,(hl)		; $3818
	ret			; $3819

loadAreaData:
	ldh a,(<hRomBank)	; $381a
	push af			; $381c
	ld a,$04		; $381d
	ldh (<hRomBank),a	; $381f
	ld ($2222),a		; $3821
	call $6c6d		; $3824
	ld hl,$403e		; $3827
	ld e,$02		; $382a
	call interBankCall		; $382c
	pop af			; $382f
	ldh (<hRomBank),a	; $3830
	ld ($2222),a		; $3832
	ret			; $3835

loadTilesetAndRoomLayout:
	ldh a,(<hRomBank)	; $3836
	push af			; $3838
	ld a,($cd2a)		; $3839
	ld b,a			; $383c
	ld a,($cd23)		; $383d
	cp b			; $3840
	ld ($cd2a),a		; $3841
	call nz,loadAreaTileset		; $3844
	call seasonsFunc_3870		; $3847
	call loadRoomLayout		; $384a
	ld a,$04		; $384d
	ldh (<hRomBank),a	; $384f
	ld ($2222),a		; $3851
	call $5d94		; $3854
	ld a,$03		; $3857
	ld ($ff00+$70),a	; $3859
	ld hl,$df00		; $385b
	ld de,$cf00		; $385e
	ld b,$c0		; $3861
	call copyMemoryReverse		; $3863
	xor a			; $3866
	ld ($ff00+$70),a	; $3867
	pop af			; $3869
	ldh (<hRomBank),a	; $386a
	ld ($2222),a		; $386c
	ret			; $386f

seasonsFunc_3870:
	ld a,$15		; $3870
	call checkGlobalFlag		; $3872
	ret z			; $3875
	ld a,$04		; $3876
	ldh (<hRomBank),a	; $3878
	ld ($2222),a		; $387a
	call $6cff		; $387d
	ret nc			; $3880
	ld a,($cc4e)		; $3881
	ld hl,$3890		; $3884
	rst_addAToHl			; $3887
	ld a,($cc4c)		; $3888
	add (hl)		; $388b
	ld ($cc4b),a		; $388c
	ret			; $388f
	.db $bc $c0 $c4 $c8


loadRoomLayout:
	ld hl,$cf00		; $3894
	ld b,$c0		; $3897
	call clearMemory		; $3899
	ld a,$04		; $389c
	ldh (<hRomBank),a	; $389e
	ld ($2222),a		; $38a0
	ld a,($cd24)		; $38a3
	add a			; $38a6
	add a			; $38a7
	ld hl,$4c4c		; $38a8
	rst_addDoubleIndex			; $38ab
	ldi a,(hl)		; $38ac
	ld b,a			; $38ad
	ldi a,(hl)		; $38ae
	ldh (<hFF8D),a	; $38af
	ldi a,(hl)		; $38b1
	ldh (<hFF8E),a	; $38b2
	ldi a,(hl)		; $38b4
	ldh (<hFF8F),a	; $38b5
	ldi a,(hl)		; $38b7
	ldh (<hFF8C),a	; $38b8
	ldi a,(hl)		; $38ba
	ld h,(hl)		; $38bb
	ld l,a			; $38bc
	ldh a,(<hFF8C)	; $38bd
	ldh (<hRomBank),a	; $38bf
	ld ($2222),a		; $38c1
	push hl			; $38c4
	ld a,b			; $38c5
	rst_jumpTable			; $38c6
	ld ($ff00+$38),a	; $38c7
	ld a,$39		; $38c9
	ld d,b			; $38cb
	ld a,b			; $38cc
	and $0f			; $38cd
	ld b,a			; $38cf
	ldh a,(<hFF8F)	; $38d0
	ld h,a			; $38d2
	ldh a,(<hFF8E)	; $38d3
	ld l,a			; $38d5
	add hl,bc		; $38d6
	ld a,d			; $38d7
	swap a			; $38d8
	and $0f			; $38da
	add $03			; $38dc
	ld b,a			; $38de
	ret			; $38df
	ldh a,(<hFF8F)	; $38e0
	ld h,a			; $38e2
	ldh a,(<hFF8E)	; $38e3
	ld l,a			; $38e5
	ld bc,$1000		; $38e6
	add hl,bc		; $38e9
	ldh a,(<hFF8D)	; $38ea
	ldh (<hRomBank),a	; $38ec
	ld ($2222),a		; $38ee
	ld a,($cc4b)		; $38f1
	rst_addDoubleIndex			; $38f4
	ldi a,(hl)		; $38f5
	ld h,(hl)		; $38f6
	ld l,a			; $38f7
	pop bc			; $38f8
	add hl,bc		; $38f9
	ld bc,$fe00		; $38fa
	add hl,bc		; $38fd
	call $39df		; $38fe
	ld de,$cf00		; $3901
_label_00_369:
	ldi a,(hl)		; $3904
	ld b,$08		; $3905
_label_00_370:
	rrca			; $3907
	ldh (<hFF8B),a	; $3908
	jr c,_label_00_372	; $390a
	ldi a,(hl)		; $390c
	ld (de),a		; $390d
	inc e			; $390e
	ld a,e			; $390f
	cp $b0			; $3910
	ret z			; $3912
_label_00_371:
	ldh a,(<hFF8B)	; $3913
	dec b			; $3915
	jr nz,_label_00_370	; $3916
	jr _label_00_369		; $3918
_label_00_372:
	push bc			; $391a
	ldi a,(hl)		; $391b
	ld c,a			; $391c
	ldi a,(hl)		; $391d
	ld b,a			; $391e
	push hl			; $391f
	call $38cb		; $3920
	ld d,$cf		; $3923
	ldh a,(<hFF8D)	; $3925
	ldh (<hRomBank),a	; $3927
	ld ($2222),a		; $3929
_label_00_373:
	ldi a,(hl)		; $392c
	ld (de),a		; $392d
	inc e			; $392e
	ld a,e			; $392f
	cp $b0			; $3930
	jr z,_label_00_374	; $3932
	dec b			; $3934
	jr nz,_label_00_373	; $3935
	pop hl			; $3937
	pop bc			; $3938
	jr _label_00_371		; $3939
_label_00_374:
	pop hl			; $393b
	pop bc			; $393c
	ret			; $393d
	ldh a,(<hFF8D)	; $393e
	ldh (<hRomBank),a	; $3940
	ld ($2222),a		; $3942
	ldh a,(<hFF8E)	; $3945
	ld l,a			; $3947
	ldh a,(<hFF8F)	; $3948
	ld h,a			; $394a
	ld a,($cc4b)		; $394b
	rst_addDoubleIndex			; $394e
	ldi a,(hl)		; $394f
	ld c,a			; $3950
	ld a,(hl)		; $3951
	ld e,a			; $3952
	and $3f			; $3953
	ld b,a			; $3955
	pop hl			; $3956
	add hl,bc		; $3957
	call $39df		; $3958
	bit 7,e			; $395b
	jr nz,_label_00_377	; $395d
	bit 6,e			; $395f
	jr nz,_label_00_379	; $3961
	ld de,$cf00		; $3963
	ld bc,$0a08		; $3966
_label_00_375:
	push bc			; $3969
_label_00_376:
	ldi a,(hl)		; $396a
	ld (de),a		; $396b
	inc e			; $396c
	dec b			; $396d
	jr nz,_label_00_376	; $396e
	ld a,e			; $3970
	add $06			; $3971
	ld e,a			; $3973
	pop bc			; $3974
	dec c			; $3975
	jr nz,_label_00_375	; $3976
	ret			; $3978
_label_00_377:
	ld de,$cf00		; $3979
	ld a,$05		; $397c
_label_00_378:
	push af			; $397e
	call $3987		; $397f
	pop af			; $3982
	dec a			; $3983
	jr nz,_label_00_378	; $3984
	ret			; $3986
	ldi a,(hl)		; $3987
	ld c,a			; $3988
	ldi a,(hl)		; $3989
	ldh (<hFF8A),a	; $398a
	or c			; $398c
	ld b,$10		; $398d
	jr z,_label_00_381	; $398f
	ldi a,(hl)		; $3991
	ldh (<hFF8B),a	; $3992
	call $39cb		; $3994
	ldh a,(<hFF8A)	; $3997
	ld c,a			; $3999
	jr _label_00_382		; $399a
_label_00_379:
	ld de,$cf00		; $399c
	ld a,$0a		; $399f
_label_00_380:
	push af			; $39a1
	call $39aa		; $39a2
	pop af			; $39a5
	dec a			; $39a6
	jr nz,_label_00_380	; $39a7
	ret			; $39a9
	ldi a,(hl)		; $39aa
	ld c,a			; $39ab
	or a			; $39ac
	ld b,$08		; $39ad
	jr z,_label_00_381	; $39af
	ldi a,(hl)		; $39b1
	ldh (<hFF8B),a	; $39b2
	jr _label_00_382		; $39b4
_label_00_381:
	ldi a,(hl)		; $39b6
	ld (de),a		; $39b7
	inc e			; $39b8
	call $39c0		; $39b9
	dec b			; $39bc
	jr nz,_label_00_381	; $39bd
	ret			; $39bf
	ld a,e			; $39c0
	and $0f			; $39c1
	cp $0a			; $39c3
	ret c			; $39c5
	ld a,$06		; $39c6
	add e			; $39c8
	ld e,a			; $39c9
	ret			; $39ca
_label_00_382:
	ld b,$08		; $39cb
_label_00_383:
	srl c			; $39cd
	jr c,_label_00_384	; $39cf
	ldi a,(hl)		; $39d1
	jr _label_00_385		; $39d2
_label_00_384:
	ldh a,(<hFF8B)	; $39d4
_label_00_385:
	ld (de),a		; $39d6
	inc e			; $39d7
	call $39c0		; $39d8
	dec b			; $39db
	jr nz,_label_00_383	; $39dc
	ret			; $39de
	push de			; $39df
	ldh a,(<hFF8C)	; $39e0
	bit 7,h			; $39e2
	jr z,_label_00_386	; $39e4
	ld a,h			; $39e6
	xor $c0			; $39e7
	ld h,a			; $39e9
	ldh a,(<hFF8C)	; $39ea
	inc a			; $39ec
	ldh (<hFF8C),a	; $39ed
_label_00_386:
	ldh (<hRomBank),a	; $39ef
	ld ($2222),a		; $39f1
	ld b,$b0		; $39f4
	ld de,$ce00		; $39f6
_label_00_387:
	call readByteSequential		; $39f9
	ld (de),a		; $39fc
	inc e			; $39fd
	dec b			; $39fe
	jr nz,_label_00_387	; $39ff
	ld hl,$ce00		; $3a01
	pop de			; $3a04
	ret			; $3a05

generateVramTilesWithRoomChanges:
	ld a,($ff00+$70)	; $3a06
	ld c,a			; $3a08
	ldh a,(<hRomBank)	; $3a09
	ld b,a			; $3a0b
	push bc			; $3a0c
	ld a,$04		; $3a0d
	ldh (<hRomBank),a	; $3a0f
	ld ($2222),a		; $3a11
	call $6ae4		; $3a14
	call $66ef		; $3a17
	pop bc			; $3a1a
	ld a,b			; $3a1b
	ldh (<hRomBank),a	; $3a1c
	ld ($2222),a		; $3a1e
	ld a,c			; $3a21
	ld ($ff00+$70),a	; $3a22
	ret			; $3a24

getTileMappingData:
	ld c,a			; $3a25
	ld a,($ff00+$70)	; $3a26
	push af			; $3a28
	ld a,$03		; $3a29
	ld ($ff00+$70),a	; $3a2b
	ld a,c			; $3a2d
	call setHlToTileMappingDataPlusATimes8		; $3a2e
	push de			; $3a31
	ld de,$cec0		; $3a32
	ld b,$08		; $3a35
_label_00_388:
	ldi a,(hl)		; $3a37
	ld (de),a		; $3a38
	inc e			; $3a39
	dec b			; $3a3a
	jr nz,_label_00_388	; $3a3b
	pop de			; $3a3d
	ld a,($cec4)		; $3a3e
	ld b,a			; $3a41
	ld a,($cec0)		; $3a42
	ld c,a			; $3a45
	pop af			; $3a46
	ld ($ff00+$70),a	; $3a47
	ret			; $3a49

setHlToTileMappingDataPlusATimes8:
	call multiplyABy8		; $3a4a
	ld hl,$d000		; $3a4d
	add hl,bc		; $3a50
	ret			; $3a51

setTile:
	ld b,a			; $3a52
	ld a,($ccf6)		; $3a53
	inc a			; $3a56
	and $1f			; $3a57
	ld e,a			; $3a59
	ld a,($ccf5)		; $3a5a
	cp e			; $3a5d
	ret z			; $3a5e
	ld a,e			; $3a5f
	ld ($ccf6),a		; $3a60
	ld a,($ff00+$70)	; $3a63
	push af			; $3a65
	ld a,$02		; $3a66
	ld ($ff00+$70),a	; $3a68
	ld a,e			; $3a6a
	add a			; $3a6b
	ld hl,$dac0		; $3a6c
	rst_addAToHl			; $3a6f
	ld (hl),b		; $3a70
	inc l			; $3a71
	ld (hl),c		; $3a72
	ld a,b			; $3a73
	call setTileWithoutGfxReload		; $3a74
	pop af			; $3a77
	ld ($ff00+$70),a	; $3a78
	or h			; $3a7a
	ret			; $3a7b

setInterleavedTile:
	push de			; $3a7c
	ld e,a			; $3a7d
	ld a,($ff00+$70)	; $3a7e
	ld c,a			; $3a80
	ldh a,(<hRomBank)	; $3a81
	ld b,a			; $3a83
	push bc			; $3a84
	ld a,$04		; $3a85
	ldh (<hRomBank),a	; $3a87
	ld ($2222),a		; $3a89
	ld a,e			; $3a8c
	call $6ba6		; $3a8d
	pop bc			; $3a90
	ld a,b			; $3a91
	ldh (<hRomBank),a	; $3a92
	ld ($2222),a		; $3a94
	ld a,c			; $3a97
	ld ($ff00+$70),a	; $3a98
	pop de			; $3a9a
	ret			; $3a9b

seasonsFunc_3a9c:
	ld b,a			; $3a9c
	ld a,($cc49)		; $3a9d
	or a			; $3aa0
	ret nz			; $3aa1
	ld a,($cc4d)		; $3aa2
	cp $f1			; $3aa5
	ret nc			; $3aa7
	ld a,b			; $3aa8
	ld ($cc4e),a		; $3aa9
	ld a,$02		; $3aac
	ld ($cc68),a		; $3aae
	ret			; $3ab1

seasonsFunc_3ab2:
	ldh a,(<hRomBank)	; $3ab2
	push af			; $3ab4
	ld a,$01		; $3ab5
	ldh (<hRomBank),a	; $3ab7
	ld ($2222),a		; $3ab9
	call $7e6e		; $3abc
	pop af			; $3abf
	ldh (<hRomBank),a	; $3ac0
	ld ($2222),a		; $3ac2
	ret			; $3ac5

getFreeInteractionSlot:
	ld hl,$d240		; $3ac6
_label_00_389:
	ld a,(hl)		; $3ac9
	or a			; $3aca
	jr z,_label_00_390	; $3acb
	inc h			; $3acd
	ld a,h			; $3ace
	cp $e0			; $3acf
	jr c,_label_00_389	; $3ad1
	or h			; $3ad3
	ret			; $3ad4
_label_00_390:
	inc (hl)		; $3ad5
	inc l			; $3ad6
	xor a			; $3ad7
	ret			; $3ad8

interactionDelete:
	ld h,d			; $3ad9
	ld l,$40		; $3ada
	ld b,$10		; $3adc
	xor a			; $3ade
_label_00_391:
	ldi (hl),a		; $3adf
	ldi (hl),a		; $3ae0
	ldi (hl),a		; $3ae1
	ldi (hl),a		; $3ae2
	dec b			; $3ae3
	jr nz,_label_00_391	; $3ae4
	ret			; $3ae6
_label_00_392:

_updateInteractionsIfStateIsZero:
	ld a,$40		; $3ae7
	ldh (<hActiveObjectType),a	; $3ae9
	ld a,$d0		; $3aeb
_label_00_393:
	ldh (<hActiveObject),a	; $3aed
	ld d,a			; $3aef
	ld e,$40		; $3af0
	ld a,(de)		; $3af2
	or a			; $3af3
	jr z,_label_00_395	; $3af4
	rlca			; $3af6
	jr c,_label_00_394	; $3af7
	ld e,$44		; $3af9
	ld a,(de)		; $3afb
	or a			; $3afc
	jr nz,_label_00_395	; $3afd
_label_00_394:
	call updateInteraction		; $3aff
_label_00_395:
	ldh a,(<hActiveObject)	; $3b02
	inc a			; $3b04
	cp $e0			; $3b05
	jr c,_label_00_393	; $3b07
	ret			; $3b09

updateInteractions:
	ld a,($cd00)		; $3b0a
	cp $08			; $3b0d
	jr z,_label_00_392	; $3b0f
	ld a,($cca4)		; $3b11
	and $02			; $3b14
	jr nz,_label_00_392	; $3b16
	ld a,($cba0)		; $3b18
	or a			; $3b1b
	jr nz,_label_00_392	; $3b1c
	ld a,$40		; $3b1e
	ldh (<hActiveObjectType),a	; $3b20
	ld a,$d0		; $3b22
_label_00_396:
	ldh (<hActiveObject),a	; $3b24
	ld d,a			; $3b26
	ld e,$40		; $3b27
	ld a,(de)		; $3b29
	or a			; $3b2a
	call nz,updateInteraction		; $3b2b
	ldh a,(<hActiveObject)	; $3b2e
	inc a			; $3b30
	cp $e0			; $3b31
	jr c,_label_00_396	; $3b33
	ret			; $3b35

updateInteraction:
	ld e,$41		; $3b36
	ld a,(de)		; $3b38
	ld b,$08		; $3b39
	cp $5e			; $3b3b
	jr c,_label_00_397	; $3b3d
	inc b			; $3b3f
	cp $89			; $3b40
	jr c,_label_00_397	; $3b42
	inc b			; $3b44
	cp $c8			; $3b45
	jr c,_label_00_397	; $3b47
	ld b,$0f		; $3b49
	cp $d8			; $3b4b
	jr c,_label_00_397	; $3b4d
	ld b,$15		; $3b4f
_label_00_397:
	ld a,b			; $3b51
	ldh (<hRomBank),a	; $3b52
	ld ($2222),a		; $3b54
	ld a,(de)		; $3b57
	ld hl,interactionCodeTable		; $3b58
	rst_addDoubleIndex			; $3b5b
	ldi a,(hl)		; $3b5c
	ld h,(hl)		; $3b5d
	ld l,a			; $3b5e
	jp hl			; $3b5f

interactionCodeTable:
	nop			; $3b60
	ld b,b			; $3b61
	nop			; $3b62
	ld b,b			; $3b63
	nop			; $3b64
	ld b,b			; $3b65
	nop			; $3b66
	ld b,b			; $3b67
	nop			; $3b68
	ld b,b			; $3b69
	nop			; $3b6a
	ld b,b			; $3b6b
	nop			; $3b6c
	ld b,b			; $3b6d
	nop			; $3b6e
	ld b,b			; $3b6f
	nop			; $3b70
	ld b,b			; $3b71
	nop			; $3b72
	ld b,b			; $3b73
	nop			; $3b74
	ld b,b			; $3b75
	nop			; $3b76
	ld b,b			; $3b77
	nop			; $3b78
	ld b,b			; $3b79
	reti			; $3b7a
	ldd a,(hl)		; $3b7b
	reti			; $3b7c
	ldd a,(hl)		; $3b7d
	and b			; $3b7e
	ld b,b			; $3b7f
	stop			; $3b80
	ld b,c			; $3b81
	ld b,a			; $3b82
	ld b,c			; $3b83
	ld c,a			; $3b84
	ld b,c			; $3b85
	ld a,(hl)		; $3b86
	ld b,d			; $3b87
	pop hl			; $3b88
	ld b,d			; $3b89
	jr c,$51		; $3b8a
	dec sp			; $3b8c
	ld b,h			; $3b8d
.DB $e3				; $3b8e
	ld b,h			; $3b8f
	ld c,b			; $3b90
	ld b,l			; $3b91
	reti			; $3b92
	ldd a,(hl)		; $3b93
	reti			; $3b94
	ldd a,(hl)		; $3b95
	reti			; $3b96
	ldd a,(hl)		; $3b97
	ld a,(hl)		; $3b98
	ld b,l			; $3b99
	and b			; $3b9a
	ld b,l			; $3b9b
	daa			; $3b9c
	ld b,(hl)		; $3b9d
	ld l,h			; $3b9e
	ld d,c			; $3b9f
	call nc,$c352		; $3ba0
	ld d,e			; $3ba3
	add sp,$54		; $3ba4
	ld h,l			; $3ba6
	ld d,(hl)		; $3ba7
	or l			; $3ba8
	ld d,(hl)		; $3ba9
	ld c,$5a		; $3baa
	ld c,$5a		; $3bac
.DB $fc				; $3bae
	ld e,d			; $3baf
.DB $eb				; $3bb0
	ld e,e			; $3bb1
	or l			; $3bb2
	ld d,(hl)		; $3bb3
	sbc e			; $3bb4
	ld e,h			; $3bb5
	cpl			; $3bb6
	ld e,(hl)		; $3bb7
	or l			; $3bb8
	ld d,(hl)		; $3bb9
	or l			; $3bba
	ld d,(hl)		; $3bbb
	sbc d			; $3bbc
	ld e,(hl)		; $3bbd
	or l			; $3bbe
	ld d,(hl)		; $3bbf
	adc b			; $3bc0
	ld e,a			; $3bc1
	call $1660		; $3bc2
	ld h,e			; $3bc5
	or l			; $3bc6
	ld d,(hl)		; $3bc7
	ld a,c			; $3bc8
	ld h,e			; $3bc9
	sub d			; $3bca
	ld h,e			; $3bcb
	or l			; $3bcc
	ld d,(hl)		; $3bcd
	or l			; $3bce
	ld d,(hl)		; $3bcf
	or l			; $3bd0
	ld d,(hl)		; $3bd1
	or l			; $3bd2
	ld d,(hl)		; $3bd3
	or l			; $3bd4
	ld d,(hl)		; $3bd5
	cp $66			; $3bd6
	or l			; $3bd8
	ld d,(hl)		; $3bd9
	or l			; $3bda
	ld d,(hl)		; $3bdb
	jr z,_label_00_398	; $3bdc
	or l			; $3bde
	ld d,(hl)		; $3bdf
	dec e			; $3be0
	ld l,e			; $3be1
	dec e			; $3be2
	ld l,e			; $3be3
.DB $dd				; $3be4
	ld l,h			; $3be5
	jr $6d			; $3be6
.DB $ec				; $3be8
	ld l,l			; $3be9
	or a			; $3bea
	ld l,(hl)		; $3beb
	or b			; $3bec
	ld b,a			; $3bed
	pop bc			; $3bee
	ld c,d			; $3bef
	ld e,c			; $3bf0
	ld l,a			; $3bf1
	ld (hl),l		; $3bf2
	ld (hl),b		; $3bf3
	ld e,d			; $3bf4
	ld c,l			; $3bf5
	bit 6,c			; $3bf6
	add b			; $3bf8
	ld (hl),d		; $3bf9
	ld l,(hl)		; $3bfa
	ld (hl),e		; $3bfb
	jr _label_00_399		; $3bfc
	jr nz,_label_00_400	; $3bfe
	ld h,h			; $3c00
	ld c,a			; $3c01
	dec a			; $3c02
	ld a,d			; $3c03
	dec b			; $3c04
	ld a,e			; $3c05
	ldi a,(hl)		; $3c06
	ld a,e			; $3c07
	call c,$2b7b		; $3c08
	ld a,h			; $3c0b
	dec d			; $3c0c
	ld d,c			; $3c0d
	ldi (hl),a		; $3c0e
	ld a,l			; $3c0f
	sbc a			; $3c10
	ld a,l			; $3c11
	ld c,e			; $3c12
	ld a,(hl)		; $3c13
	sub b			; $3c14
	ld a,(hl)		; $3c15
	dec h			; $3c16
	ld a,a			; $3c17
	ld l,(hl)		; $3c18
	ld a,a			; $3c19
	sbc e			; $3c1a
	ld a,a			; $3c1b
	adc $4b			; $3c1c
	inc b			; $3c1e
	ld c,l			; $3c1f
	nop			; $3c20
	ld b,b			; $3c21
	reti			; $3c22
	ldd a,(hl)		; $3c23
	ld c,(hl)		; $3c24
	ld c,a			; $3c25
	add c			; $3c26
	ld d,b			; $3c27
.DB $eb				; $3c28
	ld d,b			; $3c29
	ld h,b			; $3c2a
	ld d,c			; $3c2b
	ld l,h			; $3c2c
	ld d,l			; $3c2d
	call z,$0456		; $3c2e
	ld e,b			; $3c31
	dec e			; $3c32
	ld e,c			; $3c33
	and $5b			; $3c34
	xor $60			; $3c36
	add l			; $3c38
	ld h,a			; $3c39
	adc l			; $3c3a
	ld h,a			; $3c3b
	ldi (hl),a		; $3c3c
	ld l,e			; $3c3d
	ld b,b			; $3c3e
	ld b,e			; $3c3f
	ldd a,(hl)		; $3c40
	ld l,h			; $3c41
	adc (hl)		; $3c42
	ld l,h			; $3c43
	adc h			; $3c44
	ld l,a			; $3c45
_label_00_398:
	ld e,a			; $3c46
	ld (hl),b		; $3c47
	push hl			; $3c48
	ld (hl),c		; $3c49
	sbc c			; $3c4a
	ld (hl),d		; $3c4b
	ld h,$73		; $3c4c
	sbc b			; $3c4e
	ld (hl),h		; $3c4f
	ld d,$44		; $3c50
	ld a,b			; $3c52
	ld b,h			; $3c53
	jr z,$45		; $3c54
	ld a,($ff00+c)		; $3c56
	ld (hl),h		; $3c57
	ld a,($bf75)		; $3c58
	ld b,(hl)		; $3c5b
	ld h,l			; $3c5c
	ld c,b			; $3c5d
	xor l			; $3c5e
	ld c,c			; $3c5f
.DB $eb				; $3c60
	halt			; $3c61
	dec l			; $3c62
	ld (hl),a		; $3c63
	or d			; $3c64
	ld a,c			; $3c65
	cp d			; $3c66
	ld a,d			; $3c67
	ld h,c			; $3c68
	ld a,e			; $3c69
	rra			; $3c6a
	ld a,h			; $3c6b
	ld d,a			; $3c6c
	ld a,h			; $3c6d
	inc d			; $3c6e
	ld a,l			; $3c6f
	ld h,$7e		; $3c70
	nop			; $3c72
_label_00_399:
	ld b,b			; $3c73
	jp c,$da4b		; $3c74
_label_00_400:
	ld c,e			; $3c77
	ld l,d			; $3c78
	ld c,h			; $3c79
	jp c,$294b		; $3c7a
	ld c,a			; $3c7d
	ld e,b			; $3c7e
	ld c,a			; $3c7f
	sub c			; $3c80
	ld c,a			; $3c81
	rst $20			; $3c82
	ld b,c			; $3c83
	ccf			; $3c84
	ld d,d			; $3c85
	ld e,a			; $3c86
	ld d,d			; $3c87
	ld b,(hl)		; $3c88
	ld d,e			; $3c89
	ld hl,$c554		; $3c8a
	ld d,l			; $3c8d
.DB $e4				; $3c8e
	ld d,a			; $3c8f
	xor b			; $3c90
	ld b,d			; $3c91
	ld d,b			; $3c92
	ld e,b			; $3c93
	adc e			; $3c94
	ld e,b			; $3c95
	ld (de),a		; $3c96
	ld e,e			; $3c97
.DB $ec				; $3c98
	ld e,e			; $3c99
	ld l,$5d		; $3c9a
	ld ($ff00+c),a		; $3c9c
	ld e,(hl)		; $3c9d
	ld a,($ff00+$42)	; $3c9e
	dec a			; $3ca0
	ld b,e			; $3ca1
	ld (hl),l		; $3ca2
	ld h,b			; $3ca3
	add hl,hl		; $3ca4
	ld h,c			; $3ca5
	sub $61			; $3ca6
	ld ($4063),a		; $3ca8
	ld h,h			; $3cab
	dec e			; $3cac
	ld h,a			; $3cad
	ld l,a			; $3cae
	ld h,a			; $3caf
	rst $20			; $3cb0
	ld h,a			; $3cb1
	or l			; $3cb2
	ld l,b			; $3cb3
	ld b,e			; $3cb4
	ld l,c			; $3cb5
	ld l,a			; $3cb6
	ld l,c			; $3cb7
	and b			; $3cb8
	ld b,e			; $3cb9
	add hl,sp		; $3cba
	ld l,d			; $3cbb
	di			; $3cbc
	ld l,d			; $3cbd
	ld e,d			; $3cbe
	ld l,l			; $3cbf
	di			; $3cc0
	ld l,l			; $3cc1
	ld l,h			; $3cc2
	ld l,(hl)		; $3cc3
	ld a,(hl)		; $3cc4
	ld l,(hl)		; $3cc5
	adc c			; $3cc6
	ld l,a			; $3cc7
	ldi a,(hl)		; $3cc8
	ld (hl),b		; $3cc9
	add hl,hl		; $3cca
	ld (hl),e		; $3ccb
	sbc l			; $3ccc
	ld b,(hl)		; $3ccd
	inc h			; $3cce
	ld c,e			; $3ccf
	and (hl)		; $3cd0
	ld (hl),e		; $3cd1
	inc a			; $3cd2
	ld (hl),h		; $3cd3
	add d			; $3cd4
	ld (hl),l		; $3cd5
	cp c			; $3cd6
	ld (hl),l		; $3cd7
	pop af			; $3cd8
	ld (hl),a		; $3cd9
	pop af			; $3cda
	ld (hl),a		; $3cdb
	pop af			; $3cdc
	ld (hl),a		; $3cdd
	rlca			; $3cde
	ld a,c			; $3cdf
	dec (hl)		; $3ce0
	ld c,e			; $3ce1
	ld h,d			; $3ce2
	ld a,c			; $3ce3
	sbc $79			; $3ce4
	ei			; $3ce6
	ld a,c			; $3ce7
	ldd (hl),a		; $3ce8
	ld a,d			; $3ce9
	or h			; $3cea
	ld a,d			; $3ceb
	ld d,c			; $3cec
	ld a,e			; $3ced
	adc c			; $3cee
	ld c,e			; $3cef
	add h			; $3cf0
	ld a,b			; $3cf1
	ld ($4578),a		; $3cf2
	ld a,c			; $3cf5
	cp l			; $3cf6
	ld a,d			; $3cf7
	dec e			; $3cf8
	ld a,l			; $3cf9
	rst $8			; $3cfa
	ld a,l			; $3cfb
	nop			; $3cfc
	ld (hl),h		; $3cfd
	rst $8			; $3cfe
	ld (hl),l		; $3cff
	ld hl,sp+$75		; $3d00
.DB $dd				; $3d02
	halt			; $3d03
	rst $30			; $3d04
	halt			; $3d05
	ld l,h			; $3d06
	ld (hl),a		; $3d07
	ld hl,$8978		; $3d08
	ld a,(hl)		; $3d0b
	daa			; $3d0c
	ld a,a			; $3d0d
	sbc d			; $3d0e
	ld a,a			; $3d0f
	jp nc,$c465		; $3d10
	ld c,c			; $3d13
	xor h			; $3d14
	ld c,e			; $3d15
	cp $65			; $3d16
	ld l,c			; $3d18
	ld h,(hl)		; $3d19
	sub h			; $3d1a
	ld l,d			; $3d1b
	rst_addDoubleIndex			; $3d1c
	ld l,d			; $3d1d
	ld ($066c),a		; $3d1e
	ld c,h			; $3d21
	call c,$5c6d		; $3d22
	ld c,h			; $3d25
	jr z,$6e		; $3d26
	ld ($566e),a		; $3d28
	ld c,l			; $3d2b
	ld e,(hl)		; $3d2c
	ld l,a			; $3d2d
	ld h,(hl)		; $3d2e
	ld (hl),c		; $3d2f

seasonsFunc_3d30:
	ld a,(wFrameCounter)		; $3d30
	and $3f			; $3d33
	ret nz			; $3d35
	ld b,$fa		; $3d36
	ld c,$fc		; $3d38
	jp objectCreateFloatingSnore		; $3d3a

seasonsFunc_3d3d:
	ldh a,(<hRomBank)	; $3d3d
	push af			; $3d3f
	ld a,$0a		; $3d40
	ldh (<hRomBank),a	; $3d42
	ld ($2222),a		; $3d44
	call $7a7b		; $3d47
	push af			; $3d4a
	pop bc			; $3d4b
	pop af			; $3d4c
	ldh (<hRomBank),a	; $3d4d
	ld ($2222),a		; $3d4f
	ret			; $3d52

interactionSetSimpleScript:
	ld e,$58		; $3d53
	ld a,l			; $3d55
	ld (de),a		; $3d56
	inc e			; $3d57
	ld a,h			; $3d58
	ld (de),a		; $3d59
	ret			; $3d5a

interactionRunSimpleScript:
	ldh a,(<hRomBank)	; $3d5b
	push af			; $3d5d
	ld a,$14		; $3d5e
	ldh (<hRomBank),a	; $3d60
	ld ($2222),a		; $3d62
	ld h,d			; $3d65
	ld l,$58		; $3d66
	ldi a,(hl)		; $3d68
	ld h,(hl)		; $3d69
	ld l,a			; $3d6a
_label_00_401:
	ld a,(hl)		; $3d6b
	or a			; $3d6c
	jr z,_label_00_402	; $3d6d
	call $3d87		; $3d6f
	jr c,_label_00_401	; $3d72
	call interactionSetSimpleScript		; $3d74
	pop af			; $3d77
	ldh (<hRomBank),a	; $3d78
	ld ($2222),a		; $3d7a
	xor a			; $3d7d
	ret			; $3d7e
_label_00_402:
	pop af			; $3d7f
	ldh (<hRomBank),a	; $3d80
	ld ($2222),a		; $3d82
	scf			; $3d85
	ret			; $3d86
	ldi a,(hl)		; $3d87
	push hl			; $3d88
	rst_jumpTable			; $3d89
	sbc h			; $3d8a
	dec a			; $3d8b
	sbc (hl)		; $3d8c
	dec a			; $3d8d
	and l			; $3d8e
	dec a			; $3d8f
	xor l			; $3d90
	dec a			; $3d91
	cp b			; $3d92
	dec a			; $3d93
	jp z,$063d		; $3d94
	ld a,$e1		; $3d97
	dec a			; $3d99
	ld b,$3e		; $3d9a
	pop hl			; $3d9c
	ret			; $3d9d
	pop hl			; $3d9e
	ldi a,(hl)		; $3d9f
	ld e,$46		; $3da0
	ld (de),a		; $3da2
	xor a			; $3da3
	ret			; $3da4
	pop hl			; $3da5
	ldi a,(hl)		; $3da6
	push hl			; $3da7
	call playSound		; $3da8
	pop hl			; $3dab
	ret			; $3dac
	pop hl			; $3dad
	ldi a,(hl)		; $3dae
	ld c,a			; $3daf
	ldi a,(hl)		; $3db0
	push hl			; $3db1
	call setTile		; $3db2
	pop hl			; $3db5
	scf			; $3db6
	ret			; $3db7
	pop hl			; $3db8
	ldi a,(hl)		; $3db9
	ldh (<hFF8C),a	; $3dba
	ldi a,(hl)		; $3dbc
	ldh (<hFF8F),a	; $3dbd
	ldi a,(hl)		; $3dbf
	ldh (<hFF8E),a	; $3dc0
	ldi a,(hl)		; $3dc2
	push hl			; $3dc3
	call setInterleavedTile		; $3dc4
	pop hl			; $3dc7
	scf			; $3dc8
	ret			; $3dc9
	pop hl			; $3dca
	ldi a,(hl)		; $3dcb
	ld b,a			; $3dcc
	ldi a,(hl)		; $3dcd
	ld c,a			; $3dce
	ldi a,(hl)		; $3dcf
	ldh (<hFF8B),a	; $3dd0
	push hl			; $3dd2
_label_00_403:
	push bc			; $3dd3
	ldh a,(<hFF8B)	; $3dd4
	call setTile		; $3dd6
	pop bc			; $3dd9
	inc c			; $3dda
	dec b			; $3ddb
	jr nz,_label_00_403	; $3ddc
	pop hl			; $3dde
	scf			; $3ddf
	ret			; $3de0
	pop hl			; $3de1
	ldi a,(hl)		; $3de2
	ld b,a			; $3de3
	ldi a,(hl)		; $3de4
	ldh (<hFF8C),a	; $3de5
	ldi a,(hl)		; $3de7
	ldh (<hFF8E),a	; $3de8
	ldi a,(hl)		; $3dea
	ldh (<hFF8D),a	; $3deb
	push hl			; $3ded
_label_00_404:
	push bc			; $3dee
	ld b,$cf		; $3def
	ldh a,(<hFF8C)	; $3df1
	ld c,a			; $3df3
	ld a,(bc)		; $3df4
	ldh (<hFF8F),a	; $3df5
	ldh a,(<hFF8D)	; $3df7
	call setInterleavedTile		; $3df9
	ld hl,$ff8c		; $3dfc
	inc (hl)		; $3dff
	pop bc			; $3e00
	dec b			; $3e01
	jr nz,_label_00_404	; $3e02
	pop hl			; $3e04
	scf			; $3e05
	ret			; $3e06

seasonsFunc_3e07:
	ldh a,(<hRomBank)	; $3e07
	push af			; $3e09
	ld a,$08		; $3e0a
	ldh (<hRomBank),a	; $3e0c
	ld ($2222),a		; $3e0e
	call $57db		; $3e11
	ld c,$01		; $3e14
	jr c,_label_00_405	; $3e16
	dec c			; $3e18
_label_00_405:
	pop af			; $3e19
	ldh (<hRomBank),a	; $3e1a
	ld ($2222),a		; $3e1c
	ret			; $3e1f

seasonsFunc_3e20:
	ldh a,(<hRomBank)	; $3e20
	push af			; $3e22
	ld a,$09		; $3e23
	ldh (<hRomBank),a	; $3e25
	ld ($2222),a		; $3e27
	call $7d8b		; $3e2a
	ld a,$15		; $3e2d
	ldh (<hRomBank),a	; $3e2f
	ld ($2222),a		; $3e31
	call $60fc		; $3e34
	pop af			; $3e37
	ldh (<hRomBank),a	; $3e38
	ld ($2222),a		; $3e3a
	ret			; $3e3d

seasonsFunc_3e3e:
	ldh a,(<hRomBank)	; $3e3e
	push af			; $3e40
	ld a,$08		; $3e41
	ldh (<hRomBank),a	; $3e43
	ld ($2222),a		; $3e45
	call $5874		; $3e48
	pop af			; $3e4b
	ldh (<hRomBank),a	; $3e4c
	ld ($2222),a		; $3e4e
	ret			; $3e51

seasonsFunc_3e52:
	ldh a,(<hRomBank)	; $3e52
	push af			; $3e54
	ld a,$0a		; $3e55
	ldh (<hRomBank),a	; $3e57
	ld ($2222),a		; $3e59
	call $69d4		; $3e5c
	ld a,$01		; $3e5f
	call $69e7		; $3e61
	call $6a0a		; $3e64
	pop af			; $3e67
	ldh (<hRomBank),a	; $3e68
	ld ($2222),a		; $3e6a
	ret			; $3e6d

interactionFunc_3e6d:
	push de			; $3e6e
	ld l,$43		; $3e6f
	ld e,(hl)		; $3e71
	ldh a,(<hRomBank)	; $3e72
	push af			; $3e74
	ld a,$14		; $3e75
	ldh (<hRomBank),a	; $3e77
	ld ($2222),a		; $3e79
	ld a,e			; $3e7c
	ld hl,$4000		; $3e7d
	rst_addDoubleIndex			; $3e80
	ldi a,(hl)		; $3e81
	ld h,(hl)		; $3e82
	ld l,a			; $3e83
	call addSpritesToOam_withOffset		; $3e84
	pop af			; $3e87
	ldh (<hRomBank),a	; $3e88
	ld ($2222),a		; $3e8a
	pop de			; $3e8d
	ret			; $3e8e

seasonsFunc_3e8f:
	ldh a,(<hRomBank)	; $3e8f
	push af			; $3e91
	ld a,$04		; $3e92
	ldh (<hRomBank),a	; $3e94
	ld ($2222),a		; $3e96
	ld hl,$7655		; $3e99
	ld a,(hl)		; $3e9c
	ld ($cc64),a		; $3e9d
	pop af			; $3ea0
	ldh (<hRomBank),a	; $3ea1
	ld ($2222),a		; $3ea3
	ret			; $3ea6

getFreePartSlot:
	ld hl,$d0c0		; $3ea7
_label_00_406:
	ld a,(hl)		; $3eaa
	or a			; $3eab
	jr z,_label_00_407	; $3eac
	inc h			; $3eae
	ld a,h			; $3eaf
	cp $e0			; $3eb0
	jr c,_label_00_406	; $3eb2
	or h			; $3eb4
	ret			; $3eb5
_label_00_407:
	inc a			; $3eb6
	ldi (hl),a		; $3eb7
	xor a			; $3eb8
	ret			; $3eb9

partDelete:
	ld h,d			; $3eba
	ld l,$c0		; $3ebb
	ld b,$10		; $3ebd
	xor a			; $3ebf
_label_00_408:
	ldi (hl),a		; $3ec0
	ldi (hl),a		; $3ec1
	ldi (hl),a		; $3ec2
	ldi (hl),a		; $3ec3
	dec b			; $3ec4
	jr nz,_label_00_408	; $3ec5
	ret			; $3ec7


.BANK $01 SLOT 1
.ORG 0

	.include "code/bank1.s"


.BANK $02 SLOT 1
.ORG 0

	.include "code/bank2.s"


.BANK $03 SLOT 1
.ORG 0

init:
	di			; $4000
	xor a			; $4001
	ld ($ff00+$0f),a	; $4002
	ld ($ff00+$ff),a	; $4004
	ld ($ff00+$41),a	; $4006
	ld ($ff00+$07),a	; $4008
	ld ($ff00+$02),a	; $400a
	xor a			; $400c
	ld ($1111),a		; $400d
	call disableLcd		; $4010
	ldh a,(<hGameboyType)	; $4013
	or a			; $4015
	jr z,_label_03_000	; $4016
	xor a			; $4018
	ld ($ff00+$56),a	; $4019
	ld ($ff00+$70),a	; $401b
	ld ($ff00+$4f),a	; $401d
	call $4071		; $401f
_label_03_000:
	ld hl,$ff98		; $4022
	ld b,$26		; $4025
	call clearMemory		; $4027
	ld hl,$c2c0		; $402a
	ld bc,$1d3f		; $402d
	call clearMemoryBc		; $4030
	call clearVram		; $4033
	ld hl,$4091		; $4036
	ld de,$ff80		; $4039
	ld b,$0a		; $403c
	call copyMemory		; $403e
	ld a,$e4		; $4041
	ld ($ff00+$47),a	; $4043
	ld ($ff00+$48),a	; $4045
	ld a,$6c		; $4047
	ld ($ff00+$49),a	; $4049
	call initSound		; $404b
	ld a,$c7		; $404e
	ld ($ff00+$45),a	; $4050
	ld a,$40		; $4052
	ld ($ff00+$41),a	; $4054
	xor a			; $4056
	ld ($ff00+$0f),a	; $4057
	ld a,$0f		; $4059
	ld ($ff00+$ff),a	; $405b
	ld hl,$4000		; $405d
	ld e,$3f		; $4060
	call interBankCall		; $4062
	ei			; $4065
	ld hl,$4000		; $4066
	ld e,$02		; $4069
	call interBankCall		; $406b
	jp startGame		; $406e
	ld a,($ff00+$4d)	; $4071
	rlca			; $4073
	ret c			; $4074
	xor a			; $4075
	ld ($ff00+$0f),a	; $4076
	ld ($ff00+$ff),a	; $4078
	ld a,$01		; $407a
	ld ($ff00+$4d),a	; $407c
	ld a,$30		; $407e
	ld ($ff00+$00),a	; $4080
	stop			; $4082
	nop			; $4083
_label_03_001:
	ld a,($ff00+$4d)	; $4084
	rlca			; $4086
	jr nc,_label_03_001	; $4087
	xor a			; $4089
	ld ($ff00+$00),a	; $408a
	ld ($ff00+$0f),a	; $408c
	ld ($ff00+$ff),a	; $408e
	ret			; $4090
	ld a,$cb		; $4091
	ld ($ff00+$46),a	; $4093
	ld a,$28		; $4095
_label_03_002:
	dec a			; $4097
	jr nz,_label_03_002	; $4098
	ret			; $409a


; Speed table for objects.
;
; It's organized in a sort of complicated way which allows it to reuse certain sin and cos
; values for certain angles, ie. an angle of $08 (right) uses the same values for its
; Y speed as angle $00 (up) does for its X speed. Due to this, there is an extra .dwsin
; line at the end of each repetition which is used for angle $18-$1f's X positions only.
;
; @addr{409b}
objectSpeedTable:
	.define TMP_SPEED $20

	.rept 24
		; Calculate 8 sin/cos values per line at increments of 11.25 degrees
		.dwsin 090 7 11.25 (-TMP_SPEED) 0 ; $00 <- angle
		.dwcos 090 7 11.25 (-TMP_SPEED) 0 ; $08
		.dwsin 270 7 11.25 (-TMP_SPEED) 0 ; $10
		.dwcos 270 7 11.25 (-TMP_SPEED) 0 ; $18
		.dwsin 090 7 11.25 (-TMP_SPEED) 0

		.redefine TMP_SPEED TMP_SPEED+$20
	.endr

	.undefine TMP_SPEED


generateGameTransferSecret:
	ld hl,$c612		; $481b
	ldi a,(hl)		; $481e
	ld b,(hl)		; $481f
	ld c,a			; $4820
	push bc			; $4821
	or b			; $4822
	ldd (hl),a		; $4823
	xor $01			; $4824
	or b			; $4826
	ld (hl),a		; $4827
	ld bc,$0000		; $4828
	call $4836		; $482b
	pop bc			; $482e
	ld hl,$c612		; $482f
	ld (hl),c		; $4832
	inc l			; $4833
	ld (hl),b		; $4834
	ret			; $4835
	push de			; $4836
	ld a,($ff00+$70)	; $4837
	push af			; $4839
	ld a,$07		; $483a
	ld ($ff00+$70),a	; $483c
	call $4846		; $483e
	pop af			; $4841
	ld ($ff00+$70),a	; $4842
	pop de			; $4844
	ret			; $4845
	ld a,b			; $4846
	rst_jumpTable			; $4847
	ld d,d			; $4848
	ld c,b			; $4849
	push hl			; $484a
	ld c,b			; $484b
	and h			; $484c
	ld c,c			; $484d
	cp (hl)			; $484e
	ld c,c			; $484f
	ld h,b			; $4850
	ld c,c			; $4851
	ld hl,$d460		; $4852
	ld b,$40		; $4855
	call clearMemory		; $4857
	call $4a7d		; $485a
	call $49be		; $485d
	call $4887		; $4860
	ld hl,$c6e8		; $4863
	ldi (hl),a		; $4866
	ld (hl),c		; $4867
	ld a,$04		; $4868
	call $48a8		; $486a
	call $48a7		; $486d
	ld b,$04		; $4870
	xor a			; $4872
	call $48c1		; $4873
	call $4a5b		; $4876
	ld hl,$d48b		; $4879
	or (hl)			; $487c
	ld (hl),a		; $487d
	call $4a69		; $487e
	call $4a3e		; $4881
	jp $49d9		; $4884
	push bc			; $4887
	ld hl,$c600		; $4888
	ldi a,(hl)		; $488b
	add (hl)		; $488c
	ld b,a			; $488d
	ld a,c			; $488e
	cp $03			; $488f
	ld a,b			; $4891
	jr nz,_label_03_017	; $4892
	ld l,$e6		; $4894
	ld a,(hl)		; $4896
	swap a			; $4897
	and $0f			; $4899
	add b			; $489b
	ld b,a			; $489c
	ld a,(hl)		; $489d
	and $01			; $489e
	rlca			; $48a0
	rlca			; $48a1
	xor b			; $48a2
_label_03_017:
	and $07			; $48a3
	pop bc			; $48a5
	ret			; $48a6
	ld a,c			; $48a7
	push bc			; $48a8
	ld hl,$4a82		; $48a9
	rst_addDoubleIndex			; $48ac
	ldi a,(hl)		; $48ad
	ld h,(hl)		; $48ae
	ld l,a			; $48af
	ldi a,(hl)		; $48b0
	ld c,a			; $48b1
_label_03_018:
	ldi a,(hl)		; $48b2
	ld e,a			; $48b3
	ldi a,(hl)		; $48b4
	ld b,a			; $48b5
	ld d,$c6		; $48b6
	ld a,(de)		; $48b8
	call $48c1		; $48b9
	dec c			; $48bc
	jr nz,_label_03_018	; $48bd
	pop bc			; $48bf
	ret			; $48c0
	push hl			; $48c1
	push bc			; $48c2
	ld c,a			; $48c3
_label_03_019:
	ld hl,$d48b		; $48c4
	ld e,$14		; $48c7
	srl c			; $48c9
_label_03_020:
	ld a,(hl)		; $48cb
	rla			; $48cc
	ldd (hl),a		; $48cd
	rla			; $48ce
	rla			; $48cf
	dec e			; $48d0
	jr nz,_label_03_020	; $48d1
	dec b			; $48d3
	jr nz,_label_03_019	; $48d4
	ld hl,$d478		; $48d6
	ld de,$3f14		; $48d9
_label_03_021:
	ld a,(hl)		; $48dc
	and d			; $48dd
	ldi (hl),a		; $48de
	dec e			; $48df
	jr nz,_label_03_021	; $48e0
	pop bc			; $48e2
	pop hl			; $48e3
	ret			; $48e4
	ld hl,$d460		; $48e5
	ld b,$40		; $48e8
	call clearMemory		; $48ea
	call $4a7d		; $48ed
	call $4a15		; $48f0
	jr c,_label_03_022	; $48f3
	call $4a3e		; $48f5
	call $4ace		; $48f8
	ld hl,$d477		; $48fb
	rst_addAToHl			; $48fe
	ld a,(hl)		; $48ff
	and $0f			; $4900
	ld e,a			; $4902
	xor (hl)		; $4903
	ld (hl),a		; $4904
	call $4a5b		; $4905
	cp e			; $4908
	jr nz,_label_03_022	; $4909
	call $491a		; $490b
	ld a,($cec1)		; $490e
	cp c			; $4911
	jr nz,_label_03_022	; $4912
	ld b,$00		; $4914
	ret			; $4916
_label_03_022:
	ld b,$01		; $4917
	ret			; $4919
	ld de,$cec0		; $491a
	ld a,$04		; $491d
	call $4923		; $491f
	ld a,c			; $4922
	ld hl,$4a82		; $4923
	rst_addDoubleIndex			; $4926
	ldi a,(hl)		; $4927
	ld h,(hl)		; $4928
	ld l,a			; $4929
	ldi a,(hl)		; $492a
	ld b,a			; $492b
_label_03_023:
	inc hl			; $492c
	ldi a,(hl)		; $492d
	call $4937		; $492e
	ld (de),a		; $4931
	inc de			; $4932
	dec b			; $4933
	jr nz,_label_03_023	; $4934
	ret			; $4936
	push bc			; $4937
	push de			; $4938
	push hl			; $4939
	ld b,a			; $493a
	ld c,a			; $493b
	ld d,$00		; $493c
_label_03_024:
	ld hl,$d48b		; $493e
	ld e,$14		; $4941
_label_03_025:
	rl (hl)			; $4943
	ld a,(hl)		; $4945
	rla			; $4946
	rla			; $4947
	dec hl			; $4948
	dec e			; $4949
	jr nz,_label_03_025	; $494a
	rr d			; $494c
	dec b			; $494e
	jr nz,_label_03_024	; $494f
	ld a,$08		; $4951
	sub c			; $4953
	ld b,a			; $4954
	ld a,d			; $4955
	jr z,_label_03_027	; $4956
_label_03_026:
	rrca			; $4958
	dec b			; $4959
	jr nz,_label_03_026	; $495a
_label_03_027:
	pop hl			; $495c
	pop de			; $495d
	pop bc			; $495e
	ret			; $495f
	call $4a7d		; $4960
	rst_jumpTable			; $4963
	ld l,h			; $4964
	ld c,c			; $4965
	ld l,h			; $4966
	ld c,c			; $4967
	adc l			; $4968
	ld c,c			; $4969
	adc h			; $496a
	ld c,c			; $496b
	ld hl,$4a95		; $496c
	ldi a,(hl)		; $496f
	ld b,a			; $4970
	ld de,$cec4		; $4971
_label_03_028:
	ld a,(de)		; $4974
	push de			; $4975
	ld e,(hl)		; $4976
	ld d,$c6		; $4977
	ld (de),a		; $4979
	pop de			; $497a
	inc de			; $497b
	inc hl			; $497c
	inc hl			; $497d
	dec b			; $497e
	jr nz,_label_03_028	; $497f
	ld hl,$c600		; $4981
	ld a,($cec2)		; $4984
	ldi (hl),a		; $4987
	ld a,($cec3)		; $4988
	ld (hl),a		; $498b
	ret			; $498c
	ld hl,$4ab9		; $498d
	ld b,$08		; $4990
	ld de,$cec4		; $4992
_label_03_029:
	ldi a,(hl)		; $4995
	push hl			; $4996
	ld l,a			; $4997
	ld h,$c6		; $4998
	ld a,(de)		; $499a
	or (hl)			; $499b
	ld (hl),a		; $499c
	pop hl			; $499d
	inc de			; $499e
	inc hl			; $499f
	dec b			; $49a0
	jr nz,_label_03_029	; $49a1
	ret			; $49a3
	ld hl,$cec2		; $49a4
	ldi a,(hl)		; $49a7
	ld d,(hl)		; $49a8
	ld e,a			; $49a9
	or d			; $49aa
	jr z,_label_03_031	; $49ab
	ld hl,$c600		; $49ad
	ldi a,(hl)		; $49b0
	cp e			; $49b1
	jr nz,_label_03_030	; $49b2
	ldi a,(hl)		; $49b4
	cp d			; $49b5
	jr z,_label_03_031	; $49b6
_label_03_030:
	ld b,$01		; $49b8
	ret			; $49ba
_label_03_031:
	ld b,$00		; $49bb
	ret			; $49bd
	ld hl,$c600		; $49be
	ldi a,(hl)		; $49c1
	or (hl)			; $49c2
	ret nz			; $49c3
	ld l,$23		; $49c4
	ldd a,(hl)		; $49c6
	and $7f			; $49c7
	ld b,a			; $49c9
	ld a,(hl)		; $49ca
	jr nz,_label_03_033	; $49cb
_label_03_032:
	or a			; $49cd
	jr nz,_label_03_033	; $49ce
	ld a,($ff00+$04)	; $49d0
	jr _label_03_032		; $49d2
_label_03_033:
	ld l,$00		; $49d4
	ldi (hl),a		; $49d6
	ld (hl),b		; $49d7
	ret			; $49d8
	ld a,c			; $49d9
	ld hl,$4a02		; $49da
	rst_addDoubleIndex			; $49dd
	ldi a,(hl)		; $49de
	ld b,(hl)		; $49df
	ld c,a			; $49e0
	ld de,$d478		; $49e1
	ld hl,$d460		; $49e4
_label_03_034:
	ld a,(bc)		; $49e7
	and $0f			; $49e8
	ret z			; $49ea
	push bc			; $49eb
	ld b,a			; $49ec
_label_03_035:
	ld a,(de)		; $49ed
	push hl			; $49ee
	ld hl,secretSymbols		; $49ef
	rst_addAToHl			; $49f2
	ld a,(hl)		; $49f3
	pop hl			; $49f4
	ldi (hl),a		; $49f5
	inc de			; $49f6
	dec b			; $49f7
	jr nz,_label_03_035	; $49f8
	pop bc			; $49fa
	ld a,(bc)		; $49fb
	and $f0			; $49fc
	ldi (hl),a		; $49fe
	inc bc			; $49ff
	jr _label_03_034		; $4a00
	ld a,(bc)		; $4a02
	ld c,d			; $4a03
	ld a,(bc)		; $4a04
	ld c,d			; $4a05
	rrca			; $4a06
	ld c,d			; $4a07
	inc de			; $4a08
	ld c,d			; $4a09
	dec h			; $4a0a
	dec b			; $4a0b
	dec h			; $4a0c
	dec b			; $4a0d
	nop			; $4a0e
	dec h			; $4a0f
	dec b			; $4a10
	dec h			; $4a11
	nop			; $4a12
	dec b			; $4a13
	nop			; $4a14
	call $4ace		; $4a15
	ld hl,$cec0		; $4a18
	ld de,$d478		; $4a1b
_label_03_036:
	ldi a,(hl)		; $4a1e
	call $4a29		; $4a1f
	ret c			; $4a22
	ld (de),a		; $4a23
	inc de			; $4a24
	dec b			; $4a25
	jr nz,_label_03_036	; $4a26
	ret			; $4a28
	push hl			; $4a29
	push bc			; $4a2a
	ld hl,secretSymbols		; $4a2b
	ld bc,$4000		; $4a2e
_label_03_037:
	cp (hl)			; $4a31
	jr z,_label_03_038	; $4a32
	inc hl			; $4a34
	inc c			; $4a35
	dec b			; $4a36
	jr nz,_label_03_037	; $4a37
	scf			; $4a39
_label_03_038:
	ld a,c			; $4a3a
	pop bc			; $4a3b
	pop hl			; $4a3c
	ret			; $4a3d
	call $4ace		; $4a3e
	ld a,($d478)		; $4a41
	and $38			; $4a44
	rrca			; $4a46
	ld de,$4ada		; $4a47
	call addAToDe		; $4a4a
	ld hl,$d478		; $4a4d
	ld a,(de)		; $4a50
	and $07			; $4a51
_label_03_039:
	xor (hl)		; $4a53
	ldi (hl),a		; $4a54
	inc de			; $4a55
	ld a,(de)		; $4a56
	dec b			; $4a57
	jr nz,_label_03_039	; $4a58
	ret			; $4a5a
	ld hl,$d478		; $4a5b
	ld b,$14		; $4a5e
	xor a			; $4a60
_label_03_040:
	add (hl)		; $4a61
	inc hl			; $4a62
	dec b			; $4a63
	jr nz,_label_03_040	; $4a64
	and $0f			; $4a66
	ret			; $4a68
	call $4ace		; $4a69
	ld a,$14		; $4a6c
	sub b			; $4a6e
	ret z			; $4a6f
	ld de,$d478		; $4a70
	ld h,d			; $4a73
	ld l,e			; $4a74
	rst_addAToHl			; $4a75
_label_03_041:
	ldi a,(hl)		; $4a76
	ld (de),a		; $4a77
	inc de			; $4a78
	dec b			; $4a79
	jr nz,_label_03_041	; $4a7a
	ret			; $4a7c
	ld a,c			; $4a7d
	and $03			; $4a7e
	ld c,a			; $4a80
	ret			; $4a81
	sub l			; $4a82
	ld c,d			; $4a83
	sub l			; $4a84
	ld c,d			; $4a85
	cp b			; $4a86
	ld c,d			; $4a87
	bit 1,d			; $4a88
	adc h			; $4a8a
	ld c,d			; $4a8b
	inc b			; $4a8c
	add sp,$03		; $4a8d
	jp hl			; $4a8f
	ld (bc),a		; $4a90
	nop			; $4a91
	ld ($0701),sp		; $4a92
	ld de,$0113		; $4a95
	ld de,$0201		; $4a98
	ld ($0809),sp		; $4a9b
	inc bc			; $4a9e
	ld ($080a),sp		; $4a9f
	rrca			; $4aa2
	ld b,$04		; $4aa3
	ld ($080b),sp		; $4aa5
	dec d			; $4aa8
	ld bc,$0805		; $4aa9
	stop			; $4aac
	inc b			; $4aad
	ld b,$08		; $4aae
	inc c			; $4ab0
	ld ($0112),sp		; $4ab1
	dec c			; $4ab4
	ld ($0207),sp		; $4ab5
	add hl,bc		; $4ab8
	rla			; $4ab9
	ld ($081b),sp		; $4aba
	dec e			; $4abd
	ld ($0819),sp		; $4abe
	ld d,$08		; $4ac1
	ld a,(de)		; $4ac3
	ld ($0818),sp		; $4ac4
	inc e			; $4ac7
	ld ($0207),sp		; $4ac8
	ld bc,$06e6		; $4acb
	ld a,c			; $4ace
	ld hl,$4ad6		; $4acf
	rst_addAToHl			; $4ad2
	ld a,(hl)		; $4ad3
	ld b,a			; $4ad4
	ret			; $4ad5
	inc d			; $4ad6
	inc d			; $4ad7
	rrca			; $4ad8
	dec b			; $4ad9
	dec d			; $4ada
	inc hl			; $4adb
	ld l,$04		; $4adc
	dec c			; $4ade
	ccf			; $4adf
	ld a,(de)		; $4ae0
	stop			; $4ae1
	ldd a,(hl)		; $4ae2
	cpl			; $4ae3
	ld e,$20		; $4ae4
	rrca			; $4ae6
	ld a,$36		; $4ae7
	scf			; $4ae9
	add hl,bc		; $4aea
	add hl,hl		; $4aeb
	dec sp			; $4aec
	ld sp,$1602		; $4aed
	dec a			; $4af0
	jr c,$28		; $4af1
	inc de			; $4af3
	inc (hl)		; $4af4
	ldd (hl),a		; $4af5
	ld bc,$0a0b		; $4af6
	dec (hl)		; $4af9
	ld c,$1b		; $4afa
	ld (de),a		; $4afc
	inc l			; $4afd
	ld hl,$252d		; $4afe
	jr nc,$19		; $4b01
	ldi a,(hl)		; $4b03
	ld b,$39		; $4b04
	inc a			; $4b06
	rla			; $4b07
	inc sp			; $4b08
	.db $18

;;
; @addr{4b0a}
twinrovaCutsceneCaller:
	ld a,c			; $4b0a
	rst_jumpTable			; $4b0b
	add c			; $4b0c
	ld c,e			; $4b0d
	inc (hl)		; $4b0e
	ld c,h			; $4b0f
_label_03_042:
	ld hl,$cc03		; $4b10
	inc (hl)		; $4b13
	ret			; $4b14
	ld hl,$cbb3		; $4b15
	inc (hl)		; $4b18
	ret			; $4b19
	ld hl,$cbb4		; $4b1a
	dec (hl)		; $4b1d
	ret			; $4b1e
	ld a,$ff		; $4b1f
	jp setScreenShakeCounter		; $4b21
	ld a,$04		; $4b24
	call fadeoutToWhiteWithDelay		; $4b26
	ld hl,$cbb3		; $4b29
	ld b,$10		; $4b2c
	call clearMemory		; $4b2e
	jr _label_03_042		; $4b31
	ld a,($c4ab)		; $4b33
	or a			; $4b36
	ret nz			; $4b37
	call $4b10		; $4b38
	ld a,$9a		; $4b3b
	ld ($cc4c),a		; $4b3d
	call $4b6f		; $4b40
	call refreshObjectGfx		; $4b43
	ld hl,$d00b		; $4b46
	ld (hl),$38		; $4b49
	inc l			; $4b4b
	inc l			; $4b4c
	ld (hl),$78		; $4b4d
	call resetCamera		; $4b4f
	ld hl,$4022		; $4b52
	call parseGivenObjectData		; $4b55
	ld a,$ac		; $4b58
	call loadPaletteHeader		; $4b5a
	ld a,$01		; $4b5d
	ld ($cd00),a		; $4b5f
	call loadCommonGraphics		; $4b62
	ld a,$04		; $4b65
	call fadeinFromWhiteWithDelay		; $4b67
	ld a,$02		; $4b6a
	jp loadGfxRegisterStateIndex		; $4b6c
	call disableLcd		; $4b6f
	call clearScreenVariablesAndWramBank1		; $4b72
	call loadScreenMusicAndSetRoomPack		; $4b75
	call loadAreaData		; $4b78
	call loadAreaGraphics		; $4b7b
	jp func_131f		; $4b7e
	ld a,($cc03)		; $4b81
_label_03_043:
	rst_jumpTable			; $4b84
	inc h			; $4b85
	ld c,e			; $4b86
	inc sp			; $4b87
	ld c,e			; $4b88
	sub c			; $4b89
	ld c,e			; $4b8a
	sbc (hl)		; $4b8b
	ld c,e			; $4b8c
	or d			; $4b8d
	ld c,e			; $4b8e
	call $fa4b		; $4b8f
	xor e			; $4b92
	call nz,$c0b7		; $4b93
	ld a,$01		; $4b96
	ld ($cbb4),a		; $4b98
	jp $4b10		; $4b9b
	call $4b1a		; $4b9e
	ret nz			; $4ba1
	ld (hl),$b4		; $4ba2
	call $4c0d		; $4ba4
	call $4c29		; $4ba7
	ld a,$b0		; $4baa
	call playSound		; $4bac
	jp $4b10		; $4baf
	call $4b1f		; $4bb2
	ld a,(wFrameCounter)		; $4bb5
	and $3f			; $4bb8
	jr nz,_label_03_044	; $4bba
	ld a,$b0		; $4bbc
	call playSound		; $4bbe
_label_03_044:
	call $4b1a		; $4bc1
	ret nz			; $4bc4
	ld a,$04		; $4bc5
	call fadeoutToWhiteWithDelay		; $4bc7
	jp $4b10		; $4bca
	call $4b1f		; $4bcd
	ld a,($c4ab)		; $4bd0
	or a			; $4bd3
	ret nz			; $4bd4
	ld a,$9e		; $4bd5
	ld ($cc4c),a		; $4bd7
	call $4b6f		; $4bda
	call getFreeEnemySlot		; $4bdd
	ld (hl),$03		; $4be0
	ld l,$83		; $4be2
	set 7,(hl)		; $4be4
	ld hl,$d000		; $4be6
	ld (hl),$03		; $4be9
	ld l,$0b		; $4beb
	ld (hl),$78		; $4bed
	inc l			; $4bef
	inc l			; $4bf0
	ld (hl),$78		; $4bf1
	call resetCamera		; $4bf3
	ld a,$01		; $4bf6
	ld ($c2ef),a		; $4bf8
	ld a,$01		; $4bfb
	ld ($cd00),a		; $4bfd
	call loadCommonGraphics		; $4c00
	ld a,$02		; $4c03
	call fadeinFromWhiteWithDelay		; $4c05
	ld a,$02		; $4c08
	jp loadGfxRegisterStateIndex		; $4c0a
	ld hl,$d240		; $4c0d
_label_03_045:
	ld l,$40		; $4c10
	ldi a,(hl)		; $4c12
	or a			; $4c13
	jr z,_label_03_046	; $4c14
	ldi a,(hl)		; $4c16
	cp $b0			; $4c17
	call z,$4c23		; $4c19
_label_03_046:
	inc h			; $4c1c
	ld a,h			; $4c1d
	cp $e0			; $4c1e
	jr c,_label_03_045	; $4c20
	ret			; $4c22
	dec l			; $4c23
	ld b,$40		; $4c24
	jp clearMemory		; $4c26
	ld a,$af		; $4c29
	call loadPaletteHeader		; $4c2b
	ld hl,$402f		; $4c2e
	jp parseGivenObjectData		; $4c31
	ld a,($cc03)		; $4c34
	rst_jumpTable			; $4c37
	inc h			; $4c38
	ld c,e			; $4c39
	inc sp			; $4c3a
	ld c,e			; $4c3b
	sub c			; $4c3c
	ld c,e			; $4c3d
	sbc (hl)		; $4c3e
	ld c,e			; $4c3f
	ld c,h			; $4c40
	ld c,h			; $4c41
	ld e,e			; $4c42
	ld c,h			; $4c43
	ld h,(hl)		; $4c44
	ld c,h			; $4c45
	ld (hl),c		; $4c46
	ld c,h			; $4c47
	ld a,a			; $4c48
	ld c,h			; $4c49
	sbc e			; $4c4a
	ld c,h			; $4c4b
	call $4b1a		; $4c4c
	ret nz			; $4c4f
	ld (hl),$14		; $4c50
	ld bc,$1878		; $4c52
_label_03_047:
	call $4cba		; $4c55
	jp $4b10		; $4c58
	call $4b1a		; $4c5b
	ret nz			; $4c5e
	ld (hl),$14		; $4c5f
	ld bc,$48a8		; $4c61
	jr _label_03_047		; $4c64
	call $4b1a		; $4c66
	ret nz			; $4c69
	ld (hl),$28		; $4c6a
	ld bc,$4848		; $4c6c
	jr _label_03_047		; $4c6f
	call $4b1a		; $4c71
	ret nz			; $4c74
	ld (hl),$78		; $4c75
	ld a,$67		; $4c77
	call playSound		; $4c79
	jp $4b10		; $4c7c
	call $4b1f		; $4c7f
	ld a,(wFrameCounter)		; $4c82
	and $07			; $4c85
	call z,fastFadeinFromWhite		; $4c87
	call $4b1a		; $4c8a
	ret nz			; $4c8d
	ld a,$04		; $4c8e
	call fadeoutToWhiteWithDelay		; $4c90
	ld a,$b4		; $4c93
	call playSound		; $4c95
	jp $4b10		; $4c98
	call $4b1f		; $4c9b
	ld a,($c4ab)		; $4c9e
	or a			; $4ca1
	ret nz			; $4ca2
	call clearScreenVariablesAndWramBank1		; $4ca3
	ld a,$01		; $4ca6
	ld ($c2ef),a		; $4ca8
	ld a,$01		; $4cab
	ld ($cd00),a		; $4cad
	call getFreeEnemySlot		; $4cb0
	ld (hl),$04		; $4cb3
	ld a,$f0		; $4cb5
	jp playSound		; $4cb7
	call getFreePartSlot		; $4cba
	ret nz			; $4cbd
	ld (hl),$27		; $4cbe
	inc l			; $4cc0
	inc (hl)		; $4cc1
	ld l,$cb		; $4cc2
	ld (hl),b		; $4cc4
	inc l			; $4cc5
	inc l			; $4cc6
	ld (hl),c		; $4cc7
	ret			; $4cc8
	ldh a,(<hSerialInterruptBehaviour)	; $4cc9
	or a			; $4ccb
	jr z,_label_03_048	; $4ccc
	call serialFunc_0c8d		; $4cce
	ld a,$09		; $4cd1
	ld ($cbb4),a		; $4cd3
	jr _label_03_049		; $4cd6
_label_03_048:
	call serialFunc_0c85		; $4cd8
	ld a,$03		; $4cdb
	ldh (<hFFBE),a	; $4cdd
	xor a			; $4cdf
	ldh (<hFFBF),a	; $4ce0
	ld a,($c482)		; $4ce2
	and $08			; $4ce5
	jr z,_label_03_050	; $4ce7
_label_03_049:
	ldh a,(<hIntroInputsEnabled)	; $4ce9
	add a			; $4ceb
	jr z,_label_03_050	; $4cec
	ld a,($c2e6)		; $4cee
	cp $03			; $4cf1
	jr nz,_label_03_051	; $4cf3
_label_03_050:
	ld a,($c2e6)		; $4cf5
	rst_jumpTable			; $4cf8
	jr c,$4d		; $4cf9
	inc a			; $4cfb
	ld c,l			; $4cfc
	ld h,c			; $4cfd
	inc l			; $4cfe
	adc b			; $4cff
	ld c,l			; $4d00
	dec de			; $4d01
	ld c,l			; $4d02
_label_03_051:
	call clearPaletteFadeVariables		; $4d03
	call $539c		; $4d06
	ld hl,$c2e7		; $4d09
	xor a			; $4d0c
	ldd (hl),a		; $4d0d
	ldh (<hCameraY),a	; $4d0e
	ld ($cbb6),a		; $4d10
	ld (hl),$03		; $4d13
	dec a			; $4d15
	ld ($cd25),a		; $4d16
	jr _label_03_050		; $4d19
	xor a			; $4d1b
	ld ($c2e6),a		; $4d1c
	ld ($c2e7),a		; $4d1f
	ret			; $4d22
	call enableIntroInputs		; $4d23
	call clearDynamicInteractions		; $4d26
	ld hl,$c2e6		; $4d29
	inc (hl)		; $4d2c
	inc l			; $4d2d
	ld (hl),$00		; $4d2e
	jp clearPaletteFadeVariables		; $4d30
	ld hl,$c2e7		; $4d33
	inc (hl)		; $4d36
	ret			; $4d37
	ld hl,$c2e6		; $4d38
	inc (hl)		; $4d3b
	ld a,($c2e7)		; $4d3c
	rst_jumpTable			; $4d3f
	ld b,(hl)		; $4d40
	ld c,l			; $4d41
	ld l,b			; $4d42
	ld c,l			; $4d43
	ld (hl),l		; $4d44
	ld c,l			; $4d45
	call restartSound		; $4d46
	call clearVram		; $4d49
	ld a,$01		; $4d4c
	call loadGfxHeader		; $4d4e
	ld a,$01		; $4d51
	call loadPaletteHeader		; $4d53
	ld hl,$cbb3		; $4d56
	ld (hl),$d0		; $4d59
	inc hl			; $4d5b
	ld (hl),$00		; $4d5c
	call $4d33		; $4d5e
	call fadeinFromWhite		; $4d61
	xor a			; $4d64
	jp loadGfxRegisterStateIndex		; $4d65
	ld hl,$cbb3		; $4d68
	call decHlRef16WithCap		; $4d6b
	ret nz			; $4d6e
	call $4d33		; $4d6f
	jp fadeoutToWhite		; $4d72
	ld a,($c4ab)		; $4d75
	or a			; $4d78
	ret nz			; $4d79
	xor a			; $4d7a
	ld hl,$c2e6		; $4d7b
	ld (hl),$02		; $4d7e
	inc l			; $4d80
	ld (hl),a		; $4d81
	ld ($cbb5),a		; $4d82
	jp enableIntroInputs		; $4d85
	call getRandomNumber_noPreserveVars		; $4d88
	call $4da3		; $4d8b
	call clearOam		; $4d8e
	ld hl,$4e1c		; $4d91
	call addSpritesToOam		; $4d94
	ld a,($cbb3)		; $4d97
	and $20			; $4d9a
	ret nz			; $4d9c
	ld hl,$4e65		; $4d9d
	jp addSpritesToOam		; $4da0
	ld a,($c2e7)		; $4da3
	rst_jumpTable			; $4da6
	xor a			; $4da7
	ld c,l			; $4da8
.DB $dd				; $4da9
	ld c,l			; $4daa
	inc b			; $4dab
	ld c,(hl)		; $4dac
	inc c			; $4dad
	ld c,(hl)		; $4dae
	call restartSound		; $4daf
	ld a,$e8		; $4db2
	call threadStop		; $4db4
	call stopTextThread		; $4db7
	call disableLcd		; $4dba
	ld a,$02		; $4dbd
	call loadGfxHeader		; $4dbf
	ld a,$03		; $4dc2
	call loadPaletteHeader		; $4dc4
	ld hl,$cbb3		; $4dc7
	ld a,$60		; $4dca
	ldi (hl),a		; $4dcc
	ld a,$09		; $4dcd
	ldi (hl),a		; $4dcf
	call $4d33		; $4dd0
	ld a,$01		; $4dd3
	call playSound		; $4dd5
	ld a,$04		; $4dd8
	jp loadGfxRegisterStateIndex		; $4dda
	ld a,($c482)		; $4ddd
	and $08			; $4de0
	jr nz,_label_03_052	; $4de2
	ld hl,$cbb3		; $4de4
	call decHlRef16WithCap		; $4de7
	ret nz			; $4dea
	ld a,$02		; $4deb
	jr _label_03_053		; $4ded
_label_03_052:
	ld a,$56		; $4def
	call playSound		; $4df1
	call serialFunc_0c7e		; $4df4
	ld a,$03		; $4df7
_label_03_053:
	ld ($c2e7),a		; $4df9
	ld a,$fa		; $4dfc
	call playSound		; $4dfe
	jp fadeoutToWhite		; $4e01
	ld a,($c4ab)		; $4e04
	or a			; $4e07
	ret nz			; $4e08
	jp $4d23		; $4e09
	ld a,($c4ab)		; $4e0c
	or a			; $4e0f
	ret nz			; $4e10
	ld a,$e8		; $4e11
	ld bc,fileSelectThreadStart		; $4e13
	call threadRestart		; $4e16
	jp stubThreadStart		; $4e19
	ld (de),a		; $4e1c
	ld d,c			; $4e1d
	ld a,d			; $4e1e
	ld d,(hl)		; $4e1f
	inc b			; $4e20
	ld d,b			; $4e21
	add d			; $4e22
	ld (hl),h		; $4e23
	inc b			; $4e24
	ld e,b			; $4e25
	ld a,d			; $4e26
	ld l,d			; $4e27
	rlca			; $4e28
	ld e,b			; $4e29
	add d			; $4e2a
	ld l,h			; $4e2b
	rlca			; $4e2c
	ld e,b			; $4e2d
	adc d			; $4e2e
	ld l,(hl)		; $4e2f
	rlca			; $4e30
	ld c,b			; $4e31
	sub b			; $4e32
	ld h,d			; $4e33
	ld b,$44		; $4e34
	adc l			; $4e36
	ld l,b			; $4e37
	ld b,$54		; $4e38
	adc d			; $4e3a
	ld d,h			; $4e3b
	inc bc			; $4e3c
	ld d,h			; $4e3d
	add d			; $4e3e
	ld d,d			; $4e3f
	inc bc			; $4e40
	ld d,h			; $4e41
	ld a,d			; $4e42
	ld d,b			; $4e43
	inc bc			; $4e44
	ld b,b			; $4e45
	add l			; $4e46
	ld h,(hl)		; $4e47
	ld b,$40		; $4e48
	ld a,a			; $4e4a
	ld h,h			; $4e4b
	ld b,$41		; $4e4c
	ld (hl),b		; $4e4e
	ld h,b			; $4e4f
	ld b,$54		; $4e50
	halt			; $4e52
	ld e,d			; $4e53
	ld b,$44		; $4e54
	ld l,b			; $4e56
	ld e,(hl)		; $4e57
	ld h,$64		; $4e58
	ld a,d			; $4e5a
	ld (hl),b		; $4e5b
	inc bc			; $4e5c
	ld h,h			; $4e5d
	add d			; $4e5e
	ld (hl),d		; $4e5f
	inc bc			; $4e60
	ld h,h			; $4e61
	adc d			; $4e62
	ld (hl),b		; $4e63
	inc hl			; $4e64
	ld a,(bc)		; $4e65
	add b			; $4e66
	inc l			; $4e67
	jr c,_label_03_054	; $4e68
_label_03_054:
	add b			; $4e6a
	inc (hl)		; $4e6b
	ldd a,(hl)		; $4e6c
	nop			; $4e6d
	add b			; $4e6e
	inc a			; $4e6f
	inc a			; $4e70
	nop			; $4e71
	add b			; $4e72
	ld b,h			; $4e73
	ld a,$00		; $4e74
	add b			; $4e76
	ld c,h			; $4e77
	ld a,$00		; $4e78
	add b			; $4e7a
	ld e,h			; $4e7b
	ld a,$00		; $4e7c
	add b			; $4e7e
	ld h,h			; $4e7f
	ld b,b			; $4e80
	nop			; $4e81
	add b			; $4e82
	ld l,h			; $4e83
	ld b,d			; $4e84
	nop			; $4e85
	add b			; $4e86
	ld (hl),h		; $4e87
	ldd a,(hl)		; $4e88
	nop			; $4e89
	add b			; $4e8a
	ld a,h			; $4e8b
	ld b,b			; $4e8c
	nop			; $4e8d
	ld a,($cbb5)		; $4e8e
	rst_jumpTable			; $4e91
	sbc b			; $4e92
	ld c,(hl)		; $4e93
	ld d,h			; $4e94
	ld d,b			; $4e95
	dec (hl)		; $4e96
	ld d,d			; $4e97
	ld a,($c2e7)		; $4e98
	rst_jumpTable			; $4e9b
	.dw $4eaa
	.dw $4f01
	.dw $4f32
	.dw $4f68
	.dw $4f86
	.dw $4fce
	.dw $5008

	call disableLcd		; $4eaa
	ld hl,$cba0		; $4ead
	ld bc,$0460		; $4eb0
	call clearMemoryBc		; $4eb3

	ld a,$10		; $4eb6
	ldh (<hOamTail),a	; $4eb8
	ld a,$9b		; $4eba
	call loadGfxHeader		; $4ebc
	ld a,$90		; $4ebf
	call loadPaletteHeader		; $4ec1
	ld hl,$cbb3		; $4ec4
	ld (hl),$7e		; $4ec7
	inc hl			; $4ec9
	ld (hl),$03		; $4eca
	ld a,$20		; $4ecc
	ld ($cbb8),a		; $4ece
	ld a,$10		; $4ed1
	ld ($cbb9),a		; $4ed3
	ld a,$22		; $4ed6
	ld ($cbb6),a		; $4ed8
	ld a,$01		; $4edb
	ld ($cbba),a		; $4edd
	ld a,$08		; $4ee0
	call loadGfxRegisterStateIndex		; $4ee2
	ld a,$3f		; $4ee5
	call playSound		; $4ee7
	call getFreeInteractionSlot		; $4eea
	jr nz,_label_03_055	; $4eed
	ld (hl),$75		; $4eef
	inc l			; $4ef1
	ld (hl),$00		; $4ef2
_label_03_055:
	ld a,$14		; $4ef4
	call fadeinFromWhiteWithDelay		; $4ef6
	ld hl,$c4b5		; $4ef9
	ld (hl),$01		; $4efc
	jp $4d33		; $4efe

	call $534f		; $4f01
	ld hl,$cbb3		; $4f04
	call decHlRef16WithCap		; $4f07
	ret nz			; $4f0a
	call clearPaletteFadeVariablesAndRefreshPalettes		; $4f0b
	ld a,$96		; $4f0e
	call loadPaletteHeader		; $4f10
	ld a,$0c		; $4f13
	call loadGfxRegisterStateIndex		; $4f15
	ld a,($c48c)		; $4f18
	ld ($cbbb),a		; $4f1b
	ld a,($c48d)		; $4f1e
	ld ($cbbc),a		; $4f21
	call $4f54		; $4f24
	ld hl,$cbb3		; $4f27
	ld (hl),$58		; $4f2a
	inc hl			; $4f2c
	ld (hl),$01		; $4f2d
	jp $4d33		; $4f2f
	ld hl,$cbb3		; $4f32
	call decHlRef16WithCap		; $4f35
	jr nz,_label_03_056	; $4f38
	call disableLcd		; $4f3a
	ld a,$92		; $4f3d
	call loadPaletteHeader		; $4f3f
	ld a,$9c		; $4f42
	call loadGfxHeader		; $4f44
	ld a,$0a		; $4f47
	call loadGfxRegisterStateIndex		; $4f49
	call $4d33		; $4f4c
	jr _label_03_057		; $4f4f
_label_03_056:
	call $5367		; $4f51
	ld hl,$c48c		; $4f54
	ldi a,(hl)		; $4f57
	cpl			; $4f58
	inc a			; $4f59
	ld b,a			; $4f5a
	ld a,(hl)		; $4f5b
	cpl			; $4f5c
	inc a			; $4f5d
	ld c,a			; $4f5e
	xor a			; $4f5f
	ldh (<hOamTail),a	; $4f60
	ld hl,$543e		; $4f62
	jp addSpritesToOam_withOffset		; $4f65

	ld hl,$c486		; $4f68
	dec (hl)		; $4f6b
	jr nz,_label_03_057	; $4f6c
	ld a,$cc		; $4f6e
	ld ($cbb6),a		; $4f70
	call $4d33		; $4f73
_label_03_057:
	ld a,($c486)		; $4f76
	cpl			; $4f79
	inc a			; $4f7a
	ld b,a			; $4f7b
	xor a			; $4f7c
	ldh (<hOamTail),a	; $4f7d
	ld c,a			; $4f7f
	ld hl,$53a5		; $4f80
	jp addSpritesToOam_withOffset		; $4f83
	ld hl,$cbb6		; $4f86
	dec (hl)		; $4f89
	jr nz,_label_03_057	; $4f8a
	ld a,$93		; $4f8c
	call loadPaletteHeader		; $4f8e
	call disableLcd		; $4f91
	call clearOam		; $4f94
	ld a,$10		; $4f97
	ldh (<hOamTail),a	; $4f99
	ld a,$9d		; $4f9b
	call loadGfxHeader		; $4f9d
	ld a,$05		; $4fa0
	ld ($cbbb),a		; $4fa2
	ld hl,$cbb3		; $4fa5
	ld (hl),$90		; $4fa8
	inc hl			; $4faa
	ld (hl),$01		; $4fab
	ld a,$b4		; $4fad
	ld ($cbb6),a		; $4faf
	call clearPaletteFadeVariablesAndRefreshPalettes		; $4fb2
	ld a,$0b		; $4fb5
	call loadGfxRegisterStateIndex		; $4fb7
	call $4ff8		; $4fba
	ld b,$02		; $4fbd
_label_03_058:
	call getFreeInteractionSlot		; $4fbf
	jr nz,_label_03_059	; $4fc2
	ld (hl),$75		; $4fc4
	inc l			; $4fc6
	ld (hl),b		; $4fc7
	dec b			; $4fc8
	jr nz,_label_03_058	; $4fc9
_label_03_059:
	jp $4d33		; $4fcb
	ld hl,$cbb3		; $4fce
	call decHlRef16WithCap		; $4fd1
	jr nz,_label_03_060	; $4fd4
	call fadeoutToWhite		; $4fd6
	call $4d33		; $4fd9
	jr _label_03_061		; $4fdc
_label_03_060:
	ld hl,$cbb6		; $4fde
	ld a,(hl)		; $4fe1
	or a			; $4fe2
	jr z,_label_03_061	; $4fe3
	dec (hl)		; $4fe5
	ld a,($c487)		; $4fe6
	or a			; $4fe9
	jr z,_label_03_061	; $4fea
	ld hl,$cbbb		; $4fec
	dec (hl)		; $4fef
	jr nz,_label_03_061	; $4ff0
	ld (hl),$05		; $4ff2
	ld hl,$c487		; $4ff4
	dec (hl)		; $4ff7
_label_03_061:
	xor a			; $4ff8
	ldh (<hOamTail),a	; $4ff9
	ld b,a			; $4ffb
	ld a,($c487)		; $4ffc
	cpl			; $4fff
	inc a			; $5000
	ld c,a			; $5001
	ld hl,$5493		; $5002
	jp addSpritesToOam_withOffset		; $5005
	ld a,($c4ab)		; $5008
	or a			; $500b
	jr nz,_label_03_061	; $500c
	call clearDynamicInteractions		; $500e
	jr _label_03_065		; $5011
	ld hl,$cbb6		; $5013
	dec (hl)		; $5016
	ret nz			; $5017
	ld a,($cbba)		; $5018
	ld ($cbb6),a		; $501b
	ld hl,$c486		; $501e
	dec (hl)		; $5021
	ld a,(hl)		; $5022
	cp $88			; $5023
	ret z			; $5025
	cp $10			; $5026
	jr nz,_label_03_063	; $5028
	ld a,$0d		; $502a
	call loadUncompressedGfxHeader		; $502c
	ld b,$04		; $502f
_label_03_062:
	call getFreeInteractionSlot		; $5031
	jr nz,_label_03_064	; $5034
	ld (hl),$d2		; $5036
	inc l			; $5038
	dec b			; $5039
	ld (hl),b		; $503a
	jr nz,_label_03_062	; $503b
	jr _label_03_064		; $503d
_label_03_063:
	cp $b0			; $503f
	jr nz,_label_03_064	; $5041
	ld a,$2a		; $5043
	call loadUncompressedGfxHeader		; $5045
_label_03_064:
	or $01			; $5048
	ret			; $504a
_label_03_065:
	ld hl,$cbb5		; $504b
	inc (hl)		; $504e
	xor a			; $504f
	ld ($c2e7),a		; $5050
	ret			; $5053
	ld a,($c2e7)		; $5054
	rst_jumpTable			; $5057
	.dw @state0
	.dw $50e5
	.dw $50ed
	.dw $50fe
	.dw $510a
	.dw $5130
	.dw $5140
	.dw $5152
	.dw $516e
	.dw $5186
	.dw $5193
	.dw $51a6

@state0:
	call disableLcd		; $5070
	call clearOam		; $5073
	ld a,$10		; $5076
	ldh (<hOamTail),a	; $5078
	ld a,$9e		; $507a
	call loadGfxHeader		; $507c
	ld a,$91		; $507f
	call loadPaletteHeader		; $5081
	ld a,$09		; $5084
	call loadGfxRegisterStateIndex		; $5086
	ld a,($c486)		; $5089
	ldh (<hCameraY),a	; $508c
	ld a,$18		; $508e
	ld ($cd25),a		; $5090
	call loadAnimationData		; $5093
	ld a,$01		; $5096
	ld ($cd00),a		; $5098
	ld a,$08		; $509b
	call setLinkID		; $509d
	ld l,$00		; $50a0
	ld (hl),$01		; $50a2
	ld l,$0b		; $50a4
	ld a,($c486)		; $50a6
	add $60			; $50a9
	ld (hl),a		; $50ab
	ld l,$0d		; $50ac
	ld (hl),$50		; $50ae
	ld hl,$54a8		; $50b0
	ld a,$03		; $50b3
_label_03_066:
	call setSimulatedInputAddress		; $50b5
	ld b,$03		; $50b8
	ld c,$30		; $50ba
_label_03_067:
	call getFreeInteractionSlot		; $50bc
	jr nz,_label_03_068	; $50bf
	ld (hl),$4a		; $50c1
	inc l			; $50c3
	ld a,b			; $50c4
	dec a			; $50c5
	ld (hl),a		; $50c6
	ld l,$4b		; $50c7
	ld (hl),$19		; $50c9
	ld a,c			; $50cb
	ld l,$4d		; $50cc
	ld (hl),a		; $50ce
	add $20			; $50cf
	ld c,a			; $50d1
	ld a,c			; $50d2
	dec b			; $50d3
	jr nz,_label_03_067	; $50d4
_label_03_068:
	ld hl,$cc02		; $50d6
	ld (hl),$01		; $50d9
	call fadeinFromWhite		; $50db
	xor a			; $50de
	ld ($cbb9),a		; $50df
	jp $4d33		; $50e2

@state1:
	ld a,($c4ab)		; $50e5
	or a			; $50e8
	ret nz			; $50e9
	jp $4d33		; $50ea

@state2:
	ld a,($cbc3)		; $50ed
	rlca			; $50f0
	jp nc,$5336		; $50f1
	xor a			; $50f4
	ld ($cbc3),a		; $50f5
	call $5336		; $50f8
	jp $4d33		; $50fb
	ld a,($cbb9)		; $50fe
	cp $03			; $5101
	ret nz			; $5103
	call fadeoutToWhite		; $5104
	jp $4d33		; $5107
	ld a,($c4ab)		; $510a
	or a			; $510d
	ret nz			; $510e
	ld a,$01		; $510f
	ld ($c48a),a		; $5111
	inc a			; $5114
	ld ($c490),a		; $5115
	ld a,$00		; $5118
	ldh (<hNextLcdInterruptBehaviour),a	; $511a
	ld a,$20		; $511c
	call initWaveScrollValues		; $511e
	call fadeinFromWhite		; $5121
	call $4d33		; $5124
	ld hl,wFrameCounter		; $5127
	inc (hl)		; $512a
	ld a,$02		; $512b
	jp loadBigBufferScrollValues		; $512d
	call $5127		; $5130
	ld a,($c4ab)		; $5133
	or a			; $5136
	ret nz			; $5137
	ld hl,$cbb6		; $5138
	ld (hl),$78		; $513b
	jp $4d33		; $513d
	call $5127		; $5140
	ld hl,$cbb6		; $5143
	dec (hl)		; $5146
	ret nz			; $5147
	ld ($cbb6),a		; $5148
	dec a			; $514b
	ld ($cbba),a		; $514c
	call $4d33		; $514f
	call $5127		; $5152
	ld hl,$cbb6		; $5155
	ld b,$00		; $5158
	call $51b4		; $515a
	ret z			; $515d
	call clearPaletteFadeVariablesAndRefreshPalettes		; $515e
	ld a,$06		; $5161
	ld ($cbb9),a		; $5163
	ld a,$91		; $5166
	call playSound		; $5168
	jp $4d33		; $516b
	call $5127		; $516e
	ld a,($cbb9)		; $5171
	cp $07			; $5174
	ret nz			; $5176
	call clearLinkObject		; $5177
	ld b,$08		; $517a
	call func_2d48		; $517c
	ld a,b			; $517f
	ld ($cbb6),a		; $5180
	jp $4d33		; $5183
	call $5127		; $5186
	ld hl,$cbb6		; $5189
	dec (hl)		; $518c
	ret nz			; $518d
	ld (hl),$3c		; $518e
	jp $4d33		; $5190
	call $5127		; $5193
	ld hl,$cbb6		; $5196
	dec (hl)		; $5199
	ret nz			; $519a
	ld a,$b4		; $519b
	call playSound		; $519d
	call fadeoutToWhite		; $51a0
	jp $4d33		; $51a3
	call $5127		; $51a6
	ld a,($c4ab)		; $51a9
	or a			; $51ac
	ret nz			; $51ad
	call clearDynamicInteractions		; $51ae
	jp $504b		; $51b1
	ld a,b			; $51b4
	inc (hl)		; $51b5
	ld b,(hl)		; $51b6
	ld hl,$51fc		; $51b7
	rst_addDoubleIndex			; $51ba
	ldi a,(hl)		; $51bb
	ld h,(hl)		; $51bc
	ld l,a			; $51bd
	ld c,$00		; $51be
_label_03_069:
	ld a,(hl)		; $51c0
	bit 7,a			; $51c1
	ret nz			; $51c3
	cp b			; $51c4
	jr nc,_label_03_070	; $51c5
	inc hl			; $51c7
	inc c			; $51c8
	jr _label_03_069		; $51c9
_label_03_070:
	ld a,c			; $51cb
	and $01			; $51cc
	ld c,a			; $51ce
	ld a,($cbba)		; $51cf
	cp c			; $51d2
	ret z			; $51d3
	ld a,c			; $51d4
	ld ($cbba),a		; $51d5
	or a			; $51d8
	jr z,_label_03_071	; $51d9
	call clearPaletteFadeVariablesAndRefreshPalettes		; $51db
	xor a			; $51de
	ret			; $51df
_label_03_071:
	ld a,$02		; $51e0
	ld ($ff00+$70),a	; $51e2
	ld b,$80		; $51e4
	ld hl,$df80		; $51e6
	ld a,$ff		; $51e9
	call fillMemory		; $51eb
	ld a,$ff		; $51ee
	ldh (<hSprPaletteSources),a	; $51f0
	ldh (<hBgPaletteSources),a	; $51f2
	ldh (<hDirtySprPalettes),a	; $51f4
	ldh (<hDirtyBgPalettes),a	; $51f6
	xor a			; $51f8
	ld ($ff00+$70),a	; $51f9
	ret			; $51fb
	rrca			; $51fc
	ld d,d			; $51fd
	rlca			; $51fe
	ld d,d			; $51ff
	dec d			; $5200
	ld d,d			; $5201
	dec e			; $5202
	ld d,d			; $5203
	dec l			; $5204
	ld d,d			; $5205
	inc bc			; $5206
	ld (bc),a		; $5207
	inc b			; $5208
	ld b,$08		; $5209
	inc c			; $520b
	ld c,$10		; $520c
	rst $38			; $520e
	ld (bc),a		; $520f
	inc b			; $5210
	ld b,$0c		; $5211
	ld c,$ff		; $5213
	ld (bc),a		; $5215
	inc b			; $5216
	ld b,$08		; $5217
	ld a,(bc)		; $5219
	inc c			; $521a
	ld c,$ff		; $521b
	ld bc,$0605		; $521d
	ld a,(bc)		; $5220
	dec bc			; $5221
	rrca			; $5222
	ld de,$1615		; $5223
	ld a,(de)		; $5226
	inc e			; $5227
	jr nz,$22		; $5228
	ld h,$28		; $522a
	rst $38			; $522c
	ld bc,$0402		; $522d
	ld b,$08		; $5230
	ld a,(bc)		; $5232
	inc c			; $5233
	rst $38			; $5234
	ld a,($c2e7)		; $5235
	rst_jumpTable			; $5238
	ld b,c			; $5239
	ld d,d			; $523a
	sub e			; $523b
	ld d,d			; $523c
	pop af			; $523d
	ld d,d			; $523e
	ldi (hl),a		; $523f
	ld d,e			; $5240
	call disableLcd		; $5241
	ld a,$ff		; $5244
	ld ($cd25),a		; $5246
	ld a,$9f		; $5249
	call loadGfxHeader		; $524b
	ld a,$94		; $524e
	call loadPaletteHeader		; $5250
	call refreshObjectGfx		; $5253
	ld a,$0a		; $5256
	call loadGfxRegisterStateIndex		; $5258
	call getFreeInteractionSlot		; $525b
	jr nz,_label_03_072	; $525e
	ld (hl),$4a		; $5260
	inc l			; $5262
	ld (hl),$08		; $5263
	ld l,$4a		; $5265
	ld a,$60		; $5267
	ldi (hl),a		; $5269
	ldi (hl),a		; $526a
	ld a,$3d		; $526b
	inc l			; $526d
	ldi (hl),a		; $526e
_label_03_072:
	ld b,$08		; $526f
_label_03_073:
	call getFreeInteractionSlot		; $5271
	jr nz,_label_03_074	; $5274
	ld (hl),$d3		; $5276
	inc l			; $5278
	dec b			; $5279
	ld (hl),b		; $527a
	jr nz,_label_03_073	; $527b
_label_03_074:
	ld a,$03		; $527d
	ld ($cbba),a		; $527f
	ld ($cbb6),a		; $5282
	call fadeinFromWhite		; $5285
	xor a			; $5288
	ldh (<hCameraY),a	; $5289
	ld a,$40		; $528b
	call playSound		; $528d
	jp $4d33		; $5290
	call $5013		; $5293
	ret nz			; $5296
	call $4d33		; $5297
	ld hl,$cbb3		; $529a
	ld (hl),$02		; $529d
	inc hl			; $529f
	xor a			; $52a0
	ld (hl),a		; $52a1
	ld hl,$cbb6		; $52a2
	ld (hl),$10		; $52a5
	inc a			; $52a7
	ld ($c48a),a		; $52a8
	inc a			; $52ab
	ld ($c490),a		; $52ac
	ld a,$01		; $52af
	ldh (<hNextLcdInterruptBehaviour),a	; $52b1
	ld a,($c486)		; $52b3
	ld b,$90		; $52b6
	ld hl,$c300		; $52b8
_label_03_075:
	ldi (hl),a		; $52bb
	dec b			; $52bc
	jr nz,_label_03_075	; $52bd
	ld a,$01		; $52bf
	ld b,a			; $52c1
	xor a			; $52c2
	ld c,a			; $52c3
_label_03_076:
	inc c			; $52c4
	add b			; $52c5
	cp $18			; $52c6
	jr z,_label_03_077	; $52c8
	ret nc			; $52ca
	jr _label_03_076		; $52cb
_label_03_077:
	push bc			; $52cd
	ld a,$38		; $52ce
	sub b			; $52d0
	ld h,$c3		; $52d1
	ld l,a			; $52d3
	xor a			; $52d4
_label_03_078:
	push af			; $52d5
	sub l			; $52d6
	add $58			; $52d7
	ldi (hl),a		; $52d9
	pop af			; $52da
	add c			; $52db
	dec b			; $52dc
	jr nz,_label_03_078	; $52dd
	pop bc			; $52df
	ld a,$37		; $52e0
	add b			; $52e2
	ld l,a			; $52e3
	ld a,$2f		; $52e4
_label_03_079:
	push af			; $52e6
	sub l			; $52e7
	add $58			; $52e8
	ldd (hl),a		; $52ea
	pop af			; $52eb
	sub c			; $52ec
	dec b			; $52ed
	jr nz,_label_03_079	; $52ee
	ret			; $52f0
	ld hl,$cbb6		; $52f1
	ld a,(hl)		; $52f4
	or a			; $52f5
	jr z,_label_03_080	; $52f6
	dec a			; $52f8
	ld (hl),a		; $52f9
	ld a,$ab		; $52fa
	call z,playSound		; $52fc
_label_03_080:
	ld a,($cbb7)		; $52ff
	and $01			; $5302
	ld hl,$cbb4		; $5304
	ret nz			; $5307
	ld a,(hl)		; $5308
	cp $08			; $5309
	jr nc,_label_03_081	; $530b
	inc a			; $530d
	ld (hl),a		; $530e
	ld hl,$532e		; $530f
	rst_addAToHl			; $5312
	ld a,(hl)		; $5313
	jp $52c1		; $5314
_label_03_081:
	xor a			; $5317
	ld ($cbb6),a		; $5318
	dec a			; $531b
	ld ($cbba),a		; $531c
	jp $4d33		; $531f
	ld hl,$cbb6		; $5322
	ld b,$01		; $5325
	call $51b4		; $5327
	ret z			; $532a
	jp $4d03		; $532b
	ld bc,$0302		; $532e
_label_03_082:
	inc b			; $5331
	ld b,$08		; $5332
	inc c			; $5334
	jr _label_03_082		; $5335
	add (hl)		; $5337
	call nz,$1147		; $5338
	dec bc			; $533b
	ret nc			; $533c
	ld a,(de)		; $533d
	sub b			; $533e
	sub $40			; $533f
	ld b,a			; $5341
	ld a,($c486)		; $5342
	add b			; $5345
	cp $70			; $5346
	ret nc			; $5348
	ld ($c486),a		; $5349
	ldh (<hCameraY),a	; $534c
	ret			; $534e
	ld hl,$c48a		; $534f
	inc (hl)		; $5352
	inc (hl)		; $5353
	ld a,(hl)		; $5354
	cp $17			; $5355
	jr c,_label_03_083	; $5357
	ld (hl),$17		; $5359
_label_03_083:
	ld hl,$c48e		; $535b
	dec (hl)		; $535e
	dec (hl)		; $535f
	ld a,(hl)		; $5360
	cp $78			; $5361
	ret nc			; $5363
	ld (hl),$78		; $5364
	ret			; $5366
	call $5380		; $5367
	ld bc,$0506		; $536a
	jr nz,_label_03_084	; $536d
	ld bc,$0000		; $536f
_label_03_084:
	ld hl,$cbbb		; $5372
	ldi a,(hl)		; $5375
	add b			; $5376
	ld ($c48c),a		; $5377
	ld a,(hl)		; $537a
	add c			; $537b
	ld ($c48d),a		; $537c
	ret			; $537f
_label_03_085:
	ld a,($cbb6)		; $5380
	dec a			; $5383
	jr nz,_label_03_086	; $5384
	ld a,($cbba)		; $5386
	xor $01			; $5389
	ld ($cbba),a		; $538b
	ld a,$05		; $538e
	jr z,_label_03_086	; $5390
	ld a,$22		; $5392
_label_03_086:
	ld ($cbb6),a		; $5394
	ld a,($cbba)		; $5397
	or a			; $539a
	ret			; $539b
	call clearDynamicInteractions		; $539c
	call clearLinkObject		; $539f
	jp refreshObjectGfx		; $53a2
	ld h,$80		; $53a5
	add b			; $53a7
	ld b,b			; $53a8
	ld b,$80		; $53a9
	ld d,b			; $53ab
	ld b,d			; $53ac
	nop			; $53ad
	add b			; $53ae
	ld e,b			; $53af
	ld b,h			; $53b0
	nop			; $53b1
	ld l,b			; $53b2
	ld b,b			; $53b3
	ld b,(hl)		; $53b4
	ld b,$b8		; $53b5
	dec a			; $53b7
	jr nz,_label_03_087	; $53b8
	cp b			; $53ba
	ld b,l			; $53bb
_label_03_087:
	ldi (hl),a		; $53bc
	ld (bc),a		; $53bd
	cp b			; $53be
	ld c,l			; $53bf
	inc h			; $53c0
	ld (bc),a		; $53c1
	cp b			; $53c2
	ld d,l			; $53c3
	ld h,$02		; $53c4
	cp b			; $53c6
	ld e,l			; $53c7
	jr z,$02		; $53c8
	sub b			; $53ca
	jr z,$2c		; $53cb
	ld (bc),a		; $53cd
	sub b			; $53ce
	jr nc,$2e		; $53cf
	ld (bc),a		; $53d1
	add b			; $53d2
	jr nc,$2a		; $53d3
	ld (bc),a		; $53d5
	jr nz,$78		; $53d6
	ld c,b			; $53d8
	dec b			; $53d9
	ld e,b			; $53da
	ld l,b			; $53db
	nop			; $53dc
_label_03_088:
	ld (bc),a		; $53dd
	ld e,b			; $53de
	ld (hl),b		; $53df
	ld (bc),a		; $53e0
	ld (bc),a		; $53e1
	ld l,b			; $53e2
	ld l,b			; $53e3
	inc b			; $53e4
_label_03_089:
	ld (bc),a		; $53e5
	ld c,b			; $53e6
	ld (hl),b		; $53e7
	ld b,$02		; $53e8
	ld e,d			; $53ea
	ld b,b			; $53eb
	ld ($5a01),sp		; $53ec
	ld c,b			; $53ef
	ld a,(bc)		; $53f0
	ld bc,$505a		; $53f1
	inc c			; $53f4
	ld bc,$8838		; $53f5
	ld c,$04		; $53f8
	jr nc,_label_03_098	; $53fa
	stop			; $53fc
	inc b			; $53fd
	jr nc,_label_03_085	; $53fe
	ld (de),a		; $5400
_label_03_090:
	inc b			; $5401
	ld b,b			; $5402
	add b			; $5403
	inc d			; $5404
	inc b			; $5405
	ld d,b			; $5406
	halt			; $5407
	ld d,$04		; $5408
	ld d,b			; $540a
	ld a,(hl)		; $540b
	jr _label_03_091		; $540c
	ld b,c			; $540e
	ld h,d			; $540f
	ld a,(de)		; $5410
	inc bc			; $5411
_label_03_091:
	add b			; $5412
	jr z,_label_03_093	; $5413
	ld (bc),a		; $5415
	xor b			; $5416
	ld e,c			; $5417
	ld e,$02		; $5418
	sbc b			; $541a
	jr nz,_label_03_095	; $541b
	ld (bc),a		; $541d
	sbc b			; $541e
	jr z,_label_03_096	; $541f
	ld (bc),a		; $5421
	adc h			; $5422
	jr c,_label_03_097	; $5423
	rlca			; $5425
	xor b			; $5426
	ld b,c			; $5427
	ld (hl),$02		; $5428
	xor b			; $542a
	ld c,c			; $542b
	jr c,_label_03_092	; $542c
	xor b			; $542e
	ld d,c			; $542f
_label_03_092:
	ldd a,(hl)		; $5430
_label_03_093:
	ld (bc),a		; $5431
	sub b			; $5432
	ld b,b			; $5433
	ld a,$07		; $5434
	adc d			; $5436
	ld e,h			; $5437
	ld c,d			; $5438
	nop			; $5439
	adc d			; $543a
	ld h,h			; $543b
	ld c,h			; $543c
	nop			; $543d
_label_03_094:
	dec d			; $543e
	jr z,_label_03_102	; $543f
	sbc h			; $5441
	ld ($5820),sp		; $5442
	add b			; $5445
	ld ($6020),sp		; $5446
	add d			; $5449
	ld ($6820),sp		; $544a
_label_03_095:
	add h			; $544d
	ld a,(bc)		; $544e
	jr nz,_label_03_105	; $544f
	ret nc			; $5451
	add hl,bc		; $5452
_label_03_096:
	jr nz,_label_03_106	; $5453
	add (hl)		; $5455
	dec c			; $5456
	jr nz,_label_03_109	; $5457
_label_03_097:
	adc b			; $5459
	add hl,bc		; $545a
	jr nz,_label_03_088	; $545b
	adc d			; $545d
	add hl,bc		; $545e
	jr nc,_label_03_102	; $545f
	sub b			; $5461
	inc c			; $5462
	jr nc,_label_03_089	; $5463
	sbc (hl)		; $5465
	add hl,bc		; $5466
	ld c,(hl)		; $5467
	ld h,b			; $5468
	sub h			; $5469
	inc c			; $546a
	ld e,b			; $546b
	ld l,b			; $546c
	sub (hl)		; $546d
	inc c			; $546e
	ld l,b			; $546f
	ld a,b			; $5470
	sbc b			; $5471
	add hl,bc		; $5472
	ld h,b			; $5473
_label_03_098:
	add b			; $5474
	sbc d			; $5475
	ld a,(bc)		; $5476
	jr nz,_label_03_090	; $5477
	adc h			; $5479
	add hl,bc		; $547a
	jr nz,-$70		; $547b
	adc (hl)		; $547d
	add hl,bc		; $547e
	ld b,b			; $547f
	ld (hl),d		; $5480
	sub d			; $5481
	ld c,$42		; $5482
	ld h,d			; $5484
	and b			; $5485
	ld c,$70		; $5486
	jr nc,_label_03_094	; $5488
	rrca			; $548a
	ld (hl),b		; $548b
	jr c,-$4a		; $548c
	rrca			; $548e
	ld a,b			; $548f
	ld l,b			; $5490
	cp b			; $5491
	inc c			; $5492
	dec b			; $5493
	jr nc,_label_03_104	; $5494
	ld c,b			; $5496
	ld (bc),a		; $5497
	jr nc,_label_03_108	; $5498
	ld c,d			; $549a
	ld (bc),a		; $549b
	jr _label_03_110		; $549c
	ld c,h			; $549e
	inc bc			; $549f
	stop			; $54a0
	ld b,b			; $54a1
	ld c,(hl)		; $54a2
	inc bc			; $54a3
	jr $48			; $54a4
	ld d,b			; $54a6
	inc bc			; $54a7
	dec l			; $54a8
	nop			; $54a9
	nop			; $54aa
	stop			; $54ab
	nop			; $54ac
	ld b,b			; $54ad
	jr nc,_label_03_099	; $54ae
_label_03_099:
	nop			; $54b0
	jr nz,_label_03_100	; $54b1
_label_03_100:
	ld b,b			; $54b3
	jr _label_03_101		; $54b4
_label_03_101:
	nop			; $54b6
	jr nz,_label_03_102	; $54b7
_label_03_102:
	ld b,b			; $54b9
	jr nc,_label_03_103	; $54ba
_label_03_103:
	nop			; $54bc
	ldi (hl),a		; $54bd
_label_03_104:
	nop			; $54be
	ld b,b			; $54bf
	ld (hl),b		; $54c0
_label_03_105:
	nop			; $54c1
	nop			; $54c2
	dec b			; $54c3
	nop			; $54c4
_label_03_106:
	ld b,b			; $54c5
	jr nz,_label_03_107	; $54c6
_label_03_107:
	nop			; $54c8
	dec b			; $54c9
_label_03_108:
	nop			; $54ca
	ld b,b			; $54cb
	inc h			; $54cc
	nop			; $54cd
	nop			; $54ce
	dec b			; $54cf
	nop			; $54d0
_label_03_109:
	ld b,b			; $54d1
	inc h			; $54d2
	nop			; $54d3
	nop			; $54d4
	dec b			; $54d5
_label_03_110:
	nop			; $54d6
	ld b,b			; $54d7
	inc h			; $54d8
	nop			; $54d9
	nop			; $54da
	inc c			; $54db
	nop			; $54dc
	ld b,b			; $54dd
	rst $38			; $54de
	rst $38			; $54df
	inc a			; $54e0
	or h			; $54e1
	inc a			; $54e2
	ld d,b			; $54e3
	ld a,b			; $54e4
	or h			; $54e5
	inc a			; $54e6
	inc a			; $54e7
	inc a			; $54e8
	ld (hl),b		; $54e9
	ld a,b			; $54ea
	ld a,b			; $54eb
	ld hl,$cc03		; $54ec
	bit 0,(hl)		; $54ef
	jr nz,_label_03_111	; $54f1
	inc (hl)		; $54f3
	ld hl,$cbb3		; $54f4
	ld b,$10		; $54f7
	call clearMemory		; $54f9
_label_03_111:
	ld a,e			; $54fc
	rst_jumpTable			; $54fd
	rra			; $54fe
	ld d,l			; $54ff
	ld a,a			; $5500
	ld e,(hl)		; $5501
	xor l			; $5502
	ld e,e			; $5503
	ld a,$02		; $5504
	ld ($ff00+$70),a	; $5506
	ld hl,$df80		; $5508
	ld b,$80		; $550b
	call clearMemory		; $550d
	xor a			; $5510
	ld ($ff00+$70),a	; $5511
	dec a			; $5513
	ldh (<hSprPaletteSources),a	; $5514
	ldh (<hDirtySprPalettes),a	; $5516
	ld a,$fd		; $5518
	ldh (<hBgPaletteSources),a	; $551a
	ldh (<hDirtyBgPalettes),a	; $551c
	ret			; $551e
	ld de,$cbc1		; $551f
	ld a,(de)		; $5522
	rst_jumpTable			; $5523
	jr z,_label_03_112	; $5524
	ld sp,$cd5a		; $5526
	ld h,d			; $5529
	ld a,(de)		; $552a
	call $5534		; $552b
	call updateAllObjects		; $552e
	jp checkEnemyAndPartCollisionsIfTextInactive		; $5531
	ld de,$cbc2		; $5534
	ld a,(de)		; $5537
	rst_jumpTable			; $5538
	adc c			; $5539
	ld d,l			; $553a
	rst $30			; $553b
	ld d,l			; $553c
	rrca			; $553d
	ld d,(hl)		; $553e
	jr $56			; $553f
	ldi a,(hl)		; $5541
	ld d,(hl)		; $5542
	add hl,sp		; $5543
	ld d,(hl)		; $5544
	ld c,(hl)		; $5545
	ld d,(hl)		; $5546
	ld e,b			; $5547
	ld d,(hl)		; $5548
	or (hl)			; $5549
	ld d,(hl)		; $554a
	cp l			; $554b
	ld d,(hl)		; $554c
	rst_jumpTable			; $554d
	ld d,(hl)		; $554e
.DB $f4				; $554f
	ld d,(hl)		; $5550
	inc de			; $5551
	ld d,a			; $5552
	jr z,$57		; $5553
	dec sp			; $5555
	ld d,a			; $5556
	ld d,h			; $5557
	ld d,a			; $5558
	sbc c			; $5559
	ld d,a			; $555a
	or b			; $555b
	ld d,a			; $555c
	ret nz			; $555d
	ld d,a			; $555e
	ld (de),a		; $555f
	ld e,b			; $5560
	jr z,$58		; $5561
	ld a,$58		; $5563
	ld b,l			; $5565
	ld e,b			; $5566
	ld d,e			; $5567
	ld e,b			; $5568
	adc c			; $5569
	ld e,b			; $556a
	xor a			; $556b
	ld e,b			; $556c
	pop bc			; $556d
	ld e,b			; $556e
.DB $d3				; $556f
	ld e,b			; $5570
.DB $f4				; $5571
	ld e,b			; $5572
	ld ($1759),sp		; $5573
	ld e,c			; $5576
	ld a,a			; $5577
	ld e,c			; $5578
	sbc a			; $5579
	ld e,c			; $557a
_label_03_112:
	and a			; $557b
	ld e,c			; $557c
	or e			; $557d
	ld e,c			; $557e
	cp e			; $557f
	ld e,c			; $5580
	ret nz			; $5581
	ld e,c			; $5582
	call nc,$eb59		; $5583
	ld e,c			; $5586
	ld b,$5a		; $5587
	ld a,($c4ab)		; $5589
	or a			; $558c
	ret nz			; $558d
	ld b,$20		; $558e
	ld hl,$cfc0		; $5590
	call clearMemory		; $5593
	call incCbc2		; $5596
	xor a			; $5599
	ld bc,$0790		; $559a
	call $63d2		; $559d
	ld a,$0d		; $55a0
	call playSound		; $55a2
	call clearAllParentItems		; $55a5
	call dropLinkHeldItem		; $55a8
	ld c,$00		; $55ab
	call getFreeInteractionSlot		; $55ad
	jr nz,_label_03_113	; $55b0
	ld a,$a5		; $55b2
	ld ($cc1d),a		; $55b4
	ldi (hl),a		; $55b7
	ld (hl),c		; $55b8
	ld ($cc17),a		; $55b9
_label_03_113:
	ld a,c			; $55bc
	ld hl,$d000		; $55bd
	ld (hl),$03		; $55c0
	ld de,$55f3		; $55c2
	call addDoubleIndexToDe		; $55c5
	ld a,(de)		; $55c8
	inc de			; $55c9
	ld l,$0b		; $55ca
	ldi (hl),a		; $55cc
	inc l			; $55cd
	ld a,(de)		; $55ce
	ldi (hl),a		; $55cf
	ld l,$08		; $55d0
	ld (hl),$03		; $55d2
	ld a,c			; $55d4
	ld bc,$0050		; $55d5
	or a			; $55d8
	jr z,_label_03_114	; $55d9
	ld bc,$3050		; $55db
_label_03_114:
	ld hl,$ffa8		; $55de
	ld (hl),b		; $55e1
	ld hl,$ffaa		; $55e2
	ld (hl),c		; $55e5
	ld a,$80		; $55e6
	ld ($cca4),a		; $55e8
	ld a,$02		; $55eb
	call loadGfxRegisterStateIndex		; $55ed
	jp fadeinFromWhiteToRoom		; $55f0
	sbc c			; $55f3
	ret z			; $55f4
	sbc c			; $55f5
	cp b			; $55f6
	ld hl,$ccef		; $55f7
	ld (hl),$ff		; $55fa
	ld a,($c4ab)		; $55fc
	or a			; $55ff
	ret nz			; $5600
	ld a,($cfdf)		; $5601
	or a			; $5604
	ret z			; $5605
	call incCbc2		; $5606
	ld bc,$3d00		; $5609
	jp showText		; $560c
	call retIfTextIsActive		; $560f
	call incCbc2		; $5612
	jp fastFadeoutToWhite		; $5615
	ld a,($c4ab)		; $5618
	or a			; $561b
	ret nz			; $561c
	call incCbc2		; $561d
	ld hl,$cbb3		; $5620
	ld (hl),$3c		; $5623
	inc l			; $5625
	ld (hl),$00		; $5626
	jr _label_03_115		; $5628
	call $6462		; $562a
	ret nz			; $562d
	call incCbc2		; $562e
	ld a,$c1		; $5631
	call playSound		; $5633
	jp fadeoutToWhite		; $5636
	ld a,($c4ab)		; $5639
	or a			; $563c
	ret nz			; $563d
	call incCbc2		; $563e
	ld a,$00		; $5641
	call $644c		; $5643
	ld hl,$cbb3		; $5646
	ld (hl),$3c		; $5649
	jp fadeinFromWhite		; $564b
	call $6462		; $564e
	ret nz			; $5651
	call incCbc2		; $5652
	jp fastFadeoutToWhite		; $5655
	ld a,($c4ab)		; $5658
	or a			; $565b
	ret nz			; $565c
_label_03_115:
	call clearDynamicInteractions		; $565d
	ld hl,$cbb3		; $5660
	ld (hl),$3c		; $5663
	inc l			; $5665
	ld a,(hl)		; $5666
	ld hl,$56ac		; $5667
	rst_addDoubleIndex			; $566a
	ld c,(hl)		; $566b
	inc hl			; $566c
	ld b,(hl)		; $566d
	ld a,$03		; $566e
	call $63d2		; $5670
	call fastFadeinFromWhite		; $5673
	ld hl,$cbb4		; $5676
	ld a,(hl)		; $5679
	ld b,a			; $567a
	inc (hl)		; $567b
	cp $04			; $567c
	jr nc,_label_03_116	; $567e
	ld c,$04		; $5680
	push bc			; $5682
	ld a,$02		; $5683
	call loadGfxRegisterStateIndex		; $5685
	call resetCamera		; $5688
	pop bc			; $568b
	jr _label_03_117		; $568c
_label_03_116:
	ld hl,$cbb3		; $568e
	ld (hl),$3c		; $5691
	push bc			; $5693
	ld c,$01		; $5694
	call $55ad		; $5696
	pop bc			; $5699
	ld c,$08		; $569a
	call checkIsLinkedGame		; $569c
	ld b,$ff		; $569f
	jr z,_label_03_117	; $56a1
	ld c,$0d		; $56a3
_label_03_117:
	ld hl,$cbc2		; $56a5
	ld (hl),c		; $56a8
	jp $6405		; $56a9
	rst $20			; $56ac
	nop			; $56ad
	ld d,h			; $56ae
	nop			; $56af
	pop de			; $56b0
	nop			; $56b1
	ld e,(hl)		; $56b2
	nop			; $56b3
	sub b			; $56b4
	rlca			; $56b5
	ld e,$3c		; $56b6
	ld bc,$3d01		; $56b8
	jr _label_03_118		; $56bb
	call $645a		; $56bd
	ret nz			; $56c0
	call incCbc2		; $56c1
	jp fadeoutToWhite		; $56c4
	ld a,($c4ab)		; $56c7
	or a			; $56ca
	ret nz			; $56cb
	call incCbc2		; $56cc
	ld hl,$cbb3		; $56cf
	ld (hl),$3c		; $56d2
	ld a,$ff		; $56d4
	ld ($cd25),a		; $56d6
	call disableLcd		; $56d9
	ld a,$2b		; $56dc
	call loadGfxHeader		; $56de
	ld a,$9d		; $56e1
	call loadPaletteHeader		; $56e3
	call $539c		; $56e6
	call $5ab0		; $56e9
	ld a,$04		; $56ec
	call loadGfxRegisterStateIndex		; $56ee
	jp fadeinFromWhite		; $56f1
	call $5ab0		; $56f4
	call $6462		; $56f7
	ret nz			; $56fa
	call incCbc2		; $56fb
	ld hl,$cc02		; $56fe
	ld (hl),$01		; $5701
	ld hl,$cbb3		; $5703
	ld (hl),$3c		; $5706
	ld bc,$3d02		; $5708
	ld a,$01		; $570b
	ld ($cbae),a		; $570d
	jp showText		; $5710
	call $5ab0		; $5713
	call $645a		; $5716
	ret nz			; $5719
	call $646a		; $571a
	ld a,$01		; $571d
	ld ($cbc1),a		; $571f
	call disableActiveRing		; $5722
	jp fadeoutToWhite		; $5725
	ld e,$3c		; $5728
	ld bc,$4f00		; $572a
_label_03_118:
	call $6462		; $572d
	ret nz			; $5730
	call incCbc2		; $5731
	ld a,e			; $5734
	ld ($cbb3),a		; $5735
	jp showText		; $5738
	call $645a		; $573b
	ret nz			; $573e
	xor a			; $573f
	ld ($cbb3),a		; $5740
	dec a			; $5743
	ld ($cbba),a		; $5744
	ld a,$d2		; $5747
	call playSound		; $5749
	ld a,$f0		; $574c
	call playSound		; $574e
	jp incCbc2		; $5751
	ld hl,$cbb3		; $5754
	ld b,$02		; $5757
	call func_2d73		; $5759
	ret z			; $575c
	call incCbc2		; $575d
	xor a			; $5760
	ld bc,$059a		; $5761
	call $63d2		; $5764
	ld a,$ac		; $5767
	call loadPaletteHeader		; $5769
	call hideStatusBar		; $576c
	call $5504		; $576f
	ld b,$06		; $5772
_label_03_119:
	call getFreeInteractionSlot		; $5774
	jr nz,_label_03_120	; $5777
	ld (hl),$b0		; $5779
	inc l			; $577b
	dec b			; $577c
	ld (hl),b		; $577d
	jr nz,_label_03_119	; $577e
_label_03_120:
	ld hl,$cbb3		; $5780
	ld (hl),$1e		; $5783
	ld a,$13		; $5785
	call loadGfxRegisterStateIndex		; $5787
	ld hl,$c486		; $578a
	ldi a,(hl)		; $578d
	ldh (<hCameraY),a	; $578e
	ld a,(hl)		; $5790
	ldh (<hCameraX),a	; $5791
	ld a,$00		; $5793
	ld ($cd00),a		; $5795
	ret			; $5798
	call decCbb3		; $5799
	ret nz			; $579c
	call incCbc2		; $579d
	ld hl,$cbb3		; $57a0
	ld (hl),$28		; $57a3
	ld a,$04		; $57a5
	ld ($cbae),a		; $57a7
	ld bc,$4f01		; $57aa
	jp showText		; $57ad
	call $645a		; $57b0
	ret nz			; $57b3
	call incCbc2		; $57b4
	ld a,$20		; $57b7
	ld hl,$cbb3		; $57b9
	ldi (hl),a		; $57bc
	xor a			; $57bd
	ld (hl),a		; $57be
	ret			; $57bf
	call $6462		; $57c0
	ret nz			; $57c3
	ld hl,$cbb3		; $57c4
	ld (hl),$20		; $57c7
	inc hl			; $57c9
	ld a,(hl)		; $57ca
	cp $03			; $57cb
	jr nc,_label_03_121	; $57cd
	ld b,a			; $57cf
	push hl			; $57d0
	ld a,$72		; $57d1
	call playSound		; $57d3
	pop hl			; $57d6
	ld a,b			; $57d7
_label_03_121:
	inc (hl)		; $57d8
	ld hl,$580c		; $57d9
	rst_addAToHl			; $57dc
	ld a,(hl)		; $57dd
	or a			; $57de
	ld b,a			; $57df
	jr nz,_label_03_122	; $57e0
	call fadeinFromBlack		; $57e2
	ld a,$01		; $57e5
	ld ($c4b2),a		; $57e7
	ld ($c4b4),a		; $57ea
	ld hl,$cbb3		; $57ed
	ld (hl),$3c		; $57f0
	ld a,$21		; $57f2
	call playSound		; $57f4
	jp incCbc2		; $57f7
_label_03_122:
	call fastFadeinFromBlack		; $57fa
	ld a,b			; $57fd
	ld ($c4b2),a		; $57fe
	ld ($c4b4),a		; $5801
	xor a			; $5804
	ld ($c4b1),a		; $5805
	ld ($c4b3),a		; $5808
	ret			; $580b
	stop			; $580c
	ld b,b			; $580d
	add b			; $580e
	jr z,_label_03_123	; $580f
	nop			; $5811
	ld e,$28		; $5812
	ld bc,$4f02		; $5814
_label_03_123:
	call $581d		; $5817
	jp $572d		; $581a
	ld a,$08		; $581d
	ld ($cbae),a		; $581f
	ld a,$03		; $5822
	ld ($cbac),a		; $5824
	ret			; $5827
	ld e,$28		; $5828
	ld bc,$4f03		; $582a
_label_03_124:
	call $645a		; $582d
	ret nz			; $5830
	call incCbc2		; $5831
	ld hl,$cbb3		; $5834
	ld (hl),e		; $5837
	call $581d		; $5838
	jp showText		; $583b
	ld e,$3c		; $583e
	ld bc,$4f04		; $5840
	jr _label_03_124		; $5843
	ld e,$b4		; $5845
	call $645a		; $5847
	ret nz			; $584a
	call incCbc2		; $584b
	ld hl,$cbb3		; $584e
	ld (hl),e		; $5851
	ret			; $5852
	ld hl,$c486		; $5853
	ldh a,(<hCameraY)	; $5856
	ldi (hl),a		; $5858
	ldh a,(<hCameraX)	; $5859
	ldi (hl),a		; $585b
	ld hl,$5881		; $585c
	ld de,$c486		; $585f
	call $79cd		; $5862
	inc de			; $5865
	call $79cd		; $5866
	call $5d00		; $5869
	call decCbb3		; $586c
	ret nz			; $586f
	dec a			; $5870
	ld ($cbba),a		; $5871
	ld a,$d2		; $5874
	call playSound		; $5876
	ld a,$f0		; $5879
	call playSound		; $587b
	jp incCbc2		; $587e
	rst $38			; $5881
	ld bc,$0100		; $5882
	nop			; $5885
	nop			; $5886
	rst $38			; $5887
	nop			; $5888
	ld hl,$cbb3		; $5889
	ld b,$01		; $588c
	call func_2d73		; $588e
	ret z			; $5891
	call incCbc2		; $5892
	ld hl,$cbb3		; $5895
	ld (hl),$3c		; $5898
	call clearDynamicInteractions		; $589a
	call clearOam		; $589d
	call showStatusBar		; $58a0
	xor a			; $58a3
	ld bc,$0790		; $58a4
	call $63d2		; $58a7
	ld c,$01		; $58aa
	jp $55ad		; $58ac
	call decCbb3		; $58af
	ret nz			; $58b2
	call incCbc2		; $58b3
	ld hl,$cbb3		; $58b6
	ld (hl),$1e		; $58b9
	ld bc,$3d17		; $58bb
	jp showText		; $58be
	call $645a		; $58c1
	ret nz			; $58c4
	call incCbc2		; $58c5
	ld hl,$cbb3		; $58c8
	ld (hl),$1e		; $58cb
	ld bc,$4f09		; $58cd
	jp showText		; $58d0
	call $645a		; $58d3
	ret nz			; $58d6
	call incCbc2		; $58d7
	ld c,$40		; $58da
	ld a,$29		; $58dc
	call giveTreasure		; $58de
	ld a,$08		; $58e1
	call setLinkIDOverride		; $58e3
	ld l,$02		; $58e6
	ld (hl),$07		; $58e8
	ld hl,$cbb3		; $58ea
	ld (hl),$5a		; $58ed
	ld a,$4a		; $58ef
	jp playSound		; $58f1
	call decCbb3		; $58f4
	ret nz			; $58f7
	call incCbc2		; $58f8
	ld hl,$cbb3		; $58fb
	ld (hl),$b4		; $58fe
	ld bc,$90bd		; $5900
	ld a,$ff		; $5903
	jp createEnergySwirlGoingOut		; $5905
	call decCbb3		; $5908
	ret nz			; $590b
	call incCbc2		; $590c
	ld hl,$cbb3		; $590f
	ld (hl),$3c		; $5912
	jp fadeoutToWhite		; $5914
	call $6462		; $5917
	ret nz			; $591a
	call incCbc2		; $591b
	call disableLcd		; $591e
	call clearOam		; $5921
	call clearDynamicInteractions		; $5924
	call refreshObjectGfx		; $5927
	call hideStatusBar		; $592a
	ld a,$02		; $592d
	ld ($ff00+$70),a	; $592f
	ld hl,$de90		; $5931
	ld b,$08		; $5934
	ld a,$ff		; $5936
	call fillMemory		; $5938
	xor a			; $593b
	ld ($ff00+$70),a	; $593c
	ld a,$07		; $593e
	ldh (<hDirtyBgPalettes),a	; $5940
	ld b,$02		; $5942
_label_03_125:
	call getFreeInteractionSlot		; $5944
	jr nz,_label_03_126	; $5947
	ld (hl),$b0		; $5949
	inc l			; $594b
	ld a,$05		; $594c
	add b			; $594e
	ld (hl),a		; $594f
	dec b			; $5950
	jr nz,_label_03_125	; $5951
_label_03_126:
	ld a,$02		; $5953
	ld ($cbcb),a		; $5955
	call $7a6b		; $5958
	ld a,$02		; $595b
	call $7a88		; $595d
	ld hl,$cbb3		; $5960
	ld (hl),$1e		; $5963
	ld a,$04		; $5965
	call loadGfxRegisterStateIndex		; $5967
	ld a,$10		; $596a
	ldh (<hCameraY),a	; $596c
	ld ($cd2d),a		; $596e
	xor a			; $5971
	ldh (<hCameraX),a	; $5972
	ld a,$00		; $5974
	ld ($cd00),a		; $5976
	ld bc,$4f05		; $5979
	jp showText		; $597c
	call $645a		; $597f
	ret nz			; $5982
	call incCbc2		; $5983
	ld b,$02		; $5986
	call fadeinFromWhite		; $5988
	ld a,b			; $598b
	ld ($c4b2),a		; $598c
	ld ($c4b4),a		; $598f
	xor a			; $5992
	ld ($c4b1),a		; $5993
	ld ($c4b3),a		; $5996
	ld hl,$cbb3		; $5999
	ld (hl),$3c		; $599c
	ret			; $599e
	ld e,$1e		; $599f
	ld bc,$4f06		; $59a1
	jp $572d		; $59a4
	call $645a		; $59a7
	ret nz			; $59aa
	call incCbc2		; $59ab
	ld b,$14		; $59ae
	jp $5988		; $59b0
	ld e,$1e		; $59b3
	ld bc,$4f07		; $59b5
	jp $572d		; $59b8
	ld e,$3c		; $59bb
	jp $5847		; $59bd
	call decCbb3		; $59c0
	ret nz			; $59c3
	call incCbc2		; $59c4
	ld hl,$cbb3		; $59c7
	ld (hl),$f0		; $59ca
	ld a,$ff		; $59cc
	ld bc,$4850		; $59ce
	jp createEnergySwirlGoingOut		; $59d1
	call decCbb3		; $59d4
	ret nz			; $59d7
	ld hl,$cbb3		; $59d8
	ld (hl),$5a		; $59db
	call fadeoutToWhite		; $59dd
	ld a,$fc		; $59e0
	ld ($c4b1),a		; $59e2
	ld ($c4b3),a		; $59e5
	jp incCbc2		; $59e8
	call $6462		; $59eb
	ret nz			; $59ee
	call incCbc2		; $59ef
	call clearDynamicInteractions		; $59f2
	call clearParts		; $59f5
	call clearOam		; $59f8
	ld hl,$cbb3		; $59fb
	ld (hl),$3c		; $59fe
	ld bc,$4f08		; $5a00
	jp showTextNonExitable		; $5a03
	ld a,($cba0)		; $5a06
	rlca			; $5a09
	ret nc			; $5a0a
	call decCbb3		; $5a0b
	ret nz			; $5a0e
	call showStatusBar		; $5a0f
	xor a			; $5a12
	ld ($cbcb),a		; $5a13
	dec a			; $5a16
	ld (wActiveMusic),a		; $5a17
	ld a,$f0		; $5a1a
	call playSound		; $5a1c
	ld hl,$cc63		; $5a1f
	ld a,$85		; $5a22
	ldi (hl),a		; $5a24
	ld a,$9d		; $5a25
	ldi (hl),a		; $5a27
	ld a,$0f		; $5a28
	ldi (hl),a		; $5a2a
	ld a,$57		; $5a2b
	ldi (hl),a		; $5a2d
	ld (hl),$03		; $5a2e
	ret			; $5a30
	call $5a37		; $5a31
	jp updateAllObjects		; $5a34
	ld de,$cbc2		; $5a37
	ld a,(de)		; $5a3a
	rst_jumpTable			; $5a3b
	ld d,b			; $5a3c
	ld e,d			; $5a3d
	ld a,l			; $5a3e
	ld e,d			; $5a3f
	adc d			; $5a40
	ld e,d			; $5a41
	cp h			; $5a42
	ld e,d			; $5a43
	jp nc,$e35a		; $5a44
	ld e,d			; $5a47
	rst $38			; $5a48
	ld e,d			; $5a49
	inc d			; $5a4a
	ld e,e			; $5a4b
	dec hl			; $5a4c
	ld e,e			; $5a4d
	add c			; $5a4e
	ld e,e			; $5a4f
	call $5ab0		; $5a50
	ld a,($c4ab)		; $5a53
	or a			; $5a56
	ret nz			; $5a57
	call incCbc2		; $5a58
	ld hl,$cbb3		; $5a5b
	ld (hl),$3c		; $5a5e
	call disableLcd		; $5a60
	call clearOam		; $5a63
	ld a,$2c		; $5a66
	call loadGfxHeader		; $5a68
	ld a,$9e		; $5a6b
	call loadPaletteHeader		; $5a6d
	ld a,$04		; $5a70
	call loadGfxRegisterStateIndex		; $5a72
	ld a,$21		; $5a75
	call playSound		; $5a77
	jp fadeinFromWhite		; $5a7a
	ld a,$01		; $5a7d
	ld ($cbae),a		; $5a7f
	ld a,$3c		; $5a82
	ld bc,$3d03		; $5a84
	jp $572d		; $5a87
	call $645a		; $5a8a
	ret nz			; $5a8d
	call incCbc2		; $5a8e
	ld hl,$cbb5		; $5a91
	ld (hl),$d0		; $5a94
_label_03_127:
	ld hl,$6472		; $5a96
_label_03_128:
	ld b,$30		; $5a99
	ld de,$cbb5		; $5a9b
	ld a,(de)		; $5a9e
	ld c,a			; $5a9f
	jr _label_03_129		; $5aa0
	ld hl,$4da3		; $5aa2
	ld e,$15		; $5aa5
	ld bc,$3038		; $5aa7
	xor a			; $5aaa
	ldh (<hOamTail),a	; $5aab
	jp addSpritesFromBankToOam_withOffset		; $5aad
	ld hl,$65a4		; $5ab0
	ld bc,$3038		; $5ab3
_label_03_129:
	xor a			; $5ab6
	ldh (<hOamTail),a	; $5ab7
	jp addSpritesToOam_withOffset		; $5ab9
	ld hl,$cbb5		; $5abc
	inc (hl)		; $5abf
	jr nz,_label_03_127	; $5ac0
	call clearOam		; $5ac2
	ld a,$0a		; $5ac5
	call loadUncompressedGfxHeader		; $5ac7
	ld hl,$cbb3		; $5aca
	ld (hl),$1e		; $5acd
	jp incCbc2		; $5acf
	call decCbb3		; $5ad2
	ret nz			; $5ad5
	call incCbc2		; $5ad6
	ld hl,$cbb5		; $5ad9
	ld (hl),$d0		; $5adc
	ld hl,$650b		; $5ade
	jr _label_03_128		; $5ae1
	call $5ade		; $5ae3
	ld hl,$cbb5		; $5ae6
	dec (hl)		; $5ae9
	ld a,(hl)		; $5aea
	sub $a0			; $5aeb
	ret nz			; $5aed
	ld ($cd08),a		; $5aee
	ld ($cd09),a		; $5af1
	ld a,$1e		; $5af4
	ld ($cbb3),a		; $5af6
	ld ($cbcb),a		; $5af9
	jp incCbc2		; $5afc
	call $5ade		; $5aff
	call decCbb3		; $5b02
	ret nz			; $5b05
	ld hl,$cbb3		; $5b06
	ld (hl),$14		; $5b09
	ld bc,$3d04		; $5b0b
	call $570b		; $5b0e
	jp incCbc2		; $5b11
	call $5ade		; $5b14
	call $645a		; $5b17
	ret nz			; $5b1a
	xor a			; $5b1b
	ld ($cbcb),a		; $5b1c
	dec a			; $5b1f
	ld ($cbba),a		; $5b20
	ld a,$d2		; $5b23
	call playSound		; $5b25
	jp incCbc2		; $5b28
	call $5ade		; $5b2b
	ld hl,$cbb3		; $5b2e
	ld b,$02		; $5b31
	call func_2d73		; $5b33
	ret z			; $5b36
	call incCbc2		; $5b37
	ld hl,$cbb3		; $5b3a
	ld (hl),$1e		; $5b3d
	call disableLcd		; $5b3f
	call clearOam		; $5b42
	xor a			; $5b45
	ld ($ff00+$4f),a	; $5b46
	ld hl,$8000		; $5b48
	ld bc,$2000		; $5b4b
	call clearMemoryBc		; $5b4e
	xor a			; $5b51
	ld ($ff00+$4f),a	; $5b52
	ld hl,$9c00		; $5b54
	ld bc,$0400		; $5b57
	call clearMemoryBc		; $5b5a
	ld a,$01		; $5b5d
	ld ($ff00+$4f),a	; $5b5f
	ld hl,$9c00		; $5b61
	ld bc,$0400		; $5b64
	call clearMemoryBc		; $5b67
	ld a,$2d		; $5b6a
	call loadGfxHeader		; $5b6c
	ld a,$9c		; $5b6f
	call loadPaletteHeader		; $5b71
	ld a,$04		; $5b74
	call loadGfxRegisterStateIndex		; $5b76
	ld a,$d2		; $5b79
	call playSound		; $5b7b
	jp clearPaletteFadeVariablesAndRefreshPalettes		; $5b7e
	call decCbb3		; $5b81
	ret nz			; $5b84
	ld a,$0a		; $5b85
	ld ($c2ef),a		; $5b87
	call $646a		; $5b8a
	ld hl,$cf00		; $5b8d
	ld bc,$00c0		; $5b90
	call clearMemoryBc		; $5b93
	ld hl,$ce00		; $5b96
	ld bc,$00c0		; $5b99
	call clearMemoryBc		; $5b9c
	ldh (<hCameraY),a	; $5b9f
	ldh (<hCameraX),a	; $5ba1
	ld hl,$cbb3		; $5ba3
	ld (hl),$3c		; $5ba6
	ld a,$03		; $5ba8
	jp fadeoutToBlackWithDelay		; $5baa
	ld de,$cbc1		; $5bad
	ld a,(de)		; $5bb0
	rst_jumpTable			; $5bb1
	or (hl)			; $5bb2
	ld e,e			; $5bb3
	ld e,$5d		; $5bb4
	call updateStatusBar		; $5bb6
	call $5bbf		; $5bb9
	jp updateAllObjects		; $5bbc
	ld de,$cbc2		; $5bbf
	ld a,(de)		; $5bc2
	rst_jumpTable			; $5bc3
	ld ($ff00+$5b),a	; $5bc4
	add hl,bc		; $5bc6
	ld e,h			; $5bc7
	ld a,(de)		; $5bc8
	ld e,h			; $5bc9
	inc l			; $5bca
	ld e,h			; $5bcb
	ld b,(hl)		; $5bcc
	ld e,h			; $5bcd
	ld e,d			; $5bce
	ld e,h			; $5bcf
	ld l,c			; $5bd0
	ld e,h			; $5bd1
	ld a,l			; $5bd2
	ld e,h			; $5bd3
	adc a			; $5bd4
	ld e,h			; $5bd5
	and e			; $5bd6
	ld e,h			; $5bd7
	cp b			; $5bd8
	ld e,h			; $5bd9
	cp l			; $5bda
	ld e,h			; $5bdb
	rst_addAToHl			; $5bdc
	ld e,h			; $5bdd
	jp hl			; $5bde
	ld e,h			; $5bdf
	ld a,$01		; $5be0
	ld (de),a		; $5be2
	ld hl,$c6c5		; $5be3
	ld (hl),$ff		; $5be6
	xor a			; $5be8
	ldh (<hActiveObjectType),a	; $5be9
	ld de,$d000		; $5beb
	ld bc,$f8f0		; $5bee
	ld a,$28		; $5bf1
	call objectCreateExclamationMark		; $5bf3
	ld a,$28		; $5bf6
	call objectCreateExclamationMark		; $5bf8
	ld l,$4b		; $5bfb
	ld (hl),$30		; $5bfd
	inc l			; $5bff
	inc l			; $5c00
	ld (hl),$78		; $5c01
	ld hl,$cbb3		; $5c03
	ld (hl),$0a		; $5c06
	ret			; $5c08
	call decCbb3		; $5c09
	ret nz			; $5c0c
	ld hl,$cbb3		; $5c0d
	ld (hl),$1e		; $5c10
	ld a,$f0		; $5c12
	call playSound		; $5c14
	jp incCbc2		; $5c17
	call $5cfb		; $5c1a
	call decCbb3		; $5c1d
	ret nz			; $5c20
	call incCbc2		; $5c21
	ld hl,$cbb3		; $5c24
	ld (hl),$96		; $5c27
	jp $5d0b		; $5c29
	call $5cfb		; $5c2c
	call decCbb3		; $5c2f
	ret nz			; $5c32
	call incCbc2		; $5c33
	ld a,$f1		; $5c36
	call playSound		; $5c38
	ld hl,$cbb3		; $5c3b
	ld (hl),$3c		; $5c3e
	ld bc,$3d0e		; $5c40
	jp showText		; $5c43
	call $645a		; $5c46
	ret nz			; $5c49
	call incCbc2		; $5c4a
	ld a,$21		; $5c4d
	call playSound		; $5c4f
	ld hl,$cbb3		; $5c52
	ld (hl),$3c		; $5c55
	jp $5d0b		; $5c57
	call $5cfb		; $5c5a
	call decCbb3		; $5c5d
	ret nz			; $5c60
	ld hl,$cbb3		; $5c61
	ld (hl),$5a		; $5c64
	jp incCbc2		; $5c66
	call $5cfb		; $5c69
	call decCbb3		; $5c6c
	ret nz			; $5c6f
	call incCbc2		; $5c70
	ld hl,$cbb3		; $5c73
	ld (hl),$3c		; $5c76
	ld a,$f1		; $5c78
	jp playSound		; $5c7a
	call decCbb3		; $5c7d
	ret nz			; $5c80
	call incCbc2		; $5c81
	ld hl,$cbb3		; $5c84
	ld (hl),$3c		; $5c87
	ld bc,$3d0f		; $5c89
	jp showText		; $5c8c
	call $645a		; $5c8f
	ret nz			; $5c92
	call incCbc2		; $5c93
	ld hl,$cbb3		; $5c96
	ld (hl),$2c		; $5c99
	inc hl			; $5c9b
	ld (hl),$01		; $5c9c
	ld b,$03		; $5c9e
	jp $5d12		; $5ca0
	ld hl,$cbb3		; $5ca3
	call decHlRef16WithCap		; $5ca6
	ret nz			; $5ca9
	call incCbc2		; $5caa
	ld hl,$cbb3		; $5cad
	ld (hl),$3c		; $5cb0
	ld bc,$3d10		; $5cb2
	jp showText		; $5cb5
	ld e,$1e		; $5cb8
	jp $5847		; $5cba
	call $5cfb		; $5cbd
	call decCbb3		; $5cc0
	ret nz			; $5cc3
	call incCbc2		; $5cc4
	call $5d0b		; $5cc7
	ld a,$8c		; $5cca
	ld ($cbb3),a		; $5ccc
	ld a,$ff		; $5ccf
	ld bc,$4478		; $5cd1
	jp createEnergySwirlGoingOut		; $5cd4
	call $5cfb		; $5cd7
	call decCbb3		; $5cda
	ret nz			; $5cdd
	call incCbc2		; $5cde
	ld hl,$cbb3		; $5ce1
	ld (hl),$3c		; $5ce4
	jp $5d0b		; $5ce6
	call $5cfb		; $5ce9
	call decCbb3		; $5cec
	ret nz			; $5cef
	call incCbc1		; $5cf0
	inc l			; $5cf3
	xor a			; $5cf4
	ld (hl),a		; $5cf5
	ld a,$03		; $5cf6
	jp fadeoutToWhiteWithDelay		; $5cf8
	ld a,$04		; $5cfb
	call setScreenShakeCounter		; $5cfd
	ld a,(wFrameCounter)		; $5d00
	and $0f			; $5d03
	ld a,$b8		; $5d05
	jp z,playSound		; $5d07
	ret			; $5d0a
	call getFreePartSlot		; $5d0b
	ret nz			; $5d0e
	ld (hl),$48		; $5d0f
	ret			; $5d11
	call getFreeInteractionSlot		; $5d12
	ret nz			; $5d15
	ld (hl),$48		; $5d16
	inc l			; $5d18
	ld (hl),$00		; $5d19
	inc l			; $5d1b
	ld (hl),b		; $5d1c
	ret			; $5d1d
	call updateStatusBar		; $5d1e
	call $5d27		; $5d21
	jp updateAllObjects		; $5d24
	ld de,$cbc2		; $5d27
	ld a,(de)		; $5d2a
	rst_jumpTable			; $5d2b
	ld b,d			; $5d2c
	ld e,l			; $5d2d
	ld a,a			; $5d2e
	ld e,l			; $5d2f
	sub e			; $5d30
	ld e,l			; $5d31
	and d			; $5d32
	ld e,l			; $5d33
	cp l			; $5d34
	ld e,l			; $5d35
.DB $d3				; $5d36
	ld e,l			; $5d37
	rst $20			; $5d38
	ld e,l			; $5d39
	nop			; $5d3a
	ld e,(hl)		; $5d3b
	ld c,$5e		; $5d3c
	dec sp			; $5d3e
	ld e,(hl)		; $5d3f
	ld c,a			; $5d40
	ld e,(hl)		; $5d41
	call $5cfb		; $5d42
	ld a,($c4ab)		; $5d45
	or a			; $5d48
	ret nz			; $5d49
	call incCbc2		; $5d4a
	xor a			; $5d4d
	ld bc,$022b		; $5d4e
	call $63d2		; $5d51
	call refreshObjectGfx		; $5d54
	ld b,$0c		; $5d57
	call getEntryFromObjectTable1		; $5d59
	ld d,h			; $5d5c
	ld e,l			; $5d5d
	call parseGivenObjectData		; $5d5e
	ld a,$04		; $5d61
	ld b,$02		; $5d63
	call $642e		; $5d65
	ld a,$f1		; $5d68
	call playSound		; $5d6a
	ld a,$fa		; $5d6d
	call playSound		; $5d6f
	ld a,$02		; $5d72
	call loadGfxRegisterStateIndex		; $5d74
	ld hl,$cbb3		; $5d77
	ld (hl),$3c		; $5d7a
	jp fadeinFromWhiteToRoom		; $5d7c
	call $6462		; $5d7f
	ret nz			; $5d82
	call incCbc2		; $5d83
	ld a,$3c		; $5d86
	ld ($cbb3),a		; $5d88
	ld a,$64		; $5d8b
	ld bc,$5850		; $5d8d
	jp createEnergySwirlGoingIn		; $5d90
	call decCbb3		; $5d93
	ret nz			; $5d96
	xor a			; $5d97
	ld ($cbb3),a		; $5d98
	dec a			; $5d9b
	ld ($cbba),a		; $5d9c
	jp incCbc2		; $5d9f
	ld hl,$cbb3		; $5da2
	ld b,$01		; $5da5
	call func_2d73		; $5da7
	ret z			; $5daa
	call incCbc2		; $5dab
	ld hl,$cbb3		; $5dae
	ld (hl),$3c		; $5db1
	ld a,$01		; $5db3
	ld ($cfc0),a		; $5db5
	ld a,$03		; $5db8
	jp fadeinFromWhiteWithDelay		; $5dba
	call $6462		; $5dbd
	ret nz			; $5dc0
	ld a,$01		; $5dc1
	ld ($cc17),a		; $5dc3
	ld a,$29		; $5dc6
	call playSound		; $5dc8
	ld hl,$cbb3		; $5dcb
	ld (hl),$3c		; $5dce
	jp incCbc2		; $5dd0
	call decCbb3		; $5dd3
	ret nz			; $5dd6
	call incCbc2		; $5dd7
	ld hl,$cbb3		; $5dda
	ld (hl),$2c		; $5ddd
	inc hl			; $5ddf
	ld (hl),$01		; $5de0
	ld b,$00		; $5de2
	jp $5d12		; $5de4
	ld hl,$cbb3		; $5de7
	call decHlRef16WithCap		; $5dea
	ret nz			; $5ded
	ld a,$01		; $5dee
	ld ($cc17),a		; $5df0
	ld hl,$cbb3		; $5df3
	ld (hl),$3c		; $5df6
	ld hl,$cfc0		; $5df8
	ld (hl),$02		; $5dfb
	jp incCbc2		; $5dfd
	ld a,($cfc0)		; $5e00
	cp $09			; $5e03
	ret nz			; $5e05
	call incCbc2		; $5e06
	ld a,$03		; $5e09
	jp fadeoutToWhiteWithDelay		; $5e0b
	ld a,($c4ab)		; $5e0e
	or a			; $5e11
	ret nz			; $5e12
	call incCbc2		; $5e13
	call disableLcd		; $5e16
	call clearScreenVariablesAndWramBank1		; $5e19
	call hideStatusBar		; $5e1c
	ld a,$3c		; $5e1f
	call loadGfxHeader		; $5e21
	ld a,$ad		; $5e24
	call loadPaletteHeader		; $5e26
	ld hl,$cbb3		; $5e29
	ld (hl),$f0		; $5e2c
	ld a,$04		; $5e2e
	call loadGfxRegisterStateIndex		; $5e30
	call $5aa2		; $5e33
	ld a,$03		; $5e36
	jp fadeinFromWhiteWithDelay		; $5e38
	call $5aa2		; $5e3b
	call $6462		; $5e3e
	ret nz			; $5e41
	call incCbc2		; $5e42
	ld hl,$cbb3		; $5e45
	ld (hl),$10		; $5e48
	ld a,$03		; $5e4a
	jp fadeoutToBlackWithDelay		; $5e4c
	call $5aa2		; $5e4f
	call $6462		; $5e52
	ret nz			; $5e55
	ld a,$0a		; $5e56
	ld ($c2ef),a		; $5e58
	call $646a		; $5e5b
	ld hl,$cf00		; $5e5e
	ld bc,$00c0		; $5e61
	call clearMemoryBc		; $5e64
	ld hl,$ce00		; $5e67
	ld bc,$00c0		; $5e6a
	call clearMemoryBc		; $5e6d
	xor a			; $5e70
	ldh (<hCameraY),a	; $5e71
	ldh (<hCameraX),a	; $5e73
	ld hl,$cbb3		; $5e75
	ld (hl),$3c		; $5e78
	ld a,$fb		; $5e7a
	jp playSound		; $5e7c
	call $5e85		; $5e7f
	jp func_3539		; $5e82
	ld de,$cbc1		; $5e85
	ld a,(de)		; $5e88
	rst_jumpTable			; $5e89
	sub d			; $5e8a
	ld e,(hl)		; $5e8b
.DB $f4				; $5e8c
	ld e,(hl)		; $5e8d
	ld l,l			; $5e8e
	ld h,b			; $5e8f
	ld a,($1161)		; $5e90
	jp nz,$1acb		; $5e93
	rst_jumpTable			; $5e96
	sbc l			; $5e97
	ld e,(hl)		; $5e98
	cp h			; $5e99
	ld e,(hl)		; $5e9a
	ret c			; $5e9b
	ld e,(hl)		; $5e9c
	call $6462		; $5e9d
	ret nz			; $5ea0
	call $66dc		; $5ea1
	call incCbc2		; $5ea4
	call clearOam		; $5ea7
	ld hl,$cbb3		; $5eaa
	ld (hl),$b4		; $5ead
	inc hl			; $5eaf
	ld (hl),$00		; $5eb0
	ld hl,$c485		; $5eb2
	set 3,(hl)		; $5eb5
	ld a,$2a		; $5eb7
	jp playSound		; $5eb9
	ld hl,$cbb3		; $5ebc
	call decHlRef16WithCap		; $5ebf
	ret nz			; $5ec2
	call incCbc2		; $5ec3
	ld hl,$cbb3		; $5ec6
	ld (hl),$48		; $5ec9
	inc hl			; $5ecb
	ld (hl),$03		; $5ecc
	ld a,$04		; $5ece
	call loadPaletteHeader		; $5ed0
	ld a,$06		; $5ed3
	jp fadeinFromBlackWithDelay		; $5ed5
	ld hl,$cbb3		; $5ed8
	call decHlRef16WithCap		; $5edb
	ret nz			; $5ede
	call incCbc1		; $5edf
	inc l			; $5ee2
	ld (hl),a		; $5ee3
	ld b,$04		; $5ee4
	call checkIsLinkedGame		; $5ee6
	jr z,_label_03_130	; $5ee9
	ld b,$08		; $5eeb
_label_03_130:
	ld hl,$cbb4		; $5eed
	ld (hl),b		; $5ef0
	jp fadeoutToWhite		; $5ef1
	ld de,$cbc2		; $5ef4
	ld a,(de)		; $5ef7
	rst_jumpTable			; $5ef8
	inc bc			; $5ef9
	ld e,a			; $5efa
	or (hl)			; $5efb
	ld e,a			; $5efc
	bit 3,a			; $5efd
	ld de,$2d60		; $5eff
	ld h,b			; $5f02
	xor a			; $5f03
	ldh (<hOamTail),a	; $5f04
	ld a,($c4ab)		; $5f06
	or a			; $5f09
	ret nz			; $5f0a
	call disableLcd		; $5f0b
	call incCbc2		; $5f0e
	call clearDynamicInteractions		; $5f11
	call clearOam		; $5f14
	ld a,$10		; $5f17
	ldh (<hOamTail),a	; $5f19
	ld a,($cbb4)		; $5f1b
	sub $04			; $5f1e
	ld hl,$5fa6		; $5f20
	rst_addDoubleIndex			; $5f23
	ld b,(hl)		; $5f24
	inc hl			; $5f25
	ld a,(hl)		; $5f26
	or a			; $5f27
	jr z,_label_03_132	; $5f28
	ld c,a			; $5f2a
	ld a,$00		; $5f2b
	call func_36f6		; $5f2d
	ld b,$2d		; $5f30
	ld a,($cbb4)		; $5f32
	cp $04			; $5f35
	jr nz,_label_03_131	; $5f37
	ld b,$0f		; $5f39
_label_03_131:
	ld a,b			; $5f3b
	call loadUncompressedGfxHeader		; $5f3c
_label_03_132:
	ld a,($cbb4)		; $5f3f
	sub $04			; $5f42
	add a			; $5f44
	add $85			; $5f45
	call loadGfxHeader		; $5f47
	ld a,$0f		; $5f4a
	call loadPaletteHeader		; $5f4c
	call reloadObjectGfx		; $5f4f
	call checkIsLinkedGame		; $5f52
	jr nz,_label_03_133	; $5f55
	ld a,($cbb4)		; $5f57
	ld b,$10		; $5f5a
	ld c,$00		; $5f5c
	cp $05			; $5f5e
	jr nz,_label_03_134	; $5f60
	ld b,$50		; $5f62
	ld c,$0e		; $5f64
	jr _label_03_134		; $5f66
_label_03_133:
	ld a,($cbb4)		; $5f68
	ld b,$10		; $5f6b
	ld c,$00		; $5f6d
	cp $0b			; $5f6f
	jr nz,_label_03_134	; $5f71
	ld b,$ae		; $5f73
	ld c,$ff		; $5f75
_label_03_134:
	ld a,b			; $5f77
	push bc			; $5f78
	call loadPaletteHeader		; $5f79
	pop bc			; $5f7c
	ld a,c			; $5f7d
	ld ($cd25),a		; $5f7e
	call loadAnimationData		; $5f81
	ld a,$01		; $5f84
	ld ($cd00),a		; $5f86
	xor a			; $5f89
	ldh (<hCameraX),a	; $5f8a
	ld b,$20		; $5f8c
	ld hl,$cfc0		; $5f8e
	call clearMemory		; $5f91
	ld hl,$cbb3		; $5f94
	ld (hl),$f0		; $5f97
	inc l			; $5f99
	ld b,(hl)		; $5f9a
	call $6405		; $5f9b
	ld a,$04		; $5f9e
	call loadGfxRegisterStateIndex		; $5fa0
	jp fadeinFromWhite		; $5fa3
	nop			; $5fa6
	add $01			; $5fa7
	dec hl			; $5fa9
	nop			; $5faa
	or (hl)			; $5fab
	nop			; $5fac
	sub $00			; $5fad
	nop			; $5faf
	ld bc,$002b		; $5fb0
	nop			; $5fb3
	nop			; $5fb4
	nop			; $5fb5
	ld a,($c4ab)		; $5fb6
	or a			; $5fb9
	ret nz			; $5fba
	ld a,($cfdf)		; $5fbb
	or a			; $5fbe
	ret z			; $5fbf
	call incCbc2		; $5fc0
	ld a,$ff		; $5fc3
	ld ($cd25),a		; $5fc5
	jp fadeoutToWhite		; $5fc8
	ld a,($c4ab)		; $5fcb
	or a			; $5fce
	ret nz			; $5fcf
	call incCbc2		; $5fd0
	call disableLcd		; $5fd3
	call clearWramBank1		; $5fd6
	ld a,($cbb4)		; $5fd9
	sub $04			; $5fdc
	add a			; $5fde
	add $86			; $5fdf
	call loadGfxHeader		; $5fe1
	ld hl,$cbb3		; $5fe4
	ld (hl),$5a		; $5fe7
	inc l			; $5fe9
	ld a,(hl)		; $5fea
	add $9d			; $5feb
	call loadPaletteHeader		; $5fed
	ld a,$04		; $5ff0
	call loadGfxRegisterStateIndex		; $5ff2
	ld a,($cbb4)		; $5ff5
	sub $04			; $5ff8
	ld hl,$6009		; $5ffa
	rst_addAToHl			; $5ffd
	ld a,(hl)		; $5ffe
	ld ($c487),a		; $5fff
	ld a,$10		; $6002
	ldh (<hCameraX),a	; $6004
	jp fadeinFromWhite		; $6006
	nop			; $6009
	ret nc			; $600a
	nop			; $600b
	ret nc			; $600c
	nop			; $600d
	ret nc			; $600e
	nop			; $600f
	ret nc			; $6010
	ld a,($c4ab)		; $6011
	or a			; $6014
	ret nz			; $6015
	call decCbb3		; $6016
	ret nz			; $6019
	call incCbc2		; $601a
	call getFreeInteractionSlot		; $601d
	ret nz			; $6020
	ld (hl),$ae		; $6021
	inc l			; $6023
	ld a,($cbb4)		; $6024
	sub $04			; $6027
	ldi (hl),a		; $6029
	ld (hl),$00		; $602a
	ret			; $602c
	ld a,($c4ab)		; $602d
	or a			; $6030
	ret nz			; $6031
	xor a			; $6032
	ldh (<hOamTail),a	; $6033
	ld a,($cfde)		; $6035
	or a			; $6038
	ret z			; $6039
	ld b,$07		; $603a
	call checkIsLinkedGame		; $603c
	jr z,_label_03_135	; $603f
	ld b,$0b		; $6041
_label_03_135:
	ld hl,$cbb4		; $6043
	ld a,(hl)		; $6046
	cp b			; $6047
	jr nc,_label_03_136	; $6048
	inc (hl)		; $604a
	xor a			; $604b
	ld ($cbc2),a		; $604c
	jr _label_03_137		; $604f
_label_03_136:
	call $646a		; $6051
	call enableActiveRing		; $6054
	ld a,$02		; $6057
	ld ($cbc1),a		; $6059
	ld hl,$c6a3		; $605c
	ldd a,(hl)		; $605f
	ld (hl),a		; $6060
	xor a			; $6061
	ld l,$80		; $6062
	ldi (hl),a		; $6064
	ld (hl),a		; $6065
	ld l,$c5		; $6066
	ld (hl),$ff		; $6068
_label_03_137:
	jp fadeoutToWhite		; $606a
	xor a			; $606d
	ldh (<hOamTail),a	; $606e
	ld de,$cbc2		; $6070
	ld a,(de)		; $6073
	rst_jumpTable			; $6074
	add a			; $6075
	ld h,b			; $6076
	cp l			; $6077
	ld h,b			; $6078
	call $0e60		; $6079
	ld h,c			; $607c
	ldi a,(hl)		; $607d
	ld h,c			; $607e
	ld (hl),$61		; $607f
	xor c			; $6081
	ld h,c			; $6082
	cp b			; $6083
	ld h,c			; $6084
	and $61			; $6085
	ld a,($c4ab)		; $6087
	or a			; $608a
	ret nz			; $608b
	call incCbc2		; $608c
	call disableLcd		; $608f
	call clearDynamicInteractions		; $6092
	call clearOam		; $6095
	xor a			; $6098
	ld ($cfde),a		; $6099
	ld a,$95		; $609c
	call loadGfxHeader		; $609e
	ld a,$a0		; $60a1
	call loadPaletteHeader		; $60a3
	ld a,$09		; $60a6
	call loadGfxRegisterStateIndex		; $60a8
	call fadeinFromWhite		; $60ab
	call getFreeInteractionSlot		; $60ae
	ret nz			; $60b1
	ld (hl),$af		; $60b2
	ld l,$4b		; $60b4
	ld (hl),$e8		; $60b6
	inc l			; $60b8
	inc l			; $60b9
	ld (hl),$50		; $60ba
	ret			; $60bc
	ld a,($cfde)		; $60bd
	or a			; $60c0
	ret z			; $60c1
	ld hl,$cbb3		; $60c2
	ld (hl),$e0		; $60c5
	inc hl			; $60c7
	ld (hl),$01		; $60c8
	jp incCbc2		; $60ca
	ld hl,$cbb3		; $60cd
	call decHlRef16WithCap		; $60d0
	ret nz			; $60d3
	call checkIsLinkedGame		; $60d4
	jr nz,_label_03_138	; $60d7
	call $646a		; $60d9
	ld a,$03		; $60dc
	ld ($cbc1),a		; $60de
	ld a,$04		; $60e1
	jp fadeoutToWhiteWithDelay		; $60e3
_label_03_138:
	ld a,$04		; $60e6
	ld ($cbb3),a		; $60e8
	ld a,($c486)		; $60eb
	ldh (<hCameraY),a	; $60ee
	ld a,$01		; $60f0
	call loadUncompressedGfxHeader		; $60f2
	ld a,$0b		; $60f5
	call loadPaletteHeader		; $60f7
	ld b,$03		; $60fa
_label_03_139:
	call getFreeInteractionSlot		; $60fc
	jr nz,_label_03_140	; $60ff
	ld (hl),$4a		; $6101
	inc l			; $6103
	ld (hl),$09		; $6104
	inc l			; $6106
	dec b			; $6107
	ld (hl),b		; $6108
	jr nz,_label_03_139	; $6109
_label_03_140:
	jp incCbc2		; $610b
	ld a,($c486)		; $610e
	or a			; $6111
	jr nz,_label_03_141	; $6112
	ld a,$78		; $6114
	ld ($cbb3),a		; $6116
	jp incCbc2		; $6119
_label_03_141:
	call decCbb3		; $611c
	ret nz			; $611f
	ld (hl),$04		; $6120
	ld hl,$c486		; $6122
	dec (hl)		; $6125
	ld a,(hl)		; $6126
	ldh (<hCameraY),a	; $6127
	ret			; $6129
	call decCbb3		; $612a
	ret nz			; $612d
	ld a,$ff		; $612e
	ld ($cbba),a		; $6130
	jp incCbc2		; $6133
	ld hl,$cbb3		; $6136
	ld b,$01		; $6139
	call func_2d73		; $613b
	ret z			; $613e
	call disableLcd		; $613f
	ld a,$9a		; $6142
	call loadGfxHeader		; $6144
	ld a,$9f		; $6147
	call loadPaletteHeader		; $6149
	call clearDynamicInteractions		; $614c
	ld b,$03		; $614f
_label_03_142:
	call getFreeInteractionSlot		; $6151
	jr nz,_label_03_143	; $6154
	ld (hl),$cf		; $6156
	inc l			; $6158
	dec b			; $6159
	ld (hl),b		; $615a
	jr nz,_label_03_142	; $615b
_label_03_143:
	ld a,$04		; $615d
	call loadGfxRegisterStateIndex		; $615f
	ld a,$04		; $6162
	call fadeinFromWhiteWithDelay		; $6164
	call incCbc2		; $6167
	ld a,$f0		; $616a
	ld ($cbb3),a		; $616c
	xor a			; $616f
	ldh (<hOamTail),a	; $6170
	ld a,($c486)		; $6172
	cp $60			; $6175
	jr nc,_label_03_144	; $6177
	cpl			; $6179
	inc a			; $617a
	ld b,a			; $617b
	ld a,(wFrameCounter)		; $617c
	and $01			; $617f
	jr nz,_label_03_144	; $6181
	ld c,a			; $6183
	ld hl,$6641		; $6184
	call addSpritesToOam_withOffset		; $6187
_label_03_144:
	ld a,($c486)		; $618a
	cpl			; $618d
	inc a			; $618e
	ld b,$c7		; $618f
	add b			; $6191
	ld b,a			; $6192
	ld c,$38		; $6193
	ld hl,$668a		; $6195
	push bc			; $6198
	call addSpritesToOam_withOffset		; $6199
	pop bc			; $619c
	ld a,($c486)		; $619d
	cp $60			; $61a0
	ret c			; $61a2
	ld hl,$66bf		; $61a3
	jp addSpritesToOam_withOffset		; $61a6
	call $616f		; $61a9
	call $6462		; $61ac
	ret nz			; $61af
	ld a,$04		; $61b0
	ld ($cbb3),a		; $61b2
	jp incCbc2		; $61b5
	ld a,($c486)		; $61b8
	cp $98			; $61bb
	jr nz,_label_03_145	; $61bd
	ld a,$f0		; $61bf
	ld ($cbb3),a		; $61c1
	call incCbc2		; $61c4
	jr _label_03_146		; $61c7
_label_03_145:
	call decCbb3		; $61c9
	jr nz,_label_03_146	; $61cc
	ld (hl),$04		; $61ce
	ld hl,$c486		; $61d0
	inc (hl)		; $61d3
	ld a,(hl)		; $61d4
	ldh (<hCameraY),a	; $61d5
	cp $60			; $61d7
	jr nz,_label_03_146	; $61d9
	call clearDynamicInteractions		; $61db
	ld a,$2c		; $61de
	call loadUncompressedGfxHeader		; $61e0
_label_03_146:
	jp $616f		; $61e3
	call $616f		; $61e6
	call decCbb3		; $61e9
	ret nz			; $61ec
	call $646a		; $61ed
	ld a,$03		; $61f0
	ld ($cbc1),a		; $61f2
	ld a,$04		; $61f5
	jp fadeoutToWhiteWithDelay		; $61f7
	ld de,$cbc2		; $61fa
	ld a,(de)		; $61fd
	rst_jumpTable			; $61fe
	rla			; $61ff
	ld h,d			; $6200
	ld (hl),b		; $6201
	ld h,d			; $6202
	sbc h			; $6203
	ld h,d			; $6204
	and (hl)		; $6205
	ld h,d			; $6206
	cp l			; $6207
	ld h,d			; $6208
	rla			; $6209
	ld h,e			; $620a
	ld l,$63		; $620b
	ld c,b			; $620d
	ld h,e			; $620e
	ld l,b			; $620f
	ld h,e			; $6210
	sub c			; $6211
	ld h,e			; $6212
	xor a			; $6213
	ld h,e			; $6214
	rst_jumpTable			; $6215
	ld h,e			; $6216
	call checkIsLinkedGame		; $6217
	call nz,$616f		; $621a
	ld a,($c4ab)		; $621d
	or a			; $6220
	ret nz			; $6221
	call disableLcd		; $6222
	call incCbc2		; $6225
	call $66ed		; $6228
	call clearDynamicInteractions		; $622b
	call clearOam		; $622e
	call checkIsLinkedGame		; $6231
	jp z,$6249		; $6234
	ld a,$99		; $6237
	call loadGfxHeader		; $6239
	ld a,$aa		; $623c
	call loadPaletteHeader		; $623e
	ld hl,$5887		; $6241
	call parseGivenObjectData		; $6244
	jr _label_03_147		; $6247
	ld a,$98		; $6249
	call loadGfxHeader		; $624b
	ld a,$a9		; $624e
	call loadPaletteHeader		; $6250
_label_03_147:
	ld a,$04		; $6253
	call loadGfxRegisterStateIndex		; $6255
	xor a			; $6258
	ld hl,$ffa8		; $6259
	ldi (hl),a		; $625c
	ldi (hl),a		; $625d
	ldi (hl),a		; $625e
	ld (hl),a		; $625f
	ld hl,$cbb3		; $6260
	ld (hl),$f0		; $6263
	ld (hl),a		; $6265
	ld a,$fb		; $6266
	call playSound		; $6268
	ld a,$04		; $626b
	jp fadeinFromWhiteWithDelay		; $626d
	ld a,($c4ab)		; $6270
	or a			; $6273
	ret nz			; $6274
	call incCbc2		; $6275
	call checkIsLinkedGame		; $6278
	ret z			; $627b
	ld hl,$cbb4		; $627c
	ld a,(hl)		; $627f
	or a			; $6280
	jr z,_label_03_148	; $6281
	dec (hl)		; $6283
	ret			; $6284
_label_03_148:
	ld a,$aa		; $6285
	call playSound		; $6287
	call getRandomNumber_noPreserveVars		; $628a
	and $03			; $628d
	ld hl,$6298		; $628f
	rst_addAToHl			; $6292
	ld a,(hl)		; $6293
	ld ($cbb4),a		; $6294
	ret			; $6297
	and b			; $6298
	ret z			; $6299
	stop			; $629a
	ld a,($ff00+$cd)	; $629b
	ld a,b			; $629d
	ld h,d			; $629e
	call decCbb3		; $629f
	ret nz			; $62a2
	call incCbc2		; $62a3
	call $6278		; $62a6
	ld hl,$c612		; $62a9
	ldi a,(hl)		; $62ac
	add (hl)		; $62ad
	cp $02			; $62ae
	ret z			; $62b0
	ld a,($c482)		; $62b1
	and $0b			; $62b4
	ret z			; $62b6
	call incCbc2		; $62b7
	jp fadeoutToWhite		; $62ba
	ld a,($c4ab)		; $62bd
	or a			; $62c0
	ret nz			; $62c1
	call incCbc2		; $62c2
	call disableLcd		; $62c5
	call $481b		; $62c8
	ld a,$ff		; $62cb
	ld ($cbba),a		; $62cd
	ld a,($ff00+$70)	; $62d0
	push af			; $62d2
	ld a,$07		; $62d3
	ld ($ff00+$70),a	; $62d5
	ld hl,$d460		; $62d7
	ld de,$d800		; $62da
	ld bc,$1800		; $62dd
_label_03_149:
	ldi a,(hl)		; $62e0
	call copyTextCharacterGfx		; $62e1
	dec b			; $62e4
	jr nz,_label_03_149	; $62e5
	pop af			; $62e7
	ld ($ff00+$70),a	; $62e8
	ld a,$97		; $62ea
	call loadGfxHeader		; $62ec
	ld a,$2b		; $62ef
	call loadUncompressedGfxHeader		; $62f1
	ld a,$05		; $62f4
	call loadPaletteHeader		; $62f6
	call checkIsLinkedGame		; $62f9
	ld a,$84		; $62fc
	call nz,loadGfxHeader		; $62fe
	call clearDynamicInteractions		; $6301
	call clearOam		; $6304
	ld a,$04		; $6307
	call loadGfxRegisterStateIndex		; $6309
	ld hl,$cbb3		; $630c
	ld (hl),$3c		; $630f
	call fileSelect_redrawDecorations		; $6311
	jp fadeinFromWhite		; $6314
	call fileSelect_redrawDecorations		; $6317
	call $6462		; $631a
	ret nz			; $631d
	ld hl,$cbb3		; $631e
	ld b,$3c		; $6321
	call checkIsLinkedGame		; $6323
	jr z,_label_03_150	; $6326
	ld b,$b4		; $6328
_label_03_150:
	ld (hl),b		; $632a
	jp incCbc2		; $632b
	call fileSelect_redrawDecorations		; $632e
	call decCbb3		; $6331
	ret nz			; $6334
	call checkIsLinkedGame		; $6335
	jr nz,_label_03_151	; $6338
	call getFreeInteractionSlot		; $633a
	jr nz,_label_03_151	; $633d
	ld (hl),$d1		; $633f
	xor a			; $6341
	ld ($cfde),a		; $6342
_label_03_151:
	jp incCbc2		; $6345
	call fileSelect_redrawDecorations		; $6348
	call checkIsLinkedGame		; $634b
	jr z,_label_03_152	; $634e
	ld a,($c482)		; $6350
	and $01			; $6353
	jr nz,_label_03_153	; $6355
	ret			; $6357
_label_03_152:
	ld a,($cfde)		; $6358
	or a			; $635b
	ret z			; $635c
_label_03_153:
	call incCbc2		; $635d
	ld a,$fa		; $6360
	call playSound		; $6362
	jp fadeoutToWhite		; $6365
	call fileSelect_redrawDecorations		; $6368
	ld a,($c4ab)		; $636b
	or a			; $636e
	ret nz			; $636f
	call checkIsLinkedGame		; $6370
	jp nz,resetGame		; $6373
	call disableLcd		; $6376
	call clearOam		; $6379
	call incCbc2		; $637c
	ld a,$82		; $637f
	call loadGfxHeader		; $6381
	ld a,$8f		; $6384
	call loadPaletteHeader		; $6386
	call fadeinFromWhite		; $6389
	ld a,$04		; $638c
	jp loadGfxRegisterStateIndex		; $638e
	call $63a1		; $6391
	ld a,($c4ab)		; $6394
	or a			; $6397
	ret nz			; $6398
	ld hl,$cbb3		; $6399
	ld (hl),$b4		; $639c
	jp incCbc2		; $639e
	ld hl,$4e0c		; $63a1
	ld e,$15		; $63a4
	ld bc,$3038		; $63a6
	xor a			; $63a9
	ldh (<hOamTail),a	; $63aa
	jp addSpritesFromBankToOam_withOffset		; $63ac
	call $63a1		; $63af
	ld hl,$cbb3		; $63b2
	ld a,(hl)		; $63b5
	or a			; $63b6
	jr z,_label_03_154	; $63b7
	dec (hl)		; $63b9
	ret			; $63ba
_label_03_154:
	ld a,($c482)		; $63bb
	and $01			; $63be
	ret z			; $63c0
	call incCbc2		; $63c1
	jp fadeoutToWhite		; $63c4
	call $63a1		; $63c7
	ld a,($c4ab)		; $63ca
	or a			; $63cd
	ret nz			; $63ce
	jp resetGame		; $63cf
	ld ($cc4e),a		; $63d2
	ld a,b			; $63d5
	ld ($cc49),a		; $63d6
	ld a,c			; $63d9
	ld ($cc4c),a		; $63da
	call disableLcd		; $63dd
	call clearScreenVariablesAndWramBank1		; $63e0
	ld hl,$cc77		; $63e3
	ld b,$88		; $63e6
	call clearMemory		; $63e8
	call initializeVramMaps		; $63eb
	call loadScreenMusicAndSetRoomPack		; $63ee
	call loadAreaData		; $63f1
	call loadAreaGraphics		; $63f4
	call func_131f		; $63f7
	ld a,$01		; $63fa
	ld ($cd00),a		; $63fc
	call loadCommonGraphics		; $63ff
	jp clearOam		; $6402
	ld a,b			; $6405
	cp $ff			; $6406
	ret z			; $6408
	push bc			; $6409
	call refreshObjectGfx		; $640a
	pop bc			; $640d
	call getEntryFromObjectTable1		; $640e
	ld d,h			; $6411
	ld e,l			; $6412
	call parseGivenObjectData		; $6413
	xor a			; $6416
	ld ($cfc0),a		; $6417
	ld a,($cbb4)		; $641a
	cp $05			; $641d
	jr z,_label_03_155	; $641f
	cp $06			; $6421
	jr z,_label_03_158	; $6423
	cp $07			; $6425
	jr z,_label_03_159	; $6427
	ret			; $6429
_label_03_155:
	ld a,$04		; $642a
	ld b,$03		; $642c
_label_03_156:
	call $6434		; $642e
	jp reloadObjectGfx		; $6431
	ld hl,$cc07		; $6434
_label_03_157:
	ldi (hl),a		; $6437
	inc a			; $6438
	ld (hl),$01		; $6439
	inc l			; $643b
	dec b			; $643c
	jr nz,_label_03_157	; $643d
	ret			; $643f
_label_03_158:
	ld a,$0f		; $6440
	ld b,$06		; $6442
	jr _label_03_156		; $6444
_label_03_159:
	ld a,$13		; $6446
	ld b,$02		; $6448
	jr _label_03_156		; $644a
	ld ($cc4e),a		; $644c
	call disableLcd		; $644f
	call $63eb		; $6452
	ld a,$02		; $6455
	jp loadGfxRegisterStateIndex		; $6457
	ld a,($cba0)		; $645a
	or a			; $645d
	ret nz			; $645e
	jp decCbb3		; $645f
	ld a,($c4ab)		; $6462
	or a			; $6465
	ret nz			; $6466
	jp decCbb3		; $6467
	ld hl,$cbb3		; $646a
	ld b,$10		; $646d
	jp clearMemory		; $646f
	ld h,$e0		; $6472
	stop			; $6474
	ld (bc),a		; $6475
	ld bc,$18e0		; $6476
	inc b			; $6479
	ld bc,$20e0		; $647a
	ld b,$01		; $647d
	ld ($ff00+$28),a	; $647f
	ld ($f001),sp		; $6481
	ld ($0114),sp		; $6484
	ld a,($ff00+$10)	; $6487
	ld d,$01		; $6489
	ld a,($ff00+$18)	; $648b
	jr $01			; $648d
	ld a,($ff00+$20)	; $648f
	ld a,(de)		; $6491
	ld bc,$28f0		; $6492
	inc e			; $6495
	ld bc,$0800		; $6496
	jr z,_label_03_160	; $6499
	nop			; $649b
_label_03_160:
	stop			; $649c
	ldi a,(hl)		; $649d
	ld bc,$1800		; $649e
	inc l			; $64a1
	ld bc,$2000		; $64a2
	ld l,$01		; $64a5
	nop			; $64a7
	jr z,$30		; $64a8
	ld bc,$0810		; $64aa
	ldd a,(hl)		; $64ad
	ld bc,$1010		; $64ae
	inc a			; $64b1
	ld bc,$1810		; $64b2
	ld a,$01		; $64b5
	stop			; $64b7
	jr nz,_label_03_162	; $64b8
	ld bc,$2810		; $64ba
	ld b,d			; $64bd
	ld bc,$0820		; $64be
	nop			; $64c1
	ld bc,$1020		; $64c2
	ld a,(bc)		; $64c5
	ld bc,$1820		; $64c6
	inc c			; $64c9
	ld bc,$2020		; $64ca
	ld c,$01		; $64cd
	jr nz,_label_03_161	; $64cf
	stop			; $64d1
	ld bc,$0830		; $64d2
	ld e,$01		; $64d5
	jr nc,$10		; $64d7
	jr nz,$01		; $64d9
	jr nc,$18		; $64db
	ldi (hl),a		; $64dd
	ld bc,$2030		; $64de
	inc h			; $64e1
	ld bc,$2830		; $64e2
	ld h,$01		; $64e5
	ld b,b			; $64e7
	ld ($0132),sp		; $64e8
	ld b,b			; $64eb
	stop			; $64ec
	inc (hl)		; $64ed
	ld bc,$1840		; $64ee
	ld (hl),$01		; $64f1
	ld d,b			; $64f3
	ld ($0144),sp		; $64f4
	ld d,b			; $64f7
	stop			; $64f8
_label_03_161:
	ld b,(hl)		; $64f9
_label_03_162:
	ld bc,$1850		; $64fa
	ld c,b			; $64fd
	ld bc,$2040		; $64fe
	jr c,_label_03_163	; $6501
	ld h,b			; $6503
_label_03_163:
	ld ($0100),sp		; $6504
	ld h,b			; $6507
	stop			; $6508
	ld (de),a		; $6509
	ld bc,$e026		; $650a
	ld hl,sp+$02		; $650d
	ld hl,$f0e0		; $650f
	inc b			; $6512
	ld hl,$e8e0		; $6513
	ld b,$21		; $6516
	ld ($ff00+$e0),a	; $6518
	ld ($f021),sp		; $651a
	nop			; $651d
	inc d			; $651e
	ld hl,$f8f0		; $651f
	ld d,$21		; $6522
	ld a,($ff00+$f0)	; $6524
	jr $21			; $6526
	ld a,($ff00+$e8)	; $6528
	ld a,(de)		; $652a
	ld hl,$e0f0		; $652b
	inc e			; $652e
	ld hl,$0000		; $652f
	jr z,$21		; $6532
	nop			; $6534
	ld hl,sp+$2a		; $6535
	ld hl,$f000		; $6537
	inc l			; $653a
	ld hl,$e800		; $653b
	ld l,$21		; $653e
	nop			; $6540
	ld ($ff00+$30),a	; $6541
	ld hl,$0010		; $6543
	ldd a,(hl)		; $6546
	ld hl,$f810		; $6547
_label_03_164:
	inc a			; $654a
	ld hl,$f010		; $654b
	ld a,$21		; $654e
	stop			; $6550
	add sp,$40		; $6551
	ld hl,$e010		; $6553
	ld b,d			; $6556
	ld hl,$0020		; $6557
	nop			; $655a
	ld hl,$f820		; $655b
	ld a,(bc)		; $655e
	ld hl,$f020		; $655f
	inc c			; $6562
	ld hl,$e820		; $6563
_label_03_165:
	ld c,$21		; $6566
	jr nz,_label_03_164	; $6568
_label_03_166:
	stop			; $656a
	ld hl,$0030		; $656b
	ld e,$21		; $656e
	jr nc,_label_03_166	; $6570
	jr nz,$21		; $6572
	jr nc,_label_03_165	; $6574
	ldi (hl),a		; $6576
	ld hl,$e830		; $6577
	inc h			; $657a
	ld hl,$e030		; $657b
	ld h,$21		; $657e
	ld b,b			; $6580
	nop			; $6581
	ldd (hl),a		; $6582
	ld hl,$f840		; $6583
	inc (hl)		; $6586
	ld hl,$f040		; $6587
	ld (hl),$21		; $658a
	ld d,b			; $658c
	nop			; $658d
	ld b,h			; $658e
	ld hl,$f850		; $658f
	ld b,(hl)		; $6592
	ld hl,$f050		; $6593
	ld c,b			; $6596
	ld hl,$e840		; $6597
	jr c,$21		; $659a
	ld h,b			; $659c
	nop			; $659d
	nop			; $659e
	ld hl,$f860		; $659f
	ld (de),a		; $65a2
	ld hl,$e027		; $65a3
	add sp,$00		; $65a6
	ld bc,$f0e0		; $65a8
	ld (bc),a		; $65ab
	ld bc,$f8e0		; $65ac
	inc b			; $65af
	ld bc,$e0f0		; $65b0
	stop			; $65b3
	ld bc,$e8f0		; $65b4
	ld (de),a		; $65b7
	ld bc,$f0f0		; $65b8
	inc d			; $65bb
	ld bc,$e000		; $65bc
	ld l,$01		; $65bf
	nop			; $65c1
	add sp,$30		; $65c2
	ld bc,$e820		; $65c4
	ldd (hl),a		; $65c7
	ld bc,$f020		; $65c8
	inc (hl)		; $65cb
	ld bc,$f820		; $65cc
	ld (hl),$01		; $65cf
	nop			; $65d1
	jr _label_03_167		; $65d2
	ld (bc),a		; $65d4
	nop			; $65d5
	jr nz,_label_03_168	; $65d6
	ld (bc),a		; $65d8
	stop			; $65d9
	jr $3c			; $65da
	ld (bc),a		; $65dc
	stop			; $65dd
	jr nz,_label_03_170	; $65de
	ld (bc),a		; $65e0
	ld h,b			; $65e1
	ld a,($0140)		; $65e2
	ld h,b			; $65e5
	ld (bc),a		; $65e6
	ld b,d			; $65e7
	ld bc,$1960		; $65e8
	ld b,h			; $65eb
	ld bc,$2160		; $65ec
	ld b,(hl)		; $65ef
	inc bc			; $65f0
	ld d,b			; $65f1
	jr _label_03_175		; $65f2
	ld bc,$2050		; $65f4
	ld c,d			; $65f7
	inc bc			; $65f8
	ld b,b			; $65f9
	jr _label_03_177		; $65fa
	inc bc			; $65fc
	ld c,b			; $65fd
	stop			; $65fe
	inc l			; $65ff
	ld bc,$2960		; $6600
	ld d,$04		; $6603
	ld b,b			; $6605
	jr nz,_label_03_171	; $6606
	inc b			; $6608
	ld b,b			; $6609
	jr z,_label_03_172	; $660a
_label_03_167:
	inc b			; $660c
	ld d,b			; $660d
	jr z,_label_03_173	; $660e
	inc b			; $6610
	ld d,b			; $6611
_label_03_168:
	ld e,b			; $6612
	ld e,$04		; $6613
	ld d,b			; $6615
	ld h,b			; $6616
	jr nz,_label_03_169	; $6617
	ld d,b			; $6619
	ld l,b			; $661a
	ldi (hl),a		; $661b
	inc b			; $661c
_label_03_169:
	ld b,b			; $661d
_label_03_170:
	ld h,b			; $661e
	inc h			; $661f
_label_03_171:
	inc b			; $6620
	ld h,b			; $6621
	ld e,b			; $6622
	ld h,$04		; $6623
	ld h,b			; $6625
_label_03_172:
	ld h,b			; $6626
	jr z,_label_03_174	; $6627
	ld h,b			; $6629
	ld l,b			; $662a
	ldi a,(hl)		; $662b
_label_03_173:
	inc b			; $662c
_label_03_174:
	jr $38			; $662d
	ld b,$05		; $662f
	jr _label_03_181		; $6631
	ld ($0805),sp		; $6633
	jr nc,_label_03_176	; $6636
	ld b,$00		; $6638
	jr c,_label_03_177	; $663a
_label_03_175:
	ld b,$00		; $663c
	ld b,b			; $663e
	ld c,$06		; $663f
	ld (de),a		; $6641
_label_03_176:
	stop			; $6642
	ld ($0c00),sp		; $6643
	stop			; $6646
	stop			; $6647
_label_03_177:
	ld (bc),a		; $6648
	inc c			; $6649
	stop			; $664a
	jr _label_03_178		; $664b
	inc c			; $664d
	jr nz,_label_03_179	; $664e
	inc c			; $6650
_label_03_178:
	inc c			; $6651
	jr nz,$10		; $6652
	ld c,$0c		; $6654
	jr nz,_label_03_180	; $6656
_label_03_179:
	stop			; $6658
	inc c			; $6659
	ld sp,$0623		; $665a
	dec c			; $665d
	ld sp,$082b		; $665e
	dec c			; $6661
	ld sp,$063b		; $6662
	dec l			; $6665
	ld sp,$0833		; $6666
	dec l			; $6669
	ld b,c			; $666a
	inc hl			; $666b
	ld b,$4d		; $666c
	ld b,c			; $666e
	dec hl			; $666f
_label_03_180:
	ld ($414d),sp		; $6670
	dec sp			; $6673
	ld b,$6d		; $6674
	ld b,c			; $6676
	inc sp			; $6677
	ld ($2c6d),sp		; $6678
_label_03_181:
	dec e			; $667b
	ld a,(bc)		; $667c
	dec c			; $667d
	inc l			; $667e
	dec h			; $667f
	ld a,(bc)		; $6680
	dec l			; $6681
	ld c,h			; $6682
	ldd a,(hl)		; $6683
	ld a,(bc)		; $6684
	dec c			; $6685
	ld c,h			; $6686
	ld b,d			; $6687
	ld a,(bc)		; $6688
	dec l			; $6689
	dec c			; $668a
	jr c,-$2d		; $668b
	ld (bc),a		; $668d
	inc bc			; $668e
	ldd (hl),a		; $668f
	ld hl,sp+$0c		; $6690
	ld bc,$d8f8		; $6692
	stop			; $6695
	rlca			; $6696
	ld hl,sp-$20		; $6697
	ld (de),a		; $6699
	rlca			; $669a
	ld hl,sp-$18		; $669b
	inc d			; $669d
	rlca			; $669e
	rst $30			; $669f
	rst $30			; $66a0
	ld d,$07		; $66a1
	ldi (hl),a		; $66a3
	ld hl,sp+$1a		; $66a4
	inc bc			; $66a6
	ld a,(de)		; $66a7
	nop			; $66a8
	inc e			; $66a9
	inc bc			; $66aa
	ld de,$1ee2		; $66ab
	nop			; $66ae
	ld de,$20ea		; $66af
	nop			; $66b2
	ld bc,$22ea		; $66b3
	nop			; $66b6
	ld de,$26f2		; $66b7
	nop			; $66ba
	ld bc,$24f2		; $66bb
	nop			; $66be
	rlca			; $66bf
	ld h,b			; $66c0
	ld hl,sp+$00		; $66c1
	ld (bc),a		; $66c3
	ld c,b			; $66c4
.DB $d3				; $66c5
	inc b			; $66c6
	inc bc			; $66c7
	ld b,b			; $66c8
	ld ($ff00+$06),a	; $66c9
	rlca			; $66cb
	ld b,b			; $66cc
	add sp,$08		; $66cd
	rlca			; $66cf
	ld b,b			; $66d0
	ld a,($ff00+$0a)	; $66d1
	rlca			; $66d3
	ld b,d			; $66d4
	ld hl,sp+$0e		; $66d5
	ld bc,$e068		; $66d7
	jr $02			; $66da
	ld hl,$c6a2		; $66dc
	ld (hl),$04		; $66df
	ld l,$80		; $66e1
	ldi a,(hl)		; $66e3
	ld b,(hl)		; $66e4
	ld hl,$cc3b		; $66e5
	ldi (hl),a		; $66e8
	ld (hl),b		; $66e9
	jp disableActiveRing		; $66ea
	ld hl,$c6a3		; $66ed
	ldd a,(hl)		; $66f0
	ld (hl),a		; $66f1
	ld hl,$cc3b		; $66f2
	ldi a,(hl)		; $66f5
	ld b,(hl)		; $66f6
	ld hl,$c680		; $66f7
	ldi (hl),a		; $66fa
	ld (hl),b		; $66fb
	jp enableActiveRing		; $66fc
	ld a,($cc03)		; $66ff
	rst_jumpTable			; $6702
	rrca			; $6703
	ld h,a			; $6704
	ldd (hl),a		; $6705
	ld h,a			; $6706
	add d			; $6707
	ld l,b			; $6708
	call nc,$e368		; $6709
	ld l,c			; $670c
	ld ($066a),sp		; $670d
	stop			; $6710
	ld hl,$cbb3		; $6711
	call clearMemory		; $6714
	call clearWramBank1		; $6717
	xor a			; $671a
	ld ($cca4),a		; $671b
	ld ($cd00),a		; $671e
	ld a,($c48c)		; $6721
	ld ($cbba),a		; $6724
	ld a,$80		; $6727
	ld ($cc02),a		; $6729
	ld a,$01		; $672c
	ld ($cc03),a		; $672e
	ret			; $6731
	call $6b6c		; $6732
	ld a,(wFrameCounter)		; $6735
	and $07			; $6738
	ret nz			; $673a
	ld a,($cbb3)		; $673b
	rst_jumpTable			; $673e
	ld c,e			; $673f
	ld h,a			; $6740
	adc l			; $6741
	ld h,a			; $6742
	sbc (hl)		; $6743
	ld h,a			; $6744
	xor a			; $6745
	ld h,a			; $6746
	jp nz,$d267		; $6747
	ld h,a			; $674a
	call $6815		; $674b
	ld a,$08		; $674e
	ld ($cbb8),a		; $6750
	ld a,$04		; $6753
	ld ($cbb4),a		; $6755
	ld a,$51		; $6758
	call loadGfxHeader		; $675a
	ld a,$54		; $675d
	call loadGfxHeader		; $675f
	ld a,$04		; $6762
	ldh (<hNextLcdInterruptBehaviour),a	; $6764
	call $681a		; $6766
	jp $67f8		; $6769
	ld hl,$677e		; $676c
	ld d,$0f		; $676f
_label_03_182:
	ldi a,(hl)		; $6771
	ld c,a			; $6772
	ld a,$0f		; $6773
	push hl			; $6775
	call setTile		; $6776
	pop hl			; $6779
	dec d			; $677a
	jr nz,_label_03_182	; $677b
	ret			; $677d
	inc b			; $677e
	dec b			; $677f
	ld b,$07		; $6780
	ld ($1514),sp		; $6782
	ld d,$17		; $6785
	jr $24			; $6787
	dec h			; $6789
	ld h,$27		; $678a
	jr z,_label_03_183	; $678c
	or h			; $678e
	swap l			; $678f
	ret nz			; $6791
	ld bc,$4e00		; $6792
	call showText		; $6795
	call $676c		; $6798
	jp $6815		; $679b
	call retIfTextIsActive		; $679e
	ld hl,$7dd9		; $67a1
	call parseGivenObjectData		; $67a4
	ld a,$20		; $67a7
	call playSound		; $67a9
	jp $6815		; $67ac
_label_03_183:
	call $6b77		; $67af
	ld a,(hl)		; $67b2
	cp $10			; $67b3
	jr c,_label_03_184	; $67b5
	call $681a		; $67b7
	jr nz,_label_03_184	; $67ba
	call $6815		; $67bc
_label_03_184:
	jp $67f8		; $67bf
	call $6b77		; $67c2
	ld a,(hl)		; $67c5
	cp $30			; $67c6
	jr c,_label_03_185	; $67c8
	call fadeoutToWhite		; $67ca
	call $6815		; $67cd
	jr _label_03_185		; $67d0
	call $6b77		; $67d2
	ld a,($c4ab)		; $67d5
	or a			; $67d8
	jr nz,_label_03_185	; $67d9
	ld a,$c7		; $67db
	ld ($c488),a		; $67dd
	ld ($c48e),a		; $67e0
	ld a,$03		; $67e3
	ldh (<hNextLcdInterruptBehaviour),a	; $67e5
	ld a,$02		; $67e7
	ld ($cc03),a		; $67e9
	xor a			; $67ec
	ld ($cfc0),a		; $67ed
	ld b,$10		; $67f0
	ld hl,$cbb3		; $67f2
	jp clearMemory		; $67f5
_label_03_185:
	ld a,$40		; $67f8
	ld ($c490),a		; $67fa
	ld a,$47		; $67fd
	ld ($c48f),a		; $67ff
	ld a,$a5		; $6802
	ld ($c489),a		; $6804
	ld a,($cbb8)		; $6807
	ld ($c48e),a		; $680a
	ld ($c488),a		; $680d
	ld ($cbbc),a		; $6810
	jr _label_03_187		; $6813
	ld hl,$cbb3		; $6815
	inc (hl)		; $6818
	ret			; $6819
	ld a,($cbb7)		; $681a
	ld hl,$6844		; $681d
	rst_addAToHl			; $6820
	ld a,(hl)		; $6821
	cp $ff			; $6822
	ret z			; $6824
	ld l,a			; $6825
	ld h,$d0		; $6826
	push hl			; $6828
	ld de,$9c00		; $6829
	ld bc,$0f02		; $682c
	call queueDmaTransfer		; $682f
	pop hl			; $6832
	set 2,h			; $6833
	ld e,$01		; $6835
	call queueDmaTransfer		; $6837
	ld a,$08		; $683a
	ld ($cbb8),a		; $683c
	ld hl,$cbb7		; $683f
	inc (hl)		; $6842
	ret			; $6843
	ret nz			; $6844
	and b			; $6845
	add b			; $6846
	ld h,b			; $6847
	ld b,b			; $6848
	jr nz,_label_03_186	; $6849
_label_03_186:
	rst $38			; $684b
_label_03_187:
	ld a,$02		; $684c
	ld ($ff00+$70),a	; $684e
	ld a,($cbb8)		; $6850
	and $07			; $6853
	ld hl,$d800		; $6855
	rst_addDoubleIndex			; $6858
	ld de,$d9e0		; $6859
	ld b,$10		; $685c
	call copyMemory		; $685e
	ld a,($cbb8)		; $6861
	and $07			; $6864
	ld hl,$d820		; $6866
	rst_addDoubleIndex			; $6869
	ld de,$d9f0		; $686a
	ld b,$10		; $686d
	call copyMemory		; $686f
	ld a,$00		; $6872
	ld ($ff00+$70),a	; $6874
	ld hl,$d9e0		; $6876
	ld de,$94e1		; $6879
	ld bc,$0102		; $687c
	jp queueDmaTransfer		; $687f
	ld a,($cbb3)		; $6882
	rst_jumpTable			; $6885
	cp l			; $6886
	ld l,b			; $6887
	bit 5,b			; $6888
	call z,$cd68		; $688a
	pop bc			; $688d
	ld (bc),a		; $688e
	call clearScreenVariablesAndWramBank1		; $688f
	call $6815		; $6892
	ld bc,$05d4		; $6895
	call $691f		; $6898
	ld hl,$d000		; $689b
	ld (hl),$03		; $689e
	ld l,$0b		; $68a0
	ld (hl),$58		; $68a2
	ld l,$0d		; $68a4
	ld (hl),$70		; $68a6
	ld l,$08		; $68a8
	ld (hl),$02		; $68aa
	xor a			; $68ac
	ld ($cc6a),a		; $68ad
	ld a,$01		; $68b0
	ld ($ccae),a		; $68b2
	call resetCamera		; $68b5
	ld a,$02		; $68b8
	jp $6933		; $68ba
	ld a,($c4ab)		; $68bd
	or a			; $68c0
	ret nz			; $68c1
	call $688c		; $68c2
	ld hl,$7e14		; $68c5
	jp parseGivenObjectData		; $68c8
	ret			; $68cb
	ld a,$03		; $68cc
	call $67e9		; $68ce
	jp fadeoutToWhite		; $68d1
	ld a,($cbb3)		; $68d4
	rst_jumpTable			; $68d7
	ld ($ff00+c),a		; $68d8
	ld l,b			; $68d9
	ld (hl),h		; $68da
	ld l,c			; $68db
	add a			; $68dc
	ld l,c			; $68dd
	sub d			; $68de
	ld l,c			; $68df
	xor l			; $68e0
	ld l,c			; $68e1
	ld a,($c4ab)		; $68e2
	or a			; $68e5
	ret nz			; $68e6
	call disableLcd		; $68e7
	call clearScreenVariablesAndWramBank1		; $68ea
	call $6815		; $68ed
	ld a,$40		; $68f0
	ld ($cbb8),a		; $68f2
	ld ($cbbf),a		; $68f5
	ld a,$1e		; $68f8
	ld ($cbb4),a		; $68fa
	ld a,$01		; $68fd
	ld ($cc4e),a		; $68ff
	ld bc,$00fe		; $6902
	call $691f		; $6905
	call $6943		; $6908
	ld e,$0c		; $690b
	call loadObjectGfxHeaderToSlot4		; $690d
	ld a,$52		; $6910
	call loadGfxHeader		; $6912
	ld hl,$7df0		; $6915
	call parseGivenObjectData		; $6918
	ld a,$11		; $691b
	jr _label_03_189		; $691d
_label_03_188:
	ld a,b			; $691f
	ld ($cc49),a		; $6920
	ld a,c			; $6923
	ld ($cc4c),a		; $6924
	call loadScreenMusicAndSetRoomPack		; $6927
	call loadAreaData		; $692a
	call loadAreaGraphics		; $692d
	jp func_131f		; $6930
_label_03_189:
	push af			; $6933
	ld a,$01		; $6934
	ld ($cd00),a		; $6936
	call fadeinFromWhite		; $6939
	call loadCommonGraphics		; $693c
	pop af			; $693f
	jp loadGfxRegisterStateIndex		; $6940
	ld hl,$6953		; $6943
_label_03_190:
	ldi a,(hl)		; $6946
	cp $ff			; $6947
	ret z			; $6949
	ld c,a			; $694a
	ldi a,(hl)		; $694b
	push hl			; $694c
	call setTile		; $694d
	pop hl			; $6950
	jr _label_03_190		; $6951
	dec b			; $6953
	xor l			; $6954
	ld b,$ad		; $6955
	ld ($09ae),sp		; $6957
	xor (hl)		; $695a
	dec d			; $695b
	xor l			; $695c
	ld d,$ad		; $695d
	jr -$52			; $695f
	add hl,de		; $6961
	xor (hl)		; $6962
	dec h			; $6963
	xor l			; $6964
	ld h,$ad		; $6965
	jr z,-$52		; $6967
	add hl,hl		; $6969
	xor (hl)		; $696a
	dec (hl)		; $696b
	xor l			; $696c
	ld (hl),$ad		; $696d
	jr c,_label_03_188	; $696f
	add hl,sp		; $6971
	xor (hl)		; $6972
	rst $38			; $6973
	ld hl,$cbb4		; $6974
	dec (hl)		; $6977
	ret nz			; $6978
	call $6815		; $6979
	xor a			; $697c
	ldh (<hCameraY),a	; $697d
	ldh (<hCameraX),a	; $697f
	ld bc,$4e09		; $6981
	jp showText		; $6984
	call retIfTextIsActive		; $6987
	ld a,$ff		; $698a
	ld ($cfc0),a		; $698c
	jp $6815		; $698f
	ld a,(wFrameCounter)		; $6992
	and $07			; $6995
	ret nz			; $6997
	call $6b77		; $6998
	ld a,(hl)		; $699b
	cp $70			; $699c
	jr c,_label_03_191	; $699e
	call fadeoutToWhite		; $69a0
	ld a,$fb		; $69a3
	call playSound		; $69a5
	call $6815		; $69a8
	jr _label_03_191		; $69ab
	ld a,(wFrameCounter)		; $69ad
	and $07			; $69b0
	ret nz			; $69b2
	call $6b77		; $69b3
	ld a,($c4ab)		; $69b6
	or a			; $69b9
	jr nz,_label_03_191	; $69ba
	ld a,$c7		; $69bc
	ld ($c488),a		; $69be
	ld ($c48e),a		; $69c1
	ld a,$04		; $69c4
	ld ($cc03),a		; $69c6
	ld b,$10		; $69c9
	ld hl,$cbb3		; $69cb
	jp clearMemory		; $69ce
_label_03_191:
	ld a,$a5		; $69d1
	ld ($c489),a		; $69d3
	ld a,($cbb8)		; $69d6
	ld ($c48e),a		; $69d9
	ld ($c488),a		; $69dc
	ld ($cbbc),a		; $69df
	ret			; $69e2
	ld a,($cbb3)		; $69e3
	rst_jumpTable			; $69e6
.DB $ed				; $69e7
	ld l,c			; $69e8
	rst $38			; $69e9
	ld l,c			; $69ea
	nop			; $69eb
	ld l,d			; $69ec
	ld a,($c4ab)		; $69ed
	or a			; $69f0
	ret nz			; $69f1
	call $688c		; $69f2
	xor a			; $69f5
	ld ($cfc0),a		; $69f6
	ld hl,$7e2e		; $69f9
	jp parseGivenObjectData		; $69fc
	ret			; $69ff
	ld a,$05		; $6a00
	call $67e9		; $6a02
	jp fadeoutToWhite		; $6a05
	call $6b6c		; $6a08
	ld a,($cbb3)		; $6a0b
	rst_jumpTable			; $6a0e
	dec d			; $6a0f
	ld l,d			; $6a10
	ld e,d			; $6a11
	ld l,d			; $6a12
	ld (hl),l		; $6a13
	ld l,d			; $6a14
	ld a,($c4ab)		; $6a15
	or a			; $6a18
	ret nz			; $6a19
	call disableLcd		; $6a1a
	call clearScreenVariablesAndWramBank1		; $6a1d
	call $6815		; $6a20
	ld a,$90		; $6a23
	ld ($cbb8),a		; $6a25
	ld ($cbbf),a		; $6a28
	ld a,$10		; $6a2b
	ld ($cbbd),a		; $6a2d
	ld a,$03		; $6a30
	ld ($cc4e),a		; $6a32
	ld bc,$00f2		; $6a35
	call $691f		; $6a38
	ld a,$ff		; $6a3b
	ld ($cd25),a		; $6a3d
	ld e,$00		; $6a40
	call loadObjectGfxHeaderToSlot4		; $6a42
	ld a,$53		; $6a45
	call loadGfxHeader		; $6a47
	ld a,$54		; $6a4a
	call loadGfxHeader		; $6a4c
	ld hl,$7dfa		; $6a4f
	call parseGivenObjectData		; $6a52
	ld a,$12		; $6a55
	jp $6933		; $6a57
	ld a,(wFrameCounter)		; $6a5a
	and $03			; $6a5d
	jr nz,_label_03_192	; $6a5f
	call $6b80		; $6a61
	ld a,(hl)		; $6a64
	cp $09			; $6a65
	jp nc,$6a70		; $6a67
	call $6b30		; $6a6a
	call $6815		; $6a6d
_label_03_192:
	call $69d1		; $6a70
	jr _label_03_194		; $6a73
	ld a,(wFrameCounter)		; $6a75
	and $07			; $6a78
	jr nz,_label_03_192	; $6a7a
	call $6b80		; $6a7c
	ld a,(hl)		; $6a7f
	cp $09			; $6a80
	jr nc,_label_03_192	; $6a82
	call $6b30		; $6a84
	jr nz,_label_03_192	; $6a87
	ld a,$17		; $6a89
	call setGlobalFlag		; $6a8b
	xor a			; $6a8e
	ld (wActiveMusic),a		; $6a8f
	ld hl,$6a98		; $6a92
	jp setWarpDestVariables		; $6a95
	add b			; $6a98
	ld ($ff00+c),a		; $6a99
	rrca			; $6a9a
	ld h,(hl)		; $6a9b
	inc bc			; $6a9c
_label_03_193:
	ld a,$02		; $6a9d
	ld ($ff00+$70),a	; $6a9f
	ld a,($cbbe)		; $6aa1
	dec a			; $6aa4
	and $03			; $6aa5
	ld hl,$6b1a		; $6aa7
	rst_addDoubleIndex			; $6aaa
	ldi a,(hl)		; $6aab
	ld h,(hl)		; $6aac
	ld l,a			; $6aad
	ld a,($cbb8)		; $6aae
	and $07			; $6ab1
	rst_addDoubleIndex			; $6ab3
	ld de,$d9e0		; $6ab4
	call $6b22		; $6ab7
	ld a,$00		; $6aba
	ld ($ff00+$70),a	; $6abc
	ld hl,$d9e0		; $6abe
	ld de,$8ce0		; $6ac1
	ld bc,$0102		; $6ac4
	jp queueDmaTransfer		; $6ac7
_label_03_194:
	ld hl,$cbbd		; $6aca
	dec (hl)		; $6acd
	jr nz,_label_03_193	; $6ace
	ld (hl),$10		; $6ad0
	ld a,$02		; $6ad2
	ld ($ff00+$70),a	; $6ad4
	ld a,($cbbe)		; $6ad6
	ld hl,$6b1a		; $6ad9
	rst_addDoubleIndex			; $6adc
	ldi a,(hl)		; $6add
	ld h,(hl)		; $6ade
	ld l,a			; $6adf
	ld de,$d9c0		; $6ae0
	push hl			; $6ae3
	call $6b22		; $6ae4
	pop hl			; $6ae7
	ld a,($cbb8)		; $6ae8
	and $07			; $6aeb
	rst_addDoubleIndex			; $6aed
	ld de,$d9e0		; $6aee
	call $6b22		; $6af1
	ld a,$00		; $6af4
	ld ($ff00+$70),a	; $6af6
	ld hl,$d9c0		; $6af8
	ld de,$88e1		; $6afb
	ld bc,$0102		; $6afe
	call queueDmaTransfer		; $6b01
	ld hl,$d9e0		; $6b04
	ld de,$8ce0		; $6b07
	ld bc,$0102		; $6b0a
	call queueDmaTransfer		; $6b0d
	ld a,($cbbe)		; $6b10
	inc a			; $6b13
	and $03			; $6b14
	ld ($cbbe),a		; $6b16
	ret			; $6b19
	ld b,b			; $6b1a
	ret c			; $6b1b
	add b			; $6b1c
	ret c			; $6b1d
	ret nz			; $6b1e
	ret c			; $6b1f
	nop			; $6b20
	reti			; $6b21
	ld b,$10		; $6b22
	call copyMemory		; $6b24
	ld bc,$0010		; $6b27
	add hl,bc		; $6b2a
_label_03_195:
	ld b,$10		; $6b2b
	jp copyMemory		; $6b2d
	ld a,($cbb7)		; $6b30
	ld hl,$6b59		; $6b33
	rst_addDoubleIndex			; $6b36
	ldi a,(hl)		; $6b37
	cp $ff			; $6b38
	ret z			; $6b3a
	ld h,(hl)		; $6b3b
_label_03_196:
	ld l,a			; $6b3c
	push hl			; $6b3d
	ld de,$9c00		; $6b3e
	ld bc,$2102		; $6b41
	call queueDmaTransfer		; $6b44
	pop hl			; $6b47
	set 2,h			; $6b48
	ld e,$01		; $6b4a
	call queueDmaTransfer		; $6b4c
	ld a,$10		; $6b4f
	ld ($cbb8),a		; $6b51
	ld hl,$cbb7		; $6b54
	inc (hl)		; $6b57
	ret			; $6b58
	jr nz,_label_03_195	; $6b59
	ld b,b			; $6b5b
	ret nc			; $6b5c
	ld h,b			; $6b5d
	ret nc			; $6b5e
	add b			; $6b5f
	ret nc			; $6b60
	and b			; $6b61
	ret nc			; $6b62
	ret nz			; $6b63
	ret nc			; $6b64
	ld ($ff00+$d0),a	; $6b65
	nop			; $6b67
	pop de			; $6b68
	jr nz,_label_03_196	; $6b69
	rst $38			; $6b6b
	ld hl,$6b72		; $6b6c
	jp addSpritesToOam		; $6b6f
	ld bc,$a610		; $6b72
	ld c,h			; $6b75
	add hl,bc		; $6b76
	ld hl,$cbbf		; $6b77
	inc (hl)		; $6b7a
	ld hl,$cbb8		; $6b7b
	inc (hl)		; $6b7e
	ret			; $6b7f
	ld hl,$cbbf		; $6b80
	dec (hl)		; $6b83
	ld hl,$cbb8		; $6b84
	dec (hl)		; $6b87
	ret			; $6b88
	ld a,($cc03)		; $6b89
	rst_jumpTable			; $6b8c
	sbc c			; $6b8d
	ld l,e			; $6b8e
	jp c,$696b		; $6b8f
	ld l,h			; $6b92
	adc c			; $6b93
	ld l,h			; $6b94
	stop			; $6b95
	ld l,l			; $6b96
	ld b,e			; $6b97
	ld l,l			; $6b98
	ld a,($c4ab)		; $6b99
	or a			; $6b9c
	ret nz			; $6b9d
	call disableLcd		; $6b9e
	call clearScreenVariablesAndWramBank1		; $6ba1
	ld a,$03		; $6ba4
	ld ($cc4e),a		; $6ba6
	ld bc,$0103		; $6ba9
	call $6de4		; $6bac
	ld a,$78		; $6baf
	ld ($cbb4),a		; $6bb1
	ld a,$01		; $6bb4
	ld ($cc03),a		; $6bb6
	xor a			; $6bb9
	ld ($cbb3),a		; $6bba
	ld a,$21		; $6bbd
	ld (wActiveMusic),a		; $6bbf
	call playSound		; $6bc2
	ld a,$b0		; $6bc5
	call playSound		; $6bc7
	ld a,$01		; $6bca
	ld ($cd00),a		; $6bcc
	call fadeinFromWhite		; $6bcf
	call loadCommonGraphics		; $6bd2
	ld a,$02		; $6bd5
	jp loadGfxRegisterStateIndex		; $6bd7
	call $6df8		; $6bda
	ld a,($cbb3)		; $6bdd
	rst_jumpTable			; $6be0
	jp hl			; $6be1
	ld l,e			; $6be2
	inc bc			; $6be3
	ld l,h			; $6be4
	add hl,de		; $6be5
	ld l,h			; $6be6
	ld b,c			; $6be7
	ld l,h			; $6be8
	ld a,($c4ab)		; $6be9
	or a			; $6bec
	ret nz			; $6bed
	call $6ddf		; $6bee
	ret nz			; $6bf1
	ld a,$b0		; $6bf2
	call playSound		; $6bf4
	ld hl,$cbb4		; $6bf7
	ld (hl),$96		; $6bfa
	inc hl			; $6bfc
	ld (hl),$01		; $6bfd
	ld hl,$cbb3		; $6bff
	inc (hl)		; $6c02
	ld bc,$1478		; $6c03
	ld hl,$cbb5		; $6c06
	call $6db1		; $6c09
	call $6ddf		; $6c0c
	ret nz			; $6c0f
	ld a,$81		; $6c10
	ld ($cd02),a		; $6c12
	ld hl,$cbb3		; $6c15
	inc (hl)		; $6c18
	ld a,($cd00)		; $6c19
	and $04			; $6c1c
	ret z			; $6c1e
	ld a,$04		; $6c1f
	ld ($cc4c),a		; $6c21
	ld hl,$4964		; $6c24
	ld e,$01		; $6c27
	call interBankCall		; $6c29
	call loadScreenMusicAndSetRoomPack		; $6c2c
	call loadAreaData		; $6c2f
	call loadTilesetAndRoomLayout		; $6c32
	call generateVramTilesWithRoomChanges		; $6c35
	ld a,$08		; $6c38
	ld ($cd00),a		; $6c3a
	ld hl,$cbb3		; $6c3d
	inc (hl)		; $6c40
	ld a,($cd00)		; $6c41
	and $01			; $6c44
	ret z			; $6c46
	ld hl,$49a4		; $6c47
	ld e,$01		; $6c4a
	call interBankCall		; $6c4c
	ld hl,$cbb4		; $6c4f
	ld (hl),$96		; $6c52
	inc hl			; $6c54
	ld (hl),$01		; $6c55
	inc hl			; $6c57
	ld (hl),$01		; $6c58
	ld a,$b0		; $6c5a
	call playSound		; $6c5c
	ld hl,$cc03		; $6c5f
	inc (hl)		; $6c62
	ld hl,$cbb3		; $6c63
	ld (hl),$00		; $6c66
	ret			; $6c68
	call $6df8		; $6c69
	ld bc,$1430		; $6c6c
	ld hl,$cbb5		; $6c6f
	call $6db1		; $6c72
	ld bc,$1488		; $6c75
	ld hl,$cbb6		; $6c78
	call $6db1		; $6c7b
	ld hl,$cbb4		; $6c7e
	dec (hl)		; $6c81
	ret nz			; $6c82
	call $6c5f		; $6c83
	jp fastFadeoutToWhite		; $6c86
	ld a,($cbb3)		; $6c89
	rst_jumpTable			; $6c8c
	sub a			; $6c8d
	ld l,h			; $6c8e
	or a			; $6c8f
	ld l,h			; $6c90
	jp z,$e06c		; $6c91
	ld l,h			; $6c94
	cp $6c			; $6c95
	ld a,($c4ab)		; $6c97
	or a			; $6c9a
	ret nz			; $6c9b
	call setScreenShakeCounter		; $6c9c
	call disableLcd		; $6c9f
	call clearScreenVariablesAndWramBank1		; $6ca2
	ld bc,$0015		; $6ca5
	call $6de4		; $6ca8
	ld a,$1e		; $6cab
	ld ($cbb4),a		; $6cad
	ld hl,$cbb3		; $6cb0
	inc (hl)		; $6cb3
	jp $6d9f		; $6cb4
	call $6ddf		; $6cb7
	ret nz			; $6cba
	call $6df8		; $6cbb
	ld hl,$cbb4		; $6cbe
	ld (hl),$78		; $6cc1
	inc hl			; $6cc3
	ld (hl),$01		; $6cc4
	ld hl,$cbb3		; $6cc6
	inc (hl)		; $6cc9
	ld hl,$cbb5		; $6cca
	call $6dcb		; $6ccd
	call $6ddf		; $6cd0
	ret nz			; $6cd3
	call $6df8		; $6cd4
	ld hl,$cbb3		; $6cd7
	inc (hl)		; $6cda
	ld a,$02		; $6cdb
	call fadeoutToWhiteWithDelay		; $6cdd
	ld a,($c4ab)		; $6ce0
	or a			; $6ce3
	ret nz			; $6ce4
	call $6d8b		; $6ce5
	call getFreeInteractionSlot		; $6ce8
	jr nz,_label_03_197	; $6ceb
	ld (hl),$dc		; $6ced
	inc l			; $6cef
	ld (hl),$0e		; $6cf0
_label_03_197:
	ld hl,$cbb3		; $6cf2
	inc (hl)		; $6cf5
	ld hl,$cbb4		; $6cf6
	ld (hl),$78		; $6cf9
	call $6df8		; $6cfb
	ld hl,$cbb5		; $6cfe
	call $6dcb		; $6d01
	call $6ddf		; $6d04
	ret nz			; $6d07
	call $6c5f		; $6d08
	ld a,$02		; $6d0b
	jp fadeoutToWhiteWithDelay		; $6d0d
	ld a,($cbb3)		; $6d10
	rst_jumpTable			; $6d13
	ld e,$6d		; $6d14
	or a			; $6d16
	ld l,h			; $6d17
	jp z,$e06c		; $6d18
	ld l,h			; $6d1b
	cp $6c			; $6d1c
	ld a,($c4ab)		; $6d1e
	or a			; $6d21
	ret nz			; $6d22
	call setScreenShakeCounter		; $6d23
	call disableLcd		; $6d26
	call clearScreenVariablesAndWramBank1		; $6d29
	ld a,$15		; $6d2c
	call unsetGlobalFlag		; $6d2e
	ld bc,$0027		; $6d31
	call $6de4		; $6d34
	ld a,$1e		; $6d37
	ld ($cbb4),a		; $6d39
	ld hl,$cbb3		; $6d3c
	inc (hl)		; $6d3f
	jp $6d9f		; $6d40
	ld a,($cbb3)		; $6d43
	rst_jumpTable			; $6d46
	ld d,c			; $6d47
	ld l,l			; $6d48
	or a			; $6d49
	ld l,h			; $6d4a
	jp z,$e06c		; $6d4b
	ld l,h			; $6d4e
	halt			; $6d4f
	ld l,l			; $6d50
	ld a,($c4ab)		; $6d51
	or a			; $6d54
	ret nz			; $6d55
	call setScreenShakeCounter		; $6d56
	call disableLcd		; $6d59
	call clearScreenVariablesAndWramBank1		; $6d5c
	ld a,$15		; $6d5f
	call unsetGlobalFlag		; $6d61
	ld bc,$0017		; $6d64
	call $6de4		; $6d67
	ld a,$1e		; $6d6a
	ld ($cbb4),a		; $6d6c
	ld hl,$cbb3		; $6d6f
	inc (hl)		; $6d72
	jp $6d9f		; $6d73
	ld hl,$cbb5		; $6d76
	call $6dcb		; $6d79
	call $6ddf		; $6d7c
	ret nz			; $6d7f
	ld hl,$6d86		; $6d80
	jp setWarpDestVariables		; $6d83
	add h			; $6d86
	rst $28			; $6d87
	nop			; $6d88
	ld l,c			; $6d89
	inc bc			; $6d8a
	call disableLcd		; $6d8b
	call clearScreenVariablesAndWramBank1		; $6d8e
	ld a,$15		; $6d91
	call setGlobalFlag		; $6d93
	call loadAreaData		; $6d96
	call loadAreaGraphics		; $6d99
	call func_131f		; $6d9c
	ld a,$01		; $6d9f
	ld ($cd00),a		; $6da1
	ld a,$02		; $6da4
	call fadeinFromWhiteWithDelay		; $6da6
	call loadCommonGraphics		; $6da9
	ld a,$02		; $6dac
	jp loadGfxRegisterStateIndex		; $6dae
	dec (hl)		; $6db1
	ret nz			; $6db2
	call getRandomNumber		; $6db3
	and $0f			; $6db6
	add $08			; $6db8
	ld (hl),a		; $6dba
	call getFreePartSlot		; $6dbb
	ret nz			; $6dbe
	ld (hl),$11		; $6dbf
	inc l			; $6dc1
	ld (hl),$01		; $6dc2
	ld l,$cb		; $6dc4
	ld (hl),b		; $6dc6
	ld l,$cd		; $6dc7
	ld (hl),c		; $6dc9
	ret			; $6dca
	dec (hl)		; $6dcb
	ret nz			; $6dcc
	call getRandomNumber		; $6dcd
	and $0f			; $6dd0
	add $08			; $6dd2
	ld (hl),a		; $6dd4
	call getFreePartSlot		; $6dd5
	ret nz			; $6dd8
	ld (hl),$11		; $6dd9
	inc l			; $6ddb
	ld (hl),$02		; $6ddc
	ret			; $6dde
	ld hl,$cbb4		; $6ddf
	dec (hl)		; $6de2
	ret			; $6de3
	ld a,b			; $6de4
	ld ($cc49),a		; $6de5
	ld a,c			; $6de8
	ld ($cc4c),a		; $6de9
	call loadScreenMusicAndSetRoomPack		; $6dec
	call loadAreaData		; $6def
	call loadAreaGraphics		; $6df2
	jp func_131f		; $6df5
	ld a,$ff		; $6df8
	jp setScreenShakeCounter		; $6dfa
	ld a,($cc03)		; $6dfd
	rst_jumpTable			; $6e00
	dec d			; $6e01
	ld l,(hl)		; $6e02
	cpl			; $6e03
	ld l,(hl)		; $6e04
	ld a,($cc03)		; $6e05
	rst_jumpTable			; $6e08
	dec d			; $6e09
	ld l,(hl)		; $6e0a
	ld e,c			; $6e0b
	ld l,a			; $6e0c
	ld a,($cc03)		; $6e0d
	rst_jumpTable			; $6e10
	dec d			; $6e11
	ld l,(hl)		; $6e12
	di			; $6e13
	ld l,a			; $6e14
	ld b,$10		; $6e15
	ld hl,$cbb3		; $6e17
	call clearMemory		; $6e1a
	call clearWramBank1		; $6e1d
	xor a			; $6e20
	ld ($cca4),a		; $6e21
	ld a,$80		; $6e24
	ld ($cc02),a		; $6e26
	ld a,$01		; $6e29
	ld ($cc03),a		; $6e2b
	ret			; $6e2e
	ld a,($cbb3)		; $6e2f
	rst_jumpTable			; $6e32
	ld c,e			; $6e33
	ld l,(hl)		; $6e34
	ld d,(hl)		; $6e35
	ld l,(hl)		; $6e36
	ld a,a			; $6e37
	ld l,(hl)		; $6e38
	adc (hl)		; $6e39
	ld l,(hl)		; $6e3a
	xor (hl)		; $6e3b
	ld l,(hl)		; $6e3c
.DB $d3				; $6e3d
	ld l,(hl)		; $6e3e
.DB $e4				; $6e3f
	ld l,(hl)		; $6e40
	dec c			; $6e41
	ld l,a			; $6e42
	ld d,$6f		; $6e43
	rra			; $6e45
	ld l,a			; $6e46
	jr z,_label_03_200	; $6e47
	scf			; $6e49
	ld l,a			; $6e4a
	ld a,$28		; $6e4b
	ld ($cbb5),a		; $6e4d
	call fastFadeoutToBlack		; $6e50
	jp $71f1		; $6e53
	call $7205		; $6e56
	ret nz			; $6e59
	call $720f		; $6e5a
	call getFreeInteractionSlot		; $6e5d
	jr nz,_label_03_198	; $6e60
	ld (hl),$b0		; $6e62
	inc l			; $6e64
	ld (hl),$03		; $6e65
_label_03_198:
	ld a,$13		; $6e67
	call loadGfxRegisterStateIndex		; $6e69
	ld a,$d2		; $6e6c
	call playSound		; $6e6e
	xor a			; $6e71
	ld ($cbb5),a		; $6e72
	ld ($cbb6),a		; $6e75
	dec a			; $6e78
	ld ($cbba),a		; $6e79
	call $71f1		; $6e7c
	ld hl,$cbb5		; $6e7f
	ld b,$04		; $6e82
	call func_2d73		; $6e84
	ret z			; $6e87
	call clearPaletteFadeVariablesAndRefreshPalettes		; $6e88
	jp $71f1		; $6e8b
	call getFreeInteractionSlot		; $6e8e
	jr nz,_label_03_199	; $6e91
	ld (hl),$b0		; $6e93
	inc l			; $6e95
	ld (hl),$04		; $6e96
_label_03_199:
	ld a,$f0		; $6e98
	call playSound		; $6e9a
	ld a,$04		; $6e9d
	ld ($cbb5),a		; $6e9f
	call $5504		; $6ea2
	ld a,$ef		; $6ea5
	ldh (<hSprPaletteSources),a	; $6ea7
	ldh (<hDirtySprPalettes),a	; $6ea9
	jp $71f1		; $6eab
	ld hl,$cbb5		; $6eae
	dec (hl)		; $6eb1
	ret nz			; $6eb2
	ld a,$04		; $6eb3
	ld ($cbae),a		; $6eb5
_label_03_200:
	ld c,$08		; $6eb8
	jp $71e7		; $6eba
	call fastFadeinFromBlack		; $6ebd
	ld a,b			; $6ec0
	ld ($c4b2),a		; $6ec1
	ld ($c4b4),a		; $6ec4
	xor a			; $6ec7
	ld ($c4b1),a		; $6ec8
	ld ($c4b3),a		; $6ecb
	ld a,$72		; $6ece
	jp playSound		; $6ed0
	call $71fb		; $6ed3
	ret nz			; $6ed6
	ld b,$40		; $6ed7
	call $6ebd		; $6ed9
	ld a,$1e		; $6edc
	ld ($cbb5),a		; $6ede
	jp $71f1		; $6ee1
	call $7205		; $6ee4
	ret nz			; $6ee7
	call fadeinFromBlack		; $6ee8
	ld a,$af		; $6eeb
	ld ($c4b2),a		; $6eed
	ld ($c4b4),a		; $6ef0
	xor a			; $6ef3
	ld ($cfc6),a		; $6ef4
	call $72af		; $6ef7
	call $72d0		; $6efa
	ld a,$21		; $6efd
	ld (wActiveMusic),a		; $6eff
	call playSound		; $6f02
	ld a,$1e		; $6f05
	ld ($cbb5),a		; $6f07
	jp $71f1		; $6f0a
	call $7205		; $6f0d
	ret nz			; $6f10
	ld c,$09		; $6f11
	jp $71e7		; $6f13
	call $71fb		; $6f16
	ret nz			; $6f19
	ld c,$0a		; $6f1a
	jp $71e7		; $6f1c
	call $71fb		; $6f1f
	ret nz			; $6f22
	ld c,$0b		; $6f23
	jp $71e7		; $6f25
	call $71fb		; $6f28
	ret nz			; $6f2b
	ld c,$0c		; $6f2c
	call $71e7		; $6f2e
	ld a,$3c		; $6f31
	ld ($cbb5),a		; $6f33
	ret			; $6f36
	call $71fb		; $6f37
	ret nz			; $6f3a
	xor a			; $6f3b
	ld ($cc02),a		; $6f3c
	ld a,$20		; $6f3f
	call setGlobalFlag		; $6f41
	ld a,$03		; $6f44
	ld ($cc4e),a		; $6f46
	ld hl,$6f54		; $6f49
	call setWarpDestVariables		; $6f4c
	ld a,$0f		; $6f4f
	jp loadPaletteHeader		; $6f51
	add b			; $6f54
	adc d			; $6f55
	nop			; $6f56
	dec h			; $6f57
	add e			; $6f58
	ld a,($cbb3)		; $6f59
	rst_jumpTable			; $6f5c
	ld l,e			; $6f5d
	ld l,a			; $6f5e
	ld (hl),c		; $6f5f
	ld l,a			; $6f60
	sbc d			; $6f61
	ld l,a			; $6f62
	and d			; $6f63
	ld l,a			; $6f64
	xor (hl)		; $6f65
	ld l,a			; $6f66
	pop de			; $6f67
	ld l,a			; $6f68
.DB $db				; $6f69
	ld l,a			; $6f6a
	call fadeoutToWhite		; $6f6b
	jp $71f1		; $6f6e
	ld a,($c4ab)		; $6f71
	or a			; $6f74
	ret nz			; $6f75
	ld a,$03		; $6f76
	ld bc,$00b6		; $6f78
	call $63d2		; $6f7b
	ld a,$f1		; $6f7e
	call playSound		; $6f80
	ld a,$20		; $6f83
	ld (wActiveMusic),a		; $6f85
	call playSound		; $6f88
	ld a,$02		; $6f8b
	call loadGfxRegisterStateIndex		; $6f8d
	xor a			; $6f90
	call $7242		; $6f91
	call fadeinFromWhite		; $6f94
	jp $71f1		; $6f97
	ld a,($c4ab)		; $6f9a
	or a			; $6f9d
	ret nz			; $6f9e
	jp $71f1		; $6f9f
	ld a,($cfc0)		; $6fa2
	bit 1,a			; $6fa5
	ret z			; $6fa7
	call fadeoutToWhite		; $6fa8
	jp $71f1		; $6fab
	ld a,($c4ab)		; $6fae
	or a			; $6fb1
	ret nz			; $6fb2
	ld bc,$00e9		; $6fb3
	call $63d2		; $6fb6
	ld a,$f1		; $6fb9
	call playSound		; $6fbb
	ld a,$02		; $6fbe
	call loadGfxRegisterStateIndex		; $6fc0
	call clearWramBank1		; $6fc3
	ld a,$01		; $6fc6
	call $7242		; $6fc8
	call fadeinFromWhite		; $6fcb
	jp $71f1		; $6fce
	ld a,($c4ab)		; $6fd1
	or a			; $6fd4
	ret nz			; $6fd5
	ld c,$10		; $6fd6
	jp $71e7		; $6fd8
	call $71fb		; $6fdb
	ret nz			; $6fde
	xor a			; $6fdf
	ld ($cc02),a		; $6fe0
	ld a,$1e		; $6fe3
	call setGlobalFlag		; $6fe5
	ld hl,$6fee		; $6fe8
	jp setWarpDestVariables		; $6feb
	add l			; $6fee
	add a			; $6fef
	sub e			; $6ff0
	rst $38			; $6ff1
	ld bc,$00cd		; $6ff2
	ld (hl),b		; $6ff5
	ld hl,$cbb3		; $6ff6
	ld a,(hl)		; $6ff9
	cp $10			; $6ffa
	jp c,updateStatusBar		; $6ffc
	ret			; $6fff
	ld a,($cbb3)		; $7000
	rst_jumpTable			; $7003
	ld l,$70		; $7004
	inc (hl)		; $7006
	ld (hl),b		; $7007
	ld d,a			; $7008
	ld (hl),b		; $7009
	ld l,b			; $700a
	ld (hl),b		; $700b
	ld a,b			; $700c
	ld (hl),b		; $700d
	sub h			; $700e
	ld (hl),b		; $700f
	or e			; $7010
	ld (hl),b		; $7011
	jp $cc70		; $7012
	ld (hl),b		; $7015
	push de			; $7016
	ld (hl),b		; $7017
	pop hl			; $7018
	ld (hl),b		; $7019
	di			; $701a
	ld (hl),b		; $701b
	inc de			; $701c
	ld (hl),c		; $701d
	inc e			; $701e
	ld (hl),c		; $701f
	dec h			; $7020
	ld (hl),c		; $7021
	dec sp			; $7022
	ld (hl),c		; $7023
	ld b,(hl)		; $7024
	ld (hl),c		; $7025
	ld (hl),h		; $7026
	ld (hl),c		; $7027
	ld a,l			; $7028
	ld (hl),c		; $7029
	add (hl)		; $702a
	ld (hl),c		; $702b
	adc a			; $702c
	ld (hl),c		; $702d
	call fadeoutToWhite		; $702e
	jp $71f1		; $7031
	ld a,($c4ab)		; $7034
	or a			; $7037
	ret nz			; $7038
	ld bc,$00e9		; $7039
	call $63d2		; $703c
	ld a,$02		; $703f
	call loadGfxRegisterStateIndex		; $7041
	call restartSound		; $7044
	ld a,$02		; $7047
	call $7242		; $7049
	call fadeinFromWhite		; $704c
	ld a,$3c		; $704f
	ld ($cbb5),a		; $7051
	jp $71f1		; $7054
	call $7205		; $7057
	ret nz			; $705a
	ld hl,$cfc0		; $705b
	set 7,(hl)		; $705e
	ld a,$ff		; $7060
	ld ($cbb5),a		; $7062
	jp $71f1		; $7065
	ld hl,$cbb5		; $7068
	dec (hl)		; $706b
	ret nz			; $706c
	ld c,$11		; $706d
	call $71e7		; $706f
	ld a,$5a		; $7072
	ld ($cbb5),a		; $7074
	ret			; $7077
	call $71fb		; $7078
	jr z,_label_03_201	; $707b
	ld a,$3c		; $707d
	cp (hl)			; $707f
	ret nz			; $7080
	ld hl,$cfc0		; $7081
	set 6,(hl)		; $7084
	ret			; $7086
_label_03_201:
	ld hl,$cfc0		; $7087
	set 5,(hl)		; $708a
	ld a,$3c		; $708c
	ld ($cbb5),a		; $708e
	jp $71f1		; $7091
	ld hl,$cbb5		; $7094
	dec (hl)		; $7097
	ret nz			; $7098
	ld a,$1e		; $7099
	ld ($cbb5),a		; $709b
	xor a			; $709e
	ld ($cfc6),a		; $709f
	call $72af		; $70a2
	call $72ba		; $70a5
	ld a,$21		; $70a8
	ld (wActiveMusic),a		; $70aa
	call playSound		; $70ad
	jp $71f1		; $70b0
	ld a,($cfc0)		; $70b3
	bit 0,a			; $70b6
	ret z			; $70b8
	ld hl,$cbb5		; $70b9
	dec (hl)		; $70bc
	ret nz			; $70bd
	ld c,$12		; $70be
	jp $71e7		; $70c0
	call $71fb		; $70c3
	ret nz			; $70c6
	ld c,$13		; $70c7
	jp $71e7		; $70c9
	call $71fb		; $70cc
	ret nz			; $70cf
	ld c,$14		; $70d0
	jp $71e7		; $70d2
	call $71fb		; $70d5
	ret nz			; $70d8
	ld hl,$cfc0		; $70d9
	res 0,(hl)		; $70dc
	jp $71f1		; $70de
	ld a,($cfc0)		; $70e1
	bit 0,a			; $70e4
	ret z			; $70e6
	xor a			; $70e7
	ld ($cbb4),a		; $70e8
	ld a,$d2		; $70eb
	call playSound		; $70ed
	call $71f1		; $70f0
	call $71ac		; $70f3
	ret nz			; $70f6
	call clearWramBank1		; $70f7
	ld hl,$cfc0		; $70fa
	res 0,(hl)		; $70fd
	xor a			; $70ff
	ld ($cfc6),a		; $7100
	call $72c5		; $7103
	ld a,$04		; $7106
	call fadeinFromWhiteWithDelay		; $7108
	ld a,$1e		; $710b
	ld ($cbb5),a		; $710d
	jp $71f1		; $7110
	call $7205		; $7113
	ret nz			; $7116
	ld c,$16		; $7117
	jp $71e7		; $7119
	call $71fb		; $711c
	ret nz			; $711f
	ld c,$17		; $7120
	jp $71e7		; $7122
	call $71fb		; $7125
	ret nz			; $7128
	ld hl,$cfc0		; $7129
	set 0,(hl)		; $712c
	ld a,$3c		; $712e
	ld ($cbb5),a		; $7130
	ld a,$bb		; $7133
	call playSound		; $7135
	jp $71f1		; $7138
	ld hl,$cbb5		; $713b
	dec (hl)		; $713e
	ret nz			; $713f
	call fadeoutToWhite		; $7140
	jp $71f1		; $7143
	ld a,($c4ab)		; $7146
	or a			; $7149
	ret nz			; $714a
	call $720f		; $714b
	call $7231		; $714e
	ld a,$f1		; $7151
	call playSound		; $7153
	xor a			; $7156
	ld ($cfc6),a		; $7157
	call $72d0		; $715a
	call getFreeInteractionSlot		; $715d
	jr nz,_label_03_202	; $7160
	ld (hl),$b0		; $7162
_label_03_202:
	ld a,$13		; $7164
	call loadGfxRegisterStateIndex		; $7166
	call fadeinFromBlack		; $7169
	ld a,$1e		; $716c
	ld ($cbb5),a		; $716e
	jp $71f1		; $7171
	call $7205		; $7174
	ret nz			; $7177
	ld c,$18		; $7178
	jp $71e7		; $717a
	call $71fb		; $717d
	ret nz			; $7180
	ld c,$19		; $7181
	jp $71e7		; $7183
	call $71fb		; $7186
	ret nz			; $7189
	ld c,$1a		; $718a
	jp $71e7		; $718c
	call $71fb		; $718f
	ret nz			; $7192
	xor a			; $7193
	ld ($cc02),a		; $7194
	ld a,$1f		; $7197
	call setGlobalFlag		; $7199
	ld a,$03		; $719c
	ld ($cc4e),a		; $719e
	ld hl,$71a7		; $71a1
	jp setWarpDestVariables		; $71a4
	ret nz			; $71a7
	inc hl			; $71a8
	nop			; $71a9
	ld b,l			; $71aa
	add e			; $71ab
	ld a,($cbb4)		; $71ac
	rst_jumpTable			; $71af
	cp h			; $71b0
	ld (hl),c		; $71b1
	rst_jumpTable			; $71b2
	ld (hl),c		; $71b3
	rst_jumpTable			; $71b4
	ld (hl),c		; $71b5
	rst_addAToHl			; $71b6
	ld (hl),c		; $71b7
.DB $db				; $71b8
	ld (hl),c		; $71b9
.DB $e4				; $71ba
	ld (hl),c		; $71bb
	ld a,$0a		; $71bc
_label_03_203:
	ld ($cbb5),a		; $71be
	call clearFadingPalettes		; $71c1
	jp $71f6		; $71c4
	ld hl,$cbb5		; $71c7
	dec (hl)		; $71ca
	ret nz			; $71cb
	ld a,$0a		; $71cc
_label_03_204:
	ld ($cbb5),a		; $71ce
	call fastFadeoutToWhite		; $71d1
	jp $71f6		; $71d4
	ld a,$14		; $71d7
	jr _label_03_203		; $71d9
	ld hl,$cbb5		; $71db
	dec (hl)		; $71de
	ret nz			; $71df
	ld a,$1e		; $71e0
	jr _label_03_204		; $71e2
	jp $7205		; $71e4
	ld b,$50		; $71e7
	call showText		; $71e9
	ld a,$1e		; $71ec
	ld ($cbb5),a		; $71ee
	ld hl,$cbb3		; $71f1
	inc (hl)		; $71f4
	ret			; $71f5
	ld hl,$cbb4		; $71f6
	inc (hl)		; $71f9
	ret			; $71fa
	ld a,($cba0)		; $71fb
	or a			; $71fe
	ret nz			; $71ff
	ld hl,$cbb5		; $7200
	dec (hl)		; $7203
	ret			; $7204
	ld a,($c4ab)		; $7205
	or a			; $7208
	ret nz			; $7209
	ld hl,$cbb5		; $720a
	dec (hl)		; $720d
	ret			; $720e
	xor a			; $720f
	ld bc,$059a		; $7210
	call $63d2		; $7213
	ld a,$ac		; $7216
	call loadPaletteHeader		; $7218
	ld a,$28		; $721b
	ld ($c487),a		; $721d
	ld ($c48d),a		; $7220
	ldh (<hCameraX),a	; $7223
	ld a,$00		; $7225
	ld ($cd00),a		; $7227
	ld a,$10		; $722a
	ldh (<hOamTail),a	; $722c
	jp clearWramBank1		; $722e
	ld b,$02		; $7231
_label_03_205:
	call getFreeInteractionSlot		; $7233
	ret nz			; $7236
	ld (hl),$b0		; $7237
	inc l			; $7239
	ld a,$02		; $723a
	add b			; $723c
	dec b			; $723d
	ld (hl),a		; $723e
	jr nz,_label_03_205	; $723f
	ret			; $7241
	ld hl,$7265		; $7242
	rst_addDoubleIndex			; $7245
	ldi a,(hl)		; $7246
	ld b,(hl)		; $7247
	ld c,a			; $7248
_label_03_206:
	ld a,(bc)		; $7249
	or a			; $724a
	ret z			; $724b
	call getFreeInteractionSlot		; $724c
	ret nz			; $724f
	ld a,(bc)		; $7250
	ldi (hl),a		; $7251
	inc bc			; $7252
	ld a,(bc)		; $7253
	ldi (hl),a		; $7254
	inc bc			; $7255
	ld a,(bc)		; $7256
	ldi (hl),a		; $7257
	inc bc			; $7258
	ld l,$4b		; $7259
	ld a,(bc)		; $725b
	ld (hl),a		; $725c
	inc bc			; $725d
	ld l,$4d		; $725e
	ld a,(bc)		; $7260
	ld (hl),a		; $7261
	inc bc			; $7262
	jr _label_03_206		; $7263
	ld l,e			; $7265
	ld (hl),d		; $7266
	ld (hl),c		; $7267
	ld (hl),d		; $7268
	sub b			; $7269
	ld (hl),d		; $726a
	ld b,h			; $726b
	ld (bc),a		; $726c
	nop			; $726d
	jr _label_03_207		; $726e
	nop			; $7270
	cp l			; $7271
	nop			; $7272
	ld bc,$3828		; $7273
	cp (hl)			; $7276
	nop			; $7277
	ld bc,$3840		; $7278
	ld b,h			; $727b
	inc bc			; $727c
	nop			; $727d
	jr nz,_label_03_208	; $727e
	cp h			; $7280
	nop			; $7281
	nop			; $7282
	ld c,b			; $7283
	ld d,b			; $7284
	cp d			; $7285
	nop			; $7286
	inc bc			; $7287
_label_03_207:
	jr z,_label_03_211	; $7288
	cp e			; $728a
	nop			; $728b
	nop			; $728c
	ld b,b			; $728d
	ld l,b			; $728e
	nop			; $728f
	cp l			; $7290
	nop			; $7291
	ld bc,$382c		; $7292
	cp (hl)			; $7295
	nop			; $7296
	nop			; $7297
	ld b,h			; $7298
	ld b,b			; $7299
	ld b,h			; $729a
	inc bc			; $729b
	nop			; $729c
	jr nz,_label_03_210	; $729d
	cp h			; $729f
	nop			; $72a0
	nop			; $72a1
	ld d,b			; $72a2
	ld e,b			; $72a3
	cp d			; $72a4
	nop			; $72a5
	ld (bc),a		; $72a6
	jr nz,$64		; $72a7
	cp e			; $72a9
	nop			; $72aa
	inc bc			; $72ab
	jr c,$68		; $72ac
	nop			; $72ae
	ld a,$01		; $72af
	ld ($cc17),a		; $72b1
	ld a,$b4		; $72b4
	ld ($cc1d),a		; $72b6
	ret			; $72b9
	ld bc,$72ed		; $72ba
	call $72d9		; $72bd
	ld bc,$72f0		; $72c0
	jr _label_03_209		; $72c3
	ld bc,$72f3		; $72c5
	call $72d9		; $72c8
	ld bc,$72f6		; $72cb
	jr _label_03_209		; $72ce
_label_03_208:
	ld bc,$72f9		; $72d0
	call $72d9		; $72d3
	ld bc,$72fc		; $72d6
_label_03_209:
	call getFreeInteractionSlot		; $72d9
	ret nz			; $72dc
	ld (hl),$b4		; $72dd
	inc l			; $72df
	ld a,(bc)		; $72e0
	inc bc			; $72e1
	ld (hl),a		; $72e2
	ld l,$4b		; $72e3
	ld a,(bc)		; $72e5
	inc bc			; $72e6
	ld (hl),a		; $72e7
	ld l,$4d		; $72e8
	ld a,(bc)		; $72ea
	ld (hl),a		; $72eb
	ret			; $72ec
	ld (bc),a		; $72ed
	nop			; $72ee
_label_03_210:
	ld b,b			; $72ef
	inc bc			; $72f0
	nop			; $72f1
_label_03_211:
	ld h,b			; $72f2
	inc b			; $72f3
	ld d,b			; $72f4
	ld l,b			; $72f5
	dec b			; $72f6
	ld d,b			; $72f7
	jr c,_label_03_212	; $72f8
	ld c,h			; $72fa
	adc (hl)		; $72fb
	rlca			; $72fc
	ld c,h			; $72fd
	ld h,d			; $72fe
	ld a,e			; $72ff
_label_03_212:
	rst_jumpTable			; $7300
	dec bc			; $7301
	ld (hl),e		; $7302
	ld a,(bc)		; $7303
	halt			; $7304
	sbc h			; $7305
	ld (hl),a		; $7306
	rst_addAToHl			; $7307
	ld a,d			; $7308
	ei			; $7309
	ld a,e			; $730a
	call $731b		; $730b
	ld hl,$cc03		; $730e
	ld a,(hl)		; $7311
	cp $02			; $7312
	ret z			; $7314
	cp $03			; $7315
	ret z			; $7317
	jp updateAllObjects		; $7318
	ld de,$cc03		; $731b
	ld a,(de)		; $731e
	rst_jumpTable			; $731f
	ld b,b			; $7320
	ld (hl),e		; $7321
	ld c,b			; $7322
	ld (hl),e		; $7323
	jr z,_label_03_213	; $7324
	ld l,d			; $7326
	ld (hl),h		; $7327
	add h			; $7328
	ld (hl),h		; $7329
.DB $fd				; $732a
	ld (hl),h		; $732b
	ld h,l			; $732c
	ld (hl),l		; $732d
	ld a,d			; $732e
	ld (hl),l		; $732f
	add (hl)		; $7330
	ld (hl),l		; $7331
	sbc d			; $7332
	ld (hl),l		; $7333
	or h			; $7334
	ld (hl),l		; $7335
	cp a			; $7336
	ld (hl),l		; $7337
	add $75			; $7338
	pop de			; $733a
	ld (hl),l		; $733b
.DB $dd				; $733c
	ld (hl),l		; $733d
.DB $ec				; $733e
	ld (hl),l		; $733f
	ld a,$01		; $7340
	ld (de),a		; $7342
	ld a,$55		; $7343
	call playSound		; $7345
	ld a,$ff		; $7348
	ld ($cd25),a		; $734a
	ld a,$01		; $734d
	ld ($cfd0),a		; $734f
	ld hl,$cc02		; $7352
	ld (hl),$01		; $7355
	ld hl,$d01a		; $7357
	res 7,(hl)		; $735a
	call saveGraphicsOnEnterMenu		; $735c
	ld a,$0c		; $735f
	call loadGfxHeader		; $7361
	ld a,$95		; $7364
	call loadPaletteHeader		; $7366
	ld a,$04		; $7369
	call loadGfxRegisterStateIndex		; $736b
	ld hl,$cbb3		; $736e
	ld (hl),$58		; $7371
	inc hl			; $7373
	ld (hl),$02		; $7374
	ld hl,$cbb6		; $7376
	ld (hl),$28		; $7379
	call fastFadeinFromWhite		; $737b
	call $7a66		; $737e
	ld hl,$cbb5		; $7381
	ld (hl),$02		; $7384
	call clearOam		; $7386
	ld b,$00		; $7389
	ld a,($c487)		; $738b
	cpl			; $738e
	inc a			; $738f
	ld c,a			; $7390
	ld hl,$7397		; $7391
	jp addSpritesToOam_withOffset		; $7394
	inc h			; $7397
	ld d,c			; $7398
	ccf			; $7399
_label_03_213:
	ld e,$06		; $739a
	ld b,b			; $739c
	inc c			; $739d
	ld ($4f01),sp		; $739e
	inc c			; $73a1
	jr z,_label_03_214	; $73a2
	ld e,h			; $73a4
_label_03_214:
	jr nc,_label_03_215	; $73a5
	ld (bc),a		; $73a7
	ld e,h			; $73a8
	jr c,_label_03_216	; $73a9
	ld bc,$3f4c		; $73ab
	inc b			; $73ae
	ld bc,$4a50		; $73af
	ld b,$02		; $73b2
	ld b,b			; $73b4
	inc d			; $73b5
	ld a,(bc)		; $73b6
	ld bc,$144f		; $73b7
	ldi a,(hl)		; $73ba
	ld bc,$6461		; $73bb
	inc c			; $73be
	ld bc,$6c61		; $73bf
	ld c,$01		; $73c2
	ld (hl),c		; $73c4
	ld h,h			; $73c5
	inc l			; $73c6
_label_03_215:
	ld bc,$6c71		; $73c7
	ld l,$01		; $73ca
	adc b			; $73cc
_label_03_216:
	jr c,_label_03_217	; $73cd
	nop			; $73cf
	ld l,c			; $73d0
	ld d,b			; $73d1
	ld h,$04		; $73d2
	ld l,c			; $73d4
	ld c,b			; $73d5
	inc h			; $73d6
	inc b			; $73d7
	ld c,h			; $73d8
	cpl			; $73d9
	nop			; $73da
	ld bc,$374c		; $73db
	ld (bc),a		; $73de
_label_03_217:
	ld bc,$3053		; $73df
	ld (de),a		; $73e2
	dec b			; $73e3
	ld d,e			; $73e4
	jr c,_label_03_219	; $73e5
	dec b			; $73e7
	ld de,$4286		; $73e8
	inc bc			; $73eb
	rla			; $73ec
	adc b			; $73ed
	ld d,$04		; $73ee
	scf			; $73f0
	and d			; $73f1
	jr nc,_label_03_218	; $73f2
	scf			; $73f4
	xor d			; $73f5
	ldd (hl),a		; $73f6
	inc b			; $73f7
_label_03_218:
	ld hl,$189f		; $73f8
_label_03_219:
	dec b			; $73fb
	ld hl,$1aa7		; $73fc
	dec b			; $73ff
	ldi (hl),a		; $7400
	sbc (hl)		; $7401
	inc e			; $7402
	inc bc			; $7403
	ld (hl),e		; $7404
	or b			; $7405
	inc (hl)		; $7406
	inc b			; $7407
	ld (hl),e		; $7408
	cp b			; $7409
	ld (hl),$04		; $740a
	ldd a,(hl)		; $740c
	sbc h			; $740d
	jr c,_label_03_220	; $740e
	dec sp			; $7410
	dec hl			; $7411
	ldd a,(hl)		; $7412
_label_03_220:
	inc bc			; $7413
	dec sp			; $7414
	inc sp			; $7415
	inc a			; $7416
	inc bc			; $7417
	ld b,b			; $7418
	ld b,d			; $7419
	ld a,$03		; $741a
	ld (hl),b		; $741c
	add b			; $741d
	ld b,b			; $741e
	inc bc			; $741f
	sub b			; $7420
	inc (hl)		; $7421
	ld b,h			; $7422
	ld b,$90		; $7423
	inc a			; $7425
	ld b,(hl)		; $7426
	ld b,$fa		; $7427
	xor e			; $7429
	call nz,$c2b7		; $742a
	add (hl)		; $742d
	ld (hl),e		; $742e
	call $7458		; $742f
	call $7386		; $7432
	ld hl,$cbb3		; $7435
	call decHlRef16WithCap		; $7438
	jr z,_label_03_221	; $743b
	ldi a,(hl)		; $743d
	ld h,(hl)		; $743e
	ld l,a			; $743f
	ld bc,$00f0		; $7440
	call compareHlToBc		; $7443
	ret nc			; $7446
	ld a,($c482)		; $7447
	and $01			; $744a
	ret z			; $744c
_label_03_221:
	ld a,$55		; $744d
	call playSound		; $744f
	call $7a66		; $7452
	jp fastFadeoutToWhite		; $7455
	ld a,(wFrameCounter)		; $7458
	and $07			; $745b
	ret nz			; $745d
	ld hl,$cbb6		; $745e
	ld a,(hl)		; $7461
	or a			; $7462
	ret z			; $7463
	dec (hl)		; $7464
	ld hl,$c487		; $7465
	inc (hl)		; $7468
	ret			; $7469
	ld a,($c4ab)		; $746a
	or a			; $746d
	jp nz,$7386		; $746e
	xor a			; $7471
	ld ($cd25),a		; $7472
	ld hl,$d01a		; $7475
	set 7,(hl)		; $7478
	xor a			; $747a
	ld ($cfd0),a		; $747b
	call $7a66		; $747e
	jp reloadGraphicsOnExitMenu		; $7481
	ld a,($cfd0)		; $7484
	cp $02			; $7487
	ret nz			; $7489
	ld hl,$cbb4		; $748a
	xor a			; $748d
	ld (hl),a		; $748e
	call $74aa		; $748f
	ld hl,$de90		; $7492
	ld bc,$44e8		; $7495
	call func_13c6		; $7498
	ld a,$f0		; $749b
	call playSound		; $749d
	jp $7a66		; $74a0
	call decCbb3		; $74a3
	ret nz			; $74a6
	inc l			; $74a7
	inc (hl)		; $74a8
	ld a,(hl)		; $74a9
	ld d,h			; $74aa
	ld e,l			; $74ab
	add a			; $74ac
	ld hl,$74d1		; $74ad
	rst_addDoubleIndex			; $74b0
	dec e			; $74b1
	ldi a,(hl)		; $74b2
	ld (de),a		; $74b3
	inc a			; $74b4
	ret z			; $74b5
	ld d,h			; $74b6
	ld e,l			; $74b7
	call getFreePartSlot		; $74b8
	jr nz,_label_03_222	; $74bb
	ld (hl),$27		; $74bd
	ld l,$c2		; $74bf
	inc (hl)		; $74c1
	inc l			; $74c2
	ld a,(de)		; $74c3
	ld (hl),a		; $74c4
	inc de			; $74c5
	ld l,$cb		; $74c6
	ld a,(de)		; $74c8
	ldi (hl),a		; $74c9
	inc de			; $74ca
	inc hl			; $74cb
	ld a,(de)		; $74cc
	ld (hl),a		; $74cd
_label_03_222:
	or $01			; $74ce
	ret			; $74d0
	inc a			; $74d1
	nop			; $74d2
	ld d,b			; $74d3
	jr nz,$3c		; $74d4
	ld bc,$5870		; $74d6
	jr z,_label_03_223	; $74d9
_label_03_223:
	ld b,b			; $74db
	add b			; $74dc
	jr z,_label_03_224	; $74dd
_label_03_224:
	jr _label_03_226		; $74df
	ld e,$02		; $74e1
	stop			; $74e3
	add b			; $74e4
	ld e,$00		; $74e5
	ld b,b			; $74e7
	ld c,b			; $74e8
	inc d			; $74e9
	nop			; $74ea
	jr nz,$70		; $74eb
	inc d			; $74ed
	inc b			; $74ee
	ld a,b			; $74ef
	adc b			; $74f0
	inc d			; $74f1
	ld ($7070),sp		; $74f2
	inc d			; $74f5
	nop			; $74f6
	ld b,b			; $74f7
_label_03_225:
	ld b,b			; $74f8
	rst $38			; $74f9
	stop			; $74fa
	ld (hl),b		; $74fb
	jr _label_03_225		; $74fc
	xor e			; $74fe
	call nz,$c0b7		; $74ff
	ld hl,$cfd0		; $7502
	ld (hl),$03		; $7505
	call $7516		; $7507
	call $74a3		; $750a
	ret nz			; $750d
	ld hl,$cbb3		; $750e
_label_03_226:
	ld (hl),$3c		; $7511
	jp $7a66		; $7513
	ld de,$cfd2		; $7516
	ld b,$03		; $7519
_label_03_227:
	ld a,(de)		; $751b
	ld c,a			; $751c
	ld a,b			; $751d
	ld hl,bitTable		; $751e
	add l			; $7521
	ld l,a			; $7522
	ld a,(hl)		; $7523
	and c			; $7524
	call nz,$752e		; $7525
	dec b			; $7528
	bit 7,b			; $7529
	jr z,_label_03_227	; $752b
	ret			; $752d
	xor c			; $752e
	ld (de),a		; $752f
	push bc			; $7530
	push de			; $7531
	ld a,b			; $7532
	ld hl,$754f		; $7533
	rst_addDoubleIndex			; $7536
	ldi a,(hl)		; $7537
	ld h,(hl)		; $7538
	ld l,a			; $7539
	ld b,(hl)		; $753a
	inc hl			; $753b
_label_03_228:
	ld c,(hl)		; $753c
	inc hl			; $753d
	ld e,c			; $753e
	ld d,$cf		; $753f
	ld a,(de)		; $7541
	push bc			; $7542
	push hl			; $7543
	call setTile		; $7544
	pop hl			; $7547
	pop bc			; $7548
	dec b			; $7549
	jr nz,_label_03_228	; $754a
	pop de			; $754c
	pop bc			; $754d
	ret			; $754e
	ld d,a			; $754f
	ld (hl),l		; $7550
	ld e,d			; $7551
	ld (hl),l		; $7552
	ld e,(hl)		; $7553
	ld (hl),l		; $7554
	ld h,b			; $7555
	ld (hl),l		; $7556
	ld (bc),a		; $7557
	ld h,l			; $7558
	ld (hl),l		; $7559
	inc bc			; $755a
	rlca			; $755b
	ld ($0118),sp		; $755c
	ld a,b			; $755f
	inc b			; $7560
	ld h,(hl)		; $7561
	ld h,a			; $7562
	halt			; $7563
	ld (hl),a		; $7564
	call decCbb3		; $7565
	ret nz			; $7568
	call $7a66		; $7569
	ld bc,$0c08		; $756c
	call checkIsLinkedGame		; $756f
	jr z,_label_03_229	; $7572
	ld bc,$0c12		; $7574
_label_03_229:
	jp showText		; $7577
	call retIfTextIsActive		; $757a
	call $7a66		; $757d
	ld hl,$74fa		; $7580
	jp $74b6		; $7583
	ld hl,$cfd2		; $7586
	ld a,(hl)		; $7589
	bit 4,a			; $758a
	ret z			; $758c
	call getFreeInteractionSlot		; $758d
	jr nz,_label_03_230	; $7590
	ld (hl),$4e		; $7592
	inc l			; $7594
	ld (hl),$07		; $7595
_label_03_230:
	jp $7a66		; $7597
	ld c,$09		; $759a
	call checkIsLinkedGame		; $759c
	jr z,_label_03_231	; $759f
	ld c,$13		; $75a1
_label_03_231:
	ld a,$05		; $75a3
	ld b,a			; $75a5
	ld hl,$cfd0		; $75a6
	ld a,(hl)		; $75a9
	cp b			; $75aa
	ret nz			; $75ab
	call $7a66		; $75ac
	ld b,$0c		; $75af
	jp showText		; $75b1
	call retIfTextIsActive		; $75b4
	ld hl,$cfd0		; $75b7
	ld (hl),$06		; $75ba
	jp $7a66		; $75bc
	ld a,$08		; $75bf
	ld c,$14		; $75c1
	jp $75a5		; $75c3
	call retIfTextIsActive		; $75c6
	ld hl,$cbb3		; $75c9
	ld (hl),$1e		; $75cc
	jp $7a66		; $75ce
	call decCbb3		; $75d1
	ret nz			; $75d4
	ld hl,$cfd0		; $75d5
	ld (hl),$09		; $75d8
	jp $7a66		; $75da
	ld hl,$cfd0		; $75dd
	ld a,(hl)		; $75e0
	cp $0b			; $75e1
	ret nz			; $75e3
	ld hl,$cbb3		; $75e4
	ld (hl),$3c		; $75e7
	jp $7a66		; $75e9
	call decCbb3		; $75ec
	ret nz			; $75ef
	call clearOam		; $75f0
	call $539c		; $75f3
	ld a,$07		; $75f6
	ld ($c2ef),a		; $75f8
	xor a			; $75fb
	ld ($cc02),a		; $75fc
	ld ($cc03),a		; $75ff
	ld a,$30		; $7602
	call unsetGlobalFlag		; $7604
	jp fadeoutToWhite		; $7607
	ld de,$cc03		; $760a
	ld a,(de)		; $760d
	rst_jumpTable			; $760e
	inc hl			; $760f
	halt			; $7610
	ld b,a			; $7611
	halt			; $7612
	ld (hl),b		; $7613
	halt			; $7614
	ret			; $7615
	halt			; $7616
	push hl			; $7617
	halt			; $7618
	push af			; $7619
	halt			; $761a
	ldd (hl),a		; $761b
	ld (hl),a		; $761c
	ld d,(hl)		; $761d
	ld (hl),a		; $761e
	ld h,l			; $761f
	ld (hl),a		; $7620
	add c			; $7621
	ld (hl),a		; $7622
	ld a,($c4ab)		; $7623
	or a			; $7626
	ret nz			; $7627
	ld a,$01		; $7628
	ld (de),a		; $762a
	ld a,$09		; $762b
	ld ($cfd0),a		; $762d
	ld hl,$cbb3		; $7630
	ld (hl),$58		; $7633
	inc l			; $7635
	ld (hl),$01		; $7636
	ld a,$09		; $7638
	ld b,$00		; $763a
	call $7aa9		; $763c
	ld a,$1c		; $763f
	call playSound		; $7641
	jp fadeinFromWhite		; $7644
	ld a,($c4ab)		; $7647
	or a			; $764a
	ret nz			; $764b
	ld hl,$cbb3		; $764c
	call decHlRef16WithCap		; $764f
	jr nz,_label_03_232	; $7652
	xor a			; $7654
	ld ($c486),a		; $7655
	call $7a66		; $7658
	jp fadeoutToWhite		; $765b
_label_03_232:
	ld hl,$cbb3		; $765e
	ld a,(hl)		; $7661
	and $01			; $7662
	ret nz			; $7664
	ld hl,$c486		; $7665
	ld a,(hl)		; $7668
	or a			; $7669
	ret z			; $766a
	dec a			; $766b
	ld (hl),a		; $766c
	ldh (<hCameraY),a	; $766d
	ret			; $766f
	ld a,($c4ab)		; $7670
	or a			; $7673
	ret nz			; $7674
	call $7a66		; $7675
	ld a,$0a		; $7678
	ld ($cfd0),a		; $767a
	call disableLcd		; $767d
	xor a			; $7680
	ld ($cd08),a		; $7681
	ld ($cd09),a		; $7684
	ld a,$2e		; $7687
	call loadGfxHeader		; $7689
	ld a,$97		; $768c
	call loadPaletteHeader		; $768e
	ld a,$01		; $7691
	ld ($cd00),a		; $7693
	ld a,$18		; $7696
	ld ($cd25),a		; $7698
	call loadAnimationData		; $769b
	call getFreeInteractionSlot		; $769e
	jr nz,_label_03_233	; $76a1
	ld a,$4f		; $76a3
	ldi (hl),a		; $76a5
	ld (hl),$00		; $76a6
	ld ($cc1d),a		; $76a8
	call getFreeInteractionSlot		; $76ab
	jr nz,_label_03_233	; $76ae
	ld (hl),$4f		; $76b0
	inc l			; $76b2
	ld (hl),$01		; $76b3
_label_03_233:
	call refreshObjectGfx		; $76b5
	ld a,$0d		; $76b8
	call loadGfxRegisterStateIndex		; $76ba
	ld hl,$c486		; $76bd
	ldi a,(hl)		; $76c0
	ldh (<hCameraY),a	; $76c1
	ld a,(hl)		; $76c3
	ldh (<hCameraX),a	; $76c4
	jp fadeinFromWhite		; $76c6
	ld hl,$cfd0		; $76c9
	ld a,(hl)		; $76cc
	cp $0b			; $76cd
	ret nz			; $76cf
	ld b,$04		; $76d0
_label_03_234:
	call getFreeInteractionSlot		; $76d2
	jr nz,_label_03_235	; $76d5
	ld (hl),$4f		; $76d7
	inc l			; $76d9
	ld (hl),$02		; $76da
	inc l			; $76dc
	dec b			; $76dd
	ld a,b			; $76de
	ld (hl),a		; $76df
	jr nz,_label_03_234	; $76e0
_label_03_235:
	jp $7a66		; $76e2
	ld a,($cfd0)		; $76e5
	sub $0c			; $76e8
	ret nz			; $76ea
	ld ($cbb3),a		; $76eb
	dec a			; $76ee
	ld ($cbba),a		; $76ef
	jp $7a66		; $76f2
	ld hl,$cbb3		; $76f5
	ld b,$01		; $76f8
	call func_2d73		; $76fa
	ret z			; $76fd
	call disableLcd		; $76fe
	ld a,$01		; $7701
	ldh (<hDirtyBgPalettes),a	; $7703
	ld a,$fe		; $7705
	ldh (<hBgPaletteSources),a	; $7707
	ld a,$81		; $7709
	call $7a6b		; $770b
	ld a,$81		; $770e
	ld ($cbcb),a		; $7710
	call $7a88		; $7713
	ld bc,$1e05		; $7716
	call showText		; $7719
	ld a,$0d		; $771c
	call loadGfxRegisterStateIndex		; $771e
	ld hl,$c486		; $7721
	ldi a,(hl)		; $7724
	ldh (<hCameraY),a	; $7725
	ld a,(hl)		; $7727
	ldh (<hCameraX),a	; $7728
	ld hl,$cfd0		; $772a
	ld (hl),$0d		; $772d
	jp $7a66		; $772f
	call retIfTextIsActive		; $7732
	call disableLcd		; $7735
	ld a,$0e		; $7738
	call loadUncompressedGfxHeader		; $773a
	ld a,$50		; $773d
	call playSound		; $773f
	ld a,$0d		; $7742
	call loadGfxRegisterStateIndex		; $7744
	call fadeinFromWhite		; $7747
	ld hl,$cbb3		; $774a
	ld (hl),$f0		; $774d
	xor a			; $774f
	ld ($cbcb),a		; $7750
	jp $7a66		; $7753
	ld a,($c4ab)		; $7756
	or a			; $7759
	ret nz			; $775a
	call decCbb3		; $775b
	ret nz			; $775e
	call $7a66		; $775f
	jp fadeoutToWhite		; $7762
	ld a,($c4ab)		; $7765
	or a			; $7768
	ret nz			; $7769
	call $7a66		; $776a
	ld a,$ff		; $776d
	ld ($cd25),a		; $776f
	ld a,$0e		; $7772
	ld ($cfd0),a		; $7774
	ld a,$07		; $7777
	ld b,$01		; $7779
	call $7aa9		; $777b
	jp fadeinFromWhite		; $777e
	ld a,($c4ab)		; $7781
	or a			; $7784
	ret nz			; $7785
	ld hl,$cfd0		; $7786
	ld a,(hl)		; $7789
	cp $0f			; $778a
	ret nz			; $778c
	call clearDynamicInteractions		; $778d
	ld a,$08		; $7790
	ld ($c2ef),a		; $7792
	xor a			; $7795
	ld ($cc03),a		; $7796
	jp fadeoutToWhite		; $7799
	ld de,$cc03		; $779c
	ld a,(de)		; $779f
	rst_jumpTable			; $77a0
	or e			; $77a1
	ld (hl),a		; $77a2
	ld bc,$2a78		; $77a3
	ld a,b			; $77a6
	ld c,c			; $77a7
	ld a,b			; $77a8
	ld a,a			; $77a9
	ld a,b			; $77aa
	and a			; $77ab
	ld a,b			; $77ac
	ret nc			; $77ad
	ld a,b			; $77ae
	ld ($ff00+c),a		; $77af
	ld a,b			; $77b0
	ld a,($ff00+$78)	; $77b1
	ld a,($c4ab)		; $77b3
	or a			; $77b6
	ret nz			; $77b7
	ld a,$01		; $77b8
	ld (de),a		; $77ba
	ld b,$02		; $77bb
_label_03_236:
	call getFreeInteractionSlot		; $77bd
	jr nz,_label_03_237	; $77c0
	ld (hl),$77		; $77c2
	inc l			; $77c4
	dec b			; $77c5
	ld (hl),b		; $77c6
	jr nz,_label_03_236	; $77c7
_label_03_237:
	call disableLcd		; $77c9
	ld a,$24		; $77cc
	call loadGfxHeader		; $77ce
	ld a,$98		; $77d1
	call loadPaletteHeader		; $77d3
	ld a,$0e		; $77d6
	call loadGfxRegisterStateIndex		; $77d8
	ld hl,$c486		; $77db
	ldi a,(hl)		; $77de
	ldh (<hCameraY),a	; $77df
	ldi a,(hl)		; $77e1
	ldh (<hCameraX),a	; $77e2
	ld de,$cbb6		; $77e4
	ldi a,(hl)		; $77e7
	ld (de),a		; $77e8
	inc de			; $77e9
	ld a,(hl)		; $77ea
	ld (de),a		; $77eb
	ld hl,$cbb3		; $77ec
	ld (hl),$3c		; $77ef
	xor a			; $77f1
	ld hl,$cfd3		; $77f2
	ld (hl),a		; $77f5
	call $79db		; $77f6
	ld a,$21		; $77f9
	call playSound		; $77fb
	jp fadeinFromWhite		; $77fe
	ld a,($c4ab)		; $7801
	or a			; $7804
	jp nz,$7827		; $7805
	call decCbb3		; $7808
	jr nz,_label_03_240	; $780b
	ld b,$05		; $780d
_label_03_238:
	call getFreeInteractionSlot		; $780f
	jr nz,_label_03_239	; $7812
	ld (hl),$86		; $7814
	inc l			; $7816
	dec b			; $7817
	ld a,b			; $7818
	ld (hl),a		; $7819
	jr nz,_label_03_238	; $781a
_label_03_239:
	ld hl,$cbb3		; $781c
	ld (hl),$b4		; $781f
	inc hl			; $7821
	ld (hl),$00		; $7822
	call $7a66		; $7824
_label_03_240:
	jp $7981		; $7827
	call decCbb3		; $782a
	jr nz,_label_03_241	; $782d
	call $7a01		; $782f
	xor a			; $7832
	ld hl,$cbb4		; $7833
	ld (hl),a		; $7836
	call $7917		; $7837
	ld hl,$cfd3		; $783a
	inc (hl)		; $783d
	set 7,(hl)		; $783e
	jp $7a66		; $7840
_label_03_241:
	call $7909		; $7843
	jp $7981		; $7846
	call $7981		; $7849
	call decCbb3		; $784c
	ret nz			; $784f
	inc l			; $7850
	inc (hl)		; $7851
	ld a,(hl)		; $7852
	cp $03			; $7853
	jr z,_label_03_242	; $7855
	ld hl,$cfd3		; $7857
	inc (hl)		; $785a
	jp $7917		; $785b
_label_03_242:
	call disableLcd		; $785e
	ld a,$24		; $7861
	call loadGfxHeader		; $7863
	ld a,$98		; $7866
	call loadPaletteHeader		; $7868
	call $7a17		; $786b
	ld hl,$cbb3		; $786e
	ld (hl),$78		; $7871
	inc l			; $7873
	ld (hl),$00		; $7874
	ld hl,$cfd3		; $7876
	inc (hl)		; $7879
	res 7,(hl)		; $787a
	jp $7a66		; $787c
	call decCbb3		; $787f
	jr nz,_label_03_243	; $7882
	call disableLcd		; $7884
	ld a,$03		; $7887
	inc l			; $7889
	ld (hl),a		; $788a
	call $7917		; $788b
	ld hl,$cfd3		; $788e
	ld (hl),$ff		; $7891
	call $7a66		; $7893
	ld hl,$cbba		; $7896
	ld (hl),$02		; $7899
	ld hl,$cbb8		; $789b
	jp $7a3b		; $789e
_label_03_243:
	call $7909		; $78a1
	jp $7981		; $78a4
	call $7981		; $78a7
	call $7a2e		; $78aa
	call decCbb3		; $78ad
	ret nz			; $78b0
	inc l			; $78b1
	inc (hl)		; $78b2
	ld a,(hl)		; $78b3
	cp $06			; $78b4
	jr z,_label_03_244	; $78b6
	jp $7917		; $78b8
_label_03_244:
	ld hl,$cbb3		; $78bb
	ld (hl),$3c		; $78be
	call reloadObjectGfx		; $78c0
	ld a,$07		; $78c3
	ld b,$01		; $78c5
	call $7aa9		; $78c7
	call clearPaletteFadeVariablesAndRefreshPalettes		; $78ca
	jp $7a66		; $78cd
	call decCbb3		; $78d0
	ret nz			; $78d3
	ld a,$01		; $78d4
	ld ($cc02),a		; $78d6
	ld bc,$1e04		; $78d9
	call showText		; $78dc
	jp $7a66		; $78df
	call retIfTextIsActive		; $78e2
	call $7a66		; $78e5
	ld hl,$cbb3		; $78e8
	ld (hl),$5a		; $78eb
	jp fadeoutToBlack		; $78ed
	ld a,($c4ab)		; $78f0
	or a			; $78f3
	ret nz			; $78f4
	call decCbb3		; $78f5
	ret nz			; $78f8
	xor a			; $78f9
	ld ($c2ee),a		; $78fa
	ld ($c2ef),a		; $78fd
	ld c,a			; $7900
	ld hl,$5d0d		; $7901
	ld e,$01		; $7904
	jp interBankCall		; $7906
	ld hl,$cbb4		; $7909
	inc (hl)		; $790c
	ld a,(hl)		; $790d
	sub $07			; $790e
	ret nz			; $7910
	ld (hl),a		; $7911
	ld hl,$cbb6		; $7912
	inc (hl)		; $7915
	ret			; $7916
	ld ($cbbb),a		; $7917
	ld hl,$cbb3		; $791a
	ld (hl),$5a		; $791d
	call disableLcd		; $791f
	ld a,($cbbb)		; $7922
	cp $03			; $7925
	jr c,_label_03_246	; $7927
	sub $03			; $7929
	ld hl,$797b		; $792b
	rst_addDoubleIndex			; $792e
	ld b,$00		; $792f
	ldi a,(hl)		; $7931
	ld c,(hl)		; $7932
	call func_36f6		; $7933
	ld b,$31		; $7936
	ld a,($cbbb)		; $7938
	cp $05			; $793b
	jr nz,_label_03_245	; $793d
	ld b,$0f		; $793f
_label_03_245:
	ld a,b			; $7941
	call loadUncompressedGfxHeader		; $7942
	ld a,($cbbb)		; $7945
_label_03_246:
	add $25			; $7948
	call loadGfxHeader		; $794a
	ld a,($cbbb)		; $794d
	ld hl,$7972		; $7950
	rst_addAToHl			; $7953
	ld a,(hl)		; $7954
	call loadPaletteHeader		; $7955
	ld a,$0f		; $7958
	call loadPaletteHeader		; $795a
	ld a,$04		; $795d
	call loadGfxRegisterStateIndex		; $795f
	ld a,($cbbb)		; $7962
	sub $03			; $7965
	ret c			; $7967
	ld hl,$7978		; $7968
	rst_addAToHl			; $796b
	ld a,(hl)		; $796c
	ld de,$cbb9		; $796d
	ld (de),a		; $7970
	ret			; $7971
	ld e,a			; $7972
	ld e,a			; $7973
	ld e,a			; $7974
	ld de,checkAndUpdateLinkOnChest		; $7975
	ld (bc),a		; $7978
	inc bc			; $7979
	ld bc,$b801		; $797a
	ld (bc),a		; $797d
	add $02			; $797e
	ret z			; $7980
	call $79bb		; $7981
	ld hl,wFrameCounter		; $7984
	ld a,(hl)		; $7987
	and $0f			; $7988
	ld a,$b8		; $798a
	call z,playSound		; $798c
	ld de,$cbb5		; $798f
	ld a,(de)		; $7992
	cp $02			; $7993
	jr z,_label_03_247	; $7995
	ld hl,$cbb4		; $7997
	dec (hl)		; $799a
	jr nz,_label_03_247	; $799b
	inc a			; $799d
	ld (de),a		; $799e
	call $79db		; $799f
_label_03_247:
	add a			; $79a2
	add a			; $79a3
	ld hl,$79e9		; $79a4
	rst_addDoubleIndex			; $79a7
	ld b,$00		; $79a8
	call $79af		; $79aa
	ld b,$01		; $79ad
	ld de,$c486		; $79af
	dec b			; $79b2
	jr nz,_label_03_248	; $79b3
	ld de,$c488		; $79b5
_label_03_248:
	jp $79cd		; $79b8
	ld hl,$c486		; $79bb
	ldh a,(<hCameraY)	; $79be
	ldi (hl),a		; $79c0
	ldh a,(<hCameraX)	; $79c1
	ldi (hl),a		; $79c3
	ld de,$cbb6		; $79c4
	ld a,(de)		; $79c7
	ldi (hl),a		; $79c8
	inc de			; $79c9
	ld a,(de)		; $79ca
	ldi (hl),a		; $79cb
	ret			; $79cc
	push hl			; $79cd
	call getRandomNumber		; $79ce
	and $07			; $79d1
	rst_addAToHl			; $79d3
	ld a,(hl)		; $79d4
	ld b,a			; $79d5
	ld a,(de)		; $79d6
	add b			; $79d7
	ld (de),a		; $79d8
	pop hl			; $79d9
	ret			; $79da
	ld b,a			; $79db
	ld hl,$79e7		; $79dc
	rst_addAToHl			; $79df
	ld a,(hl)		; $79e0
	ld hl,$cbb4		; $79e1
	ld (hl),a		; $79e4
	ld a,b			; $79e5
	ret			; $79e6
	ld e,$14		; $79e7
	nop			; $79e9
	nop			; $79ea
	nop			; $79eb
	nop			; $79ec
	nop			; $79ed
	ld bc,$0000		; $79ee
	nop			; $79f1
	nop			; $79f2
	ld bc,$0000		; $79f3
	nop			; $79f6
	rst $38			; $79f7
	nop			; $79f8
	rst $38			; $79f9
	ld bc,$0100		; $79fa
	nop			; $79fd
	nop			; $79fe
	rst $38			; $79ff
	nop			; $7a00
	ld hl,$cbd5		; $7a01
	ld de,$c485		; $7a04
	ld b,$0c		; $7a07
_label_03_249:
	ld a,(de)		; $7a09
	ldi (hl),a		; $7a0a
	inc e			; $7a0b
	dec b			; $7a0c
	jr nz,_label_03_249	; $7a0d
	call clearOam		; $7a0f
	ld a,$10		; $7a12
	ldh (<hOamTail),a	; $7a14
	ret			; $7a16
	ld hl,$cbd5		; $7a17
	ld de,$c485		; $7a1a
	ld b,$0c		; $7a1d
_label_03_250:
	ldi a,(hl)		; $7a1f
	ld (de),a		; $7a20
	inc e			; $7a21
	dec b			; $7a22
	jr nz,_label_03_250	; $7a23
	ld a,($c485)		; $7a25
	ld ($c497),a		; $7a28
	ld ($ff00+$40),a	; $7a2b
	ret			; $7a2d
	ld hl,$cbba		; $7a2e
	dec (hl)		; $7a31
	ret nz			; $7a32
	ld (hl),$02		; $7a33
	ld hl,$cbb8		; $7a35
	dec (hl)		; $7a38
	jr nz,_label_03_251	; $7a39
	ld (hl),$1f		; $7a3b
	ld hl,$cbb9		; $7a3d
	inc (hl)		; $7a40
	ld a,(hl)		; $7a41
	and $03			; $7a42
	ld (hl),a		; $7a44
	ld hl,$7a5e		; $7a45
	rst_addDoubleIndex			; $7a48
	ldi a,(hl)		; $7a49
	ld h,(hl)		; $7a4a
	ld l,a			; $7a4b
	ld b,h			; $7a4c
	ld c,l			; $7a4d
	ld hl,$de90		; $7a4e
	call func_13c6		; $7a51
	xor a			; $7a54
	ld ($c4ab),a		; $7a55
	ld hl,$cbb8		; $7a58
_label_03_251:
	jp $35ec		; $7a5b
	or b			; $7a5e
	ld c,c			; $7a5f
	stop			; $7a60
	ld c,d			; $7a61
	ld ($ff00+$49),a	; $7a62
	ld b,b			; $7a64
	ld c,d			; $7a65
	ld hl,$cc03		; $7a66
	inc (hl)		; $7a69
	ret			; $7a6a
	ldh (<hFF8B),a	; $7a6b
	ld a,$01		; $7a6d
	ld ($ff00+$4f),a	; $7a6f
	ld hl,$9800		; $7a71
	ld bc,$0400		; $7a74
	ldh a,(<hFF8B)	; $7a77
	call fillMemoryBc		; $7a79
	xor a			; $7a7c
	ld ($ff00+$4f),a	; $7a7d
	ld hl,$9800		; $7a7f
	ld bc,$0400		; $7a82
	jp clearMemoryBc		; $7a85
	ldh (<hFF8B),a	; $7a88
	ld a,($ff00+$70)	; $7a8a
	push af			; $7a8c
	ld a,$04		; $7a8d
	ld ($ff00+$70),a	; $7a8f
	ld hl,$d000		; $7a91
	ld bc,$0240		; $7a94
	call clearMemoryBc		; $7a97
	ld hl,$d400		; $7a9a
	ld bc,$0240		; $7a9d
	ldh a,(<hFF8B)	; $7aa0
	call fillMemoryBc		; $7aa2
	pop af			; $7aa5
	ld ($ff00+$70),a	; $7aa6
	ret			; $7aa8
	ld d,a			; $7aa9
	ld a,b			; $7aaa
	ld e,a			; $7aab
	call disableLcd		; $7aac
	push de			; $7aaf
	ld a,$2f		; $7ab0
	call loadGfxHeader		; $7ab2
	ld a,$0f		; $7ab5
	call loadPaletteHeader		; $7ab7
	ld a,$3b		; $7aba
	call loadPaletteHeader		; $7abc
	pop de			; $7abf
	call getFreeInteractionSlot		; $7ac0
	jr nz,_label_03_252	; $7ac3
	ld (hl),$88		; $7ac5
	inc l			; $7ac7
	ld (hl),e		; $7ac8
_label_03_252:
	ld a,d			; $7ac9
	call loadGfxRegisterStateIndex		; $7aca
	ld hl,$c486		; $7acd
	ldi a,(hl)		; $7ad0
	ldh (<hCameraY),a	; $7ad1
	ld a,(hl)		; $7ad3
	ldh (<hCameraX),a	; $7ad4
	ret			; $7ad6
	call $7add		; $7ad7
	jp updateAllObjects		; $7ada
	ld de,$cc03		; $7add
	ld a,(de)		; $7ae0
	rst_jumpTable			; $7ae1
.DB $fc				; $7ae2
	ld a,d			; $7ae3
	ld b,a			; $7ae4
	ld a,e			; $7ae5
	ld e,c			; $7ae6
	ld a,e			; $7ae7
	ld e,l			; $7ae8
	ld a,e			; $7ae9
	ld a,h			; $7aea
	ld a,e			; $7aeb
	sbc l			; $7aec
	ld a,e			; $7aed
	xor l			; $7aee
	ld a,e			; $7aef
	call nz,$d97b		; $7af0
	ld a,e			; $7af3
	rst $28			; $7af4
	ld a,e			; $7af5
	ld b,h			; $7af6
	ld a,l			; $7af7
	sub e			; $7af8
	ld a,l			; $7af9
	and h			; $7afa
	ld a,l			; $7afb
	ld a,($c4ab)		; $7afc
	or a			; $7aff
	ret nz			; $7b00
	call checkIsLinkedGame		; $7b01
	jr nz,_label_03_253	; $7b04
	ld a,$0a		; $7b06
	ld (de),a		; $7b08
	jp $7d44		; $7b09
_label_03_253:
	ld a,$01		; $7b0c
	ld (de),a		; $7b0e
	ld bc,$059a		; $7b0f
	call $63d2		; $7b12
	ld a,$ac		; $7b15
	call loadPaletteHeader		; $7b17
	ld b,$03		; $7b1a
_label_03_254:
	call getFreeInteractionSlot		; $7b1c
	jr nz,_label_03_255	; $7b1f
	ld (hl),$b0		; $7b21
	inc l			; $7b23
	ld (hl),b		; $7b24
	dec b			; $7b25
	jr nz,_label_03_254	; $7b26
_label_03_255:
	ld a,$1b		; $7b28
	call playSound		; $7b2a
	ld hl,$cbb3		; $7b2d
	ld (hl),$3c		; $7b30
	ld a,$13		; $7b32
	call loadGfxRegisterStateIndex		; $7b34
	ld a,($c48d)		; $7b37
	ldh (<hCameraX),a	; $7b3a
	xor a			; $7b3c
	ldh (<hCameraY),a	; $7b3d
	ld a,$00		; $7b3f
	ld ($cd00),a		; $7b41
	jp $5504		; $7b44
	ld e,$96		; $7b47
_label_03_256:
	call decCbb3		; $7b49
	ret nz			; $7b4c
	call $7a66		; $7b4d
	ld hl,$cbb3		; $7b50
	ld (hl),e		; $7b53
	ld a,$cf		; $7b54
	jp playSound		; $7b56
	ld e,$3c		; $7b59
	jr _label_03_256		; $7b5b
	call decCbb3		; $7b5d
	ret nz			; $7b60
	call $7a66		; $7b61
	call fastFadeinFromBlack		; $7b64
	ld a,$10		; $7b67
	ld ($c4b2),a		; $7b69
	ld ($c4b4),a		; $7b6c
	ld a,$03		; $7b6f
	ld ($c4b1),a		; $7b71
	ld ($c4b3),a		; $7b74
	ld a,$72		; $7b77
	jp playSound		; $7b79
	ld a,($c4ab)		; $7b7c
	or a			; $7b7f
	ret nz			; $7b80
	call $7a66		; $7b81
	ld a,$0e		; $7b84
	ld ($cbb3),a		; $7b86
	call fadeinFromBlack		; $7b89
	ld a,$ef		; $7b8c
	ld ($c4b2),a		; $7b8e
	ld ($c4b4),a		; $7b91
	ld a,$fc		; $7b94
	ld ($c4b1),a		; $7b96
	ld ($c4b3),a		; $7b99
	ret			; $7b9c
	call decCbb3		; $7b9d
	ret nz			; $7ba0
	xor a			; $7ba1
	ld ($c4ab),a		; $7ba2
	ld a,$78		; $7ba5
	ld ($cbb3),a		; $7ba7
	jp $7a66		; $7baa
	call decCbb3		; $7bad
	ret nz			; $7bb0
	call $7a66		; $7bb1
	ld a,$08		; $7bb4
	ld ($cbae),a		; $7bb6
	ld a,$03		; $7bb9
	ld ($cbac),a		; $7bbb
	ld bc,$0c15		; $7bbe
	jp showText		; $7bc1
	call retIfTextIsActive		; $7bc4
	call $7a66		; $7bc7
	ld ($cbb3),a		; $7bca
	dec a			; $7bcd
	ld ($cbba),a		; $7bce
	call restartSound		; $7bd1
	ld a,$bc		; $7bd4
	jp playSound		; $7bd6
	ld hl,$cbb3		; $7bd9
	ld b,$03		; $7bdc
	call func_2d73		; $7bde
	ret z			; $7be1
	call $7a66		; $7be2
	ld a,$3c		; $7be5
	ld ($cbb3),a		; $7be7
	ld a,$02		; $7bea
	jp fadeoutToWhiteWithDelay		; $7bec
	ld a,($c4ab)		; $7bef
	or a			; $7bf2
	ret nz			; $7bf3
	call decCbb3		; $7bf4
	ret nz			; $7bf7
	jp $7a66		; $7bf8
	call $7c01		; $7bfb
	jp updateInteractionsAndDrawAllSprites		; $7bfe
	ld de,$cc03		; $7c01
	ld a,(de)		; $7c04
	rst_jumpTable			; $7c05
	ld d,$7c		; $7c06
	scf			; $7c08
	ld a,h			; $7c09
	ld c,e			; $7c0a
	ld a,h			; $7c0b
	xor c			; $7c0c
	ld a,h			; $7c0d
	push de			; $7c0e
	ld a,h			; $7c0f
	ld a,($ff00+$7c)	; $7c10
	ld c,$7d		; $7c12
	rra			; $7c14
	ld a,l			; $7c15
	ld a,($c4ab)		; $7c16
	or a			; $7c19
	ret nz			; $7c1a
	call hideStatusBar		; $7c1b
	call clearDynamicInteractions		; $7c1e
	ld a,$fa		; $7c21
	call playSound		; $7c23
	ld hl,$cbb3		; $7c26
	ld (hl),$3c		; $7c29
	ld hl,$d01a		; $7c2b
	res 7,(hl)		; $7c2e
	xor a			; $7c30
	ld ($cfc0),a		; $7c31
	jp $7a66		; $7c34
	call decCbb3		; $7c37
	ret nz			; $7c3a
	ld (hl),$14		; $7c3b
	call $7a66		; $7c3d
	ld hl,$cbae		; $7c40
	ld (hl),$04		; $7c43
	ld bc,$1719		; $7c45
	jp showText		; $7c48
	call retIfTextIsActive		; $7c4b
	call decCbb3		; $7c4e
	ret nz			; $7c51
	call disableLcd		; $7c52
	call getFreeInteractionSlot		; $7c55
	jr nz,_label_03_257	; $7c58
	ld a,$a5		; $7c5a
	ld ($cc1d),a		; $7c5c
	ldi (hl),a		; $7c5f
	ld (hl),$06		; $7c60
	call refreshObjectGfx		; $7c62
_label_03_257:
	xor a			; $7c65
	ld ($cd08),a		; $7c66
	ld ($cd09),a		; $7c69
	ld a,$2e		; $7c6c
	call loadGfxHeader		; $7c6e
	ld a,$97		; $7c71
	call loadPaletteHeader		; $7c73
	ld a,$01		; $7c76
	ld ($cd00),a		; $7c78
	ld a,$18		; $7c7b
	ld ($cd25),a		; $7c7d
	call loadAnimationData		; $7c80
	ld a,$0d		; $7c83
	call loadGfxRegisterStateIndex		; $7c85
	ld hl,$c486		; $7c88
	ldi a,(hl)		; $7c8b
	ldh (<hCameraY),a	; $7c8c
	ld a,(hl)		; $7c8e
	ldh (<hCameraX),a	; $7c8f
	ld a,$18		; $7c91
	ld ($cd25),a		; $7c93
	call loadAnimationData		; $7c96
	xor a			; $7c99
	ld ($cbb3),a		; $7c9a
	dec a			; $7c9d
	ld ($cbba),a		; $7c9e
	ld a,$d2		; $7ca1
	call playSound		; $7ca3
	jp $7a66		; $7ca6
	ld hl,$cbb3		; $7ca9
	ld b,$01		; $7cac
	call func_2d73		; $7cae
	ret z			; $7cb1
	xor a			; $7cb2
	ldh (<hFF8B),a	; $7cb3
	ld a,$f0		; $7cb5
	ld c,a			; $7cb7
	ld ($c4ae),a		; $7cb8
	call $35cc		; $7cbb
	ld a,$ff		; $7cbe
	ldh (<hDirtyBgPalettes),a	; $7cc0
	ldh (<hDirtySprPalettes),a	; $7cc2
	ldh (<hBgPaletteSources),a	; $7cc4
	ldh (<hSprPaletteSources),a	; $7cc6
	ld hl,$cbb3		; $7cc8
	ld (hl),$3c		; $7ccb
	ld a,$21		; $7ccd
	call playSound		; $7ccf
	jp $7a66		; $7cd2
	call decCbb3		; $7cd5
	ret nz			; $7cd8
	ld (hl),$3c		; $7cd9
	call brightenRoom		; $7cdb
	ld a,$ff		; $7cde
	ld ($c4b2),a		; $7ce0
	ld ($c4b4),a		; $7ce3
	xor a			; $7ce6
	ld ($c4b1),a		; $7ce7
	ld ($c4b3),a		; $7cea
	jp $7a66		; $7ced
	ld a,($c4ab)		; $7cf0
	or a			; $7cf3
	ret nz			; $7cf4
	call decCbb3		; $7cf5
	ret nz			; $7cf8
	ld (hl),$5a		; $7cf9
	ld a,$f0		; $7cfb
	ld ($c4ae),a		; $7cfd
	call brightenRoom		; $7d00
	ld a,$ff		; $7d03
	ld ($c4b1),a		; $7d05
	ld ($c4b3),a		; $7d08
	jp $7a66		; $7d0b
	call decCbb3		; $7d0e
	ret nz			; $7d11
	call getFreeInteractionSlot		; $7d12
	jr nz,_label_03_258	; $7d15
	ld (hl),$4f		; $7d17
	inc l			; $7d19
	ld (hl),$05		; $7d1a
_label_03_258:
	jp $7a66		; $7d1c
	ld a,($cfc0)		; $7d1f
	or a			; $7d22
	ret z			; $7d23
	call showStatusBar		; $7d24
	ld a,$fa		; $7d27
	call playSound		; $7d29
	xor a			; $7d2c
	ld ($cc66),a		; $7d2d
	ld a,$82		; $7d30
	ld ($cc63),a		; $7d32
	ld a,$5d		; $7d35
	ld ($cc64),a		; $7d37
	xor a			; $7d3a
	ld ($cc65),a		; $7d3b
	ld a,$03		; $7d3e
	ld ($cc67),a		; $7d40
	ret			; $7d43
	call disableLcd		; $7d44
	ld a,($ff00+$70)	; $7d47
	push af			; $7d49
	ld a,$02		; $7d4a
	ld ($ff00+$70),a	; $7d4c
	ld hl,$de80		; $7d4e
	ld b,$40		; $7d51
	call clearMemory		; $7d53
	pop af			; $7d56
	ld ($ff00+$70),a	; $7d57
	call clearScreenVariablesAndWramBank1		; $7d59
	call clearOam		; $7d5c
	ld a,$0f		; $7d5f
	call loadPaletteHeader		; $7d61
	ld a,$02		; $7d64
	call $7a6b		; $7d66
	call $7db8		; $7d69
	ld a,$0d		; $7d6c
	call playSound		; $7d6e
	ld a,$08		; $7d71
	call setLinkID		; $7d73
	ld l,$00		; $7d76
	ld (hl),$01		; $7d78
	ld l,$02		; $7d7a
	ld (hl),$0a		; $7d7c
	ld a,$00		; $7d7e
	ld ($cd00),a		; $7d80
	call $7a66		; $7d83
	call clearPaletteFadeVariablesAndRefreshPalettes		; $7d86
	xor a			; $7d89
	ldh (<hCameraY),a	; $7d8a
	ldh (<hCameraX),a	; $7d8c
	ld a,$15		; $7d8e
	jp loadGfxRegisterStateIndex		; $7d90
	ld a,($cbb9)		; $7d93
	cp $07			; $7d96
	ret nz			; $7d98
	call clearLinkObject		; $7d99
	ld hl,$cbb3		; $7d9c
	ld (hl),$3c		; $7d9f
	jp $7a66		; $7da1
	call decCbb3		; $7da4
	ret nz			; $7da7
	ld hl,$c2ee		; $7da8
	xor a			; $7dab
	ldi (hl),a		; $7dac
	ld (hl),a		; $7dad
	ld a,$f0		; $7dae
	call playSound		; $7db0
	ld a,$2a		; $7db3
	jp setGlobalFlag		; $7db5
	ld a,($ff00+$70)	; $7db8
	push af			; $7dba
	ld a,$03		; $7dbb
	ld ($ff00+$70),a	; $7dbd
	ld hl,$d800		; $7dbf
	ld bc,$0240		; $7dc2
	call clearMemoryBc		; $7dc5
	ld hl,$dc00		; $7dc8
	ld bc,$0240		; $7dcb
	ld a,$02		; $7dce
	call fillMemoryBc		; $7dd0
	pop af			; $7dd3
	ld ($ff00+$70),a	; $7dd4
	ret			; $7dd6

.BANK $04 SLOT 1
.ORG 0

	ld h,b			; $4000
	ld l,e			; $4001
	ld b,$04		; $4002
_label_04_000:
	ld e,$00		; $4004
	ldi a,(hl)		; $4006
	ld (de),a		; $4007
	ld e,$20		; $4008
	ldi a,(hl)		; $400a
	ld (de),a		; $400b
	ld e,$40		; $400c
	ldi a,(hl)		; $400e
	ld (de),a		; $400f
	ld e,$60		; $4010
	ldi a,(hl)		; $4012
	ld (de),a		; $4013
	ld e,$80		; $4014
	ldi a,(hl)		; $4016
	ld (de),a		; $4017
	ld e,$a0		; $4018
	ldi a,(hl)		; $401a
	ld (de),a		; $401b
	ld e,$c0		; $401c
	ldi a,(hl)		; $401e
	ld (de),a		; $401f
	ld e,$e0		; $4020
	ldi a,(hl)		; $4022
	ld (de),a		; $4023
	inc d			; $4024
	dec b			; $4025
	jr nz,_label_04_000	; $4026
	ld l,c			; $4028
	ld h,$c4		; $4029
	jp vblankFunctionRet		; $402b
	ld h,b			; $402e
	ld l,e			; $402f
	ld b,$04		; $4030
_label_04_001:
	ld e,$01		; $4032
	ldi a,(hl)		; $4034
	ld (de),a		; $4035
	ld e,$21		; $4036
	ldi a,(hl)		; $4038
	ld (de),a		; $4039
	ld e,$41		; $403a
	ldi a,(hl)		; $403c
	ld (de),a		; $403d
	ld e,$61		; $403e
	ldi a,(hl)		; $4040
	ld (de),a		; $4041
	ld e,$81		; $4042
	ldi a,(hl)		; $4044
	ld (de),a		; $4045
	ld e,$a1		; $4046
	ldi a,(hl)		; $4048
	ld (de),a		; $4049
	ld e,$c1		; $404a
	ldi a,(hl)		; $404c
	ld (de),a		; $404d
	ld e,$e1		; $404e
	ldi a,(hl)		; $4050
	ld (de),a		; $4051
	inc d			; $4052
	dec b			; $4053
	jr nz,_label_04_001	; $4054
	ld l,c			; $4056
	ld h,$c4		; $4057
	jp vblankFunctionRet		; $4059
	ld h,b			; $405c
	ld l,e			; $405d
	ld b,$04		; $405e
_label_04_002:
	ld e,$02		; $4060
	ldi a,(hl)		; $4062
	ld (de),a		; $4063
	ld e,$22		; $4064
	ldi a,(hl)		; $4066
	ld (de),a		; $4067
	ld e,$42		; $4068
	ldi a,(hl)		; $406a
	ld (de),a		; $406b
	ld e,$62		; $406c
	ldi a,(hl)		; $406e
	ld (de),a		; $406f
	ld e,$82		; $4070
	ldi a,(hl)		; $4072
	ld (de),a		; $4073
	ld e,$a2		; $4074
	ldi a,(hl)		; $4076
	ld (de),a		; $4077
	ld e,$c2		; $4078
	ldi a,(hl)		; $407a
	ld (de),a		; $407b
	ld e,$e2		; $407c
	ldi a,(hl)		; $407e
	ld (de),a		; $407f
	inc d			; $4080
	dec b			; $4081
	jr nz,_label_04_002	; $4082
	ld l,c			; $4084
	ld h,$c4		; $4085
	jp vblankFunctionRet		; $4087
	ld h,b			; $408a
	ld l,e			; $408b
	ld b,$04		; $408c
_label_04_003:
	ld e,$03		; $408e
	ldi a,(hl)		; $4090
	ld (de),a		; $4091
	ld e,$23		; $4092
	ldi a,(hl)		; $4094
	ld (de),a		; $4095
	ld e,$43		; $4096
	ldi a,(hl)		; $4098
	ld (de),a		; $4099
	ld e,$63		; $409a
	ldi a,(hl)		; $409c
	ld (de),a		; $409d
	ld e,$83		; $409e
	ldi a,(hl)		; $40a0
	ld (de),a		; $40a1
	ld e,$a3		; $40a2
	ldi a,(hl)		; $40a4
	ld (de),a		; $40a5
	ld e,$c3		; $40a6
	ldi a,(hl)		; $40a8
	ld (de),a		; $40a9
	ld e,$e3		; $40aa
	ldi a,(hl)		; $40ac
	ld (de),a		; $40ad
	inc d			; $40ae
	dec b			; $40af
	jr nz,_label_04_003	; $40b0
	ld l,c			; $40b2
	ld h,$c4		; $40b3
	jp vblankFunctionRet		; $40b5
	ld h,b			; $40b8
	ld l,e			; $40b9
	ld b,$04		; $40ba
_label_04_004:
	ld e,$04		; $40bc
	ldi a,(hl)		; $40be
	ld (de),a		; $40bf
	ld e,$24		; $40c0
	ldi a,(hl)		; $40c2
	ld (de),a		; $40c3
	ld e,$44		; $40c4
	ldi a,(hl)		; $40c6
	ld (de),a		; $40c7
	ld e,$64		; $40c8
	ldi a,(hl)		; $40ca
	ld (de),a		; $40cb
	ld e,$84		; $40cc
	ldi a,(hl)		; $40ce
	ld (de),a		; $40cf
	ld e,$a4		; $40d0
	ldi a,(hl)		; $40d2
	ld (de),a		; $40d3
	ld e,$c4		; $40d4
	ldi a,(hl)		; $40d6
	ld (de),a		; $40d7
	ld e,$e4		; $40d8
	ldi a,(hl)		; $40da
	ld (de),a		; $40db
	inc d			; $40dc
	dec b			; $40dd
	jr nz,_label_04_004	; $40de
	ld l,c			; $40e0
	ld h,$c4		; $40e1
	jp vblankFunctionRet		; $40e3
	ld h,b			; $40e6
	ld l,e			; $40e7
	ld b,$04		; $40e8
_label_04_005:
	ld e,$05		; $40ea
	ldi a,(hl)		; $40ec
	ld (de),a		; $40ed
	ld e,$25		; $40ee
	ldi a,(hl)		; $40f0
	ld (de),a		; $40f1
	ld e,$45		; $40f2
	ldi a,(hl)		; $40f4
	ld (de),a		; $40f5
	ld e,$65		; $40f6
	ldi a,(hl)		; $40f8
	ld (de),a		; $40f9
	ld e,$85		; $40fa
	ldi a,(hl)		; $40fc
	ld (de),a		; $40fd
	ld e,$a5		; $40fe
	ldi a,(hl)		; $4100
	ld (de),a		; $4101
	ld e,$c5		; $4102
	ldi a,(hl)		; $4104
	ld (de),a		; $4105
	ld e,$e5		; $4106
	ldi a,(hl)		; $4108
	ld (de),a		; $4109
	inc d			; $410a
	dec b			; $410b
	jr nz,_label_04_005	; $410c
	ld l,c			; $410e
	ld h,$c4		; $410f
	jp vblankFunctionRet		; $4111
	ld h,b			; $4114
	ld l,e			; $4115
	ld b,$04		; $4116
_label_04_006:
	ld e,$06		; $4118
	ldi a,(hl)		; $411a
	ld (de),a		; $411b
	ld e,$26		; $411c
	ldi a,(hl)		; $411e
	ld (de),a		; $411f
	ld e,$46		; $4120
	ldi a,(hl)		; $4122
	ld (de),a		; $4123
	ld e,$66		; $4124
	ldi a,(hl)		; $4126
	ld (de),a		; $4127
	ld e,$86		; $4128
	ldi a,(hl)		; $412a
	ld (de),a		; $412b
	ld e,$a6		; $412c
	ldi a,(hl)		; $412e
	ld (de),a		; $412f
	ld e,$c6		; $4130
	ldi a,(hl)		; $4132
	ld (de),a		; $4133
	ld e,$e6		; $4134
	ldi a,(hl)		; $4136
	ld (de),a		; $4137
	inc d			; $4138
	dec b			; $4139
	jr nz,_label_04_006	; $413a
	ld l,c			; $413c
	ld h,$c4		; $413d
	jp vblankFunctionRet		; $413f
	ld h,b			; $4142
	ld l,e			; $4143
	ld b,$04		; $4144
_label_04_007:
	ld e,$07		; $4146
	ldi a,(hl)		; $4148
	ld (de),a		; $4149
	ld e,$27		; $414a
	ldi a,(hl)		; $414c
	ld (de),a		; $414d
	ld e,$47		; $414e
	ldi a,(hl)		; $4150
	ld (de),a		; $4151
	ld e,$67		; $4152
	ldi a,(hl)		; $4154
	ld (de),a		; $4155
	ld e,$87		; $4156
	ldi a,(hl)		; $4158
	ld (de),a		; $4159
	ld e,$a7		; $415a
	ldi a,(hl)		; $415c
	ld (de),a		; $415d
	ld e,$c7		; $415e
	ldi a,(hl)		; $4160
	ld (de),a		; $4161
	ld e,$e7		; $4162
	ldi a,(hl)		; $4164
	ld (de),a		; $4165
	inc d			; $4166
	dec b			; $4167
	jr nz,_label_04_007	; $4168
	ld l,c			; $416a
	ld h,$c4		; $416b
	jp vblankFunctionRet		; $416d
	ld h,b			; $4170
	ld l,e			; $4171
	ld b,$04		; $4172
_label_04_008:
	ld e,$08		; $4174
	ldi a,(hl)		; $4176
	ld (de),a		; $4177
	ld e,$28		; $4178
	ldi a,(hl)		; $417a
	ld (de),a		; $417b
	ld e,$48		; $417c
	ldi a,(hl)		; $417e
	ld (de),a		; $417f
	ld e,$68		; $4180
	ldi a,(hl)		; $4182
	ld (de),a		; $4183
	ld e,$88		; $4184
	ldi a,(hl)		; $4186
	ld (de),a		; $4187
	ld e,$a8		; $4188
	ldi a,(hl)		; $418a
	ld (de),a		; $418b
	ld e,$c8		; $418c
	ldi a,(hl)		; $418e
	ld (de),a		; $418f
	ld e,$e8		; $4190
	ldi a,(hl)		; $4192
	ld (de),a		; $4193
	inc d			; $4194
	dec b			; $4195
	jr nz,_label_04_008	; $4196
	ld l,c			; $4198
	ld h,$c4		; $4199
	jp vblankFunctionRet		; $419b
	ld h,b			; $419e
	ld l,e			; $419f
	ld b,$04		; $41a0
_label_04_009:
	ld e,$09		; $41a2
	ldi a,(hl)		; $41a4
	ld (de),a		; $41a5
	ld e,$29		; $41a6
	ldi a,(hl)		; $41a8
	ld (de),a		; $41a9
	ld e,$49		; $41aa
	ldi a,(hl)		; $41ac
	ld (de),a		; $41ad
	ld e,$69		; $41ae
	ldi a,(hl)		; $41b0
	ld (de),a		; $41b1
	ld e,$89		; $41b2
	ldi a,(hl)		; $41b4
	ld (de),a		; $41b5
	ld e,$a9		; $41b6
	ldi a,(hl)		; $41b8
	ld (de),a		; $41b9
	ld e,$c9		; $41ba
	ldi a,(hl)		; $41bc
	ld (de),a		; $41bd
	ld e,$e9		; $41be
	ldi a,(hl)		; $41c0
	ld (de),a		; $41c1
	inc d			; $41c2
	dec b			; $41c3
	jr nz,_label_04_009	; $41c4
	ld l,c			; $41c6
	ld h,$c4		; $41c7
	jp vblankFunctionRet		; $41c9
	ld h,b			; $41cc
	ld l,e			; $41cd
	ld b,$04		; $41ce
_label_04_010:
	ld e,$0a		; $41d0
	ldi a,(hl)		; $41d2
	ld (de),a		; $41d3
	ld e,$2a		; $41d4
	ldi a,(hl)		; $41d6
	ld (de),a		; $41d7
	ld e,$4a		; $41d8
	ldi a,(hl)		; $41da
	ld (de),a		; $41db
	ld e,$6a		; $41dc
	ldi a,(hl)		; $41de
	ld (de),a		; $41df
	ld e,$8a		; $41e0
	ldi a,(hl)		; $41e2
	ld (de),a		; $41e3
	ld e,$aa		; $41e4
	ldi a,(hl)		; $41e6
	ld (de),a		; $41e7
	ld e,$ca		; $41e8
	ldi a,(hl)		; $41ea
	ld (de),a		; $41eb
	ld e,$ea		; $41ec
	ldi a,(hl)		; $41ee
	ld (de),a		; $41ef
	inc d			; $41f0
	dec b			; $41f1
	jr nz,_label_04_010	; $41f2
	ld l,c			; $41f4
	ld h,$c4		; $41f5
	jp vblankFunctionRet		; $41f7
	ld h,b			; $41fa
	ld l,e			; $41fb
	ld b,$04		; $41fc
_label_04_011:
	ld e,$0b		; $41fe
	ldi a,(hl)		; $4200
	ld (de),a		; $4201
	ld e,$2b		; $4202
	ldi a,(hl)		; $4204
	ld (de),a		; $4205
	ld e,$4b		; $4206
	ldi a,(hl)		; $4208
	ld (de),a		; $4209
	ld e,$6b		; $420a
	ldi a,(hl)		; $420c
	ld (de),a		; $420d
	ld e,$8b		; $420e
	ldi a,(hl)		; $4210
	ld (de),a		; $4211
	ld e,$ab		; $4212
	ldi a,(hl)		; $4214
	ld (de),a		; $4215
	ld e,$cb		; $4216
	ldi a,(hl)		; $4218
	ld (de),a		; $4219
	ld e,$eb		; $421a
	ldi a,(hl)		; $421c
	ld (de),a		; $421d
	inc d			; $421e
	dec b			; $421f
	jr nz,_label_04_011	; $4220
	ld l,c			; $4222
	ld h,$c4		; $4223
	jp vblankFunctionRet		; $4225
	ld h,b			; $4228
	ld l,e			; $4229
	ld b,$04		; $422a
_label_04_012:
	ld e,$0c		; $422c
	ldi a,(hl)		; $422e
	ld (de),a		; $422f
	ld e,$2c		; $4230
	ldi a,(hl)		; $4232
	ld (de),a		; $4233
	ld e,$4c		; $4234
	ldi a,(hl)		; $4236
	ld (de),a		; $4237
	ld e,$6c		; $4238
	ldi a,(hl)		; $423a
	ld (de),a		; $423b
	ld e,$8c		; $423c
	ldi a,(hl)		; $423e
	ld (de),a		; $423f
	ld e,$ac		; $4240
	ldi a,(hl)		; $4242
	ld (de),a		; $4243
	ld e,$cc		; $4244
	ldi a,(hl)		; $4246
	ld (de),a		; $4247
	ld e,$ec		; $4248
	ldi a,(hl)		; $424a
	ld (de),a		; $424b
	inc d			; $424c
	dec b			; $424d
	jr nz,_label_04_012	; $424e
	ld l,c			; $4250
	ld h,$c4		; $4251
	jp vblankFunctionRet		; $4253
	ld h,b			; $4256
	ld l,e			; $4257
	ld b,$04		; $4258
_label_04_013:
	ld e,$0d		; $425a
	ldi a,(hl)		; $425c
	ld (de),a		; $425d
	ld e,$2d		; $425e
	ldi a,(hl)		; $4260
	ld (de),a		; $4261
	ld e,$4d		; $4262
	ldi a,(hl)		; $4264
	ld (de),a		; $4265
	ld e,$6d		; $4266
	ldi a,(hl)		; $4268
	ld (de),a		; $4269
	ld e,$8d		; $426a
	ldi a,(hl)		; $426c
	ld (de),a		; $426d
	ld e,$ad		; $426e
	ldi a,(hl)		; $4270
	ld (de),a		; $4271
	ld e,$cd		; $4272
	ldi a,(hl)		; $4274
	ld (de),a		; $4275
	ld e,$ed		; $4276
	ldi a,(hl)		; $4278
	ld (de),a		; $4279
	inc d			; $427a
	dec b			; $427b
	jr nz,_label_04_013	; $427c
	ld l,c			; $427e
	ld h,$c4		; $427f
	jp vblankFunctionRet		; $4281
	ld h,b			; $4284
	ld l,e			; $4285
	ld b,$04		; $4286
_label_04_014:
	ld e,$0e		; $4288
	ldi a,(hl)		; $428a
	ld (de),a		; $428b
	ld e,$2e		; $428c
	ldi a,(hl)		; $428e
	ld (de),a		; $428f
	ld e,$4e		; $4290
	ldi a,(hl)		; $4292
	ld (de),a		; $4293
	ld e,$6e		; $4294
	ldi a,(hl)		; $4296
	ld (de),a		; $4297
	ld e,$8e		; $4298
	ldi a,(hl)		; $429a
	ld (de),a		; $429b
	ld e,$ae		; $429c
	ldi a,(hl)		; $429e
	ld (de),a		; $429f
	ld e,$ce		; $42a0
	ldi a,(hl)		; $42a2
	ld (de),a		; $42a3
	ld e,$ee		; $42a4
	ldi a,(hl)		; $42a6
	ld (de),a		; $42a7
	inc d			; $42a8
	dec b			; $42a9
	jr nz,_label_04_014	; $42aa
	ld l,c			; $42ac
	ld h,$c4		; $42ad
	jp vblankFunctionRet		; $42af
	ld h,b			; $42b2
	ld l,e			; $42b3
	ld b,$04		; $42b4
_label_04_015:
	ld e,$0f		; $42b6
	ldi a,(hl)		; $42b8
	ld (de),a		; $42b9
	ld e,$2f		; $42ba
	ldi a,(hl)		; $42bc
	ld (de),a		; $42bd
	ld e,$4f		; $42be
	ldi a,(hl)		; $42c0
	ld (de),a		; $42c1
	ld e,$6f		; $42c2
	ldi a,(hl)		; $42c4
	ld (de),a		; $42c5
	ld e,$8f		; $42c6
	ldi a,(hl)		; $42c8
	ld (de),a		; $42c9
	ld e,$af		; $42ca
	ldi a,(hl)		; $42cc
	ld (de),a		; $42cd
	ld e,$cf		; $42ce
	ldi a,(hl)		; $42d0
	ld (de),a		; $42d1
	ld e,$ef		; $42d2
	ldi a,(hl)		; $42d4
	ld (de),a		; $42d5
	inc d			; $42d6
	dec b			; $42d7
	jr nz,_label_04_015	; $42d8
	ld l,c			; $42da
	ld h,$c4		; $42db
	jp vblankFunctionRet		; $42dd
	ld h,b			; $42e0
	ld l,e			; $42e1
	ld b,$04		; $42e2
_label_04_016:
	ld e,$10		; $42e4
	ldi a,(hl)		; $42e6
	ld (de),a		; $42e7
	ld e,$30		; $42e8
	ldi a,(hl)		; $42ea
	ld (de),a		; $42eb
	ld e,$50		; $42ec
	ldi a,(hl)		; $42ee
	ld (de),a		; $42ef
	ld e,$70		; $42f0
	ldi a,(hl)		; $42f2
	ld (de),a		; $42f3
	ld e,$90		; $42f4
	ldi a,(hl)		; $42f6
	ld (de),a		; $42f7
	ld e,$b0		; $42f8
	ldi a,(hl)		; $42fa
	ld (de),a		; $42fb
	ld e,$d0		; $42fc
	ldi a,(hl)		; $42fe
	ld (de),a		; $42ff
	ld e,$f0		; $4300
	ldi a,(hl)		; $4302
	ld (de),a		; $4303
	inc d			; $4304
	dec b			; $4305
	jr nz,_label_04_016	; $4306
	ld l,c			; $4308
	ld h,$c4		; $4309
	jp vblankFunctionRet		; $430b
	ld h,b			; $430e
	ld l,e			; $430f
	ld b,$04		; $4310
_label_04_017:
	ld e,$11		; $4312
	ldi a,(hl)		; $4314
	ld (de),a		; $4315
	ld e,$31		; $4316
	ldi a,(hl)		; $4318
	ld (de),a		; $4319
	ld e,$51		; $431a
	ldi a,(hl)		; $431c
	ld (de),a		; $431d
	ld e,$71		; $431e
	ldi a,(hl)		; $4320
	ld (de),a		; $4321
	ld e,$91		; $4322
	ldi a,(hl)		; $4324
	ld (de),a		; $4325
	ld e,$b1		; $4326
	ldi a,(hl)		; $4328
	ld (de),a		; $4329
	ld e,$d1		; $432a
	ldi a,(hl)		; $432c
	ld (de),a		; $432d
	ld e,$f1		; $432e
	ldi a,(hl)		; $4330
	ld (de),a		; $4331
	inc d			; $4332
	dec b			; $4333
	jr nz,_label_04_017	; $4334
	ld l,c			; $4336
	ld h,$c4		; $4337
	jp vblankFunctionRet		; $4339
	ld h,b			; $433c
	ld l,e			; $433d
	ld b,$04		; $433e
_label_04_018:
	ld e,$12		; $4340
	ldi a,(hl)		; $4342
	ld (de),a		; $4343
	ld e,$32		; $4344
	ldi a,(hl)		; $4346
	ld (de),a		; $4347
	ld e,$52		; $4348
	ldi a,(hl)		; $434a
	ld (de),a		; $434b
	ld e,$72		; $434c
	ldi a,(hl)		; $434e
	ld (de),a		; $434f
	ld e,$92		; $4350
	ldi a,(hl)		; $4352
	ld (de),a		; $4353
	ld e,$b2		; $4354
	ldi a,(hl)		; $4356
	ld (de),a		; $4357
	ld e,$d2		; $4358
	ldi a,(hl)		; $435a
	ld (de),a		; $435b
	ld e,$f2		; $435c
	ldi a,(hl)		; $435e
	ld (de),a		; $435f
	inc d			; $4360
	dec b			; $4361
	jr nz,_label_04_018	; $4362
	ld l,c			; $4364
	ld h,$c4		; $4365
	jp vblankFunctionRet		; $4367
	ld h,b			; $436a
	ld l,e			; $436b
	ld b,$04		; $436c
_label_04_019:
	ld e,$13		; $436e
	ldi a,(hl)		; $4370
	ld (de),a		; $4371
	ld e,$33		; $4372
	ldi a,(hl)		; $4374
	ld (de),a		; $4375
	ld e,$53		; $4376
	ldi a,(hl)		; $4378
	ld (de),a		; $4379
	ld e,$73		; $437a
	ldi a,(hl)		; $437c
	ld (de),a		; $437d
	ld e,$93		; $437e
	ldi a,(hl)		; $4380
	ld (de),a		; $4381
	ld e,$b3		; $4382
	ldi a,(hl)		; $4384
	ld (de),a		; $4385
	ld e,$d3		; $4386
	ldi a,(hl)		; $4388
	ld (de),a		; $4389
	ld e,$f3		; $438a
	ldi a,(hl)		; $438c
	ld (de),a		; $438d
	inc d			; $438e
	dec b			; $438f
	jr nz,_label_04_019	; $4390
	ld l,c			; $4392
	ld h,$c4		; $4393
	jp vblankFunctionRet		; $4395
	ld h,b			; $4398
	ld l,e			; $4399
	ld b,$04		; $439a
_label_04_020:
	ld e,$14		; $439c
	ldi a,(hl)		; $439e
	ld (de),a		; $439f
	ld e,$34		; $43a0
	ldi a,(hl)		; $43a2
	ld (de),a		; $43a3
	ld e,$54		; $43a4
	ldi a,(hl)		; $43a6
	ld (de),a		; $43a7
	ld e,$74		; $43a8
	ldi a,(hl)		; $43aa
	ld (de),a		; $43ab
	ld e,$94		; $43ac
	ldi a,(hl)		; $43ae
	ld (de),a		; $43af
	ld e,$b4		; $43b0
	ldi a,(hl)		; $43b2
	ld (de),a		; $43b3
	ld e,$d4		; $43b4
	ldi a,(hl)		; $43b6
	ld (de),a		; $43b7
	ld e,$f4		; $43b8
	ldi a,(hl)		; $43ba
	ld (de),a		; $43bb
	inc d			; $43bc
	dec b			; $43bd
	jr nz,_label_04_020	; $43be
	ld l,c			; $43c0
	ld h,$c4		; $43c1
	jp vblankFunctionRet		; $43c3
	ld h,b			; $43c6
	ld l,e			; $43c7
	ld b,$04		; $43c8
_label_04_021:
	ld e,$15		; $43ca
	ldi a,(hl)		; $43cc
	ld (de),a		; $43cd
	ld e,$35		; $43ce
	ldi a,(hl)		; $43d0
	ld (de),a		; $43d1
	ld e,$55		; $43d2
	ldi a,(hl)		; $43d4
	ld (de),a		; $43d5
	ld e,$75		; $43d6
	ldi a,(hl)		; $43d8
	ld (de),a		; $43d9
	ld e,$95		; $43da
	ldi a,(hl)		; $43dc
	ld (de),a		; $43dd
	ld e,$b5		; $43de
	ldi a,(hl)		; $43e0
	ld (de),a		; $43e1
	ld e,$d5		; $43e2
	ldi a,(hl)		; $43e4
	ld (de),a		; $43e5
	ld e,$f5		; $43e6
	ldi a,(hl)		; $43e8
	ld (de),a		; $43e9
	inc d			; $43ea
	dec b			; $43eb
	jr nz,_label_04_021	; $43ec
	ld l,c			; $43ee
	ld h,$c4		; $43ef
	jp vblankFunctionRet		; $43f1
	ld h,b			; $43f4
	ld l,e			; $43f5
	ld b,$04		; $43f6
_label_04_022:
	ld e,$16		; $43f8
	ldi a,(hl)		; $43fa
	ld (de),a		; $43fb
	ld e,$36		; $43fc
	ldi a,(hl)		; $43fe
	ld (de),a		; $43ff
	ld e,$56		; $4400
	ldi a,(hl)		; $4402
	ld (de),a		; $4403
	ld e,$76		; $4404
	ldi a,(hl)		; $4406
	ld (de),a		; $4407
	ld e,$96		; $4408
	ldi a,(hl)		; $440a
	ld (de),a		; $440b
	ld e,$b6		; $440c
	ldi a,(hl)		; $440e
	ld (de),a		; $440f
	ld e,$d6		; $4410
	ldi a,(hl)		; $4412
	ld (de),a		; $4413
	ld e,$f6		; $4414
	ldi a,(hl)		; $4416
	ld (de),a		; $4417
	inc d			; $4418
	dec b			; $4419
	jr nz,_label_04_022	; $441a
	ld l,c			; $441c
	ld h,$c4		; $441d
	jp vblankFunctionRet		; $441f
	ld h,b			; $4422
	ld l,e			; $4423
	ld b,$04		; $4424
_label_04_023:
	ld e,$17		; $4426
	ldi a,(hl)		; $4428
	ld (de),a		; $4429
	ld e,$37		; $442a
	ldi a,(hl)		; $442c
	ld (de),a		; $442d
	ld e,$57		; $442e
	ldi a,(hl)		; $4430
	ld (de),a		; $4431
	ld e,$77		; $4432
	ldi a,(hl)		; $4434
	ld (de),a		; $4435
	ld e,$97		; $4436
	ldi a,(hl)		; $4438
	ld (de),a		; $4439
	ld e,$b7		; $443a
	ldi a,(hl)		; $443c
	ld (de),a		; $443d
	ld e,$d7		; $443e
	ldi a,(hl)		; $4440
	ld (de),a		; $4441
	ld e,$f7		; $4442
	ldi a,(hl)		; $4444
	ld (de),a		; $4445
	inc d			; $4446
	dec b			; $4447
	jr nz,_label_04_023	; $4448
	ld l,c			; $444a
	ld h,$c4		; $444b
	jp vblankFunctionRet		; $444d
	ld h,b			; $4450
	ld l,e			; $4451
	ld b,$04		; $4452
_label_04_024:
	ld e,$18		; $4454
	ldi a,(hl)		; $4456
	ld (de),a		; $4457
	ld e,$38		; $4458
	ldi a,(hl)		; $445a
	ld (de),a		; $445b
	ld e,$58		; $445c
	ldi a,(hl)		; $445e
	ld (de),a		; $445f
	ld e,$78		; $4460
	ldi a,(hl)		; $4462
	ld (de),a		; $4463
	ld e,$98		; $4464
	ldi a,(hl)		; $4466
	ld (de),a		; $4467
	ld e,$b8		; $4468
	ldi a,(hl)		; $446a
	ld (de),a		; $446b
	ld e,$d8		; $446c
	ldi a,(hl)		; $446e
	ld (de),a		; $446f
	ld e,$f8		; $4470
	ldi a,(hl)		; $4472
	ld (de),a		; $4473
	inc d			; $4474
	dec b			; $4475
	jr nz,_label_04_024	; $4476
	ld l,c			; $4478
	ld h,$c4		; $4479
	jp vblankFunctionRet		; $447b
	ld h,b			; $447e
	ld l,e			; $447f
	ld b,$04		; $4480
_label_04_025:
	ld e,$19		; $4482
	ldi a,(hl)		; $4484
	ld (de),a		; $4485
	ld e,$39		; $4486
	ldi a,(hl)		; $4488
	ld (de),a		; $4489
	ld e,$59		; $448a
	ldi a,(hl)		; $448c
	ld (de),a		; $448d
	ld e,$79		; $448e
	ldi a,(hl)		; $4490
	ld (de),a		; $4491
	ld e,$99		; $4492
	ldi a,(hl)		; $4494
	ld (de),a		; $4495
	ld e,$b9		; $4496
	ldi a,(hl)		; $4498
	ld (de),a		; $4499
	ld e,$d9		; $449a
	ldi a,(hl)		; $449c
	ld (de),a		; $449d
	ld e,$f9		; $449e
	ldi a,(hl)		; $44a0
	ld (de),a		; $44a1
	inc d			; $44a2
	dec b			; $44a3
	jr nz,_label_04_025	; $44a4
	ld l,c			; $44a6
	ld h,$c4		; $44a7
	jp vblankFunctionRet		; $44a9
	ld h,b			; $44ac
	ld l,e			; $44ad
	ld b,$04		; $44ae
_label_04_026:
	ld e,$1a		; $44b0
	ldi a,(hl)		; $44b2
	ld (de),a		; $44b3
	ld e,$3a		; $44b4
	ldi a,(hl)		; $44b6
	ld (de),a		; $44b7
	ld e,$5a		; $44b8
	ldi a,(hl)		; $44ba
	ld (de),a		; $44bb
	ld e,$7a		; $44bc
	ldi a,(hl)		; $44be
	ld (de),a		; $44bf
	ld e,$9a		; $44c0
	ldi a,(hl)		; $44c2
	ld (de),a		; $44c3
	ld e,$ba		; $44c4
	ldi a,(hl)		; $44c6
	ld (de),a		; $44c7
	ld e,$da		; $44c8
	ldi a,(hl)		; $44ca
	ld (de),a		; $44cb
	ld e,$fa		; $44cc
	ldi a,(hl)		; $44ce
	ld (de),a		; $44cf
	inc d			; $44d0
	dec b			; $44d1
	jr nz,_label_04_026	; $44d2
	ld l,c			; $44d4
	ld h,$c4		; $44d5
	jp vblankFunctionRet		; $44d7
	ld h,b			; $44da
	ld l,e			; $44db
	ld b,$04		; $44dc
_label_04_027:
	ld e,$1b		; $44de
	ldi a,(hl)		; $44e0
	ld (de),a		; $44e1
	ld e,$3b		; $44e2
	ldi a,(hl)		; $44e4
	ld (de),a		; $44e5
	ld e,$5b		; $44e6
	ldi a,(hl)		; $44e8
	ld (de),a		; $44e9
	ld e,$7b		; $44ea
	ldi a,(hl)		; $44ec
	ld (de),a		; $44ed
	ld e,$9b		; $44ee
	ldi a,(hl)		; $44f0
	ld (de),a		; $44f1
	ld e,$bb		; $44f2
	ldi a,(hl)		; $44f4
	ld (de),a		; $44f5
	ld e,$db		; $44f6
	ldi a,(hl)		; $44f8
	ld (de),a		; $44f9
	ld e,$fb		; $44fa
	ldi a,(hl)		; $44fc
	ld (de),a		; $44fd
	inc d			; $44fe
	dec b			; $44ff
	jr nz,_label_04_027	; $4500
	ld l,c			; $4502
	ld h,$c4		; $4503
	jp vblankFunctionRet		; $4505
	ld h,b			; $4508
	ld l,e			; $4509
	ld b,$04		; $450a
_label_04_028:
	ld e,$1c		; $450c
	ldi a,(hl)		; $450e
	ld (de),a		; $450f
	ld e,$3c		; $4510
	ldi a,(hl)		; $4512
	ld (de),a		; $4513
	ld e,$5c		; $4514
	ldi a,(hl)		; $4516
	ld (de),a		; $4517
	ld e,$7c		; $4518
	ldi a,(hl)		; $451a
	ld (de),a		; $451b
	ld e,$9c		; $451c
	ldi a,(hl)		; $451e
	ld (de),a		; $451f
	ld e,$bc		; $4520
	ldi a,(hl)		; $4522
	ld (de),a		; $4523
	ld e,$dc		; $4524
	ldi a,(hl)		; $4526
	ld (de),a		; $4527
	ld e,$fc		; $4528
	ldi a,(hl)		; $452a
	ld (de),a		; $452b
	inc d			; $452c
	dec b			; $452d
	jr nz,_label_04_028	; $452e
	ld l,c			; $4530
	ld h,$c4		; $4531
	jp vblankFunctionRet		; $4533
	ld h,b			; $4536
	ld l,e			; $4537
	ld b,$04		; $4538
_label_04_029:
	ld e,$1d		; $453a
	ldi a,(hl)		; $453c
	ld (de),a		; $453d
	ld e,$3d		; $453e
	ldi a,(hl)		; $4540
	ld (de),a		; $4541
	ld e,$5d		; $4542
	ldi a,(hl)		; $4544
	ld (de),a		; $4545
	ld e,$7d		; $4546
	ldi a,(hl)		; $4548
	ld (de),a		; $4549
	ld e,$9d		; $454a
	ldi a,(hl)		; $454c
	ld (de),a		; $454d
	ld e,$bd		; $454e
	ldi a,(hl)		; $4550
	ld (de),a		; $4551
	ld e,$dd		; $4552
	ldi a,(hl)		; $4554
	ld (de),a		; $4555
	ld e,$fd		; $4556
	ldi a,(hl)		; $4558
	ld (de),a		; $4559
	inc d			; $455a
	dec b			; $455b
	jr nz,_label_04_029	; $455c
	ld l,c			; $455e
	ld h,$c4		; $455f
	jp vblankFunctionRet		; $4561
	ld h,b			; $4564
	ld l,e			; $4565
	ld b,$04		; $4566
_label_04_030:
	ld e,$1e		; $4568
	ldi a,(hl)		; $456a
	ld (de),a		; $456b
	ld e,$3e		; $456c
	ldi a,(hl)		; $456e
	ld (de),a		; $456f
	ld e,$5e		; $4570
	ldi a,(hl)		; $4572
	ld (de),a		; $4573
	ld e,$7e		; $4574
	ldi a,(hl)		; $4576
	ld (de),a		; $4577
	ld e,$9e		; $4578
	ldi a,(hl)		; $457a
	ld (de),a		; $457b
	ld e,$be		; $457c
	ldi a,(hl)		; $457e
	ld (de),a		; $457f
	ld e,$de		; $4580
	ldi a,(hl)		; $4582
	ld (de),a		; $4583
	ld e,$fe		; $4584
	ldi a,(hl)		; $4586
	ld (de),a		; $4587
	inc d			; $4588
	dec b			; $4589
	jr nz,_label_04_030	; $458a
	ld l,c			; $458c
	ld h,$c4		; $458d
	jp vblankFunctionRet		; $458f
	ld h,b			; $4592
	ld l,e			; $4593
	ld b,$04		; $4594
_label_04_031:
	ld e,$1f		; $4596
	ldi a,(hl)		; $4598
	ld (de),a		; $4599
	ld e,$3f		; $459a
	ldi a,(hl)		; $459c
	ld (de),a		; $459d
	ld e,$5f		; $459e
	ldi a,(hl)		; $45a0
	ld (de),a		; $45a1
	ld e,$7f		; $45a2
	ldi a,(hl)		; $45a4
	ld (de),a		; $45a5
	ld e,$9f		; $45a6
	ldi a,(hl)		; $45a8
	ld (de),a		; $45a9
	ld e,$bf		; $45aa
	ldi a,(hl)		; $45ac
	ld (de),a		; $45ad
	ld e,$df		; $45ae
	ldi a,(hl)		; $45b0
	ld (de),a		; $45b1
	ld e,$ff		; $45b2
	ldi a,(hl)		; $45b4
	ld (de),a		; $45b5
	inc d			; $45b6
	dec b			; $45b7
	jr nz,_label_04_031	; $45b8
	ld l,c			; $45ba
	ld h,$c4		; $45bb
	jp vblankFunctionRet		; $45bd
	pop hl			; $45c0
	ldi a,(hl)		; $45c1
	ld ($ff00+$4f),a	; $45c2
	ldi a,(hl)		; $45c4
	ld e,a			; $45c5
	ld b,$cd		; $45c6
	ld d,$98		; $45c8
	ldi a,(hl)		; $45ca
	ld h,(hl)		; $45cb
	inc l			; $45cc
	ld c,l			; $45cd
	ld l,a			; $45ce
	jp hl			; $45cf
	ld a,($cc63)		; $45d0
	bit 7,a			; $45d3
	jr nz,_label_04_034	; $45d5
	and $0f			; $45d7
	cp $02			; $45d9
	jr nz,_label_04_032	; $45db
	ld hl,$6d4e		; $45dd
	rst_addDoubleIndex			; $45e0
	ldi a,(hl)		; $45e1
	ld h,(hl)		; $45e2
	ld l,a			; $45e3
	ld a,($cc64)		; $45e4
	ld b,a			; $45e7
	ld a,($c6df)		; $45e8
	add b			; $45eb
	jr _label_04_033		; $45ec
_label_04_032:
	ld hl,$6d4e		; $45ee
	rst_addDoubleIndex			; $45f1
	ldi a,(hl)		; $45f2
	ld h,(hl)		; $45f3
	ld l,a			; $45f4
	ld a,($cc64)		; $45f5
_label_04_033:
	ld c,a			; $45f8
	ld b,$00		; $45f9
	add hl,bc		; $45fb
	add hl,bc		; $45fc
	add hl,bc		; $45fd
	ldi a,(hl)		; $45fe
	ld ($cc64),a		; $45ff
	ldi a,(hl)		; $4602
	ld ($cc66),a		; $4603
	ldi a,(hl)		; $4606
	or $80			; $4607
	ld ($cc65),a		; $4609
_label_04_034:
	ld a,$0a		; $460c
	ld ($cc6a),a		; $460e
	ld a,($cc49)		; $4611
	ldh (<hFF8B),a	; $4614
	ld a,($cc63)		; $4616
	and $07			; $4619
	ld ($cc49),a		; $461b
	ld a,($cc64)		; $461e
	ld ($cc4c),a		; $4621
	ld hl,$d000		; $4624
	ld (hl),$03		; $4627
	ld a,($cc66)		; $4629
	ld b,a			; $462c
	and $f0			; $462d
	or $08			; $462f
	ld l,$0b		; $4631
	ldi (hl),a		; $4633
	inc l			; $4634
	ld a,b			; $4635
	and $0f			; $4636
	swap a			; $4638
	or $08			; $463a
	ldi (hl),a		; $463c
	ld a,($cc63)		; $463d
	bit 6,a			; $4640
	jr nz,_label_04_036	; $4642
	ld a,($cc49)		; $4644
	or a			; $4647
	jr nz,_label_04_036	; $4648
	ldh a,(<hFF8B)	; $464a
	cp $03			; $464c
	jr c,_label_04_035	; $464e
	jr z,_label_04_036	; $4650
	ld a,($cc55)		; $4652
	cp $ff			; $4655
	jr z,_label_04_036	; $4657
_label_04_035:
	call loadScreenMusicAndSetRoomPack		; $4659
	jp seasonsFunc_3ab2		; $465c
_label_04_036:
	jp loadScreenMusicAndSetRoomPack		; $465f

;;
; @addr{4662}
findWarpSourceAndDest:
	ld a,($cc49)		; $4662
	ld hl,$7457		; $4665
	rst_addDoubleIndex			; $4668
	ldi a,(hl)		; $4669
	ld h,(hl)		; $466a
	ld l,a			; $466b
	ld a,($cc4c)		; $466c
	ld b,a			; $466f
_label_04_037:
	ldi a,(hl)		; $4670
	bit 7,a			; $4671
	jr nz,_label_04_040	; $4673
	bit 6,a			; $4675
	jr nz,_label_04_039	; $4677
	and $0f			; $4679
	jr nz,_label_04_038	; $467b
	ld a,(hl)		; $467d
	cp b			; $467e
	jr z,_label_04_040	; $467f
_label_04_038:
	inc hl			; $4681
	inc hl			; $4682
	inc hl			; $4683
	jr _label_04_037		; $4684
_label_04_039:
	ld a,(hl)		; $4686
	cp b			; $4687
	jr nz,_label_04_038	; $4688
	inc hl			; $468a
	ldi a,(hl)		; $468b
	ld h,(hl)		; $468c
	ld l,a			; $468d
	ldh a,(<hFF8D)	; $468e
	ld b,a			; $4690
	jr _label_04_037		; $4691
_label_04_040:
	inc hl			; $4693
	ldi a,(hl)		; $4694
	ld ($cc64),a		; $4695
	ldi a,(hl)		; $4698
	ld b,a			; $4699
	swap a			; $469a
	and $0f			; $469c
	ld ($cc63),a		; $469e
	ld a,b			; $46a1
	and $0f			; $46a2
	ld ($cc65),a		; $46a4
	ret			; $46a7

;;
; @addr{46a8}
findScreenEdgeWarpSource:
	ld a,($cd00)		; $46a8
	and $04			; $46ab
	ret z			; $46ad
	ld a,($cd02)		; $46ae
	rrca			; $46b1
	ret c			; $46b2
	call $4722		; $46b3
	ld hl,bitTable		; $46b6
	add l			; $46b9
	ld l,a			; $46ba
	ld b,(hl)		; $46bb
	ld a,($cc49)		; $46bc
	ld hl,$7457		; $46bf
	rst_addDoubleIndex			; $46c2
	ldi a,(hl)		; $46c3
	ld h,(hl)		; $46c4
	ld l,a			; $46c5
	ld a,($cc4c)		; $46c6
	ld c,a			; $46c9
_label_04_041:
	ldi a,(hl)		; $46ca
	bit 7,a			; $46cb
	ret nz			; $46cd
	bit 6,a			; $46ce
	jr nz,_label_04_043	; $46d0
	ld e,a			; $46d2
	ldi a,(hl)		; $46d3
	cp c			; $46d4
	jr nz,_label_04_042	; $46d5
	ld a,e			; $46d7
	and b			; $46d8
	jr nz,_label_04_044	; $46d9
_label_04_042:
	inc hl			; $46db
	inc hl			; $46dc
	jr _label_04_041		; $46dd
_label_04_043:
	ldi a,(hl)		; $46df
	cp c			; $46e0
	jr nz,_label_04_042	; $46e1
	ldi a,(hl)		; $46e3
	ld h,(hl)		; $46e4
	ld l,a			; $46e5
	jr _label_04_041		; $46e6
_label_04_044:
	ldi a,(hl)		; $46e8
	ld ($cc64),a		; $46e9
	ldi a,(hl)		; $46ec
	ld b,a			; $46ed
	swap a			; $46ee
	and $0f			; $46f0
	ld ($cc63),a		; $46f2
	ld a,b			; $46f5
	and $0f			; $46f6
	ld b,a			; $46f8
	ld a,($cd02)		; $46f9
	rlca			; $46fc
	swap a			; $46fd
	and $40			; $46ff
	or b			; $4701
	ld ($cc65),a		; $4702
	ld a,($cc48)		; $4705
	cp $d0			; $4708
	call nz,$4712		; $470a
	xor a			; $470d
	ld ($cec0),a		; $470e
	ret			; $4711
	push hl			; $4712
	call dismountCompanionAndSetRememberedPositionToScreenCenter		; $4713
	ld a,$01		; $4716
	ld ($cc65),a		; $4718
	ld a,$01		; $471b
	ld ($cc67),a		; $471d
	pop hl			; $4720
	ret			; $4721
	ld a,($cd02)		; $4722
	ld b,a			; $4725
	ld a,($cc49)		; $4726
	cp $04			; $4729
	ld a,($d00d)		; $472b
	jr nc,_label_04_045	; $472e
	cp $60			; $4730
	ld a,b			; $4732
	ret c			; $4733
	inc a			; $4734
	ret			; $4735
_label_04_045:
	cp $80			; $4736
	ld a,b			; $4738
	ret c			; $4739
	inc a			; $473a
	ret			; $473b
	jr _label_04_046		; $473c
	jr _label_04_047		; $473e
	inc e			; $4740
	inc e			; $4741
	inc e			; $4742
	inc e			; $4743
	ld d,$16		; $4744
	ld d,$15		; $4746
	dec d			; $4748
	dec d			; $4749
	dec d			; $474a
	dec d			; $474b
	jr _label_04_048		; $474c
	jr _label_04_049		; $474e
	inc e			; $4750
	inc e			; $4751
	inc e			; $4752
	inc e			; $4753
	ld d,$16		; $4754
_label_04_046:
	ld d,$15		; $4756
	dec d			; $4758
	dec d			; $4759
	dec d			; $475a
	dec d			; $475b
	rla			; $475c
_label_04_047:
	jr $18			; $475d
	dec e			; $475f
	inc e			; $4760
	inc e			; $4761
	inc e			; $4762
	inc e			; $4763
	ld d,$16		; $4764
_label_04_048:
	ld d,$15		; $4766
	dec d			; $4768
	dec d			; $4769
	dec d			; $476a
	dec d			; $476b
	rla			; $476c
_label_04_049:
	rla			; $476d
	rla			; $476e
	dec e			; $476f
	dec e			; $4770
	inc e			; $4771
	inc e			; $4772
	inc e			; $4773
	ld d,$16		; $4774
	ld d,$15		; $4776
	dec d			; $4778
	dec d			; $4779
	dec d			; $477a
	dec d			; $477b
	rla			; $477c
	rla			; $477d
	rla			; $477e
	rla			; $477f
	dec e			; $4780
	inc d			; $4781
	rst $38			; $4782
	rst $38			; $4783
	rst $38			; $4784
	rst $38			; $4785
	rst $38			; $4786
	rst $38			; $4787
	rst $38			; $4788
	dec d			; $4789
	dec d			; $478a
	dec d			; $478b
	rla			; $478c
	rla			; $478d
	rla			; $478e
	rla			; $478f
	inc d			; $4790
	inc d			; $4791
	rst $38			; $4792
	rst $38			; $4793
	rst $38			; $4794
	rst $38			; $4795
	rst $38			; $4796
	rst $38			; $4797
	rst $38			; $4798
	dec d			; $4799
	dec d			; $479a
	dec d			; $479b
	inc de			; $479c
	inc de			; $479d
	inc de			; $479e
	rla			; $479f
	inc d			; $47a0
	inc d			; $47a1
	inc d			; $47a2
	inc d			; $47a3
	inc d			; $47a4
	rst $38			; $47a5
	rst $38			; $47a6
	rst $38			; $47a7
	rst $38			; $47a8
	dec d			; $47a9
	dec d			; $47aa
	dec d			; $47ab
	inc de			; $47ac
	inc de			; $47ad
	inc de			; $47ae
	inc de			; $47af
	inc d			; $47b0
	inc d			; $47b1
	inc d			; $47b2
	inc d			; $47b3
	inc d			; $47b4
	rst $38			; $47b5
	rst $38			; $47b6
	rst $38			; $47b7
	ld de,$1212		; $47b8
	ld (de),a		; $47bb
	inc de			; $47bc
	inc de			; $47bd
	inc de			; $47be
	inc de			; $47bf
	inc d			; $47c0
	inc d			; $47c1
	inc d			; $47c2
	inc d			; $47c3
	stop			; $47c4
	stop			; $47c5
	stop			; $47c6
	ld de,$1211		; $47c7
	ld (de),a		; $47ca
	ld de,$1313		; $47cb
	inc de			; $47ce
	inc d			; $47cf
	inc d			; $47d0
	inc d			; $47d1
	stop			; $47d2
	stop			; $47d3
	stop			; $47d4
	stop			; $47d5
	stop			; $47d6
	ld de,$1111		; $47d7
	ld (de),a		; $47da
	ld de,$1313		; $47db
	inc de			; $47de
	inc d			; $47df
	inc d			; $47e0
	inc d			; $47e1
	stop			; $47e2
	stop			; $47e3
	stop			; $47e4
	stop			; $47e5
	stop			; $47e6
	ld de,$1111		; $47e7
	ld de,$1311		; $47ea
	inc de			; $47ed
	inc de			; $47ee
	inc d			; $47ef
	inc d			; $47f0
	inc d			; $47f1
	stop			; $47f2
	stop			; $47f3
	stop			; $47f4
	stop			; $47f5
	stop			; $47f6
	ld de,$1911		; $47f7
	add hl,de		; $47fa
	add hl,de		; $47fb
	inc de			; $47fc
	inc de			; $47fd
	inc de			; $47fe
	dec de			; $47ff
	dec de			; $4800
	nop			; $4801
	nop			; $4802
	nop			; $4803
	nop			; $4804
	ld a,($ff00+$11)	; $4805
	ld de,$1911		; $4807
	add hl,de		; $480a
	add hl,de		; $480b
	dec de			; $480c
	dec de			; $480d
	dec de			; $480e
	dec de			; $480f
	dec de			; $4810
	dec de			; $4811
	nop			; $4812
	nop			; $4813
	nop			; $4814
	nop			; $4815
	ld de,$1911		; $4816
	add hl,de		; $4819
	add hl,de		; $481a
	add hl,de		; $481b
	dec de			; $481c
	dec de			; $481d
	dec de			; $481e
	dec de			; $481f
	dec de			; $4820
	dec de			; $4821
	nop			; $4822
	nop			; $4823
	nop			; $4824
	nop			; $4825
	ld de,$1911		; $4826
	add hl,de		; $4829
	add hl,de		; $482a
	add hl,de		; $482b
	dec de			; $482c
	dec de			; $482d
	dec de			; $482e
	dec de			; $482f
	dec de			; $4830
	nop			; $4831
	nop			; $4832
	nop			; $4833
	nop			; $4834
	nop			; $4835
	add hl,de		; $4836
	add hl,de		; $4837
	add hl,de		; $4838
	add hl,de		; $4839
	add hl,de		; $483a
	add hl,de		; $483b


groupMusicPointerTable:
	.dw group0Music
	.dw group1Music
	.dw group2Music
	.dw group3Music
	.dw group4Music
	.dw group5Music
	.dw group6Music
	.dw group7Music

group0Music:
	.incbin "audio/seasons/group0IDs.bin"
group1Music:
group2Music:
group3Music:
	.incbin "audio/seasons/group1IDs.bin"
group4Music:
group6Music:
	.incbin "audio/seasons/group4IDs.bin"
group5Music:
group7Music:
	.incbin "audio/seasons/group5IDs.bin"


	ld bc,$0616		; $4c4c
	ld (hl),b		; $4c4f
	ld hl,$4e04		; $4c50
	nop			; $4c53
	ld bc,$0616		; $4c54
	ld (hl),d		; $4c57
	ldi (hl),a		; $4c58
	inc d			; $4c59
	ld c,e			; $4c5a
	nop			; $4c5b
	ld bc,$0616		; $4c5c
	ld (hl),h		; $4c5f
	inc hl			; $4c60
	inc b			; $4c61
	ld c,c			; $4c62
	nop			; $4c63
	ld bc,$0616		; $4c64
	halt			; $4c67
	inc h			; $4c68
	ld h,c			; $4c69
	ld b,l			; $4c6a
	nop			; $4c6b
	ld bc,$0616		; $4c6c
	ld a,b			; $4c6f
	dec h			; $4c70
	ld e,c			; $4c71
	ld b,d			; $4c72
	nop			; $4c73
	nop			; $4c74
	jr _label_04_112		; $4c75
_label_04_112:
	ld b,b			; $4c77
	dec h			; $4c78
	and a			; $4c79
	ld a,d			; $4c7a
	nop			; $4c7b
	nop			; $4c7c
	jr _label_04_113		; $4c7d
_label_04_113:
	ld d,d			; $4c7f
	ld h,$93		; $4c80
	ld a,d			; $4c82
	nop			; $4c83
	rst $38			; $4c84
	sbc h			; $4c85
	ld c,a			; $4c86
	nop			; $4c87
	nop			; $4c88
	nop			; $4c89
	nop			; $4c8a
	nop			; $4c8b
	rst $38			; $4c8c
	cp h			; $4c8d
	ld c,a			; $4c8e
	nop			; $4c8f
	nop			; $4c90
	nop			; $4c91
	nop			; $4c92
	nop			; $4c93
	rst $38			; $4c94
	call c,$004f		; $4c95
	nop			; $4c98
	nop			; $4c99
	nop			; $4c9a
	nop			; $4c9b
	rst $38			; $4c9c
.DB $fc				; $4c9d
	ld c,a			; $4c9e
	nop			; $4c9f
	nop			; $4ca0
	nop			; $4ca1
	nop			; $4ca2
	nop			; $4ca3
	rst $38			; $4ca4
	inc e			; $4ca5
	ld d,b			; $4ca6
	nop			; $4ca7
	nop			; $4ca8
	nop			; $4ca9
	nop			; $4caa
	nop			; $4cab
	rst $38			; $4cac
	inc a			; $4cad
	ld d,b			; $4cae
	nop			; $4caf
	nop			; $4cb0
	nop			; $4cb1
	nop			; $4cb2
	nop			; $4cb3
	rst $38			; $4cb4
	ld e,h			; $4cb5
	ld d,b			; $4cb6
	nop			; $4cb7
	nop			; $4cb8
	nop			; $4cb9
	nop			; $4cba
	nop			; $4cbb
	rst $38			; $4cbc
	ld a,h			; $4cbd
	ld d,b			; $4cbe
	nop			; $4cbf
	nop			; $4cc0
	nop			; $4cc1
	nop			; $4cc2
	nop			; $4cc3
	rst $38			; $4cc4
	sbc h			; $4cc5
	ld d,b			; $4cc6
	nop			; $4cc7
	nop			; $4cc8
	nop			; $4cc9
	nop			; $4cca
	nop			; $4ccb
	rst $38			; $4ccc
	cp h			; $4ccd
	ld d,b			; $4cce
	nop			; $4ccf
	nop			; $4cd0
	nop			; $4cd1
	nop			; $4cd2
	nop			; $4cd3
	rst $38			; $4cd4
	call c,$0050		; $4cd5
	nop			; $4cd8
	nop			; $4cd9
	nop			; $4cda
	nop			; $4cdb
	rst $38			; $4cdc
.DB $fc				; $4cdd
	ld d,b			; $4cde
	nop			; $4cdf
	nop			; $4ce0
	nop			; $4ce1
	nop			; $4ce2
	nop			; $4ce3
	rst $38			; $4ce4
	inc e			; $4ce5
	ld d,c			; $4ce6
	nop			; $4ce7
	nop			; $4ce8
	nop			; $4ce9
	nop			; $4cea
	nop			; $4ceb
	rst $38			; $4cec
	inc a			; $4ced
	ld d,c			; $4cee
	nop			; $4cef
	nop			; $4cf0
	nop			; $4cf1
	nop			; $4cf2
	nop			; $4cf3
	rst $38			; $4cf4
	ld e,h			; $4cf5
	ld d,c			; $4cf6
	nop			; $4cf7
	nop			; $4cf8
	nop			; $4cf9
	nop			; $4cfa
	nop			; $4cfb
	rst $38			; $4cfc
	ld a,h			; $4cfd
	ld d,c			; $4cfe
	nop			; $4cff
	nop			; $4d00
	nop			; $4d01
	nop			; $4d02
	nop			; $4d03
	rst $38			; $4d04
	sbc h			; $4d05
	ld d,c			; $4d06
	nop			; $4d07
	nop			; $4d08
	nop			; $4d09
	nop			; $4d0a
	nop			; $4d0b
	rst $38			; $4d0c
	cp h			; $4d0d
	ld d,c			; $4d0e
	nop			; $4d0f
	nop			; $4d10
	nop			; $4d11
	nop			; $4d12
	nop			; $4d13
	rst $38			; $4d14
	call c,$0051		; $4d15
	nop			; $4d18
	nop			; $4d19
	nop			; $4d1a
	nop			; $4d1b
	rst $38			; $4d1c
.DB $fc				; $4d1d
	ld d,c			; $4d1e
	nop			; $4d1f
	nop			; $4d20
	nop			; $4d21
	nop			; $4d22
	nop			; $4d23
	rst $38			; $4d24
	inc e			; $4d25
	ld d,d			; $4d26
	nop			; $4d27
	nop			; $4d28
	nop			; $4d29
	nop			; $4d2a
	nop			; $4d2b
	rst $38			; $4d2c
	inc a			; $4d2d
	ld d,d			; $4d2e
	nop			; $4d2f
	nop			; $4d30
	nop			; $4d31
	nop			; $4d32
	nop			; $4d33
	rst $38			; $4d34
	ld e,h			; $4d35
	ld d,d			; $4d36
	nop			; $4d37
	nop			; $4d38
	nop			; $4d39
	nop			; $4d3a
	nop			; $4d3b
	rst $38			; $4d3c
	ld a,h			; $4d3d
	ld d,d			; $4d3e
	nop			; $4d3f
	nop			; $4d40
	nop			; $4d41
	nop			; $4d42
	nop			; $4d43
	rst $38			; $4d44
	sbc h			; $4d45
	ld d,d			; $4d46
	nop			; $4d47
	nop			; $4d48
	nop			; $4d49
	nop			; $4d4a
	nop			; $4d4b
	rst $38			; $4d4c
	cp h			; $4d4d
	ld d,d			; $4d4e
	nop			; $4d4f
	nop			; $4d50
	nop			; $4d51
	nop			; $4d52
	nop			; $4d53
	rst $38			; $4d54
	call c,$0052		; $4d55
	nop			; $4d58
	nop			; $4d59
	nop			; $4d5a
	nop			; $4d5b
	rrca			; $4d5c
	ld bc,$4110		; $4d5d
	stop			; $4d60
	ld de,$0401		; $4d61
	rrca			; $4d64
	ld bc,$4111		; $4d65
	stop			; $4d68
	ld (de),a		; $4d69
	ld bc,$0f05		; $4d6a
	ld bc,$4110		; $4d6d
	stop			; $4d70
	dec (hl)		; $4d71
	ld bc,$0f04		; $4d72
	ld bc,$4f00		; $4d75
	ld d,(hl)		; $4d78
	ld c,$01		; $4d79
	inc bc			; $4d7b
	rrca			; $4d7c
	ld bc,$441f		; $4d7d
	ld d,h			; $4d80
	dec bc			; $4d81
	inc bc			; $4d82
	dec c			; $4d83
	rra			; $4d84
	add c			; $4d85
	nop			; $4d86
	ld d,b			; $4d87
	ld e,d			; $4d88
	inc e			; $4d89
	inc b			; $4d8a
	stop			; $4d8b
	rra			; $4d8c
	add c			; $4d8d
	rla			; $4d8e
	ld d,b			; $4d8f
	ld e,b			; $4d90
	dec de			; $4d91
	inc b			; $4d92
	stop			; $4d93
	rra			; $4d94
	add c			; $4d95
	rla			; $4d96
	ld d,b			; $4d97
	ld e,c			; $4d98
	dec de			; $4d99
	inc b			; $4d9a
	stop			; $4d9b
	rra			; $4d9c
	add c			; $4d9d
	rla			; $4d9e
	ld d,b			; $4d9f
	ld e,a			; $4da0
	dec de			; $4da1
	inc b			; $4da2
	stop			; $4da3
	rra			; $4da4
	add c			; $4da5
	jr _label_04_115		; $4da6
	ld e,d			; $4da8
	inc e			; $4da9
	inc b			; $4daa
	stop			; $4dab
	rra			; $4dac
	add c			; $4dad
	add hl,de		; $4dae
	ld d,b			; $4daf
	ld e,e			; $4db0
	dec e			; $4db1
	inc b			; $4db2
	stop			; $4db3
	rra			; $4db4
	add c			; $4db5
	ld a,(de)		; $4db6
	ld d,b			; $4db7
	ld e,h			; $4db8
	ld e,$04		; $4db9
	stop			; $4dbb
	rra			; $4dbc
	add c			; $4dbd
	dec de			; $4dbe
	ld d,b			; $4dbf
	ld e,l			; $4dc0
	rra			; $4dc1
	inc b			; $4dc2
	stop			; $4dc3
	rra			; $4dc4
	add c			; $4dc5
	inc e			; $4dc6
	ld d,b			; $4dc7
	ld e,(hl)		; $4dc8
	jr nz,_label_04_114	; $4dc9
	ld de,$022f		; $4dcb
	dec e			; $4dce
_label_04_114:
	ld (hl),b		; $4dcf
	ld d,b			; $4dd0
	inc sp			; $4dd1
	inc b			; $4dd2
	rst $38			; $4dd3
	cpl			; $4dd4
	ld (bc),a		; $4dd5
	ld e,$70		; $4dd6
	ld d,b			; $4dd8
	inc sp			; $4dd9
	inc b			; $4dda
	rst $38			; $4ddb
	cpl			; $4ddc
	ld (bc),a		; $4ddd
	nop			; $4dde
	ld (hl),c		; $4ddf
	ld d,c			; $4de0
	inc (hl)		; $4de1
	inc b			; $4de2
	rst $38			; $4de3
	ccf			; $4de4
	inc b			; $4de5
	nop			; $4de6
	ld a,h			; $4de7
	ld (hl),b		; $4de8
	ld l,$04		; $4de9
	jr _label_04_116		; $4deb
	inc b			; $4ded
	nop			; $4dee
	ld a,h			; $4def
	ld (hl),c		; $4df0
	ld l,$04		; $4df1
	jr _label_04_117		; $4df3
	inc b			; $4df5
	nop			; $4df6
	ld a,h			; $4df7
_label_04_115:
	ld (hl),d		; $4df8
	ld l,$04		; $4df9
	jr _label_04_118		; $4dfb
	inc b			; $4dfd
	nop			; $4dfe
	ld a,h			; $4dff
	ld (hl),h		; $4e00
	ld l,$04		; $4e01
	jr $3f			; $4e03
	inc b			; $4e05
	nop			; $4e06
	ld a,h			; $4e07
	halt			; $4e08
	ld l,$04		; $4e09
	jr _label_04_119		; $4e0b
	inc b			; $4e0d
	nop			; $4e0e
	ld a,l			; $4e0f
	ld (hl),a		; $4e10
	cpl			; $4e11
	inc b			; $4e12
	jr $3f			; $4e13
	inc b			; $4e15
	nop			; $4e16
	ld a,l			; $4e17
	ld a,d			; $4e18
	cpl			; $4e19
	inc b			; $4e1a
	jr $3f			; $4e1b
	inc b			; $4e1d
	nop			; $4e1e
	ld a,l			; $4e1f
	ld a,e			; $4e20
	cpl			; $4e21
	inc b			; $4e22
	jr $3f			; $4e23
	inc b			; $4e25
	nop			; $4e26
	ld a,a			; $4e27
	ld a,h			; $4e28
	ld sp,$1804		; $4e29
_label_04_116:
	ccf			; $4e2c
	inc b			; $4e2d
	nop			; $4e2e
	ld a,a			; $4e2f
	ld (hl),d		; $4e30
	ld sp,$1804		; $4e31
_label_04_117:
	ld b,b			; $4e34
	ld ($6000),sp		; $4e35
	ld b,b			; $4e38
	ld hl,$1805		; $4e39
_label_04_118:
	ld b,c			; $4e3c
	ld ($6100),sp		; $4e3d
	ld b,c			; $4e40
	ldi (hl),a		; $4e41
	dec b			; $4e42
	jr $42			; $4e43
	ld ($6200),sp		; $4e45
	ld b,d			; $4e48
	inc hl			; $4e49
	dec b			; $4e4a
	add hl,de		; $4e4b
_label_04_119:
	ld b,e			; $4e4c
	ld ($6300),sp		; $4e4d
	ld b,e			; $4e50
	inc h			; $4e51
	dec b			; $4e52
	jr _label_04_120		; $4e53
	ld ($6400),sp		; $4e55
	ld b,h			; $4e58
	dec h			; $4e59
	dec b			; $4e5a
	jr _label_04_121		; $4e5b
	ld ($6500),sp		; $4e5d
	ld b,l			; $4e60
	ld h,$05		; $4e61
	jr $46			; $4e63
	ld ($6600),sp		; $4e65
	ld b,(hl)		; $4e68
	daa			; $4e69
	dec b			; $4e6a
	add hl,de		; $4e6b
	ld (hl),$04		; $4e6c
	ld c,$40		; $4e6e
	stop			; $4e70
	jr z,$04		; $4e71
	rst $38			; $4e73
	ld b,a			; $4e74
	ld ($6700),sp		; $4e75
	ld b,a			; $4e78
	add hl,hl		; $4e79
	ld b,$18		; $4e7a
	ld b,a			; $4e7c
	ld ($6727),sp		; $4e7d
	ld b,a			; $4e80
	add hl,hl		; $4e81
	ld b,$18		; $4e82
	ld b,a			; $4e84
	ld ($6728),sp		; $4e85
	ld c,l			; $4e88
	add hl,hl		; $4e89
	ld b,$18		; $4e8a
	ld c,b			; $4e8c
	ld ($6800),sp		; $4e8d
	ld c,b			; $4e90
	ldi a,(hl)		; $4e91
	ld b,$18		; $4e92
	ld c,b			; $4e94
	ld ($6c00),sp		; $4e95
	ld c,(hl)		; $4e98
_label_04_120:
	ldi a,(hl)		; $4e99
	ld b,$18		; $4e9a
	ld c,b			; $4e9c
	ld ($6c26),sp		; $4e9d
	ld c,a			; $4ea0
	ldi a,(hl)		; $4ea1
_label_04_121:
	ld b,$18		; $4ea2
	ld c,c			; $4ea4
	ld ($6900),sp		; $4ea5
	ld c,c			; $4ea8
	dec hl			; $4ea9
	ld b,$18		; $4eaa
	ld c,d			; $4eac
	ld ($6a00),sp		; $4ead
	ld c,d			; $4eb0
	inc l			; $4eb1
	ld b,$18		; $4eb2
	ld c,d			; $4eb4
	ld ($6a00),sp		; $4eb5
	adc (hl)		; $4eb8
	inc l			; $4eb9
	ld b,$18		; $4eba
	ld c,e			; $4ebc
	ld ($6000),sp		; $4ebd
	ld b,b			; $4ec0
	ld hl,$1806		; $4ec1
	ld c,a			; $4ec4
	stop			; $4ec5
	nop			; $4ec6
	ld a,l			; $4ec7
	ld (hl),a		; $4ec8
	cpl			; $4ec9
	dec b			; $4eca
	jr _label_04_122		; $4ecb
	stop			; $4ecd
	nop			; $4ece
	ld a,l			; $4ecf
	ld a,b			; $4ed0
	cpl			; $4ed1
	dec b			; $4ed2
	jr _label_04_123		; $4ed3
	stop			; $4ed5
	nop			; $4ed6
	ld a,l			; $4ed7
	ld a,c			; $4ed8
	cpl			; $4ed9
	dec b			; $4eda
	jr _label_04_124		; $4edb
	stop			; $4edd
	nop			; $4ede
	ld a,h			; $4edf
	ld (hl),l		; $4ee0
	ld l,$05		; $4ee1
	jr _label_04_126		; $4ee3
	stop			; $4ee5
	nop			; $4ee6
	ld a,a			; $4ee7
	ld a,h			; $4ee8
	ld sp,$1805		; $4ee9
	ld c,a			; $4eec
	stop			; $4eed
	nop			; $4eee
	ld a,h			; $4eef
	ld (hl),b		; $4ef0
	ld l,$06		; $4ef1
	jr _label_04_129		; $4ef3
	stop			; $4ef5
	nop			; $4ef6
	ld a,h			; $4ef7
	ld (hl),e		; $4ef8
	ld l,$06		; $4ef9
	jr _label_04_131		; $4efb
	stop			; $4efd
	nop			; $4efe
	ld a,l			; $4eff
	ld (hl),a		; $4f00
	cpl			; $4f01
	ld b,$18		; $4f02
	ld c,a			; $4f04
	stop			; $4f05
	nop			; $4f06
	ld a,l			; $4f07
	ld a,c			; $4f08
	cpl			; $4f09
	ld b,$18		; $4f0a
	ld c,a			; $4f0c
	stop			; $4f0d
	nop			; $4f0e
	ld a,l			; $4f0f
	ld h,b			; $4f10
	cpl			; $4f11
	ld b,$18		; $4f12
	ld c,a			; $4f14
	stop			; $4f15
	nop			; $4f16
	ld a,l			; $4f17
	ld h,c			; $4f18
	cpl			; $4f19
	ld b,$18		; $4f1a
_label_04_122:
	ld c,a			; $4f1c
	stop			; $4f1d
	nop			; $4f1e
	ld a,l			; $4f1f
	ld h,d			; $4f20
	cpl			; $4f21
	ld b,$18		; $4f22
_label_04_123:
	ld c,a			; $4f24
	stop			; $4f25
	nop			; $4f26
	ld a,l			; $4f27
	ld h,e			; $4f28
	cpl			; $4f29
	ld b,$18		; $4f2a
_label_04_124:
	ld d,b			; $4f2c
	jr z,_label_04_125	; $4f2d
_label_04_125:
	ld l,l			; $4f2f
	inc a			; $4f30
	ldd (hl),a		; $4f31
	dec b			; $4f32
	ld a,(de)		; $4f33
_label_04_126:
	ld d,c			; $4f34
	jr z,_label_04_127	; $4f35
_label_04_127:
	ld l,l			; $4f37
	dec a			; $4f38
	ldd (hl),a		; $4f39
	dec b			; $4f3a
	ld a,(de)		; $4f3b
	ld d,d			; $4f3c
	jr z,_label_04_128	; $4f3d
_label_04_128:
	ld l,l			; $4f3f
	ld l,b			; $4f40
	ldd (hl),a		; $4f41
	dec b			; $4f42
	ld a,(de)		; $4f43
_label_04_129:
	ld d,e			; $4f44
	jr z,_label_04_130	; $4f45
_label_04_130:
	ld l,l			; $4f47
	ld a,$32		; $4f48
	dec b			; $4f4a
	ld a,(de)		; $4f4b
_label_04_131:
	ld d,h			; $4f4c
	jr z,_label_04_132	; $4f4d
_label_04_132:
	ld l,l			; $4f4f
	ld l,c			; $4f50
	ldd (hl),a		; $4f51
	dec b			; $4f52
	ld a,(de)		; $4f53
	ld d,l			; $4f54
	jr z,_label_04_133	; $4f55
_label_04_133:
	ld l,l			; $4f57
	ld l,d			; $4f58
	ldd (hl),a		; $4f59
	dec b			; $4f5a
	ld a,(de)		; $4f5b
	ld e,b			; $4f5c
	jr z,_label_04_134	; $4f5d
_label_04_134:
	ld l,l			; $4f5f
	ld l,e			; $4f60
	ldd (hl),a		; $4f61
	ld b,$1a		; $4f62
	ld e,b			; $4f64
	jr z,_label_04_135	; $4f65
_label_04_135:
	ld l,l			; $4f67
	ld l,h			; $4f68
	ldd (hl),a		; $4f69
	ld b,$1a		; $4f6a
	ld e,c			; $4f6c
	jr z,_label_04_136	; $4f6d
_label_04_136:
	ld l,l			; $4f6f
	adc l			; $4f70
	ldd (hl),a		; $4f71
	ld b,$1a		; $4f72
	ld e,a			; $4f74
	jr nz,_label_04_137	; $4f75
_label_04_137:
	ld l,l			; $4f77
	ld l,l			; $4f78
	ldd (hl),a		; $4f79
	ld b,$1a		; $4f7a
	ld e,a			; $4f7c
	jr nz,_label_04_138	; $4f7d
_label_04_138:
	ld l,l			; $4f7f
	ld l,(hl)		; $4f80
	ldd (hl),a		; $4f81
	ld b,$1a		; $4f82
	ld e,a			; $4f84
	jr nz,_label_04_139	; $4f85
_label_04_139:
	ld l,l			; $4f87
	ld l,a			; $4f88
	ldd (hl),a		; $4f89
	ld b,$1a		; $4f8a
	ld e,a			; $4f8c
	jr nz,_label_04_141	; $4f8d
	ld c,b			; $4f8f
	jr nc,_label_04_142	; $4f90
	inc b			; $4f92
	nop			; $4f93
	ld e,c			; $4f94
	jr z,_label_04_140	; $4f95
_label_04_140:
	sub (hl)		; $4f97
	adc l			; $4f98
	ldd (hl),a		; $4f99
	ld b,$ff		; $4f9a
	rrca			; $4f9c
	ld bc,$4001		; $4f9d
	stop			; $4fa0
	nop			; $4fa1
	nop			; $4fa2
	nop			; $4fa3
_label_04_141:
	rrca			; $4fa4
	ld bc,$4101		; $4fa5
_label_04_142:
	ld de,$0100		; $4fa8
	nop			; $4fab
	rrca			; $4fac
	ld bc,$4201		; $4fad
	ld (de),a		; $4fb0
	nop			; $4fb1
	ld (bc),a		; $4fb2
	nop			; $4fb3
	rrca			; $4fb4
	ld bc,$4301		; $4fb5
	inc de			; $4fb8
	nop			; $4fb9
	inc bc			; $4fba
	nop			; $4fbb
	rrca			; $4fbc
	ld bc,$4002		; $4fbd
	stop			; $4fc0
	ld bc,$0000		; $4fc1
	rrca			; $4fc4
	ld bc,$4102		; $4fc5
	ld de,$0101		; $4fc8
	nop			; $4fcb
	rrca			; $4fcc
	ld bc,$4202		; $4fcd
	ld (de),a		; $4fd0
	ld bc,$0002		; $4fd1
	rrca			; $4fd4
	ld bc,$4302		; $4fd5
	inc de			; $4fd8
	ld bc,$0003		; $4fd9
	rrca			; $4fdc
	ld bc,$4003		; $4fdd
	stop			; $4fe0
	ld (bc),a		; $4fe1
	nop			; $4fe2
	nop			; $4fe3
	rrca			; $4fe4
	ld bc,$4103		; $4fe5
	ld de,$0102		; $4fe8
	nop			; $4feb
	rrca			; $4fec
	ld bc,$4203		; $4fed
	ld (de),a		; $4ff0
	ld (bc),a		; $4ff1
	ld (bc),a		; $4ff2
	nop			; $4ff3
	rrca			; $4ff4
	ld bc,$4303		; $4ff5
	inc de			; $4ff8
	ld (bc),a		; $4ff9
	inc bc			; $4ffa
	nop			; $4ffb
	rrca			; $4ffc
	ld bc,$4004		; $4ffd
	stop			; $5000
	inc bc			; $5001
	nop			; $5002
	nop			; $5003
	rrca			; $5004
	ld bc,$4104		; $5005
	ld de,$0103		; $5008
	nop			; $500b
	rrca			; $500c
	ld bc,$4204		; $500d
	ld (de),a		; $5010
	inc bc			; $5011
	ld (bc),a		; $5012
	nop			; $5013
	rrca			; $5014
	ld bc,$4304		; $5015
	inc de			; $5018
	inc bc			; $5019
	inc bc			; $501a
	nop			; $501b
	rrca			; $501c
	ld bc,$4005		; $501d
	stop			; $5020
	dec b			; $5021
	nop			; $5022
	nop			; $5023
	rrca			; $5024
	ld bc,$4105		; $5025
	ld de,$0105		; $5028
	nop			; $502b
	rrca			; $502c
	ld bc,$4205		; $502d
	ld (de),a		; $5030
	dec b			; $5031
	ld (bc),a		; $5032
	nop			; $5033
	rrca			; $5034
	ld bc,$4305		; $5035
	inc de			; $5038
	dec b			; $5039
	inc bc			; $503a
	nop			; $503b
	rrca			; $503c
	ld bc,$4006		; $503d
	inc d			; $5040
	ld b,$00		; $5041
	ld (bc),a		; $5043
	rrca			; $5044
	ld bc,$4106		; $5045
	dec d			; $5048
	ld b,$01		; $5049
	ld (bc),a		; $504b
	rrca			; $504c
	ld bc,$4206		; $504d
	ld d,$06		; $5050
	ld (bc),a		; $5052
	ld (bc),a		; $5053
	rrca			; $5054
	ld bc,$4306		; $5055
	rla			; $5058
	ld b,$03		; $5059
	ld (bc),a		; $505b
	rrca			; $505c
	ld bc,$4007		; $505d
	inc d			; $5060
	rlca			; $5061
	nop			; $5062
	ld bc,$010f		; $5063
	rlca			; $5066
	ld b,c			; $5067
	dec d			; $5068
	rlca			; $5069
	ld bc,$0f01		; $506a
	ld bc,$4207		; $506d
	ld d,$07		; $5070
	ld (bc),a		; $5072
	ld bc,$010f		; $5073
	rlca			; $5076
	ld b,e			; $5077
	rla			; $5078
	rlca			; $5079
	inc bc			; $507a
	ld bc,$010f		; $507b
	ld ($2440),sp		; $507e
	ld ($0000),sp		; $5081
	rrca			; $5084
	ld bc,$4108		; $5085
	dec h			; $5088
	ld ($0001),sp		; $5089
	rrca			; $508c
	ld bc,$4208		; $508d
	ld h,$08		; $5090
	ld (bc),a		; $5092
	nop			; $5093
	rrca			; $5094
	ld bc,$4308		; $5095
	daa			; $5098
	ld ($0003),sp		; $5099
	rrca			; $509c
	ld bc,$4009		; $509d
	stop			; $50a0
	add hl,bc		; $50a1
	nop			; $50a2
	ld (bc),a		; $50a3
	rrca			; $50a4
	ld bc,$4109		; $50a5
	ld de,$0109		; $50a8
	ld (bc),a		; $50ab
	rrca			; $50ac
	ld bc,$4209		; $50ad
	ld (de),a		; $50b0
	add hl,bc		; $50b1
	ld (bc),a		; $50b2
	ld (bc),a		; $50b3
	rrca			; $50b4
	ld bc,$4309		; $50b5
	inc de			; $50b8
	add hl,bc		; $50b9
	inc bc			; $50ba
	ld (bc),a		; $50bb
	rrca			; $50bc
	ld bc,$4009		; $50bd
	jr $09			; $50c0
	nop			; $50c2
	ld (bc),a		; $50c3
	rrca			; $50c4
	ld bc,$4109		; $50c5
	add hl,de		; $50c8
	add hl,bc		; $50c9
	ld bc,$0f02		; $50ca
	ld bc,$4209		; $50cd
	ld a,(de)		; $50d0
	add hl,bc		; $50d1
	ld (bc),a		; $50d2
	ld (bc),a		; $50d3
	rrca			; $50d4
	ld bc,$4309		; $50d5
	dec de			; $50d8
	add hl,bc		; $50d9
	inc bc			; $50da
	ld (bc),a		; $50db
	rrca			; $50dc
	ld bc,$400a		; $50dd
	stop			; $50e0
	ld a,(bc)		; $50e1
	nop			; $50e2
	ld (bc),a		; $50e3
	rrca			; $50e4
	ld bc,$410a		; $50e5
	ld de,$010a		; $50e8
	ld (bc),a		; $50eb
	rrca			; $50ec
	ld bc,$420a		; $50ed
	ld (de),a		; $50f0
	ld a,(bc)		; $50f1
	ld (bc),a		; $50f2
	ld (bc),a		; $50f3
	rrca			; $50f4
	ld bc,$430a		; $50f5
	inc de			; $50f8
	ld a,(bc)		; $50f9
	inc bc			; $50fa
	ld (bc),a		; $50fb
	rrca			; $50fc
	ld bc,$400a		; $50fd
	inc e			; $5100
	ld a,(bc)		; $5101
	nop			; $5102
	ld (bc),a		; $5103
	rrca			; $5104
	ld bc,$410a		; $5105
	dec e			; $5108
	ld a,(bc)		; $5109
	ld bc,$0f02		; $510a
	ld bc,$420a		; $510d
	ld e,$0a		; $5110
	ld (bc),a		; $5112
	ld (bc),a		; $5113
	rrca			; $5114
	ld bc,$430a		; $5115
	rra			; $5118
	ld a,(bc)		; $5119
	inc bc			; $511a
	ld (bc),a		; $511b
	rrca			; $511c
	ld bc,$400b		; $511d
	stop			; $5120
	inc c			; $5121
	nop			; $5122
	ld (bc),a		; $5123
	rrca			; $5124
	ld bc,$410b		; $5125
	ld de,$010c		; $5128
	ld (bc),a		; $512b
	rrca			; $512c
	ld bc,$420b		; $512d
	ld (de),a		; $5130
	inc c			; $5131
	ld (bc),a		; $5132
	ld (bc),a		; $5133
	rrca			; $5134
	ld bc,$430b		; $5135
	inc de			; $5138
	inc c			; $5139
	inc bc			; $513a
	ld (bc),a		; $513b
	rrca			; $513c
	ld bc,$4009		; $513d
	jr nz,_label_04_143	; $5140
	nop			; $5142
	ld (bc),a		; $5143
	rrca			; $5144
	ld bc,$4109		; $5145
	ld hl,$0109		; $5148
_label_04_143:
	ld (bc),a		; $514b
	rrca			; $514c
	ld bc,$4209		; $514d
	ldi (hl),a		; $5150
	add hl,bc		; $5151
	ld (bc),a		; $5152
	ld (bc),a		; $5153
	rrca			; $5154
	ld bc,$4309		; $5155
	inc hl			; $5158
	add hl,bc		; $5159
	inc bc			; $515a
	ld (bc),a		; $515b
	rrca			; $515c
	ld bc,$400c		; $515d
	stop			; $5160
	dec c			; $5161
	nop			; $5162
	nop			; $5163
	rrca			; $5164
	ld bc,$410c		; $5165
	ld de,$010d		; $5168
	nop			; $516b
	rrca			; $516c
	ld bc,$420c		; $516d
	ld (de),a		; $5170
	dec c			; $5171
	ld (bc),a		; $5172
	nop			; $5173
	rrca			; $5174
	ld bc,$430c		; $5175
	inc de			; $5178
	dec c			; $5179
	inc bc			; $517a
	nop			; $517b
	rrca			; $517c
	ld bc,$400d		; $517d
	inc h			; $5180
	ld c,$00		; $5181
	inc bc			; $5183
	rrca			; $5184
	ld bc,$410d		; $5185
	dec h			; $5188
	ld c,$01		; $5189
	inc bc			; $518b
	rrca			; $518c
	ld bc,$420d		; $518d
	ld h,$0e		; $5190
	ld (bc),a		; $5192
	inc bc			; $5193
	rrca			; $5194
	ld bc,$430d		; $5195
	daa			; $5198
	ld c,$03		; $5199
	inc bc			; $519b
	rrca			; $519c
	ld bc,$400e		; $519d
	stop			; $51a0
	rrca			; $51a1
	nop			; $51a2
	inc bc			; $51a3
	rrca			; $51a4
	ld bc,$410e		; $51a5
	ld de,$010f		; $51a8
	inc bc			; $51ab
	rrca			; $51ac
	ld bc,$420e		; $51ad
	ld (de),a		; $51b0
	rrca			; $51b1
	ld (bc),a		; $51b2
	inc bc			; $51b3
	rrca			; $51b4
	ld bc,$430e		; $51b5
	inc de			; $51b8
	rrca			; $51b9
	inc bc			; $51ba
	inc bc			; $51bb
	rrca			; $51bc
	ld bc,$400f		; $51bd
	jr z,_label_04_144	; $51c0
	nop			; $51c2
	rst $38			; $51c3
	rrca			; $51c4
	ld bc,$410f		; $51c5
	add hl,hl		; $51c8
	stop			; $51c9
	ld bc,$0fff		; $51ca
	ld bc,$420f		; $51cd
	ldi a,(hl)		; $51d0
	stop			; $51d1
_label_04_144:
	ld (bc),a		; $51d2
	rst $38			; $51d3
	rrca			; $51d4
	ld bc,$430f		; $51d5
	dec hl			; $51d8
	stop			; $51d9
	inc bc			; $51da
	rst $38			; $51db
	rrca			; $51dc
	ld bc,$4012		; $51dd
	stop			; $51e0
	inc de			; $51e1
	nop			; $51e2
	ld b,$0f		; $51e3
	ld bc,$4112		; $51e5
	ld de,$0113		; $51e8
	ld b,$0f		; $51eb
	ld bc,$4212		; $51ed
	ld (de),a		; $51f0
	inc de			; $51f1
	ld (bc),a		; $51f2
	ld b,$0f		; $51f3
	ld bc,$4312		; $51f5
	inc de			; $51f8
	inc de			; $51f9
	inc bc			; $51fa
	ld b,$0f		; $51fb
	ld bc,$4013		; $51fd
	inc l			; $5200
	inc d			; $5201
	nop			; $5202
	rlca			; $5203
	rrca			; $5204
	ld bc,$4113		; $5205
	dec l			; $5208
	inc d			; $5209
	ld bc,$0f07		; $520a
	ld bc,$4213		; $520d
	ld l,$14		; $5210
	ld (bc),a		; $5212
	rlca			; $5213
	rrca			; $5214
	ld bc,$4313		; $5215
	cpl			; $5218
	inc d			; $5219
	inc bc			; $521a
	rlca			; $521b
	rrca			; $521c
	ld bc,$4014		; $521d
	stop			; $5220
	dec d			; $5221
	nop			; $5222
	ld b,$0f		; $5223
	ld bc,$4114		; $5225
	ld de,$0115		; $5228
	ld b,$0f		; $522b
	ld bc,$4214		; $522d
	ld (de),a		; $5230
	dec d			; $5231
	ld (bc),a		; $5232
	ld b,$0f		; $5233
	ld bc,$4314		; $5235
	inc de			; $5238
	dec d			; $5239
	inc bc			; $523a
	ld b,$0f		; $523b
	ld bc,$4800		; $523d
	jr nc,_label_04_145	; $5240
	nop			; $5242
	nop			; $5243
	rrca			; $5244
	ld bc,$4900		; $5245
	ld sp,$0116		; $5248
	nop			; $524b
	rrca			; $524c
	ld bc,$4a00		; $524d
	ldd (hl),a		; $5250
	ld d,$02		; $5251
	nop			; $5253
	rrca			; $5254
	ld bc,$4b00		; $5255
_label_04_145:
	inc sp			; $5258
	ld d,$03		; $5259
	nop			; $525b
	rrca			; $525c
	ld bc,$4815		; $525d
	jr nc,_label_04_146	; $5260
	nop			; $5262
	nop			; $5263
	rrca			; $5264
	ld bc,$4915		; $5265
	ld sp,$0116		; $5268
	nop			; $526b
	rrca			; $526c
	ld bc,$4a15		; $526d
	ldd (hl),a		; $5270
	ld d,$02		; $5271
	nop			; $5273
	rrca			; $5274
	ld bc,$4b15		; $5275
_label_04_146:
	inc sp			; $5278
	ld d,$03		; $5279
	nop			; $527b
	rrca			; $527c
	ld bc,$4815		; $527d
	jr nc,_label_04_147	; $5280
	nop			; $5282
	ld ($010f),sp		; $5283
	dec d			; $5286
	ld c,c			; $5287
	ld sp,$0116		; $5288
	ld ($010f),sp		; $528b
	dec d			; $528e
	ld c,d			; $528f
	ldd (hl),a		; $5290
	ld d,$02		; $5291
	ld ($010f),sp		; $5293
	dec d			; $5296
	ld c,e			; $5297
_label_04_147:
	inc sp			; $5298
	ld d,$03		; $5299
	ld ($010f),sp		; $529b
	ld d,$48		; $529e
	inc (hl)		; $52a0
	rla			; $52a1
	nop			; $52a2
	nop			; $52a3
	rrca			; $52a4
	ld bc,$4916		; $52a5
	dec (hl)		; $52a8
	rla			; $52a9
	ld bc,$0f00		; $52aa
	ld bc,$4a16		; $52ad
	ld (hl),$17		; $52b0
	ld (bc),a		; $52b2
	nop			; $52b3
	rrca			; $52b4
	ld bc,$4b16		; $52b5
	scf			; $52b8
	rla			; $52b9
	inc bc			; $52ba
	nop			; $52bb
	rrca			; $52bc
	ld bc,$4816		; $52bd
	jr c,_label_04_148	; $52c0
	nop			; $52c2
	nop			; $52c3
	rrca			; $52c4
	ld bc,$4916		; $52c5
	add hl,sp		; $52c8
	rla			; $52c9
	ld bc,$0f00		; $52ca
	ld bc,$4a16		; $52cd
	ldd a,(hl)		; $52d0
	rla			; $52d1
	ld (bc),a		; $52d2
	nop			; $52d3
	rrca			; $52d4
	ld bc,$4b16		; $52d5
	dec sp			; $52d8
_label_04_148:
	rla			; $52d9
	inc bc			; $52da
	nop			; $52db
	rrca			; $52dc
	ld bc,$4c00		; $52dd
	ld h,h			; $52e0
	jr _label_04_149		; $52e1
_label_04_149:
	nop			; $52e3
	rrca			; $52e4
	ld bc,$4c00		; $52e5
	ld h,h			; $52e8
	jr _label_04_150		; $52e9
_label_04_150:
	nop			; $52eb
	rrca			; $52ec
	ld bc,$4d00		; $52ed
	ld h,l			; $52f0
	add hl,de		; $52f1
	ld bc,$0f0a		; $52f2
	ld bc,$4e00		; $52f5
	ld h,(hl)		; $52f8
	ld a,(de)		; $52f9
	ld (bc),a		; $52fa
	dec b			; $52fb
	rrca			; $52fc
	ld bc,$4800		; $52fd
	jr nc,_label_04_151	; $5300
	inc b			; $5302
	ld ($010f),sp		; $5303
	nop			; $5306
	ld c,c			; $5307
	ld sp,$0416		; $5308
	ld ($010f),sp		; $530b
	nop			; $530e
	ld c,d			; $530f
	ldd (hl),a		; $5310
	ld d,$04		; $5311
	ld ($010f),sp		; $5313
	nop			; $5316
	ld c,e			; $5317
_label_04_151:
	inc sp			; $5318
	ld d,$04		; $5319
	ld ($010f),sp		; $531b
	nop			; $531e
	ld c,h			; $531f
	ld h,h			; $5320
	jr $03			; $5321
	nop			; $5323
	rrca			; $5324
	ld bc,$4c00		; $5325
	ld h,h			; $5328
	jr $03			; $5329
	nop			; $532b
	rrca			; $532c
	ld bc,$4d00		; $532d
	ld h,l			; $5330
	add hl,de		; $5331
	inc bc			; $5332
	ld a,(bc)		; $5333
	rrca			; $5334
	ld bc,$4e00		; $5335
	ld h,(hl)		; $5338
	ld a,(de)		; $5339
	inc bc			; $533a
	dec b			; $533b
	ld c,h			; $533c
	ld d,e			; $533d
	ld c,h			; $533e
	ld d,h			; $533f
	ld c,h			; $5340
	ld d,h			; $5341
	ld c,h			; $5342
	ld d,h			; $5343
	ld c,h			; $5344
	ld d,l			; $5345
	ld c,h			; $5346
	ld d,(hl)		; $5347
	ld c,h			; $5348
	ld d,l			; $5349
	ld c,h			; $534a
	ld d,(hl)		; $534b
	ld de,$1091		; $534c
	add hl,de		; $534f
	rla			; $5350
	rla			; $5351
	rla			; $5352
	rla			; $5353
	rra			; $5354
	adc c			; $5355
	add hl,bc		; $5356
	add hl,bc		; $5357
	adc c			; $5358
	dec c			; $5359
	adc c			; $535a
	add hl,bc		; $535b
	stop			; $535c
	stop			; $535d
	stop			; $535e
	add hl,de		; $535f
	ld d,$16		; $5360
	ld d,$16		; $5362
	sbc a			; $5364
	add hl,bc		; $5365
	add hl,bc		; $5366
	add hl,bc		; $5367
	add hl,bc		; $5368
	adc c			; $5369
	adc c			; $536a
	add hl,bc		; $536b
	adc a			; $536c
	stop			; $536d
	stop			; $536e
	add hl,de		; $536f
	ld d,$16		; $5370
	ld d,$16		; $5372
	ld ($0808),sp		; $5374
	ld ($8808),sp		; $5377
	dec c			; $537a
	adc c			; $537b
	rrca			; $537c
	rrca			; $537d
	rrca			; $537e
	jr _label_04_152		; $537f
	rla			; $5381
	ld d,$16		; $5382
	ld ($0808),sp		; $5384
	ld ($0a08),sp		; $5387
	adc d			; $538a
	ld a,(bc)		; $538b
	rrca			; $538c
	rrca			; $538d
	rrca			; $538e
	rrca			; $538f
	jr -$80			; $5390
	ld a,(de)		; $5392
	ld a,(de)		; $5393
	ld a,(de)		; $5394
	ld a,(de)		; $5395
_label_04_152:
	ld a,(de)		; $5396
	ld a,(de)		; $5397
	ld a,(de)		; $5398
	ld a,(bc)		; $5399
	adc d			; $539a
	ld a,(bc)		; $539b
	rrca			; $539c
	rrca			; $539d
	rrca			; $539e
	adc a			; $539f
	ld bc,$1a01		; $53a0
	ld a,(de)		; $53a3
	ld a,(de)		; $53a4
	ld a,(de)		; $53a5
	ld a,(de)		; $53a6
	ld a,(de)		; $53a7
	ld a,(de)		; $53a8
	adc d			; $53a9
	inc c			; $53aa
	adc d			; $53ab
	dec b			; $53ac
	dec b			; $53ad
	dec b			; $53ae
	rlca			; $53af
	add b			; $53b0
	add b			; $53b1
	add b			; $53b2
	nop			; $53b3
	nop			; $53b4
	ld a,(de)		; $53b5
	ld a,(de)		; $53b6
	ld a,(de)		; $53b7
	ld a,(de)		; $53b8
	ld a,(bc)		; $53b9
	adc d			; $53ba
	ld a,(bc)		; $53bb
	dec b			; $53bc
	dec b			; $53bd
	dec b			; $53be
	add l			; $53bf
	nop			; $53c0
	nop			; $53c1
	nop			; $53c2
	nop			; $53c3
	add b			; $53c4
	ld a,(de)		; $53c5
	ld a,(de)		; $53c6
	ld a,(de)		; $53c7
	inc b			; $53c8
	inc b			; $53c9
	inc b			; $53ca
	inc b			; $53cb
	add l			; $53cc
	add l			; $53cd
	add l			; $53ce
	dec b			; $53cf
	nop			; $53d0
	nop			; $53d1
	add b			; $53d2
	nop			; $53d3
	ld bc,$0e80		; $53d4
	add b			; $53d7
	inc b			; $53d8
	inc b			; $53d9
	inc b			; $53da
	inc b			; $53db
	ld b,$06		; $53dc
	ld b,$80		; $53de
	nop			; $53e0
	add b			; $53e1
	inc bc			; $53e2
	add b			; $53e3
	add b			; $53e4
	ld c,$80		; $53e5
	inc b			; $53e7
	inc b			; $53e8
	inc b			; $53e9
	inc b			; $53ea
	inc b			; $53eb
	ld b,$06		; $53ec
	ld b,$00		; $53ee
	add b			; $53f0
	add b			; $53f1
	add b			; $53f2
	add b			; $53f3
	add b			; $53f4
	ld c,$0e		; $53f5
	inc b			; $53f7
	inc b			; $53f8
	inc b			; $53f9
	inc b			; $53fa
	inc b			; $53fb
	ld b,$06		; $53fc
	ld b,$80		; $53fe
	add b			; $5400
	ld bc,$8001		; $5401
	ld c,$0e		; $5404
	add b			; $5406
	add b			; $5407
	add b			; $5408
	dec de			; $5409
	sbc e			; $540a
	dec e			; $540b
	ld b,$06		; $540c
	ld b,$80		; $540e
	add b			; $5410
	ld bc,$8080		; $5411
	ld bc,$801e		; $5414
	nop			; $5417
	nop			; $5418
	dec de			; $5419
	dec de			; $541a
	sbc e			; $541b
	inc de			; $541c
	inc de			; $541d
	ld (de),a		; $541e
	ld (de),a		; $541f
	ld (de),a		; $5420
	ld (de),a		; $5421
	add b			; $5422
	ld bc,$0280		; $5423
	ld (bc),a		; $5426
	add b			; $5427
	dec de			; $5428
	dec de			; $5429
	sbc e			; $542a
	dec de			; $542b
	inc de			; $542c
	inc de			; $542d
	ld (de),a		; $542e
	ld (de),a		; $542f
	sub d			; $5430
	ld (de),a		; $5431
	nop			; $5432
	add b			; $5433
	nop			; $5434
	add b			; $5435
	add b			; $5436
	nop			; $5437
	dec de			; $5438
	sbc e			; $5439
	inc e			; $543a
	sbc e			; $543b
	sub d			; $543c
	ld (de),a		; $543d
	ld (de),a		; $543e
	ld (de),a		; $543f
	inc d			; $5440
	nop			; $5441
	nop			; $5442
	nop			; $5443
	nop			; $5444
	nop			; $5445
	dec de			; $5446
	dec de			; $5447
	dec de			; $5448
	dec de			; $5449
	sbc e			; $544a
	dec de			; $544b
	daa			; $544c
	and h			; $544d
	jr nz,$25		; $544e
	dec h			; $5450
	dec h			; $5451
	inc h			; $5452
	inc h			; $5453
_label_04_153:
	ld hl,$22a1		; $5454
	dec hl			; $5457
	dec hl			; $5458
	add hl,hl		; $5459
	inc h			; $545a
	inc h			; $545b
	and h			; $545c
	inc h			; $545d
	jr nz,_label_04_154	; $545e
	jr nz,_label_04_155	; $5460
	jr nz,_label_04_156	; $5462
	and c			; $5464
	ld hl,$29a1		; $5465
	add hl,hl		; $5468
	add hl,hl		; $5469
	inc h			; $546a
	inc hl			; $546b
	inc h			; $546c
	jr nz,_label_04_157	; $546d
	dec h			; $546f
	dec h			; $5470
	jr nz,_label_04_158	; $5471
	inc h			; $5473
	ld hl,$22a1		; $5474
	add hl,hl		; $5477
	add hl,hl		; $5478
	add hl,hl		; $5479
	inc h			; $547a
	inc hl			; $547b
	inc h			; $547c
	jr nz,_label_04_159	; $547d
	dec h			; $547f
_label_04_154:
	dec h			; $5480
	and a			; $5481
_label_04_155:
	and h			; $5482
	and h			; $5483
	ld hl,$2121		; $5484
	ldi a,(hl)		; $5487
_label_04_156:
	ldi a,(hl)		; $5488
	ldi a,(hl)		; $5489
	ldi a,(hl)		; $548a
	inc h			; $548b
	inc h			; $548c
	jr nz,$20		; $548d
	jr nz,_label_04_160	; $548f
	daa			; $5491
	jr nz,_label_04_161	; $5492
_label_04_157:
	and h			; $5494
	ld h,$a4		; $5495
_label_04_158:
	xor c			; $5497
	xor c			; $5498
	xor c			; $5499
	xor c			; $549a
	inc h			; $549b
	jr nz,$25		; $549c
	dec h			; $549e
_label_04_159:
	jr nz,_label_04_162	; $549f
	jr nz,$20		; $54a1
	inc h			; $54a3
	and h			; $54a4
	ld h,$a6		; $54a5
	add hl,hl		; $54a7
	add hl,hl		; $54a8
	add hl,hl		; $54a9
	add hl,hl		; $54aa
	inc h			; $54ab
	jr z,_label_04_163	; $54ac
	jr nz,_label_04_153	; $54ae
	jr z,_label_04_164	; $54b0
	jr z,_label_04_165	; $54b2
	inc h			; $54b4
	inc h			; $54b5
_label_04_160:
	inc h			; $54b6
	add hl,hl		; $54b7
_label_04_161:
	inc h			; $54b8
	inc h			; $54b9
	inc h			; $54ba
	inc h			; $54bb
	jr z,$28		; $54bc
	inc h			; $54be
	inc h			; $54bf
	jr z,_label_04_166	; $54c0
	jr z,_label_04_167	; $54c2
	inc h			; $54c4
	inc h			; $54c5
_label_04_162:
	inc h			; $54c6
	add hl,hl		; $54c7
	inc h			; $54c8
	inc h			; $54c9
	inc h			; $54ca
	inc h			; $54cb
	inc l			; $54cc
	dec l			; $54cd
_label_04_163:
	dec l			; $54ce
	inc l			; $54cf
	inc l			; $54d0
	inc l			; $54d1
	inc l			; $54d2
	inc l			; $54d3
	inc l			; $54d4
	inc l			; $54d5
	inc (hl)		; $54d6
	inc (hl)		; $54d7
	inc l			; $54d8
	inc l			; $54d9
_label_04_164:
	inc (hl)		; $54da
	inc (hl)		; $54db
_label_04_165:
	inc l			; $54dc
	inc l			; $54dd
	inc l			; $54de
	inc l			; $54df
	dec l			; $54e0
	inc (hl)		; $54e1
	inc (hl)		; $54e2
	inc (hl)		; $54e3
	dec a			; $54e4
	jr nc,_label_04_168	; $54e5
	dec l			; $54e7
	inc l			; $54e8
	inc l			; $54e9
_label_04_166:
	inc (hl)		; $54ea
	inc l			; $54eb
_label_04_167:
	inc (hl)		; $54ec
	inc (hl)		; $54ed
	inc (hl)		; $54ee
	inc l			; $54ef
	inc l			; $54f0
	inc l			; $54f1
	inc l			; $54f2
	inc l			; $54f3
	ld sp,$2f34		; $54f4
	ld sp,$3333		; $54f7
	inc l			; $54fa
	inc l			; $54fb
	inc l			; $54fc
	dec (hl)		; $54fd
	dec (hl)		; $54fe
	inc l			; $54ff
	inc l			; $5500
	inc l			; $5501
	inc l			; $5502
	ld sp,$3232		; $5503
	inc sp			; $5506
	inc l			; $5507
	inc sp			; $5508
	inc sp			; $5509
	inc l			; $550a
	inc l			; $550b
	ld h,c			; $550c
	ld h,c			; $550d
	ld h,c			; $550e
	ld h,c			; $550f
	ld h,c			; $5510
	ld h,c			; $5511
	ld h,c			; $5512
	ld h,c			; $5513
_label_04_168:
	ld h,c			; $5514
	ld h,c			; $5515
	ld h,c			; $5516
	ld h,c			; $5517
	ld h,c			; $5518
	ld h,c			; $5519
	ld h,c			; $551a
	ld h,c			; $551b
	ld h,c			; $551c
	ld h,c			; $551d
	ld h,c			; $551e
	ld h,c			; $551f
	ld h,c			; $5520
	ld h,c			; $5521
	ld h,c			; $5522
	ld h,c			; $5523
	ld h,c			; $5524
	ld h,c			; $5525
	ld h,c			; $5526
	ld h,c			; $5527
	ld h,c			; $5528
	ld h,c			; $5529
	ld h,c			; $552a
	ld h,c			; $552b
	ld h,c			; $552c
	ld h,c			; $552d
	ld h,c			; $552e
	ld h,c			; $552f
	ld h,c			; $5530
	ld h,c			; $5531
	ld h,c			; $5532
	ld h,c			; $5533
	ld h,c			; $5534
	ld h,c			; $5535
	ld h,c			; $5536
	ld h,c			; $5537
	ld h,c			; $5538
	ld h,c			; $5539
	ld h,c			; $553a
	ld h,c			; $553b
	ld h,c			; $553c
	ld h,c			; $553d
	ld h,c			; $553e
	ld h,c			; $553f
	ld h,c			; $5540
	ld h,c			; $5541
	ld h,c			; $5542
	ld h,c			; $5543
	ld h,c			; $5544
	ld h,c			; $5545
	ld h,c			; $5546
	ld h,c			; $5547
	ld h,c			; $5548
	ld h,c			; $5549
	ld h,c			; $554a
	ld h,c			; $554b
	ld (hl),$55		; $554c
	ld (hl),$36		; $554e
	ld (hl),$36		; $5550
	ld (hl),$36		; $5552
	ld (hl),$56		; $5554
	scf			; $5556
	scf			; $5557
	scf			; $5558
	scf			; $5559
	scf			; $555a
	scf			; $555b
	scf			; $555c
	scf			; $555d
	scf			; $555e
	scf			; $555f
	scf			; $5560
	scf			; $5561
	scf			; $5562
	scf			; $5563
	scf			; $5564
	scf			; $5565
	scf			; $5566
	scf			; $5567
	scf			; $5568
	ld d,a			; $5569
	ld d,a			; $556a
	jr c,_label_04_169	; $556b
	jr c,_label_04_170	; $556d
	jr c,_label_04_171	; $556f
	jr c,_label_04_172	; $5571
	jr c,_label_04_173	; $5573
	jr c,_label_04_174	; $5575
	jr c,_label_04_175	; $5577
	jr c,_label_04_176	; $5579
	jr c,_label_04_177	; $557b
	jr c,_label_04_178	; $557d
	jr c,_label_04_179	; $557f
	jr c,_label_04_180	; $5581
	jr c,_label_04_181	; $5583
	jr c,_label_04_182	; $5585
	ld e,b			; $5587
	ld e,b			; $5588
	ld e,b			; $5589
	add hl,sp		; $558a
	add hl,sp		; $558b
	add hl,sp		; $558c
	add hl,sp		; $558d
	add hl,sp		; $558e
	add hl,sp		; $558f
	add hl,sp		; $5590
	add hl,sp		; $5591
	add hl,sp		; $5592
	add hl,sp		; $5593
	add hl,sp		; $5594
	add hl,sp		; $5595
	add hl,sp		; $5596
	add hl,sp		; $5597
	add hl,sp		; $5598
	add hl,sp		; $5599
	add hl,sp		; $559a
	add hl,sp		; $559b
	add hl,sp		; $559c
	add hl,sp		; $559d
	add hl,sp		; $559e
	add hl,sp		; $559f
	add hl,sp		; $55a0
	add hl,sp		; $55a1
	add hl,sp		; $55a2
	add hl,sp		; $55a3
	add hl,sp		; $55a4
_label_04_169:
	add hl,sp		; $55a5
	add hl,sp		; $55a6
_label_04_170:
	add hl,sp		; $55a7
	ld e,c			; $55a8
_label_04_171:
	ld e,c			; $55a9
	ldd a,(hl)		; $55aa
_label_04_172:
	ldd a,(hl)		; $55ab
	ldd a,(hl)		; $55ac
_label_04_173:
	ldd a,(hl)		; $55ad
	ldd a,(hl)		; $55ae
_label_04_174:
	ldd a,(hl)		; $55af
	ldd a,(hl)		; $55b0
_label_04_175:
	ldd a,(hl)		; $55b1
	ldd a,(hl)		; $55b2
_label_04_176:
	ldd a,(hl)		; $55b3
	ldd a,(hl)		; $55b4
_label_04_177:
	ldd a,(hl)		; $55b5
	ldd a,(hl)		; $55b6
_label_04_178:
	ldd a,(hl)		; $55b7
	ldd a,(hl)		; $55b8
_label_04_179:
	ldd a,(hl)		; $55b9
	ldd a,(hl)		; $55ba
_label_04_180:
	ldd a,(hl)		; $55bb
	ldd a,(hl)		; $55bc
_label_04_181:
	ldd a,(hl)		; $55bd
	ldd a,(hl)		; $55be
	ldd a,(hl)		; $55bf
	ldd a,(hl)		; $55c0
	ldd a,(hl)		; $55c1
	ldd a,(hl)		; $55c2
	ldd a,(hl)		; $55c3
	ldd a,(hl)		; $55c4
	ldd a,(hl)		; $55c5
	ldd a,(hl)		; $55c6
	ldd a,(hl)		; $55c7
	ldd a,(hl)		; $55c8
	ldd a,(hl)		; $55c9
	ldd a,(hl)		; $55ca
	ldd a,(hl)		; $55cb
	ldd a,(hl)		; $55cc
	ldd a,(hl)		; $55cd
	ldd a,(hl)		; $55ce
	ldd a,(hl)		; $55cf
	ld e,d			; $55d0
	ld e,d			; $55d1
	ld e,d			; $55d2
	ld e,d			; $55d3
	dec sp			; $55d4
	dec sp			; $55d5
	dec sp			; $55d6
	ld e,d			; $55d7
	dec sp			; $55d8
	dec sp			; $55d9
	dec sp			; $55da
	dec sp			; $55db
	dec sp			; $55dc
	dec sp			; $55dd
	dec sp			; $55de
_label_04_182:
	dec sp			; $55df
	dec sp			; $55e0
	dec sp			; $55e1
	dec sp			; $55e2
	dec sp			; $55e3
	dec sp			; $55e4
	dec sp			; $55e5
	dec sp			; $55e6
	dec sp			; $55e7
	dec sp			; $55e8
	dec sp			; $55e9
	dec sp			; $55ea
	dec sp			; $55eb
	dec sp			; $55ec
	dec sp			; $55ed
	dec sp			; $55ee
	dec sp			; $55ef
	dec sp			; $55f0
	dec sp			; $55f1
	dec sp			; $55f2
	dec sp			; $55f3
	ld e,d			; $55f4
	ld e,d			; $55f5
	inc a			; $55f6
	inc a			; $55f7
	inc a			; $55f8
	inc a			; $55f9
	inc a			; $55fa
	inc a			; $55fb
	inc a			; $55fc
	inc a			; $55fd
	inc a			; $55fe
	inc a			; $55ff
	inc a			; $5600
	inc a			; $5601
	inc a			; $5602
	inc a			; $5603
	inc a			; $5604
	inc a			; $5605
	inc a			; $5606
	inc a			; $5607
	inc a			; $5608
	inc a			; $5609
	inc a			; $560a
	inc a			; $560b
	inc a			; $560c
	inc a			; $560d
	inc a			; $560e
	inc a			; $560f
	inc a			; $5610
	inc a			; $5611
	inc a			; $5612
	inc a			; $5613
	inc a			; $5614
	inc a			; $5615
	inc a			; $5616
	inc a			; $5617
	inc a			; $5618
	inc a			; $5619
	inc a			; $561a
	inc a			; $561b
	inc a			; $561c
	inc a			; $561d
	inc a			; $561e
	inc a			; $561f
	inc a			; $5620
	inc a			; $5621
	inc a			; $5622
	nop			; $5623
	nop			; $5624
	nop			; $5625
	nop			; $5626
	nop			; $5627
	nop			; $5628
	nop			; $5629
	nop			; $562a
	nop			; $562b
	ld c,b			; $562c
	ld c,b			; $562d
	ld c,b			; $562e
	ld c,b			; $562f
	ld c,b			; $5630
	ld c,b			; $5631
	ld c,b			; $5632
	ld c,b			; $5633
	ld c,e			; $5634
	ld c,e			; $5635
	ld c,b			; $5636
	ld c,b			; $5637
	ld c,b			; $5638
	ld c,b			; $5639
	ld c,b			; $563a
	ld c,d			; $563b
	ld c,h			; $563c
	ld c,b			; $563d
	ld c,b			; $563e
	ld c,b			; $563f
	ld c,b			; $5640
	ld c,b			; $5641
	ld c,b			; $5642
	ld c,b			; $5643
	ld c,b			; $5644
	ld c,d			; $5645
	ld c,b			; $5646
	ld c,b			; $5647
	ld c,b			; $5648
	ld c,b			; $5649
	ld c,b			; $564a
	ld c,b			; $564b
	ld a,$4e		; $564c
	ld c,(hl)		; $564e
	ld c,(hl)		; $564f
	ld c,(hl)		; $5650
	ld c,(hl)		; $5651
	ld c,(hl)		; $5652
	ld c,(hl)		; $5653
	ld c,(hl)		; $5654
	ld c,a			; $5655
	ld c,a			; $5656
	ld c,a			; $5657
	ld c,a			; $5658
	ld c,a			; $5659
	ld c,a			; $565a
	ld c,a			; $565b
	ld c,a			; $565c
	ld c,(hl)		; $565d
	ld d,b			; $565e
	ld a,$3e		; $565f
	ld a,$3e		; $5661
	ld a,$3e		; $5663
	ld a,$3e		; $5665
	ld a,$3e		; $5667
	ld a,$3e		; $5669
	ld a,$47		; $566b
	ld b,a			; $566d
	ld b,a			; $566e
	ld b,a			; $566f
	ld b,a			; $5670
	ld b,a			; $5671
	ld b,a			; $5672
	ld b,a			; $5673
	ld b,a			; $5674
	ld b,a			; $5675
	ld b,a			; $5676
	ld b,a			; $5677
	ld b,a			; $5678
	ld b,a			; $5679
	ld b,a			; $567a
	ld b,a			; $567b
	ld b,a			; $567c
	ld b,a			; $567d
	ld b,a			; $567e
	ld b,a			; $567f
	ld b,a			; $5680
	ld a,$3e		; $5681
	ld a,$3e		; $5683
	ld a,$3e		; $5685
	ld a,$3e		; $5687
	ld a,$3e		; $5689
	ccf			; $568b
	ccf			; $568c
	ld a,$40		; $568d
	ld a,$3e		; $568f
	ld a,$3e		; $5691
	ld a,$3e		; $5693
	ld a,$3e		; $5695
	ld a,$3f		; $5697
	ld a,$40		; $5699
	ld a,$3e		; $569b
	ld a,$40		; $569d
	ld b,b			; $569f
	ld b,b			; $56a0
	ld b,b			; $56a1
	ld b,b			; $56a2
	ld b,b			; $56a3
	ld b,b			; $56a4
	ret nz			; $56a5
	ld b,b			; $56a6
	ccf			; $56a7
	ld e,h			; $56a8
	ld e,h			; $56a9
	ld b,d			; $56aa
	ld b,d			; $56ab
	ld e,e			; $56ac
	ld e,e			; $56ad
	ld e,e			; $56ae
	ld b,d			; $56af
	ld b,d			; $56b0
	ld b,d			; $56b1
	ld b,d			; $56b2
	ld b,d			; $56b3
	ld b,d			; $56b4
	ld b,d			; $56b5
	ld b,d			; $56b6
	ld b,d			; $56b7
	ld b,d			; $56b8
	ld b,d			; $56b9
	ld b,d			; $56ba
	ld b,d			; $56bb
	ld b,d			; $56bc
	ld b,d			; $56bd
	ld b,e			; $56be
	ld b,d			; $56bf
	ld b,d			; $56c0
	ld b,c			; $56c1
	ld b,c			; $56c2
	ld b,c			; $56c3
	ld b,c			; $56c4
	ld b,c			; $56c5
	ld b,c			; $56c6
	ld b,c			; $56c7
	ld b,c			; $56c8
	ld b,c			; $56c9
	ld b,c			; $56ca
	ld b,c			; $56cb
	ld b,c			; $56cc
	ld b,c			; $56cd
	ld b,c			; $56ce
	ld b,c			; $56cf
	ld b,c			; $56d0
	ld b,c			; $56d1
	ld b,c			; $56d2
	ld b,c			; $56d3
	ld b,c			; $56d4
	ld b,c			; $56d5
	ld b,c			; $56d6
	ld b,c			; $56d7
	ld b,c			; $56d8
	ld b,c			; $56d9
	ld b,c			; $56da
	ld a,$5d		; $56db
	ld b,h			; $56dd
	ld b,h			; $56de
	ld b,h			; $56df
	ld b,h			; $56e0
	ld b,h			; $56e1
	ld b,h			; $56e2
	ld b,h			; $56e3
	ld b,h			; $56e4
	ld b,l			; $56e5
	ld b,l			; $56e6
	ld b,l			; $56e7
	ld b,l			; $56e8
	ld b,l			; $56e9
	ld b,(hl)		; $56ea
	ld a,$3e		; $56eb
	ld a,$3e		; $56ed
	ld a,$3e		; $56ef
	ld a,$3e		; $56f1
	ld a,$3e		; $56f3
	ld a,$3e		; $56f5
	ld a,$3e		; $56f7
	ld a,$3e		; $56f9
	ld a,$4d		; $56fb
	ld c,l			; $56fd
	ld c,a			; $56fe
	ld c,a			; $56ff
	ld c,a			; $5700
	ld c,a			; $5701
	ld c,a			; $5702
	ld c,a			; $5703
	ld c,a			; $5704
	ld c,a			; $5705
	ld c,a			; $5706
	ld c,a			; $5707
	ld c,a			; $5708
	ld c,a			; $5709
	ld c,a			; $570a
	ld c,a			; $570b
	ld c,a			; $570c
	ld c,a			; $570d
	ld c,a			; $570e
	ld c,a			; $570f
	ld c,a			; $5710
	ld c,a			; $5711
	ld d,b			; $5712
	ld d,b			; $5713
	ld d,b			; $5714
	ld c,a			; $5715
	ld c,a			; $5716
	ld c,a			; $5717
	ld d,b			; $5718
	ld c,a			; $5719
	ld c,a			; $571a
	ld c,l			; $571b
	ld c,a			; $571c
	ld c,a			; $571d
	ld c,a			; $571e
	ld c,a			; $571f
	ld c,l			; $5720
	ld c,a			; $5721
	ld c,a			; $5722
	ld c,a			; $5723
	ld c,a			; $5724
	ld c,a			; $5725
	ld c,a			; $5726
	ld c,a			; $5727
	ld c,a			; $5728
	ld c,a			; $5729
	ld c,a			; $572a
	ld c,a			; $572b
	ld e,a			; $572c
	ld e,a			; $572d
	ld h,b			; $572e
	ld h,b			; $572f
	ld e,a			; $5730
	ld e,a			; $5731
	ld e,a			; $5732
	ld e,a			; $5733
	ld e,a			; $5734
	ld e,a			; $5735
	ld e,a			; $5736
	ld a,$3e		; $5737
	ld a,$3e		; $5739
	ld a,$54		; $573b
	ld d,h			; $573d
	ld d,h			; $573e
	ld d,c			; $573f
	ld d,c			; $5740
	ld d,c			; $5741
	ld d,d			; $5742
	ld d,d			; $5743
	ld d,d			; $5744
	ld d,e			; $5745
	ld d,e			; $5746
	ld d,e			; $5747
	ld a,$3e		; $5748
	ld a,$62		; $574a
	ld a,($cd25)		; $574c
	cp $ff			; $574f
	ret z			; $5751
	call loadAnimationData		; $5752
	call $579a		; $5755
_label_04_183:
	call $5773		; $5758
	jr nz,_label_04_183	; $575b
	ret			; $575d
	ld hl,$cd30		; $575e
	res 6,(hl)		; $5761
	ld a,($cd25)		; $5763
	inc a			; $5766
	ret z			; $5767
	ld a,($cd00)		; $5768
	and $01			; $576b
	ret z			; $576d
	call $5773		; $576e
	jr _label_04_184		; $5771
	ld a,($ccfa)		; $5773
	ld b,a			; $5776
	ld a,($ccfb)		; $5777
	cp b			; $577a
	ret z			; $577b
	inc b			; $577c
	ld a,b			; $577d
	and $1f			; $577e
	ld ($ccfa),a		; $5780
	ld hl,$db90		; $5783
	rst_addAToHl			; $5786
	ld a,$02		; $5787
	ld ($ff00+$70),a	; $5789
	ld b,(hl)		; $578b
	xor a			; $578c
	ld ($ff00+$70),a	; $578d
	ld a,b			; $578f
	call $580f		; $5790
	ld hl,$cd30		; $5793
	set 6,(hl)		; $5796
	or h			; $5798
	ret			; $5799
_label_04_184:
	ld hl,$cd31		; $579a
	ld a,($cd30)		; $579d
	bit 0,a			; $57a0
	call nz,$57cf		; $57a2
	ld hl,$cd34		; $57a5
	ld a,($cd30)		; $57a8
	bit 1,a			; $57ab
	call nz,$57cf		; $57ad
	ld hl,$cd37		; $57b0
	ld a,($cd30)		; $57b3
	bit 2,a			; $57b6
	call nz,$57cf		; $57b8
	ld hl,$cd3a		; $57bb
	ld a,($cd30)		; $57be
	bit 3,a			; $57c1
	call nz,$57cf		; $57c3
	ld a,($cd30)		; $57c6
	and $7f			; $57c9
	ld ($cd30),a		; $57cb
	ret			; $57ce
	ld a,($cd30)		; $57cf
	bit 7,a			; $57d2
	jr nz,_label_04_185	; $57d4
	dec (hl)		; $57d6
	ret nz			; $57d7
_label_04_185:
	push hl			; $57d8
	inc hl			; $57d9
	ldi a,(hl)		; $57da
	ld h,(hl)		; $57db
	ld l,a			; $57dc
	ld e,(hl)		; $57dd
	inc hl			; $57de
	ldi a,(hl)		; $57df
	cp $ff			; $57e0
	jr nz,_label_04_186	; $57e2
	ld b,a			; $57e4
	ld c,(hl)		; $57e5
	add hl,bc		; $57e6
	ldi a,(hl)		; $57e7
_label_04_186:
	ld c,l			; $57e8
	ld b,h			; $57e9
	pop hl			; $57ea
	ldi (hl),a		; $57eb
	ld (hl),c		; $57ec
	inc hl			; $57ed
	ld (hl),b		; $57ee
	ld b,e			; $57ef
	ld a,($ccfb)		; $57f0
	inc a			; $57f3
	and $1f			; $57f4
	ld e,a			; $57f6
	ld a,($ccfa)		; $57f7
	cp e			; $57fa
	ret z			; $57fb
	ld a,e			; $57fc
	ld ($ccfb),a		; $57fd
	ld a,$02		; $5800
	ld ($ff00+$70),a	; $5802
	ld a,e			; $5804
	ld hl,$db90		; $5805
	rst_addAToHl			; $5808
	ld (hl),b		; $5809
	xor a			; $580a
	ld ($ff00+$70),a	; $580b
	or h			; $580d
	ret			; $580e
	ld c,$06		; $580f
	call multiplyAByC		; $5811
	ld bc,$5a48		; $5814
	add hl,bc		; $5817
	ldi a,(hl)		; $5818
	ld c,a			; $5819
	ldi a,(hl)		; $581a
	ld d,a			; $581b
	ldi a,(hl)		; $581c
	ld e,a			; $581d
	push de			; $581e
	ldi a,(hl)		; $581f
	ld d,a			; $5820
	ldi a,(hl)		; $5821
	ld e,a			; $5822
	ld b,(hl)		; $5823
	pop hl			; $5824
	jp queueDmaTransfer		; $5825
	ld l,l			; $5828
	ld h,c			; $5829
	ld d,d			; $582a
	sub (hl)		; $582b
	ld bc,$6e1f		; $582c
	ld c,d			; $582f
	sub b			; $5830
	sub (hl)		; $5831
	ld bc,$ae1f		; $5832
	ld c,h			; $5835
	ldd (hl),a		; $5836
	sub (hl)		; $5837
	ld bc,$2c1f		; $5838
	ld l,d			; $583b
	or l			; $583c
	sub (hl)		; $583d
	ld bc,$6e1f		; $583e
	ld c,(hl)		; $5841
	add hl,hl		; $5842
	sub (hl)		; $5843
	ld bc,$6e1f		; $5844
	ld c,a			; $5847
	rst $8			; $5848
	sub (hl)		; $5849
	ld bc,$ae1f		; $584a
	ld d,c			; $584d
	add h			; $584e
	sub (hl)		; $584f
	ld bc,$ee1f		; $5850
	ld d,e			; $5853
	ld l,b			; $5854
	sub (hl)		; $5855
	ld bc,$009f		; $5856
	ld d,l			; $5859
	xor (hl)		; $585a
	ld d,h			; $585b
	and e			; $585c
	sub (hl)		; $585d
	ld bc,$6e1f		; $585e
	ld d,(hl)		; $5861
	ld h,h			; $5862
	sub (hl)		; $5863
	ld bc,$ae1f		; $5864
	ld e,d			; $5867
.DB $d3				; $5868
	sub (hl)		; $5869
	ld bc,$ae1f		; $586a
	ld e,h			; $586d
	or a			; $586e
	sub (hl)		; $586f
	ld bc,$ee1f		; $5870
	ld e,(hl)		; $5873
	or l			; $5874
	sub (hl)		; $5875
	ld bc,$ee1f		; $5876
	ld h,b			; $5879
	rla			; $587a
	sub (hl)		; $587b
	ld bc,$6e1f		; $587c
	ld h,c			; $587f
	ld d,h			; $5880
	sub (hl)		; $5881
	ld bc,$ae1f		; $5882
	ld h,e			; $5885
	ld (hl),$96		; $5886
	ld bc,$ae1f		; $5888
	ld h,l			; $588b
	inc hl			; $588c
	sub (hl)		; $588d
	ld bc,$ae1f		; $588e
	ld h,(hl)		; $5891
	rst $20			; $5892
	sub (hl)		; $5893
	ld bc,$189f		; $5894
	ld h,a			; $5897
	ld b,b			; $5898
	adc b			; $5899
	pop bc			; $589a
	inc bc			; $589b
	xor (hl)		; $589c
	ld l,b			; $589d
	cp (hl)			; $589e
	sub (hl)		; $589f
	ld bc,$189f		; $58a0
	ld h,a			; $58a3
	ld b,b			; $58a4
	adc b			; $58a5
	pop bc			; $58a6
	inc bc			; $58a7
	ld l,$6a		; $58a8
	and h			; $58aa
	sub (hl)		; $58ab
	ld bc,$6d1f		; $58ac
	ld a,b			; $58af
.DB $e4				; $58b0
	sub (hl)		; $58b1
	ld bc,$ae1f		; $58b2
	ld b,l			; $58b5
	rra			; $58b6
	sub d			; $58b7
	ld bc,$6ebf		; $58b8
	ld c,b			; $58bb
	jp $0196		; $58bc
	rra			; $58bf
	ld l,(hl)		; $58c0
	halt			; $58c1
	ld a,c			; $58c2
	adc e			; $58c3
	ld bc,$aeaf		; $58c4
	ld a,c			; $58c7
	inc e			; $58c8
	adc (hl)		; $58c9
	ld bc,$ae9f		; $58ca
	ld a,d			; $58cd
.DB $e4				; $58ce
	sub b			; $58cf
	ld bc,$eebf		; $58d0
	ld a,(hl)		; $58d3
	ld e,d			; $58d4
	sub h			; $58d5
	ld bc,$af3f		; $58d6
	ld b,c			; $58d9
	adc c			; $58da
	adc e			; $58db
	ld bc,$afaf		; $58dc
	ld b,h			; $58df
	ld h,(hl)		; $58e0
	adc (hl)		; $58e1
	ld bc,$6f9f		; $58e2
	ld b,(hl)		; $58e5
	ld b,a			; $58e6
	sub b			; $58e7
	ld bc,$af9f		; $58e8
	ld c,b			; $58eb
	dec e			; $58ec
	sub l			; $58ed
	or c			; $58ee
	inc h			; $58ef
	ld l,a			; $58f0
	ld c,d			; $58f1
	ld c,b			; $58f2
	sub h			; $58f3
	ld b,c			; $58f4
	dec sp			; $58f5
	ld l,a			; $58f6
	ld c,l			; $58f7
	xor d			; $58f8
	sub h			; $58f9
	pop bc			; $58fa
	inc sp			; $58fb
	ld l,a			; $58fc
	ld d,b			; $58fd
	ld d,b			; $58fe
	sub h			; $58ff
	add c			; $5900
	scf			; $5901
	ld l,a			; $5902
	ld d,e			; $5903
	daa			; $5904
	sub h			; $5905
	ld bc,$6f9f		; $5906
	ld d,h			; $5909
	ld d,l			; $590a
	sub (hl)		; $590b
	ld bc,$ac1f		; $590c
	ld (hl),h		; $590f
	ld de,$418c		; $5910
	cp e			; $5913
	xor h			; $5914
	ld (hl),a		; $5915
	dec a			; $5916
	sub b			; $5917
	ld bc,$acbf		; $5918
	ld a,e			; $591b
	inc bc			; $591c
	sub h			; $591d
	ld bc,$00bf		; $591e
	ld d,d			; $5921
	xor h			; $5922
	ld a,(hl)		; $5923
	adc a			; $5924
	adc a			; $5925
	ld bc,$6c87		; $5926
	ld a,(hl)		; $5929
	call nc,$0190		; $592a
	cp a			; $592d
	ld l,l			; $592e
	ld b,c			; $592f
	or (hl)			; $5930
	sub h			; $5931
	ld bc,$00bf		; $5932
	ld d,d			; $5935
	jr _label_04_187		; $5936
	ld b,b			; $5938
	adc b			; $5939
	add c			; $593a
	rlca			; $593b
.DB $ec				; $593c
	ld h,h			; $593d
	pop hl			; $593e
	sub (hl)		; $593f
	ld bc,$ec1f		; $5940
	ld h,(hl)		; $5943
	ld b,(hl)		; $5944
	sub (hl)		; $5945
	ld bc,$ec1b		; $5946
	ld h,a			; $5949
	and l			; $594a
	sub (hl)		; $594b
	ld bc,$ec1b		; $594c
	ld l,c			; $594f
	ld de,$0196		; $5950
	dec de			; $5953
	nop			; $5954
	ld c,b			; $5955
	nop			; $5956
	ld c,(hl)		; $5957
	nop			; $5958
	ld c,a			; $5959
	nop			; $595a
	ld b,a			; $595b
	nop			; $595c
	ld c,l			; $595d
	jr z,_label_04_188	; $595e
	jr z,_label_04_189	; $5960
	ld l,$58		; $5962
	inc (hl)		; $5964
	ld e,b			; $5965
	ldd a,(hl)		; $5966
	ld e,b			; $5967
	ld b,b			; $5968
	ld e,b			; $5969
	ld b,(hl)		; $596a
	ld e,b			; $596b
	ld c,h			; $596c
	ld e,b			; $596d
	ld d,d			; $596e
	ld e,b			; $596f
	ld e,d			; $5970
	ld e,b			; $5971
	ld h,b			; $5972
	ld e,b			; $5973
	ld h,(hl)		; $5974
	ld e,b			; $5975
	ld l,h			; $5976
	ld e,b			; $5977
	ld (hl),d		; $5978
	ld e,b			; $5979
	ld a,b			; $597a
	ld e,b			; $597b
	ld a,(hl)		; $597c
	ld e,b			; $597d
	add h			; $597e
	ld e,b			; $597f
	adc d			; $5980
	ld e,b			; $5981
	sub b			; $5982
	ld e,b			; $5983
	sbc h			; $5984
	ld e,b			; $5985
	xor b			; $5986
	ld e,b			; $5987
	xor (hl)		; $5988
	ld e,b			; $5989
	or h			; $598a
	ld e,b			; $598b
	ret nz			; $598c
	ld e,b			; $598d
	ret c			; $598e
	ld e,b			; $598f
	ld a,($ff00+$58)	; $5990
	or $58			; $5992
.DB $fc				; $5994
	ld e,b			; $5995
	ld (bc),a		; $5996
	ld e,c			; $5997
	ld c,$59		; $5998
	ldi (hl),a		; $599a
	ld e,c			; $599b
_label_04_187:
	ld (hl),$59		; $599c
	inc a			; $599e
	ld e,c			; $599f
	ld b,d			; $59a0
	ld e,c			; $59a1
	ld c,b			; $59a2
	ld e,c			; $59a3
	ld c,(hl)		; $59a4
	ld e,c			; $59a5
	ld d,h			; $59a6
	ld e,c			; $59a7
	ld d,(hl)		; $59a8
	ld e,c			; $59a9
	ld e,b			; $59aa
	ld e,c			; $59ab
	ld e,d			; $59ac
	ld e,c			; $59ad
	ld e,h			; $59ae
	ld e,c			; $59af
	and $59			; $59b0
.DB $eb				; $59b2
	ld e,c			; $59b3
	ld a,($ff00+$59)	; $59b4
	push af			; $59b6
	ld e,c			; $59b7
_label_04_188:
	ld hl,sp+$59		; $59b8
_label_04_189:
	rst $38			; $59ba
	ld e,c			; $59bb
	inc b			; $59bc
	ld e,d			; $59bd
	and $59			; $59be
	ld c,$5a		; $59c0
	inc de			; $59c2
	ld e,d			; $59c3
	ld d,$5a		; $59c4
	dec e			; $59c6
	ld e,d			; $59c7
	jr nz,_label_04_190	; $59c8
	inc hl			; $59ca
	ld e,d			; $59cb
	ld h,$5a		; $59cc
	and $59			; $59ce
	add hl,hl		; $59d0
	ld e,d			; $59d1
	ld l,$5a		; $59d2
	and $59			; $59d4
	and $59			; $59d6
	and $59			; $59d8
	and $59			; $59da
	and $59			; $59dc
	and $59			; $59de
	inc sp			; $59e0
	ld e,d			; $59e1
	inc a			; $59e2
	ld e,d			; $59e3
	ld b,l			; $59e4
	ld e,d			; $59e5
	add e			; $59e6
	sub h			; $59e7
	ld e,h			; $59e8
	sbc (hl)		; $59e9
	ld e,h			; $59ea
	add e			; $59eb
	sub h			; $59ec
	ld e,h			; $59ed
.DB $e4				; $59ee
	ld e,h			; $59ef
	add e			; $59f0
	sub h			; $59f1
	ld e,h			; $59f2
	xor b			; $59f3
	ld e,h			; $59f4
	add c			; $59f5
	sub h			; $59f6
	ld e,h			; $59f7
	add a			; $59f8
	sub h			; $59f9
	ld e,h			; $59fa
	add $5c			; $59fb
	jp c,$835c		; $59fd
	sub h			; $5a00
	ld e,h			; $5a01
	jp c,$875c		; $5a02
	sub h			; $5a05
	ld e,h			; $5a06
	ret nc			; $5a07
	ld e,h			; $5a08
	cp h			; $5a09
	ld e,h			; $5a0a
	add c			; $5a0b
	sub h			; $5a0c
	ld e,h			; $5a0d
	add e			; $5a0e
	ld hl,sp+$5c		; $5a0f
	ld (bc),a		; $5a11
	ld e,l			; $5a12
	add c			; $5a13
	inc c			; $5a14
	ld e,l			; $5a15
	add a			; $5a16
	sub h			; $5a17
	ld e,h			; $5a18
	xor b			; $5a19
	ld e,h			; $5a1a
	xor $5c			; $5a1b
	add c			; $5a1d
	ld d,$5d		; $5a1e
	add c			; $5a20
	ld a,(de)		; $5a21
	ld e,l			; $5a22
	add c			; $5a23
_label_04_190:
	ld e,$5d		; $5a24
	add c			; $5a26
	inc h			; $5a27
	ld e,l			; $5a28
	add e			; $5a29
	ld l,$5d		; $5a2a
	jr c,_label_04_191	; $5a2c
	add e			; $5a2e
	ld l,$5d		; $5a2f
	ld c,d			; $5a31
	ld e,l			; $5a32
	adc a			; $5a33
	ld e,(hl)		; $5a34
	ld e,l			; $5a35
	ld l,b			; $5a36
	ld e,l			; $5a37
	ld (hl),d		; $5a38
	ld e,l			; $5a39
	add b			; $5a3a
	ld e,l			; $5a3b
	adc a			; $5a3c
	ld e,(hl)		; $5a3d
	ld e,l			; $5a3e
	ld l,b			; $5a3f
	ld e,l			; $5a40
	ld (hl),d		; $5a41
	ld e,l			; $5a42
	adc d			; $5a43
	ld e,l			; $5a44
	add c			; $5a45
	ld d,h			; $5a46
	ld e,l			; $5a47
	jr $65			; $5a48
	ld b,b			; $5a4a
	adc b			; $5a4b
	add c			; $5a4c
	inc bc			; $5a4d
	jr $65			; $5a4e
	add b			; $5a50
	adc b			; $5a51
	add c			; $5a52
	inc bc			; $5a53
	jr $65			; $5a54
	ret nz			; $5a56
	adc b			; $5a57
	add c			; $5a58
	inc bc			; $5a59
	jr _label_04_192		; $5a5a
	nop			; $5a5c
	adc b			; $5a5d
	add c			; $5a5e
	inc bc			; $5a5f
	jr _label_04_193		; $5a60
	ld h,b			; $5a62
	adc b			; $5a63
	pop bc			; $5a64
	ld bc,$6718		; $5a65
	and b			; $5a68
	adc b			; $5a69
	pop bc			; $5a6a
	ld bc,$6718		; $5a6b
	ld ($ff00+$88),a	; $5a6e
	pop bc			; $5a70
	ld bc,$6818		; $5a71
	jr nz,-$78		; $5a74
	pop bc			; $5a76
	ld bc,$6718		; $5a77
	ld b,b			; $5a7a
	sub (hl)		; $5a7b
	ld bc,$1803		; $5a7c
	ld h,a			; $5a7f
	add b			; $5a80
	sub (hl)		; $5a81
	ld bc,$1803		; $5a82
	ld h,a			; $5a85
	ret nz			; $5a86
	sub (hl)		; $5a87
	ld bc,$1803		; $5a88
_label_04_191:
	ld l,b			; $5a8b
	nop			; $5a8c
	sub (hl)		; $5a8d
	ld bc,$1803		; $5a8e
	ld h,a			; $5a91
	ld b,b			; $5a92
	adc b			; $5a93
	pop bc			; $5a94
	inc bc			; $5a95
	jr _label_04_194		; $5a96
	add b			; $5a98
	adc b			; $5a99
	pop bc			; $5a9a
	inc bc			; $5a9b
	jr _label_04_195		; $5a9c
	ret nz			; $5a9e
	adc b			; $5a9f
	pop bc			; $5aa0
	inc bc			; $5aa1
	jr _label_04_196		; $5aa2
	nop			; $5aa4
	adc b			; $5aa5
	pop bc			; $5aa6
	inc bc			; $5aa7
	jr _label_04_197		; $5aa8
	ld b,b			; $5aaa
	adc b			; $5aab
	pop bc			; $5aac
	inc bc			; $5aad
	jr _label_04_198		; $5aae
	add b			; $5ab0
	adc b			; $5ab1
	pop bc			; $5ab2
	inc bc			; $5ab3
	jr _label_04_199		; $5ab4
	ret nz			; $5ab6
	adc b			; $5ab7
	pop bc			; $5ab8
	inc bc			; $5ab9
	jr _label_04_200		; $5aba
	nop			; $5abc
	adc b			; $5abd
	pop bc			; $5abe
	inc bc			; $5abf
	jr _label_04_201		; $5ac0
_label_04_192:
	ld b,b			; $5ac2
	sub (hl)		; $5ac3
	add c			; $5ac4
	ld bc,$6918		; $5ac5
	ld h,b			; $5ac8
_label_04_193:
	sub (hl)		; $5ac9
	add c			; $5aca
	ld bc,$6918		; $5acb
	add b			; $5ace
	sub (hl)		; $5acf
	add c			; $5ad0
	ld bc,$6918		; $5ad1
	and b			; $5ad4
	sub (hl)		; $5ad5
	add c			; $5ad6
	ld bc,$6918		; $5ad7
	ld b,b			; $5ada
	sub (hl)		; $5adb
	ld sp,$1801		; $5adc
	ld l,c			; $5adf
	ld h,b			; $5ae0
	sub (hl)		; $5ae1
	ld sp,$1801		; $5ae2
	ld l,c			; $5ae5
	add b			; $5ae6
	sub (hl)		; $5ae7
	ld sp,$1801		; $5ae8
	ld l,c			; $5aeb
	and b			; $5aec
	sub (hl)		; $5aed
	ld sp,$1801		; $5aee
	ld l,b			; $5af1
	ld b,b			; $5af2
	adc b			; $5af3
	pop bc			; $5af4
	inc bc			; $5af5
	jr _label_04_204		; $5af6
	add b			; $5af8
	adc b			; $5af9
	pop bc			; $5afa
	inc bc			; $5afb
	jr _label_04_205		; $5afc
	ret nz			; $5afe
_label_04_194:
	adc b			; $5aff
	pop bc			; $5b00
	inc bc			; $5b01
	jr _label_04_206		; $5b02
	nop			; $5b04
_label_04_195:
	adc b			; $5b05
	pop bc			; $5b06
	inc bc			; $5b07
	jr _label_04_207		; $5b08
	nop			; $5b0a
	adc b			; $5b0b
_label_04_196:
	pop bc			; $5b0c
	inc bc			; $5b0d
	jr _label_04_208		; $5b0e
_label_04_197:
	ld b,b			; $5b10
	adc b			; $5b11
	pop bc			; $5b12
	inc bc			; $5b13
	jr _label_04_209		; $5b14
_label_04_198:
	add b			; $5b16
	adc b			; $5b17
	pop bc			; $5b18
	inc bc			; $5b19
	jr _label_04_210		; $5b1a
_label_04_199:
	ret nz			; $5b1c
	adc b			; $5b1d
	pop bc			; $5b1e
	inc bc			; $5b1f
	jr _label_04_211		; $5b20
	nop			; $5b22
_label_04_200:
	sub e			; $5b23
	add c			; $5b24
	inc bc			; $5b25
	jr _label_04_212		; $5b26
	ld b,b			; $5b28
	sub e			; $5b29
	add c			; $5b2a
_label_04_201:
	inc bc			; $5b2b
_label_04_202:
	jr _label_04_213		; $5b2c
	add b			; $5b2e
	sub e			; $5b2f
	add c			; $5b30
	inc bc			; $5b31
_label_04_203:
	jr _label_04_214		; $5b32
	ret nz			; $5b34
	sub e			; $5b35
	add c			; $5b36
	inc bc			; $5b37
	jr _label_04_215		; $5b38
	ld ($ff00+$88),a	; $5b3a
	and c			; $5b3c
	inc b			; $5b3d
	jr $6a			; $5b3e
	ld (hl),b		; $5b40
	adc b			; $5b41
	and c			; $5b42
	inc b			; $5b43
	jr _label_04_216		; $5b44
	nop			; $5b46
	adc b			; $5b47
	and c			; $5b48
	inc b			; $5b49
	jr _label_04_217		; $5b4a
	sub b			; $5b4c
	adc b			; $5b4d
	and c			; $5b4e
	inc b			; $5b4f
	jr _label_04_218		; $5b50
	ret nz			; $5b52
	adc b			; $5b53
	add c			; $5b54
	ld bc,$6a18		; $5b55
	ld d,b			; $5b58
	adc b			; $5b59
	add c			; $5b5a
	ld bc,$6a18		; $5b5b
	ld ($ff00+$88),a	; $5b5e
_label_04_204:
	add c			; $5b60
	ld bc,$6b18		; $5b61
	ld (hl),b		; $5b64
	adc b			; $5b65
_label_04_205:
	add c			; $5b66
	ld bc,$6918		; $5b67
	ret nz			; $5b6a
	adc b			; $5b6b
	add c			; $5b6c
_label_04_206:
	inc bc			; $5b6d
	jr $6a			; $5b6e
	ld d,b			; $5b70
	adc b			; $5b71
	add c			; $5b72
	inc bc			; $5b73
	jr $6a			; $5b74
_label_04_207:
	ld ($ff00+$88),a	; $5b76
	add c			; $5b78
	inc bc			; $5b79
	jr _label_04_220		; $5b7a
_label_04_208:
	ld (hl),b		; $5b7c
	adc b			; $5b7d
	add c			; $5b7e
	inc bc			; $5b7f
	jr $64			; $5b80
_label_04_209:
	ld b,b			; $5b82
	adc b			; $5b83
	add c			; $5b84
	rlca			; $5b85
	jr $64			; $5b86
_label_04_210:
	ret nz			; $5b88
	adc b			; $5b89
	add c			; $5b8a
	rlca			; $5b8b
	jr $64			; $5b8c
_label_04_211:
	nop			; $5b8e
	sub b			; $5b8f
	sub c			; $5b90
	nop			; $5b91
	jr $64			; $5b92
_label_04_212:
	stop			; $5b94
	sub b			; $5b95
	sub c			; $5b96
	nop			; $5b97
	jr $64			; $5b98
_label_04_213:
	jr nz,_label_04_202	; $5b9a
	sub c			; $5b9c
	nop			; $5b9d
	jr $64			; $5b9e
_label_04_214:
	jr nc,_label_04_203	; $5ba0
	sub c			; $5ba2
_label_04_215:
	nop			; $5ba3
	jr _label_04_221		; $5ba4
	add b			; $5ba6
	adc l			; $5ba7
	add c			; $5ba8
	ld b,$18		; $5ba9
	ld (hl),d		; $5bab
	add b			; $5bac
	adc l			; $5bad
	add c			; $5bae
	ld b,$18		; $5baf
_label_04_216:
	ld (hl),e		; $5bb1
	add b			; $5bb2
	adc l			; $5bb3
	add c			; $5bb4
	ld b,$18		; $5bb5
_label_04_217:
	ld (hl),h		; $5bb7
	add b			; $5bb8
	adc l			; $5bb9
	add c			; $5bba
_label_04_218:
	ld b,$18		; $5bbb
	ld (hl),c		; $5bbd
	ldh a,(<hFF8D)	; $5bbe
	pop af			; $5bc0
	nop			; $5bc1
	jr _label_04_222		; $5bc2
	ldh a,(<hFF8D)	; $5bc4
	pop af			; $5bc6
_label_04_219:
	nop			; $5bc7
	jr $73			; $5bc8
	ldh a,(<hFF8D)	; $5bca
	pop af			; $5bcc
	nop			; $5bcd
	jr _label_04_223		; $5bce
	ldh a,(<hFF8D)	; $5bd0
	pop af			; $5bd2
	nop			; $5bd3
	jr _label_04_224		; $5bd4
	nop			; $5bd6
	adc a			; $5bd7
	ld bc,$1800		; $5bd8
	ld (hl),e		; $5bdb
	nop			; $5bdc
	adc a			; $5bdd
	ld bc,$1800		; $5bde
	ld (hl),h		; $5be1
	nop			; $5be2
	adc a			; $5be3
	ld bc,$1800		; $5be4
_label_04_220:
	ld (hl),l		; $5be7
	nop			; $5be8
	adc a			; $5be9
	ld bc,$1800		; $5bea
	ld (hl),d		; $5bed
	nop			; $5bee
	adc a			; $5bef
	ld bc,$1804		; $5bf0
	ld (hl),e		; $5bf3
	nop			; $5bf4
	adc a			; $5bf5
	ld bc,$1804		; $5bf6
	ld (hl),h		; $5bf9
	nop			; $5bfa
	adc a			; $5bfb
	ld bc,$1804		; $5bfc
	ld (hl),l		; $5bff
	nop			; $5c00
	adc a			; $5c01
	ld bc,$1804		; $5c02
	ld l,l			; $5c05
	nop			; $5c06
	adc c			; $5c07
	ld bc,$180a		; $5c08
	ld l,l			; $5c0b
	or b			; $5c0c
	adc c			; $5c0d
	ld bc,$180a		; $5c0e
	ld l,(hl)		; $5c11
	ld h,b			; $5c12
	adc c			; $5c13
	ld bc,$180a		; $5c14
_label_04_221:
	ld l,a			; $5c17
	stop			; $5c18
	adc c			; $5c19
	ld bc,$180a		; $5c1a
	ld l,a			; $5c1d
	ret nz			; $5c1e
	adc c			; $5c1f
	or c			; $5c20
	nop			; $5c21
	jr $6f			; $5c22
	ret nc			; $5c24
	adc c			; $5c25
	or c			; $5c26
	nop			; $5c27
	jr $6f			; $5c28
	ld ($ff00+$89),a	; $5c2a
	or c			; $5c2c
	nop			; $5c2d
	jr _label_04_225		; $5c2e
	ld a,($ff00+$89)	; $5c30
	or c			; $5c32
	nop			; $5c33
	jr _label_04_226		; $5c34
_label_04_222:
	nop			; $5c36
	adc c			; $5c37
	pop bc			; $5c38
	ld bc,$7018		; $5c39
	jr nz,_label_04_219	; $5c3c
	pop bc			; $5c3e
	ld bc,$7018		; $5c3f
	ld b,b			; $5c42
	adc c			; $5c43
_label_04_223:
	pop bc			; $5c44
	ld bc,$7018		; $5c45
_label_04_224:
	ld h,b			; $5c48
	adc c			; $5c49
	pop bc			; $5c4a
	ld bc,$7018		; $5c4b
	add b			; $5c4e
	adc c			; $5c4f
	pop hl			; $5c50
	ld bc,$7018		; $5c51
	and b			; $5c54
	adc c			; $5c55
	pop hl			; $5c56
	ld bc,$7018		; $5c57
	ret nz			; $5c5a
	adc c			; $5c5b
	pop hl			; $5c5c
	ld bc,$7018		; $5c5d
	ld ($ff00+$89),a	; $5c60
	pop hl			; $5c62
	ld bc,$7118		; $5c63
	nop			; $5c66
	adc c			; $5c67
	pop hl			; $5c68
	ld bc,$7118		; $5c69
	jr nz,-$77		; $5c6c
	pop hl			; $5c6e
	ld bc,$7118		; $5c6f
	ld b,b			; $5c72
	adc c			; $5c73
	pop hl			; $5c74
	ld bc,$7118		; $5c75
	ld h,b			; $5c78
	adc c			; $5c79
	pop hl			; $5c7a
	ld bc,$7518		; $5c7b
	add b			; $5c7e
	adc l			; $5c7f
	ld bc,$180d		; $5c80
	halt			; $5c83
	add b			; $5c84
	adc l			; $5c85
	ld bc,$180d		; $5c86
	ld (hl),a		; $5c89
	add b			; $5c8a
	adc l			; $5c8b
	ld bc,$180d		; $5c8c
	ld a,b			; $5c8f
	add b			; $5c90
	adc l			; $5c91
	ld bc,$0f0d		; $5c92
	nop			; $5c95
	rrca			; $5c96
	ld bc,$020f		; $5c97
	rrca			; $5c9a
	inc bc			; $5c9b
	rst $38			; $5c9c
	rst $30			; $5c9d
	rrca			; $5c9e
_label_04_225:
	inc b			; $5c9f
	rrca			; $5ca0
	dec b			; $5ca1
	rrca			; $5ca2
	ld b,$0f		; $5ca3
	rlca			; $5ca5
_label_04_226:
	rst $38			; $5ca6
	rst $30			; $5ca7
	ld ($0810),sp		; $5ca8
	ld de,$1208		; $5cab
	ld ($ff13),sp		; $5cae
	rst $30			; $5cb1
	rrca			; $5cb2
	inc d			; $5cb3
	rrca			; $5cb4
	dec d			; $5cb5
	rrca			; $5cb6
	ld d,$0f		; $5cb7
	rla			; $5cb9
	rst $38			; $5cba
	rst $30			; $5cbb
	rrca			; $5cbc
	jr _label_04_227		; $5cbd
	add hl,de		; $5cbf
	rrca			; $5cc0
	ld a,(de)		; $5cc1
	rrca			; $5cc2
	dec de			; $5cc3
	rst $38			; $5cc4
	rst $30			; $5cc5
	rrca			; $5cc6
	ld (_mainLoop),sp		; $5cc7
	rrca			; $5cca
	ld a,(bc)		; $5ccb
	rrca			; $5ccc
	dec bc			; $5ccd
_label_04_227:
	rst $38			; $5cce
	rst $30			; $5ccf
	rrca			; $5cd0
	inc c			; $5cd1
	rrca			; $5cd2
	dec c			; $5cd3
	rrca			; $5cd4
	ld c,$0f		; $5cd5
	rrca			; $5cd7
	rst $38			; $5cd8
	rst $30			; $5cd9
	inc b			; $5cda
	inc e			; $5cdb
	inc b			; $5cdc
	dec e			; $5cdd
	inc b			; $5cde
	ld e,$04		; $5cdf
	rra			; $5ce1
	rst $38			; $5ce2
	rst $30			; $5ce3
	ld b,$20		; $5ce4
	ld b,$21		; $5ce6
	ld b,$22		; $5ce8
	ld b,$23		; $5cea
	rst $38			; $5cec
	rst $30			; $5ced
	ld b,$24		; $5cee
	ld b,$25		; $5cf0
	ld b,$26		; $5cf2
	ld b,$27		; $5cf4
	rst $38			; $5cf6
	rst $30			; $5cf7
	rrca			; $5cf8
	jr z,_label_04_228	; $5cf9
	add hl,hl		; $5cfb
	rrca			; $5cfc
	ldi a,(hl)		; $5cfd
	rrca			; $5cfe
	dec hl			; $5cff
	rst $38			; $5d00
	rst $30			; $5d01
	ld ($082c),sp		; $5d02
	dec l			; $5d05
	ld ($082e),sp		; $5d06
	cpl			; $5d09
_label_04_228:
	rst $38			; $5d0a
	rst $30			; $5d0b
	rrca			; $5d0c
	jr nc,_label_04_229	; $5d0d
	ld sp,$320f		; $5d0f
	rrca			; $5d12
	inc sp			; $5d13
	rst $38			; $5d14
	rst $30			; $5d15
	rrca			; $5d16
	inc (hl)		; $5d17
	rst $38			; $5d18
.DB $fd				; $5d19
	rrca			; $5d1a
	dec (hl)		; $5d1b
	rst $38			; $5d1c
.DB $fd				; $5d1d
_label_04_229:
	rrca			; $5d1e
	inc (hl)		; $5d1f
	rrca			; $5d20
	dec (hl)		; $5d21
	rst $38			; $5d22
	ei			; $5d23
	ld (bc),a		; $5d24
	ld (hl),$02		; $5d25
	scf			; $5d27
	ld (bc),a		; $5d28
	jr c,_label_04_230	; $5d29
	add hl,sp		; $5d2b
	rst $38			; $5d2c
_label_04_230:
	rst $30			; $5d2d
	rrca			; $5d2e
	ldd a,(hl)		; $5d2f
	rrca			; $5d30
	dec sp			; $5d31
	rrca			; $5d32
	inc a			; $5d33
	rrca			; $5d34
	dec a			; $5d35
	rst $38			; $5d36
	rst $30			; $5d37
	inc b			; $5d38
	ld a,$04		; $5d39
	ld b,d			; $5d3b
	inc b			; $5d3c
	ccf			; $5d3d
	inc b			; $5d3e
	ld b,e			; $5d3f
	inc b			; $5d40
	ld b,b			; $5d41
	inc b			; $5d42
	ld b,h			; $5d43
	inc b			; $5d44
	ld b,c			; $5d45
	inc b			; $5d46
	ld b,l			; $5d47
	rst $38			; $5d48
	rst $28			; $5d49
	rrca			; $5d4a
	ld b,(hl)		; $5d4b
	rrca			; $5d4c
	ld b,a			; $5d4d
	rrca			; $5d4e
	ld c,b			; $5d4f
	rrca			; $5d50
	ld c,c			; $5d51
	rst $38			; $5d52
	rst $30			; $5d53
	ld e,$5e		; $5d54
	ld e,$5f		; $5d56
	ld e,$60		; $5d58
	ld e,$61		; $5d5a
	rst $38			; $5d5c
	rst $30			; $5d5d
	rrca			; $5d5e
	ld c,d			; $5d5f
	rrca			; $5d60
	ld c,e			; $5d61
	rrca			; $5d62
	ld c,h			; $5d63
	rrca			; $5d64
	ld c,l			; $5d65
	rst $38			; $5d66
	rst $30			; $5d67
	ld ($084e),sp		; $5d68
	ld c,a			; $5d6b
	ld ($0850),sp		; $5d6c
	ld d,c			; $5d6f
	rst $38			; $5d70
	rst $30			; $5d71
	rrca			; $5d72
	ld d,d			; $5d73
	rrca			; $5d74
	ld d,e			; $5d75
	rrca			; $5d76
	ld d,h			; $5d77
	rrca			; $5d78
	ld d,l			; $5d79
	rrca			; $5d7a
	ld d,h			; $5d7b
	rrca			; $5d7c
	ld d,e			; $5d7d
	rst $38			; $5d7e
	di			; $5d7f
	rrca			; $5d80
	ld d,(hl)		; $5d81
	rrca			; $5d82
	ld d,a			; $5d83
	rrca			; $5d84
	ld e,b			; $5d85
	rrca			; $5d86
	ld e,c			; $5d87
	rst $38			; $5d88
	rst $30			; $5d89
	rrca			; $5d8a
	ld e,d			; $5d8b
	rrca			; $5d8c
	ld e,e			; $5d8d
	rrca			; $5d8e
	ld e,h			; $5d8f
	rrca			; $5d90
	ld e,l			; $5d91
	rst $38			; $5d92
	rst $30			; $5d93
	call $5fda		; $5d94
	call $5de8		; $5d97
	call $5f53		; $5d9a
	ld a,($cc49)		; $5d9d
	cp $02			; $5da0
	jr z,_label_04_232	; $5da2
	cp $04			; $5da4
	jr nc,_label_04_231	; $5da6
	call $5dbc		; $5da8
	jp $60ab		; $5dab
_label_04_231:
	call $5ebd		; $5dae
	call $5f62		; $5db1
	jp $60ab		; $5db4
_label_04_232:
	ld e,$03		; $5db7
	jp loadObjectGfxHeaderToSlot4		; $5db9
	ld a,($c63a)		; $5dbc
	cp $01			; $5dbf
	ret nz			; $5dc1
	ld e,$06		; $5dc2
	jp loadObjectGfxHeaderToSlot4		; $5dc4
_label_04_233:
	ld a,(de)		; $5dc7
	or a			; $5dc8
	ret z			; $5dc9
	ld b,a			; $5dca
	inc de			; $5dcb
	ld a,(de)		; $5dcc
	inc de			; $5dcd
	call findTileInRoom		; $5dce
	jr nz,_label_04_233	; $5dd1
	ld (hl),b		; $5dd3
	ld c,a			; $5dd4
	ld a,l			; $5dd5
	or a			; $5dd6
	jr z,_label_04_233	; $5dd7
_label_04_234:
	dec l			; $5dd9
	ld a,c			; $5dda
	call backwardsSearch		; $5ddb
	jr nz,_label_04_233	; $5dde
	ld (hl),b		; $5de0
	ld c,a			; $5de1
	ld a,l			; $5de2
	or a			; $5de3
	jr z,_label_04_233	; $5de4
	jr _label_04_234		; $5de6
	call getThisRoomFlags		; $5de8
	ldh (<hFF8B),a	; $5deb
	ld hl,$5e26		; $5ded
	bit 0,a			; $5df0
	call nz,$5e1b		; $5df2
	ld hl,$5e36		; $5df5
	ldh a,(<hFF8B)	; $5df8
	bit 1,a			; $5dfa
	call nz,$5e1b		; $5dfc
	ld hl,$5e46		; $5dff
	ldh a,(<hFF8B)	; $5e02
	bit 2,a			; $5e04
	call nz,$5e1b		; $5e06
	ld hl,$5e56		; $5e09
	ldh a,(<hFF8B)	; $5e0c
	bit 3,a			; $5e0e
	call nz,$5e1b		; $5e10
	ld hl,$5e66		; $5e13
	ldh a,(<hFF8B)	; $5e16
	bit 7,a			; $5e18
	ret z			; $5e1a
	ld a,($cc49)		; $5e1b
	rst_addDoubleIndex			; $5e1e
	ldi a,(hl)		; $5e1f
	ld h,(hl)		; $5e20
	ld l,a			; $5e21
	ld e,l			; $5e22
	ld d,h			; $5e23
	jr _label_04_233		; $5e24
	halt			; $5e26
	ld e,(hl)		; $5e27
	halt			; $5e28
	ld e,(hl)		; $5e29
	halt			; $5e2a
	ld e,(hl)		; $5e2b
	ld (hl),a		; $5e2c
	ld e,(hl)		; $5e2d
	ld (hl),a		; $5e2e
	ld e,(hl)		; $5e2f
	ld (hl),a		; $5e30
	ld e,(hl)		; $5e31
	add b			; $5e32
	ld e,(hl)		; $5e33
	add b			; $5e34
	ld e,(hl)		; $5e35
	add c			; $5e36
	ld e,(hl)		; $5e37
	add c			; $5e38
	ld e,(hl)		; $5e39
	add c			; $5e3a
	ld e,(hl)		; $5e3b
	add d			; $5e3c
	ld e,(hl)		; $5e3d
	add d			; $5e3e
	ld e,(hl)		; $5e3f
	add d			; $5e40
	ld e,(hl)		; $5e41
	adc d			; $5e42
	ld e,(hl)		; $5e43
	adc d			; $5e44
	ld e,(hl)		; $5e45
	adc e			; $5e46
	ld e,(hl)		; $5e47
	adc e			; $5e48
	ld e,(hl)		; $5e49
	adc e			; $5e4a
	ld e,(hl)		; $5e4b
	adc h			; $5e4c
	ld e,(hl)		; $5e4d
	adc h			; $5e4e
	ld e,(hl)		; $5e4f
	adc h			; $5e50
	ld e,(hl)		; $5e51
	sub h			; $5e52
	ld e,(hl)		; $5e53
	sub h			; $5e54
	ld e,(hl)		; $5e55
	sub l			; $5e56
	ld e,(hl)		; $5e57
	sub l			; $5e58
	ld e,(hl)		; $5e59
	sub l			; $5e5a
	ld e,(hl)		; $5e5b
	sub (hl)		; $5e5c
	ld e,(hl)		; $5e5d
	sub (hl)		; $5e5e
	ld e,(hl)		; $5e5f
	sub (hl)		; $5e60
	ld e,(hl)		; $5e61
	sbc (hl)		; $5e62
	ld e,(hl)		; $5e63
	sbc (hl)		; $5e64
	ld e,(hl)		; $5e65
	sbc a			; $5e66
	ld e,(hl)		; $5e67
	xor l			; $5e68
	ld e,(hl)		; $5e69
	xor (hl)		; $5e6a
	ld e,(hl)		; $5e6b
	xor a			; $5e6c
	ld e,(hl)		; $5e6d
	or b			; $5e6e
	ld e,(hl)		; $5e6f
	or b			; $5e70
	ld e,(hl)		; $5e71
	cp h			; $5e72
	ld e,(hl)		; $5e73
	cp h			; $5e74
	ld e,(hl)		; $5e75
	nop			; $5e76
	inc (hl)		; $5e77
	jr nc,_label_04_235	; $5e78
	jr c,-$60		; $5e7a
	ld (hl),b		; $5e7c
	and b			; $5e7d
	ld (hl),h		; $5e7e
	nop			; $5e7f
	nop			; $5e80
	nop			; $5e81
	dec (hl)		; $5e82
	ld sp,$3935		; $5e83
	and b			; $5e86
	ld (hl),c		; $5e87
	and b			; $5e88
	ld (hl),l		; $5e89
	nop			; $5e8a
	nop			; $5e8b
	ld (hl),$32		; $5e8c
	ld (hl),$3a		; $5e8e
	and b			; $5e90
	ld (hl),d		; $5e91
	and b			; $5e92
	halt			; $5e93
	nop			; $5e94
	nop			; $5e95
	scf			; $5e96
	inc sp			; $5e97
	scf			; $5e98
	dec sp			; $5e99
	and b			; $5e9a
	ld (hl),e		; $5e9b
	and b			; $5e9c
	ld (hl),a		; $5e9d
	nop			; $5e9e
	rst $20			; $5e9f
	pop bc			; $5ea0
	ld ($ff00+$c6),a	; $5ea1
	ld ($ff00+$c2),a	; $5ea3
	ld ($ff00+$e3),a	; $5ea5
	and $c5			; $5ea7
	rst $20			; $5ea9
	set 5,b			; $5eaa
	ld ($ff00+c),a		; $5eac
	nop			; $5ead
_label_04_235:
	nop			; $5eae
	nop			; $5eaf
	and b			; $5eb0
	ld e,$44		; $5eb1
	ld b,d			; $5eb3
	ld b,l			; $5eb4
	ld b,e			; $5eb5
	ld b,(hl)		; $5eb6
	ld b,b			; $5eb7
	ld b,a			; $5eb8
	ld b,c			; $5eb9
	ld b,l			; $5eba
	adc l			; $5ebb
	nop			; $5ebc
	ld a,($cc55)		; $5ebd
	inc a			; $5ec0
	ret z			; $5ec1
	ld bc,$cfae		; $5ec2
_label_04_236:
	ld a,(bc)		; $5ec5
	push bc			; $5ec6
	sub $78			; $5ec7
	cp $08			; $5ec9
	call c,$5ed3		; $5ecb
	pop bc			; $5ece
	dec c			; $5ecf
	jr nz,_label_04_236	; $5ed0
	ret			; $5ed2
	ld de,$5f43		; $5ed3
	call addDoubleIndexToDe		; $5ed6
	ld a,(de)		; $5ed9
	ldh (<hFF8B),a	; $5eda
	inc de			; $5edc
	ld a,(de)		; $5edd
	ld e,a			; $5ede
	ld a,($cd00)		; $5edf
	and $08			; $5ee2
	jr z,_label_04_242	; $5ee4
	ld a,($cc48)		; $5ee6
	ld h,a			; $5ee9
	ld a,($cd02)		; $5eea
	xor $02			; $5eed
	ld d,a			; $5eef
	ld a,e			; $5ef0
	and $03			; $5ef1
	cp d			; $5ef3
	ret nz			; $5ef4
	ld a,($cd02)		; $5ef5
	bit 0,a			; $5ef8
	jr nz,_label_04_238	; $5efa
	and $02			; $5efc
	ld l,$0d		; $5efe
	ld a,(hl)		; $5f00
	jr nz,_label_04_237	; $5f01
	and $f0			; $5f03
	swap a			; $5f05
	or $a0			; $5f07
	jr _label_04_240		; $5f09
_label_04_237:
	and $f0			; $5f0b
	swap a			; $5f0d
	jr _label_04_240		; $5f0f
_label_04_238:
	and $02			; $5f11
	ld l,$0b		; $5f13
	ld a,(hl)		; $5f15
	jr nz,_label_04_239	; $5f16
	and $f0			; $5f18
	jr _label_04_240		; $5f1a
_label_04_239:
	and $f0			; $5f1c
	or $0e			; $5f1e
_label_04_240:
	cp c			; $5f20
	jr nz,_label_04_242	; $5f21
	push bc			; $5f23
	ld c,a			; $5f24
	ld a,(bc)		; $5f25
	sub $78			; $5f26
	cp $08			; $5f28
	jr nc,_label_04_241	; $5f2a
	ldh a,(<hFF8B)	; $5f2c
	ld (bc),a		; $5f2e
_label_04_241:
	pop bc			; $5f2f
_label_04_242:
	ld a,e			; $5f30
	bit 7,a			; $5f31
	ret nz			; $5f33
	and $7f			; $5f34
	ld e,a			; $5f36
	call getFreeInteractionSlot		; $5f37
	ret nz			; $5f3a
	ld (hl),$1e		; $5f3b
	inc l			; $5f3d
	ld (hl),e		; $5f3e
	ld l,$4b		; $5f3f
	ld (hl),c		; $5f41
	ret			; $5f42
	and b			; $5f43
	add b			; $5f44
	and b			; $5f45
	add c			; $5f46
	and b			; $5f47
	add d			; $5f48
	and b			; $5f49
	add e			; $5f4a
	ld e,(hl)		; $5f4b
	inc c			; $5f4c
	ld e,l			; $5f4d
	dec c			; $5f4e
	ld e,(hl)		; $5f4f
	ld c,$5d		; $5f50
	rrca			; $5f52
	call getThisRoomFlags		; $5f53
	bit 5,a			; $5f56
	ret z			; $5f58
	call getChestData		; $5f59
	ld d,$cf		; $5f5c
	ld a,$f0		; $5f5e
	ld (de),a		; $5f60
	ret			; $5f61
	ld hl,$5f90		; $5f62
	ld a,($cc49)		; $5f65
	sub $04			; $5f68
	jr z,_label_04_243	; $5f6a
	dec a			; $5f6c
	ret nz			; $5f6d
	ld hl,$5fd1		; $5f6e
_label_04_243:
	ld a,($cc4c)		; $5f71
	ld b,a			; $5f74
	ld a,($cc32)		; $5f75
	ld c,a			; $5f78
	ld d,$cf		; $5f79
_label_04_244:
	ldi a,(hl)		; $5f7b
	or a			; $5f7c
	ret z			; $5f7d
	cp b			; $5f7e
	jr nz,_label_04_245	; $5f7f
	ldi a,(hl)		; $5f81
	and c			; $5f82
	jr z,_label_04_246	; $5f83
	ldi a,(hl)		; $5f85
	ld e,(hl)		; $5f86
	inc hl			; $5f87
	ld (de),a		; $5f88
	jr _label_04_244		; $5f89
_label_04_245:
	inc hl			; $5f8b
_label_04_246:
	inc hl			; $5f8c
	inc hl			; $5f8d
	jr _label_04_244		; $5f8e
	rrca			; $5f90
	ld bc,$330b		; $5f91
	rrca			; $5f94
	ld bc,$745a		; $5f95
	ld l,a			; $5f98
	ld bc,$8c0b		; $5f99
	ld l,a			; $5f9c
	ld bc,$295c		; $5f9d
	ld (hl),b		; $5fa0
	ld (bc),a		; $5fa1
	dec bc			; $5fa2
	jr z,_label_04_249	; $5fa3
	ld (bc),a		; $5fa5
	ld e,e			; $5fa6
	ld d,d			; $5fa7
	ld (hl),b		; $5fa8
	inc b			; $5fa9
	dec bc			; $5faa
	ld e,c			; $5fab
	ld (hl),b		; $5fac
	inc b			; $5fad
	ld e,e			; $5fae
	add h			; $5faf
	halt			; $5fb0
	ld ($170b),sp		; $5fb1
	halt			; $5fb4
	ld ($255d),sp		; $5fb5
	ld a,(hl)		; $5fb8
	stop			; $5fb9
	dec bc			; $5fba
	ld d,(hl)		; $5fbb
	ld a,(hl)		; $5fbc
	stop			; $5fbd
	ld e,h			; $5fbe
	ld h,(hl)		; $5fbf
	and b			; $5fc0
	ld bc,$445e		; $5fc1
	and b			; $5fc4
	ld (bc),a		; $5fc5
	ld e,(hl)		; $5fc6
	scf			; $5fc7
	and b			; $5fc8
	ld bc,$830b		; $5fc9
	and b			; $5fcc
	ld (bc),a		; $5fcd
	dec bc			; $5fce
	ld a,b			; $5fcf
	nop			; $5fd0
	ld a,(hl)		; $5fd1
	ld bc,$2b5c		; $5fd2
	ld a,(hl)		; $5fd5
	ld bc,$780b		; $5fd6
	nop			; $5fd9
	ld a,($cc4c)		; $5fda
	ld b,a			; $5fdd
	call getThisRoomFlags		; $5fde
	ld c,a			; $5fe1
	ld d,$cf		; $5fe2
	ld a,($cc49)		; $5fe4
	ld hl,$6005		; $5fe7
	rst_addDoubleIndex			; $5fea
	ldi a,(hl)		; $5feb
	ld h,(hl)		; $5fec
	ld l,a			; $5fed
_label_04_247:
	ldi a,(hl)		; $5fee
	cp b			; $5fef
	jr nz,_label_04_248	; $5ff0
	ld a,(hl)		; $5ff2
	and c			; $5ff3
	jr z,_label_04_248	; $5ff4
	inc hl			; $5ff6
	ldi a,(hl)		; $5ff7
	ld e,a			; $5ff8
	ldi a,(hl)		; $5ff9
	ld (de),a		; $5ffa
	jr _label_04_247		; $5ffb
_label_04_248:
	ld a,(hl)		; $5ffd
	or a			; $5ffe
	ret z			; $5fff
	inc hl			; $6000
	inc hl			; $6001
	inc hl			; $6002
	jr _label_04_247		; $6003
	dec d			; $6005
	ld h,b			; $6006
	ccf			; $6007
	ld h,b			; $6008
	ld (hl),l		; $6009
	ld h,b			; $600a
	ld (hl),l		; $600b
	ld h,b			; $600c
	ld (hl),l		; $600d
	ld h,b			; $600e
	add e			; $600f
	ld h,b			; $6010
	xor c			; $6011
	ld h,b			; $6012
	xor c			; $6013
	ld h,b			; $6014
_label_04_249:
	sbc d			; $6015
	ld b,b			; $6016
	inc sp			; $6017
	push bc			; $6018
	ld d,d			; $6019
	ld b,b			; $601a
	ld (bc),a		; $601b
	ret nc			; $601c
	ld d,d			; $601d
	ld b,b			; $601e
	ld bc,$526b		; $601f
	ld b,b			; $6022
	inc bc			; $6023
	ld b,l			; $6024
	jp hl			; $6025
	ld bc,$0448		; $6026
	jp hl			; $6029
	ld (bc),a		; $602a
	ld e,b			; $602b
	inc b			; $602c
	ld bc,$6680		; $602d
	inc b			; $6030
	ld bc,$6580		; $6031
	sbc h			; $6034
	ld bc,$6640		; $6035
	inc b			; $6038
	ld bc,$6740		; $6039
	sbc h			; $603c
	nop			; $603d
	nop			; $603e
	ld a,(bc)		; $603f
	add b			; $6040
	ldd (hl),a		; $6041
	pop hl			; $6042
	ld a,(bc)		; $6043
	add b			; $6044
	inc sp			; $6045
	pop hl			; $6046
	ld a,(bc)		; $6047
	add b			; $6048
	inc (hl)		; $6049
	pop hl			; $604a
	ld ($5340),sp		; $604b
	add sp,$12		; $604e
	ld b,b			; $6050
	ld e,b			; $6051
	add sp,$35		; $6052
	ld b,b			; $6054
	ld b,(hl)		; $6055
	add sp,$13		; $6056
	ld bc,$0425		; $6058
	ld b,d			; $605b
	ld bc,$0657		; $605c
	ld b,h			; $605f
	ld bc,$0656		; $6060
	ld c,b			; $6063
	ld bc,$0435		; $6064
	ld d,l			; $6067
	ld bc,fillMemoryBc		; $6068
	ld d,l			; $606b
	ld (bc),a		; $606c
	ld h,d			; $606d
	inc b			; $606e
	ld l,c			; $606f
	jr nz,_label_04_250	; $6070
	pop hl			; $6072
	nop			; $6073
	nop			; $6074
	add hl,sp		; $6075
	add b			; $6076
	rlca			; $6077
	and b			; $6078
	add hl,sp		; $6079
	add b			; $607a
	inc h			; $607b
	add hl,bc		; $607c
	add hl,sp		; $607d
	add b			; $607e
	ldi a,(hl)		; $607f
	add hl,bc		; $6080
	nop			; $6081
	nop			; $6082
	ld a,($ff00+$40)	; $6083
	ld (hl),a		; $6085
	ld l,d			; $6086
	cp h			; $6087
	jr nz,_label_04_251	; $6088
	ld d,e			; $608a
	ld a,$80		; $608b
	ld e,h			; $608d
	dec b			; $608e
	ld (hl),e		; $608f
	add b			; $6090
	ld b,l			; $6091
	and b			; $6092
	ld (hl),e		; $6093
	add b			; $6094
	inc (hl)		; $6095
	ld h,$99		; $6096
	add b			; $6098
	sbc l			; $6099
_label_04_250:
	ld b,h			; $609a
	sbc d			; $609b
	add b			; $609c
	ld h,(hl)		; $609d
	ld b,l			; $609e
	sbc (hl)		; $609f
	add b			; $60a0
	sbc l			; $60a1
	ld b,h			; $60a2
	daa			; $60a3
	add b			; $60a4
	ld d,a			; $60a5
	ld c,a			; $60a6
	nop			; $60a7
	nop			; $60a8
	nop			; $60a9
	nop			; $60aa
	ld a,($cc4c)		; $60ab
	ld hl,$6114		; $60ae
	call findRoomSpecificData		; $60b1
_label_04_251:
	ret nc			; $60b4
	rst_jumpTable			; $60b5
	sub l			; $60b6
	ld h,c			; $60b7
	sbc a			; $60b8
	ld h,c			; $60b9
	dec d			; $60ba
	ld h,d			; $60bb
	jr nc,_label_04_252	; $60bc
	ld d,b			; $60be
	ld h,d			; $60bf
	ld hl,$6862		; $60c0
	ld h,d			; $60c3
	ld e,h			; $60c4
	ld h,d			; $60c5
	adc c			; $60c6
	ld h,c			; $60c7
	ld (hl),a		; $60c8
	ld h,d			; $60c9
	or c			; $60ca
	ld h,e			; $60cb
	ld ($ff00+$62),a	; $60cc
	add h			; $60ce
	ld h,e			; $60cf
	or c			; $60d0
	ld h,e			; $60d1
	or c			; $60d2
	ld h,e			; $60d3
	sub $63			; $60d4
	ld a,($ff00+c)		; $60d6
	ld h,e			; $60d7
	cp $63			; $60d8
	ld a,(bc)		; $60da
	ld h,h			; $60db
	dec l			; $60dc
	ld h,h			; $60dd
	ld c,c			; $60de
	ld h,h			; $60df
	ld e,e			; $60e0
	ld h,h			; $60e1
	ld l,l			; $60e2
	ld h,h			; $60e3
	adc c			; $60e4
	ld h,h			; $60e5
	or d			; $60e6
	ld h,h			; $60e7
	jp nz,$fb64		; $60e8
	ld h,h			; $60eb
	inc b			; $60ec
	ld h,l			; $60ed
	ld hl,$2b64		; $60ee
	ld h,(hl)		; $60f1
	or h			; $60f2
	ld h,c			; $60f3
	di			; $60f4
	ld h,c			; $60f5
	ld d,$65		; $60f6
	ld e,(hl)		; $60f8
	ld h,l			; $60f9
	adc c			; $60fa
	ld h,l			; $60fb
	and a			; $60fc
	ld h,l			; $60fd
	or l			; $60fe
	ld h,l			; $60ff
	jp $d265		; $6100
	ld h,c			; $6103
	ei			; $6104
	ld h,l			; $6105
	rlca			; $6106
	ld h,(hl)		; $6107
	add $61			; $6108
	ld (hl),e		; $610a
	ld h,(hl)		; $610b
	ldd a,(hl)		; $610c
	ld h,(hl)		; $610d
	dec c			; $610e
	ld h,l			; $610f
	ld a,($ff00+c)		; $6110
	ld h,h			; $6111
	jp hl			; $6112
	ld h,h			; $6113
	inc h			; $6114
	ld h,c			; $6115
	ld d,c			; $6116
	ld h,c			; $6117
	ld e,b			; $6118
	ld h,c			; $6119
	ld e,b			; $611a
	ld h,c			; $611b
	ld h,c			; $611c
	ld h,c			; $611d
	ld l,(hl)		; $611e
	ld h,c			; $611f
_label_04_252:
	add a			; $6120
	ld h,c			; $6121
	add a			; $6122
	ld h,c			; $6123
	push bc			; $6124
	nop			; $6125
	reti			; $6126
	ld bc,$1054		; $6127
	ld a,a			; $612a
	ld de,$1262		; $612b
	ld h,b			; $612e
	inc de			; $612f
	ld h,c			; $6130
	inc d			; $6131
	ld (hl),b		; $6132
	dec d			; $6133
	ld (hl),c		; $6134
	ld d,$81		; $6135
	rla			; $6137
	dec c			; $6138
	jr _label_04_253		; $6139
	add hl,de		; $613b
	ld h,e			; $613c
	ld e,$e4		; $613d
	ld h,$f4		; $613f
	rra			; $6141
	ld l,a			; $6142
	jr nz,_label_04_254	; $6143
	ld hl,$22fc		; $6145
	xor $25			; $6148
	ld d,(hl)		; $614a
	jr z,_label_04_255	; $614b
	dec e			; $614d
	or $08			; $614e
	nop			; $6150
	dec (hl)		; $6151
	daa			; $6152
	ld h,h			; $6153
	inc hl			; $6154
	ld (hl),h		; $6155
	inc h			; $6156
	nop			; $6157
_label_04_253:
	and h			; $6158
	add hl,hl		; $6159
	xor e			; $615a
	ldi a,(hl)		; $615b
	or b			; $615c
	inc bc			; $615d
	or l			; $615e
	inc e			; $615f
	nop			; $6160
	ld h,c			; $6161
	ld l,$78		; $6162
	ld (bc),a		; $6164
	ld l,$04		; $6165
	ld h,h			; $6167
	dec b			; $6168
	adc c			; $6169
	ld b,$bb		; $616a
	rlca			; $616c
	nop			; $616d
	dec sp			; $616e
	dec l			; $616f
	ld h,l			; $6170
	add hl,bc		; $6171
	ld h,(hl)		; $6172
	ld a,(bc)		; $6173
	ld h,a			; $6174
	dec bc			; $6175
	ld l,b			; $6176
	inc c			; $6177
	ld l,d			; $6178
	dec c			; $6179
	ld l,e			; $617a
	ld c,$86		; $617b
	rrca			; $617d
	ld a,d			; $617e
	ld a,(de)		; $617f
	ld a,b			; $6180
	dec de			; $6181
	adc (hl)		; $6182
	inc l			; $6183
	sbc (hl)		; $6184
	dec hl			; $6185
	nop			; $6186
_label_04_254:
	nop			; $6187
	ret			; $6188
	ld a,$28		; $6189
	call checkGlobalFlag		; $618b
	ret z			; $618e
	ld hl,$cf33		; $618f
	ld (hl),$f2		; $6192
	ret			; $6194
	ldh a,(<hGameboyType)	; $6195
	rlca			; $6197
_label_04_255:
	ret nc			; $6198
	ld hl,$cf14		; $6199
	ld (hl),$ea		; $619c
	ret			; $619e
	call getThisRoomFlags		; $619f
	bit 7,(hl)		; $61a2
	ret z			; $61a4
	ld hl,$cf14		; $61a5
	ld a,$bf		; $61a8
	ldi (hl),a		; $61aa
	ld (hl),a		; $61ab
	ld l,$24		; $61ac
	ld a,$a9		; $61ae
	ldi (hl),a		; $61b0
	inc a			; $61b1
	ld (hl),a		; $61b2
	ret			; $61b3
	call getThisRoomFlags		; $61b4
	bit 7,(hl)		; $61b7
	ret z			; $61b9
	ld hl,$cf14		; $61ba
	ld a,$ad		; $61bd
	ldi (hl),a		; $61bf
	ld (hl),a		; $61c0
	ld l,$24		; $61c1
	ldi (hl),a		; $61c3
	ld (hl),a		; $61c4
	ret			; $61c5
	call getThisRoomFlags		; $61c6
	and $40			; $61c9
	ret z			; $61cb
	ld hl,$cf36		; $61cc
	ld (hl),$09		; $61cf
	ret			; $61d1
	call getThisRoomFlags		; $61d2
	and $40			; $61d5
	jr z,_label_04_256	; $61d7
	ld hl,$cf77		; $61d9
	ld (hl),$a1		; $61dc
	ret			; $61de
_label_04_256:
	ld hl,$61ee		; $61df
	ld d,$cf		; $61e2
_label_04_257:
	ldi a,(hl)		; $61e4
	or a			; $61e5
	ret z			; $61e6
	ld e,a			; $61e7
	ldi a,(hl)		; $61e8
	ld (de),a		; $61e9
	inc e			; $61ea
	ld (de),a		; $61eb
	jr _label_04_257		; $61ec
	ld h,l			; $61ee
.DB $fd				; $61ef
	ld (hl),l		; $61f0
.DB $fd				; $61f1
	nop			; $61f2
	call getThisRoomFlags		; $61f3
	bit 6,(hl)		; $61f6
	ret z			; $61f8
	bit 5,(hl)		; $61f9
	jr nz,_label_04_258	; $61fb
	ld hl,$cf45		; $61fd
	ld (hl),$f1		; $6200
_label_04_258:
	ld hl,$cf22		; $6202
	ld (hl),$0f		; $6205
	inc l			; $6207
	ld (hl),$11		; $6208
	ld l,$32		; $620a
	ld (hl),$11		; $620c
	inc l			; $620e
	ld (hl),$0f		; $620f
	inc l			; $6211
	ld (hl),$11		; $6212
	ret			; $6214
	call getThisRoomFlags		; $6215
	bit 7,(hl)		; $6218
	ret nz			; $621a
	ld hl,$cf39		; $621b
	ld (hl),$b0		; $621e
	ret			; $6220
	call getThisRoomFlags		; $6221
	bit 7,(hl)		; $6224
	ret z			; $6226
	ld de,$622d		; $6227
	jp $5dc7		; $622a
	add hl,bc		; $622d
	ld ($fa00),sp		; $622e
	ccf			; $6231
	add $e6			; $6232
	rrca			; $6234
	cp $0f			; $6235
	ret nz			; $6237
	ld hl,$624c		; $6238
	call $669d		; $623b
	ld a,$f1		; $623e
	ld hl,$cf25		; $6240
	ld (hl),a		; $6243
	ld l,$27		; $6244
	ld (hl),a		; $6246
	ld l,$32		; $6247
	ld (hl),$a0		; $6249
	ret			; $624b
	inc de			; $624c
	inc bc			; $624d
	ld b,$a0		; $624e
	ld hl,$cf23		; $6250
	ld bc,$0808		; $6253
	ld de,$c8f0		; $6256
	jp $66b7		; $6259
	ld hl,$cf34		; $625c
	ld bc,$0808		; $625f
	ld de,$c8f8		; $6262
	jp $66b7		; $6265
	call getThisRoomFlags		; $6268
	bit 5,(hl)		; $626b
	ret z			; $626d
	ld de,$6274		; $626e
	jp $5dc7		; $6271
	ld a,($ff00+$25)	; $6274
	nop			; $6276
	call getThisRoomFlags		; $6277
	bit 6,(hl)		; $627a
	jr z,_label_04_259	; $627c
	call $63cb		; $627e
	ld hl,$6294		; $6281
	call $6690		; $6284
_label_04_259:
	call getThisRoomFlags		; $6287
	inc l			; $628a
	bit 6,(hl)		; $628b
	ret z			; $628d
	ld hl,$62c8		; $628e
	jp $6690		; $6291
	rst_addAToHl			; $6294
	ld de,$1817		; $6295
	ld hl,$2827		; $6298
	ld sp,$4137		; $629b
	ld b,d			; $629e
	ld b,e			; $629f
	ld b,h			; $62a0
	ld b,l			; $62a1
	ld b,(hl)		; $62a2
	ld b,a			; $62a3
	ld d,c			; $62a4
	ld d,d			; $62a5
	ld d,e			; $62a6
	ld d,l			; $62a7
	ld h,c			; $62a8
	ld h,d			; $62a9
	ld h,h			; $62aa
	ld h,(hl)		; $62ab
	ld h,a			; $62ac
	ld l,b			; $62ad
	ld (hl),c		; $62ae
	ld (hl),d		; $62af
	ld (hl),e		; $62b0
	ld (hl),h		; $62b1
	ld (hl),l		; $62b2
	halt			; $62b3
	ld (hl),a		; $62b4
	add c			; $62b5
	add d			; $62b6
	add e			; $62b7
	add h			; $62b8
	add l			; $62b9
	add (hl)		; $62ba
	add a			; $62bb
	sub c			; $62bc
	sub d			; $62bd
	sub h			; $62be
	sub l			; $62bf
	sub (hl)		; $62c0
	and c			; $62c1
	and d			; $62c2
	and e			; $62c3
	and h			; $62c4
	and l			; $62c5
	and (hl)		; $62c6
	rst $38			; $62c7
	rst_addAToHl			; $62c8
	ld l,l			; $62c9
	ld l,(hl)		; $62ca
	ld a,h			; $62cb
	ld a,l			; $62cc
	ld a,(hl)		; $62cd
	adc d			; $62ce
	adc e			; $62cf
	adc h			; $62d0
	adc l			; $62d1
	adc (hl)		; $62d2
	sbc c			; $62d3
	sbc d			; $62d4
	sbc e			; $62d5
	sbc h			; $62d6
	sbc l			; $62d7
	sbc (hl)		; $62d8
	xor c			; $62d9
	xor d			; $62da
	xor e			; $62db
	xor h			; $62dc
	xor l			; $62dd
	xor (hl)		; $62de
	rst $38			; $62df
	ld a,$65		; $62e0
	call $1959		; $62e2
	bit 6,(hl)		; $62e5
	jr z,_label_04_260	; $62e7
	ld hl,$630c		; $62e9
	call $6690		; $62ec
_label_04_260:
	ld a,$66		; $62ef
	call $1959		; $62f1
	bit 6,(hl)		; $62f4
	jr z,_label_04_261	; $62f6
	ld hl,$632d		; $62f8
	call $6690		; $62fb
_label_04_261:
	ld a,$6a		; $62fe
	call $1959		; $6300
	bit 6,(hl)		; $6303
	ret z			; $6305
	ld hl,$6340		; $6306
	jp $6690		; $6309
	rst_addAToHl			; $630c
	ld bc,$0302		; $630d
	inc b			; $6310
	dec b			; $6311
	ld b,$11		; $6312
	ld (de),a		; $6314
	inc de			; $6315
	inc d			; $6316
	dec d			; $6317
	ld d,$21		; $6318
	ldi (hl),a		; $631a
	inc hl			; $631b
	ld sp,$3332		; $631c
	ld b,c			; $631f
	ld b,d			; $6320
	ld b,e			; $6321
	ld d,c			; $6322
	ld d,d			; $6323
	ld d,e			; $6324
	ld h,c			; $6325
	ld h,d			; $6326
	ld h,e			; $6327
	ld h,h			; $6328
	ld (hl),c		; $6329
	ld (hl),d		; $632a
	ld (hl),e		; $632b
	rst $38			; $632c
	rst_addAToHl			; $632d
	add hl,bc		; $632e
	ld a,(bc)		; $632f
	dec bc			; $6330
	inc c			; $6331
	dec c			; $6332
	ld c,$19		; $6333
	ld a,(de)		; $6335
	dec de			; $6336
	inc e			; $6337
	dec e			; $6338
	ld e,$2a		; $6339
	dec hl			; $633b
	dec l			; $633c
	ld l,$3e		; $633d
	rst $38			; $633f
	rst_addAToHl			; $6340
	dec h			; $6341
	ld h,$27		; $6342
	dec (hl)		; $6344
	ld (hl),$37		; $6345
	jr c,_label_04_262	; $6347
	ld b,l			; $6349
	ld b,(hl)		; $634a
	ld b,a			; $634b
	ld c,b			; $634c
	ld c,c			; $634d
	ld d,l			; $634e
	ld d,(hl)		; $634f
	ld d,a			; $6350
	ld e,b			; $6351
	ld e,c			; $6352
	ld h,(hl)		; $6353
	ld h,a			; $6354
	ld l,b			; $6355
	ld l,c			; $6356
	ld l,d			; $6357
	ld (hl),l		; $6358
	halt			; $6359
	ld (hl),a		; $635a
	ld a,b			; $635b
	ld a,c			; $635c
	ld a,d			; $635d
	add c			; $635e
	add d			; $635f
	add e			; $6360
	add h			; $6361
	add l			; $6362
	add (hl)		; $6363
	add a			; $6364
	adc b			; $6365
	adc c			; $6366
	adc d			; $6367
	adc e			; $6368
	sub c			; $6369
	sub d			; $636a
	sub e			; $636b
	sub h			; $636c
	sub l			; $636d
	sub (hl)		; $636e
	sub a			; $636f
	sbc b			; $6370
	sbc c			; $6371
	sbc d			; $6372
	sbc e			; $6373
	sbc h			; $6374
	sbc l			; $6375
	and c			; $6376
	and d			; $6377
	and e			; $6378
	and h			; $6379
	and l			; $637a
	and (hl)		; $637b
	and a			; $637c
	xor b			; $637d
	xor c			; $637e
	xor d			; $637f
	xor e			; $6380
	xor h			; $6381
_label_04_262:
	xor l			; $6382
	rst $38			; $6383
	ld a,$66		; $6384
	call $1959		; $6386
	bit 6,(hl)		; $6389
	jr z,_label_04_263	; $638b
	ld hl,$cf00		; $638d
	ld b,$70		; $6390
	call $63a2		; $6392
_label_04_263:
	ld a,$6b		; $6395
	call $1959		; $6397
	bit 6,(hl)		; $639a
	ret z			; $639c
	ld hl,$cf70		; $639d
	ld b,$00		; $63a0
_label_04_264:
	ld a,(hl)		; $63a2
	sub $61			; $63a3
	cp $05			; $63a5
	jr nc,_label_04_265	; $63a7
	ld (hl),$d7		; $63a9
_label_04_265:
	inc l			; $63ab
	ld a,l			; $63ac
	cp b			; $63ad
	jr nz,_label_04_264	; $63ae
	ret			; $63b0
	call getThisRoomFlags		; $63b1
	bit 6,(hl)		; $63b4
	ret z			; $63b6
	call $63cb		; $63b7
	ld de,$63c0		; $63ba
	jp $5dc7		; $63bd
	rst_addAToHl			; $63c0
	ld h,c			; $63c1
	rst_addAToHl			; $63c2
	ld h,d			; $63c3
	rst_addAToHl			; $63c4
	ld h,e			; $63c5
	rst_addAToHl			; $63c6
	ld h,h			; $63c7
	rst_addAToHl			; $63c8
	ld h,l			; $63c9
	nop			; $63ca
	ld de,$63d1		; $63cb
	jp $5dc7		; $63ce
	push de			; $63d1
	call nc,$67d7		; $63d2
	nop			; $63d5
	call getThisRoomFlags		; $63d6
	bit 7,(hl)		; $63d9
	ret z			; $63db
	ld de,$63ef		; $63dc
	call $5dc7		; $63df
	ld hl,$cf4d		; $63e2
	ld a,$2f		; $63e5
	ld (hl),a		; $63e7
	ld l,$5d		; $63e8
	ld (hl),a		; $63ea
	ld l,$6d		; $63eb
	ld (hl),a		; $63ed
	ret			; $63ee
	adc h			; $63ef
	cpl			; $63f0
	nop			; $63f1
	ld a,($c643)		; $63f2
	bit 6,a			; $63f5
	ret z			; $63f7
	ld hl,$cf34		; $63f8
	ld (hl),$f2		; $63fb
	ret			; $63fd
	ld a,($cc4e)		; $63fe
	cp $03			; $6401
	ret nz			; $6403
	ld hl,$cf47		; $6404
	ld (hl),$ea		; $6407
	ret			; $6409
	ld h,$c8		; $640a
	ld l,$b5		; $640c
	bit 6,(hl)		; $640e
	ret nz			; $6410
	ld hl,$641d		; $6411
	call $669d		; $6414
	ld hl,$cf27		; $6417
	ld (hl),$fd		; $641a
	ret			; $641c
	ld h,$02		; $641d
	inc bc			; $641f
	ld a,($56cd)		; $6420
	add hl,de		; $6423
	bit 6,(hl)		; $6424
	ret nz			; $6426
	ld hl,$cf37		; $6427
	ld (hl),$fa		; $642a
	ret			; $642c
	ld a,$81		; $642d
	call $1959		; $642f
	bit 7,(hl)		; $6432
	ret nz			; $6434
	ld hl,$6441		; $6435
	call $669d		; $6438
	ld hl,$6445		; $643b
	jp $669d		; $643e
	inc h			; $6441
	ld b,$03		; $6442
.DB $fd				; $6444
	ld b,a			; $6445
	inc b			; $6446
	inc bc			; $6447
.DB $fd				; $6448
	ld a,$81		; $6449
	call $1959		; $644b
	bit 7,(hl)		; $644e
	ret nz			; $6450
	ld hl,$6457		; $6451
	jp $669d		; $6454
	ld b,b			; $6457
	inc b			; $6458
	rlca			; $6459
.DB $fd				; $645a
	ld a,$81		; $645b
	call $1959		; $645d
	bit 7,(hl)		; $6460
	ret nz			; $6462
	ld hl,$6469		; $6463
	jp $669d		; $6466
	inc b			; $6469
	inc b			; $646a
	ld b,$fd		; $646b
	ld a,$81		; $646d
	call $1959		; $646f
	bit 7,(hl)		; $6472
	ret nz			; $6474
	ld hl,$6481		; $6475
	call $669d		; $6478
	ld hl,$6485		; $647b
	jp $669d		; $647e
	nop			; $6481
	inc b			; $6482
	rlca			; $6483
.DB $fd				; $6484
	ld b,h			; $6485
	inc b			; $6486
	inc bc			; $6487
.DB $fd				; $6488
	call getThisRoomFlags		; $6489
	bit 7,(hl)		; $648c
	jr nz,_label_04_266	; $648e
	ld hl,$64a6		; $6490
	jp $669d		; $6493
_label_04_266:
	ld hl,$64ae		; $6496
	ld a,($cc4e)		; $6499
	cp $03			; $649c
	jr z,_label_04_267	; $649e
	ld hl,$64aa		; $64a0
_label_04_267:
	jp $669d		; $64a3
	inc b			; $64a6
	ld bc,$fd03		; $64a7
	inc d			; $64aa
	ld bc,$fa03		; $64ab
	inc d			; $64ae
	ld bc,$dc03		; $64af
	call getThisRoomFlags		; $64b2
	bit 7,(hl)		; $64b5
	ret nz			; $64b7
	ld hl,$64be		; $64b8
	jp $669d		; $64bb
	ld h,d			; $64be
	ld (bc),a		; $64bf
	inc bc			; $64c0
	rst $38			; $64c1
	call getThisRoomFlags		; $64c2
	bit 7,(hl)		; $64c5
	ret nz			; $64c7
	ld hl,$64d9		; $64c8
	call $669d		; $64cb
	ld l,$13		; $64ce
	ld a,$fe		; $64d0
	ld (hl),a		; $64d2
	ld l,$22		; $64d3
	ldi (hl),a		; $64d5
	ldi (hl),a		; $64d6
	ld (hl),a		; $64d7
	ret			; $64d8
	ld (bc),a		; $64d9
	inc bc			; $64da
	inc bc			; $64db
	rst $38			; $64dc
	ret			; $64dd
_label_04_268:
	call getThisRoomFlags		; $64de
	bit 7,(hl)		; $64e1
	ret z			; $64e3
	ld h,b			; $64e4
	ld l,c			; $64e5
	jp $669d		; $64e6
	ld bc,$64ee		; $64e9
	jr _label_04_268		; $64ec
	ld e,c			; $64ee
	ld bc,$6d03		; $64ef
	ld bc,$64f7		; $64f2
	jr _label_04_268		; $64f5
	ld (hl),a		; $64f7
	ld bc,$6d04		; $64f8
	ld bc,$6500		; $64fb
	jr _label_04_268		; $64fe
	inc a			; $6500
	ld b,$01		; $6501
	ld l,d			; $6503
	ld bc,$6509		; $6504
	jr _label_04_268		; $6507
	add d			; $6509
	ld bc,$6d07		; $650a
	ld bc,$6512		; $650d
	jr _label_04_268		; $6510
	dec de			; $6512
	rlca			; $6513
	ld bc,$cd6a		; $6514
	ld d,(hl)		; $6517
	add hl,de		; $6518
	and $c0			; $6519
	ret z			; $651b
	ld de,$6555		; $651c
	ld a,$12		; $651f
	call checkGlobalFlag		; $6521
	jr nz,_label_04_270	; $6524
	ld a,($cc69)		; $6526
	bit 1,a			; $6529
	jr nz,_label_04_269	; $652b
	ld de,$654c		; $652d
	jr _label_04_270		; $6530
_label_04_269:
	ld a,$12		; $6532
	call setGlobalFlag		; $6534
_label_04_270:
	ld hl,$cf36		; $6537
	ld b,$03		; $653a
_label_04_271:
	ld c,$03		; $653c
_label_04_272:
	ld a,(de)		; $653e
	inc de			; $653f
	ldi (hl),a		; $6540
	dec c			; $6541
	jr nz,_label_04_272	; $6542
	ld a,$0d		; $6544
	add l			; $6546
	ld l,a			; $6547
	dec b			; $6548
	jr nz,_label_04_271	; $6549
	ret			; $654b
.DB $fd				; $654c
.DB $fd				; $654d
.DB $fc				; $654e
	ei			; $654f
.DB $fd				; $6550
.DB $fc				; $6551
.DB $fd				; $6552
	ei			; $6553
.DB $fd				; $6554
	xor b			; $6555
.DB $eb				; $6556
	and l			; $6557
	or e			; $6558
	or h			; $6559
	or l			; $655a
	and e			; $655b
	xor $a4			; $655c
	ld hl,$cf44		; $655e
	ld (hl),$9c		; $6561
	call getThisRoomFlags		; $6563
	and $80			; $6566
	jr z,_label_04_273	; $6568
	ld hl,$cf55		; $656a
	ld (hl),$bc		; $656d
	jr _label_04_274		; $656f
_label_04_273:
	ld hl,$cf54		; $6571
	ld (hl),$d6		; $6574
_label_04_274:
	call getThisRoomFlags		; $6576
	and $40			; $6579
	jr z,_label_04_275	; $657b
	ld hl,$cf65		; $657d
	ld (hl),$bc		; $6580
	ret			; $6582
_label_04_275:
	ld hl,$cf64		; $6583
	ld (hl),$d6		; $6586
	ret			; $6588
	call getThisRoomFlags		; $6589
	bit 7,(hl)		; $658c
	ret z			; $658e
	ld hl,$cf03		; $658f
	ld a,$af		; $6592
	ldi (hl),a		; $6594
	ldi (hl),a		; $6595
	ldi (hl),a		; $6596
	ld (hl),a		; $6597
	ld a,$0d		; $6598
	rst_addAToHl			; $659a
	ld a,$af		; $659b
	ldi (hl),a		; $659d
	ldi (hl),a		; $659e
	ldi (hl),a		; $659f
	ld (hl),a		; $65a0
	ret			; $65a1
	ld a,$17		; $65a2
	jp checkGlobalFlag		; $65a4
	call $65a2		; $65a7
	ret z			; $65aa
	ld hl,$65b1		; $65ab
	jp $669d		; $65ae
	ld b,h			; $65b1
	inc b			; $65b2
	dec b			; $65b3
	rrca			; $65b4
	call $65a2		; $65b5
	ret z			; $65b8
	ld hl,$65bf		; $65b9
	jp $669d		; $65bc
	inc b			; $65bf
	inc b			; $65c0
	dec b			; $65c1
	rrca			; $65c2
	call $65a2		; $65c3
	ret z			; $65c6
	ld hl,$65e2		; $65c7
	ld de,$cf23		; $65ca
	ld bc,$0505		; $65cd
_label_04_276:
	push de			; $65d0
	push bc			; $65d1
_label_04_277:
	ldi a,(hl)		; $65d2
	ld (de),a		; $65d3
	inc e			; $65d4
	dec b			; $65d5
	jr nz,_label_04_277	; $65d6
	pop bc			; $65d8
	pop de			; $65d9
	ld a,e			; $65da
	add $10			; $65db
	ld e,a			; $65dd
	dec c			; $65de
	jr nz,_label_04_276	; $65df
	ret			; $65e1
	xor a			; $65e2
	xor a			; $65e3
	xor a			; $65e4
	xor a			; $65e5
	xor a			; $65e6
	xor l			; $65e7
	xor l			; $65e8
	xor (hl)		; $65e9
	xor (hl)		; $65ea
	xor a			; $65eb
	xor l			; $65ec
	xor l			; $65ed
	xor (hl)		; $65ee
	xor (hl)		; $65ef
	xor a			; $65f0
	cp l			; $65f1
	cp l			; $65f2
	cp (hl)			; $65f3
	cp (hl)			; $65f4
	xor a			; $65f5
	cp l			; $65f6
	cp l			; $65f7
	cp (hl)			; $65f8
	cp (hl)			; $65f9
	xor a			; $65fa
	ld a,($c9f9)		; $65fb
	and $04			; $65fe
	ret z			; $6600
	ld hl,$cf43		; $6601
	ld (hl),$e8		; $6604
	ret			; $6606
	xor a			; $6607
	ld ($cc32),a		; $6608
	ld a,($c610)		; $660b
	cp $0c			; $660e
	ret z			; $6610
	call getThisRoomFlags		; $6611
	and $40			; $6614
	jr nz,_label_04_278	; $6616
	ld a,$fd		; $6618
	ld hl,$cf43		; $661a
	ldi (hl),a		; $661d
	ld (hl),a		; $661e
	ld hl,$cf53		; $661f
	ldi (hl),a		; $6622
	ld (hl),a		; $6623
	ret			; $6624
_label_04_278:
	ld a,$b0		; $6625
	ld ($cf66),a		; $6627
	ret			; $662a
	ld a,$16		; $662b
	call checkGlobalFlag		; $662d
	ret z			; $6630
	ld hl,$cf73		; $6631
	ld a,$40		; $6634
	ldi (hl),a		; $6636
	ldi (hl),a		; $6637
	ld (hl),a		; $6638
	ret			; $6639
	ld a,($ccc4)		; $663a
	or a			; $663d
	ret z			; $663e
	dec a			; $663f
	jr z,_label_04_281	; $6640
	dec a			; $6642
	jr z,_label_04_280	; $6643
	dec a			; $6645
	jr z,_label_04_279	; $6646
	xor a			; $6648
	ld ($ccc4),a		; $6649
	ld hl,$6652		; $664c
	jp $669d		; $664f
	nop			; $6652
	dec bc			; $6653
	rrca			; $6654
	xor d			; $6655
_label_04_279:
	ld ($ccc4),a		; $6656
	ld a,$b9		; $6659
	jp loadGfxHeader		; $665b
_label_04_280:
	ld ($ccc4),a		; $665e
	ld hl,$6667		; $6661
	jp $669d		; $6664
	ld de,$0d09		; $6667
	adc h			; $666a
_label_04_281:
	ld ($ccc4),a		; $666b
	ld a,$b8		; $666e
	jp loadGfxHeader		; $6670
	call getThisRoomFlags		; $6673
	and $40			; $6676
	ret z			; $6678
	ld hl,$cf14		; $6679
	ld a,$6d		; $667c
	ldi (hl),a		; $667e
	ldi (hl),a		; $667f
	ld (hl),a		; $6680
	ld a,$6a		; $6681
	ld l,$47		; $6683
	ld (hl),a		; $6685
	ld l,$37		; $6686
	ld (hl),a		; $6688
	ld l,$27		; $6689
	ld (hl),a		; $668b
	ld l,$17		; $668c
	ld (hl),a		; $668e
	ret			; $668f
	ld d,$cf		; $6690
	ldi a,(hl)		; $6692
	ld c,a			; $6693
_label_04_282:
	ldi a,(hl)		; $6694
	cp $ff			; $6695
	ret z			; $6697
	ld e,a			; $6698
	ld a,c			; $6699
	ld (de),a		; $669a
	jr _label_04_282		; $669b
	ldi a,(hl)		; $669d
	ld e,a			; $669e
	ldi a,(hl)		; $669f
	ld b,a			; $66a0
	ldi a,(hl)		; $66a1
	ld c,a			; $66a2
	ldi a,(hl)		; $66a3
	ld d,a			; $66a4
	ld h,$cf		; $66a5
_label_04_283:
	ld a,d			; $66a7
	ld l,e			; $66a8
	push bc			; $66a9
_label_04_284:
	ldi (hl),a		; $66aa
	dec c			; $66ab
	jr nz,_label_04_284	; $66ac
	ld a,e			; $66ae
	add $10			; $66af
	ld e,a			; $66b1
	pop bc			; $66b2
	dec b			; $66b3
	jr nz,_label_04_283	; $66b4
	ret			; $66b6
_label_04_285:
	ld a,(de)		; $66b7
	inc de			; $66b8
	push bc			; $66b9
_label_04_286:
	rrca			; $66ba
	jr nc,_label_04_287	; $66bb
	ld (hl),$a0		; $66bd
_label_04_287:
	inc l			; $66bf
	dec b			; $66c0
	jr nz,_label_04_286	; $66c1
	ld a,l			; $66c3
	add $08			; $66c4
	ld l,a			; $66c6
	pop bc			; $66c7
	dec c			; $66c8
	jr nz,_label_04_285	; $66c9
	ret			; $66cb


.include "code/seasons/roomGfxChanges.s"


;;
; @addr{6ae4}
generateW3VramTilesAndAttributes:
	ld a,$03		; $6ae4
	ld ($ff00+$70),a	; $6ae6
	ld hl,$cf00		; $6ae8
	ld de,$d800		; $6aeb
	ld c,$0b		; $6aee
_label_04_317:
	ld b,$10		; $6af0
_label_04_318:
	push bc			; $6af2
	ldi a,(hl)		; $6af3
	push hl			; $6af4
	call setHlToTileMappingDataPlusATimes8		; $6af5
	push de			; $6af8
	call $6b16		; $6af9
	pop de			; $6afc
	set 2,d			; $6afd
	call $6b16		; $6aff
	res 2,d			; $6b02
	ld a,e			; $6b04
	sub $1f			; $6b05
	ld e,a			; $6b07
	pop hl			; $6b08
	pop bc			; $6b09
	dec b			; $6b0a
	jr nz,_label_04_318	; $6b0b
	ld a,$20		; $6b0d
	call addAToDe		; $6b0f
	dec c			; $6b12
	jr nz,_label_04_317	; $6b13
	ret			; $6b15
	ldi a,(hl)		; $6b16
	ld (de),a		; $6b17
	inc e			; $6b18
	ldi a,(hl)		; $6b19
	ld (de),a		; $6b1a
	ld a,$1f		; $6b1b
	add e			; $6b1d
	ld e,a			; $6b1e
	ldi a,(hl)		; $6b1f
	ld (de),a		; $6b20
	inc e			; $6b21
	ldi a,(hl)		; $6b22
	ld (de),a		; $6b23
	ret			; $6b24
	ld a,($cd00)		; $6b25
	and $0e			; $6b28
	ret nz			; $6b2a
	ld b,$04		; $6b2b
_label_04_319:
	push bc			; $6b2d
	call $6b39		; $6b2e
	pop bc			; $6b31
	dec b			; $6b32
	jr nz,_label_04_319	; $6b33
	xor a			; $6b35
	ld ($ff00+$70),a	; $6b36
	ret			; $6b38
	ld a,($ccf5)		; $6b39
	ld b,a			; $6b3c
	ld a,($ccf6)		; $6b3d
	cp b			; $6b40
	ret z			; $6b41
	inc b			; $6b42
	ld a,b			; $6b43
	and $1f			; $6b44
	ld ($ccf5),a		; $6b46
	ld hl,$dac0		; $6b49
	rst_addDoubleIndex			; $6b4c
	ld a,$02		; $6b4d
	ld ($ff00+$70),a	; $6b4f
	ldi a,(hl)		; $6b51
	ld c,(hl)		; $6b52
	ld b,a			; $6b53
	ld a,c			; $6b54
	ldh (<hFF8C),a	; $6b55
	ld a,($ff00+$70)	; $6b57
	push af			; $6b59
	ld a,$03		; $6b5a
	ld ($ff00+$70),a	; $6b5c
	call $6b7c		; $6b5e
	ld a,b			; $6b61
	call setHlToTileMappingDataPlusATimes8		; $6b62
	push hl			; $6b65
	push de			; $6b66
	call $6b16		; $6b67
	pop de			; $6b6a
	ld a,$04		; $6b6b
	add d			; $6b6d
	ld d,a			; $6b6e
	call $6b16		; $6b6f
	ldh a,(<hFF8C)	; $6b72
	pop hl			; $6b74
	call $6c17		; $6b75
	pop af			; $6b78
	ld ($ff00+$70),a	; $6b79
	ret			; $6b7b
	ld a,c			; $6b7c
	swap a			; $6b7d
	and $0f			; $6b7f
	ld hl,$6b90		; $6b81
	rst_addDoubleIndex			; $6b84
	ldi a,(hl)		; $6b85
	ld h,(hl)		; $6b86
	ld l,a			; $6b87
	ld a,c			; $6b88
	and $0f			; $6b89
	add a			; $6b8b
	rst_addAToHl			; $6b8c
	ld e,l			; $6b8d
	ld d,h			; $6b8e
	ret			; $6b8f
	nop			; $6b90
	ret c			; $6b91
	ld b,b			; $6b92
	ret c			; $6b93
	add b			; $6b94
	ret c			; $6b95
	ret nz			; $6b96
	ret c			; $6b97
	nop			; $6b98
	reti			; $6b99
	ld b,b			; $6b9a
	reti			; $6b9b
	add b			; $6b9c
	reti			; $6b9d
	ret nz			; $6b9e
	reti			; $6b9f
	nop			; $6ba0
	jp c,$da40		; $6ba1
	add b			; $6ba4
	jp c,$8be0		; $6ba5
	ld a,($ff00+$70)	; $6ba8
	push af			; $6baa
	ld a,$03		; $6bab
	ld ($ff00+$70),a	; $6bad
	ldh a,(<hFF8F)	; $6baf
	call setHlToTileMappingDataPlusATimes8		; $6bb1
	ld de,$cec8		; $6bb4
	ld b,$08		; $6bb7
_label_04_320:
	ldi a,(hl)		; $6bb9
	ld (de),a		; $6bba
	inc de			; $6bbb
	dec b			; $6bbc
	jr nz,_label_04_320	; $6bbd
	ldh a,(<hFF8E)	; $6bbf
	call setHlToTileMappingDataPlusATimes8		; $6bc1
	ld de,$cec8		; $6bc4
	ldh a,(<hFF8B)	; $6bc7
	bit 0,a			; $6bc9
	jr nz,_label_04_323	; $6bcb
	bit 1,a			; $6bcd
	jr nz,_label_04_321	; $6bcf
	inc hl			; $6bd1
	inc hl			; $6bd2
	call $6be6		; $6bd3
	jr _label_04_322		; $6bd6
_label_04_321:
	inc de			; $6bd8
	inc de			; $6bd9
	call $6be6		; $6bda
_label_04_322:
	inc hl			; $6bdd
	inc hl			; $6bde
	inc de			; $6bdf
	inc de			; $6be0
	call $6be6		; $6be1
	jr _label_04_326		; $6be4
	ldi a,(hl)		; $6be6
	ld (de),a		; $6be7
	inc de			; $6be8
	ldi a,(hl)		; $6be9
	ld (de),a		; $6bea
	inc de			; $6beb
	ret			; $6bec
_label_04_323:
	bit 1,a			; $6bed
	jr nz,_label_04_324	; $6bef
	inc de			; $6bf1
	call $6c02		; $6bf2
	jr _label_04_325		; $6bf5
_label_04_324:
	inc hl			; $6bf7
	call $6c02		; $6bf8
_label_04_325:
	inc hl			; $6bfb
	inc de			; $6bfc
	call $6c02		; $6bfd
	jr _label_04_326		; $6c00
	ldi a,(hl)		; $6c02
	ld (de),a		; $6c03
	inc de			; $6c04
	inc hl			; $6c05
	inc de			; $6c06
	ldi a,(hl)		; $6c07
	ld (de),a		; $6c08
	inc de			; $6c09
	ret			; $6c0a
_label_04_326:
	ldh a,(<hFF8C)	; $6c0b
	ld hl,$cec8		; $6c0d
	call $6c17		; $6c10
	pop af			; $6c13
	ld ($ff00+$70),a	; $6c14
	ret			; $6c16
	push hl			; $6c17
	call $6c47		; $6c18
	add $20			; $6c1b
	ld c,a			; $6c1d
	ldh a,(<hVBlankFunctionQueueTail)	; $6c1e
	ld l,a			; $6c20
	ld h,$c4		; $6c21
	ld a,(vblankCopyTileFunctionOffset)		; $6c23
	ldi (hl),a		; $6c26
	ld (hl),e		; $6c27
	inc l			; $6c28
	ld (hl),d		; $6c29
	inc l			; $6c2a
	ld e,l			; $6c2b
	ld d,h			; $6c2c
	pop hl			; $6c2d
	ld b,$02		; $6c2e
_label_04_327:
	call $6c40		; $6c30
	ld a,c			; $6c33
	ld (de),a		; $6c34
	inc e			; $6c35
	call $6c40		; $6c36
	dec b			; $6c39
	jr nz,_label_04_327	; $6c3a
	ld a,e			; $6c3c
	ldh (<hVBlankFunctionQueueTail),a	; $6c3d
	ret			; $6c3f
	ldi a,(hl)		; $6c40
	ld (de),a		; $6c41
	inc e			; $6c42
	ldi a,(hl)		; $6c43
	ld (de),a		; $6c44
	inc e			; $6c45
	ret			; $6c46
	ld e,a			; $6c47
	and $f0			; $6c48
	swap a			; $6c4a
	ld d,a			; $6c4c
	ld a,e			; $6c4d
	and $0f			; $6c4e
	add a			; $6c50
	ld e,a			; $6c51
	ld a,($cd09)		; $6c52
	swap a			; $6c55
	add a			; $6c57
	add e			; $6c58
	and $1f			; $6c59
	ld e,a			; $6c5b
	ld a,($cd08)		; $6c5c
	swap a			; $6c5f
	add d			; $6c61
	and $0f			; $6c62
	ld hl,vramBgMapTable		; $6c64
	rst_addDoubleIndex			; $6c67
	ldi a,(hl)		; $6c68
	add e			; $6c69
	ld e,a			; $6c6a
	ld d,(hl)		; $6c6b
	ret			; $6c6c
	call $6ce6		; $6c6d
	jr c,_label_04_328	; $6c70
	call $6d17		; $6c72
	jr c,_label_04_328	; $6c75
	ld a,($cc49)		; $6c77
	ld hl,$533c		; $6c7a
	rst_addDoubleIndex			; $6c7d
	ldi a,(hl)		; $6c7e
	ld h,(hl)		; $6c7f
	ld l,a			; $6c80
	ld a,($cc4c)		; $6c81
	rst_addAToHl			; $6c84
	ld a,(hl)		; $6c85
	and $80			; $6c86
	ldh (<hFF8B),a	; $6c88
	ld a,(hl)		; $6c8a
	and $7f			; $6c8b
	call multiplyABy8		; $6c8d
	ld hl,$4c84		; $6c90
	add hl,bc		; $6c93
	ld a,(hl)		; $6c94
	inc a			; $6c95
	jr nz,_label_04_328	; $6c96
	inc hl			; $6c98
	ldi a,(hl)		; $6c99
	ld h,(hl)		; $6c9a
	ld l,a			; $6c9b
	ld a,($cc4e)		; $6c9c
	call multiplyABy8		; $6c9f
	add hl,bc		; $6ca2
_label_04_328:
	ldi a,(hl)		; $6ca3
	ld e,a			; $6ca4
	and $0f			; $6ca5
	cp $0f			; $6ca7
	jr nz,_label_04_329	; $6ca9
	ld a,$ff		; $6cab
_label_04_329:
	ld ($cc55),a		; $6cad
	ld a,e			; $6cb0
	swap a			; $6cb1
	and $0f			; $6cb3
	ld ($cc4f),a		; $6cb5
	ldi a,(hl)		; $6cb8
	ld ($cc50),a		; $6cb9
	ld b,$06		; $6cbc
	ld de,$cd20		; $6cbe
_label_04_330:
	ldi a,(hl)		; $6cc1
	ld (de),a		; $6cc2
	inc e			; $6cc3
	dec b			; $6cc4
	jr nz,_label_04_330	; $6cc5
	ld e,$20		; $6cc7
	ld a,(de)		; $6cc9
	ld b,a			; $6cca
	ldh a,(<hFF8B)	; $6ccb
	or b			; $6ccd
	ld (de),a		; $6cce
	ld a,($cc49)		; $6ccf
	or a			; $6cd2
	ret nz			; $6cd3
	ld a,($cc4c)		; $6cd4
	cp $96			; $6cd7
	ret nz			; $6cd9
	call getThisRoomFlags		; $6cda
	and $80			; $6cdd
	ret nz			; $6cdf
	ld a,$20		; $6ce0
	ld ($cd20),a		; $6ce2
	ret			; $6ce5
	ld a,$15		; $6ce6
	call checkGlobalFlag		; $6ce8
	ret z			; $6ceb
	call $6cff		; $6cec
	ret nc			; $6cef
	ld a,($cc4e)		; $6cf0
	call multiplyABy8		; $6cf3
	ld hl,$52fc		; $6cf6
	add hl,bc		; $6cf9
_label_04_331:
	xor a			; $6cfa
	ldh (<hFF8B),a	; $6cfb
	scf			; $6cfd
	ret			; $6cfe
	ld a,($cc49)		; $6cff
	or a			; $6d02
	ret nz			; $6d03
	ld a,($cc4c)		; $6d04
	cp $14			; $6d07
	jr c,_label_04_332	; $6d09
	sub $04			; $6d0b
	cp $30			; $6d0d
	ret nc			; $6d0f
	and $0f			; $6d10
	cp $04			; $6d12
	ret			; $6d14
_label_04_332:
	xor a			; $6d15
	ret			; $6d16
	ld a,($cc49)		; $6d17
	or a			; $6d1a
	ret nz			; $6d1b
	call $6d36		; $6d1c
	ret nc			; $6d1f
	ld a,$16		; $6d20
	call checkGlobalFlag		; $6d22
	ret z			; $6d25
	ld a,($c610)		; $6d26
	sub $0a			; $6d29
	and $03			; $6d2b
	call multiplyABy8		; $6d2d
	ld hl,$531c		; $6d30
	add hl,bc		; $6d33
	jr _label_04_331		; $6d34
	ld a,($cc4c)		; $6d36
	ld b,$05		; $6d39
	ld hl,$6d49		; $6d3b
_label_04_333:
	cp (hl)			; $6d3e
	jr z,_label_04_334	; $6d3f
	inc hl			; $6d41
	dec b			; $6d42
	jr nz,_label_04_333	; $6d43
	xor a			; $6d45
	ret			; $6d46
_label_04_334:
	scf			; $6d47
	ret			; $6d48
	ld e,e			; $6d49
	ld e,h			; $6d4a
	ld l,e			; $6d4b
	ld l,h			; $6d4c
	ld a,e			; $6d4d
	ld e,(hl)		; $6d4e
	ld l,l			; $6d4f
	jp nc,$476e		; $6d50
	ld l,a			; $6d53
	ei			; $6d54
	ld l,a			; $6d55
	rst_addDoubleIndex			; $6d56
	ld (hl),b		; $6d57
	or $71			; $6d58
	ld b,$74		; $6d5a
	ld (hl),$74		; $6d5c
	call nc,$0154		; $6d5e
	sub (hl)		; $6d61
	ld b,h			; $6d62
	ld bc,objectSetCollideRadius		; $6d63
	ld bc,$2560		; $6d66
	ld bc,$131d		; $6d69
	ld bc,scriptFunc_add3ToHl_scf		; $6d6c
	ld bc,$3400		; $6d6f
	ld bc,$34d0		; $6d72
	ld bc,$4503		; $6d75
	ld c,$00		; $6d78
	ld b,h			; $6d7a
	ld bc,$4400		; $6d7b
	ld bc,$1388		; $6d7e
	ld bc,$02b3		; $6d81
	ld bc,$11b6		; $6d84
	ld bc,$11c5		; $6d87
	ld bc,$14c5		; $6d8a
	ld bc,$44c8		; $6d8d
	ld bc,$43d7		; $6d90
	ld bc,$45e8		; $6d93
	ld bc,$24f6		; $6d96
	ld bc,$26f6		; $6d99
	ld bc,$18b5		; $6d9c
	ld bc,$33f9		; $6d9f
	ld bc,$25f9		; $6da2
	ld bc,$45e6		; $6da5
	ld bc,$ffd9		; $6da8
	di			; $6dab
	sbc d			; $6dac
	inc sp			; $6dad
	ld bc,$35b0		; $6dae
	ld bc,$541e		; $6db1
	ld bc,$22b9		; $6db4
	ld bc,$2225		; $6db7
	ld bc,$3704		; $6dba
	ld bc,$42a3		; $6dbd
	ld bc,$3678		; $6dc0
	ld bc,$3462		; $6dc3
	ld bc,$2762		; $6dc6
	ld bc,$2160		; $6dc9
	ld bc,$127d		; $6dcc
	ld bc,$188d		; $6dcf
	inc b			; $6dd2
	adc (hl)		; $6dd3
	ld (de),a		; $6dd4
	inc b			; $6dd5
	adc (hl)		; $6dd6
	ld b,e			; $6dd7
	ld bc,$488e		; $6dd8
	ld bc,$65da		; $6ddb
	ld bc,$15ea		; $6dde
	ld bc,$07ea		; $6de1
	ld bc,$477f		; $6de4
	ld bc,$124f		; $6de7
	ld bc,createTreasure		; $6dea
	ld bc,$280b		; $6ded
	ld bc,$111c		; $6df0
	ld bc,$150f		; $6df3
	ld bc,$550f		; $6df6
	ld bc,$371f		; $6df9
	ld bc,$37aa		; $6dfc
	ld bc,$0816		; $6dff
	ld bc,$1306		; $6e02
	ld bc,refreshObjectGfx		; $6e05
	ld bc,$1307		; $6e08
	ld bc,$2704		; $6e0b
	ld bc,$0415		; $6e0e
	ld bc,$1718		; $6e11
	ld bc,$1328		; $6e14
	ld bc,$1139		; $6e17
	ld bc,$2609		; $6e1a
	ld bc,$0619		; $6e1d
	ld bc,$0819		; $6e20
	ld bc,$2219		; $6e23
	ld bc,$5719		; $6e26
	ld bc,$1729		; $6e29
	ld bc,_interactionActuallyRunScript		; $6e2c
	ld bc,func_1703		; $6e2f
	ld bc,$1843		; $6e32
	ld bc,$114d		; $6e35
	ld bc,$663d		; $6e38
	ld bc,$154d		; $6e3b
	ld bc,$1802		; $6e3e
	ld bc,$6110		; $6e41
	ld bc,$445e		; $6e44
	ld bc,$573f		; $6e47
	ld bc,$465d		; $6e4a
	ld bc,$326d		; $6e4d
	ld bc,$576f		; $6e50
	ld bc,$33f7		; $6e53
	ld bc,$335b		; $6e56
	ld bc,$355b		; $6e59
	ld bc,$66e2		; $6e5c
	ld bc,$55ee		; $6e5f
	ld bc,$16dc		; $6e62
	ld bc,$14e0		; $6e65
	ld bc,$4487		; $6e68
	ld bc,$3187		; $6e6b
	ld bc,$1431		; $6e6e
	ld bc,$47e1		; $6e71
	ld bc,$06f1		; $6e74
	ld bc,$47fd		; $6e77
	ld bc,$36ff		; $6e7a
	ld bc,$15bf		; $6e7d
	ld bc,$15bf		; $6e80
	ld bc,$11cc		; $6e83
	ld bc,$5651		; $6e86
	ld bc,$07c2		; $6e89
	ld bc,$28a7		; $6e8c
	ld bc,$06d3		; $6e8f
	ld bc,$121e		; $6e92
	ld bc,$181d		; $6e95
	ld bc,$5228		; $6e98
	ld bc,$5566		; $6e9b
	ld bc,$2397		; $6e9e
	ld bc,$12d2		; $6ea1
	ld bc,$62f9		; $6ea4
	ld bc,$1802		; $6ea7
	ld bc,$328f		; $6eaa
	ld bc,$56a4		; $6ead
	ld bc,$3257		; $6eb0
	ld bc,$6569		; $6eb3
	ld bc,$4879		; $6eb6
	ld bc,$5559		; $6eb9
	ld bc,$545a		; $6ebc
	ld bc,$1749		; $6ebf
	ld bc,$14d7		; $6ec2
	ld bc,$1557		; $6ec5
	ld bc,$27a6		; $6ec8
	ld bc,$117e		; $6ecb
	ld bc,$55b6		; $6ece
	inc b			; $6ed1
	nop			; $6ed2
	inc hl			; $6ed3
	ld bc,$6703		; $6ed4
	ld bc,$6704		; $6ed7
	ld bc,$3111		; $6eda
	ld bc,$2558		; $6edd
	ld bc,$5258		; $6ee0
	ld bc,$2405		; $6ee3
	ld bc,$2257		; $6ee6
	ld bc,$6353		; $6ee9
	ld bc,$344a		; $6eec
	ld bc,$2713		; $6eef
	ld bc,$3220		; $6ef2
	ld bc,$2472		; $6ef5
	ld bc,$2424		; $6ef8
	ld bc,$4823		; $6efb
	ld bc,$4633		; $6efe
	ld bc,$4344		; $6f01
	ld bc,$4345		; $6f04
	ld c,$26		; $6f07
	ld d,(hl)		; $6f09
	ld bc,$2851		; $6f0a
	ld bc,makeAllPaletteUseFading		; $6f0d
	ld bc,$6549		; $6f10
	ld bc,$245a		; $6f13
	ld bc,setPaletteThreadDelay		; $6f16
	ld bc,$3272		; $6f19
	ld bc,$5372		; $6f1c
	ld bc,$5812		; $6f1f
	ld bc,$4335		; $6f22
	ld bc,$4635		; $6f25
	ld bc,$2774		; $6f28
	ld bc,$6454		; $6f2b
	ld bc,$5528		; $6f2e
	ld bc,$444a		; $6f31
	ld bc,$441a		; $6f34
	ld bc,$4509		; $6f37
	ld c,$28		; $6f3a
	ld b,e			; $6f3c
	ld bc,$5308		; $6f3d
	ld bc,$230a		; $6f40
	ld bc,$472a		; $6f43
	ld bc,$ff0b		; $6f46
	sub e			; $6f49
	inc c			; $6f4a
	rst $38			; $6f4b
	sub e			; $6f4c
	ld a,e			; $6f4d
	rst $38			; $6f4e
	sub e			; $6f4f
	dec hl			; $6f50
	rst $38			; $6f51
	sub e			; $6f52
	inc l			; $6f53
	rst $38			; $6f54
	sub e			; $6f55
	dec l			; $6f56
	rst $38			; $6f57
	sub e			; $6f58
	ld e,e			; $6f59
	rst $38			; $6f5a
	sub e			; $6f5b
	ld e,h			; $6f5c
	rst $38			; $6f5d
	sub e			; $6f5e
	ld e,l			; $6f5f
	rst $38			; $6f60
	sub e			; $6f61
	ld e,(hl)		; $6f62
	rst $38			; $6f63
	sub e			; $6f64
	dec bc			; $6f65
	ld b,h			; $6f66
	ld bc,$440c		; $6f67
	ld bc,vramBgMapTable		; $6f6a
	ld bc,$362b		; $6f6d
	ld bc,$362c		; $6f70
	ld bc,$362d		; $6f73
	ld bc,$365b		; $6f76
	ld bc,$365c		; $6f79
	ld bc,$365d		; $6f7c
	ld bc,$365e		; $6f7f
	ld bc,$440b		; $6f82
	ld bc,$440c		; $6f85
	ld bc,$566b		; $6f88
	ld bc,$561b		; $6f8b
	ld bc,$561c		; $6f8e
	ld bc,$561d		; $6f91
	ld bc,$564b		; $6f94
	ld bc,$564c		; $6f97
	ld bc,$564d		; $6f9a
	ld bc,$564e		; $6f9d
	ld bc,$440b		; $6fa0
	ld bc,$440c		; $6fa3
	ld bc,$566b		; $6fa6
	ld bc,$061b		; $6fa9
	ld bc,$061c		; $6fac
	ld bc,$061d		; $6faf
	ld bc,$064b		; $6fb2
	ld bc,$064c		; $6fb5
	ld bc,$064d		; $6fb8
	ld bc,$064d		; $6fbb
	ld bc,$440b		; $6fbe
	ld bc,$440c		; $6fc1
	ld bc,$566b		; $6fc4
	ld bc,$561b		; $6fc7
	ld bc,$561c		; $6fca
	ld bc,$561d		; $6fcd
	ld bc,$533b		; $6fd0
	ld bc,$533c		; $6fd3
	ld bc,$533d		; $6fd6
	ld bc,$533e		; $6fd9
	ld bc,$675e		; $6fdc
	inc b			; $6fdf
	ld e,(hl)		; $6fe0
	ld h,a			; $6fe1
	inc b			; $6fe2
	ld e,(hl)		; $6fe3
	ld h,a			; $6fe4
	inc b			; $6fe5
	ld e,(hl)		; $6fe6
	ld h,a			; $6fe7
	inc b			; $6fe8
	ld e,(hl)		; $6fe9
	ld h,a			; $6fea
	inc b			; $6feb
	ld e,(hl)		; $6fec
	ld h,a			; $6fed
	inc b			; $6fee
	ld e,(hl)		; $6fef
	ld h,a			; $6ff0
	inc b			; $6ff1
	ld e,(hl)		; $6ff2
	ld h,a			; $6ff3
	inc b			; $6ff4
	ld e,(hl)		; $6ff5
	ld h,a			; $6ff6
	inc b			; $6ff7
	ld e,(hl)		; $6ff8
	ld h,a			; $6ff9
	inc b			; $6ffa
	add b			; $6ffb
	rst $38			; $6ffc
	sub e			; $6ffd
	add c			; $6ffe
	rst $38			; $6fff
	sub e			; $7000
	add d			; $7001
	rst $38			; $7002
	sub e			; $7003
	add e			; $7004
	rst $38			; $7005
	sub e			; $7006
	add h			; $7007
	rst $38			; $7008
	sub e			; $7009
	add l			; $700a
	rst $38			; $700b
	sub e			; $700c
	adc b			; $700d
	rst $38			; $700e
	sub e			; $700f
	adc c			; $7010
	di			; $7011
	sub e			; $7012
	adc d			; $7013
	rst $38			; $7014
	sub e			; $7015
	adc d			; $7016
	ld de,$8b04		; $7017
	ld de,$8b04		; $701a
	ld h,c			; $701d
	inc b			; $701e
	adc h			; $701f
	rst $38			; $7020
	sub e			; $7021
	adc h			; $7022
	ld h,c			; $7023
	inc b			; $7024
	adc h			; $7025
	ld l,b			; $7026
	inc b			; $7027
	adc l			; $7028
	rst $38			; $7029
	sub e			; $702a
	adc l			; $702b
	ld de,$8d04		; $702c
	jr _label_04_335		; $702f
	adc l			; $7031
	ld h,c			; $7032
	inc b			; $7033
	adc a			; $7034
_label_04_335:
	rst $38			; $7035
	sub e			; $7036
	sub b			; $7037
	rst $38			; $7038
	sub e			; $7039
	sub c			; $703a
	rst $38			; $703b
	sub e			; $703c
	sub d			; $703d
	rst $38			; $703e
	sub e			; $703f
	sub e			; $7040
	rst $38			; $7041
	sub e			; $7042
	sub h			; $7043
	rst $38			; $7044
	sub e			; $7045
	sub l			; $7046
	jr _label_04_336		; $7047
	sub (hl)		; $7049
	rst $38			; $704a
	sub e			; $704b
	sub a			; $704c
_label_04_336:
	di			; $704d
	sub e			; $704e
	sbc b			; $704f
	ld h,c			; $7050
	ld bc,$ff99		; $7051
	sub e			; $7054
	sbc d			; $7055
	jr _label_04_337		; $7056
	sbc e			; $7058
	ld l,b			; $7059
	inc b			; $705a
	sbc h			; $705b
_label_04_337:
	rst $38			; $705c
	sub e			; $705d
	sbc l			; $705e
	rst $38			; $705f
	sub e			; $7060
	sbc (hl)		; $7061
	rst $30			; $7062
	sub e			; $7063
	sbc a			; $7064
	rst $38			; $7065
	sub e			; $7066
	and b			; $7067
	rst $38			; $7068
	sub e			; $7069
	and c			; $706a
	rst $38			; $706b
	sub e			; $706c
	and d			; $706d
	di			; $706e
	sub e			; $706f
	and e			; $7070
	rst $38			; $7071
	sub e			; $7072
	and e			; $7073
	inc b			; $7074
	rlca			; $7075
	and h			; $7076
	rst $38			; $7077
	sub e			; $7078
	and l			; $7079
	di			; $707a
	sub e			; $707b
	and (hl)		; $707c
	rst $38			; $707d
	sub e			; $707e
	and (hl)		; $707f
	ld sp,$a704		; $7080
	ld de,$a704		; $7083
	ld sp,$a804		; $7086
	inc d			; $7089
	inc b			; $708a
	xor b			; $708b
	rst $38			; $708c
	sub e			; $708d
	xor c			; $708e
	rst $38			; $708f
	sub e			; $7090
	xor d			; $7091
	rst $38			; $7092
	sub e			; $7093
	xor e			; $7094
	ld h,(hl)		; $7095
	inc b			; $7096
	xor e			; $7097
	ld b,h			; $7098
	inc b			; $7099
	xor h			; $709a
	rst $38			; $709b
	di			; $709c
	xor l			; $709d
	rst $38			; $709e
	sub e			; $709f
	xor (hl)		; $70a0
	rst $38			; $70a1
	sub e			; $70a2
	xor a			; $70a3
	rst $38			; $70a4
	sub e			; $70a5
	or b			; $70a6
	ld de,$b104		; $70a7
	ld hl,sp-$6d		; $70aa
	or d			; $70ac
	rst $38			; $70ad
	sub e			; $70ae
	or e			; $70af
	rst $38			; $70b0
	sub e			; $70b1
	or h			; $70b2
	rst $38			; $70b3
	sub e			; $70b4
	or l			; $70b5
	rst $38			; $70b6
	sub e			; $70b7
	or (hl)			; $70b8
	rst $38			; $70b9
	sub e			; $70ba
	or (hl)			; $70bb
	ld e,b			; $70bc
	inc b			; $70bd
	or a			; $70be
	jr _label_04_338		; $70bf
	cp b			; $70c1
	di			; $70c2
	sub e			; $70c3
	cp b			; $70c4
_label_04_338:
	rst $30			; $70c5
	sub e			; $70c6
	cp b			; $70c7
	dec (hl)		; $70c8
	inc b			; $70c9
	cp c			; $70ca
	ld l,b			; $70cb
	inc b			; $70cc
	cp d			; $70cd
	ld h,c			; $70ce
	inc b			; $70cf
	cp e			; $70d0
	rst $38			; $70d1
	sub e			; $70d2
	cp h			; $70d3
	rst $38			; $70d4
	sub e			; $70d5
	cp l			; $70d6
	rst $38			; $70d7
	sub e			; $70d8
	cp (hl)			; $70d9
	rst $38			; $70da
	sub e			; $70db
	cp a			; $70dc
	rst $38			; $70dd
	sub e			; $70de
	inc b			; $70df
	rst $38			; $70e0
	sub e			; $70e1
	dec b			; $70e2
	ld l,l			; $70e3
	dec b			; $70e4
	inc e			; $70e5
	rst $38			; $70e6
	sub e			; $70e7
	add hl,sp		; $70e8
	rst $38			; $70e9
	sub e			; $70ea
	ld c,e			; $70eb
	rst $38			; $70ec
	sub e			; $70ed
	add c			; $70ee
	rst $38			; $70ef
	sub e			; $70f0
	and a			; $70f1
	rst $38			; $70f2
	sub e			; $70f3
	cp d			; $70f4
	rst $38			; $70f5
	sub e			; $70f6
	rlca			; $70f7
	ld a,c			; $70f8
	inc b			; $70f9
	ld a,(bc)		; $70fa
	ld d,a			; $70fb
	inc b			; $70fc
	rra			; $70fd
	ld de,fastFadeinFromWhiteToRoom		; $70fe
	ld e,e			; $7101
	inc b			; $7102
	inc sp			; $7103
	sub c			; $7104
	inc b			; $7105
	scf			; $7106
	sbc l			; $7107
	inc b			; $7108
	ld a,$5b		; $7109
	inc b			; $710b
	ccf			; $710c
	ld d,d			; $710d
	inc b			; $710e
	ccf			; $710f
	ld e,l			; $7110
	inc b			; $7111
	ld b,c			; $7112
	dec e			; $7113
	inc b			; $7114
	ld b,c			; $7115
	ld hl,$4304		; $7116
	inc d			; $7119
	inc b			; $711a
	ld b,h			; $711b
	ld l,l			; $711c
	inc b			; $711d
	ld c,b			; $711e
	sbc l			; $711f
	inc b			; $7120
	ld c,d			; $7121
	ld h,a			; $7122
	inc b			; $7123
	ld c,a			; $7124
	ld d,d			; $7125
	inc b			; $7126
	ld d,d			; $7127
	dec e			; $7128
	inc b			; $7129
	ld d,e			; $712a
	inc d			; $712b
	inc b			; $712c
	ld d,a			; $712d
	sbc l			; $712e
	inc b			; $712f
	ld e,c			; $7130
	ld h,a			; $7131
	inc b			; $7132
	ld h,l			; $7133
	ld de,$7704		; $7134
	ld de,$6904		; $7137
	ldi (hl),a		; $713a
	inc b			; $713b
	ld h,c			; $713c
	ldi (hl),a		; $713d
	inc b			; $713e
	ld h,(hl)		; $713f
	ldi (hl),a		; $7140
	inc b			; $7141
	ld a,c			; $7142
	ld de,$6804		; $7143
	sub c			; $7146
	inc b			; $7147
	ld l,l			; $7148
	ld d,l			; $7149
	inc b			; $714a
	adc (hl)		; $714b
	rla			; $714c
	inc b			; $714d
	sub b			; $714e
	sub a			; $714f
	inc b			; $7150
	sub b			; $7151
	sbc l			; $7152
	inc b			; $7153
	sub e			; $7154
	ld c,h			; $7155
	inc b			; $7156
	sbc e			; $7157
	dec hl			; $7158
	inc b			; $7159
	and c			; $715a
	rla			; $715b
	inc b			; $715c
	xor d			; $715d
	rlca			; $715e
	inc b			; $715f
	xor h			; $7160
	ld bc,$ad04		; $7161
	jr _label_04_339		; $7164
	or h			; $7166
	inc c			; $7167
	inc b			; $7168
	cp h			; $7169
_label_04_339:
	rlca			; $716a
	inc b			; $716b
	cp (hl)			; $716c
	ld bc,$bf04		; $716d
	jr _label_04_340		; $7170
	call nz,$040c		; $7172
	push bc			; $7175
_label_04_340:
	sub c			; $7176
	inc b			; $7177
	call $049d		; $7178
	adc $91			; $717b
	inc b			; $717d
.DB $d3				; $717e
	ld h,d			; $717f
	inc b			; $7180
	call nc,$049d		; $7181
	push de			; $7184
	rlca			; $7185
	inc b			; $7186
	sub $62			; $7187
	inc b			; $7189
	ld ($ff00+$ff),a	; $718a
	sub e			; $718c
	pop hl			; $718d
	push af			; $718e
	sub e			; $718f
.DB $e3				; $7190
	ld (de),a		; $7191
	inc b			; $7192
.DB $e3				; $7193
	adc h			; $7194
	inc b			; $7195
	push hl			; $7196
	ld a,e			; $7197
	inc b			; $7198
	push hl			; $7199
	add (hl)		; $719a
	inc b			; $719b
	and $66			; $719c
	inc b			; $719e
	rst $20			; $719f
	ld c,d			; $71a0
	inc b			; $71a1
	add sp,-$04		; $71a2
	sub e			; $71a4
	add sp,$0c		; $71a5
	ld bc,$fce9		; $71a7
	sub e			; $71aa
	jp hl			; $71ab
	inc c			; $71ac
	ld bc,$ffea		; $71ad
	sub e			; $71b0
.DB $eb				; $71b1
	rst $38			; $71b2
	sub e			; $71b3
.DB $ec				; $71b4
	add hl,hl		; $71b5
	inc b			; $71b6
.DB $ed				; $71b7
	rst $38			; $71b8
	sub e			; $71b9
	xor $ff			; $71ba
	sub e			; $71bc
	rst $28			; $71bd
	rst $38			; $71be
	sub e			; $71bf
	ld a,($ff00+$ff)	; $71c0
	sub e			; $71c2
	pop af			; $71c3
	rst $38			; $71c4
	sub e			; $71c5
	ld a,($ff00+c)		; $71c6
	add hl,de		; $71c7
	inc b			; $71c8
	ld a,($ff00+c)		; $71c9
	rst $38			; $71ca
	sub e			; $71cb
	di			; $71cc
	rst $38			; $71cd
	sub e			; $71ce
.DB $f4				; $71cf
	daa			; $71d0
	inc b			; $71d1
.DB $f4				; $71d2
	ld (hl),a		; $71d3
	inc b			; $71d4
	push af			; $71d5
	ld b,(hl)		; $71d6
	inc b			; $71d7
	push af			; $71d8
	scf			; $71d9
	inc b			; $71da
	or $2a			; $71db
	inc b			; $71dd
	or $ff			; $71de
	sub e			; $71e0
	rst $30			; $71e1
	ld (hl),c		; $71e2
	inc b			; $71e3
	ld hl,sp-$66		; $71e4
	inc b			; $71e6
	ld sp,hl		; $71e7
.DB $f4				; $71e8
	sub e			; $71e9
	ld sp,hl		; $71ea
	ld a,($fa93)		; $71eb
	rst $38			; $71ee
	sub e			; $71ef
	ei			; $71f0
	rst $38			; $71f1
	sub e			; $71f2
.DB $fc				; $71f3
	rst $38			; $71f4
	sub e			; $71f5
	ld e,e			; $71f6
	rst $38			; $71f7
	sub e			; $71f8
	add a			; $71f9
	rst $38			; $71fa
	sub e			; $71fb
	sub a			; $71fc
	rst $38			; $71fd
	sub e			; $71fe
	sbc l			; $71ff
	rst $38			; $7200
	sub e			; $7201
	jr nc,-$01		; $7202
	sub e			; $7204
	scf			; $7205
	sub a			; $7206
	inc b			; $7207
	add hl,sp		; $7208
	dec hl			; $7209
	inc b			; $720a
	inc a			; $720b
	dec d			; $720c
	inc b			; $720d
	ld b,e			; $720e
	ld de,$4304		; $720f
	ld d,$04		; $7212
	ld b,e			; $7214
	dec de			; $7215
	inc b			; $7216
	ld b,e			; $7217
	ld b,c			; $7218
	inc b			; $7219
	ld b,e			; $721a
	ld b,h			; $721b
	inc b			; $721c
	ld b,e			; $721d
	ld b,(hl)		; $721e
	inc b			; $721f
	ld b,e			; $7220
	ld c,b			; $7221
	inc b			; $7222
	ld b,e			; $7223
	ld c,h			; $7224
	inc b			; $7225
	ld b,e			; $7226
	ld h,(hl)		; $7227
	inc b			; $7228
	ld b,e			; $7229
	ld l,c			; $722a
	inc b			; $722b
	ld b,e			; $722c
	ld (hl),e		; $722d
	inc b			; $722e
	ld b,e			; $722f
	ld a,e			; $7230
	inc b			; $7231
	ld b,e			; $7232
	sbc l			; $7233
	inc b			; $7234
	ld b,e			; $7235
	sub c			; $7236
	inc b			; $7237
	ld b,(hl)		; $7238
	ld d,a			; $7239
	inc b			; $723a
	ld b,a			; $723b
	sub a			; $723c
	inc b			; $723d
	ld c,d			; $723e
	dec hl			; $723f
	inc b			; $7240
	ld c,e			; $7241
	add d			; $7242
	inc b			; $7243
	ld c,e			; $7244
	adc h			; $7245
	inc b			; $7246
	ld c,h			; $7247
	dec d			; $7248
	inc b			; $7249
	ld d,c			; $724a
	ld de,$5104		; $724b
	ld d,$04		; $724e
	ld d,c			; $7250
	dec de			; $7251
	inc b			; $7252
	ld d,c			; $7253
	ld b,c			; $7254
	inc b			; $7255
	ld d,c			; $7256
	ld b,h			; $7257
	inc b			; $7258
	ld d,c			; $7259
	ld b,(hl)		; $725a
	inc b			; $725b
	ld d,c			; $725c
	ld c,b			; $725d
	inc b			; $725e
	ld d,c			; $725f
	ld c,h			; $7260
	inc b			; $7261
	ld d,c			; $7262
	ld h,(hl)		; $7263
	inc b			; $7264
	ld d,c			; $7265
	ld l,c			; $7266
	inc b			; $7267
	ld d,c			; $7268
	ld (hl),e		; $7269
	inc b			; $726a
	ld d,c			; $726b
	ld a,e			; $726c
	inc b			; $726d
	ld d,c			; $726e
	sbc l			; $726f
	inc b			; $7270
	ld d,c			; $7271
	sub c			; $7272
	inc b			; $7273
	ld d,e			; $7274
	ld d,a			; $7275
	inc b			; $7276
	ld d,a			; $7277
	add d			; $7278
	inc b			; $7279
	ld d,a			; $727a
	adc h			; $727b
	inc b			; $727c
	ld e,(hl)		; $727d
	inc l			; $727e
	inc b			; $727f
	ld h,e			; $7280
	adc h			; $7281
	inc b			; $7282
	ld l,b			; $7283
	ld a,d			; $7284
	inc b			; $7285
	ld l,c			; $7286
	inc l			; $7287
	inc b			; $7288
	ld l,d			; $7289
	adc h			; $728a
	inc b			; $728b
	ld l,e			; $728c
	ld d,l			; $728d
	inc b			; $728e
	ld l,h			; $728f
	ld a,d			; $7290
	inc b			; $7291
	ld l,(hl)		; $7292
	inc sp			; $7293
	inc b			; $7294
	ld (hl),c		; $7295
	inc e			; $7296
	inc b			; $7297
	ld (hl),e		; $7298
	sub c			; $7299
	inc b			; $729a
	ld (hl),h		; $729b
	dec (hl)		; $729c
	inc b			; $729d
	ld (hl),h		; $729e
	ld l,l			; $729f
	inc b			; $72a0
	ld (hl),a		; $72a1
	inc l			; $72a2
	inc b			; $72a3
	ld a,b			; $72a4
	ldi (hl),a		; $72a5
	inc b			; $72a6
	add h			; $72a7
	adc e			; $72a8
	inc b			; $72a9
	add (hl)		; $72aa
	rla			; $72ab
	inc b			; $72ac
	adc b			; $72ad
	adc h			; $72ae
	inc b			; $72af
	adc c			; $72b0
	ld d,l			; $72b1
	inc b			; $72b2
	adc d			; $72b3
	ld a,d			; $72b4
	inc b			; $72b5
	adc e			; $72b6
	inc hl			; $72b7
	inc b			; $72b8
	adc h			; $72b9
	inc e			; $72ba
	inc b			; $72bb
	adc l			; $72bc
	sub c			; $72bd
	inc b			; $72be
	adc (hl)		; $72bf
	dec (hl)		; $72c0
	inc b			; $72c1
	adc (hl)		; $72c2
	ld l,l			; $72c3
	inc b			; $72c4
	ld h,a			; $72c5
	inc l			; $72c6
	inc b			; $72c7
	add e			; $72c8
	inc l			; $72c9
	inc b			; $72ca
	sbc d			; $72cb
	ld h,(hl)		; $72cc
	inc b			; $72cd
	sbc l			; $72ce
	ld d,a			; $72cf
	inc b			; $72d0
	sbc (hl)		; $72d1
	sbc l			; $72d2
	inc b			; $72d3
	ld sp,$041c		; $72d4
	inc sp			; $72d7
	inc e			; $72d8
	inc b			; $72d9
	cpl			; $72da
	adc l			; $72db
	inc b			; $72dc
	add hl,hl		; $72dd
	adc l			; $72de
	inc b			; $72df
	jr z,_label_04_341	; $72e0
	inc b			; $72e2
	jr nz,_label_04_342	; $72e3
	inc b			; $72e5
	inc h			; $72e6
	ldi (hl),a		; $72e7
	inc b			; $72e8
	ld h,$22		; $72e9
	inc b			; $72eb
	inc l			; $72ec
	ldi (hl),a		; $72ed
	dec b			; $72ee
	daa			; $72ef
	ld d,a			; $72f0
	inc b			; $72f1
	inc (hl)		; $72f2
	sub a			; $72f3
	inc b			; $72f4
	or b			; $72f5
	push af			; $72f6
	sub e			; $72f7
	or b			; $72f8
	inc hl			; $72f9
	inc b			; $72fa
	or b			; $72fb
	dec a			; $72fc
	inc b			; $72fd
_label_04_341:
	or c			; $72fe
	ld a,b			; $72ff
	inc b			; $7300
	or c			; $7301
	inc hl			; $7302
	inc b			; $7303
	or d			; $7304
	ld a,($b293)		; $7305
	ld b,e			; $7308
	inc b			; $7309
	or e			; $730a
	di			; $730b
	sub e			; $730c
	or e			; $730d
.DB $fc				; $730e
	sub e			; $730f
	or h			; $7310
	di			; $7311
	sub e			; $7312
	or l			; $7313
	rst $38			; $7314
	sub e			; $7315
	or (hl)			; $7316
	rst $38			; $7317
	sub e			; $7318
	or a			; $7319
	inc h			; $731a
	inc b			; $731b
	or a			; $731c
	ld (hl),h		; $731d
	inc b			; $731e
	cp b			; $731f
	inc h			; $7320
	inc b			; $7321
	cp c			; $7322
	ld sp,hl		; $7323
	sub e			; $7324
	cp d			; $7325
	inc h			; $7326
	inc b			; $7327
	cp d			; $7328
.DB $f4				; $7329
	sub e			; $732a
_label_04_342:
	cp e			; $732b
	rst $38			; $732c
	sub e			; $732d
	cp (hl)			; $732e
	inc (hl)		; $732f
	inc b			; $7330
	cp (hl)			; $7331
	ld c,b			; $7332
	inc b			; $7333
	cp a			; $7334
	inc (hl)		; $7335
	inc b			; $7336
	cp a			; $7337
	ld a,d			; $7338
	inc b			; $7339
	ret nz			; $733a
	ld a,d			; $733b
	inc b			; $733c
	pop bc			; $733d
.DB $f4				; $733e
	sub e			; $733f
	pop bc			; $7340
	inc l			; $7341
	inc b			; $7342
	jp nz,$0422		; $7343
	jp nz,$042c		; $7346
	jp $0433		; $7349
	call nz,$933b		; $734c
	push bc			; $734f
	rst $38			; $7350
	sub e			; $7351
	add $ff			; $7352
	sub e			; $7354
	rst_jumpTable			; $7355
	rst $38			; $7356
	sub e			; $7357
	ret z			; $7358
	ei			; $7359
	sub e			; $735a
	ret z			; $735b
	inc sp			; $735c
	inc b			; $735d
	ret			; $735e
	rst $38			; $735f
	sub e			; $7360
	ret			; $7361
	inc e			; $7362
	inc b			; $7363
	ret			; $7364
	sbc l			; $7365
	inc b			; $7366
	jp z,$93f6		; $7367
	jp z,$0424		; $736a
	set 6,h			; $736d
	sub e			; $736f
	set 7,h			; $7370
	sub e			; $7372
	rr h			; $7373
	inc b			; $7375
	call z,$93f6		; $7376
	call z,fillMemory		; $7379
	rst $8			; $737c
	ld d,$04		; $737d
	rst $8			; $737f
	sub a			; $7380
	inc b			; $7381
	call nc,$0497		; $7382
	ret nc			; $7385
	ld (hl),h		; $7386
	inc b			; $7387
	pop de			; $7388
	ld (hl),h		; $7389
	inc b			; $738a
	jp nc,$0474		; $738b
.DB $d3				; $738e
	scf			; $738f
	inc b			; $7390
.DB $d3				; $7391
	rst $38			; $7392
	sub e			; $7393
	ld bc,clearOam		; $7394
	ld (bc),a		; $7397
	ld a,e			; $7398
	inc b			; $7399
	inc bc			; $739a
	ld a,e			; $739b
	inc b			; $739c
	inc b			; $739d
	ld a,e			; $739e
	inc b			; $739f
	dec b			; $73a0
	ld a,e			; $73a1
	inc b			; $73a2
	ld b,$7b		; $73a3
	inc b			; $73a5
	rlca			; $73a6
	ld a,e			; $73a7
	inc b			; $73a8
	ld (clearOam),sp		; $73a9
	add hl,bc		; $73ac
	rst $38			; $73ad
	sub e			; $73ae
	ld a,(bc)		; $73af
	add a			; $73b0
	inc b			; $73b1
	dec bc			; $73b2
	rst $38			; $73b3
	sub e			; $73b4
	inc c			; $73b5
	sbc c			; $73b6
	inc b			; $73b7
	dec c			; $73b8
	rst $38			; $73b9
	sub e			; $73ba
	ld c,$52		; $73bb
	sub e			; $73bd
	rrca			; $73be
	sbc l			; $73bf
	inc b			; $73c0
	stop			; $73c1
	add a			; $73c2
	inc b			; $73c3
	ld de,clearOam		; $73c4
	ld (de),a		; $73c7
	di			; $73c8
	sub e			; $73c9
	di			; $73ca
	rst $38			; $73cb
	sub e			; $73cc
	or $ff			; $73cd
	sub e			; $73cf
	ld sp,hl		; $73d0
	rst $38			; $73d1
	sub e			; $73d2
	ld a,($ff00+$ff)	; $73d3
	sub e			; $73d5
	di			; $73d6
	daa			; $73d7
	inc b			; $73d8
.DB $f4				; $73d9
	daa			; $73da
	inc b			; $73db
.DB $f4				; $73dc
	add a			; $73dd
	inc b			; $73de
	push af			; $73df
	add a			; $73e0
	inc b			; $73e1
	or $27			; $73e2
	inc b			; $73e4
	rst $30			; $73e5
	daa			; $73e6
	inc b			; $73e7
	rst $30			; $73e8
	add a			; $73e9
	inc b			; $73ea
	ld hl,sp-$79		; $73eb
	inc b			; $73ed
	ld sp,hl		; $73ee
	daa			; $73ef
	inc b			; $73f0
	ld a,($0427)		; $73f1
	ld a,($0487)		; $73f4
	ei			; $73f7
	add a			; $73f8
	inc b			; $73f9
	ld a,($ff00+$27)	; $73fa
	inc b			; $73fc
	pop af			; $73fd
	daa			; $73fe
	inc b			; $73ff
	pop af			; $7400
	add a			; $7401
	inc b			; $7402
	ld a,($ff00+c)		; $7403
	add a			; $7404
	inc b			; $7405
	ld bc,$f302		; $7406
	add hl,bc		; $7409
	ld (bc),a		; $740a
	di			; $740b
	dec e			; $740c
	ld (bc),a		; $740d
	di			; $740e
	ld e,$0c		; $740f
	di			; $7411
	ldd a,(hl)		; $7412
	ld bc,$3bf3		; $7413
	dec c			; $7416
	di			; $7417
	inc a			; $7418
	ld bc,$3df3		; $7419
	dec c			; $741c
	di			; $741d
	ld e,h			; $741e
	ld (bc),a		; $741f
	di			; $7420
	ld e,l			; $7421
	inc c			; $7422
	di			; $7423
	add h			; $7424
	ld bc,$85f3		; $7425
	ld bc,$86f3		; $7428
	dec c			; $742b
	di			; $742c
	add a			; $742d
	dec c			; $742e
	di			; $742f
	xor b			; $7430
	ld bc,$a9f3		; $7431
	dec c			; $7434
	di			; $7435
	ld e,h			; $7436
	ld (bc),a		; $7437
	di			; $7438
	ld e,l			; $7439
	inc c			; $743a
	di			; $743b
	ld h,b			; $743c
	ld (bc),a		; $743d
	di			; $743e
	ld h,d			; $743f
	dec c			; $7440
	di			; $7441
	ld ($ff00+$02),a	; $7442
	di			; $7444
	pop hl			; $7445
	dec bc			; $7446
	di			; $7447
	ld ($ff00+c),a		; $7448
	ld bc,$e3f3		; $7449
	rlca			; $744c
	di			; $744d
.DB $e4				; $744e
	ld bc,$e5f3		; $744f
	rlca			; $7452
	di			; $7453
	add sp,$06		; $7454
	di			; $7456
	ld h,a			; $7457
	ld (hl),h		; $7458
	sbc e			; $7459
	halt			; $745a
	ld b,e			; $745b
	ld (hl),a		; $745c
	rst $30			; $745d
	ld (hl),a		; $745e
	rlca			; $745f
	ld a,c			; $7460
	add a			; $7461
	ld a,d			; $7462
	adc e			; $7463
	ld a,l			; $7464
	rst $8			; $7465
	ld a,l			; $7466
	ld b,b			; $7467
	call nc,$764b		; $7468
	nop			; $746b
	sub (hl)		; $746c
	ld (bc),a		; $746d
	ld b,h			; $746e
	ld b,b			; $746f
	adc l			; $7470
	ld d,a			; $7471
	halt			; $7472
	ld b,b			; $7473
	ld h,b			; $7474
	ld l,e			; $7475
	halt			; $7476
	nop			; $7477
	dec e			; $7478
	dec b			; $7479
	ld b,h			; $747a
	nop			; $747b
	adc d			; $747c
	ld b,$44		; $747d
	nop			; $747f
	nop			; $7480
	rlca			; $7481
	ld b,h			; $7482
	nop			; $7483
	ret nc			; $7484
	nop			; $7485
	ld d,h			; $7486
	nop			; $7487
	inc bc			; $7488
	ld (bc),a		; $7489
	ld d,h			; $748a
	nop			; $748b
	nop			; $748c
	inc bc			; $748d
	ld d,h			; $748e
	nop			; $748f
	nop			; $7490
	inc b			; $7491
	ld d,h			; $7492
	nop			; $7493
	adc b			; $7494
	nop			; $7495
	inc (hl)		; $7496
	nop			; $7497
	or (hl)			; $7498
	ld (bc),a		; $7499
	inc (hl)		; $749a
	ld b,b			; $749b
	rst_addAToHl			; $749c
.DB $e3				; $749d
	ld (hl),l		; $749e
	ld b,b			; $749f
	push bc			; $74a0
	inc bc			; $74a1
	halt			; $74a2
	nop			; $74a3
	ret z			; $74a4
	dec b			; $74a5
	inc (hl)		; $74a6
	ld b,b			; $74a7
	jp nc,$763f		; $74a8
	nop			; $74ab
	add sp,$15		; $74ac
	inc (hl)		; $74ae
	ld b,b			; $74af
	or $23			; $74b0
	halt			; $74b2
	nop			; $74b3
	or l			; $74b4
	jr _label_04_343		; $74b5
	nop			; $74b7
	ld c,l			; $74b8
	dec e			; $74b9
	inc (hl)		; $74ba
	nop			; $74bb
	stop			; $74bc
	rra			; $74bd
	inc (hl)		; $74be
	nop			; $74bf
	ld e,(hl)		; $74c0
	jr nz,_label_04_344	; $74c1
	nop			; $74c3
	ccf			; $74c4
	ld hl,$0034		; $74c5
	ld l,l			; $74c8
	inc hl			; $74c9
	inc (hl)		; $74ca
	nop			; $74cb
	ld l,a			; $74cc
	ldd (hl),a		; $74cd
	inc (hl)		; $74ce
	ld b,b			; $74cf
	ld a,a			; $74d0
	scf			; $74d1
	halt			; $74d2
	ld b,b			; $74d3
	ld sp,hl		; $74d4
	dec hl			; $74d5
	halt			; $74d6
	nop			; $74d7
	and $2b			; $74d8
	inc (hl)		; $74da
	nop			; $74db
	inc b			; $74dc
	jr nc,$34		; $74dd
	nop			; $74df
	rst $30			; $74e0
	inc sp			; $74e1
	inc (hl)		; $74e2
	nop			; $74e3
	and e			; $74e4
	inc a			; $74e5
	inc (hl)		; $74e6
	nop			; $74e7
	ld a,b			; $74e8
	dec a			; $74e9
	inc (hl)		; $74ea
_label_04_343:
	ld b,b			; $74eb
	ld h,d			; $74ec
	dec de			; $74ed
	halt			; $74ee
	nop			; $74ef
	ld e,l			; $74f0
	ccf			; $74f1
	inc (hl)		; $74f2
	nop			; $74f3
	ld b,e			; $74f4
	ld b,c			; $74f5
	inc (hl)		; $74f6
_label_04_344:
	ld b,b			; $74f7
	ld e,e			; $74f8
	dec bc			; $74f9
	halt			; $74fa
	nop			; $74fb
	sbc d			; $74fc
	ld b,$18		; $74fd
	nop			; $74ff
	or b			; $7500
	rlca			; $7501
	jr _label_04_348		; $7502
	ld e,$fb		; $7504
	ld (hl),l		; $7506
	nop			; $7507
	cp c			; $7508
	add hl,bc		; $7509
	jr _label_04_345		; $750a
_label_04_345:
	dec h			; $750c
	ld a,(bc)		; $750d
	jr _label_04_346		; $750e
_label_04_346:
	inc b			; $7510
	dec bc			; $7511
	jr _label_04_347		; $7512
	reti			; $7514
_label_04_347:
	nop			; $7515
	inc hl			; $7516
	ld (bc),a		; $7517
	reti			; $7518
	nop			; $7519
	inc hl			; $751a
	nop			; $751b
	ld a,l			; $751c
	ld e,(hl)		; $751d
	ld d,h			; $751e
	ld b,b			; $751f
	adc (hl)		; $7520
	ld e,a			; $7521
	halt			; $7522
	nop			; $7523
	jp c,$5258		; $7524
	ld b,b			; $7527
	ld ($7673),a		; $7528
	nop			; $752b
	ld c,a			; $752c
	ld e,a			; $752d
	ld d,h			; $752e
	nop			; $752f
	dec de			; $7530
	ld h,b			; $7531
	ld d,h			; $7532
	nop			; $7533
	dec bc			; $7534
	ld h,d			; $7535
	ld d,h			; $7536
	nop			; $7537
	inc e			; $7538
	ld h,h			; $7539
	ld d,h			; $753a
	ld b,b			; $753b
	rrca			; $753c
	add e			; $753d
	halt			; $753e
	nop			; $753f
	rra			; $7540
	ld h,a			; $7541
	ld d,h			; $7542
	nop			; $7543
_label_04_348:
	xor d			; $7544
	ld l,c			; $7545
	ld d,h			; $7546
	nop			; $7547
	ld d,$6d		; $7548
	ld d,h			; $754a
	ld b,b			; $754b
	ld b,$7b		; $754c
	halt			; $754e
	nop			; $754f
	rlca			; $7550
_label_04_349:
	ld l,a			; $7551
	ld d,h			; $7552
	nop			; $7553
	dec d			; $7554
	ld (hl),l		; $7555
	ld d,h			; $7556
	nop			; $7557
	jr _label_04_350		; $7558
	ld d,h			; $755a
	ld b,b			; $755b
	jr z,_label_04_349	; $755c
	ld (hl),l		; $755e
	nop			; $755f
	add hl,sp		; $7560
	ld a,e			; $7561
	ld d,h			; $7562
	nop			; $7563
	add hl,bc		; $7564
	ld a,a			; $7565
	ld d,h			; $7566
	ld b,b			; $7567
	add hl,de		; $7568
	adc e			; $7569
	halt			; $756a
	nop			; $756b
	add hl,hl		; $756c
	add b			; $756d
	ld d,h			; $756e
	nop			; $756f
	ld sp,$4448		; $7570
	nop			; $7573
	pop af			; $7574
	ld c,a			; $7575
	ld b,h			; $7576
	nop			; $7577
.DB $fd				; $7578
	ld d,b			; $7579
	ld b,h			; $757a
	nop			; $757b
	rst $38			; $757c
	ld d,d			; $757d
	ld b,h			; $757e
	ld b,b			; $757f
	cp a			; $7580
	inc de			; $7581
	halt			; $7582
	nop			; $7583
	call z,$4456		; $7584
	nop			; $7587
	ld d,c			; $7588
	ld d,a			; $7589
	ld b,h			; $758a
	nop			; $758b
	jp nz,$445a		; $758c
	nop			; $758f
	and a			; $7590
	ld e,e			; $7591
	ld b,h			; $7592
	nop			; $7593
	or e			; $7594
	add hl,sp		; $7595
	ld b,h			; $7596
	nop			; $7597
	add a			; $7598
	ldd a,(hl)		; $7599
	ld b,h			; $759a
	nop			; $759b
.DB $d3				; $759c
	ld e,h			; $759d
	ld b,h			; $759e
	nop			; $759f
	ld ($ff00+c),a		; $75a0
	add h			; $75a1
	ld d,h			; $75a2
	nop			; $75a3
	xor $83			; $75a4
	ld d,h			; $75a6
	nop			; $75a7
	call c,$5489		; $75a8
	nop			; $75ab
	ld h,(hl)		; $75ac
	adc e			; $75ad
	ld d,h			; $75ae
	nop			; $75af
	sub a			; $75b0
	adc h			; $75b1
	ld d,h			; $75b2
	nop			; $75b3
	ld (bc),a		; $75b4
	adc a			; $75b5
	ld d,h			; $75b6
	nop			; $75b7
	adc a			; $75b8
	sub b			; $75b9
	ld d,h			; $75ba
	nop			; $75bb
	and h			; $75bc
	sub c			; $75bd
	ld d,h			; $75be
	ld b,b			; $75bf
	ld d,a			; $75c0
.DB $eb				; $75c1
	ld (hl),l		; $75c2
	nop			; $75c3
	ld l,c			; $75c4
	sub e			; $75c5
	ld d,h			; $75c6
	nop			; $75c7
	ld a,c			; $75c8
	sub h			; $75c9
	ld d,h			; $75ca
	nop			; $75cb
	ld e,c			; $75cc
	sub l			; $75cd
	ld d,h			; $75ce
	nop			; $75cf
_label_04_350:
	ld c,c			; $75d0
	sub a			; $75d1
	ld d,h			; $75d2
	nop			; $75d3
	and (hl)		; $75d4
	sbc d			; $75d5
	ld d,h			; $75d6
	nop			; $75d7
	ld ($ff00+$46),a	; $75d8
	inc (hl)		; $75da
	nop			; $75db
	ld a,(hl)		; $75dc
	sbc e			; $75dd
	ld d,h			; $75de
	add b			; $75df
	or (hl)			; $75e0
	ld a,e			; $75e1
	inc b			; $75e2
	nop			; $75e3
	ld b,e			; $75e4
	inc bc			; $75e5
	inc (hl)		; $75e6
	add b			; $75e7
	inc d			; $75e8
	sbc b			; $75e9
	ld d,h			; $75ea
	nop			; $75eb
	ldd (hl),a		; $75ec
	sub d			; $75ed
	ld d,h			; $75ee
	add b			; $75ef
	dec d			; $75f0
	sbc c			; $75f1
	ld d,h			; $75f2
	nop			; $75f3
	inc de			; $75f4
	ld a,b			; $75f5
	ld d,h			; $75f6
	add b			; $75f7
	ld d,d			; $75f8
	adc d			; $75f9
	ld d,h			; $75fa
	nop			; $75fb
	ld (de),a		; $75fc
	ld b,(hl)		; $75fd
	ld b,h			; $75fe
	nop			; $75ff
	ld d,h			; $7600
	ld ($0018),sp		; $7601
	ld de,$3404		; $7604
	add b			; $7607
	inc d			; $7608
	jr c,_label_04_351	; $7609
	nop			; $760b
	inc sp			; $760c
	ld b,d			; $760d
	inc (hl)		; $760e
	add b			; $760f
	dec (hl)		; $7610
	ld b,e			; $7611
	inc (hl)		; $7612
	nop			; $7613
	jr _label_04_352		; $7614
	ld b,h			; $7616
	add b			; $7617
	ld b,(hl)		; $7618
	ld d,l			; $7619
	ld b,h			; $761a
	nop			; $761b
	daa			; $761c
	ld b,b			; $761d
	ld b,h			; $761e
	add b			; $761f
	inc (hl)		; $7620
	ld a,$34		; $7621
	nop			; $7623
	inc h			; $7624
	ld d,$34		; $7625
	add b			; $7627
	ld h,$17		; $7628
	inc (hl)		; $762a
	nop			; $762b
	ld h,d			; $762c
	adc (hl)		; $762d
	ld d,h			; $762e
	nop			; $762f
	inc sp			; $7630
	add hl,hl		; $7631
	inc (hl)		; $7632
	add b			; $7633
	dec h			; $7634
	ldi a,(hl)		; $7635
	inc (hl)		; $7636
	nop			; $7637
	ld b,a			; $7638
	daa			; $7639
	inc (hl)		; $763a
	add b			; $763b
	daa			; $763c
	jr z,_label_04_353	; $763d
_label_04_351:
	nop			; $763f
	ld (de),a		; $7640
	adc l			; $7641
	ld d,h			; $7642
	nop			; $7643
	inc h			; $7644
	ld b,$34		; $7645
	add b			; $7647
	ld d,$07		; $7648
	inc (hl)		; $764a
	nop			; $764b
	ld d,a			; $764c
	ld bc,$8049		; $764d
	ld d,h			; $7650
	nop			; $7651
	ld b,h			; $7652
	nop			; $7653
	ld d,a			; $7654
	ld d,d			; $7655
	ld e,c			; $7656
	nop			; $7657
	inc h			; $7658
	inc bc			; $7659
	ld b,h			; $765a
	add b			; $765b
	jr _label_04_352		; $765c
	ld b,d			; $765e
	nop			; $765f
	ld (de),a		; $7660
	dec c			; $7661
	ld b,d			; $7662
	nop			; $7663
	ld b,e			; $7664
	ld e,h			; $7665
	ld d,h			; $7666
	add b			; $7667
	ld c,b			; $7668
	ld e,l			; $7669
_label_04_352:
	ld d,h			; $766a
	nop			; $766b
	ld hl,$443b		; $766c
	add b			; $766f
	dec h			; $7670
	inc b			; $7671
	ld b,h			; $7672
	nop			; $7673
	dec d			; $7674
	ld d,l			; $7675
	ld d,h			; $7676
	add b			; $7677
_label_04_353:
	rlca			; $7678
	ld e,d			; $7679
	ld d,h			; $767a
	nop			; $767b
	inc de			; $767c
	ld (hl),c		; $767d
	ld d,h			; $767e
	add b			; $767f
	ld d,$72		; $7680
	ld d,h			; $7682
	nop			; $7683
	dec d			; $7684
	ld h,l			; $7685
	ld d,h			; $7686
	add b			; $7687
	ld d,l			; $7688
	ld h,(hl)		; $7689
	ld d,h			; $768a
	nop			; $768b
	ld b,$7d		; $768c
	ld d,h			; $768e
	nop			; $768f
	ld ($547e),sp		; $7690
	nop			; $7693
	ldi (hl),a		; $7694
	ld (hl),e		; $7695
	ld d,h			; $7696
	add b			; $7697
	ld d,a			; $7698
	add c			; $7699
	ld d,h			; $769a
	nop			; $769b
	nop			; $769c
	ld bc,$0054		; $769d
	add hl,bc		; $76a0
	ld c,b			; $76a1
	inc (hl)		; $76a2
	ld b,b			; $76a3
	jr z,_label_04_355	; $76a4
	ld (hl),a		; $76a6
	nop			; $76a7
	ld ($549d),sp		; $76a8
	nop			; $76ab
	ld a,(bc)		; $76ac
	sbc (hl)		; $76ad
	ld d,h			; $76ae
	nop			; $76af
	ldi a,(hl)		; $76b0
	sbc a			; $76b1
	ld d,h			; $76b2
	nop			; $76b3
	dec b			; $76b4
	ld a,(de)		; $76b5
	ld ($5700),sp		; $76b6
	dec de			; $76b9
	ld ($5300),sp		; $76ba
	inc e			; $76bd
	ld ($4a00),sp		; $76be
	dec e			; $76c1
	ld ($1300),sp		; $76c2
	ld e,$08		; $76c5
	nop			; $76c7
	jr nz,_label_04_356	; $76c8
	jr c,_label_04_354	; $76ca
_label_04_354:
	ld (de),a		; $76cc
	ld (hl),h		; $76cd
	ld d,h			; $76ce
	ld b,b			; $76cf
	dec (hl)		; $76d0
	dec sp			; $76d1
	ld (hl),a		; $76d2
	ld b,b			; $76d3
	ld (hl),d		; $76d4
	daa			; $76d5
	ld (hl),a		; $76d6
	nop			; $76d7
	ldi (hl),a		; $76d8
_label_04_355:
	inc de			; $76d9
	inc (hl)		; $76da
	nop			; $76db
	inc h			; $76dc
	add hl,de		; $76dd
	inc (hl)		; $76de
	nop			; $76df
	inc hl			; $76e0
	ld a,(de)		; $76e1
	inc (hl)		; $76e2
	nop			; $76e3
	inc sp			; $76e4
	dec de			; $76e5
	inc (hl)		; $76e6
	nop			; $76e7
	ld c,c			; $76e8
	ldi (hl),a		; $76e9
	inc (hl)		; $76ea
	nop			; $76eb
	ld b,l			; $76ec
	inc h			; $76ed
	inc (hl)		; $76ee
	nop			; $76ef
	ld b,h			; $76f0
	dec h			; $76f1
	inc (hl)		; $76f2
	nop			; $76f3
	ld h,$26		; $76f4
	inc (hl)		; $76f6
	nop			; $76f7
	ld e,d			; $76f8
_label_04_356:
	ld sp,$0034		; $76f9
	ld d,c			; $76fc
	ldd a,(hl)		; $76fd
	inc (hl)		; $76fe
	nop			; $76ff
	ld d,d			; $7700
	dec sp			; $7701
	inc (hl)		; $7702
	nop			; $7703
	ld d,h			; $7704
	ld b,$74		; $7705
	nop			; $7707
	inc bc			; $7708
	ld c,d			; $7709
	ld b,h			; $770a
	nop			; $770b
	inc b			; $770c
	ld c,e			; $770d
	ld b,h			; $770e
	nop			; $770f
	ld de,$444c		; $7710
	ld b,b			; $7713
	ld e,b			; $7714
	rra			; $7715
	ld (hl),a		; $7716
	nop			; $7717
	ld (hl),h		; $7718
	add d			; $7719
	ld d,h			; $771a
	add b			; $771b
	or (hl)			; $771c
	ld a,e			; $771d
	inc b			; $771e
	nop			; $771f
	dec h			; $7720
	ld c,l			; $7721
	ld b,h			; $7722
	add b			; $7723
	ld d,d			; $7724
	ld c,(hl)		; $7725
	ld b,h			; $7726
	nop			; $7727
	inc h			; $7728
	inc (hl)		; $7729
	jr c,_label_04_357	; $772a
_label_04_357:
	ldd (hl),a		; $772c
	dec bc			; $772d
	inc (hl)		; $772e
	add b			; $772f
	ld d,e			; $7730
	ld ($0034),sp		; $7731
	ld b,e			; $7734
	sbc h			; $7735
	ld d,h			; $7736
	add b			; $7737
	ld d,l			; $7738
	rlca			; $7739
	ld (hl),h		; $773a
	nop			; $773b
	ld b,e			; $773c
	ld e,b			; $773d
	ld b,h			; $773e
	add b			; $773f
	ld b,(hl)		; $7740
	ld e,c			; $7741
	ld b,h			; $7742
	inc b			; $7743
	dec bc			; $7744
	add hl,de		; $7745
	inc bc			; $7746
	ld ($190b),sp		; $7747
	inc bc			; $774a
	inc b			; $774b
	inc c			; $774c
	add hl,de		; $774d
	inc bc			; $774e
	ld ($190c),sp		; $774f
	inc bc			; $7752
	inc b			; $7753
	ld a,e			; $7754
	add hl,de		; $7755
	inc bc			; $7756
	ld (setInstrumentsDisabledCounterAndScrollMode),sp		; $7757
	inc bc			; $775a
	inc b			; $775b
	dec hl			; $775c
	add hl,de		; $775d
	inc bc			; $775e
	ld ($192b),sp		; $775f
	inc bc			; $7762
	inc b			; $7763
	inc l			; $7764
	add hl,de		; $7765
	inc bc			; $7766
	ld ($192c),sp		; $7767
	inc bc			; $776a
	inc b			; $776b
	dec l			; $776c
	add hl,de		; $776d
	inc bc			; $776e
	ld ($192d),sp		; $776f
	inc bc			; $7772
	inc b			; $7773
	ld e,e			; $7774
	add hl,de		; $7775
	inc bc			; $7776
	ld ($195b),sp		; $7777
	inc bc			; $777a
	inc b			; $777b
	ld e,h			; $777c
	add hl,de		; $777d
	inc bc			; $777e
	ld ($195c),sp		; $777f
	inc bc			; $7782
	inc b			; $7783
	ld e,l			; $7784
	add hl,de		; $7785
	inc bc			; $7786
	ld ($195d),sp		; $7787
	inc bc			; $778a
	inc b			; $778b
	ld e,(hl)		; $778c
	add hl,de		; $778d
	inc bc			; $778e
	ld ($195e),sp		; $778f
	inc bc			; $7792
	nop			; $7793
	ld a,e			; $7794
	ld b,c			; $7795
	ld b,h			; $7796
	nop			; $7797
	dec hl			; $7798
	ld b,c			; $7799
	ld b,h			; $779a
	nop			; $779b
	inc l			; $779c
	ld b,c			; $779d
	ld b,h			; $779e
	nop			; $779f
	dec l			; $77a0
	ld b,c			; $77a1
	ld b,h			; $77a2
	nop			; $77a3
	ld e,e			; $77a4
	ld b,c			; $77a5
	ld b,h			; $77a6
	nop			; $77a7
	ld e,h			; $77a8
	ld b,c			; $77a9
	ld b,h			; $77aa
	nop			; $77ab
	ld e,l			; $77ac
	ld b,c			; $77ad
	ld b,h			; $77ae
	ld b,b			; $77af
	ld e,(hl)		; $77b0
	rst $20			; $77b1
	ld (hl),a		; $77b2
	ld b,b			; $77b3
	ld l,e			; $77b4
	rst $28			; $77b5
	ld (hl),a		; $77b6
	ld b,b			; $77b7
	dec de			; $77b8
	rst $28			; $77b9
	ld (hl),a		; $77ba
	ld b,b			; $77bb
	inc e			; $77bc
	rst $28			; $77bd
	ld (hl),a		; $77be
	ld b,b			; $77bf
	dec e			; $77c0
	rst $28			; $77c1
	ld (hl),a		; $77c2
	ld b,b			; $77c3
	ld c,e			; $77c4
	rst $28			; $77c5
	ld (hl),a		; $77c6
	ld b,b			; $77c7
	ld c,h			; $77c8
	rst $28			; $77c9
	ld (hl),a		; $77ca
	ld b,b			; $77cb
	ld c,l			; $77cc
	rst $28			; $77cd
	ld (hl),a		; $77ce
	ld b,b			; $77cf
	ld c,(hl)		; $77d0
	rst $28			; $77d1
	ld (hl),a		; $77d2
	nop			; $77d3
	dec sp			; $77d4
	ld c,c			; $77d5
	ld b,h			; $77d6
	nop			; $77d7
	inc a			; $77d8
	ld c,c			; $77d9
	ld b,h			; $77da
	nop			; $77db
	dec a			; $77dc
	ld c,c			; $77dd
	ld b,h			; $77de
	nop			; $77df
	ld a,$49		; $77e0
	ld b,h			; $77e2
	add b			; $77e3
	or (hl)			; $77e4
	ld a,e			; $77e5
	inc b			; $77e6
	nop			; $77e7
	ld h,$41		; $77e8
	ld b,h			; $77ea
	add b			; $77eb
	ld h,a			; $77ec
	ld c,b			; $77ed
	ld d,h			; $77ee
	nop			; $77ef
	ld b,$45		; $77f0
	ld b,h			; $77f2
	add b			; $77f3
	ld d,(hl)		; $77f4
	ld b,e			; $77f5
	ld b,h			; $77f6
	inc b			; $77f7
	add b			; $77f8
	dec bc			; $77f9
	inc bc			; $77fa
	inc b			; $77fb
	add c			; $77fc
	inc c			; $77fd
	inc bc			; $77fe
	inc b			; $77ff
	add d			; $7800
	dec c			; $7801
	inc bc			; $7802
	inc b			; $7803
	add e			; $7804
	ld de,$0403		; $7805
	add h			; $7808
	ld c,$03		; $7809
	inc b			; $780b
	add l			; $780c
	stop			; $780d
	inc bc			; $780e
	inc b			; $780f
	adc b			; $7810
	ld b,l			; $7811
	inc bc			; $7812
	inc b			; $7813
	adc c			; $7814
	ld b,(hl)		; $7815
	inc bc			; $7816
	inc b			; $7817
	adc d			; $7818
	add hl,de		; $7819
	inc de			; $781a
	nop			; $781b
	adc d			; $781c
	ld a,(bc)		; $781d
	ldd (hl),a		; $781e
	ld b,b			; $781f
	adc e			; $7820
	rst $30			; $7821
	ld a,b			; $7822
	inc b			; $7823
	adc a			; $7824
	rla			; $7825
	inc de			; $7826
	inc b			; $7827
	sub c			; $7828
	ld (de),a		; $7829
	inc bc			; $782a
	inc b			; $782b
	sub d			; $782c
	inc de			; $782d
	inc bc			; $782e
	inc b			; $782f
	sub e			; $7830
	inc d			; $7831
	inc bc			; $7832
	inc b			; $7833
	sub h			; $7834
	dec d			; $7835
	inc bc			; $7836
	nop			; $7837
	sub l			; $7838
	dec c			; $7839
	ld (de),a		; $783a
	inc b			; $783b
	sub (hl)		; $783c
	ld c,$13		; $783d
	inc b			; $783f
	sub a			; $7840
	rrca			; $7841
	inc de			; $7842
	nop			; $7843
	sbc b			; $7844
	scf			; $7845
	ld b,d			; $7846
	inc b			; $7847
	sbc c			; $7848
	ld c,b			; $7849
	inc bc			; $784a
	nop			; $784b
	sbc d			; $784c
	ld c,e			; $784d
	ld (bc),a		; $784e
	nop			; $784f
	sbc e			; $7850
	ld c,h			; $7851
	ld (bc),a		; $7852
	inc b			; $7853
	sbc h			; $7854
	ld c,l			; $7855
	inc bc			; $7856
	inc b			; $7857
	sbc l			; $7858
	ld c,(hl)		; $7859
	inc bc			; $785a
	ld ($159e),sp		; $785b
	inc de			; $785e
	inc b			; $785f
	sbc a			; $7860
	ld d,b			; $7861
	inc bc			; $7862
	inc b			; $7863
	and b			; $7864
	ld de,$0413		; $7865
	and c			; $7868
	stop			; $7869
	inc de			; $786a
	inc b			; $786b
	and d			; $786c
	ld (de),a		; $786d
	inc de			; $786e
	inc b			; $786f
	and e			; $7870
	dec l			; $7871
	inc bc			; $7872
	inc b			; $7873
	and h			; $7874
	ld d,$03		; $7875
	inc b			; $7877
	and l			; $7878
	rla			; $7879
	inc bc			; $787a
	inc b			; $787b
	and (hl)		; $787c
	jr $03			; $787d
	nop			; $787f
	and (hl)		; $7880
	ld l,$32		; $7881
	ld b,b			; $7883
	and a			; $7884
	rst $28			; $7885
	ld a,b			; $7886
	inc b			; $7887
	xor b			; $7888
	ldd a,(hl)		; $7889
	inc bc			; $788a
	nop			; $788b
	xor b			; $788c
	dec bc			; $788d
	jr _label_04_358		; $788e
	xor c			; $7890
	ld d,$13		; $7891
	inc b			; $7893
_label_04_358:
	xor d			; $7894
	ld d,c			; $7895
	inc bc			; $7896
	ld b,b			; $7897
	xor e			; $7898
	rst $38			; $7899
	ld a,b			; $789a
	inc b			; $789b
	xor a			; $789c
	rrca			; $789d
	inc bc			; $789e
	nop			; $789f
	or b			; $78a0
	dec l			; $78a1
	ldd (hl),a		; $78a2
	ld ($13b1),sp		; $78a3
	inc de			; $78a6
	inc b			; $78a7
	or d			; $78a8
	inc d			; $78a9
	inc de			; $78aa
	inc b			; $78ab
	or e			; $78ac
	jr nz,$03		; $78ad
	inc b			; $78af
	or h			; $78b0
	ld hl,$0403		; $78b1
	or l			; $78b4
	ldi (hl),a		; $78b5
	inc bc			; $78b6
	inc b			; $78b7
	or (hl)			; $78b8
	ld c,a			; $78b9
	inc bc			; $78ba
	nop			; $78bb
	or (hl)			; $78bc
	ld a,(bc)		; $78bd
	ld (hl),d		; $78be
	nop			; $78bf
	or a			; $78c0
	ld b,a			; $78c1
	ld (bc),a		; $78c2
	inc b			; $78c3
	cp b			; $78c4
	ld d,e			; $78c5
	inc bc			; $78c6
	ld ($54b8),sp		; $78c7
	inc bc			; $78ca
	nop			; $78cb
	cp b			; $78cc
	ld b,l			; $78cd
	ldd (hl),a		; $78ce
	nop			; $78cf
	cp c			; $78d0
	ld b,h			; $78d1
	ldd (hl),a		; $78d2
	nop			; $78d3
	cp d			; $78d4
	ld e,b			; $78d5
	ld (bc),a		; $78d6
	ld bc,$49ac		; $78d7
	inc sp			; $78da
	ld (bc),a		; $78db
	xor h			; $78dc
	ld c,c			; $78dd
	inc sp			; $78de
	inc b			; $78df
	cp l			; $78e0
	dec (hl)		; $78e1
	inc sp			; $78e2
	ld ($35bd),sp		; $78e3
	inc sp			; $78e6
	inc b			; $78e7
	cp h			; $78e8
	ldi (hl),a		; $78e9
	inc de			; $78ea
	add b			; $78eb
	or (hl)			; $78ec
	ld a,e			; $78ed
	inc b			; $78ee
	nop			; $78ef
	ld de,$3239		; $78f0
	add b			; $78f3
	ld sp,$322c		; $78f4
	nop			; $78f7
	ld de,$3209		; $78f8
	add b			; $78fb
	ld h,c			; $78fc
	jr _label_04_360		; $78fd
	nop			; $78ff
	ld h,(hl)		; $7900
	ld d,d			; $7901
	inc b			; $7902
	add b			; $7903
	ld b,h			; $7904
	inc c			; $7905
	jr _label_04_359		; $7906
	inc b			; $7908
	nop			; $7909
	inc bc			; $790a
	inc b			; $790b
_label_04_359:
	inc e			; $790c
	ld bc,$0403		; $790d
	add hl,sp		; $7910
_label_04_360:
	ld (bc),a		; $7911
	inc bc			; $7912
	inc b			; $7913
	ld c,e			; $7914
	inc bc			; $7915
	inc bc			; $7916
	inc b			; $7917
	add c			; $7918
	inc b			; $7919
	inc bc			; $791a
	inc b			; $791b
	and a			; $791c
	dec b			; $791d
	inc bc			; $791e
	inc b			; $791f
	cp d			; $7920
	ld b,$03		; $7921
	nop			; $7923
	rlca			; $7924
	nop			; $7925
	ld h,d			; $7926
	nop			; $7927
	ld a,(bc)		; $7928
	ld bc,$0062		; $7929
	rra			; $792c
	ld (bc),a		; $792d
	ld h,d			; $792e
	nop			; $792f
	ldd (hl),a		; $7930
	inc bc			; $7931
	ld h,d			; $7932
	nop			; $7933
	inc sp			; $7934
	ld h,$02		; $7935
	nop			; $7937
	scf			; $7938
	daa			; $7939
	ld (bc),a		; $793a
	nop			; $793b
	ld a,$05		; $793c
	ld h,d			; $793e
	ld b,b			; $793f
	ccf			; $7940
	ld e,a			; $7941
	ld a,d			; $7942
	ld b,b			; $7943
	ld b,c			; $7944
	ld h,a			; $7945
	ld a,d			; $7946
	nop			; $7947
	ld b,e			; $7948
	add hl,de		; $7949
	ld b,d			; $794a
	nop			; $794b
	ld b,h			; $794c
	ld b,$62		; $794d
	nop			; $794f
	ld c,b			; $7950
	ld a,(de)		; $7951
	ld b,d			; $7952
	nop			; $7953
	ld c,d			; $7954
	dec de			; $7955
	ld b,d			; $7956
	nop			; $7957
	ld c,a			; $7958
	rrca			; $7959
	ld b,d			; $795a
	nop			; $795b
	ld d,d			; $795c
	ld de,$0042		; $795d
	ld d,e			; $7960
	inc de			; $7961
	ld b,d			; $7962
	nop			; $7963
	ld d,a			; $7964
	dec d			; $7965
	ld b,d			; $7966
	nop			; $7967
	ld e,c			; $7968
	ld d,$42		; $7969
	nop			; $796b
	ld (hl),a		; $796c
	inc e			; $796d
	ld b,d			; $796e
	nop			; $796f
	ld h,l			; $7970
	dec e			; $7971
	ld b,d			; $7972
	nop			; $7973
	ld h,c			; $7974
	ld e,$42		; $7975
	nop			; $7977
	ld l,c			; $7978
	rra			; $7979
	ld b,d			; $797a
	nop			; $797b
	ld a,c			; $797c
	jr nz,_label_04_361	; $797d
	nop			; $797f
	ld h,(hl)		; $7980
	ld hl,$0042		; $7981
	ld l,b			; $7984
	ld ($0062),sp		; $7985
	ld l,l			; $7988
	add hl,bc		; $7989
	ld h,d			; $798a
	nop			; $798b
	adc (hl)		; $798c
	dec bc			; $798d
	ld h,d			; $798e
	ld b,b			; $798f
	sub b			; $7990
	ld l,a			; $7991
	ld a,d			; $7992
	nop			; $7993
	sub e			; $7994
	ld a,(bc)		; $7995
	ld h,d			; $7996
	nop			; $7997
	and c			; $7998
	inc c			; $7999
	ld h,d			; $799a
	nop			; $799b
	sbc e			; $799c
	rrca			; $799d
	ld h,d			; $799e
	nop			; $799f
	xor d			; $79a0
	ld l,$42		; $79a1
	nop			; $79a3
	xor h			; $79a4
	cpl			; $79a5
	ld b,d			; $79a6
	nop			; $79a7
	xor l			; $79a8
	jr nc,$42		; $79a9
	nop			; $79ab
	or h			; $79ac
	ld sp,$0042		; $79ad
	cp h			; $79b0
	ldi a,(hl)		; $79b1
	ld b,d			; $79b2
	nop			; $79b3
	cp (hl)			; $79b4
	dec hl			; $79b5
	ld b,d			; $79b6
	nop			; $79b7
	cp a			; $79b8
	inc l			; $79b9
	ld b,d			; $79ba
	nop			; $79bb
	call nz,$422d		; $79bc
	nop			; $79bf
	push bc			; $79c0
_label_04_361:
	inc (hl)		; $79c1
	ld b,d			; $79c2
	nop			; $79c3
	call $4236		; $79c4
	nop			; $79c7
	adc $32			; $79c8
	ld b,d			; $79ca
	nop			; $79cb
.DB $d3				; $79cc
	jr c,$42		; $79cd
	nop			; $79cf
	call nc,$4233		; $79d0
	nop			; $79d3
	push de			; $79d4
	inc e			; $79d5
	ldd (hl),a		; $79d6
	nop			; $79d7
	sub $35			; $79d8
	ld b,d			; $79da
	inc b			; $79db
	ld ($ff00+$0c),a	; $79dc
	inc bc			; $79de
	inc b			; $79df
	pop hl			; $79e0
	ld e,d			; $79e1
	inc bc			; $79e2
	ld b,b			; $79e3
.DB $e3				; $79e4
	ld (hl),a		; $79e5
	ld a,d			; $79e6
	ld b,b			; $79e7
	push hl			; $79e8
	ld a,a			; $79e9
	ld a,d			; $79ea
	nop			; $79eb
	and $3d			; $79ec
	ld b,d			; $79ee
	nop			; $79ef
	rst $20			; $79f0
	inc hl			; $79f1
	ld (bc),a		; $79f2
	ld ($0ae8),sp		; $79f3
	inc hl			; $79f6
	nop			; $79f7
	add sp,$44		; $79f8
	ld b,d			; $79fa
	ld ($14e9),sp		; $79fb
	inc hl			; $79fe
	nop			; $79ff
	jp hl			; $7a00
	ld b,d			; $7a01
	ld b,d			; $7a02
	inc b			; $7a03
	ld ($231e),a		; $7a04
	inc b			; $7a07
.DB $eb				; $7a08
	ld h,a			; $7a09
	inc bc			; $7a0a
	inc b			; $7a0b
.DB $ed				; $7a0c
	ld e,e			; $7a0d
	inc bc			; $7a0e
	inc b			; $7a0f
	xor $28			; $7a10
	inc hl			; $7a12
	inc b			; $7a13
	rst $28			; $7a14
	ld bc,$0413		; $7a15
	ld a,($ff00+$02)	; $7a18
	inc de			; $7a1a
	inc b			; $7a1b
	pop af			; $7a1c
	inc bc			; $7a1d
	inc de			; $7a1e
	nop			; $7a1f
	ld a,($ff00+c)		; $7a20
	inc b			; $7a21
	ld (de),a		; $7a22
	inc b			; $7a23
	ld a,($ff00+c)		; $7a24
	dec b			; $7a25
	inc de			; $7a26
	inc b			; $7a27
	di			; $7a28
	ld e,l			; $7a29
	inc bc			; $7a2a
	nop			; $7a2b
	di			; $7a2c
	ld e,h			; $7a2d
	inc b			; $7a2e
	nop			; $7a2f
.DB $f4				; $7a30
	ld e,(hl)		; $7a31
	inc b			; $7a32
	nop			; $7a33
	push af			; $7a34
	ld e,a			; $7a35
	inc b			; $7a36
	nop			; $7a37
	or $60			; $7a38
	inc b			; $7a3a
	inc b			; $7a3b
	or $61			; $7a3c
	inc bc			; $7a3e
	nop			; $7a3f
	rst $30			; $7a40
	ld h,d			; $7a41
	inc b			; $7a42
	nop			; $7a43
	ld hl,sp+$63		; $7a44
	inc b			; $7a46
	inc b			; $7a47
	ld sp,hl		; $7a48
	dec de			; $7a49
	inc de			; $7a4a
	ld ($1cf9),sp		; $7a4b
	inc de			; $7a4e
	inc b			; $7a4f
	ld a,($0364)		; $7a50
	inc b			; $7a53
	ei			; $7a54
	ld h,l			; $7a55
	inc bc			; $7a56
	inc b			; $7a57
.DB $fc				; $7a58
	ld h,(hl)		; $7a59
	inc bc			; $7a5a
	add b			; $7a5b
	or (hl)			; $7a5c
	ld a,e			; $7a5d
	inc b			; $7a5e
	nop			; $7a5f
	ld d,d			; $7a60
	rla			; $7a61
	ld b,d			; $7a62
	add b			; $7a63
	ld e,l			; $7a64
	rlca			; $7a65
	ld h,d			; $7a66
	nop			; $7a67
	dec e			; $7a68
	jr _label_04_362		; $7a69
	add b			; $7a6b
	ld hl,$6204		; $7a6c
	nop			; $7a6f
	sub a			; $7a70
	ld c,$62		; $7a71
	add b			; $7a73
	sbc l			; $7a74
	dec c			; $7a75
	ld h,d			; $7a76
	nop			; $7a77
	ld (de),a		; $7a78
	inc h			; $7a79
	ld (bc),a		; $7a7a
	add b			; $7a7b
	ld a,h			; $7a7c
	ld a,$42		; $7a7d
	nop			; $7a7f
	ld a,e			; $7a80
	ccf			; $7a81
	ld b,d			; $7a82
	add b			; $7a83
	add (hl)		; $7a84
	inc a			; $7a85
	ld b,d			; $7a86
	inc b			; $7a87
	ld e,e			; $7a88
	rlca			; $7a89
	inc bc			; $7a8a
	inc b			; $7a8b
	add a			; $7a8c
	nop			; $7a8d
	inc de			; $7a8e
	inc b			; $7a8f
	sub a			; $7a90
	ld ($0403),sp		; $7a91
	sbc l			; $7a94
	add hl,bc		; $7a95
	inc bc			; $7a96
	nop			; $7a97
	scf			; $7a98
	rla			; $7a99
	ld d,d			; $7a9a
	nop			; $7a9b
	add hl,sp		; $7a9c
	jr _label_04_363		; $7a9d
	nop			; $7a9f
	inc a			; $7aa0
	dec de			; $7aa1
	ld d,d			; $7aa2
	ld b,b			; $7aa3
	ld b,e			; $7aa4
.DB $db				; $7aa5
	ld a,h			; $7aa6
	nop			; $7aa7
	ld b,(hl)		; $7aa8
	ldi a,(hl)		; $7aa9
	ld d,d			; $7aaa
	nop			; $7aab
	ld b,a			; $7aac
_label_04_362:
	dec b			; $7aad
	ld d,d			; $7aae
	nop			; $7aaf
	ld c,d			; $7ab0
	ld b,$52		; $7ab1
	ld b,b			; $7ab3
	ld c,e			; $7ab4
	ld c,e			; $7ab5
	ld a,l			; $7ab6
	nop			; $7ab7
	ld c,h			; $7ab8
	rlca			; $7ab9
	ld d,d			; $7aba
	ld b,b			; $7abb
	ld d,c			; $7abc
	inc de			; $7abd
	ld a,l			; $7abe
	nop			; $7abf
	ld d,e			; $7ac0
	ld d,$52		; $7ac1
	ld b,b			; $7ac3
	ld d,a			; $7ac4
	ld d,e			; $7ac5
	ld a,l			; $7ac6
	nop			; $7ac7
	ld e,(hl)		; $7ac8
	add hl,sp		; $7ac9
	ld d,d			; $7aca
	nop			; $7acb
	ld h,e			; $7acc
	ld bc,addDoubleIndexToDe		; $7acd
	ld l,b			; $7ad0
	dec sp			; $7ad1
	ld d,d			; $7ad2
	nop			; $7ad3
	ld l,c			; $7ad4
	nop			; $7ad5
	ld (hl),d		; $7ad6
	nop			; $7ad7
	ld l,d			; $7ad8
	dec a			; $7ad9
	ld d,d			; $7ada
	nop			; $7adb
	ld l,e			; $7adc
	ld a,$52		; $7add
	nop			; $7adf
	ld l,h			; $7ae0
	ccf			; $7ae1
	ld d,d			; $7ae2
	nop			; $7ae3
	ld l,(hl)		; $7ae4
	ld b,b			; $7ae5
	ld d,d			; $7ae6
	nop			; $7ae7
	ld (hl),c		; $7ae8
	ld b,c			; $7ae9
	ld d,d			; $7aea
	nop			; $7aeb
	ld (hl),e		; $7aec
	ld b,d			; $7aed
	ld d,d			; $7aee
	ld b,b			; $7aef
	ld (hl),h		; $7af0
_label_04_363:
	ld e,e			; $7af1
	ld a,l			; $7af2
	nop			; $7af3
	ld (hl),a		; $7af4
	dec l			; $7af5
	ld d,d			; $7af6
	nop			; $7af7
	ld a,b			; $7af8
	ld (bc),a		; $7af9
	ld (hl),d		; $7afa
	nop			; $7afb
	add h			; $7afc
	cpl			; $7afd
	ld d,d			; $7afe
	nop			; $7aff
	add (hl)		; $7b00
	inc bc			; $7b01
	ld (hl),d		; $7b02
	nop			; $7b03
	adc b			; $7b04
	ld sp,$0052		; $7b05
	adc c			; $7b08
	ldd (hl),a		; $7b09
	ld d,d			; $7b0a
	nop			; $7b0b
	adc d			; $7b0c
	inc sp			; $7b0d
	ld d,d			; $7b0e
	nop			; $7b0f
	adc e			; $7b10
	inc (hl)		; $7b11
	ld d,d			; $7b12
	nop			; $7b13
	adc h			; $7b14
	dec (hl)		; $7b15
	ld d,d			; $7b16
	nop			; $7b17
	adc l			; $7b18
	ld (hl),$52		; $7b19
	ld b,b			; $7b1b
	adc (hl)		; $7b1c
	ld h,e			; $7b1d
	ld a,l			; $7b1e
	nop			; $7b1f
	ld h,a			; $7b20
	ld b,(hl)		; $7b21
	ld d,d			; $7b22
	nop			; $7b23
	add e			; $7b24
	ld b,l			; $7b25
	ld d,d			; $7b26
	nop			; $7b27
	sbc d			; $7b28
	ld c,c			; $7b29
	ld d,d			; $7b2a
	nop			; $7b2b
	sbc l			; $7b2c
	ldd (hl),a		; $7b2d
	ldi (hl),a		; $7b2e
	nop			; $7b2f
	sbc (hl)		; $7b30
	ld b,a			; $7b31
	ld d,d			; $7b32
	inc b			; $7b33
	jr nc,_label_04_364	; $7b34
_label_04_364:
	inc bc			; $7b36
	nop			; $7b37
	ld sp,$524b		; $7b38
	nop			; $7b3b
	inc sp			; $7b3c
	ld c,d			; $7b3d
	ld d,d			; $7b3e
	nop			; $7b3f
	cpl			; $7b40
	ld c,l			; $7b41
	ld d,d			; $7b42
	nop			; $7b43
	add hl,hl		; $7b44
	ld c,h			; $7b45
	ld d,d			; $7b46
	nop			; $7b47
	jr z,_label_04_366	; $7b48
	ld d,d			; $7b4a
	nop			; $7b4b
	jr nz,_label_04_367	; $7b4c
	ld d,d			; $7b4e
	nop			; $7b4f
	inc h			; $7b50
	ld d,c			; $7b51
	ld d,d			; $7b52
	nop			; $7b53
	ld h,$50		; $7b54
	ld d,d			; $7b56
	nop			; $7b57
	daa			; $7b58
	ld d,h			; $7b59
	ld d,d			; $7b5a
	nop			; $7b5b
	inc (hl)		; $7b5c
	ld d,e			; $7b5d
	ld d,d			; $7b5e
	inc b			; $7b5f
	or b			; $7b60
	dec hl			; $7b61
	inc bc			; $7b62
	ld b,b			; $7b63
	or b			; $7b64
	and e			; $7b65
	ld a,h			; $7b66
	ld b,b			; $7b67
	or c			; $7b68
	xor e			; $7b69
	ld a,h			; $7b6a
	ld ($2cb2),sp		; $7b6b
	inc bc			; $7b6e
	nop			; $7b6f
	or d			; $7b70
	ld d,a			; $7b71
	ld d,d			; $7b72
	inc b			; $7b73
	or e			; $7b74
	jr z,_label_04_365	; $7b75
	ld ($29b3),sp		; $7b77
_label_04_365:
	inc bc			; $7b7a
	inc b			; $7b7b
	or h			; $7b7c
	dec h			; $7b7d
	inc bc			; $7b7e
	inc b			; $7b7f
	or l			; $7b80
	ld l,$03		; $7b81
	inc b			; $7b83
	or (hl)			; $7b84
	cpl			; $7b85
	inc bc			; $7b86
	ld b,b			; $7b87
	or a			; $7b88
	ld l,e			; $7b89
	ld a,l			; $7b8a
	nop			; $7b8b
	cp b			; $7b8c
	ld h,c			; $7b8d
	ld d,d			; $7b8e
	ld ($31b9),sp		; $7b8f
	inc bc			; $7b92
	nop			; $7b93
	cp d			; $7b94
	ldd (hl),a		; $7b95
	ld (bc),a		; $7b96
	inc b			; $7b97
	cp d			; $7b98
_label_04_366:
	inc sp			; $7b99
	inc bc			; $7b9a
	inc b			; $7b9b
_label_04_367:
	cp e			; $7b9c
	inc (hl)		; $7b9d
	inc bc			; $7b9e
	ld b,b			; $7b9f
	cp (hl)			; $7ba0
	ld (hl),e		; $7ba1
	ld a,l			; $7ba2
	ld b,b			; $7ba3
	cp a			; $7ba4
	ld a,e			; $7ba5
	ld a,l			; $7ba6
	nop			; $7ba7
	ret nz			; $7ba8
	ld l,e			; $7ba9
	ld d,d			; $7baa
	inc b			; $7bab
	pop bc			; $7bac
	ld (hl),$02		; $7bad
	nop			; $7baf
	pop bc			; $7bb0
	ld (hl),b		; $7bb1
	ld d,d			; $7bb2
	ld b,b			; $7bb3
	jp nz,$7d83		; $7bb4
	nop			; $7bb7
	jp decHlRef16WithCap		; $7bb8
	nop			; $7bbb
	call nz,$0238		; $7bbc
	inc b			; $7bbf
	add $1a			; $7bc0
	inc de			; $7bc2
	inc b			; $7bc3
	rst_jumpTable			; $7bc4
	dec sp			; $7bc5
	inc bc			; $7bc6
	ld ($3cc8),sp		; $7bc7
	inc bc			; $7bca
	inc b			; $7bcb
	ret			; $7bcc
	dec a			; $7bcd
	inc bc			; $7bce
	inc b			; $7bcf
	jp z,$033e		; $7bd0
	nop			; $7bd3
	ret z			; $7bd4
	ld a,c			; $7bd5
	ld d,d			; $7bd6
	ld b,b			; $7bd7
	ret			; $7bd8
	or e			; $7bd9
	ld a,h			; $7bda
	nop			; $7bdb
	jp z,$527a		; $7bdc
	inc b			; $7bdf
	bit 0,b			; $7be0
	inc bc			; $7be2
	ld ($41cb),sp		; $7be3
	inc bc			; $7be6
	nop			; $7be7
	srl a			; $7be8
	ld (bc),a		; $7bea
	inc b			; $7beb
	call z,$0344		; $7bec
	nop			; $7bef
	call z,$0243		; $7bf0
	inc b			; $7bf3
	push bc			; $7bf4
	ld b,d			; $7bf5
	inc bc			; $7bf6
	ld b,b			; $7bf7
	rst $8			; $7bf8
	sbc e			; $7bf9
	ld a,h			; $7bfa
	nop			; $7bfb
	call nc,$0255		; $7bfc
	nop			; $7bff
	ret nc			; $7c00
	adc b			; $7c01
	ld d,d			; $7c02
	nop			; $7c03
	pop de			; $7c04
	adc b			; $7c05
	ld d,d			; $7c06
	nop			; $7c07
	jp nc,$5288		; $7c08
	nop			; $7c0b
.DB $d3				; $7c0c
	add l			; $7c0d
	ld d,d			; $7c0e
	inc b			; $7c0f
.DB $d3				; $7c10
	ld d,a			; $7c11
	inc bc			; $7c12
	nop			; $7c13
	ld bc,$0269		; $7c14
	nop			; $7c17
	ld (bc),a		; $7c18
	ld l,d			; $7c19
	ld (bc),a		; $7c1a
	nop			; $7c1b
	inc bc			; $7c1c
	ld l,e			; $7c1d
	ld (bc),a		; $7c1e
	nop			; $7c1f
	inc b			; $7c20
	ld l,h			; $7c21
	ld (bc),a		; $7c22
	nop			; $7c23
	dec b			; $7c24
	ld l,l			; $7c25
	ld (bc),a		; $7c26
	nop			; $7c27
	ld b,$6e		; $7c28
	ld (bc),a		; $7c2a
	nop			; $7c2b
	rlca			; $7c2c
	ld l,a			; $7c2d
	ld (bc),a		; $7c2e
	nop			; $7c2f
	ld ($0270),sp		; $7c30
	inc b			; $7c33
	add hl,bc		; $7c34
	ld (hl),c		; $7c35
	inc bc			; $7c36
	nop			; $7c37
	ld a,(bc)		; $7c38
	ld (hl),d		; $7c39
	ld (bc),a		; $7c3a
	inc b			; $7c3b
	dec bc			; $7c3c
	ld (hl),e		; $7c3d
	inc bc			; $7c3e
	nop			; $7c3f
	inc c			; $7c40
	ld (hl),h		; $7c41
	ld (bc),a		; $7c42
	nop			; $7c43
	ld c,$76		; $7c44
	ld (bc),a		; $7c46
	nop			; $7c47
	rrca			; $7c48
	ld (hl),a		; $7c49
	ld (bc),a		; $7c4a
	nop			; $7c4b
	stop			; $7c4c
	ld a,b			; $7c4d
	ld (bc),a		; $7c4e
	nop			; $7c4f
	ld de,$0279		; $7c50
	inc b			; $7c53
	ld (de),a		; $7c54
	ld a,d			; $7c55
	inc bc			; $7c56
	inc b			; $7c57
	di			; $7c58
	inc hl			; $7c59
	inc de			; $7c5a
	inc b			; $7c5b
	or $24			; $7c5c
	inc de			; $7c5e
	inc b			; $7c5f
	ld sp,hl		; $7c60
	dec h			; $7c61
	inc de			; $7c62
	inc b			; $7c63
	ld a,($ff00+$26)	; $7c64
	inc de			; $7c66
	nop			; $7c67
	di			; $7c68
	and c			; $7c69
	ld d,d			; $7c6a
	ld b,b			; $7c6b
.DB $f4				; $7c6c
	jp $007c		; $7c6d
	push af			; $7c70
	and d			; $7c71
	ld d,d			; $7c72
	nop			; $7c73
	or $a5			; $7c74
	ld d,d			; $7c76
	ld b,b			; $7c77
	rst $30			; $7c78
	bit 7,h			; $7c79
	nop			; $7c7b
	ld hl,sp-$5a		; $7c7c
	ld d,d			; $7c7e
	nop			; $7c7f
	ld sp,hl		; $7c80
	xor c			; $7c81
	ld d,d			; $7c82
	ld b,b			; $7c83
	ld a,($7cd3)		; $7c84
	nop			; $7c87
	ei			; $7c88
	xor d			; $7c89
	ld d,d			; $7c8a
	nop			; $7c8b
	ldh a,(<hActiveObject)	; $7c8c
	ld d,d			; $7c8e
	ld b,b			; $7c8f
	pop af			; $7c90
	cp e			; $7c91
	ld a,h			; $7c92
	nop			; $7c93
	ld a,($ff00+c)		; $7c94
	xor (hl)		; $7c95
	ld d,d			; $7c96
	add b			; $7c97
	or (hl)			; $7c98
	ld a,e			; $7c99
	inc b			; $7c9a
	nop			; $7c9b
	sub a			; $7c9c
	ld d,(hl)		; $7c9d
	ld (bc),a		; $7c9e
	add b			; $7c9f
	ld d,$1d		; $7ca0
	ld (de),a		; $7ca2
	nop			; $7ca3
	inc hl			; $7ca4
	ld e,c			; $7ca5
	ld d,d			; $7ca6
	add b			; $7ca7
	dec a			; $7ca8
	ld e,e			; $7ca9
	ld d,d			; $7caa
	nop			; $7cab
	inc hl			; $7cac
	ld d,(hl)		; $7cad
	ld d,d			; $7cae
	add b			; $7caf
	ld a,b			; $7cb0
	ldi a,(hl)		; $7cb1
	ld (bc),a		; $7cb2
	nop			; $7cb3
	inc e			; $7cb4
	ld (hl),a		; $7cb5
	ld d,d			; $7cb6
	add b			; $7cb7
	sbc l			; $7cb8
	ld a,h			; $7cb9
	ld d,d			; $7cba
	nop			; $7cbb
	daa			; $7cbc
	xor h			; $7cbd
	ld d,d			; $7cbe
	add b			; $7cbf
	add a			; $7cc0
	xor a			; $7cc1
	ld d,d			; $7cc2
	nop			; $7cc3
	daa			; $7cc4
	and b			; $7cc5
	ld d,d			; $7cc6
	add b			; $7cc7
	add a			; $7cc8
	and e			; $7cc9
	ld d,d			; $7cca
	nop			; $7ccb
	daa			; $7ccc
	and h			; $7ccd
	ld d,d			; $7cce
	add b			; $7ccf
	add a			; $7cd0
	and a			; $7cd1
	ld d,d			; $7cd2
	nop			; $7cd3
	daa			; $7cd4
	xor b			; $7cd5
	ld d,d			; $7cd6
	add b			; $7cd7
	add a			; $7cd8
	xor e			; $7cd9
	ld d,d			; $7cda
	nop			; $7cdb
	ld de,$521c		; $7cdc
	nop			; $7cdf
	ld d,$1d		; $7ce0
	ld d,d			; $7ce2
	nop			; $7ce3
	dec de			; $7ce4
	ld e,$52		; $7ce5
	nop			; $7ce7
	ld b,c			; $7ce8
	rra			; $7ce9
	ld d,d			; $7cea
	nop			; $7ceb
	ld b,h			; $7cec
	jr nz,_label_04_368	; $7ced
	nop			; $7cef
	ld b,(hl)		; $7cf0
	ld hl,$0052		; $7cf1
	ld c,b			; $7cf4
	ldi (hl),a		; $7cf5
	ld d,d			; $7cf6
	nop			; $7cf7
	ld c,h			; $7cf8
	inc hl			; $7cf9
	ld d,d			; $7cfa
	nop			; $7cfb
	ld h,(hl)		; $7cfc
	inc h			; $7cfd
	ld d,d			; $7cfe
	nop			; $7cff
	ld l,c			; $7d00
	dec h			; $7d01
	ld d,d			; $7d02
	nop			; $7d03
	ld (hl),e		; $7d04
	ld h,$52		; $7d05
	nop			; $7d07
	ld a,e			; $7d08
	daa			; $7d09
	ld d,d			; $7d0a
	nop			; $7d0b
	sbc l			; $7d0c
	jr z,_label_04_369	; $7d0d
	add b			; $7d0f
	sub c			; $7d10
	add hl,hl		; $7d11
	ld d,d			; $7d12
	nop			; $7d13
	ld de,$5208		; $7d14
	nop			; $7d17
	ld d,$09		; $7d18
	ld d,d			; $7d1a
	nop			; $7d1b
	dec de			; $7d1c
	ld a,(bc)		; $7d1d
	ld d,d			; $7d1e
	nop			; $7d1f
	ld b,c			; $7d20
	dec bc			; $7d21
	ld d,d			; $7d22
	nop			; $7d23
	ld b,h			; $7d24
	inc c			; $7d25
	ld d,d			; $7d26
	nop			; $7d27
	ld b,(hl)		; $7d28
	dec c			; $7d29
	ld d,d			; $7d2a
	nop			; $7d2b
	ld c,b			; $7d2c
	ld c,$52		; $7d2d
	nop			; $7d2f
	ld c,h			; $7d30
	rrca			; $7d31
	ld d,d			; $7d32
	nop			; $7d33
	ld h,(hl)		; $7d34
	stop			; $7d35
	ld d,d			; $7d36
	nop			; $7d37
	ld l,c			; $7d38
	ld de,$0052		; $7d39
	ld (hl),e		; $7d3c
	ld (de),a		; $7d3d
	ld d,d			; $7d3e
	nop			; $7d3f
	ld a,e			; $7d40
_label_04_368:
	inc de			; $7d41
	ld d,d			; $7d42
	nop			; $7d43
	sbc l			; $7d44
	inc d			; $7d45
	ld d,d			; $7d46
	add b			; $7d47
	sub c			; $7d48
	dec d			; $7d49
	ld d,d			; $7d4a
	nop			; $7d4b
	add d			; $7d4c
	dec hl			; $7d4d
	ld d,d			; $7d4e
	add b			; $7d4f
	adc h			; $7d50
	inc l			; $7d51
	ld d,d			; $7d52
	nop			; $7d53
	add d			; $7d54
	add hl,de		; $7d55
	ld d,d			; $7d56
	add b			; $7d57
	adc h			; $7d58
	ld a,(de)		; $7d59
	ld d,d			; $7d5a
	nop			; $7d5b
	dec (hl)		; $7d5c
	ld b,e			; $7d5d
	ld d,d			; $7d5e
	add b			; $7d5f
	ld l,l			; $7d60
_label_04_369:
	ld b,h			; $7d61
	ld d,d			; $7d62
	nop			; $7d63
	dec (hl)		; $7d64
	scf			; $7d65
	ld d,d			; $7d66
	add b			; $7d67
	ld l,l			; $7d68
	jr c,_label_04_371	; $7d69
	nop			; $7d6b
	inc h			; $7d6c
	ld h,e			; $7d6d
	ld d,d			; $7d6e
	add b			; $7d6f
	ld (hl),h		; $7d70
	jr nc,_label_04_370	; $7d71
	nop			; $7d73
	inc (hl)		; $7d74
_label_04_370:
	ld l,d			; $7d75
	ld d,d			; $7d76
	add b			; $7d77
	ld c,b			; $7d78
	dec (hl)		; $7d79
	ld (bc),a		; $7d7a
	nop			; $7d7b
	inc (hl)		; $7d7c
	ld l,b			; $7d7d
	ld d,d			; $7d7e
	add b			; $7d7f
	ld a,d			; $7d80
	ld l,h			; $7d81
	ld d,d			; $7d82
	nop			; $7d83
	ldi (hl),a		; $7d84
	add hl,sp		; $7d85
	ld (bc),a		; $7d86
	add b			; $7d87
	dec sp			; $7d88
	ld l,(hl)		; $7d89
	ld d,d			; $7d8a
	ld bc,$0801		; $7d8b
	ld b,e			; $7d8e
	ld bc,$0909		; $7d8f
	ld b,e			; $7d92
	ld bc,$0a1d		; $7d93
	ld b,e			; $7d96
	ld (bc),a		; $7d97
	ld e,$0b		; $7d98
	ld b,e			; $7d9a
	ld bc,$123a		; $7d9b
	ld b,e			; $7d9e
	ld (bc),a		; $7d9f
	dec sp			; $7da0
	ld c,$43		; $7da1
	ld bc,$143c		; $7da3
	ld b,e			; $7da6
	ld (bc),a		; $7da7
	dec a			; $7da8
	stop			; $7da9
	ld b,e			; $7daa
	ld bc,$225c		; $7dab
	ld b,e			; $7dae
	ld (bc),a		; $7daf
	ld e,l			; $7db0
	inc hl			; $7db1
	ld b,e			; $7db2
	ld bc,$2784		; $7db3
	ld b,e			; $7db6
	ld bc,$2485		; $7db7
	ld b,e			; $7dba
	ld (bc),a		; $7dbb
	add (hl)		; $7dbc
_label_04_371:
	add hl,hl		; $7dbd
	ld b,e			; $7dbe
	ld (bc),a		; $7dbf
	add a			; $7dc0
	ld h,$43		; $7dc1
	ld bc,$25a8		; $7dc3
	ld b,e			; $7dc6
	ld (bc),a		; $7dc7
	xor c			; $7dc8
	.db $28 $43 
	add b			; $7dcb
	or (hl)			; $7dcc
	ld a,e			; $7dcd
	inc b			; $7dce
	ld bc,$305c		; $7dcf
	ld d,e			; $7dd2
	ld (bc),a		; $7dd3
	ld e,l			; $7dd4
	ld l,$53		; $7dd5
	ld bc,$3a60		; $7dd7
	ld d,e			; $7dda
	ld (bc),a		; $7ddb
	ld h,d			; $7ddc
	inc a			; $7ddd
	ld d,e			; $7dde
	ld bc,$49e0		; $7ddf
	inc bc			; $7de2
	ld (bc),a		; $7de3
	pop hl			; $7de4
	ld c,d			; $7de5
	inc bc			; $7de6
	ld bc,$1ee2		; $7de7
	inc de			; $7dea
	ld bc,$1fe3		; $7deb
	inc de			; $7dee
	ld bc,$68e4		; $7def
	inc bc			; $7df2
	ld bc,$51e6		; $7df3
	ld b,e			; $7df6
	ld (bc),a		; $7df7
	rst $20			; $7df8
	ld d,e			; $7df9
	ld b,e			; $7dfa
	ld bc,$40e8		; $7dfb
	inc sp			; $7dfe
	add b			; $7dff
	or (hl)			; $7e00
	ld a,e			; $7e01

.BANK $05 SLOT 1
.ORG 0

	ld hl,$cc72		; $4000
	ld a,(hl)		; $4003
	ld (hl),$00		; $4004
	or a			; $4006
	jr z,_label_05_000	; $4007
	and $7f			; $4009
	ld ($d001),a		; $400b
_label_05_000:
	xor a			; $400e
	ld ($cc7f),a		; $400f
	ld ($ccac),a		; $4012
	ld ($cc81),a		; $4015
	ld hl,$ccaf		; $4018
	ld a,(hl)		; $401b
	or $7f			; $401c
	ld (hl),a		; $401e
	ld hl,$cc7b		; $401f
	res 7,(hl)		; $4022
	call $4097		; $4024
	ld hl,$d100		; $4027
	call $4061		; $402a
	xor a			; $402d
	ld ($cc83),a		; $402e
	ld hl,$d000		; $4031
	call $4061		; $4034
	call $4237		; $4037
	ld a,($cca7)		; $403a
	ld ($ccb0),a		; $403d
	ld hl,wLinkImmobilized		; $4040
	ld a,(hl)		; $4043
	and $0f			; $4044
	ld (hl),a		; $4046
	xor a			; $4047
	ld ($cc82),a		; $4048
	ld ($d02a),a		; $404b
	ld ($ccef),a		; $404e
	ld hl,$cc85		; $4051
	ld a,(hl)		; $4054
	or a			; $4055
	jr z,_label_05_001	; $4056
	dec (hl)		; $4058
_label_05_001:
	ld hl,$cc8e		; $4059
	ld b,$10		; $405c
	jp clearMemory		; $405e
	ld a,(hl)		; $4061
	or a			; $4062
	ret z			; $4063
	ld a,l			; $4064
	ldh (<hActiveObjectType),a	; $4065
	ld a,h			; $4067
	ldh (<hActiveObject),a	; $4068
	ld d,h			; $406a
	ld l,$01		; $406b
	ld a,(hl)		; $406d
	rst_jumpTable			; $406e
	ld l,a			; $406f
	ld c,c			; $4070
	jp c,$467c		; $4071
	ld h,c			; $4074
	ld b,(hl)		; $4075
	ld h,c			; $4076
	ld b,(hl)		; $4077
	ld h,c			; $4078
	ld b,(hl)		; $4079
	ld h,c			; $407a
	ld b,(hl)		; $407b
	ld h,c			; $407c
	ld b,(hl)		; $407d
	ld h,c			; $407e
	jp hl			; $407f
	inc l			; $4080
	adc e			; $4081
	ld h,d			; $4082
	call c,$6a62		; $4083
	ld l,h			; $4086
	adc $72			; $4087
	dec hl			; $4089
	ld (hl),a		; $408a
.DB $e4				; $408b
	ld h,d			; $408c
	push de			; $408d
	inc l			; $408e
	push de			; $408f
	inc l			; $4090
	push de			; $4091
	inc l			; $4092
	push de			; $4093
	inc l			; $4094
	xor l			; $4095
	ld a,e			; $4096
	ld a,($c481)		; $4097
	ld c,a			; $409a
	ld a,($cbc3)		; $409b
	or a			; $409e
	jr z,_label_05_004	; $409f
	cp $02			; $40a1
	jr z,_label_05_002	; $40a3
	call getSimulatedInput		; $40a5
	jr _label_05_003		; $40a8
_label_05_002:
	xor a			; $40aa
	ld ($cbc3),a		; $40ab
	ld a,$a0		; $40ae
	and c			; $40b0
	rrca			; $40b1
	ld b,a			; $40b2
	ld a,$50		; $40b3
	and c			; $40b5
	rlca			; $40b6
	or b			; $40b7
	ld b,a			; $40b8
	ld a,$0f		; $40b9
	and c			; $40bb
	or b			; $40bc
_label_05_003:
	ld c,a			; $40bd
_label_05_004:
	ld a,($cc34)		; $40be
	or a			; $40c1
	ld hl,$cc45		; $40c2
	jr nz,_label_05_005	; $40c5
	ld a,(hl)		; $40c7
	cpl			; $40c8
	ld b,a			; $40c9
	ld a,c			; $40ca
	ldi (hl),a		; $40cb
	and b			; $40cc
	ldi (hl),a		; $40cd
	ld a,c			; $40ce
	and $f0			; $40cf
	swap a			; $40d1
	ld hl,$40e2		; $40d3
	rst_addAToHl			; $40d6
	ld a,(hl)		; $40d7
	ld ($cc47),a		; $40d8
	ret			; $40db
_label_05_005:
	xor a			; $40dc
	ldi (hl),a		; $40dd
	ldi (hl),a		; $40de
	dec a			; $40df
	ldi (hl),a		; $40e0
	ret			; $40e1
	rst $38			; $40e2
	ld ($ff18),sp		; $40e3
	nop			; $40e6
	inc b			; $40e7
	inc e			; $40e8
	rst $38			; $40e9
	stop			; $40ea
	inc c			; $40eb
	inc d			; $40ec
	rst $38			; $40ed
	rst $38			; $40ee
	rst $38			; $40ef
	rst $38			; $40f0
	xor a			; $40f1
	ldh (<hActiveObjectType),a	; $40f2
	ld de,$d101		; $40f4
	ld a,d			; $40f7
	ldh (<hActiveObject),a	; $40f8
	ld a,(de)		; $40fa
	sub $0a			; $40fb
	rst_jumpTable			; $40fd
	adc h			; $40fe
	ld b,c			; $40ff
	inc de			; $4100
	ld b,c			; $4101
	jr $41			; $4102
	ldi a,(hl)		; $4104
	ld b,c			; $4105
	ld (de),a		; $4106
	ld b,c			; $4107
	ld (de),a		; $4108
	ld b,c			; $4109
	ld (de),a		; $410a
	ld b,c			; $410b
	ld (de),a		; $410c
	ld b,c			; $410d
	ld (de),a		; $410e
	ld b,c			; $410f
	or l			; $4110
	ld b,c			; $4111
	ret			; $4112
	ld bc,$0000		; $4113
	jr _label_05_006		; $4116
	ld e,$08		; $4118
	ld a,(de)		; $411a
	rrca			; $411b
	ld bc,$f600		; $411c
	jr nc,_label_05_006	; $411f
	ld c,$fb		; $4121
	rrca			; $4123
	jr nc,_label_05_006	; $4124
	ld c,$05		; $4126
	jr _label_05_006		; $4128
	ld e,$08		; $412a
	ld a,(de)		; $412c
	rrca			; $412d
	ld bc,$f200		; $412e
	jr nc,_label_05_006	; $4131
	ld b,$f0		; $4133
_label_05_006:
	ld hl,$d00b		; $4135
	call objectCopyPositionWithOffset		; $4138
	ld e,$08		; $413b
	ld l,$08		; $413d
	ld a,(de)		; $413f
	ld (hl),a		; $4140
	ld a,$01		; $4141
	ld ($ccaa),a		; $4143
	ld l,$2a		; $4146
	ldi a,(hl)		; $4148
	or (hl)			; $4149
	ld l,$2d		; $414a
	or (hl)			; $414c
	jr nz,_label_05_007	; $414d
	ld l,$25		; $414f
	ld e,l			; $4151
	ld a,(de)		; $4152
	or a			; $4153
	jr z,_label_05_007	; $4154
	ldi (hl),a		; $4156
	ld l,$29		; $4157
	ld e,l			; $4159
	ld b,$06		; $415a
	call copyMemoryReverse		; $415c
	jr _label_05_008		; $415f
_label_05_007:
	ld l,$25		; $4161
	ld e,l			; $4163
	ld a,(hl)		; $4164
	ld (de),a		; $4165
	ld d,$d0		; $4166
	ld h,$d1		; $4168
	ld l,$29		; $416a
	ld e,l			; $416c
	ld b,$06		; $416d
	call copyMemoryReverse		; $416f
_label_05_008:
	ld h,$d0		; $4172
	ld d,$d1		; $4174
	ld l,$1c		; $4176
	ld a,(hl)		; $4178
	ld l,$1b		; $4179
	cp (hl)			; $417b
	jr nz,_label_05_009	; $417c
	ld e,$1b		; $417e
	ld a,(de)		; $4180
_label_05_009:
	ld e,$1c		; $4181
	ld (de),a		; $4183
	ld l,$1a		; $4184
	ld e,l			; $4186
	ld a,(de)		; $4187
	and $83			; $4188
	ld (hl),a		; $418a
	ret			; $418b
	ld h,d			; $418c
	ld l,$08		; $418d
	ld a,(hl)		; $418f
	ld l,$21		; $4190
	add (hl)		; $4192
	ld hl,$41a5		; $4193
	rst_addDoubleIndex			; $4196
	ldi a,(hl)		; $4197
	ld c,(hl)		; $4198
	ld b,a			; $4199
	ld hl,$d00b		; $419a
	call objectCopyPositionWithOffset		; $419d
	ld l,$1a		; $41a0
	res 6,(hl)		; $41a2
	ret			; $41a4
	rst $30			; $41a5
	nop			; $41a6
	rst $30			; $41a7
	nop			; $41a8
	rst $30			; $41a9
	nop			; $41aa
	rst $30			; $41ab
	nop			; $41ac
	rst $30			; $41ad
	rst $38			; $41ae
	ld hl,sp+$00		; $41af
	rst $30			; $41b1
	rst $38			; $41b2
	ld hl,sp+$00		; $41b3
	ld e,$32		; $41b5
	ld a,$ff		; $41b7
	ld (de),a		; $41b9
	ld e,$01		; $41ba
	ld a,(de)		; $41bc
	ld hl,$41cb		; $41bd
	rst_addDoubleIndex			; $41c0
	ld e,$1d		; $41c1
	ldi a,(hl)		; $41c3
	ld (de),a		; $41c4
	dec e			; $41c5
	ldi a,(hl)		; $41c6
	ld (de),a		; $41c7
	dec e			; $41c8
	ld (de),a		; $41c9
	ret			; $41ca
	ld (hl),b		; $41cb
	ld ($0870),sp		; $41cc
	ld (hl),b		; $41cf
	ld ($0870),sp		; $41d0
	ld (hl),b		; $41d3
	ld ($0870),sp		; $41d4
	ld (hl),b		; $41d7
	ld ($0870),sp		; $41d8
	ld (hl),b		; $41db
	ld ($0870),sp		; $41dc
	ld h,b			; $41df
	inc c			; $41e0
	ld h,b			; $41e1
	dec bc			; $41e2
	ld h,b			; $41e3
	ld a,(bc)		; $41e4
	ld h,b			; $41e5
	add hl,bc		; $41e6
	ld h,b			; $41e7
	ld ($0b60),sp		; $41e8
	ld h,b			; $41eb
	ld a,(bc)		; $41ec
	ld h,b			; $41ed
	add hl,bc		; $41ee
	ld h,b			; $41ef
	ld ($0b60),sp		; $41f0
	ld a,($ccb0)		; $41f3
	ld b,a			; $41f6
	ld h,d			; $41f7
	ld l,$2b		; $41f8
	or (hl)			; $41fa
	ret nz			; $41fb
	ld (hl),$28		; $41fc
	ld a,$1d		; $41fe
	call cpActiveRing		; $4200
	ld a,$fc		; $4203
	jr nz,_label_05_010	; $4205
	sra a			; $4207
_label_05_010:
	ld l,$25		; $4209
	add (hl)		; $420b
	ld (hl),a		; $420c
	ld l,$2a		; $420d
	ld (hl),$80		; $420f
	ld l,$2d		; $4211
	ld a,$0a		; $4213
	add (hl)		; $4215
	ld (hl),a		; $4216
	ld e,$09		; $4217
	ld a,(de)		; $4219
	xor $10			; $421a
	ld l,$2c		; $421c
	ld (hl),a		; $421e
	ld a,$5f		; $421f
	call playSound		; $4221
	jr _label_05_011		; $4224
	ld hl,$4647		; $4226
	ld e,$06		; $4229
	call interBankCall		; $422b
_label_05_011:
	ld hl,$469a		; $422e
	ld e,$06		; $4231
	call interBankCall		; $4233
	ret			; $4236
	ld hl,$d02b		; $4237
	ld a,(hl)		; $423a
	or a			; $423b
	ret z			; $423c
	bit 7,a			; $423d
	jr nz,_label_05_012	; $423f
	dec (hl)		; $4241
	jr z,_label_05_013	; $4242
	ld a,(wFrameCounter)		; $4244
	bit 2,a			; $4247
	jr nz,_label_05_013	; $4249
	ld l,$1c		; $424b
	ld (hl),$0d		; $424d
	ret			; $424f
_label_05_012:
	inc (hl)		; $4250
_label_05_013:
	ld l,$1b		; $4251
	ldi a,(hl)		; $4253
	ld (hl),a		; $4254
	ret			; $4255
	call objectGetTileAtPosition		; $4256
	ld ($ccb4),a		; $4259
	ld hl,$7bad		; $425c
	call lookupCollisionTable		; $425f
	ld ($ccb6),a		; $4262
	ld bc,$0800		; $4265
	call objectGetRelativeTile		; $4268
	ld hl,$7bad		; $426b
	call lookupCollisionTable		; $426e
	ld ($ccb7),a		; $4271
	ret			; $4274
	xor a			; $4275
	ld ($ccb8),a		; $4276
	ld a,($cc77)		; $4279
	or a			; $427c
	jp nz,$42b3		; $427d
	call $43b9		; $4280
	ld ($ccb6),a		; $4283
	rst_jumpTable			; $4286
	or e			; $4287
	ld b,d			; $4288
	dec b			; $4289
	ld b,e			; $428a
	dec b			; $428b
	ld b,e			; $428c
	ld ($dd42),a		; $428d
	ld b,d			; $4290
	push hl			; $4291
	ld b,d			; $4292
	push hl			; $4293
	ld b,d			; $4294
	ld c,l			; $4295
	ld b,e			; $4296
	jp nc,$8a42		; $4297
	ld b,e			; $429a
	adc d			; $429b
	ld b,e			; $429c
	adc d			; $429d
	ld b,e			; $429e
	adc d			; $429f
	ld b,e			; $42a0
	di			; $42a1
	ld b,c			; $42a2
	dec a			; $42a3
	ld b,e			; $42a4
	cpl			; $42a5
	ld b,e			; $42a6
	ld l,d			; $42a7
	ld b,e			; $42a8
	cp (hl)			; $42a9
	ld b,d			; $42aa
	or c			; $42ab
	ld b,e			; $42ac
	or c			; $42ad
	ld b,e			; $42ae
	or c			; $42af
	ld b,e			; $42b0
	or c			; $42b1
	ld b,e			; $42b2
_label_05_014:
	xor a			; $42b3
	ld ($ccb6),a		; $42b4
	ld ($ccb5),a		; $42b7
	ld ($cc78),a		; $42ba
	ret			; $42bd
	ld h,d			; $42be
	ld l,$21		; $42bf
	bit 5,(hl)		; $42c1
	jr z,_label_05_014	; $42c3
	res 5,(hl)		; $42c5
	ld a,(wLinkImmobilized)		; $42c7
	or a			; $42ca
	ld a,$87		; $42cb
	call z,playSound		; $42cd
	jr _label_05_014		; $42d0
	ld h,d			; $42d2
	ld l,$33		; $42d3
	ld (hl),$ff		; $42d5
	ld l,$24		; $42d7
	res 7,(hl)		; $42d9
	jr _label_05_015		; $42db
	call dropLinkHeldItem		; $42dd
	ld a,$ff		; $42e0
	ld ($cc83),a		; $42e2
_label_05_015:
	xor a			; $42e5
	ld ($cc78),a		; $42e6
	ret			; $42e9
	ld a,$22		; $42ea
	call cpActiveRing		; $42ec
	jr z,_label_05_014	; $42ef
	ld a,($ccb5)		; $42f1
	cp $20			; $42f4
	jr c,_label_05_015	; $42f6
	ld a,($ccb3)		; $42f8
	ld c,a			; $42fb
	ld a,$f3		; $42fc
	call breakCrackedFloor		; $42fe
	xor a			; $4301
	ld ($ccb5),a		; $4302
	xor a			; $4305
	ld ($cc78),a		; $4306
	ld a,($ccb0)		; $4309
	or a			; $430c
	jr nz,_label_05_014	; $430d
	ld a,($cc79)		; $430f
	bit 6,a			; $4312
	jr nz,_label_05_014	; $4314
	ld hl,$ccb7		; $4316
	ldd a,(hl)		; $4319
	cp (hl)			; $431a
	jr nz,_label_05_016	; $431b
	ld l,$b3		; $431d
	ldi a,(hl)		; $431f
	cp b			; $4320
	jr z,_label_05_016	; $4321
	inc l			; $4323
	ld a,$0e		; $4324
	ld (hl),a		; $4326
_label_05_016:
	ld a,$80		; $4327
	ld ($ccac),a		; $4329
	jp $5dd9		; $432c
_label_05_017:
	ld a,$21		; $432f
	call cpActiveRing		; $4331
	jr z,_label_05_015	; $4334
	ld hl,$ccb8		; $4336
	set 6,(hl)		; $4339
	jr _label_05_015		; $433b
	ld a,($ccb5)		; $433d
	cp $20			; $4340
	jr c,_label_05_017	; $4342
	ld a,($ccb3)		; $4344
	ld c,a			; $4347
	ld a,$fd		; $4348
	call setTile		; $434a
_label_05_018:
	ld a,($ccb0)		; $434d
	or a			; $4350
	jp nz,$42b3		; $4351
	ld a,($cc78)		; $4354
	or a			; $4357
	ret nz			; $4358
	xor a			; $4359
	ld e,$35		; $435a
	ld (de),a		; $435c
	ld e,$2d		; $435d
	ld (de),a		; $435f
	inc a			; $4360
	ld ($cc78),a		; $4361
	ld a,$80		; $4364
	ld ($ccac),a		; $4366
	ret			; $4369
	ld a,($cc79)		; $436a
	bit 6,a			; $436d
	jp nz,$42b3		; $436f
	ld a,$80		; $4372
	ld ($ccac),a		; $4374
	ld e,$2d		; $4377
	xor a			; $4379
	ld (de),a		; $437a
	ld a,($cc78)		; $437b
	or a			; $437e
	ret nz			; $437f
	xor a			; $4380
	ld e,$35		; $4381
	ld (de),a		; $4383
	ld a,$41		; $4384
	ld ($cc78),a		; $4386
	ret			; $4389
	ld a,($ccb0)		; $438a
	or a			; $438d
	jp nz,$42b3		; $438e
	ld a,$23		; $4391
	call cpActiveRing		; $4393
	jp z,$42b3		; $4396
	ld bc,$1409		; $4399
	ld a,$01		; $439c
	ld ($ccac),a		; $439e
	ld a,($ccb6)		; $43a1
	sub c			; $43a4
	ld hl,$43ad		; $43a5
	rst_addAToHl			; $43a8
	ld c,(hl)		; $43a9
	jp $5c90		; $43aa
	nop			; $43ad
	ld ($1810),sp		; $43ae
	ld bc,$1e12		; $43b1
	call $439c		; $43b4
	jr _label_05_018		; $43b7
	ld bc,$0500		; $43b9
	call objectGetRelativeTile		; $43bc
	ld c,a			; $43bf
	ld b,l			; $43c0
	ld hl,$ccb3		; $43c1
	ldi a,(hl)		; $43c4
	cp b			; $43c5
	jr nz,_label_05_019	; $43c6
	ld a,(hl)		; $43c8
	cp c			; $43c9
	jr z,_label_05_020	; $43ca
_label_05_019:
	ld l,$b3		; $43cc
	ld a,(hl)		; $43ce
	ld (hl),b		; $43cf
	ld b,a			; $43d0
	inc l			; $43d1
	ld (hl),c		; $43d2
	inc l			; $43d3
	ld (hl),$00		; $43d4
_label_05_020:
	ld l,$b5		; $43d6
	inc (hl)		; $43d8
	inc l			; $43d9
	ldi a,(hl)		; $43da
	ld (hl),a		; $43db
	ld a,c			; $43dc
	ld hl,$7bad		; $43dd
	jp lookupCollisionTable		; $43e0
	ld l,$09		; $43e3
	ld h,d			; $43e5
	ld e,l			; $43e6
	ld a,($cc50)		; $43e7
	and $20			; $43ea
	ret z			; $43ec
	bit 7,(hl)		; $43ed
	ret nz			; $43ef
	ld a,(hl)		; $43f0
	ld hl,$43f8		; $43f1
	rst_addAToHl			; $43f4
	ld a,(hl)		; $43f5
	ld (de),a		; $43f6
	ret			; $43f7
	rst $38			; $43f8
	ld ($0808),sp		; $43f9
	ld ($0808),sp		; $43fc
	ld ($0808),sp		; $43ff
	ld ($0808),sp		; $4402
	ld ($0808),sp		; $4405
	rst $38			; $4408
	jr $18			; $4409
	jr _label_05_021		; $440b
	jr _label_05_022		; $440d
	jr _label_05_023		; $440f
	jr _label_05_024		; $4411
	jr _label_05_025		; $4413
	jr $18			; $4415
	jr $21			; $4417
	nop			; $4419
	ret nc			; $441a
	jp preventObjectHFromPassingObjectD		; $441b
	call $4439		; $441e
	call $5c88		; $4421
	ld h,d			; $4424
_label_05_021:
	ld l,$0f		; $4425
_label_05_022:
	ld a,(hl)		; $4427
	or a			; $4428
_label_05_023:
	ret nz			; $4429
	ld h,d			; $442a
_label_05_024:
	ld l,$0b		; $442b
_label_05_025:
	ld a,(hl)		; $442d
	add $05			; $442e
	ld b,a			; $4430
	ld l,$0d		; $4431
	ld c,(hl)		; $4433
	ld a,$13		; $4434
	jp tryToBreakTile		; $4436
	ld e,$33		; $4439
	xor a			; $443b
	ld (de),a		; $443c
	ld h,d			; $443d
	ld l,$0b		; $443e
	ld b,(hl)		; $4440
	ld l,$0d		; $4441
	ld c,(hl)		; $4443
	ld a,$01		; $4444
	ldh (<hFF8B),a	; $4446
	ld hl,$4461		; $4448
_label_05_026:
	ldi a,(hl)		; $444b
	add b			; $444c
	ld b,a			; $444d
	ldi a,(hl)		; $444e
	add c			; $444f
	ld c,a			; $4450
	push hl			; $4451
	call $4471		; $4452
	pop hl			; $4455
	ldh a,(<hFF8B)	; $4456
	rla			; $4458
	ldh (<hFF8B),a	; $4459
	jr nc,_label_05_026	; $445b
	ld e,$33		; $445d
	ld (de),a		; $445f
	ret			; $4460
	ei			; $4461
.DB $fd				; $4462
	nop			; $4463
	rlca			; $4464
	dec c			; $4465
	ld sp,hl		; $4466
	nop			; $4467
	rlca			; $4468
	push af			; $4469
	rst $30			; $446a
	add hl,bc		; $446b
	nop			; $446c
	rst $30			; $446d
	dec bc			; $446e
	add hl,bc		; $446f
	nop			; $4470
	call getTileAtPosition		; $4471
	ld a,(hl)		; $4474
	cp $df			; $4475
	jr z,_label_05_028	; $4477
	cp $de			; $4479
	jr z,_label_05_028	; $447b
	cp $dd			; $447d
	ld a,$03		; $447f
	jp z,checkGivenCollision_allowHoles		; $4481
	ld e,$01		; $4484
	ld a,(de)		; $4486
	cp $0b			; $4487
	jr nz,_label_05_027	; $4489
	ld e,$0f		; $448b
	ld a,(de)		; $448d
	bit 7,a			; $448e
	jr z,_label_05_029	; $4490
	ld a,(hl)		; $4492
	cp $d9			; $4493
	ret z			; $4495
	cp $da			; $4496
	ret z			; $4498
	jr _label_05_029		; $4499
_label_05_027:
	cp $0c			; $449b
	jr nz,_label_05_029	; $449d
	ld a,(hl)		; $449f
	cp $fe			; $44a0
	ret nc			; $44a2
	jr _label_05_029		; $44a3
_label_05_028:
	scf			; $44a5
	ret			; $44a6
_label_05_029:
	jp checkCollisionPosition_disallowSmallBridges		; $44a7
	ld e,$08		; $44aa
	ld a,(de)		; $44ac
	rst_addDoubleIndex			; $44ad
	ldi a,(hl)		; $44ae
	ld b,a			; $44af
	ld c,(hl)		; $44b0
	call objectGetRelativeTile		; $44b1
	ld b,a			; $44b4
	ld h,$ce		; $44b5
	ld a,(hl)		; $44b7
	ret			; $44b8
	ld h,d			; $44b9
	ld l,$09		; $44ba
	ld a,(hl)		; $44bc
	cp $ff			; $44bd
	ret z			; $44bf
	add $10			; $44c0
	and $1f			; $44c2
	ld (hl),a		; $44c4
	call $44db		; $44c5
	ld c,a			; $44c8
	ld l,$09		; $44c9
	ld a,(hl)		; $44cb
	add $10			; $44cc
	and $1f			; $44ce
	ld (hl),a		; $44d0
	ld a,c			; $44d1
	or a			; $44d2
	ret			; $44d3
	ld h,d			; $44d4
	ld l,$09		; $44d5
	ld a,(hl)		; $44d7
	cp $ff			; $44d8
	ret z			; $44da
	ld bc,$0000		; $44db
	cp $08			; $44de
	jr z,_label_05_031	; $44e0
	cp $18			; $44e2
	jr z,_label_05_031	; $44e4
	ld l,$33		; $44e6
	ld b,(hl)		; $44e8
	add a			; $44e9
	swap a			; $44ea
	and $03			; $44ec
	ld a,$30		; $44ee
	jr nz,_label_05_030	; $44f0
	ld a,$c0		; $44f2
_label_05_030:
	and b			; $44f4
	ld b,a			; $44f5
_label_05_031:
	ld l,$09		; $44f6
	ld a,(hl)		; $44f8
	and $0f			; $44f9
	jr z,_label_05_033	; $44fb
	ld a,(hl)		; $44fd
	ld l,$33		; $44fe
	ld c,(hl)		; $4500
	bit 4,a			; $4501
	ld a,$03		; $4503
	jr z,_label_05_032	; $4505
	ld a,$0c		; $4507
_label_05_032:
	and c			; $4509
	ld c,a			; $450a
_label_05_033:
	ld a,b			; $450b
	or c			; $450c
	ret			; $450d
	call getFreeItemSlot		; $450e
	ret nz			; $4511
	jr _label_05_034		; $4512
	ld hl,$d600		; $4514
	ld a,(hl)		; $4517
	or a			; $4518
	ret nz			; $4519
_label_05_034:
	inc (hl)		; $451a
	inc l			; $451b
	ld (hl),b		; $451c
	inc l			; $451d
	ld (hl),c		; $451e
	ld l,$28		; $451f
	ld (hl),$f9		; $4521
	xor a			; $4523
	ret			; $4524
	ld e,$08		; $4525
	ld a,(de)		; $4527
	ld ($d008),a		; $4528
	ld e,$04		; $452b
	ld a,(de)		; $452d
	cp $0c			; $452e
	jp z,specialObjectAnimate		; $4530
	call updateLinkDirectionFromAngle		; $4533
	ld hl,$d108		; $4536
	cp (hl)			; $4539
	jp z,specialObjectAnimate		; $453a
	ld e,$09		; $453d
	ld a,(de)		; $453f
	add a			; $4540
	swap a			; $4541
	and $03			; $4543
	dec e			; $4545
	ld (de),a		; $4546
	ld h,d			; $4547
	ld a,c			; $4548
	ld l,$08		; $4549
	add (hl)		; $454b
	ld l,$38		; $454c
	add (hl)		; $454e
	jp specialObjectSetAnimation		; $454f
	ld a,($ccb6)		; $4552
	cp $01			; $4555
	jr z,_label_05_035	; $4557
	call checkLinkID0AndControlNormal		; $4559
	jr c,_label_05_036	; $455c
_label_05_035:
	or d			; $455e
	ret			; $455f
_label_05_036:
	ld a,($d004)		; $4560
	cp $01			; $4563
	ret nz			; $4565
	ld a,($cc78)		; $4566
	or a			; $4569
	ret nz			; $456a
	ld a,($cc75)		; $456b
	or a			; $456e
	ret nz			; $456f
	ld a,($cc77)		; $4570
	or a			; $4573
	ret nz			; $4574
	inc a			; $4575
	ld ($ccaa),a		; $4576
	ld ($cc88),a		; $4579
	ld e,$04		; $457c
	ld a,$03		; $457e
	ld (de),a		; $4580
	ld a,$ff		; $4581
	ld ($cc47),a		; $4583
	ld a,$81		; $4586
	ld ($cc77),a		; $4588
	ld ($ccab),a		; $458b
	ld hl,$d009		; $458e
	ld (hl),a		; $4591
	ld l,$10		; $4592
	ld (hl),$14		; $4594
	ld l,$14		; $4596
	ld (hl),$40		; $4598
	inc l			; $459a
	ld (hl),$fe		; $459b
	xor a			; $459d
	ret			; $459e
	call objectCheckIsOnHazard		; $459f
	ld h,d			; $45a2
	ret nc			; $45a3
	push af			; $45a4
	ld l,$04		; $45a5
	ld a,$04		; $45a7
	ldi (hl),a		; $45a9
	xor a			; $45aa
	ldi (hl),a		; $45ab
	ldi (hl),a		; $45ac
	ld l,$01		; $45ad
	ld a,(hl)		; $45af
	cp $0c			; $45b0
	jr z,_label_05_037	; $45b2
	ld ($ccab),a		; $45b4
	ld a,$87		; $45b7
	call playSound		; $45b9
_label_05_037:
	pop af			; $45bc
	scf			; $45bd
	ret			; $45be
	call $45f5		; $45bf
	ld e,$01		; $45c2
	ld a,(de)		; $45c4
	ld hl,$c610		; $45c5
	cp (hl)			; $45c8
	jr z,_label_05_041	; $45c9
	cp $0b			; $45cb
	jr z,_label_05_038	; $45cd
	cp $0c			; $45cf
	jr z,_label_05_039	; $45d1
	ld a,($c6bb)		; $45d3
	bit 4,a			; $45d6
	jr z,_label_05_041	; $45d8
	jr _label_05_040		; $45da
_label_05_038:
	ld a,($c6af)		; $45dc
	or a			; $45df
	jr z,_label_05_041	; $45e0
	jr _label_05_040		; $45e2
_label_05_039:
	ld a,$2e		; $45e4
	call checkTreasureObtained		; $45e6
	jr nc,_label_05_041	; $45e9
_label_05_040:
	call $4641		; $45eb
	xor a			; $45ee
	ld ($cc40),a		; $45ef
	ret			; $45f2
_label_05_041:
	jr _label_05_042		; $45f3
	xor a			; $45f5
	call setLinkID		; $45f6
	ld hl,$d01b		; $45f9
	ldi a,(hl)		; $45fc
	ldd (hl),a		; $45fd
	ld h,d			; $45fe
	ldi a,(hl)		; $45ff
	ld (hl),a		; $4600
	xor a			; $4601
	ld l,$25		; $4602
	ld (hl),a		; $4604
	ld l,$2b		; $4605
	ldi (hl),a		; $4607
	ldi (hl),a		; $4608
	ld (hl),a		; $4609
	ld l,$3c		; $460a
	ld (hl),a		; $460c
	ld ($cc6a),a		; $460d
	ld ($cc6b),a		; $4610
	ld l,$00		; $4613
	ld (hl),$01		; $4615
	ld l,$08		; $4617
	ldi a,(hl)		; $4619
	swap a			; $461a
	srl a			; $461c
	ld (hl),a		; $461e
	call $4583		; $461f
	ld hl,$d009		; $4622
	ld (hl),$ff		; $4625
	call objectCopyPosition		; $4627
	dec l			; $462a
	ld (hl),$f8		; $462b
	ld a,h			; $462d
	ld ($cc48),a		; $462e
	xor a			; $4631
	ld ($ccaa),a		; $4632
	ld ($cc88),a		; $4635
	ld ($ccb1),a		; $4638
	ld ($ccab),a		; $463b
	jp setCameraFocusedObjectToLink		; $463e
_label_05_042:
	ld hl,$cc40		; $4641
	ld a,($d101)		; $4644
	ldi (hl),a		; $4647
	ld a,($cc49)		; $4648
	ldi (hl),a		; $464b
	ld a,($cc4c)		; $464c
	ldi (hl),a		; $464f
	ld a,($d108)		; $4650
	ld ($cc3f),a		; $4653
	ld a,($d10b)		; $4656
	ldi (hl),a		; $4659
	ld ($cc3d),a		; $465a
	ld a,($d10d)		; $465d
	ldi (hl),a		; $4660
	ld ($cc3e),a		; $4661
	ret			; $4664
	ld e,$3d		; $4665
	ld a,(de)		; $4667
	or a			; $4668
	jr z,_label_05_043	; $4669
	xor a			; $466b
	ret			; $466c
_label_05_043:
	ld bc,$0500		; $466d
	call objectGetRelativeTile		; $4670
	ld c,l			; $4673
	call convertShortToLongPosition_paramC		; $4674
	ld e,$0d		; $4677
	ld a,(de)		; $4679
	cp c			; $467a
	ld c,$00		; $467b
	jr z,_label_05_045	; $467d
	ld hl,$0040		; $467f
	jr c,_label_05_044	; $4682
	ld hl,$ffc0		; $4684
_label_05_044:
	dec e			; $4687
	ld a,(de)		; $4688
	add l			; $4689
	ld (de),a		; $468a
	inc e			; $468b
	ld a,(de)		; $468c
	adc h			; $468d
	ld (de),a		; $468e
	dec c			; $468f
_label_05_045:
	ld e,$0b		; $4690
	ld a,(de)		; $4692
	cp b			; $4693
	jr z,_label_05_047	; $4694
	ld hl,$0040		; $4696
	jr c,_label_05_046	; $4699
	ld hl,$ffc0		; $469b
_label_05_046:
	dec e			; $469e
	ld a,(de)		; $469f
	add l			; $46a0
	ld (de),a		; $46a1
	inc e			; $46a2
	ld a,(de)		; $46a3
	adc h			; $46a4
	ld (de),a		; $46a5
	dec c			; $46a6
_label_05_047:
	ld h,d			; $46a7
	ld a,c			; $46a8
	or a			; $46a9
	ret			; $46aa
	xor a			; $46ab
	ld ($ccab),a		; $46ac
	ld ($cc6a),a		; $46af
	ld ($cc6b),a		; $46b2
	call specialObjectSetCoordinatesToRespawnYX		; $46b5
	ld bc,$0500		; $46b8
	call objectGetRelativeTile		; $46bb
	cp $20			; $46be
	jr nz,_label_05_048	; $46c0
	ld h,d			; $46c2
	ld l,$0b		; $46c3
	ld a,($cc43)		; $46c5
	ldi (hl),a		; $46c8
	inc l			; $46c9
	ld a,($cc44)		; $46ca
	ldi (hl),a		; $46cd
_label_05_048:
	call objectCheckSimpleCollision		; $46ce
	jr nz,_label_05_049	; $46d1
	call objectGetPosition		; $46d3
	call $4471		; $46d6
	jr c,_label_05_049	; $46d9
	call objectCheckIsOnHazard		; $46db
	jr nc,_label_05_050	; $46de
_label_05_049:
	ld h,d			; $46e0
	ld l,$0b		; $46e1
	ld a,($c638)		; $46e3
	ld ($cc3d),a		; $46e6
	ldi (hl),a		; $46e9
	inc l			; $46ea
	ld a,($c639)		; $46eb
	ld ($cc3e),a		; $46ee
	ldi (hl),a		; $46f1
_label_05_050:
	ld a,($cc48)		; $46f2
	rrca			; $46f5
	ld a,$01		; $46f6
	jr nc,_label_05_051	; $46f8
	ld a,$fe		; $46fa
	ld ($d025),a		; $46fc
	ld a,$40		; $46ff
	ld ($d02b),a		; $4701
	ld a,$05		; $4704
_label_05_051:
	ld h,d			; $4706
	ld l,$04		; $4707
	ldi (hl),a		; $4709
	xor a			; $470a
	ld (hl),a		; $470b
	ld l,$3d		; $470c
	ld (hl),a		; $470e
	ld ($ccab),a		; $470f
	ld l,$24		; $4712
	res 7,(hl)		; $4714
	ret			; $4716
	ld a,($cc47)		; $4717
	ld c,a			; $471a
	and $e7			; $471b
	ret nz			; $471d
	ld e,$09		; $471e
	ld a,(de)		; $4720
	cp c			; $4721
	ret nz			; $4722
	call $44d4		; $4723
	cp $03			; $4726
	jr z,_label_05_052	; $4728
	cp $0c			; $472a
	jr z,_label_05_052	; $472c
	cp $30			; $472e
	ret nz			; $4730
_label_05_052:
	ld e,$08		; $4731
	ld a,(de)		; $4733
	ld hl,$4771		; $4734
	rst_addDoubleIndex			; $4737
	ldi a,(hl)		; $4738
	ld b,a			; $4739
	ld c,(hl)		; $473a
	call objectGetRelativeTile		; $473b
	cp $dd			; $473e
	jr z,_label_05_053	; $4740
	ld hl,$7c9a		; $4742
	call lookupCollisionTable		; $4745
	jr c,_label_05_054	; $4748
	or d			; $474a
	ret			; $474b
_label_05_053:
	ld a,$10		; $474c
_label_05_054:
	ld h,d			; $474e
	ld l,$09		; $474f
	cp (hl)			; $4751
	ret nz			; $4752
	ld a,$80		; $4753
	ld ($cc77),a		; $4755
	ld bc,$fd40		; $4758
	call objectSetSpeedZ		; $475b
	ld l,$10		; $475e
	ld (hl),$50		; $4760
	ld l,$06		; $4762
	ld a,$14		; $4764
	ldi (hl),a		; $4766
	xor a			; $4767
	ld (hl),a		; $4768
	ld l,$04		; $4769
	ld a,$07		; $476b
	ldi (hl),a		; $476d
	xor a			; $476e
	ld (hl),a		; $476f
	ret			; $4770
	ld a,($0000)		; $4771
	inc b			; $4774
	ld ($0000),sp		; $4775
	ei			; $4778
	ld h,d			; $4779
	ld l,$00		; $477a
	set 1,(hl)		; $477c
	ld l,$04		; $477e
	ld (hl),$05		; $4780
	ld l,$09		; $4782
	ld a,$ff		; $4784
	ld (hl),a		; $4786
	ld l,$3c		; $4787
	ld (hl),a		; $4789
	ld l,$1a		; $478a
	ld a,(hl)		; $478c
	and $c0			; $478d
	or $01			; $478f
	ld (hl),a		; $4791
	xor a			; $4792
	ld l,$3d		; $4793
	ld (hl),a		; $4795
	ld ($cc77),a		; $4796
	ld ($ccab),a		; $4799
	ld bc,$c638		; $479c
	ld l,$0b		; $479f
	ldi a,(hl)		; $47a1
	ld (bc),a		; $47a2
	inc c			; $47a3
	inc l			; $47a4
	ld a,(hl)		; $47a5
	ld (bc),a		; $47a6
	ld a,d			; $47a7
	ld ($cc48),a		; $47a8
	call setCameraFocusedObjectToLink		; $47ab
	ld a,$09		; $47ae
	jp setLinkID		; $47b0
	ld h,d			; $47b3
	ld l,$3c		; $47b4
	ld a,(hl)		; $47b6
	or a			; $47b7
	ret z			; $47b8
	ld a,($cc34)		; $47b9
	or a			; $47bc
	ret z			; $47bd
	xor a			; $47be
	ld (hl),a		; $47bf
	ld e,$0e		; $47c0
	ldi (hl),a		; $47c2
	ldi (hl),a		; $47c3
	ld l,$04		; $47c4
	ld (hl),$09		; $47c6
	ld e,$1b		; $47c8
	ldi a,(hl)		; $47ca
	ld (hl),a		; $47cb
	ld e,$1a		; $47cc
	xor a			; $47ce
	ld (de),a		; $47cf
	ld h,$d0		; $47d0
	call objectCopyPosition		; $47d2
	ld a,h			; $47d5
	ld ($cc48),a		; $47d6
	call setCameraFocusedObjectToLink		; $47d9
	xor a			; $47dc
	call setLinkID		; $47dd
	or d			; $47e0
	ret			; $47e1
	ld e,$38		; $47e2
	ld a,(de)		; $47e4
	or a			; $47e5
	jr z,_label_05_055	; $47e6
	xor a			; $47e8
	ld ($ccb1),a		; $47e9
	ret			; $47ec
_label_05_055:
	ld a,$06		; $47ed
	jr _label_05_056		; $47ef
	call $4547		; $47f1
	ld a,$05		; $47f4
_label_05_056:
	ld e,$04		; $47f6
	ld (de),a		; $47f8
	inc e			; $47f9
	xor a			; $47fa
	ld (de),a		; $47fb
	ret			; $47fc
	ld e,$04		; $47fd
	ld a,(de)		; $47ff
	or a			; $4800
	jr nz,_label_05_058	; $4801
	ld e,$0b		; $4803
	ld a,(de)		; $4805
	add $05			; $4806
	ld b,a			; $4808
	ld e,$0d		; $4809
	ld a,(de)		; $480b
	ld c,a			; $480c
	call getTileCollisionsAtPosition		; $480d
	cp $10			; $4810
	jr z,_label_05_057	; $4812
	cp $0f			; $4814
	jr nz,_label_05_058	; $4816
_label_05_057:
	ld hl,$c638		; $4818
	ldi a,(hl)		; $481b
	ld e,$0b		; $481c
	ld (de),a		; $481e
	ld a,(hl)		; $481f
	ld e,$0d		; $4820
	ld (de),a		; $4822
	call objectGetTileCollisions		; $4823
	jr z,_label_05_058	; $4826
	pop af			; $4828
	jp itemDelete		; $4829
_label_05_058:
	call $41b5		; $482c
	ld hl,$d103		; $482f
	ldi a,(hl)		; $4832
	inc a			; $4833
	ld (hl),a		; $4834
	ld l,$24		; $4835
	ld (hl),$80		; $4837
	ret			; $4839
	ld e,$04		; $483a
	ld a,(de)		; $483c
	or a			; $483d
	ret z			; $483e
	ld a,($cba0)		; $483f
	or a			; $4842
	jr nz,_label_05_059	; $4843
	ld a,($cd00)		; $4845
	and $0e			; $4848
	jr nz,_label_05_059	; $484a
	ld a,($c4ab)		; $484c
	or a			; $484f
	jr nz,_label_05_059	; $4850
	ld a,($cca4)		; $4852
	and $a0			; $4855
	ret z			; $4857
_label_05_059:
	pop af			; $4858
	ret			; $4859
	ld h,d			; $485a
	ld l,$3f		; $485b
	ld a,(hl)		; $485d
	ld l,$30		; $485e
	cp (hl)			; $4860
	jp nz,specialObjectSetAnimation		; $4861
	ret			; $4864
	ld hl,$d01b		; $4865
	ld a,(wFrameCounter)		; $4868
	bit 2,a			; $486b
	jr nz,_label_05_060	; $486d
	ldi a,(hl)		; $486f
	and $f8			; $4870
	or c			; $4872
	ld (hl),a		; $4873
	ret			; $4874
_label_05_060:
	ldi a,(hl)		; $4875
	ld (hl),a		; $4876
	ret			; $4877
	ld a,($d004)		; $4878
	cp $01			; $487b
	jr nz,_label_05_061	; $487d
	ld a,($cc75)		; $487f
	or a			; $4882
	jr z,_label_05_062	; $4883
_label_05_061:
	xor a			; $4885
	ld ($ccaa),a		; $4886
	ld ($cc88),a		; $4889
	ld ($ccab),a		; $488c
	ld a,$01		; $488f
	ld e,$04		; $4891
	ld (de),a		; $4893
	or d			; $4894
	ret			; $4895
_label_05_062:
	ld hl,$d00b		; $4896
	ld e,$0b		; $4899
	ld a,(de)		; $489b
	cp (hl)			; $489c
	call nz,$48b5		; $489d
	ld e,$0d		; $48a0
	ld l,e			; $48a2
	ld a,(de)		; $48a3
	cp (hl)			; $48a4
	call nz,$48b5		; $48a5
	ld l,$15		; $48a8
	bit 7,(hl)		; $48aa
	ret nz			; $48ac
	ld l,$0f		; $48ad
	ld a,(hl)		; $48af
	cp $fc			; $48b0
	ret c			; $48b2
	xor a			; $48b3
	ret			; $48b4
	jr c,_label_05_063	; $48b5
	inc (hl)		; $48b7
	ret			; $48b8
_label_05_063:
	dec (hl)		; $48b9
	ret			; $48ba
	ld h,d			; $48bb
	ld l,$00		; $48bc
	ld a,(hl)		; $48be
	or a			; $48bf
	ret z			; $48c0
	ld l,$3c		; $48c1
	ld a,(hl)		; $48c3
	ld ($cc88),a		; $48c4
	ld l,$0f		; $48c7
	ldi a,(hl)		; $48c9
	bit 7,a			; $48ca
	jr nz,_label_05_066	; $48cc
	ld bc,$0500		; $48ce
	call objectGetRelativeTile		; $48d1
	ld h,d			; $48d4
	cp $fa			; $48d5
	jr z,_label_05_064	; $48d7
	cp $fb			; $48d9
	jr z,_label_05_064	; $48db
	cp $fc			; $48dd
	jr nz,_label_05_065	; $48df
_label_05_064:
	ld l,$1a		; $48e1
	res 6,(hl)		; $48e3
	ret			; $48e5
_label_05_065:
	ld l,$0f		; $48e6
	ld (hl),$00		; $48e8
_label_05_066:
	ld l,$1a		; $48ea
	set 6,(hl)		; $48ec
	ret			; $48ee
	call objectSetPriorityRelativeToLink_withTerrainEffects		; $48ef
	dec b			; $48f2
	and $c0			; $48f3
	or b			; $48f5
	ld (de),a		; $48f6
	ret			; $48f7
	ld e,$06		; $48f8
	ld a,(de)		; $48fa
	or a			; $48fb
	jr z,_label_05_067	; $48fc
	dec a			; $48fe
	ld (de),a		; $48ff
	ld a,$53		; $4900
	scf			; $4902
	ret nz			; $4903
	call playSound		; $4904
	xor a			; $4907
	scf			; $4908
	ret			; $4909
_label_05_067:
	call specialObjectAnimate		; $490a
	call objectApplySpeed		; $490d
	ld c,$40		; $4910
	call objectUpdateSpeedZ_paramC		; $4912
	or d			; $4915
	ret			; $4916
	ld h,d			; $4917
	ld l,$06		; $4918
	ld a,(hl)		; $491a
	or a			; $491b
	ret z			; $491c
	dec (hl)		; $491d
	ret			; $491e
	call specialObjectAnimate		; $491f
	ld e,$21		; $4922
	ld a,(de)		; $4924
	rlca			; $4925
	ret nc			; $4926
	call $46ab		; $4927
	scf			; $492a
	ret			; $492b
	call $47fd		; $492c
	ld l,$04		; $492f
	ld (hl),$0c		; $4931
	ld l,$03		; $4933
	inc (hl)		; $4935
	ld l,$07		; $4936
	jp objectSetVisiblec1		; $4938
	call $44aa		; $493b
	or a			; $493e
	ret nz			; $493f
	ld e,$07		; $4940
	ld a,(de)		; $4942
	dec a			; $4943
	ld (de),a		; $4944
	ret z			; $4945
	pop af			; $4946
	ret			; $4947
	ld a,($cc02)		; $4948
	push af			; $494b
	xor a			; $494c
	ld ($cc02),a		; $494d
	ld ($d02b),a		; $4950
	call $4552		; $4953
	pop af			; $4956
	ld ($cc02),a		; $4957
	ret			; $495a
	ld h,d			; $495b
	ld l,$06		; $495c
	ld a,(hl)		; $495e
	or a			; $495f
	ret			; $4960
	ld h,d			; $4961
	ld l,$0b		; $4962
	ldi a,(hl)		; $4964
	inc l			; $4965
	ld c,(hl)		; $4966
	add $05			; $4967
	ld b,a			; $4969
	ld a,$05		; $496a
	jp tryToBreakTile		; $496c
	ld e,$04		; $496f
	ld a,(de)		; $4971
	rst_jumpTable			; $4972
	sbc l			; $4973
	ld c,c			; $4974
	add l			; $4975
	ld d,h			; $4976
	call c,$944e		; $4977
	ld c,(hl)		; $497a
	ld d,a			; $497b
	ld c,(hl)		; $497c
	rst $38			; $497d
	ld d,c			; $497e
	ld a,e			; $497f
	ld d,d			; $4980
.DB $f4				; $4981
	dec hl			; $4982
	or h			; $4983
	ld c,l			; $4984
	call nz,$df4f		; $4985
	ld c,c			; $4988
	jr z,_label_05_069	; $4989
	add sp,$50		; $498b
	sbc d			; $498d
	ld d,c			; $498e
	rst $30			; $498f
	ld c,l			; $4990
	xor $52			; $4991
	xor c			; $4993
	ld d,e			; $4994
	rrca			; $4995
	ld d,h			; $4996
	ld a,(bc)		; $4997
	ld h,b			; $4998
	inc hl			; $4999
	ld d,c			; $499a
	ld a,e			; $499b
	ld d,c			; $499c
	call clearAllParentItems		; $499d
	call $41b5		; $49a0
	ld a,$10		; $49a3
	call specialObjectSetAnimation		; $49a5
	ld h,d			; $49a8
	ld l,$24		; $49a9
	ld a,$80		; $49ab
	ldi (hl),a		; $49ad
	inc l			; $49ae
	ld a,$06		; $49af
	ldi (hl),a		; $49b1
	ldi (hl),a		; $49b2
	ld l,$29		; $49b3
	ld (hl),$01		; $49b5
	ld a,($cc6a)		; $49b7
	cp $0a			; $49ba
	jr z,_label_05_068	; $49bc
	ld a,($cc71)		; $49be
	or a			; $49c1
	jr nz,_label_05_068	; $49c2
	call objectGetTileCollisions		; $49c4
	cp $0f			; $49c7
	jr nz,_label_05_068	; $49c9
	ld hl,$c638		; $49cb
	ldi a,(hl)		; $49ce
	ld e,$0b		; $49cf
	ld (de),a		; $49d1
	ld a,(hl)		; $49d2
	ld e,$0d		; $49d3
	ld (de),a		; $49d5
_label_05_068:
	call objectSetVisiblec1		; $49d6
_label_05_069:
	call $5468		; $49d9
	jp $5ba7		; $49dc
	ld a,($cc65)		; $49df
	and $0f			; $49e2
	rst_jumpTable			; $49e4
	dec b			; $49e5
	ld c,d			; $49e6
	ld (de),a		; $49e7
	ld c,d			; $49e8
	ld d,h			; $49e9
	ld c,d			; $49ea
	ld e,(hl)		; $49eb
	ld c,d			; $49ec
	ld hl,$324b		; $49ed
	ld c,e			; $49f0
	add e			; $49f1
	ld c,e			; $49f2
	sbc $4b			; $49f3
	ld d,l			; $49f5
	ld c,h			; $49f6
	ld b,c			; $49f7
	ld c,l			; $49f8
	ld ($6f4a),sp		; $49f9
	ld c,l			; $49fc
	dec h			; $49fd
	ld c,d			; $49fe
	ld ($0b4a),sp		; $49ff
	ld c,d			; $4a02
	xor (hl)		; $4a03
	ld c,l			; $4a04
_label_05_070:
	call $4a30		; $4a05
	jp $5ba7		; $4a08
	call objectCenterOnTile		; $4a0b
	ld a,(hl)		; $4a0e
	and $f0			; $4a0f
	ld (hl),a		; $4a11
	call $4a30		; $4a12
	ld a,($cc49)		; $4a15
	cp $06			; $4a18
	jr nc,_label_05_070	; $4a1a
	call setDeathRespawnPoint		; $4a1c
	call updateLinkLocalRespawnPosition		; $4a1f
	jp $5ba7		; $4a22
	ld a,($cc6b)		; $4a25
	and $03			; $4a28
	ld e,$08		; $4a2a
	ld (de),a		; $4a2c
	jp $5ba7		; $4a2d
	call objectGetTileAtPosition		; $4a30
	ld hl,$4a41		; $4a33
	call lookupCollisionTable		; $4a36
	jr c,_label_05_071	; $4a39
	ld a,$02		; $4a3b
_label_05_071:
	ld e,$08		; $4a3d
	ld (de),a		; $4a3f
	ret			; $4a40
	ld d,e			; $4a41
	ld c,d			; $4a42
	ld d,e			; $4a43
	ld c,d			; $4a44
	ld d,e			; $4a45
	ld c,d			; $4a46
	ld c,l			; $4a47
	ld c,d			; $4a48
	ld c,a			; $4a49
	ld c,d			; $4a4a
	ld c,a			; $4a4b
	ld c,d			; $4a4c
	ld (hl),$00		; $4a4d
	ld b,h			; $4a4f
	inc bc			; $4a50
	ld b,l			; $4a51
	ld bc,$3e00		; $4a52
	inc bc			; $4a55
	ld ($cc67),a		; $4a56
	ld a,$6e		; $4a59
	jp playSound		; $4a5b
	ld e,$05		; $4a5e
	ld a,(de)		; $4a60
	or a			; $4a61
	jr nz,_label_05_072	; $4a62
	ld h,d			; $4a64
	ld l,e			; $4a65
	inc (hl)		; $4a66
	ld l,$06		; $4a67
	ld (hl),$10		; $4a69
	ld a,($cc65)		; $4a6b
	and $40			; $4a6e
	swap a			; $4a70
	rrca			; $4a72
	ld bc,$4a91		; $4a73
	call addAToBc		; $4a76
	ld l,$08		; $4a79
	ld a,(bc)		; $4a7b
	ldi (hl),a		; $4a7c
	inc bc			; $4a7d
	ld a,(bc)		; $4a7e
	ld (hl),a		; $4a7f
	call $5bdf		; $4a80
	call $5bae		; $4a83
	ld a,($cc65)		; $4a86
	rlca			; $4a89
	jr c,_label_05_073	; $4a8a
	ld a,$6e		; $4a8c
	jp playSound		; $4a8e
	nop			; $4a91
	nop			; $4a92
	ld (bc),a		; $4a93
	stop			; $4a94
_label_05_072:
	ld a,($cd00)		; $4a95
	and $0a			; $4a98
	ret nz			; $4a9a
	ld a,$00		; $4a9b
	ld ($cd00),a		; $4a9d
	call specialObjectAnimate		; $4aa0
	call itemDecCounter1		; $4aa3
	jp nz,$5c88		; $4aa6
	ld a,$01		; $4aa9
	ld ($cd00),a		; $4aab
	xor a			; $4aae
	ld ($cc02),a		; $4aaf
	ld a,($cc65)		; $4ab2
	bit 7,a			; $4ab5
	jp nz,$4a15		; $4ab7
	swap a			; $4aba
	and $03			; $4abc
	ld ($cc67),a		; $4abe
	ret			; $4ac1
_label_05_073:
	ld h,d			; $4ac2
	ld a,($cc66)		; $4ac3
	cp $ff			; $4ac6
	jr z,_label_05_074	; $4ac8
	cp $f0			; $4aca
	jr nc,_label_05_075	; $4acc
	ld l,$0b		; $4ace
	call setShortPosition		; $4ad0
	ld l,$06		; $4ad3
	ld (hl),$1c		; $4ad5
	jp $5ba7		; $4ad7
_label_05_074:
	ld a,$01		; $4ada
	ld ($cc02),a		; $4adc
	ld l,$06		; $4adf
	ld (hl),$1c		; $4ae1
	ld a,($cc65)		; $4ae3
	and $40			; $4ae6
	swap a			; $4ae8
	ld b,a			; $4aea
	ld a,($cc49)		; $4aeb
	and $04			; $4aee
	rrca			; $4af0
	or b			; $4af1
	ld bc,$4b19		; $4af2
	call addAToBc		; $4af5
	ld l,$0b		; $4af8
	ld a,(bc)		; $4afa
	ldi (hl),a		; $4afb
	inc bc			; $4afc
	inc l			; $4afd
	ld a,(bc)		; $4afe
	ld (hl),a		; $4aff
	ret			; $4b00
_label_05_075:
	call $4ada		; $4b01
	ld a,($cc66)		; $4b04
	swap a			; $4b07
	and $f0			; $4b09
	ld b,a			; $4b0b
	ld a,($cc49)		; $4b0c
	and $04			; $4b0f
	jr z,_label_05_076	; $4b11
	rlca			; $4b13
_label_05_076:
	or b			; $4b14
	ld l,$0d		; $4b15
	ld (hl),a		; $4b17
	ret			; $4b18
	add b			; $4b19
	ld d,b			; $4b1a
	or b			; $4b1b
	ld a,b			; $4b1c
	ld a,($ff00+$50)	; $4b1d
	ld a,($ff00+$78)	; $4b1f
	ld a,($cc65)		; $4b21
	rlca			; $4b24
	jp c,$4a05		; $4b25
	ld a,$01		; $4b28
	ld ($cc67),a		; $4b2a
	ld a,$6e		; $4b2d
	jp playSound		; $4b2f
	ld e,$05		; $4b32
	ld a,(de)		; $4b34
	rst_jumpTable			; $4b35
	inc a			; $4b36
	ld c,e			; $4b37
	ld e,d			; $4b38
	ld c,e			; $4b39
	ld b,c			; $4b3a
	ld c,h			; $4b3b
	ld a,$01		; $4b3c
	ld (de),a		; $4b3e
	ld bc,$0020		; $4b3f
	call objectSetSpeedZ		; $4b42
	call objectGetZAboveScreen		; $4b45
	ld l,$0f		; $4b48
	ld (hl),a		; $4b4a
	ld l,$0b		; $4b4b
	ld a,(hl)		; $4b4d
	sub $04			; $4b4e
	ld (hl),a		; $4b50
	ld l,$08		; $4b51
	ld (hl),$02		; $4b53
	ld a,$04		; $4b55
	jp specialObjectSetAnimation		; $4b57
	call specialObjectAnimate		; $4b5a
	ld c,$20		; $4b5d
	call objectUpdateSpeedZ_paramC		; $4b5f
	ret nz			; $4b62
	call objectGetTileAtPosition		; $4b63
	cp $07			; $4b66
	jr z,_label_05_077	; $4b68
	ld hl,hazardCollisionTable		; $4b6a
	call lookupCollisionTable		; $4b6d
	jp nc,$4c2d		; $4b70
	jp $5ba7		; $4b73
_label_05_077:
	ld a,($cc49)		; $4b76
	and $06			; $4b79
	cp $04			; $4b7b
	jp nz,$4c2d		; $4b7d
	jp $50a5		; $4b80
	ld e,$05		; $4b83
	ld a,(de)		; $4b85
	rst_jumpTable			; $4b86
	adc e			; $4b87
	ld c,e			; $4b88
	or l			; $4b89
	ld c,e			; $4b8a
	ld a,$01		; $4b8b
	ld (de),a		; $4b8d
	ld a,($cc6b)		; $4b8e
	bit 7,a			; $4b91
	jr z,_label_05_078	; $4b93
	rrca			; $4b95
	and $0f			; $4b96
	ld ($cc6b),a		; $4b98
	ld a,$09		; $4b9b
	jp $5471		; $4b9d
_label_05_078:
	ld bc,$fd00		; $4ba0
	call objectSetSpeedZ		; $4ba3
	ld l,$06		; $4ba6
	ld (hl),$78		; $4ba8
	ld l,$0b		; $4baa
	ld a,(hl)		; $4bac
	sub $04			; $4bad
	ld (hl),a		; $4baf
	ld a,$04		; $4bb0
	call specialObjectSetAnimation		; $4bb2
	ld c,$18		; $4bb5
	call objectUpdateSpeedZ_paramC		; $4bb7
	jr z,_label_05_079	; $4bba
	call specialObjectAnimate		; $4bbc
	call $5d53		; $4bbf
	ld e,$10		; $4bc2
	ld a,$14		; $4bc4
	ld (de),a		; $4bc6
	ld a,($cc47)		; $4bc7
	ld e,$09		; $4bca
	ld (de),a		; $4bcc
	call updateLinkDirectionFromAngle		; $4bcd
	jp $5c88		; $4bd0
_label_05_079:
	call objectGetTileAtPosition		; $4bd3
	cp $07			; $4bd6
	jp z,$50a5		; $4bd8
	jp $5ba7		; $4bdb
	ld e,$05		; $4bde
	ld a,(de)		; $4be0
	rst_jumpTable			; $4be1
	ld ($0b4b),a		; $4be2
	ld c,h			; $4be5
	inc h			; $4be6
	ld c,h			; $4be7
	ld a,$4c		; $4be8
	ld a,$01		; $4bea
	ld (de),a		; $4bec
	ld h,d			; $4bed
	ld l,$08		; $4bee
	ld (hl),$02		; $4bf0
	inc l			; $4bf2
	ld (hl),$10		; $4bf3
	ld l,$10		; $4bf5
	ld (hl),$28		; $4bf7
	ld l,$1a		; $4bf9
	res 7,(hl)		; $4bfb
	ld l,$06		; $4bfd
	ld (hl),$78		; $4bff
	ld a,$04		; $4c01
	call specialObjectSetAnimation		; $4c03
	ld a,$65		; $4c06
	jp playSound		; $4c08
	call itemDecCounter1		; $4c0b
	ret nz			; $4c0e
	ld l,$05		; $4c0f
	inc (hl)		; $4c11
	ld l,$1a		; $4c12
	set 7,(hl)		; $4c14
	ld l,$06		; $4c16
	ld (hl),$30		; $4c18
	ld a,$10		; $4c1a
	call setScreenShakeCounter		; $4c1c
	ld a,$85		; $4c1f
	jp playSound		; $4c21
	call specialObjectAnimate		; $4c24
	call itemDecCounter1		; $4c27
	jp nz,$5c88		; $4c2a
	call itemIncState2		; $4c2d
	ld l,$06		; $4c30
	ld (hl),$1e		; $4c32
	ld a,$02		; $4c34
	call specialObjectSetAnimation		; $4c36
	ld a,$87		; $4c39
	jp playSound		; $4c3b
	call setDeathRespawnPoint		; $4c3e
	call itemDecCounter1		; $4c41
	ret nz			; $4c44
	jp $5ba7		; $4c45
	ld a,(wFrameCounter)		; $4c48
	rrca			; $4c4b
	ret nc			; $4c4c
	ld e,$08		; $4c4d
	ld a,(de)		; $4c4f
	inc a			; $4c50
	and $03			; $4c51
	ld (de),a		; $4c53
	ret			; $4c54
	ld e,$05		; $4c55
	ld a,(de)		; $4c57
	rst_jumpTable			; $4c58
	ld l,c			; $4c59
	ld c,h			; $4c5a
	sub e			; $4c5b
	ld c,h			; $4c5c
	or d			; $4c5d
	ld c,h			; $4c5e
	call z,$da4c		; $4c5f
	ld c,h			; $4c62
.DB $eb				; $4c63
	ld c,h			; $4c64
	ld a,($144c)		; $4c65
	ld c,l			; $4c68
	ld a,$01		; $4c69
	ld (de),a		; $4c6b
	ld a,$ff		; $4c6c
	ld ($cca4),a		; $4c6e
	ld a,$80		; $4c71
	ld ($cc02),a		; $4c73
	ld a,$15		; $4c76
	ld ($cc04),a		; $4c78
	ld bc,$ff60		; $4c7b
	call objectSetSpeedZ		; $4c7e
	ld l,$06		; $4c81
	ld (hl),$30		; $4c83
	call $4df1		; $4c85
	call restartSound		; $4c88
	ld a,$b4		; $4c8b
	call playSound		; $4c8d
	jp objectCenterOnTile		; $4c90
	ld c,$02		; $4c93
	call objectUpdateSpeedZ_paramC		; $4c95
	ld a,(wFrameCounter)		; $4c98
	and $03			; $4c9b
	jr nz,_label_05_080	; $4c9d
	ld hl,$cbbc		; $4c9f
	inc (hl)		; $4ca2
_label_05_080:
	ld a,(wFrameCounter)		; $4ca3
	and $03			; $4ca6
	call z,$4c4d		; $4ca8
	call itemDecCounter1		; $4cab
	ret nz			; $4cae
	jp itemIncState2		; $4caf
	ld c,$02		; $4cb2
	call objectUpdateSpeedZ_paramC		; $4cb4
	call $4c48		; $4cb7
	ld h,d			; $4cba
	ld l,$15		; $4cbb
	bit 7,(hl)		; $4cbd
	ret nz			; $4cbf
	ld l,$06		; $4cc0
	ld (hl),$28		; $4cc2
	ld a,$02		; $4cc4
	call fadeoutToWhiteWithDelay		; $4cc6
	jp itemIncState2		; $4cc9
	call $4c48		; $4ccc
	call itemDecCounter1		; $4ccf
	ret nz			; $4cd2
	ld hl,$cbb3		; $4cd3
	inc (hl)		; $4cd6
	jp itemIncState2		; $4cd7
	call $4c48		; $4cda
	ld a,($cc03)		; $4cdd
	cp $02			; $4ce0
	ret nz			; $4ce2
	call itemIncState2		; $4ce3
	ld l,$06		; $4ce6
	ld (hl),$28		; $4ce8
	ret			; $4cea
	ld c,$02		; $4ceb
	call objectUpdateSpeedZ_paramC		; $4ced
	call $4c48		; $4cf0
	call itemDecCounter1		; $4cf3
	ret nz			; $4cf6
	jp itemIncState2		; $4cf7
	ld c,$02		; $4cfa
	call objectUpdateSpeedZ_paramC		; $4cfc
	ld a,(wFrameCounter)		; $4cff
	and $03			; $4d02
	ret nz			; $4d04
	call $4c4d		; $4d05
	ld hl,$cbbc		; $4d08
	dec (hl)		; $4d0b
	ret nz			; $4d0c
	ld hl,$cbb3		; $4d0d
	inc (hl)		; $4d10
	jp itemIncState2		; $4d11
	ld a,($cca4)		; $4d14
	and $81			; $4d17
	jr z,_label_05_081	; $4d19
	ld a,(wFrameCounter)		; $4d1b
	and $07			; $4d1e
	ret nz			; $4d20
	jp $4c4d		; $4d21
_label_05_081:
	ld e,$08		; $4d24
	ld a,(de)		; $4d26
	cp $02			; $4d27
	jp nz,$4c4d		; $4d29
	ld a,($cc62)		; $4d2c
	ld (wActiveMusic),a		; $4d2f
	call playSound		; $4d32
	call setDeathRespawnPoint		; $4d35
	call updateLinkLocalRespawnPosition		; $4d38
	call resetLinkInvincibility		; $4d3b
	jp $5ba7		; $4d3e
	ld e,$05		; $4d41
	ld a,(de)		; $4d43
	rst_jumpTable			; $4d44
	ld c,c			; $4d45
	ld c,l			; $4d46
	ld h,d			; $4d47
	ld c,l			; $4d48
	call itemIncState2		; $4d49
	ld l,$0b		; $4d4c
	ld a,$08		; $4d4e
	add (hl)		; $4d50
	ld (hl),a		; $4d51
	call objectCenterOnTile		; $4d52
	call clearAllParentItems		; $4d55
	ld a,$0d		; $4d58
	call specialObjectSetAnimation		; $4d5a
	ld a,$65		; $4d5d
	jp playSound		; $4d5f
	ld e,$21		; $4d62
	ld a,(de)		; $4d64
	inc a			; $4d65
	jp nz,specialObjectAnimate		; $4d66
	ld a,$03		; $4d69
	ld ($cc67),a		; $4d6b
	ret			; $4d6e
	ld e,$05		; $4d6f
	ld a,(de)		; $4d71
	rst_jumpTable			; $4d72
	ld a,c			; $4d73
	ld c,l			; $4d74
	adc e			; $4d75
	ld c,l			; $4d76
	and d			; $4d77
	ld c,l			; $4d78
	call itemIncState2		; $4d79
	call objectGetZAboveScreen		; $4d7c
	ld l,$0f		; $4d7f
	ld (hl),a		; $4d81
	ld l,$08		; $4d82
	ld (hl),$02		; $4d84
	ld a,$04		; $4d86
	jp specialObjectSetAnimation		; $4d88
	call specialObjectAnimate		; $4d8b
	ld c,$0c		; $4d8e
	call objectUpdateSpeedZ_paramC		; $4d90
	ret nz			; $4d93
	xor a			; $4d94
	ld ($cca4),a		; $4d95
	ld a,$08		; $4d98
	call setLinkIDOverride		; $4d9a
	ld l,$02		; $4d9d
	ld (hl),$02		; $4d9f
	ret			; $4da1
	ld a,($cca4)		; $4da2
	and $81			; $4da5
	ret nz			; $4da7
	call objectSetVisiblec2		; $4da8
	jp $5ba7		; $4dab
	call $5468		; $4dae
	jp objectSetInvisible		; $4db1
	ld e,$05		; $4db4
	ld a,(de)		; $4db6
	rst_jumpTable			; $4db7
	cp h			; $4db8
	ld c,l			; $4db9
	rst $8			; $4dba
	ld c,l			; $4dbb
	ld a,$01		; $4dbc
	ld (de),a		; $4dbe
	ld hl,$cc6b		; $4dbf
	ld a,(hl)		; $4dc2
	ld (hl),$00		; $4dc3
	or a			; $4dc5
	ret nz			; $4dc6
	call $4ded		; $4dc7
	ld a,$10		; $4dca
	jp specialObjectSetAnimation		; $4dcc
	call $5468		; $4dcf
	ld hl,$cc6b		; $4dd2
	ld a,(hl)		; $4dd5
	or a			; $4dd6
	jr z,_label_05_082	; $4dd7
	ld (hl),$00		; $4dd9
	call specialObjectSetAnimation		; $4ddb
_label_05_082:
	ld a,($cc7e)		; $4dde
	or a			; $4de1
	call nz,checkUseItems		; $4de2
	ld a,($cca4)		; $4de5
	or a			; $4de8
	ret nz			; $4de9
	jp $5ba7		; $4dea
	ld e,$33		; $4ded
	xor a			; $4def
	ld (de),a		; $4df0
	call dropLinkHeldItem		; $4df1
	jp clearAllParentItems		; $4df4
	ld e,$05		; $4df7
	ld a,(de)		; $4df9
	rst_jumpTable			; $4dfa
	ld bc,$0a4e		; $4dfb
	ld c,(hl)		; $4dfe
	inc d			; $4dff
	ld c,(hl)		; $4e00
	call itemIncState2		; $4e01
	ld e,$37		; $4e04
	ld a,($cc4c)		; $4e06
	ld (de),a		; $4e09
	call objectCheckWithinScreenBoundary		; $4e0a
	ret c			; $4e0d
	call itemIncState2		; $4e0e
	call objectSetInvisible		; $4e11
	ld h,d			; $4e14
	ld l,$37		; $4e15
	ld a,($cc4c)		; $4e17
	cp (hl)			; $4e1a
	ret nz			; $4e1b
	call objectCheckWithinScreenBoundary		; $4e1c
	ret nc			; $4e1f
	ld e,$05		; $4e20
	ld a,$01		; $4e22
	ld (de),a		; $4e24
	jp objectSetVisiblec2		; $4e25
	ld e,$05		; $4e28
	ld a,(de)		; $4e2a
	rst_jumpTable			; $4e2b
	jr nc,_label_05_083	; $4e2c
	ld b,a			; $4e2e
	ld c,(hl)		; $4e2f
	ld a,$01		; $4e30
	ld (de),a		; $4e32
	ld e,$06		; $4e33
	ld a,($cc6c)		; $4e35
	ld (de),a		; $4e38
	call clearPegasusSeedCounter		; $4e39
	call $4ded		; $4e3c
	call $5bdf		; $4e3f
	ld a,$10		; $4e42
	call specialObjectSetAnimation		; $4e44
	call specialObjectAnimate		; $4e47
	call itemDecCounter1		; $4e4a
	ld l,$33		; $4e4d
	ld (hl),$00		; $4e4f
	jp nz,$5c88		; $4e51
	jp $5ba7		; $4e54
	ld e,$05		; $4e57
	ld a,(de)		; $4e59
	rst_jumpTable			; $4e5a
	ld e,a			; $4e5b
	ld c,(hl)		; $4e5c
	ld (hl),l		; $4e5d
	ld c,(hl)		; $4e5e
	ld a,$01		; $4e5f
	ld (de),a		; $4e61
	call $4df1		; $4e62
	ld e,$30		; $4e65
	ld a,(de)		; $4e67
	ld ($cc6d),a		; $4e68
	ld a,($cc6b)		; $4e6b
	and $0f			; $4e6e
	add $0e			; $4e70
	jp specialObjectSetAnimation		; $4e72
	call retIfTextIsActive		; $4e75
	ld a,($cc6b)		; $4e78
	rlca			; $4e7b
_label_05_083:
	jr c,_label_05_084	; $4e7c
	ld a,($cca4)		; $4e7e
	and $81			; $4e81
	ret nz			; $4e83
_label_05_084:
	ld e,$04		; $4e84
	ld a,$01		; $4e86
	ld (de),a		; $4e88
	ld a,($cc6d)		; $4e89
	jp specialObjectSetAnimation		; $4e8c
	ld a,$03		; $4e8f
	call $5471		; $4e91
	xor a			; $4e94
	ld ($c6a2),a		; $4e95
	ld e,$05		; $4e98
	ld a,(de)		; $4e9a
	rst_jumpTable			; $4e9b
	and b			; $4e9c
	ld c,(hl)		; $4e9d
	cp a			; $4e9e
	ld c,(hl)		; $4e9f
	call $5d53		; $4ea0
	ld e,$2d		; $4ea3
	ld a,(de)		; $4ea5
	or a			; $4ea6
	jp nz,$5c4c		; $4ea7
	ld h,d			; $4eaa
	ld l,$05		; $4eab
	inc (hl)		; $4ead
	ld l,$06		; $4eae
	ld (hl),$04		; $4eb0
	call $4df1		; $4eb2
	ld a,$01		; $4eb5
	call specialObjectSetAnimation		; $4eb7
	ld a,$64		; $4eba
	jp playSound		; $4ebc
	call resetLinkInvincibility		; $4ebf
	call specialObjectAnimate		; $4ec2
	ld h,d			; $4ec5
	ld l,$21		; $4ec6
	ld a,(hl)		; $4ec8
	add a			; $4ec9
	jr nz,_label_05_085	; $4eca
	ret nc			; $4ecc
	ld l,$06		; $4ecd
	dec (hl)		; $4ecf
	ret nz			; $4ed0
	ld a,$02		; $4ed1
	jp specialObjectSetAnimation		; $4ed3
_label_05_085:
	ld a,$ff		; $4ed6
	ld ($cc35),a		; $4ed8
	ret			; $4edb
	ld a,$ff		; $4edc
	ld ($cc45),a		; $4ede
	ld a,$80		; $4ee1
	ld ($cc81),a		; $4ee3
	ld e,$05		; $4ee6
	ld a,(de)		; $4ee8
	rst_jumpTable			; $4ee9
	or $4e			; $4eea
	dec l			; $4eec
	ld c,a			; $4eed
	ld h,a			; $4eee
	ld c,a			; $4eef
	and d			; $4ef0
	ld c,a			; $4ef1
	xor l			; $4ef2
	ld c,a			; $4ef3
	cp e			; $4ef4
	ld c,a			; $4ef5
	call $4df1		; $4ef6
	ld a,($cc6c)		; $4ef9
	rst_jumpTable			; $4efc
	ld de,$144f		; $4efd
	ld c,a			; $4f00
	ld d,c			; $4f01
	ld c,a			; $4f02
	add hl,de		; $4f03
	ld c,a			; $4f04
	rlca			; $4f05
	ld c,a			; $4f06
	ld e,$05		; $4f07
	ld a,$05		; $4f09
	ld (de),a		; $4f0b
	ld a,$0a		; $4f0c
	jp specialObjectSetAnimation		; $4f0e
	call objectCenterOnTile		; $4f11
	call itemIncState2		; $4f14
	jr _label_05_086		; $4f17
	ld e,$05		; $4f19
	ld a,$04		; $4f1b
	ld (de),a		; $4f1d
_label_05_086:
	ld h,d			; $4f1e
	ld l,$24		; $4f1f
	res 7,(hl)		; $4f21
	ld a,$0d		; $4f23
	call specialObjectSetAnimation		; $4f25
	ld a,$65		; $4f28
	jp playSound		; $4f2a
	ld h,d			; $4f2d
	ld l,$21		; $4f2e
	bit 7,(hl)		; $4f30
	jp z,specialObjectAnimate		; $4f32
	ld a,($ccb6)		; $4f35
	cp $02			; $4f38
	jr nz,_label_05_088	; $4f3a
	ld a,($cc55)		; $4f3c
	cp $09			; $4f3f
	jr nz,_label_05_087	; $4f41
	ld a,$13		; $4f43
	ld ($cc04),a		; $4f45
	ret			; $4f48
_label_05_087:
	ld hl,$4a6d		; $4f49
	ld e,$01		; $4f4c
	jp interBankCall		; $4f4e
_label_05_088:
	call specialObjectSetCoordinatesToRespawnYX		; $4f51
	ld l,$05		; $4f54
	ld a,$02		; $4f56
	ldi (hl),a		; $4f58
	ld (hl),a		; $4f59
	call $4961		; $4f5a
	call objectGetTileAtPosition		; $4f5d
	ld a,l			; $4f60
	ld ($cca8),a		; $4f61
	jp objectSetInvisible		; $4f64
	ld h,d			; $4f67
	ld l,$06		; $4f68
	ld a,($cd00)		; $4f6a
	and $80			; $4f6d
	jr z,_label_05_089	; $4f6f
	ld (hl),$04		; $4f71
	ret			; $4f73
_label_05_089:
	dec (hl)		; $4f74
	ret nz			; $4f75
	xor a			; $4f76
	ld ($cc77),a		; $4f77
	ld ($cc78),a		; $4f7a
	ld a,$1c		; $4f7d
	call cpActiveRing		; $4f7f
	ld a,$fc		; $4f82
	jr nz,_label_05_090	; $4f84
	sra a			; $4f86
_label_05_090:
	call itemIncState2		; $4f88
	ld l,$25		; $4f8b
	ld (hl),a		; $4f8d
	ld l,$2b		; $4f8e
	ld (hl),$3c		; $4f90
	ld l,$06		; $4f92
	ld (hl),$10		; $4f94
	call linkApplyDamage		; $4f96
	call objectSetVisiblec1		; $4f99
	call $5d53		; $4f9c
	jp $5bae		; $4f9f
	call itemDecCounter1		; $4fa2
	ret nz			; $4fa5
	ld l,$24		; $4fa6
	set 7,(hl)		; $4fa8
	jp $5ba7		; $4faa
	ld h,d			; $4fad
	ld l,$21		; $4fae
	bit 7,(hl)		; $4fb0
	jp z,specialObjectAnimate		; $4fb2
	call objectSetInvisible		; $4fb5
	jp $5468		; $4fb8
	ld e,$21		; $4fbb
	ld a,(de)		; $4fbd
	rlca			; $4fbe
	jp nc,specialObjectAnimate		; $4fbf
	jr _label_05_088		; $4fc2
	call retIfTextIsActive		; $4fc4
	ld e,$05		; $4fc7
	ld a,(de)		; $4fc9
	rst_jumpTable			; $4fca
	reti			; $4fcb
	ld c,a			; $4fcc
	rst $38			; $4fcd
	ld c,a			; $4fce
	add hl,hl		; $4fcf
	ld d,b			; $4fd0
	ld h,d			; $4fd1
	ld d,b			; $4fd2
	ld l,(hl)		; $4fd3
	ld d,b			; $4fd4
	add a			; $4fd5
	ld d,b			; $4fd6
	sub d			; $4fd7
	ld d,b			; $4fd8
	call clearAllParentItems		; $4fd9
	xor a			; $4fdc
	ld ($cd00),a		; $4fdd
	ld ($cc89),a		; $4fe0
	ld bc,$fc00		; $4fe3
	call objectSetSpeedZ		; $4fe6
	ld l,$06		; $4fe9
	ld (hl),$0a		; $4feb
	ld a,($cc6b)		; $4fed
	rrca			; $4ff0
	ld a,$01		; $4ff1
	jr nc,_label_05_091	; $4ff3
	inc a			; $4ff5
_label_05_091:
	ld l,$05		; $4ff6
	ld (hl),a		; $4ff8
	ld a,$81		; $4ff9
	ld ($cc77),a		; $4ffb
	ret			; $4ffe
	call $5043		; $4fff
	ret c			; $5002
	ld a,($cc57)		; $5003
	inc a			; $5006
	ld ($cc57),a		; $5007
	call getActiveRoomFromDungeonMapPosition		; $500a
	ld ($cc64),a		; $500d
	call objectGetShortPosition		; $5010
	ld ($cc66),a		; $5013
	ld a,($cc49)		; $5016
	or $80			; $5019
	ld ($cc63),a		; $501b
	ld a,$06		; $501e
	ld ($cc65),a		; $5020
	ld a,$03		; $5023
	ld ($cc67),a		; $5025
	ret			; $5028
	call $5043		; $5029
	ret c			; $502c
	ld a,$01		; $502d
	ld ($cd00),a		; $502f
	ld l,$05		; $5032
	inc (hl)		; $5034
	ld l,$06		; $5035
	ld (hl),$1e		; $5037
	ld a,$08		; $5039
	call setScreenShakeCounter		; $503b
	ld a,$02		; $503e
	jp specialObjectSetAnimation		; $5040
	ld c,$0c		; $5043
	call objectUpdateSpeedZ_paramC		; $5045
	call specialObjectAnimate		; $5048
	ld h,d			; $504b
	ld l,$06		; $504c
	ld a,(hl)		; $504e
	or a			; $504f
	jr z,_label_05_092	; $5050
	dec (hl)		; $5052
	jr nz,_label_05_092	; $5053
	ld a,$04		; $5055
	call specialObjectSetAnimation		; $5057
_label_05_092:
	call objectGetZAboveScreen		; $505a
	ld h,d			; $505d
	ld l,$0f		; $505e
	cp (hl)			; $5060
	ret			; $5061
	call itemDecCounter1		; $5062
	ret nz			; $5065
	dec l			; $5066
	inc (hl)		; $5067
	ld bc,$ff00		; $5068
	jp objectSetSpeedZ		; $506b
	ld c,$20		; $506e
	call objectUpdateSpeedZ_paramC		; $5070
	ret nz			; $5073
	call objectGetTileAtPosition		; $5074
	cp $07			; $5077
	jr z,_label_05_094	; $5079
	ld h,d			; $507b
	ld l,$05		; $507c
	inc (hl)		; $507e
	inc l			; $507f
	ld (hl),$1e		; $5080
	ld a,$02		; $5082
	call specialObjectSetAnimation		; $5084
	call itemDecCounter1		; $5087
	ret nz			; $508a
_label_05_093:
	xor a			; $508b
	ld ($cc77),a		; $508c
	jp $5ba7		; $508f
	call specialObjectAnimate		; $5092
	call $5d53		; $5095
	ld c,$20		; $5098
	call objectUpdateSpeedZ_paramC		; $509a
	jp nz,$5c88		; $509d
	call updateLinkLocalRespawnPosition		; $50a0
	jr _label_05_093		; $50a3
_label_05_094:
	call objectGetShortPosition		; $50a5
	ld c,a			; $50a8
	ld b,$02		; $50a9
_label_05_095:
	ld a,b			; $50ab
	ld hl,$50e4		; $50ac
	rst_addAToHl			; $50af
	ld a,c			; $50b0
	add (hl)		; $50b1
	ld h,$ce		; $50b2
	ld l,a			; $50b4
	ld a,(hl)		; $50b5
	or a			; $50b6
	jr z,_label_05_096	; $50b7
	ld a,b			; $50b9
	inc a			; $50ba
	and $03			; $50bb
	ld b,a			; $50bd
	jr _label_05_095		; $50be
_label_05_096:
	ld h,d			; $50c0
	ld l,$08		; $50c1
	ld (hl),b		; $50c3
	ld a,b			; $50c4
	swap a			; $50c5
	rrca			; $50c7
	inc l			; $50c8
	ld (hl),a		; $50c9
	ld l,$0f		; $50ca
	ld (hl),$ff		; $50cc
	ld bc,$fd00		; $50ce
	call objectSetSpeedZ		; $50d1
	ld l,$10		; $50d4
	ld (hl),$14		; $50d6
	ld l,$04		; $50d8
	ld (hl),$09		; $50da
	inc l			; $50dc
	ld (hl),$06		; $50dd
	ld a,$04		; $50df
	jp specialObjectSetAnimation		; $50e1
	ld a,($ff00+$01)	; $50e4
	stop			; $50e6
	rst $38			; $50e7
	ld e,$05		; $50e8
	ld a,(de)		; $50ea
	rst_jumpTable			; $50eb
	ld a,($ff00+c)		; $50ec
	ld d,b			; $50ed
	ldi (hl),a		; $50ee
	ld d,c			; $50ef
	add hl,bc		; $50f0
	ld d,c			; $50f1
	ld a,$01		; $50f2
	ld (de),a		; $50f4
	ld ($cc88),a		; $50f5
	xor a			; $50f8
	ld e,$24		; $50f9
	ld (de),a		; $50fb
	ld a,$00		; $50fc
	ld ($cd00),a		; $50fe
	call $4df1		; $5101
	ld a,$67		; $5104
	jp playSound		; $5106
	xor a			; $5109
	ld ($cc88),a		; $510a
	ld hl,$cc63		; $510d
	ld a,($cc49)		; $5110
	or $80			; $5113
	ldi (hl),a		; $5115
	ld a,($cc5a)		; $5116
	ldi (hl),a		; $5119
	ld a,$05		; $511a
	ldi (hl),a		; $511c
	ld a,$87		; $511d
	ldi (hl),a		; $511f
	ld (hl),$03		; $5120
	ret			; $5122
	ld a,$80		; $5123
	ld ($cc81),a		; $5125
	ld e,$05		; $5128
	ld a,(de)		; $512a
	rst_jumpTable			; $512b
	jr nc,_label_05_100	; $512c
	ld b,(hl)		; $512e
	ld d,c			; $512f
	call itemIncState2		; $5130
	inc l			; $5133
	ld (hl),$b4		; $5134
	ld l,$1b		; $5136
	ld a,$0f		; $5138
	ldi (hl),a		; $513a
	ld (hl),a		; $513b
	ld a,$7f		; $513c
	call loadPaletteHeader		; $513e
	xor a			; $5141
	ld ($cc6b),a		; $5142
	ret			; $5145
	ld c,$40		; $5146
	call objectUpdateSpeedZ_paramC		; $5148
	ld a,($cc6b)		; $514b
	or a			; $514e
	jr z,_label_05_097	; $514f
	call updateLinkDirectionFromAngle		; $5151
	ld l,$2a		; $5154
	ld a,(hl)		; $5156
	or a			; $5157
	jr nz,_label_05_099	; $5158
_label_05_097:
	ld c,$01		; $515a
	ld a,($cc46)		; $515c
	or a			; $515f
	jr z,_label_05_098	; $5160
	ld c,$04		; $5162
_label_05_098:
	ld l,$06		; $5164
	ld a,(hl)		; $5166
	sub c			; $5167
	ld (hl),a		; $5168
	ret nc			; $5169
_label_05_099:
	ld l,$1b		; $516a
	ld a,$08		; $516c
	ldi (hl),a		; $516e
	ld (hl),a		; $516f
	ld l,$2d		; $5170
	ld (hl),$00		; $5172
	xor a			; $5174
	ld ($cc6a),a		; $5175
	jp $5ba7		; $5178
	ld e,$05		; $517b
	ld a,(de)		; $517d
	rst_jumpTable			; $517e
_label_05_100:
	add e			; $517f
	ld d,c			; $5180
	ld b,(hl)		; $5181
	ld d,c			; $5182
	call itemIncState2		; $5183
	ld l,$06		; $5186
	ld (hl),$f0		; $5188
	call $4df1		; $518a
	ld a,($cc6b)		; $518d
	or a			; $5190
	ld a,$02		; $5191
	jr z,_label_05_101	; $5193
	ld a,$10		; $5195
_label_05_101:
	jp specialObjectSetAnimation		; $5197
	ld a,$80		; $519a
	ld ($ccac),a		; $519c
	ld e,$05		; $519f
	ld a,(de)		; $51a1
	rst_jumpTable			; $51a2
	xor l			; $51a3
	ld d,c			; $51a4
	ld h,$42		; $51a5
	cp d			; $51a7
	ld d,c			; $51a8
	ld ($ff00+$51),a	; $51a9
	di			; $51ab
	ld d,c			; $51ac
	ld a,$01		; $51ad
	ld (de),a		; $51af
	ld ($cc88),a		; $51b0
	ld e,$30		; $51b3
	xor a			; $51b5
	ld (de),a		; $51b6
	jp $4df1		; $51b7
	ld a,$03		; $51ba
	ld (de),a		; $51bc
	ld h,d			; $51bd
	ld l,$06		; $51be
	ld (hl),$1e		; $51c0
	ld a,$e8		; $51c2
	ld l,$0f		; $51c4
	ld (hl),a		; $51c6
	ld l,$0b		; $51c7
	cpl			; $51c9
	inc a			; $51ca
	add (hl)		; $51cb
	ld (hl),a		; $51cc
	xor a			; $51cd
	ld l,$14		; $51ce
	ldi (hl),a		; $51d0
	ldi (hl),a		; $51d1
	ld l,$08		; $51d2
	ldi (hl),a		; $51d4
	ld (hl),$0c		; $51d5
	ld l,$10		; $51d7
	ld (hl),$3c		; $51d9
	ld a,$03		; $51db
	jp specialObjectSetAnimation		; $51dd
	call itemDecCounter1		; $51e0
	jr z,_label_05_102	; $51e3
	ld c,$20		; $51e5
	call objectUpdateSpeedZ_paramC		; $51e7
	call $5d53		; $51ea
	call $5c88		; $51ed
	jp specialObjectAnimate		; $51f0
	ld h,d			; $51f3
	ld l,$2b		; $51f4
	ld (hl),$94		; $51f6
_label_05_102:
	xor a			; $51f8
	ld ($cc88),a		; $51f9
	jp $5ba7		; $51fc
	ld e,$05		; $51ff
	ld a,(de)		; $5201
	rst_jumpTable			; $5202
	add hl,bc		; $5203
	ld d,d			; $5204
	daa			; $5205
	ld d,d			; $5206
	inc a			; $5207
	ld d,d			; $5208
	call itemIncState2		; $5209
	ld l,$10		; $520c
	ld (hl),$14		; $520e
	ld l,$13		; $5210
	ld a,$02		; $5212
	call $5f42		; $5214
	ld bc,$fe80		; $5217
	call objectSetSpeedZ		; $521a
	ld a,$81		; $521d
	ld ($cc77),a		; $521f
	ld a,$2f		; $5222
	jp specialObjectSetAnimation		; $5224
	call specialObjectAnimate		; $5227
	call $5f48		; $522a
	call objectApplySpeed		; $522d
	ld c,$20		; $5230
	call objectUpdateSpeedZ_paramC		; $5232
	ret nz			; $5235
	call itemIncState2		; $5236
	jp $5f6b		; $5239
	call specialObjectAnimate		; $523c
	ld h,d			; $523f
	ld l,$21		; $5240
	ld a,(hl)		; $5242
	ld (hl),$00		; $5243
	rst_jumpTable			; $5245
	ld e,(hl)		; $5246
	ld d,d			; $5247
	ld d,b			; $5248
	ld d,d			; $5249
	ld e,c			; $524a
	ld d,d			; $524b
	ld e,a			; $524c
	ld d,d			; $524d
	ld h,d			; $524e
	ld d,d			; $524f
	call darkenRoomLightly		; $5250
	ld a,$06		; $5253
	ld ($c4ad),a		; $5255
	ret			; $5258
	ld hl,$c6a3		; $5259
	ldd a,(hl)		; $525c
	ld (hl),a		; $525d
	ret			; $525e
	jp brightenRoom		; $525f
	ld bc,$fe80		; $5262
	call objectSetSpeedZ		; $5265
	ld l,$08		; $5268
	ld (hl),$01		; $526a
	inc l			; $526c
	ld (hl),$08		; $526d
	ld l,$10		; $526f
	ld (hl),$14		; $5271
	ld a,$81		; $5273
	ld ($cc77),a		; $5275
	jp $5ba7		; $5278
	ld e,$05		; $527b
	ld a,(de)		; $527d
	rst_jumpTable			; $527e
	add a			; $527f
	ld d,d			; $5280
	and c			; $5281
	ld d,d			; $5282
	or h			; $5283
	ld d,d			; $5284
	push de			; $5285
	ld d,d			; $5286
	ld a,$01		; $5287
	ld (de),a		; $5289
	ld h,d			; $528a
	ld l,$06		; $528b
	ld (hl),$08		; $528d
	ld l,$10		; $528f
	ld (hl),$50		; $5291
	ld l,$09		; $5293
	ld (hl),$00		; $5295
	ld a,$81		; $5297
	ld ($cc77),a		; $5299
	ld a,$53		; $529c
	call playSound		; $529e
	call $5c7f		; $52a1
	call itemDecCounter1		; $52a4
	ret nz			; $52a7
	ld l,$05		; $52a8
	inc (hl)		; $52aa
	ld l,$08		; $52ab
	ld (hl),$00		; $52ad
	ld a,$04		; $52af
	call specialObjectSetAnimation		; $52b1
	call specialObjectAnimate		; $52b4
	ld a,($cd00)		; $52b7
	and $01			; $52ba
	ret z			; $52bc
	call objectCheckTileCollision_allowHoles		; $52bd
	jp c,$5c7f		; $52c0
	ld bc,$fe00		; $52c3
	call objectSetSpeedZ		; $52c6
	ld l,$05		; $52c9
	inc (hl)		; $52cb
	ld l,$10		; $52cc
	ld (hl),$0a		; $52ce
	ld a,$18		; $52d0
	call specialObjectSetAnimation		; $52d2
	call specialObjectAnimate		; $52d5
	call $5d53		; $52d8
	call $5c88		; $52db
	ld c,$18		; $52de
	call objectUpdateSpeedZ_paramC		; $52e0
	ret nz			; $52e3
	xor a			; $52e4
	ld ($cc77),a		; $52e5
	ld ($cc88),a		; $52e8
	jp $5ba7		; $52eb
	ld e,$05		; $52ee
	ld a,(de)		; $52f0
	rst_jumpTable			; $52f1
	cp $52			; $52f2
	ld d,$53		; $52f4
	add hl,hl		; $52f6
	ld d,e			; $52f7
	ld b,h			; $52f8
	ld d,e			; $52f9
	add a			; $52fa
	ld d,e			; $52fb
	sbc c			; $52fc
	ld d,e			; $52fd
	ld h,d			; $52fe
	ld l,e			; $52ff
	inc (hl)		; $5300
	inc l			; $5301
	ld (hl),$10		; $5302
	xor a			; $5304
	ld l,$08		; $5305
	ldi (hl),a		; $5307
	ld (hl),a		; $5308
	call $4ded		; $5309
	ld a,$01		; $530c
	ld ($cbca),a		; $530e
	ld a,$10		; $5311
	call specialObjectSetAnimation		; $5313
	call itemDecCounter1		; $5316
	jr nz,_label_05_103	; $5319
	ld (hl),$5a		; $531b
	dec l			; $531d
	inc (hl)		; $531e
	ld l,$10		; $531f
	ld (hl),$14		; $5321
_label_05_103:
	call specialObjectAnimate		; $5323
	jp $5c7f		; $5326
	ld h,d			; $5329
	ld l,$06		; $532a
	ld a,(hl)		; $532c
	or a			; $532d
	jr z,_label_05_104	; $532e
	dec (hl)		; $5330
	ret			; $5331
_label_05_104:
	ld h,d			; $5332
	ld l,$0b		; $5333
	ld a,(hl)		; $5335
	cp $74			; $5336
	jr nc,_label_05_103	; $5338
	ld l,$05		; $533a
	inc (hl)		; $533c
	inc l			; $533d
	ld (hl),$60		; $533e
	ld l,$10		; $5340
	ld (hl),$28		; $5342
	call itemDecCounter1		; $5344
	jr z,_label_05_106	; $5347
	ld a,(hl)		; $5349
	sub $19			; $534a
	jr c,_label_05_105	; $534c
	cp $32			; $534e
	ret nc			; $5350
	and $0f			; $5351
	ret nz			; $5353
	ld a,(hl)		; $5354
	swap a			; $5355
	and $01			; $5357
	add a			; $5359
	inc a			; $535a
	ld l,$08		; $535b
	ld (hl),a		; $535d
	ret			; $535e
_label_05_105:
	inc a			; $535f
	ret nz			; $5360
	ld l,$08		; $5361
	ld (hl),$00		; $5363
	inc l			; $5365
	ld (hl),$10		; $5366
	ld a,$18		; $5368
	ld bc,$f4f8		; $536a
	call objectCreateExclamationMark		; $536d
	ld a,$50		; $5370
	jp playSound		; $5372
_label_05_106:
	ld l,e			; $5375
	inc (hl)		; $5376
	ld bc,$fe80		; $5377
	call objectSetSpeedZ		; $537a
	ld a,$18		; $537d
	call specialObjectSetAnimation		; $537f
	ld a,$53		; $5382
	call playSound		; $5384
	ld c,$18		; $5387
	call objectUpdateSpeedZ_paramC		; $5389
	jr nz,_label_05_103	; $538c
	ld l,$05		; $538e
	inc (hl)		; $5390
	inc l			; $5391
	ld (hl),$f0		; $5392
	ld a,$10		; $5394
	call specialObjectSetAnimation		; $5396
	ld a,(wFrameCounter)		; $5399
	rrca			; $539c
	ret nc			; $539d
	call itemDecCounter1		; $539e
	ret nz			; $53a1
	xor a			; $53a2
	ld ($cbca),a		; $53a3
	jp $5ba7		; $53a6
	ld e,$05		; $53a9
	ld a,(de)		; $53ab
	rst_jumpTable			; $53ac
	or e			; $53ad
	ld d,e			; $53ae
	jp z,$fa53		; $53af
	ld d,e			; $53b2
	ld a,$01		; $53b3
	ld (de),a		; $53b5
	call $4df1		; $53b6
	call resetLinkInvincibility		; $53b9
	ld l,$10		; $53bc
	ld (hl),$14		; $53be
	ld l,$08		; $53c0
	ld (hl),$00		; $53c2
	inc l			; $53c4
	ld (hl),$00		; $53c5
	jp $5bae		; $53c7
	call specialObjectAnimate		; $53ca
	ld h,d			; $53cd
	ld a,(wFrameCounter)		; $53ce
	and $07			; $53d1
	jr nz,_label_05_107	; $53d3
	ld l,$10		; $53d5
	ld a,(hl)		; $53d7
	sub $05			; $53d8
	jr z,_label_05_107	; $53da
	ld (hl),a		; $53dc
_label_05_107:
	ld a,($cbb3)		; $53dd
	cp $02			; $53e0
	jp nz,$5c88		; $53e2
	ld a,($cc03)		; $53e5
	dec a			; $53e8
	jp nz,$5ba7		; $53e9
	ld l,$05		; $53ec
	inc (hl)		; $53ee
	inc l			; $53ef
	ld (hl),$20		; $53f0
	ld l,$09		; $53f2
	ld (hl),$10		; $53f4
	ld l,$10		; $53f6
	ld (hl),$50		; $53f8
	call specialObjectAnimate		; $53fa
	call itemDecCounter1		; $53fd
	jp nz,$5c88		; $5400
	ld hl,$cbb3		; $5403
	inc (hl)		; $5406
	ld a,$02		; $5407
	call fadeoutToWhiteWithDelay		; $5409
	jp $5ba7		; $540c
	ld e,$05		; $540f
	ld a,(de)		; $5411
	rst_jumpTable			; $5412
	add hl,de		; $5413
	ld d,h			; $5414
	dec (hl)		; $5415
	ld d,h			; $5416
	ld b,h			; $5417
	ld d,h			; $5418
	ld a,$01		; $5419
	ld (de),a		; $541b
	call $4df1		; $541c
	xor a			; $541f
	ld e,$24		; $5420
	ld (de),a		; $5422
	ld a,$4e		; $5423
	call playSound		; $5425
	ld a,($cc6b)		; $5428
	and $7f			; $542b
	ld a,$06		; $542d
	jr z,_label_05_108	; $542f
	inc a			; $5431
_label_05_108:
	call specialObjectSetAnimation		; $5432
	call specialObjectAnimate		; $5435
	ld e,$21		; $5438
	ld a,(de)		; $543a
	inc a			; $543b
	ret nz			; $543c
	call itemIncState2		; $543d
	ld l,$06		; $5440
	ld (hl),$14		; $5442
	call specialObjectAnimate		; $5444
	ld a,(wFrameCounter)		; $5447
	rrca			; $544a
	jp c,objectSetInvisible		; $544b
	call objectSetVisible		; $544e
	call itemDecCounter1		; $5451
	ret nz			; $5454
	ld a,($cc6b)		; $5455
	bit 7,a			; $5458
	jr nz,_label_05_109	; $545a
	call respawnLink		; $545c
	jr _label_05_110		; $545f
_label_05_109:
	ld a,$03		; $5461
	ld ($cc6a),a		; $5463
	jr _label_05_110		; $5466
_label_05_110:
	ld hl,$cc6a		; $5468
	ld a,(hl)		; $546b
	or a			; $546c
	ret z			; $546d
	ld (hl),$00		; $546e
	pop hl			; $5470
	ld h,d			; $5471
	ld l,$04		; $5472
	ldi (hl),a		; $5474
	ld (hl),$00		; $5475
	cp $0a			; $5477
	jr z,_label_05_111	; $5479
	cp $0c			; $547b
	jr z,_label_05_111	; $547d
	cp $0d			; $547f
	ret nz			; $5481
_label_05_111:
	jp $496f		; $5482
	ld a,$80		; $5485
	ld ($cc81),a		; $5487
	ld a,($c4ab)		; $548a
	or a			; $548d
	ret nz			; $548e
	ld a,($cd00)		; $548f
	and $0e			; $5492
	ret nz			; $5494
	call $4226		; $5495
	ld a,($cc34)		; $5498
	or a			; $549b
	jp nz,$4e8f		; $549c
	call $5468		; $549f
	call retIfTextIsActive		; $54a2
	ld a,($cca4)		; $54a5
	and $81			; $54a8
	ret nz			; $54aa
	call decPegasusSeedCounter		; $54ab
	ld a,($d101)		; $54ae
	cp $0a			; $54b1
	jr z,_label_05_112	; $54b3
	ld a,($cc48)		; $54b5
	rrca			; $54b8
	ret c			; $54b9
	ld a,($cca7)		; $54ba
	ld b,a			; $54bd
	ld a,($cc77)		; $54be
	or b			; $54c1
	jr nz,_label_05_112	; $54c2
	ld e,$2d		; $54c4
	ld a,(de)		; $54c6
	or a			; $54c7
	jr nz,_label_05_112	; $54c8
	call linkInteractWithAButtonSensitiveObjects		; $54ca
	ret c			; $54cd
	call interactWithTileBeforeLink		; $54ce
	ret c			; $54d1
_label_05_112:
	xor a			; $54d2
	ld ($cc81),a		; $54d3
	ld ($cca7),a		; $54d6
	ld a,($cc50)		; $54d9
	and $20			; $54dc
	jp nz,$58b2		; $54de
	call $4275		; $54e1
	call checkAndUpdateLinkOnChest		; $54e4
	call checkUseItems		; $54e7
	ld a,($cca7)		; $54ea
	or a			; $54ed
	ret nz			; $54ee
	call $5d53		; $54ef
	call $5c4c		; $54f2
	ld a,($cc78)		; $54f5
	and $40			; $54f8
	jr nz,_label_05_113	; $54fa
	ld a,($cc79)		; $54fc
	bit 6,a			; $54ff
	jr nz,_label_05_113	; $5501
	ld a,($cc77)		; $5503
	or a			; $5506
	jr nz,_label_05_113	; $5507
	ld a,($cc75)		; $5509
	ld c,a			; $550c
	ld a,(wLinkImmobilized)		; $550d
	or c			; $5510
	jr nz,_label_05_113	; $5511
	call $5e3d		; $5513
	call $5e74		; $5516
	call $5f89		; $5519
_label_05_113:
	call $59e2		; $551c
	ld a,($cc77)		; $551f
	or a			; $5522
	jr z,_label_05_115	; $5523
	bit 7,a			; $5525
	jr nz,_label_05_114	; $5527
	ld e,$15		; $5529
	ld a,(de)		; $552b
	bit 7,a			; $552c
	call z,$5828		; $552e
_label_05_114:
	ld hl,$ccaf		; $5531
	res 4,(hl)		; $5534
	call $5f48		; $5536
	call $5c88		; $5539
	jp specialObjectAnimate		; $553c
_label_05_115:
	ld a,($cc79)		; $553f
	bit 6,a			; $5542
	jp nz,$5bae		; $5544
	ld e,$2d		; $5547
	ld a,(de)		; $5549
	or a			; $554a
	jp nz,$55c0		; $554b
	ld h,d			; $554e
	ld l,$24		; $554f
	set 7,(hl)		; $5551
	ld a,($cc78)		; $5553
	or a			; $5556
	jp nz,$5627		; $5557
	call objectSetVisiblec1		; $555a
	ld a,($cc48)		; $555d
	rrca			; $5560
	jr c,_label_05_119	; $5561
	ld hl,$460c		; $5563
	ld e,$06		; $5566
	call interBankCall		; $5568
	ld a,b			; $556b
	or a			; $556c
	jp nz,setLinkIDOverride		; $556d
	ld a,($cc75)		; $5570
	and $0f			; $5573
	dec a			; $5575
	cp $02			; $5576
	jr c,_label_05_116	; $5578
	ld hl,$ccb8		; $557a
	bit 6,(hl)		; $557d
	jr z,_label_05_116	; $557f
	ld c,$88		; $5581
	call $5be1		; $5583
	call $5828		; $5586
	ld a,($cc47)		; $5589
	rlca			; $558c
	ld c,$02		; $558d
	jr c,_label_05_118	; $558f
	jr _label_05_117		; $5591
_label_05_116:
	ld a,($ccaf)		; $5593
	ld b,a			; $5596
	ld e,$09		; $5597
	ld a,($cc47)		; $5599
	ld (de),a		; $559c
	or b			; $559d
	rlca			; $559e
	ld c,$00		; $559f
	jr c,_label_05_118	; $55a1
	ld c,$01		; $55a3
	ld a,(wLinkImmobilized)		; $55a5
	or a			; $55a8
	jr nz,_label_05_118	; $55a9
	call $5bdf		; $55ab
_label_05_117:
	ld c,$07		; $55ae
_label_05_118:
	call $59bf		; $55b0
	ld a,($cc7b)		; $55b3
	or a			; $55b6
	ret nz			; $55b7
_label_05_119:
	jp updateLinkDirectionFromAngle		; $55b8
	ld e,$10		; $55bb
	xor a			; $55bd
	ld (de),a		; $55be
	ret			; $55bf
	ld hl,$ccb8		; $55c0
	bit 6,(hl)		; $55c3
	ret z			; $55c5
	ld e,$2c		; $55c6
	ld a,(de)		; $55c8
	ld e,$09		; $55c9
	ld (de),a		; $55cb
	ret			; $55cc
	ld e,a			; $55cd
	ld a,($c6c5)		; $55ce
	ld bc,$0208		; $55d1
	cp $13			; $55d4
	jr z,_label_05_120	; $55d6
	cp $14			; $55d8
	jr nz,_label_05_121	; $55da
	ld bc,$0310		; $55dc
_label_05_120:
	ld a,e			; $55df
	or c			; $55e0
	ld c,a			; $55e1
	push de			; $55e2
	ld de,$cec1		; $55e3
	ld hl,$cc6e		; $55e6
	srl c			; $55e9
	call c,$560f		; $55eb
	ld e,$c3		; $55ee
	ld l,$6e		; $55f0
	srl c			; $55f2
	call c,$560f		; $55f4
	pop de			; $55f7
	ld a,($cc70)		; $55f8
	cp b			; $55fb
	ret c			; $55fc
	ld hl,$c6a2		; $55fd
	ldi a,(hl)		; $5600
	cp (hl)			; $5601
	ld a,$29		; $5602
	call c,giveTreasure		; $5604
_label_05_121:
	ld hl,$cc6e		; $5607
	xor a			; $560a
	ldi (hl),a		; $560b
	ldi (hl),a		; $560c
	ldi (hl),a		; $560d
	ret			; $560e
	ld a,(de)		; $560f
	dec e			; $5610
	rlca			; $5611
	jr nc,_label_05_122	; $5612
	ld a,(de)		; $5614
	cpl			; $5615
	adc (hl)		; $5616
	ldi (hl),a		; $5617
	inc e			; $5618
	ld a,(de)		; $5619
	cpl			; $561a
	jr _label_05_123		; $561b
_label_05_122:
	ld a,(de)		; $561d
	add (hl)		; $561e
	ldi (hl),a		; $561f
	inc e			; $5620
	ld a,(de)		; $5621
_label_05_123:
	adc (hl)		; $5622
	ldi (hl),a		; $5623
	ret nc			; $5624
	inc (hl)		; $5625
	ret			; $5626
	ld a,($cc78)		; $5627
	and $0f			; $562a
	ld hl,$ccaf		; $562c
	res 4,(hl)		; $562f
	rst_jumpTable			; $5631
	sbc d			; $5632
	ld e,e			; $5633
	inc a			; $5634
	ld d,(hl)		; $5635
	sub c			; $5636
	ld d,(hl)		; $5637
	sbc e			; $5638
	ld d,(hl)		; $5639
	cp l			; $563a
	ld d,(hl)		; $563b
	call $4df1		; $563c
	call $56dc		; $563f
	ld l,$06		; $5642
	ld (hl),$0a		; $5644
	ld a,($cc78)		; $5646
	bit 6,a			; $5649
	jr nz,_label_05_124	; $564b
	ld a,$2e		; $564d
	call checkTreasureObtained		; $564f
	ld b,$0b		; $5652
	jr c,_label_05_126	; $5654
	ld c,$88		; $5656
	jr _label_05_125		; $5658
_label_05_124:
	ld c,$78		; $565a
_label_05_125:
	ld a,$02		; $565c
	ld ($cc6a),a		; $565e
	ld a,$04		; $5661
	ld ($cc6c),a		; $5663
	ld a,$80		; $5666
	ld ($ccac),a		; $5668
	ld h,d			; $566b
	ld l,$2b		; $566c
	ld (hl),c		; $566e
	ld l,$24		; $566f
	res 7,(hl)		; $5671
	ld a,$5f		; $5673
	call playSound		; $5675
	ld b,$0a		; $5678
_label_05_126:
	ld hl,$cc78		; $567a
	ld a,(hl)		; $567d
	and $f0			; $567e
	or $02			; $5680
	ld (hl),a		; $5682
	ld a,b			; $5683
	call specialObjectSetAnimation		; $5684
	jp linkCreateSplash		; $5687
	ld hl,$cc78		; $568a
	set 6,(hl)		; $568d
	jr _label_05_124		; $568f
	call itemDecCounter1		; $5691
	jp nz,$5c88		; $5694
	ld hl,$cc78		; $5697
	inc (hl)		; $569a
	call $5774		; $569b
	call objectSetVisiblec1		; $569e
	ld h,d			; $56a1
	ld l,$24		; $56a2
	set 7,(hl)		; $56a4
	ld a,($cc78)		; $56a6
	rlca			; $56a9
	jr nc,_label_05_127	; $56aa
	res 7,(hl)		; $56ac
	call objectSetVisiblec3		; $56ae
_label_05_127:
	call updateLinkDirectionFromAngle		; $56b1
	call $5704		; $56b4
	call $582b		; $56b7
	jp $5c88		; $56ba
	ld a,$80		; $56bd
	ld ($ccac),a		; $56bf
	call specialObjectAnimate		; $56c2
	ld h,d			; $56c5
	xor a			; $56c6
	ld l,$24		; $56c7
	ld (hl),a		; $56c9
	ld l,$21		; $56ca
	bit 7,(hl)		; $56cc
	ret z			; $56ce
	ld ($cc78),a		; $56cf
	ld a,$02		; $56d2
	ld ($cc6c),a		; $56d4
	ld a,$02		; $56d7
	jp $5471		; $56d9
	ld a,$15		; $56dc
	call cpActiveRing		; $56de
	ld a,$23		; $56e1
	jr z,_label_05_128	; $56e3
	ld a,$14		; $56e5
_label_05_128:
	ld h,d			; $56e7
	ld l,$10		; $56e8
	ldi (hl),a		; $56ea
	ldi (hl),a		; $56eb
	inc l			; $56ec
	ld a,$03		; $56ed
	ld (hl),a		; $56ef
	ld l,$35		; $56f0
	ld (hl),$00		; $56f2
	ret			; $56f4
	ld a,$15		; $56f5
	call cpActiveRing		; $56f7
	ld a,$23		; $56fa
	jr z,_label_05_129	; $56fc
	ld a,$14		; $56fe
_label_05_129:
	ld e,$11		; $5700
	ld (de),a		; $5702
	ret			; $5703
	ld e,$35		; $5704
	ld a,(de)		; $5706
	rst_jumpTable			; $5707
	ld c,$57		; $5708
	add hl,sp		; $570a
	ld d,a			; $570b
	ld a,$57		; $570c
	ld a,($cc46)		; $570e
	and $01			; $5711
	jr nz,_label_05_130	; $5713
	call $56f5		; $5715
	ld a,($cc47)		; $5718
	ret			; $571b
_label_05_130:
	ld a,$01		; $571c
	ld (de),a		; $571e
	ld a,$08		; $571f
_label_05_131:
	push af			; $5721
	ld e,$08		; $5722
	ld a,(de)		; $5724
	add a			; $5725
	add a			; $5726
	add a			; $5727
	call $582b		; $5728
	pop af			; $572b
	dec a			; $572c
	jr nz,_label_05_131	; $572d
	ld e,$06		; $572f
	ld a,$0d		; $5731
	ld (de),a		; $5733
	ld a,$88		; $5734
	call playSound		; $5736
	ld bc,$0105		; $5739
	jr _label_05_132		; $573c
	ld bc,$fffb		; $573e
_label_05_132:
	call itemDecCounter1		; $5741
	jr z,_label_05_133	; $5744
	ld a,(hl)		; $5746
	and $03			; $5747
	jr z,_label_05_135	; $5749
	jr _label_05_137		; $574b
_label_05_133:
	ld l,$35		; $574d
	inc b			; $574f
	ld (hl),b		; $5750
	jr nz,_label_05_134	; $5751
	call $56dc		; $5753
	jr _label_05_137		; $5756
_label_05_134:
	ld l,$06		; $5758
	ld a,$0c		; $575a
	ld (hl),a		; $575c
_label_05_135:
	ld l,$11		; $575d
	ld a,(hl)		; $575f
	add c			; $5760
	bit 7,a			; $5761
	jr z,_label_05_136	; $5763
	xor a			; $5765
_label_05_136:
	ld (hl),a		; $5766
_label_05_137:
	ld a,($cc47)		; $5767
	bit 7,a			; $576a
	ret z			; $576c
	ld e,$08		; $576d
	ld a,(de)		; $576f
	swap a			; $5770
	rrca			; $5772
	ret			; $5773
	call specialObjectAnimate		; $5774
	ld hl,$cc78		; $5777
	ld a,($cc46)		; $577a
	bit 1,a			; $577d
	jr nz,_label_05_138	; $577f
	ld a,$3c		; $5781
	call cpActiveRing		; $5783
	ret z			; $5786
	ld e,$07		; $5787
	ld a,(de)		; $5789
	dec a			; $578a
	ld (de),a		; $578b
	jr z,_label_05_139	; $578c
	ret			; $578e
_label_05_138:
	bit 7,(hl)		; $578f
	jr z,_label_05_140	; $5791
_label_05_139:
	res 7,(hl)		; $5793
	ld a,$0b		; $5795
	jp specialObjectSetAnimation		; $5797
_label_05_140:
	set 7,(hl)		; $579a
	ld e,$07		; $579c
	ld a,$78		; $579e
	ld (de),a		; $57a0
	call linkCreateSplash		; $57a1
	ld a,$0c		; $57a4
	jp specialObjectSetAnimation		; $57a6
	ld a,($cc78)		; $57a9
	and $0f			; $57ac
	jr z,_label_05_141	; $57ae
	ld hl,$ccaf		; $57b0
	res 4,(hl)		; $57b3
	rst_jumpTable			; $57b5
	cp (hl)			; $57b6
	ld d,a			; $57b7
	pop bc			; $57b8
	ld d,a			; $57b9
.DB $e3				; $57ba
	ld d,a			; $57bb
	cp l			; $57bc
	ld d,(hl)		; $57bd
_label_05_141:
	jp $5b9a		; $57be
	call $4df1		; $57c1
	ld hl,$cc78		; $57c4
	inc (hl)		; $57c7
	call $56dc		; $57c8
	call objectSetVisiblec1		; $57cb
	ld a,$2e		; $57ce
	call checkTreasureObtained		; $57d0
	jr nc,_label_05_142	; $57d3
	ld a,$17		; $57d5
	jr _label_05_143		; $57d7
_label_05_142:
	ld a,$03		; $57d9
	ld ($cc78),a		; $57db
	ld a,$0a		; $57de
_label_05_143:
	jp specialObjectSetAnimation		; $57e0
	xor a			; $57e3
	ld ($cc77),a		; $57e4
	ld h,d			; $57e7
	ld l,$24		; $57e8
	set 7,(hl)		; $57ea
	ld a,(wLinkImmobilized)		; $57ec
	or a			; $57ef
	jr nz,_label_05_145	; $57f0
	ld l,$08		; $57f2
	ld a,($cc47)		; $57f4
	add a			; $57f7
	jr c,_label_05_144	; $57f8
	ld c,a			; $57fa
	and $18			; $57fb
	jr z,_label_05_144	; $57fd
	ld a,c			; $57ff
	swap a			; $5800
	and $03			; $5802
	ld (hl),a		; $5804
_label_05_144:
	set 0,(hl)		; $5805
	call $5704		; $5807
	call $582b		; $580a
	call $5c88		; $580d
_label_05_145:
	ld h,d			; $5810
	ld l,$07		; $5811
	dec (hl)		; $5813
	bit 7,(hl)		; $5814
	jr z,_label_05_146	; $5816
	call getRandomNumber		; $5818
	and $1f			; $581b
	add $32			; $581d
	ld (hl),a		; $581f
	ld b,$91		; $5820
	call objectCreateInteractionWithSubid00		; $5822
_label_05_146:
	jp specialObjectAnimate		; $5825
	ld a,($cc47)		; $5828
	ld e,a			; $582b
	ld h,d			; $582c
	ld l,$09		; $582d
	bit 7,(hl)		; $582f
	jr z,_label_05_147	; $5831
	ld (hl),e		; $5833
	ret			; $5834
_label_05_147:
	bit 7,a			; $5835
	jr nz,_label_05_148	; $5837
	sub (hl)		; $5839
	add $04			; $583a
	and $1f			; $583c
	cp $09			; $583e
	jr c,_label_05_150	; $5840
	sub $10			; $5842
	cp $09			; $5844
	jr c,_label_05_149	; $5846
	ld bc,$0100		; $5848
	bit 7,a			; $584b
	jr nz,_label_05_151	; $584d
	ld b,$ff		; $584f
	jr _label_05_151		; $5851
_label_05_148:
	ld bc,$00fb		; $5853
	ld a,($cc77)		; $5856
	or a			; $5859
	jr z,_label_05_151	; $585a
	ld c,b			; $585c
	jr _label_05_151		; $585d
_label_05_149:
	ld bc,$01fb		; $585f
	cp $03			; $5862
	jr c,_label_05_151	; $5864
	ld b,$ff		; $5866
	cp $06			; $5868
	jr nc,_label_05_151	; $586a
	ld a,e			; $586c
	xor $10			; $586d
	ld (hl),a		; $586f
	ld b,$00		; $5870
	jr _label_05_151		; $5872
_label_05_150:
	ld bc,$ff05		; $5874
	cp $03			; $5877
	jr c,_label_05_151	; $5879
	ld b,$01		; $587b
	cp $06			; $587d
	jr nc,_label_05_151	; $587f
	ld a,e			; $5881
	ld (hl),a		; $5882
	ld b,$00		; $5883
_label_05_151:
	ld l,$12		; $5885
	inc (hl)		; $5887
	ldi a,(hl)		; $5888
	cp (hl)			; $5889
	ret c			; $588a
	dec l			; $588b
	ld (hl),$00		; $588c
	ld l,$09		; $588e
	ld a,(hl)		; $5890
	add b			; $5891
	and $1f			; $5892
	ld (hl),a		; $5894
	ld l,$11		; $5895
	ldd a,(hl)		; $5897
	ld b,a			; $5898
	ld a,(hl)		; $5899
	add c			; $589a
	jr z,_label_05_153	; $589b
	bit 7,a			; $589d
	jr nz,_label_05_153	; $589f
	cp b			; $58a1
	jr c,_label_05_152	; $58a2
	ld a,b			; $58a4
_label_05_152:
	ld (hl),a		; $58a5
	ret			; $58a6
_label_05_153:
	ld l,$10		; $58a7
	xor a			; $58a9
	ldi (hl),a		; $58aa
	inc l			; $58ab
	ld (hl),l		; $58ac
	dec a			; $58ad
	ld l,$09		; $58ae
	ld (hl),a		; $58b0
	ret			; $58b1
	call $4256		; $58b2
	ld a,($ccb6)		; $58b5
	bit 5,a			; $58b8
	jr z,_label_05_154	; $58ba
	ld a,($cc78)		; $58bc
	or a			; $58bf
	jr nz,_label_05_155	; $58c0
	inc a			; $58c2
	ld ($cc78),a		; $58c3
	call linkCreateSplash		; $58c6
	jr _label_05_155		; $58c9
_label_05_154:
	ld hl,$cc78		; $58cb
	ld a,(hl)		; $58ce
	ld (hl),$00		; $58cf
	or a			; $58d1
	jr z,_label_05_155	; $58d2
	ld a,($ccb7)		; $58d4
	cp $30			; $58d7
	jr z,_label_05_155	; $58d9
	ld a,$02		; $58db
	ld ($cc77),a		; $58dd
	call linkCreateSplash		; $58e0
	ld bc,$fe60		; $58e3
	call objectSetSpeedZ		; $58e6
	ld a,($cc47)		; $58e9
	ld l,$09		; $58ec
	ld (hl),a		; $58ee
_label_05_155:
	call checkUseItems		; $58ef
	ld a,($cca7)		; $58f2
	or a			; $58f5
	ret nz			; $58f6
	call $5d53		; $58f7
	call $5c4c		; $58fa
	ld a,($cc78)		; $58fd
	or a			; $5900
	jp nz,$57a9		; $5901
	ld a,($cc79)		; $5904
	bit 6,a			; $5907
	jp z,$5913		; $5909
	xor a			; $590c
	ld ($cc77),a		; $590d
	jp $5bae		; $5910
	call $5a7f		; $5913
	ret z			; $5916
	ld e,$2d		; $5917
	ld a,(de)		; $5919
	or a			; $591a
	ret nz			; $591b
	ld a,($ccb4)		; $591c
	cp $02			; $591f
	call z,$41f3		; $5921
	ld a,($cc73)		; $5924
	or a			; $5927
	jr z,_label_05_156	; $5928
	ld e,$33		; $592a
	ld a,(de)		; $592c
	and $30			; $592d
	jr nz,_label_05_157	; $592f
_label_05_156:
	ld a,($ccb7)		; $5931
	cp $40			; $5934
	jr nz,_label_05_158	; $5936
_label_05_157:
	ld a,$21		; $5938
	call cpActiveRing		; $593a
	jr z,_label_05_158	; $593d
	ld c,$88		; $593f
	call $5be1		; $5941
	ld a,$06		; $5944
	ld ($cc73),a		; $5946
	call $5828		; $5949
	ld c,$02		; $594c
	ld a,($cc47)		; $594e
	rlca			; $5951
	jr c,_label_05_160	; $5952
	jr _label_05_159		; $5954
_label_05_158:
	xor a			; $5956
	ld ($cc73),a		; $5957
	ld c,a			; $595a
	ld a,($cc47)		; $595b
	ld e,$09		; $595e
	ld (de),a		; $5960
	rlca			; $5961
	jr c,_label_05_160	; $5962
	call $5bdf		; $5964
	ld c,$01		; $5967
	ld a,(wLinkImmobilized)		; $5969
	or a			; $596c
	jr nz,_label_05_160	; $596d
_label_05_159:
	ld c,$07		; $596f
_label_05_160:
	ld hl,$ccb6		; $5971
	ldi a,(hl)		; $5974
	or (hl)			; $5975
	and $bf			; $5976
	call z,$43e3		; $5978
	call $59bf		; $597b
	ld e,$09		; $597e
	ld a,(de)		; $5980
	add $04			; $5981
	and $1f			; $5983
	cp $09			; $5985
	jr nc,_label_05_161	; $5987
	ld hl,$ccb6		; $5989
	ldi a,(hl)		; $598c
	or a			; $598d
	jr nz,_label_05_161	; $598e
	ld a,(hl)		; $5990
	cp $90			; $5991
	jr nz,_label_05_161	; $5993
	ld e,$0b		; $5995
	ld a,(de)		; $5997
	and $0f			; $5998
	cp $09			; $599a
	jr nc,_label_05_161	; $599c
	ld a,(de)		; $599e
	and $f0			; $599f
	add $09			; $59a1
	ld (de),a		; $59a3
_label_05_161:
	ld e,$33		; $59a4
	ld a,(de)		; $59a6
	and $30			; $59a7
	jr nz,_label_05_162	; $59a9
	ld a,($ccb6)		; $59ab
	bit 4,a			; $59ae
	jr z,_label_05_162	; $59b0
	ld a,$01		; $59b2
	ld ($cc83),a		; $59b4
_label_05_162:
	ld a,($cc7b)		; $59b7
	or a			; $59ba
	ret nz			; $59bb
	jp updateLinkDirectionFromAngle		; $59bc
	ld a,c			; $59bf
	rrca			; $59c0
	push af			; $59c1
	jr c,_label_05_163	; $59c2
	call $5bae		; $59c4
	jr _label_05_164		; $59c7
_label_05_163:
	call $5bbc		; $59c9
_label_05_164:
	pop af			; $59cc
	rrca			; $59cd
	jr nc,_label_05_166	; $59ce
	push af			; $59d0
	call $5c88		; $59d1
	jr z,_label_05_165	; $59d4
	ld c,a			; $59d6
	pop af			; $59d7
	rrca			; $59d8
	ret nc			; $59d9
	ld a,c			; $59da
	jp $55cd		; $59db
_label_05_165:
	pop af			; $59de
_label_05_166:
	jp $55bb		; $59df
	ld a,($cc77)		; $59e2
	and $0f			; $59e5
	rst_jumpTable			; $59e7
	xor $59			; $59e8
	ei			; $59ea
	ld e,c			; $59eb
	add hl,hl		; $59ec
	ld e,d			; $59ed
	ld h,d			; $59ee
	ld l,$0f		; $59ef
	bit 7,(hl)		; $59f1
	ret z			; $59f3
	ld a,$02		; $59f4
	ld ($cc77),a		; $59f6
	jr _label_05_168		; $59f9
	ld hl,$cc77		; $59fb
	inc (hl)		; $59fe
	bit 7,(hl)		; $59ff
	jr nz,_label_05_167	; $5a01
	ld hl,$ccb8		; $5a03
	bit 6,(hl)		; $5a06
	jr nz,_label_05_167	; $5a08
	ld l,$b6		; $5a0a
	ld (hl),$00		; $5a0c
	call $5bdf		; $5a0e
	ld a,($cc47)		; $5a11
	ld e,$09		; $5a14
	ld (de),a		; $5a16
_label_05_167:
	ld a,$53		; $5a17
	call playSound		; $5a19
_label_05_168:
	ld a,($cc75)		; $5a1c
	ld c,a			; $5a1f
	ld a,($cc7b)		; $5a20
	or c			; $5a23
	ld a,$18		; $5a24
	call z,specialObjectSetAnimation		; $5a26
	xor a			; $5a29
	ld e,$12		; $5a2a
	ld (de),a		; $5a2c
	inc e			; $5a2d
	ld (de),a		; $5a2e
	ld hl,$cc77		; $5a2f
	bit 7,(hl)		; $5a32
	jr z,_label_05_169	; $5a34
	ld e,$33		; $5a36
	ld (de),a		; $5a38
_label_05_169:
	bit 5,(hl)		; $5a39
	ld c,$20		; $5a3b
	jr z,_label_05_170	; $5a3d
	ld c,$0a		; $5a3f
_label_05_170:
	call objectUpdateSpeedZ_paramC		; $5a41
	ld l,$15		; $5a44
	jr z,_label_05_171	; $5a46
	ld a,(hl)		; $5a48
	bit 7,a			; $5a49
	ret nz			; $5a4b
	cp $03			; $5a4c
	ret c			; $5a4e
	ld (hl),$03		; $5a4f
	dec l			; $5a51
	ld (hl),$00		; $5a52
	ret			; $5a54
_label_05_171:
	xor a			; $5a55
	ldd (hl),a		; $5a56
	ld (hl),a		; $5a57
	ld ($cc77),a		; $5a58
	ld e,$36		; $5a5b
	ld (de),a		; $5a5d
	call $5bae		; $5a5e
	call $5f6b		; $5a61
	call $4275		; $5a64
	ld a,($ccb6)		; $5a67
	dec a			; $5a6a
	cp $02			; $5a6b
	jr nc,_label_05_172	; $5a6d
	ld a,$04		; $5a6f
	ld ($ccb5),a		; $5a71
_label_05_172:
	ld a,$a3		; $5a74
	call playSound		; $5a76
	call $5d53		; $5a79
	jp $5b9a		; $5a7c
	ld a,($cc77)		; $5a7f
	and $0f			; $5a82
	rst_jumpTable			; $5a84
	adc e			; $5a85
	ld e,d			; $5a86
	and (hl)		; $5a87
	ld e,d			; $5a88
	ret nz			; $5a89
	ld e,d			; $5a8a
	ld a,($ccb0)		; $5a8b
	or a			; $5a8e
	ret nz			; $5a8f
	ld e,$33		; $5a90
	ld a,(de)		; $5a92
	and $30			; $5a93
	ret nz			; $5a95
	ld hl,$ccb6		; $5a96
	ldi a,(hl)		; $5a99
	or (hl)			; $5a9a
	bit 4,a			; $5a9b
	ret nz			; $5a9d
	ld h,d			; $5a9e
	ld l,$14		; $5a9f
	xor a			; $5aa1
	ldi (hl),a		; $5aa2
	ldi (hl),a		; $5aa3
	jr _label_05_173		; $5aa4
	ld a,$53		; $5aa6
	call playSound		; $5aa8
_label_05_173:
	ld a,($cc75)		; $5aab
	ld c,a			; $5aae
	ld a,($cc7b)		; $5aaf
	or c			; $5ab2
	ld a,$18		; $5ab3
	call z,specialObjectSetAnimation		; $5ab5
	ld a,$02		; $5ab8
	ld ($cc77),a		; $5aba
	call $5bdf		; $5abd
	ld h,d			; $5ac0
	ld l,$15		; $5ac1
	bit 7,(hl)		; $5ac3
	jr z,_label_05_174	; $5ac5
	ld e,$33		; $5ac7
	ld a,(de)		; $5ac9
	and $c0			; $5aca
	jr nz,_label_05_179	; $5acc
	jr _label_05_178		; $5ace
_label_05_174:
	ld a,($ccb0)		; $5ad0
	or a			; $5ad3
	jp nz,$5b8e		; $5ad4
	ld e,$33		; $5ad7
	ld a,(de)		; $5ad9
	and $30			; $5ada
	jp nz,$5b6b		; $5adc
	ld a,($ccb6)		; $5adf
	bit 4,a			; $5ae2
	jr z,_label_05_175	; $5ae4
	ld a,($cc45)		; $5ae6
	and $40			; $5ae9
	jp nz,$5b73		; $5aeb
_label_05_175:
	ld e,$0b		; $5aee
	ld a,(de)		; $5af0
	bit 3,a			; $5af1
	jr z,_label_05_176	; $5af3
	ld a,($ccb7)		; $5af5
	cp $90			; $5af8
	jr z,_label_05_183	; $5afa
_label_05_176:
	ld hl,$ccb6		; $5afc
	ldi a,(hl)		; $5aff
	cp $04			; $5b00
	jp z,$568a		; $5b02
	cp $01			; $5b05
	jr nz,_label_05_177	; $5b07
	ld a,(hl)		; $5b09
	or a			; $5b0a
	jr nz,_label_05_177	; $5b0b
	ld a,$5f		; $5b0d
	call playSound		; $5b0f
	jp respawnLink		; $5b12
_label_05_177:
	call $5828		; $5b15
_label_05_178:
	ld l,$0a		; $5b18
	ld e,$14		; $5b1a
	ld a,(de)		; $5b1c
	add (hl)		; $5b1d
	ldi (hl),a		; $5b1e
	inc e			; $5b1f
	ld a,(de)		; $5b20
	adc (hl)		; $5b21
	ldi (hl),a		; $5b22
_label_05_179:
	ld c,$24		; $5b23
	ld a,($cc77)		; $5b25
	bit 5,a			; $5b28
	jr z,_label_05_180	; $5b2a
	ld c,$0e		; $5b2c
_label_05_180:
	ld l,$14		; $5b2e
	ld a,(hl)		; $5b30
	add c			; $5b31
	ldi (hl),a		; $5b32
	ld a,(hl)		; $5b33
	adc $00			; $5b34
	ldd (hl),a		; $5b36
	bit 7,a			; $5b37
	jr nz,_label_05_181	; $5b39
	cp $03			; $5b3b
	jr c,_label_05_181	; $5b3d
	xor a			; $5b3f
	ldi (hl),a		; $5b40
	ld (hl),$03		; $5b41
_label_05_181:
	call $5d53		; $5b43
	ld e,$33		; $5b46
	ld a,(de)		; $5b48
	and $30			; $5b49
	jr nz,_label_05_183	; $5b4b
	call $43e3		; $5b4d
	call $5c88		; $5b50
	call specialObjectAnimate		; $5b53
	ld e,$0b		; $5b56
	ld a,(de)		; $5b58
	cp $a9			; $5b59
	jr c,_label_05_182	; $5b5b
	ld a,($ccb6)		; $5b5d
	cp $10			; $5b60
	jr nz,_label_05_182	; $5b62
	ld a,$82		; $5b64
	ld ($cd02),a		; $5b66
_label_05_182:
	xor a			; $5b69
	ret			; $5b6a
_label_05_183:
	ld e,$0b		; $5b6b
	ld a,(de)		; $5b6d
	and $f8			; $5b6e
	add $01			; $5b70
	ld (de),a		; $5b72
_label_05_184:
	xor a			; $5b73
	ld e,$14		; $5b74
	ld (de),a		; $5b76
	inc e			; $5b77
	ld (de),a		; $5b78
	ld ($cc77),a		; $5b79
	ld a,($ccb4)		; $5b7c
	cp $02			; $5b7f
	call z,$41f3		; $5b81
	ld a,$a3		; $5b84
	call playSound		; $5b86
	call $5bae		; $5b89
	xor a			; $5b8c
	ret			; $5b8d
	ld e,$12		; $5b8e
	xor a			; $5b90
	ld (de),a		; $5b91
	ld a,$ff		; $5b92
	ld (de),a		; $5b94
	ld e,$09		; $5b95
	ld (de),a		; $5b97
	jr _label_05_184		; $5b98
	ld h,d			; $5b9a
	ld l,$04		; $5b9b
	ld (hl),$01		; $5b9d
	inc l			; $5b9f
	ld (hl),$00		; $5ba0
	ld l,$35		; $5ba2
	ld (hl),$00		; $5ba4
	ret			; $5ba6
	call $5b9a		; $5ba7
	ld l,$1a		; $5baa
	set 7,(hl)		; $5bac
	ld e,$30		; $5bae
	ld a,(de)		; $5bb0
	cp $10			; $5bb1
	jr nz,_label_05_185	; $5bb3
	call checkPegasusSeedCounter		; $5bb5
	jr nz,_label_05_186	; $5bb8
_label_05_185:
	xor a			; $5bba
	ld (de),a		; $5bbb
_label_05_186:
	call checkPegasusSeedCounter		; $5bbc
	jr z,_label_05_187	; $5bbf
	rlca			; $5bc1
	jr nc,_label_05_187	; $5bc2
	ld hl,$df00		; $5bc4
	ld a,$03		; $5bc7
	ldi (hl),a		; $5bc9
	ld (hl),$1a		; $5bca
	inc l			; $5bcc
	inc (hl)		; $5bcd
	ld a,$a3		; $5bce
	call playSound		; $5bd0
_label_05_187:
	ld h,d			; $5bd3
	ld a,$10		; $5bd4
	ld l,$30		; $5bd6
	cp (hl)			; $5bd8
	jp nz,specialObjectSetAnimation		; $5bd9
	jp specialObjectAnimate		; $5bdc
	ld c,$00		; $5bdf
	ld e,$36		; $5be1
	ld a,(de)		; $5be3
	cp c			; $5be4
	jr z,_label_05_189	; $5be5
	ld a,c			; $5be7
	ld (de),a		; $5be8
	and $7f			; $5be9
	ld hl,$5c34		; $5beb
	rst_addAToHl			; $5bee
	ld e,$10		; $5bef
	ldi a,(hl)		; $5bf1
	or a			; $5bf2
	jr z,_label_05_188	; $5bf3
	ld (de),a		; $5bf5
_label_05_188:
	xor a			; $5bf6
	ld e,$12		; $5bf7
	ld (de),a		; $5bf9
	inc e			; $5bfa
	ldi a,(hl)		; $5bfb
	ld (de),a		; $5bfc
_label_05_189:
	ld b,$02		; $5bfd
	ld e,$00		; $5bff
	ld a,($ccb6)		; $5c01
	cp $01			; $5c04
	jr z,_label_05_191	; $5c06
	cp $02			; $5c08
	jr z,_label_05_191	; $5c0a
	cp $05			; $5c0c
	jr z,_label_05_190	; $5c0e
	inc b			; $5c10
	cp $06			; $5c11
	jr z,_label_05_190	; $5c13
	cp $04			; $5c15
	jr z,_label_05_190	; $5c17
	inc b			; $5c19
_label_05_190:
	call checkPegasusSeedCounter		; $5c1a
	jr z,_label_05_191	; $5c1d
	ld e,$03		; $5c1f
_label_05_191:
	ld a,e			; $5c21
	add b			; $5c22
	add c			; $5c23
	and $7f			; $5c24
	ld hl,$5c34		; $5c26
	rst_addAToHl			; $5c29
	ld a,(hl)		; $5c2a
	ld h,d			; $5c2b
	ld l,$11		; $5c2c
	ldd (hl),a		; $5c2e
	bit 7,c			; $5c2f
	ret nz			; $5c31
	ld (hl),a		; $5c32
	ret			; $5c33
	jr z,_label_05_192	; $5c34
_label_05_192:
	ld e,$14		; $5c36
	jr z,$2d		; $5c38
	ld e,$3c		; $5c3a
	nop			; $5c3c
	ld b,$28		; $5c3d
	jr z,_label_05_194	; $5c3f
	inc a			; $5c41
	inc a			; $5c42
	inc a			; $5c43
	inc d			; $5c44
	inc bc			; $5c45
	ld e,$14		; $5c46
	jr z,_label_05_195	; $5c48
	ld e,$3c		; $5c4a
	ld e,$04		; $5c4c
	ld a,(de)		; $5c4e
	cp $02			; $5c4f
	jr z,_label_05_196	; $5c51
	ld a,($cc77)		; $5c53
	rlca			; $5c56
	jr c,_label_05_196	; $5c57
	ld c,$01		; $5c59
	or a			; $5c5b
	jr z,_label_05_193	; $5c5c
	inc c			; $5c5e
_label_05_193:
	ld h,d			; $5c5f
	ld l,$2d		; $5c60
	ld a,(hl)		; $5c62
	or a			; $5c63
	ret z			; $5c64
	sub c			; $5c65
	jr c,_label_05_196	; $5c66
	ld (hl),a		; $5c68
_label_05_194:
	ld l,$2c		; $5c69
	call $43e5		; $5c6b
	ld a,(de)		; $5c6e
	ld c,a			; $5c6f
	ld b,$32		; $5c70
	ld hl,$ccaf		; $5c72
	res 5,(hl)		; $5c75
_label_05_195:
	jp $5c90		; $5c77
_label_05_196:
	ld e,$2d		; $5c7a
	xor a			; $5c7c
	ld (de),a		; $5c7d
	ret			; $5c7e
	ld e,$10		; $5c7f
	ld a,(de)		; $5c81
	ld b,a			; $5c82
	ld e,$09		; $5c83
	ld a,(de)		; $5c85
	jr _label_05_197		; $5c86
	ld e,$10		; $5c88
	ld a,(de)		; $5c8a
	ld b,a			; $5c8b
	ld e,$09		; $5c8c
	ld a,(de)		; $5c8e
	ld c,a			; $5c8f
	bit 7,c			; $5c90
	jr nz,_label_05_201	; $5c92
	ld e,$33		; $5c94
	ld a,(de)		; $5c96
	ld e,a			; $5c97
	call $5d00		; $5c98
	jr nz,_label_05_198	; $5c9b
_label_05_197:
	ld c,a			; $5c9d
	ld e,$00		; $5c9e
_label_05_198:
	ld a,c			; $5ca0
	ld hl,$5ce0		; $5ca1
	rst_addAToHl			; $5ca4
	ld a,e			; $5ca5
	and (hl)		; $5ca6
	ld e,a			; $5ca7
	call getPositionOffsetForVelocity		; $5ca8
	ld c,$00		; $5cab
	ld b,e			; $5cad
	ld a,b			; $5cae
	and $f0			; $5caf
	jr nz,_label_05_199	; $5cb1
	ldi a,(hl)		; $5cb3
	or (hl)			; $5cb4
	jr z,_label_05_199	; $5cb5
	dec l			; $5cb7
	ld e,$0a		; $5cb8
	ld a,(de)		; $5cba
	add (hl)		; $5cbb
	ld (de),a		; $5cbc
	inc e			; $5cbd
	inc l			; $5cbe
	ld a,(de)		; $5cbf
	adc (hl)		; $5cc0
	ld (de),a		; $5cc1
	inc c			; $5cc2
_label_05_199:
	ld a,b			; $5cc3
	and $0f			; $5cc4
	jr nz,_label_05_200	; $5cc6
	ld l,$c3		; $5cc8
	ldd a,(hl)		; $5cca
	or (hl)			; $5ccb
	jr z,_label_05_200	; $5ccc
	ld e,$0c		; $5cce
	ld a,(de)		; $5cd0
	add (hl)		; $5cd1
	ld (de),a		; $5cd2
	inc l			; $5cd3
	inc e			; $5cd4
	ld a,(de)		; $5cd5
	adc (hl)		; $5cd6
	ld (de),a		; $5cd7
	set 1,c			; $5cd8
_label_05_200:
	ld a,c			; $5cda
	or a			; $5cdb
	ret			; $5cdc
_label_05_201:
	xor a			; $5cdd
	ld c,a			; $5cde
	ret			; $5cdf
	rst $8			; $5ce0
	jp $c3c3		; $5ce1
	jp $c3c3		; $5ce4
	jp $33f3		; $5ce7
	inc sp			; $5cea
	inc sp			; $5ceb
	inc sp			; $5cec
	inc sp			; $5ced
	inc sp			; $5cee
	inc sp			; $5cef
	ccf			; $5cf0
	inc a			; $5cf1
	inc a			; $5cf2
	inc a			; $5cf3
	inc a			; $5cf4
	inc a			; $5cf5
	inc a			; $5cf6
	inc a			; $5cf7
.DB $fc				; $5cf8
	call z,$cccc		; $5cf9
	call z,$cccc		; $5cfc
	call z,$2179		; $5cff
	ld c,l			; $5d02
	inc h			; $5d03
	rst_addAToHl			; $5d04
	ld a,(hl)		; $5d05
	and $03			; $5d06
	ret nz			; $5d08
	ld a,(hl)		; $5d09
	rlca			; $5d0a
	jr c,_label_05_203	; $5d0b
	rlca			; $5d0d
	jr c,_label_05_204	; $5d0e
	rlca			; $5d10
	jr c,_label_05_202	; $5d11
	ld a,e			; $5d13
	and $cc			; $5d14
	cp $04			; $5d16
	ld a,$00		; $5d18
	ret z			; $5d1a
	ld a,e			; $5d1b
	and $3c			; $5d1c
	cp $08			; $5d1e
	ld a,$10		; $5d20
	ret			; $5d22
_label_05_202:
	ld a,e			; $5d23
	and $c3			; $5d24
	cp $01			; $5d26
	ld a,$00		; $5d28
	ret z			; $5d2a
	ld a,e			; $5d2b
	and $33			; $5d2c
	cp $02			; $5d2e
	ld a,$10		; $5d30
	ret			; $5d32
_label_05_203:
	ld a,e			; $5d33
	and $c3			; $5d34
	cp $80			; $5d36
	ld a,$08		; $5d38
	ret z			; $5d3a
	ld a,e			; $5d3b
	and $cc			; $5d3c
	cp $40			; $5d3e
	ld a,$18		; $5d40
	ret			; $5d42
_label_05_204:
	ld a,e			; $5d43
	and $33			; $5d44
	cp $20			; $5d46
	ld a,$08		; $5d48
	ret z			; $5d4a
	ld a,e			; $5d4b
	and $3c			; $5d4c
	cp $10			; $5d4e
	ld a,$18		; $5d50
	ret			; $5d52
	ld e,$33		; $5d53
	xor a			; $5d55
	ld (de),a		; $5d56
	ld a,($cc48)		; $5d57
	rrca			; $5d5a
	ret c			; $5d5b
	ld a,($ccb6)		; $5d5c
	sub $08			; $5d5f
	jr nz,_label_05_205	; $5d61
	dec a			; $5d63
	jr _label_05_206		; $5d64
_label_05_205:
	ld h,d			; $5d66
	ld l,$0b		; $5d67
	ld b,(hl)		; $5d69
	ld l,$0d		; $5d6a
	ld c,(hl)		; $5d6c
	call $5d85		; $5d6d
_label_05_206:
	ld e,$33		; $5d70
	ld (de),a		; $5d72
	ret			; $5d73
	call $5d85		; $5d74
_label_05_207:
	ld b,$80		; $5d77
	cp $ff			; $5d79
	ret z			; $5d7b
	rra			; $5d7c
	rl b			; $5d7d
	rra			; $5d7f
	rl b			; $5d80
	jr nz,_label_05_207	; $5d82
	ret			; $5d84
	ld a,$01		; $5d85
	ldh (<hFF8B),a	; $5d87
	ld hl,$5da9		; $5d89
	ld a,($cc50)		; $5d8c
	and $20			; $5d8f
	jr z,_label_05_208	; $5d91
	ld hl,$5db9		; $5d93
_label_05_208:
	ldi a,(hl)		; $5d96
	add b			; $5d97
	ld b,a			; $5d98
	ldi a,(hl)		; $5d99
	add c			; $5d9a
	ld c,a			; $5d9b
	push hl			; $5d9c
	call checkTileCollisionAt_allowHoles		; $5d9d
	pop hl			; $5da0
	ldh a,(<hFF8B)	; $5da1
	rla			; $5da3
	ldh (<hFF8B),a	; $5da4
	jr nc,_label_05_208	; $5da6
	ret			; $5da8
.DB $fd				; $5da9
.DB $fd				; $5daa
	nop			; $5dab
	dec b			; $5dac
	ld a,(bc)		; $5dad
	ei			; $5dae
	nop			; $5daf
	dec b			; $5db0
	ld sp,hl		; $5db1
	ld sp,hl		; $5db2
	dec b			; $5db3
	nop			; $5db4
	ei			; $5db5
	add hl,bc		; $5db6
	dec b			; $5db7
	nop			; $5db8
.DB $fd				; $5db9
.DB $fd				; $5dba
	nop			; $5dbb
	dec b			; $5dbc
	ld a,(bc)		; $5dbd
	ei			; $5dbe
	nop			; $5dbf
	dec b			; $5dc0
	ld sp,hl		; $5dc1
	ld sp,hl		; $5dc2
	dec b			; $5dc3
	nop			; $5dc4
	ei			; $5dc5
	add hl,bc		; $5dc6
	dec b			; $5dc7
	nop			; $5dc8
	push hl			; $5dc9
	ld hl,wLinkImmobilized		; $5dca
	res 4,(hl)		; $5dcd
	pop hl			; $5dcf
	ret			; $5dd0
	push hl			; $5dd1
	ld hl,wLinkImmobilized		; $5dd2
	set 4,(hl)		; $5dd5
	pop hl			; $5dd7
	ret			; $5dd8
	xor a			; $5dd9
	ld e,$2d		; $5dda
	ld (de),a		; $5ddc
	ld h,d			; $5ddd
	ld l,$04		; $5dde
	ld a,(hl)		; $5de0
	cp $02			; $5de1
	ret z			; $5de3
	ld a,($ccb5)		; $5de4
	cp $10			; $5de7
	call nc,$5dd1		; $5de9
	and $03			; $5dec
	jr z,_label_05_209	; $5dee
	dec a			; $5df0
	jr z,_label_05_210	; $5df1
	ret			; $5df3
_label_05_209:
	ld l,$0b		; $5df4
	ld a,(hl)		; $5df6
	add $05			; $5df7
	and $f0			; $5df9
	add $08			; $5dfb
	sub (hl)		; $5dfd
	jr c,_label_05_212	; $5dfe
	jr _label_05_211		; $5e00
_label_05_210:
	ld l,$0d		; $5e02
	ld a,(hl)		; $5e04
	and $f0			; $5e05
	add $08			; $5e07
	sub (hl)		; $5e09
	jr c,_label_05_212	; $5e0a
_label_05_211:
	ld a,(hl)		; $5e0c
	inc a			; $5e0d
	jr _label_05_213		; $5e0e
_label_05_212:
	ld a,(hl)		; $5e10
	dec a			; $5e11
_label_05_213:
	ld (hl),a		; $5e12
	ld l,$0b		; $5e13
	ldi a,(hl)		; $5e15
	and $0f			; $5e16
	sub $07			; $5e18
	cp $03			; $5e1a
	ret nc			; $5e1c
	inc l			; $5e1d
	ldi a,(hl)		; $5e1e
	and $0f			; $5e1f
	sub $07			; $5e21
	cp $03			; $5e23
	ret nc			; $5e25
	call clearAllParentItems		; $5e26
	ld e,$2d		; $5e29
	xor a			; $5e2b
	ld (de),a		; $5e2c
	ld ($cc6c),a		; $5e2d
	ld e,$01		; $5e30
	ld a,(de)		; $5e32
	or a			; $5e33
	ld a,$02		; $5e34
	jp z,$5471		; $5e36
	ld ($cc6a),a		; $5e39
	ret			; $5e3c
	ld hl,$ccee		; $5e3d
	bit 1,(hl)		; $5e40
	ret nz			; $5e42
	ld a,($cc49)		; $5e43
	cp $03			; $5e46
	ret nz			; $5e48
	ld bc,$8214		; $5e49
	ld l,$03		; $5e4c
	ld a,($cc4c)		; $5e4e
	cp b			; $5e51
	ret nz			; $5e52
	ld a,($ccb3)		; $5e53
	cp c			; $5e56
	ret nz			; $5e57
	ld e,$08		; $5e58
	ld a,(de)		; $5e5a
	cp l			; $5e5b
	ret nz			; $5e5c
	call checkLinkPushingAgainstWall		; $5e5d
	ret z			; $5e60
	ld hl,$cceb		; $5e61
	inc (hl)		; $5e64
	ld a,(hl)		; $5e65
	cp $5a			; $5e66
	ret c			; $5e68
	pop hl			; $5e69
	ld hl,$ccee		; $5e6a
	set 1,(hl)		; $5e6d
	ld a,$05		; $5e6f
	jp $5471		; $5e71
	ld a,($ccb6)		; $5e74
	cp $08			; $5e77
	jp z,$5ed3		; $5e79
	ld a,($cc49)		; $5e7c
	or a			; $5e7f
	ret nz			; $5e80
	ld a,($cc47)		; $5e81
	and $e7			; $5e84
	ret nz			; $5e86
	call checkLinkPushingAgainstWall		; $5e87
	ret nc			; $5e8a
	ld e,$08		; $5e8b
	ld a,(de)		; $5e8d
	ld hl,$5ebf		; $5e8e
	rst_addDoubleIndex			; $5e91
	ldi a,(hl)		; $5e92
	ld b,a			; $5e93
	ld c,(hl)		; $5e94
	call objectGetRelativeTile		; $5e95
	cp $20			; $5e98
	ret nz			; $5e9a
	ld a,$01		; $5e9b
	call $5f42		; $5e9d
	ld e,$08		; $5ea0
	ld a,(de)		; $5ea2
	ld l,a			; $5ea3
	add a			; $5ea4
	add l			; $5ea5
	ld hl,$5ec7		; $5ea6
	rst_addAToHl			; $5ea9
	ld e,$10		; $5eaa
	ldi a,(hl)		; $5eac
	ld (de),a		; $5ead
	inc e			; $5eae
	ld (de),a		; $5eaf
	ld e,$14		; $5eb0
	ldi a,(hl)		; $5eb2
	ld (de),a		; $5eb3
	inc e			; $5eb4
	ldi a,(hl)		; $5eb5
	ld (de),a		; $5eb6
	ld a,$81		; $5eb7
	ld ($cc77),a		; $5eb9
	jp $4df1		; $5ebc
.DB $f4				; $5ebf
	nop			; $5ec0
	nop			; $5ec1
	rlca			; $5ec2
	ld ($0000),sp		; $5ec3
	ld hl,sp+$23		; $5ec6
	ld b,b			; $5ec8
	cp $14			; $5ec9
	ld h,b			; $5ecb
	cp $0f			; $5ecc
	ld b,b			; $5ece
	cp $14			; $5ecf
	ld h,b			; $5ed1
	cp $fa			; $5ed2
	ld b,a			; $5ed4
	call z,$e64f		; $5ed5
	rst $20			; $5ed8
	jr nz,_label_05_215	; $5ed9
	ld a,c			; $5edb
	add a			; $5edc
	swap a			; $5edd
	ld hl,$5f27		; $5edf
	rst_addDoubleIndex			; $5ee2
	ldi a,(hl)		; $5ee3
	ld c,(hl)		; $5ee4
	ld h,d			; $5ee5
	ld l,$0b		; $5ee6
	add (hl)		; $5ee8
	ld b,a			; $5ee9
	ld l,$0d		; $5eea
	ld a,(hl)		; $5eec
	add c			; $5eed
	ld c,a			; $5eee
	call checkTileCollisionAt_allowHoles		; $5eef
	jr c,_label_05_215	; $5ef2
	ld a,($cc47)		; $5ef4
	ld e,$09		; $5ef7
	ld (de),a		; $5ef9
	add a			; $5efa
	swap a			; $5efb
	ld c,a			; $5efd
	add a			; $5efe
	add c			; $5eff
	ld hl,$5f2f		; $5f00
	rst_addAToHl			; $5f03
	ld a,($cc7b)		; $5f04
	or a			; $5f07
	jr nz,_label_05_214	; $5f08
	ld e,$08		; $5f0a
	ld a,c			; $5f0c
	ld (de),a		; $5f0d
_label_05_214:
	ld e,$10		; $5f0e
	ldi a,(hl)		; $5f10
	ld (de),a		; $5f11
	inc e			; $5f12
	ld (de),a		; $5f13
	ld e,$14		; $5f14
	ldi a,(hl)		; $5f16
	ld (de),a		; $5f17
	inc e			; $5f18
	ldi a,(hl)		; $5f19
	ld (de),a		; $5f1a
	call $5f3b		; $5f1b
	ld a,$81		; $5f1e
	ld ($cc77),a		; $5f20
	xor a			; $5f23
	ret			; $5f24
_label_05_215:
	or d			; $5f25
	ret			; $5f26
	ei			; $5f27
	nop			; $5f28
	nop			; $5f29
	add hl,bc		; $5f2a
	dec de			; $5f2b
	nop			; $5f2c
	nop			; $5f2d
	or $0f			; $5f2e
	ld h,b			; $5f30
	cp $14			; $5f31
	ld h,b			; $5f33
	cp $1e			; $5f34
	ld b,b			; $5f36
	cp $14			; $5f37
	ld h,b			; $5f39
	cp $af			; $5f3a
	ld e,$37		; $5f3c
	ld (de),a		; $5f3e
	inc e			; $5f3f
	ld (de),a		; $5f40
	ret			; $5f41
	ld e,$37		; $5f42
	ld (de),a		; $5f44
	inc e			; $5f45
	ld a,l			; $5f46
	ld (de),a		; $5f47
	ld e,$37		; $5f48
	ld a,(de)		; $5f4a
	or a			; $5f4b
	ret z			; $5f4c
	ld hl,$5f65		; $5f4d
	rst_addDoubleIndex			; $5f50
	inc e			; $5f51
	ld a,(de)		; $5f52
	ld c,a			; $5f53
	and $f0			; $5f54
	add (hl)		; $5f56
	ld b,a			; $5f57
	inc hl			; $5f58
	ld a,c			; $5f59
	and $0f			; $5f5a
	swap a			; $5f5c
	add (hl)		; $5f5e
	ld c,a			; $5f5f
	call objectGetRelativeAngle		; $5f60
	ld e,$09		; $5f63
	ld (de),a		; $5f65
	ret			; $5f66
	ld (bc),a		; $5f67
	ld ($080c),sp		; $5f68
	ld e,$37		; $5f6b
	ld a,(de)		; $5f6d
	or a			; $5f6e
	ret z			; $5f6f
	ld hl,$5f65		; $5f70
	rst_addDoubleIndex			; $5f73
	inc e			; $5f74
	ld a,(de)		; $5f75
	ld c,a			; $5f76
	and $f0			; $5f77
	add (hl)		; $5f79
	ld e,$0b		; $5f7a
	ld (de),a		; $5f7c
	inc hl			; $5f7d
	ld a,c			; $5f7e
	and $0f			; $5f7f
	swap a			; $5f81
	add (hl)		; $5f83
	ld e,$0d		; $5f84
	ld (de),a		; $5f86
	jr -$4e			; $5f87
	ld a,($ccb6)		; $5f89
	cp $08			; $5f8c
	ret z			; $5f8e
	ld a,($cc47)		; $5f8f
	ld c,a			; $5f92
	and $e7			; $5f93
	ret nz			; $5f95
	ld h,d			; $5f96
	ld l,$09		; $5f97
	xor c			; $5f99
	cp (hl)			; $5f9a
	ret nz			; $5f9b
	add a			; $5f9c
	swap a			; $5f9d
	ld c,a			; $5f9f
	add a			; $5fa0
	add a			; $5fa1
	add c			; $5fa2
	ld hl,$5ff6		; $5fa3
	rst_addAToHl			; $5fa6
	ld e,$33		; $5fa7
	ld a,(de)		; $5fa9
	and (hl)		; $5faa
	cp (hl)			; $5fab
	ret nz			; $5fac
	call $5fdb		; $5fad
	ret nc			; $5fb0
	call $5fdb		; $5fb1
	ret nc			; $5fb4
	ld a,$81		; $5fb5
	ld ($cc77),a		; $5fb7
	ld bc,$fe40		; $5fba
	call objectSetSpeedZ		; $5fbd
	ld l,$2d		; $5fc0
	ld (hl),$00		; $5fc2
	ldh a,(<hFF8B)	; $5fc4
	cp $05			; $5fc6
	jr z,_label_05_216	; $5fc8
	cp $06			; $5fca
	jr z,_label_05_216	; $5fcc
	pop hl			; $5fce
	ld a,$12		; $5fcf
	call $5471		; $5fd1
	jr _label_05_217		; $5fd4
_label_05_216:
	ld l,$10		; $5fd6
	ld (hl),$32		; $5fd8
	ret			; $5fda
	inc hl			; $5fdb
	ldi a,(hl)		; $5fdc
	ld c,(hl)		; $5fdd
	ld b,a			; $5fde
	push hl			; $5fdf
	call objectGetRelativeTile		; $5fe0
	ldh (<hFF8B),a	; $5fe3
	ld hl,$7c9a		; $5fe5
	call lookupCollisionTable		; $5fe8
	pop hl			; $5feb
	ret nc			; $5fec
	ld c,a			; $5fed
	ld e,$09		; $5fee
	ld a,(de)		; $5ff0
	cp c			; $5ff1
	scf			; $5ff2
	ret z			; $5ff3
	xor a			; $5ff4
	ret			; $5ff5
	ret nz			; $5ff6
.DB $fc				; $5ff7
.DB $fd				; $5ff8
.DB $fc				; $5ff9
	ld (bc),a		; $5ffa
	inc bc			; $5ffb
	nop			; $5ffc
	inc b			; $5ffd
	dec b			; $5ffe
	inc b			; $5fff
	jr nc,_label_05_217	; $6000
.DB $fd				; $6002
	ld ($0c02),sp		; $6003
	nop			; $6006
	ei			; $6007
	dec b			; $6008
	ei			; $6009
_label_05_217:
	ld e,$05		; $600a
	ld a,(de)		; $600c
	rst_jumpTable			; $600d
	ld d,$60		; $600e
	ld l,e			; $6010
	ld h,b			; $6011
	xor (hl)		; $6012
	ld h,b			; $6013
	pop bc			; $6014
	ld h,b			; $6015
	call itemIncState2		; $6016
	ld a,($cc75)		; $6019
	ld c,a			; $601c
	ld a,($cc7b)		; $601d
	or c			; $6020
	ld a,$18		; $6021
	call z,specialObjectSetAnimation		; $6023
	ld a,$53		; $6026
	call playSound		; $6028
	call $60dc		; $602b
	jr z,_label_05_218	; $602e
	ld hl,$605f		; $6030
	rst_addAToHl			; $6033
	ld a,(hl)		; $6034
	ld e,$10		; $6035
	ld (de),a		; $6037
	ret			; $6038
_label_05_218:
	ld a,($cd0d)		; $6039
	ld b,a			; $603c
	ld h,d			; $603d
	ld l,$0b		; $603e
	ld a,(hl)		; $6040
	sub b			; $6041
	ld (hl),b		; $6042
	ld l,$0f		; $6043
	ld (hl),a		; $6045
	ld l,$1a		; $6046
	res 6,(hl)		; $6048
	ld l,$05		; $604a
	ld (hl),$02		; $604c
	xor a			; $604e
	ld l,$10		; $604f
	ld (hl),a		; $6051
	ld l,$14		; $6052
	ldi (hl),a		; $6054
	ld (hl),$ff		; $6055
	inc a			; $6057
	ld ($ccab),a		; $6058
	ld l,$2f		; $605b
	set 0,(hl)		; $605d
	ret			; $605f
	inc d			; $6060
	add hl,de		; $6061
	inc hl			; $6062
	dec l			; $6063
	scf			; $6064
	ld b,c			; $6065
	ld d,b			; $6066
	ld e,d			; $6067
	ld h,h			; $6068
	ld l,(hl)		; $6069
	ld a,b			; $606a
	call objectApplySpeed		; $606b
	ld c,$20		; $606e
	call objectUpdateSpeedZ_paramC		; $6070
	jp nz,specialObjectAnimate		; $6073
	ld h,d			; $6076
	ld l,$2f		; $6077
	bit 0,(hl)		; $6079
	res 0,(hl)		; $607b
	call nz,updateLinkLocalRespawnPosition		; $607d
	call $4961		; $6080
	ld a,($cc49)		; $6083
	or a			; $6086
	jr nz,_label_05_219	; $6087
	ld bc,$0500		; $6089
	call objectGetRelativeTile		; $608c
	cp $20			; $608f
	jr nz,_label_05_219	; $6091
	call objectCenterOnTile		; $6093
	ld l,$0b		; $6096
	ld a,(hl)		; $6098
	sub $06			; $6099
	ld (hl),a		; $609b
_label_05_219:
	xor a			; $609c
	ld ($cc77),a		; $609d
	ld ($cc78),a		; $60a0
	ld a,$a3		; $60a3
	call playSound		; $60a5
	call $5d53		; $60a8
	jp $5ba7		; $60ab
	ld c,$20		; $60ae
	call objectUpdateSpeedZ_paramC		; $60b0
	jp nz,specialObjectAnimate		; $60b3
	ld a,$82		; $60b6
	ld ($cd02),a		; $60b8
	ld e,$05		; $60bb
	ld a,$03		; $60bd
	ld (de),a		; $60bf
	ret			; $60c0
	ld a,($cd00)		; $60c1
	cp $01			; $60c4
	ret nz			; $60c6
	call $60dc		; $60c7
	ld h,d			; $60ca
	ld l,$0b		; $60cb
	ld a,(hl)		; $60cd
	sub b			; $60ce
	ld (hl),b		; $60cf
	ld l,$0f		; $60d0
	ld (hl),a		; $60d2
	ld l,$1a		; $60d3
	set 6,(hl)		; $60d5
	ld l,$05		; $60d7
	ld (hl),$01		; $60d9
	ret			; $60db
	ld h,d			; $60dc
	ld l,$0b		; $60dd
	ldi a,(hl)		; $60df
	add $05			; $60e0
	ld b,a			; $60e2
	inc l			; $60e3
	ld c,(hl)		; $60e4
	ld l,$09		; $60e5
	ld a,(hl)		; $60e7
	add a			; $60e8
	swap a			; $60e9
	and $03			; $60eb
	ld hl,$612f		; $60ed
	rst_addDoubleIndex			; $60f0
	ldi a,(hl)		; $60f1
	ldh (<hFF8D),a	; $60f2
	ld a,(hl)		; $60f4
	ldh (<hFF8C),a	; $60f5
	ld a,$01		; $60f7
	ldh (<hFF8B),a	; $60f9
_label_05_220:
	ldh a,(<hFF8D)	; $60fb
	add b			; $60fd
	ld b,a			; $60fe
	ldh a,(<hFF8C)	; $60ff
	add c			; $6101
	ld c,a			; $6102
	call checkTileCollisionAt_allowHoles		; $6103
	jr nc,_label_05_221	; $6106
	ld a,$85		; $6108
	call tryToBreakTile		; $610a
	jr c,_label_05_222	; $610d
	ldh a,(<hFF92)	; $610f
	ld hl,$6137		; $6111
	call findByteInCollisionTable		; $6114
	jr c,_label_05_222	; $6117
	ldh a,(<hFF8B)	; $6119
	inc a			; $611b
	ldh (<hFF8B),a	; $611c
	jr _label_05_220		; $611e
_label_05_221:
	call getTileAtPosition		; $6120
	or a			; $6123
	ret z			; $6124
_label_05_222:
	ldh a,(<hFF8B)	; $6125
	cp $0b			; $6127
	jr c,_label_05_223	; $6129
	ld a,$0b		; $612b
_label_05_223:
	or a			; $612d
	ret			; $612e
	ld hl,sp+$00		; $612f
	nop			; $6131
	ld ($0008),sp		; $6132
	nop			; $6135
	ld hl,sp+$43		; $6136
	ld h,c			; $6138
	ld b,l			; $6139
	ld h,c			; $613a
	ld b,l			; $613b
	ld h,c			; $613c
	ld b,l			; $613d
	ld h,c			; $613e
	ld b,l			; $613f
	ld h,c			; $6140
	ld b,l			; $6141
	ld h,c			; $6142
.DB $eb				; $6143
	jr nz,_label_05_224	; $6144
_label_05_224:
	ld e,$04		; $6146
	ld a,(de)		; $6148
	rst_jumpTable			; $6149
	ld c,(hl)		; $614a
	ld h,c			; $614b
	xor d			; $614c
	ld h,c			; $614d
	call dropLinkHeldItem		; $614e
	call clearAllParentItems		; $6151
	ld a,($cc6a)		; $6154
	or a			; $6157
	jr nz,_label_05_228	; $6158
	call $41b5		; $615a
	xor a			; $615d
	call specialObjectSetAnimation		; $615e
	call objectSetVisiblec1		; $6161
	call itemIncState		; $6164
	ld l,$24		; $6167
	ld a,$80		; $6169
	ldi (hl),a		; $616b
	inc l			; $616c
	ld a,$06		; $616d
	ldi (hl),a		; $616f
	ldi (hl),a		; $6170
	ld l,$01		; $6171
	ld a,(hl)		; $6173
	cp $02			; $6174
	ret nz			; $6176
	ld l,$06		; $6177
	ld (hl),$e0		; $6179
	inc l			; $617b
	ld (hl),$01		; $617c
	ld a,$9a		; $617e
	call playSound		; $6180
	jr _label_05_227		; $6183
_label_05_225:
	ld a,$83		; $6185
	call playSound		; $6187
_label_05_226:
	xor a			; $618a
	call setLinkIDOverride		; $618b
	ld a,$01		; $618e
	ld ($cc71),a		; $6190
	ld e,$01		; $6193
	ld a,(de)		; $6195
	cp $02			; $6196
	ret nz			; $6198
_label_05_227:
	ld b,$02		; $6199
	jp objectCreateInteractionWithSubid00		; $619b
_label_05_228:
	xor a			; $619e
	call setLinkID		; $619f
	ld a,$01		; $61a2
	ld ($cc71),a		; $61a4
	jp $496f		; $61a7
	ld a,($cc6a)		; $61aa
	or a			; $61ad
	jr nz,_label_05_228	; $61ae
	ld a,($c4ab)		; $61b0
	or a			; $61b3
	ret nz			; $61b4
	ld a,($cd00)		; $61b5
	and $0e			; $61b8
	ret nz			; $61ba
	call $4226		; $61bb
	ld a,($cc34)		; $61be
	or a			; $61c1
	jr nz,_label_05_226	; $61c2
	call retIfTextIsActive		; $61c4
	ld a,($cca4)		; $61c7
	and $81			; $61ca
	ret nz			; $61cc
	call decPegasusSeedCounter		; $61cd
	ld h,d			; $61d0
	ld l,$01		; $61d1
	ld a,(hl)		; $61d3
	cp $02			; $61d4
	jr nz,_label_05_229	; $61d6
	ld l,$06		; $61d8
	call decHlRef16WithCap		; $61da
	jr z,_label_05_225	; $61dd
	jr _label_05_230		; $61df
_label_05_229:
	call $4275		; $61e1
	ld a,($cc78)		; $61e4
	or a			; $61e7
	jr nz,_label_05_228	; $61e8
	ld hl,$460c		; $61ea
	ld e,$06		; $61ed
	call interBankCall		; $61ef
	ld e,$01		; $61f2
	ld a,(de)		; $61f4
	cp b			; $61f5
	ld a,b			; $61f6
	jr nz,_label_05_228	; $61f7
_label_05_230:
	call $5d53		; $61f9
	call $5c4c		; $61fc
	call $5bdf		; $61ff
	ld h,d			; $6202
	ld l,$01		; $6203
	ld a,(hl)		; $6205
	cp $02			; $6206
	jr nz,_label_05_231	; $6208
	ld l,$10		; $620a
	srl (hl)		; $620c
_label_05_231:
	ld l,$2d		; $620e
	ld a,(hl)		; $6210
	or a			; $6211
	jr nz,_label_05_236	; $6212
	ld l,$24		; $6214
	set 7,(hl)		; $6216
	ld l,$0f		; $6218
	bit 7,(hl)		; $621a
	jr z,_label_05_232	; $621c
	ld c,$20		; $621e
	call objectUpdateSpeedZ_paramC		; $6220
	jr nz,_label_05_232	; $6223
	xor a			; $6225
	ld ($cc77),a		; $6226
_label_05_232:
	ld a,($ccaf)		; $6229
	ld b,a			; $622c
	ld l,$09		; $622d
	ld a,($cc47)		; $622f
	ld (hl),a		; $6232
	or b			; $6233
	rlca			; $6234
	jr c,_label_05_236	; $6235
	ld l,$01		; $6237
	ld a,(hl)		; $6239
	cp $02			; $623a
	jr nz,_label_05_233	; $623c
	ld l,$21		; $623e
	bit 7,(hl)		; $6240
	res 7,(hl)		; $6242
	ld a,$87		; $6244
	call nz,playSound		; $6246
_label_05_233:
	ld a,($cc7b)		; $6249
	or a			; $624c
	call z,updateLinkDirectionFromAngle		; $624d
	ld a,($ccb6)		; $6250
	cp $08			; $6253
	jr z,_label_05_234	; $6255
	ld a,(wLinkImmobilized)		; $6257
	or a			; $625a
	jr nz,_label_05_234	; $625b
	call $5c88		; $625d
_label_05_234:
	call checkPegasusSeedCounter		; $6260
	jr z,_label_05_235	; $6263
	rlca			; $6265
	jr nc,_label_05_235	; $6266
	call getFreeInteractionSlot		; $6268
	jr nz,_label_05_235	; $626b
	ld (hl),$0f		; $626d
	inc l			; $626f
	inc (hl)		; $6270
	ld bc,$0500		; $6271
	call objectCopyPositionWithOffset		; $6274
_label_05_235:
	ld e,$30		; $6277
	ld a,(de)		; $6279
	or a			; $627a
	jp z,specialObjectAnimate		; $627b
	xor a			; $627e
	jp specialObjectSetAnimation		; $627f
_label_05_236:
	call checkPegasusSeedCounter		; $6282
	jr nz,_label_05_234	; $6285
	xor a			; $6287
	jp specialObjectSetAnimation		; $6288
	ld e,$04		; $628b
	ld a,(de)		; $628d
	rst_jumpTable			; $628e
	sub e			; $628f
	ld h,d			; $6290
	cp c			; $6291
	ld h,d			; $6292
	call dropLinkHeldItem		; $6293
	call clearAllParentItems		; $6296
	call $41b5		; $6299
	ld h,d			; $629c
	ld l,$04		; $629d
	inc (hl)		; $629f
	ld l,$24		; $62a0
	ld a,$80		; $62a2
	ldi (hl),a		; $62a4
	inc l			; $62a5
	ld a,$06		; $62a6
	ldi (hl),a		; $62a8
	ldi (hl),a		; $62a9
	call $62d2		; $62aa
	jp objectSetVisiblec1		; $62ad
	xor a			; $62b0
	call setLinkIDOverride		; $62b1
	ld b,$02		; $62b4
	jp objectCreateInteractionWithSubid00		; $62b6
	ld a,($c4ab)		; $62b9
	or a			; $62bc
	ret nz			; $62bd
	call $4226		; $62be
	call retIfTextIsActive		; $62c1
	ld a,($cd00)		; $62c4
	and $0e			; $62c7
	ret nz			; $62c9
	ld a,($cca4)		; $62ca
	rlca			; $62cd
	ret c			; $62ce
	call $5c4c		; $62cf
	ld hl,$d121		; $62d2
	ld a,(hl)		; $62d5
	and $3f			; $62d6
	ld e,$31		; $62d8
	ld (de),a		; $62da
	ret			; $62db
	ld hl,$5588		; $62dc
	ld e,$06		; $62df
	jp interBankCall		; $62e1
	call $4845		; $62e4
	ld e,$04		; $62e7
	ld a,(de)		; $62e9
	rst_jumpTable			; $62ea
	dec b			; $62eb
	ld h,e			; $62ec
	ld a,a			; $62ed
	ld h,e			; $62ee
	sbc h			; $62ef
	ld h,e			; $62f0
	and d			; $62f1
	ld h,h			; $62f2
	sub d			; $62f3
	ld h,e			; $62f4
	rrca			; $62f5
	ld h,l			; $62f6
	ld a,($ff00+$65)	; $62f7
	ld c,h			; $62f9
	ld h,(hl)		; $62fa
	ld d,d			; $62fb
	ld h,a			; $62fc
	xor b			; $62fd
	ld h,a			; $62fe
	inc a			; $62ff
	ld h,a			; $6300
	ld b,a			; $6301
	ld l,b			; $6302
	adc l			; $6303
	ld l,b			; $6304
	xor a			; $6305
	ld ($cc9f),a		; $6306
	call $41b5		; $6309
	ld c,$02		; $630c
	ld a,($c641)		; $630e
	and $0f			; $6311
	cp $0f			; $6313
	jr z,_label_05_237	; $6315
	dec c			; $6317
	cp $08			; $6318
	jr nc,_label_05_237	; $631a
	dec c			; $631c
_label_05_237:
	ld a,c			; $631d
	ld e,$3f		; $631e
	ld (de),a		; $6320
	or a			; $6321
	jr z,_label_05_238	; $6322
	ld a,$01		; $6324
_label_05_238:
	ld e,$28		; $6326
	ld (de),a		; $6328
	or a			; $6329
	jr z,_label_05_239	; $632a
	call checkIsLinkedGame		; $632c
	jr z,_label_05_239	; $632f
	ld a,$02		; $6331
	ld (de),a		; $6333
_label_05_239:
	call itemIncState		; $6334
	ld l,$0b		; $6337
	ld a,$10		; $6339
	ldi (hl),a		; $633b
	inc l			; $633c
	ld (hl),$b8		; $633d
	ld l,$0f		; $633f
	ld a,$88		; $6341
	ldi (hl),a		; $6343
	ld (hl),$32		; $6344
	ld l,$26		; $6346
	ld a,$08		; $6348
	ldi (hl),a		; $634a
	ld (hl),a		; $634b
	ld l,$2d		; $634c
	ld (hl),$03		; $634e
	call getRandomNumber		; $6350
	and $07			; $6353
	jr z,_label_05_240	; $6355
	ld a,$01		; $6357
_label_05_240:
	ld e,$03		; $6359
	ld (de),a		; $635b
	ld hl,$6b9e		; $635c
	rst_addDoubleIndex			; $635f
	ldi a,(hl)		; $6360
	ld h,(hl)		; $6361
	ld l,a			; $6362
	ld e,$3a		; $6363
	ldi a,(hl)		; $6365
	ld (de),a		; $6366
	inc e			; $6367
	ld (de),a		; $6368
	ld e,$18		; $6369
	ld a,l			; $636b
	ld (de),a		; $636c
	inc e			; $636d
	ld a,h			; $636e
	ld (de),a		; $636f
	ld a,(hl)		; $6370
	ld e,$09		; $6371
	ld (de),a		; $6373
	call $6425		; $6374
	call objectSetVisiblec0		; $6377
	ld a,$19		; $637a
	jp specialObjectSetAnimation		; $637c
	call $6392		; $637f
	ret nz			; $6382
	ld a,($cc02)		; $6383
	or a			; $6386
	jp nz,$6836		; $6387
	ld a,$2b		; $638a
	ld (wActiveMusic),a		; $638c
	jp playSound		; $638f
	ld hl,$d12d		; $6392
	dec (hl)		; $6395
	ret nz			; $6396
	call itemIncState		; $6397
	xor a			; $639a
	ret			; $639b
	ld a,($cba0)		; $639c
	or a			; $639f
	jr nz,_label_05_244	; $63a0
	ld hl,$d107		; $63a2
	ld a,(hl)		; $63a5
	or a			; $63a6
	jr z,_label_05_241	; $63a7
	dec (hl)		; $63a9
	ret			; $63aa
_label_05_241:
	ld l,$3d		; $63ab
	ld a,(hl)		; $63ad
	ld l,$09		; $63ae
	cp (hl)			; $63b0
	jr z,_label_05_242	; $63b1
	call $65be		; $63b3
	jr _label_05_243		; $63b6
_label_05_242:
	ld l,$06		; $63b8
	dec (hl)		; $63ba
	call z,$6425		; $63bb
	jr z,_label_05_245	; $63be
_label_05_243:
	call objectApplySpeed		; $63c0
	ld e,$3e		; $63c3
	ld a,(de)		; $63c5
	or a			; $63c6
	ret z			; $63c7
	call checkLinkID0AndControlNormal		; $63c8
	jr nc,_label_05_244	; $63cb
	call objectCheckCollidedWithLink_ignoreZ		; $63cd
	jr c,_label_05_247	; $63d0
_label_05_244:
	call $659f		; $63d2
	jp specialObjectAnimate		; $63d5
_label_05_245:
	ld hl,$d13e		; $63d8
	ld a,(hl)		; $63db
	or a			; $63dc
	jp nz,$6836		; $63dd
	inc (hl)		; $63e0
	call $6ab7		; $63e1
	ld l,$10		; $63e4
	ld (hl),$50		; $63e6
	ld l,$07		; $63e8
	ld (hl),$3c		; $63ea
	ld e,$3f		; $63ec
	ld a,(de)		; $63ee
	ld e,$03		; $63ef
	or a			; $63f1
	jr z,_label_05_246	; $63f2
	set 2,e			; $63f4
	cp $01			; $63f6
	jr z,_label_05_246	; $63f8
	set 3,e			; $63fa
_label_05_246:
	call getRandomNumber		; $63fc
	and e			; $63ff
	ld hl,$6bb8		; $6400
	rst_addAToHl			; $6403
	ld a,(hl)		; $6404
	ld hl,$6bc8		; $6405
	rst_addDoubleIndex			; $6408
	ld e,$0b		; $6409
	ldi a,(hl)		; $640b
	ld h,(hl)		; $640c
	ld l,a			; $640d
	ldi a,(hl)		; $640e
	ld (de),a		; $640f
	ld e,$0d		; $6410
	ldi a,(hl)		; $6412
	ld (de),a		; $6413
	ldi a,(hl)		; $6414
	ld e,$3a		; $6415
	ld (de),a		; $6417
	inc e			; $6418
	ld (de),a		; $6419
	ld a,(hl)		; $641a
	ld e,$09		; $641b
	ld (de),a		; $641d
	ld e,$18		; $641e
	ld a,l			; $6420
	ld (de),a		; $6421
	inc e			; $6422
	ld a,h			; $6423
	ld (de),a		; $6424
	ld hl,$d118		; $6425
	ldi a,(hl)		; $6428
	ld h,(hl)		; $6429
	ld l,a			; $642a
	ld e,$3d		; $642b
	ldi a,(hl)		; $642d
	ld (de),a		; $642e
	ld c,a			; $642f
	ld e,$06		; $6430
	ldi a,(hl)		; $6432
	ld (de),a		; $6433
	ld e,$18		; $6434
	ld a,l			; $6436
	ld (de),a		; $6437
	inc e			; $6438
	ld a,h			; $6439
	ld (de),a		; $643a
	ld a,c			; $643b
	cp $ff			; $643c
	ret z			; $643e
	jp $65d2		; $643f
_label_05_247:
	call dropLinkHeldItem		; $6442
	call $68df		; $6445
	ld a,$01		; $6448
	ld ($ccab),a		; $644a
	ld ($cc02),a		; $644d
	ld a,$3c		; $6450
	ld ($cc85),a		; $6452
	ld e,$06		; $6455
	xor a			; $6457
	ld (de),a		; $6458
	call $6aca		; $6459
	ld b,a			; $645c
	ld hl,$d02d		; $645d
	ld (hl),$18		; $6460
	ld e,$09		; $6462
	ld l,$2c		; $6464
	ld (hl),a		; $6466
	xor $10			; $6467
	ld (de),a		; $6469
	ld e,$28		; $646a
	ld a,(de)		; $646c
	ld hl,$649f		; $646d
	rst_addAToHl			; $6470
	ld a,(hl)		; $6471
	ld e,$10		; $6472
	ld (de),a		; $6474
	ld e,$3a		; $6475
	ld a,$fc		; $6477
	ld (de),a		; $6479
	ld a,$0f		; $647a
	ld ($cd19),a		; $647c
	ld e,$04		; $647f
	ld a,$03		; $6481
	ld (de),a		; $6483
	ld a,b			; $6484
	add $04			; $6485
	add a			; $6487
	add a			; $6488
	swap a			; $6489
	and $01			; $648b
	xor $01			; $648d
	add $10			; $648f
	ld b,a			; $6491
	ld e,$28		; $6492
	ld a,(de)		; $6494
	add a			; $6495
	add b			; $6496
	call specialObjectSetAnimation		; $6497
	ld a,$85		; $649a
	jp playSound		; $649c
	jr z,_label_05_250	; $649f
	inc a			; $64a1
	ld a,($d02d)		; $64a2
	or a			; $64a5
	jr nz,_label_05_248	; $64a6
	ld a,$01		; $64a8
	ld ($cca4),a		; $64aa
_label_05_248:
	ld h,d			; $64ad
	ld e,$3a		; $64ae
	ld a,(de)		; $64b0
	or a			; $64b1
	jr z,_label_05_250	; $64b2
	ld e,$0f		; $64b4
	ld a,(de)		; $64b6
	or a			; $64b7
	jr nz,_label_05_249	; $64b8
	ld e,$3a		; $64ba
	ld l,$15		; $64bc
	ld a,(de)		; $64be
	inc a			; $64bf
	ld (de),a		; $64c0
	ld (hl),a		; $64c1
_label_05_249:
	ld c,$40		; $64c2
	call objectUpdateSpeedZ_paramC		; $64c4
	call objectApplySpeed		; $64c7
	call $68ae		; $64ca
	call objectGetTileCollisions		; $64cd
	ret z			; $64d0
	jr _label_05_251		; $64d1
_label_05_250:
	ld a,($cca4)		; $64d3
	or a			; $64d6
	ret z			; $64d7
	ld e,$21		; $64d8
	ld a,(de)		; $64da
	cp $ff			; $64db
	jp nz,specialObjectAnimate		; $64dd
	ld e,$2d		; $64e0
	ld a,$78		; $64e2
	ld (de),a		; $64e4
	ld e,$04		; $64e5
	ld a,$04		; $64e7
	ld (de),a		; $64e9
	ret			; $64ea
_label_05_251:
	ld e,$09		; $64eb
	call convertAngleDeToDirection		; $64ed
	ld hl,$6507		; $64f0
	rst_addDoubleIndex			; $64f3
	ld e,$0b		; $64f4
	ld a,(de)		; $64f6
	add (hl)		; $64f7
	ld b,a			; $64f8
	inc hl			; $64f9
	ld e,$0d		; $64fa
	ld a,(de)		; $64fc
	add (hl)		; $64fd
	ld c,a			; $64fe
	ld h,d			; $64ff
	ld l,$0b		; $6500
	ld (hl),b		; $6502
	ld l,$0d		; $6503
	ld (hl),c		; $6505
	ret			; $6506
	inc b			; $6507
	nop			; $6508
	nop			; $6509
.DB $fc				; $650a
.DB $fc				; $650b
	nop			; $650c
	nop			; $650d
	inc b			; $650e
	ld hl,$d106		; $650f
	ld a,(hl)		; $6512
	or a			; $6513
	jr nz,_label_05_252	; $6514
	inc (hl)		; $6516
	call $6ab7		; $6517
	ld l,$0f		; $651a
	ld (hl),$ff		; $651c
	ld a,$01		; $651e
	ld l,$3a		; $6520
	ldi (hl),a		; $6522
	ld (hl),a		; $6523
	ld e,$09		; $6524
	ld a,(de)		; $6526
	xor $10			; $6527
	ld (de),a		; $6529
	call $65d2		; $652a
_label_05_252:
	ld e,$28		; $652d
	ld a,(de)		; $652f
	ld c,a			; $6530
	ld e,$0f		; $6531
	ld a,(de)		; $6533
	dec a			; $6534
	ld (de),a		; $6535
	cp $f9			; $6536
	ret nc			; $6538
	ld a,c			; $6539
	or a			; $653a
	jr z,_label_05_253	; $653b
	ld a,(de)		; $653d
	cp $e9			; $653e
	ret nc			; $6540
_label_05_253:
	ld a,($c641)		; $6541
	bit 4,a			; $6544
	jr nz,_label_05_255	; $6546
	ld l,$04		; $6548
	ld (hl),$06		; $654a
	ld e,$28		; $654c
	ld a,(de)		; $654e
	ld hl,$6599		; $654f
	rst_addDoubleIndex			; $6552
	ld e,$26		; $6553
	ldi a,(hl)		; $6555
	ld (de),a		; $6556
	inc e			; $6557
	ld a,(hl)		; $6558
	ld (de),a		; $6559
	ld a,($c641)		; $655a
	and $0f			; $655d
	ld bc,$0700		; $655f
	jr z,_label_05_254	; $6562
	ld c,$05		; $6564
	cp $05			; $6566
	jr nc,_label_05_254	; $6568
	call getRandomNumber		; $656a
	and $03			; $656d
	ld hl,$6595		; $656f
	rst_addAToHl			; $6572
	ld c,(hl)		; $6573
_label_05_254:
	call showText		; $6574
	xor a			; $6577
	ld ($cca4),a		; $6578
	ld ($cc02),a		; $657b
	jp $6ad0		; $657e
_label_05_255:
	ld a,$0b		; $6581
	ld l,$04		; $6583
	ld (hl),a		; $6585
	ld l,$08		; $6586
	ldi (hl),a		; $6588
	ld (hl),$ff		; $6589
	ld l,$10		; $658b
	ld (hl),$28		; $658d
	ld bc,$0709		; $658f
	jp showText		; $6592
	ld bc,$0302		; $6595
	inc b			; $6598
	ld (bc),a		; $6599
	ld (bc),a		; $659a
	ld (bc),a		; $659b
	ld (bc),a		; $659c
	inc b			; $659d
	inc b			; $659e
	ld h,d			; $659f
	ld e,$28		; $65a0
	ld a,(de)		; $65a2
	cp $02			; $65a3
	ret z			; $65a5
	ld c,$00		; $65a6
	call objectUpdateSpeedZ_paramC		; $65a8
	ld l,$3c		; $65ab
	ld a,(hl)		; $65ad
	dec a			; $65ae
	ld (hl),a		; $65af
	ret nz			; $65b0
	ld a,$16		; $65b1
	ld (hl),a		; $65b3
	ld l,$14		; $65b4
	ld a,(hl)		; $65b6
	cpl			; $65b7
	inc a			; $65b8
	ldi (hl),a		; $65b9
	ld a,(hl)		; $65ba
	cpl			; $65bb
	ld (hl),a		; $65bc
	ret			; $65bd
	ld hl,$d13b		; $65be
	dec (hl)		; $65c1
	ret nz			; $65c2
	ld e,$3a		; $65c3
	ld a,(de)		; $65c5
	ld (hl),a		; $65c6
	ld l,$09		; $65c7
	ld e,$3d		; $65c9
	ld l,(hl)		; $65cb
	ldh (<hFF8B),a	; $65cc
	ld a,(de)		; $65ce
	call objectNudgeAngleTowards		; $65cf
	ld e,$3e		; $65d2
	ld a,(de)		; $65d4
	or a			; $65d5
	jr z,_label_05_256	; $65d6
	ld h,d			; $65d8
	ld l,$09		; $65d9
	ld a,(hl)		; $65db
	call convertAngleToDirection		; $65dc
	add $04			; $65df
	ld b,a			; $65e1
	ld e,$28		; $65e2
	ld a,(de)		; $65e4
	add a			; $65e5
	add a			; $65e6
	add b			; $65e7
	ld l,$30		; $65e8
	cp (hl)			; $65ea
	call nz,specialObjectSetAnimation		; $65eb
_label_05_256:
	or d			; $65ee
	ret			; $65ef
	call $659f		; $65f0
	call specialObjectAnimate		; $65f3
	call retIfTextIsActive		; $65f6
	ld a,(wActiveMusic)		; $65f9
	cp $2c			; $65fc
	jr z,_label_05_257	; $65fe
	ld a,$2c		; $6600
	ld (wActiveMusic),a		; $6602
	call playSound		; $6605
_label_05_257:
	ld l,$3d		; $6608
	ld a,(hl)		; $660a
	ld l,$09		; $660b
	cp (hl)			; $660d
	call nz,$65be		; $660e
	call $6ad0		; $6611
	call objectApplySpeed		; $6614
	ld e,$18		; $6617
	ld a,(de)		; $6619
	ld h,a			; $661a
	inc e			; $661b
	ld a,(de)		; $661c
	ld l,a			; $661d
	call checkObjectsCollided		; $661e
	jp nc,$68ae		; $6621
	ld e,$18		; $6624
	ld a,(de)		; $6626
	ld h,a			; $6627
	inc e			; $6628
	ld a,(de)		; $6629
	or $04			; $662a
	ld l,a			; $662c
	ld (hl),$04		; $662d
	inc l			; $662f
	ld (hl),$00		; $6630
	ld a,(de)		; $6632
	or $03			; $6633
	ld l,a			; $6635
	ld a,(hl)		; $6636
	ld e,$2e		; $6637
	ld (de),a		; $6639
	ld e,$04		; $663a
	ld a,$07		; $663c
	ld (de),a		; $663e
	ld e,$28		; $663f
	ld a,(de)		; $6641
	or a			; $6642
	call z,$6b73		; $6643
	ret z			; $6646
	add $16			; $6647
	jp specialObjectSetAnimation		; $6649
	call specialObjectAnimate		; $664c
	ld e,$28		; $664f
	ld a,(de)		; $6651
	cp $01			; $6652
	jp nz,$66e8		; $6654
	ld e,$26		; $6657
	ld a,$08		; $6659
	ld (de),a		; $665b
	inc e			; $665c
	ld a,$0a		; $665d
	ld (de),a		; $665f
	call $6a8c		; $6660
	jr nz,_label_05_258	; $6663
	call checkObjectsCollided		; $6665
	jr c,_label_05_259	; $6668
_label_05_258:
	call $6a9a		; $666a
	jr nz,_label_05_264	; $666d
	call checkObjectsCollided		; $666f
	jr c,_label_05_259	; $6672
	ld e,$16		; $6674
	xor a			; $6676
	ld (de),a		; $6677
	inc e			; $6678
	ld (de),a		; $6679
	jr _label_05_264		; $667a
_label_05_259:
	ld l,$2f		; $667c
	set 7,(hl)		; $667e
	ld b,$00		; $6680
	ld l,$0b		; $6682
	ld e,l			; $6684
	ld a,(de)		; $6685
	cp (hl)			; $6686
	jr z,_label_05_261	; $6687
	inc b			; $6689
	jr c,_label_05_260	; $668a
	inc (hl)		; $668c
	jr _label_05_261		; $668d
_label_05_260:
	dec (hl)		; $668f
_label_05_261:
	ld l,$0d		; $6690
	ld e,l			; $6692
	ld a,(de)		; $6693
	cp (hl)			; $6694
	jr z,_label_05_263	; $6695
	inc b			; $6697
	jr c,_label_05_262	; $6698
	inc (hl)		; $669a
	jr _label_05_263		; $669b
_label_05_262:
	dec (hl)		; $669d
_label_05_263:
	ld a,b			; $669e
	or a			; $669f
	jr nz,_label_05_264	; $66a0
	ld l,$0e		; $66a2
	ld a,(hl)		; $66a4
	sub $40			; $66a5
	ldi (hl),a		; $66a7
	ld a,(hl)		; $66a8
	sbc $00			; $66a9
	ld (hl),a		; $66ab
	cp $f8			; $66ac
	jr nz,_label_05_264	; $66ae
	ld l,$2f		; $66b0
	set 5,(hl)		; $66b2
	ld a,$1a		; $66b4
	call specialObjectSetAnimation		; $66b6
	ld h,d			; $66b9
	ld l,$04		; $66ba
	ld (hl),$08		; $66bc
	inc l			; $66be
	ld (hl),$00		; $66bf
	ld l,$07		; $66c1
	ld (hl),$20		; $66c3
	ld e,$18		; $66c5
	ld a,(de)		; $66c7
	ld h,a			; $66c8
	inc e			; $66c9
	ld a,(de)		; $66ca
	ld l,a			; $66cb
	ld a,(hl)		; $66cc
	or a			; $66cd
	jr z,_label_05_264	; $66ce
	ld a,(de)		; $66d0
	add $04			; $66d1
	ld l,a			; $66d3
	ld (hl),$01		; $66d4
	add $05			; $66d6
	ld l,a			; $66d8
	ld (hl),$80		; $66d9
	xor a			; $66db
	ld e,$18		; $66dc
	ld (de),a		; $66de
_label_05_264:
	ld e,$26		; $66df
	ld a,$02		; $66e1
	ld (de),a		; $66e3
	inc e			; $66e4
	ld a,$02		; $66e5
	ld (de),a		; $66e7
	ld e,$18		; $66e8
	ld a,(de)		; $66ea
	or a			; $66eb
	ret z			; $66ec
	ld h,a			; $66ed
	inc e			; $66ee
	ld a,(de)		; $66ef
	ld l,a			; $66f0
	ldi a,(hl)		; $66f1
	or a			; $66f2
	jr z,_label_05_265	; $66f3
	inc l			; $66f5
	bit 7,(hl)		; $66f6
	jr nz,_label_05_265	; $66f8
	ld e,$25		; $66fa
	ld a,(de)		; $66fc
	or a			; $66fd
	ret z			; $66fe
	ld e,$18		; $66ff
	ld a,(de)		; $6701
	ld h,a			; $6702
	ld l,$c3		; $6703
	ld a,$80		; $6705
	ld (hl),a		; $6707
	xor a			; $6708
	ld l,$eb		; $6709
	ld (hl),a		; $670b
	ld l,$e4		; $670c
	ld (hl),a		; $670e
	ld e,$2e		; $670f
	ld a,(de)		; $6711
	ld hl,$69b2		; $6712
	rst_addAToHl			; $6715
	ld a,$0e		; $6716
	ld (de),a		; $6718
	ld e,$29		; $6719
	ld a,(de)		; $671b
	ld b,a			; $671c
	ld a,(hl)		; $671d
	add b			; $671e
	ld (de),a		; $671f
	ld e,$28		; $6720
	ld a,(de)		; $6722
	or a			; $6723
	jr nz,_label_05_265	; $6724
	ld a,$0a		; $6726
	jr _label_05_266		; $6728
_label_05_265:
	ld h,d			; $672a
	ld l,$16		; $672b
	ldi a,(hl)		; $672d
	or (hl)			; $672e
	ret nz			; $672f
	ld a,$06		; $6730
_label_05_266:
	ld e,$04		; $6732
	ld (de),a		; $6734
	ld e,$3d		; $6735
	ld a,(de)		; $6737
	ld e,$09		; $6738
	ld (de),a		; $673a
	ret			; $673b
	call specialObjectAnimate		; $673c
	call itemDecCounter2		; $673f
	ret nz			; $6742
	ld l,$04		; $6743
	ld (hl),$06		; $6745
	ld l,$08		; $6747
	ld a,(hl)		; $6749
	ld l,$0f		; $674a
	ld (hl),a		; $674c
	ld a,$04		; $674d
	jp specialObjectSetAnimation		; $674f
	call specialObjectAnimate		; $6752
	ld e,$05		; $6755
	ld a,(de)		; $6757
	rst_jumpTable			; $6758
	ld h,c			; $6759
	ld h,a			; $675a
	ld (hl),e		; $675b
	ld h,a			; $675c
	add d			; $675d
	ld h,a			; $675e
	adc a			; $675f
	ld h,a			; $6760
	call itemDecCounter2		; $6761
	ret nz			; $6764
	ld l,$05		; $6765
	ld (hl),$01		; $6767
	ld l,$14		; $6769
	xor a			; $676b
	ldi (hl),a		; $676c
	ld (hl),a		; $676d
	ld a,$13		; $676e
	jp specialObjectSetAnimation		; $6770
	ld c,$40		; $6773
	call objectUpdateSpeedZ_paramC		; $6775
	ret nz			; $6778
	ld l,$05		; $6779
	ld (hl),$02		; $677b
	ld l,$07		; $677d
	ld (hl),$40		; $677f
	ret			; $6781
	call itemDecCounter2		; $6782
	ret nz			; $6785
	ld l,$05		; $6786
	ld (hl),$03		; $6788
	ld a,$08		; $678a
	jp specialObjectSetAnimation		; $678c
	ld h,d			; $678f
	ld l,$0f		; $6790
	dec (hl)		; $6792
	ld a,(hl)		; $6793
	cp $e9			; $6794
	ret nc			; $6796
	ld l,$04		; $6797
	ld (hl),$06		; $6799
	ld l,$29		; $679b
	inc (hl)		; $679d
	ld l,$14		; $679e
	ld a,$40		; $67a0
	ldi (hl),a		; $67a2
	ld (hl),$00		; $67a3
	jp $6ad0		; $67a5
	call specialObjectAnimate		; $67a8
	ld e,$05		; $67ab
	ld a,(de)		; $67ad
	rst_jumpTable			; $67ae
	or l			; $67af
	ld h,a			; $67b0
	or $67			; $67b1
	inc e			; $67b3
	ld l,b			; $67b4
	call retIfTextIsActive		; $67b5
	ld a,$3c		; $67b8
	ld ($cc85),a		; $67ba
	ld a,$01		; $67bd
	ld (de),a		; $67bf
	ld h,d			; $67c0
	ld l,$29		; $67c1
	ldi a,(hl)		; $67c3
	ld b,a			; $67c4
	or (hl)			; $67c5
	jr z,_label_05_267	; $67c6
	ld a,(hl)		; $67c8
	cp b			; $67c9
	ld a,$01		; $67ca
	jr z,_label_05_267	; $67cc
	inc a			; $67ce
	jr c,_label_05_267	; $67cf
	inc a			; $67d1
_label_05_267:
	ld hl,$67ee		; $67d2
	rst_addDoubleIndex			; $67d5
	ld c,(hl)		; $67d6
	inc hl			; $67d7
	ld b,(hl)		; $67d8
	call showText		; $67d9
	call $6aca		; $67dc
	call convertAngleToDirection		; $67df
	add $04			; $67e2
	ld b,a			; $67e4
	ld e,$28		; $67e5
	ld a,(de)		; $67e7
	add a			; $67e8
	add a			; $67e9
	add b			; $67ea
	jp specialObjectSetAnimation		; $67eb
	inc c			; $67ee
	rlca			; $67ef
	ld ($0607),sp		; $67f0
	rlca			; $67f3
	rlca			; $67f4
	rlca			; $67f5
	call $659f		; $67f6
	call retIfTextIsActive		; $67f9
	ld a,$80		; $67fc
	ld ($cba0),a		; $67fe
	ld a,$1f		; $6801
	ld ($cca4),a		; $6803
	ld l,$09		; $6806
	ld (hl),$18		; $6808
	ld l,$10		; $680a
	ld (hl),$78		; $680c
	ld l,$05		; $680e
	ld (hl),$02		; $6810
	ld e,$28		; $6812
	ld a,(de)		; $6814
	add a			; $6815
	add a			; $6816
	add $07			; $6817
	jp specialObjectSetAnimation		; $6819
	call $659f		; $681c
	call objectApplySpeed		; $681f
	call objectCheckWithinScreenBoundary		; $6822
	ret c			; $6825
	xor a			; $6826
	ld ($cba0),a		; $6827
	ld ($cca4),a		; $682a
	ld ($cc02),a		; $682d
	ld ($ccab),a		; $6830
	call $6b8e		; $6833
	ld a,($cc62)		; $6836
	ld (wActiveMusic),a		; $6839
	call playSound		; $683c
	pop af			; $683f
	xor a			; $6840
	ld ($cc3a),a		; $6841
	jp itemDelete		; $6844
	inc e			; $6847
	ld a,(de)		; $6848
	or a			; $6849
	jr nz,_label_05_269	; $684a
	call $659f		; $684c
	call objectGetLinkRelativeAngle		; $684f
	call convertAngleToDirection		; $6852
	ld h,d			; $6855
	ld l,$08		; $6856
	cp (hl)			; $6858
	ld (hl),a		; $6859
	jr z,_label_05_268	; $685a
	add $04			; $685c
	ld b,a			; $685e
	ld e,$28		; $685f
	ld a,(de)		; $6861
	add a			; $6862
	add a			; $6863
	add b			; $6864
	call specialObjectSetAnimation		; $6865
_label_05_268:
	call retIfTextIsActive		; $6868
	ld hl,$c641		; $686b
	set 5,(hl)		; $686e
	ld e,$09		; $6870
	ld a,(de)		; $6872
	rlca			; $6873
	jp nc,objectApplySpeed		; $6874
	ret			; $6877
_label_05_269:
	dec a			; $6878
	ld (de),a		; $6879
	ret nz			; $687a
	ld bc,$070b		; $687b
	call showText		; $687e
	ld e,$09		; $6881
	ld a,$18		; $6883
	ld (de),a		; $6885
	call itemIncState		; $6886
	ld l,$10		; $6889
	ld (hl),$78		; $688b
	call $659f		; $688d
	call retIfTextIsActive		; $6890
	call objectApplySpeed		; $6893
	ld e,$28		; $6896
	ld a,(de)		; $6898
	add a			; $6899
	add a			; $689a
	add $07			; $689b
	ld hl,$c641		; $689d
	bit 4,(hl)		; $68a0
	res 4,(hl)		; $68a2
	call nz,specialObjectSetAnimation		; $68a4
	call objectCheckWithinScreenBoundary		; $68a7
	ret c			; $68aa
	jp $6826		; $68ab
	ld e,$0b		; $68ae
	ld a,(de)		; $68b0
	cp $f0			; $68b1
	jr c,_label_05_270	; $68b3
	xor a			; $68b5
_label_05_270:
	cp $20			; $68b6
	jr nc,_label_05_271	; $68b8
	ld a,$20		; $68ba
	ld (de),a		; $68bc
	jr _label_05_272		; $68bd
_label_05_271:
	cp $78			; $68bf
	jr c,_label_05_272	; $68c1
	ld a,$78		; $68c3
	ld (de),a		; $68c5
_label_05_272:
	ld e,$0d		; $68c6
	ld a,(de)		; $68c8
	cp $f0			; $68c9
	jr c,_label_05_273	; $68cb
	xor a			; $68cd
_label_05_273:
	cp $08			; $68ce
	jr nc,_label_05_274	; $68d0
	ld a,$08		; $68d2
	ld (de),a		; $68d4
	jr _label_05_275		; $68d5
_label_05_274:
	cp $98			; $68d7
	jr c,_label_05_275	; $68d9
	ld a,$98		; $68db
	ld (de),a		; $68dd
_label_05_275:
	ret			; $68de
	ld a,$41		; $68df
	call checkTreasureObtained		; $68e1
	jr nc,_label_05_276	; $68e4
	cp $01			; $68e6
	jr nz,_label_05_276	; $68e8
	ld b,$94		; $68ea
	call objectCreateInteractionWithSubid00		; $68ec
	ret nz			; $68ef
	ld hl,$c641		; $68f0
	set 4,(hl)		; $68f3
	ret			; $68f5
_label_05_276:
	ld e,$2a		; $68f6
	xor a			; $68f8
	ld (de),a		; $68f9
	ld e,$29		; $68fa
	ld (de),a		; $68fc
	ld e,$06		; $68fd
	ld a,$05		; $68ff
	ld (de),a		; $6901
_label_05_277:
	ld e,$03		; $6902
	ld a,(de)		; $6904
	ld hl,$6984		; $6905
	rst_addDoubleIndex			; $6908
	ldi a,(hl)		; $6909
	ld h,(hl)		; $690a
	ld l,a			; $690b
	call getRandomIndexFromProbabilityDistribution		; $690c
	ld a,b			; $690f
	call $6948		; $6910
	jr c,_label_05_278	; $6913
	jr nz,_label_05_277	; $6915
_label_05_278:
	ld e,$06		; $6917
	ld a,(de)		; $6919
	dec a			; $691a
	ld (de),a		; $691b
	jr nz,_label_05_277	; $691c
	ld a,$20		; $691e
	ldh (<hFF8C),a	; $6920
	ld e,$06		; $6922
	ld a,$05		; $6924
	ld (de),a		; $6926
_label_05_279:
	ldh a,(<hFF8C)	; $6927
	dec a			; $6929
	ldh (<hFF8C),a	; $692a
	jr z,_label_05_280	; $692c
	ld hl,$69a4		; $692e
	call getRandomIndexFromProbabilityDistribution		; $6931
	call $6b00		; $6934
	jr z,_label_05_279	; $6937
	ld d,$d0		; $6939
	call $69cf		; $693b
	ld d,$d1		; $693e
	ld e,$06		; $6940
	ld a,(de)		; $6942
	dec a			; $6943
	ld (de),a		; $6944
	jr nz,_label_05_279	; $6945
_label_05_280:
	ret			; $6947
	push af			; $6948
	ld hl,$69c1		; $6949
	rst_addAToHl			; $694c
	ld a,(hl)		; $694d
	call checkTreasureObtained		; $694e
	pop hl			; $6951
	jr c,_label_05_281	; $6952
	or d			; $6954
	ret			; $6955
_label_05_281:
	ld a,h			; $6956
	ldh (<hFF8B),a	; $6957
	cp $05			; $6959
	jp nc,$69cf		; $695b
	or a			; $695e
	jr nz,_label_05_282	; $695f
	ld a,($c641)		; $6961
	bit 7,a			; $6964
	ret nz			; $6966
	ld e,$2b		; $6967
	ld a,(de)		; $6969
	or a			; $696a
	ret nz			; $696b
	inc a			; $696c
	ld (de),a		; $696d
	jr _label_05_283		; $696e
_label_05_282:
	dec a			; $6970
	ld hl,$6980		; $6971
	rst_addAToHl			; $6974
	ld b,(hl)		; $6975
	ld e,$2c		; $6976
	ld a,(de)		; $6978
	and b			; $6979
	ret nz			; $697a
	ld a,(de)		; $697b
	or b			; $697c
	ld (de),a		; $697d
_label_05_283:
	jr _label_05_289		; $697e
	inc b			; $6980
	ld (bc),a		; $6981
	ld (bc),a		; $6982
	ld bc,$6988		; $6983
	sub (hl)		; $6986
	ld l,c			; $6987
	inc d			; $6988
	ld c,$0e		; $6989
	ld e,$20		; $698b
	nop			; $698d
	nop			; $698e
	nop			; $698f
	nop			; $6990
	nop			; $6991
	jr z,_label_05_285	; $6992
	jr z,$14		; $6994
	nop			; $6996
	ld (bc),a		; $6997
	inc b			; $6998
	ld ($000a),sp		; $6999
	nop			; $699c
	nop			; $699d
	nop			; $699e
	nop			; $699f
	ldd (hl),a		; $69a0
	inc (hl)		; $69a1
	inc a			; $69a2
	ld b,(hl)		; $69a3
	nop			; $69a4
	nop			; $69a5
	nop			; $69a6
	nop			; $69a7
	nop			; $69a8
	jr nz,_label_05_286	; $69a9
	jr nz,_label_05_287	; $69ab
	jr nz,_label_05_288	; $69ad
	jr nz,_label_05_284	; $69af
_label_05_284:
	jr nz,_label_05_290	; $69b1
	rrca			; $69b3
	ld a,(bc)		; $69b4
	ld ($0506),sp		; $69b5
	dec b			; $69b8
	dec b			; $69b9
	dec b			; $69ba
	dec b			; $69bb
	inc b			; $69bc
	inc bc			; $69bd
	ld (bc),a		; $69be
	ld bc,$0200		; $69bf
_label_05_285:
	ld (bc),a		; $69c2
	ld (bc),a		; $69c3
	ld (bc),a		; $69c4
	ld (bc),a		; $69c5
	jr nz,$21		; $69c6
	ldi (hl),a		; $69c8
	inc hl			; $69c9
	inc h			; $69ca
_label_05_286:
	inc bc			; $69cb
	ld (bc),a		; $69cc
_label_05_287:
	ld (bc),a		; $69cd
	ld (bc),a		; $69ce
_label_05_288:
	call getFreePartSlot		; $69cf
	scf			; $69d2
	ret nz			; $69d3
	ld (hl),$14		; $69d4
	ld e,$0b		; $69d6
	call objectCopyPosition_rawAddress		; $69d8
	ldh a,(<hFF8B)	; $69db
	ld l,$c3		; $69dd
	ldd (hl),a		; $69df
	ld (hl),a		; $69e0
	xor a			; $69e1
	ret			; $69e2
_label_05_289:
	call getFreePartSlot		; $69e3
	scf			; $69e6
	ret nz			; $69e7
	ld (hl),$15		; $69e8
	ld l,$c2		; $69ea
	ldh a,(<hFF8B)	; $69ec
	ldi (hl),a		; $69ee
_label_05_290:
	ld (hl),a		; $69ef
	call objectCopyPosition		; $69f0
	or a			; $69f3
	ret			; $69f4
	ld b,$00		; $69f5
_label_05_291:
	ld hl,$d0c0		; $69f7
_label_05_292:
	ld l,$c0		; $69fa
	ldi a,(hl)		; $69fc
	or a			; $69fd
	jr z,_label_05_293	; $69fe
	ldi a,(hl)		; $6a00
	cp $15			; $6a01
	jr nz,_label_05_293	; $6a03
	ldd a,(hl)		; $6a05
	cp b			; $6a06
	jr nz,_label_05_293	; $6a07
	dec l			; $6a09
	xor a			; $6a0a
	ret			; $6a0b
_label_05_293:
	inc h			; $6a0c
	ld a,h			; $6a0d
	cp $e0			; $6a0e
	jr c,_label_05_292	; $6a10
	inc b			; $6a12
	ld a,b			; $6a13
	cp $05			; $6a14
	jr c,_label_05_291	; $6a16
	xor a			; $6a18
	ld c,$00		; $6a19
	ld hl,$6a83		; $6a1b
	rst_addAToHl			; $6a1e
	ld a,(hl)		; $6a1f
	ld b,a			; $6a20
	xor a			; $6a21
	ldh (<hFF91),a	; $6a22
_label_05_294:
	ld hl,$d0c0		; $6a24
_label_05_295:
	ld l,$c0		; $6a27
	ldi a,(hl)		; $6a29
	or a			; $6a2a
	jr z,_label_05_299	; $6a2b
	ldi a,(hl)		; $6a2d
	cp $14			; $6a2e
	jr nz,_label_05_299	; $6a30
	ldd a,(hl)		; $6a32
	cp b			; $6a33
	jr nz,_label_05_299	; $6a34
	ld l,$cb		; $6a36
	ld l,(hl)		; $6a38
	ld e,$0b		; $6a39
	ld a,(de)		; $6a3b
	sub l			; $6a3c
	jr nc,_label_05_296	; $6a3d
	cpl			; $6a3f
	inc a			; $6a40
_label_05_296:
	ldh (<hFF8C),a	; $6a41
	ld l,$cd		; $6a43
	ld l,(hl)		; $6a45
	ld e,$0d		; $6a46
	ld a,(de)		; $6a48
	sub l			; $6a49
	jr nc,_label_05_297	; $6a4a
	cpl			; $6a4c
	inc a			; $6a4d
_label_05_297:
	ld l,a			; $6a4e
	ldh a,(<hFF8C)	; $6a4f
	add l			; $6a51
	ld l,a			; $6a52
	ldh a,(<hFF91)	; $6a53
	or a			; $6a55
	jr z,_label_05_298	; $6a56
	ldh a,(<hFF8D)	; $6a58
	cp l			; $6a5a
	jr c,_label_05_299	; $6a5b
_label_05_298:
	ld a,l			; $6a5d
	ldh (<hFF8D),a	; $6a5e
	ld a,h			; $6a60
	ldh (<hFF91),a	; $6a61
_label_05_299:
	inc h			; $6a63
	ld a,h			; $6a64
	cp $e0			; $6a65
	jr c,_label_05_295	; $6a67
	ldh a,(<hFF91)	; $6a69
	or a			; $6a6b
	jr nz,_label_05_301	; $6a6c
	inc c			; $6a6e
	ld a,c			; $6a6f
	cp $09			; $6a70
	jr nc,_label_05_300	; $6a72
	ld hl,$6a83		; $6a74
	rst_addAToHl			; $6a77
	ld a,(hl)		; $6a78
	ld b,a			; $6a79
	jr _label_05_294		; $6a7a
_label_05_300:
	and d			; $6a7c
	ret			; $6a7d
_label_05_301:
	ld h,a			; $6a7e
	ld l,$c0		; $6a7f
	xor a			; $6a81
	ret			; $6a82
	dec b			; $6a83
	ld b,$07		; $6a84
	ld ($0a09),sp		; $6a86
	dec bc			; $6a89
	inc c			; $6a8a
	dec c			; $6a8b
	ld e,$16		; $6a8c
	xor a			; $6a8e
	ld (de),a		; $6a8f
	inc e			; $6a90
	ld (de),a		; $6a91
	ld c,$03		; $6a92
	call findItemWithID		; $6a94
	ret nz			; $6a97
	jr _label_05_302		; $6a98
	ld c,$03		; $6a9a
	call findItemWithID_startingAfterH		; $6a9c
	ret nz			; $6a9f
_label_05_302:
	ld l,$2f		; $6aa0
	ld a,(hl)		; $6aa2
	bit 7,a			; $6aa3
	jr nz,_label_05_303	; $6aa5
	and $60			; $6aa7
	ret nz			; $6aa9
	ld l,$0f		; $6aaa
	bit 7,(hl)		; $6aac
	ret nz			; $6aae
_label_05_303:
	ld e,$16		; $6aaf
	ld a,h			; $6ab1
	ld (de),a		; $6ab2
	inc e			; $6ab3
	xor a			; $6ab4
	ld (de),a		; $6ab5
	ret			; $6ab6
	ld h,d			; $6ab7
	ld l,$0f		; $6ab8
	ld a,$f8		; $6aba
	ldi (hl),a		; $6abc
	ld l,$14		; $6abd
	ld (hl),$40		; $6abf
	inc l			; $6ac1
	ld (hl),$00		; $6ac2
	ld l,$3c		; $6ac4
	ld a,$16		; $6ac6
	ldi (hl),a		; $6ac8
	ret			; $6ac9
	call objectGetLinkRelativeAngle		; $6aca
	and $18			; $6acd
	ret			; $6acf
	call $69f5		; $6ad0
	jr nz,_label_05_304	; $6ad3
	ld e,$18		; $6ad5
	ld a,h			; $6ad7
	ld (de),a		; $6ad8
	inc e			; $6ad9
	ld a,l			; $6ada
	ld (de),a		; $6adb
	ld e,$25		; $6adc
	xor a			; $6ade
	ld (de),a		; $6adf
	jr _label_05_305		; $6ae0
_label_05_304:
	ld e,$04		; $6ae2
	ld a,$09		; $6ae4
	ld (de),a		; $6ae6
	inc e			; $6ae7
	xor a			; $6ae8
	ld (de),a		; $6ae9
	ret			; $6aea
_label_05_305:
	ld e,$18		; $6aeb
	ld a,(de)		; $6aed
	ld h,a			; $6aee
	inc e			; $6aef
	ld a,(de)		; $6af0
	or $0b			; $6af1
	ld l,a			; $6af3
	ldi a,(hl)		; $6af4
	ld b,a			; $6af5
	inc l			; $6af6
	ld a,(hl)		; $6af7
	ld c,a			; $6af8
	call objectGetRelativeAngle		; $6af9
	ld e,$3d		; $6afc
	ld (de),a		; $6afe
	ret			; $6aff
	ld a,b			; $6b00
	sub $05			; $6b01
	ld b,a			; $6b03
	rst_jumpTable			; $6b04
	ld a,$6b		; $6b05
	ld a,$6b		; $6b07
	ld a,$6b		; $6b09
	ld a,$6b		; $6b0b
	ld a,$6b		; $6b0d
	ld h,$6b		; $6b0f
	ld e,e			; $6b11
	ld l,e			; $6b12
	ld e,e			; $6b13
	ld l,e			; $6b14
	rla			; $6b15
	ld l,e			; $6b16
	ld hl,$c6a5		; $6b17
	ldi a,(hl)		; $6b1a
	or (hl)			; $6b1b
	ret z			; $6b1c
	ld a,$01		; $6b1d
	call removeRupeeValue		; $6b1f
	ld a,$0c		; $6b22
	jr _label_05_308		; $6b24
	ld a,$0a		; $6b26
	ldh (<hFF8B),a	; $6b28
	call checkTreasureObtained		; $6b2a
	jr nc,_label_05_306	; $6b2d
	ld hl,$c6aa		; $6b2f
	ld a,(hl)		; $6b32
	sub $04			; $6b33
	jr c,_label_05_306	; $6b35
	daa			; $6b37
	ld (hl),a		; $6b38
	call setStatusBarNeedsRefreshBit1		; $6b39
	or d			; $6b3c
	ret			; $6b3d
	ld a,b			; $6b3e
	add $05			; $6b3f
	ldh (<hFF8B),a	; $6b41
	call checkTreasureObtained		; $6b43
	jr nc,_label_05_306	; $6b46
	ld a,b			; $6b48
	ld hl,$c6b5		; $6b49
	rst_addAToHl			; $6b4c
	ld a,(hl)		; $6b4d
	sub $05			; $6b4e
	jr c,_label_05_306	; $6b50
	daa			; $6b52
	ld (hl),a		; $6b53
	call setStatusBarNeedsRefreshBit1		; $6b54
	or d			; $6b57
	ret			; $6b58
_label_05_306:
	xor a			; $6b59
	ret			; $6b5a
	ld hl,$c6a2		; $6b5b
	ld a,(hl)		; $6b5e
	cp $0c			; $6b5f
	jr nc,_label_05_307	; $6b61
	xor a			; $6b63
	ret			; $6b64
_label_05_307:
	sub $04			; $6b65
	ld (hl),a		; $6b67
	ld hl,$cbea		; $6b68
	set 2,(hl)		; $6b6b
	ld a,$0b		; $6b6d
_label_05_308:
	ldh (<hFF8B),a	; $6b6f
	or d			; $6b71
	ret			; $6b72
	ld e,$07		; $6b73
	ld a,$30		; $6b75
	ld (de),a		; $6b77
	ld e,$0f		; $6b78
	ld a,(de)		; $6b7a
	ld e,$08		; $6b7b
	ld (de),a		; $6b7d
	call objectGetTileCollisions		; $6b7e
	jr nz,_label_05_309	; $6b81
	ld e,$0f		; $6b83
	xor a			; $6b85
	ld (de),a		; $6b86
	or d			; $6b87
	ld e,$28		; $6b88
	ld a,(de)		; $6b8a
	ret			; $6b8b
_label_05_309:
	xor a			; $6b8c
	ret			; $6b8d
	ld hl,$c641		; $6b8e
	ld a,(hl)		; $6b91
_label_05_310:
	and $0f			; $6b92
	ld b,a			; $6b94
	cp $0f			; $6b95
	jr nc,_label_05_311	; $6b97
	inc b			; $6b99
_label_05_311:
	xor (hl)		; $6b9a
	or b			; $6b9b
	ld (hl),a		; $6b9c
	ret			; $6b9d
	and d			; $6b9e
	ld l,e			; $6b9f
	xor a			; $6ba0
	ld l,e			; $6ba1
	ld (bc),a		; $6ba2
	jr _label_05_313		; $6ba3
	stop			; $6ba5
	ld (bc),a		; $6ba6
	ld ($101e),sp		; $6ba7
	ld (bc),a		; $6baa
	jr _label_05_318		; $6bab
	rst $38			; $6bad
	rst $38			; $6bae
	inc b			; $6baf
	jr _label_05_314		; $6bb0
	stop			; $6bb2
	inc b			; $6bb3
	ld ($ff64),sp		; $6bb4
	rst $38			; $6bb7
	nop			; $6bb8
	ld bc,$0002		; $6bb9
	inc bc			; $6bbc
	inc b			; $6bbd
	dec b			; $6bbe
	inc bc			; $6bbf
	ld b,$07		; $6bc0
	ld bc,$0402		; $6bc2
	dec b			; $6bc5
	ld b,$07		; $6bc6
	ret c			; $6bc8
	ld l,e			; $6bc9
	rst $20			; $6bca
	ld l,e			; $6bcb
	or $6b			; $6bcc
	rrca			; $6bce
	ld l,h			; $6bcf
	ldi (hl),a		; $6bd0
	ld l,h			; $6bd1
	dec (hl)		; $6bd2
	ld l,h			; $6bd3
	ld b,h			; $6bd4
	ld l,h			; $6bd5
	ld d,a			; $6bd6
	ld l,h			; $6bd7
	jr _label_05_310		; $6bd8
	ld (bc),a		; $6bda
	jr $4b			; $6bdb
	stop			; $6bdd
	ld bc,$3208		; $6bde
	stop			; $6be1
	ld bc,$4618		; $6be2
	rst $38			; $6be5
	rst $38			; $6be6
	ld (hl),b		; $6be7
_label_05_312:
	cp b			; $6be8
	ld (bc),a		; $6be9
	jr _label_05_319		; $6bea
	nop			; $6bec
	ld bc,$3208		; $6bed
	nop			; $6bf0
	ld bc,$4618		; $6bf1
	rst $38			; $6bf4
	rst $38			; $6bf5
	jr _label_05_312		; $6bf6
	ld (bc),a		; $6bf8
	ld (queueDrawEverything),sp		; $6bf9
	add hl,de		; $6bfc
	jr _label_05_318		; $6bfd
	nop			; $6bff
	inc d			; $6c00
	ld ($1019),sp		; $6c01
	rrca			; $6c04
	jr _label_05_316		; $6c05
	nop			; $6c07
	ld a,(bc)		; $6c08
_label_05_313:
	ld ($100f),sp		; $6c09
	ldd (hl),a		; $6c0c
	rst $38			; $6c0d
	rst $38			; $6c0e
	and b			; $6c0f
	sub b			; $6c10
	ld (bc),a		; $6c11
	nop			; $6c12
	scf			; $6c13
	jr _label_05_315		; $6c14
_label_05_314:
	stop			; $6c16
_label_05_315:
	add hl,de		; $6c17
	jr _label_05_316		; $6c18
	nop			; $6c1a
_label_05_316:
	add hl,de		; $6c1b
	jr _label_05_317		; $6c1c
	stop			; $6c1e
_label_05_317:
	inc a			; $6c1f
	rst $38			; $6c20
	rst $38			; $6c21
	and b			; $6c22
	stop			; $6c23
	ld (bc),a		; $6c24
	nop			; $6c25
	scf			; $6c26
_label_05_318:
	ld ($1001),sp		; $6c27
	add hl,de		; $6c2a
	ld ($0001),sp		; $6c2b
	add hl,de		; $6c2e
	ld ($1001),sp		; $6c2f
	inc a			; $6c32
	rst $38			; $6c33
	rst $38			; $6c34
	jr _label_05_318		; $6c35
_label_05_319:
	ld bc,$2808		; $6c37
	ld d,$0f		; $6c3a
	ld ($162d),sp		; $6c3c
	ld a,(bc)		; $6c3f
	ld ($ff37),sp		; $6c40
	rst $38			; $6c43
	ld a,($ff00+$30)	; $6c44
	ld (bc),a		; $6c46
	inc d			; $6c47
	add hl,de		; $6c48
	dec b			; $6c49
	ld de,$0a14		; $6c4a
	rla			; $6c4d
	dec b			; $6c4e
	stop			; $6c4f
	ld bc,$1e05		; $6c50
	inc d			; $6c53
	ld e,$ff		; $6c54
	rst $38			; $6c56
	ld a,($ff00+$70)	; $6c57
	ld (bc),a		; $6c59
	inc c			; $6c5a
	add hl,de		; $6c5b
	dec de			; $6c5c
	ld de,$080c		; $6c5d
	ld a,(bc)		; $6c60
	ld (bc),a		; $6c61
	stop			; $6c62
	ld bc,$0f1b		; $6c63
	inc c			; $6c66
	ld e,$ff		; $6c67
	rst $38			; $6c69
	call $483a		; $6c6a
	call $47b3		; $6c6d
	call $6c76		; $6c70
	jp $48bb		; $6c73
	ld e,$04		; $6c76
	ld a,(de)		; $6c78
	rst_jumpTable			; $6c79
	sub h			; $6c7a
	ld l,h			; $6c7b
	jp nz,$ed6c		; $6c7c
	ld l,h			; $6c7f
	jr $6d			; $6c80
	ld l,$6d		; $6c82
	ld h,l			; $6c84
	ld l,l			; $6c85
	sbc e			; $6c86
	ld l,a			; $6c87
	pop de			; $6c88
	ld l,a			; $6c89
.DB $dd				; $6c8a
	ld l,(hl)		; $6c8b
.DB $ec				; $6c8c
	ld l,h			; $6c8d
	ld e,$70		; $6c8e
	sub h			; $6c90
	ld l,h			; $6c91
	cp c			; $6c92
	ld (hl),c		; $6c93
	call $47fd		; $6c94
	ld a,$06		; $6c97
	call objectSetCollideRadius		; $6c99
	ld a,$02		; $6c9c
	ld l,$08		; $6c9e
	ldi (hl),a		; $6ca0
	ld (hl),a		; $6ca1
	ld l,$39		; $6ca2
	ld (hl),$10		; $6ca4
	ld a,($c643)		; $6ca6
	and $80			; $6ca9
	jr nz,_label_05_320	; $6cab
	ld l,$04		; $6cad
	ld (hl),$0a		; $6caf
	ld e,$3d		; $6cb1
	call objectAddToAButtonSensitiveObjectList		; $6cb3
	ld a,$00		; $6cb6
	jr _label_05_321		; $6cb8
_label_05_320:
	ld a,$17		; $6cba
_label_05_321:
	call specialObjectSetAnimation		; $6cbc
	jp objectSetVisiblec1		; $6cbf
	call specialObjectAnimate		; $6cc2
	call $48ef		; $6cc5
	ld c,$09		; $6cc8
	call objectCheckLinkWithinDistance		; $6cca
	jr nc,_label_05_322	; $6ccd
	call $4552		; $6ccf
	ret z			; $6cd2
_label_05_322:
	ld e,$21		; $6cd3
	ld a,(de)		; $6cd5
	and $c0			; $6cd6
	jr z,_label_05_323	; $6cd8
	rlca			; $6cda
	ld c,$40		; $6cdb
	jp nc,objectUpdateSpeedZ_paramC		; $6cdd
	ld bc,$ff00		; $6ce0
	call objectSetSpeedZ		; $6ce3
_label_05_323:
	call $459f		; $6ce6
	jp c,$700d		; $6ce9
	ret			; $6cec
	call $495b		; $6ced
	jr z,_label_05_324	; $6cf0
	dec (hl)		; $6cf2
	ret nz			; $6cf3
	ld a,$c3		; $6cf4
	call playSound		; $6cf6
_label_05_324:
	ld c,$40		; $6cf9
	call objectUpdateSpeedZ_paramC		; $6cfb
	call specialObjectAnimate		; $6cfe
	call objectApplySpeed		; $6d01
	call $4439		; $6d04
	ld e,$33		; $6d07
	ld a,(de)		; $6d09
	and $0f			; $6d0a
	ld e,$07		; $6d0c
	jr z,_label_05_325	; $6d0e
	ld (de),a		; $6d10
	ret			; $6d11
_label_05_325:
	ld a,(de)		; $6d12
	or a			; $6d13
	ret z			; $6d14
	jp $6fe4		; $6d15
	ld c,$40		; $6d18
	call objectUpdateSpeedZ_paramC		; $6d1a
	call $4878		; $6d1d
	ret nz			; $6d20
	call $4779		; $6d21
	ld a,$c3		; $6d24
	call playSound		; $6d26
	ld c,$20		; $6d29
	jp $4547		; $6d2b
	ld e,$37		; $6d2e
	ld a,(de)		; $6d30
	cp $0e			; $6d31
	jr z,_label_05_326	; $6d33
	ld a,$0d		; $6d35
	ld (de),a		; $6d37
	call $4665		; $6d38
	ret nz			; $6d3b
_label_05_326:
	call $495b		; $6d3c
	jr nz,_label_05_327	; $6d3f
	inc (hl)		; $6d41
	ld e,$37		; $6d42
	ld a,(de)		; $6d44
	call specialObjectSetAnimation		; $6d45
	ld e,$37		; $6d48
	ld a,(de)		; $6d4a
	cp $0e			; $6d4b
	jr z,_label_05_327	; $6d4d
	ld a,$65		; $6d4f
	jp playSound		; $6d51
_label_05_327:
	call $491f		; $6d54
	ret nc			; $6d57
	ld c,$01		; $6d58
	ld a,($cc48)		; $6d5a
	rrca			; $6d5d
	jr nc,_label_05_328	; $6d5e
	ld c,$05		; $6d60
_label_05_328:
	jp $453d		; $6d62
	ld e,$05		; $6d65
	ld a,(de)		; $6d67
	rst_jumpTable			; $6d68
	ld (hl),c		; $6d69
	ld l,l			; $6d6a
	ld d,a			; $6d6b
	ld l,(hl)		; $6d6c
	xor h			; $6d6d
	ld l,(hl)		; $6d6e
	call $fa6e		; $6d6f
	or c			; $6d72
	call z,$20b7		; $6d73
	ld a,(bc)		; $6d76
	ld a,($cc46)		; $6d77
	bit 0,a			; $6d7a
	jp nz,$6f7e		; $6d7c
	bit 1,a			; $6d7f
	jp nz,$47e2		; $6d81
	ld h,d			; $6d84
	ld a,($cc47)		; $6d85
	ld l,$09		; $6d88
	ld (hl),a		; $6d8a
	rlca			; $6d8b
	ld l,$39		; $6d8c
	jr nc,_label_05_329	; $6d8e
	ld a,$10		; $6d90
	ld (hl),a		; $6d92
	ld c,$20		; $6d93
	call $4547		; $6d95
	jp $6ce6		; $6d98
_label_05_329:
	ld l,$39		; $6d9b
	ld a,(hl)		; $6d9d
	or a			; $6d9e
	jr z,_label_05_332	; $6d9f
	dec (hl)		; $6da1
	ld l,$10		; $6da2
	ld (hl),$1e		; $6da4
	ld c,$20		; $6da6
	call $4525		; $6da8
	call $6e20		; $6dab
	jp z,$7286		; $6dae
	call $4717		; $6db1
	jr nz,_label_05_330	; $6db4
	jp $7290		; $6db6
_label_05_330:
	call $7204		; $6db9
	jr nz,_label_05_331	; $6dbc
	jp $728b		; $6dbe
_label_05_331:
	call $441e		; $6dc1
	jp $6ce6		; $6dc4
_label_05_332:
	ld h,d			; $6dc7
	ld l,$09		; $6dc8
	ldd a,(hl)		; $6dca
	add a			; $6dcb
	swap a			; $6dcc
	and $03			; $6dce
	ldi (hl),a		; $6dd0
	call $728b		; $6dd1
	ld l,$09		; $6dd4
	ld a,(hl)		; $6dd6
	bit 2,a			; $6dd7
	jr nz,_label_05_334	; $6dd9
	call $4717		; $6ddb
	jr nz,_label_05_333	; $6dde
	ld ($ccab),a		; $6de0
	ld c,$0f		; $6de3
	jp $4547		; $6de5
_label_05_333:
	call $7204		; $6de8
	ld c,$0f		; $6deb
	jp z,$4547		; $6ded
_label_05_334:
	ld e,$05		; $6df0
	ld a,$02		; $6df2
	ld (de),a		; $6df4
	call $6e20		; $6df5
	jp z,$7286		; $6df8
	ld bc,$fe80		; $6dfb
	call objectSetSpeedZ		; $6dfe
	ld l,$05		; $6e01
	ld (hl),$01		; $6e03
	ld l,$06		; $6e05
	ld (hl),$08		; $6e07
	ld l,$10		; $6e09
	ld (hl),$50		; $6e0b
	ld c,$19		; $6e0d
	call $4547		; $6e0f
	call getRandomNumber		; $6e12
	and $0f			; $6e15
	ld a,$53		; $6e17
	jr nz,_label_05_335	; $6e19
	ld a,$c3		; $6e1b
_label_05_335:
	jp playSound		; $6e1d
	ld a,($cc47)		; $6e20
	and $04			; $6e23
	ret nz			; $6e25
	ld e,$08		; $6e26
	ld a,(de)		; $6e28
	ld hl,$72c6		; $6e29
	rst_addDoubleIndex			; $6e2c
	ld e,$0b		; $6e2d
	ld a,(de)		; $6e2f
	add (hl)		; $6e30
	ldh (<hFF90),a	; $6e31
	add (hl)		; $6e33
	ld b,a			; $6e34
	inc hl			; $6e35
	ld e,$0d		; $6e36
	ld a,(de)		; $6e38
	add (hl)		; $6e39
	ldh (<hFF91),a	; $6e3a
	add (hl)		; $6e3c
	ld c,a			; $6e3d
	call getTileAtPosition		; $6e3e
	ld a,l			; $6e41
	ld e,$36		; $6e42
	ld (de),a		; $6e44
	ldh a,(<hFF90)	; $6e45
	ld b,a			; $6e47
	ldh a,(<hFF91)	; $6e48
	ld c,a			; $6e4a
	call getTileAtPosition		; $6e4b
	ld h,$cf		; $6e4e
	ld a,(hl)		; $6e50
	cp $f3			; $6e51
	ret z			; $6e53
	cp $fd			; $6e54
	ret			; $6e56
	dec e			; $6e57
	ld a,(de)		; $6e58
	cp $05			; $6e59
	jr nz,_label_05_336	; $6e5b
	ld a,($cc46)		; $6e5d
	bit 0,a			; $6e60
	jp nz,$6f7e		; $6e62
	ld a,($cc47)		; $6e65
	bit 7,a			; $6e68
	jr nz,_label_05_336	; $6e6a
	ld hl,$d108		; $6e6c
	ld b,a			; $6e6f
	add a			; $6e70
	swap a			; $6e71
	and $03			; $6e73
	ldi (hl),a		; $6e75
	ld a,b			; $6e76
	cp (hl)			; $6e77
	ld (hl),a		; $6e78
	ld c,$19		; $6e79
	call nz,$4547		; $6e7b
_label_05_336:
	ld c,$40		; $6e7e
	call objectUpdateSpeedZ_paramC		; $6e80
	jr z,_label_05_339	; $6e83
	ld a,($cc48)		; $6e85
	rra			; $6e88
	jr nc,_label_05_337	; $6e89
	ld a,($cc47)		; $6e8b
	and $04			; $6e8e
	jr nz,_label_05_338	; $6e90
_label_05_337:
	ld hl,$72c6		; $6e92
	call $44aa		; $6e95
	ld a,b			; $6e98
	cp $f3			; $6e99
	ret z			; $6e9b
	cp $fd			; $6e9c
	ret z			; $6e9e
_label_05_338:
	jp $441e		; $6e9f
_label_05_339:
	call specialObjectAnimate		; $6ea2
	call $4917		; $6ea5
	ret nz			; $6ea8
	jp $6fe4		; $6ea9
	call $495b		; $6eac
	jr z,_label_05_340	; $6eaf
	dec (hl)		; $6eb1
	ret nz			; $6eb2
	ld a,$c3		; $6eb3
	call playSound		; $6eb5
_label_05_340:
	ld c,$40		; $6eb8
	call objectUpdateSpeedZ_paramC		; $6eba
	jp z,$6fe4		; $6ebd
	call specialObjectAnimate		; $6ec0
	call $441e		; $6ec3
	call $44d4		; $6ec6
	jp nz,$6fe4		; $6ec9
	ret			; $6ecc
	ld c,$40		; $6ecd
	call objectUpdateSpeedZ_paramC		; $6ecf
	ret nz			; $6ed2
	call $7260		; $6ed3
	xor a			; $6ed6
	ld e,$05		; $6ed7
	ld (de),a		; $6ed9
	jp $7005		; $6eda
	ld e,$05		; $6edd
	ld a,(de)		; $6edf
	rst_jumpTable			; $6ee0
	push hl			; $6ee1
	ld l,(hl)		; $6ee2
	inc h			; $6ee3
	ld l,a			; $6ee4
	ld c,$40		; $6ee5
	call objectUpdateSpeedZ_paramC		; $6ee7
	jr z,_label_05_341	; $6eea
	call $441e		; $6eec
	jr _label_05_342		; $6eef
_label_05_341:
	call $442a		; $6ef1
	call $6ce6		; $6ef4
_label_05_342:
	call specialObjectAnimate		; $6ef7
	ld e,$21		; $6efa
	ld a,(de)		; $6efc
	and $c0			; $6efd
	ret z			; $6eff
	rlca			; $6f00
	jr c,_label_05_343	; $6f01
	ld a,$75		; $6f03
	jp playSound		; $6f05
_label_05_343:
	ld e,$0f		; $6f08
	ld a,(de)		; $6f0a
	or a			; $6f0b
	ret nz			; $6f0c
	ld a,($cc45)		; $6f0d
	and $01			; $6f10
	jp z,$6fe4		; $6f12
	call itemIncState2		; $6f15
	ld c,$13		; $6f18
	call $4547		; $6f1a
	call $459f		; $6f1d
	ret nc			; $6f20
	jp $700d		; $6f21
	ld a,($cc47)		; $6f24
	bit 7,a			; $6f27
	jr nz,_label_05_344	; $6f29
	ld hl,$d109		; $6f2b
	cp (hl)			; $6f2e
	ld (hl),a		; $6f2f
	ld c,$13		; $6f30
	call nz,$4525		; $6f32
_label_05_344:
	call specialObjectAnimate		; $6f35
	ld a,($cc45)		; $6f38
	and $01			; $6f3b
	jr z,_label_05_346	; $6f3d
	ld e,$35		; $6f3f
	ld a,(de)		; $6f41
	cp $1e			; $6f42
	jr nz,_label_05_345	; $6f44
	call $442a		; $6f46
	call $6ce6		; $6f49
	ld c,$04		; $6f4c
	jp $4865		; $6f4e
_label_05_345:
	inc a			; $6f51
	ld (de),a		; $6f52
	cp $1e			; $6f53
	ret nz			; $6f55
	ld a,$4f		; $6f56
	jp playSound		; $6f58
_label_05_346:
	ld hl,$d01b		; $6f5b
	ldi a,(hl)		; $6f5e
	ld (hl),a		; $6f5f
	ld e,$35		; $6f60
	ld a,(de)		; $6f62
	cp $1e			; $6f63
	jr nz,_label_05_347	; $6f65
	ld bc,$2a00		; $6f67
	call $450e		; $6f6a
	ld a,$f1		; $6f6d
	call playSound		; $6f6f
	ld a,$6b		; $6f72
	call playSound		; $6f74
	jr _label_05_348		; $6f77
_label_05_347:
	ld c,$05		; $6f79
	jp $47f1		; $6f7b
_label_05_348:
	ld bc,$2800		; $6f7e
	call $4514		; $6f81
	ret nz			; $6f84
	ld h,d			; $6f85
	ld l,$04		; $6f86
	ld a,$08		; $6f88
	ldi (hl),a		; $6f8a
	xor a			; $6f8b
	ld (hl),a		; $6f8c
	inc a			; $6f8d
	ld l,$35		; $6f8e
	ld (hl),a		; $6f90
	ld c,$09		; $6f91
	call $4547		; $6f93
	ld a,$74		; $6f96
	jp playSound		; $6f98
	ld e,$05		; $6f9b
	ld a,(de)		; $6f9d
	rst_jumpTable			; $6f9e
	and l			; $6f9f
	ld l,a			; $6fa0
	or (hl)			; $6fa1
	ld l,a			; $6fa2
	cp (hl)			; $6fa3
	ld l,a			; $6fa4
	ld c,$40		; $6fa5
	call objectUpdateSpeedZ_paramC		; $6fa7
	ret nz			; $6faa
	call itemIncState2		; $6fab
	call $45bf		; $6fae
	ld a,$17		; $6fb1
	jp specialObjectSetAnimation		; $6fb3
	ld a,($cc77)		; $6fb6
	or a			; $6fb9
	ret nz			; $6fba
	jp itemIncState2		; $6fbb
	call $48ef		; $6fbe
	ld c,$09		; $6fc1
	call objectCheckLinkWithinDistance		; $6fc3
	jp c,$6ce6		; $6fc6
	ld e,$05		; $6fc9
	xor a			; $6fcb
	ld (de),a		; $6fcc
	dec e			; $6fcd
	inc a			; $6fce
	ld (de),a		; $6fcf
	ret			; $6fd0
	call $48f8		; $6fd1
	ret c			; $6fd4
	call $4439		; $6fd5
	call $44b9		; $6fd8
	ld e,$07		; $6fdb
	jr z,_label_05_349	; $6fdd
	ld (de),a		; $6fdf
	ret			; $6fe0
_label_05_349:
	ld a,(de)		; $6fe1
	or a			; $6fe2
	ret z			; $6fe3
	ld a,($cc48)		; $6fe4
	rrca			; $6fe7
	jr nc,_label_05_350	; $6fe8
	xor a			; $6fea
	ld ($cc77),a		; $6feb
	ld ($ccab),a		; $6fee
_label_05_350:
	ld a,$05		; $6ff1
	ld e,$04		; $6ff3
	ld (de),a		; $6ff5
	ld a,$03		; $6ff6
	ld e,$05		; $6ff8
	ld (de),a		; $6ffa
	call $72a5		; $6ffb
	jr z,_label_05_351	; $6ffe
	ld e,$39		; $7000
	ld a,$10		; $7002
	ld (de),a		; $7004
_label_05_351:
	call $459f		; $7005
	ld c,$20		; $7008
	jp nc,$4547		; $700a
	ld c,$0e		; $700d
	cp $01			; $700f
	jr z,_label_05_352	; $7011
	ld c,$0d		; $7013
_label_05_352:
	ld h,d			; $7015
	ld l,$37		; $7016
	ld (hl),c		; $7018
	ld l,$06		; $7019
	ld (hl),$00		; $701b
	ret			; $701d
	ld e,$03		; $701e
	ld a,(de)		; $7020
	rst_jumpTable			; $7021
	inc a			; $7022
	ld (hl),b		; $7023
	ld d,h			; $7024
	ld (hl),b		; $7025
	ld e,h			; $7026
	ld (hl),b		; $7027
	xor b			; $7028
	ld (hl),b		; $7029
	jp $d270		; $702a
	ld (hl),b		; $702d
.DB $db				; $702e
	ld (hl),b		; $702f
	adc l			; $7030
	ld (hl),b		; $7031
.DB $db				; $7032
	ld (hl),b		; $7033
	inc c			; $7034
	ld (hl),c		; $7035
	ldi a,(hl)		; $7036
	ld (hl),c		; $7037
	ld b,e			; $7038
	ld (hl),c		; $7039
	ld l,c			; $703a
	ld (hl),c		; $703b
	call $4418		; $703c
	call $48ef		; $703f
	call specialObjectAnimate		; $7042
	ld e,$21		; $7045
	ld a,(de)		; $7047
	rlca			; $7048
	ld c,$40		; $7049
	jp nc,objectUpdateSpeedZ_paramC		; $704b
	ld bc,$ff00		; $704e
	jp objectSetSpeedZ		; $7051
	ld e,$3d		; $7054
	call objectRemoveFromAButtonSensitiveObjectList		; $7056
	jp $4948		; $7059
	ld a,$01		; $705c
	ld ($cca4),a		; $705e
	ld a,$00		; $7061
	ld e,$08		; $7063
	ld (de),a		; $7065
	ld a,$05		; $7066
	ld e,$3f		; $7068
	ld (de),a		; $706a
	call $713d		; $706b
_label_05_353:
	ld b,$30		; $706e
	ld c,$58		; $7070
	call objectGetRelativeAngle		; $7072
	and $1c			; $7075
	ld e,$09		; $7077
	ld (de),a		; $7079
	ld bc,$fe80		; $707a
	call objectSetSpeedZ		; $707d
	ld l,$05		; $7080
	ld (hl),$01		; $7082
	ld l,$10		; $7084
	ld (hl),$50		; $7086
	ld l,$06		; $7088
	ld (hl),$08		; $708a
	ret			; $708c
	call $485a		; $708d
	call specialObjectAnimate		; $7090
	ld e,$21		; $7093
	ld a,(de)		; $7095
	or a			; $7096
	ld a,$c3		; $7097
	jp z,playSound		; $7099
	ld a,(de)		; $709c
	rlca			; $709d
	ret nc			; $709e
	call $706e		; $709f
	ld e,$09		; $70a2
	ld a,$10		; $70a4
	ld (de),a		; $70a6
	ret			; $70a7
	call $485a		; $70a8
	ld e,$3e		; $70ab
	ld a,(de)		; $70ad
	and $01			; $70ae
	ret nz			; $70b0
	call $71a5		; $70b1
	ret nz			; $70b4
	ld e,$0b		; $70b5
	ld a,(de)		; $70b7
	cp $38			; $70b8
	jr nc,_label_05_353	; $70ba
	ld e,$3e		; $70bc
	ld a,(de)		; $70be
	or $01			; $70bf
	ld (de),a		; $70c1
	ret			; $70c2
	call $485a		; $70c3
	ld e,$3e		; $70c6
	ld a,(de)		; $70c8
	bit 1,a			; $70c9
	ret nz			; $70cb
	or $02			; $70cc
	ld (de),a		; $70ce
	jp $45f5		; $70cf
	call $706e		; $70d2
	ld e,$09		; $70d5
	ld a,$10		; $70d7
	ld (de),a		; $70d9
	ret			; $70da
	call $485a		; $70db
	call $71a5		; $70de
	ret nz			; $70e1
	call objectCheckWithinScreenBoundary		; $70e2
	jr nc,_label_05_355	; $70e5
	ld e,$0b		; $70e7
	ld a,(de)		; $70e9
	cp $60			; $70ea
	jr c,_label_05_354	; $70ec
	ld e,$3e		; $70ee
	ld a,(de)		; $70f0
	or $04			; $70f1
	ld (de),a		; $70f3
_label_05_354:
	call $706e		; $70f4
	ld e,$09		; $70f7
	ld a,$10		; $70f9
	ld (de),a		; $70fb
	ret			; $70fc
_label_05_355:
	ld a,$01		; $70fd
	ld ($cc6a),a		; $70ff
	xor a			; $7102
	ld ($cca4),a		; $7103
	call itemDelete		; $7106
	jp $4641		; $7109
	ld a,$80		; $710c
	ld ($cc02),a		; $710e
	ld a,$01		; $7111
	ld e,$08		; $7113
	ld (de),a		; $7115
	call $713d		; $7116
	ld c,$20		; $7119
	call $4547		; $711b
_label_05_356:
	ld bc,$4070		; $711e
	call objectGetRelativeAngle		; $7121
	and $1c			; $7124
	ld e,$09		; $7126
	ld (de),a		; $7128
	ret			; $7129
	call specialObjectAnimate		; $712a
	call $441e		; $712d
	ld e,$0d		; $7130
	ld a,(de)		; $7132
	cp $38			; $7133
	jr c,_label_05_356	; $7135
	ld bc,$2004		; $7137
	call showText		; $713a
_label_05_357:
	ld e,$03		; $713d
	ld a,(de)		; $713f
	inc a			; $7140
	ld (de),a		; $7141
	ret			; $7142
	call retIfTextIsActive		; $7143
	call $45f5		; $7146
	ld a,$18		; $7149
	ld ($d009),a		; $714b
	ld ($cc47),a		; $714e
	ld a,$32		; $7151
	ld ($d010),a		; $7153
	ld h,d			; $7156
	ld l,$09		; $7157
	ld a,$18		; $7159
	ldd (hl),a		; $715b
	ld a,$03		; $715c
	ldd (hl),a		; $715e
	ld a,$1e		; $715f
	ld (hl),a		; $7161
	ld a,$24		; $7162
	call specialObjectSetAnimation		; $7164
	jr _label_05_357		; $7167
	ld a,($cc77)		; $7169
	or a			; $716c
	ret nz			; $716d
	call setLinkForceStateToState08		; $716e
	ld hl,$d00d		; $7171
	ld e,$0d		; $7174
	ld a,(de)		; $7176
	bit 7,a			; $7177
	jr nz,_label_05_358	; $7179
	cp (hl)			; $717b
	ld a,$01		; $717c
	jr nc,_label_05_359	; $717e
_label_05_358:
	ld a,$03		; $7180
_label_05_359:
	ld l,$08		; $7182
	ld (hl),a		; $7184
	ld e,$07		; $7185
	ld a,(de)		; $7187
	or a			; $7188
	jr z,_label_05_360	; $7189
	dec a			; $718b
	ld (de),a		; $718c
	ret			; $718d
_label_05_360:
	call specialObjectAnimate		; $718e
	call $441e		; $7191
	call objectCheckWithinScreenBoundary		; $7194
	ret c			; $7197
	xor a			; $7198
	ld ($cc40),a		; $7199
	ld ($cca4),a		; $719c
	ld ($cc02),a		; $719f
	jp itemDelete		; $71a2
	ld c,$40		; $71a5
	call objectUpdateSpeedZ_paramC		; $71a7
	jr z,_label_05_361	; $71aa
	call $441e		; $71ac
	or d			; $71af
	ret			; $71b0
_label_05_361:
	ld c,$05		; $71b1
	call $4547		; $71b3
	jp $4917		; $71b6
	ld e,$03		; $71b9
	ld a,(de)		; $71bb
	rst_jumpTable			; $71bc
	pop bc			; $71bd
	ld (hl),c		; $71be
.DB $d3				; $71bf
	ld (hl),c		; $71c0
	call $492c		; $71c1
	ld (hl),$02		; $71c4
	call $707a		; $71c6
	ld a,$c3		; $71c9
	call playSound		; $71cb
	ld c,$01		; $71ce
	jp $4547		; $71d0
	call $6d65		; $71d3
	ld e,$04		; $71d6
	ld a,(de)		; $71d8
	cp $04			; $71d9
	ret z			; $71db
	ld a,$0c		; $71dc
	ld (de),a		; $71de
	inc e			; $71df
	ld a,(de)		; $71e0
	cp $03			; $71e1
	ret nz			; $71e3
	call $7260		; $71e4
	ld hl,$72c6		; $71e7
	call $44aa		; $71ea
	or a			; $71ed
	jr nz,_label_05_362	; $71ee
	call itemDecCounter2		; $71f0
	jr z,_label_05_362	; $71f3
	call $707a		; $71f5
	ld c,$01		; $71f8
	jp $4547		; $71fa
_label_05_362:
	ld e,$03		; $71fd
	xor a			; $71ff
	ld (de),a		; $7200
	jp $6c94		; $7201
	ld e,$33		; $7204
	ld a,(de)		; $7206
	and $c0			; $7207
	cp $c0			; $7209
	ret nz			; $720b
	ld a,($cc47)		; $720c
	cp $00			; $720f
	ret nz			; $7211
	ld hl,$7258		; $7212
	call $44ae		; $7215
	cp $03			; $7218
	jr z,_label_05_363	; $721a
	ld a,b			; $721c
	cp $dd			; $721d
	jr nz,_label_05_364	; $721f
_label_05_363:
	ld hl,$725a		; $7221
	call $44ae		; $7224
	cp $03			; $7227
	jr z,_label_05_366	; $7229
	ld a,b			; $722b
	cp $dd			; $722c
	jr z,_label_05_366	; $722e
_label_05_364:
	ld hl,$725c		; $7230
	call $44ae		; $7233
	cp $03			; $7236
	jr z,_label_05_365	; $7238
	ld a,b			; $723a
	cp $dd			; $723b
	ret nz			; $723d
_label_05_365:
	ld hl,$725e		; $723e
	call $44ae		; $7241
	cp $03			; $7244
	jr z,_label_05_366	; $7246
	ld a,b			; $7248
	cp $dd			; $7249
	ret nz			; $724b
_label_05_366:
	ld e,$04		; $724c
	ld a,$02		; $724e
	ld (de),a		; $7250
	inc e			; $7251
	xor a			; $7252
	ld (de),a		; $7253
	ld e,$07		; $7254
	ld (de),a		; $7256
	ret			; $7257
	ld hl,sp+$06		; $7258
	ld hl,sp-$06		; $725a
	add sp,$06		; $725c
	add sp,-$06		; $725e
	ld hl,$727c		; $7260
_label_05_367:
	ldi a,(hl)		; $7263
	ld b,a			; $7264
	ldi a,(hl)		; $7265
	ld c,a			; $7266
	or b			; $7267
	ret z			; $7268
	push hl			; $7269
	ld a,($d10b)		; $726a
	add b			; $726d
	ld b,a			; $726e
	ld a,($d10d)		; $726f
	add c			; $7272
	ld c,a			; $7273
	ld a,$10		; $7274
	call tryToBreakTile		; $7276
	pop hl			; $7279
	jr _label_05_367		; $727a
	inc b			; $727c
	nop			; $727d
	inc b			; $727e
	ld b,$fe		; $727f
	nop			; $7281
	inc b			; $7282
	ld a,($0000)		; $7283
	ld a,$01		; $7286
	ld ($cc77),a		; $7288
	ld a,$01		; $728b
	ld ($ccab),a		; $728d
	ld bc,$fd00		; $7290
	call objectSetSpeedZ		; $7293
	ld l,$06		; $7296
	ld (hl),$08		; $7298
	ld l,$10		; $729a
	ld (hl),$32		; $729c
	ld c,$0f		; $729e
	call $4547		; $72a0
	ld h,d			; $72a3
	ret			; $72a4
	ld h,d			; $72a5
	ld l,$0b		; $72a6
	ld a,$06		; $72a8
	cp (hl)			; $72aa
	jr nc,_label_05_368	; $72ab
	ld a,($cd0d)		; $72ad
	dec a			; $72b0
	cp (hl)			; $72b1
	jr c,_label_05_368	; $72b2
	ld l,$0d		; $72b4
	ld a,$06		; $72b6
	cp (hl)			; $72b8
	jr nc,_label_05_368	; $72b9
	ld a,($cd0c)		; $72bb
	dec a			; $72be
	cp (hl)			; $72bf
	jr c,_label_05_368	; $72c0
	xor a			; $72c2
	ret			; $72c3
_label_05_368:
	or d			; $72c4
	ret			; $72c5
	ld hl,sp+$00		; $72c6
	dec b			; $72c8
	ld ($0008),sp		; $72c9
	dec b			; $72cc
	ld hl,sp-$33		; $72cd
	ldd a,(hl)		; $72cf
	ld c,b			; $72d0
	call $47b3		; $72d1
	call $72de		; $72d4
	xor a			; $72d7
	ld ($cc37),a		; $72d8
	jp $48bb		; $72db
	ld e,$04		; $72de
	ld a,(de)		; $72e0
	rst_jumpTable			; $72e1
	cp $72			; $72e2
	cpl			; $72e4
	ld (hl),e		; $72e5
	ld l,(hl)		; $72e6
	ld (hl),e		; $72e7
	or (hl)			; $72e8
	ld (hl),h		; $72e9
	jp nz,$df74		; $72ea
	ld (hl),h		; $72ed
	halt			; $72ee
	ld (hl),l		; $72ef
	xor b			; $72f0
	ld (hl),l		; $72f1
	cp (hl)			; $72f2
	ld (hl),l		; $72f3
	ld c,c			; $72f4
	ld (hl),l		; $72f5
	ld a,b			; $72f6
	halt			; $72f7
	inc de			; $72f8
	halt			; $72f9
	add hl,hl		; $72fa
	halt			; $72fb
	ld d,l			; $72fc
	halt			; $72fd
	call $47fd		; $72fe
	ld a,$02		; $7301
	ld l,$08		; $7303
	ldi (hl),a		; $7305
	ld (hl),a		; $7306
	ld a,($c644)		; $7307
	and $80			; $730a
	jr nz,_label_05_369	; $730c
	ld l,$04		; $730e
	ld (hl),$0a		; $7310
	ld e,$3d		; $7312
	call objectAddToAButtonSensitiveObjectList		; $7314
	ld a,$24		; $7317
	ld e,$3f		; $7319
	ld (de),a		; $731b
	call specialObjectSetAnimation		; $731c
	ld bc,$0408		; $731f
	call objectSetCollideRadii		; $7322
	jr _label_05_370		; $7325
_label_05_369:
	ld c,$1c		; $7327
	call $4547		; $7329
_label_05_370:
	jp objectSetVisible81		; $732c
	call $48ef		; $732f
	ld c,$40		; $7332
	call objectUpdateSpeedZ_paramC		; $7334
	ret nz			; $7337
	call $459f		; $7338
	jr nc,_label_05_371	; $733b
	cp $02			; $733d
	ret z			; $733f
	call $7703		; $7340
	ld a,$04		; $7343
	call $74a6		; $7345
	jr _label_05_372		; $7348
_label_05_371:
	ld e,$38		; $734a
	ld a,(de)		; $734c
	or a			; $734d
	jr z,_label_05_372	; $734e
	xor a			; $7350
	ld (de),a		; $7351
	ld c,$1c		; $7352
	call $4547		; $7354
_label_05_372:
	ld a,$06		; $7357
	call objectSetCollideRadius		; $7359
	ld e,$3b		; $735c
	ld a,(de)		; $735e
	or a			; $735f
	jp nz,$7596		; $7360
	ld c,$09		; $7363
	call objectCheckLinkWithinDistance		; $7365
	jp nc,$769e		; $7368
	jp $4552		; $736b
	inc e			; $736e
	ld a,(de)		; $736f
	rst_jumpTable			; $7370
	ld a,c			; $7371
	ld (hl),e		; $7372
	sbc h			; $7373
	ld (hl),e		; $7374
.DB $dd				; $7375
	ld (hl),e		; $7376
	adc d			; $7377
	ld (hl),h		; $7378
	ld a,$40		; $7379
	ld (wLinkGrabState2),a		; $737b
	call itemIncState2		; $737e
	xor a			; $7381
	ld ($ccaa),a		; $7382
	ld l,$38		; $7385
	ld (hl),a		; $7387
	ld l,$3f		; $7388
	ld (hl),$ff		; $738a
	call objectSetVisiblec0		; $738c
	ld a,$02		; $738f
	ld hl,$c646		; $7391
	call setFlag		; $7394
	ld c,$18		; $7397
	jp $4547		; $7399
	xor a			; $739c
	ld ($d02d),a		; $739d
	ld a,($ccb6)		; $73a0
	cp $0e			; $73a3
	jr nz,_label_05_373	; $73a5
	ld a,$20		; $73a7
	ld ($ccb5),a		; $73a9
_label_05_373:
	ld a,($cc83)		; $73ac
	or a			; $73af
	jr nz,_label_05_374	; $73b0
	ld a,($d009)		; $73b2
	bit 7,a			; $73b5
	jr nz,_label_05_375	; $73b7
	ld e,$09		; $73b9
	ld (de),a		; $73bb
	ld a,($d008)		; $73bc
	dec e			; $73bf
	ld (de),a		; $73c0
	call $76c6		; $73c1
	jr nz,_label_05_375	; $73c4
_label_05_374:
	ld h,d			; $73c6
	ld l,$00		; $73c7
	res 1,(hl)		; $73c9
	ld l,$3b		; $73cb
	ld (hl),$01		; $73cd
	jp dropLinkHeldItem		; $73cf
_label_05_375:
	call $4439		; $73d2
	call $44d4		; $73d5
	ret z			; $73d8
	ld ($cc82),a		; $73d9
	ret			; $73dc
	ld h,d			; $73dd
	ld l,$00		; $73de
	res 1,(hl)		; $73e0
	call $459f		; $73e2
	jr nc,_label_05_376	; $73e5
	cp $02			; $73e7
	ret z			; $73e9
	jr _label_05_386		; $73ea
_label_05_376:
	ld h,d			; $73ec
	ld l,$3f		; $73ed
	ld a,(hl)		; $73ef
	cp $ff			; $73f0
	jr nz,_label_05_377	; $73f2
	xor a			; $73f4
	ld (hl),a		; $73f5
	ld l,$39		; $73f6
	ld a,($d00b)		; $73f8
	ldi (hl),a		; $73fb
	ld a,($d00d)		; $73fc
	ld (hl),a		; $73ff
_label_05_377:
	ld a,($cc37)		; $7400
	or a			; $7403
	jr nz,_label_05_384	; $7404
	call $4439		; $7406
	call $44d4		; $7409
	jr nz,_label_05_384	; $740c
	ld c,$00		; $740e
	ld h,d			; $7410
	ld l,$0b		; $7411
	ld a,(hl)		; $7413
	cp $08			; $7414
	jr nc,_label_05_378	; $7416
	ld (hl),$10		; $7418
	inc c			; $741a
	jr _label_05_380		; $741b
_label_05_378:
	ld a,($cc49)		; $741d
	or a			; $7420
	ld a,(hl)		; $7421
	jr nz,_label_05_379	; $7422
	cp $7a			; $7424
	jr c,_label_05_380	; $7426
	ld (hl),$7a		; $7428
	inc c			; $742a
	jr _label_05_380		; $742b
_label_05_379:
	cp $a8			; $742d
	jr c,_label_05_380	; $742f
	ld (hl),$a8		; $7431
	inc c			; $7433
	jr _label_05_380		; $7434
_label_05_380:
	ld l,$0d		; $7436
	ld a,(hl)		; $7438
	cp $04			; $7439
	jr nc,_label_05_381	; $743b
	ld (hl),$04		; $743d
	inc c			; $743f
	jr _label_05_383		; $7440
_label_05_381:
	ld a,($cc49)		; $7442
	or a			; $7445
	ld a,(hl)		; $7446
	jr nz,_label_05_382	; $7447
	cp $9b			; $7449
	jr c,_label_05_383	; $744b
	ld (hl),$9b		; $744d
	inc c			; $744f
	jr _label_05_383		; $7450
_label_05_382:
	cp $df			; $7452
	jr c,_label_05_383	; $7454
	ld (hl),$df		; $7456
	inc c			; $7458
_label_05_383:
	ld a,c			; $7459
	or a			; $745a
	jr z,_label_05_385	; $745b
_label_05_384:
	ld a,$00		; $745d
	ld ($dc10),a		; $745f
_label_05_385:
	call objectCheckIsOnHazard		; $7462
	cp $01			; $7465
	ret nz			; $7467
_label_05_386:
	ld h,d			; $7468
	ld l,$04		; $7469
	ld (hl),$0b		; $746b
	ld l,$38		; $746d
	ld (hl),$04		; $746f
	ld l,$39		; $7471
	ldi a,(hl)		; $7473
	ld c,(hl)		; $7474
	ld b,a			; $7475
	call objectGetRelativeAngle		; $7476
	and $18			; $7479
	ld e,$09		; $747b
	ld (de),a		; $747d
	add a			; $747e
	swap a			; $747f
	and $03			; $7481
	dec e			; $7483
	ld (de),a		; $7484
	ld c,$00		; $7485
	jp $4547		; $7487
	ld h,d			; $748a
	ld l,$00		; $748b
	res 1,(hl)		; $748d
	ld c,$40		; $748f
	call objectUpdateSpeedZ_paramC		; $7491
	ret nz			; $7494
	call $442a		; $7495
	call $459f		; $7498
	jr nc,_label_05_387	; $749b
	cp $02			; $749d
	ret z			; $749f
	ld a,$04		; $74a0
	jp $74a6		; $74a2
_label_05_387:
	xor a			; $74a5
	ld h,d			; $74a6
	ld l,$38		; $74a7
	ld (hl),a		; $74a9
	ld l,$04		; $74aa
	ld a,$01		; $74ac
	ldi (hl),a		; $74ae
	ld (hl),$00		; $74af
	ld c,$1c		; $74b1
	jp $4547		; $74b3
	call $4878		; $74b6
	ret nz			; $74b9
	call $4779		; $74ba
	ld c,$00		; $74bd
	jp $4547		; $74bf
	call $4665		; $74c2
	ret nz			; $74c5
	call $495b		; $74c6
	jr nz,_label_05_388	; $74c9
	inc (hl)		; $74cb
	ld a,$65		; $74cc
	call playSound		; $74ce
	ld a,$25		; $74d1
	jp specialObjectSetAnimation		; $74d3
_label_05_388:
	call $491f		; $74d6
	ret nc			; $74d9
	ld c,$00		; $74da
	jp $453d		; $74dc
	ld c,$40		; $74df
	call objectUpdateSpeedZ_paramC		; $74e1
	ret nz			; $74e4
	ld a,($ccb1)		; $74e5
	or a			; $74e8
	jr nz,_label_05_389	; $74e9
	ld a,($cc46)		; $74eb
	bit 0,a			; $74ee
	jr nz,_label_05_394	; $74f0
	bit 1,a			; $74f2
_label_05_389:
	jp nz,$47e2		; $74f4
	ld a,($cc47)		; $74f7
	bit 7,a			; $74fa
	jr nz,_label_05_391	; $74fc
	ld hl,$d109		; $74fe
	cp (hl)			; $7501
	ld (hl),a		; $7502
	ld c,$00		; $7503
	jp nz,$4525		; $7505
	call $4717		; $7508
	ret z			; $750b
	ld h,d			; $750c
	ld l,$21		; $750d
	ld a,(hl)		; $750f
	rlca			; $7510
	ld a,$88		; $7511
	call c,playSound		; $7513
	ld l,$38		; $7516
	ld a,(hl)		; $7518
	or a			; $7519
	ld a,$1e		; $751a
	jr z,_label_05_390	; $751c
	ld a,$28		; $751e
_label_05_390:
	ld l,$10		; $7520
	ld (hl),a		; $7522
	call $441e		; $7523
	call specialObjectAnimate		; $7526
_label_05_391:
	call $459f		; $7529
	ld h,d			; $752c
	jr nc,_label_05_392	; $752d
	cp $02			; $752f
	ret z			; $7531
	ld l,$04		; $7532
	ld (hl),$05		; $7534
	call $7703		; $7536
	ld b,$04		; $7539
	jr _label_05_393		; $753b
_label_05_392:
	ld b,$00		; $753d
_label_05_393:
	ld l,$38		; $753f
	ld a,(hl)		; $7541
	cp b			; $7542
	ld (hl),b		; $7543
	ld c,$00		; $7544
	jp nz,$453d		; $7546
	ret			; $7549
_label_05_394:
	ld h,d			; $754a
	ld l,$04		; $754b
	ld a,$08		; $754d
	ldi (hl),a		; $754f
	xor a			; $7550
	ldi (hl),a		; $7551
	ld (hl),a		; $7552
	ld l,$35		; $7553
	ld (hl),a		; $7555
	ld l,$08		; $7556
	ldi a,(hl)		; $7558
	swap a			; $7559
	rrca			; $755b
	ld (hl),a		; $755c
	ld a,$01		; $755d
	ld ($cc77),a		; $755f
	ld l,$10		; $7562
	ld (hl),$1e		; $7564
	ld c,$08		; $7566
	call $4547		; $7568
	ld bc,$2b00		; $756b
	call $4514		; $756e
	ld a,$c4		; $7571
	jp playSound		; $7573
	ld e,$05		; $7576
	ld a,(de)		; $7578
	rst_jumpTable			; $7579
	add b			; $757a
	ld (hl),l		; $757b
	adc e			; $757c
	ld (hl),l		; $757d
	sub e			; $757e
	ld (hl),l		; $757f
	ld a,$01		; $7580
	ld (de),a		; $7582
	call $45bf		; $7583
	ld c,$1c		; $7586
	jp $4547		; $7588
	ld a,($cc77)		; $758b
	or a			; $758e
	ret nz			; $758f
	jp itemIncState2		; $7590
	call $769e		; $7593
	ld c,$09		; $7596
	call objectCheckLinkWithinDistance		; $7598
	ret c			; $759b
	ld e,$04		; $759c
	ld a,$01		; $759e
	ld (de),a		; $75a0
	inc e			; $75a1
	xor a			; $75a2
	ld (de),a		; $75a3
	ld e,$3b		; $75a4
	ld (de),a		; $75a6
	ret			; $75a7
	call $48f8		; $75a8
	ret c			; $75ab
	call $4439		; $75ac
	call $44b9		; $75af
	ld l,$07		; $75b2
	jr z,_label_05_395	; $75b4
	ld (hl),a		; $75b6
	ret			; $75b7
_label_05_395:
	ld a,(hl)		; $75b8
	or a			; $75b9
	ret z			; $75ba
	jp $766f		; $75bb
	ld e,$05		; $75be
	ld a,(de)		; $75c0
	rst_jumpTable			; $75c1
	ret z			; $75c2
	ld (hl),l		; $75c3
	add sp,$75		; $75c4
	ld a,(bc)		; $75c6
	halt			; $75c7
	call specialObjectAnimate		; $75c8
	call objectApplySpeed		; $75cb
	ld e,$21		; $75ce
	ld a,(de)		; $75d0
	rlca			; $75d1
	ret nc			; $75d2
	call itemIncState2		; $75d3
	ld l,$08		; $75d6
	ldi a,(hl)		; $75d8
	xor $02			; $75d9
	swap a			; $75db
	rrca			; $75dd
	ld (hl),a		; $75de
	ld l,$06		; $75df
	ld (hl),$0c		; $75e1
	ld c,$00		; $75e3
	jp $4547		; $75e5
	call specialObjectAnimate		; $75e8
	call objectApplySpeed		; $75eb
	call $4917		; $75ee
	ret nz			; $75f1
	ld (hl),$14		; $75f2
	ld l,$08		; $75f4
	ldi a,(hl)		; $75f6
	swap a			; $75f7
	rrca			; $75f9
	ld (hl),a		; $75fa
	ld l,$35		; $75fb
	ld a,(hl)		; $75fd
	or a			; $75fe
	jp z,$766f		; $75ff
	call itemIncState2		; $7602
	ld c,$10		; $7605
	jp $4547		; $7607
	call specialObjectAnimate		; $760a
	call $4917		; $760d
	ret nz			; $7610
	jr _label_05_397		; $7611
	ld c,$40		; $7613
	call objectUpdateSpeedZ_paramC		; $7615
	ret nz			; $7618
	call $750c		; $7619
	ld h,d			; $761c
	ld l,$38		; $761d
	ld a,(hl)		; $761f
	or a			; $7620
	ld l,$04		; $7621
	ld (hl),$0b		; $7623
	ret nz			; $7625
	ld (hl),$01		; $7626
	ret			; $7628
	ld e,$03		; $7629
	ld a,(de)		; $762b
	rst_jumpTable			; $762c
	ld sp,$4076		; $762d
	halt			; $7630
	call $492c		; $7631
	ld (hl),$3c		; $7634
	ld a,$c4		; $7636
	call playSound		; $7638
	ld c,$00		; $763b
	jp $4547		; $763d
	call $750c		; $7640
	ld e,$04		; $7643
	ld a,$0c		; $7645
	ld (de),a		; $7647
	ld hl,$7723		; $7648
	call $493b		; $764b
	ld e,$03		; $764e
	xor a			; $7650
	ld (de),a		; $7651
	jp $72fe		; $7652
	ld e,$3c		; $7655
	ld a,(de)		; $7657
	or a			; $7658
	jr nz,_label_05_396	; $7659
	call $759c		; $765b
	inc a			; $765e
	ld (de),a		; $765f
	ld hl,$d100		; $7660
	res 1,(hl)		; $7663
	ld c,$1c		; $7665
	jp $4547		; $7667
_label_05_396:
	ld e,$04		; $766a
	ld a,$05		; $766c
	ld (de),a		; $766e
_label_05_397:
	xor a			; $766f
	ld ($cc77),a		; $7670
	ld c,$00		; $7673
	jp $47f1		; $7675
	call $485a		; $7678
	call $4418		; $767b
	call specialObjectAnimate		; $767e
	ld e,$1a		; $7681
	ld a,$c7		; $7683
	ld (de),a		; $7685
	ld a,($c644)		; $7686
	and $80			; $7689
	ret z			; $768b
	ld e,$1a		; $768c
	ld a,$c1		; $768e
	ld (de),a		; $7690
	ld a,$ff		; $7691
	ld ($cbea),a		; $7693
	ld c,$1c		; $7696
	call $4547		; $7698
	jp $4948		; $769b
	ld a,($cc83)		; $769e
	or a			; $76a1
	ret nz			; $76a2
	ld a,($d008)		; $76a3
	call $76c6		; $76a6
	ret z			; $76a9
	ld hl,$d00b		; $76aa
	ld b,(hl)		; $76ad
	ld l,$0d		; $76ae
	ld c,(hl)		; $76b0
	call getTileCollisionsAtPosition		; $76b1
	cp $0c			; $76b4
	jr z,_label_05_398	; $76b6
	cp $0f			; $76b8
	jr z,_label_05_398	; $76ba
	cp $11			; $76bc
	jr z,_label_05_398	; $76be
	cp $19			; $76c0
	call nz,objectAddToGrabbableObjectBuffer		; $76c2
_label_05_398:
	ret			; $76c5
	call $76e4		; $76c6
	ret z			; $76c9
	ld hl,$d009		; $76ca
	ldd a,(hl)		; $76cd
	bit 7,a			; $76ce
	ret nz			; $76d0
	bit 2,a			; $76d1
	jr nz,_label_05_399	; $76d3
	or d			; $76d5
	ret			; $76d6
_label_05_399:
	add a			; $76d7
	ld b,a			; $76d8
	ldi a,(hl)		; $76d9
	swap a			; $76da
	srl a			; $76dc
	xor b			; $76de
	add a			; $76df
	swap a			; $76e0
	and $03			; $76e2
	ld hl,$7723		; $76e4
	rst_addDoubleIndex			; $76e7
	ldi a,(hl)		; $76e8
	ld c,(hl)		; $76e9
	ld b,a			; $76ea
	call objectGetRelativeTile		; $76eb
	cp $df			; $76ee
	ret z			; $76f0
	cp $de			; $76f1
	ret z			; $76f3
	cp $dd			; $76f4
	ret z			; $76f6
	ld h,$ce		; $76f7
	ld a,(hl)		; $76f9
	cp $0c			; $76fa
	ret z			; $76fc
	cp $11			; $76fd
	ret z			; $76ff
	cp $19			; $7700
	ret			; $7702
	call objectGetTileAtPosition		; $7703
	ld h,d			; $7706
	cp $ff			; $7707
	jr z,_label_05_400	; $7709
	cp $fe			; $770b
	ret nz			; $770d
_label_05_400:
	ld l,$0a		; $770e
	ld a,(hl)		; $7710
	add $c0			; $7711
	ldi (hl),a		; $7713
	ld a,(hl)		; $7714
	adc $00			; $7715
	ld (hl),a		; $7717
	ld a,($cd0d)		; $7718
	cp (hl)			; $771b
	ret nc			; $771c
	ld a,$82		; $771d
	ld ($cd02),a		; $771f
	ret			; $7722
	ld hl,sp+$00		; $7723
	nop			; $7725
	ld ($0008),sp		; $7726
	nop			; $7729
	ld hl,sp-$33		; $772a
	ldd a,(hl)		; $772c
	ld c,b			; $772d
	call $47b3		; $772e
	call $7737		; $7731
	jp $48bb		; $7734
	ld e,$04		; $7737
	ld a,(de)		; $7739
	rst_jumpTable			; $773a
	ld d,l			; $773b
	ld (hl),a		; $773c
	sub a			; $773d
	ld (hl),a		; $773e
	ld e,a			; $773f
	ld a,b			; $7740
	xor e			; $7741
	ld (hl),a		; $7742
	or a			; $7743
	ld (hl),a		; $7744
	ld c,$78		; $7745
	jp nz,$f079		; $7747
	ld a,c			; $774a
	ld h,b			; $774b
	ld a,b			; $774c
	ld e,a			; $774d
	ld a,b			; $774e
	ld b,h			; $774f
	ld a,d			; $7750
	ld e,a			; $7751
	ld a,b			; $7752
	dec c			; $7753
	ld a,d			; $7754
	call $47fd		; $7755
	ld a,$06		; $7758
	call objectSetCollideRadius		; $775a
	ld a,$02		; $775d
	ld l,$08		; $775f
	ldi (hl),a		; $7761
	ldi (hl),a		; $7762
	ld hl,$c645		; $7763
	ld a,$80		; $7766
	and (hl)		; $7768
	jr nz,_label_05_403	; $7769
	ld a,($c610)		; $776b
	cp $0d			; $776e
	jr nz,_label_05_402	; $7770
	ld a,$20		; $7772
	and (hl)		; $7774
	jr z,_label_05_401	; $7775
	ld a,($cc4c)		; $7777
	cp $2f			; $777a
	jr z,_label_05_402	; $777c
	jr _label_05_403		; $777e
_label_05_401:
	ld a,($cc4c)		; $7780
	cp $90			; $7783
	jr nz,_label_05_403	; $7785
_label_05_402:
	ld e,$04		; $7787
	ld a,$0a		; $7789
	ld (de),a		; $778b
	jp $7a44		; $778c
_label_05_403:
	ld c,$01		; $778f
	call $4547		; $7791
	jp objectSetVisiblec1		; $7794
	call $48ef		; $7797
	call specialObjectAnimate		; $779a
	ld c,$09		; $779d
	call objectCheckLinkWithinDistance		; $779f
	jp c,$4552		; $77a2
	call $459f		; $77a5
	ret nc			; $77a8
	jr _label_05_408		; $77a9
	call $4878		; $77ab
	ret nz			; $77ae
	call $4779		; $77af
	ld c,$13		; $77b2
	jp $4547		; $77b4
	ld h,d			; $77b7
	ld l,$24		; $77b8
	set 7,(hl)		; $77ba
	ld l,$37		; $77bc
	ld a,(hl)		; $77be
	cp $0d			; $77bf
	jr z,_label_05_404	; $77c1
	ld a,$0e		; $77c3
	ld (hl),a		; $77c5
	call $4665		; $77c6
	ret nz			; $77c9
_label_05_404:
	call $495b		; $77ca
	jr nz,_label_05_405	; $77cd
	dec (hl)		; $77cf
	ld l,$37		; $77d0
	ld a,(hl)		; $77d2
	call specialObjectSetAnimation		; $77d3
	ld e,$37		; $77d6
	ld a,(de)		; $77d8
	cp $0d			; $77d9
	jr z,_label_05_405	; $77db
	ld a,$65		; $77dd
	jp playSound		; $77df
_label_05_405:
	call $491f		; $77e2
	ret nc			; $77e5
	ld c,$13		; $77e6
	ld a,($cc48)		; $77e8
	rrca			; $77eb
	jr c,_label_05_406	; $77ec
	ld c,$01		; $77ee
_label_05_406:
	jp $453d		; $77f0
_label_05_407:
	call $442a		; $77f3
	call $459f		; $77f6
	ld c,$13		; $77f9
	jp nc,$4525		; $77fb
_label_05_408:
	dec a			; $77fe
	ld c,$0d		; $77ff
	jr z,_label_05_409	; $7801
	ld c,$0e		; $7803
_label_05_409:
	ld e,$37		; $7805
	ld a,c			; $7807
	ld (de),a		; $7808
	ld e,$06		; $7809
	xor a			; $780b
	ld (de),a		; $780c
	ret			; $780d
	ld c,$10		; $780e
	call objectUpdateSpeedZ_paramC		; $7810
	ret nz			; $7813
	call $459f		; $7814
	jr c,_label_05_408	; $7817
	ld a,($ccb1)		; $7819
	or a			; $781c
	jr nz,_label_05_410	; $781d
	ld a,($cc46)		; $781f
	bit 0,a			; $7822
	jr nz,_label_05_411	; $7824
	bit 1,a			; $7826
_label_05_410:
	jp nz,$47e2		; $7828
	ld a,($cc47)		; $782b
	bit 7,a			; $782e
	ret nz			; $7830
	ld hl,$d109		; $7831
	cp (hl)			; $7834
	ld (hl),a		; $7835
	ld c,$13		; $7836
	jp nz,$4525		; $7838
	call $4717		; $783b
	ret z			; $783e
	ld e,$10		; $783f
	ld a,$28		; $7841
	ld (de),a		; $7843
	call $441e		; $7844
	jr _label_05_407		; $7847
	xor a			; $7849
	ld ($cc77),a		; $784a
	ld c,$13		; $784d
	jp $47f1		; $784f
_label_05_411:
	ld a,$08		; $7852
	ld e,$04		; $7854
	ld (de),a		; $7856
	inc e			; $7857
	xor a			; $7858
	ld (de),a		; $7859
	ld a,$53		; $785a
	call playSound		; $785c
	ret			; $785f
	ld e,$05		; $7860
	ld a,(de)		; $7862
	rst_jumpTable			; $7863
	ld (hl),b		; $7864
	ld a,b			; $7865
	adc d			; $7866
	ld a,b			; $7867
	ld e,$79		; $7868
	ld h,d			; $786a
	ld a,c			; $786b
	sbc e			; $786c
	ld a,c			; $786d
	xor (hl)		; $786e
	ld a,c			; $786f
	ld a,$01		; $7870
	ld (de),a		; $7872
	ld bc,$fec0		; $7873
	call objectSetSpeedZ		; $7876
	ld l,$10		; $7879
	ld (hl),$28		; $787b
	ld l,$39		; $787d
	ld a,$04		; $787f
	ldi (hl),a		; $7881
	xor a			; $7882
	ldi (hl),a		; $7883
	ldi (hl),a		; $7884
	ld c,$09		; $7885
	jp $4547		; $7887
	call objectCheckIsOverHazard		; $788a
	cp $01			; $788d
	jr nz,_label_05_412	; $788f
	ld bc,$0000		; $7891
	call objectSetSpeedZ		; $7894
	ld l,$05		; $7897
	ld (hl),$05		; $7899
	ld b,$9f		; $789b
	call objectCreateInteractionWithSubid00		; $789d
	dec l			; $78a0
	ld a,(hl)		; $78a1
	sub $20			; $78a2
	ld (hl),a		; $78a4
	ld l,$46		; $78a5
	ld e,$06		; $78a7
	ld a,$3c		; $78a9
	ld (hl),a		; $78ab
	ld (de),a		; $78ac
	ret			; $78ad
_label_05_412:
	ld a,($cc47)		; $78ae
	bit 7,a			; $78b1
	jr nz,_label_05_413	; $78b3
	ld hl,$d109		; $78b5
	cp (hl)			; $78b8
	ld (hl),a		; $78b9
	call $441e		; $78ba
_label_05_413:
	ld e,$15		; $78bd
	ld a,(de)		; $78bf
	rlca			; $78c0
	jr c,_label_05_416	; $78c1
	ld e,$3b		; $78c3
	ld a,($cc45)		; $78c5
	and $01			; $78c8
	jr z,_label_05_414	; $78ca
	ld a,(de)		; $78cc
	inc a			; $78cd
_label_05_414:
	ld (de),a		; $78ce
	cp $0a			; $78cf
	jr nc,_label_05_418	; $78d1
	ld a,($cc46)		; $78d3
	bit 0,a			; $78d6
	jr z,_label_05_415	; $78d8
	ld e,$3a		; $78da
	ld a,(de)		; $78dc
	cp $10			; $78dd
	jr z,_label_05_415	; $78df
	inc a			; $78e1
	ld (de),a		; $78e2
	dec e			; $78e3
	ld a,(de)		; $78e4
	add $08			; $78e5
	ld (de),a		; $78e7
	ld e,$20		; $78e8
	ld a,$01		; $78ea
	ld (de),a		; $78ec
	call specialObjectAnimate		; $78ed
	ld a,$53		; $78f0
	call playSound		; $78f2
_label_05_415:
	ld e,$39		; $78f5
	ld a,(de)		; $78f7
	or a			; $78f8
	jr z,_label_05_417	; $78f9
	dec a			; $78fb
	ld (de),a		; $78fc
	ld e,$20		; $78fd
	ld a,$0f		; $78ff
	ld (de),a		; $7901
	ld c,$09		; $7902
	jp $4525		; $7904
_label_05_416:
	ld c,$09		; $7907
	call $4525		; $7909
_label_05_417:
	ld c,$10		; $790c
	call objectUpdateSpeedZ_paramC		; $790e
	ret nz			; $7911
	call $442a		; $7912
	call $7849		; $7915
	jp $77f3		; $7918
_label_05_418:
	jp itemIncState2		; $791b
	call specialObjectAnimate		; $791e
	ld a,($cc45)		; $7921
	bit 0,a			; $7924
	jr z,_label_05_420	; $7926
	ld e,$3b		; $7928
	ld a,(de)		; $792a
	cp $28			; $792b
	jr c,_label_05_419	; $792d
	ld c,$02		; $792f
	call $4865		; $7931
_label_05_419:
	ld e,$3b		; $7934
	ld a,(de)		; $7936
	inc a			; $7937
	ld (de),a		; $7938
	cp $28			; $7939
	ret c			; $793b
	ld a,$4f		; $793c
	jp z,playSound		; $793e
	ld hl,$d024		; $7941
	res 7,(hl)		; $7944
	inc h			; $7946
	res 7,(hl)		; $7947
	ld e,$3b		; $7949
	ld a,(de)		; $794b
	cp $78			; $794c
	ret nz			; $794e
_label_05_420:
	ld hl,$d01b		; $794f
	ldi a,(hl)		; $7952
	ld (hl),a		; $7953
	call itemIncState2		; $7954
	ld c,$17		; $7957
	ld e,$3b		; $7959
	ld a,(de)		; $795b
	cp $28			; $795c
	ret c			; $795e
	jp $4547		; $795f
	ld c,$80		; $7962
	call objectUpdateSpeedZ_paramC		; $7964
	ret nz			; $7967
	ld e,$3b		; $7968
	ld a,(de)		; $796a
	cp $28			; $796b
	jr nc,_label_05_421	; $796d
	call $7849		; $796f
	jp $77f3		; $7972
_label_05_421:
	call $459f		; $7975
	jp c,$77fe		; $7978
	call itemIncState2		; $797b
	ld a,$0f		; $797e
	ld ($cd18),a		; $7980
	ld a,$f1		; $7983
	call playSound		; $7985
	ld a,$85		; $7988
	call playSound		; $798a
	ld a,$05		; $798d
	ld hl,$c646		; $798f
	call setFlag		; $7992
	ld bc,$2800		; $7995
	jp $4514		; $7998
	call specialObjectAnimate		; $799b
	ld e,$21		; $799e
	ld a,(de)		; $79a0
	rlca			; $79a1
	ret nc			; $79a2
	ld hl,$d024		; $79a3
	set 7,(hl)		; $79a6
	inc h			; $79a8
	set 7,(hl)		; $79a9
	jp $7849		; $79ab
	call $4917		; $79ae
	jr z,_label_05_422	; $79b1
	jp specialObjectAnimate		; $79b3
_label_05_422:
	ld c,$10		; $79b6
	call objectUpdateSpeedZ_paramC		; $79b8
	ret nz			; $79bb
	call $7849		; $79bc
	jp $77f3		; $79bf
	ld e,$05		; $79c2
	ld a,(de)		; $79c4
	rst_jumpTable			; $79c5
	call z,$d779		; $79c6
	ld a,c			; $79c9
	rst_addDoubleIndex			; $79ca
	ld a,c			; $79cb
	ld a,$01		; $79cc
	ld (de),a		; $79ce
	call $45bf		; $79cf
	ld c,$01		; $79d2
	jp $4547		; $79d4
	ld a,($cc77)		; $79d7
	or a			; $79da
	ret nz			; $79db
	jp itemIncState2		; $79dc
	ld c,$09		; $79df
	call objectCheckLinkWithinDistance		; $79e1
	jp c,$77a5		; $79e4
	ld e,$05		; $79e7
	xor a			; $79e9
	ld (de),a		; $79ea
	dec e			; $79eb
	ld a,$01		; $79ec
	ld (de),a		; $79ee
	ret			; $79ef
	call $48f8		; $79f0
	jr nc,_label_05_423	; $79f3
	ret nz			; $79f5
	ld c,$09		; $79f6
	jp $4547		; $79f8
_label_05_423:
	call $4439		; $79fb
	call $44b9		; $79fe
	ld e,$07		; $7a01
	jr z,_label_05_424	; $7a03
	ld (de),a		; $7a05
	ret			; $7a06
_label_05_424:
	ld a,(de)		; $7a07
	or a			; $7a08
	ret z			; $7a09
	jp $7849		; $7a0a
	ld e,$03		; $7a0d
	ld a,(de)		; $7a0f
	rst_jumpTable			; $7a10
	dec d			; $7a11
	ld a,d			; $7a12
	inc h			; $7a13
	ld a,d			; $7a14
	call $492c		; $7a15
	ld (hl),$3c		; $7a18
	ld a,$c5		; $7a1a
	call playSound		; $7a1c
	ld c,$0f		; $7a1f
	jp $4547		; $7a21
	call specialObjectAnimate		; $7a24
	ld e,$10		; $7a27
	ld a,$1e		; $7a29
	ld (de),a		; $7a2b
	call $441e		; $7a2c
	ld hl,$7a3c		; $7a2f
	call $493b		; $7a32
	ld e,$03		; $7a35
	xor a			; $7a37
	ld (de),a		; $7a38
	jp $7755		; $7a39
	ld hl,sp+$00		; $7a3c
	nop			; $7a3e
	ld ($0008),sp		; $7a3f
	nop			; $7a42
	ld hl,sp+$1e		; $7a43
	inc bc			; $7a45
	ld a,(de)		; $7a46
	rst_jumpTable			; $7a47
	ld h,d			; $7a48
	ld a,d			; $7a49
	adc l			; $7a4a
	ld a,d			; $7a4b
	and a			; $7a4c
	ld a,d			; $7a4d
	or d			; $7a4e
	ld a,d			; $7a4f
	pop bc			; $7a50
	ld a,d			; $7a51
.DB $d3				; $7a52
	ld a,d			; $7a53
.DB $d3				; $7a54
	ld a,d			; $7a55
	adc l			; $7a56
	ld a,d			; $7a57
	di			; $7a58
	ld a,d			; $7a59
	inc c			; $7a5a
	ld a,e			; $7a5b
	ld h,$7b		; $7a5c
	jr c,$7b		; $7a5e
	ld h,c			; $7a60
	ld a,e			; $7a61
	ld a,$01		; $7a62
	ld (de),a		; $7a64
	ld a,($c610)		; $7a65
	cp $0d			; $7a68
	jr nz,_label_05_425	; $7a6a
	ld a,($c645)		; $7a6c
	and $20			; $7a6f
	jr nz,_label_05_425	; $7a71
	ld a,$02		; $7a73
	ld (de),a		; $7a75
	ld c,$01		; $7a76
	call $4547		; $7a78
	jr _label_05_426		; $7a7b
_label_05_425:
	ld a,$00		; $7a7d
	ld e,$3f		; $7a7f
	ld (de),a		; $7a81
	call specialObjectSetAnimation		; $7a82
_label_05_426:
	call objectSetVisiblec3		; $7a85
	ld e,$3d		; $7a88
	jp objectAddToAButtonSensitiveObjectList		; $7a8a
	call $485a		; $7a8d
	call $7b9e		; $7a90
	ld a,($c645)		; $7a93
	and $80			; $7a96
	jr z,_label_05_427	; $7a98
	jr _label_05_428		; $7a9a
_label_05_427:
	ld e,$3d		; $7a9c
	ld a,(de)		; $7a9e
	or a			; $7a9f
	ret z			; $7aa0
	ld a,$81		; $7aa1
	ld ($cca4),a		; $7aa3
	ret			; $7aa6
	ld e,$2b		; $7aa7
	ld a,(de)		; $7aa9
	or a			; $7aaa
	ret z			; $7aab
	dec a			; $7aac
	ld (de),a		; $7aad
	ld h,d			; $7aae
	jp $4244		; $7aaf
	call $485a		; $7ab2
	call specialObjectAnimate		; $7ab5
	call $4917		; $7ab8
	ret nz			; $7abb
	ld c,$10		; $7abc
	jp objectUpdateSpeedZ_paramC		; $7abe
	call $485a		; $7ac1
	ld c,$10		; $7ac4
	call objectUpdateSpeedZ_paramC		; $7ac6
	ret nz			; $7ac9
	ld e,$3e		; $7aca
	ld a,(de)		; $7acc
	or $40			; $7acd
	ld (de),a		; $7acf
	jp specialObjectAnimate		; $7ad0
	call $485a		; $7ad3
	call $7b9e		; $7ad6
	ld a,($c645)		; $7ad9
	and $20			; $7adc
	ret z			; $7ade
	ld a,$ff		; $7adf
	ld ($cbea),a		; $7ae1
_label_05_428:
	ld e,$3d		; $7ae4
	xor a			; $7ae6
	ld (de),a		; $7ae7
	call objectRemoveFromAButtonSensitiveObjectList		; $7ae8
	ld c,$01		; $7aeb
	call $4547		; $7aed
	jp $4948		; $7af0
	call $485a		; $7af3
	ld e,$3e		; $7af6
	xor a			; $7af8
	ld (de),a		; $7af9
	ld c,$10		; $7afa
	jp objectUpdateSpeedZ_paramC		; $7afc
_label_05_429:
	ld b,$40		; $7aff
	ld c,$70		; $7b01
	call objectGetRelativeAngle		; $7b03
	and $1c			; $7b06
	ld e,$09		; $7b08
	ld (de),a		; $7b0a
	ret			; $7b0b
	ld c,$10		; $7b0c
	call objectUpdateSpeedZ_paramC		; $7b0e
	call specialObjectAnimate		; $7b11
	call $441e		; $7b14
	ld e,$0d		; $7b17
	ld a,(de)		; $7b19
	cp $38			; $7b1a
	jr c,_label_05_429	; $7b1c
	ld a,$01		; $7b1e
	ld e,$3e		; $7b20
	ld (de),a		; $7b22
	jp $7ba7		; $7b23
	call $485a		; $7b26
	ld e,$3e		; $7b29
	ld a,(de)		; $7b2b
	and $02			; $7b2c
	ret z			; $7b2e
	ld bc,$220f		; $7b2f
	call showText		; $7b32
	jp $7ba7		; $7b35
	call retIfTextIsActive		; $7b38
	call $45f5		; $7b3b
	ld a,$18		; $7b3e
	ld ($d009),a		; $7b40
	ld ($cc47),a		; $7b43
	ld a,$32		; $7b46
	ld ($d010),a		; $7b48
	ld bc,$fec0		; $7b4b
	call objectSetSpeedZ		; $7b4e
	ld l,$09		; $7b51
	ld (hl),$18		; $7b53
	ld l,$06		; $7b55
	ld (hl),$1e		; $7b57
	ld c,$0c		; $7b59
	call $4547		; $7b5b
	jp $7ba7		; $7b5e
	call specialObjectAnimate		; $7b61
	ld e,$15		; $7b64
	ld a,(de)		; $7b66
	or a			; $7b67
	ld c,$10		; $7b68
	call nz,objectUpdateSpeedZ_paramC		; $7b6a
	ld a,($cc77)		; $7b6d
	or a			; $7b70
	ret nz			; $7b71
	call setLinkForceStateToState08		; $7b72
	ld hl,$d00d		; $7b75
	ld e,$0d		; $7b78
	ld a,(de)		; $7b7a
	bit 7,a			; $7b7b
	jr nz,_label_05_430	; $7b7d
	cp (hl)			; $7b7f
	ld a,$01		; $7b80
	jr nc,_label_05_431	; $7b82
_label_05_430:
	ld a,$03		; $7b84
_label_05_431:
	ld l,$08		; $7b86
	ld (hl),a		; $7b88
	call $4917		; $7b89
	ret nz			; $7b8c
	call $441e		; $7b8d
	call objectCheckWithinScreenBoundary		; $7b90
	ret c			; $7b93
	xor a			; $7b94
	ld ($cc40),a		; $7b95
	ld ($cc02),a		; $7b98
	jp itemDelete		; $7b9b
	call $4418		; $7b9e
	call specialObjectAnimate		; $7ba1
	jp $48ef		; $7ba4
	ld e,$03		; $7ba7
	ld a,(de)		; $7ba9
	inc a			; $7baa
	ld (de),a		; $7bab
	ret			; $7bac
	cp c			; $7bad
	ld a,e			; $7bae
.DB $ec				; $7baf
	ld a,e			; $7bb0
	add hl,hl		; $7bb1
	ld a,h			; $7bb2
	ldd (hl),a		; $7bb3
	ld a,h			; $7bb4
	ldd (hl),a		; $7bb5
	ld a,h			; $7bb6
	ld (hl),e		; $7bb7
	ld a,h			; $7bb8
	jr nz,_label_05_432	; $7bb9
	di			; $7bbb
	ld bc,$01f4		; $7bbc
.DB $dd				; $7bbf
	inc b			; $7bc0
	sbc $04			; $7bc1
_label_05_432:
	rst_addDoubleIndex			; $7bc3
	inc b			; $7bc4
	ld hl,sp+$05		; $7bc5
	ld sp,hl		; $7bc7
	dec b			; $7bc8
	ret nc			; $7bc9
	ld b,$db		; $7bca
	ld c,$dc		; $7bcc
	rrca			; $7bce
.DB $fd				; $7bcf
	rlca			; $7bd0
	ld a,($fb11)		; $7bd1
	ld de,setRoomFlagsForUnlockedKeyDoor_overworldOnly		; $7bd4
	pop de			; $7bd7
	ld (de),a		; $7bd8
	call nc,$d213		; $7bd9
	inc d			; $7bdc
.DB $d3				; $7bdd
	dec d			; $7bde
	ret			; $7bdf
	inc bc			; $7be0
	ld a,e			; $7be1
	stop			; $7be2
	ld a,h			; $7be3
	stop			; $7be4
	ld a,l			; $7be5
	stop			; $7be6
	ld a,(hl)		; $7be7
	stop			; $7be8
	ld a,a			; $7be9
	stop			; $7bea
	nop			; $7beb
	di			; $7bec
	ld bc,$01f4		; $7bed
	ld hl,sp+$05		; $7bf0
	ld sp,hl		; $7bf2
	dec b			; $7bf3
	ret nc			; $7bf4
	ld b,$d1		; $7bf5
	ld b,$fa		; $7bf7
	ld de,$11fb		; $7bf9
.DB $fc				; $7bfc
	ld de,$107b		; $7bfd
	ld a,h			; $7c00
	stop			; $7c01
	ld a,l			; $7c02
	stop			; $7c03
	ld a,(hl)		; $7c04
	stop			; $7c05
	ld a,a			; $7c06
	stop			; $7c07
	ret nz			; $7c08
	stop			; $7c09
	pop bc			; $7c0a
	stop			; $7c0b
	jp nz,$c310		; $7c0c
	stop			; $7c0f
	call nz,$c510		; $7c10
	stop			; $7c13
	add $10			; $7c14
	rst_jumpTable			; $7c16
	stop			; $7c17
	ret z			; $7c18
	stop			; $7c19
	ret			; $7c1a
	stop			; $7c1b
	jp z,$cb10		; $7c1c
	stop			; $7c1f
	call z,$cd10		; $7c20
	stop			; $7c23
	adc $10			; $7c24
	rst $8			; $7c26
	stop			; $7c27
	nop			; $7c28
	ret nc			; $7c29
	inc b			; $7c2a
.DB $dd				; $7c2b
	inc b			; $7c2c
	sbc $04			; $7c2d
	rst_addDoubleIndex			; $7c2f
	inc b			; $7c30
	nop			; $7c31
	di			; $7c32
	ld bc,$01f4		; $7c33
	push af			; $7c36
	ld bc,$01f6		; $7c37
	rst $30			; $7c3a
	ld bc,$07fd		; $7c3b
	ld a,($fb11)		; $7c3e
	ld de,setRoomFlagsForUnlockedKeyDoor_overworldOnly		; $7c41
	ret nc			; $7c44
_label_05_433:
	ld bc,$1061		; $7c45
	ld h,d			; $7c48
	stop			; $7c49
	ld h,e			; $7c4a
	stop			; $7c4b
	ld h,h			; $7c4c
	stop			; $7c4d
	ld h,l			; $7c4e
	stop			; $7c4f
	ld d,b			; $7c50
	ld b,$51		; $7c51
	ld b,$52		; $7c53
	ld b,$53		; $7c55
	ld b,$48		; $7c57
	ld (bc),a		; $7c59
	ld c,c			; $7c5a
	ld (bc),a		; $7c5b
	ld c,d			; $7c5c
	ld (bc),a		; $7c5d
	ld c,e			; $7c5e
	ld (bc),a		; $7c5f
	ld c,l			; $7c60
	inc bc			; $7c61
	ld d,h			; $7c62
	add hl,bc		; $7c63
	ld d,l			; $7c64
	ld a,(bc)		; $7c65
	ld d,(hl)		; $7c66
	dec bc			; $7c67
	ld d,a			; $7c68
	inc c			; $7c69
	ld h,b			; $7c6a
	dec c			; $7c6b
	adc h			; $7c6c
	rrca			; $7c6d
	adc l			; $7c6e
	rrca			; $7c6f
	ccf			; $7c70
	ld bc,$1600		; $7c71
	stop			; $7c74
	jr $10			; $7c75
	rla			; $7c77
	sub b			; $7c78
	add hl,de		; $7c79
	sub b			; $7c7a
.DB $f4				; $7c7b
	ld bc,$010f		; $7c7c
	inc c			; $7c7f
	ld bc,$301a		; $7c80
	dec de			; $7c83
_label_05_434:
	jr nz,_label_05_435	; $7c84
	jr nz,_label_05_436	; $7c86
	jr nz,_label_05_437	; $7c88
	jr nz,_label_05_438	; $7c8a
	jr nz,_label_05_439	; $7c8c
	ld b,b			; $7c8e
	ldi (hl),a		; $7c8f
	ld b,b			; $7c90
	inc c			; $7c91
	inc b			; $7c92
	dec c			; $7c93
	inc b			; $7c94
	ld c,$04		; $7c95
	ld (bc),a		; $7c97
	nop			; $7c98
	nop			; $7c99
	and (hl)		; $7c9a
	ld a,h			; $7c9b
	push bc			; $7c9c
	ld a,h			; $7c9d
	call z,$cd7c		; $7c9e
	ld a,h			; $7ca1
_label_05_435:
	call $d97c		; $7ca2
_label_05_436:
	ld a,h			; $7ca5
	ld d,h			; $7ca6
	stop			; $7ca7
_label_05_437:
	dec h			; $7ca8
	jr $26			; $7ca9
_label_05_438:
	ld ($0828),sp		; $7cab
_label_05_439:
	daa			; $7cae
	jr _label_05_433		; $7caf
	stop			; $7cb1
	sub l			; $7cb2
	stop			; $7cb3
	ldi a,(hl)		; $7cb4
	nop			; $7cb5
	sbc d			; $7cb6
	stop			; $7cb7
	call z,$cd10		; $7cb8
	stop			; $7cbb
	adc $10			; $7cbc
	rst $8			; $7cbe
	stop			; $7cbf
	cp $10			; $7cc0
	rst $38			; $7cc2
	stop			; $7cc3
	nop			; $7cc4
	ld ($eb10),a		; $7cc5
	stop			; $7cc8
	ld d,h			; $7cc9
	stop			; $7cca
	nop			; $7ccb
	nop			; $7ccc
	or b			; $7ccd
	stop			; $7cce
	or c			; $7ccf
	jr _label_05_434		; $7cd0
	nop			; $7cd2
	or e			; $7cd3
	ld ($0005),sp		; $7cd4
	ld b,$10		; $7cd7
	nop			; $7cd9
	ld e,$04		; $7cda
	ld a,(de)		; $7cdc
	rst_jumpTable			; $7cdd
	ld ($0f7c),a		; $7cde
	ld a,l			; $7ce1
	sbc c			; $7ce2
	ld a,l			; $7ce3
	cp $7d			; $7ce4
	rrca			; $7ce6
	ld a,(hl)		; $7ce7
	ld (de),a		; $7ce8
	ld a,(hl)		; $7ce9
	call clearAllParentItems		; $7cea
	call $41b5		; $7ced
	ld h,d			; $7cf0
	ld l,$00		; $7cf1
	ld a,(hl)		; $7cf3
	or $03			; $7cf4
	ld (hl),a		; $7cf6
	ld l,$04		; $7cf7
	ld (hl),$01		; $7cf9
	ld l,$08		; $7cfb
	ld (hl),$02		; $7cfd
	ld l,$0b		; $7cff
	ld (hl),$38		; $7d01
	ld l,$0d		; $7d03
	ld (hl),$68		; $7d05
	ld a,$00		; $7d07
	call specialObjectSetAnimation		; $7d09
	jp objectSetVisiblec1		; $7d0c
	call $7e13		; $7d0f
	ld h,d			; $7d12
	ld a,($cc46)		; $7d13
	ld b,$00		; $7d16
	bit 4,a			; $7d18
	jr nz,_label_05_440	; $7d1a
	inc b			; $7d1c
	bit 5,a			; $7d1d
	jr nz,_label_05_440	; $7d1f
	inc b			; $7d21
	and $01			; $7d22
	jr nz,_label_05_444	; $7d24
	ret			; $7d26
_label_05_440:
	call $7d8f		; $7d27
	ld l,$04		; $7d2a
	inc (hl)		; $7d2c
	ld l,$37		; $7d2d
	ld (hl),$00		; $7d2f
	call objectGetShortPosition		; $7d31
	ld c,a			; $7d34
	ld hl,$7d57		; $7d35
_label_05_441:
	ldi a,(hl)		; $7d38
	cp c			; $7d39
	jr z,_label_05_442	; $7d3a
	inc hl			; $7d3c
	jr _label_05_441		; $7d3d
_label_05_442:
	ld a,($cc46)		; $7d3f
	and $10			; $7d42
	ld a,(hl)		; $7d44
	jr nz,_label_05_443	; $7d45
	swap a			; $7d47
_label_05_443:
	and $0f			; $7d49
	ld e,$08		; $7d4b
	ld (de),a		; $7d4d
	swap a			; $7d4e
	rrca			; $7d50
	inc e			; $7d51
	ld (de),a		; $7d52
	xor a			; $7d53
	jp specialObjectSetAnimation		; $7d54
	ld de,$2121		; $7d57
	jr nz,$31		; $7d5a
	jr nz,_label_05_445	; $7d5c
	jr nz,$51		; $7d5e
	jr nz,_label_05_446	; $7d60
	stop			; $7d62
	ld h,d			; $7d63
	inc de			; $7d64
	ld h,e			; $7d65
	inc de			; $7d66
	ld h,h			; $7d67
	inc de			; $7d68
	ld h,l			; $7d69
	inc de			; $7d6a
	ld h,(hl)		; $7d6b
	inc bc			; $7d6c
	ld d,(hl)		; $7d6d
	ld (bc),a		; $7d6e
	ld b,(hl)		; $7d6f
	ld (bc),a		; $7d70
	ld (hl),$02		; $7d71
	ld h,$02		; $7d73
	ld d,$32		; $7d75
	dec d			; $7d77
	ld sp,$3114		; $7d78
	inc de			; $7d7b
	ld sp,$3112		; $7d7c
_label_05_444:
	call $7d8f		; $7d7f
	ld l,$04		; $7d82
	ld (hl),$03		; $7d84
	ld l,$08		; $7d86
	ld (hl),$00		; $7d88
	ld a,$01		; $7d8a
	jp specialObjectSetAnimation		; $7d8c
	ld a,($cfd8)		; $7d8f
	inc a			; $7d92
	ret nz			; $7d93
	ld a,b			; $7d94
	ld ($cfd8),a		; $7d95
	ret			; $7d98
	call $7e13		; $7d99
	call specialObjectAnimate		; $7d9c
_label_05_445:
	call $7da9		; $7d9f
	ret c			; $7da2
	ld e,$04		; $7da3
	ld a,$01		; $7da5
	ld (de),a		; $7da7
	ret			; $7da8
	ld h,d			; $7da9
	ld e,$0b		; $7daa
	ld l,$38		; $7dac
	ld a,(de)		; $7dae
	ldi (hl),a		; $7daf
	ld e,$0d		; $7db0
	ld a,(de)		; $7db2
	ld (hl),a		; $7db3
	ld a,($cfd3)		; $7db4
	ld e,$10		; $7db7
	ld (de),a		; $7db9
	call objectApplySpeed		; $7dba
	call $7dc2		; $7dbd
	jr _label_05_448		; $7dc0
	ld h,d			; $7dc2
_label_05_446:
	ld l,$0b		; $7dc3
	call $7dcb		; $7dc5
	ld h,d			; $7dc8
	ld l,$0d		; $7dc9
	ld a,$17		; $7dcb
	cp (hl)			; $7dcd
	inc a			; $7dce
	jr nc,_label_05_447	; $7dcf
	ld a,$68		; $7dd1
	cp (hl)			; $7dd3
	ret nc			; $7dd4
_label_05_447:
	ld (hl),a		; $7dd5
	ret			; $7dd6
_label_05_448:
	ld e,$0b		; $7dd7
	ld a,(de)		; $7dd9
	ld b,a			; $7dda
	ld e,$38		; $7ddb
	ld a,(de)		; $7ddd
	sub b			; $7dde
	jr nc,_label_05_449	; $7ddf
	cpl			; $7de1
	inc a			; $7de2
_label_05_449:
	ld c,a			; $7de3
	ld e,$0d		; $7de4
	ld a,(de)		; $7de6
	ld b,a			; $7de7
	ld e,$39		; $7de8
	ld a,(de)		; $7dea
	sub b			; $7deb
	jr nc,_label_05_450	; $7dec
	cpl			; $7dee
	inc a			; $7def
_label_05_450:
	add c			; $7df0
	ret z			; $7df1
	ld b,a			; $7df2
	ld e,$37		; $7df3
	ld a,(de)		; $7df5
	add b			; $7df6
	ld (de),a		; $7df7
	cp $10			; $7df8
	ret c			; $7dfa
	jp objectCenterOnTile		; $7dfb
	call $7e13		; $7dfe
	call specialObjectAnimate		; $7e01
	ld e,$21		; $7e04
	ld a,(de)		; $7e06
	inc a			; $7e07
	ret nz			; $7e08
	ld e,$04		; $7e09
	ld a,$01		; $7e0b
	ld (de),a		; $7e0d
	ret			; $7e0e
	jp specialObjectAnimate		; $7e0f
	ret			; $7e12
	ld a,($cfd0)		; $7e13
	or a			; $7e16
	ret z			; $7e17
	pop hl			; $7e18
	inc a			; $7e19
	ld a,$05		; $7e1a
	ld b,$02		; $7e1c
	jr z,_label_05_451	; $7e1e
	dec a			; $7e20
	ld b,$01		; $7e21
_label_05_451:
	ld e,$04		; $7e23
	ld (de),a		; $7e25
	ld a,b			; $7e26
	call specialObjectSetAnimation		; $7e27
	jp objectSetVisible80		; $7e2a

.BANK $06 SLOT 1
.ORG 0

	ld a,($cc75)		; $4000
	or a			; $4003
	ret nz			; $4004
	call $4364		; $4005
	ld e,a			; $4008
	ldh (<hFF8B),a	; $4009
	ld a,c			; $400b
	ldh (<hFF8D),a	; $400c
	ld hl,$43a3		; $400e
	call lookupCollisionTable_paramE		; $4011
	jp nc,$41dd		; $4014
	ld b,a			; $4017
	and $0f			; $4018
	rst_jumpTable			; $401a
	ld c,$41		; $401b
	ld h,d			; $401d
	ld b,c			; $401e
	sub a			; $401f
	ld b,c			; $4020
	xor (hl)		; $4021
	ld b,d			; $4022
	dec l			; $4023
	ld b,b			; $4024
	or h			; $4025
	ld b,b			; $4026
	add sp,$41		; $4027
	ld d,a			; $4029
	ld b,d			; $402a
	add (hl)		; $402b
	ld b,d			; $402c
	call $40ef		; $402d
	jr z,_label_06_000	; $4030
	ld bc,$510d		; $4032
	call showText		; $4035
	scf			; $4038
	ret			; $4039
_label_06_000:
	ld a,($ccea)		; $403a
	or a			; $403d
	jr z,_label_06_001	; $403e
	ld a,($ccbb)		; $4040
	or a			; $4043
	jr nz,_label_06_001	; $4044
	ld a,($ccbc)		; $4046
	or a			; $4049
	ret nz			; $404a
_label_06_001:
	ld a,c			; $404b
	ld ($ccbc),a		; $404c
	ld a,$f0		; $404f
	call setTile		; $4051
	ld a,$6c		; $4054
	call playSound		; $4056
	ld a,($ccea)		; $4059
	or a			; $405c
	ret nz			; $405d
	ld a,($ccbb)		; $405e
	or a			; $4061
	scf			; $4062
	ret nz			; $4063
	ld hl,$d040		; $4064
	ld b,$40		; $4067
	call clearMemory		; $4069
	ld a,($ccbd)		; $406c
	or a			; $406f
	jr z,_label_06_002	; $4070
	ld b,a			; $4072
	ld a,($ccbe)		; $4073
	ld c,a			; $4076
	jr _label_06_003		; $4077
_label_06_002:
	call getChestData		; $4079
_label_06_003:
	ld a,b			; $407c
	or a			; $407d
	jr z,_label_06_004	; $407e
	ld a,$83		; $4080
	ld ($cca4),a		; $4082
	ld ($cbca),a		; $4085
	ld hl,$d040		; $4088
	ld a,$81		; $408b
	ldi (hl),a		; $408d
	ld (hl),$60		; $408e
	inc l			; $4090
	ld (hl),b		; $4091
	inc l			; $4092
	ld (hl),c		; $4093
	ld l,$4b		; $4094
	ld a,($ccbc)		; $4096
	ld b,a			; $4099
	and $f0			; $409a
	ldi (hl),a		; $409c
	inc l			; $409d
	ld a,b			; $409e
	swap a			; $409f
	and $f0			; $40a1
	or $08			; $40a3
	ld (hl),a		; $40a5
_label_06_004:
	call getThisRoomFlags		; $40a6
	set 5,(hl)		; $40a9
	xor a			; $40ab
	ld ($ccbd),a		; $40ac
	ld ($ccbe),a		; $40af
	scf			; $40b2
	ret			; $40b3
	call $40ef		; $40b4
	ld bc,$510e		; $40b7
	jr nz,_label_06_009	; $40ba
	ld a,($cc49)		; $40bc
	ld hl,$7552		; $40bf
	rst_addDoubleIndex			; $40c2
	ldi a,(hl)		; $40c3
	ld h,(hl)		; $40c4
	ld l,a			; $40c5
	ld a,($cc4c)		; $40c6
	ld b,a			; $40c9
	ldh a,(<hFF8D)	; $40ca
	ld c,a			; $40cc
_label_06_005:
	ldi a,(hl)		; $40cd
	or a			; $40ce
	jr z,_label_06_008	; $40cf
	cp c			; $40d1
	jr z,_label_06_006	; $40d2
	inc hl			; $40d4
	inc hl			; $40d5
	jr _label_06_005		; $40d6
_label_06_006:
	ldi a,(hl)		; $40d8
	cp b			; $40d9
	jr z,_label_06_007	; $40da
	inc hl			; $40dc
	jr _label_06_005		; $40dd
_label_06_007:
	ld c,(hl)		; $40df
	ld b,$2e		; $40e0
	call showText		; $40e2
	scf			; $40e5
	ret			; $40e6
_label_06_008:
	ld bc,$0901		; $40e7
_label_06_009:
	call showText		; $40ea
	scf			; $40ed
	ret			; $40ee
	ld a,($cc46)		; $40ef
	and $01			; $40f2
	jr z,_label_06_010	; $40f4
	ld a,($d008)		; $40f6
	ld hl,$4107		; $40f9
	rst_addAToHl			; $40fc
	ld a,($d033)		; $40fd
	and (hl)		; $4100
	cp (hl)			; $4101
	jr nz,_label_06_010	; $4102
	cp $c0			; $4104
	ret			; $4106
	ret nz			; $4107
	inc bc			; $4108
	jr nc,_label_06_011	; $4109
_label_06_010:
	pop af			; $410b
	xor a			; $410c
	ret			; $410d
	call $4314		; $410e
	jp z,$41dd		; $4111
	call $41e3		; $4114
_label_06_011:
	ret nz			; $4117
	bit 6,b			; $4118
	jr z,_label_06_012	; $411a
	ld a,$16		; $411c
	call checkTreasureObtained		; $411e
	ld a,$03		; $4121
	jp nc,$42e6		; $4123
_label_06_012:
	bit 7,b			; $4126
	jr nz,_label_06_013	; $4128
	ld a,b			; $412a
	swap a			; $412b
	and $03			; $412d
	ld l,a			; $412f
	ld a,($cc80)		; $4130
	cp l			; $4133
	jr nz,_label_06_014	; $4134
_label_06_013:
	call $4389		; $4136
	jr nc,_label_06_014	; $4139
	ld hl,$d140		; $413b
	ld a,(hl)		; $413e
	or a			; $413f
	jr nz,_label_06_014	; $4140
	ld (hl),$01		; $4142
	inc l			; $4144
	ld (hl),$14		; $4145
	ld a,($cc80)		; $4147
	swap a			; $414a
	rrca			; $414c
	ld l,$49		; $414d
	ld (hl),a		; $414f
	ldh a,(<hFF8D)	; $4150
	ld l,$70		; $4152
	ld (hl),a		; $4154
	ld l,$4b		; $4155
	call setShortPosition		; $4157
	ld l,$4b		; $415a
	dec (hl)		; $415c
	dec (hl)		; $415d
_label_06_014:
	xor a			; $415e
	jp $41dd		; $415f
	call $4314		; $4162
	jp z,$41dd		; $4165
	call $41e3		; $4168
	ret nz			; $416b
	call $433b		; $416c
	ld a,$02		; $416f
	jp z,$42e6		; $4171
	call $4246		; $4174
	ld a,$a0		; $4177
	call setTile		; $4179
	ld a,$6c		; $417c
	call playSound		; $417e
	call getThisRoomFlags		; $4181
	set 7,(hl)		; $4184
	call getFreeInteractionSlot		; $4186
	jr nz,_label_06_015	; $4189
	ld (hl),$05		; $418b
	ld l,$4b		; $418d
	ldh a,(<hFF8D)	; $418f
	call setShortPosition		; $4191
_label_06_015:
	xor a			; $4194
	jr _label_06_019		; $4195
	call $4314		; $4197
	jr z,_label_06_019	; $419a
	call $41e3		; $419c
	jr z,_label_06_016	; $419f
	dec (hl)		; $41a1
	ret nz			; $41a2
_label_06_016:
	call $433b		; $41a3
	jr z,_label_06_018	; $41a6
	ld hl,$d040		; $41a8
	ld a,(hl)		; $41ab
	or a			; $41ac
	jr nz,_label_06_017	; $41ad
	call $4246		; $41af
	ld hl,$d040		; $41b2
	ld (hl),$01		; $41b5
	inc l			; $41b7
	ld (hl),$1e		; $41b8
	ldh a,(<hFF8D)	; $41ba
	ld l,$4b		; $41bc
	ld (hl),a		; $41be
	ld l,$49		; $41bf
	ld a,b			; $41c1
	swap a			; $41c2
	and $0f			; $41c4
	add a			; $41c6
	ld (hl),a		; $41c7
	push de			; $41c8
	add a			; $41c9
	call setRoomFlagsForUnlockedKeyDoor		; $41ca
	pop de			; $41cd
_label_06_017:
	xor a			; $41ce
	jr _label_06_019		; $41cf
_label_06_018:
	ld a,b			; $41d1
	cp $40			; $41d2
	ld a,$01		; $41d4
	jp nc,$42e6		; $41d6
	xor a			; $41d9
	jp $42e6		; $41da
_label_06_019:
	ld a,$14		; $41dd
	ld ($cc84),a		; $41df
	ret			; $41e2
	ld hl,$cc84		; $41e3
	dec (hl)		; $41e6
	ret			; $41e7
	call getThisRoomFlags		; $41e8
	and $80			; $41eb
	ret nz			; $41ed
	call $4314		; $41ee
	jr z,_label_06_019	; $41f1
	call $40f6		; $41f3
	jr z,_label_06_020	; $41f6
	xor a			; $41f8
	ret			; $41f9
_label_06_020:
	call $41e3		; $41fa
	jr z,_label_06_021	; $41fd
	dec (hl)		; $41ff
	ret nz			; $4200
_label_06_021:
	ld a,($cc4c)		; $4201
	ld hl,$4238		; $4204
	call findRoomSpecificData		; $4207
	ld b,a			; $420a
	jr nc,_label_06_022	; $420b
	call checkTreasureObtained		; $420d
	jr nc,_label_06_022	; $4210
	ld a,$6c		; $4212
	call playSound		; $4214
	call getThisRoomFlags		; $4217
	set 7,(hl)		; $421a
	ld hl,$cfc0		; $421c
	set 0,(hl)		; $421f
	call $4246		; $4221
	ld l,$41		; $4224
	inc (hl)		; $4226
	ld a,b			; $4227
	sub $42			; $4228
	ld l,$42		; $422a
	ldi (hl),a		; $422c
	ld (hl),a		; $422d
	ld a,$81		; $422e
	ld ($cca4),a		; $4230
	ld ($cc02),a		; $4233
	scf			; $4236
	ret			; $4237
	ldd a,(hl)		; $4238
	ld b,d			; $4239
	sub (hl)		; $423a
	ld b,d			; $423b
	add c			; $423c
	ld b,e			; $423d
	dec c			; $423e
	ld b,h			; $423f
	nop			; $4240
_label_06_022:
	ld a,$08		; $4241
	jp $42e6		; $4243
	call getFreeInteractionSlot		; $4246
	ret nz			; $4249
	ld (hl),$17		; $424a
	inc l			; $424c
	ldh a,(<hFF8B)	; $424d
	ld (hl),a		; $424f
	ldh a,(<hFF8D)	; $4250
	ld l,$4b		; $4252
	jp setShortPosition		; $4254
	call $4314		; $4257
	jp z,$41dd		; $425a
	call $40f6		; $425d
	jr z,_label_06_023	; $4260
	xor a			; $4262
	ret			; $4263
_label_06_023:
	call $41e3		; $4264
	jr z,_label_06_024	; $4267
	dec (hl)		; $4269
	ret nz			; $426a
_label_06_024:
	ld a,$0b		; $426b
	call checkGlobalFlag		; $426d
	jr z,_label_06_022	; $4270
	ld a,$6c		; $4272
	call playSound		; $4274
	call getThisRoomFlags		; $4277
	set 6,(hl)		; $427a
	ld a,$e8		; $427c
	call setTile		; $427e
	call $4246		; $4281
	scf			; $4284
	ret			; $4285
	ld a,($cc3a)		; $4286
	or a			; $4289
	ret nz			; $428a
	call $4314		; $428b
	jp z,$41dd		; $428e
	call $41e3		; $4291
	ret nz			; $4294
	ldh a,(<hFF8D)	; $4295
	ld l,a			; $4297
	ld h,$cf		; $4298
	ld (hl),$00		; $429a
	call convertShortToLongPosition		; $429c
	call getFreeEnemySlot		; $429f
	ret nz			; $42a2
	ld (hl),$17		; $42a3
	inc l			; $42a5
	inc (hl)		; $42a6
	ld l,$8b		; $42a7
	ld (hl),b		; $42a9
	ld l,$8d		; $42aa
	ld (hl),c		; $42ac
	ret			; $42ad
	call $4314		; $42ae
	jp z,$41dd		; $42b1
	call $41e3		; $42b4
	ret nz			; $42b7
	call $41dd		; $42b8
	ld a,b			; $42bb
	swap a			; $42bc
	and $0f			; $42be
	rst_jumpTable			; $42c0
	bit 0,d			; $42c1
	sub $42			; $42c3
	jp c,$de42		; $42c5
	ld b,d			; $42c8
	ld ($ff00+c),a		; $42c9
	ld b,d			; $42ca
	ld a,$16		; $42cb
	call checkTreasureObtained		; $42cd
	ccf			; $42d0
	ret nc			; $42d1
	ld a,$03		; $42d2
	jr _label_06_025		; $42d4
	ld a,$05		; $42d6
	jr _label_06_025		; $42d8
	ld a,$06		; $42da
	jr _label_06_025		; $42dc
	ld a,$07		; $42de
	jr _label_06_025		; $42e0
	ld a,$04		; $42e2
	jr _label_06_025		; $42e4
_label_06_025:
	ld hl,$4300		; $42e6
	rst_addDoubleIndex			; $42e9
	ldi a,(hl)		; $42ea
	ld b,a			; $42eb
	ld c,(hl)		; $42ec
	call $41dd		; $42ed
	ld hl,$ccee		; $42f0
	ld a,(hl)		; $42f3
	and b			; $42f4
	ret nz			; $42f5
	ld a,(hl)		; $42f6
	or b			; $42f7
	ld (hl),a		; $42f8
	ld b,$51		; $42f9
	call showText		; $42fb
	scf			; $42fe
	ret			; $42ff
	inc b			; $4300
	nop			; $4301
	ld (bc),a		; $4302
	ld bc,$0204		; $4303
	ld ($2003),sp		; $4306
	inc b			; $4309
	stop			; $430a
	dec b			; $430b
	jr nz,_label_06_026	; $430c
	jr nz,_label_06_027	; $430e
	jr nz,$09		; $4310
	ld b,b			; $4312
	ld a,(bc)		; $4313
_label_06_026:
	ld a,($cc80)		; $4314
	rlca			; $4317
_label_06_027:
	jr c,_label_06_028	; $4318
	ld a,($cc47)		; $431a
	and $07			; $431d
	jr nz,_label_06_028	; $431f
	call $432a		; $4321
	jr nc,_label_06_028	; $4324
	or d			; $4326
	ret			; $4327
_label_06_028:
	xor a			; $4328
	ret			; $4329
	ld h,d			; $432a
	ld l,$0b		; $432b
	call $4333		; $432d
	ret c			; $4330
	ld l,$0d		; $4331
	ld a,(hl)		; $4333
	and $0f			; $4334
	sub $03			; $4336
	cp $0b			; $4338
	ret			; $433a
	ld a,$0b		; $433b
	call checkGlobalFlag		; $433d
	ret nz			; $4340

_checkAndDecKeyCount:
	ld a,($cc55)		; $4341
	cp $ff			; $4344
	ret z			; $4346
	ld a,b			; $4347
	cp $40			; $4348
	ld h,$c6		; $434a
	ld a,($cc55)		; $434c
	jr nc,_label_06_029	; $434f

	add $6e			; $4351
	ld l,a			; $4353
	ld a,(hl)		; $4354
	or a			; $4355
	ret z			; $4356
	dec (hl)		; $4357
	ld hl,$cbea		; $4358
	set 4,(hl)		; $435b
	or h			; $435d
	ret			; $435e
_label_06_029:
	ld l,$7a		; $435f
	jp checkFlag		; $4361
	ld e,$08		; $4364
	ld a,(de)		; $4366
	ld hl,$4381		; $4367
	rst_addDoubleIndex			; $436a
	ld e,$0b		; $436b
	ld a,(de)		; $436d
	add (hl)		; $436e
	and $f0			; $436f
	ld c,a			; $4371
	inc hl			; $4372
	ld e,$0d		; $4373
	ld a,(de)		; $4375
	add (hl)		; $4376
	swap a			; $4377
	and $0f			; $4379
	or c			; $437b
	ld c,a			; $437c
	ld b,$cf		; $437d
	ld a,(bc)		; $437f
	ret			; $4380
.DB $fc				; $4381
	nop			; $4382
	nop			; $4383
	rlca			; $4384
	ld ($0000),sp		; $4385
	ld hl,sp-$06		; $4388
	add b			; $438a
	call z,$9b21		; $438b
	ld b,e			; $438e
	rst_addDoubleIndex			; $438f
	call $436b		; $4390
	ld b,$ce		; $4393
	ld a,(bc)		; $4395
	and $0f			; $4396
	ret nz			; $4398
	scf			; $4399
	ret			; $439a
.DB $ec				; $439b
	nop			; $439c
	nop			; $439d
	inc d			; $439e
	jr _label_06_030		; $439f
_label_06_030:
	nop			; $43a1
.DB $eb				; $43a2
	xor a			; $43a3
	ld b,e			; $43a4
	jp nz,$c843		; $43a5
	ld b,e			; $43a8
	ret			; $43a9
	ld b,e			; $43aa
	ret			; $43ab
	ld b,e			; $43ac
	rlca			; $43ad
	ld b,h			; $43ae
	sub $80			; $43af
	ret nz			; $43b1
	inc bc			; $43b2
	pop bc			; $43b3
	inc bc			; $43b4
	jp nz,$9603		; $43b5
	ld b,e			; $43b8
	pop af			; $43b9
	inc b			; $43ba
	ld a,($ff00+c)		; $43bb
	dec b			; $43bc
.DB $ec				; $43bd
	ld b,$d5		; $43be
	ld ($f100),sp		; $43c0
	inc b			; $43c3
	ld a,($ff00+c)		; $43c4
	dec b			; $43c5
.DB $ec				; $43c6
	rlca			; $43c7
	nop			; $43c8
	jr _label_06_031		; $43c9
_label_06_031:
	add hl,de		; $43cb
	stop			; $43cc
	ld a,(de)		; $43cd
	jr nz,_label_06_032	; $43ce
	jr nc,_label_06_033	; $43d0
	add b			; $43d2
	ldi a,(hl)		; $43d3
	add b			; $43d4
	inc l			; $43d5
	add b			; $43d6
	dec l			; $43d7
	add b			; $43d8
	stop			; $43d9
	ret nz			; $43da
	ld de,$12c0		; $43db
	ret nz			; $43de
	inc de			; $43df
	ret nz			; $43e0
	dec h			; $43e1
	add b			; $43e2
	cpl			; $43e3
	add b			; $43e4
	ld e,$01		; $43e5
	ld (hl),b		; $43e7
	ld (bc),a		; $43e8
	ld (hl),c		; $43e9
	ld (de),a		; $43ea
_label_06_032:
	ld (hl),d		; $43eb
	ldi (hl),a		; $43ec
	ld (hl),e		; $43ed
_label_06_033:
	ldd (hl),a		; $43ee
	ld (hl),h		; $43ef
	ld b,d			; $43f0
	ld (hl),l		; $43f1
	ld d,d			; $43f2
	halt			; $43f3
	ld h,d			; $43f4
	ld (hl),a		; $43f5
	ld (hl),d		; $43f6
	rra			; $43f7
	inc de			; $43f8
	jr nc,$23		; $43f9
	ld sp,$3223		; $43fb
	inc hl			; $43fe
	inc sp			; $43ff
	inc hl			; $4400
	ld ($f133),sp		; $4401
	inc b			; $4404
	ld a,($ff00+c)		; $4405
	dec b			; $4406
	nop			; $4407
	ld e,$30		; $4408
	ld (de),a		; $440a
	add a			; $440b
	ld c,a			; $440c
	ld b,$00		; $440d
	ld a,($d001)		; $440f
	jr _label_06_034		; $4412
	ld h,d			; $4414
	ld l,$20		; $4415
	dec (hl)		; $4417
	ret nz			; $4418
	ld l,$22		; $4419
	jr _label_06_035		; $441b
	ld e,$01		; $441d
	ld a,(de)		; $441f
_label_06_034:
	ld hl,$446f		; $4420
	rst_addDoubleIndex			; $4423
	ldi a,(hl)		; $4424
	ld h,(hl)		; $4425
	ld l,a			; $4426
	add hl,bc		; $4427
_label_06_035:
	ldi a,(hl)		; $4428
	ld h,(hl)		; $4429
	ld l,a			; $442a
	ldi a,(hl)		; $442b
	cp $ff			; $442c
	jr nz,_label_06_036	; $442e
	ld c,(hl)		; $4430
	ld b,a			; $4431
	add hl,bc		; $4432
	ldi a,(hl)		; $4433
_label_06_036:
	ld e,$20		; $4434
	ld (de),a		; $4436
	inc e			; $4437
	ldi a,(hl)		; $4438
	ld c,a			; $4439
	ldi a,(hl)		; $443a
	ld (de),a		; $443b
	inc e			; $443c
	ld a,l			; $443d
	ld (de),a		; $443e
	inc e			; $443f
	ld a,h			; $4440
	ld (de),a		; $4441
	ld e,$31		; $4442
	ld a,c			; $4444
	ld (de),a		; $4445
	ret			; $4446
	add hl,sp		; $4447
	ld d,a			; $4448
	add hl,sp		; $4449
	ld d,a			; $444a
	cp $5d			; $444b
	inc hl			; $444d
	ld e,(hl)		; $444e
	dec sp			; $444f
	ld e,(hl)		; $4450
	ld d,e			; $4451
	ld e,(hl)		; $4452
	ld l,e			; $4453
	ld e,(hl)		; $4454
	add e			; $4455
	ld e,(hl)		; $4456
	add hl,sp		; $4457
	ld d,a			; $4458
	jp nc,$a85e		; $4459
	ld e,(hl)		; $445c
	cp h			; $445d
	ld h,c			; $445e
	sbc c			; $445f
	ld h,h			; $4460
	cpl			; $4461
	ld h,a			; $4462
	ld l,e			; $4463
	ld e,a			; $4464
	cp h			; $4465
	ld h,c			; $4466
	sbc c			; $4467
	ld h,h			; $4468
	cpl			; $4469
	ld h,a			; $446a
	ld l,e			; $446b
	ld e,a			; $446c
	jp nc,$215e		; $446d
	ld e,d			; $4470
	sub c			; $4471
	ld e,d			; $4472
	ld d,$5e		; $4473
	sbc e			; $4475
	ld e,(hl)		; $4476
	sbc e			; $4477
	ld e,(hl)		; $4478
	sbc e			; $4479
	ld e,(hl)		; $447a
	sbc e			; $447b
	ld e,(hl)		; $447c
	sbc e			; $447d
	ld e,(hl)		; $447e
	sub a			; $447f
	ld e,d			; $4480
	ld hl,$b45a		; $4481
	ld e,(hl)		; $4484
	ld e,b			; $4485
	ld h,d			; $4486
	dec sp			; $4487
	ld h,l			; $4488
.DB $ec				; $4489
	ld h,a			; $448a
	ld d,$60		; $448b
	ld e,b			; $448d
	ld h,d			; $448e
	dec sp			; $448f
	ld h,l			; $4490
.DB $ec				; $4491
	ld h,a			; $4492
	ld d,$60		; $4493
	jp nc,$9e5e		; $4495
	ld e,l			; $4498
	sbc (hl)		; $4499
	ld e,l			; $449a
	sbc (hl)		; $449b
	ld e,l			; $449c
	sbc (hl)		; $449d
	ld e,l			; $449e
	sbc (hl)		; $449f
	ld e,l			; $44a0
	sbc (hl)		; $44a1
	ld e,l			; $44a2
	sbc (hl)		; $44a3
	ld e,l			; $44a4
	sbc (hl)		; $44a5
	ld e,l			; $44a6
	sbc (hl)		; $44a7
	ld e,l			; $44a8
	sbc (hl)		; $44a9
	ld e,l			; $44aa
	call z,$315e		; $44ab
	ld h,h			; $44ae
	call $4b66		; $44af
	ld l,c			; $44b2
	ld c,d			; $44b3
	ld h,c			; $44b4
	ld sp,$cd64		; $44b5
	ld h,(hl)		; $44b8
	ld c,e			; $44b9
	ld l,c			; $44ba
	ld c,d			; $44bb
	ld h,c			; $44bc
	jp nc,$3e5e		; $44bd
	rst $38			; $44c0
	ld ($cc80),a		; $44c1
	ld a,($d01a)		; $44c4
	rlca			; $44c7
	jr nc,_label_06_038	; $44c8
	call $4549		; $44ca
	ld a,($d001)		; $44cd
	ld hl,$4502		; $44d0
	rst_addAToHl			; $44d3
	ld a,b			; $44d4
	cp (hl)			; $44d5
	jr c,_label_06_037	; $44d6
	ld a,($d008)		; $44d8
	add b			; $44db
_label_06_037:
	ld h,$d0		; $44dc
	call $44ea		; $44de
_label_06_038:
	ld hl,$d11a		; $44e1
	bit 7,(hl)		; $44e4
	ret z			; $44e6
	ld l,$31		; $44e7
	ld a,(hl)		; $44e9
	ld l,$32		; $44ea
	cp (hl)			; $44ec
	ret z			; $44ed
	ld (hl),a		; $44ee
	call $450c		; $44ef
	ret z			; $44f2
	ld e,$01		; $44f3
	ld a,(de)		; $44f5
	cp $0a			; $44f6
	ld de,$8701		; $44f8
	jr c,_label_06_039	; $44fb
	ld d,$86		; $44fd
_label_06_039:
	jp queueDmaTransfer		; $44ff
	ld d,h			; $4502
	jr nz,_label_06_040	; $4503
_label_06_040:
	nop			; $4505
	nop			; $4506
	nop			; $4507
	nop			; $4508
	nop			; $4509
	ld b,b			; $450a
	rst $38			; $450b
	ld c,a			; $450c
	ld b,$00		; $450d
	ld d,h			; $450f
	ld l,$01		; $4510
	ld a,(hl)		; $4512
	ld e,a			; $4513
	ld hl,$4447		; $4514
	rst_addDoubleIndex			; $4517
	ldi a,(hl)		; $4518
	ld h,(hl)		; $4519
	ld l,a			; $451a
	add hl,bc		; $451b
	add hl,bc		; $451c
	add hl,bc		; $451d
	ldi a,(hl)		; $451e
	push hl			; $451f
	add a			; $4520
	ld c,a			; $4521
	ld a,e			; $4522
	ld hl,$4497		; $4523
	rst_addDoubleIndex			; $4526
	ldi a,(hl)		; $4527
	ld h,(hl)		; $4528
	ld l,a			; $4529
	add hl,bc		; $452a
	ld e,$1e		; $452b
	ldi a,(hl)		; $452d
	ld (de),a		; $452e
	inc e			; $452f
	ldi a,(hl)		; $4530
	and $3f			; $4531
	ld (de),a		; $4533
	pop hl			; $4534
	ldi a,(hl)		; $4535
	ld h,(hl)		; $4536
	ld l,a			; $4537
	or h			; $4538
	ret z			; $4539
	ld a,l			; $453a
	and $01			; $453b
	add $1a			; $453d
	ld c,a			; $453f
	ld a,l			; $4540
	and $1e			; $4541
	dec a			; $4543
	ld b,a			; $4544
	res 4,l			; $4545
	or d			; $4547
	ret			; $4548
	ld a,($d001)		; $4549
	or a			; $454c
	jr z,_label_06_041	; $454d
	ld a,($d031)		; $454f
	ld b,a			; $4552
	ret			; $4553
_label_06_041:
	ld hl,$d200		; $4554
	ld bc,$0000		; $4557
_label_06_042:
	ld l,$3f		; $455a
	ld a,(hl)		; $455c
	cp c			; $455d
	jr c,_label_06_043	; $455e
	ld c,a			; $4560
	ld l,$31		; $4561
	ld b,(hl)		; $4563
_label_06_043:
	inc h			; $4564
	ld a,h			; $4565
	cp $d6			; $4566
	jr c,_label_06_042	; $4568
	ld a,($d03f)		; $456a
	cp c			; $456d
	ret c			; $456e
	ld a,($d031)		; $456f
	ld b,a			; $4572
	ld a,($d030)		; $4573
	cp $10			; $4576
	ret nz			; $4578
	call $457f		; $4579
	add b			; $457c
	ld b,a			; $457d
	ret			; $457e
	ld c,$00		; $457f
	ld a,($cc75)		; $4581
	bit 6,a			; $4584
	ret nz			; $4586
	or a			; $4587
	jr z,_label_06_044	; $4588
	ld c,$02		; $458a
_label_06_044:
	ld a,($cc48)		; $458c
	rrca			; $458f
	jr nc,_label_06_045	; $4590
	ld a,($d101)		; $4592
	cp $0a			; $4595
	jr nz,_label_06_045	; $4597
	inc c			; $4599
_label_06_045:
	ld a,c			; $459a
	or a			; $459b
	jr nz,_label_06_051	; $459c
	ld a,($cc79)		; $459e
	or a			; $45a1
	jr z,_label_06_046	; $45a2
	ld c,$09		; $45a4
	jr _label_06_051		; $45a6
_label_06_046:
	ld a,($cc89)		; $45a8
	or a			; $45ab
	jr z,_label_06_047	; $45ac
	ld c,$07		; $45ae
	cp $02			; $45b0
	jr c,_label_06_051	; $45b2
	inc c			; $45b4
	jr _label_06_051		; $45b5
_label_06_047:
	ld a,($cc7b)		; $45b7
	or a			; $45ba
	jr nz,_label_06_049	; $45bb
	ld a,($cc81)		; $45bd
	dec a			; $45c0
	jr z,_label_06_048	; $45c1
	ld a,($cc81)		; $45c3
	rlca			; $45c6
	jr c,_label_06_049	; $45c7
	ld a,($cc83)		; $45c9
	ld l,a			; $45cc
	ld a,($cba0)		; $45cd
	or l			; $45d0
	jr nz,_label_06_049	; $45d1
	call checkLinkPushingAgainstWall		; $45d3
	jr nc,_label_06_049	; $45d6
_label_06_048:
	ld a,($d008)		; $45d8
	ld ($cc80),a		; $45db
	ld c,$04		; $45de
	jr _label_06_051		; $45e0
_label_06_049:
	ld a,($c681)		; $45e2
	cp $01			; $45e5
	jr z,_label_06_050	; $45e7
	ld a,($c680)		; $45e9
	cp $01			; $45ec
	jr nz,_label_06_051	; $45ee
_label_06_050:
	ld c,$05		; $45f0
	ld a,($c6a9)		; $45f2
	cp $01			; $45f5
	jr z,_label_06_051	; $45f7
	ld c,$06		; $45f9
_label_06_051:
	ld a,($cc83)		; $45fb
	or a			; $45fe
	jr z,_label_06_052	; $45ff
	xor a			; $4601
	ld ($d008),a		; $4602
_label_06_052:
	ld a,c			; $4605
	add a			; $4606
	add a			; $4607
	ld ($d034),a		; $4608
	ret			; $460b
	ld hl,$cc71		; $460c
	ld a,(hl)		; $460f
	or a			; $4610
	jr z,_label_06_053	; $4611
	dec (hl)		; $4613
	jr _label_06_054		; $4614
_label_06_053:
	ld a,($cc50)		; $4616
	and $60			; $4619
	jr nz,_label_06_054	; $461b
	ld a,($cc02)		; $461d
	or a			; $4620
	jr nz,_label_06_054	; $4621
	ld a,($ccea)		; $4623
	ld b,a			; $4626
	ld a,($cc75)		; $4627
	or b			; $462a
	jr nz,_label_06_054	; $462b
	ld a,($c6c5)		; $462d
	ld e,a			; $4630
	ld hl,$463c		; $4631
	call lookupKey		; $4634
	ld b,a			; $4637
	ret			; $4638
_label_06_054:
	ld b,$00		; $4639
	ret			; $463b
	ldi a,(hl)		; $463c
	dec b			; $463d
	dec hl			; $463e
	ld b,$2c		; $463f
	rlca			; $4641
	dec l			; $4642
	inc bc			; $4643
	ld l,$04		; $4644
	nop			; $4646
	ld e,$25		; $4647
	ld a,(de)		; $4649
	or a			; $464a
	ret z			; $464b
	ld b,a			; $464c
	ld hl,$468d		; $464d
	ld a,($c6c5)		; $4650
	ld e,a			; $4653
_label_06_055:
	ldi a,(hl)		; $4654
	or a			; $4655
	jr z,_label_06_056	; $4656
	cp e			; $4658
	jr z,_label_06_059	; $4659
	inc hl			; $465b
	jr _label_06_055		; $465c
_label_06_056:
	ld a,e			; $465e
	cp $08			; $465f
	jr z,_label_06_057	; $4661
	cp $09			; $4663
	jr z,_label_06_058	; $4665
	cp $0a			; $4667
	ret nz			; $4669
	ld a,b			; $466a
	add a			; $466b
	jr _label_06_060		; $466c
_label_06_057:
	ld a,b			; $466e
	sra a			; $466f
	jr _label_06_060		; $4671
_label_06_058:
	ld a,b			; $4673
	cpl			; $4674
	inc a			; $4675
	add a			; $4676
	add a			; $4677
	add b			; $4678
	sra a			; $4679
	sra a			; $467b
	cpl			; $467d
	inc a			; $467e
	jr _label_06_060		; $467f
_label_06_059:
	ld a,(hl)		; $4681
	add b			; $4682
_label_06_060:
	bit 7,a			; $4683
	jr nz,_label_06_061	; $4685
	ld a,$ff		; $4687
_label_06_061:
	ld e,$25		; $4689
	ld (de),a		; $468b
	ret			; $468c
	ld bc,$02fe		; $468d
.DB $fc				; $4690
	inc bc			; $4691
	ld hl,sp+$04		; $4692
	ld bc,checkFlag		; $4694
	ld b,$03		; $4697
	nop			; $4699
	ld h,d			; $469a
	ld l,$25		; $469b
	ld a,(hl)		; $469d
	ld (hl),$00		; $469e
	or a			; $46a0
	jr z,_label_06_063	; $46a1
	ld b,a			; $46a3
	ld a,$3f		; $46a4
	call cpActiveRing		; $46a6
	jr nz,_label_06_062	; $46a9
	ld b,$f8		; $46ab
_label_06_062:
	ld l,$29		; $46ad
	ld a,(hl)		; $46af
	add b			; $46b0
	ld (hl),a		; $46b1
_label_06_063:
	ld l,$2a		; $46b2
	ld a,(hl)		; $46b4
	or a			; $46b5
	jr z,_label_06_064	; $46b6
	ld a,$10		; $46b8
	call cpActiveRing		; $46ba
	jr nz,_label_06_064	; $46bd
	ld l,$2d		; $46bf
	srl (hl)		; $46c1
_label_06_064:
	ld hl,$c6a2		; $46c3
	ld e,$29		; $46c6
	ld a,(de)		; $46c8
	bit 7,a			; $46c9
	jr z,_label_06_066	; $46cb
	ld a,(de)		; $46cd
_label_06_065:
	dec (hl)		; $46ce
	add $02			; $46cf
	jr nc,_label_06_065	; $46d1
	ld (de),a		; $46d3
_label_06_066:
	ld a,(hl)		; $46d4
	dec a			; $46d5
	rlca			; $46d6
	jr nc,_label_06_068	; $46d7
	ld a,$2f		; $46d9
	call checkTreasureObtained		; $46db
	jr nc,_label_06_067	; $46de
	ld hl,$c6a3		; $46e0
	ldd a,(hl)		; $46e3
	ld (hl),a		; $46e4
	ld a,$01		; $46e5
	ld (de),a		; $46e7
	ld a,$2f		; $46e8
	call loseTreasure		; $46ea
	jr _label_06_068		; $46ed
_label_06_067:
	xor a			; $46ef
	ld (de),a		; $46f0
	ld (hl),a		; $46f1
	ld ($cc89),a		; $46f2
	ld e,$04		; $46f5
	ld a,(de)		; $46f7
	cp $0d			; $46f8
	jr z,_label_06_068	; $46fa
	ld a,$ff		; $46fc
	ld ($cc34),a		; $46fe
	call clearAllParentItems		; $4701
_label_06_068:
	ld a,(wFrameCounter)		; $4704
	rrca			; $4707
	jr nc,_label_06_069	; $4708
	ld e,$2e		; $470a
	ld a,(de)		; $470c
	or a			; $470d
	jr z,_label_06_069	; $470e
	dec a			; $4710
	ld (de),a		; $4711
_label_06_069:
	ret			; $4712
	ld a,b			; $4713
	and $f0			; $4714
	or $08			; $4716
	ldh (<hFF90),a	; $4718
	ld a,c			; $471a
	and $f0			; $471b
	or $08			; $471d
	ldh (<hFF91),a	; $471f
	call getTileAtPosition		; $4721
	ldh (<hFF92),a	; $4724
	ld e,a			; $4726
	ld a,l			; $4727
	ldh (<hFF93),a	; $4728
	ld hl,$75c0		; $472a
	call lookupCollisionTable_paramE		; $472d
	ret nc			; $4730
	ld e,a			; $4731
	add a			; $4732
	ld hl,$76e4		; $4733
	rst_addDoubleIndex			; $4736
	ld a,e			; $4737
	rst_addAToHl			; $4738
	ldh a,(<hFF8F)	; $4739
	ld e,a			; $473b
	and $1f			; $473c
	call checkFlag		; $473e
	ret z			; $4741
	rl e			; $4742
	ret c			; $4744
	inc hl			; $4745
	inc hl			; $4746
	ldi a,(hl)		; $4747
	swap a			; $4748
	and $0f			; $474a
	ldh (<hFF8D),a	; $474c
	ldi a,(hl)		; $474e
	ldh (<hFF8E),a	; $474f
	push de			; $4751
	ld a,(hl)		; $4752
	or a			; $4753
	jr z,_label_06_072	; $4754
	ld a,($cc49)		; $4756
	cp $03			; $4759
	jr c,_label_06_070	; $475b
	ldh a,(<hFF92)	; $475d
	cp $10			; $475f
	jr nz,_label_06_070	; $4761
	ldh a,(<hFF93)	; $4763
	push hl			; $4765
	call getTileIndexFromRoomLayoutBuffer		; $4766
	pop hl			; $4769
	jr nc,_label_06_071	; $476a
_label_06_070:
	ldh a,(<hFF93)	; $476c
	ld c,a			; $476e
	ld b,(hl)		; $476f
	call setTileInRoomLayoutBuffer		; $4770
	ld a,(hl)		; $4773
_label_06_071:
	call setTile		; $4774
_label_06_072:
	ldh a,(<hFF92)	; $4777
	cp $f2			; $4779
	ld hl,$c626		; $477b
	call z,incHlRefWithCap		; $477e
	ldh a,(<hFF8E)	; $4781
	rlca			; $4783
	ldh a,(<hFF92)	; $4784
	call c,updateRoomFlagsForBrokenTile		; $4786
	ldh a,(<hFF8E)	; $4789
	bit 6,a			; $478b
	ld a,$4d		; $478d
	call nz,playSound		; $478f
	ld hl,$ccc5		; $4792
	ldh a,(<hFF93)	; $4795
	cp (hl)			; $4797
	jr nz,_label_06_073	; $4798
	ld (hl),$ff		; $479a
	jr _label_06_074		; $479c
_label_06_073:
	ldh a,(<hFF8D)	; $479e
	or a			; $47a0
	call nz,$47ef		; $47a1
_label_06_074:
	ldh a,(<hFF8F)	; $47a4
	or a			; $47a6
	jr z,_label_06_075	; $47a7
	cp $0c			; $47a9
	jr z,_label_06_075	; $47ab
	cp $08			; $47ad
	jr z,_label_06_075	; $47af
	cp $12			; $47b1
	ldh a,(<hFF8E)	; $47b3
	call nz,$47c8		; $47b5
_label_06_075:
	pop de			; $47b8
	scf			; $47b9
	ret			; $47ba
	ld h,d			; $47bb
	ld l,$0b		; $47bc
	ldi a,(hl)		; $47be
	ldh (<hFF90),a	; $47bf
	inc l			; $47c1
	ldi a,(hl)		; $47c2
	ldh (<hFF91),a	; $47c3
	ld l,$03		; $47c5
	ld a,(hl)		; $47c7
	and $1f			; $47c8
	cp $1f			; $47ca
	ret z			; $47cc
	ld c,a			; $47cd
	call getFreeInteractionSlot		; $47ce
	ret nz			; $47d1
	ld a,c			; $47d2
	and $0f			; $47d3
	ldi (hl),a		; $47d5
	ld a,c			; $47d6
	and $10			; $47d7
	swap a			; $47d9
	ldi (hl),a		; $47db
	ld a,($d008)		; $47dc
	ld l,$48		; $47df
	ldi (hl),a		; $47e1
	swap a			; $47e2
	rrca			; $47e4
	ldi (hl),a		; $47e5
	inc l			; $47e6
	ldh a,(<hFF90)	; $47e7
	ldi (hl),a		; $47e9
	inc l			; $47ea
	ldh a,(<hFF91)	; $47eb
	ldi (hl),a		; $47ed
	ret			; $47ee
	push hl			; $47ef
	call func_16eb		; $47f0
	jr z,_label_06_077	; $47f3
	call getFreePartSlot		; $47f5
	jr nz,_label_06_077	; $47f8
	ld (hl),$01		; $47fa
	inc l			; $47fc
	ld (hl),c		; $47fd
	ld l,$cb		; $47fe
	ldh a,(<hFF90)	; $4800
	ldi (hl),a		; $4802
	inc l			; $4803
	ldh a,(<hFF91)	; $4804
	ld (hl),a		; $4806
	ld a,($d008)		; $4807
	swap a			; $480a
	rrca			; $480c
	ld l,$c9		; $480d
	ld (hl),a		; $480f
	ld l,$c3		; $4810
	ld a,c			; $4812
	cp $0f			; $4813
	jr nz,_label_06_076	; $4815
	ld (hl),$02		; $4817
_label_06_076:
	ldh a,(<hFF8F)	; $4819
	cp $06			; $481b
	jr nz,_label_06_077	; $481d
	inc (hl)		; $481f
_label_06_077:
	pop hl			; $4820
	ret			; $4821
	ld a,c			; $4822
	rst_jumpTable			; $4823
	ldi a,(hl)		; $4824
	ld c,b			; $4825
	ld b,d			; $4826
	ld c,b			; $4827
	ld h,l			; $4828
	ld c,b			; $4829
	push de			; $482a
	ld d,$d2		; $482b
_label_06_078:
	call _clearParentItem		; $482d
	inc d			; $4830
	ld a,d			; $4831
	cp $d6			; $4832
	jr c,_label_06_078	; $4834
	xor a			; $4836
	ld ($cc89),a		; $4837
	ld ($cc7e),a		; $483a
	ld ($cc79),a		; $483d
	pop de			; $4840
	ret			; $4841
	ld h,$d2		; $4842
_label_06_079:
	ld l,$00		; $4844
	ldi a,(hl)		; $4846
	or a			; $4847
	jr z,_label_06_080	; $4848
	ld a,($c680)		; $484a
	cp (hl)			; $484d
	ld a,$02		; $484e
	jr z,_label_06_081	; $4850
	ld a,($c681)		; $4852
	cp (hl)			; $4855
	ld a,$01		; $4856
	jr z,_label_06_081	; $4858
_label_06_080:
	xor a			; $485a
_label_06_081:
	ld l,$03		; $485b
	ld (hl),a		; $485d
	inc h			; $485e
	ld a,h			; $485f
	cp $d6			; $4860
	jr c,_label_06_079	; $4862
	ret			; $4864


b6_checkUseItems:
	xor a			; $4865
	ld ($cc89),a		; $4866
	ld hl,$cc74		; $4869
	ld a,(hl)		; $486c
	or a			; $486d
	jr z,_label_06_082	; $486e
	dec (hl)		; $4870
_label_06_082:
	ld hl,$cc7a		; $4871
	ld a,(hl)		; $4874
	and $0f			; $4875
	ld (hl),a		; $4877
	ld a,($cc7e)		; $4878
	rlca			; $487b
	jr c,_label_06_088	; $487c
	ld a,($ccea)		; $487e
	or a			; $4881
	jp nz,$497f		; $4882
	ld a,($ccaf)		; $4885
	ld b,a			; $4888
	ld a,($cc77)		; $4889
	or b			; $488c
	rlca			; $488d
	jr c,_label_06_086	; $488e
	ld a,($ccef)		; $4890
	ld b,a			; $4893
	ld a,($cc75)		; $4894
	or b			; $4897
	jr nz,_label_06_086	; $4898
	ld a,($cc83)		; $489a
	inc a			; $489d
	jr z,_label_06_086	; $489e
	ld a,($cc50)		; $48a0
	bit 5,a			; $48a3
	jr nz,_label_06_083	; $48a5
	ld a,($cc78)		; $48a7
	or a			; $48aa
	jr z,_label_06_084	; $48ab
	jr _label_06_086		; $48ad
_label_06_083:
	ld a,($cc78)		; $48af
	or a			; $48b2
	jr nz,_label_06_085	; $48b3
_label_06_084:
	ld de,addDecimalToHlRef		; $48b5
	call $48f3		; $48b8
_label_06_085:
	ld de,$0280		; $48bb
	call $48f3		; $48be
_label_06_086:
	ld de,$d200		; $48c1
_label_06_087:
	ld e,$00		; $48c4
	ld a,(de)		; $48c6
	or a			; $48c7
	call nz,$4994		; $48c8
	inc d			; $48cb
	ld a,d			; $48cc
	cp $d6			; $48cd
	jr c,_label_06_087	; $48cf
	xor a			; $48d1
	ldh (<hActiveObjectType),a	; $48d2
	ld d,$d0		; $48d4
	ld a,d			; $48d6
	ldh (<hActiveObject),a	; $48d7
	ret			; $48d9
_label_06_088:
	cp $ff			; $48da
	jr nz,_label_06_086	; $48dc
	call $482a		; $48de
	ld hl,$d200		; $48e1
	ld de,$ff05		; $48e4
	ld c,$f1		; $48e7
	call $4925		; $48e9
	ld a,$80		; $48ec
	ld ($cc7e),a		; $48ee
	jr _label_06_086		; $48f1
	ld h,$c6		; $48f3
	ld l,e			; $48f5
	ld a,(hl)		; $48f6
	or a			; $48f7
	jr nz,_label_06_091	; $48f8
	ld a,($ccc9)		; $48fa
	or a			; $48fd
	jr nz,_label_06_090	; $48fe
	ld a,($c6c5)		; $4900
	cp $0b			; $4903
	jr z,_label_06_089	; $4905
	cp $3d			; $4907
	ret nz			; $4909
_label_06_089:
	ld l,$80		; $490a
	ldi a,(hl)		; $490c
	or (hl)			; $490d
	ret nz			; $490e
_label_06_090:
	ld a,$02		; $490f
_label_06_091:
	cp $20			; $4911
	ret nc			; $4913
	ld e,a			; $4914
	ld hl,_itemUsageParameterTable		; $4915
	rst_addDoubleIndex			; $4918
	ldi a,(hl)		; $4919
	ld c,a			; $491a
	ld l,(hl)		; $491b
	ld h,$cc		; $491c
	ld a,(hl)		; $491e
	and d			; $491f
	ret z			; $4920
	call $4931		; $4921
	ret nz			; $4924

_initializeParentItem:
	ld a,c			; $4925
	and $f0			; $4926
	inc a			; $4928
	ld l,$00		; $4929
	ldi (hl),a		; $492b
	ld (hl),e		; $492c
	inc l			; $492d
	inc l			; $492e
	ld (hl),d		; $492f
	ret			; $4930
	ld a,c			; $4931
	and $0f			; $4932
	rst_jumpTable			; $4934
	ld a,l			; $4935
	ld c,c			; $4936
	ld d,c			; $4937
	ld c,c			; $4938
	ld b,(hl)		; $4939
	ld c,c			; $493a
	ld e,e			; $493b
	ld c,c			; $493c
	ld b,c			; $493d
	ld c,c			; $493e
	ld (hl),a		; $493f
	ld c,c			; $4940
	ld a,($d200)		; $4941
	or a			; $4944
	ret nz			; $4945
	ld hl,$d301		; $4946
	ld a,e			; $4949
	cp (hl)			; $494a
	jr z,_label_06_092	; $494b
	inc h			; $494d
	cp (hl)			; $494e
	jr z,_label_06_092	; $494f
	ld hl,$d300		; $4951
	ld a,(hl)		; $4954
	or a			; $4955
	ret z			; $4956
	inc h			; $4957
	ld a,(hl)		; $4958
	or a			; $4959
	ret			; $495a
	ld hl,$d200		; $495b
	ld a,c			; $495e
	and $f0			; $495f
	inc a			; $4961
	cp (hl)			; $4962
	jr c,_label_06_092	; $4963
	push de			; $4965
	push bc			; $4966
	call $49f5		; $4967
	pop bc			; $496a
	pop de			; $496b
	ld hl,$d200		; $496c
	xor a			; $496f
	ld ($cc79),a		; $4970
	ld ($cc7e),a		; $4973
	ret			; $4976
	ld hl,$d500		; $4977
	ld a,(hl)		; $497a
	or a			; $497b
	ret z			; $497c
_label_06_092:
	or h			; $497d
	ret			; $497e
	ld a,($cc75)		; $497f
	or a			; $4982
	ret nz			; $4983
	ld a,($cc46)		; $4984
	and $03			; $4987
	ret z			; $4989
	call checkGrabbableObjects		; $498a
	ret nc			; $498d
	ld a,$83		; $498e
	ld ($cc75),a		; $4990
	ret			; $4993


_parentItemUpdate:
	ld a,e			; $4994
	ldh (<hActiveObjectType),a	; $4995
	ld a,d			; $4997
	ldh (<hActiveObject),a	; $4998
	call $53de		; $499a
	ld hl,$ccaf		; $499d
	cpl			; $49a0
	and (hl)		; $49a1
	ld (hl),a		; $49a2
	ld e,$01		; $49a3
	ld a,(de)		; $49a5
	rst_jumpTable			; $49a6
	.dw _parentItemCode_punch		; ITEMID_NONE
	.dw _parentItemCode_shield              ; ITEMID_SHIELD
	.dw _parentItemCode_punch               ; ITEMID_PUNCH
	.dw _parentItemCode_bomb                ; ITEMID_BOMB
	.dw _parentItemCode_somaria             ; ITEMID_CANE_OF_SOMARIA
	.dw _parentItemCode_sword               ; ITEMID_SWORD
	.dw _parentItemCode_boomerang           ; ITEMID_BOOMERANG
	.dw _parentItemCode_rodOfSeasons        ; ITEMID_ROD_OF_SEASONS
	.dw _parentItemCode_magnetGloves        ; ITEMID_MAGNET_GLOVES
	.dw _clearParentItem                    ; ITEMID_SWITCH_HOOK_HELPER
	.dw _parentItemCode_sword               ; ITEMID_SWITCH_HOOK
	.dw _clearParentItem                    ; ITEMID_SWITCH_HOOK_CHAIN
	.dw _parentItemCode_biggoronSword       ; ITEMID_BIGGORON_SWORD
	.dw _parentItemCode_bombchu             ; ITEMID_BOMBCHUS
	.dw _parentItemCode_flute               ; ITEMID_FLUTE
	.dw _parentItemCode_shooter             ; ITEMID_SHOOTER
	.dw _clearParentItem                    ; ITEMID_10
	.dw _parentItemCode_harp                ; ITEMID_HARP
	.dw _clearParentItem                    ; ITEMID_12
	.dw _parentItemCode_slingshot           ; ITEMID_SLINGSHOT
	.dw _clearParentItem                    ; ITEMID_14
	.dw _parentItemCode_shovel              ; ITEMID_SHOVEL
	.dw _parentItemCode_bracelet            ; ITEMID_BRACELET
	.dw parentItemCode_feather              ; ITEMID_FEATHER
	.dw _clearParentItem                    ; ITEMID_18
	.dw _parentItemCode_satchel             ; ITEMID_SEED_SATCHEL
	.dw _clearParentItem                    ; ITEMID_DUST
	.dw _clearParentItem                    ; ITEMID_1b
	.dw _clearParentItem                    ; ITEMID_1c
	.dw _clearParentItem                    ; ITEMID_MINECART_COLLISION
	.dw _parentItemCode_foolsOre            ; ITEMID_FOOLS_ORE
	.dw _clearParentItem                    ; ITEMID_1f

_clearParentItem:
	call $53a2		; $49e7
	call $53cb		; $49ea
	call $53b8		; $49ed
	ld e,$00		; $49f0
	jp objectDelete_de		; $49f2
	push de			; $49f5
	ld d,h			; $49f6
	call _clearParentItem		; $49f7
	pop de			; $49fa
	ret			; $49fb


_parentItemCode_shield:
	call $4a25		; $49fc
	jr nc,_label_06_093	; $49ff
	call $52d0		; $4a01
	ret nz			; $4a04
	ld e,$04		; $4a05
	ld a,(de)		; $4a07
	rst_jumpTable			; $4a08
	dec c			; $4a09
	ld c,d			; $4a0a
	dec d			; $4a0b
	ld c,d			; $4a0c
	ld a,$01		; $4a0d
	ld (de),a		; $4a0f
	ld a,$76		; $4a10
	call playSound		; $4a12
	ld a,($c6a9)		; $4a15
	add $00			; $4a18
	ld ($cc89),a		; $4a1a
	ret			; $4a1d
_label_06_093:
	xor a			; $4a1e
	ld ($cc89),a		; $4a1f
	jp _clearParentItem		; $4a22
	ld a,($cc78)		; $4a25
	or a			; $4a28
	jr nz,_label_06_094	; $4a29
	ld a,($ccaf)		; $4a2b
	rlca			; $4a2e
	jr c,_label_06_094	; $4a2f
	ld a,($cc48)		; $4a31
	rrca			; $4a34
	jr c,_label_06_094	; $4a35
	call $53e8		; $4a37
	jr z,_label_06_094	; $4a3a
	scf			; $4a3c
	ret			; $4a3d
_label_06_094:
	xor a			; $4a3e
	ret			; $4a3f


_parentItemCode_rodOfSeasons:
	call $53f0		; $4a40
	ld e,$04		; $4a43
	ld a,(de)		; $4a45
	rst_jumpTable			; $4a46
	ld d,(hl)		; $4a47
	ld c,d			; $4a48
	sub a			; $4a49
	ld c,d			; $4a4a
	; Fall through


_parentItemCode_biggoronSword:
	call $53f0		; $4a4b
	; Fall through


_parentItemCode_foolsOre:
	ld e,$04		; $4a4e
	ld a,(de)		; $4a50
	rst_jumpTable			; $4a51
	ld e,l			; $4a52
	ld c,d			; $4a53
	sub a			; $4a54
	ld c,d			; $4a55
	ld a,($ccb6)		; $4a56
	cp $08			; $4a59
	jr nz,_label_06_095	; $4a5b
	ld e,$00		; $4a5d
	ld a,$ff		; $4a5f
	ld (de),a		; $4a61
_label_06_095:
	call updateLinkDirectionFromAngle		; $4a62
	call $52e2		; $4a65
	jp $532f		; $4a68


_parentItemCode_punch:
	ld e,$04		; $4a6b
	ld a,(de)		; $4a6d
	rst_jumpTable			; $4a6e
	ld (hl),e		; $4a6f
	ld c,d			; $4a70
	sub a			; $4a71
	ld c,d			; $4a72
	ld e,$00		; $4a73
	ld a,$ff		; $4a75
	ld (de),a		; $4a77
	call updateLinkDirectionFromAngle		; $4a78
	call $52e2		; $4a7b
	call $532f		; $4a7e
	ld a,($c6c5)		; $4a81
	cp $0b			; $4a84
	ret nz			; $4a86
	ld l,$02		; $4a87
	inc (hl)		; $4a89
	ld c,$34		; $4a8a
	ld a,($cc48)		; $4a8c
	rrca			; $4a8f
	jr nc,_label_06_096	; $4a90
	inc c			; $4a92
_label_06_096:
	ld a,c			; $4a93
	jp $4408		; $4a94
	ld e,$21		; $4a97
	ld a,(de)		; $4a99
	rlca			; $4a9a
	jp nc,$4414		; $4a9b
	jp _clearParentItem		; $4a9e


_parentItemCode_somaria:
	; Nothing here

_parentItemCode_switchHook:
	; Nothing here

_parentItemCode_sword:
	call $53f0		; $4aa1
	ld e,$04		; $4aa4
	ld a,(de)		; $4aa6
	rst_jumpTable			; $4aa7
	or (hl)			; $4aa8
	ld c,d			; $4aa9
	ld ($644a),a		; $4aaa
	ld c,e			; $4aad
	and e			; $4aae
	ld c,e			; $4aaf
.DB $e4				; $4ab0
	ld c,e			; $4ab1
	ei			; $4ab2
	ld c,e			; $4ab3
	jr _label_06_098		; $4ab4
	ld hl,$cc7e		; $4ab6
	bit 7,(hl)		; $4ab9
	jr nz,_label_06_097	; $4abb
	ld (hl),$00		; $4abd
	call updateLinkDirectionFromAngle		; $4abf
	ld a,($c6a2)		; $4ac2
	cp $05			; $4ac5
	jr c,_label_06_097	; $4ac7
	ld a,$32		; $4ac9
	call cpActiveRing		; $4acb
	jr nz,_label_06_097	; $4ace
	ld e,$3a		; $4ad0
	ld a,$f8		; $4ad2
	ld (de),a		; $4ad4
_label_06_097:
	ld hl,$d600		; $4ad5
	ld a,(hl)		; $4ad8
	or a			; $4ad9
	ld b,$40		; $4ada
	call nz,clearMemory		; $4adc
	ld h,d			; $4adf
	ld l,$00		; $4ae0
	set 7,(hl)		; $4ae2
	call $52e2		; $4ae4
	jp $532f		; $4ae7
	ld a,($cc7e)		; $4aea
	rlca			; $4aed
	jp c,$4baa		; $4aee
	call $4414		; $4af1
	ld h,d			; $4af4
	ld e,$21		; $4af5
	ld a,(de)		; $4af7
	or a			; $4af8
	jr z,_label_06_099	; $4af9
	ld l,$3a		; $4afb
	bit 7,(hl)		; $4afd
	jr nz,_label_06_099	; $4aff
_label_06_098:
	ld l,$00		; $4b01
	res 7,(hl)		; $4b03
_label_06_099:
	ld l,e			; $4b05
	bit 7,a			; $4b06
	jr nz,_label_06_100	; $4b08
	bit 5,a			; $4b0a
	ret z			; $4b0c
	res 5,(hl)		; $4b0d
	ld a,($c6ac)		; $4b0f
	cp $02			; $4b12
	jp nc,$4c4b		; $4b14
	ret			; $4b17
_label_06_100:
	ld a,($d62a)		; $4b18
	or a			; $4b1b
	jp nz,$4b4e		; $4b1c
	ld a,($cc48)		; $4b1f
	rrca			; $4b22
	jp c,$4c17		; $4b23
	call $53e8		; $4b26
	jp z,$4c17		; $4b29
	ld a,$01		; $4b2c
	ld ($cc7e),a		; $4b2e
	inc a			; $4b31
	ld ($d604),a		; $4b32
	ld a,$89		; $4b35
	ld ($d624),a		; $4b37
	ld l,$04		; $4b3a
	ld (hl),$02		; $4b3c
	inc l			; $4b3e
	xor a			; $4b3f
	ld (hl),a		; $4b40
	ld l,$3a		; $4b41
	ld (hl),a		; $4b43
	ld l,$3f		; $4b44
	ld (hl),a		; $4b46
	ld l,$06		; $4b47
	ld (hl),$28		; $4b49
	jp $53b8		; $4b4b
	bit 0,a			; $4b4e
	jp z,$4c17		; $4b50
	ld e,$3a		; $4b53
	ld a,(de)		; $4b55
	or a			; $4b56
	jp z,$4c17		; $4b57
	ld hl,$d025		; $4b5a
	add (hl)		; $4b5d
	ld (hl),a		; $4b5e
	xor a			; $4b5f
	ld (de),a		; $4b60
	jp $4c17		; $4b61
	ld a,($cc48)		; $4b64
	rrca			; $4b67
	jp c,$4c17		; $4b68
	call $53e8		; $4b6b
	jp z,$4c17		; $4b6e
	call $4c1e		; $4b71
	ld a,$16		; $4b74
	call cpActiveRing		; $4b76
	ld c,$01		; $4b79
	jr nz,_label_06_101	; $4b7b
	ld c,$04		; $4b7d
_label_06_101:
	ld l,$06		; $4b7f
	ld a,(hl)		; $4b81
	sub c			; $4b82
	ld (hl),a		; $4b83
	ret nc			; $4b84
	ld a,$31		; $4b85
	call cpActiveRing		; $4b87
	jr nz,_label_06_102	; $4b8a
	call $4c66		; $4b8c
	jp $4c3a		; $4b8f
_label_06_102:
	ld l,$04		; $4b92
	inc (hl)		; $4b94
	ld l,$00		; $4b95
	set 7,(hl)		; $4b97
	ld a,$03		; $4b99
	ld ($d604),a		; $4b9b
	ld a,$4f		; $4b9e
	jp playSound		; $4ba0
	call $4c1e		; $4ba3
	call $53e8		; $4ba6
	ret nz			; $4ba9
	ld h,d			; $4baa
	ld a,$02		; $4bab
	ld ($cc7e),a		; $4bad
	ld l,$04		; $4bb0
	ld (hl),$04		; $4bb2
	ld a,$2f		; $4bb4
	call cpActiveRing		; $4bb6
	ld a,$05		; $4bb9
	jr nz,_label_06_103	; $4bbb
	ld a,$09		; $4bbd
_label_06_103:
	ld l,$06		; $4bbf
	ld (hl),a		; $4bc1
	ld l,$3f		; $4bc2
	ld (hl),$0f		; $4bc4
	ld a,($d008)		; $4bc6
	add $28			; $4bc9
	call $4408		; $4bcb
	ld h,d			; $4bce
	ld l,$21		; $4bcf
	res 6,(hl)		; $4bd1
	ld hl,$d604		; $4bd3
	ld (hl),$04		; $4bd6
	ld l,$3a		; $4bd8
	sla (hl)		; $4bda
	call $53af		; $4bdc
	ld a,$6b		; $4bdf
	jp playSound		; $4be1
	call $4414		; $4be4
	ld h,d			; $4be7
	ld l,$21		; $4be8
	bit 7,(hl)		; $4bea
	ret z			; $4bec
	res 7,(hl)		; $4bed
	ld l,$06		; $4bef
	dec (hl)		; $4bf1
	ret nz			; $4bf2
	ld a,$05		; $4bf3
	ld ($d604),a		; $4bf5
	jp $4c17		; $4bf8
	call $4414		; $4bfb
	ld h,d			; $4bfe
	ld l,$21		; $4bff
	bit 7,(hl)		; $4c01
	ret z			; $4c03
	ld l,$02		; $4c04
	ld a,(hl)		; $4c06
	or a			; $4c07
	jr z,_label_06_104	; $4c08
	ld a,$06		; $4c0a
	ld ($d604),a		; $4c0c
	ld l,$04		; $4c0f
	inc (hl)		; $4c11
	xor a			; $4c12
	ld ($d62a),a		; $4c13
	ret			; $4c16
_label_06_104:
	xor a			; $4c17
	ld ($cc7e),a		; $4c18
	jp _clearParentItem		; $4c1b
	xor a			; $4c1e
	ld e,$02		; $4c1f
	ld (de),a		; $4c21
	ld a,($d62a)		; $4c22
	cp $04			; $4c25
	jr z,_label_06_105	; $4c27
	or a			; $4c29
	jr nz,_label_06_106	; $4c2a
	call checkLinkPushingAgainstWall		; $4c2c
	ret nc			; $4c2f
_label_06_105:
	ld e,$02		; $4c30
	ld a,$01		; $4c32
	ld (de),a		; $4c34
_label_06_106:
	pop hl			; $4c35
	xor a			; $4c36
	ld ($d624),a		; $4c37
	ld h,d			; $4c3a
	ld l,$3f		; $4c3b
	ld (hl),$08		; $4c3d
	ld l,$04		; $4c3f
	ld (hl),$05		; $4c41
	call $53af		; $4c43
	ld a,$1f		; $4c46
	jp $4408		; $4c48
	ld c,$08		; $4c4b
	ld a,$17		; $4c4d
	call cpActiveRing		; $4c4f
	jr z,_label_06_107	; $4c52
	ld c,$0c		; $4c54
	ld a,$18		; $4c56
	call cpActiveRing		; $4c58
	jr z,_label_06_107	; $4c5b
	ld c,$00		; $4c5d
_label_06_107:
	ld hl,$c6a2		; $4c5f
	ldi a,(hl)		; $4c62
	add c			; $4c63
	cp (hl)			; $4c64
	ret c			; $4c65
	ld bc,$2700		; $4c66
	ld e,$01		; $4c69
	call $5368		; $4c6b
	ret c			; $4c6e
	inc (hl)		; $4c6f
	inc l			; $4c70
	ld a,b			; $4c71
	ldi (hl),a		; $4c72
	ld a,c			; $4c73
	ldi (hl),a		; $4c74
	push de			; $4c75
	ld de,$d008		; $4c76
	ld l,$08		; $4c79
	ld b,$08		; $4c7b
	call copyMemoryReverse		; $4c7d
	pop de			; $4c80
	scf			; $4c81
	ret			; $4c82


_parentItemCode_flute:
_parentItemCode_harp:
	ld e,$04		; $4c83
	ld a,(de)		; $4c85
	rst_jumpTable			; $4c86
	adc e			; $4c87
	ld c,h			; $4c88
	call nz,$cd4c		; $4c89
	ld d,$54		; $4c8c
	jp nz,_clearParentItem		; $4c8e
	ld a,($cc85)		; $4c91
	or a			; $4c94
	jp nz,_clearParentItem		; $4c95
	call $5422		; $4c98
	jp c,_clearParentItem		; $4c9b
	call $52d0		; $4c9e
	jp nz,_clearParentItem		; $4ca1
	ld a,$80		; $4ca4
	ld ($ccaf),a		; $4ca6
	ld a,$7e		; $4ca9
	ld ($cca4),a		; $4cab
	call $52e2		; $4cae
	ld b,$00		; $4cb1
	call $4d1c		; $4cb3
	jr z,_label_06_108	; $4cb6
	ld b,$03		; $4cb8
_label_06_108:
	ld a,(hl)		; $4cba
	add b			; $4cbb
	ld hl,$4d18		; $4cbc
	rst_addAToHl			; $4cbf
	ld a,(hl)		; $4cc0
	call playSound		; $4cc1
	ld hl,$d024		; $4cc4
	res 7,(hl)		; $4cc7
	call itemDecCounter1		; $4cc9
	ld a,(hl)		; $4ccc
	and $1f			; $4ccd
	jr nz,_label_06_110	; $4ccf
	ld l,$21		; $4cd1
	bit 0,(hl)		; $4cd3
	ld bc,$fcf8		; $4cd5
	jr z,_label_06_109	; $4cd8
	ld c,$08		; $4cda
_label_06_109:
	call getRandomNumber		; $4cdc
	and $01			; $4cdf
	push de			; $4ce1
	ld d,$d0		; $4ce2
	call objectCreateFloatingMusicNote		; $4ce4
	pop de			; $4ce7
_label_06_110:
	call $4414		; $4ce8
	call $4d1c		; $4ceb
	ld a,$ff		; $4cee
	ld ($cca7),a		; $4cf0
	ld ($ccb0),a		; $4cf3
	ld c,$80		; $4cf6
	ld a,(hl)		; $4cf8
	or a			; $4cf9
	jr nz,_label_06_111	; $4cfa
	ld c,$40		; $4cfc
_label_06_111:
	ld e,$21		; $4cfe
	ld a,(de)		; $4d00
	and c			; $4d01
	ret z			; $4d02
	ld hl,$d024		; $4d03
	set 7,(hl)		; $4d06
	ld bc,$5f80		; $4d08
	call objectCreateInteraction		; $4d0b
	xor a			; $4d0e
	ld ($cca4),a		; $4d0f
	ld ($ccaf),a		; $4d12
	jp _clearParentItem		; $4d15
	adc e			; $4d18
	sbc l			; $4d19
	sbc (hl)		; $4d1a
	sbc a			; $4d1b
	ld hl,$c6af		; $4d1c
	ld e,$01		; $4d1f
	ld a,(de)		; $4d21
	cp $0e			; $4d22
	ret			; $4d24


_parentItemCode_slingshot:
	ld e,$04		; $4d25
	ld a,(de)		; $4d27
	rst_jumpTable			; $4d28
	dec l			; $4d29
	ld c,l			; $4d2a
	rst_jumpTable			; $4d2b
	ld c,l			; $4d2c
	ld a,($cc78)		; $4d2d
	ld b,a			; $4d30
	ld a,($ccf1)		; $4d31
	or b			; $4d34
	jp nz,_clearParentItem		; $4d35
	call updateLinkDirectionFromAngle		; $4d38
	ld c,$01		; $4d3b
	ld a,($c6b3)		; $4d3d
	cp $02			; $4d40
	jr nz,_label_06_112	; $4d42
	ld c,$03		; $4d44
_label_06_112:
	call $5383		; $4d46
	cp c			; $4d49
	jp c,_clearParentItem		; $4d4a
	ld a,$01		; $4d4d
	call $4db4		; $4d4f
	push bc			; $4d52
	call $52e2		; $4d53
	call $532f		; $4d56
	pop bc			; $4d59
_label_06_113:
	ld e,$19		; $4d5a
	ld a,$d0		; $4d5c
	ld (de),a		; $4d5e
	push bc			; $4d5f
	ld e,$01		; $4d60
	call $5335		; $4d62
	pop bc			; $4d65
	dec c			; $4d66
	jr nz,_label_06_113	; $4d67
	ld a,b			; $4d69
	jp decNumActiveSeeds		; $4d6a


_parentItemCode_shooter:
_parentItemCode_satchel:
	ld e,$04		; $4d6d
	ld a,(de)		; $4d6f
	rst_jumpTable			; $4d70
	ld (hl),l		; $4d71
	ld c,l			; $4d72
	rst_jumpTable			; $4d73
	ld c,l			; $4d74
	ld a,($cc78)		; $4d75
	or a			; $4d78
	jp nz,_clearParentItem		; $4d79
	call $4db4		; $4d7c
	ld a,b			; $4d7f
	cp $22			; $4d80
	jr z,_label_06_114	; $4d82
	push bc			; $4d84
	call $52e2		; $4d85
	pop bc			; $4d88
	push bc			; $4d89
	ld c,$00		; $4d8a
	ld e,$01		; $4d8c
	call $5335		; $4d8e
	pop bc			; $4d91
	jp c,_clearParentItem		; $4d92
	ld a,b			; $4d95
	jp decNumActiveSeeds		; $4d96
_label_06_114:
	ld hl,$cc86		; $4d99
	ldi a,(hl)		; $4d9c
	or (hl)			; $4d9d
	jr nz,_label_06_115	; $4d9e
	ld a,$03		; $4da0
	ldd (hl),a		; $4da2
	ld (hl),$c0		; $4da3
	ld a,b			; $4da5
	call decNumActiveSeeds		; $4da6
	ld hl,$df00		; $4da9
	ld a,$03		; $4dac
	ldi (hl),a		; $4dae
	ld (hl),$1a		; $4daf
_label_06_115:
	jp _clearParentItem		; $4db1
	ld hl,$c6be		; $4db4
	rst_addAToHl			; $4db7
	ld a,(hl)		; $4db8
	ld b,a			; $4db9
	set 5,b			; $4dba
	ld hl,$c6b5		; $4dbc
	rst_addAToHl			; $4dbf
	ld a,(hl)		; $4dc0
	or a			; $4dc1
	ret nz			; $4dc2
	pop hl			; $4dc3
	jp _clearParentItem		; $4dc4
	ld e,$21		; $4dc7
	ld a,(de)		; $4dc9
	rlca			; $4dca
	jp nc,$4414		; $4dcb
	jp _clearParentItem		; $4dce


_parentItemCode_shovel:
	ld e,$04		; $4dd1
	ld a,(de)		; $4dd3
	rst_jumpTable			; $4dd4
	reti			; $4dd5
	ld c,l			; $4dd6
	ld ($ff00+c),a		; $4dd7
	ld c,l			; $4dd8
	call $5416		; $4dd9
	jp nz,_clearParentItem		; $4ddc
	jp $52e2		; $4ddf
	call $4414		; $4de2
	ld e,$21		; $4de5
	ld a,(de)		; $4de7
	bit 7,a			; $4de8
	jp nz,_clearParentItem		; $4dea
	dec a			; $4ded
	ret nz			; $4dee
	ld (de),a		; $4def
	call $5326		; $4df0
	push hl			; $4df3
	ld l,$08		; $4df4
	ld a,(hl)		; $4df6
	ld hl,$4e07		; $4df7
	rst_addDoubleIndex			; $4dfa
	ldi a,(hl)		; $4dfb
	ld c,(hl)		; $4dfc
	pop hl			; $4dfd
	ld l,$0b		; $4dfe
	add (hl)		; $4e00
	ldi (hl),a		; $4e01
	inc l			; $4e02
	ld a,(hl)		; $4e03
	add c			; $4e04
	ldi (hl),a		; $4e05
	ret			; $4e06
	ld hl,sp+$00		; $4e07
	inc b			; $4e09
	ld b,$07		; $4e0a
	nop			; $4e0c
	inc b			; $4e0d
	ld sp,hl		; $4e0e


_parentItemCode_boomerang:
	ld e,$04		; $4e0f
	ld a,(de)		; $4e11
	rst_jumpTable			; $4e12
	add hl,de		; $4e13
	ld c,(hl)		; $4e14
	ld a,a			; $4e15
	ld c,(hl)		; $4e16
	ld d,d			; $4e17
	ld c,(hl)		; $4e18
	ld a,($cc78)		; $4e19
	or a			; $4e1c
	jp nz,_clearParentItem		; $4e1d
	call $52e2		; $4e20
	ld a,($c6b1)		; $4e23
	cp $02			; $4e26
	ld a,$01		; $4e28
	jr nz,_label_06_116	; $4e2a
	inc a			; $4e2c
_label_06_116:
	ld e,$04		; $4e2d
	ld (de),a		; $4e2f
	dec a			; $4e30
	ld c,a			; $4e31
	ld e,$01		; $4e32
	ld a,(de)		; $4e34
	ld b,a			; $4e35
	ld e,$01		; $4e36
	call $5335		; $4e38
	jp c,_clearParentItem		; $4e3b
	ld a,($cc47)		; $4e3e
	bit 7,a			; $4e41
	jr z,_label_06_117	; $4e43
	ld a,($d008)		; $4e45
	swap a			; $4e48
	rrca			; $4e4a
_label_06_117:
	ld l,$09		; $4e4b
	ld (hl),a		; $4e4d
	ld l,$34		; $4e4e
	ld (hl),a		; $4e50
	ret			; $4e51
	call $53e8		; $4e52
	jr z,_label_06_120	; $4e55
	ld a,$17		; $4e57
	call objectGetRelatedObject2Var		; $4e59
	ld a,(hl)		; $4e5c
	cp d			; $4e5d
	jr nz,_label_06_120	; $4e5e
	ld a,($cc47)		; $4e60
	ld c,a			; $4e63
	ld a,$ff		; $4e64
	ld ($cc47),a		; $4e66
	ld a,(wFrameCounter)		; $4e69
	rrca			; $4e6c
	jr c,_label_06_118	; $4e6d
	ld a,c			; $4e6f
	rlca			; $4e70
	jr nc,_label_06_119	; $4e71
_label_06_118:
	ld l,$09		; $4e73
	ld c,(hl)		; $4e75
_label_06_119:
	ld l,$34		; $4e76
	ld (hl),c		; $4e78
	ret			; $4e79
_label_06_120:
	ld e,$04		; $4e7a
	ld a,$01		; $4e7c
	ld (de),a		; $4e7e
	ld e,$21		; $4e7f
	ld a,(de)		; $4e81
	rlca			; $4e82
	jp nc,$4414		; $4e83
	jp _clearParentItem		; $4e86


_parentItemCode_bombchu:
	ld e,$04		; $4e89
	ld a,(de)		; $4e8b
	rst_jumpTable			; $4e8c
	sub c			; $4e8d
	ld c,(hl)		; $4e8e
	rst_jumpTable			; $4e8f
	ld c,l			; $4e90
	ld a,($cc78)		; $4e91
	or a			; $4e94
	jp nz,_clearParentItem		; $4e95
	ld a,($c6ad)		; $4e98
	or a			; $4e9b
	jp z,_clearParentItem		; $4e9c
	call $52e2		; $4e9f
	ld e,$01		; $4ea2
	jp $5328		; $4ea4


_parentItemCode_bomb:
	ld e,$04		; $4ea7
	ld a,(de)		; $4ea9
	rst_jumpTable			; $4eaa
	or l			; $4eab
	ld c,(hl)		; $4eac
	rst_jumpTable			; $4ead
	ld c,l			; $4eae
.DB $fc				; $4eaf
	ld c,a			; $4eb0
	ccf			; $4eb1
	ld d,b			; $4eb2
	call z,$fa50		; $4eb3
	ld c,b			; $4eb6
	call z,$da0f		; $4eb7
	rst $20			; $4eba
	ld c,c			; $4ebb
	ld a,($cc78)		; $4ebc
	ld b,a			; $4ebf
	ld a,($cc77)		; $4ec0
	or b			; $4ec3
	jp nz,_clearParentItem		; $4ec4
	call $4eed		; $4ec7
	jp nz,$4fd0		; $4eca
	ld a,($c6aa)		; $4ecd
	or a			; $4ed0
	jp z,_clearParentItem		; $4ed1
	call $52e2		; $4ed4
	ld e,$01		; $4ed7
	ld a,$19		; $4ed9
	call cpActiveRing		; $4edb
	jr nz,_label_06_121	; $4ede
	inc e			; $4ee0
_label_06_121:
	call $532f		; $4ee1
	jp c,_clearParentItem		; $4ee4
	call $4f13		; $4ee7
	jp $4fd5		; $4eea
	ld a,($cc7a)		; $4eed
	or a			; $4ef0
	jr nz,_label_06_122	; $4ef1
	ld c,$03		; $4ef3
	call findItemWithID		; $4ef5
	jr nz,_label_06_122	; $4ef8
	call $4f05		; $4efa
	ret nz			; $4efd
	ld c,$03		; $4efe
	call findItemWithID_startingAfterH		; $4f00
	jr nz,_label_06_122	; $4f03
	ld l,$2f		; $4f05
	ld a,(hl)		; $4f07
	and $b0			; $4f08
	jr nz,_label_06_122	; $4f0a
	call objectHCheckCollisionWithLink		; $4f0c
	jr c,_label_06_123	; $4f0f
_label_06_122:
	xor a			; $4f11
	ret			; $4f12
_label_06_123:
	ld l,$00		; $4f13
	set 1,(hl)		; $4f15
	ld l,$05		; $4f17
	xor a			; $4f19
	ldd (hl),a		; $4f1a
	ld (hl),$02		; $4f1b
	ld ($d018),a		; $4f1d
	ld a,h			; $4f20
	ld ($d019),a		; $4f21
	or a			; $4f24
	ret			; $4f25


_parentItemCode_bracelet:
	ld e,$04		; $4f26
	ld a,(de)		; $4f28
	rst_jumpTable			; $4f29
	ld (hl),$4f		; $4f2a
	ld (hl),a		; $4f2c
	ld c,a			; $4f2d
.DB $fc				; $4f2e
	ld c,a			; $4f2f
	ccf			; $4f30
	ld d,b			; $4f31
	call z,$1150		; $4f32
	ld d,c			; $4f35
	call $5416		; $4f36
	jp nz,_clearParentItem		; $4f39
	ld a,($ccb6)		; $4f3c
	cp $08			; $4f3f
	jp z,_clearParentItem		; $4f41
	ld a,($dc00)		; $4f44
	or a			; $4f47
	jp nz,_clearParentItem		; $4f48
	call $53e8		; $4f4b
	jp z,$50e1		; $4f4e
	ld a,($cc7a)		; $4f51
	or a			; $4f54
	jr nz,_label_06_124	; $4f55
	call checkGrabbableObjects		; $4f57
	jr c,_label_06_125	; $4f5a
	call $4eed		; $4f5c
	jr nz,_label_06_125	; $4f5f
	call $50e7		; $4f61
	jr nz,_label_06_124	; $4f64
	ld a,$41		; $4f66
	ld ($cc75),a		; $4f68
	jp $52e2		; $4f6b
_label_06_124:
	ld a,($d008)		; $4f6e
	or $80			; $4f71
	ld ($cc7f),a		; $4f73
	ret			; $4f76
	call $50d5		; $4f77
	ld a,($d02d)		; $4f7a
	or a			; $4f7d
	jp nz,$50e1		; $4f7e
	call $53e8		; $4f81
	jp z,$50e1		; $4f84
	ld a,($cc77)		; $4f87
	or a			; $4f8a
	jp nz,$50e1		; $4f8b
	call $50e7		; $4f8e
	jp nz,$50e1		; $4f91
	ld a,($d008)		; $4f94
	ld hl,$4ff8		; $4f97
	rst_addAToHl			; $4f9a
	call $53eb		; $4f9b
	ld a,$14		; $4f9e
	jp z,$4408		; $4fa0
	call $4414		; $4fa3
	ld e,$21		; $4fa6
	ld a,(de)		; $4fa8
	rlca			; $4fa9
	ret nc			; $4faa
	call $50e7		; $4fab
	jp nz,$50e1		; $4fae
	xor a			; $4fb1
	call tryToBreakTile		; $4fb2
	ret nc			; $4fb5
	ld hl,$dc00		; $4fb6
	ld a,$03		; $4fb9
	ldi (hl),a		; $4fbb
	ld (hl),$16		; $4fbc
	inc l			; $4fbe
	ldh a,(<hFF92)	; $4fbf
	ldi (hl),a		; $4fc1
	ld e,$37		; $4fc2
	ld (de),a		; $4fc4
	ldh a,(<hFF8E)	; $4fc5
	ldi (hl),a		; $4fc7
	xor a			; $4fc8
	ld ($d018),a		; $4fc9
	ld a,h			; $4fcc
	ld ($d019),a		; $4fcd
_label_06_125:
	ld a,$15		; $4fd0
	call $4408		; $4fd2
	call $53af		; $4fd5
	call $53c2		; $4fd8
	ld a,$c2		; $4fdb
	ld ($cc75),a		; $4fdd
	xor a			; $4fe0
	ld (wLinkGrabState2),a		; $4fe1
	ld hl,$d024		; $4fe4
	res 7,(hl)		; $4fe7
	ld a,$02		; $4fe9
	ld e,$04		; $4feb
	ld (de),a		; $4fed
	ld e,$3f		; $4fee
	ld a,$0f		; $4ff0
	ld (de),a		; $4ff2
	ld a,$9c		; $4ff3
	jp playSound		; $4ff5
	add b			; $4ff8
	jr nz,$40		; $4ff9
	stop			; $4ffb
	call $50d5		; $4ffc
	call $4414		; $4fff
	ld a,(wLinkGrabState2)		; $5002
	rlca			; $5005
	jr nc,_label_06_126	; $5006
	ld a,$83		; $5008
	ld ($cc75),a		; $500a
	ld e,$04		; $500d
	ld a,$05		; $500f
	ld (de),a		; $5011
	ld a,$13		; $5012
	jp $4408		; $5014
_label_06_126:
	ld h,d			; $5017
	ld l,$21		; $5018
	bit 7,(hl)		; $501a
	jr nz,_label_06_127	; $501c
	ld a,(wLinkGrabState2)		; $501e
	and $f0			; $5021
	add (hl)		; $5023
	ld (wLinkGrabState2),a		; $5024
	ret			; $5027
_label_06_127:
	ld a,$83		; $5028
	ld ($cc75),a		; $502a
	ld l,$04		; $502d
	inc (hl)		; $502f
	ld l,$3f		; $5030
	ld (hl),$00		; $5032
	ld hl,$d024		; $5034
	set 7,(hl)		; $5037
	call $53cb		; $5039
	jp $53b8		; $503c
	call $50d5		; $503f
	ld a,($cc77)		; $5042
	rlca			; $5045
	ret c			; $5046
	ld a,($cc82)		; $5047
	or a			; $504a
	ret nz			; $504b
	ld a,($d02a)		; $504c
	or a			; $504f
	jr nz,_label_06_128	; $5050
	ld a,($cc46)		; $5052
	and $03			; $5055
	ret z			; $5057
	call updateLinkDirectionFromAngle		; $5058
_label_06_128:
	ld hl,$d018		; $505b
	xor a			; $505e
	ld c,(hl)		; $505f
	ldi (hl),a		; $5060
	ld b,(hl)		; $5061
	ldi (hl),a		; $5062
	ld a,c			; $5063
	add $05			; $5064
	ld l,a			; $5066
	ld h,b			; $5067
	ld (hl),$02		; $5068
	ld e,$37		; $506a
	ld a,(de)		; $506c
	or a			; $506d
	jr nz,_label_06_130	; $506e
	ld a,c			; $5070
	or a			; $5071
	jr nz,_label_06_129	; $5072
	ld a,b			; $5074
	cp $d7			; $5075
	jr nc,_label_06_130	; $5077
_label_06_129:
	push de			; $5079
	ld hl,$dc00		; $507a
	inc (hl)		; $507d
	inc l			; $507e
	ld a,$16		; $507f
	ldi (hl),a		; $5081
	ld l,$18		; $5082
	ld a,c			; $5084
	ldi (hl),a		; $5085
	ld (hl),b		; $5086
	add $0b			; $5087
	ld e,a			; $5089
	ld d,b			; $508a
	call objectCopyPosition_rawAddress		; $508b
	pop de			; $508e
_label_06_130:
	ld a,($cc47)		; $508f
	rlca			; $5092
	jr c,_label_06_131	; $5093
	ld a,($d008)		; $5095
	swap a			; $5098
	rrca			; $509a
_label_06_131:
	ld l,$09		; $509b
	ld (hl),a		; $509d
	ld l,$38		; $509e
	ld a,(wLinkGrabState2)		; $50a0
	ld (hl),a		; $50a3
	xor a			; $50a4
	ld (wLinkGrabState2),a		; $50a5
	ld ($cc75),a		; $50a8
	ld h,d			; $50ab
	ld l,$04		; $50ac
	inc (hl)		; $50ae
	ld l,$3f		; $50af
	ld (hl),$0f		; $50b1
	ld c,$16		; $50b3
	ld a,($cc48)		; $50b5
	rrca			; $50b8
	jr nc,_label_06_132	; $50b9
	ld c,$25		; $50bb
_label_06_132:
	ld a,c			; $50bd
	call $4408		; $50be
	call $53af		; $50c1
	call $53c2		; $50c4
	ld a,$51		; $50c7
	jp playSound		; $50c9
	ld e,$21		; $50cc
	ld a,(de)		; $50ce
	rlca			; $50cf
	jp nc,$4414		; $50d0
	jr _label_06_134		; $50d3
	ld a,($cc78)		; $50d5
	or a			; $50d8
	jr nz,_label_06_133	; $50d9
	ld a,($cc75)		; $50db
	or a			; $50de
	ret nz			; $50df
_label_06_133:
	pop af			; $50e0
_label_06_134:
	call dropLinkHeldItem		; $50e1
	jp _clearParentItem		; $50e4
	ld a,($d008)		; $50e7
	ld b,a			; $50ea
	add a			; $50eb
	add b			; $50ec
	ld hl,$5105		; $50ed
	rst_addAToHl			; $50f0
	ld a,($d033)		; $50f1
	and (hl)		; $50f4
	cp (hl)			; $50f5
	ret nz			; $50f6
	inc hl			; $50f7
	ld a,($d00b)		; $50f8
	add (hl)		; $50fb
	ld b,a			; $50fc
	inc hl			; $50fd
	ld a,($d00d)		; $50fe
	add (hl)		; $5101
	ld c,a			; $5102
	xor a			; $5103
	ret			; $5104
	ret nz			; $5105
	ei			; $5106
	nop			; $5107
	inc bc			; $5108
	nop			; $5109
	rlca			; $510a
	jr nc,_label_06_135	; $510b
	nop			; $510d
	inc c			; $510e
	nop			; $510f
	ld hl,sp-$33		; $5110
	add sp,$53		; $5112
_label_06_135:
	jp z,$50e1		; $5114
	call $50d5		; $5117
	ld a,($d02d)		; $511a
	or a			; $511d
	jp nz,$50e1		; $511e
	ld a,($d008)		; $5121
	ld hl,$4ff8		; $5124
	rst_addAToHl			; $5127
	ld a,($cc45)		; $5128
	and (hl)		; $512b
	ld a,$13		; $512c
	jp z,$4408		; $512e
	jp $4414		; $5131



; ITEMID_FEATHER
parentItemCode_feather:
	ld e,Item.state		; $5134
	ld a,(de)		; $5136
	rst_jumpTable			; $5137
	.dw @state0
	.dw @state1

@state0:
	; No jumping in minecarts / on companions
	ld a,($cc48)		; $513c
	rrca			; $513f
	jr c,@deleteParent	; $5140

	; No jumping when holding something?
	ld a,($cc75)		; $5142
	or a			; $5145
	jr nz,@deleteParent	; $5146

	call $5422		; $5148
	jr c,@deleteParent	; $514b

	ld hl,$cc78		; $514d
	ldi a,(hl)		; $5150

	or (hl)			; $5151
	jr nz,@deleteParent	; $5152

	ld a,($cc77)		; $5154
	add a			; $5157
	jr c,@deleteParent	; $5158

	add a			; $515a
	jr c,@state1	; $515b
	jr nz,@deleteParent	; $515d

	ld a,($d00f)		; $515f
	or a			; $5162
	jr nz,@deleteParent	; $5163

	; Jump higher in sidescrolling rooms
	ld bc,$fe20		; $5165
	ld a,($cc49)		; $5168
	cp $06			; $516b
	jr c,+			; $516d
	ld bc,$fdd0		; $516f
+
	ld hl,$d014		; $5172
	ld (hl),c		; $5175
	inc l			; $5176
	ld (hl),b		; $5177

	ld a,$01		; $5178
	ld a,($c6b4)		; $517a
	cp $02			; $517d
	ld a,$41		; $517f
	jr z,+			; $5181
	ld a,$01		; $5183
+
	ld ($cc77),a		; $5185
	jr nz,@deleteParent	; $5188

	ld e,$04		; $518a
	ld a,$01		; $518c
	ld (de),a		; $518e
	ret			; $518f
@deleteParent
	jp _clearParentItem		; $5190

@state1:
	ld a,($cc77)		; $5193
	bit 5,a			; $5196
	jr nz,@deleteParent	; $5198

	call $53e8		; $519a
	jr z,@deleteParent	; $519d

	ld hl,$d014		; $519f
	ldi a,(hl)		; $51a2
	ld h,(hl)		; $51a3
	bit 7,h			; $51a4
	ret nz			; $51a6
	ld l,a			; $51a7
	ld bc,$0100		; $51a8
	call compareHlToBc		; $51ab
	inc a			; $51ae
	ret z			; $51af
	ld hl,$d014		; $51b0
	ld (hl),$80		; $51b3
	inc l			; $51b5
	ld (hl),$ff		; $51b6
	push de			; $51b8
	ld d,h			; $51b9
	ld a,$19		; $51ba
	call specialObjectSetAnimation		; $51bc
	pop de			; $51bf
	ld hl,$cc77		; $51c0
	set 5,(hl)		; $51c3
	ld a,$51		; $51c5
	call playSound		; $51c7
	jp _clearParentItem		; $51ca


_parentItemCode_magnetGloves:
	ld a,($cc83)		; $51cd
	inc a			; $51d0
	jr z,_label_06_142	; $51d1
	ld e,$04		; $51d3
	ld a,(de)		; $51d5
	rst_jumpTable			; $51d6
.DB $db				; $51d7
	ld d,c			; $51d8
	rst $30			; $51d9
	ld d,c			; $51da
	ld a,($cc78)		; $51db
	or a			; $51de
	jr nz,_label_06_142	; $51df
	call itemIncState		; $51e1
	ld l,$37		; $51e4
	ld (hl),$ff		; $51e6
	ld l,$18		; $51e8
	xor a			; $51ea
	ldi (hl),a		; $51eb
	ld (hl),$d6		; $51ec
	call $532f		; $51ee
	call updateLinkDirectionFromAngle		; $51f1
	call setStatusBarNeedsRefreshBit1		; $51f4
	ld a,($cc78)		; $51f7
	or a			; $51fa
	jr nz,_label_06_141	; $51fb
	ld a,($cc77)		; $51fd
	rlca			; $5200
	jr c,_label_06_141	; $5201
	call $53e8		; $5203
	jr z,_label_06_141	; $5206
	ld a,$af		; $5208
	call playSound		; $520a
	ld a,($c6b2)		; $520d
	scf			; $5210
	adc a			; $5211
	ld ($cc79),a		; $5212
	call $53c2		; $5215
	call $524b		; $5218
	ret z			; $521b
	call objectGetRelativeAngleWithTempVars		; $521c
	ld hl,$cc79		; $521f
	set 6,(hl)		; $5222
	bit 1,(hl)		; $5224
	jr nz,_label_06_140	; $5226
	xor $10			; $5228
_label_06_140:
	ld e,$09		; $522a
	ld (de),a		; $522c
	ld c,a			; $522d
	ld a,$ff		; $522e
	ld ($d009),a		; $5230
	ld b,$3c		; $5233
	jp updateLinkPositionGivenVelocity		; $5235
_label_06_141:
	ld hl,$c6b2		; $5238
	ld a,(hl)		; $523b
	xor $01			; $523c
	ld (hl),a		; $523e
	ld hl,$cbea		; $523f
	set 0,(hl)		; $5242
_label_06_142:
	xor a			; $5244
	ld ($cc79),a		; $5245
	jp _clearParentItem		; $5248
	ld a,($cc48)		; $524b
	xor $01			; $524e
	and $01			; $5250
	ret z			; $5252
	ld a,($cc49)		; $5253
	ld hl,$52ba		; $5256
	rst_addAToHl			; $5259
	ld a,(hl)		; $525a
	or a			; $525b
	ret z			; $525c
	push de			; $525d
	ld d,a			; $525e
	ld a,($d008)		; $525f
	ld e,a			; $5262
	add a			; $5263
	add a			; $5264
	add e			; $5265
	ld hl,$52a6		; $5266
	rst_addAToHl			; $5269
	ldi a,(hl)		; $526a
	ld e,a			; $526b
	call $5274		; $526c
	call z,$5274		; $526f
	pop de			; $5272
	ret			; $5273
	ld a,($d00b)		; $5274
	ldh (<hFF8F),a	; $5277
	add (hl)		; $5279
	ld b,a			; $527a
	inc hl			; $527b
	ld a,($d00d)		; $527c
	ldh (<hFF8E),a	; $527f
	add (hl)		; $5281
	ld c,a			; $5282
	inc hl			; $5283
	push hl			; $5284
	call getTileAtPosition		; $5285
	ld c,l			; $5288
	ld b,h			; $5289
	pop hl			; $528a
_label_06_143:
	or a			; $528b
	jr z,_label_06_145	; $528c
	cp d			; $528e
	jr z,_label_06_144	; $528f
	ld a,c			; $5291
	add e			; $5292
	ld c,a			; $5293
	ld a,(bc)		; $5294
	jr _label_06_143		; $5295
_label_06_144:
	ld a,c			; $5297
	and $f0			; $5298
	or $08			; $529a
	ld b,a			; $529c
	ld a,c			; $529d
	swap a			; $529e
	and $f0			; $52a0
	or $08			; $52a2
	ld c,a			; $52a4
_label_06_145:
	ret			; $52a5
	ld a,($ff00+$00)	; $52a6
.DB $fd				; $52a8
	nop			; $52a9
	ld (bc),a		; $52aa
	ld bc,$0000		; $52ab
	inc b			; $52ae
	nop			; $52af
	stop			; $52b0
	nop			; $52b1
.DB $fd				; $52b2
	nop			; $52b3
	ld (bc),a		; $52b4
	rst $38			; $52b5
	nop			; $52b6
	nop			; $52b7
	inc b			; $52b8
	nop			; $52b9
	nop			; $52ba
.DB $e3				; $52bb
	nop			; $52bc
	ccf			; $52bd
	ccf			; $52be
	ccf			; $52bf
	ccf			; $52c0
	ccf			; $52c1
	call $52d0		; $52c2
_label_06_146:
	push hl			; $52c5
	call nz,$49f5		; $52c6
	pop hl			; $52c9
	call $52da		; $52ca
	jr nz,_label_06_146	; $52cd
	ret			; $52cf
	ld hl,$d200		; $52d0
_label_06_147:
	ld a,d			; $52d3
	cp h			; $52d4
	jr z,_label_06_148	; $52d5
	ld a,(hl)		; $52d7
	or a			; $52d8
	ret nz			; $52d9
_label_06_148:
	inc h			; $52da
	ld a,h			; $52db
	cp $d6			; $52dc
	jr c,_label_06_147	; $52de
	xor a			; $52e0
	ret			; $52e1
	call $53af		; $52e2
	call $53c2		; $52e5
	ld e,$04		; $52e8
	ld a,$01		; $52ea
	ld (de),a		; $52ec
	ld e,$01		; $52ed
	ld a,(de)		; $52ef
	ld hl,$5548		; $52f0
	rst_addDoubleIndex			; $52f3
	ld e,$18		; $52f4
	xor a			; $52f6
	ld (de),a		; $52f7
	inc e			; $52f8
	ld a,(hl)		; $52f9
	and $0f			; $52fa
	cp $01			; $52fc
	jr z,_label_06_149	; $52fe
	or $d0			; $5300
_label_06_149:
	ld (de),a		; $5302
	ldi a,(hl)		; $5303
	ld b,a			; $5304
	swap a			; $5305
	and $07			; $5307
	ld e,$3f		; $5309
	ld (de),a		; $530b
	ld c,(hl)		; $530c
	bit 7,b			; $530d
	call nz,$5396		; $530f
	ld a,($cc48)		; $5312
	rrca			; $5315
	ld a,c			; $5316
	jr nc,_label_06_150	; $5317
	cp $20			; $5319
	jr c,_label_06_150	; $531b
	cp $24			; $531d
	jr nc,_label_06_150	; $531f
	add $04			; $5321
_label_06_150:
	jp $4408		; $5323
	ld e,$01		; $5326
	call $532f		; $5328
	ret nc			; $532b
	jp _clearParentItem		; $532c
	ld c,$00		; $532f
	ld h,d			; $5331
	ld l,$01		; $5332
	ld b,(hl)		; $5334
	ld h,d			; $5335
	ld l,$19		; $5336
	ldd a,(hl)		; $5338
	ld l,(hl)		; $5339
	ld h,a			; $533a
	cp $01			; $533b
	scf			; $533d
	ret z			; $533e
	cp $d0			; $533f
	call z,$5368		; $5341
	ret c			; $5344
	inc (hl)		; $5345
	inc l			; $5346
	ld a,b			; $5347
	ldi (hl),a		; $5348
	ld a,c			; $5349
	ldi (hl),a		; $534a
	xor a			; $534b
	ldi (hl),a		; $534c
	ldi (hl),a		; $534d
	ldi (hl),a		; $534e
	push de			; $534f
	ld de,$d008		; $5350
	ld l,$08		; $5353
	ld b,$08		; $5355
	call copyMemoryReverse		; $5357
	pop de			; $535a
	ld l,$16		; $535b
	xor a			; $535d
	ldi (hl),a		; $535e
	ld (hl),d		; $535f
	ld e,$18		; $5360
	ld (de),a		; $5362
	inc e			; $5363
	ld a,h			; $5364
	ld (de),a		; $5365
	xor a			; $5366
	ret			; $5367
	ld hl,$d701		; $5368
_label_06_151:
	ld a,(hl)		; $536b
	cp b			; $536c
	jr nz,_label_06_152	; $536d
	inc l			; $536f
	ldd a,(hl)		; $5370
	cp c			; $5371
	jr nz,_label_06_152	; $5372
	dec e			; $5374
	jr z,_label_06_153	; $5375
_label_06_152:
	inc h			; $5377
	ld a,h			; $5378
	cp $dc			; $5379
	jr c,_label_06_151	; $537b
	call getFreeItemSlot		; $537d
	ret z			; $5380
_label_06_153:
	scf			; $5381
	ret			; $5382


_func_5431:
	ld hl,$d700		; $5383
	ld b,$00		; $5386
_label_06_154:
	ld a,(hl)		; $5388
	or a			; $5389
	jr nz,_label_06_155	; $538a
	inc b			; $538c
_label_06_155:
	inc h			; $538d
	ld a,h			; $538e
	cp $dc			; $538f
	jr c,_label_06_154	; $5391
	ld a,b			; $5393
	or a			; $5394
	ret			; $5395


_setLinkUsingItem1:
	call $53de		; $5396
	swap a			; $5399
	or (hl)			; $539b
	ld hl,$cc7a		; $539c
	or (hl)			; $539f
	ld (hl),a		; $53a0
	ret			; $53a1


_clearLinkUsingItem1:
	call $53de		; $53a2
	swap a			; $53a5
	or (hl)			; $53a7
	cpl			; $53a8
	ld hl,$cc7a		; $53a9
	and (hl)		; $53ac
	ld (hl),a		; $53ad
	ret			; $53ae


_itemDisableLinkMovement:
	call $53de		; $53af
	ld hl,wLinkImmobilized		; $53b2
	or (hl)			; $53b5
	ld (hl),a		; $53b6
	ret			; $53b7


_itemEnableLinkMovement:
	call $53de		; $53b8
	ld hl,wLinkImmobilized		; $53bb
	cpl			; $53be
	and (hl)		; $53bf
	ld (hl),a		; $53c0
	ret			; $53c1


_itemDisableLinkTurning:
	call $53de		; $53c2
	ld hl,$cc7b		; $53c5
	or (hl)			; $53c8
	ld (hl),a		; $53c9
	ret			; $53ca


_itemEnableLinkTurning:
	call $53de		; $53cb
	ld hl,$cc7b		; $53ce
	cpl			; $53d1
	and (hl)		; $53d2
	ld (hl),a		; $53d3
	ret			; $53d4


_setCc95Bit:
	call $53de		; $53d5
	ld hl,$ccaf		; $53d8
	or (hl)			; $53db
	ld (hl),a		; $53dc
	ret			; $53dd


_itemIndexToBit:
	ld a,d			; $53de
	sub $d2			; $53df
	ld hl,bitTable		; $53e1
	add l			; $53e4
	ld l,a			; $53e5
	ld a,(hl)		; $53e6
	ret			; $53e7


_parentItemCheckButtonPressed:
	ld h,d			; $53e8
	ld l,$03		; $53e9

_andHlWithGameKeysPressed:
	ld a,($cc45)		; $53eb
	and (hl)		; $53ee
	ret			; $53ef
	ld a,($ccaf)		; $53f0
	rlca			; $53f3
	jr c,_label_06_156	; $53f4
	ld a,($cc83)		; $53f6
	inc a			; $53f9
	jr z,_label_06_156	; $53fa
	ld a,($ccef)		; $53fc
	ld b,a			; $53ff
	ld a,($cc74)		; $5400
	or b			; $5403
	ret z			; $5404
	ld e,$04		; $5405
	ld a,(de)		; $5407
	or a			; $5408
	ld a,$5a		; $5409
	call z,playSound		; $540b
_label_06_156:
	pop af			; $540e
	xor a			; $540f
	ld ($cc7e),a		; $5410
	jp _clearParentItem		; $5413
	ld a,($cc48)		; $5416
	and $01			; $5419
	ret nz			; $541b
	ld hl,$cc77		; $541c
	ldi a,(hl)		; $541f
	or (hl)			; $5420
	ret			; $5421
	ld a,($ccb6)		; $5422
	dec a			; $5425
	cp $02			; $5426
	ret			; $5428
	ld a,(wLinkGrabState2)		; $5429
	ld b,a			; $542c
	rlca			; $542d
	ret c			; $542e
	ld de,$d000		; $542f
	ld a,e			; $5432
	ldh (<hActiveObjectType),a	; $5433
	ld a,d			; $5435
	ldh (<hActiveObject),a	; $5436
	ld a,($cc75)		; $5438
	cp $83			; $543b
	jr nz,_label_06_157	; $543d
	ld e,$21		; $543f
	ld a,(de)		; $5441
	and $0f			; $5442
	add b			; $5444
	ld b,a			; $5445
_label_06_157:
	ld e,$08		; $5446
	ld a,(de)		; $5448
	add b			; $5449
	ld hl,$5468		; $544a
	rst_addDoubleIndex			; $544d
	ldi a,(hl)		; $544e
	ld b,a			; $544f
	ldi a,(hl)		; $5450
	ld c,a			; $5451
	ld a,$0b		; $5452
	call objectGetRelatedObject2Var		; $5454
	ld e,$0b		; $5457
	ld a,(de)		; $5459
	ldi (hl),a		; $545a
	inc l			; $545b
	ld e,$0d		; $545c
	ld a,(de)		; $545e
	add c			; $545f
	ldi (hl),a		; $5460
	inc l			; $5461
	ld e,$0f		; $5462
	ld a,(de)		; $5464
	add b			; $5465
	ldi (hl),a		; $5466
	ret			; $5467
	ld hl,sp+$00		; $5468
	nop			; $546a
	rlca			; $546b
	ld b,$00		; $546c
	nop			; $546e
	ld hl,sp-$06		; $546f
	nop			; $5471
	ld hl,sp+$03		; $5472
	inc b			; $5474
	nop			; $5475
	ld hl,sp-$04		; $5476
	di			; $5478
	nop			; $5479
	ld a,($ff00+c)		; $547a
	nop			; $547b
	di			; $547c
	nop			; $547d
	ld a,($ff00+c)		; $547e
	nop			; $547f
	di			; $5480
	nop			; $5481
	di			; $5482
	nop			; $5483
	di			; $5484
	nop			; $5485
	di			; $5486
	nop			; $5487
.DB $f4				; $5488
	nop			; $5489
	nop			; $548a
	inc d			; $548b
	inc c			; $548c
	nop			; $548d
	nop			; $548e
.DB $ec				; $548f
	ld a,($ff00+c)		; $5490
	nop			; $5491
	ld a,($ff00+c)		; $5492
	stop			; $5493
	ld a,($ff00+c)		; $5494
	nop			; $5495
	ld a,($ff00+c)		; $5496
	ld a,($ff00+$ef)	; $5497
	nop			; $5499
	rst $28			; $549a
	nop			; $549b
	rst $28			; $549c
	nop			; $549d
	rst $28			; $549e
	nop			; $549f
	ld a,($ff00+$00)	; $54a0
	ld a,($ff00+$00)	; $54a2
	ld a,($ff00+$00)	; $54a4
	ld a,($ff00+$00)	; $54a6
.DB $f4				; $54a8
	nop			; $54a9
	nop			; $54aa
	inc d			; $54ab
	inc c			; $54ac
	nop			; $54ad
	nop			; $54ae
.DB $ec				; $54af
	ld a,($ff00+c)		; $54b0
	nop			; $54b1
	ld a,($ff00+c)		; $54b2
	stop			; $54b3
	ld a,($ff00+c)		; $54b4
	nop			; $54b5
	ld a,($ff00+c)		; $54b6
	ld a,($ff00+$ef)	; $54b7
	nop			; $54b9
	rst $28			; $54ba
	nop			; $54bb
	rst $28			; $54bc
	nop			; $54bd
	rst $28			; $54be
	nop			; $54bf
	ld a,($ff00+$00)	; $54c0
	ld a,($ff00+$00)	; $54c2
	ld a,($ff00+$00)	; $54c4
	ld a,($ff00+$00)	; $54c6
.DB $f4				; $54c8
	nop			; $54c9
	nop			; $54ca
	inc d			; $54cb
	inc c			; $54cc
	nop			; $54cd
	nop			; $54ce
.DB $ec				; $54cf
	ld a,($ff00+c)		; $54d0
	nop			; $54d1
	ld a,($ff00+c)		; $54d2
	stop			; $54d3
	ld a,($ff00+c)		; $54d4
	nop			; $54d5
	ld a,($ff00+c)		; $54d6
	ld a,($ff00+$ef)	; $54d7
	nop			; $54d9
	rst $28			; $54da
	nop			; $54db
	rst $28			; $54dc
	nop			; $54dd
	rst $28			; $54de
	nop			; $54df
	ld a,($ff00+$00)	; $54e0
	ld a,($ff00+$00)	; $54e2
	ld a,($ff00+$00)	; $54e4
	ld a,($ff00+$00)	; $54e6
	or $00			; $54e8
	nop			; $54ea
	ld a,(bc)		; $54eb
	ld a,(bc)		; $54ec
	nop			; $54ed
	nop			; $54ee
	or $f4			; $54ef
	nop			; $54f1
.DB $f4				; $54f2
	ld c,$f4		; $54f3
	nop			; $54f5
.DB $f4				; $54f6
	ld a,($ff00+c)		; $54f7
	ld a,($ff00+c)		; $54f8
	nop			; $54f9
	pop af			; $54fa
	nop			; $54fb
	ld a,($ff00+c)		; $54fc
	nop			; $54fd
	pop af			; $54fe
	nop			; $54ff
	ld a,($ff00+c)		; $5500
	nop			; $5501
	ld a,($ff00+c)		; $5502
	nop			; $5503
	ld a,($ff00+c)		; $5504
	nop			; $5505
	ld a,($ff00+c)		; $5506
	nop			; $5507

_itemUsageParameterTable:
	.db $00 <wGameKeysPressed       ; ITEMID_NONE
	.db $05 <wGameKeysPressed       ; ITEMID_SHIELD
	.db $03 <wGameKeysJustPressed   ; ITEMID_PUNCH
	.db $23 <wGameKeysJustPressed   ; ITEMID_BOMB
	.db $00 <wGameKeysJustPressed   ; ITEMID_CANE_OF_SOMARIA
	.db $63 <wGameKeysJustPressed   ; ITEMID_SWORD
	.db $02 <wGameKeysJustPressed   ; ITEMID_BOOMERANG
	.db $33 <wGameKeysJustPressed   ; ITEMID_ROD_OF_SEASONS
	.db $53 <wGameKeysJustPressed   ; ITEMID_MAGNET_GLOVES
	.db $00 <wGameKeysJustPressed   ; ITEMID_SWITCH_HOOK_HELPER
	.db $00 <wGameKeysJustPressed   ; ITEMID_SWITCH_HOOK
	.db $00 <wGameKeysJustPressed   ; ITEMID_SWITCH_HOOK_CHAIN
	.db $73 <wGameKeysJustPressed   ; ITEMID_BIGGORON_SWORD
	.db $02 <wGameKeysJustPressed   ; ITEMID_BOMBCHUS
	.db $05 <wGameKeysJustPressed   ; ITEMID_FLUTE
	.db $00 <wGameKeysJustPressed   ; ITEMID_SHOOTER
	.db $00 <wGameKeysJustPressed   ; ITEMID_10
	.db $00 <wGameKeysJustPressed   ; ITEMID_HARP
	.db $00 <wGameKeysJustPressed   ; ITEMID_12
	.db $43 <wGameKeysJustPressed   ; ITEMID_SLINGSHOT
	.db $00 <wGameKeysJustPressed   ; ITEMID_14
	.db $13 <wGameKeysJustPressed   ; ITEMID_SHOVEL
	.db $13 <wGameKeysPressed       ; ITEMID_BRACELET
	.db $01 <wGameKeysJustPressed   ; ITEMID_FEATHER
	.db $00 <wGameKeysJustPressed   ; ITEMID_18
	.db $02 <wGameKeysJustPressed   ; ITEMID_SEED_SATCHEL
	.db $00 <wGameKeysJustPressed   ; ITEMID_DUST
	.db $00 <wGameKeysJustPressed   ; ITEMID_1b
	.db $00 <wGameKeysJustPressed   ; ITEMID_1c
	.db $00 <wGameKeysJustPressed   ; ITEMID_MINECART_COLLISION
	.db $03 <wGameKeysJustPressed   ; ITEMID_FOOLS_ORE
	.db $00 <wGameKeysJustPressed   ; ITEMID_1f


_linkItemAnimationTable:
	.db $00  LINK_ANIM_MODE_NONE	; ITEMID_NONE
	.db $00  LINK_ANIM_MODE_NONE	; ITEMID_SHIELD
	.db $d6  LINK_ANIM_MODE_21	; ITEMID_PUNCH
	.db $30  LINK_ANIM_MODE_LIFT	; ITEMID_BOMB
	.db $d6  LINK_ANIM_MODE_22	; ITEMID_CANE_OF_SOMARIA
	.db $e6  LINK_ANIM_MODE_22	; ITEMID_SWORD
	.db $b0  LINK_ANIM_MODE_21	; ITEMID_BOOMERANG
	.db $d6  LINK_ANIM_MODE_22	; ITEMID_ROD_OF_SEASONS
	.db $60  LINK_ANIM_MODE_NONE	; ITEMID_MAGNET_GLOVES
	.db $80  LINK_ANIM_MODE_NONE	; ITEMID_SWITCH_HOOK_HELPER
	.db $f6  LINK_ANIM_MODE_21	; ITEMID_SWITCH_HOOK
	.db $80  LINK_ANIM_MODE_NONE	; ITEMID_SWITCH_HOOK_CHAIN
	.db $f6  LINK_ANIM_MODE_23	; ITEMID_BIGGORON_SWORD
	.db $30  LINK_ANIM_MODE_21	; ITEMID_BOMBCHUS
	.db $70  LINK_ANIM_MODE_FLUTE	; ITEMID_FLUTE
	.db $c6  LINK_ANIM_MODE_21	; ITEMID_SHOOTER
	.db $80  LINK_ANIM_MODE_NONE	; ITEMID_10
	.db $70  LINK_ANIM_MODE_HARP_2	; ITEMID_HARP
	.db $80  LINK_ANIM_MODE_NONE	; ITEMID_12
	.db $c6  LINK_ANIM_MODE_21	; ITEMID_SLINGSHOT
	.db $80  LINK_ANIM_MODE_NONE	; ITEMID_14
	.db $b0  LINK_ANIM_MODE_DIG_2	; ITEMID_SHOVEL
	.db $40  LINK_ANIM_MODE_LIFT_3	; ITEMID_BRACELET
	.db $80  LINK_ANIM_MODE_NONE	; ITEMID_FEATHER
	.db $80  LINK_ANIM_MODE_NONE	; ITEMID_18
	.db $a0  LINK_ANIM_MODE_21	; ITEMID_SEED_SATCHEL
	.db $80  LINK_ANIM_MODE_NONE	; ITEMID_DUST
	.db $80  LINK_ANIM_MODE_NONE	; ITEMID_1b
	.db $80  LINK_ANIM_MODE_NONE	; ITEMID_1c
	.db $80  LINK_ANIM_MODE_NONE	; ITEMID_MINECART_COLLISION
	.db $e6  LINK_ANIM_MODE_22	; ITEMID_FOOLS_ORE
	.db $80  LINK_ANIM_MODE_NONE	; ITEMID_1f

	call $5727		; $5588
	ld e,$04		; $558b
	ld a,(de)		; $558d
	rst_jumpTable			; $558e
	sub e			; $558f
	ld d,l			; $5590
	cp a			; $5591
	ld d,l			; $5592
	ld a,$01		; $5593
	ld (de),a		; $5595
	ld hl,$41b5		; $5596
	ld e,$05		; $5599
	call interBankCall		; $559b
	ld h,d			; $559e
	ld l,$10		; $559f
	ld (hl),$28		; $55a1
	ld l,$08		; $55a3
	ld a,(hl)		; $55a5
	call specialObjectSetAnimation		; $55a6
	ld a,d			; $55a9
	ld ($cc48),a		; $55aa
	call setCameraFocusedObjectToLink		; $55ad
	call clearVar3fForParentItems		; $55b0
	call clearPegasusSeedCounter		; $55b3
	ld hl,$d00e		; $55b6
	xor a			; $55b9
	ldi (hl),a		; $55ba
	ldi (hl),a		; $55bb
	jp objectSetVisiblec2		; $55bc
	ld a,($c4ab)		; $55bf
	or a			; $55c2
	ret nz			; $55c3
	call retIfTextIsActive		; $55c4
	ld a,($cd00)		; $55c7
	and $0e			; $55ca
	ret nz			; $55cc
	ld a,($cca4)		; $55cd
	and $81			; $55d0
	ret nz			; $55d2
	ld hl,$d024		; $55d3
	res 7,(hl)		; $55d6
	xor a			; $55d8
	ld l,$2d		; $55d9
	ldi (hl),a		; $55db
	ld h,d			; $55dc
	ld l,$0b		; $55dd
	ldi a,(hl)		; $55df
	ld b,a			; $55e0
	and $0f			; $55e1
	cp $08			; $55e3
	jr nz,_label_06_159	; $55e5
	inc l			; $55e7
	ldi a,(hl)		; $55e8
	ld c,a			; $55e9
	and $0f			; $55ea
	cp $08			; $55ec
	jr nz,_label_06_159	; $55ee
	call $5656		; $55f0
	jr c,_label_06_161	; $55f3
	ld h,d			; $55f5
	ld l,$08		; $55f6
	ldi a,(hl)		; $55f8
	swap a			; $55f9
	rrca			; $55fb
	cp (hl)			; $55fc
	jr z,_label_06_159	; $55fd
	ldd (hl),a		; $55ff
	ld a,(hl)		; $5600
	call specialObjectSetAnimation		; $5601
_label_06_159:
	ld h,d			; $5604
	ld l,$35		; $5605
	dec (hl)		; $5607
	bit 7,(hl)		; $5608
	jr z,_label_06_160	; $560a
	ld (hl),$1a		; $560c
	ld a,$80		; $560e
	call playSound		; $5610
_label_06_160:
	call objectApplySpeed		; $5613
	jp specialObjectAnimate		; $5616
_label_06_161:
	ld e,$04		; $5619
	ld a,$02		; $561b
	ld (de),a		; $561d
	call clearVar3fForParentItems		; $561e
	ld a,$81		; $5621
	ld ($cc77),a		; $5623
	ld hl,$d009		; $5626
	ld e,$09		; $5629
	ld a,(de)		; $562b
	ld (hl),a		; $562c
	ld l,$0b		; $562d
	ld a,(hl)		; $562f
	add $06			; $5630
	ld (hl),a		; $5632
	ld l,$0f		; $5633
	ld (hl),$fa		; $5635
	ld l,$10		; $5637
	ld (hl),$14		; $5639
	ld l,$14		; $563b
	ld (hl),$40		; $563d
	inc l			; $563f
	ld (hl),$fe		; $5640
	ld l,$1a		; $5642
	set 6,(hl)		; $5644
	ld a,$d0		; $5646
	ld ($cc48),a		; $5648
	call setCameraFocusedObjectToLink		; $564b
	ld b,$16		; $564e
	call objectCreateInteractionWithSubid00		; $5650
	jp objectDelete_useActiveObjectType		; $5653
	call getTileAtPosition		; $5656
	ld e,a			; $5659
	ld c,l			; $565a
	ld h,d			; $565b
	ld l,$08		; $565c
	ld a,(hl)		; $565e
	swap a			; $565f
	ld hl,$56cd		; $5661
	rst_addAToHl			; $5664
_label_06_162:
	ldi a,(hl)		; $5665
	or a			; $5666
	jr z,_label_06_167	; $5667
	cp e			; $5669
	jr z,_label_06_163	; $566a
	ld a,$04		; $566c
	rst_addAToHl			; $566e
	jr _label_06_162		; $566f
_label_06_163:
	ldi a,(hl)		; $5671
	add c			; $5672
	ld c,a			; $5673
	ldh (<hFF8B),a	; $5674
	ld b,$ce		; $5676
	ld a,(bc)		; $5678
	cp $ff			; $5679
	ret z			; $567b
	ld b,$cf		; $567c
	ld a,(bc)		; $567e
	cp $5f			; $567f
	jr z,_label_06_165	; $5681
	ld c,a			; $5683
	ld b,$03		; $5684
_label_06_164:
	ldi a,(hl)		; $5686
	cp c			; $5687
	jr z,_label_06_166	; $5688
	dec b			; $568a
	jr nz,_label_06_164	; $568b
	jr _label_06_167		; $568d
_label_06_165:
	scf			; $568f
	ret			; $5690
_label_06_166:
	ld a,e			; $5691
	sub $59			; $5692
	cp $06			; $5694
	jr c,_label_06_168	; $5696
_label_06_167:
	ld a,$06		; $5698
_label_06_168:
	ld e,$08		; $569a
	rst_jumpTable			; $569c
	xor e			; $569d
	ld d,(hl)		; $569e
	xor e			; $569f
	ld d,(hl)		; $56a0
	or b			; $56a1
	ld d,(hl)		; $56a2
	or b			; $56a3
	ld d,(hl)		; $56a4
	or l			; $56a5
	ld d,(hl)		; $56a6
	cp h			; $56a7
	ld d,(hl)		; $56a8
	pop bc			; $56a9
	ld d,(hl)		; $56aa
	ld a,(de)		; $56ab
	xor $01			; $56ac
	ld (de),a		; $56ae
	ret			; $56af
	ld a,(de)		; $56b0
	xor $03			; $56b1
	ld (de),a		; $56b3
	ret			; $56b4
	ld a,(de)		; $56b5
	and $02			; $56b6
	or $01			; $56b8
	ld (de),a		; $56ba
	ret			; $56bb
	ld a,(de)		; $56bc
	and $02			; $56bd
	ld (de),a		; $56bf
	ret			; $56c0
	call $570d		; $56c1
	jr nc,_label_06_169	; $56c4
	xor a			; $56c6
	ret			; $56c7
_label_06_169:
	ld a,(de)		; $56c8
	xor $02			; $56c9
	ld (de),a		; $56cb
	ret			; $56cc
	ld e,(hl)		; $56cd
	ld a,($ff00+$5e)	; $56ce
	ld e,c			; $56d0
	ld e,h			; $56d1
	ld e,c			; $56d2
	ld bc,$5a5d		; $56d3
	ld e,h			; $56d6
	ld e,h			; $56d7
	rst $38			; $56d8
	ld e,l			; $56d9
	ld e,e			; $56da
	ld e,c			; $56db
	nop			; $56dc
	ld e,l			; $56dd
	ld bc,$5a5d		; $56de
	ld e,h			; $56e1
	ld e,d			; $56e2
	ld a,($ff00+$5e)	; $56e3
	ld e,c			; $56e5
	ld e,h			; $56e6
	ld e,h			; $56e7
	stop			; $56e8
	ld e,(hl)		; $56e9
	ld e,e			; $56ea
	ld e,d			; $56eb
	nop			; $56ec
	ld e,(hl)		; $56ed
	stop			; $56ee
	ld e,(hl)		; $56ef
	ld e,d			; $56f0
	ld e,e			; $56f1
	ld e,d			; $56f2
	rst $38			; $56f3
	ld e,l			; $56f4
	ld e,e			; $56f5
	ld e,c			; $56f6
	ld e,e			; $56f7
	ld bc,$5a5d		; $56f8
	ld e,h			; $56fb
	nop			; $56fc
	ld e,l			; $56fd
	rst $38			; $56fe
	ld e,l			; $56ff
	ld e,e			; $5700
	ld e,c			; $5701
	ld e,e			; $5702
	ld a,($ff00+$5e)	; $5703
	ld e,h			; $5705
	ld e,c			; $5706
	ld e,c			; $5707
	stop			; $5708
	ld e,(hl)		; $5709
	ld e,d			; $570a
	ld e,e			; $570b
	nop			; $570c
	ld a,c			; $570d
	sub $7c			; $570e
	cp $04			; $5710
	ret nc			; $5712
	add $0c			; $5713
	add a			; $5715
	ld b,a			; $5716
	call getFreeInteractionSlot		; $5717
	ret nz			; $571a
	ld (hl),$1e		; $571b
	ld l,$49		; $571d
	ld (hl),b		; $571f
	ld l,$4b		; $5720
	ldh a,(<hFF8B)	; $5722
	ld (hl),a		; $5724
	scf			; $5725
	ret			; $5726
	ld e,$36		; $5727
	ld a,(de)		; $5729
	or a			; $572a
	ret nz			; $572b
	call getFreeItemSlot		; $572c
	ret nz			; $572f
	ld e,$36		; $5730
	ld a,$01		; $5732
	ld (de),a		; $5734
	ldi (hl),a		; $5735
	ld (hl),$1d		; $5736
	ret			; $5738


	.include "data/seasons/specialObjectAnimationData.s"


	ld hl,$d101		; $69c9
	ld a,(hl)		; $69cc
	sub $0f			; $69cd
	rst_jumpTable			; $69cf
	ret c			; $69d0
	ld l,c			; $69d1
	ld a,(bc)		; $69d2
	ld l,h			; $69d3
	ld h,h			; $69d4
	ld l,e			; $69d5
.DB $f4				; $69d6
	ld l,h			; $69d7
	ld e,$04		; $69d8
	ld a,(de)		; $69da
	ld a,(de)		; $69db
	rst_jumpTable			; $69dc
	pop hl			; $69dd
	ld l,c			; $69de
	dec d			; $69df
	ld l,d			; $69e0
	call $6a07		; $69e1
	ld h,d			; $69e4
	ld l,$02		; $69e5
	ld a,(hl)		; $69e7
	or a			; $69e8
	jr z,_label_06_220	; $69e9
	ld l,$10		; $69eb
	ld (hl),$50		; $69ed
	ld l,$09		; $69ef
	ld (hl),$08		; $69f1
	ld bc,$fe00		; $69f3
	call objectSetSpeedZ		; $69f6
	ld a,$02		; $69f9
	jp specialObjectSetAnimation		; $69fb
_label_06_220:
	xor a			; $69fe
	ld ($cbb5),a		; $69ff
	ld a,$1e		; $6a02
	jp specialObjectSetAnimation		; $6a04
	ld a,$01		; $6a07
_label_06_221:
	ld (de),a		; $6a09
	ld hl,$41b5		; $6a0a
	ld e,$05		; $6a0d
	call interBankCall		; $6a0f
	jp objectSetVisiblec0		; $6a12
	ld e,$02		; $6a15
	ld a,(de)		; $6a17
	rst_jumpTable			; $6a18
	dec e			; $6a19
	ld l,d			; $6a1a
	ld h,l			; $6a1b
	ld l,d			; $6a1c
	ld e,$05		; $6a1d
	ld a,(de)		; $6a1f
	rst_jumpTable			; $6a20
	dec h			; $6a21
	ld l,d			; $6a22
	ld b,h			; $6a23
	ld l,d			; $6a24
	call specialObjectAnimate		; $6a25
	ld h,d			; $6a28
	ld l,$21		; $6a29
	ld a,(hl)		; $6a2b
	or a			; $6a2c
	jr z,_label_06_222	; $6a2d
	ld a,$01		; $6a2f
	ld ($cbb5),a		; $6a31
	ld l,$05		; $6a34
	inc (hl)		; $6a36
_label_06_222:
	ld c,$20		; $6a37
	call objectUpdateSpeedZ_paramC		; $6a39
	ret nz			; $6a3c
	ld h,d			; $6a3d
	ld bc,$ff20		; $6a3e
	jp objectSetSpeedZ		; $6a41
	call specialObjectAnimate		; $6a44
	ld h,d			; $6a47
	ld l,$21		; $6a48
	ld a,(hl)		; $6a4a
	or a			; $6a4b
	ret z			; $6a4c
	ld (hl),$00		; $6a4d
	inc a			; $6a4f
	jr z,_label_06_223	; $6a50
	call getFreeInteractionSlot		; $6a52
	ret nz			; $6a55
	ld (hl),$07		; $6a56
	ld bc,$f812		; $6a58
	jp objectCopyPositionWithOffset		; $6a5b
_label_06_223:
	ld l,$05		; $6a5e
	ld (hl),$00		; $6a60
	jp $69fe		; $6a62
	ld e,$05		; $6a65
	ld a,(de)		; $6a67
	rst_jumpTable			; $6a68
	ld a,a			; $6a69
	ld l,d			; $6a6a
	add d			; $6a6b
	ld l,d			; $6a6c
	or h			; $6a6d
	ld l,d			; $6a6e
	cp l			; $6a6f
	ld l,d			; $6a70
	jp z,$dd6a		; $6a71
	ld l,d			; $6a74
	ld ($126a),a		; $6a75
	ld l,e			; $6a78
	inc h			; $6a79
	ld l,e			; $6a7a
	add hl,sp		; $6a7b
	ld l,e			; $6a7c
	ld e,d			; $6a7d
	ld l,e			; $6a7e
	ld l,$05		; $6a7f
	inc (hl)		; $6a81
	call objectApplySpeed		; $6a82
	ld e,$0d		; $6a85
	ld a,(de)		; $6a87
	bit 7,a			; $6a88
	jr nz,_label_06_224	; $6a8a
	ld hl,$d00d		; $6a8c
	ld b,(hl)		; $6a8f
	add $18			; $6a90
	cp b			; $6a92
	jr c,_label_06_224	; $6a93
	call itemIncState2		; $6a95
	inc (hl)		; $6a98
	inc l			; $6a99
	ld (hl),$3c		; $6a9a
	ld l,$0e		; $6a9c
	xor a			; $6a9e
	ldi (hl),a		; $6a9f
	ld (hl),a		; $6aa0
	jp specialObjectAnimate		; $6aa1
_label_06_224:
	ld c,$40		; $6aa4
	call objectUpdateSpeedZ_paramC		; $6aa6
	ret nz			; $6aa9
	call itemIncState2		; $6aaa
	ld l,$06		; $6aad
	ld (hl),$08		; $6aaf
	jp specialObjectAnimate		; $6ab1
	call itemDecCounter1		; $6ab4
	ret nz			; $6ab7
	dec l			; $6ab8
	dec (hl)		; $6ab9
	jp $69f3		; $6aba
	call itemDecCounter1		; $6abd
	ret nz			; $6ac0
	ld (hl),$5a		; $6ac1
	dec l			; $6ac3
	inc (hl)		; $6ac4
	ld a,$14		; $6ac5
	jp specialObjectSetAnimation		; $6ac7
	call specialObjectAnimate		; $6aca
	call itemDecCounter1		; $6acd
	ret nz			; $6ad0
	ld (hl),$0c		; $6ad1
	dec l			; $6ad3
	inc (hl)		; $6ad4
	ld a,$1f		; $6ad5
	call specialObjectSetAnimation		; $6ad7
	jp $6a52		; $6ada
	call itemDecCounter1		; $6add
	ret nz			; $6ae0
	ld (hl),$3c		; $6ae1
	dec l			; $6ae3
	inc (hl)		; $6ae4
	ld a,$1e		; $6ae5
	jp specialObjectSetAnimation		; $6ae7
	call itemDecCounter1		; $6aea
	ret nz			; $6aed
	ld (hl),$1e		; $6aee
	dec l			; $6af0
	inc (hl)		; $6af1
	ld hl,$c6c5		; $6af2
	ld (hl),$ff		; $6af5
	ld a,$81		; $6af7
	ld ($cc77),a		; $6af9
	ld hl,$d010		; $6afc
	ld (hl),$14		; $6aff
	ld l,$14		; $6b01
	ld (hl),$00		; $6b03
	inc l			; $6b05
	ld (hl),$fe		; $6b06
	ld a,$18		; $6b08
	ld ($d009),a		; $6b0a
	ld a,$53		; $6b0d
	jp playSound		; $6b0f
	call itemDecCounter1		; $6b12
	ret nz			; $6b15
	ld (hl),$14		; $6b16
	dec l			; $6b18
	inc (hl)		; $6b19
	xor a			; $6b1a
	ld hl,$d01a		; $6b1b
	ld (hl),a		; $6b1e
	inc a			; $6b1f
	ld ($cca4),a		; $6b20
	ret			; $6b23
	call itemDecCounter1		; $6b24
	ret nz			; $6b27
	dec l			; $6b28
	inc (hl)		; $6b29
	ld l,$09		; $6b2a
	ld (hl),$18		; $6b2c
	ld a,$1c		; $6b2e
	call specialObjectSetAnimation		; $6b30
	ld bc,$fe00		; $6b33
	jp objectSetSpeedZ		; $6b36
	call objectApplySpeed		; $6b39
	ld e,$0d		; $6b3c
	ld a,(de)		; $6b3e
	sub $10			; $6b3f
	rlca			; $6b41
	jr nc,_label_06_225	; $6b42
	ld hl,$cfdf		; $6b44
	ld (hl),$01		; $6b47
	ret			; $6b49
_label_06_225:
	ld c,$40		; $6b4a
	call objectUpdateSpeedZ_paramC		; $6b4c
	ret nz			; $6b4f
	call itemIncState2		; $6b50
	ld l,$06		; $6b53
	ld (hl),$08		; $6b55
	jp specialObjectAnimate		; $6b57
	call itemDecCounter1		; $6b5a
	ret nz			; $6b5d
	ld l,$05		; $6b5e
	dec (hl)		; $6b60
	jp $6b2e		; $6b61
	ld e,$04		; $6b64
	ld a,(de)		; $6b66
	rst_jumpTable			; $6b67
	ld l,h			; $6b68
	ld l,e			; $6b69
	sub (hl)		; $6b6a
	ld l,e			; $6b6b
	call $6a07		; $6b6c
	ld h,d			; $6b6f
	ld l,$06		; $6b70
	ld (hl),$5a		; $6b72
	ld l,$10		; $6b74
	ld (hl),$37		; $6b76
	ld l,$36		; $6b78
	ld (hl),$05		; $6b7a
	ld l,$09		; $6b7c
	ld (hl),$10		; $6b7e
	ld l,$0e		; $6b80
	ld (hl),$ff		; $6b82
	inc l			; $6b84
	ld (hl),$e0		; $6b85
	call getFreeInteractionSlot		; $6b87
	jr nz,_label_06_226	; $6b8a
	ld (hl),$c0		; $6b8c
	ld l,$57		; $6b8e
	ld (hl),d		; $6b90
_label_06_226:
	ld a,$07		; $6b91
	jp specialObjectSetAnimation		; $6b93
	ld e,$05		; $6b96
	ld a,(de)		; $6b98
	or a			; $6b99
	jr z,_label_06_227	; $6b9a
	call specialObjectAnimate		; $6b9c
	call objectApplySpeed		; $6b9f
_label_06_227:
	ld e,$05		; $6ba2
	ld a,(de)		; $6ba4
	rst_jumpTable			; $6ba5
	or b			; $6ba6
	ld l,e			; $6ba7
	cp d			; $6ba8
	ld l,e			; $6ba9
	add $6b			; $6baa
	sbc $6b			; $6bac
	xor $6b			; $6bae
	call itemDecCounter1		; $6bb0
	ret nz			; $6bb3
	ld (hl),$48		; $6bb4
	ld l,$05		; $6bb6
	inc (hl)		; $6bb8
	ret			; $6bb9
	call itemDecCounter1		; $6bba
	ret nz			; $6bbd
	ld (hl),$06		; $6bbe
	ld l,$05		; $6bc0
	inc (hl)		; $6bc2
	jp $6d89		; $6bc3
	ld h,d			; $6bc6
	ld l,$09		; $6bc7
	ld a,(hl)		; $6bc9
	cp $10			; $6bca
	jr z,_label_06_228	; $6bcc
	ld l,$05		; $6bce
	inc (hl)		; $6bd0
	ret			; $6bd1
_label_06_228:
	ld l,$06		; $6bd2
	dec (hl)		; $6bd4
	ret nz			; $6bd5
	call $6da0		; $6bd6
	ld (hl),$06		; $6bd9
	jp $6d89		; $6bdb
	ld h,d			; $6bde
	ld l,$09		; $6bdf
	ld a,(hl)		; $6be1
	cp $10			; $6be2
	jr nz,_label_06_228	; $6be4
	ld l,$05		; $6be6
	inc (hl)		; $6be8
	ld a,$07		; $6be9
	jp specialObjectSetAnimation		; $6beb
	ld e,$0b		; $6bee
	ld a,(de)		; $6bf0
	cp $b0			; $6bf1
	ret c			; $6bf3
	ld hl,$d101		; $6bf4
	ld b,$3f		; $6bf7
	call clearMemory		; $6bf9
	ld hl,$d101		; $6bfc
	ld (hl),$10		; $6bff
	ld l,$0b		; $6c01
	ld (hl),$e8		; $6c03
	inc l			; $6c05
	inc l			; $6c06
	ld (hl),$28		; $6c07
	ret			; $6c09
	ld e,$04		; $6c0a
	ld a,(de)		; $6c0c
	rst_jumpTable			; $6c0d
	ld (de),a		; $6c0e
	ld l,h			; $6c0f
	ld h,$6c		; $6c10
	call $6a07		; $6c12
	ld h,d			; $6c15
	ld l,$10		; $6c16
	ld (hl),$28		; $6c18
	ld l,$0e		; $6c1a
	ld (hl),$e0		; $6c1c
	inc l			; $6c1e
	ld (hl),$ff		; $6c1f
	ld a,$19		; $6c21
	jp specialObjectSetAnimation		; $6c23
	ld e,$05		; $6c26
	ld a,(de)		; $6c28
	rst_jumpTable			; $6c29
	jr c,$6c		; $6c2a
	ld h,h			; $6c2c
	ld l,h			; $6c2d
	add a			; $6c2e
	ld l,h			; $6c2f
	sub a			; $6c30
	ld l,h			; $6c31
	and e			; $6c32
	ld l,h			; $6c33
	cp d			; $6c34
	ld l,h			; $6c35
	add $6c			; $6c36
	ld h,d			; $6c38
	ld l,$05		; $6c39
	inc (hl)		; $6c3b
	ld l,$07		; $6c3c
	ld a,(hl)		; $6c3e
	cp $02			; $6c3f
	jr nz,_label_06_229	; $6c41
	push af			; $6c43
	ld a,$1a		; $6c44
	call specialObjectSetAnimation		; $6c46
	pop af			; $6c49
_label_06_229:
	ld b,a			; $6c4a
	add a			; $6c4b
	add b			; $6c4c
	ld hl,$6c5b		; $6c4d
	rst_addAToHl			; $6c50
	ldi a,(hl)		; $6c51
	ld e,$09		; $6c52
	ld (de),a		; $6c54
	ld c,(hl)		; $6c55
	inc hl			; $6c56
	ld b,(hl)		; $6c57
	jp objectSetSpeedZ		; $6c58
	inc c			; $6c5b
	ld b,b			; $6c5c
.DB $fd				; $6c5d
	inc c			; $6c5e
	and b			; $6c5f
.DB $fd				; $6c60
	inc de			; $6c61
	add b			; $6c62
	cp $cd			; $6c63
	ld (hl),$2a		; $6c65
	call objectApplySpeed		; $6c67
	ld c,$18		; $6c6a
	call objectUpdateSpeedZ_paramC		; $6c6c
	ret nz			; $6c6f
	ld h,d			; $6c70
	ld l,$07		; $6c71
	inc (hl)		; $6c73
	ld a,(hl)		; $6c74
	ld l,$05		; $6c75
	cp $03			; $6c77
	jr z,_label_06_230	; $6c79
	dec (hl)		; $6c7b
	ld l,$06		; $6c7c
	ld (hl),$08		; $6c7e
	ret			; $6c80
_label_06_230:
	inc (hl)		; $6c81
	ld l,$06		; $6c82
	ld (hl),$06		; $6c84
	ret			; $6c86
	call itemDecCounter1		; $6c87
	ret nz			; $6c8a
	ld l,$05		; $6c8b
	inc (hl)		; $6c8d
	ld l,$06		; $6c8e
	ld (hl),$14		; $6c90
	ld a,$27		; $6c92
	jp specialObjectSetAnimation		; $6c94
	call itemDecCounter1		; $6c97
	ret nz			; $6c9a
	ld l,$05		; $6c9b
	inc (hl)		; $6c9d
	ld l,$06		; $6c9e
	ld (hl),$78		; $6ca0
	ret			; $6ca2
	call specialObjectAnimate		; $6ca3
	call itemDecCounter1		; $6ca6
	ret nz			; $6ca9
	ld l,$05		; $6caa
	inc (hl)		; $6cac
	ld l,$06		; $6cad
	ld (hl),$3c		; $6caf
	ld l,$09		; $6cb1
	ld (hl),$0b		; $6cb3
	ld l,$10		; $6cb5
	ld (hl),$14		; $6cb7
	ret			; $6cb9
	call itemDecCounter1		; $6cba
	ret nz			; $6cbd
	ld l,$05		; $6cbe
	inc (hl)		; $6cc0
	ld a,$26		; $6cc1
	jp specialObjectSetAnimation		; $6cc3
	call specialObjectAnimate		; $6cc6
	call objectApplySpeed		; $6cc9
	ld e,$0d		; $6ccc
	ld a,(de)		; $6cce
	cp $78			; $6ccf
	jr nz,_label_06_231	; $6cd1
	ld a,$05		; $6cd3
	jp specialObjectSetAnimation		; $6cd5
_label_06_231:
	cp $b0			; $6cd8
	ret c			; $6cda
	ld hl,$d101		; $6cdb
	ld b,$3f		; $6cde
	call clearMemory		; $6ce0
	ld hl,$d101		; $6ce3
	ld (hl),$0f		; $6ce6
	inc l			; $6ce8
	ld (hl),$01		; $6ce9
	ld l,$0b		; $6ceb
	ld (hl),$48		; $6ced
	inc l			; $6cef
	inc l			; $6cf0
	ld (hl),$d8		; $6cf1
	ret			; $6cf3
	ld e,$04		; $6cf4
	ld a,(de)		; $6cf6
	ld a,(de)		; $6cf7
	rst_jumpTable			; $6cf8
.DB $fd				; $6cf9
	ld l,h			; $6cfa
	inc h			; $6cfb
	ld l,l			; $6cfc
	call $6a07		; $6cfd
	ld h,d			; $6d00
	ld l,$10		; $6d01
	ld (hl),$32		; $6d03
	ld l,$36		; $6d05
	ld (hl),$04		; $6d07
	ld l,$02		; $6d09
	ld a,(hl)		; $6d0b
	or a			; $6d0c
	ld a,$f0		; $6d0d
	jr z,_label_06_232	; $6d0f
	ld a,d			; $6d11
	ld ($cc48),a		; $6d12
	ld a,$d0		; $6d15
_label_06_232:
	ld l,$0f		; $6d17
	ld (hl),a		; $6d19
	ld l,$09		; $6d1a
	ld (hl),$18		; $6d1c
	ld l,$02		; $6d1e
	ld a,(hl)		; $6d20
	jp $6d78		; $6d21
	ld e,$02		; $6d24
	ld a,(de)		; $6d26
	rst_jumpTable			; $6d27
	ld d,d			; $6d28
	ld l,l			; $6d29
	inc l			; $6d2a
	ld l,l			; $6d2b
	ld e,$05		; $6d2c
	ld a,(de)		; $6d2e
	rst_jumpTable			; $6d2f
	ld (hl),$6d		; $6d30
	ld h,d			; $6d32
	ld l,l			; $6d33
	ld (hl),a		; $6d34
	ld l,l			; $6d35
	ld a,($cfc0)		; $6d36
	or a			; $6d39
	jr z,_label_06_233	; $6d3a
	call itemIncState2		; $6d3c
	ld bc,$ff00		; $6d3f
	call objectSetSpeedZ		; $6d42
	ld l,$09		; $6d45
	ld (hl),$0e		; $6d47
	ld l,$10		; $6d49
	ld (hl),$14		; $6d4b
	ld a,$1b		; $6d4d
	jp specialObjectSetAnimation		; $6d4f
_label_06_233:
	ld h,d			; $6d52
	ld l,$02		; $6d53
	ld a,(hl)		; $6d55
	ld l,$06		; $6d56
	dec (hl)		; $6d58
	call z,$6d78		; $6d59
	call objectApplySpeed		; $6d5c
	jp specialObjectAnimate		; $6d5f
	call objectApplySpeed		; $6d62
	ld c,$20		; $6d65
	call objectUpdateSpeedZAndBounce		; $6d67
	jp nc,$6d74		; $6d6a
	call itemIncState2		; $6d6d
	ld l,$20		; $6d70
	ld (hl),$01		; $6d72
	jp specialObjectAnimate		; $6d74
	ret			; $6d77
	ld hl,$6da8		; $6d78
	rst_addDoubleIndex			; $6d7b
	ldi a,(hl)		; $6d7c
	ld h,(hl)		; $6d7d
	ld l,a			; $6d7e
	call $6da0		; $6d7f
	ld b,a			; $6d82
	rst_addAToHl			; $6d83
	ld a,(hl)		; $6d84
	ld e,$06		; $6d85
	ld (de),a		; $6d87
	ld a,b			; $6d88
	sub $04			; $6d89
	and $07			; $6d8b
	ret nz			; $6d8d
	ld e,$09		; $6d8e
	call convertAngleDeToDirection		; $6d90
	dec a			; $6d93
	and $03			; $6d94
	ld h,d			; $6d96
	ld l,$08		; $6d97
	ld (hl),a		; $6d99
	ld l,$36		; $6d9a
	add (hl)		; $6d9c
	jp specialObjectSetAnimation		; $6d9d
	ld e,$09		; $6da0
	ld a,(de)		; $6da2
	dec a			; $6da3
	and $1f			; $6da4
	ld (de),a		; $6da6
	ret			; $6da7
	xor h			; $6da8
	ld l,l			; $6da9
	call z,$066d		; $6daa
	ld b,$06		; $6dad
	ld b,$07		; $6daf
	ld ($0a09),sp		; $6db1
	dec bc			; $6db4
	ld a,(bc)		; $6db5
	add hl,bc		; $6db6
	ld ($0607),sp		; $6db7
	ld b,$06		; $6dba
	ld b,$06		; $6dbc
	ld b,$06		; $6dbe
	rlca			; $6dc0
	ld ($0a09),sp		; $6dc1
	dec bc			; $6dc4
	ld a,(bc)		; $6dc5
	add hl,bc		; $6dc6
	ld ($0607),sp		; $6dc7
	ld b,$06		; $6dca
	ld (bc),a		; $6dcc
	ld (bc),a		; $6dcd
	ld (bc),a		; $6dce
	ld (bc),a		; $6dcf
	inc b			; $6dd0
	ld b,$08		; $6dd1
	ld a,(bc)		; $6dd3
	dec c			; $6dd4
	ld a,(bc)		; $6dd5
	ld ($0406),sp		; $6dd6
	ld (bc),a		; $6dd9
	ld (bc),a		; $6dda
	ld (bc),a		; $6ddb
	ld (bc),a		; $6ddc
	ld (bc),a		; $6ddd
	ld (bc),a		; $6dde
	ld (bc),a		; $6ddf
	inc b			; $6de0
	ld b,$08		; $6de1
	ld a,(bc)		; $6de3
	dec c			; $6de4
	ld a,(bc)		; $6de5
	ld ($0406),sp		; $6de6
	ld (bc),a		; $6de9
	ld (bc),a		; $6dea
	ld (bc),a		; $6deb
	ld e,$02		; $6dec
	ld a,(de)		; $6dee
	rst_jumpTable			; $6def
	ld b,$6e		; $6df0
	ld de,$096f		; $6df2
	ld (hl),c		; $6df5
	or b			; $6df6
	ld (hl),c		; $6df7
	inc c			; $6df8
	ld (hl),d		; $6df9
	sbc a			; $6dfa
	ld (hl),d		; $6dfb
.DB $eb				; $6dfc
	ld (hl),d		; $6dfd
	ld (hl),e		; $6dfe
	ld (hl),e		; $6dff
	adc a			; $6e00
	ld (hl),e		; $6e01
	or l			; $6e02
	ld (hl),e		; $6e03
	ld d,d			; $6e04
	ld (hl),h		; $6e05
	ld e,$04		; $6e06
	ld a,(de)		; $6e08
	rst_jumpTable			; $6e09
	ld c,$6e		; $6e0a
	jr _label_06_236		; $6e0c
	call $7381		; $6e0e
	call objectSetVisible81		; $6e11
	xor a			; $6e14
	call specialObjectSetAnimation		; $6e15
	ld e,$05		; $6e18
	ld a,(de)		; $6e1a
	rst_jumpTable			; $6e1b
	ldi a,(hl)		; $6e1c
	ld l,(hl)		; $6e1d
	ld d,(hl)		; $6e1e
	ld l,(hl)		; $6e1f
	ld l,l			; $6e20
	ld l,(hl)		; $6e21
	add e			; $6e22
	ld l,(hl)		; $6e23
	sbc e			; $6e24
	ld l,(hl)		; $6e25
	xor c			; $6e26
	ld l,(hl)		; $6e27
	ld hl,sp+$6e		; $6e28
	ld a,($cc47)		; $6e2a
	rlca			; $6e2d
	ld a,$00		; $6e2e
	jp c,specialObjectSetAnimation		; $6e30
	ld h,d			; $6e33
	ld l,$0b		; $6e34
	ld a,($cc45)		; $6e36
	bit 7,a			; $6e39
	jr z,_label_06_234	; $6e3b
	inc (hl)		; $6e3d
_label_06_234:
	bit 6,a			; $6e3e
	jr z,_label_06_235	; $6e40
	dec (hl)		; $6e42
_label_06_235:
	ld a,(hl)		; $6e43
	cp $40			; $6e44
	jp nc,specialObjectAnimate		; $6e46
	ld a,$01		; $6e49
	ld ($cbb9),a		; $6e4b
	ld a,$77		; $6e4e
	call playSound		; $6e50
	jp itemIncState2		; $6e53
	ld a,($cbb9)		; $6e56
	cp $02			; $6e59
	ret nz			; $6e5b
	call itemIncState2		; $6e5c
	ld b,$04		; $6e5f
	call func_2d48		; $6e61
	ld a,b			; $6e64
	ld e,$06		; $6e65
	ld (de),a		; $6e67
	ld a,$04		; $6e68
	jp specialObjectSetAnimation		; $6e6a
	call itemDecCounter1		; $6e6d
	jp nz,specialObjectAnimate		; $6e70
	ld l,$10		; $6e73
	ld (hl),$05		; $6e75
	ld b,$05		; $6e77
	call func_2d48		; $6e79
_label_06_236:
	ld a,b			; $6e7c
	ld e,$06		; $6e7d
	ld (de),a		; $6e7f
	jp itemIncState2		; $6e80
	call itemDecCounter1		; $6e83
	jp nz,$6e95		; $6e86
	call itemIncState2		; $6e89
	ld b,$07		; $6e8c
	call func_2d48		; $6e8e
	ld a,b			; $6e91
	ld e,$06		; $6e92
	ld (de),a		; $6e94
	ld hl,$6ee0		; $6e95
	jp $6ec9		; $6e98
	call itemDecCounter1		; $6e9b
	jp nz,$6ec6		; $6e9e
	ld a,$03		; $6ea1
	ld ($cbb9),a		; $6ea3
	call itemIncState2		; $6ea6
	ld a,($cbb9)		; $6ea9
	cp $06			; $6eac
	jr nz,_label_06_238	; $6eae
	ld bc,$8406		; $6eb0
	call objectCreateInteraction		; $6eb3
	jr nz,_label_06_237	; $6eb6
	ld l,$56		; $6eb8
	ld a,$00		; $6eba
	ldi (hl),a		; $6ebc
	ld (hl),d		; $6ebd
_label_06_237:
	call itemIncState2		; $6ebe
	ld a,$05		; $6ec1
	jp specialObjectSetAnimation		; $6ec3
_label_06_238:
	ld hl,$6ee8		; $6ec6
	ld a,($cbb7)		; $6ec9
	ld b,a			; $6ecc
	and $07			; $6ecd
	jr nz,_label_06_239	; $6ecf
	ld a,b			; $6ed1
	and $38			; $6ed2
	swap a			; $6ed4
	rlca			; $6ed6
	rst_addAToHl			; $6ed7
	ld e,$0f		; $6ed8
	ld a,(de)		; $6eda
	add (hl)		; $6edb
	ld (de),a		; $6edc
_label_06_239:
	jp specialObjectAnimate		; $6edd
	rst $38			; $6ee0
	cp $fe			; $6ee1
	rst $38			; $6ee3
	nop			; $6ee4
	ld bc,$0001		; $6ee5
	rst $38			; $6ee8
	rst $38			; $6ee9
	rst $38			; $6eea
	nop			; $6eeb
	ld bc,$0101		; $6eec
	nop			; $6eef
	ld (bc),a		; $6ef0
	inc bc			; $6ef1
	inc b			; $6ef2
	inc bc			; $6ef3
	ld (bc),a		; $6ef4
	nop			; $6ef5
	rst $38			; $6ef6
	nop			; $6ef7
	ld e,$21		; $6ef8
	ld a,(de)		; $6efa
	inc a			; $6efb
	jr nz,_label_06_240	; $6efc
	ld a,$07		; $6efe
	ld ($cbb9),a		; $6f00
	ret			; $6f03
_label_06_240:
	call specialObjectAnimate		; $6f04
	ld a,($cbb7)		; $6f07
	rrca			; $6f0a
	jp nc,objectSetInvisible		; $6f0b
	jp objectSetVisible		; $6f0e
	ld e,$04		; $6f11
	ld a,(de)		; $6f13
	rst_jumpTable			; $6f14
	add hl,de		; $6f15
	ld l,a			; $6f16
	inc e			; $6f17
	ld l,a			; $6f18
	jp $7381		; $6f19
	ld e,$05		; $6f1c
	ld a,(de)		; $6f1e
	rst_jumpTable			; $6f1f
	ld c,h			; $6f20
	ld l,a			; $6f21
	ld a,e			; $6f22
	ld l,a			; $6f23
	adc l			; $6f24
	ld l,a			; $6f25
	and b			; $6f26
	ld l,a			; $6f27
	or (hl)			; $6f28
	ld l,a			; $6f29
	rst_jumpTable			; $6f2a
	ld l,a			; $6f2b
	call nc,$e16f		; $6f2c
	ld l,a			; $6f2f
	or $6f			; $6f30
	rst $38			; $6f32
	ld l,a			; $6f33
	inc de			; $6f34
	ld (hl),b		; $6f35
	rra			; $6f36
	ld (hl),b		; $6f37
	ldd (hl),a		; $6f38
	ld (hl),b		; $6f39
	ld h,c			; $6f3a
	ld (hl),b		; $6f3b
	halt			; $6f3c
	ld (hl),b		; $6f3d
	add d			; $6f3e
	ld (hl),b		; $6f3f
	and b			; $6f40
	ld (hl),b		; $6f41
	or a			; $6f42
	ld (hl),b		; $6f43
	ret z			; $6f44
	ld (hl),b		; $6f45
	push de			; $6f46
	ld (hl),b		; $6f47
.DB $f4				; $6f48
	ld (hl),b		; $6f49
	ld h,b			; $6f4a
	ld (hl),b		; $6f4b
	ld a,($cfd0)		; $6f4c
	or a			; $6f4f
	ret nz			; $6f50
	call itemIncState2		; $6f51
	ld l,$06		; $6f54
	ld (hl),$aa		; $6f56
	ld l,$0b		; $6f58
	ld a,$30		; $6f5a
	ldi (hl),a		; $6f5c
	inc l			; $6f5d
	ld a,$50		; $6f5e
	ld (hl),a		; $6f60
	ld l,$19		; $6f61
	ld h,(hl)		; $6f63
	ld l,$4b		; $6f64
	ld a,$30		; $6f66
	ldi (hl),a		; $6f68
	inc l			; $6f69
	ld a,$60		; $6f6a
	ld (hl),a		; $6f6c
	ld e,$08		; $6f6d
	xor a			; $6f6f
	ld (de),a		; $6f70
_label_06_241:
	ld a,$07		; $6f71
	call specialObjectSetAnimation		; $6f73
	ld a,$08		; $6f76
	jp $71a4		; $6f78
	call itemDecCounter1		; $6f7b
	jr nz,_label_06_242	; $6f7e
	ld (hl),$1e		; $6f80
	call itemIncState2		; $6f82
	jr _label_06_241		; $6f85
_label_06_242:
	call specialObjectAnimate		; $6f87
	jp $719a		; $6f8a
	call itemDecCounter1		; $6f8d
	ret nz			; $6f90
	ld (hl),$28		; $6f91
	ld a,$10		; $6f93
	call specialObjectSetAnimation		; $6f95
	ld a,$0d		; $6f98
	call $71a4		; $6f9a
	jp itemIncState2		; $6f9d
	call itemDecCounter1		; $6fa0
	ret nz			; $6fa3
	ld (hl),$3c		; $6fa4
	call itemIncState2		; $6fa6
	ld bc,$0c17		; $6fa9
	call checkIsLinkedGame		; $6fac
	jr z,_label_06_243	; $6faf
	ld c,$18		; $6fb1
_label_06_243:
	jp showText		; $6fb3
	ld a,($cba0)		; $6fb6
	or a			; $6fb9
	ret nz			; $6fba
	call itemDecCounter1		; $6fbb
	ret nz			; $6fbe
	ld (hl),$96		; $6fbf
	call $6f71		; $6fc1
	jp itemIncState2		; $6fc4
	call itemDecCounter1		; $6fc7
	jr nz,_label_06_242	; $6fca
	ld a,$02		; $6fcc
	ld ($cfd0),a		; $6fce
	jp itemIncState2		; $6fd1
	ld a,($cfd0)		; $6fd4
	cp $03			; $6fd7
	jr nz,_label_06_242	; $6fd9
	call $6f71		; $6fdb
	jp itemIncState2		; $6fde
	ld a,($cfd0)		; $6fe1
	cp $04			; $6fe4
	ret nz			; $6fe6
	call itemIncState2		; $6fe7
	ld l,$06		; $6fea
	ld (hl),$5a		; $6fec
	ld l,$08		; $6fee
	ld (hl),$03		; $6ff0
	xor a			; $6ff2
	jp specialObjectSetAnimation		; $6ff3
	call itemDecCounter1		; $6ff6
	ret nz			; $6ff9
	ld (hl),$12		; $6ffa
	jp itemIncState2		; $6ffc
	call itemDecCounter1		; $6fff
	jr nz,_label_06_244	; $7002
	ld (hl),$46		; $7004
	xor a			; $7006
	call specialObjectSetAnimation		; $7007
	jp itemIncState2		; $700a
_label_06_244:
	ld l,$0d		; $700d
	dec (hl)		; $700f
	jp specialObjectAnimate		; $7010
	call itemDecCounter1		; $7013
	ret nz			; $7016
	ld hl,$cfd0		; $7017
	ld (hl),$05		; $701a
	jp itemIncState2		; $701c
	ld hl,$cfd1		; $701f
	bit 6,(hl)		; $7022
	ret z			; $7024
	ld a,$14		; $7025
	ld e,$06		; $7027
	ld (de),a		; $7029
	ld e,$0d		; $702a
	ld a,(de)		; $702c
	dec e			; $702d
	ld (de),a		; $702e
	jp itemIncState2		; $702f
	call itemDecCounter1		; $7032
	jr nz,_label_06_245	; $7035
	ld h,d			; $7037
	ld l,$10		; $7038
	ld (hl),$50		; $703a
	ld l,$09		; $703c
	ld (hl),$0e		; $703e
	ld l,$0d		; $7040
	ld (hl),$40		; $7042
	ld a,$08		; $7044
	call specialObjectSetAnimation		; $7046
	ld bc,$fe80		; $7049
	call objectSetSpeedZ		; $704c
	jp itemIncState2		; $704f
_label_06_245:
	call getRandomNumber		; $7052
	and $0f			; $7055
	sub $08			; $7057
	ld b,a			; $7059
	ld e,$0c		; $705a
	ld a,(de)		; $705c
	inc e			; $705d
	add b			; $705e
	ld (de),a		; $705f
	ret			; $7060
	call objectApplySpeed		; $7061
	ld c,$20		; $7064
	call objectUpdateSpeedZ_paramC		; $7066
	ret nz			; $7069
	call itemIncState2		; $706a
	ld l,$06		; $706d
	ld (hl),$28		; $706f
	ld a,$14		; $7071
	jp specialObjectSetAnimation		; $7073
	call itemDecCounter1		; $7076
	ret nz			; $7079
	ld a,$07		; $707a
	ld ($cfd0),a		; $707c
	jp itemIncState2		; $707f
	ld a,($cfd0)		; $7082
	cp $09			; $7085
	ret nz			; $7087
	call itemIncState2		; $7088
	ld l,$14		; $708b
	ld (hl),$f0		; $708d
	inc l			; $708f
	ld (hl),$fd		; $7090
	ld l,$08		; $7092
	ld (hl),$02		; $7094
	ld a,$0a		; $7096
	call specialObjectSetAnimation		; $7098
	ld a,$53		; $709b
	jp playSound		; $709d
	call specialObjectAnimate		; $70a0
	ld c,$20		; $70a3
	call objectUpdateSpeedZ_paramC		; $70a5
	ret nz			; $70a8
	call itemIncState2		; $70a9
	ld l,$06		; $70ac
	ld (hl),$1e		; $70ae
	xor a			; $70b0
	ld l,$08		; $70b1
	ld (hl),a		; $70b3
	jp specialObjectSetAnimation		; $70b4
	call itemDecCounter1		; $70b7
	ret nz			; $70ba
	ld (hl),$19		; $70bb
	ld l,$10		; $70bd
	ld (hl),$50		; $70bf
	ld l,$09		; $70c1
	ld (hl),$02		; $70c3
	jp itemIncState2		; $70c5
	call specialObjectAnimate		; $70c8
	call objectApplySpeed		; $70cb
	call itemDecCounter1		; $70ce
	ret nz			; $70d1
	jp $7025		; $70d2
	call itemDecCounter1		; $70d5
	jp nz,$7052		; $70d8
	ld e,$10		; $70db
	ld a,$78		; $70dd
	ld (de),a		; $70df
	ld e,$09		; $70e0
	ld a,$19		; $70e2
	ld (de),a		; $70e4
	ld e,$08		; $70e5
	xor a			; $70e7
	ld (de),a		; $70e8
	ld ($cd00),a		; $70e9
	ld a,$08		; $70ec
	call specialObjectSetAnimation		; $70ee
	jp itemIncState2		; $70f1
	call specialObjectAnimate		; $70f4
	call objectApplySpeed		; $70f7
	call objectApplySpeed		; $70fa
	call objectCheckWithinScreenBoundary		; $70fd
	ret c			; $7100
	ld a,$0a		; $7101
	ld ($cfd0),a		; $7103
	jp itemIncState2		; $7106
	ld e,$04		; $7109
	ld a,(de)		; $710b
	rst_jumpTable			; $710c
	ld de,$1971		; $710d
	ld (hl),c		; $7110
	call $7381		; $7111
	ld a,$09		; $7114
	call specialObjectSetAnimation		; $7116
	ld e,$05		; $7119
	ld a,(de)		; $711b
	rst_jumpTable			; $711c
	dec h			; $711d
	ld (hl),c		; $711e
	ld c,h			; $711f
	ld (hl),c		; $7120
	ld e,b			; $7121
	ld (hl),c		; $7122
	ld l,l			; $7123
	ld (hl),c		; $7124
	ld hl,$cfd0		; $7125
	ld a,(hl)		; $7128
	cp $01			; $7129
	ret nz			; $712b
	call specialObjectAnimate		; $712c
	ld e,$21		; $712f
	ld a,(de)		; $7131
	inc a			; $7132
	ret nz			; $7133
	call itemIncState2		; $7134
	ld l,$14		; $7137
	ld (hl),$f0		; $7139
	inc l			; $713b
	ld (hl),$fd		; $713c
	ld l,$08		; $713e
	ld (hl),$02		; $7140
	ld a,$0a		; $7142
	call specialObjectSetAnimation		; $7144
	ld a,$53		; $7147
	call playSound		; $7149
	call $7178		; $714c
	ret nz			; $714f
	call itemIncState2		; $7150
	ld l,$06		; $7153
	ld (hl),$1e		; $7155
	ret			; $7157
	call itemDecCounter1		; $7158
	ret nz			; $715b
	ld hl,$cfd0		; $715c
	ld (hl),$02		; $715f
	call itemIncState2		; $7161
	ld l,$08		; $7164
	ld (hl),$03		; $7166
	ld a,$00		; $7168
	jp specialObjectSetAnimation		; $716a
	ld a,($cfd0)		; $716d
	cp $03			; $7170
	ret nz			; $7172
	ld a,$00		; $7173
	jp setLinkIDOverride		; $7175
	call specialObjectAnimate		; $7178
	ld c,$20		; $717b
	call objectUpdateSpeedZ_paramC		; $717d
	jr z,_label_06_246	; $7180
	ld h,d			; $7182
	ld l,$15		; $7183
	ld a,(hl)		; $7185
	bit 7,a			; $7186
	ret nz			; $7188
	cp $03			; $7189
	ret c			; $718b
	ld l,$14		; $718c
	xor a			; $718e
	ldi (hl),a		; $718f
	ld a,$03		; $7190
	ld (hl),a		; $7192
	or a			; $7193
	ret			; $7194
_label_06_246:
	ld a,$00		; $7195
	jp specialObjectSetAnimation		; $7197
	push de			; $719a
	ld e,$19		; $719b
	ld a,(de)		; $719d
	ld d,a			; $719e
	call interactionUpdateAnimCounter		; $719f
	pop de			; $71a2
	ret			; $71a3
	ld b,a			; $71a4
	push de			; $71a5
	ld e,$19		; $71a6
	ld a,(de)		; $71a8
	ld d,a			; $71a9
	ld a,b			; $71aa
	call interactionSetAnimation		; $71ab
	pop de			; $71ae
	ret			; $71af
	ld e,$04		; $71b0
	ld a,(de)		; $71b2
	rst_jumpTable			; $71b3
	cp b			; $71b4
	ld (hl),c		; $71b5
	call nz,$cd71		; $71b6
	add c			; $71b9
	ld (hl),e		; $71ba
	ld l,$06		; $71bb
	ld (hl),$a8		; $71bd
	ld a,$0c		; $71bf
	jp specialObjectSetAnimation		; $71c1
	ld e,$05		; $71c4
	ld a,(de)		; $71c6
	rst_jumpTable			; $71c7
	ret nc			; $71c8
	ld (hl),c		; $71c9
	and $71			; $71ca
.DB $f4				; $71cc
	ld (hl),c		; $71cd
	ld (bc),a		; $71ce
	ld (hl),d		; $71cf
	call itemDecCounter1		; $71d0
	jr nz,_label_06_247	; $71d3
	ld a,$80		; $71d5
	ld ($cfc0),a		; $71d7
	call itemIncState2		; $71da
	ld bc,$ff00		; $71dd
	call objectSetSpeedZ		; $71e0
_label_06_247:
	jp specialObjectAnimate		; $71e3
	ld c,$20		; $71e6
	call objectUpdateSpeedZ_paramC		; $71e8
	ret nz			; $71eb
	call itemIncState2		; $71ec
	ld l,$06		; $71ef
	ld (hl),$0a		; $71f1
	ret			; $71f3
	call itemDecCounter1		; $71f4
	ret nz			; $71f7
	ld (hl),$78		; $71f8
	call itemIncState2		; $71fa
	ld a,$0c		; $71fd
	jp specialObjectSetAnimation		; $71ff
	call itemDecCounter1		; $7202
	ret nz			; $7205
	ld a,$01		; $7206
	ld ($cfdf),a		; $7208
	ret			; $720b
	ld e,$04		; $720c
	ld a,(de)		; $720e
	rst_jumpTable			; $720f
	inc d			; $7210
	ld (hl),d		; $7211
	jr z,_label_06_248	; $7212
	call $7381		; $7214
	ld l,$09		; $7217
	ld (hl),$00		; $7219
	ld l,$10		; $721b
	ld (hl),$28		; $721d
	ld l,$06		; $721f
	ld (hl),$80		; $7221
	ld a,$00		; $7223
	jp specialObjectSetAnimation		; $7225
	ld e,$05		; $7228
	ld a,(de)		; $722a
	rst_jumpTable			; $722b
	jr c,$72		; $722c
	ld c,h			; $722e
	ld (hl),d		; $722f
	ld e,d			; $7230
	ld (hl),d		; $7231
	ld h,(hl)		; $7232
	ld (hl),d		; $7233
	ld a,(hl)		; $7234
	ld (hl),d		; $7235
	sub e			; $7236
	ld (hl),d		; $7237
	ld a,($c4ab)		; $7238
	or a			; $723b
	ret nz			; $723c
	call specialObjectAnimate		; $723d
	call objectApplySpeed		; $7240
	call itemDecCounter1		; $7243
	ret nz			; $7246
	ld (hl),$06		; $7247
	jp itemIncState2		; $7249
	call itemDecCounter1		; $724c
	ret nz			; $724f
	ld (hl),$78		; $7250
	call itemIncState2		; $7252
	ld a,$03		; $7255
	jp specialObjectSetAnimation		; $7257
	call itemDecCounter1		; $725a
	ret nz			; $725d
	ld hl,$cfc0		; $725e
	ld (hl),$01		; $7261
	jp itemIncState2		; $7263
	ld a,($cfc0)		; $7266
	cp $02			; $7269
	ret nz			; $726b
	call itemIncState2		; $726c
	ld l,$09		; $726f
	ld (hl),$10		; $7271
	ld bc,$ff00		; $7273
	call objectSetSpeedZ		; $7276
	ld a,$0d		; $7279
	jp specialObjectSetAnimation		; $727b
	call objectApplySpeed		; $727e
	ld c,$20		; $7281
	call objectUpdateSpeedZ_paramC		; $7283
_label_06_248:
	ret nz			; $7286
	call itemIncState2		; $7287
	ld l,$06		; $728a
	ld (hl),$78		; $728c
	ld l,$20		; $728e
	ld (hl),$01		; $7290
	ret			; $7292
	call itemDecCounter1		; $7293
	jp nz,specialObjectAnimate		; $7296
	ld hl,$cfdf		; $7299
	ld (hl),$01		; $729c
	ret			; $729e
	ld e,$04		; $729f
	ld a,(de)		; $72a1
	rst_jumpTable			; $72a2
	and a			; $72a3
	ld (hl),d		; $72a4
	or e			; $72a5
	ld (hl),d		; $72a6
	call $7381		; $72a7
	ld l,$06		; $72aa
	ld (hl),$f0		; $72ac
	ld a,$03		; $72ae
	jp specialObjectSetAnimation		; $72b0
	ld e,$05		; $72b3
	ld a,(de)		; $72b5
	rst_jumpTable			; $72b6
	cp e			; $72b7
	ld (hl),d		; $72b8
	pop hl			; $72b9
	ld (hl),d		; $72ba
	ld a,($c4ab)		; $72bb
	or a			; $72be
	ret nz			; $72bf
	call itemDecCounter1		; $72c0
	ret nz			; $72c3
	ld l,$06		; $72c4
	ld (hl),$3c		; $72c6
	call itemIncState2		; $72c8
	ld hl,$cfc0		; $72cb
	ld (hl),$01		; $72ce
	ld bc,$f804		; $72d0
	ld a,$ff		; $72d3
	call objectCreateExclamationMark		; $72d5
	ld l,$42		; $72d8
	ld (hl),$01		; $72da
	ld a,$0e		; $72dc
	jp specialObjectSetAnimation		; $72de
	call itemDecCounter1		; $72e1
	ret nz			; $72e4
	ld hl,$cfdf		; $72e5
	ld (hl),$01		; $72e8
	ret			; $72ea
	ld e,$04		; $72eb
	ld a,(de)		; $72ed
	rst_jumpTable			; $72ee
	di			; $72ef
	ld (hl),d		; $72f0
	rrca			; $72f1
	ld (hl),e		; $72f2
	call $7381		; $72f3
	call objectSetInvisible		; $72f6
	call $7305		; $72f9
	ld a,$0b		; $72fc
	jr nz,_label_06_249	; $72fe
	ld a,$0f		; $7300
_label_06_249:
	jp specialObjectSetAnimation		; $7302
	ld hl,$c680		; $7305
	ld a,$01		; $7308
	cp (hl)			; $730a
	ret z			; $730b
	inc l			; $730c
	cp (hl)			; $730d
	ret			; $730e
	ld e,$05		; $730f
	ld a,(de)		; $7311
	rst_jumpTable			; $7312
	dec de			; $7313
	ld (hl),e		; $7314
	daa			; $7315
	ld (hl),e		; $7316
	dec sp			; $7317
	ld (hl),e		; $7318
	ld h,e			; $7319
	ld (hl),e		; $731a
	ld a,($cfc0)		; $731b
	cp $01			; $731e
	ret nz			; $7320
	call itemIncState2		; $7321
	jp objectSetVisible		; $7324
	ld a,($cfc0)		; $7327
	cp $07			; $732a
	ret nz			; $732c
	call itemIncState2		; $732d
	call $7305		; $7330
	ld a,$10		; $7333
	jr nz,_label_06_250	; $7335
	inc a			; $7337
_label_06_250:
	jp specialObjectSetAnimation		; $7338
	ld a,($cfc0)		; $733b
	cp $08			; $733e
	ret nz			; $7340
	call itemIncState2		; $7341
	ld l,$06		; $7344
	ld (hl),$68		; $7346
	inc l			; $7348
	ld (hl),$01		; $7349
	ld b,$02		; $734b
_label_06_251:
	call getFreeInteractionSlot		; $734d
	jr nz,_label_06_252	; $7350
	ld (hl),$b7		; $7352
	inc l			; $7354
	ld a,b			; $7355
	dec a			; $7356
	ld (hl),a		; $7357
	call objectCopyPosition		; $7358
	dec b			; $735b
	jr nz,_label_06_251	; $735c
_label_06_252:
	ld a,$12		; $735e
	jp specialObjectSetAnimation		; $7360
	call specialObjectAnimate		; $7363
	ld h,d			; $7366
	ld l,$06		; $7367
	call decHlRef16WithCap		; $7369
	ret nz			; $736c
	ld hl,$cfc0		; $736d
	ld (hl),$09		; $7370
	ret			; $7372
	ld e,$04		; $7373
	ld a,(de)		; $7375
	rst_jumpTable			; $7376
	ld a,e			; $7377
	ld (hl),e		; $7378
	ld ($cd72),a		; $7379
	add c			; $737c
	ld (hl),e		; $737d
	jp $72d0		; $737e
	ld hl,$41b5		; $7381
	ld e,$05		; $7384
	call interBankCall		; $7386
	call objectSetVisiblec1		; $7389
	jp itemIncState		; $738c
	ld e,$04		; $738f
	ld a,(de)		; $7391
	rst_jumpTable			; $7392
	sub a			; $7393
	ld (hl),e		; $7394
	and e			; $7395
	ld (hl),e		; $7396
	call $7381		; $7397
	ld l,$10		; $739a
	ld (hl),$28		; $739c
	ld a,$00		; $739e
	call specialObjectSetAnimation		; $73a0
	call specialObjectAnimate		; $73a3
	call $74ee		; $73a6
	call $7520		; $73a9
	call $7501		; $73ac
	ret nc			; $73af
	ld a,$00		; $73b0
	jp setLinkIDOverride		; $73b2
	ld e,$04		; $73b5
	ld a,(de)		; $73b7
	rst_jumpTable			; $73b8
	cp l			; $73b9
	ld (hl),e		; $73ba
	jp z,$cd73		; $73bb
	add c			; $73be
	ld (hl),e		; $73bf
	push de			; $73c0
	call clearItems		; $73c1
	pop de			; $73c4
	ld a,$13		; $73c5
	jp specialObjectSetAnimation		; $73c7
	ld e,$05		; $73ca
	ld a,(de)		; $73cc
	rst_jumpTable			; $73cd
	call c,$f173		; $73ce
	ld (hl),e		; $73d1
.DB $fc				; $73d2
	ld (hl),e		; $73d3
	ld d,$74		; $73d4
	dec l			; $73d6
	ld (hl),h		; $73d7
	dec sp			; $73d8
	ld (hl),h		; $73d9
	ld d,c			; $73da
	ld (hl),h		; $73db
	ld a,($cfd1)		; $73dc
	or a			; $73df
	ret z			; $73e0
	call itemIncState2		; $73e1
	ld l,$06		; $73e4
	ld (hl),$28		; $73e6
	ld l,$10		; $73e8
	ld (hl),$05		; $73ea
	ld l,$09		; $73ec
	ld (hl),$10		; $73ee
	ret			; $73f0
	call itemDecCounter1		; $73f1
	jp nz,objectApplySpeed		; $73f4
	ld (hl),$19		; $73f7
	jp itemIncState2		; $73f9
	call itemDecCounter1		; $73fc
	ret nz			; $73ff
	call itemIncState2		; $7400
	ld l,$10		; $7403
	ld (hl),$78		; $7405
	ld l,$09		; $7407
	xor a			; $7409
	ld (hl),a		; $740a
	ld l,$0f		; $740b
	ld (hl),$fa		; $740d
_label_06_253:
	ld l,$20		; $740f
	ld (hl),$01		; $7411
	jp specialObjectAnimate		; $7413
	call objectApplySpeed		; $7416
	ld e,$0b		; $7419
	ld a,(de)		; $741b
	cp $10			; $741c
	ret nc			; $741e
	ld a,$82		; $741f
	call playSound		; $7421
	call itemIncState2		; $7424
	ld l,$06		; $7427
	ld (hl),$1e		; $7429
	jr _label_06_253		; $742b
	call itemDecCounter1		; $742d
	jr nz,_label_06_254	; $7430
	call itemIncState2		; $7432
	ld bc,$ff40		; $7435
	jp objectSetSpeedZ		; $7438
	ld c,$10		; $743b
	call objectUpdateSpeedZ_paramC		; $743d
	ret nz			; $7440
	call itemIncState2		; $7441
	jr _label_06_253		; $7444
_label_06_254:
	ld a,(wFrameCounter)		; $7446
	and $03			; $7449
	ret nz			; $744b
	ld a,$04		; $744c
	ld ($cd18),a		; $744e
	ret			; $7451
	ld e,$04		; $7452
	ld a,(de)		; $7454
	rst_jumpTable			; $7455
	ld e,d			; $7456
	ld (hl),h		; $7457
	add (hl)		; $7458
	ld (hl),h		; $7459
	call $7381		; $745a
	call objectSetVisible81		; $745d
	ld l,$06		; $7460
	ld (hl),$2c		; $7462
	inc hl			; $7464
	ld (hl),$01		; $7465
	ld l,$0b		; $7467
	ld (hl),$d0		; $7469
	ld l,$0d		; $746b
	ld (hl),$50		; $746d
	ld a,$08		; $746f
	call specialObjectSetAnimation		; $7471
	xor a			; $7474
	ld ($cbb9),a		; $7475
	ld bc,$8409		; $7478
	call objectCreateInteraction		; $747b
	jr nz,_label_06_255	; $747e
	ld l,$56		; $7480
	ld a,$00		; $7482
	ldi (hl),a		; $7484
	ld (hl),d		; $7485
_label_06_255:
	ld a,(wFrameCounter)		; $7486
	ld ($cbb7),a		; $7489
	ld e,$05		; $748c
	ld a,(de)		; $748e
	rst_jumpTable			; $748f
	sbc b			; $7490
	ld (hl),h		; $7491
	and a			; $7492
	ld (hl),h		; $7493
	or a			; $7494
	ld (hl),h		; $7495
	rst $8			; $7496
	ld (hl),h		; $7497
	call $74e8		; $7498
	ld hl,$d006		; $749b
	call decHlRef16WithCap		; $749e
	ret nz			; $74a1
	ld (hl),$3c		; $74a2
	jp itemIncState2		; $74a4
	call $74e8		; $74a7
	call itemDecCounter1		; $74aa
	ret nz			; $74ad
	call itemIncState2		; $74ae
	ld bc,$0c16		; $74b1
	jp showText		; $74b4
	ld hl,$6ee8		; $74b7
	call $6ec9		; $74ba
	ld a,($cba0)		; $74bd
	or a			; $74c0
	ret nz			; $74c1
	ld a,$06		; $74c2
	ld ($cbb9),a		; $74c4
	ld a,$91		; $74c7
	call playSound		; $74c9
	jp $6eb0		; $74cc
	ld e,$21		; $74cf
	ld a,(de)		; $74d1
	inc a			; $74d2
	jr nz,_label_06_256	; $74d3
	ld a,$07		; $74d5
	ld ($cbb9),a		; $74d7
	ret			; $74da
_label_06_256:
	call specialObjectAnimate		; $74db
	ld a,(wFrameCounter)		; $74de
	rrca			; $74e1
	jp nc,objectSetInvisible		; $74e2
	jp objectSetVisible		; $74e5
	ld hl,$6ef0		; $74e8
	jp $6ec9		; $74eb
	ld e,$03		; $74ee
	ld a,(de)		; $74f0
	ld hl,$751e		; $74f1
	rst_addDoubleIndex			; $74f4
	ld b,(hl)		; $74f5
	inc hl			; $74f6
	ld c,(hl)		; $74f7
	call objectGetRelativeAngle		; $74f8
	ld e,$09		; $74fb
	ld (de),a		; $74fd
	jp objectApplySpeed		; $74fe
	ld e,$03		; $7501
	ld a,(de)		; $7503
	ld bc,$751e		; $7504
	call addDoubleIndexToBc		; $7507
	ld h,d			; $750a
	ld l,$0b		; $750b
	ld a,(bc)		; $750d
	sub (hl)		; $750e
	add $01			; $750f
	cp $03			; $7511
	ret nc			; $7513
	inc bc			; $7514
	ld l,$0d		; $7515
	ld a,(bc)		; $7517
	sub (hl)		; $7518
	add $01			; $7519
	cp $03			; $751b
	ret			; $751d
	ld c,b			; $751e
	ld d,b			; $751f
	ld a,(wFrameCounter)		; $7520
	and $07			; $7523
	ret nz			; $7525
	ld e,$09		; $7526
	ld a,(de)		; $7528
	ld hl,$7532		; $7529
	rst_addAToHl			; $752c
	ld a,(hl)		; $752d
	ld e,$08		; $752e
	ld (de),a		; $7530
	ret			; $7531
	nop			; $7532
	nop			; $7533
	ld bc,$0101		; $7534
	ld bc,$0101		; $7537
	ld bc,$0101		; $753a
	ld bc,$0101		; $753d
	ld bc,$0202		; $7540
	ld (bc),a		; $7543
	inc bc			; $7544
	inc bc			; $7545
	inc bc			; $7546
	inc bc			; $7547
	inc bc			; $7548
	inc bc			; $7549
	inc bc			; $754a
	inc bc			; $754b
	inc bc			; $754c
	inc bc			; $754d
	inc bc			; $754e
	inc bc			; $754f
	inc bc			; $7550
	nop			; $7551
	ld h,d			; $7552
	ld (hl),l		; $7553
	xor (hl)		; $7554
	ld (hl),l		; $7555
	cp b			; $7556
	ld (hl),l		; $7557
_label_06_257:
	ld h,d			; $7558
	ld (hl),l		; $7559
	cp b			; $755a
	ld (hl),l		; $755b
	cp h			; $755c
	ld (hl),l		; $755d
	cp a			; $755e
	ld (hl),l		; $755f
	cp a			; $7560
	ld (hl),l		; $7561
	ld b,e			; $7562
	reti			; $7563
	nop			; $7564
	ld d,d			; $7565
	ld c,l			; $7566
	ld bc,$0b17		; $7567
	inc bc			; $756a
	ld d,e			; $756b
	rra			; $756c
	inc b			; $756d
	daa			; $756e
	sub a			; $756f
	dec b			; $7570
	ld b,l			; $7571
	ld (hl),e		; $7572
	ld a,(bc)		; $7573
	daa			; $7574
.DB $fc				; $7575
	dec bc			; $7576
	jr z,_label_06_258	; $7577
	inc c			; $7579
	ld b,l			; $757a
	ld a,a			; $757b
	dec c			; $757c
	inc de			; $757d
	or h			; $757e
	ld c,$55		; $757f
	add d			; $7581
	rrca			; $7582
	rla			; $7583
	add d			; $7584
	stop			; $7585
	ld h,$9b		; $7586
	ld de,$6341		; $7588
	ld (de),a		; $758b
	ldi (hl),a		; $758c
	ld a,e			; $758d
	inc de			; $758e
	inc (hl)		; $758f
	ld d,h			; $7590
	inc d			; $7591
	ld d,(hl)		; $7592
	rst_addAToHl			; $7593
	dec d			; $7594
	ld (de),a		; $7595
	call nz,$2316		; $7596
	inc l			; $7599
	rla			; $759a
	jr c,_label_06_257	; $759b
	jr $27			; $759d
	ld d,l			; $759f
	add hl,de		; $75a0
	dec h			; $75a1
.DB $f4				; $75a2
	ld a,(de)		; $75a3
	inc hl			; $75a4
	cp c			; $75a5
	dec de			; $75a6
	inc sp			; $75a7
	or $1d			; $75a8
	inc hl			; $75aa
	ld l,b			; $75ab
	ld e,$00		; $75ac
_label_06_258:
	daa			; $75ae
	ld b,l			; $75af
	rlca			; $75b0
	ld b,d			; $75b1
	ld e,c			; $75b2
	ld ($1446),sp		; $75b3
	add hl,bc		; $75b6
	nop			; $75b7
	rla			; $75b8
	inc b			; $75b9
	ld (bc),a		; $75ba
	nop			; $75bb
	add d			; $75bc
	ld (de),a		; $75bd
	inc e			; $75be
	nop			; $75bf
	call z,$4375		; $75c0
	halt			; $75c3
	call z,$b275		; $75c4
	halt			; $75c7
	or d			; $75c8
	halt			; $75c9
	pop hl			; $75ca
	halt			; $75cb
	ld hl,sp+$00		; $75cc
	ld a,($ff00+c)		; $75ce
	dec c			; $75cf
	call nz,$c501		; $75d0
	ld (bc),a		; $75d3
	add $03			; $75d4
	rst_jumpTable			; $75d6
	inc b			; $75d7
	push hl			; $75d8
	dec b			; $75d9
	ret c			; $75da
	ld b,$c3		; $75db
	ld b,$c8		; $75dd
	rlca			; $75df
	ret			; $75e0
	ld ($09c0),sp		; $75e1
	pop bc			; $75e4
	ld a,(bc)		; $75e5
	jp nz,$e20b		; $75e6
	inc c			; $75e9
	reti			; $75ea
	ld c,$da		; $75eb
	rrca			; $75ed
.DB $db				; $75ee
	stop			; $75ef
	jp z,$cb11		; $75f0
	ld (de),a		; $75f3
	rst_addAToHl			; $75f4
	inc de			; $75f5
.DB $e3				; $75f6
	dec d			; $75f7
	ld bc,$0414		; $75f8
	inc d			; $75fb
	dec b			; $75fc
	inc d			; $75fd
	ld b,$14		; $75fe
	rlca			; $7600
	inc d			; $7601
	ld ($0914),sp		; $7602
	inc d			; $7605
	ld a,(bc)		; $7606
	inc d			; $7607
	dec bc			; $7608
	inc d			; $7609
	inc c			; $760a
	inc d			; $760b
	dec c			; $760c
	inc d			; $760d
	ld c,$14		; $760e
	rrca			; $7610
	inc d			; $7611
	ld de,$1214		; $7612
	inc d			; $7615
	inc de			; $7616
	inc d			; $7617
	inc d			; $7618
	inc d			; $7619
	dec d			; $761a
	inc d			; $761b
	ld d,$14		; $761c
	rla			; $761e
	inc d			; $761f
	jr _label_06_259		; $7620
	add hl,de		; $7622
	inc d			; $7623
	ld a,(de)		; $7624
	inc d			; $7625
	dec de			; $7626
	inc d			; $7627
	inc e			; $7628
	inc d			; $7629
	dec e			; $762a
	inc d			; $762b
	ld e,$14		; $762c
	ld c,l			; $762e
	inc d			; $762f
	ld c,(hl)		; $7630
	inc d			; $7631
	ld e,l			; $7632
	inc d			; $7633
	ld e,(hl)		; $7634
	inc d			; $7635
_label_06_259:
	ld e,a			; $7636
	inc d			; $7637
	ld l,l			; $7638
	inc d			; $7639
	ld l,(hl)		; $763a
	inc d			; $763b
	ld l,a			; $763c
	inc d			; $763d
	xor a			; $763e
	inc d			; $763f
	cp a			; $7640
	inc d			; $7641
	nop			; $7642
	ld hl,sp+$00		; $7643
	ld sp,hl		; $7645
	nop			; $7646
	ld a,($ff00+c)		; $7647
	dec c			; $7648
	jp hl			; $7649
	add hl,bc		; $764a
	ld bc,$0417		; $764b
	rla			; $764e
	dec b			; $764f
	rla			; $7650
	ld b,$17		; $7651
	rlca			; $7653
	rla			; $7654
	ld ($0917),sp		; $7655
	rla			; $7658
	ld a,(bc)		; $7659
	rla			; $765a
	dec bc			; $765b
	rla			; $765c
_label_06_260:
	inc c			; $765d
	rla			; $765e
	dec c			; $765f
	rla			; $7660
_label_06_261:
	ld c,$17		; $7661
	rrca			; $7663
	rla			; $7664
	ld de,$1217		; $7665
	rla			; $7668
	inc de			; $7669
	rla			; $766a
	inc d			; $766b
	rla			; $766c
	dec d			; $766d
	rla			; $766e
	ld d,$17		; $766f
	rla			; $7671
	rla			; $7672
	jr _label_06_262		; $7673
	add hl,de		; $7675
	rla			; $7676
	ld a,(de)		; $7677
	rla			; $7678
	dec de			; $7679
	rla			; $767a
	inc e			; $767b
	rla			; $767c
	dec e			; $767d
	rla			; $767e
	ld e,$17		; $767f
	rra			; $7681
	rla			; $7682
	jr nz,_label_06_263	; $7683
	ld hl,$2217		; $7685
	rla			; $7688
	inc hl			; $7689
	rla			; $768a
	inc h			; $768b
_label_06_262:
	rla			; $768c
	dec h			; $768d
	rla			; $768e
	ld h,$17		; $768f
	daa			; $7691
	rla			; $7692
	jr z,_label_06_265	; $7693
	add hl,hl		; $7695
	rla			; $7696
	ldi a,(hl)		; $7697
	rla			; $7698
	dec hl			; $7699
	rla			; $769a
	inc l			; $769b
_label_06_263:
	rla			; $769c
	dec l			; $769d
	rla			; $769e
	ld l,$17		; $769f
	cp b			; $76a1
_label_06_264:
	jr _label_06_260		; $76a2
	jr _label_06_261		; $76a4
	rla			; $76a6
	cp h			; $76a7
	rla			; $76a8
	cp l			; $76a9
	rla			; $76aa
	cp (hl)			; $76ab
_label_06_265:
	rla			; $76ac
	cp a			; $76ad
	rla			; $76ae
	cpl			; $76af
	ld d,$00		; $76b0
	ld hl,sp+$2d		; $76b2
	jr nz,_label_06_266	; $76b4
	ld hl,$221a		; $76b6
	dec de			; $76b9
	inc hl			; $76ba
	inc e			; $76bb
	rst $28			; $76bc
	ld l,$11		; $76bd
	dec e			; $76bf
	ld (de),a		; $76c0
	ld e,$10		; $76c1
	rra			; $76c3
	inc de			; $76c4
	jr nz,$1f		; $76c5
	ld hl,$2230		; $76c7
	ld sp,$3223		; $76ca
	inc h			; $76cd
	inc sp			; $76ce
_label_06_266:
	dec h			; $76cf
	jr c,$26		; $76d0
	add hl,sp		; $76d2
	daa			; $76d3
	ldd a,(hl)		; $76d4
	jr z,$3b		; $76d5
	add hl,hl		; $76d7
	ld d,$2a		; $76d8
	dec d			; $76da
	dec hl			; $76db
	dec hl			; $76dc
	inc l			; $76dd
	ldi a,(hl)		; $76de
	inc l			; $76df
	nop			; $76e0
	ld (de),a		; $76e1
	cpl			; $76e2
	nop			; $76e3
	sub (hl)		; $76e4
	jr nc,_label_06_267	; $76e5
	stop			; $76e7
	inc b			; $76e8
	or a			; $76e9
	or c			; $76ea
	ld d,$00		; $76eb
	inc b			; $76ed
	or a			; $76ee
	or c			; $76ef
	ld b,$c0		; $76f0
	and $b7			; $76f2
	or c			; $76f4
	ld b,$c0		; $76f5
	ldh (<hIntroInputsEnabled),a	; $76f7
_label_06_267:
	or c			; $76f9
	ld b,$00		; $76fa
	di			; $76fc
	or a			; $76fd
	or c			; $76fe
	ld b,$00		; $76ff
	inc b			; $7701
	or (hl)			; $7702
	or c			; $7703
	ld b,(hl)		; $7704
	ld bc,$f604		; $7705
	jr nc,_label_06_268	; $7708
	nop			; $770a
	inc b			; $770b
	or $30			; $770c
	dec bc			; $770e
	nop			; $770f
	di			; $7710
	ld hl,$4000		; $7711
	ld b,$04		; $7714
	ld hl,$0000		; $7716
	add $e7			; $7719
	ld hl,$0000		; $771b
	add $e0			; $771e
	jr nc,_label_06_264	; $7720
	nop			; $7722
	add $e8			; $7723
	xor l			; $7725
	ld de,$0c70		; $7726
	inc b			; $7729
	ld b,b			; $772a
	add b			; $772b
	ld b,a			; $772c
	add hl,de		; $772d
	inc b			; $772e
	ld b,b			; $772f
	add b			; $7730
	rlca			; $7731
	add hl,de		; $7732
	di			; $7733
	ld (hl),b		; $7734
	nop			; $7735
	dec bc			; $7736
	rra			; $7737
.DB $fd				; $7738
	nop			; $7739
	stop			; $773a
	ld (hl),b		; $773b
_label_06_268:
	rra			; $773c
	inc b			; $773d
	nop			; $773e
	stop			; $773f
	nop			; $7740
	rst_addDoubleIndex			; $7741
	rst $20			; $7742
	add c			; $7743
	nop			; $7744
	add h			; $7745
	rra			; $7746
	inc b			; $7747
	ld b,b			; $7748
	nop			; $7749
	sub b			; $774a
	ld a,(bc)		; $774b
	pop hl			; $774c
	ld b,b			; $774d
	nop			; $774e
	nop			; $774f
	jp z,$40e0		; $7750
	nop			; $7753
	nop			; $7754
	ld a,(bc)		; $7755
	pop hl			; $7756
	ld b,b			; $7757
	nop			; $7758
	and b			; $7759
	ld a,(bc)		; $775a
	pop hl			; $775b
	ld b,b			; $775c
	nop			; $775d
	or b			; $775e
	ld a,(bc)		; $775f
	pop hl			; $7760
	or a			; $7761
	ld sp,$0014		; $7762
	and b			; $7765
	or a			; $7766
	ld sp,$0004		; $7767
	and b			; $776a
	or a			; $776b
	ld sp,$4004		; $776c
	ld b,l			; $776f
	or a			; $7770
	ld sp,$0004		; $7771
	di			; $7774
	dec h			; $7775
	ld bc,$0600		; $7776
	and b			; $7779
	dec h			; $777a
	ld bc,$4600		; $777b
	ld b,l			; $777e
	dec h			; $777f
	ld bc,$0620		; $7780
	and b			; $7783
	dec h			; $7784
	ld bc,$4600		; $7785
	dec c			; $7788
	jr nc,_label_06_269	; $7789
_label_06_269:
	nop			; $778b
	ld b,$a0		; $778c
	jr nc,_label_06_270	; $778e
_label_06_270:
	nop			; $7790
	add $34			; $7791
	jr nc,_label_06_271	; $7793
_label_06_271:
	nop			; $7795
	add $35			; $7796
	jr nc,_label_06_272	; $7798
_label_06_272:
	nop			; $779a
	add $36			; $779b
	jr nc,_label_06_273	; $779d
_label_06_273:
	nop			; $779f
	add $37			; $77a0
	jr nc,_label_06_274	; $77a2
_label_06_274:
	nop			; $77a4
	add $34			; $77a5
	jr nc,_label_06_275	; $77a7
_label_06_275:
	nop			; $77a9
	add $35			; $77aa
	jr nc,_label_06_276	; $77ac
_label_06_276:
	nop			; $77ae
	add $36			; $77af
	jr nc,_label_06_277	; $77b1
_label_06_277:
	nop			; $77b3
	add $37			; $77b4
	ccf			; $77b6
	nop			; $77b7
	nop			; $77b8
	ld b,$a0		; $77b9
	ld hl,$4000		; $77bb
	ld b,$4c		; $77be
	ld b,$00		; $77c0
	nop			; $77c2
	rlca			; $77c3
	nop			; $77c4
	sub (hl)		; $77c5
	jr nc,_label_06_278	; $77c6
	stop			; $77c8
	rst $28			; $77c9
_label_06_278:
	ld b,b			; $77ca
	nop			; $77cb
	ret nz			; $77cc
	ld a,(bc)		; $77cd
	ld c,h			; $77ce
	jr nc,_label_06_279	; $77cf
_label_06_279:
	nop			; $77d1
	ld b,$01		; $77d2

.BANK $07 SLOT 1
.ORG 0

	ld a,c			; $4000
	rst_jumpTable			; $4001
	ld a,(bc)		; $4002
	ld b,b			; $4003
	ld d,c			; $4004
	ld b,b			; $4005
	ld a,l			; $4006
	ld b,b			; $4007
	sub (hl)		; $4008
	ld b,b			; $4009
	ld hl,$4182		; $400a
	call $416e		; $400d
	ld hl,$c613		; $4010
	ldd a,(hl)		; $4013
	add a			; $4014
	add (hl)		; $4015
	push af			; $4016
	ld hl,$417a		; $4017
	rst_addDoubleIndex			; $401a
	ldi a,(hl)		; $401b
	ld h,(hl)		; $401c
	ld l,a			; $401d
	call $416e		; $401e
	pop af			; $4021
	ld c,a			; $4022
	ld hl,$c5c0		; $4023
	ld b,$40		; $4026
	ld a,$ff		; $4028
	call fillMemory		; $402a
	ld hl,$c6c0		; $402d
	ld b,$06		; $4030
	ld a,$ff		; $4032
	call fillMemory		; $4034
	ld a,c			; $4037
	cp $02			; $4038
	jr nz,_label_07_000	; $403a
	ld hl,$c692		; $403c
	ld a,$2d		; $403f
	call setFlag		; $4041
	ld a,$76		; $4044
	ld ($c5c0),a		; $4046
_label_07_000:
	ld hl,$4404		; $4049
	ld e,$0a		; $404c
	call interBankCall		; $404e
	ld hl,$c611		; $4051
	ld (hl),$00		; $4054
	ld hl,$c5b2		; $4056
	ld de,$41b1		; $4059
	ld b,$08		; $405c
	call copyMemoryReverse		; $405e
	ld l,$b0		; $4061
	call $4138		; $4063
	ld (hl),e		; $4066
	inc l			; $4067
	ld (hl),d		; $4068
	ld l,$b0		; $4069
	call $414f		; $406b
	ld e,c			; $406e
	ld d,b			; $406f
	call $40f6		; $4070
	call $4153		; $4073
	ld e,c			; $4076
	ld d,b			; $4077
	call $40f6		; $4078
	jr _label_07_003		; $407b
	call $40b4		; $407d
	push af			; $4080
	or a			; $4081
	jr nz,_label_07_001	; $4082
	call $414f		; $4084
	jr _label_07_002		; $4087
_label_07_001:
	call $4153		; $4089
_label_07_002:
	ld l,c			; $408c
	ld h,b			; $408d
	ld de,$c5b0		; $408e
	call $40f6		; $4091
	pop af			; $4094
	ret			; $4095
	call $414f		; $4096
	call $409f		; $4099
	call $4153		; $409c
	ld a,$0a		; $409f
	ld ($1111),a		; $40a1
	ld l,c			; $40a4
	ld h,b			; $40a5
	call $40ae		; $40a6
	xor a			; $40a9
	ld ($1111),a		; $40aa
	ret			; $40ad
	ld bc,$0550		; $40ae
	jp clearMemoryBc		; $40b1
_label_07_003:
	call $4153		; $40b4
	ld l,c			; $40b7
	ld h,b			; $40b8
	call $4108		; $40b9
	and $01			; $40bc
	push af			; $40be
	call $414f		; $40bf
	ld l,c			; $40c2
	ld h,b			; $40c3
	call $4108		; $40c4
	pop bc			; $40c7
	rl b			; $40c8
	ld a,b			; $40ca
	rst_jumpTable			; $40cb
	pop hl			; $40cc
	ld b,b			; $40cd
.DB $e3				; $40ce
	ld b,b			; $40cf
	call nc,$f340		; $40d0
	ld b,b			; $40d3
	call $4153		; $40d4
	ld e,c			; $40d7
	ld d,b			; $40d8
	call $414f		; $40d9
	ld l,c			; $40dc
	ld h,b			; $40dd
	call $40f6		; $40de
	xor a			; $40e1
	ret			; $40e2
	call $414f		; $40e3
	ld e,c			; $40e6
	ld d,b			; $40e7
	call $4153		; $40e8
	ld l,c			; $40eb
	ld h,b			; $40ec
	call $40f6		; $40ed
	ld a,$01		; $40f0
	ret			; $40f2
	ld a,$ff		; $40f3
	ret			; $40f5
	push hl			; $40f6
	ld a,$0a		; $40f7
	ld ($1111),a		; $40f9
	ld bc,$0550		; $40fc
	call copyMemoryBc		; $40ff
	xor a			; $4102
	ld ($1111),a		; $4103
	pop hl			; $4106
	ret			; $4107
	push hl			; $4108
	ld a,$0a		; $4109
	ld ($1111),a		; $410b
	call $4138		; $410e
	ldi a,(hl)		; $4111
	cp e			; $4112
	jr nz,_label_07_006	; $4113
	ldi a,(hl)		; $4115
	cp d			; $4116
	jr nz,_label_07_006	; $4117
	ld de,$41b1		; $4119
	ld b,$08		; $411c
_label_07_004:
	ld a,(de)		; $411e
	cp (hl)			; $411f
	jr nz,_label_07_006	; $4120
	inc de			; $4122
	inc hl			; $4123
	dec b			; $4124
	jr nz,_label_07_004	; $4125
_label_07_005:
	xor a			; $4127
	ld ($1111),a		; $4128
	pop hl			; $412b
	ld a,b			; $412c
	rrca			; $412d
	ret			; $412e
_label_07_006:
	pop hl			; $412f
	push hl			; $4130
	call $40ae		; $4131
	ld b,$ff		; $4134
	jr _label_07_005		; $4136
	push hl			; $4138
	ld a,$02		; $4139
	rst_addAToHl			; $413b
	ld bc,$02a7		; $413c
	ld de,$0000		; $413f
_label_07_007:
	ldi a,(hl)		; $4142
	add e			; $4143
	ld e,a			; $4144
	ldi a,(hl)		; $4145
	adc d			; $4146
	ld d,a			; $4147
	dec bc			; $4148
	ld a,b			; $4149
	or c			; $414a
	jr nz,_label_07_007	; $414b
	pop hl			; $414d
	ret			; $414e
	ld c,$00		; $414f
	jr _label_07_008		; $4151
	ld c,$03		; $4153
_label_07_008:
	push hl			; $4155
	ldh a,(<hActiveFileSlot)	; $4156
	add c			; $4158
	ld hl,$4162		; $4159
	rst_addDoubleIndex			; $415c
	ldi a,(hl)		; $415d
	ld b,(hl)		; $415e
	ld c,a			; $415f
	pop hl			; $4160
	ret			; $4161
	stop			; $4162
	and b			; $4163
	ld h,b			; $4164
	and l			; $4165
	or b			; $4166
	xor d			; $4167
	nop			; $4168
	or b			; $4169
	ld d,b			; $416a
	or l			; $416b
	and b			; $416c
	cp d			; $416d
	ld d,$c6		; $416e
_label_07_009:
	ldi a,(hl)		; $4170
	or a			; $4171
	jr z,_label_07_010	; $4172
	ld e,a			; $4174
	ldi a,(hl)		; $4175
	ld (de),a		; $4176
	jr _label_07_009		; $4177
_label_07_010:
	ret			; $4179
	sbc l			; $417a
	ld b,c			; $417b
	xor b			; $417c
	ld b,c			; $417d
	and c			; $417e
	ld b,c			; $417f
	xor b			; $4180
	ld b,c			; $4181
	add hl,hl		; $4182
	ld (bc),a		; $4183
	ld ($0701),sp		; $4184
	nop			; $4187
	ld c,$00		; $4188
	sub d			; $418a
	inc b			; $418b
	xor e			; $418c
	stop			; $418d
	and d			; $418e
	stop			; $418f
	and e			; $4190
	stop			; $4191
	dec hl			; $4192
	nop			; $4193
	inc l			; $4194
	and a			; $4195
	cpl			; $4196
	jr c,_label_07_011	; $4197
	ld c,b			; $4199
	ld l,$02		; $419a
	nop			; $419c
	and d			; $419d
	inc c			; $419e
	and e			; $419f
	inc c			; $41a0
	rrca			; $41a1
	nop			; $41a2
	xor c			; $41a3
	ld bc,$0b10		; $41a4
	nop			; $41a7
	xor h			; $41a8
	ld bc,$01a9		; $41a9
	add d			; $41ac
	dec b			; $41ad
	sub d			; $41ae
	inc h			; $41af
	nop			; $41b0
	ld e,d			; $41b1
	ld sp,$3231		; $41b2
	ld sp,$2d36		; $41b5
	jr nc,-$06		; $41b8
	ld ($87d0),sp		; $41ba
	add a			; $41bd
	ld hl,$4219		; $41be
	rst_addAToHl			; $41c1
	ld de,$cc8a		; $41c2
	ld a,($d00b)		; $41c5
	add (hl)		; $41c8
_label_07_011:
	ld (de),a		; $41c9
	inc hl			; $41ca
	inc e			; $41cb
	ld a,($d00d)		; $41cc
	add (hl)		; $41cf
	ld (de),a		; $41d0
	inc hl			; $41d1
	inc e			; $41d2
	ldi a,(hl)		; $41d3
	ld (de),a		; $41d4
	inc e			; $41d5
	ldi a,(hl)		; $41d6
	ld (de),a		; $41d7
	ld a,$80		; $41d8
	ldh (<hActiveObjectType),a	; $41da
	ld d,$d0		; $41dc
	ld a,d			; $41de
_label_07_012:
	ldh (<hActiveObject),a	; $41df
	ld h,d			; $41e1
	ld l,$a4		; $41e2
	bit 7,(hl)		; $41e4
	jr z,_label_07_013	; $41e6
	ld a,(hl)		; $41e8
	ld l,$aa		; $41e9
	bit 7,(hl)		; $41eb
	call z,$4233		; $41ed
_label_07_013:
	inc d			; $41f0
	ld a,d			; $41f1
	cp $e0			; $41f2
	jr c,_label_07_012	; $41f4
	ld a,$c0		; $41f6
	ldh (<hActiveObjectType),a	; $41f8
	ld d,$d0		; $41fa
	ld a,d			; $41fc
_label_07_014:
	ldh (<hActiveObject),a	; $41fd
	ld h,d			; $41ff
	ld l,$e4		; $4200
	bit 7,(hl)		; $4202
	jr z,_label_07_015	; $4204
	ld l,$ea		; $4206
	bit 7,(hl)		; $4208
	jr nz,_label_07_015	; $420a
	inc l			; $420c
	ld a,(hl)		; $420d
	or a			; $420e
	call z,$4229		; $420f
_label_07_015:
	inc d			; $4212
	ld a,d			; $4213
	cp $e0			; $4214
	jr c,_label_07_014	; $4216
	ret			; $4218
	ld sp,hl		; $4219
	ld bc,$0601		; $421a
	nop			; $421d
	ld b,$07		; $421e
	ld bc,$ff06		; $4220
	ld bc,$0006		; $4223
	ld sp,hl		; $4226
	rlca			; $4227
	.db $01

_partCheckCollisions:
	ld e,$e4		; $4229
	ld a,(de)		; $422b
	ld hl,$6940		; $422c
	ld e,$cb		; $422f
	jr ++			; $4231


_enemyCheckCollisions:
	ld hl,$6740		; $4233
	ld e,$8b		; $4236
++
	add a			; $4238
	ld c,a			; $4239
	ld b,$00		; $423a
	add hl,bc		; $423c
	add hl,bc		; $423d
	ld a,l			; $423e
	ldh (<hFF92),a	; $423f
	ld a,h			; $4241
	ldh (<hFF93),a	; $4242
	ld h,d			; $4244
	ld l,e			; $4245
	ldi a,(hl)		; $4246
	ldh (<hFF8F),a	; $4247
	inc l			; $4249
	ldi a,(hl)		; $424a
	ldh (<hFF8E),a	; $424b
	inc l			; $424d
	ld a,(hl)		; $424e
	ldh (<hFF91),a	; $424f
	ld a,l			; $4251
	add $1c			; $4252
	ld l,a			; $4254
	ld a,(hl)		; $4255
	or a			; $4256
	jr nz,_label_07_020	; $4257
	ld h,$d6		; $4259
_label_07_017:
	ld l,$24		; $425b
	ld a,(hl)		; $425d
	bit 7,a			; $425e
	jr z,_label_07_019	; $4260
	and $7f			; $4262
	ldh (<hFF90),a	; $4264
	ld b,a			; $4266
	ld e,h			; $4267
	ldh a,(<hFF92)	; $4268
	ld l,a			; $426a
	ldh a,(<hFF93)	; $426b
	ld h,a			; $426d
	ld a,b			; $426e
	call $4313		; $426f
	ld h,e			; $4272
	jr z,_label_07_019	; $4273
	ld bc,$0e07		; $4275
	ldh a,(<hFF90)	; $4278
	cp $17			; $427a
	jr nz,_label_07_018	; $427c
	ld l,$26		; $427e
	ld a,(hl)		; $4280
	ld c,a			; $4281
	add a			; $4282
	ld b,a			; $4283
_label_07_018:
	ld l,$0f		; $4284
	ldh a,(<hFF91)	; $4286
	sub (hl)		; $4288
	add c			; $4289
	cp b			; $428a
	jr nc,_label_07_019	; $428b
	ld l,$0b		; $428d
	ld b,(hl)		; $428f
	ld l,$0d		; $4290
	ld c,(hl)		; $4292
	ld l,$26		; $4293
	ldh a,(<hActiveObjectType)	; $4295
	add $26			; $4297
	ld e,a			; $4299
	call checkObjectsCollidedFromVariables		; $429a
	jp c,$4329		; $429d
_label_07_019:
	inc h			; $42a0
	ld a,h			; $42a1
	cp $de			; $42a2
	jr c,_label_07_017	; $42a4
_label_07_020:
	call checkLinkVulnerable		; $42a6
	ret nc			; $42a9
	ld l,$0f		; $42aa
	ldh a,(<hFF91)	; $42ac
	sub (hl)		; $42ae
	add $07			; $42af
	cp $0e			; $42b1
	ret nc			; $42b3
	ld a,($cc89)		; $42b4
	or a			; $42b7
	jr z,_label_07_021	; $42b8
	ldh (<hFF90),a	; $42ba
	ldh a,(<hFF92)	; $42bc
	ld l,a			; $42be
	ldh a,(<hFF93)	; $42bf
	ld h,a			; $42c1
	ldh a,(<hFF90)	; $42c2
	call $4313		; $42c4
	jr z,_label_07_021	; $42c7
	ld hl,$cc8a		; $42c9
	ldi a,(hl)		; $42cc
	ld b,a			; $42cd
	ldi a,(hl)		; $42ce
	ld c,a			; $42cf
	ldh a,(<hActiveObjectType)	; $42d0
	add $26			; $42d2
	ld e,a			; $42d4
	call checkObjectsCollidedFromVariables		; $42d5
	ld hl,$d000		; $42d8
	jp c,$4329		; $42db
_label_07_021:
	ldh a,(<hActiveObjectType)	; $42de
	add $2e			; $42e0
	ld e,a			; $42e2
	ld a,(de)		; $42e3
	or a			; $42e4
	ret nz			; $42e5
	ld a,($cc48)		; $42e6
	ld h,a			; $42e9
	ld e,a			; $42ea
	ld l,$24		; $42eb
	ld a,(hl)		; $42ed
	and $7f			; $42ee
	ldh (<hFF90),a	; $42f0
	ldh a,(<hFF92)	; $42f2
	ld l,a			; $42f4
	ldh a,(<hFF93)	; $42f5
	ld h,a			; $42f7
	ldh a,(<hFF90)	; $42f8
	call $4313		; $42fa
	ret z			; $42fd
	ld h,e			; $42fe
	ld l,$0b		; $42ff
	ld b,(hl)		; $4301
	ld l,$0d		; $4302
	ld c,(hl)		; $4304
	ld l,$26		; $4305
	ldh a,(<hActiveObjectType)	; $4307
	add $26			; $4309
	ld e,a			; $430b
	call checkObjectsCollidedFromVariables		; $430c
	jp c,$4329		; $430f
	ret			; $4312
	ld b,a			; $4313
	and $f8			; $4314
	rlca			; $4316
	swap a			; $4317
	ld c,a			; $4319
	ld a,b			; $431a
	and $07			; $431b
	ld b,$00		; $431d
	add hl,bc		; $431f
	ld c,(hl)		; $4320
	ld hl,bitTable		; $4321
	add l			; $4324
	ld l,a			; $4325
	ld a,(hl)		; $4326
	and c			; $4327
	ret			; $4328
	ld a,l			; $4329
	and $c0			; $432a
	ld l,a			; $432c
	push hl			; $432d
	ld a,$d6		; $432e
	cp h			; $4330
	jr nz,_label_07_022	; $4331
	ld a,($d00b)		; $4333
	ld b,a			; $4336
	ld a,($d00d)		; $4337
	jr _label_07_023		; $433a
_label_07_022:
	ldh a,(<hFF8D)	; $433c
	ld b,a			; $433e
	ldh a,(<hFF8C)	; $433f
_label_07_023:
	ld c,a			; $4341
	call objectGetRelativeAngleWithTempVars		; $4342
	ldh (<hFF8A),a	; $4345
	ldh a,(<hActiveObjectType)	; $4347
	add $25			; $4349
	ld e,a			; $434b
	ld a,(de)		; $434c
	add a			; $434d
	call multiplyABy16		; $434e
	ld hl,spriteCollisionReactionSets		; $4351
	add hl,bc		; $4354
	pop bc			; $4355
	ldh a,(<hFF90)	; $4356
	rst_addAToHl			; $4358
	ld a,(hl)		; $4359
	rst_jumpTable			; $435a

.DB $db				; $435b
	ld b,e			; $435c
	ld c,$44		; $435d
	ld (de),a		; $435f
	ld b,h			; $4360
	ld d,$44		; $4361
	ld a,(de)		; $4363
	ld b,h			; $4364
	ld l,e			; $4365
	ld b,h			; $4366
	ld (hl),b		; $4367
	ld b,h			; $4368
	ld (hl),l		; $4369
	ld b,h			; $436a
	inc h			; $436b
	ld b,h			; $436c
	jr z,_label_07_024	; $436d
	inc l			; $436f
	ld b,h			; $4370
	jr nc,_label_07_025	; $4371
	ld c,h			; $4373
	ld b,h			; $4374
	ld d,e			; $4375
	ld b,h			; $4376
	ld e,d			; $4377
	ld b,h			; $4378
	ld a,l			; $4379
	ld b,h			; $437a
	add l			; $437b
	ld b,h			; $437c
	and l			; $437d
	ld b,h			; $437e
	ld c,c			; $437f
	ld b,h			; $4380
	ld d,b			; $4381
	ld b,h			; $4382
	ld d,a			; $4383
	ld b,h			; $4384
	adc d			; $4385
	ld b,h			; $4386
	sub d			; $4387
	ld b,h			; $4388
	sbc d			; $4389
	ld b,h			; $438a
	ld a,d			; $438b
	ld b,h			; $438c
	add d			; $438d
	ld b,h			; $438e
	and d			; $438f
	ld b,h			; $4390
	xor d			; $4391
	ld b,h			; $4392
	inc (hl)		; $4393
	ld b,l			; $4394
	or d			; $4395
	ld b,h			; $4396
	or a			; $4397
	ld b,h			; $4398
	cp h			; $4399
	ld b,h			; $439a
	pop bc			; $439b
	ld b,h			; $439c
	jr c,$44		; $439d
	sub $44			; $439f
	ld l,h			; $43a1
	ld b,l			; $43a2
	ld (hl),l		; $43a3
	ld b,l			; $43a4
	adc l			; $43a5
	ld b,l			; $43a6
.DB $e3				; $43a7
	ld b,h			; $43a8
	add sp,$44		; $43a9
	ld sp,hl		; $43ab
	ld b,h			; $43ac
	sbc h			; $43ad
	ld b,l			; $43ae
.DB $ec				; $43af
	ld b,l			; $43b0
	jr nz,$45		; $43b1
_label_07_024:
	dec h			; $43b3
	ld b,l			; $43b4
	ld (bc),a		; $43b5
	ld b,(hl)		; $43b6
_label_07_025:
	add hl,sp		; $43b7
	ld b,l			; $43b8
	ldi a,(hl)		; $43b9
	ld b,l			; $43ba
	cpl			; $43bb
	ld b,l			; $43bc
	ld ($0d46),sp		; $43bd
	ld b,(hl)		; $43c0
	ld (de),a		; $43c1
	ld b,(hl)		; $43c2
	dec de			; $43c3
	ld b,(hl)		; $43c4
	dec hl			; $43c5
	ld b,(hl)		; $43c6
	ccf			; $43c7
	ld b,(hl)		; $43c8
	ld a,e			; $43c9
	ld b,(hl)		; $43ca
	sbc (hl)		; $43cb
	ld b,(hl)		; $43cc
	or l			; $43cd
	ld b,(hl)		; $43ce
	rlca			; $43cf
	ld b,l			; $43d0
	or (hl)			; $43d1
	ld b,(hl)		; $43d2
	call c,$0c43		; $43d3
	ld b,l			; $43d6
	ret nz			; $43d7
	ld b,(hl)		; $43d8
	pop bc			; $43d9
	ld b,(hl)		; $43da
	ret			; $43db
	ldh a,(<hActiveObjectType)	; $43dc
	inc a			; $43de
	ld e,a			; $43df
	ld a,(de)		; $43e0
	ld c,a			; $43e1
	ld hl,$4405		; $43e2
_label_07_026:
	ldi a,(hl)		; $43e5
	or a			; $43e6
	jr z,_label_07_027	; $43e7
	cp c			; $43e9
	ldi a,(hl)		; $43ea
	jr nz,_label_07_026	; $43eb
	ld c,a			; $43ed
	and $7f			; $43ee
	call cpActiveRing		; $43f0
	jr nz,_label_07_027	; $43f3
	bit 7,c			; $43f5
	ld a,$40		; $43f7
	jp z,$46ef		; $43f9
	call $4412		; $43fc
	ld h,b			; $43ff
	ld l,$25		; $4400
	sra (hl)		; $4402
	ret			; $4404
	ld c,$9a		; $4405
	jr $20			; $4407
	add hl,de		; $4409
	rra			; $440a
	add hl,hl		; $440b
	sbc e			; $440c
	nop			; $440d
	ld e,$00		; $440e
	jr _label_07_028		; $4410
_label_07_027:
	ld e,$04		; $4412
	jr _label_07_028		; $4414
	ld e,$08		; $4416
	jr _label_07_028		; $4418
	ld e,$0c		; $441a
_label_07_028:
	call $47c7		; $441c
	ld a,$1c		; $441f
	jp $46ef		; $4421
	ld e,$00		; $4424
	jr _label_07_029		; $4426
	ld e,$04		; $4428
	jr _label_07_029		; $442a
	ld e,$08		; $442c
	jr _label_07_029		; $442e
	call $479f		; $4430
	ret z			; $4433
	ld e,$0c		; $4434
	jr _label_07_029		; $4436
	ld e,$30		; $4438
_label_07_029:
	ldh a,(<hActiveObjectType)	; $443a
	add $3e			; $443c
	ld l,a			; $443e
	ld h,d			; $443f
	ld c,$2a		; $4440
	ld a,(bc)		; $4442
	or (hl)			; $4443
	ld (bc),a		; $4444
	ld a,e			; $4445
	jp $46ef		; $4446
	call $46cf		; $4449
	ld e,$10		; $444c
	jr _label_07_030		; $444e
	call $46cf		; $4450
	ld e,$14		; $4453
	jr _label_07_030		; $4455
	call $46cf		; $4457
	ld e,$18		; $445a
_label_07_030:
	ldh a,(<hActiveObjectType)	; $445c
	add $3e			; $445e
	ld l,a			; $4460
	ld h,d			; $4461
	ld c,$2a		; $4462
	ld a,(bc)		; $4464
	or (hl)			; $4465
	ld (bc),a		; $4466
	ld a,e			; $4467
	jp $46ef		; $4468
	ld hl,$101c		; $446b
	jr _label_07_032		; $446e
	ld hl,$141c		; $4470
	jr _label_07_032		; $4473
	ld hl,$181c		; $4475
	jr _label_07_032		; $4478
	call $46cf		; $447a
	ld hl,$1010		; $447d
	jr _label_07_032		; $4480
	call $46cf		; $4482
	ld hl,setTileInRoomLayoutBuffer		; $4485
	jr _label_07_032		; $4488
	call $46cf		; $448a
	ld hl,$1034		; $448d
	jr _label_07_032		; $4490
	call $46cf		; $4492
	ld hl,$1434		; $4495
	jr _label_07_032		; $4498
	call $46cf		; $449a
	ld hl,$1834		; $449d
	jr _label_07_032		; $44a0
	call $46cf		; $44a2
	ld hl,$1818		; $44a5
	jr _label_07_032		; $44a8
	call $46cf		; $44aa
	ld hl,$1c28		; $44ad
	jr _label_07_032		; $44b0
	ld hl,$0c04		; $44b2
	jr _label_07_032		; $44b5
	ld hl,$2834		; $44b7
	jr _label_07_032		; $44ba
	ld hl,$2034		; $44bc
	jr _label_07_032		; $44bf
	ld h,b			; $44c1
	ld l,$01		; $44c2
	ld a,(hl)		; $44c4
	cp $28			; $44c5
	jr nc,_label_07_031	; $44c7
	ld l,$24		; $44c9
	res 7,(hl)		; $44cb
_label_07_031:
	call $479f		; $44cd
	ret z			; $44d0
	ld hl,$2444		; $44d1
	jr _label_07_032		; $44d4
	ld hl,$1c24		; $44d6
_label_07_032:
	ld a,h			; $44d9
	push hl			; $44da
	call $47c8		; $44db
	pop hl			; $44de
	ld a,l			; $44df
	jp $46ef		; $44e0
	ld hl,$1c34		; $44e3
	jr _label_07_032		; $44e6
	ld h,b			; $44e8
	ld l,$24		; $44e9
	res 7,(hl)		; $44eb
	call $479f		; $44ed
	ret z			; $44f0
	call $46c2		; $44f1
	ld hl,$1c2c		; $44f4
	jr _label_07_032		; $44f7
	ld h,b			; $44f9
	ld l,$24		; $44fa
	res 7,(hl)		; $44fc
	call $479f		; $44fe
	ret z			; $4501
	ld hl,$1c38		; $4502
	jr _label_07_032		; $4505
	ld e,$ad		; $4507
	ld a,(de)		; $4509
	or a			; $450a
	ret nz			; $450b
	ld a,($d001)		; $450c
	or a			; $450f
	ret nz			; $4510
	ld a,($cc88)		; $4511
	or a			; $4514
	ret nz			; $4515
	ld a,$0d		; $4516
	ld ($cc6a),a		; $4518
	ld hl,$2c1c		; $451b
	jr _label_07_032		; $451e
	ld hl,$1c3c		; $4520
	jr _label_07_032		; $4523
	ld hl,$1430		; $4525
	jr _label_07_032		; $4528
	ld hl,$3004		; $452a
	jr _label_07_032		; $452d
	ld hl,$1c44		; $452f
	jr _label_07_032		; $4532
_label_07_033:
	ld hl,$1c1c		; $4534
	jr _label_07_032		; $4537
	ld h,d			; $4539
	ldh a,(<hActiveObjectType)	; $453a
	add $29			; $453c
	ld l,a			; $453e
	ld a,(hl)		; $453f
	or a			; $4540
	jr z,_label_07_033	; $4541
	ld a,l			; $4543
	add $05			; $4544
	ld l,a			; $4546
	xor a			; $4547
	ldd (hl),a		; $4548
	ldd (hl),a		; $4549
	ldh a,(<hFF8A)	; $454a
	xor $10			; $454c
	ld (hl),a		; $454e
	res 3,l			; $454f
	res 7,(hl)		; $4551
	ld a,l			; $4553
	add $e0			; $4554
	ld l,a			; $4556
	ld (hl),$03		; $4557
	inc l			; $4559
	ld (hl),$00		; $455a
	ld h,b			; $455c
	ld l,$2a		; $455d
	set 5,(hl)		; $455f
	ld l,$24		; $4561
	res 7,(hl)		; $4563
	ld l,$18		; $4565
	ldh a,(<hActiveObjectType)	; $4567
	ldi (hl),a		; $4569
	ld (hl),d		; $456a
	ret			; $456b
	ldh a,(<hActiveObjectType)	; $456c
	add $29			; $456e
	ld l,a			; $4570
	ld h,d			; $4571
	ld (hl),$00		; $4572
	ret			; $4574
	ldh a,(<hActiveObjectType)	; $4575
	add $2a			; $4577
	ld e,a			; $4579
	ldh a,(<hFF90)	; $457a
	or $80			; $457c
	ld (de),a		; $457e
	ld a,e			; $457f
	add $ec			; $4580
	ld l,a			; $4582
	ld h,d			; $4583
	ld (hl),c		; $4584
	inc l			; $4585
	ld (hl),b		; $4586
	ld c,$2a		; $4587
	ld a,$01		; $4589
	ld (bc),a		; $458b
	ret			; $458c
	call $4631		; $458d
	ld a,l			; $4590
	add $1b			; $4591
	ld l,a			; $4593
	set 7,(hl)		; $4594
	ld c,$2a		; $4596
	ld a,$02		; $4598
	ld (bc),a		; $459a
	ret			; $459b
	ld h,b			; $459c
	ld l,$24		; $459d
	res 7,(hl)		; $459f
	call $479f		; $45a1
	ret z			; $45a4
	ld h,d			; $45a5
	ld l,$aa		; $45a6
	ld (hl),$9e		; $45a8
	ld l,$ae		; $45aa
	ld (hl),$00		; $45ac
	ld l,$a4		; $45ae
	res 7,(hl)		; $45b0
	ld l,$84		; $45b2
	ld (hl),$05		; $45b4
	ld l,$9a		; $45b6
	ld a,(hl)		; $45b8
	and $c0			; $45b9
	or $02			; $45bb
	ld (hl),a		; $45bd
	ld l,$87		; $45be
	ld (hl),$1e		; $45c0
	ld l,$90		; $45c2
	ld (hl),$05		; $45c4
	ld l,$94		; $45c6
	ld (hl),$00		; $45c8
	inc l			; $45ca
	ld (hl),$fa		; $45cb
	ld l,$8b		; $45cd
	ld c,$0b		; $45cf
	ld a,(bc)		; $45d1
	ldi (hl),a		; $45d2
	inc l			; $45d3
	ld c,$0d		; $45d4
	ld a,(bc)		; $45d6
	ldi (hl),a		; $45d7
	inc l			; $45d8
	ld a,(hl)		; $45d9
	rlca			; $45da
	jr c,_label_07_034	; $45db
	ld (hl),$ff		; $45dd
_label_07_034:
	call getRandomNumber		; $45df
	and $18			; $45e2
	ld e,$89		; $45e4
	ld (de),a		; $45e6
	ld a,$1c		; $45e7
	jp $47c8		; $45e9
	ld h,b			; $45ec
	ld l,$2d		; $45ed
	ld a,d			; $45ef
	cp (hl)			; $45f0
	ret z			; $45f1
	ldd (hl),a		; $45f2
	ld e,$e1		; $45f3
	ld a,(de)		; $45f5
	ldd (hl),a		; $45f6
	dec l			; $45f7
	set 4,(hl)		; $45f8
	ld e,$ea		; $45fa
	ldh a,(<hFF90)	; $45fc
	or $80			; $45fe
	ld (de),a		; $4600
	ret			; $4601
	ld h,b			; $4602
	ld l,$2f		; $4603
	set 5,(hl)		; $4605
	ret			; $4607
	ld a,$34		; $4608
	jp $46ef		; $460a
	ld hl,$3448		; $460d
	jr _label_07_035		; $4610
	ld hl,$384c		; $4612
_label_07_035:
	call $44d9		; $4615
	jp $46cf		; $4618
	call $46c2		; $461b
	ld h,b			; $461e
	ld l,$24		; $461f
	res 7,(hl)		; $4621
	ld hl,$1c2c		; $4623
	call $44d9		; $4626
	jr _label_07_036		; $4629
	ld hl,$1c1c		; $462b
	call $44d9		; $462e
_label_07_036:
	ld h,d			; $4631
	ldh a,(<hActiveObjectType)	; $4632
	add $29			; $4634
	ld l,a			; $4636
	ld (hl),$00		; $4637
	add $fb			; $4639
	ld l,a			; $463b
	res 7,(hl)		; $463c
	ret			; $463e
	ld h,d			; $463f
	ldh a,(<hActiveObjectType)	; $4640
	add $2a			; $4642
	ld l,a			; $4644
	ld (hl),$a0		; $4645
	add $fa			; $4647
	ld l,a			; $4649
	res 7,(hl)		; $464a
	ld a,$1e		; $464c
	call cpActiveRing		; $464e
	ld a,$f8		; $4651
	jr nz,_label_07_037	; $4653
	xor a			; $4655
_label_07_037:
	ld hl,$d025		; $4656
	ld (hl),a		; $4659
	ld l,$2c		; $465a
	ldh a,(<hFF8A)	; $465c
	ld (hl),a		; $465e
	ld l,$2d		; $465f
	ld (hl),$08		; $4661
	ld l,$2b		; $4663
	ld (hl),$0c		; $4665
	ld a,($ccf2)		; $4667
	or a			; $466a
	jr nz,_label_07_038	; $466b
	inc a			; $466d
	ld ($ccf2),a		; $466e
_label_07_038:
	ld h,b			; $4671
	ld l,$24		; $4672
	res 7,(hl)		; $4674
	ld a,$1c		; $4676
	jp $47c8		; $4678
	ldh a,(<hActiveObjectType)	; $467b
	add $2b			; $467d
	ld e,a			; $467f
	ld a,(de)		; $4680
	or a			; $4681
	ret nz			; $4682
	ld a,($cc88)		; $4683
	or a			; $4686
	ret nz			; $4687
	ld a,($d004)		; $4688
	cp $01			; $468b
	ret nz			; $468d
	ld a,e			; $468e
	add $f9			; $468f
	ld e,a			; $4691
	xor a			; $4692
	ld (de),a		; $4693
	ld a,$0c		; $4694
	ld ($cc6a),a		; $4696
	ld a,$1c		; $4699
	jp $46ef		; $469b
	ld h,d			; $469e
	ldh a,(<hActiveObjectType)	; $469f
	add $24			; $46a1
	ld l,a			; $46a3
	res 7,(hl)		; $46a4
	add $e2			; $46a6
	ld l,a			; $46a8
	ld (hl),$60		; $46a9
	add $09			; $46ab
	ld l,a			; $46ad
	ld (hl),$00		; $46ae
	ld a,$1c		; $46b0
	jp $46ef		; $46b2
	ret			; $46b5
	ld a,$02		; $46b6
	call setLinkIDOverride		; $46b8
	ld a,$1c		; $46bb
	jp $46ef		; $46bd
	ret			; $46c0
	ret			; $46c1
	call getFreePartSlot		; $46c2
	ret nz			; $46c5
	ld (hl),$12		; $46c6
	ld l,$d6		; $46c8
	ldh a,(<hActiveObjectType)	; $46ca
	ldi (hl),a		; $46cc
	ld (hl),d		; $46cd
	ret			; $46ce
	call getFreeInteractionSlot		; $46cf
	jr nz,_label_07_039	; $46d2
	ld (hl),$07		; $46d4
	ldh a,(<hFF8F)	; $46d6
	ld l,a			; $46d8
	ldh a,(<hFF8D)	; $46d9
	sub l			; $46db
	sra a			; $46dc
	add l			; $46de
	ld l,$4b		; $46df
	ldi (hl),a		; $46e1
	ldh a,(<hFF8E)	; $46e2
	ld l,a			; $46e4
	ldh a,(<hFF8C)	; $46e5
	sub l			; $46e7
	sra a			; $46e8
	add l			; $46ea
	ld l,$4d		; $46eb
	ld (hl),a		; $46ed
_label_07_039:
	ret			; $46ee
	ld hl,$4747		; $46ef
	rst_addAToHl			; $46f2
	ldh a,(<hActiveObjectType)	; $46f3
	add $29			; $46f5
	ld e,a			; $46f7
	bit 7,(hl)		; $46f8
	jr z,_label_07_041	; $46fa
	ld c,$28		; $46fc
	ld a,(bc)		; $46fe
	ld c,a			; $46ff
	ld a,(de)		; $4700
	add c			; $4701
	jr c,_label_07_040	; $4702
	xor a			; $4704
_label_07_040:
	ld (de),a		; $4705
	jr nz,_label_07_041	; $4706
	ld c,e			; $4708
	ld a,e			; $4709
	add $fb			; $470a
	ld e,a			; $470c
	ld a,(de)		; $470d
	res 7,a			; $470e
	ld (de),a		; $4710
	ld e,c			; $4711
_label_07_041:
	inc e			; $4712
	ldi a,(hl)		; $4713
	ld c,a			; $4714
	bit 6,c			; $4715
	jr z,_label_07_042	; $4717
	ldh a,(<hFF90)	; $4719
	or $80			; $471b
	ld (de),a		; $471d
_label_07_042:
	inc e			; $471e
	ldi a,(hl)		; $471f
	bit 5,c			; $4720
	jr z,_label_07_043	; $4722
	ld (de),a		; $4724
_label_07_043:
	inc e			; $4725
	inc e			; $4726
	bit 4,c			; $4727
	ldi a,(hl)		; $4729
	jr z,_label_07_044	; $472a
	ld (de),a		; $472c
	ldh a,(<hFF8A)	; $472d
	xor $10			; $472f
	dec e			; $4731
	ld (de),a		; $4732
	inc e			; $4733
_label_07_044:
	inc e			; $4734
	ldi a,(hl)		; $4735
	bit 3,c			; $4736
	jr z,_label_07_045	; $4738
	ld (de),a		; $473a
_label_07_045:
	ld a,c			; $473b
	and $07			; $473c
	ret z			; $473e
	ld hl,$4797		; $473f
	rst_addAToHl			; $4742
	ld a,(hl)		; $4743
	jp playSound		; $4744
	pop af			; $4747
	stop			; $4748
	ld ($f100),sp		; $4749
	dec d			; $474c
	dec bc			; $474d
	nop			; $474e
	pop af			; $474f
	ld a,(de)		; $4750
	rrca			; $4751
	nop			; $4752
	pop af			; $4753
	jr nz,_label_07_046	; $4754
_label_07_046:
	nop			; $4756
	ld (hl),b		; $4757
	ld a,($ff00+$08)	; $4758
	nop			; $475a
	ld (hl),b		; $475b
.DB $eb				; $475c
	dec bc			; $475d
	nop			; $475e
	ld (hl),b		; $475f
	and $0f			; $4760
	nop			; $4762
	ld b,b			; $4763
	nop			; $4764
	nop			; $4765
	nop			; $4766
	pop hl			; $4767
	jr nz,_label_07_047	; $4768
_label_07_047:
	nop			; $476a
	add hl,hl		; $476b
	ld a,($ff00+$00)	; $476c
	ld a,b			; $476e
	ld h,b			; $476f
.DB $ec				; $4770
	nop			; $4771
	nop			; $4772
	add sp,-$5a		; $4773
	nop			; $4775
	ld e,d			; $4776
	ld a,($ff00+c)		; $4777
	jr nz,_label_07_048	; $4778
_label_07_048:
	nop			; $477a
	ld h,b			; $477b
.DB $e4				; $477c
	nop			; $477d
	nop			; $477e
	add hl,hl		; $477f
	ld a,($ff00+$00)	; $4780
	ld a,($ff00+$a9)	; $4782
	jr _label_07_049		; $4784
_label_07_049:
	ld a,b			; $4786
.DB $e3				; $4787
	jr nz,_label_07_050	; $4788
_label_07_050:
	nop			; $478a
	ld d,b			; $478b
	nop			; $478c
	nop			; $478d
	nop			; $478e
	ld (hl),b		; $478f
	rst $30			; $4790
	rlca			; $4791
	nop			; $4792
	ld (hl),b		; $4793
	push af			; $4794
	add hl,bc		; $4795
	nop			; $4796
	nop			; $4797
	ld c,(hl)		; $4798
	ld h,e			; $4799
	ld e,b			; $479a
	nop			; $479b
	nop			; $479c
	nop			; $479d
	nop			; $479e
	ld c,$01		; $479f
	ld a,(bc)		; $47a1
	cp $24			; $47a2
	ret nz			; $47a4
	ldh a,(<hActiveObjectType)	; $47a5
	add $3f			; $47a7
	ld e,a			; $47a9
	ld a,(de)		; $47aa
	cpl			; $47ab
	bit 5,a			; $47ac
	ret nz			; $47ae
	ld h,b			; $47af
	ld l,$2a		; $47b0
	ld (hl),$40		; $47b2
	ld l,$24		; $47b4
	res 7,(hl)		; $47b6
	ldh a,(<hActiveObjectType)	; $47b8
	add $2a			; $47ba
	ld e,a			; $47bc
	ld a,$9a		; $47bd
	ld (de),a		; $47bf
	ld a,e			; $47c0
	add $04			; $47c1
	ld e,a			; $47c3
	xor a			; $47c4
	ld (de),a		; $47c5
	ret			; $47c6
	ld a,e			; $47c7
	push af			; $47c8
	ldh a,(<hActiveObjectType)	; $47c9
	add $3e			; $47cb
	ld e,a			; $47cd
	ld a,(de)		; $47ce
	ld ($cec0),a		; $47cf
	pop af			; $47d2
	ld hl,$4816		; $47d3
	rst_addAToHl			; $47d6
	bit 7,(hl)		; $47d7
	jr z,_label_07_051	; $47d9
	ldh a,(<hActiveObjectType)	; $47db
	add $28			; $47dd
	ld e,a			; $47df
	ld a,(de)		; $47e0
	ld c,$25		; $47e1
	ld (bc),a		; $47e3
_label_07_051:
	ldi a,(hl)		; $47e4
	ld e,a			; $47e5
	ld c,$2a		; $47e6
	ld a,(bc)		; $47e8
	ld c,a			; $47e9
	ld a,($cec0)		; $47ea
	or c			; $47ed
	ld c,$2a		; $47ee
	ld (bc),a		; $47f0
	inc c			; $47f1
	ldi a,(hl)		; $47f2
	bit 5,e			; $47f3
	jr z,_label_07_052	; $47f5
	ld (bc),a		; $47f7
_label_07_052:
	inc c			; $47f8
	ldh a,(<hFF8A)	; $47f9
	ld (bc),a		; $47fb
	inc c			; $47fc
	ldi a,(hl)		; $47fd
	bit 4,e			; $47fe
	jr z,_label_07_053	; $4800
	ld (bc),a		; $4802
_label_07_053:
	inc c			; $4803
	ldi a,(hl)		; $4804
	bit 4,e			; $4805
	jr z,_label_07_054	; $4807
	ld (bc),a		; $4809
_label_07_054:
	ld a,e			; $480a
	and $07			; $480b
	ret z			; $480d
	ld hl,$4852		; $480e
	rst_addAToHl			; $4811
	ld a,(hl)		; $4812
	jp playSound		; $4813
	or d			; $4816
	add hl,de		; $4817
	rlca			; $4818
	nop			; $4819
	or d			; $481a
	ldi (hl),a		; $481b
	rrca			; $481c
	nop			; $481d
	or d			; $481e
	ldi a,(hl)		; $481f
	dec d			; $4820
	nop			; $4821
	or d			; $4822
	jr nz,_label_07_055	; $4823
_label_07_055:
	nop			; $4825
	ld sp,$0bf8		; $4826
	nop			; $4829
	ld sp,$13f1		; $482a
	nop			; $482d
	ld sp,$19ea		; $482e
	nop			; $4831
	ld b,b			; $4832
	nop			; $4833
	nop			; $4834
	nop			; $4835
	inc bc			; $4836
	nop			; $4837
	nop			; $4838
	nop			; $4839
	ret nz			; $483a
	nop			; $483b
	nop			; $483c
	nop			; $483d
	inc de			; $483e
	nop			; $483f
	stop			; $4840
	nop			; $4841
	ld h,d			; $4842
.DB $f4				; $4843
	nop			; $4844
	nop			; $4845
	ret nz			; $4846
	nop			; $4847
	nop			; $4848
	nop			; $4849
	ld sp,$06fa		; $484a
	nop			; $484d
	ld sp,$08f8		; $484e
	nop			; $4851
	nop			; $4852
	ld d,d			; $4853
	ld e,a			; $4854
	ld e,b			; $4855
	ld d,d			; $4856
	ld d,d			; $4857
	ld d,d			; $4858
	ld d,d			; $4859


updateItems:
	ld b,$00		; $485a
	ld a,($cd00)		; $485c
	cp $08			; $485f
	jr z,_label_07_056	; $4861
	ld a,($cca4)		; $4863
	and $90			; $4866
	jr nz,_label_07_056	; $4868
	ld a,($c4ab)		; $486a
	or a			; $486d
	jr nz,_label_07_056	; $486e
	ld a,($cba0)		; $4870
	or a			; $4873
	jr z,_label_07_057	; $4874
_label_07_056:
	inc b			; $4876
_label_07_057:
	ld hl,$cca5		; $4877
	ld a,(hl)		; $487a
	and $fe			; $487b
	or b			; $487d
	ld (hl),a		; $487e
	xor a			; $487f
	ld ($ccf0),a		; $4880
	ld a,$00		; $4883
	ldh (<hActiveObjectType),a	; $4885
	ld d,$d6		; $4887
	ld a,d			; $4889
_label_07_058:
	ldh (<hActiveObject),a	; $488a
	ld e,$00		; $488c
	ld a,(de)		; $488e
	or a			; $488f
	jr z,_label_07_060	; $4890
	ld e,$04		; $4892
	ld a,(de)		; $4894
	or a			; $4895
	jr z,_label_07_059	; $4896
	ld a,($cca5)		; $4898
	or a			; $489b
_label_07_059:
	call z,$48a6		; $489c
_label_07_060:
	inc d			; $489f
	ld a,d			; $48a0
	cp $e0			; $48a1
	jr c,_label_07_058	; $48a3
	ret			; $48a5
	ld e,$01		; $48a6
	ld a,(de)		; $48a8
	rst_jumpTable			; $48a9
	.dw itemCode00 ; 0x00
	.dw itemDelete ; 0x01
	.dw itemCode02 ; 0x02
	.dw itemCode03 ; 0x03
	.dw itemDelete ; 0x04
	.dw itemCode05 ; 0x05
	.dw itemCode06 ; 0x06
	.dw itemCode07 ; 0x07
	.dw itemCode08 ; 0x08
	.dw itemDelete ; 0x09
	.dw itemDelete ; 0x0a
	.dw itemDelete ; 0x0b
	.dw itemCode0c ; 0x0c
	.dw itemCode0d ; 0x0d
	.dw itemDelete ; 0x0e
	.dw itemDelete ; 0x0f
	.dw itemDelete ; 0x10
	.dw itemDelete ; 0x11
	.dw itemDelete ; 0x12
	.dw itemCode13 ; 0x13
	.dw itemDelete ; 0x14
	.dw itemCode15 ; 0x15
	.dw itemCode16 ; 0x16
	.dw itemDelete ; 0x17
	.dw itemDelete ; 0x18
	.dw itemDelete ; 0x19
	.dw itemCode1a ; 0x1a
	.dw itemDelete ; 0x1b
	.dw itemDelete ; 0x1c
	.dw itemCode1d ; 0x1d
	.dw itemCode1e ; 0x1e
	.dw itemDelete ; 0x1f
	.dw itemCode20 ; 0x20
	.dw itemCode21 ; 0x21
	.dw itemCode22 ; 0x22
	.dw itemCode23 ; 0x23
	.dw itemCode24 ; 0x24
	.dw itemDelete ; 0x25
	.dw itemDelete ; 0x26
	.dw itemCode27 ; 0x27
	.dw itemCode28 ; 0x28
	.dw itemCode29 ; 0x29
	.dw itemCode2a ; 0x2a
	.dw itemCode2b ; 0x2b


updateItemsPost:
	xor a
	ldh (<hActiveObjectType),a	; $4903
	ld d,$d6		; $4905
	ld a,d			; $4907
_label_07_061:
	ldh (<hActiveObject),a	; $4908
	ld e,$00		; $490a
	ld a,(de)		; $490c
	or a			; $490d
	call nz,_updateItemPost		; $490e
	inc d			; $4911
	ld a,d			; $4912
	cp $e0			; $4913
	jr c,_label_07_061	; $4915

itemCodeNilPost:
	ret			; $4917

_updateItemPost:
	ld e,$01		; $4918
	ld a,(de)		; $491a
	rst_jumpTable			; $491b
	.dw itemCode00Post  ; 0x00
	.dw itemCodeNilPost ; 0x01
	.dw itemCode02Post  ; 0x02
	.dw itemCodeNilPost ; 0x03
	.dw itemCode04Post  ; 0x04
	.dw itemCode05Post  ; 0x05
	.dw itemCodeNilPost ; 0x06
	.dw itemCode07Post  ; 0x07
	.dw itemCode08Post  ; 0x08
	.dw itemCodeNilPost ; 0x09
	.dw itemDelete      ; 0x0a
	.dw itemDelete      ; 0x0b
	.dw itemCode0cPost  ; 0x0c
	.dw itemCodeNilPost ; 0x0d
	.dw itemCodeNilPost ; 0x0e
	.dw itemDelete      ; 0x0f
	.dw itemCodeNilPost ; 0x10
	.dw itemCodeNilPost ; 0x11
	.dw itemCodeNilPost ; 0x12
	.dw itemCode13Post  ; 0x13
	.dw itemCodeNilPost ; 0x14
	.dw itemCodeNilPost ; 0x15
	.dw itemCodeNilPost ; 0x16
	.dw itemCodeNilPost ; 0x17
	.dw itemCodeNilPost ; 0x18
	.dw itemCodeNilPost ; 0x19
	.dw itemCodeNilPost ; 0x1a
	.dw itemCodeNilPost ; 0x1b
	.dw itemCodeNilPost ; 0x1c
	.dw itemCode1dPost  ; 0x1d
	.dw itemCode1ePost  ; 0x1e
	.dw itemCodeNilPost ; 0x1f
	.dw itemCodeNilPost ; 0x20
	.dw itemCodeNilPost ; 0x21
	.dw itemCodeNilPost ; 0x22
	.dw itemCodeNilPost ; 0x23
	.dw itemCodeNilPost ; 0x24
	.dw itemCodeNilPost ; 0x25
	.dw itemCodeNilPost ; 0x26
	.dw itemCodeNilPost ; 0x27
	.dw itemCodeNilPost ; 0x28
	.dw itemCodeNilPost ; 0x29
	.dw itemCodeNilPost ; 0x2a
	.dw itemCodeNilPost ; 0x2b

_loadAttributesAndGraphicsAndIncState:
	call itemIncState		; $4974
	ld l,$00		; $4977
	ld (hl),$03		; $4979

_itemLoadAttributesAndGraphics:
	ld e,$01		; $497b
	ld a,(de)		; $497d
	add a			; $497e
	ld hl,itemAttributes		; $497f
	rst_addDoubleIndex			; $4982
	ld e,$24		; $4983
	ldi a,(hl)		; $4985
	ld (de),a		; $4986
	ld e,$26		; $4987
	ld a,(hl)		; $4989
	swap a			; $498a
	and $0f			; $498c
	ld (de),a		; $498e
	inc e			; $498f
	ldi a,(hl)		; $4990
	and $0f			; $4991
	ld (de),a		; $4993
	inc e			; $4994
	ldi a,(hl)		; $4995
	ld (de),a		; $4996
	ld c,a			; $4997
	inc e			; $4998
	ldi a,(hl)		; $4999
	ld (de),a		; $499a
	ld e,$3a		; $499b
	ld a,c			; $499d
	ld (de),a		; $499e
	call $49aa		; $499f
	ld hl,$4422		; $49a2
	ld e,$3f		; $49a5
	jp interBankCall		; $49a7
	ld e,$3c		; $49aa
	ld a,$ff		; $49ac
	ld (de),a		; $49ae
	ret			; $49af
	ld h,d			; $49b0
	ld l,$25		; $49b1
	ld a,(hl)		; $49b3
	ld (hl),$00		; $49b4
	ld l,$29		; $49b6
	add (hl)		; $49b8
	ld (hl),a		; $49b9
	rlca			; $49ba
	ld l,$2a		; $49bb
	ld a,(hl)		; $49bd
	dec a			; $49be
	inc a			; $49bf
	ret			; $49c0
	ld h,d			; $49c1
	ld l,$20		; $49c2
	dec (hl)		; $49c4
	ret nz			; $49c5
	ld l,$22		; $49c6
	jr _itemNextAnimationFrame		; $49c8


itemSetAnimation:
	add a			; $49ca
	ld c,a			; $49cb
	ld b,$00		; $49cc
	ld e,$01		; $49ce
	ld a,(de)		; $49d0
	ld hl,$6401		; $49d1
	rst_addDoubleIndex			; $49d4
	ldi a,(hl)		; $49d5
	ld h,(hl)		; $49d6
	ld l,a			; $49d7
	add hl,bc		; $49d8

_itemNextAnimationFrame:
	ldi a,(hl)		; $49d9
	ld h,(hl)		; $49da
	ld l,a			; $49db
	ldi a,(hl)		; $49dc
	cp $ff			; $49dd
	jr nz,_label_07_063	; $49df
	ld b,a			; $49e1
	ld c,(hl)		; $49e2
	add hl,bc		; $49e3
	ldi a,(hl)		; $49e4
_label_07_063:
	ld e,$20		; $49e5
	ld (de),a		; $49e7
	ldi a,(hl)		; $49e8
	ld c,a			; $49e9
	ld b,$00		; $49ea
	inc e			; $49ec
	ldi a,(hl)		; $49ed
	ld (de),a		; $49ee
	inc e			; $49ef
	ld a,l			; $49f0
	ld (de),a		; $49f1
	inc e			; $49f2
	ld a,h			; $49f3
	ld (de),a		; $49f4
	ld e,$01		; $49f5
	ld a,(de)		; $49f7
	ld hl,$6461		; $49f8
	rst_addDoubleIndex			; $49fb
	ldi a,(hl)		; $49fc
	ld h,(hl)		; $49fd
	ld l,a			; $49fe
	add hl,bc		; $49ff

	; Set the address of the oam data
	ld e,$1e		; $4a00
	ldi a,(hl)		; $4a02
	ld (de),a		; $4a03
	inc e			; $4a04
	ldi a,(hl)		; $4a05
	and $3f			; $4a06
	ld (de),a		; $4a08
	ret			; $4a09

_itemTransferKnockbackToLink:
	ld h,d			; $4a0a
	ld l,$2d		; $4a0b
	ld a,(hl)		; $4a0d
	or a			; $4a0e
	ret z			; $4a0f
	ld (hl),$00		; $4a10
	dec l			; $4a12
	ld b,(hl)		; $4a13
	ld hl,$d02d		; $4a14
	cp (hl)			; $4a17
	jr c,_label_07_064	; $4a18
	ld (hl),a		; $4a1a
_label_07_064:
	dec l			; $4a1b
	ld (hl),b		; $4a1c
	ret			; $4a1d
	ld e,$08		; $4a1e
	ld a,(de)		; $4a20
	ld e,a			; $4a21
	add a			; $4a22
	add e			; $4a23
	rst_addAToHl			; $4a24
	ld e,$0b		; $4a25
	ld a,(de)		; $4a27
	add (hl)		; $4a28
	ld (de),a		; $4a29
	inc hl			; $4a2a
	ld e,$0d		; $4a2b
	ld a,(de)		; $4a2d
	add (hl)		; $4a2e
	ld (de),a		; $4a2f
	inc hl			; $4a30
	ld e,$0f		; $4a31
	ld a,(de)		; $4a33
	add (hl)		; $4a34
	ld (de),a		; $4a35
	ret			; $4a36
	ld h,d			; $4a37
	ld a,($cc50)		; $4a38
	and $20			; $4a3b
	ret z			; $4a3d
	ld e,$0b		; $4a3e
	ld l,$0f		; $4a40
	ld a,(de)		; $4a42
	add (hl)		; $4a43
	ld (de),a		; $4a44
	xor a			; $4a45
	ldd (hl),a		; $4a46
	ld (hl),a		; $4a47
	or d			; $4a48
	ret			; $4a49
	ld e,$0f		; $4a4a
	ld a,e			; $4a4c
	ldh (<hFF8B),a	; $4a4d
	ld a,(de)		; $4a4f
	rlca			; $4a50
	jr nc,_label_07_065	; $4a51
	rrca			; $4a53
	ldh (<hFF8B),a	; $4a54
	call objectUpdateSpeedZ_paramC		; $4a56
	jr nz,_label_07_066	; $4a59
	ldh (<hFF8B),a	; $4a5b
_label_07_065:
	call objectReplaceWithAnimationIfOnHazard		; $4a5d
	jr nc,_label_07_066	; $4a60
	pop hl			; $4a62
	ld a,$ff		; $4a63
	ret			; $4a65
_label_07_066:
	ldh a,(<hFF8B)	; $4a66
	rlca			; $4a68
	or a			; $4a69
	ret			; $4a6a
	ld h,d			; $4a6b
	ld l,$0f		; $4a6c
	and $80			; $4a6e
	jr nz,_label_07_067	; $4a70
	ld l,$31		; $4a72
	ld b,(hl)		; $4a74
	ldi (hl),a		; $4a75
	ld c,(hl)		; $4a76
	ldi (hl),a		; $4a77
	or b			; $4a78
	ret z			; $4a79
	push bc			; $4a7a
	call objectCheckContainsPoint		; $4a7b
	pop bc			; $4a7e
	ret c			; $4a7f
	call objectGetRelativeAngle		; $4a80
	ld c,a			; $4a83
	ld b,$0a		; $4a84
	ld e,$09		; $4a86
	call objectApplyGivenSpeed		; $4a88
_label_07_067:
	xor a			; $4a8b
	ret			; $4a8c
	call $4a37		; $4a8d
	jr nz,_label_07_070	; $4a90
	call objectUpdateSpeedZ_paramC		; $4a92
	jr nz,_label_07_068	; $4a95
	call $4b02		; $4a97
	bit 4,(hl)		; $4a9a
	set 4,(hl)		; $4a9c
	scf			; $4a9e
	ret			; $4a9f
_label_07_068:
	ld l,$3b		; $4aa0
	res 4,(hl)		; $4aa2
	or d			; $4aa4
	ret			; $4aa5
_label_07_069:
	ld h,d			; $4aa6
	ld l,$3b		; $4aa7
	bit 4,(hl)		; $4aa9
	set 4,(hl)		; $4aab
	scf			; $4aad
	ret			; $4aae
_label_07_070:
	push bc			; $4aaf
	call $4b02		; $4ab0
	ld l,$15		; $4ab3
	bit 7,(hl)		; $4ab5
	jr z,_label_07_071	; $4ab7
	call objectCheckTileCollision_allowHoles		; $4ab9
	ld h,d			; $4abc
	pop bc			; $4abd
	jr nc,_label_07_072	; $4abe
	ld b,$03		; $4ac0
	jr _label_07_074		; $4ac2
_label_07_071:
	ld l,$0b		; $4ac4
	ldi a,(hl)		; $4ac6
	add $05			; $4ac7
	ld b,a			; $4ac9
	inc l			; $4aca
	ld c,(hl)		; $4acb
	call checkTileCollisionAt_allowHoles		; $4acc
	ld h,d			; $4acf
	pop bc			; $4ad0
	jr c,_label_07_069	; $4ad1
_label_07_072:
	ld l,$3b		; $4ad3
	bit 0,(hl)		; $4ad5
	ld b,$03		; $4ad7
	jr z,_label_07_073	; $4ad9
	ld b,$01		; $4adb
	bit 7,(hl)		; $4add
	jr nz,_label_07_068	; $4adf
_label_07_073:
	ld e,$14		; $4ae1
	ld l,$0a		; $4ae3
	ld a,(de)		; $4ae5
	add (hl)		; $4ae6
	ldi (hl),a		; $4ae7
	inc e			; $4ae8
	ld a,(de)		; $4ae9
	adc (hl)		; $4aea
	ldi (hl),a		; $4aeb
_label_07_074:
	ld l,$14		; $4aec
	ld a,(hl)		; $4aee
	add c			; $4aef
	ldi (hl),a		; $4af0
	ld a,(hl)		; $4af1
	adc $00			; $4af2
	ld (hl),a		; $4af4
	bit 7,a			; $4af5
	jr nz,_label_07_068	; $4af7
	cp b			; $4af9
	jr c,_label_07_068	; $4afa
	ld (hl),b		; $4afc
	dec l			; $4afd
	ld (hl),$00		; $4afe
	jr _label_07_068		; $4b00
	call $4a37		; $4b02
	jr nz,_label_07_075	; $4b05
	ld l,$0f		; $4b07
	bit 7,(hl)		; $4b09
	jr nz,_label_07_076	; $4b0b
_label_07_075:
	call objectCheckIsOverHazard		; $4b0d
	ld h,d			; $4b10
_label_07_076:
	ld b,a			; $4b11
	ld l,$3b		; $4b12
	ld a,(hl)		; $4b14
	ld c,a			; $4b15
	and $b8			; $4b16
	xor $80			; $4b18
	or b			; $4b1a
	ld (hl),a		; $4b1b
	ld a,b			; $4b1c
	xor c			; $4b1d
	rrca			; $4b1e
	jr nc,_label_07_077	; $4b1f
	set 6,(hl)		; $4b21
_label_07_077:
	ret			; $4b23
	call $4a8d		; $4b24
	jr c,_label_07_079	; $4b27
	ld a,($cc50)		; $4b29
	and $20			; $4b2c
	jr z,_label_07_078	; $4b2e
	ld b,$04		; $4b30
	bit 2,(hl)		; $4b32
	jr nz,_label_07_081	; $4b34
	ld b,$03		; $4b36
	bit 6,(hl)		; $4b38
	call nz,$4b5f		; $4b3a
_label_07_078:
	xor a			; $4b3d
	ret			; $4b3e
_label_07_079:
	ld a,($cc50)		; $4b3f
	and $20			; $4b42
	jr nz,_label_07_080	; $4b44
	ld h,d			; $4b46
	ld l,$3b		; $4b47
	ld b,$03		; $4b49
	bit 0,(hl)		; $4b4b
	jr nz,_label_07_081	; $4b4d
	ld b,$0f		; $4b4f
	bit 1,(hl)		; $4b51
	jr nz,_label_07_082	; $4b53
	ld b,$04		; $4b55
	bit 2,(hl)		; $4b57
	jr nz,_label_07_081	; $4b59
_label_07_080:
	xor a			; $4b5b
	bit 4,(hl)		; $4b5c
	ret			; $4b5e
_label_07_081:
	call objectCreateInteractionWithSubid00		; $4b5f
	scf			; $4b62
	ret			; $4b63
_label_07_082:
	call objectCreateFallingDownHoleInteraction		; $4b64
	scf			; $4b67
	ret			; $4b68
	ld b,$07		; $4b69
	jp objectCreateInteractionWithSubid00		; $4b6b
	ld a,$01		; $4b6e
	call objectGetRelatedObject1Var		; $4b70
	ld e,$01		; $4b73
	ld a,(de)		; $4b75
	cp (hl)			; $4b76
	ret			; $4b77
	call getTileAtPosition		; $4b78
	jr _label_07_083		; $4b7b
	call objectGetTileAtPosition		; $4b7d
_label_07_083:
	ld e,a			; $4b80
	ld a,l			; $4b81
	ld h,d			; $4b82
	ld l,$3c		; $4b83
	cp (hl)			; $4b85
	ldi (hl),a		; $4b86
	jr nz,_label_07_084	; $4b87
	ld a,e			; $4b89
	cp (hl)			; $4b8a
	ret z			; $4b8b
_label_07_084:
	ld (hl),e		; $4b8c
	ld l,$09		; $4b8d
	ld b,(hl)		; $4b8f
	call $4ba7		; $4b90
	jr nc,_label_07_085	; $4b93
	ret z			; $4b95
	ld h,d			; $4b96
	ld l,$3e		; $4b97
	add (hl)		; $4b99
	ld (hl),a		; $4b9a
	and $80			; $4b9b
	ret z			; $4b9d
_label_07_085:
	ld h,d			; $4b9e
	ld l,$3c		; $4b9f
	ld a,$ff		; $4ba1
	ldi (hl),a		; $4ba3
	ld (hl),a		; $4ba4
	or d			; $4ba5
	ret			; $4ba6
	ld hl,$4ca4		; $4ba7
	call findByteInCollisionTable_paramE		; $4baa
	jr c,_label_07_089	; $4bad
	ld a,b			; $4baf
	ld hl,angleTable		; $4bb0
	rst_addAToHl			; $4bb3
	ld a,(hl)		; $4bb4
	push af			; $4bb5
	ld a,($cc4f)		; $4bb6
	ld hl,$4c38		; $4bb9
	rst_addDoubleIndex			; $4bbc
	ldi a,(hl)		; $4bbd
	ld h,(hl)		; $4bbe
	ld l,a			; $4bbf
	pop af			; $4bc0
	srl a			; $4bc1
	jr nc,_label_07_086	; $4bc3
	rst_addAToHl			; $4bc5
	ld a,(hl)		; $4bc6
	push hl			; $4bc7
	rst_addAToHl			; $4bc8
	call lookupKey		; $4bc9
	pop hl			; $4bcc
	jr c,_label_07_088	; $4bcd
	inc hl			; $4bcf
	jr _label_07_087		; $4bd0
_label_07_086:
	rst_addAToHl			; $4bd2
_label_07_087:
	ld a,(hl)		; $4bd3
	rst_addAToHl			; $4bd4
	call lookupKey		; $4bd5
	ret nc			; $4bd8
_label_07_088:
	or a			; $4bd9
	scf			; $4bda
	ret			; $4bdb
_label_07_089:
	xor a			; $4bdc
	scf			; $4bdd
	ret			; $4bde
	ld e,$0f		; $4bdf
	ld a,(de)		; $4be1
	rlca			; $4be2
	ret c			; $4be3
	ld bc,$0500		; $4be4
	call objectGetRelativeTile		; $4be7
	ld hl,$4c23		; $4bea
	call lookupCollisionTable		; $4bed
	ret nc			; $4bf0
	push af			; $4bf1
	rrca			; $4bf2
	rrca			; $4bf3
	ld hl,$4c1b		; $4bf4
	rst_addAToHl			; $4bf7
	ldi a,(hl)		; $4bf8
	ld c,(hl)		; $4bf9
	ld h,d			; $4bfa
	ld l,$0b		; $4bfb
	add (hl)		; $4bfd
	ld b,a			; $4bfe
	ld l,$0d		; $4bff
	ld a,(hl)		; $4c01
	add c			; $4c02
	ld c,a			; $4c03
	call getTileCollisionsAtPosition		; $4c04
	cp $ff			; $4c07
	jr z,_label_07_090	; $4c09
	call checkGivenCollision_allowHoles		; $4c0b
	jr c,_label_07_090	; $4c0e
	pop af			; $4c10
	ld c,a			; $4c11
	ld b,$14		; $4c12
	ld e,$09		; $4c14
	jp objectApplyGivenSpeed		; $4c16
_label_07_090:
	pop af			; $4c19
	ret			; $4c1a
.DB $fd				; $4c1b
	nop			; $4c1c
	nop			; $4c1d
	inc bc			; $4c1e
	rlca			; $4c1f
	nop			; $4c20
	nop			; $4c21
.DB $fd				; $4c22
	scf			; $4c23
	ld c,h			; $4c24
	scf			; $4c25
	ld c,h			; $4c26
	scf			; $4c27
	ld c,h			; $4c28
	scf			; $4c29
	ld c,h			; $4c2a
	cpl			; $4c2b
	ld c,h			; $4c2c
	scf			; $4c2d
	ld c,h			; $4c2e
	ld d,h			; $4c2f
	nop			; $4c30
	ld d,l			; $4c31
	ld ($1056),sp		; $4c32
	ld d,a			; $4c35
	jr _label_07_091		; $4c36
_label_07_091:
	ld b,h			; $4c38
	ld c,h			; $4c39
	ld a,l			; $4c3a
	ld c,h			; $4c3b
	ld a,l			; $4c3c
	ld c,h			; $4c3d
	ld a,l			; $4c3e
	ld c,h			; $4c3f
	add e			; $4c40
	ld c,h			; $4c41
	ld a,l			; $4c42
	ld c,h			; $4c43
	dec b			; $4c44
	ld h,$14		; $4c45
	dec l			; $4c47
	ld bc,$ff54		; $4c48
	rst $8			; $4c4b
	rst $38			; $4c4c
	adc $ff			; $4c4d
	ld e,b			; $4c4f
	rst $38			; $4c50
	call $94ff		; $4c51
	rst $38			; $4c54
	sub l			; $4c55
	rst $38			; $4c56
	ldi a,(hl)		; $4c57
	ld bc,$5400		; $4c58
	ld bc,$01cf		; $4c5b
	adc $01			; $4c5e
	ld e,b			; $4c60
	ld bc,s8ToS16		; $4c61
	sub h			; $4c64
	ld bc,$0195		; $4c65
	ldi a,(hl)		; $4c68
	rst $38			; $4c69
	nop			; $4c6a
	daa			; $4c6b
	ld bc,$0126		; $4c6c
	dec h			; $4c6f
	rst $38			; $4c70
	jr z,-$01		; $4c71
	nop			; $4c73
	daa			; $4c74
	rst $38			; $4c75
	ld h,$ff		; $4c76
	dec h			; $4c78
	ld bc,$0128		; $4c79
	nop			; $4c7c
	dec b			; $4c7d
	inc b			; $4c7e
	inc bc			; $4c7f
	ld (bc),a		; $4c80
	ld bc,$0500		; $4c81
	ld d,$0c		; $4c84
	add hl,de		; $4c86
	ld bc,$01b2		; $4c87
	or b			; $4c8a
	rst $38			; $4c8b
	dec b			; $4c8c
	ld bc,$ff06		; $4c8d
	nop			; $4c90
	or b			; $4c91
	ld bc,$ffb2		; $4c92
	dec b			; $4c95
	rst $38			; $4c96
	ld b,$01		; $4c97
	nop			; $4c99
	or e			; $4c9a
	ld bc,$ffb1		; $4c9b
	nop			; $4c9e
	or c			; $4c9f
	ld bc,$ffb3		; $4ca0
	nop			; $4ca3
	or b			; $4ca4
	ld c,h			; $4ca5
	or b			; $4ca6
	ld c,h			; $4ca7
	or c			; $4ca8
	ld c,h			; $4ca9
	or d			; $4caa
	ld c,h			; $4cab
	or h			; $4cac
	ld c,h			; $4cad
	jp nz,$fd4c		; $4cae
	nop			; $4cb1
	rst $8			; $4cb2
	nop			; $4cb3
	sub b			; $4cb4
	sub c			; $4cb5
	sub d			; $4cb6
	sub e			; $4cb7
	sub h			; $4cb8
	sub l			; $4cb9
	sub (hl)		; $4cba
	sub a			; $4cbb
	sbc b			; $4cbc
	sbc c			; $4cbd
	sbc d			; $4cbe
	sbc e			; $4cbf
	ld a,(bc)		; $4cc0
	dec bc			; $4cc1
	nop			; $4cc2

; ITEMID_EMBER_SEED
; ITEMID_SCENT_SEED
; ITEMID_PEGASUS_SEED
; ITEMID_GALE_SEED
; ITEMID_MYSTERY_SEED
itemCode20:
itemCode21:
itemCode22:
itemCode23:
itemCode24:
	ld e,$04		; $4cc3
	ld a,(de)		; $4cc5
	rst_jumpTable			; $4cc6
	rst $8			; $4cc7
	ld c,h			; $4cc8
	inc a			; $4cc9
	ld c,l			; $4cca
	call $7b4e		; $4ccb
	ld c,(hl)		; $4cce
	call $497b		; $4ccf
	xor a			; $4cd2
	call $49ca		; $4cd3
	call objectSetVisiblec1		; $4cd6
	call itemIncState		; $4cd9
	ld bc,$ffe0		; $4cdc
	call objectSetSpeedZ		; $4cdf
	call itemUpdateAngle		; $4ce2
	ld l,$02		; $4ce5
	ldd a,(hl)		; $4ce7
	or a			; $4ce8
	jr nz,_label_07_093	; $4ce9
	ldi a,(hl)		; $4ceb
	cp $23			; $4cec
	jr nz,_label_07_092	; $4cee
	ld l,$0f		; $4cf0
	ld a,(hl)		; $4cf2
	add $f8			; $4cf3
	ld (hl),a		; $4cf5
	ld l,$09		; $4cf6
	ld (hl),$ff		; $4cf8
	ret			; $4cfa
_label_07_092:
	ld a,$1e		; $4cfb
	jr _label_07_094		; $4cfd
_label_07_093:
	ld hl,$4d2c		; $4cff
	rst_addAToHl			; $4d02
	ld e,$09		; $4d03
	ld a,(de)		; $4d05
	add (hl)		; $4d06
	and $1f			; $4d07
	ld (de),a		; $4d09
	ld hl,$ccf1		; $4d0a
	inc (hl)		; $4d0d
	ld a,$78		; $4d0e
_label_07_094:
	ld e,$10		; $4d10
	ld (de),a		; $4d12
	ld hl,$4d30		; $4d13
	call $4a1e		; $4d16
	ld e,$01		; $4d19
	ld a,(de)		; $4d1b
	cp $24			; $4d1c
	ret nz			; $4d1e
	call getRandomNumber_noPreserveVars		; $4d1f
	and $03			; $4d22
	ld e,$03		; $4d24
	ld (de),a		; $4d26
	add $9b			; $4d27
	ld e,$24		; $4d29
	ld (de),a		; $4d2b
	ret			; $4d2c
	nop			; $4d2d
	ld (bc),a		; $4d2e
	cp $fc			; $4d2f
	nop			; $4d31
	cp $01			; $4d32
	inc b			; $4d34
	cp $05			; $4d35
	nop			; $4d37
	cp $01			; $4d38
	ei			; $4d3a
	cp $cd			; $4d3b
	or b			; $4d3d
	ld c,c			; $4d3e
	jr nz,_label_07_098	; $4d3f
	ld e,$02		; $4d41
	ld a,(de)		; $4d43
	or a			; $4d44
	jr z,_label_07_095	; $4d45
	call $4fdf		; $4d47
	jr nz,_label_07_097	; $4d4a
	call objectCheckWithinScreenBoundary		; $4d4c
	jp c,objectApplySpeed		; $4d4f
	jp $4e6a		; $4d52
_label_07_095:
	ld h,d			; $4d55
	ld l,$3b		; $4d56
	bit 0,(hl)		; $4d58
	jr z,_label_07_096	; $4d5a
	ld l,$10		; $4d5c
	ld (hl),$00		; $4d5e
_label_07_096:
	call objectCheckWithinRoomBoundary		; $4d60
	jp nc,$4e6a		; $4d63
	call objectApplySpeed		; $4d66
	ld c,$1c		; $4d69
	call $4b24		; $4d6b
	jp c,$4e6a		; $4d6e
	ret z			; $4d71
	ld a,$52		; $4d72
	call playSound		; $4d74
	call $49c1		; $4d77
	ld e,$01		; $4d7a
	ld a,(de)		; $4d7c
	sub $20			; $4d7d
	rst_jumpTable			; $4d7f
	or h			; $4d80
	ld c,l			; $4d81
	cp d			; $4d82
	ld c,l			; $4d83
	ld l,d			; $4d84
	ld c,(hl)		; $4d85
	sub $4d			; $4d86
	dec h			; $4d88
	ld c,(hl)		; $4d89
_label_07_097:
	call $49c1		; $4d8a
	ld e,$01		; $4d8d
	ld a,(de)		; $4d8f
	sub $20			; $4d90
	rst_jumpTable			; $4d92
	or h			; $4d93
	ld c,l			; $4d94
	ret nc			; $4d95
	ld c,l			; $4d96
	ret nc			; $4d97
	ld c,l			; $4d98
.DB $f4				; $4d99
	ld c,l			; $4d9a
	dec h			; $4d9b
	ld c,(hl)		; $4d9c
_label_07_098:
	call $49c1		; $4d9d
	ld e,$24		; $4da0
	xor a			; $4da2
	ld (de),a		; $4da3
	ld e,$01		; $4da4
	ld a,(de)		; $4da6
	sub $20			; $4da7
	rst_jumpTable			; $4da9
	or h			; $4daa
	ld c,l			; $4dab
	ret nc			; $4dac
	ld c,l			; $4dad
	ret nc			; $4dae
	ld c,l			; $4daf
	or h			; $4db0
	ld c,l			; $4db1
	ld ($cd4e),sp		; $4db2
	inc l			; $4db5
	ld c,(hl)		; $4db6
	jp objectSetVisible82		; $4db7
	ld a,$27		; $4dba
	call $4e34		; $4dbc
	ld a,$02		; $4dbf
	call itemSetState		; $4dc1
	ld l,$24		; $4dc4
	res 7,(hl)		; $4dc6
	ld a,$01		; $4dc8
	call $49ca		; $4dca
	jp objectSetVisible83		; $4dcd
	ld e,$24		; $4dd0
	xor a			; $4dd2
	ld (de),a		; $4dd3
	jr _label_07_101		; $4dd4
	call $4def		; $4dd6
	ld a,$25		; $4dd9
	call $4e34		; $4ddb
	ld a,$02		; $4dde
	call itemSetState		; $4de0
	ld l,$24		; $4de3
	xor a			; $4de5
	ldi (hl),a		; $4de6
	inc l			; $4de7
	ld a,$02		; $4de8
	ldi (hl),a		; $4dea
	ld (hl),a		; $4deb
	jp objectSetVisible82		; $4dec
	ld a,$0d		; $4def
	jp itemTryToBreakTile		; $4df1
	call $4def		; $4df4
	ld a,$26		; $4df7
	call $4e34		; $4df9
	ld a,$03		; $4dfc
	call itemSetState		; $4dfe
	ld l,$24		; $4e01
	res 7,(hl)		; $4e03
	jp objectSetVisible82		; $4e05
	ld h,d			; $4e08
	ld l,$2a		; $4e09
	bit 6,(hl)		; $4e0b
	jr nz,_label_07_100	; $4e0d
	ld l,$03		; $4e0f
	ldd a,(hl)		; $4e11
	add $20			; $4e12
	dec l			; $4e14
_label_07_099:
	ld (hl),a		; $4e15
	call $497b		; $4e16
	xor a			; $4e19
	call $49ca		; $4e1a
	ld e,$29		; $4e1d
	ld a,$ff		; $4e1f
	ld (de),a		; $4e21
	jp $4d9d		; $4e22
_label_07_100:
	ld e,$24		; $4e25
	xor a			; $4e27
	ld (de),a		; $4e28
	call objectSetVisible82		; $4e29
_label_07_101:
	ld e,$04		; $4e2c
	ld a,$03		; $4e2e
	ld (de),a		; $4e30
	ld e,$01		; $4e31
	ld a,(de)		; $4e33
	add a			; $4e34
	ld hl,$4dca		; $4e35
	rst_addDoubleIndex			; $4e38
	ld e,$1b		; $4e39
	ldi a,(hl)		; $4e3b
	ld (de),a		; $4e3c
	inc e			; $4e3d
	ld (de),a		; $4e3e
	inc e			; $4e3f
	ldi a,(hl)		; $4e40
	ld (de),a		; $4e41
	ldi a,(hl)		; $4e42
	ld e,$06		; $4e43
	ld (de),a		; $4e45
	ld a,(hl)		; $4e46
	jp playSound		; $4e47
	ld a,(bc)		; $4e4a
	ld b,$3a		; $4e4b
	ld (hl),d		; $4e4d
	dec bc			; $4e4e
	stop			; $4e4f
	inc a			; $4e50
	ret nc			; $4e51
	add hl,bc		; $4e52
	jr _label_07_102		; $4e53
_label_07_102:
	ld (hl),d		; $4e55
	add hl,bc		; $4e56
	jr z,_label_07_105	; $4e57
	sub b			; $4e59
	ld ($0018),sp		; $4e5a
	ld a,e			; $4e5d
	add hl,bc		; $4e5e
	jr z,_label_07_099	; $4e5f
	sub b			; $4e61
	add hl,bc		; $4e62
	jr z,_label_07_104	; $4e63
	sub b			; $4e65
	dec bc			; $4e66
	inc a			; $4e67
	sub (hl)		; $4e68
	add l			; $4e69
	ld e,$02		; $4e6a
	ld a,(de)		; $4e6c
	or a			; $4e6d
	jr z,_label_07_103	; $4e6e
	ld hl,$ccf1		; $4e70
	ld a,(hl)		; $4e73
	or a			; $4e74
	jr z,_label_07_103	; $4e75
	dec (hl)		; $4e77
_label_07_103:
	jp itemDelete		; $4e78
	ld e,$01		; $4e7b
	ld a,(de)		; $4e7d
	sub $20			; $4e7e
	rst_jumpTable			; $4e80
	adc e			; $4e81
	ld c,(hl)		; $4e82
_label_07_104:
	cp (hl)			; $4e83
	ld c,(hl)		; $4e84
	cp (hl)			; $4e85
	ld c,(hl)		; $4e86
	rrca			; $4e87
	ld c,a			; $4e88
	cp (hl)			; $4e89
	ld c,(hl)		; $4e8a
_label_07_105:
	ld h,d			; $4e8b
	ld l,$06		; $4e8c
	dec (hl)		; $4e8e
	jr z,_label_07_107	; $4e8f
	call $49c1		; $4e91
	call $49b0		; $4e94
	ld l,$21		; $4e97
	ld b,(hl)		; $4e99
	jr z,_label_07_106	; $4e9a
	ld l,$24		; $4e9c
	ld (hl),$00		; $4e9e
	bit 7,b			; $4ea0
	jr nz,_label_07_108	; $4ea2
_label_07_106:
	ld l,$0e		; $4ea4
	ldi a,(hl)		; $4ea6
	or (hl)			; $4ea7
	ld c,$1c		; $4ea8
	jp nz,objectUpdateSpeedZ_paramC		; $4eaa
	bit 6,b			; $4ead
	ret z			; $4eaf
	call objectCheckTileAtPositionIsWater		; $4eb0
	jr c,_label_07_108	; $4eb3
	ret			; $4eb5
_label_07_107:
	ld a,$0c		; $4eb6
	call itemTryToBreakTile		; $4eb8
_label_07_108:
	jp $4e6a		; $4ebb
	ld e,$24		; $4ebe
	xor a			; $4ec0
	ld (de),a		; $4ec1
	call $49c1		; $4ec2
	ld e,$21		; $4ec5
	ld a,(de)		; $4ec7
	rlca			; $4ec8
	ret nc			; $4ec9
	jp $4e6a		; $4eca
	ld e,$01		; $4ecd
	ld a,(de)		; $4ecf
	sub $20			; $4ed0
	rst_jumpTable			; $4ed2
	adc e			; $4ed3
	ld c,(hl)		; $4ed4
.DB $dd				; $4ed5
	ld c,(hl)		; $4ed6
	cp (hl)			; $4ed7
	ld c,(hl)		; $4ed8
	ld (hl),$4f		; $4ed9
	cp (hl)			; $4edb
	ld c,(hl)		; $4edc
	ld h,d			; $4edd
	ld l,$06		; $4ede
	ld a,(wFrameCounter)		; $4ee0
	rrca			; $4ee3
	jr c,_label_07_109	; $4ee4
	dec (hl)		; $4ee6
	jp z,$4e6a		; $4ee7
_label_07_109:
	ld a,(hl)		; $4eea
	cp $1e			; $4eeb
	jr nc,_label_07_110	; $4eed
	ld l,$1a		; $4eef
	ld a,(hl)		; $4ef1
	xor $80			; $4ef2
	ld (hl),a		; $4ef4
_label_07_110:
	ld l,$0b		; $4ef5
	ldi a,(hl)		; $4ef7
	ldh (<hFFB2),a	; $4ef8
	inc l			; $4efa
	ldi a,(hl)		; $4efb
	ldh (<hFFB3),a	; $4efc
	ld a,$ff		; $4efe
	ld ($ccf0),a		; $4f00
	call $49c1		; $4f03
	call $4a6b		; $4f06
	jp c,$4e6a		; $4f09
	jp $4a4a		; $4f0c
_label_07_111:
	call $4f23		; $4f0f
	call itemDecCounter1		; $4f12
	jp z,$4e6a		; $4f15
	ld a,(hl)		; $4f18
	cp $14			; $4f19
	ret nc			; $4f1b
	ld l,$1a		; $4f1c
	ld a,(hl)		; $4f1e
	xor $80			; $4f1f
	ld (hl),a		; $4f21
	ret			; $4f22
	call $49c1		; $4f23
	ld e,$06		; $4f26
	ld a,(de)		; $4f28
	and $03			; $4f29
	ret nz			; $4f2b
	ld e,$1b		; $4f2c
	ld a,(de)		; $4f2e
	inc a			; $4f2f
	and $0b			; $4f30
	ld (de),a		; $4f32
	inc e			; $4f33
	ld (de),a		; $4f34
	ret			; $4f35
	call $4f23		; $4f36
	ld e,$05		; $4f39
	ld a,(de)		; $4f3b
	rst_jumpTable			; $4f3c
	ld b,l			; $4f3d
	ld c,a			; $4f3e
	sub c			; $4f3f
	ld c,a			; $4f40
	and a			; $4f41
	ld c,a			; $4f42
	jp nc,$fa4f		; $4f43
	ld d,b			; $4f46
	call z,$203d		; $4f47
	ld b,b			; $4f4a
	ld a,($cc88)		; $4f4b
	or a			; $4f4e
	jr nz,_label_07_111	; $4f4f
	ld a,($cc48)		; $4f51
	rrca			; $4f54
	jr c,_label_07_111	; $4f55
	ld a,(wLinkGrabState2)		; $4f57
	and $f0			; $4f5a
	cp $40			; $4f5c
	jr z,_label_07_111	; $4f5e
	call checkLinkID0AndControlNormal		; $4f60
	jr nc,_label_07_111	; $4f63
	call objectCheckCollidedWithLink		; $4f65
	jr nc,_label_07_111	; $4f68
	ld hl,$d000		; $4f6a
	call objectTakePosition		; $4f6d
	ld e,$07		; $4f70
	ld a,$3c		; $4f72
	ld (de),a		; $4f74
	ld e,$05		; $4f75
	ld a,$01		; $4f77
	ld (de),a		; $4f79
	ld ($cc02),a		; $4f7a
	ld ($cca6),a		; $4f7d
	ld ($ccab),a		; $4f80
	ld a,$07		; $4f83
	ld ($cc6a),a		; $4f85
	jp objectSetVisible80		; $4f88
_label_07_112:
	ld e,$05		; $4f8b
	ld a,$03		; $4f8d
	ld (de),a		; $4f8f
	ret			; $4f90
	ld a,($cc34)		; $4f91
	or a			; $4f94
	jr nz,_label_07_112	; $4f95
	ld h,d			; $4f97
	ld l,$07		; $4f98
	dec (hl)		; $4f9a
	jr z,_label_07_113	; $4f9b
	ld a,($cc49)		; $4f9d
	or a			; $4fa0
	jr z,_label_07_114	; $4fa1
	ret			; $4fa3
_label_07_113:
	ld a,$02		; $4fa4
	ld (de),a		; $4fa6
	ld h,d			; $4fa7
	ld l,$0f		; $4fa8
	dec (hl)		; $4faa
	dec (hl)		; $4fab
	bit 7,(hl)		; $4fac
	jr nz,_label_07_114	; $4fae
	ld a,$02		; $4fb0
	ld ($d005),a		; $4fb2
	ld a,$16		; $4fb5
	ld ($cc04),a		; $4fb7
	ld a,$05		; $4fba
	call openMenu		; $4fbc
	jp $4e6a		; $4fbf
_label_07_114:
	ld e,$1a		; $4fc2
	ld a,(de)		; $4fc4
	xor $80			; $4fc5
	ld (de),a		; $4fc7
	xor a			; $4fc8
	ld ($cc78),a		; $4fc9
	ld hl,$d000		; $4fcc
	jp objectCopyPosition		; $4fcf
	call itemDecCounter2		; $4fd2
	jp z,$4e6a		; $4fd5
	ld l,$1a		; $4fd8
	ld a,(hl)		; $4fda
	xor $80			; $4fdb
	ld (hl),a		; $4fdd
	ret			; $4fde
	call objectCheckTileCollision_allowHoles		; $4fdf
	jr nc,_label_07_115	; $4fe2
	call $4b7d		; $4fe4
	ret			; $4fe7
_label_07_115:
	xor a			; $4fe8
	ret			; $4fe9

; ITEMID_DIMITRI_MOUTH
itemCode2b:
	ld e,$04		; $4fea
	ld a,(de)		; $4fec
	or a			; $4fed
	jr nz,_label_07_116	; $4fee
	call $497b		; $4ff0
	call itemIncState		; $4ff3
	ld l,$06		; $4ff6
	ld (hl),$0c		; $4ff8
_label_07_116:
	call $5019		; $4ffa
	ld h,d			; $4ffd
	ld l,$2a		; $4ffe
	bit 1,(hl)		; $5000
	jr nz,_label_07_117	; $5002
	ld a,$12		; $5004
	call itemTryToBreakTile		; $5006
	jr c,_label_07_117	; $5009
	call itemDecCounter1		; $500b
	jr z,_label_07_118	; $500e
	ret			; $5010
_label_07_117:
	ld a,$01		; $5011
	ld ($d135),a		; $5013
_label_07_118:
	jp itemDelete		; $5016
	ld a,($d108)		; $5019
	ld hl,$5029		; $501c
	rst_addDoubleIndex			; $501f
	ldi a,(hl)		; $5020
	ld c,(hl)		; $5021
	ld b,a			; $5022
	ld hl,$d10b		; $5023
	jp objectTakePositionWithOffset		; $5026
	or $00			; $5029
	cp $0a			; $502b
	inc b			; $502d
	nop			; $502e
	cp $f6			; $502f

; ITEMID_BOMBCHUS
itemCode0d:
	call $52ac		; $5031
	ld e,$04		; $5034
	ld a,(de)		; $5036
	cp $ff			; $5037
	jp nc,$5402		; $5039
	call objectCheckWithinRoomBoundary		; $503c
	jp nc,itemDelete		; $503f
	call objectSetPriorityRelativeToLink_withTerrainEffects		; $5042
	ld a,($cc50)		; $5045
	and $20			; $5048
	jr nz,_label_07_119	; $504a
	ld c,$20		; $504c
	call $4a4a		; $504e
	ld e,$04		; $5051
	ld a,(de)		; $5053
	rst_jumpTable			; $5054
	ld a,c			; $5055
	ld d,b			; $5056
	xor a			; $5057
	ld d,b			; $5058
	cp b			; $5059
	ld d,b			; $505a
	push bc			; $505b
	ld d,b			; $505c
	ret nc			; $505d
	ld d,b			; $505e
_label_07_119:
	ld e,$32		; $505f
	ld a,(de)		; $5061
	or a			; $5062
	jr nz,_label_07_120	; $5063
	ld c,$18		; $5065
	call $4b24		; $5067
	jp c,itemDelete		; $506a
_label_07_120:
	ld e,$04		; $506d
	ld a,(de)		; $506f
	rst_jumpTable			; $5070
	sbc $50			; $5071
.DB $ed				; $5073
	ld d,b			; $5074
.DB $fc				; $5075
	ld d,b			; $5076
	inc b			; $5077
	ld d,c			; $5078
	call $497b		; $5079
	call decNumBombchus		; $507c
	ld h,d			; $507f
	ld l,$04		; $5080
	inc (hl)		; $5082
	ld l,$30		; $5083
	ld (hl),$d0		; $5085
	ld l,$11		; $5087
	ld (hl),$14		; $5089
	ld l,$06		; $508b
	ld (hl),$10		; $508d
	inc l			; $508f
	ld (hl),$b4		; $5090
	ld l,$26		; $5092
	ld a,$18		; $5094
	ldi (hl),a		; $5096
	ld (hl),a		; $5097
	ld l,$31		; $5098
	ld (hl),$08		; $509a
	ld l,$09		; $509c
	ld a,($d008)		; $509e
	swap a			; $50a1
	rrca			; $50a3
	ld (hl),a		; $50a4
	ld l,$08		; $50a5
	ld (hl),$ff		; $50a7
	call $5220		; $50a9
	jp $526b		; $50ac
	ld h,d			; $50af
	ld l,$0f		; $50b0
	bit 7,(hl)		; $50b2
	jr nz,_label_07_121	; $50b4
	ld l,e			; $50b6
	inc (hl)		; $50b7
	call $52c3		; $50b8
	ret z			; $50bb
_label_07_121:
	call $5117		; $50bc
	call $4bdf		; $50bf
_label_07_122:
	jp $49c1		; $50c2
	ld h,d			; $50c5
	ld l,$06		; $50c6
	dec (hl)		; $50c8
	jp nz,$4bdf		; $50c9
	ld (hl),$0a		; $50cc
	ld l,e			; $50ce
	inc (hl)		; $50cf
	call $52b7		; $50d0
	jp c,$52b0		; $50d3
	call $510f		; $50d6
	call $4bdf		; $50d9
	jr _label_07_122		; $50dc
	call $5079		; $50de
	ld e,$09		; $50e1
	ld a,(de)		; $50e3
	bit 3,a			; $50e4
	ret nz			; $50e6
	add $08			; $50e7
	ld (de),a		; $50e9
	jp $5220		; $50ea
	ld e,$10		; $50ed
	ld a,$14		; $50ef
	ld (de),a		; $50f1
	call $52c3		; $50f2
	ret z			; $50f5
	call $5181		; $50f6
_label_07_123:
	jp $49c1		; $50f9
	call itemDecCounter1		; $50fc
	ret nz			; $50ff
	ld (hl),$0a		; $5100
	ld l,e			; $5102
	inc (hl)		; $5103
	call $52b7		; $5104
	jp c,$52b0		; $5107
	call $5179		; $510a
	jr _label_07_123		; $510d
	ld a,(wFrameCounter)		; $510f
	and $07			; $5112
	call z,$51fe		; $5114
	call $5122		; $5117
	ld c,$18		; $511a
	call objectUpdateSpeedZ_paramC		; $511c
	jp objectApplySpeed		; $511f
	ld e,$09		; $5122
	call $515a		; $5124
	cp $10			; $5127
	jr z,_label_07_125	; $5129
	cp $15			; $512b
	jr z,_label_07_125	; $512d
	inc a			; $512f
	jr z,_label_07_125	; $5130
	dec a			; $5132
	ld e,$11		; $5133
	ld a,(de)		; $5135
	jr z,_label_07_124	; $5136
	ld e,a			; $5138
	ld hl,$6270		; $5139
	call lookupKey		; $513c
_label_07_124:
	ld h,d			; $513f
	ld l,$10		; $5140
	cp (hl)			; $5142
	ld (hl),a		; $5143
	ret nc			; $5144
	ld l,$14		; $5145
	ld a,$80		; $5147
	ldi (hl),a		; $5149
	ld (hl),$ff		; $514a
	ret			; $514c
_label_07_125:
	ld h,d			; $514d
	ld l,$31		; $514e
	ld a,(hl)		; $5150
	ld l,$09		; $5151
	add (hl)		; $5153
	and $18			; $5154
	ld (hl),a		; $5156
	jp $5220		; $5157
	ld h,d			; $515a
	ld l,$0b		; $515b
	ld b,(hl)		; $515d
	ld l,$0d		; $515e
	ld c,(hl)		; $5160
	ld a,(de)		; $5161
	rrca			; $5162
	rrca			; $5163
	ld hl,$5171		; $5164
	rst_addAToHl			; $5167
	ldi a,(hl)		; $5168
	add b			; $5169
	ld b,a			; $516a
	ld a,(hl)		; $516b
	add c			; $516c
	ld c,a			; $516d
	jp getTileCollisionsAtPosition		; $516e
.DB $fc				; $5171
	nop			; $5172
	ld (bc),a		; $5173
	inc bc			; $5174
	ld b,$00		; $5175
	ld (bc),a		; $5177
.DB $fc				; $5178
	ld a,(wFrameCounter)		; $5179
	and $07			; $517c
	call z,$523b		; $517e
	call $5187		; $5181
	jp objectApplySpeed		; $5184
	ld e,$32		; $5187
	ld a,(de)		; $5189
	or a			; $518a
	jr nz,_label_07_127	; $518b
	ld e,$09		; $518d
	call $515a		; $518f
	ret z			; $5192
	inc a			; $5193
	jr nz,_label_07_126	; $5194
	ld e,$09		; $5196
	ld a,(de)		; $5198
	xor $10			; $5199
	ld (de),a		; $519b
	jp $5220		; $519c
_label_07_126:
	ld h,d			; $519f
	ld l,$09		; $51a0
	ld a,(hl)		; $51a2
	ld (hl),$00		; $51a3
	ld l,$33		; $51a5
	ld (hl),a		; $51a7
	ld l,$32		; $51a8
	ld (hl),$01		; $51aa
	jp $5220		; $51ac
_label_07_127:
	ld e,$33		; $51af
	call $515a		; $51b1
	jr nz,_label_07_129	; $51b4
	ld h,d			; $51b6
	ld l,$09		; $51b7
	ld e,$33		; $51b9
	ld a,(de)		; $51bb
	or a			; $51bc
	jr nz,_label_07_128	; $51bd
	ld a,(hl)		; $51bf
	ld e,$33		; $51c0
	ld (de),a		; $51c2
_label_07_128:
	ld a,(de)		; $51c3
	ld (hl),a		; $51c4
	ld l,$32		; $51c5
	xor a			; $51c7
	ldi (hl),a		; $51c8
	inc l			; $51c9
	ld (hl),a		; $51ca
	ld l,$14		; $51cb
	ldi (hl),a		; $51cd
	ldi (hl),a		; $51ce
	ld l,$08		; $51cf
	ld (hl),$ff		; $51d1
	jp $5220		; $51d3
_label_07_129:
	ld e,$09		; $51d6
	call $515a		; $51d8
	ret z			; $51db
	ld h,d			; $51dc
	ld l,$09		; $51dd
	ld b,(hl)		; $51df
	ld e,$33		; $51e0
	ld a,(de)		; $51e2
	xor $10			; $51e3
	ld (hl),a		; $51e5
	bit 3,a			; $51e6
	jr z,_label_07_130	; $51e8
	bit 3,b			; $51ea
	jr z,_label_07_130	; $51ec
	ld l,$32		; $51ee
	ld (hl),$00		; $51f0
_label_07_130:
	ld a,b			; $51f2
	ld (de),a		; $51f3
	or a			; $51f4
	ld l,$34		; $51f5
	ld (hl),$00		; $51f7
	jr nz,_label_07_132	; $51f9
	inc (hl)		; $51fb
	jr _label_07_132		; $51fc
	ld a,$0b		; $51fe
	call objectGetRelatedObject2Var		; $5200
	ld b,(hl)		; $5203
	ld l,$8d		; $5204
	ld c,(hl)		; $5206
	call objectGetRelativeAngle		; $5207
	ld b,a			; $520a
	add $04			; $520b
	and $18			; $520d
	ld e,$09		; $520f
	ld (de),a		; $5211
	sub b			; $5212
	and $1f			; $5213
	cp $10			; $5215
	ld a,$08		; $5217
	jr nc,_label_07_131	; $5219
	ld a,$f8		; $521b
_label_07_131:
	ld e,$31		; $521d
	ld (de),a		; $521f
_label_07_132:
	ld h,d			; $5220
	ld l,$08		; $5221
	ld e,$09		; $5223
	ld a,(de)		; $5225
	cp (hl)			; $5226
	ret z			; $5227
	ld (hl),a		; $5228
	swap a			; $5229
	rlca			; $522b
	ld l,$34		; $522c
	bit 0,(hl)		; $522e
	jr z,_label_07_133	; $5230
	dec a			; $5232
	ld a,$04		; $5233
	jr z,_label_07_133	; $5235
	inc a			; $5237
_label_07_133:
	jp $49ca		; $5238
	ld a,$0b		; $523b
	call objectGetRelatedObject2Var		; $523d
	ld b,(hl)		; $5240
	ld l,$8d		; $5241
	ld c,(hl)		; $5243
	call objectGetRelativeAngle		; $5244
	ld b,a			; $5247
	ld e,$09		; $5248
	ld a,(de)		; $524a
	bit 3,a			; $524b
	ld a,b			; $524d
	jr nz,_label_07_134	; $524e
	sub $08			; $5250
	and $1f			; $5252
	cp $10			; $5254
	ld a,$00		; $5256
	jr c,_label_07_135	; $5258
	ld a,$10		; $525a
	jr _label_07_135		; $525c
_label_07_134:
	cp $10			; $525e
	ld a,$08		; $5260
	jr c,_label_07_135	; $5262
	ld a,$18		; $5264
_label_07_135:
	ld e,$09		; $5266
	ld (de),a		; $5268
	jr _label_07_132		; $5269
	ld hl,$d00b		; $526b
	ld b,(hl)		; $526e
	ld l,$0d		; $526f
	ld c,(hl)		; $5271
	ld a,($cc49)		; $5272
	cp $06			; $5275
	ld l,$08		; $5277
	ld a,(hl)		; $5279
	ld hl,$529c		; $527a
	jr c,_label_07_136	; $527d
	ld hl,$52a4		; $527f
_label_07_136:
	rst_addDoubleIndex			; $5282
	ld e,$0b		; $5283
	ldi a,(hl)		; $5285
	add b			; $5286
	ld (de),a		; $5287
	ld e,$0d		; $5288
	ld a,(hl)		; $528a
	add c			; $528b
	ld (de),a		; $528c
	push bc			; $528d
	call objectGetTileCollisions		; $528e
	pop bc			; $5291
	cp $0f			; $5292
	ret nz			; $5294
	ld a,c			; $5295
	ld (de),a		; $5296
	ld e,$0b		; $5297
	ld a,b			; $5299
	ld (de),a		; $529a
	ret			; $529b
.DB $f4				; $529c
	nop			; $529d
	ld (bc),a		; $529e
	inc c			; $529f
	inc c			; $52a0
	nop			; $52a1
	ld (bc),a		; $52a2
.DB $f4				; $52a3
	nop			; $52a4
	nop			; $52a5
	ld (bc),a		; $52a6
	inc c			; $52a7
	nop			; $52a8
	nop			; $52a9
	ld (bc),a		; $52aa
.DB $f4				; $52ab
	call itemDecCounter2		; $52ac
	ret nz			; $52af
	ld e,$07		; $52b0
	xor a			; $52b2
	ld (de),a		; $52b3
	jp $543c		; $52b4
	ld a,$29		; $52b7
	call objectGetRelatedObject2Var		; $52b9
	ld a,(hl)		; $52bc
	or a			; $52bd
	scf			; $52be
	ret z			; $52bf
	jp checkObjectsCollided		; $52c0
	ld e,$30		; $52c3
	ld a,(de)		; $52c5
	ld h,a			; $52c6
	ld l,$80		; $52c7
	ld a,(hl)		; $52c9
	or a			; $52ca
	jr z,_label_07_138	; $52cb
	ld l,$9a		; $52cd
	bit 7,(hl)		; $52cf
	jr z,_label_07_138	; $52d1
	ld l,$81		; $52d3
	ld a,(hl)		; $52d5
	push hl			; $52d6
	ld hl,$532d		; $52d7
	call checkFlag		; $52da
	pop hl			; $52dd
	jr z,_label_07_138	; $52de
	call checkObjectsCollided		; $52e0
	jr nc,_label_07_138	; $52e3
	ld a,h			; $52e5
	ld h,d			; $52e6
	ld l,$19		; $52e7
	ldd (hl),a		; $52e9
	ld (hl),$80		; $52ea
	ld l,$26		; $52ec
	ld a,$06		; $52ee
	ldi (hl),a		; $52f0
	ld (hl),a		; $52f1
	ld l,$06		; $52f2
	ld (hl),$0c		; $52f4
	ld l,$11		; $52f6
	ld (hl),$46		; $52f8
	ld l,$04		; $52fa
	inc (hl)		; $52fc
	ld a,($cc50)		; $52fd
	and $20			; $5300
	jr nz,_label_07_137	; $5302
	call $51fe		; $5304
	xor a			; $5307
	ret			; $5308
_label_07_137:
	call $523b		; $5309
	xor a			; $530c
	ret			; $530d
_label_07_138:
	inc h			; $530e
	ld a,h			; $530f
	cp $e0			; $5310
	jr c,_label_07_139	; $5312
	call $531e		; $5314
	ld a,$d0		; $5317
_label_07_139:
	ld e,$30		; $5319
	ld (de),a		; $531b
	or d			; $531c
	ret			; $531d
	ld e,$26		; $531e
	ld a,(de)		; $5320
	add $10			; $5321
	cp $60			; $5323
	jr c,_label_07_140	; $5325
	ld a,$18		; $5327
_label_07_140:
	ld (de),a		; $5329
	inc e			; $532a
	ld (de),a		; $532b
	ret			; $532c
	nop			; $532d
	ccf			; $532e
	sub a			; $532f
	ld a,l			; $5330
	ccf			; $5331
	jr nc,$37		; $5332
	ld a,h			; $5334
	jp hl			; $5335
	rst $28			; $5336
	ld (bc),a		; $5337
	ld b,b			; $5338
	nop			; $5339
	nop			; $533a
	inc bc			; $533b
	nop			; $533c

; ITEMID_BOMB
itemCode03:
	ld e,$2f		; $533d
	ld a,(de)		; $533f
	bit 5,a			; $5340
	jr nz,_label_07_141	; $5342
	bit 7,a			; $5344
	jp nz,$548d		; $5346
	bit 4,a			; $5349
	jp nz,$542a		; $534b
	ld e,$04		; $534e
	ld a,(de)		; $5350
	rst_jumpTable			; $5351
	ld a,d			; $5352
	ld d,e			; $5353
	ld l,b			; $5354
	ld d,e			; $5355
	ld a,d			; $5356
	ld d,e			; $5357
_label_07_141:
	ld h,d			; $5358
	ld l,$04		; $5359
	ldi a,(hl)		; $535b
	cp $02			; $535c
	jr nz,_label_07_142	; $535e
	bit 1,(hl)		; $5360
	call z,dropLinkHeldItem		; $5362
_label_07_142:
	jp itemDelete		; $5365
	ld c,$20		; $5368
	call $53cd		; $536a
	ret c			; $536d
	call $4a6b		; $536e
	jp c,itemDelete		; $5371
	call $4bdf		; $5374
	jp $5434		; $5377
	ld e,$05		; $537a
	ld a,(de)		; $537c
	rst_jumpTable			; $537d
	add (hl)		; $537e
	ld d,e			; $537f
	sub h			; $5380
	ld d,e			; $5381
	and e			; $5382
	ld d,e			; $5383
	and e			; $5384
	ld d,e			; $5385
	call itemIncState2		; $5386
	ld l,$2f		; $5389
	set 6,(hl)		; $538b
	ld l,$37		; $538d
	res 0,(hl)		; $538f
	call $547c		; $5391
	ld a,$3b		; $5394
	call cpActiveRing		; $5396
	jp z,$548d		; $5399
	call $5434		; $539c
	ret z			; $539f
	jp dropLinkHeldItem		; $53a0
	ld a,$03		; $53a3
	ld (de),a		; $53a5
	call $613a		; $53a6
	ld e,$39		; $53a9
	ld a,(de)		; $53ab
	ld c,a			; $53ac
	call $53cd		; $53ad
	ret c			; $53b0
	jr z,_label_07_143	; $53b1
	call $6220		; $53b3
	jr c,_label_07_144	; $53b6
	call $4a6b		; $53b8
	jp c,itemDelete		; $53bb
_label_07_143:
	jp $5434		; $53be
_label_07_144:
	ld h,d			; $53c1
	ld l,$04		; $53c2
	ld (hl),$01		; $53c4
	ld l,$2f		; $53c6
	res 6,(hl)		; $53c8
	jp $5434		; $53ca
	push bc			; $53cd
	ld a,($cc50)		; $53ce
	and $20			; $53d1
	jr z,_label_07_145	; $53d3
	ld e,$0b		; $53d5
	ld a,(de)		; $53d7
	sub $08			; $53d8
	cp $f0			; $53da
	ccf			; $53dc
	jr c,_label_07_146	; $53dd
_label_07_145:
	call objectCheckWithinRoomBoundary		; $53df
_label_07_146:
	pop bc			; $53e2
	jr nc,_label_07_147	; $53e3
	call $4b24		; $53e5
	ret nc			; $53e8
	ld bc,$04ef		; $53e9
	ld a,($cc49)		; $53ec
	cp b			; $53ef
	jr nz,_label_07_147	; $53f0
	ld a,($cc4c)		; $53f2
	cp c			; $53f5
	jr nz,_label_07_147	; $53f6
	ld a,$01		; $53f8
	ld ($cfc0),a		; $53fa
_label_07_147:
	call itemDelete		; $53fd
	scf			; $5400
	ret			; $5401
_label_07_148:
	ld h,d			; $5402
	ld l,$21		; $5403
	ld a,(hl)		; $5405
	bit 7,a			; $5406
	jp nz,itemDelete		; $5408
	ld l,$24		; $540b
	bit 6,a			; $540d
	jr z,_label_07_149	; $540f
	ld (hl),$00		; $5411
_label_07_149:
	ld c,(hl)		; $5413
	ld l,$26		; $5414
	and $1f			; $5416
	ldi (hl),a		; $5418
	ldi (hl),a		; $5419
	bit 7,c			; $541a
	call nz,$5494		; $541c
	ld h,d			; $541f
	ld l,$06		; $5420
	bit 7,(hl)		; $5422
	call z,$54db		; $5424
	jp $49c1		; $5427
	ld h,d			; $542a
	ld l,$04		; $542b
	ld a,(hl)		; $542d
	cp $ff			; $542e
	jr nz,_label_07_150	; $5430
	jr _label_07_148		; $5432
	call $49c1		; $5434
	ld e,$21		; $5437
	ld a,(de)		; $5439
	or a			; $543a
	ret z			; $543b
_label_07_150:
	ld h,d			; $543c
	ld l,$1b		; $543d
	ld a,$0a		; $543f
	ldi (hl),a		; $5441
	ldi (hl),a		; $5442
	ld (hl),$0c		; $5443
	ld l,$24		; $5445
	set 7,(hl)		; $5447
	ld a,$0c		; $5449
	call cpActiveRing		; $544b
	jr nz,_label_07_151	; $544e
	ld l,$28		; $5450
	dec (hl)		; $5452
	dec (hl)		; $5453
_label_07_151:
	ld l,$04		; $5454
	ld (hl),$ff		; $5456
	ld l,$06		; $5458
	ld (hl),$08		; $545a
	ld l,$2f		; $545c
	ld a,(hl)		; $545e
	or $50			; $545f
	ld (hl),a		; $5461
	ld l,$01		; $5462
	ldd a,(hl)		; $5464
	res 1,(hl)		; $5465
	cp $03			; $5467
	ld a,$01		; $5469
	jr z,_label_07_152	; $546b
	ld a,$06		; $546d
_label_07_152:
	call $49ca		; $546f
	call objectSetVisible80		; $5472
	ld a,$6f		; $5475
	call playSound		; $5477
	or d			; $547a
	ret			; $547b
	ld h,d			; $547c
	ld l,$37		; $547d
	bit 7,(hl)		; $547f
	ret nz			; $5481
	set 7,(hl)		; $5482
	call decNumBombs		; $5484
	call $497b		; $5487
	call $4a37		; $548a
	xor a			; $548d
	call $49ca		; $548e
	jp objectSetVisiblec1		; $5491
	ld h,d			; $5494
	ld l,$37		; $5495
	bit 6,(hl)		; $5497
	ret nz			; $5499
	ld a,($d101)		; $549a
	cp $0a			; $549d
	ret z			; $549f
	ld a,$30		; $54a0
	call cpActiveRing		; $54a2
	ret z			; $54a5
	call checkLinkVulnerable		; $54a6
	ret nc			; $54a9
	ld h,d			; $54aa
	ld l,$26		; $54ab
	ld a,(hl)		; $54ad
	ld c,a			; $54ae
	add a			; $54af
	ld b,a			; $54b0
	ld l,$0f		; $54b1
	ld a,($d00f)		; $54b3
	sub (hl)		; $54b6
	add c			; $54b7
	cp b			; $54b8
	ret nc			; $54b9
	call objectCheckCollidedWithLink_ignoreZ		; $54ba
	ret nc			; $54bd
	call objectGetLinkRelativeAngle		; $54be
	ld h,d			; $54c1
	ld l,$37		; $54c2
	set 6,(hl)		; $54c4
	ld l,$28		; $54c6
	ld c,(hl)		; $54c8
	ld hl,$d025		; $54c9
	ld (hl),c		; $54cc
	ld l,$2d		; $54cd
	ld (hl),$0c		; $54cf
	dec l			; $54d1
	ldd (hl),a		; $54d2
	ld (hl),$10		; $54d3
	dec l			; $54d5
	ld (hl),$01		; $54d6
	jp linkApplyDamage		; $54d8
	ld a,(hl)		; $54db
	dec (hl)		; $54dc
	ld l,a			; $54dd
	add a			; $54de
	add l			; $54df
	ld hl,$551f		; $54e0
	rst_addAToHl			; $54e3
	ld a,($cc50)		; $54e4
	and $20			; $54e7
	ld e,$0f		; $54e9
	ld a,(de)		; $54eb
	jr nz,_label_07_153	; $54ec
	sub $02			; $54ee
	cp (hl)			; $54f0
	ret c			; $54f1
	xor a			; $54f2
_label_07_153:
	ld c,a			; $54f3
	inc hl			; $54f4
	ldi a,(hl)		; $54f5
	add c			; $54f6
	ld b,a			; $54f7
	ld a,(hl)		; $54f8
	ld c,a			; $54f9
	ld h,d			; $54fa
	ld e,$00		; $54fb
	bit 7,b			; $54fd
	jr z,_label_07_154	; $54ff
	dec e			; $5501
_label_07_154:
	ld l,$0b		; $5502
	ldi a,(hl)		; $5504
	add b			; $5505
	ld b,a			; $5506
	ld a,$00		; $5507
	adc e			; $5509
	ret nz			; $550a
	inc l			; $550b
	ld e,$00		; $550c
	bit 7,c			; $550e
	jr z,_label_07_155	; $5510
	dec e			; $5512
_label_07_155:
	ld a,(hl)		; $5513
	add c			; $5514
	ld c,a			; $5515
	ld a,$00		; $5516
	adc e			; $5518
	ret nz			; $5519
	ld a,$04		; $551a
	jp tryToBreakTile		; $551c
	ld hl,sp-$0d		; $551f
	di			; $5521
	ld hl,sp+$0c		; $5522
	di			; $5524
	ld hl,sp+$0c		; $5525
	inc c			; $5527
	ld hl,sp-$0d		; $5528
	inc c			; $552a
.DB $f4				; $552b
	nop			; $552c
	di			; $552d
.DB $f4				; $552e
	inc c			; $552f
	nop			; $5530
.DB $f4				; $5531
	nop			; $5532
	inc c			; $5533
.DB $f4				; $5534
	di			; $5535
	nop			; $5536
	ld a,($ff00+c)		; $5537
	nop			; $5538
	nop			; $5539

; ITEMID_BOOMERANG
itemCode06:
	ld e,$04		; $553a
	ld a,(de)		; $553c
	rst_jumpTable			; $553d
	ld c,b			; $553e
	ld d,l			; $553f
	sub b			; $5540
	ld d,l			; $5541
	rst $20			; $5542
	ld d,l			; $5543
	ld hl,sp+$55		; $5544
	inc d			; $5546
	ld d,(hl)		; $5547
	call $497b		; $5548
	ld e,$02		; $554b
	ld a,(de)		; $554d
	add $18			; $554e
	call loadWeaponGfx		; $5550
	call itemIncState		; $5553
	ld bc,$4128		; $5556
	ld l,$02		; $5559
	bit 0,(hl)		; $555b
	jr z,_label_07_156	; $555d
	ld l,$24		; $555f
	ld (hl),$96		; $5561
	ld l,$1b		; $5563
	ld a,$0c		; $5565
	ldi (hl),a		; $5567
	ldi (hl),a		; $5568
	ld bc,$5f78		; $5569
_label_07_156:
	ld l,$10		; $556c
	ld (hl),b		; $556e
	ld l,$06		; $556f
	ld (hl),c		; $5571
	ld c,$ff		; $5572
	ld a,$0d		; $5574
	call cpActiveRing		; $5576
	jr z,_label_07_157	; $5579
	ld a,$29		; $557b
	call cpActiveRing		; $557d
	jr nz,_label_07_158	; $5580
	ld c,$fe		; $5582
_label_07_157:
	ld l,$28		; $5584
	ld a,(hl)		; $5586
	add c			; $5587
	ld (hl),a		; $5588
_label_07_158:
	call objectSetVisible82		; $5589
	xor a			; $558c
	jp $49ca		; $558d
	call $5638		; $5590
	ld e,$2a		; $5593
	ld a,(de)		; $5595
	or a			; $5596
	jr nz,_label_07_160	; $5597
	call objectCheckTileCollision_allowHoles		; $5599
	jr nc,_label_07_159	; $559c
	call $4b7d		; $559e
	jr nz,_label_07_162	; $55a1
_label_07_159:
	call objectCheckWithinRoomBoundary		; $55a3
	jr nc,_label_07_160	; $55a6
	ld e,$34		; $55a8
	ld a,(de)		; $55aa
	call objectNudgeAngleTowards		; $55ab
	call itemDecCounter1		; $55ae
	jr nz,_label_07_165	; $55b1
_label_07_160:
	call objectGetLinkRelativeAngle		; $55b3
	ld c,a			; $55b6
	ld h,d			; $55b7
	ld l,$0b		; $55b8
	ld a,$f0		; $55ba
	cp (hl)			; $55bc
	jr c,_label_07_161	; $55bd
	ld l,$0d		; $55bf
	cp (hl)			; $55c1
	jr c,_label_07_161	; $55c2
	ld l,$09		; $55c4
	ld a,c			; $55c6
	sub (hl)		; $55c7
	add $08			; $55c8
	cp $11			; $55ca
	jr c,_label_07_163	; $55cc
_label_07_161:
	ld l,$09		; $55ce
	ld (hl),c		; $55d0
	jr _label_07_163		; $55d1
_label_07_162:
	call $4b69		; $55d3
	ld h,d			; $55d6
	ld l,$09		; $55d7
	ld a,(hl)		; $55d9
	xor $10			; $55da
	ld (hl),a		; $55dc
_label_07_163:
	ld l,$04		; $55dd
	inc (hl)		; $55df
	ld l,$16		; $55e0
	xor a			; $55e2
	ldi (hl),a		; $55e3
	ld (hl),a		; $55e4
	jr _label_07_165		; $55e5
	call objectGetLinkRelativeAngle		; $55e7
	call objectNudgeAngleTowards		; $55ea
	ld bc,setTileWithoutGfxReload		; $55ed
	call $5642		; $55f0
	call c,itemIncState		; $55f3
	jr _label_07_164		; $55f6
	call objectGetLinkRelativeAngle		; $55f8
	ld e,$09		; $55fb
	ld (de),a		; $55fd
	ld bc,$0402		; $55fe
	call $5642		; $5601
	jr nc,_label_07_164	; $5604
	call itemIncState		; $5606
	ld l,$06		; $5609
	ld (hl),$04		; $560b
	ld l,$24		; $560d
	ld (hl),$00		; $560f
	jp objectSetInvisible		; $5611
	call itemDecCounter1		; $5614
	jp z,itemDelete		; $5617
	ld a,($cc48)		; $561a
	ld h,a			; $561d
	ld l,$0b		; $561e
	jp objectTakePosition		; $5620
_label_07_164:
	call $5638		; $5623
_label_07_165:
	call objectApplySpeed		; $5626
	ld h,d			; $5629
	ld l,$21		; $562a
	ld a,(hl)		; $562c
	or a			; $562d
	ld (hl),$00		; $562e
	ld a,$78		; $5630
	call nz,playSound		; $5632
	jp $49c1		; $5635
	ld e,$02		; $5638
	ld a,(de)		; $563a
	or a			; $563b
	ret z			; $563c
	ld a,$07		; $563d
	jp itemTryToBreakTile		; $563f
	ld hl,$d00b		; $5642
	ld e,$0b		; $5645
	ld a,(de)		; $5647
	sub (hl)		; $5648
	add c			; $5649
	cp b			; $564a
	ret nc			; $564b
	ld l,$0d		; $564c
	ld e,$0d		; $564e
	ld a,(de)		; $5650
	sub (hl)		; $5651
	add c			; $5652
	cp b			; $5653
	ret			; $5654

; ITEMID_RICKY_TORNADO
itemCode2a:
	ld e,$04		; $5655
	ld a,(de)		; $5657
	rst_jumpTable			; $5658
	ld e,l			; $5659
	ld d,(hl)		; $565a
	sub c			; $565b
	ld d,(hl)		; $565c
	call itemIncState		; $565d
	ld l,$10		; $5660
	ld (hl),$78		; $5662
	ld a,($d108)		; $5664
	ld c,a			; $5667
	swap a			; $5668
	rrca			; $566a
	ld l,$09		; $566b
	ld (hl),a		; $566d
	ld a,c			; $566e
	ld hl,$5689		; $566f
	rst_addDoubleIndex			; $5672
	ldi a,(hl)		; $5673
	ld c,(hl)		; $5674
	ld b,a			; $5675
	ld hl,$d10b		; $5676
	call objectTakePositionWithOffset		; $5679
	sub $02			; $567c
	ld (de),a		; $567e
	call $497b		; $567f
	xor a			; $5682
	call $49ca		; $5683
	jp objectSetVisiblec1		; $5686
	ld a,($ff00+$00)	; $5689
	nop			; $568b
	inc c			; $568c
	ld ($0000),sp		; $568d
.DB $f4				; $5690
	call objectApplySpeed		; $5691
	ld a,$01		; $5694
	call itemTryToBreakTile		; $5696
	call objectGetTileCollisions		; $5699
	and $0f			; $569c
	cp $0f			; $569e
	jp z,itemDelete		; $56a0
	jp $49c1		; $56a3

; ITEMID_29
itemCode29:
	ld e,$04		; $56a6
	ld a,(de)		; $56a8
	rst_jumpTable			; $56a9
	or b			; $56aa
	ld d,(hl)		; $56ab
	ld ($ff00+$56),a	; $56ac
	ld c,e			; $56ae
	ld e,b			; $56af
	ld a,$01		; $56b0
	ld (de),a		; $56b2
	ld h,d			; $56b3
	ld l,$10		; $56b4
	ld (hl),$0a		; $56b6
	ld l,$0b		; $56b8
	ld a,(hl)		; $56ba
	ld b,a			; $56bb
	ld l,$0d		; $56bc
	ld a,(hl)		; $56be
	ld l,$31		; $56bf
	ldd (hl),a		; $56c1
	ld (hl),b		; $56c2
	call $497b		; $56c3
	xor a			; $56c6
	call $49ca		; $56c7
	call objectSetVisiblec3		; $56ca
	ld a,($cc49)		; $56cd
	cp $04			; $56d0
	jr nz,_label_07_166	; $56d2
	ld a,($cc4c)		; $56d4
	cp $94			; $56d7
	jr nz,_label_07_166	; $56d9
	ld e,$03		; $56db
	ld a,$01		; $56dd
	ld (de),a		; $56df
_label_07_166:
	call $56ef		; $56e0
	call $590f		; $56e3
	ld e,$24		; $56e6
	ld a,(de)		; $56e8
	bit 7,a			; $56e9
	ret nz			; $56eb
	jp $5a06		; $56ec
	ld h,d			; $56ef
	ld l,$03		; $56f0
	ld a,(hl)		; $56f2
	or a			; $56f3
	jr nz,_label_07_167	; $56f4
	ld l,$24		; $56f6
	res 7,(hl)		; $56f8
_label_07_167:
	call $5a28		; $56fa
	call $5a5e		; $56fd
	ld a,($cc79)		; $5700
	or a			; $5703
	jp z,$57bd		; $5704
	ld b,$0c		; $5707
	call objectCheckCenteredWithLink		; $5709
	jp nc,$57bd		; $570c
	call objectGetLinkRelativeAngle		; $570f
	add $04			; $5712
	add a			; $5714
	swap a			; $5715
	and $03			; $5717
	xor $02			; $5719
	ld b,a			; $571b
	ld a,($d008)		; $571c
	cp b			; $571f
	jp nz,$57bd		; $5720
	ld e,$10		; $5723
	ld a,$28		; $5725
	ld (de),a		; $5727
	ld e,$32		; $5728
	ld a,(de)		; $572a
	or a			; $572b
	jr z,_label_07_168	; $572c
	inc e			; $572e
	ld a,(de)		; $572f
	cp $10			; $5730
	jp nc,$57bd		; $5732
	inc e			; $5735
	ld a,(de)		; $5736
	cp $10			; $5737
	jp nc,$57bd		; $5739
	ld e,$32		; $573c
	xor a			; $573e
	ld (de),a		; $573f
_label_07_168:
	ld a,($cc79)		; $5740
	bit 1,a			; $5743
	jr nz,_label_07_170	; $5745
	ld a,($d008)		; $5747
	ld hl,$587b		; $574a
	rst_addDoubleIndex			; $574d
	ld a,($d00b)		; $574e
	add (hl)		; $5751
	ldh (<hFF8D),a	; $5752
	inc hl			; $5754
	ld a,($d00d)		; $5755
	add (hl)		; $5758
	ldh (<hFF8C),a	; $5759
	push bc			; $575b
	call $5842		; $575c
	pop bc			; $575f
	jp c,$5806		; $5760
	bit 0,b			; $5763
	jr nz,_label_07_169	; $5765
	call $588d		; $5767
	ld e,$04		; $576a
	ld a,(de)		; $576c
	cp $01			; $576d
	ret nz			; $576f
	call $5972		; $5770
	call $594e		; $5773
	jp $5883		; $5776
_label_07_169:
	call $5883		; $5779
	ld e,$04		; $577c
	ld a,(de)		; $577e
	cp $01			; $577f
	ret nz			; $5781
	call $5979		; $5782
	call $5966		; $5785
	jp $588d		; $5788
_label_07_170:
	ld a,($d00b)		; $578b
	ldh (<hFF8D),a	; $578e
	ld a,($d00d)		; $5790
	ldh (<hFF8C),a	; $5793
	bit 0,b			; $5795
	jr nz,_label_07_171	; $5797
	call $588d		; $5799
	ld e,$04		; $579c
	ld a,(de)		; $579e
	cp $01			; $579f
	ret nz			; $57a1
	call $5972		; $57a2
	call $594e		; $57a5
	jp $5897		; $57a8
_label_07_171:
	call $5883		; $57ab
	ld e,$04		; $57ae
	ld a,(de)		; $57b0
	cp $01			; $57b1
	ret nz			; $57b3
	call $5979		; $57b4
	call $5966		; $57b7
	jp $58a1		; $57ba
	ld e,$33		; $57bd
	ld a,(de)		; $57bf
	or a			; $57c0
	jr z,_label_07_172	; $57c1
	ld e,$32		; $57c3
	ld a,$01		; $57c5
	ld (de),a		; $57c7
	call $5980		; $57c8
	call $5980		; $57cb
	call $594e		; $57ce
	ld e,$09		; $57d1
	ld a,(de)		; $57d3
	call $58c3		; $57d4
_label_07_172:
	ld e,$34		; $57d7
	ld a,(de)		; $57d9
	or a			; $57da
	jr z,_label_07_173	; $57db
	ld e,$32		; $57dd
	ld a,$01		; $57df
	ld (de),a		; $57e1
	call $598f		; $57e2
	call $598f		; $57e5
	call $5966		; $57e8
	ld e,$09		; $57eb
	ld a,(de)		; $57ed
	call $58c3		; $57ee
_label_07_173:
	call objectCheckIsOnHazard		; $57f1
	jp c,$57f8		; $57f4
	ret			; $57f7
	ldh (<hFF8B),a	; $57f8
	call $5a1f		; $57fa
	ldh a,(<hFF8B)	; $57fd
	dec a			; $57ff
	jp z,objectReplaceWithSplash		; $5800
	jp objectReplaceWithFallingDownHoleInteraction		; $5803
	xor a			; $5806
	ld e,$33		; $5807
	ld (de),a		; $5809
	ld e,$34		; $580a
	ld (de),a		; $580c
	ld a,($cc47)		; $580d
	cp $ff			; $5810
	ret z			; $5812
	ld a,($cc45)		; $5813
	ld b,a			; $5816
	bit 6,b			; $5817
	jr z,_label_07_174	; $5819
	ld a,$00		; $581b
	call $583c		; $581d
	jr _label_07_175		; $5820
_label_07_174:
	bit 7,b			; $5822
	jr z,_label_07_175	; $5824
	ld a,$10		; $5826
	call $583c		; $5828
_label_07_175:
	ld a,($cc45)		; $582b
	ld b,a			; $582e
	bit 4,b			; $582f
	jr z,_label_07_176	; $5831
	ld a,$08		; $5833
	jr _label_07_177		; $5835
_label_07_176:
	bit 5,b			; $5837
	ld a,$18		; $5839
	ret z			; $583b
_label_07_177:
	ld e,$09		; $583c
	ld (de),a		; $583e
	jp $58c3		; $583f
	ldh a,(<hFF8D)	; $5842
	ld b,a			; $5844
	ldh a,(<hFF8C)	; $5845
	ld c,a			; $5847
	jp objectCheckContainsPoint		; $5848
	ld h,d			; $584b
	ld l,$24		; $584c
	set 7,(hl)		; $584e
	ld l,$08		; $5850
	ldi a,(hl)		; $5852
	ld (hl),a		; $5853
	call objectApplySpeed		; $5854
	ld c,$20		; $5857
	call objectUpdateSpeedZ_paramC		; $5859
	ret nz			; $585c
	ld a,$77		; $585d
	call playSound		; $585f
	ld h,d			; $5862
	ld l,$06		; $5863
	dec (hl)		; $5865
	jr z,_label_07_178	; $5866
	ld bc,$ff20		; $5868
	ld l,$14		; $586b
	ld (hl),c		; $586d
	inc l			; $586e
	ld (hl),b		; $586f
	ld l,$10		; $5870
	ld (hl),$14		; $5872
	ret			; $5874
_label_07_178:
	ld a,$01		; $5875
	ld e,$04		; $5877
	ld (de),a		; $5879
	ret			; $587a
	ld a,($ff00+$00)	; $587b
	nop			; $587d
	stop			; $587e
	stop			; $587f
	nop			; $5880
	nop			; $5881
	ld a,($ff00+$06)	; $5882
	nop			; $5884
	ld c,$10		; $5885
	call $58ab		; $5887
	ret z			; $588a
	jr _label_07_181		; $588b
	ld b,$18		; $588d
	ld c,$08		; $588f
	call $58bb		; $5891
	ret z			; $5894
	jr _label_07_181		; $5895
	ld b,$10		; $5897
	ld c,$00		; $5899
	call $58ab		; $589b
	ret z			; $589e
	jr _label_07_181		; $589f
	ld b,$08		; $58a1
	ld c,$18		; $58a3
	call $58bb		; $58a5
	ret z			; $58a8
	jr _label_07_181		; $58a9
	ldh a,(<hFF8D)	; $58ab
	ld l,$0b		; $58ad
	ld e,$33		; $58af
_label_07_179:
	ld h,d			; $58b1
	cp (hl)			; $58b2
	ld a,b			; $58b3
	jr c,_label_07_180	; $58b4
	ld a,c			; $58b6
_label_07_180:
	ld l,$09		; $58b7
	ld (hl),a		; $58b9
	ret			; $58ba
	ldh a,(<hFF8C)	; $58bb
	ld l,$0d		; $58bd
	ld e,$34		; $58bf
	jr _label_07_179		; $58c1
_label_07_181:
	srl a			; $58c3
	ld hl,$58ff		; $58c5
	rst_addAToHl			; $58c8
	call $58ed		; $58c9
	jr c,_label_07_182	; $58cc
	call $58ed		; $58ce
	jr c,_label_07_182	; $58d1
	ld h,d			; $58d3
	ld l,$24		; $58d4
	set 7,(hl)		; $58d6
	call objectApplySpeed		; $58d8
	jr _label_07_184		; $58db
_label_07_182:
	call $59a9		; $58dd
	ld e,$09		; $58e0
	ld a,(de)		; $58e2
	bit 3,a			; $58e3
	ld e,$33		; $58e5
	jr z,_label_07_183	; $58e7
	inc e			; $58e9
_label_07_183:
	xor a			; $58ea
	ld (de),a		; $58eb
	ret			; $58ec
	ld e,$0b		; $58ed
	ld a,(de)		; $58ef
	add (hl)		; $58f0
	inc hl			; $58f1
	ld b,a			; $58f2
	ld e,$0d		; $58f3
	ld a,(de)		; $58f5
	add (hl)		; $58f6
	inc hl			; $58f7
	ld c,a			; $58f8
	push hl			; $58f9
	call checkTileCollisionAt_allowHoles		; $58fa
	pop hl			; $58fd
	ret			; $58fe
	ld hl,sp-$04		; $58ff
	ld hl,sp+$04		; $5901
.DB $fc				; $5903
	ld ($0804),sp		; $5904
	ld ($08fc),sp		; $5907
	inc b			; $590a
.DB $fc				; $590b
	ld hl,sp+$04		; $590c
	ld hl,sp-$33		; $590e
	ldd (hl),a		; $5910
	inc d			; $5911
	ld hl,hazardCollisionTable		; $5912
	call lookupCollisionTable		; $5915
	ret nc			; $5918
	call objectGetPosition		; $5919
	ld a,$05		; $591c
	add b			; $591e
	ld b,a			; $591f
	call checkTileCollisionAt_allowHoles		; $5920
	ret nc			; $5923
	ld b,$14		; $5924
	call $5961		; $5926
	ld e,$09		; $5929
	xor a			; $592b
	ld (de),a		; $592c
	jp objectApplySpeed		; $592d
_label_07_184:
	ld bc,$a8e8		; $5930
	ld e,$08		; $5933
	ld h,d			; $5935
	ld l,$0b		; $5936
	ld a,e			; $5938
	cp (hl)			; $5939
	jr c,_label_07_185	; $593a
	ld (hl),a		; $593c
_label_07_185:
	ld a,b			; $593d
	cp (hl)			; $593e
	jr nc,_label_07_186	; $593f
	ld (hl),a		; $5941
_label_07_186:
	ld l,$0d		; $5942
	ld a,e			; $5944
	cp (hl)			; $5945
	jr c,_label_07_187	; $5946
	ld (hl),a		; $5948
_label_07_187:
	ld a,c			; $5949
	cp (hl)			; $594a
	ret nc			; $594b
	ld (hl),a		; $594c
	ret			; $594d
	ld e,$33		; $594e
_label_07_188:
	ld a,(de)		; $5950
	cp $40			; $5951
	ld b,$78		; $5953
	jr nc,_label_07_189	; $5955
	and $38			; $5957
	swap a			; $5959
	rlca			; $595b
	ld hl,$596a		; $595c
	rst_addAToHl			; $595f
	ld b,(hl)		; $5960
_label_07_189:
	ld a,b			; $5961
	ld e,$10		; $5962
	ld (de),a		; $5964
	ret			; $5965
	ld e,$34		; $5966
	jr _label_07_188		; $5968
	ld a,(bc)		; $596a
	inc d			; $596b
	jr z,_label_07_192	; $596c
	inc a			; $596e
	ld b,(hl)		; $596f
	ld d,b			; $5970
	ld d,b			; $5971
	ld h,d			; $5972
	ld l,$33		; $5973
	inc (hl)		; $5975
	ret nz			; $5976
	dec (hl)		; $5977
	ret			; $5978
	ld h,d			; $5979
	ld l,$34		; $597a
	inc (hl)		; $597c
	ret nz			; $597d
	dec (hl)		; $597e
	ret			; $597f
	ld l,$33		; $5980
_label_07_190:
	ld h,d			; $5982
	ld a,(hl)		; $5983
	cp $40			; $5984
	jr c,_label_07_191	; $5986
	ld a,$40		; $5988
_label_07_191:
	or a			; $598a
	ret z			; $598b
	dec a			; $598c
	ld (hl),a		; $598d
	ret			; $598e
	ld l,$34		; $598f
	jr _label_07_190		; $5991
	ld e,$0b		; $5993
	ld a,(de)		; $5995
	add (hl)		; $5996
	inc hl			; $5997
	ld b,a			; $5998
	ld e,$0d		; $5999
	ld a,(de)		; $599b
	add (hl)		; $599c
	inc hl			; $599d
	ld c,a			; $599e
	push hl			; $599f
_label_07_192:
	call getTileAtPosition		; $59a0
	pop hl			; $59a3
	sub $b0			; $59a4
	cp $04			; $59a6
	ret			; $59a8
	call $59fb		; $59a9
	add a			; $59ac
	ld hl,$58ff		; $59ad
	rst_addDoubleIndex			; $59b0
	call $5993		; $59b1
	ret nc			; $59b4
	call $5993		; $59b5
	ret nc			; $59b8
	add $02			; $59b9
	and $03			; $59bb
	swap a			; $59bd
	rrca			; $59bf
	ld b,a			; $59c0
	ld e,$09		; $59c1
	ld a,(de)		; $59c3
	cp b			; $59c4
	ret nz			; $59c5
	sra a			; $59c6
	ld hl,$59eb		; $59c8
	rst_addAToHl			; $59cb
	ldi a,(hl)		; $59cc
	ld e,$08		; $59cd
	ld (de),a		; $59cf
	ldi a,(hl)		; $59d0
	ld e,$10		; $59d1
	ld (de),a		; $59d3
	ldi a,(hl)		; $59d4
	ld e,$14		; $59d5
	ld (de),a		; $59d7
	inc e			; $59d8
	ld a,(hl)		; $59d9
	ld (de),a		; $59da
	xor a			; $59db
	ld h,d			; $59dc
	ld l,$32		; $59dd
	ldi (hl),a		; $59df
	ldi (hl),a		; $59e0
	ld (hl),a		; $59e1
	ld l,$06		; $59e2
	ld (hl),$02		; $59e4
	ld l,$04		; $59e6
	ld (hl),$02		; $59e8
	ret			; $59ea
	nop			; $59eb
	jr z,_label_07_194	; $59ec
	cp $08			; $59ee
	jr z,_label_07_195	; $59f0
	cp $10			; $59f2
	jr z,_label_07_197	; $59f4
	cp $18			; $59f6
	jr z,_label_07_198	; $59f8
	cp $1e			; $59fa
	add hl,bc		; $59fc
	ld a,(de)		; $59fd
	add $04			; $59fe
	add a			; $5a00
	swap a			; $5a01
	and $03			; $5a03
	ret			; $5a05
	ld hl,$d080		; $5a06
_label_07_193:
	ld a,(hl)		; $5a09
	or a			; $5a0a
	call nz,$5a15		; $5a0b
	inc h			; $5a0e
	ld a,h			; $5a0f
	cp $e0			; $5a10
	jr c,_label_07_193	; $5a12
	ret			; $5a14
	push hl			; $5a15
	ld l,$8f		; $5a16
	bit 7,(hl)		; $5a18
	call z,preventObjectHFromPassingObjectD		; $5a1a
	pop hl			; $5a1d
	ret			; $5a1e
	ld e,$30		; $5a1f
	ld a,(de)		; $5a21
	ld b,a			; $5a22
	inc e			; $5a23
	ld a,(de)		; $5a24
	ld c,a			; $5a25
	jr _label_07_196		; $5a26
	call objectCheckIsOnHazard		; $5a28
	ret c			; $5a2b
	ld e,$0b		; $5a2c
_label_07_194:
	ld a,(de)		; $5a2e
	ld b,a			; $5a2f
	ld e,$0d		; $5a30
_label_07_195:
	ld a,(de)		; $5a32
	ld c,a			; $5a33
_label_07_196:
	ld e,$16		; $5a34
_label_07_197:
	ld a,(de)		; $5a36
	ld l,a			; $5a37
	inc e			; $5a38
	ld a,(de)		; $5a39
_label_07_198:
	ld h,a			; $5a3a
	push bc			; $5a3b
	ld bc,$0004		; $5a3c
	add hl,bc		; $5a3f
	pop bc			; $5a40
	ld a,b			; $5a41
	cp $18			; $5a42
	jr nc,_label_07_199	; $5a44
	ld a,$18		; $5a46
_label_07_199:
	cp $99			; $5a48
	jr c,_label_07_200	; $5a4a
	ld a,$98		; $5a4c
_label_07_200:
	ldi (hl),a		; $5a4e
	ld a,c			; $5a4f
	cp $18			; $5a50
	jr nc,_label_07_201	; $5a52
	ld a,$18		; $5a54
_label_07_201:
	cp $d9			; $5a56
	jr c,_label_07_202	; $5a58
	ld a,$d8		; $5a5a
_label_07_202:
	ld (hl),a		; $5a5c
	ret			; $5a5d
	ld a,($cc77)		; $5a5e
	rlca			; $5a61
	ret c			; $5a62
	ld a,($d004)		; $5a63
	cp $01			; $5a66
	ret nz			; $5a68
	call objectCheckCollidedWithLink_ignoreZ		; $5a69
	ret nc			; $5a6c
	ld a,($d00b)		; $5a6d
	ld b,a			; $5a70
	ld a,($d00d)		; $5a71
	ld c,a			; $5a74
	call objectCheckContainsPoint		; $5a75
	jr c,_label_07_203	; $5a78
	call objectGetLinkRelativeAngle		; $5a7a
	ld c,a			; $5a7d
	ld b,$78		; $5a7e
	jp updateLinkPositionGivenVelocity		; $5a80
_label_07_203:
	call objectGetLinkRelativeAngle		; $5a83
	ld c,a			; $5a86
	ld b,$14		; $5a87
	jp updateLinkPositionGivenVelocity		; $5a89

; ITEMID_28
itemCode28:
	ld e,$04		; $5a8c
	ld a,(de)		; $5a8e
	or a			; $5a8f
	jr nz,_label_07_204	; $5a90
	call itemIncState		; $5a92
	ld l,$06		; $5a95
	ld (hl),$14		; $5a97
	call $497b		; $5a99
	jr _label_07_205		; $5a9c
_label_07_204:
	call $5aab		; $5a9e
	call $5ad4		; $5aa1
	call itemDecCounter1		; $5aa4
	ret nz			; $5aa7
	jp itemDelete		; $5aa8
_label_07_205:
	ld a,($d101)		; $5aab
	cp $0b			; $5aae
	ld hl,$5ad0		; $5ab0
	jr nz,_label_07_206	; $5ab3
	ld a,($d108)		; $5ab5
	add a			; $5ab8
	ld hl,$5ac0		; $5ab9
	rst_addDoubleIndex			; $5abc
_label_07_206:
	jp $5e5a		; $5abd
	stop			; $5ac0
	inc c			; $5ac1
.DB $f4				; $5ac2
	nop			; $5ac3
	inc c			; $5ac4
	ld (de),a		; $5ac5
	cp $08			; $5ac6
	stop			; $5ac8
	inc c			; $5ac9
	ld ($0c00),sp		; $5aca
	ld (de),a		; $5acd
	cp $f8			; $5ace
	jr _label_07_208		; $5ad0
	stop			; $5ad2
	nop			; $5ad3
	ld hl,$5b03		; $5ad4
	ld a,($d101)		; $5ad7
	cp $0b			; $5ada
	jr z,_label_07_207	; $5adc
	ld hl,$5b0c		; $5ade
_label_07_207:
	ld e,$0b		; $5ae1
	ld a,(de)		; $5ae3
	add (hl)		; $5ae4
	ld b,a			; $5ae5
	inc hl			; $5ae6
	ld e,$0d		; $5ae7
	ld a,(de)		; $5ae9
_label_07_208:
	add (hl)		; $5aea
	ld c,a			; $5aeb
	inc hl			; $5aec
	push hl			; $5aed
	ld a,($d101)		; $5aee
	cp $0b			; $5af1
	ld a,$0f		; $5af3
	jr z,_label_07_209	; $5af5
	ld a,$11		; $5af7
_label_07_209:
	call tryToBreakTile		; $5af9
	pop hl			; $5afc
	ld a,(hl)		; $5afd
	cp $ff			; $5afe
	jr nz,_label_07_207	; $5b00
	ret			; $5b02
	ld hl,sp+$08		; $5b03
	ld hl,sp-$08		; $5b05
	ld ($0808),sp		; $5b07
	ld hl,sp-$01		; $5b0a
	nop			; $5b0c
	nop			; $5b0d
	ld a,($ff00+$f0)	; $5b0e
	ld a,($ff00+$00)	; $5b10
	ld a,($ff00+$10)	; $5b12
	nop			; $5b14
	ld a,($ff00+$00)	; $5b15
	stop			; $5b17
	stop			; $5b18
	ld a,($ff00+$10)	; $5b19
	nop			; $5b1b
	stop			; $5b1c
	stop			; $5b1d
	rst $38			; $5b1e

; ITEMID_SHOVEL
itemCode15:
	ld e,$04		; $5b1f
	ld a,(de)		; $5b21
	or a			; $5b22
	jr nz,_label_07_211	; $5b23
	call $497b		; $5b25
	call itemIncState		; $5b28
	ld l,$06		; $5b2b
	ld (hl),$04		; $5b2d
	ld a,$06		; $5b2f
	call itemTryToBreakTile		; $5b31
	ld a,$50		; $5b34
	jr nc,_label_07_210	; $5b36
	ld a,$01		; $5b38
	call addToGashaMaturity		; $5b3a
	ld a,$a9		; $5b3d
_label_07_210:
	jp playSound		; $5b3f
_label_07_211:
	call itemDecCounter1		; $5b42
	ret nz			; $5b45
	jp itemDelete		; $5b46

; ITEMID_ROD_OF_SEASONS
itemCode07:
	call $4a0a		; $5b49
	ld e,$04		; $5b4c
	ld a,(de)		; $5b4e
	rst_jumpTable			; $5b4f
	ld d,h			; $5b50
	ld e,e			; $5b51
	ld (hl),b		; $5b52
	ld e,e			; $5b53
	ld a,$01		; $5b54
	ld (de),a		; $5b56
	ld h,d			; $5b57
	ld l,$00		; $5b58
	ld (hl),$03		; $5b5a
	ld l,$06		; $5b5c
	ld (hl),$10		; $5b5e
	ld a,$74		; $5b60
	call playSound		; $5b62
	ld a,$1c		; $5b65
	call loadWeaponGfx		; $5b67
	call $497b		; $5b6a
	jp objectSetVisible82		; $5b6d
	ld h,d			; $5b70
	ld l,$06		; $5b71
	dec (hl)		; $5b73
	ret nz			; $5b74
	ld a,($ccb6)		; $5b75
	cp $08			; $5b78
	ret nz			; $5b7a
	call getFreeInteractionSlot		; $5b7b
	ret nz			; $5b7e
	ld (hl),$15		; $5b7f
	ld e,$09		; $5b81
	ld l,$49		; $5b83
	ld a,(de)		; $5b85
	ldi (hl),a		; $5b86
	jp objectCopyPosition		; $5b87

; ITEMID_MINECART_COLLISION
itemCode1d:
	ld e,$04		; $5b8a
	ld a,(de)		; $5b8c
	or a			; $5b8d
	ret nz			; $5b8e
	call $497b		; $5b8f
	call itemIncState		; $5b92
	ld l,$00		; $5b95
	set 1,(hl)		; $5b97
	ret			; $5b99

itemCode1dPost:
	ld hl,$d101		; $5b9a
	ld a,(hl)		; $5b9d
	cp $0a			; $5b9e
	jp z,objectTakePosition		; $5ba0
	jp itemDelete		; $5ba3

; ITEMID_SLINGSHOT
itemCode13:
	ld e,$04		; $5ba6
	ld a,(de)		; $5ba8
	or a			; $5ba9
	ret nz			; $5baa
	ld a,$1d		; $5bab
	call loadWeaponGfx		; $5bad
	call $4974		; $5bb0
	ld h,d			; $5bb3
	ld a,($c6b3)		; $5bb4
	or $08			; $5bb7
	ld l,$1b		; $5bb9
	ldi (hl),a		; $5bbb
	ld (hl),a		; $5bbc
	jp objectSetVisible81		; $5bbd
	ret			; $5bc0

; ITEMID_MAGNET_GLOVES
itemCode08:
	ld e,$04		; $5bc1
	ld a,(de)		; $5bc3
	rst_jumpTable			; $5bc4
	ret			; $5bc5
	ld e,e			; $5bc6
	call nc,$3e5b		; $5bc7
	ld e,$cd		; $5bca
	ld e,e			; $5bcc
	ld d,$cd		; $5bcd
	ld (hl),h		; $5bcf
	ld c,c			; $5bd0
	call objectSetVisible81		; $5bd1
	ld a,($cc79)		; $5bd4
	bit 1,a			; $5bd7
	ld a,$0c		; $5bd9
	jr z,_label_07_212	; $5bdb
	inc a			; $5bdd
_label_07_212:
	ld h,d			; $5bde
	ld l,$1b		; $5bdf
	ldi (hl),a		; $5be1
	ld (hl),a		; $5be2
	ret			; $5be3

; ITEMID_FOOLS_ORE
itemCode1e:
	ld e,$04		; $5be4
	ld a,(de)		; $5be6
	rst_jumpTable			; $5be7
.DB $ec				; $5be8
	ld e,e			; $5be9
	ret nz			; $5bea
	ld e,e			; $5beb
	ld a,$1f		; $5bec
	call loadWeaponGfx		; $5bee
	call $4974		; $5bf1
	xor a			; $5bf4
	call $49ca		; $5bf5
	jp objectSetVisible82		; $5bf8

; ITEMID_BIGGORON_SWORD
itemCode0c:
	ld e,$04		; $5bfb
	ld a,(de)		; $5bfd
	rst_jumpTable			; $5bfe
	inc bc			; $5bff
	ld e,h			; $5c00
	sbc c			; $5c01
	ld e,e			; $5c02
	ld a,$1b		; $5c03
	call loadWeaponGfx		; $5c05
	call $4974		; $5c08
	ld a,$b1		; $5c0b
	call playSound		; $5c0d
	jp objectSetVisible82		; $5c10

; ITEMID_SWORD
itemCode05:
	call $4a0a		; $5c13
	ld e,$04		; $5c16
	ld a,(de)		; $5c18
	rst_jumpTable			; $5c19
	jr nc,$5c		; $5c1a
	adc d			; $5c1c
	ld e,h			; $5c1d
	sub b			; $5c1e
	ld e,h			; $5c1f
	sub a			; $5c20
	ld e,h			; $5c21
	add l			; $5c22
	ld e,h			; $5c23
	and (hl)		; $5c24
	ld e,h			; $5c25
	ld b,(hl)		; $5c26
	ld e,h			; $5c27
	ld (hl),h		; $5c28
	ld (hl),l		; $5c29
	ld a,b			; $5c2a
	ld (hl),h		; $5c2b
	ld (hl),h		; $5c2c
	ld (hl),l		; $5c2d
	ld (hl),h		; $5c2e
	ld (hl),h		; $5c2f
	ld a,$1a		; $5c30
	call loadWeaponGfx		; $5c32
	call getRandomNumber_noPreserveVars		; $5c35
	and $07			; $5c38
	ld hl,$5c28		; $5c3a
	rst_addAToHl			; $5c3d
	ld a,(hl)		; $5c3e
	call playSound		; $5c3f
	ld e,$31		; $5c42
	xor a			; $5c44
	ld (de),a		; $5c45
	call $4974		; $5c46
	ld a,($c6ac)		; $5c49
	ld hl,$5c7d		; $5c4c
	rst_addDoubleIndex			; $5c4f
	ld e,$24		; $5c50
	ldi a,(hl)		; $5c52
	ld (de),a		; $5c53
	ld c,(hl)		; $5c54
	ld e,$31		; $5c55
	ld a,(de)		; $5c57
	or a			; $5c58
	ld a,c			; $5c59
	ld (de),a		; $5c5a
	jr nz,_label_07_213	; $5c5b





;
; VS64 generated Example was the starting point...
;

*=$0801
!byte $0c,$08,$b5,$07,$9e,$20,$32,$30,$36,$32,$00,$00,$00

    jmp     MAIN

*=$3000

!source     "src/c64_defs.asm"
!source     "src/c64_maths.asm"
!source     "src/c64_screen.asm"
!source     "src/cw4_raster.asm"
!source     "src/cw4_sprite.asm"

MAIN
    jsr     SCREEN_OFF
    jsr     ROM_CLR_SCREEN
;    jsr     SCREEN_SET_MULTI_COLOR_CHARACTER_MODE
    jsr     SCREEN_SET_HOZ_SCROLLING_38
    jsr     MATHS_SETUP_RNG
    jsr     RASTER_INTERRUPT_SETUP
    jsr     SPRITE_INIT

    ldy     #0

HELLO
    lda     .hellotext,y
    beq     +
    sta     SCREEN_RAM+15+SCREEN_WIDTH_CHARS,y
    lda     #PURPLE
    sta     COLOR_RAM+15+SCREEN_WIDTH_CHARS,y
    iny
    jmp     HELLO
+

    jsr     SCREEN_ON

HOLD
    jmp     HOLD

.hellotext
    !scr    "c-witchy-4",0



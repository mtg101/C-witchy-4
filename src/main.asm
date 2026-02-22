;
; VS64 generated Example was the starting point...
;

*=$0801
!byte $0c,$08,$b5,$07,$9e,$20,$32,$30,$36,$32,$00,$00,$00

    jmp     MAIN

; data in memory includes
!source     "src/cw4_sprite_data.asm"
!source     "src/cw4_tile_bg_data.asm"



; all the code no location specific data, bank 1 full 16k to use
*=$4000

!source     "src/c64_defs.asm"
!source     "src/c64_maths.asm"
!source     "src/c64_screen.asm"
!source     "src/cw4_raster.asm"
!source     "src/cw4_sprite.asm"
!source     "src/cw4_tile_bg.asm"

MAIN
    jsr     SCREEN_OFF
    jsr     ROM_CLR_SCREEN
    jsr     SCREEN_SET_HOZ_SCROLLING_38
    jsr     MATHS_SETUP_RNG
    jsr     RASTER_INTERRUPT_SETUP
    jsr     SPRITE_INIT
    jsr     SCREEN_CHAR_COPY_ROM_2800
    jsr     SCREEN_CHAR_SET_2800
    jsr     TILE_BG_SETUP
    jsr     SCREEN_ON

HOLD
    jmp     HOLD

; --- End of code section ---
!warn "Code ends at: ", *
!if * > $7FFF {
    !error "Code has hit the bank 1 boundary!"
}

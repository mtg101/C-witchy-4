;
; VS64 generated Example was the starting point...
;

*=$0801
!byte $0c,$08,$b5,$07,$9e,$20,$32,$30,$36,$32,$00,$00,$00

    jmp MAIN

; data in memory includes
!source "src/cw4_sprite_data.asm"
!source "src/cw4_tile_bg_data.asm"



; all the code no location specific data, bank 1 full 16k to use
*=$4000

!source     "src/c64_defs.asm"
!source     "src/c64_maths.asm"
!source     "src/c64_screen.asm"
!source     "src/c64_system.asm"
!source     "src/cw4_raster.asm"
!source     "src/cw4_sprite.asm"
!source     "src/cw4_tile_bg.asm"

MAIN
    jsr SCREEN_OFF
    lda 
    sta     VIC_CR2
    jsr     ROM_CLR_SCREEN
    jsr     MATHS_SETUP_RNG

    jsr SYS_NO_BASIC_NO_KERNEL_ROM  ; also does raster irq setup
    
    jsr     SPRITE_INIT
    jsr     SCREEN_CHAR_COPY_ROM_2800
    jsr     SCREEN_CHAR_SET_2800
    jsr     TILE_BG_SETUP
    jsr     SCREEN_ON


MAIN_LOOP
    ; is raster flag set?
    lda     RASTER_CHASE_BEAM
    beq     MAIN_LOOP           ; not time yet...





;;;    jsr     SPRITE_BOB      
;;;    jsr     TILE_BG_SCROLL


    ; clear raster flag
    lda     #$00
    sta     RASTER_CHASE_BEAM

    jmp     MAIN_LOOP


; the CR2 we need is all 0s for hi res, but we might want col mode later, so write like we need this...
CW4_CR2_0 = %00000111
CW4_CR2_1 = %00000110
CW4_CR2_2 = %00000101
CW4_CR2_3 = %00000100
CW4_CR2_4 = %00000011
CW4_CR2_5 = %00000010
CW4_CR2_6 = %00000001
CW4_CR2_7 = %00000000


FRAME_COUNTER
    !byte   $00


; --- End of code section ---
!warn "Code ends at: ", *
!if * > $7FFF {
    !error "Code has hit the bank 1 boundary!"
}


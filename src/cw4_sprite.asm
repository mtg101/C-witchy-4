





SPRITE_INIT
    ; disable sprite while we setup
    lda #$00
    sta SPR_ENABLE

    ; setup animated sprites
    jsr SPRITE_FRAME_0      

    ; static sprites
    ; shield
    lda #(witch_sprite_shield_tint / 64)
    sta SPR_PTR4

    lda #(witch_sprite_shield / 64)
    sta SPR_PTR5

    ; flames
    lda #(witch_sprite_flames_tint / 64)
    sta SPR_PTR6

    lda #(witch_sprite_flames / 64)
    sta SPR_PTR7

    ; sprite colours
    lda #BROWN
    sta SPR0_COLOR
    lda #PURPLE
    sta SPR1_COLOR
    lda #BLACK
    sta SPR2_COLOR
    sta SPR3_COLOR

    lda #CYAN
    sta SPR4_COLOR
    lda #LT_BLUE
    sta SPR5_COLOR

    lda #RED
    sta SPR6_COLOR
    lda #YELLOW
    sta SPR7_COLOR

    ; sprite locations
    lda SPRITE_Y
    sta SPR0_Y
    sta SPR1_Y
    sta SPR2_Y
    sta SPR3_Y
    sta SPR4_Y
    sta SPR5_Y
    sta SPR6_Y
    sta SPR7_Y

    lda SPRITE_X
    sta SPR0_X
    sta SPR2_X

    clc 
    adc #SPR_WIDTH
    sta SPR1_X
    sta SPR3_X

    ; shield
    clc 
    adc #SPR_WIDTH
    sta SPR4_X
    sta SPR5_X

    ; flames
    lda SPRITE_X
    sec 
    sbc #SPR_WIDTH-8    ; overlaps behind broom
    sta SPR6_X
    sta SPR7_X

    ; enable sprites
    lda #%00001111
    sta SPR_ENABLE

    ; setup key ports
    lda #$ff        ; all bits output
    sta CIA1_DDRA

    lda #$00        ; all bits input
    sta CIA1_DDRB

    rts     

SPRITE_BOB
    lda MATHS_RNG
    and #%00000111
    cmp #%00000000
    beq SPRITE_BOB_UP

    cmp #%00000001
    beq SPRITE_BOB_DOWN

    ; reset
    lda SPRITE_Y
    sta SPR0_Y
    sta SPR1_Y
    sta SPR2_Y
    sta SPR3_Y
    ; shield doesn't bob
    sta SPR6_Y
    sta SPR7_Y
    rts

SPRITE_BOB_UP
    dec SPR0_Y
    dec SPR1_Y
    dec SPR2_Y
    dec SPR3_Y
    ; shield doesn't bob
    dec SPR6_Y
    dec SPR7_Y
    rts

SPRITE_BOB_DOWN
    inc SPR0_Y
    inc SPR1_Y
    inc SPR2_Y
    inc SPR3_Y
    ; shield doesn't bob
    inc SPR6_Y
    inc SPR7_Y
    rts

SPRITE_UPDATE_WITCH
    ; a - left
    lda #KEY_A_ROW
    sta CIA1_PRA

    lda CIA1_PRB
    and #KEY_A_COL

    bne SPRITE_MOVE_LEFT_DONE
SPRITE_MOVE_LEFT
    lda SPRITE_X
    cmp #SPRITE_X_MIN
    beq SPRITE_MOVE_LEFT_DONE

    dec SPRITE_X
    lda SPRITE_X
    sta SPR0_X
    sta SPR2_X

    clc 
    adc #SPR_WIDTH
    sta SPR1_X
    sta SPR3_X

    ; shield
    clc 
    adc #SPR_WIDTH
    sta SPR4_X
    sta SPR5_X

    ; flames
    lda SPRITE_X
    sec 
    sbc #SPR_WIDTH-8    ; overlaps behind broom
    sta SPR6_X
    sta SPR7_X
    
SPRITE_MOVE_LEFT_DONE

    ; d - right
    lda #KEY_D_ROW
    sta CIA1_PRA

    lda CIA1_PRB
    and #KEY_D_COL

    bne SPRITE_MOVE_RIGHT_DONE
SPRITE_MOVE_RIGHT
    lda SPRITE_X
    cmp #SPRITE_X_MAX
    beq SPRITE_MOVE_RIGHT_DONE

    inc SPRITE_X
    lda SPRITE_X
    sta SPR0_X
    sta SPR2_X

    clc 
    adc #SPR_WIDTH
    sta SPR1_X
    sta SPR3_X

    ; shield
    clc 
    adc #SPR_WIDTH
    sta SPR4_X
    sta SPR5_X

    ; flames
    lda SPRITE_X
    sec 
    sbc #SPR_WIDTH-8    ; overlaps behind broom
    sta SPR6_X
    sta SPR7_X

SPRITE_MOVE_RIGHT_DONE

    ; w - up
    lda #KEY_W_ROW
    sta CIA1_PRA

    lda CIA1_PRB
    and #KEY_W_COL

    bne SPRITE_MOVE_UP_DONE
SPRITE_MOVE_UP
    lda SPRITE_Y
    cmp #SPRITE_Y_MIN
    beq SPRITE_MOVE_UP_DONE

    dec SPRITE_Y
    lda SPRITE_Y
    sta SPR0_Y
    sta SPR1_Y
    sta SPR2_Y
    sta SPR3_Y
    sta SPR4_Y
    sta SPR5_Y
    sta SPR6_Y
    sta SPR7_Y
SPRITE_MOVE_UP_DONE

    ; s - down
    lda #KEY_S_ROW
    sta CIA1_PRA

    lda CIA1_PRB
    and #KEY_S_COL

    bne SPRITE_MOVE_DOWN_DONE
SPRITE_MOVE_DOWN
    lda SPRITE_Y
    cmp #SPRITE_Y_MAX
    beq SPRITE_MOVE_DOWN_DONE

    inc SPRITE_Y
    lda SPRITE_Y
    sta SPR0_Y
    sta SPR1_Y
    sta SPR2_Y
    sta SPR3_Y
    sta SPR4_Y
    sta SPR5_Y
    sta SPR6_Y
    sta SPR7_Y
SPRITE_MOVE_DOWN_DONE

SPRITE_SHIELD
    ; space - shield
    lda #KEY_SPACE_ROW
    sta CIA1_PRA

    lda CIA1_PRB
    and #KEY_SPACE_COL

    beq SPRITE_SHIELD_ON

SPRITE_SHIELD_OFF
    lda SPR_ENABLE
    and #%11001111       ; disable shield sprites
    jmp SPRITE_SHIELD_DONE

SPRITE_SHIELD_ON
    lda SPR_ENABLE
    ora #%00110000       ; enable shield sprites

SPRITE_SHIELD_DONE
    sta SPR_ENABLE      ; update vic

SPRITE_FLAMES
    ; enter - flames
    lda #KEY_ENTER_ROW
    sta CIA1_PRA

    lda CIA1_PRB
    and #KEY_ENTER_COL

    beq SPRITE_FLAMES_ON

SPRITE_FLAMES_OFF
    lda SPR_ENABLE
    and #%00111111       ; disable shield sprites
    jmp SPRITE_FLAMES_DONE
SPRITE_FLAMES_ON
    lda SPR_ENABLE
    ora #%11000000       ; enable shield sprites
SPRITE_FLAMES_DONE
    sta SPR_ENABLE      ; update vic


SPRITE_READ_KEYS_DONE
    ; always bob sprite
    jsr SPRITE_BOB

    rts             ; SPRITE_READ_KEYS

SPRITE_FLIP_FRAME
    inc SPRITE_FRAME
    lda SPRITE_FRAME
    and #%00000111      ; every 7 frames
    bne SPRITE_FLIP_CAT_DONE

    ; flip cat
    lda SPRITE_FRAME_CAT
    cmp #SPRITE_CAT_NORM
    beq SPRITE_FLIP_CAT_WAG

;     ; set cat norm
    lda #SPRITE_CAT_NORM
    sta SPRITE_FRAME_CAT

    lda #SPRITE_CAT_BRUSH_NORM
    sta SPRITE_FRAME_CAT_BRUSH


    jmp SPRITE_FLIP_CAT_DONE

SPRITE_FLIP_CAT_WAG
    lda #SPRITE_CAT_WAG
    sta SPRITE_FRAME_CAT

    lda #SPRITE_CAT_BRUSH_WAG
    sta SPRITE_FRAME_CAT_BRUSH

SPRITE_FLIP_CAT_DONE

    lda SPRITE_FRAME
    and #%00000001
    beq SPRITE_FRAME_0

SPRITE_FRAME_1
    ; point to sprites
    lda #(witch_sprite_left_tint_brush / 64)
    sta SPR_PTR0
    lda #(witch_sprite_right_tint_hat / 64)
    sta SPR_PTR1
    lda SPRITE_FRAME_CAT_BRUSH
    sta SPR_PTR2
    lda #(witch_sprite_right_hat / 64)
    sta SPR_PTR3

    rts             ; SPRITE_FLIP_FRAME

SPRITE_FRAME_0
    ; point to sprites
    lda #(witch_sprite_left_tint / 64)
    sta SPR_PTR0
    lda #(witch_sprite_right_tint / 64)
    sta SPR_PTR1
    lda SPRITE_FRAME_CAT
    sta SPR_PTR2
    lda #(witch_sprite_right / 64)
    sta SPR_PTR3

    rts             ; SPRITE_FLIP_FRAME



SPRITE_X_MIN = 60
SPRITE_X_MAX = 200
SPRITE_Y_MIN = 130
SPRITE_Y_MAX = 190

SPRITE_FRAME
    !byte   0


SPRITE_CAT_NORM = (witch_sprite_left / 64)
SPRITE_CAT_BRUSH_NORM = (witch_sprite_left_brush / 64)
SPRITE_CAT_WAG = (witch_sprite_left_wag / 64)
SPRITE_CAT_BRUSH_WAG = (witch_sprite_left_brush_wag / 64)


SPRITE_FRAME_CAT
    !byte   SPRITE_CAT_NORM
SPRITE_FRAME_CAT_BRUSH
    !byte   SPRITE_CAT_BRUSH_NORM
SPRITE_X
    !byte   80

SPRITE_Y 
    !byte   170


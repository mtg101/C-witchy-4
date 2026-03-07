





SPRITE_INIT
    ; disable sprite while we setup
    lda #$00
    sta SPR_ENABLE

    jsr SPRITE_FRAME_0

    ; sprite colours
    lda #BROWN
    sta SPR0_COLOR
    lda #PURPLE
    sta SPR1_COLOR
    lda #BLACK
    sta SPR2_COLOR
    sta SPR3_COLOR

    ; sprite locations
    lda SPRITE_Y
    sta SPR0_Y
    sta SPR1_Y
    sta SPR2_Y
    sta SPR3_Y

    lda SPRITE_X
    sta SPR0_X
    sta SPR2_X

    clc 
    adc #SPR_WIDTH
    sta SPR1_X
    sta SPR3_X

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
    rts

SPRITE_BOB_UP
    dec SPR0_Y
    dec SPR1_Y
    dec SPR2_Y
    dec SPR3_Y
    rts

SPRITE_BOB_DOWN
    inc SPR0_Y
    inc SPR1_Y
    inc SPR2_Y
    inc SPR3_Y
    rts

SPRITE_READ_KEYS
    ; just for debugging this...
    lda #0              ; all low so check if anything pressed
    sta CIA1_PRA
    lda CIA1_PRB
    cmp #$FF
    beq SPRITE_READ_KEYS_DONE   ; skip if nothing pressed


    ; a - left
    lda #KEY_A_ROW
    sta CIA1_PRA

    lda CIA1_PRB
    and #KEY_A_COL

    beq SPRITE_MOVE_LEFT

    ; d - right
    lda #KEY_D_ROW
    sta CIA1_PRA

    lda CIA1_PRB
    and #KEY_D_COL

    beq SPRITE_MOVE_RIGHT

    ; w - up
    lda #KEY_W_ROW
    sta CIA1_PRA

    lda CIA1_PRB
    and #KEY_W_COL

    beq SPRITE_MOVE_UP

    ; s - down
    lda #KEY_S_ROW
    sta CIA1_PRA

    lda CIA1_PRB
    and #KEY_S_COL

    beq SPRITE_MOVE_DOWN

SPRITE_READ_KEYS_DONE
    ; no keys so bob
;    jsr SPRITE_BOB

    rts             ; SPRITE_READ_KEYS


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

SPRITE_MOVE_LEFT_DONE
    rts             ; SPRITE_READ_KEYS

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

SPRITE_MOVE_RIGHT_DONE    
    rts             ; SPRITE_READ_KEYS

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

SPRITE_MOVE_UP_DONE    
    rts             ; SPRITE_READ_KEYS

SPRITE_MOVE_DOWN
    lda SPRITE_Y
    cmp #SPRITE_Y_MAX
    beq SPRITE_MOVE_LEFT_DONE

    inc SPRITE_Y
    lda SPRITE_Y
    sta SPR0_Y
    sta SPR1_Y
    sta SPR2_Y
    sta SPR3_Y

SPRITE_MOVE_DOWN_DONE
    rts             ; SPRITE_READ_KEYS



SPRITE_FLIP_FRAME
    inc SPRITE_FRAME
    lda SPRITE_FRAME
    and #%00000001
    beq SPRITE_FRAME_0

SPRITE_FRAME_1
    ; point to sprites
    lda #(witch_sprite_left_tint_brush / 64)
    sta SPR_PTR0
    lda #(which_sprite_right_tint_hat / 64)
    sta SPR_PTR1
    lda #(witch_sprite_left_brush / 64)
    sta SPR_PTR2
    lda #(witch_sprite_right_hat / 64)
    sta SPR_PTR3

    rts             ; SPRITE_FLIP_FRAME

SPRITE_FRAME_0
    ; point to sprites
    lda #(witch_sprite_left_tint / 64)
    sta SPR_PTR0
    lda #(which_sprite_right_tint / 64)
    sta SPR_PTR1
    lda #(witch_sprite_left / 64)
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

SPRITE_X
    !byte   80

SPRITE_Y 
    !byte   170


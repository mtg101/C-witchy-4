





SPRITE_INIT
    ; disable sprite while we setup
    lda #$00
    sta SPR_ENABLE


    ; point to sprites
    lda #(witch_sprite_left_tint / 64)
    sta SPR_PTR0
    lda #(which_sprite_right_tint / 64)
    sta SPR_PTR1
    lda #(witch_sprite_left / 64)
    sta SPR_PTR2
    lda #(witch_sprite_right / 64)
    sta SPR_PTR3

    ; sprite colours
    lda #BROWN
    sta SPR0_COLOR
    lda #PURPLE
    sta SPR1_COLOR
    lda #BLACK
    sta SPR2_COLOR
    sta SPR3_COLOR

    ; sprite locations
    lda #SPRITE_START_Y
    sta SPR0_Y
    sta SPR1_Y
    sta SPR2_Y
    sta SPR3_Y

    lda #SPRITE_START_X
    sta SPR0_X
    sta SPR2_X

    lda #SPRITE_START_X + SPR_WIDTH
    sta SPR1_X
    sta SPR3_X

    ; enable sprites
    lda #%00001111
    sta SPR_ENABLE

    rts     

SPRITE_BOB
    lda MATHS_RNG
    and #%00000111
    cmp #%00000000
    beq SPRITE_BOB_UP

    cmp #%00000001
    beq SPRITE_BOB_DOWN

    lda #SPRITE_START_Y
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


SPRITE_START_X = 80
SPRITE_START_Y = 170


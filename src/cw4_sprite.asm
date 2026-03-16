

SPRITE_INIT
    ; setup key ports
    lda #$ff        ; all bits output
    sta CIA1_DDRA

    lda #$00        ; all bits input
    sta CIA1_DDRB

    rts     

SPRITE_FLIP_TO_CLOUDS
    ; sprite colours
    lda #WHITE
    sta SPR0_COLOR
    sta SPR1_COLOR
    sta SPR2_COLOR
    sta SPR3_COLOR
    sta SPR4_COLOR
    sta SPR5_COLOR
    sta SPR6_COLOR
    sta SPR7_COLOR

    ; sprite locations
    lda SPRITE_CLOUDS_Y_0
    sta SPR0_Y
    lda SPRITE_CLOUDS_Y_1
    sta SPR1_Y
    lda SPRITE_CLOUDS_Y_2
    sta SPR2_Y
    lda SPRITE_CLOUDS_Y_3
    sta SPR3_Y
    lda SPRITE_CLOUDS_Y_4
    sta SPR4_Y
    lda SPRITE_CLOUDS_Y_5
    sta SPR5_Y
    lda SPRITE_CLOUDS_Y_6
    sta SPR6_Y
    lda SPRITE_CLOUDS_Y_7
    sta SPR7_Y

    lda SPRITE_CLOUDS_X_0
    sta SPR0_X
    lda SPRITE_CLOUDS_X_1
    sta SPR1_X
    lda SPRITE_CLOUDS_X_2
    sta SPR2_X
    lda SPRITE_CLOUDS_X_3
    sta SPR3_X
    lda SPRITE_CLOUDS_X_4
    sta SPR4_X
    lda SPRITE_CLOUDS_X_5
    sta SPR5_X
    lda SPRITE_CLOUDS_X_6
    sta SPR6_X
    lda SPRITE_CLOUDS_X_7
    sta SPR7_X

    ; 255 funsies
    lda SPRITE_CLOUDS_MSB
    sta SPR_X_MSB

    ; sprite pointers
    lda SPRITE_CLOUDS_PTR_0
    sta SPR_PTR0
    lda SPRITE_CLOUDS_PTR_1
    sta SPR_PTR1
    lda SPRITE_CLOUDS_PTR_2
    sta SPR_PTR2
    lda SPRITE_CLOUDS_PTR_3
    sta SPR_PTR3
    lda SPRITE_CLOUDS_PTR_4
    sta SPR_PTR4
    lda SPRITE_CLOUDS_PTR_5
    sta SPR_PTR5
    lda SPRITE_CLOUDS_PTR_6
    sta SPR_PTR6
    lda SPRITE_CLOUDS_PTR_7
    sta SPR_PTR7

    ; enable sprites
    lda SPRITE_CLOUDS_ENABLE
    sta SPR_ENABLE 

    ; behind text
    lda #%11111111
    sta SPR_PRIORITY

    rts             ; SPRITE_FLIP_TO_CLOUDS

SPRITE_FLIP_TO_WITCH
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
    lda SPRITE_WITCH_Y_0
    sta SPR0_Y
    lda SPRITE_WITCH_Y_1
    sta SPR1_Y
    lda SPRITE_WITCH_Y_2
    sta SPR2_Y
    lda SPRITE_WITCH_Y_3
    sta SPR3_Y
    lda SPRITE_WITCH_Y_4
    sta SPR4_Y
    lda SPRITE_WITCH_Y_5
    sta SPR5_Y
    lda SPRITE_WITCH_Y_6
    sta SPR6_Y
    lda SPRITE_WITCH_Y_7
    sta SPR7_Y

    lda SPRITE_WITCH_X_0
    sta SPR0_X
    lda SPRITE_WITCH_X_1
    sta SPR1_X
    lda SPRITE_WITCH_X_2
    sta SPR2_X
    lda SPRITE_WITCH_X_3
    sta SPR3_X
    lda SPRITE_WITCH_X_4
    sta SPR4_X
    lda SPRITE_WITCH_X_5
    sta SPR5_X
    lda SPRITE_WITCH_X_6
    sta SPR6_X
    lda SPRITE_WITCH_X_7
    sta SPR7_X

    ; sprite pointers
    lda SPRITE_WITCH_PTR_0
    sta SPR_PTR0
    lda SPRITE_WITCH_PTR_1
    sta SPR_PTR1
    lda SPRITE_WITCH_PTR_2
    sta SPR_PTR2
    lda SPRITE_WITCH_PTR_3
    sta SPR_PTR3
    lda SPRITE_WITCH_PTR_4
    sta SPR_PTR4
    lda SPRITE_WITCH_PTR_5
    sta SPR_PTR5
    lda SPRITE_WITCH_PTR_6
    sta SPR_PTR6
    lda SPRITE_WITCH_PTR_7
    sta SPR_PTR7

    jsr SPRITE_BOB

    ; enable sprites
    lda SPRITE_WITCH_ENABLE
    sta SPR_ENABLE 

    ; in front of trees
    lda #%00000000
    sta SPR_PRIORITY

    ; never goes beyond X 255
    lda #0
    sta SPR_X_MSB

    rts             ; SPRITE_FLIP_TO_WITCH

SPRITE_BOB
    lda MATHS_RNG
    and #%00000111
    cmp #%00000000
    beq SPRITE_BOB_UP

    cmp #%00000001
    beq SPRITE_BOB_DOWN

SPRITE_BOB_X
    lda MATHS_RNG
    and #%00000111
    cmp #%00000000
    beq SPRITE_BOB_LEFT

    cmp #%00000001
    beq SPRITE_BOB_RIGHT

SPRITE_BOB_DONE
    rts 


SPRITE_BOB_UP
    dec SPR0_Y
    dec SPR1_Y
    dec SPR2_Y
    dec SPR3_Y
    ; shield doesn't bob
    dec SPR6_Y
    dec SPR7_Y
    jmp SPRITE_BOB_X

SPRITE_BOB_DOWN
    inc SPR0_Y
    inc SPR1_Y
    inc SPR2_Y
    inc SPR3_Y
    ; shield doesn't bob
    inc SPR6_Y
    inc SPR7_Y
    jmp SPRITE_BOB_X

SPRITE_BOB_LEFT
    dec SPR6_X
    dec SPR7_X
    jmp SPRITE_BOB_DONE

SPRITE_BOB_RIGHT
    inc SPR6_X
    inc SPR7_X
    jmp SPRITE_BOB_DONE


SPRITE_UPDATE_WITCH
    ; a - left
    lda #KEY_A_ROW
    sta CIA1_PRA

    lda CIA1_PRB
    and #KEY_A_COL

    bne SPRITE_MOVE_LEFT_DONE
SPRITE_MOVE_LEFT
    lda SPRITE_WITCH_X_0
    cmp #SPRITE_WITCH_X_MIN
    beq SPRITE_MOVE_LEFT_DONE

    dec SPRITE_WITCH_X_0
    dec SPRITE_WITCH_X_1
    dec SPRITE_WITCH_X_2
    dec SPRITE_WITCH_X_3
    dec SPRITE_WITCH_X_4
    dec SPRITE_WITCH_X_5
    dec SPRITE_WITCH_X_6
    dec SPRITE_WITCH_X_7
    
SPRITE_MOVE_LEFT_DONE

    ; d - right
    lda #KEY_D_ROW
    sta CIA1_PRA

    lda CIA1_PRB
    and #KEY_D_COL

    bne SPRITE_MOVE_RIGHT_DONE
SPRITE_MOVE_RIGHT
    lda SPRITE_WITCH_X_0
    cmp #SPRITE_WITCH_X_MAX
    beq SPRITE_MOVE_RIGHT_DONE

    inc SPRITE_WITCH_X_0
    inc SPRITE_WITCH_X_1
    inc SPRITE_WITCH_X_2
    inc SPRITE_WITCH_X_3
    inc SPRITE_WITCH_X_4
    inc SPRITE_WITCH_X_5
    inc SPRITE_WITCH_X_6
    inc SPRITE_WITCH_X_7

SPRITE_MOVE_RIGHT_DONE

    ; w - up
    lda #KEY_W_ROW
    sta CIA1_PRA

    lda CIA1_PRB
    and #KEY_W_COL

    bne SPRITE_MOVE_UP_DONE
SPRITE_MOVE_UP
    lda SPRITE_WITCH_Y_0
    cmp #SPRITE_WITCH_Y_MIN
    beq SPRITE_MOVE_UP_DONE

    dec SPRITE_WITCH_Y_0
    dec SPRITE_WITCH_Y_1
    dec SPRITE_WITCH_Y_2
    dec SPRITE_WITCH_Y_3
    dec SPRITE_WITCH_Y_4
    dec SPRITE_WITCH_Y_5
    dec SPRITE_WITCH_Y_6
    dec SPRITE_WITCH_Y_7
SPRITE_MOVE_UP_DONE

    ; s - down
    lda #KEY_S_ROW
    sta CIA1_PRA

    lda CIA1_PRB
    and #KEY_S_COL

    bne SPRITE_MOVE_DOWN_DONE
SPRITE_MOVE_DOWN
    lda SPRITE_WITCH_Y_0
    cmp #SPRITE_WITCH_Y_MAX
    beq SPRITE_MOVE_DOWN_DONE

    inc SPRITE_WITCH_Y_0
    inc SPRITE_WITCH_Y_1
    inc SPRITE_WITCH_Y_2
    inc SPRITE_WITCH_Y_3
    inc SPRITE_WITCH_Y_4
    inc SPRITE_WITCH_Y_5
    inc SPRITE_WITCH_Y_6
    inc SPRITE_WITCH_Y_7
SPRITE_MOVE_DOWN_DONE

SPRITE_SHIELD
    ; space - shield
    lda #KEY_SPACE_ROW
    sta CIA1_PRA

    lda CIA1_PRB
    and #KEY_SPACE_COL

    beq SPRITE_SHIELD_ON

SPRITE_SHIELD_OFF
    lda SPRITE_WITCH_ENABLE
    and #%11001111       
    jmp SPRITE_SHIELD_DONE

SPRITE_SHIELD_ON
    lda SPRITE_WITCH_ENABLE
    ora #%00110000       

SPRITE_SHIELD_DONE
    sta SPRITE_WITCH_ENABLE

SPRITE_FLAMES
    ; enter - flames
    lda #KEY_ENTER_ROW
    sta CIA1_PRA

    lda CIA1_PRB
    and #KEY_ENTER_COL

    beq SPRITE_FLAMES_ON

SPRITE_FLAMES_OFF
    lda SPRITE_WITCH_ENABLE
    and #%00111111       
    jmp SPRITE_FLAMES_DONE
SPRITE_FLAMES_ON
    lda SPRITE_WITCH_ENABLE
    ora #%11000000       
SPRITE_FLAMES_DONE
    sta SPRITE_WITCH_ENABLE

SPRITE_READ_KEYS_DONE
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

    ; set cat norm
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
    beq SPRITE_WITCH_FRAME_0

SPRITE_WITCH_FRAME_1
    ; point to sprites
    lda #(witch_sprite_left_tint_brush / 64)
    sta SPRITE_WITCH_PTR_0
    lda #(witch_sprite_right_tint_hat / 64)
    sta SPRITE_WITCH_PTR_1
    lda SPRITE_FRAME_CAT_BRUSH
    sta SPRITE_WITCH_PTR_2
    lda #(witch_sprite_right_hat / 64)
    sta SPRITE_WITCH_PTR_3

    rts             ; SPRITE_FLIP_FRAME

SPRITE_WITCH_FRAME_0
    ; point to sprites
    lda #(witch_sprite_left_tint / 64)
    sta SPRITE_WITCH_PTR_0
    lda #(witch_sprite_right_tint / 64)
    sta SPRITE_WITCH_PTR_1
    lda SPRITE_FRAME_CAT
    sta SPRITE_WITCH_PTR_2
    lda #(witch_sprite_right / 64)
    sta SPRITE_WITCH_PTR_3

    rts             ; SPRITE_FLIP_FRAME


SPRITE_MOVE_CLOUDS
    inc SPRITE_CLOUD_FRAME
    lda SPRITE_CLOUD_FRAME
    and #%00000001  
    beq SPRITE_MOVE_CLOUDS_1in2
SPRITE_MOVE_CLOUDS_1in2_DONE
    lda SPRITE_CLOUD_FRAME
    and #%00000011  
    beq SPRITE_MOVE_CLOUDS_1in4
SPRITE_MOVE_CLOUDS_1in4_DONE
    lda SPRITE_CLOUD_FRAME
    and #%00000111  
    beq SPRITE_MOVE_CLOUDS_1in8

SPRITE_MOVE_CLOUDS_1in8_DONE
    lda SPRITE_CLOUD_FRAME
    and #%00001111  
    beq SPRITE_MOVE_CLOUDS_1in16

SPRITE_MOVE_CLOUDS_1in16_DONE
    lda SPRITE_CLOUD_FRAME
    and #%00011111  
    beq SPRITE_MOVE_CLOUDS_1in32

SPRITE_MOVE_CLOUDS_1in32_DONE
    rts

SPRITE_MOVE_CLOUDS_1in2
    dec SPRITE_CLOUDS_X_0
    bne +
    ; flip 9th bit
    lda SPRITE_CLOUDS_MSB
    eor #%00000001
    sta SPRITE_CLOUDS_MSB
+
    jmp SPRITE_MOVE_CLOUDS_1in2_DONE

SPRITE_MOVE_CLOUDS_1in4
    dec SPRITE_CLOUDS_X_1
    bne +
    ; flip 9th bit
    lda SPRITE_CLOUDS_MSB
    eor #%00000010
    sta SPRITE_CLOUDS_MSB
+
    dec SPRITE_CLOUDS_X_2
    bne +
    ; flip 9th bit
    lda SPRITE_CLOUDS_MSB
    eor #%00000100
    sta SPRITE_CLOUDS_MSB
+
    jmp SPRITE_MOVE_CLOUDS_1in4_DONE

SPRITE_MOVE_CLOUDS_1in8
    dec SPRITE_CLOUDS_X_3
    bne +
    ; flip 9th bit
    lda SPRITE_CLOUDS_MSB
    eor #%00001000
    sta SPRITE_CLOUDS_MSB
+
    dec SPRITE_CLOUDS_X_4
    bne +
    ; flip 9th bit
    lda SPRITE_CLOUDS_MSB
    eor #%00010000
    sta SPRITE_CLOUDS_MSB
+
    jmp SPRITE_MOVE_CLOUDS_1in8_DONE

SPRITE_MOVE_CLOUDS_1in16
    dec SPRITE_CLOUDS_X_5
    bne +
    ; flip 9th bit
    lda SPRITE_CLOUDS_MSB
    eor #%00100000
    sta SPRITE_CLOUDS_MSB
+
    dec SPRITE_CLOUDS_X_6
    bne +
    ; flip 9th bit
    lda SPRITE_CLOUDS_MSB
    eor #%01000000
    sta SPRITE_CLOUDS_MSB
+
    jmp SPRITE_MOVE_CLOUDS_1in16_DONE

SPRITE_MOVE_CLOUDS_1in32
    dec SPRITE_CLOUDS_X_7
    bne +
    ; flip 9th bit
    lda SPRITE_CLOUDS_MSB
    eor #%10000000
    sta SPRITE_CLOUDS_MSB
+
    jmp SPRITE_MOVE_CLOUDS_1in32_DONE


SPRITE_WITCH_X_MIN = 60
SPRITE_WITCH_X_MAX = 200
SPRITE_WITCH_Y_MIN = 130
SPRITE_WITCH_Y_MAX = 190

SPRITE_FRAME 
    !byte 0

SPRITE_CLOUD_FRAME
    !byte 0

SPRITE_CAT_NORM = (witch_sprite_left / 64)
SPRITE_CAT_BRUSH_NORM = (witch_sprite_left_brush / 64)
SPRITE_CAT_WAG = (witch_sprite_left_wag / 64)
SPRITE_CAT_BRUSH_WAG = (witch_sprite_left_brush_wag / 64)


SPRITE_FRAME_CAT
    !byte SPRITE_CAT_NORM
SPRITE_FRAME_CAT_BRUSH
    !byte SPRITE_CAT_BRUSH_NORM

SPRITE_WITCH_ENABLE      
    !byte %00001111

SPRITE_WITCH_X_0
    !byte 80
SPRITE_WITCH_X_1
    !byte 80 + SPR_WIDTH
SPRITE_WITCH_X_2
    !byte 80
SPRITE_WITCH_X_3
    !byte 80 + SPR_WIDTH
SPRITE_WITCH_X_4
    !byte 80 + SPR_WIDTH + SPR_WIDTH
SPRITE_WITCH_X_5
    !byte 80 + SPR_WIDTH + SPR_WIDTH
SPRITE_WITCH_X_6
    !byte 80 - SPR_WIDTH + 8
SPRITE_WITCH_X_7
    !byte 80 - SPR_WIDTH + 8

SPRITE_WITCH_Y_0
    !byte   170
SPRITE_WITCH_Y_1
    !byte   170
SPRITE_WITCH_Y_2
    !byte   170
SPRITE_WITCH_Y_3
    !byte   170
SPRITE_WITCH_Y_4
    !byte   170
SPRITE_WITCH_Y_5
    !byte   170
SPRITE_WITCH_Y_6
    !byte   170
SPRITE_WITCH_Y_7
    !byte   170

SPRITE_WITCH_PTR_0
    !byte   (witch_sprite_left_tint / 64)
SPRITE_WITCH_PTR_1
    !byte   (witch_sprite_right_tint / 64)
SPRITE_WITCH_PTR_2
    !byte   SPRITE_CAT_NORM
SPRITE_WITCH_PTR_3
    !byte   (witch_sprite_right / 64)
SPRITE_WITCH_PTR_4
    !byte   (witch_sprite_shield_tint / 64)
SPRITE_WITCH_PTR_5
    !byte   (witch_sprite_shield / 64)
SPRITE_WITCH_PTR_6
    !byte   (witch_sprite_flames_tint / 64)
SPRITE_WITCH_PTR_7
    !byte   (witch_sprite_flames / 64)

SPRITE_CLOUDS_ENABLE
    !byte   %11111111

SPRITE_CLOUDS_MSB
    !byte   %11111111

SPRITE_CLOUDS_X_0
    !byte   200
SPRITE_CLOUDS_X_1
    !byte   210
SPRITE_CLOUDS_X_2
    !byte   250
SPRITE_CLOUDS_X_3
    !byte   255
SPRITE_CLOUDS_X_4
    !byte   145
SPRITE_CLOUDS_X_5
    !byte   205
SPRITE_CLOUDS_X_6
    !byte   240
SPRITE_CLOUDS_X_7
    !byte   215

SPRITE_CLOUDS_Y_0
    !byte   75
SPRITE_CLOUDS_Y_1
    !byte   70
SPRITE_CLOUDS_Y_2
    !byte   65
SPRITE_CLOUDS_Y_3
    !byte   63
SPRITE_CLOUDS_Y_4
    !byte   65
SPRITE_CLOUDS_Y_5
    !byte   57
SPRITE_CLOUDS_Y_6
    !byte   50
SPRITE_CLOUDS_Y_7
    !byte   44

SPRITE_CLOUDS_PTR_0
    !byte   (witch_sprite_cloud / 64)
SPRITE_CLOUDS_PTR_1
    !byte   (witch_sprite_cloud / 64)
SPRITE_CLOUDS_PTR_2
    !byte   (witch_sprite_cloud / 64)
SPRITE_CLOUDS_PTR_3
    !byte   (witch_sprite_cloud / 64)
SPRITE_CLOUDS_PTR_4
    !byte   (witch_sprite_cloud / 64)
SPRITE_CLOUDS_PTR_5
    !byte   (witch_sprite_cloud / 64)
SPRITE_CLOUDS_PTR_6
    !byte   (witch_sprite_cloud / 64)
SPRITE_CLOUDS_PTR_7
    !byte   (witch_sprite_cloud / 64)

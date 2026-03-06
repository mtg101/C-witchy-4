
!macro TILE_BG_SCROLL_ROW .row_addr, .proc_row {
    lda #<.row_addr     ; set up safe zero page for offset
    sta ZP_PTR_TEMP_0
    lda #>.row_addr
    sta ZP_PTR_TEMP_0_PAIR

    ldy #0
-
    iny                 ; Look at next char
    lda (ZP_PTR_TEMP_0),y  ; Indirect read
    dey                 ; Step back
    sta (ZP_PTR_TEMP_0),y  ; Indirect write
    iny                 ; Move forward to next pair
    cpy #38             ; Done all 0-37? (38-1 leaving right col alone to write later)
    bne     -

    ; last col from procgen
    lda PROCGEN_CHAR_BUFF + .proc_row
    sta (ZP_PTR_TEMP_0),y    
}

!macro TILE_BG_SCROLL_ROW_COL .row_addr, .proc_row {
    lda #<.row_addr     ; set up safe zero page for offset
    sta ZP_PTR_TEMP_0
    lda #>.row_addr
    sta ZP_PTR_TEMP_0_PAIR

    ldy #0
-
    iny                 ; Look at next col
    lda (ZP_PTR_TEMP_0),y  ; Indirect read
    dey                 ; Step back
    sta (ZP_PTR_TEMP_0),y  ; Indirect write
    iny                 ; Move forward to next pair
    cpy #38             ; Done all 0-37? (38-1 leaving right col alone to write later)
    bne     -

    ; last col from procgen
    lda PROCGEN_COL_BUFF + .proc_row
    sta (ZP_PTR_TEMP_0),y    
}

TILE_BG_SETUP
    ; reset scroll offsets
    jsr SCREEN_RESET_SCROLL_X
    jsr SCREEN_RESET_SCROLL_Y

    ; title text
    ldy     #0
TILE_BG_SETUP_LOOP
    lda     .hellotext,y
    beq     +
    sta     SCREEN_RAM+15+SCREEN_WIDTH_CHARS,y
    lda     #PURPLE
    sta     COLOR_RAM+15+SCREEN_WIDTH_CHARS,y
    iny
    jmp     TILE_BG_SETUP_LOOP
+
    rts

.hellotext
    !scr    "c-witchy-4",0

TILE_BG_SCROLL
    ; chars
    +TILE_BG_SCROLL_ROW TILE_BG_GRASS_START_6, 0
    +TILE_BG_SCROLL_ROW TILE_BG_GRASS_START_7, 1
    +TILE_BG_SCROLL_ROW TILE_BG_GRASS_START_8, 2
    +TILE_BG_SCROLL_ROW TILE_BG_GRASS_START_9, 3

    +TILE_BG_SCROLL_ROW TILE_BG_GRASS_START_10, 4
    +TILE_BG_SCROLL_ROW TILE_BG_GRASS_START_11, 5
    +TILE_BG_SCROLL_ROW TILE_BG_GRASS_START_12, 6
    +TILE_BG_SCROLL_ROW TILE_BG_GRASS_START_13, 7

    +TILE_BG_SCROLL_ROW TILE_BG_GRASS_START_14, 8
    +TILE_BG_SCROLL_ROW TILE_BG_GRASS_START_15, 9
    +TILE_BG_SCROLL_ROW TILE_BG_GRASS_START_16, 10
    +TILE_BG_SCROLL_ROW TILE_BG_GRASS_START_17, 11

    +TILE_BG_SCROLL_ROW TILE_BG_GRASS_START_18, 12
    +TILE_BG_SCROLL_ROW TILE_BG_GRASS_START_19, 13
    +TILE_BG_SCROLL_ROW TILE_BG_GRASS_START_20, 14
    +TILE_BG_SCROLL_ROW TILE_BG_GRASS_START_21, 15

    ; cols
    +TILE_BG_SCROLL_ROW_COL TILE_BG_GRASS_START_COL_6, 0
    +TILE_BG_SCROLL_ROW_COL TILE_BG_GRASS_START_COL_7, 1
    +TILE_BG_SCROLL_ROW_COL TILE_BG_GRASS_START_COL_8, 2
    +TILE_BG_SCROLL_ROW_COL TILE_BG_GRASS_START_COL_9, 3

    ; +TILE_BG_SCROLL_ROW_COL TILE_BG_GRASS_START_COL_10, 4
    ; +TILE_BG_SCROLL_ROW_COL TILE_BG_GRASS_START_COL_11, 5
    ; +TILE_BG_SCROLL_ROW_COL TILE_BG_GRASS_START_COL_12, 6
    ; +TILE_BG_SCROLL_ROW_COL TILE_BG_GRASS_START_COL_13, 7

    lda #YELLOW
    sta BORDER_COL

    rts                 ; TILE_BG_SCROLL

TILE_BG_PROCGEN
    ; clear char buf
    lda #BLANK_SPACE
    sta PROCGEN_CHAR_BUFF
    sta PROCGEN_CHAR_BUFF+1
    sta PROCGEN_CHAR_BUFF+2
    sta PROCGEN_CHAR_BUFF+3
    sta PROCGEN_CHAR_BUFF+4
    sta PROCGEN_CHAR_BUFF+5
    sta PROCGEN_CHAR_BUFF+6
    sta PROCGEN_CHAR_BUFF+7
    sta PROCGEN_CHAR_BUFF+8
    sta PROCGEN_CHAR_BUFF+9
    sta PROCGEN_CHAR_BUFF+10
    sta PROCGEN_CHAR_BUFF+11
    sta PROCGEN_CHAR_BUFF+12
    sta PROCGEN_CHAR_BUFF+13
    sta PROCGEN_CHAR_BUFF+14
    sta PROCGEN_CHAR_BUFF+15

    ; clear col buf
    lda #GREEN
    sta PROCGEN_COL_BUFF
    sta PROCGEN_COL_BUFF+1
    sta PROCGEN_COL_BUFF+2
    sta PROCGEN_COL_BUFF+3
    sta PROCGEN_COL_BUFF+4
    sta PROCGEN_COL_BUFF+5
    sta PROCGEN_COL_BUFF+6
    sta PROCGEN_COL_BUFF+7
    sta PROCGEN_COL_BUFF+8
    sta PROCGEN_COL_BUFF+9
    sta PROCGEN_COL_BUFF+10
    sta PROCGEN_COL_BUFF+11
    sta PROCGEN_COL_BUFF+12
    sta PROCGEN_COL_BUFF+13
    sta PROCGEN_COL_BUFF+14
    sta PROCGEN_COL_BUFF+15


    lda PROCGEN_COUNTER
    inc PROCGEN_COUNTER
    and #%00001111       ; 1 in 16
    bne TILE_BG_PROCGEN_TREES

    ; top & bottom literal edge cases
    lda #$41
    sta PROCGEN_CHAR_BUFF
    sta PROCGEN_CHAR_BUFF+15

    lda #DK_GRAY
    sta PROCGEN_COL_BUFF
    sta PROCGEN_COL_BUFF+15

TILE_BG_PROCGEN_TREES
    lda MATHS_RNG
    and #%00000011              ; 1 in 4 draws something
    bne TILE_BG_PROCGEN_DONE    

    ; random height of trunk
    lda MATHS_RNG
    and #%00000011              ; 0-3
    tax                         ; x is trunk height

    ; random place
    clc                         ; clear carry for add
    adc #02                     ; a is now tree height 2-5
    sta ZP_PTR_TEMP_1

    lda #15                     ; 0-15 placement
    sec                         ; set carry for sub
    sbc ZP_PTR_TEMP_1           ; a is now pacement 0-max takign into accoutn tree heigh
    tay                         ; y is now max rng 

    jsr MATHS_RNG_0_Y_15        ; a is RNG 0-Y for placement
    tay                         ; y is placement

    ; draw top at placement
    lda #$42
    sta PROCGEN_CHAR_BUFF, y
    lda #LT_GREEN
    sta PROCGEN_COL_BUFF, y
    iny         

    ; then draw X trunks
    cpx #0
    beq TILE_BG_PROGREN_BASE

TILE_GB_TRUNK_LOOP
    lda #$41
    sta PROCGEN_CHAR_BUFF, y
    lda #ORANGE
    sta PROCGEN_COL_BUFF, y
    iny 
    dex 
    bne TILE_GB_TRUNK_LOOP

TILE_BG_PROGREN_BASE
    ; finally one base
    lda #$40
    sta PROCGEN_CHAR_BUFF, y
    lda #BROWN
    sta PROCGEN_COL_BUFF, y

TILE_BG_PROCGEN_DONE

    rts                         ; TILE_BG_PROCGEN







; ---------------------------------------------------------
; SMC row macro
; ---------------------------------------------------------

!macro TILE_BG_SCROLL_SMC_ROW .scr_addr, .col_addr, .proc_row {
    ; setup Screen RAM addresses
    lda #<.scr_addr             ; Low Byte for screen
    sta scr_src + 1
    sta scr_dst + 1
    sta scr_dst_last + 1
    inc scr_src + 1             ; src is dest + 1

    lda #>.scr_addr             ; High Byte for Screen
    sta scr_src + 2
    sta scr_dst + 2
    sta scr_dst_last + 2

    ; setup last column char source
    lda #<PROCGEN_CHAR_BUFF + .proc_row ; Low Byte 
    sta scr_src_last + 1

    lda #>PROCGEN_CHAR_BUFF + .proc_row ; High Byte
    sta scr_src_last + 2

    ; setup Color RAM addresses
    lda #<.col_addr                 ; Low Byte color
    sta col_src + 1
    sta col_dst + 1
    sta col_dst_last + 1
    inc col_src + 1                 ; src is dest + 1

    lda #>.col_addr                 ; High Byte for Color RAM
    sta col_src + 2
    sta col_dst + 2
    sta col_dst_last + 2

    ; setup last column col
    lda #<PROCGEN_COL_BUFF + .proc_row  ; Low Byte 
    sta col_src_last + 1

    lda #>PROCGEN_COL_BUFF + .proc_row  ; High Byte
    sta col_src_last + 2

    jsr TILE_BG_SCROLL_SMC_EXECUTE
}


; ---------------------------------------------------------
; SMC FULL ROW SCROLL (Screen + Color)
; ---------------------------------------------------------

TILE_BG_SCROLL_SMC
    +TILE_BG_SCROLL_SMC_ROW TILE_BG_GRASS_START_6, TILE_BG_GRASS_START_COL_6, 0
    +TILE_BG_SCROLL_SMC_ROW TILE_BG_GRASS_START_7, TILE_BG_GRASS_START_COL_7, 1
    +TILE_BG_SCROLL_SMC_ROW TILE_BG_GRASS_START_8, TILE_BG_GRASS_START_COL_8, 2
    +TILE_BG_SCROLL_SMC_ROW TILE_BG_GRASS_START_9, TILE_BG_GRASS_START_COL_9, 3

    +TILE_BG_SCROLL_SMC_ROW TILE_BG_GRASS_START_10, TILE_BG_GRASS_START_COL_10, 4
    +TILE_BG_SCROLL_SMC_ROW TILE_BG_GRASS_START_11, TILE_BG_GRASS_START_COL_11, 5
    +TILE_BG_SCROLL_SMC_ROW TILE_BG_GRASS_START_12, TILE_BG_GRASS_START_COL_12, 6
    +TILE_BG_SCROLL_SMC_ROW TILE_BG_GRASS_START_13, TILE_BG_GRASS_START_COL_13, 7

    +TILE_BG_SCROLL_SMC_ROW TILE_BG_GRASS_START_14, TILE_BG_GRASS_START_COL_14, 8
    +TILE_BG_SCROLL_SMC_ROW TILE_BG_GRASS_START_15, TILE_BG_GRASS_START_COL_15, 9
    +TILE_BG_SCROLL_SMC_ROW TILE_BG_GRASS_START_16, TILE_BG_GRASS_START_COL_16, 10
    +TILE_BG_SCROLL_SMC_ROW TILE_BG_GRASS_START_17, TILE_BG_GRASS_START_COL_17, 11

    +TILE_BG_SCROLL_SMC_ROW TILE_BG_GRASS_START_18, TILE_BG_GRASS_START_COL_18, 12
    +TILE_BG_SCROLL_SMC_ROW TILE_BG_GRASS_START_19, TILE_BG_GRASS_START_COL_19, 13
    +TILE_BG_SCROLL_SMC_ROW TILE_BG_GRASS_START_20, TILE_BG_GRASS_START_COL_20, 14
    +TILE_BG_SCROLL_SMC_ROW TILE_BG_GRASS_START_21, TILE_BG_GRASS_START_COL_21, 15

    lda #YELLOW
    sta BORDER_COL

    rts             ; TILE_BG_SCROLL_SMC

; Execute Scroll
TILE_BG_SCROLL_SMC_EXECUTE
    ldx #$00
.loop
scr_src
    lda $ffff,x         ; SMC overwrites
scr_dst
    sta $ffff,x         ; SMC overwrites

col_src
    lda $ffff,x         ; SMC overwrites
col_dst
    sta $ffff,x         ; SMC overwrites

    inx
    cpx #38             ; done all 0-37? (38-1 leaving right col alone to write later)
    bne .loop

    ; last col char from procgen
scr_src_last
    lda $ffff           ; SMC overwritten
scr_dst_last
    sta $ffff,x         ; SMC overwritten

    ; last col color from procgen
col_src_last
    lda $ffff           ; SMC overwritten
col_dst_last
    sta $ffff,x         ; SMC overwritten

    rts                 ; TILE_BG_SCROLL_SMC_EXECUTE



; grass starts at row: 6
; goes 16 rows to: 22
; base is SCREEN_RAM $0400
; add (40 * y) = (40 * 6) = 240 = $F0
; each extra row adds 40 = $28
TILE_BG_GRASS_START_6     = SCREEN_RAM + $F0 + (0 * $28)
TILE_BG_GRASS_START_7     = SCREEN_RAM + $F0 + (1 * $28)
TILE_BG_GRASS_START_8     = SCREEN_RAM + $F0 + (2 * $28)
TILE_BG_GRASS_START_9     = SCREEN_RAM + $F0 + (3 * $28)

TILE_BG_GRASS_START_10     = SCREEN_RAM + $F0 + (4 * $28)
TILE_BG_GRASS_START_11     = SCREEN_RAM + $F0 + (5 * $28)
TILE_BG_GRASS_START_12     = SCREEN_RAM + $F0 + (6 * $28)
TILE_BG_GRASS_START_13     = SCREEN_RAM + $F0 + (7 * $28)

TILE_BG_GRASS_START_14     = SCREEN_RAM + $F0 + (8 * $28)
TILE_BG_GRASS_START_15     = SCREEN_RAM + $F0 + (9 * $28)
TILE_BG_GRASS_START_16     = SCREEN_RAM + $F0 + (10 * $28)
TILE_BG_GRASS_START_17     = SCREEN_RAM + $F0 + (11 * $28)

TILE_BG_GRASS_START_18     = SCREEN_RAM + $F0 + (12 * $28)
TILE_BG_GRASS_START_19     = SCREEN_RAM + $F0 + (13 * $28)
TILE_BG_GRASS_START_20     = SCREEN_RAM + $F0 + (14 * $28)
TILE_BG_GRASS_START_21     = SCREEN_RAM + $F0 + (15 * $28)


; color ram version
TILE_BG_GRASS_START_COL_6     = COLOR_RAM + $F0 + (0 * $28)
TILE_BG_GRASS_START_COL_7     = COLOR_RAM + $F0 + (1 * $28)
TILE_BG_GRASS_START_COL_8     = COLOR_RAM + $F0 + (2 * $28)
TILE_BG_GRASS_START_COL_9     = COLOR_RAM + $F0 + (3 * $28)

TILE_BG_GRASS_START_COL_10     = COLOR_RAM + $F0 + (4 * $28)
TILE_BG_GRASS_START_COL_11     = COLOR_RAM + $F0 + (5 * $28)
TILE_BG_GRASS_START_COL_12     = COLOR_RAM + $F0 + (6 * $28)
TILE_BG_GRASS_START_COL_13     = COLOR_RAM + $F0 + (7 * $28)

TILE_BG_GRASS_START_COL_14     = COLOR_RAM + $F0 + (8 * $28)
TILE_BG_GRASS_START_COL_15     = COLOR_RAM + $F0 + (9 * $28)
TILE_BG_GRASS_START_COL_16     = COLOR_RAM + $F0 + (10 * $28)
TILE_BG_GRASS_START_COL_17     = COLOR_RAM + $F0 + (11 * $28)

TILE_BG_GRASS_START_COL_18     = COLOR_RAM + $F0 + (12 * $28)
TILE_BG_GRASS_START_COL_19     = COLOR_RAM + $F0 + (13 * $28)
TILE_BG_GRASS_START_COL_20     = COLOR_RAM + $F0 + (14 * $28)
TILE_BG_GRASS_START_COL_21     = COLOR_RAM + $F0 + (15 * $28)




PROCGEN_COUNTER
    !byte   $00

PROCGEN_CHAR_BUFF
    !fill 16, $00 
PROCGEN_COL_BUFF
    !fill 16, GREEN

TILE_BG_CR2
    !byte   $00


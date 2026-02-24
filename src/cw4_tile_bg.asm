
!macro TILE_BG_SCROLL_ROW .row_addr {
    lda     #<.row_addr     ; set up safe zero page for offset
    sta     ZP_PTR_1
    lda     #>.row_addr
    sta     ZP_PTR_1_PAIR

    ldy     #0
-
    iny                     ; Look at next char
    lda     (ZP_PTR_1),y    ; Indirect read
    dey                     ; Step back
    sta     (ZP_PTR_1),y    ; Indirect write
    iny                     ; Move forward to next pair
    cpy     #38             ; Done all 37? (38-1 leaving right col alone to write later)
    bne     -

    ;iny                     ; last col
    lda     #BLANK_SPACE
    sta     (ZP_PTR_1),y    ; blank final col
}

TILE_BG_SETUP
    ; reset scroll offsets
    jsr     SCREEN_RESET_SCROLL_X
    jsr     SCREEN_RESET_SCROLL_Y


    ; title text
    ldy     #0

; TILE_BG_SETUP_LOOP
;     lda     .hellotext,y
;     beq     +
;     sta     SCREEN_RAM+15+SCREEN_WIDTH_CHARS,y
;     lda     #PURPLE
;     sta     COLOR_RAM+15+SCREEN_WIDTH_CHARS,y
;     iny
;     jmp     TILE_BG_SETUP_LOOP
; +

; test tree
; col 38 is offscreen - but scroll_y is 0, which is shifted 7 bits left so 7 col pixels rows show in max col 37

    lda     #$40        ; first 'udg' - tree base
    sta     SCREEN_RAM+38+(40*16)
    lda     #BROWN
    sta     COLOR_RAM+38+(40*16)

    lda     #$41        ; tree trunk
    sta     SCREEN_RAM+38+(40*15)
    lda     #BROWN
    sta     COLOR_RAM+38+(40*15)

    lda     #$42        ; tree top
    sta     SCREEN_RAM+38+(40*14)
    lda     #LT_GREEN
    sta     COLOR_RAM+38+(40*14)

    lda     #$41        ; tree trunk top grass align
    sta     SCREEN_RAM+38+(40*6)
    lda     #BROWN
    sta     COLOR_RAM+38+(40*6)

    lda     #$41        ; tree trunk bottom grass align
    sta     SCREEN_RAM+38+(40*21)
    lda     #BROWN
    sta     COLOR_RAM+38+(40*21)

    rts


TILE_BG_SCROLL
    ; only every 8 frames for now...
    lda     TILE_BG_FRAME_COUNTER
    inc     TILE_BG_FRAME_COUNTER
    and     #%00000111       ; 0-7

    beq     TILE_BG_DEC_SCROLL_CHARS

    jsr     SCREEN_DEC_SCROLL_X
    rts                 ; TILE_BG_SCROLL

TILE_BG_DEC_SCROLL_CHARS
    ; rows 6-22
    +TILE_BG_SCROLL_ROW TILE_BG_GRASS_START_6
    +TILE_BG_SCROLL_ROW TILE_BG_GRASS_START_7
    +TILE_BG_SCROLL_ROW TILE_BG_GRASS_START_8
    +TILE_BG_SCROLL_ROW TILE_BG_GRASS_START_9

    +TILE_BG_SCROLL_ROW TILE_BG_GRASS_START_10
    +TILE_BG_SCROLL_ROW TILE_BG_GRASS_START_11
    +TILE_BG_SCROLL_ROW TILE_BG_GRASS_START_12
    +TILE_BG_SCROLL_ROW TILE_BG_GRASS_START_13

    +TILE_BG_SCROLL_ROW TILE_BG_GRASS_START_14
    +TILE_BG_SCROLL_ROW TILE_BG_GRASS_START_15
    +TILE_BG_SCROLL_ROW TILE_BG_GRASS_START_16
    +TILE_BG_SCROLL_ROW TILE_BG_GRASS_START_17

    +TILE_BG_SCROLL_ROW TILE_BG_GRASS_START_18
    +TILE_BG_SCROLL_ROW TILE_BG_GRASS_START_19
    +TILE_BG_SCROLL_ROW TILE_BG_GRASS_START_20
    +TILE_BG_SCROLL_ROW TILE_BG_GRASS_START_21

    +TILE_BG_SCROLL_ROW TILE_BG_GRASS_START_22

    ; reset scroll x
    jsr     SCREEN_RESET_SCROLL_X


    ; procgen tree
    ; not yet...

    ; fill right column with blanks and trees
    ; blanks for now...
    ; 16 loop blanking col 38

    rts                 ; TILE_BG_SCROLL





.hellotext
    !scr    "c-witchy-4",0

TILE_BG_FRAME_COUNTER
    !byte   $00

; grass starts at row: 6
; goes 16 rows to: 22
; base is SCREEN_RAM $4000
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

TILE_BG_GRASS_START_22     = SCREEN_RAM + $F0 + (16 * $28)

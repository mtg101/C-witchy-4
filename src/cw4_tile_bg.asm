
!macro TILE_BG_SCROLL_ROW .row_addr, .proc_row {
    lda #<.row_addr     ; set up safe zero page for offset
    sta ZP_PTR_2
    lda #>.row_addr
    sta ZP_PTR_2_PAIR

    ldy #0
-
    iny                 ; Look at next char
    lda (ZP_PTR_2),y    ; Indirect read
    dey                 ; Step back
    sta (ZP_PTR_2),y    ; Indirect write
    iny                 ; Move forward to next pair
    cpy #38             ; Done all 37? (38-1 leaving right col alone to write later)
    bne     -

    ;iny                ; last col from procgen
    lda PROCGEN_COL_BUFF + .proc_row
    sta (ZP_PTR_2),y    
}

TILE_BG_SETUP
    ; reset scroll offsets
    jsr SCREEN_RESET_SCROLL_X
    jsr SCREEN_RESET_SCROLL_Y

    rts


TILE_BG_SCROLL
    ; 16 rows 6-21
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
    
;    +TILE_BG_SCROLL_ROW TILE_BG_GRASS_START_20, 14

    lda #<TILE_BG_GRASS_START_20
    sta ZP_PTR_2
    lda #>TILE_BG_GRASS_START_20
    sta ZP_PTR_2_PAIR

    ldy #0
-
    iny                 ; Look at next char
    lda (ZP_PTR_2),y    ; Indirect read
    dey                 ; Step back
    sta (ZP_PTR_2),y    ; Indirect write
    iny                 ; Move forward to next pair
    cpy #38             ; Done all 37? (38-1 leaving right col alone to write later)
    bne     -

    ;iny                ; last col from procgen
    lda PROCGEN_COL_BUFF + 14
    sta (ZP_PTR_2),y    


    +TILE_BG_SCROLL_ROW TILE_BG_GRASS_START_21, 15

    rts                 ; TILE_BG_SCROLL

TILE_BG_PROCGEN
    ; clear buf
    lda #BLANK_SPACE
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
    sta PROCGEN_COL_BUFF+16

    lda MATHS_RNG
    and #%00001111       ; 0-16
    bne TILE_BG_PROCGEN_DONE    ; 1 in 32 stuff

    ; draw stuff
    lda #$41
    sta PROCGEN_COL_BUFF
    sta PROCGEN_COL_BUFF+15

    lda #$40
    sta PROCGEN_COL_BUFF+9

    lda #$41
    sta PROCGEN_COL_BUFF+8

    lda #$42
    sta PROCGEN_COL_BUFF+7

TILE_BG_PROCGEN_DONE

    rts                 ; TILE_BG_PROCGEN

PROCGEN_COL_BUFF
    !fill 16, $00 


;TILE_BG_SCROLL_SMC
; ---------------------------------------------------------
; SMC FULL ROW SCROLL (Screen + Color)
; ---------------------------------------------------------

; Parameters for this example: 
; Screen Row Start: $0428 (Row 1)
; Color Row Start:  $D828 (Row 1)

; PrepareScroll
;     ; 1. Setup Screen RAM addresses
;     lda #$28            ; Low Byte for offset 40
;     sta scr_src + 1
;     sta scr_dst + 1
;     inc scr_src + 1     ; Src is offset 41 (dest + 1)

;     lda #$04            ; High Byte for Screen
;     sta scr_src + 2
;     sta scr_dst + 2

;     ; 2. Setup Color RAM addresses
;     lda #$28            ; Same Low Byte
;     sta col_src + 1
;     sta col_dst + 1
;     inc col_src + 1

;     lda #$d8            ; High Byte for Color RAM
;     sta col_src + 2
;     sta col_dst + 2

; ExecuteScroll
;     ldx #$00
; .loop
; scr_src
;     lda $ffff,x         ; Poked: lda $0429,x
; scr_dst
;     sta $ffff,x         ; Poked: sta $0428,x

; col_src
;     lda $ffff,x         ; Poked: lda $d829,x
; col_dst
;     sta $ffff,x         ; Poked: sta $d828,x

;     inx
;     cpx #$27            ; 39 characters
;     bne .loop

;     ; Optional: Fill the last column (39) with a space/color
;     lda #$20            ; Space
;     sta $0428 + 39      ; Hardcoded or use more SMC
;     rts



; .hellotext
;     !scr    "c-witchy-4",0

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


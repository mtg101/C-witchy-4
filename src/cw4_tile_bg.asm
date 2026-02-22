


TILE_BG_SETUP
    ; reset scroll offsets
    jsr     SCREEN_RESET_SCROLL_X
    jsr     SCREEN_RESET_SCROLL_Y


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
    ; need global frame counter...


    ; scroll green area (ignoring wrap)

    ; grass starts at row: 6
    ; grass ends at row: 22
    ; which it total rows: 22-6=16
    ; 16 rows, 37 copies per row
    ; 16 loops of 38 copies: unrolled :) -- yes 38, 1 into 0... 38 into 37


    ; procgen tree
    ; not yet...

    ; fill right column with blanks and trees
    ; blanks for now...
    ; 16 loop blanking col 38



    rts


.hellotext
    !scr    "c-witchy-4",0

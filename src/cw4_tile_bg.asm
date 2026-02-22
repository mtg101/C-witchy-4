


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
; col 38 is max displayed - but scroll_y is 0, which is shifter far left from 39 into 38, so missing a pixel (I think...)
; col 39 exists hidden - use for scroll test

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
    ; scroll green area (ignoring wrap)




    ; procgen tree


    ; fill right column with blanks and trees


    rts


.hellotext
    !scr    "c-witchy-4",0

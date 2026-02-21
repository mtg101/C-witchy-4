

SCREEN_SET_MULTI_COLOR_CHARACTER_MODE
    lda VIC_CR2
    ora #H_MULTICOLOR 
    sta VIC_CR2
    rts

SCREEN_SET_HI_RES_CHARACTER_MODE
    lda VIC_CR2
    and #H_HI_RES 
    sta VIC_CR2
    rts

SCREEN_SET_HOZ_SCROLLING_38
    lda VIC_CR2
    and #H_COL_38  
    sta VIC_CR2
    rts

SCREEN_SET_HOZ_STATIC_40
    lda VIC_CR2
    ora #H_COL_40
    sta VIC_CR2
    rts

SCREEN_OFF
    lda     VIC_CR1
    and     #%11101111 ; Clear Bit 4 
    sta     VIC_CR1
    rts

SCREEN_ON
    lda     VIC_CR1
    ora     #%00010000 ; Set Bit 4 
    sta     VIC_CR1
    rts    
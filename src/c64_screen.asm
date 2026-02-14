

SCREEN_SET_MULTI_COLOR_CHARACTER_MODE
    lda VIC_CR2
    ora #H_MULTICOLOR 
    sta VIC_CR2
    rts


SCREEN_SET_HOZ_SCROLLING_38
    lda VIC_CR2
    ora #H_COL_38  
    sta VIC_CR2
    rts


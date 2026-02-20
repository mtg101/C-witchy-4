

SCREEN_SET_MULTI_COLOR_CHARACTER_MODE
    lda VIC_CR_HOZ
    ora #H_MULTICOLOR 
    sta VIC_CR_HOZ
    rts

SCREEN_SET_HI_RES_CHARACTER_MODE
    lda VIC_CR_HOZ
    and #H_HI_RES 
    sta VIC_CR_HOZ
    rts

SCREEN_SET_HOZ_SCROLLING_38
    lda VIC_CR_HOZ
    and #H_COL_38  
    sta VIC_CR_HOZ
    rts

SCREEN_SET_HOZ_STATIC_40
    lda VIC_CR_HOZ
    ora #H_COL_40
    sta VIC_CR_HOZ
    rts


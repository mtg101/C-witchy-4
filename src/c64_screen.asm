

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

SCREEN_CHAR_COPY_ROM_2800
     sei          ; Disable interrupts to prevent the Kernal 
                  ; from trying to read I/O while we hide it.

     lda $01      ; Save current memory configuration
     pha
     lda #$33     ; Map Character ROM at $D000-$DFFF
     sta $01

    ; --- Setup Pointers in Zero Page ---
    lda #$00
    sta $fb      ; Source Low ($D000)
    sta $fd      ; Destination Low ($2800)
    
    lda #$d0     ; Source High
    sta $fc
    lda #$28     ; Destination High
    sta $fe

    ; --- The 1KB Copy Loop (first 128 chars) ---
    ldx #$04     ; only first 128 chars: 4 pages of 256 bytes = 1024 bytes
    ldy #$00     ; Clear Y index
    
copy_loop:
    lda ($fb),y  ; Grab byte from ROM
    sta ($fd),y  ; Write byte to RAM
    iny          ; Next byte
    bne copy_loop ; Loop until Y wraps to 0 (256 bytes)
    
    inc $fc      ; Move source to next page
    inc $fe      ; Move destination to next page
    dex          ; Decrease page count
    bne copy_loop ; Repeat for all 8 pages

     ; --- Restore Memory Map ---
     pla
     sta $01
     cli          ; Re-enable interrupts

    rts
SCREEN_CHAR_SET_2800
    ; --- Setting Character Memory to $2800 ---
    ; $2800 is Offset 5 (5 * 2048 = 10240 or $2800)
    ; Binary for 5 is %101

    lda MEM_SETUP      ; Get current Screen/Char settings
    and #%11110001 ; Clear bits 1, 2, and 3 (Keep the Screen pointer)
    ora #%00001010 ; Set bits 1-3 to %101 (Binary 5)
    sta MEM_SETUP      ; Apply changes
    rts


SYS_NO_BASIC_ROM
    sei         ; Disable interrupts just in case
    lda #$36    ; Binary %00110110
    sta $01     ; BASIC is now gone!
    cli         ; Re-enable interrupts
    rts

    
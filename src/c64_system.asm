

SYS_NO_BASIC_ROM
    sei         ; Disable interrupts just in case
    lda #ROM_NO_BASIC    
    sta $01     ; BASIC is now gone!

    jsr RASTER_INTERRUPT_SETUP  ; take over irq

    cli         ; Re-enable interrupts
    rts

SYS_NO_BASIC_NO_KERNEL_ROM
    sei         ; Disable interrupts just in case
    lda #ROM_JUST_IO
    sta $01     ; BASIC & kernel both gone

    jsr RASTER_INTERRUPT_SETUP  ; take over irq

    cli         ; Re-enable interrupts
    rts

        
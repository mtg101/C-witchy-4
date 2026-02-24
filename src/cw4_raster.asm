

; +ACK_RASTER to use
; Use our "lazy" ASL $D019 macro
!macro ACK_RASTER {
    asl $D019
}

; does all the stuff like KB and clocks the Kernel handles
!macro EXIT_FULL {
    jmp $EA31
}

; just pops the pushed registers that the interrupt system pushed automatically
!macro EXIT_FAST {
    jmp $FEB1
}

!macro SET_IRQ .irq_name {
    lda #<.irq_name     ; Low byte
    sta $0314           ; Kernel pushes AXY then jumps to addr here
    lda #>.irq_name     ; High byte
    sta $0315           ; Kernel pushes AXY then jumps to addr here
}

; only up to 255... !TODO
!macro RASTER_INTERRUPT_SET_ROW .row {
    lda #.row
    sta RASTER_LINE      
    lda VIC_CR1 
    and #$7f        ; Ensure the 8th bit of the raster line is 0 (for lines < 256)
    sta VIC_CR1
}


; 
RASTER_INTERRUPT_SETUP
    sei             ; 1. Stop all interrupts while we mess with the wires
    
    ; 2. Disable the CIA "Timer" interrupts (the 60Hz system tick)
    lda #$7F
    sta $DC0D       ; Clear CIA 1 interrupt control
    sta $DD0D       ; Clear CIA 2 interrupt control
    lda $DC0D       ; Acknowledge any pending CIA interrupts
    lda $DD0D       ; Acknowledge any pending CIA interrupts

    ; 3. Setup VIC-II to trigger a Raster Interrupt
    lda #$01
    sta VIC_IMASK   ; Enable Raster Interrupts only

    ; 4. Set the line number where the interrupt triggers
    ; default to row 0
    +RASTER_INTERRUPT_SET_ROW 0

    ; 5. Point the Vector to our custom routine
    +SET_IRQ RASTER_IRQ_TOP_BORDER

    cli             ; 6. Re-enable interrupts
    rts             ; Return to BASIC (your IRQ is now running in the background!)


; --- INTERRUPT ROUTINES ---
RASTER_IRQ_TOP_BORDER
    lda     #BLACK
    sta     BORDER_COL
    sta     BG_COL
    +RASTER_INTERRUPT_SET_ROW 50
    +ACK_RASTER         
    +SET_IRQ RASTER_IRQ_SKY
    +EXIT_FAST

RASTER_IRQ_SKY
    inx
    inx
    inx
    inx
    inx
    inx
    inx
    inx
    inx
    inx

    lda     #CYAN
    sta     BORDER_COL
    sta     BG_COL

    jsr     SPRITE_BOB      ; still in IRQ for now...

    +RASTER_INTERRUPT_SET_ROW (51-1+(8*6))
    +ACK_RASTER         
    +SET_IRQ RASTER_IRQ_GRASS
    +EXIT_FAST

RASTER_IRQ_GRASS
    inx
    inx
    inx
    inx
    inx
    inx
    inx
    inx
    inx
    inx

    lda     #GREEN
    sta     BORDER_COL
    sta     BG_COL

    lda     #$01
    sta     RASTER_CHASE_BEAM

    +RASTER_INTERRUPT_SET_ROW (51-1+(8*22))
    +ACK_RASTER         
    +SET_IRQ RASTER_IRQ_RIVER
    +EXIT_FAST

RASTER_IRQ_RIVER
    inx
    inx
    inx
    inx
    inx
    inx
    inx
    inx
    inx
    inx

    lda     #BLUE
    sta     BORDER_COL
    sta     BG_COL

    +RASTER_INTERRUPT_SET_ROW 0
    +ACK_RASTER         
    +SET_IRQ RASTER_IRQ_TOP_BORDER
    +EXIT_FAST

; raster flags go 1 when they're ready for main loop (which will need to clear)
RASTER_CHASE_BEAM
    !byte   $00




; ROM routines

ROM_CLR_SCREEN = $E544

; as the AI said: I’ve got you. Typing out 16 constants is the exact kind of "busy work" 
; that a computer should be doing for you.

; --- C64 Color Constants ---
BLACK       = $00
WHITE       = $01
RED         = $02
CYAN        = $03
PURPLE      = $04
GREEN       = $05
BLUE        = $06
YELLOW      = $07
ORANGE      = $08
BROWN       = $09
LT_RED      = $0a
DK_GRAY     = $0b
MD_GRAY     = $0c
LT_GREEN    = $0d
LT_BLUE     = $0e
LT_GRAY     = $0f

; --- Screen Size ---
SCREEN_WIDTH    = 320
SCREEN_HEIGHT   = 200
SCREEN_WIDTH_CHARS  = 40 
SCREEN_WIDTH_CHARS_SCROLL  = 38
SCREEN_HEIGHT_CHARS = 25
SCREEN_HEIGHT_CHARS_SCROLL = 24

; --- Common VIC-II Registers ---
BORDER_COL  = $D020
BG_COL      = $D021
BG_COL_1    = $D022
BG_COL_2    = $D023
COLOR_RAM   = $D800

SCREEN_RAM  = $0400
CHAR_ROM    = $D000 ; Note: This is in a different bank than RAM!
DEFAULT_CHR = $14   ; Value for $D018 to use Uppercase/Graphics
LOWER_CHR   = $16   ; Value for $D018 to use Lower/Upper


; --- KERNAL JUMP TABLE ---
; PSA: these are all really slow...
SCNKEY  = $ff9f ; Scan keyboard matrix (call manually if not letting system handle everything)
SETLFS  = $ffba ; Set logical file parameters
SETNAM  = $ffbd ; Set filename
OPEN    = $ffc0 ; Open a logical file
CLOSE   = $ffc3 ; Close a logical file
CHKIN   = $ffc6 ; Open channel for input
CHKOUT  = $ffc9 ; Open channel for output
CLRCHN  = $ffcc ; Restore default I/O
CHRIN   = $ffcf ; Get character from input
CHROUT  = $ffd2 ; Output character to screen
LOAD    = $ffd5 ; Load from device
SAVE    = $ffd8 ; Save to device
GETIN   = $ffe4 ; Get character from buffer (call SCNKEY first if taking control from the system)
PLOT    = $fff0 ; Set/Get cursor position

; --- VIC-II Video Controller ---
VIC_BASE    = $D000
SPRITE_0_X  = $D000
SPRITE_0_Y  = $D001

; --- VIC-II Control Registers ---
VIC_CR_VERT = $D011 ; Vertical scroll, Screen On/Off, Bitmap mode, Raster Bit 8
VIC_CR_HOZ  = $D016 ; Horizontal scroll, Multi-color mode, 40/38 column switch
RASTER_LINE = $D012 ; Current scanline (Read) / Trigger line (Write)
MEM_SETUP   = $D018 ; Where are the screen and characters located?
VIC_INTER   = $D019 ; Interrupt Status (ACK)
VIC_IMASK   = $D01A ; Interrupt Control (Which ones are enabled?)

; --- $D011 (Vertical & Mode) Masks ---
V_TEXT_MODE    = %00000000   ; Standard Text
V_BITMAP_MODE  = %00100000   ; Turn on Bitmaps
V_ECM_MODE     = %01000000   ; Extended Color Mode
V_SCREEN_ON    = %00010000   ; Show the screen
V_SCREEN_OFF   = %11101111   ; Hide the screen (use with AND)
V_ROW_25       = %00001000   ; 25 row mode (Standard)
V_ROW_24       = %11110111   ; 24 row mode (For scrolling)
V_RASTER_MSB   = %10000000   ; The 9th bit (Bit 7) of the raster position

; --- $D016 (Horizontal & Multi) Masks ---
H_MULTICOLOR   = %00010000   ; Enable 4-color mode
H_HI_RES       = %11101111
H_COL_40       = %00001000   ; 40 Column mode (Standard)
H_COL_38       = %11110111   ; 38 Column mode (For scrolling)

; ... repeat for Sprites 1-7
; !TODO
MSB_X       = $d010 ; Most Significant Bits of X (for sprites past pixel 255)

; --- Zero Page Pointers ---
; the safe ones if you've not disabled all the ROMs
ZP_PTR_1   = $FB  ; Safe Zero Page Uses $FB and $FC
ZP_PTR_2   = $FD  ; Safe Zero Page Uses $FD and $FE








*=$3200                 ; last 64 chars of font, $40 onwards

tile_bg_base_pixels
!byte %00111100
!byte %00111100
!byte %00111100
!byte %00111100
!byte %00111100
!byte %00111100
!byte %01111110
!byte %11111111

tile_bg_trunk_pixels
!byte %00111100
!byte %00111100
!byte %00111100
!byte %00111100
!byte %00111100
!byte %00111100
!byte %00111100
!byte %00111100

tile_bg_top_pixels
!byte %00111100
!byte %00111110
!byte %01111110
!byte %11111111
!byte %11111111
!byte %01111110
!byte %01111110
!byte %00111100

; being lazy here - using other UDGs to store the tree top variants
; should really have those in regular program memory to free up UDGs but yeah lazy...

tile_bg_top_pixels_norm
!byte %00111100
!byte %00111110
!byte %01111110
!byte %11111111
!byte %11111111
!byte %01111110
!byte %01111110
!byte %00111100

tile_bg_top_pixels_alt
!byte %01111000
!byte %01111100
!byte %01111110
!byte %11111111
!byte %11111110
!byte %11111110
!byte %01111110
!byte %00111100

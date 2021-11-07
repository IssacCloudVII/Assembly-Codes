#include "p16F887.inc"   ; TODO INSERT CONFIG CODE HERE USING CONFIG BITS GENERATOR
 	__CONFIG	_CONFIG1,	_INTRC_OSC_NOCLKOUT & _WDT_OFF & _PWRTE_OFF & _MCLRE_ON & _CP_OFF & _CPD_OFF & _BOR_OFF & _IESO_ON & _FCMEN_ON & _LVP_OFF 
 	__CONFIG	_CONFIG2,	_BOR40V & _WRT_OFF

RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START                   ; go to beginning of program

MAIN_PROG CODE                      ; let linker place main program

i EQU 0x20
j EQU 0x21
 
a equ 0x30
c equ 0x31
d equ 0x32
e equ 0x33
 
n equ 0x25
 
m equ 0x10
p equ 0x35
x equ 0x12
y equ 0x13 
 
n1 equ 0x15
n2 equ 0x16
r equ 0x17
pos equ 0x40
 
START

    BANKSEL PORTA ;
    CLRF PORTA ;Init PORTA
    BANKSEL ANSEL ;
    CLRF ANSEL ;digital I/O
    CLRF ANSELH
    BANKSEL TRISA ;
    CLRF TRISA
    CLRF TRISB
    CLRF TRISC
    CLRF TRISD
    CLRF TRISE
    MOVLW b'00001111'
    MOVWF TRISD
    BCF STATUS,RP1
    BCF STATUS,RP0
    CLRF PORTA
    CLRF PORTB
    CLRF PORTC
    CLRF PORTD
    CLRF PORTE
    
INITLCD
    
    BCF PORTA,0		;reset
    MOVLW 0x01
    MOVWF PORTB
    
    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
    
    MOVLW 0x0C		;first line
    MOVWF PORTB
    
    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
         
    MOVLW 0x3C		;cursor mode
    MOVWF PORTB
    
    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
  
    
INICIO	  
   
    call INITLCD_f
    
    BCF PORTA, 7
    CLRF PORTC
  
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0x80
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time

    MOVLW 0x08
    MOVWF n
    
    MOVLW 0x01
    MOVWF m
    
    MOVLW 0x50
    MOVWF FSR
    
    MOVLW 'I'
    MOVWF PORTB
    call exec
    
    MOVLW 'N'
    MOVWF PORTB
    call exec
    
    MOVLW 'S'
    MOVWF PORTB
    call exec
    
    MOVLW 'E'
    MOVWF PORTB
    call exec
    
    MOVLW 'R'
    MOVWF PORTB
    call exec
  
    MOVLW 'T'
    MOVWF PORTB
    call exec
    
    MOVLW 'A'
    MOVWF PORTB
    call exec
    
    MOVLW ' '
    MOVWF PORTB
    call exec
    
    MOVLW 'C'
    MOVWF PORTB
    call exec
    
    MOVLW 'L'
    MOVWF PORTB
    call exec
    
    
    MOVLW 'A'
    MOVWF PORTB
    call exec
    
    
    MOVLW 'V'
    MOVWF PORTB
    call exec
    
    MOVLW 'E'
    MOVWF PORTB
    call exec
    
    MOVLW ':'
    MOVWF PORTB
    call exec
    
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0xC0	;LCD position
    MOVWF PORTB
    CALL exec
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    BSF PORTA,0		;data mode
    CALL time
          
    MOVLW 0xC0
    MOVWF pos
;    MOVLW 'a'
;    MOVWF INDF
;    INCF FSR
;    MOVLW 'b'
;    MOVWF INDF
;    
;    MOVLW 0x50
;    MOVWF FSR
;    MOVFW INDF
;    MOVWF PORTB
;    call exec
;    INCF FSR
;    MOVFW INDF
;    MOVWF PORTB
;    call exec
    
    
;   GOTO $
    
;    MOVLW d'10'
;    MOVWF value
;    MOVWF random
;    BCF STATUS, C
;    RRF value,f
;    BTFSC STATUS, C
;    BSF value, 7
;    MOVF value, w
;    BTFSC STATUS, C
;    XORLW 0xFF
;    BTFSS STATUS, C
;    XORLW 0x00
;    ANDLW b'00011100'
;    MOVWF temp
;    MOVF value, w
;    ANDLW b'11100011'
;    IORWF temp, w
;    MOVWF value
;    
;    MOVFW value
;    ADDLW 0x40
;    MOVWF PORTB
;    call exec
PUERTOS_ANTES:
    BCF PORTA,0		;command mode
    CALL time
    
    MOVFW pos	;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time
PUERTOS
    BSF PORTD,4
    BTFSC PORTD,3
    call NUM_1
    BTFSC PORTD,2
    call NUM_4
    BTFSC PORTD,1
    call NUM_7
    BTFSC PORTD,0
    call BORRAR
    BCF PORTD,4
    
    BSF PORTD,5
    BTFSC PORTD,3
    call NUM_2
    BTFSC PORTD,2
    call NUM_5
    BTFSC PORTD,1
    call NUM_8
    BTFSC PORTD,0
    call NUM_0
    BCF PORTD,5
    
    BSF PORTD,6
    BTFSC PORTD,3
    call NUM_3
    BTFSC PORTD,2
    call NUM_6
    BTFSC PORTD,1
    call NUM_9
    BCF PORTD,6
    
    GOTO PUERTOS
    
NUM_0:
    
    MOVLW '0'
    MOVWF PORTB
    CALL exec
    call tiempo_1
    
    MOVLW d'0'
    MOVWF INDF
    
    GOTO SIGUIENTE
return
    
NUM_1:
    
    MOVLW '1'
    MOVWF PORTB
    CALL exec
    call tiempo_1
    
    MOVLW d'1'
    MOVWF INDF
    
    GOTO SIGUIENTE
return 
    
    
NUM_2:
    
    MOVLW '2'
    MOVWF PORTB
    CALL exec
    call tiempo_1
    
    MOVLW d'2'
    MOVWF INDF
    
    GOTO SIGUIENTE
return 
    
    
NUM_3:
    
    MOVLW '3'
    MOVWF PORTB
    CALL exec
    call tiempo_1
    
    MOVLW d'3'
    MOVWF INDF
    
    GOTO SIGUIENTE
return 
    
NUM_4:
    
    MOVLW '4'
    MOVWF PORTB
    CALL exec
    call tiempo_1
    
    MOVLW d'4'
    MOVWF INDF
    
    GOTO SIGUIENTE
return 
    
    
NUM_5:
    
    MOVLW '5'
    MOVWF PORTB
    CALL exec
    call tiempo_1
    
    MOVLW d'5'
    MOVWF INDF
    
    GOTO SIGUIENTE
return 
    
    
NUM_6:
    
    MOVLW '6'
    MOVWF PORTB
    CALL exec
    call tiempo_1
    
    MOVLW d'6'
    MOVWF INDF
    GOTO SIGUIENTE
return 

    
NUM_7:
    
    MOVLW '7'
    MOVWF PORTB
    CALL exec
    call tiempo_1
    
    MOVLW d'7'
    MOVWF INDF
    
    GOTO SIGUIENTE
return 
    
    
NUM_8:
    
    MOVLW '8'
    MOVWF PORTB
    CALL exec
    call tiempo_1
    
    MOVLW d'8'
    MOVWF INDF
    
    GOTO SIGUIENTE
return 
    
    
NUM_9:
    
    MOVLW '9'
    MOVWF PORTB
    CALL exec
    call tiempo_1
    
    MOVLW d'9'
    MOVWF INDF
    
    GOTO SIGUIENTE
return 

BORRAR:
    
    
    DECF pos
      
    BCF PORTA,0		;command mode
    CALL time
    
    MOVFW pos	;LCD position
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time
    
    MOVLW ' '
    MOVWF PORTB
    CALL exec
   
    call tiempo_1
    
    MOVLW d'0'
    MOVWF INDF
    DECF FSR
    INCF n
     
    GOTO PUERTOS_ANTES
return 
    
 
SIGUIENTE:
    INCF FSR
    INCF pos
    DECFSZ n
    GOTO PUERTOS
    
    DECFSZ m
    GOTO FINAL
    BCF PORTA,0	
    CALL time
    
    MOVLW 0x02
    MOVWF m
   
    MOVLW 0x90	
    MOVWF PORTB
    CALL exec

    BSF PORTA,0
    CALL time
    
    MOVLW 0x60
    MOVWF FSR
    MOVLW 0x08
    MOVWF n
    
    MOVLW 0xD0
    MOVWF pos
    
    MOVLW 'C'
    MOVWF PORTB
    call exec
    
    MOVLW 'O'
    MOVWF PORTB
    call exec
    
    MOVLW 'N'
    MOVWF PORTB
    call exec
    
    MOVLW 'F'
    MOVWF PORTB
    call exec
    
    MOVLW 'I'
    MOVWF PORTB
    call exec
  
    MOVLW 'R'
    MOVWF PORTB
    call exec
    
    MOVLW 'M'
    MOVWF PORTB
    call exec
    
    MOVLW 'E'
    MOVWF PORTB
    call exec
    
    
    MOVLW ' '
    MOVWF PORTB
    call exec
    
    MOVLW 'C'
    MOVWF PORTB
    call exec
    
    MOVLW 'L'
    MOVWF PORTB
    call exec
    
    
    MOVLW 'A'
    MOVWF PORTB
    call exec
    
    
    MOVLW 'V'
    MOVWF PORTB
    call exec
    
    MOVLW 'E'
    MOVWF PORTB
    call exec
    
    MOVLW ':'
    MOVWF PORTB
    call exec

    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0xD0	;LCD position
    MOVWF PORTB
    CALL exec
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    BSF PORTA,0		;data mode
    CALL time
    
    GOTO PUERTOS

FINAL:
  
    call INITLCD_f
    
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0x80
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time
    
    MOVLW d'8'
    MOVWF p
    
FINAL_2:
    
;    MOVLW 0x08
;    MOVWF n
;    
;    MOVLW 0x60
;    MOVWF FSR
;    GOTO IMPRIMIR
;
;    MOVLW 0x08
;    MOVWF n
;    
;    MOVLW 0x60
;    MOVWF FSR
;    GOTO IMPRIMIR
;    
;    GOTO $
    
    MOVLW 0x50 ;w = 50
    ADDWF p, w ;w = 58
    MOVWF x ; x = 58
    DECF x,f ; x = 57
;    
    MOVLW 0x60 ; w = 60
    ADDWF p,0 ; w = 68
    MOVWF y ; y = 68
    DECF y,f ; y = 67
    
;    MOVFW p
;    ADDLW d'48'
;    MOVWF PORTB
;    call exec
    
;    MOVFW x
;    MOVWF PORTB
;    call exec
;    
;    MOVFW y
;    MOVWF PORTB
;    call exec
    
;    GOTO $

;    MOVFW y
;    MOVWF FSR
;    MOVFW INDF
;    ADDLW d'48'
;    MOVWF PORTB
;    call exec
;    
;    GOTO $
    
    MOVFW x
    MOVWF FSR 
    MOVFW INDF
    MOVWF n1
;    
;    MOVFW n1
;    ADDLW d'48'
;    MOVWF PORTB
;    call exec
;    
    MOVFW y
    MOVWF FSR
    MOVFW INDF
    MOVWF n2
;    
;    MOVFW n2
;    ADDLW d'48'
;    MOVWF PORTB
;    call exec
    
;    GOTO $
    
    MOVFW n1
    
    XORWF n2, W
    
    MOVWF PORTC
    
    BTFSC PORTC, 0
    GOTO INCORRECTO
    BTFSC PORTC, 1
    GOTO INCORRECTO
    BTFSC PORTC, 2
    GOTO INCORRECTO
    BTFSC PORTC, 3
    GOTO INCORRECTO
    BTFSC PORTC, 4
    GOTO INCORRECTO
    BTFSC PORTC, 5
    GOTO INCORRECTO
    BTFSC PORTC, 6
    GOTO INCORRECTO
    BTFSC PORTC, 7
    GOTO INCORRECTO
    DECFSZ p
    GOTO FINAL_2
    GOTO CORRECTO

INCORRECTO: 
    
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0xC6
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time
    
    MOVLW 'T'
    MOVWF PORTB
    call exec
    
    MOVLW 'E'
    MOVWF PORTB
    call exec
    
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0x92
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time
    
    MOVLW 'E'
    MOVWF PORTB
    call exec
    
    MOVLW 'Q'
    MOVWF PORTB
    call exec
    
    MOVLW 'U'
    MOVWF PORTB
    call exec
    
    MOVLW 'I'
    MOVWF PORTB
    call exec
    
    MOVLW 'V'
    MOVWF PORTB
    call exec
    
    MOVLW 'O'
    MOVWF PORTB
    call exec
    
    MOVLW 'C'
    MOVWF PORTB
    call exec
    
    MOVLW 'A'
    MOVWF PORTB
    call exec
    
    MOVLW 'S'
    MOVWF PORTB
    call exec
    
    MOVLW 'T'
    MOVWF PORTB
    call exec
    
    MOVLW 'E'
    MOVWF PORTB
    call exec
    
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0xD4
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time
    
    MOVLW 'V'
    MOVWF PORTB
    call exec
    
    MOVLW 'A'
    MOVWF PORTB
    call exec
    
    MOVLW 'L'
    MOVWF PORTB
    call exec
    
    MOVLW 'I'
    MOVWF PORTB
    call exec
    
    MOVLW 'O'
    MOVWF PORTB
    call exec
    
    MOVLW ' '
    MOVWF PORTB
    call exec
    
    MOVLW ':'
    MOVWF PORTB
    call exec
    
    MOVLW '('
    MOVWF PORTB
    call exec
    
    GOTO REINICIO
   
CORRECTO: 
    
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0xC4
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time
    
    MOVLW 'C'
    MOVWF PORTB
    call exec
    
    MOVLW 'L'
    MOVWF PORTB
    call exec
    
    MOVLW 'A'
    MOVWF PORTB
    call exec
    
    MOVLW 'V'
    MOVWF PORTB
    call exec
    
    MOVLW 'E'
    MOVWF PORTB
    call exec
    
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0x92
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time
    
    MOVLW 'C'
    MOVWF PORTB
    call exec
    
    MOVLW 'O'
    MOVWF PORTB
    call exec
    
    MOVLW 'R'
    MOVWF PORTB
    call exec
    
    MOVLW 'R'
    MOVWF PORTB
    call exec
    
    MOVLW 'E'
    MOVWF PORTB
    call exec
    
    MOVLW 'C'
    MOVWF PORTB
    call exec
    
    MOVLW 'T'
    MOVWF PORTB
    call exec
    
    MOVLW 'A'
    MOVWF PORTB
    call exec
    
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0xD4
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		;data mode
    CALL time
    
    MOVLW 'Y'
    MOVWF PORTB
    call exec
    
    MOVLW 'E'
    MOVWF PORTB
    call exec
    
    MOVLW 'I'
    MOVWF PORTB
    call exec
    
    MOVLW ':'
    MOVWF PORTB
    call exec
    
    MOVLW 'D'
    MOVWF PORTB
    call exec
    
    GOTO REINICIO
    
IMPRIMIR:
    MOVFW INDF 
    ADDLW d'48'
    MOVWF PORTB
    call exec
    INCF FSR
    DECFSZ n
    GOTO IMPRIMIR
    return
    
exec

    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
    RETURN
    
time
    CLRF i
    MOVLW d'10'
    MOVWF j
ciclo    
    MOVLW d'80'
    MOVWF i
    DECFSZ i
    GOTO $-1
    DECFSZ j
    GOTO ciclo
    RETURN
    
tiempo_1:
movlw d'4' ;establecer valor de la variable m
movwf e
mloop_1:
nop
decfsz e,f
goto mloop_1
movlw d'25' ;establecer valor de la variable i
movwf a
iloop_1: ;NOPs de relleno (ajuste de tiempo)
movlw d'27' ;establecer valor de la variable j
movwf c
jloop_1:
nop ;NOPs de relleno (ajuste de tiempo)
nop
nop
movlw d'200' ;establecer valor de la variable k
movwf d
kloop_1:
decfsz d,f
goto kloop_1
decfsz c,f
goto jloop_1
decfsz a,f
goto iloop_1
return ;salir de la rutina de tiempo y regresar al
;valor de contador de programa
    
INITLCD_f:
    BCF PORTA,0		;reset
    MOVLW 0x01
    MOVWF PORTB
    
    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
    
    MOVLW 0x0C		;first line
    MOVWF PORTB
    
    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
         
    MOVLW 0x3C		;cursor mode
    MOVWF PORTB
    
    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
return 
    
REINICIO:
    BTFSC PORTA, 7
    GOTO INICIO
goto REINICIO
    

END

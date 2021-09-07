#include "p16F628a.inc"    ;incluir librerias relacionadas con el dispositivo
 __CONFIG _FOSC_INTOSCCLK & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _CP_OFF    
;configuración del dispositivotodo en OFF y la frecuencia de oscilador
;es la del "reloj del oscilador interno" (INTOSCCLK)     
RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START                   ; go to beginning of program
; TODO ADD INTERRUPTS HERE IF USED
MAIN_PROG CODE                      ; let linker place main program
;variables para el contador:
i equ 0x30
j equ 0x31
k equ 0x32
;inicio del programa: 
START
    MOVLW 0x07 ;Apagar comparadores
    MOVWF CMCON
    BCF STATUS, RP1 ;Cambiar al banco 1
    BSF STATUS, RP0 
    MOVLW b'00000001'
    MOVWF TRISA ;Archivo de configuración del puerto A
    MOVLW b'00000000' ;Establecer puerto B como salida (los 8 bits del puerto)
    MOVWF TRISB 
    CLRF PORTB
    BCF STATUS, RP0 ;Regresar al banco 0

 

INICIO
     
    MOVLW b'00000110' ; W = 6
    MOVWF PORTB ;b = w
    MOVWF i ;i = w
    GOTO $+3
    MOVFW i ;w = i
    MOVWF PORTB
    BTFSS PORTA, 0
    GOTO $+4
    DECFSZ i
    GOTO $-5
    GOTO $-10
    BTFSS PORTA,0
    GOTO $-1
    GOTO $-7
   
    
    
    
    ;BTFSS PORTA,7
    ;GOTO $-1
    ;INCF PORTB,
    ;BTFSC PORTA,7
    ;GOTO $-1
    ;GOTO $-5
    
    ;BSF PORTB, 7 
    ;BSF PORTB, 4 
    ;BSF PORTB, 3 
    ;BSF PORTB, 1
    
    ;BTFSC PORTA, 7
    ;BSF PORTB,7
    ;BTFSS PORTA,7
    ;BCF PORTB,7 Para prender el LED si aprieto el botón. 
   
   
    ;GOTO $-4
    ;MOVLW b'10011010'
    ;MOVWF PORTB	
    
    END
#include "p16F628a.inc" ;incluir librerias relacionadas con el dispositivo
__CONFIG _FOSC_INTOSCCLK & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _CP_OFF
;configuración del dispositivotodo en OFF y la frecuencia de oscilador
;es la del "reloj del oscilador interno" (INTOSCCLK)
RES_VECT CODE 0x0000 ; processor reset vector
GOTO START ; go to beginning of program
; TODO ADD INTERRUPTS HERE IF USED
MAIN_PROG CODE ; let linker place main program
;variables para el contador:
i equ 0x30
j equ 0x31
k equ 0x32
m equ 0x33
;inicio del programa:
START
MOVLW 0x07 ;Apagar comparadores
MOVWF CMCON
BCF STATUS, RP1 ;Cambiar al banco 1
BSF STATUS, RP0
MOVLW b'00000000' ;Establecer puerto B como salida (los 8 bits del puerto)
MOVWF TRISB
BCF STATUS, RP0 ;Regresar al banco 0
CLRF PORTB
NOP

inicio:
CLRF PORTB
bsf PORTB,1
bsf PORTB,6
call tiempo_5 ;llamar a la rutina de tiempo
bcf PORTB, 1
bsf PORTB, 2
call tiempo_1
bcf PORTB, 1
bcf PORTB, 6
bcf PORTB, 2
bsf PORTB,3
bsf PORTB,4
call tiempo_5
bcf PORTB, 4
bsf PORTB, 5
call tiempo_1
goto inicio
tiempo_5:
nop
nop
nop
nop
nop
nop
movlw d'156' ;establecer valor de la variable m
movwf m
mloop:
nop
nop
nop
nop
nop
nop
nop
decfsz m,f
goto mloop
movlw d'166' ;establecer valor de la variable i
movwf i
iloop: 
nop  
nop
nop
nop
nop
nop
nop;NOPs de relleno (ajuste de tiempo)
movlw d'100' ;establecer valor de la variable j
movwf j
jloop:
nop ;NOPs de relleno (ajuste de tiempo)
nop
nop
movlw d'98' ;establecer valor de la variable k
movwf k
kloop:
decfsz k,f
goto kloop
decfsz j,f
goto jloop
decfsz i,f
goto iloop
return ;salir de la rutina de tiempo y regresar al
;valor de contador de programa
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
tiempo_1:
movlw d'4' ;establecer valor de la variable m
movwf m
mloop_1:
nop
decfsz m,f
goto mloop_1
movlw d'61' ;establecer valor de la variable i
movwf i
iloop_1: ;NOPs de relleno (ajuste de tiempo)
movlw d'27' ;establecer valor de la variable j
movwf j
jloop_1:
nop ;NOPs de relleno (ajuste de tiempo)
nop
nop
movlw d'200' ;establecer valor de la variable k
movwf k
kloop_1:
decfsz k,f
goto kloop_1
decfsz j,f
goto jloop_1
decfsz i,f
goto iloop_1
return ;salir de la rutina de tiempo y regresar al
;valor de contador de programa
END
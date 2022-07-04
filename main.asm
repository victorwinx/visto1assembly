;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
;
;
;-------------------------------------------------------------------------------
            .cdecls C,LIST,"msp430.h"       ; Include device header file
            
;-------------------------------------------------------------------------------
            .def    RESET                   ; Export program entry-point to
                                            ; make it known to linker.
;-------------------------------------------------------------------------------
            .text                           ; Assemble into program memory.
            .retain                         ; Override ELF conditional linking
                                            ; and retain current section.
            .retainrefs                     ; And retain any sections that have
                                            ; references to current section.

;-------------------------------------------------------------------------------
RESET       mov.w   #__STACK_END,SP         ; Initialize stackpointer
StopWDT     mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer


;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------
RT_TAM			.equ	6;
CONF1			.equ	1;

VISTO1:			MOV		#MSG,R5;
				MOV		#GSM,R6;
				CALL	#ENIGMA3;
				JMP		$;
				NOP;


ENIGMA3:		MOV.B	@R5,R7;
				TST.B	R7;
				JNZ		EN1;
				RET
EN1:			SUB.B	#'A',R7;
				ADD.B	#CONF1,R7;
				CMP		#'F'+1,R7;
				JZ		ATUALIZACAO;
CONTINUACAO:	MOV.B	RT1(R7),R7
				MOV.B	RF1(R7),R7
				ADD.B	#'A',R7;
				MOV.B	R7,0(R6);
				JMP		ENIGMA3;

ATUALIZACAO:	SUB.B		#'F',R7;
				;ADD.B		CONF1,R7
				JMP			CONTINUACAO;

         		.data
MSG:			.byte	"CABECAFEFACAFAD",0;
GSM:			.byte	"XXXXXXXXXXXXXXX",0;
DCF:			.byte	"XXXXXXXXXXXXXXX",0;
RT1:			.byte	2,4,1,5,3,0;
RF1:			.byte	3,5,4,0,2,1;
;-------------------------------------------------------------------------------
; Stack Pointer definition
;-------------------------------------------------------------------------------
            .global __STACK_END
            .sect   .stack
            
;-------------------------------------------------------------------------------
; Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET
            

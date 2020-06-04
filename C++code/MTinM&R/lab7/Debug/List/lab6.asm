
;CodeVisionAVR C Compiler V3.12 Advanced
;(C) Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Debug
;Chip type              : ATmega128A
;Program type           : Application
;Clock frequency        : 11,052900 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 1024 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: No
;Enhanced function parameter passing: Yes
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATmega128A
	#pragma AVRPART MEMORY PROG_FLASH 131072
	#pragma AVRPART MEMORY EEPROM 4096
	#pragma AVRPART MEMORY INT_SRAM SIZE 4096
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x100

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU RAMPZ=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F
	.EQU XMCRA=0x6D
	.EQU XMCRB=0x6C

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0100
	.EQU __SRAM_END=0x10FF
	.EQU __DSTACK_SIZE=0x0400
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __EEPROMRDD
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z
	MOVW R30,R0
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_0x12:
	.DB  0x41,0xA0,0x42,0xA1,0xE0,0x45,0xA3,0xA4
	.DB  0xA5,0xA6,0x4B,0xA7,0x4D,0x48,0x4F,0xA8
	.DB  0x50,0x43,0x54,0xA9,0xAA,0x58,0xE1,0xAB
	.DB  0xAC,0xE2,0xAD,0xAE,0x62,0xAF,0xB0,0xB1
	.DB  0x61,0xB2,0xB3,0xB4,0xE3,0x65,0xB6,0xB7
	.DB  0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0x6F,0xBE
	.DB  0x70,0x63,0xBF,0x79,0x5C,0x78,0xE5,0xC0
	.DB  0xC1,0xE6,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7
_0x0:
	.DB  0x74,0x65,0x6D,0x70,0x28,0x30,0x29,0x20
	.DB  0x3D,0x20,0x0,0x74,0x65,0x6D,0x70,0x28
	.DB  0x37,0x29,0x20,0x3D,0x20,0x0
_0x2000060:
	.DB  0x1
_0x2000000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0,0x49,0x4E,0x46
	.DB  0x0

__GLOBAL_INI_TBL:
	.DW  0x0B
	.DW  _0x16
	.DW  _0x0*2

	.DW  0x0B
	.DW  _0x16+11
	.DW  _0x0*2+11

	.DW  0x01
	.DW  __seed_G100
	.DW  _0x2000060*2

_0xFFFFFFFF:
	.DW  0

#define __GLOBAL_INI_TBL_PRESENT 1

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  MCUCR,R31
	OUT  MCUCR,R30
	STS  XMCRB,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,LOW(__SRAM_START)
	LDI  R27,HIGH(__SRAM_START)
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

	OUT  RAMPZ,R24

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x500

	.CSEG
;/*
; * Created: 11.09.2019 11:46:22
; * Author: Student
; * lab6
; * Variant 8
; *
; */
;
;#include <define.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x20
	.EQU __sm_mask=0x1C
	.EQU __sm_powerdown=0x10
	.EQU __sm_powersave=0x18
	.EQU __sm_standby=0x14
	.EQU __sm_ext_standby=0x1C
	.EQU __sm_adc_noise_red=0x08
	.SET power_ctrl_reg=mcucr
	#endif
;
;#include <io.h>
;#include <mega128a.h>
;#include <delay.h>
;
;#define CMD 1
;#define DATA 0
;#define DISPLAY 1
;#define CURSOR 0
;#define RHIGHT 1
;#define LEFT   0
;#define ON 1
;#define OFF 0
;#define EIGHT 1
;#define FOUR 0
;#define ONE 0
;#define TWO 1
;#define EIGHT  1
;#define FOUR   0
;#define LOWERCASE  0
;#define UPPERCASE  1
;#define RS 7 // выбор регистра
;#define E 6 // строб передачи
;
;//установка адреса DDRAM (позиция символа)
;//pos = 0 ... 39
;//line = 0 — first line
;//line = 1 — second line
;void LCD_pos(char pos, char line)
; 0000 0009 {

	.CSEG
_LCD_pos:
; .FSTART _LCD_pos
;   LCD_message(((1<<7)|(pos+line*64)),CMD);
	ST   -Y,R26
;	pos -> Y+1
;	line -> Y+0
	LD   R30,Y
	LDI  R26,LOW(64)
	MULS R30,R26
	MOVW R30,R0
	LDD  R26,Y+1
	ADD  R30,R26
	ORI  R30,0x80
	CALL SUBOPT_0x0
;}
	RJMP _0x2080004
; .FEND
;
;//Вывод числового значения (max 5 десятичных разрядов и больше нуля)
;void LCD_uint(int value)
;{
_LCD_uint:
; .FSTART _LCD_uint
;    int i ;
;    unsigned char flag_first_num = 0 ;
;    unsigned char number;
;    if (value<0) LCD_message(0b10010110,DATA);//выводим минус
	ST   -Y,R27
	ST   -Y,R26
	CALL __SAVELOCR4
;	value -> Y+4
;	i -> R16,R17
;	flag_first_num -> R19
;	number -> R18
	LDI  R19,0
	LDD  R26,Y+5
	TST  R26
	BRPL _0x3
	LDI  R30,LOW(150)
	CALL SUBOPT_0x1
;    for(i=1; i<=5; i++)
_0x3:
	__GETWRN 16,17,1
_0x5:
	__CPWRN 16,17,6
	BRGE _0x6
;    {
;        number = Digit(value,i);
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ST   -Y,R31
	ST   -Y,R30
	MOV  R26,R16
	RCALL _Digit
	MOV  R18,R30
;        if(number != 0)   //появление перового символа
	CPI  R18,0
	BREQ _0x7
;        {
;           flag_first_num = 1;
	LDI  R19,LOW(1)
;        }
;
;        if(flag_first_num == 1)
_0x7:
	CPI  R19,1
	BRNE _0x8
;        {
;
;            LCD_message(number+'0',DATA);//выводим цифру
	MOV  R30,R18
	SUBI R30,-LOW(48)
	CALL SUBOPT_0x1
;        }
;
;    }
_0x8:
	__ADDWRN 16,17,1
	RJMP _0x5
_0x6:
;}
	CALL __LOADLOCR4
	ADIW R28,6
	RET
; .FEND
;
;void LCD_message(char message,int type)
;{
_LCD_message:
; .FSTART _LCD_message
;    //[]--------------------------------------------------[]
;    //| Назначение: запись кодов в регистр команд ЖКИ |
;    //| Входные параметры: message - сообщение |
;    //| Входные параметры: type - тип сообщения (код или данные) |
;    //[]--------------------------------------------------[]
;
;    if(type) // 1
	ST   -Y,R27
	ST   -Y,R26
;	message -> Y+2
;	type -> Y+0
	LD   R30,Y
	LDD  R31,Y+1
	SBIW R30,0
	BREQ _0x9
;    PORTD &= ~(1<<RS); // выбор регистра команд RS=0
	CBI  0x12,7
;    else
	RJMP _0xA
_0x9:
;    PORTD |= (1<<RS); // выбор регистра данных RS=1
	SBI  0x12,7
;    PORTC=message; // записать команду в порт PORTC
_0xA:
	LDD  R30,Y+2
	OUT  0x15,R30
;    PORTD|= (1<<E); // \ сформироватьна
	SBI  0x12,6
;    delay_us(5); // |выводе E строб 1-0
	__DELAY_USB 18
;    PORTD&= ~(1<<E); // / передачи команды
	CBI  0x12,6
;    delay_ms(3); // задержка для завершения записи
	LDI  R26,LOW(3)
	LDI  R27,0
	CALL _delay_ms
;
;}
	RJMP _0x2080002
; .FEND
;
;void LCD_init(void)
;{
_LCD_init:
; .FSTART _LCD_init
;    //[]--------------------------------------------------[]
;    //| Назначение: инициализация ЖКИ |
;    //[]--------------------------------------------------[]
;    DDRC = 0xFF;            // все разряды PORTC на выход
	LDI  R30,LOW(255)
	OUT  0x14,R30
;    DDRD|= ((1<<E)|(1<<RS));// разряды PORTD на выход
	IN   R30,0x11
	ORI  R30,LOW(0xC0)
	OUT  0x11,R30
;    delay_ms (100); // задержка для установления
	LDI  R26,LOW(100)
	LDI  R27,0
	CALL _delay_ms
;                    // напряжения питания
;    LCD_message(0x30,CMD); // \ вывод
	LDI  R30,LOW(48)
	CALL SUBOPT_0x0
;    LCD_message(0x30,CMD); //| трех
	LDI  R30,LOW(48)
	CALL SUBOPT_0x0
;    LCD_message(0x30,CMD); // / команд 0x30
	LDI  R30,LOW(48)
	CALL SUBOPT_0x0
;    LCD_message(0x38,CMD); //8 разр.шина, 2 строки, 5 ? 7 точек
	LDI  R30,LOW(56)
	CALL SUBOPT_0x0
;    LCD_message(0x0E,CMD); // включить ЖКИ и курсор, без мерцания
	LDI  R30,LOW(14)
	CALL SUBOPT_0x0
;    LCD_message(0x06,CMD); //инкремент курсора, без сдвига экрана
	LDI  R30,LOW(6)
	CALL SUBOPT_0x0
;    LCD_message(0x01,CMD); // очистить экран, курсор в начало
	LDI  R30,LOW(1)
	CALL SUBOPT_0x0
;}
	RET
; .FEND
;
;//вывод строковой информации на дисплей
;void LCD_string(unsigned char* str)
;{
_LCD_string:
; .FSTART _LCD_string
;    while(*str != '\0')
	ST   -Y,R27
	ST   -Y,R26
;	*str -> Y+0
_0xB:
	LD   R26,Y
	LDD  R27,Y+1
	LD   R30,X
	CPI  R30,0
	BREQ _0xD
;    {
;        LCD_message(Code(*str++),DATA);
	LD   R30,X+
	ST   Y,R26
	STD  Y+1,R27
	MOV  R26,R30
	RCALL _Code
	CALL SUBOPT_0x1
;        //*str извлечение элемента по адресу в указателе str
;        //str++ увеличение значение указателя на 1 (т.е. переход к следующему элементу массива)
;    }
	RJMP _0xB
_0xD:
;}
	RJMP _0x2080004
; .FEND
;
;unsigned char Digit (unsigned int d, unsigned char m)
;{
_Digit:
; .FSTART _Digit
;    //[]-----------------------------------------------------[]
;    //| Назначение: выделение цифр из разрядов пятиразрядного |
;    //| десятичного положительного числа |
;    //| Входные параметры: |
;    //| d - целое десятичное положительное число |
;    //| m - номер разряда (от 1 до 5, слева направо) |
;    //| Функция возвращает значение цифры в разряде m числа d |
;    //[]-----------------------------------------------------[]
;    unsigned char i = 5, a;
;    while(i)
	ST   -Y,R26
	ST   -Y,R17
	ST   -Y,R16
;	d -> Y+3
;	m -> Y+2
;	i -> R17
;	a -> R16
	LDI  R17,5
_0xE:
	CPI  R17,0
	BREQ _0x10
;    {
;        a = d%10; //если d < 0 то a<0
	LDD  R26,Y+3
	LDD  R27,Y+3+1
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __MODW21U
	MOV  R16,R30
;        if(i-- == m) break;
	PUSH R17
	SUBI R17,1
	LDD  R30,Y+2
	POP  R26
	CP   R30,R26
	BREQ _0x10
;        d /= 10;
	LDD  R26,Y+3
	LDD  R27,Y+3+1
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __DIVW21U
	STD  Y+3,R30
	STD  Y+3+1,R31
;    }
	RJMP _0xE
_0x10:
;    return(a);
	MOV  R30,R16
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,5
	RET
;}
; .FEND
;
;unsigned char Code(unsigned char symb)
;{
_Code:
; .FSTART _Code
;    //[]------------------------------------------------[]
;    //| Назначение: перекодировка символов кириллицы |
;    //| Входные параметры: symb – символ ASCII |
;    //| Функция возвращает код отображения символа |
;    //[]------------------------------------------------[]
;      unsigned char TabCon[] =
;    {0x41,0xA0,0x42,0xA1,0xE0,0x45,0xA3,0xA4,0xA5,0xA6,0x4B, 0xA7,0x4D,0x48,0x4F,0xA8,0x50,0x43,0x54,0xA9,0xAA,0x58,
;    0xE1,0xAB,0xAC,0xE2,0xAD,0xAE,0x62,0xAF,0xB0,0xB1,0x61,
;    0xB2,0xB3,0xB4,0xE3,0x65,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,
;    0xBC,0xBD,0x6F,0xBE,0x70,0x63,0xBF,0x79,0x5C,0x78,0xE5,
;    0xC0,0xC1,0xE6,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7};//коды символов в кириллице
;    return (symb >= 192 ? TabCon[symb-192]: symb);
	ST   -Y,R26
	SBIW R28,63
	SBIW R28,1
	LDI  R24,64
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	LDI  R30,LOW(_0x12*2)
	LDI  R31,HIGH(_0x12*2)
	CALL __INITLOCB
;	symb -> Y+64
;	TabCon -> Y+0
	__GETB2SX 64
	CPI  R26,LOW(0xC0)
	BRLO _0x13
	__GETB1SX 64
	LDI  R31,0
	SUBI R30,LOW(192)
	SBCI R31,HIGH(192)
	MOVW R26,R28
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	RJMP _0x14
_0x13:
	__GETB1SX 64
_0x14:
	ADIW R28,63
	ADIW R28,2
	RET
;}
; .FEND
;
;//очистить дисплей и установить курсор в нулевую позицию(адрес 0 )
;void clear_display()
;{
;    LCD_message(1,CMD);
;};
;
;//установить курсор в нулевую позицию, дисплей относительно буфера DDRAM в начальную позицию
;void default_display()
;{
;    LCD_message(2,CMD);
;};
;
;//установить направление сдвига курсора при записи кода в DDRAM
;// и разрешить(запретить) сдвиг окна вместе с курсором
;// ID = RIGHT
;// ID = LEFT
;// S = ON разрешить сдвиг окна вместе с курсором
;// S = OFF запретить сдвиг окна вместе с курсором
;void shift_direction(int ID,int S)
;{
;  LCD_message((1<<2)|(ID<<1)|S,CMD);
;	ID -> Y+2
;	S -> Y+0
;}
;
;//Включить(выключить) индикатор,зажечь(погасить) курсор.Сделать курсор мигающим
;// B = ON  курсор мигает
;// B = OFF курсор не  мигает
;// D = ON  включить индикатор
;// D = OFF выключить индикатор
;// C = ON  зажечь курсор
;// C = OFF погасить курсор
;void switch_display(int B,int D,int C)
;{
;    LCD_message((1<<3)|(D<<2)|(C<<1)|B,CMD);
;	B -> Y+4
;	D -> Y+2
;	C -> Y+0
;}
;
;//сдвиг курсора или дисплея вправо или влево
;// choose = DISPLAY
;// choose = CURSOR
;// direction = RIGHT
;// direction = LEFT
;void shift(int choose,int direction)
;{
;    LCD_message((1<<4)|(choose<<3)|(direction<<2),CMD);
;	choose -> Y+2
;	direction -> Y+0
;}
;
;//установить разрядность шины данных, количество строк, шрифт
;//data_bus_width = EIGHT 8 бит
;//data_bus_width = FOUR 4 бит
;//line_number = ONE 1 строка
;//line_number = TWO 2 строки
;//font = LOWERCASE  строчные
;////font = UPPERCASE  заглавные
;void display_setting(int data_bus_width,int line_number,int font)
;{
;    LCD_message((1<<5)|(data_bus_width<<4)|(line_number<<3)|(font<<2),CMD);
;	data_bus_width -> Y+4
;	line_number -> Y+2
;	font -> Y+0
;}
;
;// Коды команд
;#define START_CONVERT_T 0x51
;#define READ_TEMPERATURE 0xAA
;#define ACCESS_CONFIG 0xAC
;// Биты регистра конфигурации
;#define R1 3
;#define R0 2
;#define SHOT 0
;#define W 0
;#define R 1
;
;#define SDA 1
;#define SCL 0
;#define DDRX_I2C DDRG
;#define HIGH(pin) (DDRX_I2C &= (~_BV(pin)))
;#define LOW(pin) (DDRX_I2C |= _BV(pin))
;#define PULSE 50 //us
;
;void I2C_Start(void);
;void I2C_Stop(void);
;void I2C_SendByte(unsigned char data);
;unsigned char I2C_ReadByte(unsigned char ack);
;
;// Запуск измерения температуры
;void startConvert(unsigned char address)
; 0000 0024 {
_startConvert:
; .FSTART _startConvert
; 0000 0025 I2C_Start();
	CALL SUBOPT_0x2
;	address -> Y+0
; 0000 0026 I2C_SendByte( 0b10010000 |(address<<1) | W);
; 0000 0027 I2C_SendByte(START_CONVERT_T);
	LDI  R26,LOW(81)
	RJMP _0x2080005
; 0000 0028 I2C_Stop();
; 0000 0029 }
; .FEND
;// Функция чтения температуры с датчика
;int readTemperature(unsigned char address)
; 0000 002C {
_readTemperature:
; .FSTART _readTemperature
; 0000 002D int result;
; 0000 002E I2C_Start();
	ST   -Y,R26
	ST   -Y,R17
	ST   -Y,R16
;	address -> Y+2
;	result -> R16,R17
	RCALL _I2C_Start
; 0000 002F I2C_SendByte( 0b10010000 |(address<<1) | W);
	LDD  R30,Y+2
	LSL  R30
	ORI  R30,LOW(0x90)
	MOV  R26,R30
	RCALL _I2C_SendByte
; 0000 0030 I2C_SendByte(READ_TEMPERATURE);
	LDI  R26,LOW(170)
	RCALL _I2C_SendByte
; 0000 0031 I2C_Start();
	RCALL _I2C_Start
; 0000 0032 I2C_SendByte( 0b10010000 |(address<<1) | R);
	LDD  R30,Y+2
	LSL  R30
	ORI  R30,LOW(0x91)
	MOV  R26,R30
	RCALL _I2C_SendByte
; 0000 0033 result = I2C_ReadByte(0);
	LDI  R26,LOW(0)
	RCALL _I2C_ReadByte
	MOV  R16,R30
	CLR  R17
; 0000 0034 result <<= 8;
	MOV  R17,R16
	CLR  R16
; 0000 0035 result += I2C_ReadByte(1);
	LDI  R26,LOW(1)
	RCALL _I2C_ReadByte
	LDI  R31,0
	__ADDWRR 16,17,30,31
; 0000 0036 I2C_Stop();
	RCALL _I2C_Stop
; 0000 0037 return result/256;
	MOVW R26,R16
	LDI  R30,LOW(256)
	LDI  R31,HIGH(256)
	CALL __DIVW21
	RJMP _0x2080001
; 0000 0038 }
; .FEND
;// Настройка датчика температуры на одиночное
;// измерение и 9-и битный результат
;void setDs1631(unsigned char address)
; 0000 003C {
_setDs1631:
; .FSTART _setDs1631
; 0000 003D I2C_Start();
	CALL SUBOPT_0x2
;	address -> Y+0
; 0000 003E I2C_SendByte(  0b10010000 |(address<<1) | W);  //
; 0000 003F I2C_SendByte(ACCESS_CONFIG);
	LDI  R26,LOW(172)
	RCALL _I2C_SendByte
; 0000 0040 I2C_SendByte(_BV(SHOT));
	LDI  R26,LOW(1)
_0x2080005:
	RCALL _I2C_SendByte
; 0000 0041 I2C_Stop();
	RCALL _I2C_Stop
; 0000 0042 }
	ADIW R28,1
	RET
; .FEND
;
;void pulse(void)
; 0000 0045 {
; 0000 0046     LOW(SCL);
; 0000 0047     delay_us(PULSE);
; 0000 0048     HIGH(SCL);
; 0000 0049     delay_us(PULSE);
; 0000 004A     LOW(SCL);
; 0000 004B }
;
;
;
;void main(void)
; 0000 0050 {
_main:
; .FSTART _main
; 0000 0051     LCD_init();
	RCALL _LCD_init
; 0000 0052     LCD_string("temp(0) = ");
	__POINTW2MN _0x16,0
	RCALL _LCD_string
; 0000 0053     LCD_pos(0,1);
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(1)
	RCALL _LCD_pos
; 0000 0054     LCD_string("temp(7) = ");
	__POINTW2MN _0x16,11
	RCALL _LCD_string
; 0000 0055     while(1)
_0x17:
; 0000 0056     {
; 0000 0057         setDs1631(0);
	LDI  R26,LOW(0)
	RCALL _setDs1631
; 0000 0058         startConvert(0);
	LDI  R26,LOW(0)
	RCALL _startConvert
; 0000 0059         LCD_pos(10,0);
	LDI  R30,LOW(10)
	ST   -Y,R30
	LDI  R26,LOW(0)
	RCALL _LCD_pos
; 0000 005A         LCD_uint(readTemperature(0));
	LDI  R26,LOW(0)
	RCALL _readTemperature
	MOVW R26,R30
	RCALL _LCD_uint
; 0000 005B         setDs1631(7);
	LDI  R26,LOW(7)
	RCALL _setDs1631
; 0000 005C         startConvert(7);
	LDI  R26,LOW(7)
	RCALL _startConvert
; 0000 005D         LCD_pos(10,1);
	LDI  R30,LOW(10)
	ST   -Y,R30
	LDI  R26,LOW(1)
	RCALL _LCD_pos
; 0000 005E         LCD_uint(readTemperature(7));
	LDI  R26,LOW(7)
	RCALL _readTemperature
	MOVW R26,R30
	RCALL _LCD_uint
; 0000 005F         delay_ms(200);
	LDI  R26,LOW(200)
	LDI  R27,0
	CALL _delay_ms
; 0000 0060     }
	RJMP _0x17
; 0000 0061 }
_0x1A:
	RJMP _0x1A
; .FEND

	.DSEG
_0x16:
	.BYTE 0x16
;
;void I2C_Start(void){
; 0000 0063 void I2C_Start(void){

	.CSEG
_I2C_Start:
; .FSTART _I2C_Start
; 0000 0064      HIGH(SDA);
	LDS  R30,100
	ANDI R30,0xFD
	STS  100,R30
; 0000 0065      HIGH(SCL);
	CALL SUBOPT_0x3
; 0000 0066      delay_us(PULSE);
; 0000 0067      LOW(SDA);
	ORI  R30,2
	RJMP _0x2080003
; 0000 0068      delay_us(PULSE);
; 0000 0069 }
; .FEND
;
;void I2C_SendByte(unsigned char data)
; 0000 006C {           //время на передачу 1 бита 3*PULSE  1 байт 24*PULSE
_I2C_SendByte:
; .FSTART _I2C_SendByte
; 0000 006D     unsigned char i;
; 0000 006E     LOW(SCL);
	ST   -Y,R26
	ST   -Y,R17
;	data -> Y+1
;	i -> R17
	CALL SUBOPT_0x4
; 0000 006F     delay_us(PULSE);
; 0000 0070     for(i=(1<<7);i>0;i=(i>>1))
	LDI  R17,LOW(128)
_0x1C:
	CPI  R17,1
	BRLO _0x1D
; 0000 0071     {
; 0000 0072         if(data & i){HIGH(SDA);}else{LOW(SDA);}
	MOV  R30,R17
	LDD  R26,Y+1
	AND  R30,R26
	BREQ _0x1E
	LDS  R30,100
	ANDI R30,0xFD
	RJMP _0x26
_0x1E:
	LDS  R30,100
	ORI  R30,2
_0x26:
	STS  100,R30
; 0000 0073         delay_us(PULSE);
	CALL SUBOPT_0x5
; 0000 0074         HIGH(SCL);
; 0000 0075         delay_us(PULSE);
; 0000 0076         LOW(SCL);
	CALL SUBOPT_0x6
; 0000 0077         delay_us(PULSE);
; 0000 0078     }
	LSR  R17
	RJMP _0x1C
_0x1D:
; 0000 0079         LOW(SDA); //чтобы при подтверждении не произошла отправка стоп-состояния
	LDS  R30,100
	ORI  R30,2
	STS  100,R30
; 0000 007A         delay_us(PULSE);  //ждем пока ACK бит ведомого станет 1
	CALL SUBOPT_0x5
; 0000 007B         //подтверждаем ACK бит
; 0000 007C         HIGH(SCL);
; 0000 007D         delay_us(PULSE);
; 0000 007E         LOW(SCL);
	CALL SUBOPT_0x6
; 0000 007F         delay_us(PULSE);
; 0000 0080 }
	LDD  R17,Y+0
_0x2080004:
	ADIW R28,2
	RET
; .FEND
;
;void I2C_Stop(void) { HIGH(SCL); delay_us(PULSE); HIGH(SDA); delay_us(PULSE); }
; 0000 0082 void I2C_Stop(void) { ((*(unsigned char *) 0x64) &= (~(1 << (0)))); delay_us(50 ); ((*(unsigned char *) 0x64) &= (~(1 << (1)))); delay_us(50 ); }
_I2C_Stop:
; .FSTART _I2C_Stop
	CALL SUBOPT_0x3
	ANDI R30,0xFD
_0x2080003:
	STS  100,R30
	__DELAY_USB 184
	RET
; .FEND
;
;//unsigned char I2C_ReadByte(unsigned char ack)
;//{
;//    unsigned char i,readbyte =  0;
;//    for(i=(1<<7) ; i > 0 ; i = (i >>1))
;//    {
;//          HIGH(SCL);
;//        delay_us(PULSE);
;//        if(BIT_IS_SET(PING,SDA))
;//        readbyte |= i;
;//        LOW(SCL);
;//        delay_us(PULSE);
;//    }
;//}
;
;unsigned char I2C_ReadByte(unsigned char ack)
; 0000 0093 {
_I2C_ReadByte:
; .FSTART _I2C_ReadByte
; 0000 0094    unsigned char i,readbyte =  0;
; 0000 0095    HIGH(SDA);
	ST   -Y,R26
	ST   -Y,R17
	ST   -Y,R16
;	ack -> Y+2
;	i -> R17
;	readbyte -> R16
	LDI  R16,0
	LDS  R30,100
	ANDI R30,0xFD
	STS  100,R30
; 0000 0096    for(i=(1<<7) ; i > 0 ; i = (i >>1))
	LDI  R17,LOW(128)
_0x21:
	CPI  R17,1
	BRLO _0x22
; 0000 0097    {
; 0000 0098         HIGH(SCL);
	LDS  R30,100
	ANDI R30,0xFE
	STS  100,R30
; 0000 0099         delay_us(PULSE);
	__DELAY_USB 184
; 0000 009A         if(BIT_IS_SET(PING,SDA))
	LDS  R30,99
	ANDI R30,LOW(0x2)
	BREQ _0x23
; 0000 009B         readbyte |= i;
	OR   R16,R17
; 0000 009C         LOW(SCL);
_0x23:
	CALL SUBOPT_0x4
; 0000 009D         delay_us(PULSE);
; 0000 009E    }
	LSR  R17
	RJMP _0x21
_0x22:
; 0000 009F    if(ack){HIGH(SDA);}else{LOW(SDA);}  //ACK
	LDD  R30,Y+2
	CPI  R30,0
	BREQ _0x24
	LDS  R30,100
	ANDI R30,0xFD
	RJMP _0x27
_0x24:
	LDS  R30,100
	ORI  R30,2
_0x27:
	STS  100,R30
; 0000 00A0    delay_us(PULSE);
	CALL SUBOPT_0x5
; 0000 00A1    HIGH(SCL);
; 0000 00A2    delay_us(PULSE);
; 0000 00A3    LOW(SCL);
	CALL SUBOPT_0x6
; 0000 00A4    delay_us(PULSE);
; 0000 00A5    //для окончания приема
; 0000 00A6    LOW(SDA);
	LDS  R30,100
	ORI  R30,2
	STS  100,R30
; 0000 00A7    delay_us(PULSE);
	__DELAY_USB 184
; 0000 00A8    return readbyte;
	MOV  R30,R16
_0x2080001:
	LDD  R17,Y+1
	LDD  R16,Y+0
_0x2080002:
	ADIW R28,3
	RET
; 0000 00A9 }
; .FEND

	.CSEG

	.DSEG

	.CSEG

	.CSEG

	.CSEG

	.CSEG

	.DSEG
__seed_G100:
	.BYTE 0x4

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:18 WORDS
SUBOPT_0x0:
	ST   -Y,R30
	LDI  R26,LOW(1)
	LDI  R27,0
	JMP  _LCD_message

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1:
	ST   -Y,R30
	LDI  R26,LOW(0)
	LDI  R27,0
	JMP  _LCD_message

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x2:
	ST   -Y,R26
	CALL _I2C_Start
	LD   R30,Y
	LSL  R30
	ORI  R30,LOW(0x90)
	MOV  R26,R30
	JMP  _I2C_SendByte

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:29 WORDS
SUBOPT_0x3:
	LDS  R30,100
	ANDI R30,0xFE
	STS  100,R30
	__DELAY_USB 184
	LDS  R30,100
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x4:
	LDS  R30,100
	ORI  R30,1
	STS  100,R30
	__DELAY_USB 184
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x5:
	__DELAY_USB 184
	RJMP SUBOPT_0x3

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x6:
	ORI  R30,1
	STS  100,R30
	__DELAY_USB 184
	RET


	.CSEG
_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0xACB
	wdr
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
	RET

__DIVW21U:
	CLR  R0
	CLR  R1
	LDI  R25,16
__DIVW21U1:
	LSL  R26
	ROL  R27
	ROL  R0
	ROL  R1
	SUB  R0,R30
	SBC  R1,R31
	BRCC __DIVW21U2
	ADD  R0,R30
	ADC  R1,R31
	RJMP __DIVW21U3
__DIVW21U2:
	SBR  R26,1
__DIVW21U3:
	DEC  R25
	BRNE __DIVW21U1
	MOVW R30,R26
	MOVW R26,R0
	RET

__DIVW21:
	RCALL __CHKSIGNW
	RCALL __DIVW21U
	BRTC __DIVW211
	RCALL __ANEGW1
__DIVW211:
	RET

__MODW21U:
	RCALL __DIVW21U
	MOVW R30,R26
	RET

__CHKSIGNW:
	CLT
	SBRS R31,7
	RJMP __CHKSW1
	RCALL __ANEGW1
	SET
__CHKSW1:
	SBRS R27,7
	RJMP __CHKSW2
	COM  R26
	COM  R27
	ADIW R26,1
	BLD  R0,0
	INC  R0
	BST  R0,0
__CHKSW2:
	RET

__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

__INITLOCB:
__INITLOCW:
	ADD  R26,R28
	ADC  R27,R29
__INITLOC0:
	LPM  R0,Z+
	ST   X+,R0
	DEC  R24
	BRNE __INITLOC0
	RET

;END OF CODE MARKER
__END_OF_CODE:

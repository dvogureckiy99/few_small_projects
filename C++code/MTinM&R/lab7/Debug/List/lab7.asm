
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

_0x3:
	.DB  0x3F,0x6,0x5B,0x4F,0x66,0x6D,0x7D,0x7
	.DB  0x7F,0x6F,0x40
_0x2000060:
	.DB  0x1
_0x2000000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0,0x49,0x4E,0x46
	.DB  0x0

__GLOBAL_INI_TBL:
	.DW  0x0B
	.DW  _segments
	.DW  _0x3*2

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
; * Created: 17.10.2019 11:46:22
; * Author: Student
; * lab7
; * Variant 8
; *
; */
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
;#define SIGN 10
;#define VOID 11
;
;// Массив кодов цифр
;const unsigned char segments[] = {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D,0x7D, 0x07, 0x7F, 0x6F, 0x40, 0x00};

	.DSEG
;unsigned char Digit (unsigned int val, unsigned char m)
; 0000 0008 {

	.CSEG
_Digit:
; .FSTART _Digit
;    //[]-----------------------------------------------------[]
;    //| Назначение: выделение цифр из разрядов пятиразрядного |
;    //| десятичного положительного числа  |
;    //| Входные параметры: |
;    //| d - целое десятичное положительное число |
;    //| m - номер разряда (от 1 до 5, слева направо) |
;    //| Функция возвращает значение цифры в разряде m числа d |
;    //[]-----------------------------------------------------[]
;    unsigned char i = 5, a ;
;    unsigned int d = val ;
;    while(i)
	ST   -Y,R26
	CALL __SAVELOCR4
;	val -> Y+5
;	m -> Y+4
;	i -> R17
;	a -> R16
;	d -> R18,R19
	LDI  R17,5
	__GETWRS 18,19,5
_0x4:
	CPI  R17,0
	BREQ _0x6
;    { // цикл по разрядам числа
;        a = d%10; // выделяем очередной разряд
	MOVW R26,R18
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __MODW21U
	MOV  R16,R30
;        if(i-- == m) break; // выделен заданный разряд - уходим
	PUSH R17
	SUBI R17,1
	LDD  R30,Y+4
	POP  R26
	CP   R30,R26
	BREQ _0x6
;        d /= 10; // уменьшаем число в 10 раз
	MOVW R26,R18
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __DIVW21U
	MOVW R18,R30
;    }
	RJMP _0x4
_0x6:
;    return(a);
	MOV  R30,R16
	CALL __LOADLOCR4
	ADIW R28,7
	RET
;}
; .FEND
;
;void indic_int (int val)
;{
;    unsigned char i = 1;
;    int flag_first_digit = 0;
;    int var = val;
;    if(val<0)
;	val -> Y+6
;	i -> R17
;	flag_first_digit -> R18,R19
;	var -> R20,R21
;    {
;        var = abs(val); ///перевод в прямой код отрицательного числа
;    }
;    do
;    {
;       unsigned int digit;
;       digit=Digit(var,i);
;	val -> Y+8
;	digit -> Y+0
;
;       if(digit==0)
;       {
;            if(flag_first_digit==0)
;            {
;                PORTC = segments[VOID];
;                if(i==5)
;                {
;                    PORTC = segments[0];
;                }
;            }else
;            {
;                PORTC = segments[0];
;            }
;       }else
;       {     if(val<0)
;             {
;                 if(flag_first_digit==0)
;                 {
;                     PORTC = segments[SIGN];
;                     BitSet(PORTA,i-1) ;
;                     delay_us(1)     ;
;                     BitClr(PORTA,i-1) ;
;                 }
;             }
;             flag_first_digit = 1;
;             PORTC = segments[digit];
;
;       }
;       BitSet(PORTA,i) ;
;       delay_us(1)     ;
;       BitClr(PORTA,i) ;
;       i++;
;    }
;    while (i<=5);
;}
;
;
;void indic_uint (unsigned int val)
;{
_indic_uint:
; .FSTART _indic_uint
;    unsigned char i = 1;
;    int flag_first_digit = 0;
;    int var = val;
;    do
	ST   -Y,R27
	ST   -Y,R26
	CALL __SAVELOCR6
;	val -> Y+6
;	i -> R17
;	flag_first_digit -> R18,R19
;	var -> R20,R21
	LDI  R17,1
	__GETWRN 18,19,0
	__GETWRS 20,21,6
_0x14:
;    {
;       unsigned int digit;
;       digit=Digit(var,i);
	SBIW R28,2
;	val -> Y+8
;	digit -> Y+0
	ST   -Y,R21
	ST   -Y,R20
	MOV  R26,R17
	RCALL _Digit
	LDI  R31,0
	ST   Y,R30
	STD  Y+1,R31
;
;       if(digit==0)
	SBIW R30,0
	BRNE _0x16
;       {
;            if(flag_first_digit==0)
	MOV  R0,R18
	OR   R0,R19
	BRNE _0x17
;            {
;                PORTC = segments[VOID];
	__GETB1MN _segments,11
	OUT  0x15,R30
;                if(i==5)
	CPI  R17,5
	BRNE _0x18
;                {
;                    PORTC = segments[0];
	LDS  R30,_segments
	OUT  0x15,R30
;                }
;            }else
_0x18:
	RJMP _0x19
_0x17:
;            {
;                PORTC = segments[0];
	LDS  R30,_segments
	OUT  0x15,R30
;            }
_0x19:
;       }else
	RJMP _0x1A
_0x16:
;       {
;             flag_first_digit = 1;
	__GETWRN 18,19,1
;             PORTC = segments[digit];
	LD   R30,Y
	LDD  R31,Y+1
	SUBI R30,LOW(-_segments)
	SBCI R31,HIGH(-_segments)
	LD   R30,Z
	OUT  0x15,R30
;       }
_0x1A:
;       BitSet(PORTA,i) ;
	IN   R1,27
	MOV  R30,R17
	LDI  R26,LOW(1)
	CALL __LSLB12
	OR   R30,R1
	OUT  0x1B,R30
;       delay_us(1)     ;
	__DELAY_USB 4
;       BitClr(PORTA,i) ;
	IN   R1,27
	MOV  R30,R17
	LDI  R26,LOW(1)
	CALL __LSLB12
	COM  R30
	AND  R30,R1
	OUT  0x1B,R30
;       i++;
	SUBI R17,-1
;    }
	ADIW R28,2
;    while (i<=5);
	CPI  R17,6
	BRLO _0x14
;}
	CALL __LOADLOCR6
	RJMP _0x2080002
; .FEND
;
;void indic_5bit(char byte)
;{
;    char i = (1<<4), j = 1;
;    int flag_first_digit = 0;
;    do
;	byte -> Y+4
;	i -> R17
;	j -> R16
;	flag_first_digit -> R18,R19
;    {
;       unsigned char digit;
;       if(byte & i)
;	byte -> Y+5
;	digit -> Y+0
;       digit=1;
;       else
;       digit=0;
;
;       if(digit==0)
;       {
;            if(flag_first_digit==0)
;            {
;                PORTC = segments[VOID];
;                if(i==5)
;                {
;                    PORTC = segments[0];
;                }
;            }else
;            {
;                PORTC = segments[0];
;            }
;       }else
;       {
;             flag_first_digit = 1;
;             PORTC = segments[digit];
;       }
;       BitSet(PORTA,j) ;
;       delay_us(1)     ;
;       BitClr(PORTA,j) ;
;       i=(i>>1);
;       j++;
;    }
;    while (i>0);
;}
;//void indic_float (float val)
;//{
;//    unsigned char i = 1;
;//    int flag_first_digit = 0;
;//    flo var = val;
;//    if(val<0)
;//    {
;//        var = abs(val); ///перевод в прямой код отрицательного числа
;//    }
;//    do
;//    {
;//       unsigned int digit;
;//       digit=Digit(var,i);
;//
;//       if(digit==0)
;//       {
;//            if(flag_first_digit==0)
;//            {
;//                PORTC = segments[VOID];
;//                if(i==5)
;//                {
;//                    PORTC = segments[0];
;//                }
;//            }else
;//            {
;//                PORTC = segments[0];
;//            }
;//       }else
;//       {     if(val<0)
;//             {
;//                 if(flag_first_digit==0)
;//                 {
;//                     PORTC = segments[SIGN];
;//                     BitSet(PORTA,i-1) ;
;//                     delay_us(1)     ;
;//                     BitClr(PORTA,i-1) ;
;//                 }
;//             }
;//             flag_first_digit = 1;
;//             PORTC = segments[digit];
;//
;//       }
;//       BitSet(PORTA,i) ;
;//       delay_us(1)     ;
;//       BitClr(PORTA,i) ;
;//       i++;
;//    }
;//    while (i<=5);
;//
;//}
;
;void init_segments()
;{
_init_segments:
; .FSTART _init_segments
;    PORTA &=  ~(_BV(1) | _BV(2) | _BV(3) | _BV(4) | _BV(5) )  ;
	IN   R30,0x1B
	ANDI R30,LOW(0xC1)
	OUT  0x1B,R30
;    PORTC = 0 ;
	LDI  R30,LOW(0)
	OUT  0x15,R30
;    DDRA = _BV(DDA1) | _BV(DDA2) | _BV(DDA3) | _BV(DDA4) | _BV(DDA5)  ;
	LDI  R30,LOW(62)
	OUT  0x1A,R30
;    DDRC = _BV(DDC0) | _BV(DDC1) | _BV(DDC2) | _BV(DDC3) | _BV(DDC4) | _BV(DDC5) | _BV(DDC6) | _BV(DDC7);
	LDI  R30,LOW(255)
	OUT  0x14,R30
;}
	RET
; .FEND
;
;
;void SPI_init()
; 0000 000B {
_SPI_init:
; .FSTART _SPI_init
; 0000 000C      DDRG = _BV(MOSI) | _BV(SCLK) ;
	LDI  R30,LOW(9)
	STS  100,R30
; 0000 000D      BitSet(PORTG, SCLK) ;
	CALL SUBOPT_0x0
; 0000 000E }
	RET
; .FEND
;
;#define pulse 10
;
;void SPI_Write(char byte)
; 0000 0013 {
_SPI_Write:
; .FSTART _SPI_Write
; 0000 0014     unsigned char i ;
; 0000 0015     for(i = (1 << 7) ; i > 0 ; i = (i>>1))
	ST   -Y,R26
	ST   -Y,R17
;	byte -> Y+1
;	i -> R17
	LDI  R17,LOW(128)
_0x26:
	CPI  R17,1
	BRLO _0x27
; 0000 0016     {
; 0000 0017         if(byte & i )
	MOV  R30,R17
	LDD  R26,Y+1
	AND  R30,R26
	BREQ _0x28
; 0000 0018             BitSet(PORTG, MOSI);
	LDS  R30,101
	ORI  R30,8
	RJMP _0x3E
; 0000 0019         else
_0x28:
; 0000 001A             BitClr(PORTG, MOSI);
	LDS  R30,101
	ANDI R30,0XF7
_0x3E:
	STS  101,R30
; 0000 001B         BitSet(PORTG, SCLK) ;
	CALL SUBOPT_0x0
; 0000 001C         delay_us(pulse);
	__DELAY_USB 37
; 0000 001D         BitClr(PORTG, SCLK) ;
	CALL SUBOPT_0x1
; 0000 001E         delay_us(pulse);
; 0000 001F     }
	LSR  R17
	RJMP _0x26
_0x27:
; 0000 0020 }
	LDD  R17,Y+0
	ADIW R28,2
	RET
; .FEND
;
;unsigned int SPI_Read()
; 0000 0023 {
_SPI_Read:
; .FSTART _SPI_Read
; 0000 0024     unsigned char i, byte = 0 ;
; 0000 0025     for(i = (1 << 7) ; i > 0 ; i = (i>>1))
	ST   -Y,R17
	ST   -Y,R16
;	i -> R17
;	byte -> R16
	LDI  R16,0
	LDI  R17,LOW(128)
_0x2B:
	CPI  R17,1
	BRLO _0x2C
; 0000 0026     {
; 0000 0027         BitClr(PORTG, SCLK) ;
	CALL SUBOPT_0x1
; 0000 0028         delay_us(pulse);
; 0000 0029         BitSet(PORTG, SCLK) ;
	CALL SUBOPT_0x0
; 0000 002A         delay_us(pulse);
	__DELAY_USB 37
; 0000 002B         if( BIT_IS_SET(PING,MISO))
	LDS  R30,99
	ANDI R30,LOW(0x2)
	BREQ _0x2D
; 0000 002C         byte |= i ;
	OR   R16,R17
; 0000 002D     }
_0x2D:
	LSR  R17
	RJMP _0x2B
_0x2C:
; 0000 002E     return byte ;
	MOV  R30,R16
	LDI  R31,0
	LD   R16,Y+
	LD   R17,Y+
	RET
; 0000 002F }
; .FEND
;
;unsigned long readAD7798()
; 0000 0032 {
_readAD7798:
; .FSTART _readAD7798
; 0000 0033     unsigned char byte1, byte2, byte3;
; 0000 0034     unsigned long result;
; 0000 0035     while(BIT_IS_SET(PING, MISO));
	SBIW R28,4
	CALL __SAVELOCR4
;	byte1 -> R17
;	byte2 -> R16
;	byte3 -> R19
;	result -> Y+4
_0x2E:
	LDS  R30,99
	ANDI R30,LOW(0x2)
	BRNE _0x2E
; 0000 0036     byte1 = SPI_Read();
	RCALL _SPI_Read
	MOV  R17,R30
; 0000 0037     byte2 = SPI_Read();
	RCALL _SPI_Read
	MOV  R16,R30
; 0000 0038     byte3 = SPI_Read();
	RCALL _SPI_Read
	MOV  R19,R30
; 0000 0039     result = ((unsigned long)byte1 << 15) + ((unsigned long)byte2 << 7) +
; 0000 003A     (unsigned long)byte3;
	MOV  R30,R17
	LDI  R31,0
	CALL __CWD1
	MOVW R26,R30
	MOVW R24,R22
	LDI  R30,LOW(15)
	CALL __LSLD12
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	MOV  R30,R16
	LDI  R31,0
	CALL __CWD1
	MOVW R26,R30
	MOVW R24,R22
	LDI  R30,LOW(7)
	CALL __LSLD12
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __ADDD21
	MOV  R30,R19
	LDI  R31,0
	CALL __CWD1
	CALL __ADDD12
	__PUTD1S 4
; 0000 003B     return result;
	CALL __LOADLOCR4
_0x2080002:
	ADIW R28,8
	RET
; 0000 003C }
; .FEND
;
;void setAd7798()
; 0000 003F {
_setAd7798:
; .FSTART _setAd7798
; 0000 0040     SPI_Write(CONFIG_REG);
	CALL SUBOPT_0x2
; 0000 0041     delay_us(90);
; 0000 0042     SPI_Write(_BV(G1) | _BV(G2) | _BV(UB));
	LDI  R26,LOW(22)
	RCALL _SPI_Write
; 0000 0043     SPI_Write(_BV(BUF));
	CALL SUBOPT_0x2
; 0000 0044     delay_us(90);
; 0000 0045     SPI_Write(MODE_REG);
	CALL SUBOPT_0x3
; 0000 0046     delay_us(90);
; 0000 0047     SPI_Write(_BV(MD2));
	LDI  R26,LOW(128)
	CALL SUBOPT_0x4
; 0000 0048     SPI_Write(_BV(FS0) | _BV(FS1) | _BV(FS2) | _BV(FS3));
; 0000 0049 
; 0000 004A     delay_us(90);
; 0000 004B     SPI_Write(MODE_REG);
	CALL SUBOPT_0x3
; 0000 004C     delay_us(90);
; 0000 004D     SPI_Write(0x00);
	LDI  R26,LOW(0)
	CALL SUBOPT_0x4
; 0000 004E     SPI_Write(_BV(FS0) | _BV(FS1) | _BV(FS2) | _BV(FS3));
; 0000 004F     delay_us(90);
; 0000 0050     SPI_Write(_BV(RW) | _BV(RS1) | _BV(RS0) | _BV(CREAD));
	LDI  R26,LOW(92)
	RCALL _SPI_Write
; 0000 0051 }
	RET
; .FEND
;
;void resetAD7798()
; 0000 0054 {
_resetAD7798:
; .FSTART _resetAD7798
; 0000 0055     unsigned char i;
; 0000 0056 
; 0000 0057     for(i = 0; i < 4; ++i)
	ST   -Y,R17
;	i -> R17
	LDI  R17,LOW(0)
_0x32:
	CPI  R17,4
	BRSH _0x33
; 0000 0058     {
; 0000 0059         SPI_Write(0xFF);
	LDI  R26,LOW(255)
	RCALL _SPI_Write
; 0000 005A     }
	SUBI R17,-LOW(1)
	RJMP _0x32
_0x33:
; 0000 005B }
	LD   R17,Y+
	RET
; .FEND
;
;#define TIMER_FREQ (_BV(CS02) | _BV(CS01))
;void initTimer()
; 0000 005F {
_initTimer:
; .FSTART _initTimer
; 0000 0060     TCCR0 = _BV(WGM01) | _BV(WGM00) | _BV(COM01);
	LDI  R30,LOW(104)
	OUT  0x33,R30
; 0000 0061     DDRB |= _BV(4);
	SBI  0x17,4
; 0000 0062     OCR0 = 128;
	LDI  R30,LOW(128)
	OUT  0x31,R30
; 0000 0063 }
	RET
; .FEND
;void startAlarm()
; 0000 0065 {
_startAlarm:
; .FSTART _startAlarm
; 0000 0066     TCCR0 |= TIMER_FREQ;
	IN   R30,0x33
	ORI  R30,LOW(0x6)
	RJMP _0x2080001
; 0000 0067 }
; .FEND
;void stopAlarm()
; 0000 0069 {
_stopAlarm:
; .FSTART _stopAlarm
; 0000 006A     TCCR0 &= ~TIMER_FREQ;
	IN   R30,0x33
	ANDI R30,LOW(0xF9)
_0x2080001:
	OUT  0x33,R30
; 0000 006B }
	RET
; .FEND
;
;
; unsigned char razr(unsigned long var)
; 0000 006F {
_razr:
; .FSTART _razr
; 0000 0070     unsigned char razr =0 ;
; 0000 0071     while(var)
	CALL __PUTPARD2
	ST   -Y,R17
;	var -> Y+1
;	razr -> R17
	LDI  R17,0
_0x34:
	__GETD1S 1
	CALL __CPD10
	BREQ _0x36
; 0000 0072     { // цикл по разрядам числа
; 0000 0073         var /= 2; // уменьшаем число в 2 раз
	CALL __LSRD1
	__PUTD1S 1
; 0000 0074         razr++;
	SUBI R17,-1
; 0000 0075     }
	RJMP _0x34
_0x36:
; 0000 0076     return(razr);
	MOV  R30,R17
	LDD  R17,Y+0
	ADIW R28,5
	RET
; 0000 0077 }
; .FEND
;
;void main(void)
; 0000 007A {
_main:
; .FSTART _main
; 0000 007B     unsigned long data;
; 0000 007C     init_segments();
	SBIW R28,4
;	data -> Y+0
	RCALL _init_segments
; 0000 007D     initTimer();
	RCALL _initTimer
; 0000 007E     SPI_init();
	RCALL _SPI_init
; 0000 007F     resetAD7798();
	RCALL _resetAD7798
; 0000 0080     setAd7798();
	RCALL _setAd7798
; 0000 0081     while(1)
_0x37:
; 0000 0082     {
; 0000 0083        data = (char)(readAD7798()>>16);
	RCALL _readAD7798
	CALL __LSRD16
	CLR  R31
	CLR  R22
	CLR  R23
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTD1S0
; 0000 0084        //indic_5bit(data);
; 0000 0085        indic_uint(razr(readAD7798()));
	RCALL _readAD7798
	MOVW R26,R30
	MOVW R24,R22
	RCALL _razr
	LDI  R31,0
	MOVW R26,R30
	RCALL _indic_uint
; 0000 0086        if(data>16) {startAlarm();}else{stopAlarm();}
	CALL __GETD2S0
	__CPD2N 0x11
	BRLO _0x3A
	RCALL _startAlarm
	RJMP _0x3B
_0x3A:
	RCALL _stopAlarm
_0x3B:
; 0000 0087        delay_ms(200);
	LDI  R26,LOW(200)
	LDI  R27,0
	CALL _delay_ms
; 0000 0088 
; 0000 0089     }
	RJMP _0x37
; 0000 008A }
_0x3C:
	RJMP _0x3C
; .FEND
;

	.CSEG

	.DSEG

	.CSEG

	.CSEG

	.CSEG

	.CSEG

	.DSEG
_segments:
	.BYTE 0xC
__seed_G100:
	.BYTE 0x4

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x0:
	LDS  R30,101
	ORI  R30,1
	STS  101,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1:
	LDS  R30,101
	ANDI R30,0xFE
	STS  101,R30
	__DELAY_USB 37
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x2:
	LDI  R26,LOW(16)
	CALL _SPI_Write
	__DELAY_USW 249
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x3:
	LDI  R26,LOW(8)
	CALL _SPI_Write
	__DELAY_USW 249
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x4:
	CALL _SPI_Write
	LDI  R26,LOW(15)
	CALL _SPI_Write
	__DELAY_USW 249
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

__ADDD12:
	ADD  R30,R26
	ADC  R31,R27
	ADC  R22,R24
	ADC  R23,R25
	RET

__ADDD21:
	ADD  R26,R30
	ADC  R27,R31
	ADC  R24,R22
	ADC  R25,R23
	RET

__LSLB12:
	TST  R30
	MOV  R0,R30
	MOV  R30,R26
	BREQ __LSLB12R
__LSLB12L:
	LSL  R30
	DEC  R0
	BRNE __LSLB12L
__LSLB12R:
	RET

__LSLD12:
	TST  R30
	MOV  R0,R30
	MOVW R30,R26
	MOVW R22,R24
	BREQ __LSLD12R
__LSLD12L:
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R23
	DEC  R0
	BRNE __LSLD12L
__LSLD12R:
	RET

__LSRD1:
	LSR  R23
	ROR  R22
	ROR  R31
	ROR  R30
	RET

__LSRD16:
	MOV  R30,R22
	MOV  R31,R23
	LDI  R22,0
	LDI  R23,0
	RET

__CWD1:
	MOV  R22,R31
	ADD  R22,R22
	SBC  R22,R22
	MOV  R23,R22
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

__MODW21U:
	RCALL __DIVW21U
	MOVW R30,R26
	RET

__GETD2S0:
	LD   R26,Y
	LDD  R27,Y+1
	LDD  R24,Y+2
	LDD  R25,Y+3
	RET

__PUTD1S0:
	ST   Y,R30
	STD  Y+1,R31
	STD  Y+2,R22
	STD  Y+3,R23
	RET

__PUTPARD2:
	ST   -Y,R25
	ST   -Y,R24
	ST   -Y,R27
	ST   -Y,R26
	RET

__CPD10:
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	RET

__SAVELOCR6:
	ST   -Y,R21
__SAVELOCR5:
	ST   -Y,R20
__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR6:
	LDD  R21,Y+5
__LOADLOCR5:
	LDD  R20,Y+4
__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

;END OF CODE MARKER
__END_OF_CODE:

#define BIT_IS_SET(Reg, b) ((Reg & _BV(b)) != 0)
#define BIT_IS_CLEAR(Reg, b) ((Reg & _BV(b)) == 0)
#define _BV(b) (1 << (b))
#define BitClr(var, bit) ((var) &= (~(1<<(bit))))
#define BitSet(var, bit) ((var) |= (1<<(bit)))

//3
#define MUX _BV(REFS0) //| _BV(ADLAR)) //левое выравнивание  и Используемое опорное напряжение AVCC
#define high(var)  (var>>8)
#define low(var)    var

//7
#define CREAD 2
#define RS0 3
#define RS1 4
#define RW 6
// Mode Register
#define FS0 0
#define FS1 1
#define FS2 2
#define FS3 3
#define MD2 7
// Configuration Register
#define BUF 4
// 2nd part
#define G1 1
#define G2 2
#define UB 4
// Registers
#define MODE_REG _BV(RS0)
#define CONFIG_REG _BV(RS1)
//PINS
#define MOSI 3
#define MISO 1
#define SCLK 0

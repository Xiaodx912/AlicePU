st:
add $3,$1,$2
addu $4,$1,$2
sub $3,$1,$2
subu $4,$1,$2

slt $3,$1,$2
sltu $4,$1,$2

lui $1,0x0000
ori $1,$1,0xffff
lui $2,0x00ff
ori $2,$2,0x00ff

and $3,$1,$2
or $3,$1,$2
xor $3,$1,$2
nor $3,$1,$2

lui $1,0xfe21
ori $1,$1,0x12ef
ori $2,$0,0

sll $2,$1,4
srl $2,$1,4
sra $2,$1,4

ori $3,$0,8

sllv $2,$1,$3
srlv $2,$1,$3
srav $2,$1,$3

ori $31,$0,0x6c
jr $31
j st
s2:
lui $1,0xbeaf


ori $1,$0,0x0001

addi $2,$1,0x0002
addiu $3,$1,0x0002

lui $1,0xff00
ori $1,$1,0xff00

andi $2,$1,0xf0f0
ori $2,$1,0xf0f0
xori $2,$1,0xf0f0

lui $1,0xdead
ori $1,$1,0xbeaf

sw $1,0x1000($0)
lw $2,0x1000($0)

lui $4,0x0000

beq $1,$2,j1
lui $1,0xffff
lui $4,0xdead
j1:
lui $2,0xffff
bne $1,$2,j2
lui $1,0xffff
lui $4,0xdead
j2:
lui $3,0x1234


ori $1,$0,0x0001

slti $2,$1,0xffff
sltiu $3,$1,0xffff

lui $1,0x0000

j j3
lui $1,0xdead
j3:
jal j4
lui $1,0xdead
j4:
ori $1,$1,0x1234

main:
ori $1,$0,0x0002
lui $2,0xffff
ori $2,$2,0xffff
j st


.data
.word 0xffffffff
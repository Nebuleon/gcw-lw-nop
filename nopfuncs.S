	.text
	.set	noreorder
	.set	noat

	.extern OpNop1

	# OpNop1 will be annotated. The rest follows the same pattern with more
	# NOP instructions.

	.ent	OpNop1
	.global	OpNop1
	.type	OpNop1,@function
OpNop1:  # (void* Memory, uint32_t Blocks, uint32_t BlockDistance)
	# Register assignment:
	#  $4 (parameter #1): Memory address to start with
	#  $5 (parameter #2): Block count to iterate over
	#  $6 (parameter #3): Size of each block in bytes
	#  $8 (in algorithm): Number of words left to iterate over
	#  $9 (in algorithm): Memory address to end at, exclusive ($4 + $5 * $6)
	# $10 (in algorithm): Total of all words accumulated so far
	# $11 (in algorithm): Memory word that was last read
	# $12 (in algorithm): Current memory address
	#  $1 (in algorithm): Temporary register

	move  $8,  $0       # Iterate 2^32 times
	mul   $1,  $5,  $6  # How many bytes is a block?
	move  $12, $4       # Start $12 at the start of the memory
	move  $10, $0       # For decoration/completeness
	addu  $9,  $4,  $1
1:
	lw    $11, 0($12)   # Starts loading the word from the start of the block
	nop                 # This is the most important part of the test.
	                    # It spaces out the load from the instruction that
	                    # uses it.
	addu  $10, $10, $11 # Data dependency

	addiu $8,  $8,  -1  # One less block to do
	beq   $8,  $0,  2f  # Do we have any left? (No -> 2)
	addu  $12, $12, $6  # Next block (delay slot)
	bne   $12, $9,  1b  # Are we at the end of the memory? (No -> 1)
	nop                 # Cannot delay usefully here
	j     1b            # Loop that shit
	move  $12, $4       # (End of memory) Go back to the start (delay)
2:
	jr    $ra
	nop

	.end	OpNop1

	.extern OpNop2

	.ent	OpNop2
	.global	OpNop2
	.type	OpNop2,@function
OpNop2:
	move  $8,  $0
	mul   $1,  $5,  $6
	move  $12, $4
	move  $10, $0
	addu  $9,  $4,  $1
1:
	lw    $11, 0($12)
	nop
	nop
	addu  $10, $10, $11
	addiu $8,  $8,  -1
	beq   $8,  $0,  2f
	addu  $12, $12, $6
	bne   $12, $9,  1b
	nop
	j     1b
	move  $12, $4
2:
	jr    $ra
	nop
	
	.end	OpNop2

	.extern OpNop3

	.ent	OpNop3
	.global	OpNop3
	.type	OpNop3,@function
OpNop3:
	move  $8,  $0
	mul   $1,  $5,  $6
	move  $12, $4
	move  $10, $0
	addu  $9,  $4,  $1
1:
	lw    $11, 0($12)
	nop
	nop
	nop
	addu  $10, $10, $11
	addiu $8,  $8,  -1
	beq   $8,  $0,  2f
	addu  $12, $12, $6
	bne   $12, $9,  1b
	nop
	j     1b
	move  $12, $4
2:
	jr    $ra
	nop
	
	.end	OpNop3

	.extern OpNop4

	.ent	OpNop4
	.global	OpNop4
	.type	OpNop4,@function
OpNop4:
	move  $8,  $0
	mul   $1,  $5,  $6
	move  $12, $4
	move  $10, $0
	addu  $9,  $4,  $1
1:
	lw    $11, 0($12)
	.rept 4
		nop
	.endr
	addu  $10, $10, $11
	addiu $8,  $8,  -1
	beq   $8,  $0,  2f
	addu  $12, $12, $6
	bne   $12, $9,  1b
	nop
	j     1b
	move  $12, $4
2:
	jr    $ra
	nop
	
	.end	OpNop4

	.extern OpNop5

	.ent	OpNop5
	.global	OpNop5
	.type	OpNop5,@function
OpNop5:
	move  $8,  $0
	mul   $1,  $5,  $6
	move  $12, $4
	move  $10, $0
	addu  $9,  $4,  $1
1:
	lw    $11, 0($12)
	.rept 5
		nop
	.endr
	addu  $10, $10, $11
	addiu $8,  $8,  -1
	beq   $8,  $0,  2f
	addu  $12, $12, $6
	bne   $12, $9,  1b
	nop
	j     1b
	move  $12, $4
2:
	jr    $ra
	nop
	
	.end	OpNop5

	.extern OpNop6

	.ent	OpNop6
	.global	OpNop6
	.type	OpNop6,@function
OpNop6:
	move  $8,  $0
	mul   $1,  $5,  $6
	move  $12, $4
	move  $10, $0
	addu  $9,  $4,  $1
1:
	lw    $11, 0($12)
	.rept 6
		nop
	.endr
	addu  $10, $10, $11
	addiu $8,  $8,  -1
	beq   $8,  $0,  2f
	addu  $12, $12, $6
	bne   $12, $9,  1b
	nop
	j     1b
	move  $12, $4
2:
	jr    $ra
	nop
	
	.end	OpNop6

	.extern OpNop7

	.ent	OpNop7
	.global	OpNop7
	.type	OpNop7,@function
OpNop7:
	move  $8,  $0
	mul   $1,  $5,  $6
	move  $12, $4
	move  $10, $0
	addu  $9,  $4,  $1
1:
	lw    $11, 0($12)
	.rept 7
		nop
	.endr
	addu  $10, $10, $11
	addiu $8,  $8,  -1
	beq   $8,  $0,  2f
	addu  $12, $12, $6
	bne   $12, $9,  1b
	nop
	j     1b
	move  $12, $4
2:
	jr    $ra
	nop
	
	.end	OpNop7

	.extern OpNop8

	.ent	OpNop8
	.global	OpNop8
	.type	OpNop8,@function
OpNop8:
	move  $8,  $0
	mul   $1,  $5,  $6
	move  $12, $4
	move  $10, $0
	addu  $9,  $4,  $1
1:
	lw    $11, 0($12)
	.rept 8
		nop
	.endr
	addu  $10, $10, $11
	addiu $8,  $8,  -1
	beq   $8,  $0,  2f
	addu  $12, $12, $6
	bne   $12, $9,  1b
	nop
	j     1b
	move  $12, $4
2:
	jr    $ra
	nop
	
	.end	OpNop8

	.extern OpNop9

	.ent	OpNop9
	.global	OpNop9
	.type	OpNop9,@function
OpNop9:
	move  $8,  $0
	mul   $1,  $5,  $6
	move  $12, $4
	move  $10, $0
	addu  $9,  $4,  $1
1:
	lw    $11, 0($12)
	.rept 9
		nop
	.endr
	addu  $10, $10, $11
	addiu $8,  $8,  -1
	beq   $8,  $0,  2f
	addu  $12, $12, $6
	bne   $12, $9,  1b
	nop
	j     1b
	move  $12, $4
2:
	jr    $ra
	nop
	
	.end	OpNop9

	.extern OpNop10

	.ent	OpNop10
	.global	OpNop10
	.type	OpNop10,@function
OpNop10:
	move  $8,  $0
	mul   $1,  $5,  $6
	move  $12, $4
	move  $10, $0
	addu  $9,  $4,  $1
1:
	lw    $11, 0($12)
	.rept 10
		nop
	.endr
	addu  $10, $10, $11
	addiu $8,  $8,  -1
	beq   $8,  $0,  2f
	addu  $12, $12, $6
	bne   $12, $9,  1b
	nop
	j     1b
	move  $12, $4
2:
	jr    $ra
	nop
	
	.end	OpNop10

	.extern OpNop11

	.ent	OpNop11
	.global	OpNop11
	.type	OpNop11,@function
OpNop11:
	move  $8,  $0
	mul   $1,  $5,  $6
	move  $12, $4
	move  $10, $0
	addu  $9,  $4,  $1
1:
	lw    $11, 0($12)
	.rept 11
		nop
	.endr
	addu  $10, $10, $11
	addiu $8,  $8,  -1
	beq   $8,  $0,  2f
	addu  $12, $12, $6
	bne   $12, $9,  1b
	nop
	j     1b
	move  $12, $4
2:
	jr    $ra
	nop
	
	.end	OpNop11

	.extern OpNop12

	.ent	OpNop12
	.global	OpNop12
	.type	OpNop12,@function
OpNop12:
	move  $8,  $0
	mul   $1,  $5,  $6
	move  $12, $4
	move  $10, $0
	addu  $9,  $4,  $1
1:
	lw    $11, 0($12)
	.rept 12
		nop
	.endr
	addu  $10, $10, $11
	addiu $8,  $8,  -1
	beq   $8,  $0,  2f
	addu  $12, $12, $6
	bne   $12, $9,  1b
	nop
	j     1b
	move  $12, $4
2:
	jr    $ra
	nop
	
	.end	OpNop12

	.extern OpNop13

	.ent	OpNop13
	.global	OpNop13
	.type	OpNop13,@function
OpNop13:
	move  $8,  $0
	mul   $1,  $5,  $6
	move  $12, $4
	move  $10, $0
	addu  $9,  $4,  $1
1:
	lw    $11, 0($12)
	.rept 13
		nop
	.endr
	addu  $10, $10, $11
	addiu $8,  $8,  -1
	beq   $8,  $0,  2f
	addu  $12, $12, $6
	bne   $12, $9,  1b
	nop
	j     1b
	move  $12, $4
2:
	jr    $ra
	nop
	
	.end	OpNop13

	.extern OpNop14

	.ent	OpNop14
	.global	OpNop14
	.type	OpNop14,@function
OpNop14:
	move  $8,  $0
	mul   $1,  $5,  $6
	move  $12, $4
	move  $10, $0
	addu  $9,  $4,  $1
1:
	lw    $11, 0($12)
	.rept 14
		nop
	.endr
	addu  $10, $10, $11
	addiu $8,  $8,  -1
	beq   $8,  $0,  2f
	addu  $12, $12, $6
	bne   $12, $9,  1b
	nop
	j     1b
	move  $12, $4
2:
	jr    $ra
	nop
	
	.end	OpNop14

	.extern OpNop15

	.ent	OpNop15
	.global	OpNop15
	.type	OpNop15,@function
OpNop15:
	move  $8,  $0
	mul   $1,  $5,  $6
	move  $12, $4
	move  $10, $0
	addu  $9,  $4,  $1
1:
	lw    $11, 0($12)
	.rept 15
		nop
	.endr
	addu  $10, $10, $11
	addiu $8,  $8,  -1
	beq   $8,  $0,  2f
	addu  $12, $12, $6
	bne   $12, $9,  1b
	nop
	j     1b
	move  $12, $4
2:
	jr    $ra
	nop
	
	.end	OpNop15

	.extern OpNop16

	.ent	OpNop16
	.global	OpNop16
	.type	OpNop16,@function
OpNop16:
	move  $8,  $0
	mul   $1,  $5,  $6
	move  $12, $4
	move  $10, $0
	addu  $9,  $4,  $1
1:
	lw    $11, 0($12)
	.rept 16
		nop
	.endr
	addu  $10, $10, $11
	addiu $8,  $8,  -1
	beq   $8,  $0,  2f
	addu  $12, $12, $6
	bne   $12, $9,  1b
	nop
	j     1b
	move  $12, $4
2:
	jr    $ra
	nop
	
	.end	OpNop16

	.extern OpNop17

	.ent	OpNop17
	.global	OpNop17
	.type	OpNop17,@function
OpNop17:
	move  $8,  $0
	mul   $1,  $5,  $6
	move  $12, $4
	move  $10, $0
	addu  $9,  $4,  $1
1:
	lw    $11, 0($12)
	.rept 17
		nop
	.endr
	addu  $10, $10, $11
	addiu $8,  $8,  -1
	beq   $8,  $0,  2f
	addu  $12, $12, $6
	bne   $12, $9,  1b
	nop
	j     1b
	move  $12, $4
2:
	jr    $ra
	nop
	
	.end	OpNop17

	.extern OpNop18

	.ent	OpNop18
	.global	OpNop18
	.type	OpNop18,@function
OpNop18:
	move  $8,  $0
	mul   $1,  $5,  $6
	move  $12, $4
	move  $10, $0
	addu  $9,  $4,  $1
1:
	lw    $11, 0($12)
	.rept 18
		nop
	.endr
	addu  $10, $10, $11
	addiu $8,  $8,  -1
	beq   $8,  $0,  2f
	addu  $12, $12, $6
	bne   $12, $9,  1b
	nop
	j     1b
	move  $12, $4
2:
	jr    $ra
	nop
	
	.end	OpNop18

	.extern OpNop19

	.ent	OpNop19
	.global	OpNop19
	.type	OpNop19,@function
OpNop19:
	move  $8,  $0
	mul   $1,  $5,  $6
	move  $12, $4
	move  $10, $0
	addu  $9,  $4,  $1
1:
	lw    $11, 0($12)
	.rept 19
		nop
	.endr
	addu  $10, $10, $11
	addiu $8,  $8,  -1
	beq   $8,  $0,  2f
	addu  $12, $12, $6
	bne   $12, $9,  1b
	nop
	j     1b
	move  $12, $4
2:
	jr    $ra
	nop
	
	.end	OpNop19

	.extern OpNop20

	.ent	OpNop20
	.global	OpNop20
	.type	OpNop20,@function
OpNop20:
	move  $8,  $0
	mul   $1,  $5,  $6
	move  $12, $4
	move  $10, $0
	addu  $9,  $4,  $1
1:
	lw    $11, 0($12)
	.rept 20
		nop
	.endr
	addu  $10, $10, $11
	addiu $8,  $8,  -1
	beq   $8,  $0,  2f
	addu  $12, $12, $6
	bne   $12, $9,  1b
	nop
	j     1b
	move  $12, $4
2:
	jr    $ra
	nop
	
	.end	OpNop20

	.extern OpNop21

	.ent	OpNop21
	.global	OpNop21
	.type	OpNop21,@function
OpNop21:
	move  $8,  $0
	mul   $1,  $5,  $6
	move  $12, $4
	move  $10, $0
	addu  $9,  $4,  $1
1:
	lw    $11, 0($12)
	.rept 21
		nop
	.endr
	addu  $10, $10, $11
	addiu $8,  $8,  -1
	beq   $8,  $0,  2f
	addu  $12, $12, $6
	bne   $12, $9,  1b
	nop
	j     1b
	move  $12, $4
2:
	jr    $ra
	nop
	
	.end	OpNop21

	.extern OpNop22

	.ent	OpNop22
	.global	OpNop22
	.type	OpNop22,@function
OpNop22:
	move  $8,  $0
	mul   $1,  $5,  $6
	move  $12, $4
	move  $10, $0
	addu  $9,  $4,  $1
1:
	lw    $11, 0($12)
	.rept 22
		nop
	.endr
	addu  $10, $10, $11
	addiu $8,  $8,  -1
	beq   $8,  $0,  2f
	addu  $12, $12, $6
	bne   $12, $9,  1b
	nop
	j     1b
	move  $12, $4
2:
	jr    $ra
	nop
	
	.end	OpNop22

	.extern OpNop23

	.ent	OpNop23
	.global	OpNop23
	.type	OpNop23,@function
OpNop23:
	move  $8,  $0
	mul   $1,  $5,  $6
	move  $12, $4
	move  $10, $0
	addu  $9,  $4,  $1
1:
	lw    $11, 0($12)
	.rept 23
		nop
	.endr
	addu  $10, $10, $11
	addiu $8,  $8,  -1
	beq   $8,  $0,  2f
	addu  $12, $12, $6
	bne   $12, $9,  1b
	nop
	j     1b
	move  $12, $4
2:
	jr    $ra
	nop
	
	.end	OpNop23

	.extern OpNop24

	.ent	OpNop24
	.global	OpNop24
	.type	OpNop24,@function
OpNop24:
	move  $8,  $0
	mul   $1,  $5,  $6
	move  $12, $4
	move  $10, $0
	addu  $9,  $4,  $1
1:
	lw    $11, 0($12)
	.rept 24
		nop
	.endr
	addu  $10, $10, $11
	addiu $8,  $8,  -1
	beq   $8,  $0,  2f
	addu  $12, $12, $6
	bne   $12, $9,  1b
	nop
	j     1b
	move  $12, $4
2:
	jr    $ra
	nop
	
	.end	OpNop24

	.extern OpNop25

	.ent	OpNop25
	.global	OpNop25
	.type	OpNop25,@function
OpNop25:
	move  $8,  $0
	mul   $1,  $5,  $6
	move  $12, $4
	move  $10, $0
	addu  $9,  $4,  $1
1:
	lw    $11, 0($12)
	.rept 25
		nop
	.endr
	addu  $10, $10, $11
	addiu $8,  $8,  -1
	beq   $8,  $0,  2f
	addu  $12, $12, $6
	bne   $12, $9,  1b
	nop
	j     1b
	move  $12, $4
2:
	jr    $ra
	nop
	
	.end	OpNop25

	.extern OpNop26

	.ent	OpNop26
	.global	OpNop26
	.type	OpNop26,@function
OpNop26:
	move  $8,  $0
	mul   $1,  $5,  $6
	move  $12, $4
	move  $10, $0
	addu  $9,  $4,  $1
1:
	lw    $11, 0($12)
	.rept 26
		nop
	.endr
	addu  $10, $10, $11
	addiu $8,  $8,  -1
	beq   $8,  $0,  2f
	addu  $12, $12, $6
	bne   $12, $9,  1b
	nop
	j     1b
	move  $12, $4
2:
	jr    $ra
	nop
	
	.end	OpNop26

	.extern OpNop27

	.ent	OpNop27
	.global	OpNop27
	.type	OpNop27,@function
OpNop27:
	move  $8,  $0
	mul   $1,  $5,  $6
	move  $12, $4
	move  $10, $0
	addu  $9,  $4,  $1
1:
	lw    $11, 0($12)
	.rept 27
		nop
	.endr
	addu  $10, $10, $11
	addiu $8,  $8,  -1
	beq   $8,  $0,  2f
	addu  $12, $12, $6
	bne   $12, $9,  1b
	nop
	j     1b
	move  $12, $4
2:
	jr    $ra
	nop
	
	.end	OpNop27

	.extern OpNop28

	.ent	OpNop28
	.global	OpNop28
	.type	OpNop28,@function
OpNop28:
	move  $8,  $0
	mul   $1,  $5,  $6
	move  $12, $4
	move  $10, $0
	addu  $9,  $4,  $1
1:
	lw    $11, 0($12)
	.rept 28
		nop
	.endr
	addu  $10, $10, $11
	addiu $8,  $8,  -1
	beq   $8,  $0,  2f
	addu  $12, $12, $6
	bne   $12, $9,  1b
	nop
	j     1b
	move  $12, $4
2:
	jr    $ra
	nop
	
	.end	OpNop28

	.extern OpNop29

	.ent	OpNop29
	.global	OpNop29
	.type	OpNop29,@function
OpNop29:
	move  $8,  $0
	mul   $1,  $5,  $6
	move  $12, $4
	move  $10, $0
	addu  $9,  $4,  $1
1:
	lw    $11, 0($12)
	.rept 29
		nop
	.endr
	addu  $10, $10, $11
	addiu $8,  $8,  -1
	beq   $8,  $0,  2f
	addu  $12, $12, $6
	bne   $12, $9,  1b
	nop
	j     1b
	move  $12, $4
2:
	jr    $ra
	nop
	
	.end	OpNop29

	.extern OpNop30

	.ent	OpNop30
	.global	OpNop30
	.type	OpNop30,@function
OpNop30:
	move  $8,  $0
	mul   $1,  $5,  $6
	move  $12, $4
	move  $10, $0
	addu  $9,  $4,  $1
1:
	lw    $11, 0($12)
	.rept 30
		nop
	.endr
	addu  $10, $10, $11
	addiu $8,  $8,  -1
	beq   $8,  $0,  2f
	addu  $12, $12, $6
	bne   $12, $9,  1b
	nop
	j     1b
	move  $12, $4
2:
	jr    $ra
	nop
	
	.end	OpNop30

	.extern OpNop31

	.ent	OpNop31
	.global	OpNop31
	.type	OpNop31,@function
OpNop31:
	move  $8,  $0
	mul   $1,  $5,  $6
	move  $12, $4
	move  $10, $0
	addu  $9,  $4,  $1
1:
	lw    $11, 0($12)
	.rept 31
		nop
	.endr
	addu  $10, $10, $11
	addiu $8,  $8,  -1
	beq   $8,  $0,  2f
	addu  $12, $12, $6
	bne   $12, $9,  1b
	nop
	j     1b
	move  $12, $4
2:
	jr    $ra
	nop
	
	.end	OpNop31

	.extern OpNop32

	.ent	OpNop32
	.global	OpNop32
	.type	OpNop32,@function
OpNop32:
	move  $8,  $0
	mul   $1,  $5,  $6
	move  $12, $4
	move  $10, $0
	addu  $9,  $4,  $1
1:
	lw    $11, 0($12)
	.rept 32
		nop
	.endr
	addu  $10, $10, $11
	addiu $8,  $8,  -1
	beq   $8,  $0,  2f
	addu  $12, $12, $6
	bne   $12, $9,  1b
	nop
	j     1b
	move  $12, $4
2:
	jr    $ra
	nop
	
	.end	OpNop32

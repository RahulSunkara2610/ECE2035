#=================================================================
# Copyright 2020 Georgia Tech.  All rights reserved.
# The materials provided by the instructor in this course are for
# the use of the students currently enrolled in the course.
# Copyrighted course materials may not be further disseminated.
# This file must not be made publicly available anywhere.
# =================================================================

# HW1-3
# Student Name: Rahul Sunkara
# Date: 2/2/21
#
# This program computes the Intersection over Union of two rectangles
# as an integer representing a percent:
#                 Area(Intersection of R1 and R2) * 100
#  IoU =    -----------------------------------------------------
#           Area(R1) + Area(R2) - Area(Intersection of R1 and R2)
#
# Assumptions for this homework:	
#  1. R1 and R2 do overlap (Area of intersection of R1 and R2 != 0)
#  2. only R1's bottom left corner is inside R2, and only R2's top
#     right corner is inside R1.	
#
# Input: two bounding boxes, each specified as (Tx, Ty, Bx, By), where
#	 (Tx, Ty) is the upper left corner point and
#	 (Bx, By) is the lower right corner point.
# Output: IoU (an integer, 1 <= IoU <= 100).
#
# IoU should be specified as an integer (only the whole part of the division),
# i.e., round down to the nearest whole number between 1 and 100 inclusive.
#
# Also, for HW1 (only), do not write values to registers $0, $29, $30, or $31
# and do NOT use helper functions or function calls (JAL).
#
# FOR FULL CREDIT (on all assignments in this class), BE SURE TO TRY
# MULTIPLE TEST CASES and DOCUMENT YOUR CODE.

.data
# DO NOT change the following three labels (you may change the initial values):
#               Tx, Ty,  Bx, By	
#R1:	.word	64, 51, 205, 210
#R2:	.word	19, 65, 190, 326
ECE: .word 0xA7FEAB4E
#1000:	25
#1004:	33
#1008:	48
#IoU:	.alloc  1
#S:		.word 0x2357ACFF
#T:		.word 0xFEBCAACD
	
.text
	
#	addi $1, $0, S
#	addi $2, $0, 0x01234567
#
#	lw $3, 0($1)
#	lw $4, 4($1)
#	lb $5, 3($1)
#	sw $2, 0($1)
#	sb $2, 4($1)


	addi $3, $0, ECE
	lbu $3, 2($3)
#		ori $2, $0, 6
#		addi $3, $0, 15 	
#loop:		beq $2, $3, END
#			addi $2, $2, 3
#
#			j loop
END:		jr $31


#	addi $1, $0, 1000
#	addi $2, $0, 8
#	addi $3, $0, 4
#
#	lw $2, 8($1)
#
#
#
#	addi $1, $0, R1 #adding the R1 
#	lw $2, 0($1)	#loading the Tx of R1
#	lw $3, 4($1)	#loading the Ty of R1
#	lw $4, 8($1)	#loading the Bx of R1
#	lw $5, 12($1)	#loading the By of R1
#
#	sub $6, $4, $2	#getting the width of R1
#	sub $7, $3, $5	#getting the height of R1
#
#	mult $6, $7	#area of R1
#	mflo $17	#storing the area of R1
#
#	addi $8, $0, R2 #adding the R2 
#	lw $9, 0($8)	#loading the Tx of R2
#	lw $10, 4($8)	#loading the Ty of R2
#	lw $11, 8($8)	#loading the Bx of R2
#	lw $12, 12($8)	#loading the By of R2
#
#	sub $13, $11, $9	#getting the width of R2
#	sub $14, $10, $12	#getting the height of R2
#
#	mult $13, $14	#area of R2
#	mflo $18		#storing the area of R2
#
#	sub $15, $11, $2	#getting thw width of combined area
#	sub $16, $10, $5	#getting the height of the combined area
#
#	mult $15, $16	#area of the union of R1 and R2
#	mflo $19		#storing the area of the union
#
#	addi $20, $0, 100
#
#	mult $19, $20
#	mflo $21
#
#	add $22, $17,$18
#	sub $23, $22, $19
#
#	div $21, $23
#	mflo $24
#
#End:	jr $31	     			# return to OS


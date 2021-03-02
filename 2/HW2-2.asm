#=================================================================
# Copyright 2020 Georgia Tech.  All rights reserved.
# The materials provided by the instructor in this course are for
# the use of the students currently enrolled in the course.
# Copyrighted course materials may not be further disseminated.
# This file must not be made publicly available anywhere.
# =================================================================
   
#     Color Matcher
#
# HW2-2
# Student Name: Rahul Sunkara
# Date: 02/09/2021
#
# This program finds the two closest colors in a eight color palette.
#
#  Required output register usage:
#  $10: minimum total component difference
#  $11 and $12: memory addresses of the two closest colors
#  The program must report the results by calling: swi 581

.data
Array:  .alloc  8               # allocate static space for packed color data

.text
ColorMatch:     addi  $1, $0, Array     # set memory base
                swi     500             # create color palette and update memory

                ######################################################
                # Temporary: the following 3 instructions demo use of swi 581.
                # Be sure to replace them.
                addi  $10, $0, 48       # guess min component difference
                addi  $11, $1, 12       # guess an address
                addi  $12, $1, 4        # guess an address
                ######################################################

                addi  $2, $0, 1000         # initializing the min value
                addi  $3, $0, 0            # initializing the 'i' for looping through colors
                addi  $4, $0, 1            # intializing 1 as it used for shifting and comparing
                addi  $30, $0, 0           # intializing 0 as it used for comparing

FLoop:          slti  $25, $3, 7        # if i < 7
                beq   $25, $0, Leave    # if not, exit
                sll   $5, $4, 8         # shifting
                sub   $5, $5, $4        # subtracting to get all 1's
                lbu   $6, 0($1)         # getting the blue value
                and   $5, $5, $6        # and to get the actual blue value
                sll   $6, $4, 8         # shifting
                sub   $6, $6, $4        # subtracting to get all 1's
                lbu   $6, 1($1)         # getting the green value
                sll   $7, $4, 8         # shifting
                sub   $7, $7, $4        # subtracting to get all 1's
                lbu   $7, 2($1)         # getting the red value
                addi  $28, $1, 4  
                addi  $27, $3, 1

SFLoop:         slti  $29, $27, 8
                beq   $29, $0, LeaveLoop  # incrementing to the next set of RGBs
                sll   $19, $4, 8          # shifting
                sub   $19, $19, $4        # subtracting to get all 1's
                lbu   $20, 0($28)         # getting the blue value
                and   $19, $19, $20       # and to get the actual blue value
                sll   $20, $4, 8          # shifting
                sub   $20, $20, $4        # subtracting to get all 1's
                lbu   $20, 1($28)         # getting the green value
                sll   $21, $4, 8          # shifting
                sub   $21, $21, $4        # subtracting to get all 1's
                lbu   $21, 2($28)         # getting the red value

               ## calculating the min distance
                sub   $16, $5, $19      # calculating the dis. of blue
                sub   $17, $6, $20      # calculating the dis. of green
                sub   $18, $7, $21      # calculating the dis. of red

               ## abs value
BNegCheck:      slt  $22, $16, $30      # checking if dis. is (-)
                bne  $22, $4, GNegCheck
                sub  $16, $30, $16
               
GNegCheck:      slt  $23, $17, $30      # checking if dis. is (-)
                bne  $23, $4, RNegCheck
                sub  $17, $30, $17

RNegCheck:      slt  $24, $18, $30      # checking if dis. is (-)
                bne  $24, $4, MinSetter
                sub  $18, $30, $18
               

                ## checking if the min dis. is less than the min
MinSetter:      add  $8, $16, $17
                add  $8, $8, $18
                slt  $26, $8, $2
                bne  $26, $4, ContIncreOne 
                mult $8, $4
                mflo $2
                mult $2, $4
                mflo $10                # getting the min diff.
                addu  $11, $1, $3       # getting the add. of set 1
                addu  $12, $28, $3      # getting the add. of set 2
                addi  $28, $28, 4       # increment to the next set
                
ContIncreOne:   addi  $27, $27, 1       # incrementing count by 1 
                j   SFLoop              # loop back the second loop

LeaveLoop:      addi $1, $1, 4          # increment to the next set
                addi $3, $3, 1          # incrementing count by 1 
                j   FLoop               # loop back

Leave:          swi     581             # report answer (in $10, $11, $12)
                jr      $31             # return to caller



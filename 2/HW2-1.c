//=================================================================
// Copyright 2020 Georgia Tech.  All rights reserved.
// The materials provided by the instructor in this course are for
// the use of the students currently enrolled in the course.
// Copyrighted course materials may not be further disseminated.
// This file must not be made publicly available anywhere.
//=================================================================

/*    
Please fill in the following
 Student Name: Rahul Sunkara
 Date: 2/8/2021

ECE 2035 Homework 2-1

This is the only file that should be modified for the C implementation
of Homework 2.

Do not include any additional libraries.
-----------------------------------------------

    Color Matcher

This program finds the two closest colors in an array of packed RGB values,
based on the total component difference (computed as a sum of absolute
difference.) It prints the total component difference of the two closest colors.

*/

#include <stdio.h>
#include <stdlib.h>

#define DEBUG 0 // RESET THIS TO 0 BEFORE SUBMITTING YOUR CODE

int main(int argc, char *argv[]) {
  /* you may change and add to these declarations and initializations */
  unsigned  Pixels[8];
  int         NumPixels, MinDelta=10000;  // temporary initial value
  int Load_Mem(char *, unsigned *);

  if (argc != 2) {
    printf("usage: ./HW2-1 valuefile\n");
    exit(1);
  }
  NumPixels = Load_Mem(argv[1], Pixels);
  if (NumPixels != 8) {
    printf("valuefiles must contain 8 entries\n");
    exit(1);
  }

   /* Your program goes here. */
    int arr[24];          //1D array to store the RGB values
    int count = 0;        // count to store the RGB and to move 3 cells in the 1D array
    for (int i = 0; i < 8; i++) {     //for loop to go over the color addresses providedd
      int num = Pixels[i];            // setting each color values as a seperate integer
      int blue = (((1 << 8) - 1) & num);      //getting the blue value by shifting left
      int green = (((1 << 8) - 1) << 8 & num) >> 8;     //getting the green value by shifting left and then right
      int red =  (((1 << 8) - 1) << 16 & num) >> 16;    //getting the red value by shifting left and then right
      arr[count] = blue;      //storing blue value
      arr[count + 1] = green;   //storing green value
      arr[count + 2] = red;     //storing red value
      count += 3;           //moving over by 3 to add new RGB values
    }

    for (int i = 0; i < sizeof(arr)/sizeof(int); i += 3) {      //iterating through the first set of RGB
      for (int j = i+3; j < sizeof(arr)/sizeof(int); j += 3){   //iterating through the second set of RGB
        int dist = (abs(arr[i] - arr[j]) + abs(arr[i+1] - arr[j+1]) + abs(arr[i+2] - arr[j+2]));    //computing the distance
        if (dist < MinDelta){   //checking if the distance if less than min, if so setting that as min
          MinDelta = dist;
        }
      }
    }
    //return colorReturn;
   /* Use a statement like this to print information helpful to
      debugging (e.g., the current value of some variable).
      Set DEBUG to 1 using the #define above when debugging, but
      reset it back to 0 before submitting your code so that your
      program doesn't confuse the autograder with superfluous prints. */
   if (DEBUG){
     printf("Sample debugging print statement. argc: %d \n", argc);
   }

   // your program should use this print statement
   printf("The two closest colors have a total component difference of %d\n", MinDelta);
   exit(0);
}

/* This routine loads in up to 8 newline delimited unsigned integers from
a named file in the local directory. The values are placed in the
passed unsigned integer array. The number of input integers is returned. */

int Load_Mem(char *InputFileName, unsigned PixelArray[]) {
  int N, Addr, NumVals;
  unsigned Value;
  FILE  *FP;
  
  FP = fopen(InputFileName, "r");
  if (FP == NULL) {
    printf("%s could not be opened; check the filename\n", InputFileName);
    return 0;
  } else {
    for (N=0; N < 8; N++) {
      NumVals = fscanf(FP, "%d: %d", &Addr, &Value);
      if (NumVals == 2)
  PixelArray[N] = Value;
      else
  break;
    }
    fclose(FP);
    return N;
  }
}
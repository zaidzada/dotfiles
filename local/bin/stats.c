// This program was generated with the help of ChatGPT
// Compile with gcc -O3 -march=native stats.c -o stats -lm

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>

#define MAX_NUMBERS 100000
#define MAX_LINE_LENGTH 1000

int compare_doubles(const void* a, const void* b) {
  double aa = *(double*)a;
  double bb = *(double*)b;
  if (aa < bb) {
    return -1;
  } else if (aa > bb) {
    return 1;
  } else {
    return 0;
  }
}

int main(int argc, char** argv) {

  // Read the numbers from standard input
  double numbers[MAX_NUMBERS];
  int num_numbers = 0;
  char line[MAX_LINE_LENGTH];
  while (fgets(line, sizeof(line), stdin)) {
    double number;
    if (sscanf(line, "%lf", &number) == 1) {
      numbers[num_numbers] = number;
      ++num_numbers;
    }
  }

  // Sort the numbers
  qsort(numbers, num_numbers, sizeof(double), compare_doubles);

  // Calculate the median
  double median;
  if (num_numbers % 2 == 1) {
    // If the number of numbers is odd, the median is the middle number
    int median_index = num_numbers / 2;
    median = numbers[median_index];
  } else {
    // If the number of numbers is even, the median is the average of the two middle numbers
    int median_index_1 = num_numbers / 2 - 1;
    int median_index_2 = num_numbers / 2;
    median = (numbers[median_index_1] + numbers[median_index_2]) / 2.0;
  }

  // Calculate the mean
  double sum = 0;
  for (int i = 0; i < num_numbers; ++i) {
    sum += numbers[i];
  }
  double mean = sum / num_numbers;

  // Calculate the minimum and maximum
  double min = numbers[0];
  double max = numbers[num_numbers - 1];

  // Calculate the standard deviation
  double variance = 0;
  for (int i = 0; i < num_numbers; ++i) {
    double diff = numbers[i] - mean;
    variance += diff * diff;
  }
  double std_dev = sqrt(variance / (num_numbers - 1));  // Apply Bessel's correction

  // Print the results
  printf("count   %d\n", num_numbers);
  printf("mean    %.6f\n", mean);
  printf("std     %.6f\n", std_dev);
  printf("min     %.6f\n", min);
  printf("median  %.6f\n", median);
  printf("max     %.6f\n", max);

  return 0;
}

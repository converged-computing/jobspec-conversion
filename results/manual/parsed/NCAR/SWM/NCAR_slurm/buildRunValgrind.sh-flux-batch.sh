#!/bin/bash
#FLUX: --job-name=bloated-noodle-2186
#FLUX: --priority=16

module purge
module list
gcc -g -lm shallow_swap.c wtime.c -o SWM_val
valgrind --leak-check=yes ./SWM_val

#!/bin/bash
#FLUX: --job-name=angry-onion-4788
#FLUX: --urgency=16

module purge
module list
gcc -g -lm shallow_swap.c wtime.c -o SWM_val
valgrind --leak-check=yes ./SWM_val

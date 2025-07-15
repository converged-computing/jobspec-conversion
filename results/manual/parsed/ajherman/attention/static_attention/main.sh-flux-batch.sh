#!/bin/bash
#FLUX: --job-name=main
#FLUX: -t=36000
#FLUX: --urgency=16

cores=20
srun -N 1 -n 1 -c $cores -o test.out --open-mode=append ./main_wrapper.sh  

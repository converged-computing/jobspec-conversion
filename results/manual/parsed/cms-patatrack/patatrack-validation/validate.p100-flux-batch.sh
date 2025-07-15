#!/bin/bash
#FLUX: --job-name=doopy-punk-2334
#FLUX: -c=20
#FLUX: --queue=gpu
#FLUX: --urgency=16

module purge
module load gcc/8.3.0
module load cuda/10.1.105_418.39
echo Host: `hostname`
echo Available CPU cores:
taskset -c -p $$ | cut -d' ' -f3- | sed -e's/c/C/' -e's/^/  /'
echo Avaliable GPUs:
nvidia-smi -L | sed -e's/^/  /'
./validate "$@"

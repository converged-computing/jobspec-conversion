#!/bin/bash
#FLUX: --job-name=lovable-noodle-9884
#FLUX: --urgency=16

echo "CUDA_VISIBLE_DEVICES=$CUDA_VISIBLE_DEVICES"
srun gmx mdrun -deffnm gromacs -c gromacs_out.gro

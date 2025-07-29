#!/bin/bash
#FLUX --job-name=outstanding-caramel-9628
#FLUX --queue=main
#FLUX --urgency=16

echo "CUDA_VISIBLE_DEVICES=$CUDA_VISIBLE_DEVICES"
srun gmx mdrun -deffnm gromacs -c gromacs_out.gro

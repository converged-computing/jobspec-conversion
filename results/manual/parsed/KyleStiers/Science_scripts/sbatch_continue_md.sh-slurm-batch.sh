#!/bin/bash
#FLUX: --job-name=gromacs
#FLUX: --queue=gpu3
#FLUX: -t=172800
#FLUX: --urgency=16

echo "### Starting at: $(date) ###"
source /storage/hpc/hpc-poc/micore/gromacs-gputhread/bin/GMXRC
module load cuda/cuda-8.0
module load hwloc/hwloc-1.11.4
module list
gmx_gputhread mdrun -s step5_production.tpr -cpi md.cpt -append -deffnm md #make sure the -deffnm is the SAME as whatever it was in the original mdrun call
echo "### Ending at: $(date) ###"

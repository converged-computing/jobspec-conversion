#!/bin/bash
#FLUX: --job-name=misunderstood-ricecake-6742
#FLUX: --queue=qgpu
#FLUX: -t=86400
#FLUX: --priority=16

echo "========= Job started  at `date` =========="
cd $SLURM_SUBMIT_DIR
source /comm/specialstacks/gromacs-volta/bin/modules.sh
module load gromacs-gcc-8.2.0-openmpi-4.0.3-cuda-10.1
gmx_mpi grompp -f ../../relax.mdp -p all_PRO.top -c min.gro -o relax.tpr -v
gmx_mpi mdrun -s relax.tpr -deffnm relax -ntomp 18 -maxh 23.9 -v
echo "========= Job finished at `date` =========="

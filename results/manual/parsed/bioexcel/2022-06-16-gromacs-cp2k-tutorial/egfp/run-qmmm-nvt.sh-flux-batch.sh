#!/bin/bash
#FLUX: --job-name=delicious-cat-8605
#FLUX: -c=4
#FLUX: --queue=standard
#FLUX: -t=1200
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export OMP_PLACES='cores'

. /etc/profile
module use /work/ta072/ta072/shared/modulefiles/gromacs2022
module load gmx_cp2k
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export OMP_PLACES=cores
srun gmx_mpi_d mdrun -s egfp-qmmm-nvt.tpr -deffnm egfp-qmmm-nvt

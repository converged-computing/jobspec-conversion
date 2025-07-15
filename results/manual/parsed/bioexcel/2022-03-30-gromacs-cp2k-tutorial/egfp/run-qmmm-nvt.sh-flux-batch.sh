#!/bin/bash
#FLUX: --job-name=bricky-parrot-9339
#FLUX: -c=4
#FLUX: --queue=standard
#FLUX: -t=1200
#FLUX: --priority=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export OMP_PLACES='cores'

module purge
module use /work/ta060/ta060/shared/modulefiles/gromacs2022
module load gmx_cp2k
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export OMP_PLACES=cores
srun gmx_mpi_d mdrun -s egfp-qmmm-nvt.tpr -deffnm egfp-qmmm-nvt

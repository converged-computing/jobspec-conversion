#!/bin/bash
#SBATCH --job-name=egfp-qmmm-nvt
#SBATCH --account=ta072
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=00:20:00
#SBATCH --partition=standard
#SBATCH --qos=reservation

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export OMP_PLACES='cores'

. /etc/profile
module use /work/ta072/ta072/shared/modulefiles/gromacs2022
module load gmx_cp2k
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export OMP_PLACES=cores
srun gmx_mpi_d mdrun -s egfp-qmmm-nvt.tpr -deffnm egfp-qmmm-nvt

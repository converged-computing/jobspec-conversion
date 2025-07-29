#!/bin/bash
#SBATCH --job-name=vasp-openmpi-slurm
#SBATCH --account=a9009
#SBATCH --nodes=1
#SBATCH --ntasks=48
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2G
#SBATCH --time=00:30:00
#SBATCH --constraint=[quest8|quest9|quest10|quest11]

export OMP_NUM_THREADS='1'

module purge
module use /software/spack_v17d2/spack/share/spack/modules/linux-rhel7-x86_64/
module load vasp/5.4.4-openmpi-intel
export OMP_NUM_THREADS=1
mpirun -np ${SLURM_NTASKS} vasp_std

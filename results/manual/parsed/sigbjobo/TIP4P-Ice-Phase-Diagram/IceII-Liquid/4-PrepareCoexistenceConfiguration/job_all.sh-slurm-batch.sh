#!/bin/bash
#SBATCH --job-name=2-Bulk
#SBATCH --account=SLC103
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=8
#SBATCH --time=2-00:00:00

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export PLUMED_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export LAMMPS_EXE='/home/sbore/software/mbx_lammps_plumed/lammps/src/lmp_mpi_mbx'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export PLUMED_NUM_THREADS=$SLURM_CPUS_PER_TASK
pwd; hostname; date
module load fftw openmpi
export LAMMPS_EXE=/home/sbore/software/mbx_lammps_plumed/lammps/src/lmp_mpi_mbx
cycles=2
threads_per_partition=1
ls *EQUIL_*/ -d| xargs -l -P 4 bash -c 'cd $0; pwd; srun -n 4 $LAMMPS_EXE -sf omp -in equil.lmp'
date

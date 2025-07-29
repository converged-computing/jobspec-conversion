#!/bin/bash
#FLUX: --job-name=2-Bulk
#FLUX: -n=4
#FLUX: -c=8
#FLUX: --queue=compute
#FLUX: -t=172800
#FLUX: --urgency=16

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

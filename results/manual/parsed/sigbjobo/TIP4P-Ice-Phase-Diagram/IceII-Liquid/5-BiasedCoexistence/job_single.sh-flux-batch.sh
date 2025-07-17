#!/bin/bash
#FLUX: --job-name=COEX
#FLUX: --queue=compute
#FLUX: -t=90000
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export PLUMED_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export LAMMPS_EXE='/home/sbore/software/mbx_lammps_plumed/lammps/src/lmp_mpi_mbx'

set -e
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export PLUMED_NUM_THREADS=$SLURM_CPUS_PER_TASK
pwd; hostname; date
module load fftw openmpi
export LAMMPS_EXE=/home/sbore/software/mbx_lammps_plumed/lammps/src/lmp_mpi_mbx
cycles=2
threads_per_partition=2
pwd
cycles=1
partitions=1
if [ -e runno ] ; then
   #########################################################################
   # Restart runs
   #########################################################################
   nn=`tail -n 1 runno | awk '{print $1}'`
   srun $LAMMPS_EXE -sf omp -partition 4x32 -in Restart.lmp
   #########################################################################
else
   #########################################################################
   # First run
   #########################################################################
   nn=1
   # Number of partitions
   srun $LAMMPS_EXE -sf omp -partition 4x32 -in start.lmp
   #########################################################################
fi
for j in $(seq 0 3)
do
        cp log.lammps.${j} log.lammps.${j}.${nn}
        cp restart2.lmp.${j} restart2.lmp.${j}.${nn}
        cp restart.lmp.${j} restart.lmp.${j}.${nn}
        cp data.final.${j} data.final.${j}.${nn}
done
mm=$((nn+1))
echo ${mm} > runno
if [ ${nn} -ge ${cycles} ]; then
  exit
fi

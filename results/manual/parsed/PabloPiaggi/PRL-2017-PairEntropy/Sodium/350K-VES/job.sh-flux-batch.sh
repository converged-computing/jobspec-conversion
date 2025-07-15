#!/bin/bash
#FLUX: --job-name=na-ves-350
#FLUX: -n=24
#FLUX: -t=86400
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export PLUMED_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export PLUMED_NUM_THREADS=$SLURM_CPUS_PER_TASK
pwd; hostname; date
module purge
module load intel-mpi intel
LAMMPS_HOME=/home/ppiaggi/Programs/Lammps/lammps-git-cpu/build3
LAMMPS_EXE=${LAMMPS_HOME}/lmp_della
cycles=1
threads_per_partition=4
if [ -e runno ] ; then
   #########################################################################
   # Restart runs
   #########################################################################
   nn=`tail -n 1 runno | awk '{print $1}'`
   srun $LAMMPS_EXE -partition 6x${threads_per_partition} -sf omp -sf intel -in Restart.lmp
   #########################################################################
else
   #########################################################################
   # First run
   #########################################################################
   nn=1
   # Number of partitions
   srun $LAMMPS_EXE -partition 6x${threads_per_partition} -sf omp -sf intel -in start.lmp
   #########################################################################
fi
for j in $(seq 0 5)
do
        cp restart2.${j} restart2.${j}.${nn}
        cp restart.${j} restart.${j}.${nn}
        cp data.final.${j} data.final.${j}.${nn}
done
mm=$((nn+1))
echo ${mm} > runno
if [ ${nn} -ge ${cycles} ]; then
  exit
fi
sbatch < job.sh
date

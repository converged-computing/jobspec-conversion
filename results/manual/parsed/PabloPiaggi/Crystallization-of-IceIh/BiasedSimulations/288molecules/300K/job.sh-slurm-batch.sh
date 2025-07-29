#!/bin/bash
#FLUX: --job-name=288Mol
#FLUX: -n=4
#FLUX: -c=40
#FLUX: -t=86400
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export PLUMED_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export PLUMED_NUM_THREADS=$SLURM_CPUS_PER_TASK
pwd; hostname; date
module purge
module load intel-mpi intel
LAMMPS_HOME=/home/ppiaggi/Programs/Lammps/lammps-git-cpu/build
LAMMPS_EXE=${LAMMPS_HOME}/lmp_tigerCpu
cycles=15
if [ -e runno ] ; then
   #########################################################################
   # Restart runs
   #########################################################################
   nn=`tail -n 1 runno | awk '{print $1}'`
   srun $LAMMPS_EXE -sf omp -partition 4x1 -in Restart.lmp
   #########################################################################
else
   #########################################################################
   # First run
   #########################################################################
   nn=1
   # Number of partitions
   srun $LAMMPS_EXE -sf omp -partition 4x1 -in start.lmp
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
sbatch < job.sh
date

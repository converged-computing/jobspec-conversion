#!/bin/bash
#FLUX: --job-name=al-mt-950
#FLUX: -n=4
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
cycles=15
if [ -e runno ] ; then
   #########################################################################
   # Restart runs
   #########################################################################
   nn=`tail -n 1 runno | awk '{print $1}'`
   srun $LAMMPS_EXE -in Restart.lmp
   #########################################################################
else
   #########################################################################
   # First run
   #########################################################################
   nn=1
   # Number of partitions
   srun $LAMMPS_EXE -in start.lmp
   #########################################################################
fi
cp restart2.0 restart2.0.${nn}
cp restart.0 restart.0.${nn}
cp data.final data.final.${nn}
mm=$((nn+1))
echo ${mm} > runno
if [ ${nn} -ge ${cycles} ]; then
  exit
fi
sbatch < job.sh
date

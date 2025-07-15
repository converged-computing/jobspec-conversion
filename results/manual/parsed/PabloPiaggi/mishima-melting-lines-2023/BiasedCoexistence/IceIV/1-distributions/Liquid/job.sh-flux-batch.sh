#!/bin/bash
#FLUX: --job-name="Liquid"
#FLUX: -n=2
#FLUX: -c=32
#FLUX: -t=86400
#FLUX: --priority=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export PLUMED_NUM_THREADS='$SLURM_CPUS_PER_TASK'

module purge
module load rh/devtoolset/7
module load cudatoolkit/10.0
module load cudnn/cuda-10.0/7.6.1
module load openmpi/gcc/3.1.4/64
module load anaconda3/2019.3
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export PLUMED_NUM_THREADS=$SLURM_CPUS_PER_TASK
LAMMPS_HOME=/home/ppiaggi/Programs/DeepMD/lammps2/src
LAMMPS_EXE=${LAMMPS_HOME}/lmp_mpi
cycles=1
partitions=1
if [ -e runno ] ; then
   #########################################################################
   # Restart runs
   #########################################################################
   nn=`tail -n 1 runno | awk '{print $1}'`
   export SLURM_WHOLE=1
   mpirun -np $SLURM_NTASKS $LAMMPS_EXE -partition ${partitions}x2 -in Restart.lmp
   #########################################################################
else
   #########################################################################
   # First run
   #########################################################################
   nn=1
   export SLURM_WHOLE=1
   mpirun -np $SLURM_NTASKS $LAMMPS_EXE -partition ${partitions}x2 -in start.lmp
   #########################################################################
fi
j=0
cp restart2.lmp.${j} restart2.lmp.${j}.${nn}
cp restart.lmp.${j} restart.lmp.${j}.${nn}
cp data.final.${j} data.final.${j}.${nn}
cp log.lammps.${j} log.lammps.${j}.${nn}
mm=$((nn+1))
echo ${mm} > runno
if [ ${nn} -ge ${cycles} ]; then
  exit
fi
sbatch < job.sh
date

#!/bin/bash
#FLUX: --job-name=Ic-REPLACE
#FLUX: -c=8
#FLUX: -t=86400
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export PLUMED_NUM_THREADS='$SLURM_CPUS_PER_TASK'

module purge
module avail
module load rh/devtoolset/7
module load cudatoolkit/10.0
module load cudnn/cuda-10.0/7.6.1
module load openmpi/gcc/3.1.4/64
module load anaconda3/2019.3
conda activate tensorflow-venv
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export PLUMED_NUM_THREADS=$SLURM_CPUS_PER_TASK
LAMMPS_HOME=/home/ppiaggi/Programs/DeepMD/lammps/src
LAMMPS_EXE=${LAMMPS_HOME}/lmp_mpi
cycles=4
partitions=4
if [ -e runno ] ; then
   #########################################################################
   # Restart runs
   #########################################################################
   nn=`tail -n 1 runno | awk '{print $1}'`
   mpirun -np $SLURM_NTASKS $LAMMPS_EXE -in Restart.lmp
   #########################################################################
else
   #########################################################################
   # First run
   #########################################################################
   nn=1
   # Number of partitions
   mpirun -np $SLURM_NTASKS $LAMMPS_EXE -in start.lmp
   #########################################################################
fi
cp restart2.lmp restart2.lmp.${nn}
cp restart.lmp restart.lmp.${nn}
cp data.final data.final.${nn}
mm=$((nn+1))
echo ${mm} > runno
if [ ${nn} -ge ${cycles} ]; then
  exit
fi
sbatch < job.sh
date

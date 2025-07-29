#!/bin/bash
#FLUX: --job-name=310K
#FLUX: -n=2
#FLUX: -c=7
#FLUX: -t=86400
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export PLUMED_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export PLUMED_NUM_THREADS=$SLURM_CPUS_PER_TASK
pwd; hostname; date
module purge
module load rh/devtoolset/4
module load cudatoolkit/10.0
module load cudnn/cuda-10.0/7.6.3
module load openmpi/gcc/3.1.3/64
LAMMPS_EXE=/home/ppiaggi/Programs/Software-deepmd-kit-1.0/lammps-git2/src/lmp_mpi
source /home/ppiaggi/Programs/Software-deepmd-kit-1.0/tensorflow-venv/bin/activate
cycles=1
if [ -e runno ] ; then
   #########################################################################
   # Restart runs
   #########################################################################
   nn=`tail -n 1 runno | awk '{print $1}'`
   export SLURM_WHOLE=1
   mpirun $LAMMPS_EXE -sf omp -in Restart.lmp
   #########################################################################
else
   #########################################################################
   # First run
   #########################################################################
   nn=1
   # Number of partitions
   export SLURM_WHOLE=1
   mpirun $LAMMPS_EXE -sf omp -in start.lmp
   #########################################################################
fi
cp restart2.lmp restart2.lmp.${nn}
cp restart.lmp restart.lmp.${nn}
cp data.final data.final.${nn}
cp log.lammps log.lammps.${nn}
mm=$((nn+1))
echo ${mm} > runno
if [ ${nn} -ge ${cycles} ]; then
  exit
fi
sbatch < job.sh
date

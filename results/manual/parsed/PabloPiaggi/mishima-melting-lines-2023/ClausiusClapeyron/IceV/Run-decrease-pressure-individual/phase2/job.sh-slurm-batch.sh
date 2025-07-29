#!/bin/bash
#FLUX: --job-name=liqV
#FLUX: -n=4
#FLUX: -c=32
#FLUX: -t=518400
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export SLURM_WHOLE='1'

module purge
module load cudatoolkit/10.0
module load cudnn/cuda-10.0/7.6.1
module load openmpi/gcc/3.1.4/64
module load anaconda3/2019.3
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export SLURM_WHOLE=1
LAMMPS_HOME=/home/ppiaggi/Programs/DeepMD/lammps2/src
LAMMPS_EXE=${LAMMPS_HOME}/lmp_mpi
cycles=1
if [ -e runno ] ; then
   #########################################################################
   # Restart runs
   #########################################################################
   nn=`tail -n 1 runno | awk '{print $1}'`
   srun $LAMMPS_EXE -i in.lammps.phase2.restart
   #########################################################################
else
   #########################################################################
   # First run
   #########################################################################
   nn=1
   # Number of partitions
   srun $LAMMPS_EXE -i in.lammps.phase2
   #########################################################################
fi
cp water.data.final.phase2 water.data.final.phase2.${nn}
cp restart.lmp restart.lmp.${nn}
cp log.lammps log.lammps.${nn}
mm=$((nn+1))
echo ${mm} > runno
if [ ${nn} -ge ${cycles} ]; then
  exit
fi
sbatch < job.sh
date

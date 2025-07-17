#!/bin/bash
#FLUX: --job-name=MD_tension
#FLUX: --queue=course
#FLUX: --urgency=16

module load compiles/intel/2019/u4/config
module load lib/gcc/9.2.0/config
scontrol show hostname $SLURM_JOB_NODELIST > ./hosts
rm -rf hostfile
touch hostfile
for i in `cat hosts`
do
 echo $i:4>>hostfile
done
mpirun -machinefile hostfile -np 4 /home/train1/WORK/package/lammps-stable_29Oct2020/src/lmp_mpi  < tension.in > tension_Cu.log

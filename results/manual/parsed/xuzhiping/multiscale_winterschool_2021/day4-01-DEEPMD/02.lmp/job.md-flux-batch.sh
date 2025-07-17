#!/bin/bash
#FLUX: --job-name=dpmd
#FLUX: --queue=course
#FLUX: --urgency=16

module load compiles/intel/2019/u4/config
module load lib/gcc/7.4.0/e5/config
source /apps/soft/tesorflow/bin/activate
scontrol show hostname $SLURM_JOB_NODELIST > ./hosts
rm -rf hostfile
touch hostfile
for i in `cat hosts`
do
 echo $i:4>>hostfile
done
mpirun -machinefile hostfile -np 4 /apps/soft/lammps/lammps_deepmd/lammps-3Mar20_deepmd-1.2.2/src/lmp_mpi<in.lammps
deactivate

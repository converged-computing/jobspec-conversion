#!/bin/bash
#SBATCH --job-name=parallel_traffic
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --time=00:02:00
#SBATCH --partition=normal

export PATH='$PATH:/opt/apps/intel14/mvapich2_2_0/python/2.7.6/lib/python2.7/site-packages/mpi4py/bin'
export MV2_SMP_USE_LIMIC2='0'

module load intel/14.0.1.106
module load mvapich2/2.0b
module load python/2.7.6
module load mpi4py
cd /home1/03172/dbwork/taxisim
export PATH=$PATH:/opt/apps/intel14/mvapich2_2_0/python/2.7.6/lib/python2.7/site-packages/mpi4py/bin
export MV2_SMP_USE_LIMIC2=0
ibrun -np 4 python-mpi test.py &> test_out.txt

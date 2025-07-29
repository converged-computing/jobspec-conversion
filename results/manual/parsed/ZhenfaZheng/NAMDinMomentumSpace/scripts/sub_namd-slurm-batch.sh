#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --partition=normal,normal2,normal3,normal4
#SBATCH --constraint=ntasks-per-node=28

export PATH='/data/app/qe-7.2/Hefei-NAMD/NAMD-EPC/src:$PATH'

module load hdf5/1.12.1/intel
source /data/soft/intel/oneapi2022/setvars.sh
export PATH=/data/app/qe-7.2/Hefei-NAMD/NAMD-EPC/src:$PATH
echo "Job Running ..."
JOB='namd'
EXE='namd-epc'
mpirun -n $SLURM_NTASKS $EXE > $JOB.out
echo "Job Done!"

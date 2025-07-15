#!/bin/bash
#FLUX: --job-name=evasive-parrot-5803
#FLUX: --queue=normal,normal2,normal3,normal4
#FLUX: -t=86400
#FLUX: --urgency=16

export PATH='/data/app/qe-7.2/Hefei-NAMD/NAMD-EPC/src:$PATH'

module load hdf5/1.12.1/intel
source /data/soft/intel/oneapi2022/setvars.sh
export PATH=/data/app/qe-7.2/Hefei-NAMD/NAMD-EPC/src:$PATH
echo "Job Running ..."
JOB='namd'
EXE='namd-epc'
mpirun -n $SLURM_NTASKS $EXE > $JOB.out
echo "Job Done!"

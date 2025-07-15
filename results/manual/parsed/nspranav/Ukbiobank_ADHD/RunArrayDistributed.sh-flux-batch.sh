#!/bin/bash
#FLUX: --job-name=eccentric-diablo-8738
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'
export MODULEPATH='/apps/Compilers/modules-3.2.10/Debug-Build/Modules/3.2.10/modulefiles/'

source /home/users/pnadigapusuresh1/anaconda3/bin/activate latest
python distributed_conv.py ${SLURM_ARRAY_TASK_ID}
export OMP_NUM_THREADS=1
export MODULEPATH=/apps/Compilers/modules-3.2.10/Debug-Build/Modules/3.2.10/modulefiles/
echo $HOSTNAME >&2
module load Framework/Matlab2019b
matlab -batch 'array_example($SLURM_ARRAY_TASK_ID)'
sleep 30s

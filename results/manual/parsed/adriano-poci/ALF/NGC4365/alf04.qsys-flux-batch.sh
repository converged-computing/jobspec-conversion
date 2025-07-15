#!/bin/bash
#FLUX: --job-name="alf_NGC4365_SN100"
#FLUX: -c=16
#FLUX: -t=172800
#FLUX: --priority=16

export ALF_HOME='/cosma5/data/durham/dc-poci1/alf/'

source ${HOME}/.bashrc
module load gnu_comp
module load python/3.10.7
module load openmpi/20190429
module load cmake/3.18.1
export ALF_HOME=/cosma5/data/durham/dc-poci1/alf/
cd ${ALF_HOME}
declare idx=$(printf %04d $((${SLURM_ARRAY_TASK_ID} + 1320)))
mpirun --oversubscribe -np ${SLURM_CPUS_PER_TASK} ./NGC4365/bin/alf.exe "NGC4365_SN100_${idx}" 2>&1 | tee -a "NGC4365/out_${idx}.log"

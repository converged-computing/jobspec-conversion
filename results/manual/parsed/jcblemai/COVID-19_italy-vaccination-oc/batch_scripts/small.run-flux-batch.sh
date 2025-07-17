#!/bin/bash
#FLUX: --job-name=boopy-spoon-3187
#FLUX: -c=36
#FLUX: -t=259200
#FLUX: --urgency=16

export MDL_DAYS='30'
export MDL_NNODES='107'
export F_DIR='`date +%Y-%m-%d`-${MDL_NNODES}_${MDL_DAYS}/'
export F_PREFIX='week'
export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:$HOME/src/hsl/20190503_${SYS_TYPE}/lib'
export LD_PRELOAD='$MKLROOT/lib/intel64/libmkl_rt.so'
export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

N=${SLURM_ARRAY_TASK_ID}
export MDL_DAYS=30
export MDL_NNODES=107
export F_DIR="`date +%Y-%m-%d`-${MDL_NNODES}_${MDL_DAYS}/"
export F_PREFIX="week"
mkdir -p $F_DIR
module purge
module restore COVID_OCP
source $HOME/venvs/$SYS_TYPE/bin/activate
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/src/hsl/20190503_${SYS_TYPE}/lib
export LD_PRELOAD=$MKLROOT/lib/intel64/libmkl_rt.so
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
srun python -u main.py -s ${SLURM_ARRAY_TASK_ID} -t $MDL_DAYS -n $MDL_NNODES -f $F_PREFIX -d $F_DIR --use_matlab False --optimize True > ${F_DIR}out${SLURM_ARRAY_TASK_ID}.txt 2>&1 &
wait  # so it waits for both

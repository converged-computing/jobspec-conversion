#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=36
#SBATCH --mem=180G
#SBATCH --time=3-00:00:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=0-11

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

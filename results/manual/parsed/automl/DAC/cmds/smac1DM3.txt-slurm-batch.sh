#!/bin/bash
#SBATCH --output=experiments/logs/%x.%N.%A.%a.out
#SBATCH --error=experiments/logs/%x.%N.%A.%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=bosch_cpu-cascadelake
#SBATCH --array=1-25

source activate dac
experi="1D3M"
expdir="experiments/other_${experi}"
cmd="dac/train/train_other.py -r 1 -n 100000 --bo -s ${SLURM_ARRAY_TASK_ID} --env ${experi} --out-dir ${expdir}"
if [ $SLURM_ARRAY_TASK_ID -le 25 ]; then
    python $cmd 
    exit $?
fi

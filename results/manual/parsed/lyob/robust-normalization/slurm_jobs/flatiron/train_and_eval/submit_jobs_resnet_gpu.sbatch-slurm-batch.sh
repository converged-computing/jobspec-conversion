#!/bin/bash
#SBATCH --job-name=resnorm
#SBATCH --output=./out/resnet/out.%j.%a.%N.out
#SBATCH --error=./err/resnet/err.%j.%a.%N.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --gpus-per-task=1
#SBATCH --mem=32G
#SBATCH --time=01:00:00
#SBATCH --partition=gpu
#SBATCH --constraint=a100

ARRAY_ID=$1
PARAMETER_FILE=$2
let FILE_LINE=($ARRAY_ID + $SLURM_ARRAY_TASK_ID)
echo "Line ${FILE_LINE}"
PARAMETERS=$(sed "${FILE_LINE}q;d" ${PARAMETER_FILE})
echo ${PARAMETERS}
bash run_code_resnet.sh ${PARAMETERS}

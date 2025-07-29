#!/bin/bash
#SBATCH --job-name=EV1
#SBATCH --output=EV1.%A_%a.out
#SBATCH --error=EV1.%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=50gb
#SBATCH --time=02:00:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=1-2

inputFileName="./input/EV1_input_parameters.txt"
parameters=`sed "${SLURM_ARRAY_TASK_ID}q;d" $inputFileName`
time python ./02_EV1.py $parameters

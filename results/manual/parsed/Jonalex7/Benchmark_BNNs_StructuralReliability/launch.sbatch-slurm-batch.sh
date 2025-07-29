#!/bin/bash
#SBATCH --job-name=bnn_surrogate_test
#SBATCH --mail-user=jmoran@uliege.be
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10G
#SBATCH --time=1-12:00:00
#SBATCH --array=0-5

ARGS=("--method=bnnbpp --lstate=parabolic" "--method=dropout --lstate=parabolic" "--method=sghmc --lstate=himmelblau" "--method=sghmc --lstate=parabolic" "--method=sghmc --lstate=electric" "--method=sghmc --lstate=high_dim")
ARG=${ARGS[$SLURM_ARRAY_TASK_ID]}
source env/bin/activate
python main_train.py $ARG

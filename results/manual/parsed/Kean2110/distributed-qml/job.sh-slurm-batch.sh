#!/bin/bash
#SBATCH --job-name=dqml
#SBATCH --output=./slurm_output/output.%A_%a.out
#SBATCH --mail-user=K.Izadi@campus.lmu.de
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --chdir=./
#SBATCH --array=[1,2,3,4,5]

echo Running on node $SLURMD_NODENAME at `date`
. ./env/bin/activate
cd two_feature_app
python main.py $SLURM_ARRAY_TASK_ID $SLURM_ARRAY_JOB_ID$SLURM_ARRAY_TASK_ID
echo Finished at `date`

#!/bin/bash
#SBATCH --job-name=DelBias
#SBATCH --output=/homedtic/gjimenez/DADES/DADES/DelineationResults/BIAS_20_SEPARATE/LOGS/%A_%a.out
#SBATCH --error=/homedtic/gjimenez/DADES/DADES/DelineationResults/BIAS_20_SEPARATE/LOGS/%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2G
#SBATCH --partition=medium
#SBATCH --array=000-999

ORIGINAL_SLURM_ARRAY_TASK_ID=$SLURM_ARRAY_TASK_ID;
WINDOW_SIZE=20;
module load Python/3.6.4-foss-2017a;
module load libGLU/9.0.0-foss-2017a;
source ~/VirtEnv/DeepLearning3/bin/activate;
cd ~/GitHub/DelineatorSwitchAndCompose;
for i in `seq 0 1000 10000`; 
do 
    SLURM_ARRAY_TASK_ID=$(expr $ORIGINAL_SLURM_ARRAY_TASK_ID + $i);
    python3 compute_bias.py --basedir /homedtic/gjimenez/DADES/DADES/PhysioNet/QTDB/manual0_bias --outdir /homedtic/gjimenez/DADES/DADES/DelineationResults/BIAS_20_SEPARATE --signal_id ${SLURM_ARRAY_TASK_ID} --win_size ${WINDOW_SIZE};
done

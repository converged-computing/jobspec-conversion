#!/bin/bash
#SBATCH --account=m3246
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --gpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --partition=regular
#SBATCH --constraint=gpu,ntasks-per-node=4
#SBATCH --array=500,1000,2000,3000,4000,5000,6000,7000,10000

module load tensorflow
echo python classify.py --SR --hamb --nsig ${SLURM_ARRAY_TASK_ID} --nid $1
srun python classify.py --SR  --hamb --nsig ${SLURM_ARRAY_TASK_ID} --nid $1

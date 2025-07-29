#!/bin/bash
#SBATCH --account=project_2002044
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH --gres=gpu:v100:1,nvme:20
#SBATCH --mem=10G
#SBATCH --time=02:00:00

module load tensorflow
echo $LOCAL_SCRATCH
tar xf trainingTilesBinary_1024.tar -C $LOCAL_SCRATCH
ls $LOCAL_SCRATCH
srun python3 08_1_train.py $LOCAL_SCRATCH 2

#!/bin/bash
#SBATCH --job-name=train
#SBATCH --output=out/%a.out
#SBATCH --mail-user=larend@mit.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --gres=gpu:tesla-k80:8
#SBATCH --mem=64000
#SBATCH --time=3-00:00:00

module load openmind/singularity/older_versions/2.4
singularity exec --nv -B /om:/om /om/user/larend/localtensorflow.img \
python /om/user/larend/robust/train/imagenet/train.py \
--model_index="${SLURM_ARRAY_TASK_ID}" --host_filesystem=/om

#!/bin/bash
#SBATCH --job-name=gen_image_var
#SBATCH --output=/home/jrick6/repos/data/logs/imagenet2012_subset_1pct/set0/shard10/%x.%A.%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=16G
#SBATCH --time=00:05:00
#SBATCH --chdir=/home/jrick6/repos/data
#SBATCH --array=8007-8807%30
#SBATCH --exclude=ice[100,102-105,107-109,110-134,137-150,152-161,165,167,186]

hostname
nvidia-smi
/home/jrick6/.conda/envs/simclr/bin/python generate_image_variations.py \
    -tfp "/home/jrick6/tensorflow_datasets/imagenet2012_subset_id/1pct/5.0.0/imagenet2012_subset-train.tfrecord-00010-of-00016" \
    -o "/home/jrick6/tensorflow_datasets/imagenet2012_subset_id_variations0/1pct/5.0.0/dir_imagenet2012_subset-train.tfrecord-00010-of-00016/imagenet2012_subset-train.tfrecord-00010-of-00016" \
    --input_id ${SLURM_ARRAY_TASK_ID}

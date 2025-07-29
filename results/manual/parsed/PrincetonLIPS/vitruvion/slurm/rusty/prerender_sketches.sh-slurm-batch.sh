#!/bin/bash
#SBATCH --job-name=prerender_sketches
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --partition=bnl
#SBATCH --array=0-15

set -u
set -e
MAIN_DIR=/mnt/ceph/users/wzhou/projects/gencad/img2cad/data/
OUTPUT_DIR=$MAIN_DIR/renders
mkdir -p $OUTPUT_DIR
printf -v SHARD_INDEX "%02d" $((SLURM_ARRAY_TASK_ID + 1))
python -um img2cad.pipeline.prerender_images sequence_file=$MAIN_DIR/sg_filtered_unique.npy \
    slurm_array_task_id=$SLURM_ARRAY_TASK_ID slurm_array_task_count=$SLURM_ARRAY_TASK_COUNT image_size=128 num_noisy_samples=5 \
    output_file=${OUTPUT_DIR}/render_p128_${SHARD_INDEX}_of_${SLURM_ARRAY_TASK_COUNT}.npy

#!/bin/bash
#SBATCH --job-name=aNiMAte-eval
#SBATCH --output=output-%j.txt
#SBATCH --error=output-%j.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=a100:1
#SBATCH --mem=512G

export CUDA_LAUNCH_BLOCKING='1'

if [ $# -ne 2 ]; then
  echo "ERROR USAGE: $0 <config-path> <checkpoint-path>"
  echo You need to specify a train config.ini and a model checkpoint path
  exit 1
fi
export CUDA_LAUNCH_BLOCKING=1
singularity exec -B /sdf --nv /sdf/group/ml/CryoNet/singularity_images/animate_latest.sif \
            python src/experiment_scripts/eval.py -c "$1" \
            --checkpoint_path "$2" --thread_num "${SLURM_NTASKS}" \
            --remove_nma_outliers 1 --outliers_sigma_num 2.0\
            --cluster_num 2 --latent_decomposition PCA --load_evaluation 0

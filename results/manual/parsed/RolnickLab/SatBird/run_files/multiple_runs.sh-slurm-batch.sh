#!/bin/bash
#SBATCH --job-name=ebird_baseline
#SBATCH --output=job_output_%j.txt
#SBATCH --error=job_error_%j.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=50Gb
#SBATCH --time=1-10:59:00
#SBATCH --array=1-3:1

export COMET_API_KEY='$COMET_API_KEY'
export HYDRA_FULL_ERROR='1'

module load anaconda/3
conda activate satbird
export COMET_API_KEY=$COMET_API_KEY
export HYDRA_FULL_ERROR=1
python train.py args.config=configs/SatBird-USA-summer/resnet18_RGBNIR_ENV_RM.yaml args.run_id=$SLURM_ARRAY_TASK_ID

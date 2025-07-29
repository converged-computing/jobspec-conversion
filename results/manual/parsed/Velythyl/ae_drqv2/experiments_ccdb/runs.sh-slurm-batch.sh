#!/bin/bash
#SBATCH --job-name=my_job_name
#SBATCH --account=rrg-lpaull
#SBATCH --output=%j.out
#SBATCH --mail-user=charlie.gauthier@umontreal.ca
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --gres=gpu:a100:1
#SBATCH --mem=64Gb
#SBATCH --time=1-12:00:00

export PYTHONPATH='${PYTHONPATH}:/home/$USER/projects/def-lpaull/$USER/ae_drqv2'

module load cuda/11.2.2 cudnn/8.2.0
module load singularity/3.8
export PYTHONPATH="${PYTHONPATH}:/home/$USER/projects/def-lpaull/$USER/ae_drqv2"
cd /home/$USER/projects/def-lpaull/$USER/deep-var-nets/src/experiments
singularity exec --nv --home /home/$USER/projects/def-lpaull/$USER/deep-var-nets/ --env WANDB_MODE="offline",WANDB_API_KEY="",WANDB_WATCH="false",HYDRA_FULL_ERROR=1 /home/$USER/projects/def-lpaull/Singularity/pred_unc.sif python run_general_regression_hyperparameter.py $SLURM_ARRAY_TASK_ID

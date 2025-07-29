#!/bin/bash
#SBATCH --job-name=randomfreezeencoder
#SBATCH --output=/home/codee/scratch/sourcecode/cem-dataset/evaluation/pretrain_500k_test_%j_%N.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --mem=128000M
#SBATCH --time=12:00:00
#SBATCH --constraint=ntasks-per-node=1

module load python/3.10
virtualenv --no-download $SLURM_TMPDIR/env
source $SLURM_TMPDIR/env/bin/activate
pip install --no-index --upgrade pip
pip install --no-index -r /home/codee/scratch/sourcecode/cem-dataset/evaluation/requirements.txt
pip install /home/codee/segmentation_models_pytorch-0.3.3-py3-none-any.whl
module load cuda/11.4
log_dir="/home/codee/scratch/sourcecode/cem-dataset/evaluation/finetunesave"
echo log_dir : `pwd`/$log_dir
mkdir -p `pwd`/$log_dir
srun python /home/codee/scratch/sourcecode/cem-dataset/evaluation/finetune.py > $log_dir/randominitfreezeencode1.14
echo "finetune finished"

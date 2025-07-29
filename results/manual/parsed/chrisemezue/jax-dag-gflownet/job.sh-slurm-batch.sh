#!/bin/bash
#SBATCH --job-name=gsl_big
#SBATCH --output=/home/mila/c/chris.emezue/gflownet_sl/slurmoutput_2.txt
#SBATCH --error=/home/mila/c/chris.emezue/gflownet_sl/slurmerror_2.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:rtx8000:1
#SBATCH --mem=180G
#SBATCH --time=3-00:00:00
#SBATCH --partition=long

export WANDB_API_KEY='831cb57f73367e89b34e0e6cfdb9e2d143987fcd'

source /home/mila/c/chris.emezue/gsl-env/bin/activate
module load python/3.7
module load cuda/11.1/cudnn/8.0
module load pytorch/1.8.1
export WANDB_API_KEY=831cb57f73367e89b34e0e6cfdb9e2d143987fcd
python main.py \
--graph erdos_renyi_lingauss \
--num_variables 20 \
--num_samples 100 \
--num_edges 40 \
--n_step 1 \
--batch_size 256 \
--lr 1e-6

#!/bin/bash
#SBATCH --job-name=OptionPricing
#SBATCH --mail-user=dz4@princeton.edu
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=4G
#SBATCH --time=00:30:00

module load anaconda3
conda activate tf-gpu
srun python main.py --problem_name=PricingOptionOneFactor

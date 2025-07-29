#!/bin/bash
#SBATCH --job-name=$name
#SBATCH --account=EvolvingAI
#SBATCH --output=${name}.log
#SBATCH --error=${name}.err
#SBATCH --mail-user=mnorouzz@uwyo.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:2
#SBATCH --mem=124360
#SBATCH --time=6-23:00:00

srun --export=ALL python run.py --run_data datasets/SS --base_model triplet_resnet50_1499.tar --strategy ${strategy}

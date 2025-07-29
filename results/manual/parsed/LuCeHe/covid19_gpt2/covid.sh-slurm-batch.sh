#!/bin/bash
#SBATCH --account=def-jrouat
#SBATCH --mail-user=luca.celotti@usherbrooke.ca
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:p100:1
#SBATCH --mem=32G
#SBATCH --time=2-00:00:00

module load python/3.6
source ~/projects/def-jrouat/lucacehe/denv2/bin/activate
cd ~/projects/def-jrouat/lucacehe/work/covid19_gpt2
python main.py

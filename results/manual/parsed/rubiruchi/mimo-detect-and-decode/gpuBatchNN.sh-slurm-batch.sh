#!/bin/bash
#SBATCH --job-name=Polar
#SBATCH --output=polar.%j.out
#SBATCH --error=polar.%j.err
#SBATCH --mail-user=$USER@stanford.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=8G
#SBATCH --time=2-00:00:00
#SBATCH --qos=gpu

echo "Start test"
module load matlab 
matlab -nodesktop -r "run('NeuralPolarDecode.m'); exit(0);"
echo "End test"

#!/bin/bash
#SBATCH --output=/om/user/katiemc/complex_priors_logs/outputs/chairs_%A_%a.out
#SBATCH --error=/om/user/katiemc/complex_priors_logs/outputs/chairs_%A_%a.err
#SBATCH --mail-user=katiemc@mit.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:titan-x:1
#SBATCH --mem=128G
#SBATCH --time=2-00:00:00

module load openmind/anaconda/3-2019.10; module load openmind/cuda/9.1;
source activate mesh_funcspace;
python /om/user/katiemc/occupancy_networks/train.py /om/user/katiemc/occupancy_networks/configs/unconditional/sample_complexity/double_chair.yaml

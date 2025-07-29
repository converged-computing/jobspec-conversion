#!/bin/bash
#SBATCH --job-name=train
#SBATCH --account=r00066
#SBATCH --mail-user=xxx
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=300G
#SBATCH --time=2-00:00:00
#SBATCH --partition=gpu
#SBATCH --constraint=ntasks-per-node=10

module load cudatoolkit/10.2
module load anaconda/python3.8/2020.07
source activate round10
python -u generate_attack.py \
-dataset ml-1m \
-att_type DQN \
-pop upper \
-ratio 1 \
-unroll 0 \
-tag None

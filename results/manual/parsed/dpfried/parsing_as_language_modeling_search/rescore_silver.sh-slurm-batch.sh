#!/bin/bash
#SBATCH --job-name=test
#SBATCH --account=fc_bnlp
#SBATCH --mail-user=dfried@berkeley.edu
#SBATCH --mail-type=all
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:1
#SBATCH --time=1-00:00:00
#SBATCH --partition=savio2_gpu

export MODULEPATH='$MODULEPATH:/global/home/groups/fc_bnlp/software/modfiles'

export MODULEPATH=$MODULEPATH:/global/home/groups/fc_bnlp/software/modfiles
module load tensorflow/unstable
candidate_file=$1
output_file=${candidate_file}.lstm-silver-scores
python3 rescore.py \
  semi/train_02-21.txt.traversed \
  models/semi/model \
  $candidate_file \
  $output_file

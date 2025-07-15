#!/bin/bash
#FLUX: --job-name=test
#FLUX: -c=2
#FLUX: --queue=savio2_gpu
#FLUX: -t=86400
#FLUX: --priority=16

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

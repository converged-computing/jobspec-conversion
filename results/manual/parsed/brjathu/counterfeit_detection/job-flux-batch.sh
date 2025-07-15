#!/bin/bash
#FLUX: --job-name=en_cs
#FLUX: -c=4
#FLUX: -t=86100
#FLUX: --priority=16

module load tensorflow/1.3.0-py36-gpu
module load python/3.6.13
module load cuda cudnn/v8
module load opencv/2.4.13
(( n = SLURM_ARRAY_TASK_ID ))
(( end = n * 100))
(( start = end - 100))
python ./encoding_cont_sty.py $start $end

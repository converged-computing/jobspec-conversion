#!/bin/bash
#FLUX: --job-name=ACL
#FLUX: -c=12
#FLUX: --queue=gpusmall
#FLUX: -t=129600
#FLUX: --urgency=16

module load pytorch/1.11
echo $SLURM_ARRAY_TASK_ID
python main_train.py -p config/params_unsupervised_cl.yaml #&> logs/output_unsup.out

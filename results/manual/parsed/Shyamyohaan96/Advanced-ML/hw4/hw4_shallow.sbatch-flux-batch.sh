#!/bin/bash
#FLUX: --job-name=rnn_cnn_proteins_deep
#FLUX: -c=10
#FLUX: --queue=normal
#FLUX: -t=86400
#FLUX: --priority=16

. /home/fagg/tf_setup.sh
conda activate tf
python hw6_shyam.py @deep.txt @exp_1.txt --name 'deep' --rotation $SLURM_ARRAY_TASK_ID

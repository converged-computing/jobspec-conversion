#!/bin/bash
#FLUX: --job-name=brain_machine_interface
#FLUX: -c=4
#FLUX: --queue=normal
#FLUX: -t=3600
#FLUX: --urgency=16

. /home/fagg/tf_setup.sh
conda activate tf
python hw1_shyam.py --epochs 1000 --exp_index $SLURM_ARRAY_TASK_ID

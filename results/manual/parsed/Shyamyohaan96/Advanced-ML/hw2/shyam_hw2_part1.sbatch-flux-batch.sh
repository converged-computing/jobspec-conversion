#!/bin/bash
#FLUX: --job-name=image_classification
#FLUX: -c=10
#FLUX: --queue=normal
#FLUX: -t=43200
#FLUX: --urgency=16

. /home/fagg/tf_setup.sh
conda activate tf
python hw3_shyam.py @deep.txt @exp.txt --rotation $SLURM_ARRAY_TASK_ID

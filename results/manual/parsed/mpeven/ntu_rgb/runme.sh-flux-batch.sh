#!/bin/bash
#FLUX: --job-name=ImageExtractor
#FLUX: --queue=shared
#FLUX: -t=36000
#FLUX: --priority=16

source activate activity_recognition
python /home-3/mpeven1\@jhu.edu/work/dev_mp/ntu_rgb/save_images.py $SLURM_ARRAY_TASK_ID
echo "Finished with job $SLURM_JOBID"

#!/bin/bash
#FLUX: --job-name=boopy-nalgas-4183
#FLUX: -c=16
#FLUX: -t=14400
#FLUX: --priority=16

module load OpenCV/2.4.9-intel-2015a
module load ObsPy/0.10.3rc1-intel-2015a-Python-2.7.9
module load joblib/0.8.4-intel-2015a-Python-2.7.9
srun python2.7 LFE_brightness_search.py --splits 13 --instance $SLURM_ARRAY_TASK_ID --old-nodes

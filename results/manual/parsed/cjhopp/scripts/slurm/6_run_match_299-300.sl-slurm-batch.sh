#!/bin/bash
#FLUX: --job-name=CJH_Match_Test
#FLUX: -c=12
#FLUX: -t=10800
#FLUX: --urgency=16

module load OpenCV/2.4.9-intel-2015a
module load ObsPy/0.10.3rc1-intel-2015a-Python-2.7.9
module load joblib/0.8.4-intel-2015a-Python-2.7.9
srun python2.7 /projects/nesi00228/scripts/6_PAN_match_filt_299-300.py --splits 3 --instance $SLURM_ARRAY_TASK_ID

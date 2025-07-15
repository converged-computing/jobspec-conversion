#!/bin/bash
#FLUX: --job-name=dinosaur-diablo-0543
#FLUX: -t=7200
#FLUX: --urgency=16

module load OpenCV/2.4.9-intel-2015a
module load ObsPy/0.10.3rc1-intel-2015a-Python-2.7.9
module load joblib/0.8.4-intel-2015a-Python-2.7.9
srun python2.7 /projects/nesi00228/scripts/cat2hypDD_PAN.py --splits 302 --instance $SLURM_ARRAY_TASK_ID

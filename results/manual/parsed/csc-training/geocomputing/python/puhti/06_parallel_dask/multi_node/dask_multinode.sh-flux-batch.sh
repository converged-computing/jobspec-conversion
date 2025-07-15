#!/bin/bash
#FLUX: --job-name=purple-noodle-5696
#FLUX: --queue=test
#FLUX: -t=600
#FLUX: --urgency=16

module load geoconda
datadir=/appl/data/geo/sentinel/s2_example_data/L2A
srun python dask_multinode2.py $datadir $SLURM_JOB_ACCOUNT

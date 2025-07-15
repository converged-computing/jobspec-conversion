#!/bin/bash
#FLUX: --job-name=Daskexample
#FLUX: -c=3
#FLUX: --queue=test
#FLUX: -t=300
#FLUX: --urgency=16

module load geoconda
datadir=/appl/data/geo/sentinel/s2_example_data/L2A
srun python dask_singlenode.py $datadir

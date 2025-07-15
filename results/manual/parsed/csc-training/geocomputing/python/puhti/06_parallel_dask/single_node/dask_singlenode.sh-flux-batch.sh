#!/bin/bash
#FLUX: --job-name=placid-sundae-9546
#FLUX: -c=3
#FLUX: --queue=test
#FLUX: -t=300
#FLUX: --urgency=16

module load geoconda
datadir=/appl/data/geo/sentinel/s2_example_data/L2A
srun python dask_singlenode.py $datadir

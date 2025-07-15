#!/bin/bash
#FLUX: --job-name=DaskTest
#FLUX: -c=3
#FLUX: --queue=test
#FLUX: -t=300
#FLUX: --priority=16

module load geoconda
srun python dask_example.py /appl/data/geo/sentinel/s2_example_data/L2A

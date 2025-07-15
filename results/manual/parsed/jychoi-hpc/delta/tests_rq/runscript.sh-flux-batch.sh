#!/bin/bash
#FLUX: --job-name=loopy-buttface-4545
#FLUX: -t=600
#FLUX: --urgency=16

cd /global/homes/r/rkube/repos/delta/rq_tests
conda activate delta
srun /global/homes/r/rkube/.conda/envs/delta/bin/rq worker high default low -u redis://cori02

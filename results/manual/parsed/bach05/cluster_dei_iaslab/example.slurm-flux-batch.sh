#!/bin/bash
#FLUX: --job-name=red-pastry-0555
#FLUX: --urgency=16

cd $WORKING_DIR
srun singularity exec --bind /nfsd/iaslab4/Users/rossi/example_code_repo:/mnt --nv /nfsd/iaslab4/Users/rossi/example_code_repo/example.sif python3 /mnt/example_train.py

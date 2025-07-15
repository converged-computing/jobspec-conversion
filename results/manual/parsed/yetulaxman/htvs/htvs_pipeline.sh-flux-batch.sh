#!/bin/bash
#FLUX: --job-name=crunchy-hobbit-1886
#FLUX: -n=10
#FLUX: -c=2
#FLUX: --queue=small
#FLUX: -t=610
#FLUX: --urgency=16

module load maestro parallel  # load module
find $PWD/data_SMILES  -name '*.smi' | \
parallel -j 10 bash ${SLURM_SUBMIT_DIR}/wrapper_ligprep_pipeline.sh {}

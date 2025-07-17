#!/bin/bash
#FLUX: --job-name=adorable-bike-9147
#FLUX: -n=10
#FLUX: --queue=small
#FLUX: -t=4210
#FLUX: --urgency=16

module load maestro parallel
find $PWD/data_SMILES  -name '*.smi' | \
parallel -j 10 bash ${SLURM_SUBMIT_DIR}/wrapper_ligprep_pipeline_Ligprep.sh {} 

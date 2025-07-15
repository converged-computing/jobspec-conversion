#!/bin/bash
#FLUX: --job-name=astute-cherry-7926
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
module load miniconda2/4.6.14
source activate /work_ifs/sukmb447/apps/conda.envs/r.betamgwas
outputfolder=${SLURM_SUBMIT_DIR}"/results"
Rscript test.R $SLURM_ARRAY_TASK_ID $outputfolder

#!/bin/bash
#FLUX: --job-name=NextflowWithSlurm
#FLUX: -t=432000
#FLUX: --urgency=16

module load anaconda3
module load singularityce
source activate /data/tfang/conda-envs/nf-training
cd /home/tfang/PPI_Prediction_byCoevolution/scripts
pwd
echo $CONDA_DEFAULT_ENV
nextflow run Query_coevolutionComputation_workflow.nf --root_folder "/shares/von-mering.imls.uzh/tao" -c nextflow.config -profile slurm_withSingularity  -resume

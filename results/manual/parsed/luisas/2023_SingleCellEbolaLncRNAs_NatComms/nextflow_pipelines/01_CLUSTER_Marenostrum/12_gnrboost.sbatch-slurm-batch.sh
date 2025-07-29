#!/bin/bash
#FLUX: --job-name=NextflowQAPipeline
#FLUX: -c=48
#FLUX: --urgency=16

module load java/8u131
module load intel/2017.1
module load R/3.6.1
module load singularity
CONTAINER=/gpfs/projects/bsc83/utils/containers/singularity/aertslab-pyscenic-0.10.0.sif
SCRIPT="/gpfs/projects/bsc83/Projects/Ebola/code/ebola/nextflow_pipelines/scripts/SC/grnboost2.py"
srun singularity exec ${CONTAINER} python3 ${SCRIPT} "/gpfs/projects/bsc83/Data/Ebola/02_scRNA-Seq_PBMCs/01_scRNA-Seq_inVivo_rhemac10/05_RObjects/09_graph/matrix_monocytes_de.csv" "/gpfs/projects/bsc83/Data/Ebola/02_scRNA-Seq_PBMCs/01_scRNA-Seq_inVivo_rhemac10/05_RObjects/09_graph/output_monocytes_de.tsv"

#!/bin/bash
#FLUX: --job-name="MetaAnalysis"
#FLUX: -t=172800
#FLUX: --priority=16

module load java-1.8.0_40
module load singularity/3.5.3
module load squashfs/4.4
nextflow_path=[folder where Nextflow executable is]
mastertable=[path to mastertable]
mapper_folder=[path to the folder with all mapper files]
output_folder=[path to the folder where output files are written]
NXF_VER=20.10.6 ${nextflow_path}/nextflow run HaseMetaAnalysis.nf \
--mastertable ${mastertable} \
--mapperpath ${mapper_folder} \
--covariates /gpfs/space/GI/eQTLGen/EstBB_testing/MetaAnalysis/helpfiles2/covariate_indices.txt \
--chunks 100 \
--outdir ${output_folder} \
-resume \
-profile slurm,singularity

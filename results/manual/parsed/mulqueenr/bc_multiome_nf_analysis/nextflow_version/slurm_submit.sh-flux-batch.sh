#!/bin/bash
#FLUX: --job-name=strawberry-destiny-5215
#FLUX: -c=40
#FLUX: --queue=exacloud
#FLUX: -t=129600
#FLUX: --urgency=16

module load singularity/3.8.0 #load singularity
module load nextflow/21.10.1 #load nextflow
proj_dir="/home/groups/CEDAR/mulqueen/bc_multiome"
bed="/home/groups/CEDAR/mulqueen/bc_multiome/merged.nf.bed"
nextflow run \
bc_multiome_nf_analysis/nextflow_version/bc_multiome.nf.groovy \
--merged_bed ${proj_dir}/merged.nf.bed \
--outdir ${proj_dir}/nf_analysis_round3 \
--sample_dir ${proj_dir}/cellranger_data/third_round \
-resume

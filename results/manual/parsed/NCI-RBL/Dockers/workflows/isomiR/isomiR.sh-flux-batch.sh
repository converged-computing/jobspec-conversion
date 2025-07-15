#!/bin/bash
#FLUX: --job-name=isomiR
#FLUX: -n=8
#FLUX: -c=8
#FLUX: -t=43200
#FLUX: --priority=16

set -eu
project_name=$1
Arguments=$2
procdir=./
timestamp=$(date +%Y%m%d_%H%M)
project=""$procdir""$timestamp"_isomiR_"$project_name""
mkdir $project
mkdir ${project}/ready_files
mkdir ${project}/analysis_files
mkdir ${project}/analysis_results
mkdir  ${project}/logs
printf "\ttotal\trRNA\ttRNA\tsnoRNA\tmiRNA\tmRNA\tothers_ref\tmycoplasma_H\tunmappable\thc_miRNA\n" > ${project}/analysis_results/small_RNA_profile.txt
module load nextflow
module load singularity
nextflow run isomiR.nf -c nextflow.config \
                       --outdir ${project}/ ${Arguments} \
                       -with-report ${project}/Report.html \
                       -with-dag ${project}/Flowchart.html \
                       -with-timeline ${project}/Timeline.html

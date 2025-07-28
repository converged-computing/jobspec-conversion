#!/bin/bash
#FLUX: --job-name=workflow_submission
#FLUX: --queue=exacloud
#FLUX: -t=126000
#FLUX: --urgency=16

num_active_jobs=$1
raw_data_path=$2
index_files=$3
module load /etc/modulefiles/singularity/current
snakemake -j $num_active_jobs --use-singularity --singularity-args "--bind ../Bulk-RNA-seq-pipeline-PE:/Bulk-RNA-seq-pipeline-PE,$raw_data_path,$index_files" --use-conda --profile slurm_singularity --cluster-config cluster.yaml
exit

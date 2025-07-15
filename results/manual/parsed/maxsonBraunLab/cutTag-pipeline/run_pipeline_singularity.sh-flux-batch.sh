#!/bin/bash
#FLUX: --job-name=run_pipeline
#FLUX: --queue=exacloud
#FLUX: -t=86400
#FLUX: --priority=16

indices_folder="/home/groups/MaxsonLab/indices"
fastq_folder="/home/groups/MaxsonLab/nguythai/projects/pipeline_maintenance/cutTag-pipeline-singularity/.test/downsampled_fastqs"
num_jobs=100
module load /etc/modulefiles/singularity/current
snakemake -j $num_jobs \
--verbose \
--use-singularity \
--singularity-args "--bind $indices_folder,$fastq_folder" \
--profile slurm_singularity \
--cluster-config cluster.yaml
exit

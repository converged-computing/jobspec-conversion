#!/bin/bash
#SBATCH --job-name=NFmaster
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=5g
#SBATCH --time=20-00:00:00

reads=$1
output=$2
module load NextFlow/19.10.0
nextflow \
-c ~/CODE/core/workflows/metagenomics/humann2_nextflow.config \
run ~/CODE/core/workflows/metagenomics/humann2_functional.nf \
-with-trace \
-with-timeline nf_metatest_timeline.htm \
-with-report nf_metatest_report.htm \
--reads ${reads} \
--output_dir ${output} \
-resume

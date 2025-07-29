#!/bin/bash
#SBATCH --job-name=NFmaster
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=5g
#SBATCH --time=5-00:00:00

reads=$1
reference=$2
output=$3
structure1=$4
structure2=$5
module load NextFlow/19.10.0
nextflow \
-c ~/CODE/core/workflows/umi/umi_nextflow.config \
run ~/CODE/core/workflows/umi/umi_preprocess.nf \
-with-trace \
-with-timeline nf_umi-consensus_timeline.htm \
-with-report nf_umi-consensus_report.htm \
--reads $reads \
--reference $reference \
--output_dir $output \
--read_structure1 $structure1 \
--read_structure2 $structure2

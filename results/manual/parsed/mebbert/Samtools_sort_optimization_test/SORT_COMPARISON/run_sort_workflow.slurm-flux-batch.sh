#!/bin/bash
#FLUX: --job-name=NF_Parent_Sort
#FLUX: --queue=normal
#FLUX: -t=260100
#FLUX: --urgency=16

export NXF_WORK='/mnt/gpfs3_amd/condo/mteb223/mteb223/Samtools_sort_optimization_test/SORT_COMPARISON/work'

export NXF_WORK=/mnt/gpfs3_amd/condo/mteb223/mteb223/Samtools_sort_optimization_test/SORT_COMPARISON/work
module load ccs/java/jdk1.8.0_202
nextflow run SORT_COMPARISON.nf \
	-with-report all_three-report-queue_size_30.html \
	-with-trace all_three-trace-queue_size_30.txt \
	-with-timeline

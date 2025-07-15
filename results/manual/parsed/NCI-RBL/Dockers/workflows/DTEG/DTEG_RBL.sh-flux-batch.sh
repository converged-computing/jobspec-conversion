#!/bin/bash
#FLUX: --job-name=DTEG
#FLUX: -n=8
#FLUX: -c=8
#FLUX: -t=172800
#FLUX: --priority=16

module load nextflow
module load singularity
nextflow run -c nextflow.config test.nf --SampleInfo sample_info.txt --Process AlignRNA
nextflow run -c nextflow.config test.nf --SampleInfo sample_info.txt --Process RunRiboSeq
nextflow run -c nextflow.config test.nf --SampleInfo sample_info.txt --Process RunHTseq
nextflow run -c nextflow.config test.nf --SampleInfo sample_info.txt --Process MergeCounts
nextflow run -c nextflow.config test.nf --SampleInfo sample_info.txt --Process DTEG

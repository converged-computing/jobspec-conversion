#!/bin/bash
#SBATCH --job-name=demux
#SBATCH --output=3_5_rerun_mixed_mkfastq.log
#SBATCH --mail-user=miles-smith@omrf.org
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=128
#SBATCH --partition=serial

unset _JAVA_OPTIONS
nextflow main.nf -profile slurm \
    --project /s/guth-aci/novaseq/controls \
    --raw_fastqs /s/guth-aci/novaseq/controls/fastqs \
    --with-dag flowchart.pdf \
    --with-report narch_advanta.html \
    -resume

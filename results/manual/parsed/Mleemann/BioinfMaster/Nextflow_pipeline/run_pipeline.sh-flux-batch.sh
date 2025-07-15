#!/bin/bash
#FLUX: --job-name=test_AMRtcp
#FLUX: --priority=16

ml load Java/13.0.2
NF_DIR="/scicore/home/egliadr/leeman0000/tools"
MAIN_DIR="/scicore/home/egliadr/leeman0000/github/AMRtcp"
$NF_DIR/nextflow run $MAIN_DIR/main.nf -with-singularity -with-report -profile slurm

#!/bin/bash
#SBATCH --job-name=test_AMRtcp
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2G
#SBATCH --qos=6hours

ml load Java/13.0.2
NF_DIR="/scicore/home/egliadr/leeman0000/tools"
MAIN_DIR="/scicore/home/egliadr/leeman0000/github/AMRtcp"
$NF_DIR/nextflow run $MAIN_DIR/main.nf -with-singularity -with-report -profile slurm

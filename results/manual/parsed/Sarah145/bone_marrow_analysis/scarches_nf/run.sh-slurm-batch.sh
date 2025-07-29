#!/bin/bash
#SBATCH --job-name=nf-scarches
#SBATCH --output=/data/sennis/AML/logs/nf-scarches_test.out
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1

nextflow='/home/sennis/nextflow'
cd /data/sennis/AML/scarches_nf
module load singularity
$nextflow run main.nf -profile singularity -with-trace trace.txt -with-dag flowchart.png

#!/bin/bash
#SBATCH --output=%x-%j.out
#SBATCH --error=%x-%j.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=8-08:30:00
#SBATCH --partition=defq
#SBATCH --constraint=ntasks-per-node=1

source /conda/miniconda3/etc/profile.d/conda.sh
Nextflow=n/NextFlow/nextflow
module load singularity
$Nextflow run main.nf -profile GRCh37 -resume -with-trace -with-report -with-timeline  -with-dag flowchart.png

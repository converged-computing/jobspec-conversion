#!/bin/bash
#FLUX: --job-name=aiv_seeker
#FLUX: -c=4
#FLUX: -t=21600
#FLUX: --urgency=16

 module load nextflow/22.04.3
 nextflow run main.nf --input /scratch/djhyq557/test_aiv/AIV_seeker/demo_data/samplesheet.csv -profile singularity,slurm

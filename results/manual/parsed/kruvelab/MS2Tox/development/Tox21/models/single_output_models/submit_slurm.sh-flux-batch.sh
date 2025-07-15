#!/bin/bash
#FLUX: --job-name="Tox21_models"
#FLUX: --queue=amd
#FLUX: -t=432000
#FLUX: --priority=16

module load any/jdk/1.8.0_265
module load nextflow
module load any/singularity/3.5.3
module load squashfs/4.4
nextflow run main.nf

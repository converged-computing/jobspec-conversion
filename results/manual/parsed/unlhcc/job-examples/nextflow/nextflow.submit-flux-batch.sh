#!/bin/bash
#FLUX: --job-name=nextflow
#FLUX: --queue=batch
#FLUX: -t=3600
#FLUX: --urgency=16

module purge
module load nextflow
nextflow run hello.nf -c config 

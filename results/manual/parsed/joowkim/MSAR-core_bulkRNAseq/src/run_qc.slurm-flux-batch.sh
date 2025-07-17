#!/bin/bash
#FLUX: --job-name=QCing
#FLUX: --queue=defq
#FLUX: -t=43200
#FLUX: --urgency=16

module load nextflow/22.04.3
module load singularity/3.8.0
nextflow run qc.nf -c ./conf/run.config -resume -profile slurm
module unload nextflow/22.04.3
module unload singularity/3.8.0

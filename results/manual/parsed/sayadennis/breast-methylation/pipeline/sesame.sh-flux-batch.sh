#!/bin/bash
#FLUX: --job-name=nfsesame
#FLUX: --priority=16

module purge all
module load nextflow/23.04.3
cd ~/breast-methylation/pipeline/
nextflow run -c ./sesame.nextflow.config -cache false -work-dir "/projects/p30791/methylation/nf_workdir" sesame.nf

#!/bin/bash
#FLUX: --job-name=angry-itch-3032
#FLUX: --priority=16

module load apptainer
module load nextflow/23.10.1
nextflow run . -c configs/ceres/ceres.cfg -resume

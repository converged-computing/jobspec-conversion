#!/bin/bash
#FLUX: --job-name=red-train-2846
#FLUX: -n=2
#FLUX: --queue=long
#FLUX: --urgency=16

module load apptainer
module load nextflow/23.10.1
nextflow run . -c configs/ceres/ceres.cfg -resume

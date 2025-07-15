#!/bin/bash
#FLUX: --job-name=stanky-poodle-5170
#FLUX: --urgency=16

module load apptainer
module load nextflow/23.10.1
nextflow run . -c configs/ceres/ceres.cfg -resume

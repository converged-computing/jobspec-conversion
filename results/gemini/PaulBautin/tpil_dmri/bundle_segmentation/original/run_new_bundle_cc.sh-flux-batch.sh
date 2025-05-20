#!/bin/bash

# FLUX: -N 1
# FLUX: -n 1
# FLUX: -c 32
# FLUX: --exclusive
# FLUX: -t 6:00:00

# This would run the TPIL Bundle Segmentation Pipeline with the following resources:
#     Prebuild Singularity images: https://scil.usherbrooke.ca/pages/containers/
#     Brainnetome atlas in MNI space: https://atlas.brainnetome.org/download.html
#     FA template in MNI space: https://brain.labsolver.org/hcp_template.html

# Note on mail notifications:
# The original Slurm script used --mail-user and --mail-type options.
# Flux typically handles job notifications via `flux job attach <jobid> --events=...` 
# or system-level configurations, rather than direct script directives like #FLUX: --mail-user.

module load StdEnv/2020 java/14.0.2 nextflow/22.04.3 singularity/3.8

my_singularity_img='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_scil/containers/scilus_1.3.0.sif' # or .sif
my_main_nf='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_tpil/tpil_dmri/bundle_segmentation/original/main.nf'
my_input='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_tpil/data/22-10-26_bundle_segmentation/'
my_atlas='/home/pabaua/projects/def-pascalt-ab/pabaua/dev
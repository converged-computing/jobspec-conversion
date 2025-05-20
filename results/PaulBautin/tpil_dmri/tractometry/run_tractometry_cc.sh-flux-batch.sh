#!/bin/bash

# Flux directives
# Request 1 node
#FLUX: -N 1
# Request 32 cores in total for the job (to be allocated on the single node)
#FLUX: -n 32
# Request 3 hours of walltime
#FLUX: -t 3:00:00
# Note: Slurm's --mem=0 (all memory on node) is implicitly handled by node/core allocation in Flux.
#       Flux does not have a direct equivalent for --mem=0. The job will have access to the
#       memory available on the allocated node resources.
# Note: Slurm's --mail-user and --mail-type options do not have direct equivalents in Flux
#       job submission directives. Mail notifications would need to be handled differently
#       if required (e.g., scripting within the job or via external monitoring).

# Load required software modules
module load StdEnv/2020 java/14.0.2 nextflow/22.04.3 singularity/3.8

# Define paths
my_singularity_img='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_scil/containers/scilus_1.4.2.sif' # or .sif
my_main_nf='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_tpil/tpil_dmri/tractometry/main.nf'
my_input='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_tpil/data/23-02-13_tractometry_clbp/'

# Execute the Nextflow pipeline
nextflow run $my_main_nf --input $my_input --nb_points 20 \
    -with-singularity $my_singularity_img -resume --use_provided_centroids false
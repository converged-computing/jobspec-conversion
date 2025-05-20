#!/bin/bash

# Flux directives to request resources
# Request 1 node
#FLUX: -N 1
# Request 1 task (the script itself)
#FLUX: -n 1
# Request 32 cores for the task
#FLUX: -c 32
# Set walltime to 2 hours
#FLUX: -t 2h

# Optional: Set a job name
#FLUX: --job-name=tpil_nextflow_pipeline
# Optional: Specify output and error files, %j will be replaced by the job ID
#FLUX: --output=tpil_nextflow_%j.out
#FLUX: --error=tpil_nextflow_%j.err

# Load necessary software modules
module load StdEnv/2020 java/14.0.2 nextflow/22.04.3 singularity/3.8

# Define variables for paths
# Path to your Singularity image
my_singularity_img='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_scil/containers/scilus_1.4.2.sif' # or .img
# Path to your main Nextflow pipeline script
my_main_nf='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_tpil/tpil_dmri/preparation_connectflow/registration/main.nf'
# Path to your input data directory
my_input='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_tpil/data/22-11-14_connectflow_prep_control/'
# Path to your atlas file
my_atlas='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_tpil/data/22-11-14_connectflow_prep_clbp/BNA-maxprob-thr0-1mm.nii.gz'
# Path to your template file
my_template='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_tpil/data/22-11-14_connectflow_prep_clbp/FSL_HCP1065_FA_1mm.nii.gz'

# Execute the Nextflow pipeline
# The Nextflow process will utilize the 32 cores allocated on the node.
# Memory available will be that of the entire node.
echo "Starting Nextflow pipeline..."
echo "Singularity image: $my_singularity_img"
echo "Main Nextflow script: $my_main_nf"
echo "Input directory: $my_input"
echo "Atlas: $my_atlas"
echo "Template: $my_template"

nextflow run $my_main_nf --input $my_input --atlas $my_atlas \
    -with-singularity $my_singularity_img --template $my_template -resume

echo "Nextflow pipeline finished."
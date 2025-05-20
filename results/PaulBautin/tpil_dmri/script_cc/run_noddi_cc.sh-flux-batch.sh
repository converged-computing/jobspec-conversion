#!/bin/bash

# Flux directives to request resources
#FLUX: -N 1                   # Number of nodes
#FLUX: -n 1                   # Number of tasks (Nextflow itself is the main task)
#FLUX: -c 32                  # Cores per task (for the Nextflow task)
#FLUX: --mem=250G             # Total memory for the job
#FLUX: -t 48h                 # Walltime (48 hours)
#FLUX: --exclusive            # Request exclusive access to the allocated node(s)

# Note: Mail notification options like SBATCH --mail-user and --mail-type
# do not have direct equivalents in Flux batch directives.
# Notifications in Flux are typically handled via `flux job attach` or site-specific configurations.

# Load required software modules
module load StdEnv/2020 java/14.0.2 nextflow/22.10.8 apptainer/1.1.8

# Define environment variables for paths
my_singularity_img='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_scil/containers/scilus_1.6.0.sif' # or .img
my_input='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_tpil/data/24-04-30_fw_noddi/'
my_main_nf_noddi='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_scil/noddi_flow/main.nf'

# Execute the Nextflow pipeline
# The Nextflow pipeline will run within the resources allocated by Flux.
# Nextflow itself will manage parallel execution of its processes using the 32 cores and 250G memory.
nextflow run $my_main_nf_noddi --input $my_input \
    -with-singularity $my_singularity_img -resume -with-report report.html
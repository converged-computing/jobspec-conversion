#!/bin/bash

# Flux directives translated from Slurm:
# Original: #SBATCH --nodes=1
#flux: -N 1

# Original: #SBATCH --cpus-per-task=32
# This requests 32 cores for the job on the allocated node.
# Assuming a single task model for the overall Nextflow execution.
#flux: -c 32

# Original: #SBATCH --mem=0 (all memory of the node)
# In Flux, requesting -N 1 often implies exclusive node access,
# thereby granting access to all node memory. If more specific memory
# control is needed beyond node exclusivity, explicit memory requests
# (e.g., --setopt=mem=XGB) would be required, but "all" is not a direct option.
# We rely on -N 1 providing effective access to all node memory.

# Original: #SBATCH --time=24:00:00
#flux: -t 24h

# Note: Slurm mail notification options (--mail-user, --mail-type)
# do not have direct equivalents as #flux directives.
# Job monitoring and notifications in Flux are typically handled using
# `flux job list`, `flux job info <id>`, `flux job attach --events <event_name> <id>`,
# or through external scripting based on job completion status.

# Load required software modules
module load StdEnv/2020 java/14.0.2 nextflow/21.10.3 apptainer/1.1.8

# Define paths and variables
my_singularity_img='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_scil/containers/scilus_1.5.0.sif' # or .img
my_main_nf='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_scil/connectoflow/main.nf'
my_input='/home/pabaua/scratch/tpil_dev/results/clbp/23-08-15_connectivity_prep/results'
my_template='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_scil/atlas/mni_masked.nii.gz'
my_labels_list='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_tpil/atlas_brainnetome_first_label_list.txt'

# Execute the Nextflow pipeline
# NXF_DEFAULT_DSL=1 is set in the environment for the nextflow command
NXF_DEFAULT_DSL=1 nextflow run $my_main_nf --input $my_input --labels_list $my_labels_list --template $my_template \
    --apply_t1_labels_transfo false -with-singularity $my_singularity_img -resume
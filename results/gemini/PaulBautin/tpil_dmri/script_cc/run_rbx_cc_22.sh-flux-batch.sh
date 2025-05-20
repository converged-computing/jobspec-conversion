#!/bin/bash

# This script runs RecobundleX using a Nextflow pipeline.
# Original DOI for population average atlas: 10.5281/zenodo.5165374

# Flux resource requests:
#FLUX: -N 1                     # Request 1 node
#FLUX: --exclusive              # Request exclusive access to the node (implies all its memory)
#FLUX: -n 1                     # Run 1 task for the entire job
#FLUX: -c 32                    # Allocate 32 cores for that task
#FLUX: -t 24h                   # Set walltime to 24 hours
#FLUX: --output=nextflow_rbx.out # Standard output file
#FLUX: --error=nextflow_rbx.err  # Standard error file

# Note: Flux does not have direct equivalents for Slurm's --mail-user and --mail-type.
# If email notifications are required, they need to be scripted manually, for example:
# mail -s "Job $FLUX_JOB_ID Started" your_email@example.com < /dev/null
# (at the beginning of the script)
# And a similar command at the end or upon failure.

echo "Flux job started on $(hostname) at $(date)"
echo "Flux Job ID: $FLUX_JOB_ID"
echo "Working directory: $(pwd)"

echo "Loading required software modules..."
module load StdEnv/2020 java/14.0.2 nextflow/22.04.3 apptainer/1.1
if [ $? -ne 0 ]; then
  echo "Error: Failed to load one or more modules. Exiting."
  exit 1
fi
echo "Modules loaded successfully."

# Ensure the correct version of the Nextflow pipeline code is used
RBX_FLOW_DIR="/home/pabaua/projects/def-pascalt-ab/pabaua/dev_scil/rbx_flow"
RBX_FLOW_VERSION="1.2.0"
echo "Checking out rbx_flow version ${RBX_FLOW_VERSION} from ${RBX_FLOW_DIR}..."
git -C "${RBX_FLOW_DIR}" checkout "${RBX_FLOW_VERSION}"
if [ $? -ne 0 ]; then
  echo "Error: git checkout of rbx_flow version ${RBX_FLOW_VERSION} failed. Exiting."
  exit 1
fi
echo "Git checkout successful."

# Define paths for the Nextflow pipeline
# These paths are specific to the user and system.
# Ensure they are correct for the execution environment.
my_singularity_img='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_scil/containers/scilus_1.5.0.sif'
my_main_nf="${RBX_FLOW_DIR}/main.nf" # Use variable for consistency
my_input='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_tpil/data/23-09-08_rbx_con'
my_atlas_config='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_scil/atlas_v22/config/config_ind.json'
my_atlas_anat='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_scil/atlas_v22/atlas/mni_masked.nii.gz'
my_atlas_dir='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_scil/atlas_v22/atlas/atlas'
my_atlas_centroids='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_scil/atlas_v22/atlas/centroids'

echo "Starting Nextflow pipeline: ${my_main_nf}"
echo "Input data: ${my_input}"
echo "Singularity/Apptainer image: ${my_singularity_img}"

# Set Nextflow environment variable and run the pipeline
export NXF_DEFAULT_DSL=1 # Ensures DSL1 is used if not specified in nextflow.config

nextflow run "${my_main_nf}" \
    --input "${my_input}" \
    -with-singularity "${my_singularity_img}" \
    -resume \
    --atlas_config "${my_atlas_config}" \
    --atlas_anat "${my_atlas_anat}" \
    --atlas_directory "${my_atlas_dir}" \
    --atlas_centroids "${my_atlas_centroids}" \
    -profile large_dataset

NEXTFLOW_EXIT_CODE=$?

if [ $NEXTFLOW_EXIT_CODE -eq 0 ]; then
  echo "Nextflow pipeline completed successfully."
else
  echo "Nextflow pipeline failed with exit code: $NEXTFLOW_EXIT_CODE."
fi

echo "Flux job ended at $(date)"

exit $NEXTFLOW_EXIT_CODE
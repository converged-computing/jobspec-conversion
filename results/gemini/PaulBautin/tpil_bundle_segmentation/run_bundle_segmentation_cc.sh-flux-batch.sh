#!/bin/bash

# Flux job options equivalent to the original Slurm script:
# Request 1 node
#FLUX: -N 1
# Request 1 task for the job (Slurm defaults to 1 task if --nodes=1 and --ntasks not set)
#FLUX: -n 1
# Request 32 cores for that task (from Slurm's --cpus-per-task=32)
#FLUX: -c 32
# Request exclusive access to the node, implying all its memory (from Slurm's --mem=0)
#FLUX: --exclusive
# Set walltime to 6 hours (from Slurm's --time=6:00:00)
#FLUX: -t 6h00m00s

# Original script purpose:
# This script runs the TPIL Bundle Segmentation Pipeline followed by a QC pipeline.
# It utilizes Singularity containers and Nextflow.

# Note: Slurm mail options (--mail-user, --mail-type) do not have direct equivalents
# in Flux job directives. Email notifications would typically be handled by
# user-level scripting (e.g., using `flux job wait id && mailx -s "Job Done" user@example.com < job.out`).

echo "Loading initial software modules..."
module load StdEnv/2020 java/14.0.2 nextflow/22.04.3 singularity/3.8
echo "Modules loaded: StdEnv/2020 java/14.0.2 nextflow/22.04.3 singularity/3.8"

# Define paths for the first Nextflow pipeline (TPIL Bundle Segmentation)
my_singularity_img='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_scil/containers/scilus_1.4.2.sif' # or .sif
my_main_nf='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_tpil/tpil_bundle_segmentation/main.nf'
my_input='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_tpil/data/23-02-13_bundle_segmentation_control/'
my_atlas='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_scil/atlas/BNA-maxprob-thr0-1mm.nii.gz'
my_template='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_scil/atlas/FSL_HCP1065_FA_1mm.nii.gz'

echo "Starting first Nextflow pipeline: TPIL Bundle Segmentation"
echo "Command: nextflow run $my_main_nf --input $my_input --atlas $my_atlas -with-singularity $my_singularity_img --template $my_template -resume"
nextflow run $my_main_nf --input $my_input --atlas $my_atlas \
    -with-singularity $my_singularity_img --template $my_template -resume
echo "First Nextflow pipeline (TPIL Bundle Segmentation) finished with exit code $?."

# Load a different Nextflow version for the QC pipeline
echo "Loading Nextflow version for QC pipeline..."
module load nextflow/21.10.3
echo "Module loaded: nextflow/21.10.3"

# Define paths for the second Nextflow pipeline (dmriqc_flow)
my_main_nf_qc='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_scil/dmriqc_flow/main.nf'
my_input_qc='/home/pabaua/scratch/tpil_dev/results/clbp/23-02-13_accumbofrontal_segmentation/results_bundle'

echo "Starting second Nextflow pipeline: dmriqc_flow"
echo "Command: NXF_VER=21.10.3 nextflow run $my_main_nf_qc -profile rbx_qc --input $my_input_qc -with-singularity $my_singularity_img -resume"
NXF_VER=21.10.3 nextflow run $my_main_nf_qc -profile rbx_qc --input $my_input_qc \
    -with-singularity $my_singularity_img -resume
echo "Second Nextflow pipeline (dmriqc_flow) finished with exit code $?."

echo "All tasks complete."
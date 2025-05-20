#!/bin/bash

# Flux resource requests
# FLUX: -N 1
# FLUX: -n 1
# FLUX: -c 32
# FLUX: -t 1h
# FLUX: --output=nextflow_job_%j.out
# FLUX: --error=nextflow_job_%j.err

# Original Slurm script comments related to Tractoflow:
# This would run Tractoflow with the following parameters:
#   - bids: clinical data from TPIL lab (27 CLBP and 25 control subjects), if not in BIDS format use flag --input
#   - with-singularity: container image scilus v1.3.0 (runs: dmriqc_flow, tractoflow, recobundleX, tractometry)
#   - with-report: outputs a processing report when pipeline is finished running
#   - Dti_shells 0 and 1000 (usually <1200), Fodf_shells 0 1000 and 2000 (usually >700, multishell CSD-ms).
#   - profile: bundling, bundling profile will set the seeding strategy to WM as opposed to interface seeding that is usually used for connectomics

# Notes on resource translation from Slurm to Flux:
# Slurm: --nodes=1              -> Flux: -N 1 (1 node)
# Slurm: --cpus-per-task=32     -> Flux: -n 1 -c 32 (1 task, 32 cores for that task. Total 32 cores for the job)
# Slurm: --mem=0                -> Flux: Implicitly all memory on the allocated node.
#                                  Flux does not have a direct "--mem=0" equivalent.
#                                  Requesting -N 1 and -c 32 typically grants access
#                                  to the node's full memory for the job.
# Slurm: --time=1:00:00         -> Flux: -t 1h (1 hour walltime)

# Slurm mail notifications (--mail-user, --mail-type) are not directly supported by Flux batch directives.
# This functionality would typically be handled by user-level scripting wrapping `flux submit`
# or by system-specific notification configurations if available.

echo "Flux Job ID: $FLUX_JOB_ID"
echo "Running on host(s): $(hostname)" # Will show the primary host if -N 1
echo "Job started at: $(date)"
echo "Allocated total cores by Flux: ${FLUX_JOB_NCORES:-N/A}" # Should be 32

# Load necessary software modules
module load StdEnv/2020 java/14.0.2 nextflow/21.10.3 singularity/3.8

# Define paths for the Nextflow pipeline
my_singularity_img='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_scil/containers/scilus_1.3.0.sif' # or .img
my_main_nf='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_scil/dmriqc_flow/main.nf'
my_input='/home/pabaua/scratch/tpil_dev/results/clbp/22-11-25_bundle_seg/results_bundle/'

echo "Starting Nextflow pipeline: $my_main_nf"
echo "Input directory: $my_input"
echo "Singularity image: $my_singularity_img"

# Execute the Nextflow pipeline
nextflow run $my_main_nf -profile rbx_qc --input $my_input \
    -with-singularity $my_singularity_img -resume

echo "Nextflow pipeline finished at: $(date)"
echo "Job completed."
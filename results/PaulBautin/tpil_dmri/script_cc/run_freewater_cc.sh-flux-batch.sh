#!/bin/bash

# Flux directives translated from SBATCH
#FLUX: -N 1                            # Request 1 node
#FLUX: -n 1                            # Run 1 task total in the allocation
#FLUX: -c 32                           # Request 32 cores for this task
                                       # This setup implies the task gets all 32 cores on the node.
                                       # Flux will allocate memory proportional to cores. If this node
                                       # type has 32 cores, this effectively grants all node memory,
                                       # similar to Slurm's --mem=0.
#FLUX: -t 48:00:00                     # Walltime of 48 hours
#FLUX: --output=freewater_flow_job.%J.out # Standard output file, %J is job ID
#FLUX: --error=freewater_flow_job.%J.err  # Standard error file, %J is job ID
#FLUX: --job-name=freewater_flow       # Optional: Job name for easier identification

# Original Slurm mail notifications are not directly translatable to Flux batch directives.
# Mail notifications in Flux are typically handled via 'flux job attach --events'
# or other site-specific mechanisms post-submission.
# Original Slurm directives:
# #SBATCH --mail-user=paul.bautin@polymtl.ca
# #SBATCH --mail-type=BEGIN
# #SBATCH --mail-type=END
# #SBATCH --mail-type=FAIL
# #SBATCH --mail-type=REQUEUE
# #SBATCH --mail-type=ALL

# Original script comments providing context:
# This would run Freewater_Flow with the following parameters:
#   - bids: clinical data from TPIL lab (27 CLBP and 25 control subjects), if not in BIDS format use flag --input
#   - with-singularity: container image scilus v1.3.0 (runs: dmriqc_flow, tractoflow, recobundleX, tractometry)
#   - with-report: outputs a processing report when pipeline is finished running
#   - Dti_shells 0 and 300 (usually <700), Fodf_shells 0 and 2000 (usually >1200).
#   - profile: bundling, bundling profile will set the seeding strategy to WM as opposed to interface seeding that is usually used for connectomics

# Original comments regarding node selection on the Slurm cluster (Beluga):
# --nodes=1              # --> Generally depends on your nb of subjects.
                               # See the comment for the cpus-per-task. One general rule could be
                               # that if you have more subjects than cores/cpus (ex, if you process 38
                               # subjects on 32 cpus-per-task), you could ask for one more node.
# --cpus-per-task=32     # --> You can see here the choices. For beluga, you can choose 32, 40 or 64.
                               # https://docs.computecanada.ca/wiki/B%C3%A9luga/en#Node_Characteristics
# --mem=0                # --> 0 means you take all the memory of the node. If you think you will need
                               # all the node, you can keep 0.

# Load necessary software modules
module load StdEnv/2020 java/14.0.2 nextflow/22.10.8 apptainer/1.1.8

# Define paths for Nextflow execution
my_singularity_img='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_scil/containers/scilus_1.6.0.sif' # or .img
my_main_nf='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_scil/freewater_flow/main.nf'
my_input='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_tpil/data/24-04-30_fw_noddi/'

# Execute the Nextflow pipeline
echo "Starting Nextflow pipeline..."
echo "Main Nextflow script: $my_main_nf"
echo "Input data: $my_input"
echo "Singularity image: $my_singularity_img"

nextflow run $my_main_nf --input $my_input \
    -with-singularity $my_singularity_img -resume -with-report report.html

echo "Nextflow pipeline finished."
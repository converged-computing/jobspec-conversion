#!/bin/bash

# Flux directives
#FLUX: -N 1
#FLUX: -n 1
#FLUX: -c 32
#FLUX: -t 1h
#FLUX: --output=tractoflow_job_%j.out
#FLUX: --error=tractoflow_job_%j.err
#
# Notes on translation from Slurm:
# - Mail notifications (--mail-user, --mail-type) are not directly supported by Flux batch directives.
#   Consider alternative notification mechanisms if required.
# - Slurm's --mem=0 (all memory on the node) is not directly translated.
#   This script requests 1 node and 32 cores for the main task. Memory allocation
#   will follow Flux's policy. If all memory of a potentially larger node is strictly
#   required while limiting Nextflow to 32 cores, this might behave differently than Slurm.
#   Alternatively, using --exclusive would grant all node resources, and Nextflow
#   would adapt to the available cores on the allocated node.

# Original Slurm comments:
# This would run Tractoflow with the following parameters:
#   - Dti_shells 0, 300 and 1000, Fodf_shells 0, 2000, 3000.
#   - profile bundling => WM seeding

# Original Slurm resource requests for reference:
# #SBATCH --nodes=1              # --> Generally depends on your nb of subjects.
                               # See the comment for the cpus-per-task. One general rule could be
                               # that if you have more subjects than cores/cpus (ex, if you process 38
                               # subjects on 32 cpus-per-task), you could ask for one more node.
# #SBATCH --cpus-per-task=32     # --> You can see here the choices. For beluga, you can choose 32, 40 or 64.
                               # https://docs.computecanada.ca/wiki/B%C3%A9luga/en#Node_Characteristics
# #SBATCH --mem=0                # --> 0 means you take all the memory of the node. If you think you will need
                               # all the node, you can keep 0.
# #SBATCH --time=1:00:00

# #SBATCH --mail-user=paul.bautin@polymtl.ca
# #SBATCH --mail-type=BEGIN
# #SBATCH --mail-type=END
# #SBATCH --mail-type=FAIL
# #SBATCH --mail-type=REQUEUE
# #SBATCH --mail-type=ALL

echo "Flux Job ID: $FLUX_JOB_ID"
echo "Job started on $(hostname) at $(date)"
echo "Resources allocated by Flux:"
flux resource list -v
echo "---------------------------"

# Load necessary modules
module load StdEnv/2020 java/14.0.2 nextflow/21.10.3 singularity/3.8

# Define variables for the Nextflow execution
my_singularity_img='/home/pabaua/scratch/scil_dev/containers/scilus_1.3.0.sif' # or .img
my_main_nf='/home/pabaua/scratch/scil_dev/dmriqc_flow/main.nf'
my
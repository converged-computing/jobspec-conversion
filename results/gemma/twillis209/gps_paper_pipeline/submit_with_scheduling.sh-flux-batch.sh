# Flux batch script

# Job name
export FLUX_JOB_NAME="gps_paper_pipeline_scheduler"

# Account
export FLUX_ACCOUNT="MRC-BSU-SL2-CPU"

# Resource requests
export FLUX_NODES=1
export FLUX_CPUS_PER_NODE=4
export FLUX_WALLTIME="6:00:00"

# Email notification on failure
export FLUX_MAIL_TYPE="FAIL"

# Partition/Queue (translate cclake to a suitable Flux partition)
export FLUX_PARTITION="default"  # Replace "default" with the appropriate partition

# Output directory
export FLUX_OUTPUT_DIR="logs/gps_paper_pipeline_scheduler"

# Create output directory if it doesn't exist
mkdir -p $FLUX_OUTPUT_DIR

# Environment setup
. /etc/profile.d/modules.sh
module purge
module load rhel7/default-peta4

# Set OMP_NUM_THREADS
export OMP_NUM_THREADS=5

# Conda environment activation
__conda_setup="$('/rds/project/rds-csoP2nj6Y6Y/tw395/mambaforge/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/rds/project/rds-csoP2nj6Y6Y/tw395/mambaforge/etc/profile.d/conda.sh" ]; then
        . "/rds/project/rds-csoP2nj6Y6Y/tw395/mambaforge/etc/profile.d/conda.sh"
    else
        export PATH="/rds/project/rds-csoP2nj6Y6Y/tw395/mambaforge/bin:$PATH"
    fi
fi
unset __conda_setup

unset R_LIBS

conda activate snakemake_env

# Application command
snakemake --profile profile "${@}"
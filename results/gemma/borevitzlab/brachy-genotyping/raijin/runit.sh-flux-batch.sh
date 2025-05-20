# Flux batch script equivalent

# Resources requested
# Flux uses a single resource string.  We'll approximate the PBS requests.
# Note: Flux doesn't have direct equivalents for all PBS options (e.g., 'other').
#       We'll focus on the core requests.
# Flux doesn't have a direct equivalent to PBS's 'wd' (working directory).
# Flux automatically sets the working directory to the submission directory.

# Flux resource string.  This requests 1 node with 28 cores and 800GB of memory.
# The 'gdata1' PBS option is not directly translatable to Flux.  It likely
# refers to a specific storage location.  This would need to be handled
# outside of the batch script (e.g., by mounting the filesystem).
# Flux doesn't have a direct equivalent to PBS's 'P' (project) or 'q' (queue).
# These are typically handled by the system administrator.

export FLUX_RESOURCES="ncpus=28 mem=800G"

# Email notification (Flux doesn't have built-in email, use system tools)
# This would require external scripting or system configuration.
# For example, you could add a script to send an email after job completion.

# Load modules (assuming raijin/modules.sh sets up the environment)
. raijin/modules.sh

# Create log directory
mkdir -p data/log

# Run the application
snakemake --unlock \
    -j ${FLUX_NCPUS} \
    --rerun-incomplete \
    --keep-going \
    ${target:-all} \
    |& tee data/log/snakemake.log
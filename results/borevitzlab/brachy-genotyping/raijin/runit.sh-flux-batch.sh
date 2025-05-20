#!/bin/bash
#FLUX: -N 1
#FLUX: -n 1
#FLUX: -c 28
#FLUX: --mem=800G
#FLUX: -t 24h
#FLUX: -q hugemem
#FLUX: --constraint=gdata1

# Note on project/account:
# The original PBS script used project xe2 (#PBS -P xe2).
# In Flux, project/account information is typically set at submission time, for example:
# flux submit --job-name=<your_job_name> --setattr=system.bank=xe2 your_script.sh
# Alternatively, some Flux configurations might support an in-script directive like:
# #FLUX: --account=xe2
# Please check your local Flux system documentation for the correct method.

# Note on mail notifications:
# The original PBS script requested mail notifications (#PBS -m abe -M kevin.murray@anu.edu.au).
# Flux typically handles mail notifications via the `flux job attach` command or through
# site-specific configurations, rather than in-script directives. For example:
# flux job attach --mail-to=kevin.murray@anu.edu.au --events=start,error,finish <jobid>

# The PBS -l wd option (use current working directory) is the default behavior in Flux,
# so no specific directive is needed for this.

# Original environment setup from PBS script:
# This line is specific to the "raijin" system mentioned in the original script.
# If you are running this on a different system, this line may need to be
# adjusted or replaced with appropriate `module load` commands for snakemake
# and its dependencies.
. raijin/modules.sh

# Create log directory
mkdir -p data/log

# Unlock snakemake directory if necessary
snakemake --unlock

# Run snakemake
# ${FLUX_JOB_NCORES} provides the total number of cores allocated to the job,
# similar to ${PBS_NCPUS} in the original script.
snakemake                         \
    -j ${FLUX_JOB_NCORES}         \
    --rerun-incomplete            \
    --keep-going                  \
    ${target:-all}                \
    |& tee data/log/snakemake.log
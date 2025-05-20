#!/bin/bash

# Flux Directives
#FLUX: --job-name=scansnv_main_job
#FLUX: --nodes=1
#FLUX: --tasks=1
#FLUX: --cpus-per-task=1
#FLUX: --requires=mem=4000M  # Request 4000MB of memory for the task
#FLUX: --time=120:00:00      # Walltime limit of 120 hours
#FLUX: --queue=priopark      # Submit to the 'priopark' queue (if it exists in Flux)

# --- Accounting Information ---
# The original Slurm script used '#SBATCH -A park_contrib'.
# In Flux, accounting is typically handled through user/group configurations,
# project associations (e.g., via `flux job attach project <name>`), or site-specific
# mechanisms. It is not usually set with a #FLUX directive in the script.
# Consult your system's Flux documentation for how accounting is managed.

# --- Application Execution ---
# The following command executes the 'scansnv' application.

# --- IMPORTANT NOTE ON SUB-JOBS (--drmaa argument) ---
# The '--drmaa' argument passed to 'scansnv' below contains Slurm-specific options:
#   '-p park -A park_contrib --mem={resources.mem} -t 8:00:00 -o %logdir/slurm-%A.log'
# If 'scansnv' (which might use Snakemake or a similar workflow tool) submits
# sub-jobs via DRMAA, these sub-jobs will attempt to use Slurm with these options.
# This will likely FAIL or behave unexpectedly if the main job is running under Flux
# and Slurm is not accessible or configured for submissions from within Flux jobs.
#
# For the sub-jobs to be managed by Flux, 'scansnv' would need to:
# 1. Support a Flux DRMAA backend.
# 2. Be configured with Flux-specific options in the --drmaa argument string.
#    For example (this is hypothetical, actual syntax depends on the DRMAA implementation):
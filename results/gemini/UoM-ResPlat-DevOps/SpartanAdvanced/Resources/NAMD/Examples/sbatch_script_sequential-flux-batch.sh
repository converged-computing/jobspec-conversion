#!/bin/bash
#FLUX: -N 64
#FLUX: --ntasks=256
#FLUX: -t 96:00:00
#FLUX: --job-name=namd_A2_aspirin_ion_256_run1
# Note: Account VR0030 needs to be handled by site policy or flux submit options if available.
#       Flux typically uses projects associated with users/groups.
#
#FLUX: --output=JobLog/flux_%J.out
#FLUX: --error=JobLog/flux_%J.err

### - job basename (used for NAMD output files) ---------------
jobname="_A2_aspirin_ion_256_run1_"
### --------------------------------------------------------------

# Create directories if they don't exist (original script assumes they do)
mkdir -p JobLog OutputText Errors OutputFiles RestartFiles

current_date=$(date +%F)
datetime_stamp=$(date +%F-%H.%M)

# Log Flux job information
flux job info $FLUX_JOB_ID > JobLog/${datetime_stamp}${jobname}.flux_job_info.txt

### --------------------------------------------------------------------------
## Optimize the original molecule
echo "Starting NAMD optimization step at $(date)"
# The original mpirun command: mpirun -mode VN -np 256 -exe /usr/local/namd/2.7-xl-dcmf/bin/namd2 -args aspirin_opt.conf
# Translated to flux run:
flux run -n 256 --exclusive \
    /usr/local/
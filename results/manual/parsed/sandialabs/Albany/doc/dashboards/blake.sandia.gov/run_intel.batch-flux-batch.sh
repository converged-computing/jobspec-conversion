#!/bin/bash
#FLUX: --job-name=creamy-bicycle-0378
#FLUX: -t=28800
#FLUX: --urgency=16

if [ X"$SLURM_STEP_ID" = "X" -a X"$SLURM_PROCID" = "X"0 ]
then
  echo "print SLURM_JOB_ID = $SLURM_JOB_ID"
fi 
cd /home/projects/albany/nightlyCDashTrilinosBlake
source blake_intel_modules.sh >& intel_modules.out
bash nightly_cron_script_trilinos_blake_intel_release.sh
cd /home/projects/albany/nightlyCDashAlbanyBlake
bash nightly_cron_script_albany_blake_intel_release.sh

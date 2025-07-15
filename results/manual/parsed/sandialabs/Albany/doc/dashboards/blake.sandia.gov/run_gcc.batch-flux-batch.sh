#!/bin/bash
#FLUX: --job-name=buttery-kitty-3837
#FLUX: -t=28800
#FLUX: --urgency=16

if [ X"$SLURM_STEP_ID" = "X" -a X"$SLURM_PROCID" = "X"0 ]
then
  echo "print SLURM_JOB_ID = $SLURM_JOB_ID"
fi 
cd /home/projects/albany/nightlyCDashTrilinosBlake
source blake_gcc_modules.sh >& gcc_modules.out
bash nightly_cron_script_trilinos_blake_gcc_release.sh
bash nightly_cron_script_trilinos_blake_gcc_debug.sh
cd /home/projects/albany/nightlyCDashAlbanyBlake
bash nightly_cron_script_albany_blake_gcc_release.sh
bash nightly_cron_script_albany_blake_gcc_debug.sh
bash nightly_cron_script_albany_blake_gcc_sfad.sh sfad6
bash nightly_cron_script_albany_blake_gcc_sfad.sh sfad12
bash nightly_cron_script_albany_blake_gcc_sfad.sh sfad24
bash nightly_cron_script_mali_blake_gcc_release.sh

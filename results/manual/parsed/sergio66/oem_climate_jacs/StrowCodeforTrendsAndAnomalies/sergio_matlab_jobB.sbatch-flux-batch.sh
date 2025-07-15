#!/bin/bash
#FLUX: --job-name=RUN_CRIS_ANOM
#FLUX: --queue=batch
#FLUX: -t=900
#FLUX: --priority=16

if [ $# -gt 0 ]; then
  echo "Your command line contains $# arguments"
elif [ $# -eq 0 ]; then
  echo "Your command line contains no arguments"
fi
if [[ "$1" -eq "" ]]; then
  echo "cmd line arg = DNE, generic run"
  matlab -nodisplay -r "clust_make_spectralrates_sergio_cris; exit"
else
  echo "cmd line arg = DoesExist, use it"
  matlab -nodisplay -r "iCmdLineOption = $1; clust_make_spectralrates_sergio_cris; exit"
fi

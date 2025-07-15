#!/bin/bash
#FLUX: --job-name=synchrony
#FLUX: -c=64
#FLUX: --queue=xnat
#FLUX: -t=172800
#FLUX: --urgency=16

export PYTHONPATH='$PYTHONPATH:/hpc/users/$USER/sw/github/ECoG'

config=""
while [ $# -gt 0 ]; do
  case "$1" in
    --config=*)
      config="${1#*=}"
      ;;
    *)
      printf "***************************\n"
      printf "* Error: Invalid argument: ${1}*\n"
      printf "***************************\n"
      exit 1
  esac
  shift
  echo ${participant_id}
  echo ${config}
done
cd /hpc/users/$USER/sw/github/ECoG
module purge; module load Anaconda3/2020.11; source /hpc/shared/EasyBuild/apps/Anaconda3/2020.11/bin/activate; 
conda activate /hpc/users/$USER/.conda/envs/cogitate_ecog
export PYTHONPATH=$PYTHONPATH:/hpc/users/$USER/sw/github/ECoG
python synchrony/synchrony_master.py --config "${config}"

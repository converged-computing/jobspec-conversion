#!/bin/bash
#FLUX: --job-name=duration_tracking
#FLUX: -c=64
#FLUX: --queue=octopus
#FLUX: -t=720000
#FLUX: --priority=16

export PYTHONPATH='$PYTHONPATH:/hpc/users/alexander.lepauvre/sw/github/ECoG'

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
cd /hpc/users/alexander.lepauvre/sw/github/ECoG
module purge; module load Anaconda3/2020.11; source /hpc/shared/EasyBuild/apps/Anaconda3/2020.11/bin/activate; conda activate /hpc/users/$USER/.conda/envs/mne_ecog02
export PYTHONPATH=$PYTHONPATH:/hpc/users/alexander.lepauvre/sw/github/ECoG
python ./Experiment1ActivationAnalysis/duration_tracking_master.py --config "${config}"

#!/bin/bash
#FLUX: --job-name=decoding
#FLUX: -c=64
#FLUX: --queue=xnat
#FLUX: -t=86400
#FLUX: --priority=16

export PYTHONPATH='$PYTHONPATH:/home/simon.henin/sw/ECoG'

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
cd /home/simon.henin/sw/ECoG
module purge; module load Anaconda3/2020.11; source /hpc/shared/EasyBuild/apps/Anaconda3/2020.11/bin/activate; conda activate cogitate_ecog
export PYTHONPATH=$PYTHONPATH:/home/simon.henin/sw/ECoG
python decoding/decoding_robustness_test.py --config "${config}"

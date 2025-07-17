#!/bin/bash
#FLUX: --job-name=eccentric-nalgas-7040
#FLUX: -c=16
#FLUX: --urgency=16

scratch_dir=/data1/slurm/$SLURM_JOB_ID
hpvm_image=$HOME/hpvm.sb
script=$HOME/hpvm-tuning-android/tune_x.py
cd $HOME/hpvm-tuning-android
singularity exec --nv --writable-tmpfs $hpvm_image python -u tune_x.py -D $(mktemp -ud) "$@"

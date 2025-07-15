#!/bin/bash
#FLUX: --job-name=COMP_trial_4
#FLUX: --queue=thsu
#FLUX: -t=604800
#FLUX: --priority=16

. /work/thsu/rschanta/RTS/functions/utility/bash-utils.sh
vpkg_require matlab
args="'/lustre/scratch/rschanta/','trial_4'"
run_compress_out $args
rm -rf "/lustre/scratch/rschanta/trial_4/outputs-proc/"
rm -rf "/lustre/scratch/rschanta/trial_4/outputs-raw/"

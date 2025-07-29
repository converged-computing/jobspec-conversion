#!/bin/bash
#FLUX: --job-name=GEN_make_FW2
#FLUX: --queue=thsu
#FLUX: -t=604800
#FLUX: --urgency=16

. /work/thsu/rschanta/RTS/functions/utility/bash-utils.sh
vpkg_require matlab
run_MATLAB_script "make_FW2.m"

#!/bin/bash
#FLUX: --job-name=NewTitle
#FLUX: --queue=thsu
#FLUX: -t=604800
#FLUX: --urgency=16

. /opt/shared/slurm/templates/libexec/openmpi.sh
. /work/thsu/rschanta/RTS/functions/utility/bash-utils.sh
vpkg_require openmpi
vpkg_require matlab
	run_MATLAB_script "make_FW2.m"

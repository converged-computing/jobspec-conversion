#!/bin/bash
#FLUX: --job-name=GEN_model_run_4
#FLUX: --queue=standard
#FLUX: -t=604800
#FLUX: --priority=16

. "/work/thsu/rschanta/RTS/functions/bash-utility/slurm-bash.sh"
. "/work/thsu/rschanta/RTS/functions/bash-utility/matlab-bash.sh"
. "/work/thsu/rschanta/RTS/functions/bash-utility/misc-bash.sh"
	vpkg_require matlab
	run_MATLAB_script "./model_run_4/model_run_4.m" "/work/thsu/rschanta/RTS/functions"

#!/bin/bash
#FLUX: --job-name=GEN_model_run_5
#FLUX: --queue=standard
#FLUX: -t=604800
#FLUX: --priority=16

	## Load in bash functions and VALET packages
		. "/work/thsu/rschanta/RTS/functions/bash-utility/get_bash.sh"
		vpkg_require matlab
	## Run Generation Script
		run_MATLAB_script "./model_run_5/model_run_5.m" "/work/thsu/rschanta/RTS/functions"

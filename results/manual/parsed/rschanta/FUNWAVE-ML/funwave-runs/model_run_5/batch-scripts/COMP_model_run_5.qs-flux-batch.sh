#!/bin/bash
#FLUX: --job-name=COMP_model_run_5
#FLUX: --queue=standard
#FLUX: -t=604800
#FLUX: --priority=16

		## Load in bash functions and VALET packages
			. "/work/thsu/rschanta/RTS/functions/bash-utility/get_bash.sh"
			vpkg_require matlab
		## Compress skew and asymmetry
			run_compress_ska /lustre/scratch/rschanta/ model_run_5 /work/thsu/rschanta/RTS/functions

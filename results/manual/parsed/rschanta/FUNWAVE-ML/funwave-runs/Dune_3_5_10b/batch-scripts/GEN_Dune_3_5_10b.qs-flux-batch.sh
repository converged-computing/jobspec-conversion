#!/bin/bash
#FLUX: --job-name=GEN_Dune_3_5_10b
#FLUX: --queue=standard
#FLUX: -t=604800
#FLUX: --urgency=16

. "/work/thsu/rschanta/RTS/functions/bash-utility/slurm-bash.sh"
. "/work/thsu/rschanta/RTS/functions/bash-utility/matlab-bash.sh"
. "/work/thsu/rschanta/RTS/functions/bash-utility/misc-bash.sh"
	vpkg_require matlab
	run_MATLAB_script "./Dune_3_5_10b/Dune_3_5_10b.m" "/work/thsu/rschanta/RTS/functions"

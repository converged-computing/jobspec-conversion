#!/bin/bash
#FLUX: --job-name=COMP_Dune_3_5_10b
#FLUX: --queue=standard
#FLUX: -t=604800
#FLUX: --urgency=16

. "/work/thsu/rschanta/RTS/functions/bash-utility/slurm-bash.sh"
. "/work/thsu/rschanta/RTS/functions/bash-utility/matlab-bash.sh"
. "/work/thsu/rschanta/RTS/functions/bash-utility/misc-bash.sh"
	vpkg_require matlab
	run_compress_out /lustre/scratch/rschanta/ Dune_3_5_10b /work/thsu/rschanta/RTS/
	#rm -rf "/lustre/scratch/rschanta/Dune_3_5_10b/outputs-proc/"
	rm -rf "/lustre/scratch/rschanta/Dune_3_5_10b/outputs-raw/"

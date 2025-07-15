#!/bin/bash
#FLUX: --job-name=COMP_Dune_3_5_10
#FLUX: --queue=thsu
#FLUX: -t=604800
#FLUX: --priority=16

. "/work/thsu/rschanta/RTS/functions/bash-utility/slurm-bash.sh"
. "/work/thsu/rschanta/RTS/functions/bash-utility/matlab-bash.sh"
. "/work/thsu/rschanta/RTS/functions/bash-utility/misc-bash.sh"
	vpkg_require matlab
	run_compress_out /lustre/scratch/rschanta/ Dune_3_5_10 /work/thsu/rschanta/RTS/
	#rm -rf "/lustre/scratch/rschanta/Dune_3_5_10/outputs-proc/"
	rm -rf "/lustre/scratch/rschanta/Dune_3_5_10/outputs-raw/"

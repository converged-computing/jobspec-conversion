#!/bin/bash
#FLUX: --job-name=yrv_DMR
#FLUX: --exclusive
#FLUX: --queue=compute
#FLUX: --urgency=16

module load singularity/3.7
chmod +x /vortexfs1/home/yaamini.venkataraman/06-BAT-DMRcalling.sh
echo "DMR Calling Module"
singularity exec --env-file /vortexfs1/home/yaamini.venkataraman/06-DMR-envfile.txt \
--bind /vortexfs1/home/naluru/:/naluru,/vortexfs1/scratch/yaamini.venkataraman:/scratch,/vortexfs1/home/yaamini.venkataraman/:/yaaminiv \
/vortexfs1/home/naluru/bat_latest.sif \
/yaaminiv/06-BAT-DMRcalling.sh
echo "Done with DMR calling"

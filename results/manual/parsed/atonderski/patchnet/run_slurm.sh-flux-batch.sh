#!/bin/bash
#FLUX --job-name=astute-nunchucks-6634
#FLUX -c=16
#FLUX --queue=a100
#FLUX -t=259200
#FLUX --urgency=16

singularity exec --bind /dl_workspaces/$USER:/workspace --bind /datasets:/datasets /dl_workspaces/$USER/2021-agp-spatiotemporal/singularity/pytorch21_06.sif bash -c "$@"

#!/bin/bash
#FLUX: --job-name=cowy-cattywampus-8343
#FLUX: -c=16
#FLUX: --queue=a100
#FLUX: -t=259200
#FLUX: --priority=16

singularity exec --bind /dl_workspaces/$USER:/workspace --bind /datasets:/datasets /dl_workspaces/$USER/2021-agp-spatiotemporal/singularity/pytorch21_06.sif bash -c "$@"

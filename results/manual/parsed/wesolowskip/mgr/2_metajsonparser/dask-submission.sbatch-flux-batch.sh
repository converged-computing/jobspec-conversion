#!/bin/bash
#FLUX: --job-name=milky-pot-5687
#FLUX: --queue=long
#FLUX: -t=432000
#FLUX: --urgency=16

CONTAINER="${HOME}/containers/rapids-prod.sif"
CONTAINER_RC_FILE="${HOME}/containers/singularity_rc"
SCRIPT="python -u dask_benchmark.py"
singularity run --nv -B /scratch/shared/pwesolowski,/run/udev:/run/udev:ro "$CONTAINER" /bin/bash --rcfile "$CONTAINER_RC_FILE" -ci "$SCRIPT"

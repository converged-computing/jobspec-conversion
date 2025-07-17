#!/bin/bash
#FLUX: --job-name=stanky-soup-5340
#FLUX: --queue=short
#FLUX: -t=57600
#FLUX: --urgency=16

CONTAINER="${HOME}/containers/rapids-prod.sif"
CONTAINER_RC_FILE="${HOME}/containers/singularity_rc"
SCRIPT="./run_dask.sh"
singularity run --nv -B /scratch/shared/pwesolowski,/run/udev:/run/udev:ro "$CONTAINER" /bin/bash --rcfile "$CONTAINER_RC_FILE" -ci "$SCRIPT"

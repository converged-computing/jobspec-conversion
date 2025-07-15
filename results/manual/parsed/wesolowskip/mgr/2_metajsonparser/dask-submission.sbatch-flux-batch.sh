#!/bin/bash
#FLUX: --job-name=buttery-parrot-4411
#FLUX: --queue=long
#FLUX: -t=432000
#FLUX: --priority=16

CONTAINER="${HOME}/containers/rapids-prod.sif"
CONTAINER_RC_FILE="${HOME}/containers/singularity_rc"
SCRIPT="python -u dask_benchmark.py"
singularity run --nv -B /scratch/shared/pwesolowski,/run/udev:/run/udev:ro "$CONTAINER" /bin/bash --rcfile "$CONTAINER_RC_FILE" -ci "$SCRIPT"

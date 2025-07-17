#!/bin/bash
#FLUX: --job-name=hello-punk-0525
#FLUX: -c=24
#FLUX: --queue=topola
#FLUX: --urgency=16

export LD_LIBRARY_PATH='/icm/home/bazinska/miniconda3/lib:$LD_LIBRARY_PATH'

export LD_LIBRARY_PATH="/icm/home/bazinska/miniconda3/lib:$LD_LIBRARY_PATH"
./tumor ../resources/tumors/out-vnw-tr1-st0-0a-initial.json \
../protocol_generator/data/protocol_times_${SLURM_ARRAY_TASK_ID}.csv ./results/generated/ ${SLURM_ARRAY_TASK_ID} 144000

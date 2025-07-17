#!/bin/bash
#FLUX: --job-name=fairnas
#FLUX: -c=4
#FLUX: --queue=alldlc_gpu-rtx2080
#FLUX: -t=86400
#FLUX: --urgency=16

DASK_DISTRIBUTED__WORKER__DAEMON=False dask-worker --nthreads 1 --lifetime 10000000000000000000000000 --memory-limit 0 --scheduler-file "scheduler-dpn-file.json"

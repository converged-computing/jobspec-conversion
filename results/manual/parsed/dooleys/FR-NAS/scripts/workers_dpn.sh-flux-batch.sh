#!/bin/bash
#FLUX: --job-name=outstanding-cat-2319
#FLUX: --urgency=16

DASK_DISTRIBUTED__WORKER__DAEMON=False dask-worker --nthreads 1 --lifetime 10000000000000000000000000 --memory-limit 0 --scheduler-file "scheduler-dpn-file.json"

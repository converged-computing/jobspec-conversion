#!/bin/bash
#FLUX: --job-name=carnivorous-diablo-8937
#FLUX: --priority=16

DASK_DISTRIBUTED__WORKER__DAEMON=False dask-worker --nthreads 1 --lifetime 10000000000000000000000000 --memory-limit 0 --scheduler-file "scheduler-dpn-file.json"

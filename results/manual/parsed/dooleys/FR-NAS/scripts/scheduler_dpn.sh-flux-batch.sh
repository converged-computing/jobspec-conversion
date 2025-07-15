#!/bin/bash
#FLUX: --job-name=lovely-pastry-0899
#FLUX: --urgency=16

dask-scheduler --scheduler-file  "scheduler-dpn-file.json" --idle-timeout 1000000000000000000000000 --port 1796

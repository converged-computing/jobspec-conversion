#!/bin/bash
#FLUX: --job-name=fairnas
#FLUX: --queue=mldlc_gpu-rtx2080
#FLUX: -t=518400
#FLUX: --urgency=16

dask-scheduler --scheduler-file  "scheduler-dpn-file.json" --idle-timeout 1000000000000000000000000 --port 1796

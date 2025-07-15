#!/bin/bash
#FLUX: --job-name=hello-animal-1714
#FLUX: --priority=16

dask-scheduler --scheduler-file  "scheduler-dpn-file.json" --idle-timeout 1000000000000000000000000 --port 1796

#!/bin/bash
#FLUX: --job-name=anxious-cherry-9414
#FLUX: --urgency=16

sacct --format="CPUTime,MaxRSS"
python ../fid_computation/prefid.py

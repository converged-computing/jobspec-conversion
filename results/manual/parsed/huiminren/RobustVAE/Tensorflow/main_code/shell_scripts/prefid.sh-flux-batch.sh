#!/bin/bash
#FLUX: --job-name=confused-banana-4470
#FLUX: -n=8
#FLUX: --queue=short
#FLUX: --urgency=16

sacct --format="CPUTime,MaxRSS"
python ../fid_computation/prefid.py

#!/bin/bash
#FLUX: --job-name=hanky-milkshake-6057
#FLUX: -n=8
#FLUX: --queue=short
#FLUX: --urgency=16

sacct --format="CPUTime,MaxRSS"
python ../fid_computation/prefid.py

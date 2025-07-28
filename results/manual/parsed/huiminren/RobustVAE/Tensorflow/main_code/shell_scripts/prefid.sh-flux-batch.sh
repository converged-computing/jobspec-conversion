#!/bin/bash
#FLUX: --job-name=hello-noodle-0282
#FLUX: -n=8
#FLUX: --queue=short
#FLUX: --urgency=16

sacct --format="CPUTime,MaxRSS"
python ../fid_computation/prefid.py

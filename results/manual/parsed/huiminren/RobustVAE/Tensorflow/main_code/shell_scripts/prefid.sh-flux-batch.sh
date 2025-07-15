#!/bin/bash
#FLUX: --job-name=placid-leg-2837
#FLUX: --priority=16

sacct --format="CPUTime,MaxRSS"
python ../fid_computation/prefid.py

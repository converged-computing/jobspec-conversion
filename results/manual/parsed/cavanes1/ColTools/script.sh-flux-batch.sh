#!/bin/bash
#FLUX: --job-name=LST
#FLUX: --urgency=16

set -e
date
module list
python lst.py
date
sacct --name=LST --format="JobID,JobName,Elapsed,State"

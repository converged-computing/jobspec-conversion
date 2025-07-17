#!/bin/bash
#FLUX: --job-name=LST
#FLUX: --queue=defq
#FLUX: -t=259200
#FLUX: --urgency=16

set -e
date
module list
python lst.py
date
sacct --name=LST --format="JobID,JobName,Elapsed,State"

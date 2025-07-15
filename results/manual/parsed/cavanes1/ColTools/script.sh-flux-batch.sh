#!/bin/bash
#FLUX: --job-name=LST
#FLUX: --priority=16

set -e
date
module list
python lst.py
date
sacct --name=LST --format="JobID,JobName,Elapsed,State"

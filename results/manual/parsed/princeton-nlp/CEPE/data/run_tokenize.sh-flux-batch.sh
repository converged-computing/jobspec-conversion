#!/bin/bash
#FLUX: --job-name=tokenize ## CHANGE JOBNAME HERE
#FLUX: -c=16
#FLUX: --priority=16

python tokenize_files.py

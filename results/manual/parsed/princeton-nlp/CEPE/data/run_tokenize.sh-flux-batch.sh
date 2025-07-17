#!/bin/bash
#FLUX: --job-name=tokenize
#FLUX: -c=16
#FLUX: --urgency=16

python tokenize_files.py

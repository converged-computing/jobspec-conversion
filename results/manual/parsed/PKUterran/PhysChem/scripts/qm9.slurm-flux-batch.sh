#!/bin/bash
#FLUX: --job-name=QM9
#FLUX: -c=4
#FLUX: --queue=GPU
#FLUX: -t=432000
#FLUX: --urgency=16

python qm9.py

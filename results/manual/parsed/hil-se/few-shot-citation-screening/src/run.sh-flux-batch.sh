#!/bin/bash
#FLUX: --job-name=butterscotch-muffin-5292
#FLUX: --urgency=16

mkdir -p log
spack load py-urllib3
spack load py-pandas
python3 parse.py

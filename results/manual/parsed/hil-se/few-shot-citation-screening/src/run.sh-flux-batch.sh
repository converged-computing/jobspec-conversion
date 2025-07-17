#!/bin/bash
#FLUX: --job-name=crawl_data
#FLUX: --queue=tier3
#FLUX: -t=367503
#FLUX: --urgency=16

mkdir -p log
spack load py-urllib3
spack load py-pandas
python3 parse.py

#!/bin/bash
#FLUX: --job-name=lovely-lemur-4538
#FLUX: --priority=16

mkdir -p log
spack load py-urllib3
spack load py-pandas
python3 parse.py

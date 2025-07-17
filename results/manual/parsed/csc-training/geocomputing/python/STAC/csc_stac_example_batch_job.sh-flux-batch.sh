#!/bin/bash
#FLUX: --job-name=expensive-ricecake-8906
#FLUX: -c=10
#FLUX: --queue=small
#FLUX: -t=1200
#FLUX: --urgency=16

module load geoconda
python csc_stac_example.py

#!/bin/bash
#FLUX: --job-name=data
#FLUX: --queue=standard
#FLUX: -t=432000
#FLUX: --urgency=16

python check_data.py

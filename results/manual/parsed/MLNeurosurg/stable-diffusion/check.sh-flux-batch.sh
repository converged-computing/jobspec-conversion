#!/bin/bash
#FLUX: --job-name=data
#FLUX: --queue=standard
#FLUX: -t=432000
#FLUX: --priority=16

python check_data.py

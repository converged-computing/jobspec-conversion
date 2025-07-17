#!/bin/bash
#FLUX: --job-name=zcpfJobUpdate
#FLUX: --queue=batch
#FLUX: -t=28800
#FLUX: --urgency=16

python update.py

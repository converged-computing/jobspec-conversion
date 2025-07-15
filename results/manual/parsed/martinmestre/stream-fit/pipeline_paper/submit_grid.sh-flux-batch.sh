#!/bin/bash
#FLUX: --job-name=chi2stream
#FLUX: --queue=multi
#FLUX: -t=172800
#FLUX: --urgency=16

. /etc/profile
python grid_chi2stream.py

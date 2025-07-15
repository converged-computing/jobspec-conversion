#!/bin/bash
#FLUX: --job-name=fooocus-demo
#FLUX: -c=16
#FLUX: --urgency=16

export TMPDIR='./temp'

export TMPDIR=./temp
python entry_with_update.py --listen --preset taiyi

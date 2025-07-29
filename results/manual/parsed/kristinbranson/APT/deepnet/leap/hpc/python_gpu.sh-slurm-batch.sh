#!/bin/bash
#FLUX: --job-name=placid-frito-9164
#FLUX: -c=4
#FLUX: -t=14400
#FLUX: --urgency=16

echo "args: ${@:1}"
python ${@:1}

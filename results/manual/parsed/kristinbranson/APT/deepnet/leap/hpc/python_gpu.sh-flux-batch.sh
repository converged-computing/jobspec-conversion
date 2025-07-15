#!/bin/bash
#FLUX: --job-name=doopy-taco-2794
#FLUX: -c=4
#FLUX: -t=14400
#FLUX: --urgency=16

echo "args: ${@:1}"
python ${@:1}

#!/bin/bash
#FLUX: --job-name=goodbye-mango-4430
#FLUX: -c=4
#FLUX: -t=14400
#FLUX: --priority=16

echo "args: ${@:1}"
python ${@:1}

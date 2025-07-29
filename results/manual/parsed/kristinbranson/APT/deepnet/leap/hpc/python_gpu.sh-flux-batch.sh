#!/bin/bash
#FLUX --job-name=pusheena-egg-6823
#FLUX -c=4
#FLUX -t=14400
#FLUX --urgency=16

echo "args: ${@:1}"
python ${@:1}

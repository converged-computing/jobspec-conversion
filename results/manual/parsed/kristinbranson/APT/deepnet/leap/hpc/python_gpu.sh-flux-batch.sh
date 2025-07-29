#!/bin/bash
#FLUX --job-name=creamy-despacito-1727
#FLUX -c=4
#FLUX -t=14400
#FLUX --urgency=16

echo "args: ${@:1}"
python ${@:1}

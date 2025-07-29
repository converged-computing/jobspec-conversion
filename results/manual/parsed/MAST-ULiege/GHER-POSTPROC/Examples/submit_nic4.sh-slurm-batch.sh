#!/bin/bash
#FLUX: --job-name=PyAtWork
#FLUX: --queue=defq
#FLUX: -t=18000
#FLUX: --urgency=16

source /home/ulg/mast/acapet/pyload
echo 'Running '$1
python $1

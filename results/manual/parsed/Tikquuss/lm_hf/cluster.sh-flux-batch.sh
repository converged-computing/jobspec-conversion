#!/bin/bash
#FLUX: --job-name=Grokking
#FLUX: -c=8
#FLUX: --queue=main
#FLUX: -t=172800
#FLUX: --urgency=16

module load cuda/10.1
source ../grokking/bin/activate
filename=train.sh
chmod +x $filename
. $filename

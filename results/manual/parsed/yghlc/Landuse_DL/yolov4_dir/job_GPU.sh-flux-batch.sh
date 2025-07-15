#!/bin/bash
#FLUX: --job-name=yolov4
#FLUX: -n=4
#FLUX: --queue=sgpu
#FLUX: -t=86400
#FLUX: --urgency=16

module purge
module load singularity/3.6.4
echo "== This is the scripting step! =="
./runIN_yoltv4_noconda_sing.sh
echo "== End of Job =="

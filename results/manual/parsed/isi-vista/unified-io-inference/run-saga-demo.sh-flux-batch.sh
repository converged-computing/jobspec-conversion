#!/bin/bash
#FLUX: --job-name=captioning-unified
#FLUX: --queue=gaia-lg
#FLUX: --urgency=16

export SRC='/nas/gaia02/users/napiersk/github/clean/unified-io-inference'
export INPUT_FILE='caption-part2.txt'
export HOSTPATH='/nas/gaia02/data/phase3/ta1/sample1/'

export SRC=/nas/gaia02/users/napiersk/github/clean/unified-io-inference
export INPUT_FILE=caption-part2.txt
export HOSTPATH=/nas/gaia02/data/phase3/ta1/sample1/
cd $SRC
echo $SRC
docker build -t unified-io-inference .
echo CAPTIONING-UNIFIED START ${HOSTPATH} ${INPUT_FILE}
date
docker run -t --gpus=4 -e INPUT_FILE=/image-data/${INPUT_FILE} -v ${HOSTPATH}:/image-data unified-io-inference:latest
date
echo CAPTIONING-UNIFIED DONE

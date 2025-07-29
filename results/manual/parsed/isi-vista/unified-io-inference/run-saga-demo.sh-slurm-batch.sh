#!/bin/bash
#SBATCH --job-name=captioning-unified
#SBATCH --account=gaia-lg
#SBATCH --output=captioning-unified.output.%j.txt
#SBATCH --error=captioning-unified.error.%j.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:rtxa6000:4

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

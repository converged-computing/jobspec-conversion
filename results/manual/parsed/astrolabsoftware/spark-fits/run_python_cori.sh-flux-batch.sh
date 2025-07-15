#!/bin/bash
#FLUX: --job-name=rainbow-cattywampus-9369
#FLUX: --urgency=16

module load spark
module load sbt
SCALA_VERSION=2.11.8
SCALA_VERSION_SPARK=2.11
VERSION=0.9.0
sbt ++${SCALA_VERSION} package
fitsfn="/global/cscratch1/sd/<user>/<path>"
start-all.sh
shifter spark-submit \
  --master $SPARKURL \
  --driver-memory 15g --executor-memory 50g --executor-cores 32 --total-executor-cores 192 \
  --jars target/scala-${SCALA_VERSION_SPARK}/spark-fits_${SCALA_VERSION_SPARK}-${VERSION}.jar \
  examples/python/readfits.py \
  -inputpath $fitsfn
stop-all.sh

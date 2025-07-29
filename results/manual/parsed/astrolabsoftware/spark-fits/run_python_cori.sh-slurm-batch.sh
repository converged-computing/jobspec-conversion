#!/bin/bash
#SBATCH --job-name=sparkFITS
#SBATCH --nodes=6
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --constraint=haswell

singularity
exec
nersc/spark-2.3.0:v1
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

#!/bin/bash
#SBATCH --output=mysparkjob_%j.out
#SBATCH --error=mysparkjob_%j.err
#SBATCH --nodes=46
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:08:00
#SBATCH --partition=regular
#SBATCH --qos=premium

export SPARK_LOCAL_DIRS='/tmp'
export PYTHONPATH='$PYTHONPATH:$PWD/src/main/python/h5spark'

module unload spark/hist-server
module load spark
module unload python
module load python/2.7-anaconda
module load collectl
start-collectl.sh 
start-all.sh
export SPARK_LOCAL_DIRS="/tmp"
export PYTHONPATH=$PYTHONPATH:$PWD/src/main/python/h5spark
spark-submit --verbose \
 --master $SPARKURL \
 --executor-cores 32 \
 --driver-cores 32  \
 --num-executors=45  \
 --driver-memory 100G \
 --executor-memory 105G \
 --conf spark.eventLog.enabled=true \
 --conf spark.eventLog.dir=$SCRATCH/spark/spark_event_logs \
 src/main/python/tests/single-file-test.py \ 
stop-all.sh
stop-collectl.sh

#!/bin/bash
#FLUX: --job-name=SparkMaster
#FLUX: -c=28
#FLUX: --exclusive
#FLUX: --queue=batch
#FLUX: -t=3600
#FLUX: --urgency=16

export SPARK_HOME='$EBROOTSPARK'
export MASTER='spark://$(hostname):7077'
export SPARK_WORKER_INSTANCES='3'
export CORES_PER_WORKER='1'
export TOTAL_CORES='$((${CORES_PER_WORKER}*${SPARK_WORKER_INSTANCES}))'
export TFoS_HOME='/home/users/yhoffmann/venv/tf-on-spark/lib/python3.6/site-packages/tensorflowonspark'

if [ -f  /etc/profile ]; then
       .  /etc/profile
fi
module purge
module use $HOME/.local/easybuild/modules/all
module load devel/Spark
export SPARK_HOME=$EBROOTSPARK
$SPARK_HOME/sbin/start-all.sh
export MASTER=spark://$(hostname):7077
export SPARK_WORKER_INSTANCES=3
export CORES_PER_WORKER=1
export TOTAL_CORES=$((${CORES_PER_WORKER}*${SPARK_WORKER_INSTANCES}))
export TFoS_HOME="/home/users/yhoffmann/venv/tf-on-spark/lib/python3.6/site-packages/tensorflowonspark"
${SPARK_HOME}/sbin/start-master.sh; ${SPARK_HOME}/sbin/start-slave.sh -c $CORES_PER_WORKER -m 3G $ {MASTER}
rm -rf ${TFoS_HOME}/lstm_model
rm -rf ${TFoS_HOME}/prices_export
${SPARK_HOME}/bin/spark-submit \
    --master ${MASTER} \
    --conf spark.cores.max=${TOTAL_CORES} \
    --conf spark.task.cpus=${CORES_PER_WORKER} \
    ${TFoS_HOME}/examples/prices/keras/lstm_spark.py \
    --cluster_size ${SPARK_WORKER_INSTANCES} \
    --images_labels ${TFoS_HOME}/data/prices/csv/train \
    --model_dir ${TFoS_HOME}/lstm_model \
    --export_dir ${TFoS_HOME}/prices_export
ls -lR ${TFoS_HOME}/lstm_model
ls -lR ${TFoS_HOME}/lstm_export
$SPARK_HOME/sbin/stop-all.sh

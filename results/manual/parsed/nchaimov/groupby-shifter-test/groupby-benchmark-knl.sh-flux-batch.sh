#!/bin/bash
#FLUX: --job-name=GroupByKNL
#FLUX: -N=16
#FLUX: -n=16
#FLUX: -c=32
#FLUX: --queue=debug
#FLUX: -t=1800
#FLUX: --urgency=16

export JAVA_HOME='/usr/lib/jvm/java-8-oracle'
export SPARK_HOME='/opt/spark'
export SPARK_CONF_DIR='/global/homes/n/nchaimov/groupby-shifter-test/conf-knl'
export MASTER='`hostname`'
export SPARK_WORKER_CORES='32'

ulimit -n 32768
ulimit -u 32768
export JAVA_HOME="/usr/lib/jvm/java-8-oracle"
export SPARK_HOME=/opt/spark
export SPARK_CONF_DIR="/global/homes/n/nchaimov/groupby-shifter-test/conf-knl"
export MASTER=`hostname`
NUM_NODES=16
CORES_PER_NODE=32   
export SPARK_WORKER_CORES=32
KVP_PER_PARTITION=1000
PARTITIONS_PER_CORE=4
VALUE_BYTES=8
SEED=50
TOTAL_EXECUTOR_CORES=$(( $NUM_NODES * $CORES_PER_NODE ))
NUM_PARTITIONS=$(( $TOTAL_EXECUTOR_CORES * $PARTITIONS_PER_CORE ))
echo ">>>>> Starting servers"
srun -n $NUM_NODES -N $NUM_NODES -c $CORES_PER_NODE shifter $SPARK_HOME/sbin/start-cluster.sh $MASTER &
sleep 10 # wait for master to start up
echo ">>>>> Running GroupByTest KNL"
echo ">>>>> Max nodes: $NUM_NODES Cores Per Node: $CORES_PER_NODE"
echo ">>>>> KVP Per Partition: $KVP_PER_PARTITION Partitions Per Core: $PARTITIONS_PER_CORE"
echo ">>>>> Value Bytes: $VALUE_BYTES Seed: $SEED"
CUR_NUM_NODES=1
while [ $CUR_NUM_NODES -le $NUM_NODES ] ; do
    TOTAL_EXECUTOR_CORES=$(( $CUR_NUM_NODES * $CORES_PER_NODE ))
    NUM_PARTITIONS=$(( $TOTAL_EXECUTOR_CORES * $PARTITIONS_PER_CORE ))
    echo ">>>>> Nodes: $CUR_NUM_NODES Cores: $TOTAL_EXECUTOR_CORES Partitions: $NUM_PARTITIONS"
    shifter $SPARK_HOME/bin/spark-submit --master spark://$MASTER:7077 --total-executor-cores $TOTAL_EXECUTOR_CORES --conf spark.scheduler.minRegisteredResourcesRatio=1.0 --conf spark.executor.cores=$CORES_PER_NODE $SPARK_HOME/instrumentation-benchmarks/GroupBy/target/scala-2.11/groupbytest_2.11-1.0.jar $NUM_PARTITIONS $KVP_PER_PARTITION $VALUE_BYTES $NUM_PARTITIONS $SEED
    CUR_NUM_NODES=$(( $CUR_NUM_NODES * 2 ))
    echo ">>>>> Iteration done"
done
echo ">>>>> Done"

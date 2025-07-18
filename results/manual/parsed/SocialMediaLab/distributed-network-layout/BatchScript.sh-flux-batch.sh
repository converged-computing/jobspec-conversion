#!/bin/bash
#FLUX: --job-name=DistributedLayoutAlgorithm
#FLUX: -N=20
#FLUX: -c=5
#FLUX: -t=86399
#FLUX: --urgency=16

export MKL_NUM_THREADS='1'
export SPARK_IDENT_STRING='$SLURM_JOBID'
export SPARK_WORKER_DIR='$SLURM_TMPDIR'
export PYTHONPATH='$PYTHONPATH:/cvmfs/soft.computecanada.ca/easybuild/software/2017/Core/spark/2.4.4/python/lib/py4j-0.10.7-src.zip'

cd $SLURM_SUBMIT_DIR
module load CCEnv
module load nixpkgs/16.09
module load spark/2.4.4
module load scipy-stack
module load python/3.6.3
module load networkx/1.1
export MKL_NUM_THREADS=1
export SPARK_IDENT_STRING=$SLURM_JOBID
export SPARK_WORKER_DIR=$SLURM_TMPDIR
export PYTHONPATH=$PYTHONPATH:/cvmfs/soft.computecanada.ca/easybuild/software/2017/Core/spark/2.4.4/python/lib/py4j-0.10.7-src.zip
start-master.sh
sleep 5
MASTER_URL=spark://$( scontrol show hostname $SLURM_NODELIST | head -n 1 ):7077
NWORKERS=$((SLURM_NNODES - 1))
echo "Master URL = "$MASTER_URL
echo "Number of Workers = "$NWORKERS
SPARK_NO_DAEMONIZE=1 srun -n 152 -N ${NWORKERS} -r 1 --label --output=$SPARK_LOG_DIR/spark-%j-workers.out start-slave.sh -m 16g -c 5 ${MASTER_URL} & slaves_pid=$!  
srun -n 1 -N 1 spark-submit --master ${MASTER_URL} --driver-memory 100g --conf spark.driver.memoryOvehead=50g --executor-memory 16g --conf spark.executor.memoryOverhead=4g --conf spark.memory.fraction=0.6 --conf spark.driver.maxResultSize=0 --conf spark.memory.storageFraction=0.5 --conf spark.default.parallelism=500 --conf spark.sql.shuffle.partitions=500 --conf spark.shuffle.io.maxRetries=10 --conf spark.blacklist.enabled=False  --conf spark.shuffle.io.retryWait=60s --conf spark.reducer.maxReqsInFlight=1 --conf spark.shuffle.io.backLog=4096 --conf spark.network.timeout=1200 --conf "spark.executor.extraJavaOptions=-XX:+PrintGCDetails -XX:+PrintGCTimeStamps -Xloggc:$SCRATCH/log/ -XX:+UseCompressedOops" --conf spark.serializer=org.apache.spark.serializer.KryoSerializer --conf spark.scheduler.listenerbus.eventqueue.capacity=20000 --packages graphframes:graphframes:0.8.0-spark2.4-s_2.11  --repositories https://repos.spark-packages.org [/full_path/distributedLayoutAlgorithm.py] [/full_path/graph_edgelist.tsv] [output_path] [number_of_iterations]
kill $slaves_pid
stop-master.sh

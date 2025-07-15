#!/bin/bash
#FLUX: --job-name=nerdy-arm-3183
#FLUX: -N=2
#FLUX: -n=2
#FLUX: -c=24
#FLUX: -t=18000
#FLUX: --urgency=16

export PYSPARK_PYTHON='/home/tguedon/acc_env/bin/python'
export PYTHONPATH='${PYTHONPATH}:${PWD}'
export MKL_NUM_THREADS='1'
export SPARK_IDENT_STRING='$SLURM_JOBID'
export SPARK_WORKER_DIR='$SLURM_TMPDIR'
export SLURM_SPARK_MEM='$(printf "%.0f" $((${SLURM_MEM_PER_NODE} *95/100)))'

module load python/3.7
module load spark/custom
source ~/acc_env/bin/activate
export PYSPARK_PYTHON="/home/tguedon/acc_env/bin/python"
export PYTHONPATH=${PYTHONPATH}:${PWD}
export MKL_NUM_THREADS=1
export SPARK_IDENT_STRING=$SLURM_JOBID
export SPARK_WORKER_DIR=$SLURM_TMPDIR
export SLURM_SPARK_MEM=$(printf "%.0f" $((${SLURM_MEM_PER_NODE} *95/100)))
start-master.sh
sleep 20
MASTER_URL_STRING=$(grep -Po '(?=spark://).*' $SPARK_LOG_DIR/spark-${SPARK_IDENT_STRING}-org.apache.spark.deploy.master*.out)
IFS=' '
read -ra MASTER_URL <<< "$MASTER_URL_STRING"
echo "master url :" ${MASTER_URL}
NWORKERS=$((SLURM_NTASKS - 1))
echo "----->" ${NWORKERS}
echo "----->" ${SPARK_LOG_DIR}
echo "----->" ${SLURM_CPUS_PER_TASK}
echo "----->" ${MASTER_URL}
echo "----->" ${SLURM_SPARK_MEM}
SPARK_NO_DAEMONIZE=1 srun -n ${NWORKERS} -N ${NWORKERS} --label --output=$SPARK_LOG_DIR/spark-%j-workers.out start-slave.sh -m ${SLURM_SPARK_MEM}M -c ${SLURM_CPUS_PER_TASK} ${MASTER_URL} &
slaves_pid=$!
acc=/home/tguedon/projects/def-glatard/tguedon/accident-prediction-montreal/accidents_montreal.py
road=/home/tguedon/projects/def-glatard/tguedon/accident-prediction-montreal/road_network.py
weather=/home/tguedon/projects/def-glatard/tguedon/accident-prediction-montreal/weather.py
preprocess=/home/tguedon/projects/def-glatard/tguedon/accident-prediction-montreal/preprocess.py
utils=/home/tguedon/projects/def-glatard/tguedon/accident-prediction-montreal/utils.py
random_forest=/home/tguedon/projects/def-glatard/tguedon/accident-prediction-montreal/random_forest.py
random_undersampler=/home/tguedon/projects/def-glatard/tguedon/accident-prediction-montreal/random_undersampler.py
srun -n 1 -N 1 spark-submit --master ${MASTER_URL} --executor-memory ${SLURM_SPARK_MEM}M /home/tguedon/projects/def-glatard/tguedon/accident-prediction-montreal/main_random_forest.py --py-files ${acc} ${road} ${weather} ${preprocess} ${utils} ${random_forest} ${random_undersampler}
kill $slaves_pid
stop-master.sh

#!/bin/bash
#FLUX: --job-name=spark01_single
#FLUX: -N=3
#FLUX: --exclusive
#FLUX: -t=120
#FLUX: --urgency=16

module load intel/2018.1 singularity/3.5.2
IMAGE=dcc-spark02.simg
BSC_USER=XXXXX
BSC_GROUP=YYYYY
HOME_DIR=/gpfs/projects/$BSC_GROUP/$BSC_USER/spark-test
WORK_DIR=/gpfs/scratch/$BSC_GROUP/$BSC_USER/spark-test
mkdir -p $WORK_DIR
cd $WORK_DIR
cp $HOME_DIR/mobydick.txt $WORK_DIR/
cp $HOME_DIR/example.* $WORK_DIR/
if [ ! -d $WORK_DIR/$IMAGE ]; then
    cp $HOME_DIR/$IMAGE $WORK_DIR/ ;
fi
EXPERIMENT=example.scala
SPARK_WORKER_ARGS=''    # By default '' (All resources). Set explicit values, e.g. for 16 cores & 125GB per worker: '-c 16 -m 125g'.
WORKERS_NODE=1          # By default 1 (All resources). Compose workers and resources in homogeneous nodes.
HS=`srun hostname |sort`
H_LIST=`echo ${HS} | awk '{ for (i=1; i<=NF; i+=1) print $i }'`
MASTER_OUT=spark_master_${SLURM_JOBID}
WORKER_OUT=spark_worker_${SLURM_JOBID}
REAL_WORK_DIR=$WORK_DIR
SPARK_TEMP=$TMPDIR/spark-work
mkdir -p $SPARK_TEMP
echo "Starting Master $HOSTNAME"
singularity run $IMAGE "org.apache.spark.deploy.master.Master" --host $HOSTNAME > ${MASTER_OUT}.out 2> ${MASTER_OUT}.err &
sleep 5;
for node in $H_LIST; do
        for (( i=0; i<$WORKERS_NODE; i++ )); do
                echo "Starting Worker $node (master $HOSTNAME)"
                ssh -q $node "module load intel/2018.1 SINGULARITY/3.5.2; cd ${WORK_DIR}; nohup singularity run ${IMAGE} 'org.apache.spark.deploy.worker.Worker' -d ${SPARK_TEMP} ${SPARK_WORKER_ARGS} spark://$HOSTNAME:7077 > ${WORKER_OUT}_${node}_${i}.out 2> ${WORKER_OUT}_${node}_${i}.err &";
        done;
done;
echo "Launching Application"
cd $REAL_WORK_DIR
case $( echo $EXPERIMENT | awk -F'.' '{ print tolower($NF) }' ) in
scala)
        SHELL=spark-shell
        ;;
py)
        SHELL=pyspark
        ;;
r)
        SHELL=sparkR --vanilla
        ;;
*)
        echo "Not recognized script file"
        SHELL=spark-shell
esac
singularity exec $IMAGE $SHELL --master spark://$HOSTNAME:7077 < $EXPERIMENT ;
echo "Cleaning Spark Nodes"
H_LIST_REV=`for i in $H_LIST; do echo $i; done | tac`
for node in $H_LIST_REV; do
        ssh -q $node "kill \$( ps aux | grep spark | grep -v grep | awk '{ print \$2 }' ) "
done;
mkdir -p $HOME_DIR/experiment_${SLURM_JOBID}
mv $WORK_DIR/${MASTER_OUT}* $HOME_DIR/experiment_${SLURM_JOBID}/
mv $WORK_DIR/${WORKER_OUT}* $HOME_DIR/experiment_${SLURM_JOBID}/
mv $WORK_DIR/wc-result.data $HOME_DIR/experiment_${SLURM_JOBID}/
mv $WORK_DIR/mobydick.txt $HOME_DIR/experiment_${SLURM_JOBID}/
mv $WORK_DIR/example.* $HOME_DIR/experiment_${SLURM_JOBID}/
echo "Bye!"
exit

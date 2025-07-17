#!/bin/bash
#FLUX: --job-name=quirky-ricecake-0891
#FLUX: -N=16
#FLUX: --queue=gpu
#FLUX: -t=7800
#FLUX: --urgency=16

export SPARK_HOME='/home/tahmad/tahmad/spark-3.0.0-bin-hadoop2.7'
export MASTER='$MASTER'

echo "DEBUG: SLURM_NODELIST=$SLURM_JOB_NODELIST_PACK_GROUP_0"
echo "DEBUG: SLURM_NODELIST=$SLURM_JOB_NODELIST_PACK_GROUP_1"
export SPARK_HOME=/home/tahmad/tahmad/spark-3.0.0-bin-hadoop2.7
chmod -R a+rwx $SPARK_HOME
source del.txt
nodes=($(scontrol show hostname $SLURM_NODELIST))
nnodes=${#nodes[@]}
last=$(( $nnodes - 1 ))
echo ${nodes}
ssh ${nodes[0]} hostname
echo -n "starting spark master on $MASTER... ";
singularity exec ~/tahmad/spark.simg /home/tahmad/tahmad/spark-3.0.0-bin-hadoop2.7/sbin/start-master.sh
PORT=7077
export MASTER="spark://${nodes[0]}:$PORT"
echo -n "starting spark master on $MASTER... ";
echo "done";
sleep 2;
echo "spark cluster web interface: http://tcn753:8080"  >$HOME/spark-info
echo "           spark master URL: spark://tcn753:7077" >>$HOME/spark-info
export MASTER=$MASTER
echo starting on-node worker
echo opening ssh connections to start the other nodes worker processeses
i=0
for i in $( seq 1 $last )
do
    ssh ${nodes[i]} hostname
done
echo starting remote workers
for i in $( seq 1 $last )
do
   /usr/bin/ssh ${nodes[$i]} "singularity exec ~/tahmad/spark.simg /home/tahmad/tahmad/spark-3.0.0-bin-hadoop2.7/sbin/start-slave.sh -c 16 -m 16G ${MASTER}; echo ${nodes[$i]} " &
done
'''
for i in $( seq 1 $last )
do
   /usr/bin/ssh ${nodes[$i]} "/home/tahmad/tahmad/spark-3.0.0-bin-hadoop2.7/sbin/start-slave.sh -c 24 -m 25G ${MASTER}; echo ${nodes[$i]} " &
done
'''
'''
for i in $( seq 1 $last )
do
   /usr/bin/ssh ${nodes[$i]} "singularity exec ~/tahmad/spark.simg plasma_store_server -m 3000000000 -s /tmp/store0 & " &
done
'''
sleep 25;
python run.py ${nodes[0]}
'''
for i in $( seq 1 $last )
do
   /usr/bin/ssh ${nodes[$i]} " singularity exec ~/tahmad/spark.simg /home/tahmad/tahmad/spark-2.3.4-bin-hadoop2.7/sbin/stop-slave.sh ; echo ${nodes[$i]}; kill $(pidof plasma_store_server) " &
done
'''

#!/bin/bash
#FLUX: --job-name=stanky-pot-2097
#FLUX: --priority=16

cd /data/03170/tg824689/BecksteinLab/scripts-DCD
source activate daskMda
SCHEDULER=`hostname`
echo SCHEDULER: $SCHEDULER
hostnodes=`scontrol show hostnames $SLURM_NODELIST`
echo $hostnodes
dask-ssh --nprocs 48 $hostnodes &
sleep 20
echo "====-get to work-===="
python Parallel-RMSD-dist-final-dcd.py $SCHEDULER:8786
echo "===- Kill Scheduler -==="
ps axf | grep dask-ssh | grep -v grep | awk '{print "kill -9 " $1}' | sh
mkdir 4node_stat
mv *.txt 4node_stat

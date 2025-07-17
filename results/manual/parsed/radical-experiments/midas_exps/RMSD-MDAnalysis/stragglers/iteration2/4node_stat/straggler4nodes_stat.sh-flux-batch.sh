#!/bin/bash
#FLUX: --job-name=straggler4nodes_stat
#FLUX: -N=4
#FLUX: -n=4
#FLUX: --queue=normal
#FLUX: -t=28800
#FLUX: --urgency=16

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

#!/bin/bash
#FLUX: --job-name=aquila
#FLUX: -N=16
#FLUX: -c=8
#FLUX: --exclusive
#FLUX: --queue=xahdnormal
#FLUX: --urgency=16

echo "START TIME: $(date)"
hostfile=./hostfile/$SLURM_JOB_ID
scontrol show hostnames $SLURM_JOB_NODELIST > ${hostfile}
rm `pwd`/hostfile-dl -f
for i in `cat $hostfile`
do
    echo ${i} slots=4 >> `pwd`/hostfile/hostfile-dl-$SLURM_JOB_ID
done
np=$(cat $hostfile|sort|uniq |wc -l)
np=$(($np*4))
nodename=$(cat $hostfile |sed -n "1p")
dist_url=`echo $nodename | awk '{print $1}'`
sleep 8m
mv `pwd`/hostfile/hostfile-dl-$SLURM_JOB_ID /work/home/zhaoying1/work/pr_code/FlagPerf-AI_platform/training/dcu/hosts
sed -i '/hosts = /d' config.py 
sed -i '$a\hosts = ["localhost"]' config.py 
sed -i "s/localhost/$dist_url/g" config.py
source ~/env/megatron.sh
python3 run.py

#!/bin/bash
#SBATCH --job-name=aquila
#SBATCH --output=./logs/%j.out
#SBATCH --error=./logs/%j.out
#SBATCH --nodes=16
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=dcu:4
#SBATCH --exclusive
#SBATCH --constraint=ntasks-per-node=4

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

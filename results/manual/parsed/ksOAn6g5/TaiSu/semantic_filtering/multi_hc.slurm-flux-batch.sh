#!/bin/bash
#FLUX: --job-name=clean
#FLUX: -c=8
#FLUX: --exclusive
#FLUX: --queue=kshdexclu05
#FLUX: -t=7200000
#FLUX: --urgency=16

source env_hc_zjx.sh
which python3
hostfile=./$SLURM_JOB_ID
scontrol show hostnames $SLURM_JOB_NODELIST > ${hostfile}
rm `pwd`/hostfile-dl -f
for i in `cat $hostfile`
do
    echo ${i} slots=4 >> `pwd`/hostfile-dl-$SLURM_JOB_ID
done
np=$(cat $hostfile|sort|uniq |wc -l)
np=$(($np*1))
nodename=$(cat $hostfile |sed -n "1p")
echo $nodename
dist_url=`echo $nodename | awk '{print $1}'`
echo mpirun -np $np --allow-run-as-root --hostfile hostfile-dl-$SLURM_JOB_ID  --bind-to none `pwd`/single_hc.sh $dist_url 
mpirun -np $np --allow-run-as-root --hostfile hostfile-dl-$SLURM_JOB_ID --bind-to none `pwd`/single_hc.sh $dist_url 

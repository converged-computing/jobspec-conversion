#!/bin/bash
#SBATCH --job-name=clean
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=dcu:1
#SBATCH --time=83-08:00:00
#SBATCH --exclusive
#SBATCH --constraint=ntasks-per-node=1

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

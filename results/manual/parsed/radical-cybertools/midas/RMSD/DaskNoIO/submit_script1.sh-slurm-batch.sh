#!/bin/bash
#SBATCH --job-name=DaskRMSD1
#SBATCH --account=True
#SBATCH --output=DaskRMSD1.out
#SBATCH --error=DaskRMSD1.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=08:00:00
#SBATCH --partition=normal

cd $SLURM_SUBMIT_DIR
source activate MDAnalysis
SCHEDULER=`hostname`
echo SCHEDULER: $SCHEDULER
hostnodes=`scontrol show hostnames $SLURM_NODELIST`
echo $hostnodes
dask-ssh --nprocs 24 --nthreads 1 --log-directory ./ $hostnodes &
sleep 20
echo "====-get to work-===="
python DaskDistNoIO.py $SCHEDULER:8786 24 $SLURM_SUBMIT_DIR
echo "===- Kill Scheduler -==="
ps axf | grep dask-ssh | grep -v grep | awk '{print "kill -9 " $1}' | sh
mkdir 1node
mv *.txt 1node

#!/bin/bash
#SBATCH --job-name=A5
#SBATCH --output=A5.out
#SBATCH --error=A5.err
#SBATCH --mail-user=sahn1@stanford.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=2-00:00:00
#SBATCH --partition=owners
#SBATCH --qos=normal
#SBATCH --constraint=ntasks-per-node=16
#SBATCH: --no-requeue

num_nodes=1  # TODO: set number of nodes requested
num_cpu=16  # TODO: set number of cores per node
echo The master node of this job is `hostname`
echo This job runs on the following nodes:
echo `scontrol show hostname $SLURM_JOB_NODELIST`
echo "Starting at `date`"
echo "Running on hosts: $SLURM_NODELIST"
echo "Running on $SLURM_NNODES nodes."
echo "Running on $SLURM_NPROCS processors."
echo "Current working directory is `pwd`"
scontrol show hostname $SLURM_JOB_NODELIST > initial_nodefilelist.txt
rm -rf nodefilelist.txt
for i in `seq 1 $num_nodes`;
do 
    for j in `seq 1 $num_cpu`;
    do
        awk NR==$i initial_nodefilelist.txt >> nodefilelist.txt
    done
done
rm initial_nodefilelist.txt
python main.py
exit

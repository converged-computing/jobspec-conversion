#!/bin/bash
#FLUX: --job-name=A5
#FLUX: --queue=owners
#FLUX: -t=172800
#FLUX: --urgency=16

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

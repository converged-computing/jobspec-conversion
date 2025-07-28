#!/bin/bash
#FLUX: --job-name=rayCalc
#FLUX: -N=8
#FLUX: --urgency=16

echo Time is `date`
echo Directory is $PWD
echo This job runs on the following nodes:
echo $SLURM_JOB_NODELIST
echo This job has allocated $SLURM_JOB_CPUS_PER_NODE cpu cores.
source /home/ess/pjzhang/conda_start.sh
conda activate torch15 # activate the python enviroment
MPIRUN=mpiexec #MPICH
MPIOPT="-iface ib0" #MPICH3 # use infiniband for communication
$MPIRUN $MPIOPT -n 320 python /home/ess/pjzhang/sunray/sunRay_MPI.py
echo End at `date`  # for the measure of the running time of the 

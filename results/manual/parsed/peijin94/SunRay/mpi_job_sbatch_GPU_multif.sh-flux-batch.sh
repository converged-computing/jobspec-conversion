#!/bin/bash
#FLUX: --job-name=fugly-butter-6070
#FLUX: --urgency=16

echo Time is `date`
echo Directory is $PWD
echo This job runs on the following nodes:
echo $SLURM_JOB_NODELIST
echo This job has allocated $SLURM_JOB_CPUS_PER_NODE cpu cores.
source /home/ess/pjzhang/conda_start.sh
conda activate torch15g # activate the enviroment with torch 1.5
module load cuda/10.2.89
module load intelmpi/2020
MPIRUN=mpiexec #MPICH
MPIOPT="-iface ib0" #MPICH3 # use infiniband for communication
$MPIRUN $MPIOPT -n 4 python /home/ess/pjzhang/sunray/sunRay_SCC/sunRay_MPI_GPU_multif.py
echo End at `date`  # for the measure of the running time of the 

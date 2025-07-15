#!/bin/bash
#FLUX: --job-name=DDAtest
#FLUX: -c=32
#FLUX: --queue=bigmem
#FLUX: -t=590400
#FLUX: --urgency=16

WORKDIR=$PWD
cd ${WORKDIR}
echo "we are running from this directory: $SLURM_SUBMIT_DIR"
echo " the name of the job is: $SLURM_JOB_NAME"
echo "Th job ID is $SLURM_JOB_ID"
echo "The job was run on these nodes: $SLURM_JOB_NODELIST"
echo "Number of nodes: $SLURM_JOB_NUM_NODES"
echo "We are using $SLURM_CPUS_ON_NODE cores"
echo "We are using $SLURM_CPUS_ON_NODE cores per node"
echo "Total of $SLURM_NTASKS cores"
module purge
module --ignore-cache load MaxQuant/2.4.0.0-GCCcore-11.2.0
mono --version
module load dotNET-SDK/3.1.300-linux-x64
dotnet --version
dotnet /cluster/projects/nn9036k/MaxQuant_v2.4.14.0/bin/MaxQuantCmd.exe -p 19 /cluster/projects/nn9036k/scripts/mqpar.xml

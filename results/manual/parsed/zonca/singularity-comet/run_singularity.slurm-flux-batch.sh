#!/bin/bash
#FLUX: --job-name=singularity
#FLUX: -N=2
#FLUX: --queue=compute
#FLUX: --urgency=16

export PBS_NODEFILE='`generate_pbs_nodefile`'
export SINGULARITY='$(which singularity)'

module load singularity mvapich2_ib/2.1
IMAGE=/oasis/scratch/comet/zonca/temp_project/ubuntu_anaconda_2018.simg
export PBS_NODEFILE=`generate_pbs_nodefile`
export SINGULARITY=$(which singularity)
echo $SINGULARITY
mpirun_rsh -hostfile "$PBS_NODEFILE" -np 48 $SINGULARITY exec $IMAGE /usr/bin/hellow

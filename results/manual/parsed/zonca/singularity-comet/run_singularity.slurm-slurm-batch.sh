#!/bin/bash
#SBATCH --job-name=singularity
#SBATCH --output=singularity_2018%j.%N.out
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:05:00
#SBATCH --partition=compute
#SBATCH --constraint=ntasks-per-node=24

export PBS_NODEFILE='`generate_pbs_nodefile`'
export SINGULARITY='$(which singularity)'

module load singularity mvapich2_ib/2.1
IMAGE=/oasis/scratch/comet/zonca/temp_project/ubuntu_anaconda_2018.simg
export PBS_NODEFILE=`generate_pbs_nodefile`
export SINGULARITY=$(which singularity)
echo $SINGULARITY
mpirun_rsh -hostfile "$PBS_NODEFILE" -np 48 $SINGULARITY exec $IMAGE /usr/bin/hellow

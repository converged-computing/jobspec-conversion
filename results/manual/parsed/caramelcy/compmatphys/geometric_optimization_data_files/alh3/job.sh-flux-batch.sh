#!/bin/bash
#FLUX: --job-name=19280
#FLUX: --queue=small
#FLUX: --urgency=16

hostname
module load DL-CondaPy/3.7
source /home/apps/spack/share/spack/setup-env.sh
module load oneapi/compiler/2022.0.2
module load oneapi/mpi/2021.5.1
source /opt/ohpc/pub/intel/oneapi/setvars.sh
module load QE-oneapi-compiler/7.1
if [ ! -d //scratch/$USER ]
then
  mkdir -p //scratch/$USER
fi
tdir=$(mktemp -d //scratch/$USER/qe_job__$SLURM_JOBID-XXXX)
cd $tdir
cp $SLURM_SUBMIT_DIR/alh3.in .
echo "Job execution start: $(date)" 
echo "Job submitted by ${USER}" 
echo "The job ID is:${SLURM_JOBID}"  
mpirun -n $SLURM_NTASKS pw.x -in alh3.in  
echo "Job execution finished at: $(date)" 

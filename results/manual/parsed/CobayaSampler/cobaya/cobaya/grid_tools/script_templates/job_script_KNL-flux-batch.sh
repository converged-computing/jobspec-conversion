#!/bin/bash
#FLUX: --job-name=reclusive-lettuce-1825
#FLUX: --priority=16

export OMP_NUM_THREADS='{OMP}'
export OMP_PLACES='threads'
export OMP_PROC_BIND='spread'
export PATH='$PATH:$SCRATCH/.local/cori/2.7-anaconda-4.4/bin/'

export OMP_NUM_THREADS={OMP}
export OMP_PLACES=threads
export OMP_PROC_BIND=spread
module swap craype-haswell craype-mic-knl
module load cray-mpich
module load python
export PATH=$PATH:$SCRATCH/.local/cori/2.7-anaconda-4.4/bin/
cd {ROOTDIR}
echo Running on host `hostname`
echo Time is `date`
echo Directory is `pwd`
echo Job ID is $SLURM_JOBID
echo Hostfile $SLURM_HOSTFILE
{COMMAND}

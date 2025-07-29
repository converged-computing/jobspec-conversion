#!/bin/bash
#FLUX: --job-name=example_Si
#FLUX: -n=20
#FLUX: --queue=test
#FLUX: --urgency=16

export OMP_NUM_THREADS='20'

echo Time is `date`
echo Directory is `pwd`
echo This job runs on the following nodes:
echo $SLURM_JOB_NODELIST
echo This job has allocated $SLURM_JOB_CPUS_PER_NODE cpu cores.
module purge 
module load anaconda3_nompi 
module load abacus/2.3.0/intel-2019.update5
module list 2>&1
source activate pytorch110
which python3
MPIRUN=mpirun #Intel mpi and Open MPI
MPIOPT='-env I_MPI_FABRICS shm:ofi' #Intel MPI
timeout 10 $MPIRUN $MPIOPT hostname 
export OMP_NUM_THREADS=20
echo "OMP_NUM_THREADS: $OMP_NUM_THREADS"
echo ' python3 -u ../SIAB.py SIAB_INPUT* 2>&1 '
python3 -u ../SIAB.py SIAB_INPUT* 2>&1

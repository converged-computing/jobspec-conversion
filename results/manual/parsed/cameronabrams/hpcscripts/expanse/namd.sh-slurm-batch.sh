#!/bin/bash
#SBATCH --job-name=namd
#SBATCH --account=dxu100
#SBATCH --output=namd.%j.%N.out
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --partition=compute
#SBATCH --constraint=ntasks-per-node=128

export OMP_NUM_THREADS='${NCPU}'

NNODES=2
NCPUPERNODE=128
NCPU=$((NNODES*NCPUPERNODE))
export OMP_NUM_THREADS=${NCPU}
cd $SLURM_SUBMIT_DIR
module purge
module load cpu/0.17.3b  gcc/10.2.0/npcyll4  openmpi/4.1.3/oq3qvsv
module load namd/2.14/dstif4f
CHARMRUN=`which charmrun`
NAMD2=`which namd2`
BASENAME=basename
$CHARMRUN +p${NCPU} $NAMD2 ${BASENAME}.namd > ${BASENAME}.log

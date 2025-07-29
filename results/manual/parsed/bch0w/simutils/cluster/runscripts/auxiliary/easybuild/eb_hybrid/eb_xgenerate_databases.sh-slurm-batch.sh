#!/bin/bash
#SBATCH --job-name=xgenerate_databases
#SBATCH --account=nesi00263
#SBATCH --output=generate_databases_%j.out
#SBATCH --nodes=10
#SBATCH --ntasks=40
#SBATCH --cpus-per-task=10
#SBATCH --time=00:15:00
#SBATCH --partition=nesi_research

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export OMP_PROC_BIND='true'
export OMP_PLACES='cores'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export OMP_PROC_BIND=true
export OMP_PLACES=cores
module load gcc/8.3.0
COMPILER=SPECFEM3D/20190730-CrayGNU-19.04
module load ${COMPILER}
NPROC=`grep ^NPROC DATA/Par_file | grep -v -E '^[[:space:]]*#' | cut -d = -f 2`
BASEMPIDIR=`grep ^LOCAL_PATH DATA/Par_file | cut -d = -f 2 `
mkdir -p ${BASEMPIDIR}
echo ${COMPILER}
echo "xgenerate_databases ${NPROC} processors"
echo
echo "`date`"
time srun -n ${NPROC} xgenerate_databases
if [[ $? -ne 0 ]]; then exit 1; fi
echo
echo "finished at: `date`"

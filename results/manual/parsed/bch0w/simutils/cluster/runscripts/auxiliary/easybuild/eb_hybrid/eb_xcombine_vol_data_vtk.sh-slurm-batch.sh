#!/bin/bash
#SBATCH --job-name=combine_vol_data_vtk
#SBATCH --account=nesi00263
#SBATCH --output=combine_vol_data_vtk_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:00:30

module load gcc/8.3.0
COMPILER=SPECFEM3D/20190730-CrayGNU-19.04
module load ${COMPILER}
QUANTITY=$1
if [ -z "$1" ]
then
	echo "QUANTITY REQUIRED (e.g. vs, hess_kernel, beta_kernel_smooth)"
	exit
fi
NPROC=`grep ^NPROC DATA/Par_file | grep -v -E '^[[:space:]]*#' | cut -d = -f 2`
NPROC_START=0
NPROC_END=`expr $NPROC - 1`
DIR_IN="./SUM/"
DIR_OUT=${DIR_IN}
echo ${COMPILER}
echo "xcombine_vol_data_vtk ${NPROC_START} ${NPROC_END} for ${QUANTITY}"
echo
echo "`date`"
time srun -n 1 xcombine_vol_data_vtk ${NPROC_START} ${NPROC_END} ${QUANTITY} ${DIR_IN}/ ${DIR_OUT}/ 0
echo
echo "finished at: `date`"

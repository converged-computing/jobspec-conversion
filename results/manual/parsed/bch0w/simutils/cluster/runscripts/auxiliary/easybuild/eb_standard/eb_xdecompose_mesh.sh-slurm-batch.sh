#!/bin/bash
#SBATCH --job-name=xdecompose_mesh
#SBATCH --account=nesi00263
#SBATCH --output=decompose_mesh_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:02:00

COMPILER=SPECFEM3D/20190730-CrayCCE-19.04
COMPILER=SPECFEM3D/20190730-CrayGNU-19.04
COMPILER=SPECFEM3D/20190730-CrayIntel-19.04
module load ${COMPILER}
MESH="./MESH"
NPROC=`grep ^NPROC DATA/Par_file | grep -v -E '^[[:space:]]*#' | cut -d = -f 2`
BASEMPIDIR=`grep ^LOCAL_PATH DATA/Par_file | cut -d = -f 2 `
mkdir -p ${BASEMPIDIR}
echo ${COMPILER}
echo "xdecompose_mesh"
echo
echo "`date`"
xdecompose_mesh ${NPROC} ${MESH} ${BASEMPIDIR}
echo
echo "finished at: `date`"

#!/bin/bash
#SBATCH --job-name=specfem3D
#SBATCH --output=specfem3D.%j.output.txt
#SBATCH --nodes=16
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=04:00:00
#SBATCH --partition=snsm_itn19
#SBATCH --qos=openaccess
#SBATCH --constraint=ntasks-per-node=1

module purge
module load apps/specfem3d/3.0.1i
logfile=$SLURM_JOB_NAME"."$SLURM_JOB_ID.output.txt
echo "TIME BEGAN: " >> $logfile
date >> $logfile
SECONDS=0
cp DATA/meshfem3D_files/Mesh_Par_file OUTPUT_FILES/
cp DATA/Par_file OUTPUT_FILES/
cp DATA/CMTSOLUTION OUTPUT_FILES/
cp DATA/STATIONS OUTPUT_FILES/
echo "running example: `date`"
currentdir=`pwd`
NPROC=`grep ^NPROC DATA/Par_file | grep -v -E '^[[:space:]]*#' | cut -d = -f 2`
BASEMPIDIR=`grep ^LOCAL_PATH DATA/Par_file | cut -d = -f 2 `
echo
echo "  running solver on $NPROC processors..."
echo
mpirun -np $NPROC xspecfem3D
if [[ $? -ne 0 ]]; then exit 1; fi
echo
echo "see results in directory: OUTPUT_FILES/"
echo
echo "done"
echo `date`

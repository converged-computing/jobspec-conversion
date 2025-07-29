#!/bin/bash
#SBATCH --job-name=keras-mnist-cpu
#SBATCH --account=ddp315
#SBATCH --output=keras-mnist-cpu.o%j.%N
#SBATCH --error=keras-mnist-cpu.e%j.%N
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:k80:4
#SBATCH --time=00:30:00
#SBATCH --constraint=ntasks-per-node=4
#SBATCH --no-requeue

declare -xr LOCAL_SCRATCH="/scratch/${USER}/${SLURM_JOB_ID}"
declare -xr LUSTRE_SCRATCH="/oasis/scratch/comet/mkandes/temp_project/singularity/images"
declare -xr SINGULARITY_MODULE='singularity/2.5.1'
module purge
module load gnu
module load mvapich2_ib
module load cmake
module load "${SINGULARITY_MODULE}"
module list
cp -rf ../../../comet-benchmark "${LOCAL_SCRATCH}"
cp "${LUSTRE_SCRATCH}/keras-tensorflow-cpu.img" "${LOCAL_SCRATCH}"
cd "${LOCAL_SCRATCH}/comet-benchmark/singularity/keras"
echo $(pwd)
singularity exec --nv ${LOCAL_SCRATCH}/keras-tensorflow-cpu.img python ./mnist-test.py

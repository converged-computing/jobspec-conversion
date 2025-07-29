#!/bin/bash
#SBATCH --job-name=liq32b
#SBATCH --account=m3538_g
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --cpus-per-task=4
#SBATCH --gres=4
#SBATCH --time=11:59:00
#SBATCH --qos=regular
#SBATCH --constraint=gpu,ntasks-per-node=32

export SLURM_CPU_BIND='cores'
export CUDA_MPS_PIPE_DIRECTORY='/tmp/nvidia-mps'
export CUDA_MPS_LOG_DIRECTORY='/tmp/nvidia-log'

singularity
exec
nvcr.io/hpc/deepmd-kit:v2.1.1
export SLURM_CPU_BIND="cores"
export CUDA_MPS_PIPE_DIRECTORY=/tmp/nvidia-mps
export CUDA_MPS_LOG_DIRECTORY=/tmp/nvidia-log
if [ $SLURM_LOCALID -eq 0 ]; then
    CUDA_VISIBLE_DEVICES=$SLURM_JOB_GPUS nvidia-cuda-mps-control -d
fi
sleep 5
cat /global/homes/y/yifanl/Softwares/lammps/.git/refs/heads/pimd_langevin
export SLURM_CPU_BIND="cores"
lmp=/global/u1/y/yifanl/Softwares/lammps/build-5c9480/lmp_5c9480
srun -u -l -N 1 -n 32 -c 1 -G 4 --gpus-per-node 4 --mpi=pmi2 shifter --module gpu bash -c "/bin/nventry --build_base_dir=/usr/local/lammps --build_default=gpu_native -entrypoint=/opt/nvidia/nvidia_entrypoint.sh $lmp -echo screen -in in.rerunO -p 32x1 -log log -screen screen"
if [ $SLURM_LOCALID -eq 0 ]; then
    echo quit | nvidia-cuda-mps-control
fi

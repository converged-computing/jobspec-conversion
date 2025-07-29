#!/bin/bash
#SBATCH --job-name=pyt-profiler
#SBATCH --account=nn9987k
#SBATCH --output=PyTprofiler.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=1
#SBATCH --mem=4G
#SBATCH --time=00:10:00
#SBATCH --partition=accel

Mydir=/cluster/projects/nn9987k/PyTorchProfiler
MyContainer=${Mydir}/Container/pytorch_22.12-py3.sif
MyExp=${Mydir}/examples
singularity exec --nv -B ${MyExp} ${MyContainer} python3 ${MyExp}/resnet18_profiler_api_4batch.py
echo 
echo "--Job ID:" $SLURM_JOB_ID
echo "--total nbr of gpus" $SLURM_GPUS
echo "--nbr of gpus_per_node" $SLURM_GPUS_PER_NODE

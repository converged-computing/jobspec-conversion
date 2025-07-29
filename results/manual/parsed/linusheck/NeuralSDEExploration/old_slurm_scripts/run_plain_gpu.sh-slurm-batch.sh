#!/bin/bash
#SBATCH --job-name=train
#SBATCH --account=tipes
#SBATCH --output=/home/linushe/outputs/plain-%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:v100:1
#SBATCH --time=1-00:00:00
#SBATCH --partition=gpu

export I_MPI_PMI_LIBRARY='/p/system/slurm/lib/libpmi.so'

echo "------------------------------------------------------------"
echo "SLURM JOB ID: $SLURM_JOBID"
echo "Running on nodes: $SLURM_NODELIST"
echo "------------------------------------------------------------"
export I_MPI_PMI_LIBRARY=/p/system/slurm/lib/libpmi.so
module purge
module load julia/1.8.2
srun julia --project=. -t2 notebooks/sde_train.jl --gpu true -m sun --batch-size 128 --eta 10.0 --learning-rate 0.02 --latent-dims 2 --stick-landing false

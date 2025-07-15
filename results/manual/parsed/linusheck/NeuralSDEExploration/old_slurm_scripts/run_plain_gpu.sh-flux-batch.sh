#!/bin/bash
#FLUX: --job-name=train
#FLUX: -c=2
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --priority=16

export I_MPI_PMI_LIBRARY='/p/system/slurm/lib/libpmi.so'

echo "------------------------------------------------------------"
echo "SLURM JOB ID: $SLURM_JOBID"
echo "Running on nodes: $SLURM_NODELIST"
echo "------------------------------------------------------------"
export I_MPI_PMI_LIBRARY=/p/system/slurm/lib/libpmi.so
module purge
module load julia/1.8.2
srun julia --project=. -t2 notebooks/sde_train.jl --gpu true -m sun --batch-size 128 --eta 10.0 --learning-rate 0.02 --latent-dims 2 --stick-landing false

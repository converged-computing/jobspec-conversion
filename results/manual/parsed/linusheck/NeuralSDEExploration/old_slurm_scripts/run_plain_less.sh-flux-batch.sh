#!/bin/bash
#FLUX: --job-name=train
#FLUX: -c=2
#FLUX: --queue=standard
#FLUX: -t=86400
#FLUX: --priority=16

export I_MPI_PMI_LIBRARY='/p/system/slurm/lib/libpmi.so'

echo "------------------------------------------------------------"
echo "SLURM JOB ID: $SLURM_JOBID"
echo "Running on nodes: $SLURM_NODELIST"
echo "------------------------------------------------------------"
export I_MPI_PMI_LIBRARY=/p/system/slurm/lib/libpmi.so
module purge
module add texlive
srun /home/linushe/julia-1.9.0/bin/julia --project=. -t2 notebooks/sde_train.jl -m sun --batch-size 128 --eta 10.0 --learning-rate 0.02 --latent-dims 1 --stick-landing false --dt 0.1 --kl-rate 4000 --noise 0.2

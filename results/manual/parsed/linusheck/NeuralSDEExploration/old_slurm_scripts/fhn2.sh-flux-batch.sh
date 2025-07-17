#!/bin/bash
#FLUX: --job-name=train
#FLUX: -c=16
#FLUX: --queue=standard
#FLUX: -t=86400
#FLUX: --urgency=16

export I_MPI_PMI_LIBRARY='/p/system/slurm/lib/libpmi.so'

echo "------------------------------------------------------------"
echo "SLURM JOB ID: $SLURM_JOBID"
echo "Running on nodes: $SLURM_NODELIST"
echo "------------------------------------------------------------"
export I_MPI_PMI_LIBRARY=/p/system/slurm/lib/libpmi.so
module purge
srun /home/linushe/julia-1.9.0/bin/julia --project=. -t16 notebooks/sde_train.jl -m fhn --batch-size 128 --eta 100.0 --learning-rate 0.015 --lr-cycle false --lr-rate 3000 --latent-dims 3 --stick-landing false --kl-rate 1000 --kl-anneal true --tspan-start-data 0.0 --tspan-end-data 0.5 --tspan-start-train 0.0 --tspan-end-train 0.5 --tspan-start-model 0.0 --tspan-end-model 0.5 --dt 0.05 --backsolve true --decay 1.0 --kidger true --hidden-size 32

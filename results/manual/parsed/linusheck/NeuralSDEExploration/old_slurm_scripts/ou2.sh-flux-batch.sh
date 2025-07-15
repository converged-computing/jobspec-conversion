#!/bin/bash
#FLUX: --job-name=train
#FLUX: -c=16
#FLUX: --queue=standard
#FLUX: -t=57600
#FLUX: --urgency=16

export I_MPI_PMI_LIBRARY='/p/system/slurm/lib/libpmi.so'

echo "------------------------------------------------------------"
echo "SLURM JOB ID: $SLURM_JOBID"
echo "Running on nodes: $SLURM_NODELIST"
echo "------------------------------------------------------------"
export I_MPI_PMI_LIBRARY=/p/system/slurm/lib/libpmi.so
module purge
srun /home/linushe/julia-1.9.0/bin/julia --project=. -t16 notebooks/sde_train.jl -m ou --batch-size 128 --eta 0.3 --learning-rate 0.04 --latent-dims 3 --stick-landing false --kl-rate 500 --kl-anneal true --lr-cycle false --tspan-start-data 0.0 --tspan-end-data 40.0 --tspan-start-train 0.0 --tspan-end-train 80.0 --tspan-start-model 0.0 --tspan-end-model 40.0 --dt 2.0 --hidden-size 64 --depth 2 --backsolve true --scale 0.01 --decay 1.0

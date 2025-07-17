#!/bin/bash
#FLUX: --job-name=train
#FLUX: -c=10
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
srun /home/linushe/julia-1.9.0/bin/julia --project=. -t10 notebooks/sde_train.jl -m fhn --batch-size 128 --eta 30.0 --learning-rate 0.02 --latent-dims 2 --stick-landing false --kl-rate 400 --kl-anneal true --tspan-start-data 0.0 --tspan-end-data 0.2 --tspan-start-train 0.0 --tspan-end-train 0.2 --tspan-start-model 0.0 --tspan-end-model 0.2 --dt 0.01 --backsolve true --scale 0.01

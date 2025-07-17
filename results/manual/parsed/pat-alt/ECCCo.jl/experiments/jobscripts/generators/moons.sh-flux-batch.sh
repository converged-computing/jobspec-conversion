#!/bin/bash
#FLUX: --job-name=Moons (ECCCo)
#FLUX: -n=30
#FLUX: -c=10
#FLUX: --queue=compute
#FLUX: -t=5400
#FLUX: --urgency=16

module load 2023r1 openmpi
source experiments/slurm_header.sh
srun julia --project=experiments --threads $SLURM_CPUS_PER_TASK experiments/run_experiments.jl -- data=moons output_path=results mpi threaded n_individuals=100 n_runs=50 > experiments/logs/moons.log

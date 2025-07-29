#!/bin/bash
#SBATCH --account=kfm-471-aa
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --time=2-00:00:00

module load julia/1.8.1
julia --threads=auto --project scripts/main.jl 4 4  --nsamples=1000000 --nburns=10000 --seed=1234 --nthrows=50
julia --threads=auto --project scripts/main.jl 4 6  --nsamples=1000000 --nburns=10000 --seed=1234 --nthrows=50
julia --threads=auto --project scripts/main.jl 4 8  --nsamples=1000000 --nburns=10000 --seed=1234 --nthrows=50
julia --threads=auto --project scripts/main.jl 4 10 --nsamples=1000000 --nburns=10000 --seed=1234 --nthrows=50
julia --threads=auto --project scripts/main.jl 4 12 --nsamples=1000000 --nburns=10000 --seed=1234 --nthrows=50
julia --threads=auto --project scripts/main.jl 4 14 --nsamples=1000000 --nburns=10000 --seed=1234 --nthrows=50
julia --threads=auto --project scripts/main.jl 4 16 --nsamples=1000000 --nburns=10000 --seed=1234 --nthrows=50
julia --threads=auto --project scripts/main.jl 4 18 --nsamples=1000000 --nburns=10000 --seed=1234 --nthrows=50
julia --threads=auto --project scripts/main.jl 4 20 --nsamples=1000000 --nburns=10000 --seed=1234 --nthrows=50

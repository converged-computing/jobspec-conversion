#!/bin/bash
#FLUX: --job-name=virion-4-hosts-accessions
#FLUX: -c=40
#FLUX: -t=3600
#FLUX: --priority=16

module load StdEnv/2020 julia/1.5.2
julia --project -t 38 04_parallel_host_kmers.jl

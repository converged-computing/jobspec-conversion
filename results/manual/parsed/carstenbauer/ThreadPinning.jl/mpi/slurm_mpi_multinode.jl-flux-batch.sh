#!/bin/bash
#FLUX: --job-name=chocolate-poo-5692
#FLUX: -N=2
#FLUX: -n=4
#FLUX: --queue=all
#FLUX: -t=120
#FLUX: --urgency=16

ml lang JuliaHPC
srun -n 4 julia --project -t 1 $(scontrol show job $SLURM_JOBID | awk -F= '/Command=/{print $2}')
exit
using MPI
using ThreadPinning
MPI.Init()
nranks = MPI.Comm_size(MPI.COMM_WORLD)
rank = MPI.Comm_rank(MPI.COMM_WORLD)
sleep(0.3 * rank)
println("Rank $rank:")
println("\tHost: ", gethostname())
println("\tCPUs: ", getcpuids())
print_affinity_masks()
MPI.Finalize()

#!/bin/bash
#FLUX: --job-name="julia-mkl-amd dgx-a100"
#FLUX: --queue=dgx
#FLUX: -t=14400
#FLUX: --priority=16

export LD_PRELOAD='/scratch/pc2-mitarbeiter/bauerc/devel/julia-mkl-amd/mkl_workaround/libfakeintel.so'

cd /scratch/pc2-mitarbeiter/bauerc/devel/julia-mkl-amd/dgx-a100
rm -f results.csv
OMP_NUM_THREADS=128 OMP_PLACES=sockets OMP_PROC_BIND=close srun -u -n 1 -c 128 /upb/departments/pc2/users/b/bauerc/.juliaup/bin/julia-beta --project ../bench.jl OpenBLAS highAI
OMP_NUM_THREADS=128 OMP_PLACES=sockets OMP_PROC_BIND=spread srun -u -n 1 -c 128 /upb/departments/pc2/users/b/bauerc/.juliaup/bin/julia-beta --project ../bench.jl OpenBLAS highMB
OMP_NUM_THREADS=128 OMP_PLACES=sockets OMP_PROC_BIND=close srun -u -n 1 -c 128 /upb/departments/pc2/users/b/bauerc/.juliaup/bin/julia-beta --project ../bench.jl MKL highAI
OMP_NUM_THREADS=128 OMP_PLACES=sockets OMP_PROC_BIND=spread srun -u -n 1 -c 128 /upb/departments/pc2/users/b/bauerc/.juliaup/bin/julia-beta --project ../bench.jl MKL highMB
export LD_PRELOAD=/scratch/pc2-mitarbeiter/bauerc/devel/julia-mkl-amd/mkl_workaround/libfakeintel.so
OMP_NUM_THREADS=128 OMP_PLACES=sockets OMP_PROC_BIND=close srun -u -n 1 -c 128 /upb/departments/pc2/users/b/bauerc/.juliaup/bin/julia-beta --project ../bench.jl MKL highAI
OMP_NUM_THREADS=128 OMP_PLACES=sockets OMP_PROC_BIND=spread srun -u -n 1 -c 128 /upb/departments/pc2/users/b/bauerc/.juliaup/bin/julia-beta --project ../bench.jl MKL highMB
/upb/departments/pc2/users/b/bauerc/.juliaup/bin/julia-beta --project ../plot_results.jl

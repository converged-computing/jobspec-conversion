#!/bin/bash
#FLUX: --job-name=WRF
#FLUX: -N=2
#FLUX: --exclusive
#FLUX: --priority=16

export I_MPI_OFI_LIBRARY_INTERNAL='0'
export OMP_NUM_THREADS='6'
export FI_PROVIDER='efa'
export I_MPI_FABRICS='ofi'
export I_MPI_OFI_PROVIDER='efa'
export I_MPI_PIN_DOMAIN='omp'
export KMP_AFFINITY='compact'
export I_MPI_DEBUG='4'

cd conus_12km
cat > slurm-wrf-conus12km.sh <<EOF
export I_MPI_OFI_LIBRARY_INTERNAL=0
spack load intel-oneapi-mpi
spack load wrf
wrf_exe=$(spack location -i wrf)/run/wrf.exe
set -x
ulimit -s unlimited
ulimit -a
export OMP_NUM_THREADS=6
export FI_PROVIDER=efa
export I_MPI_FABRICS=ofi
export I_MPI_OFI_PROVIDER=efa
export I_MPI_PIN_DOMAIN=omp
export KMP_AFFINITY=compact
export I_MPI_DEBUG=4
time mpiexec.hydra -np \$SLURM_NTASKS --ppn \$SLURM_NTASKS_PER_NODE \$wrf_exe
echo $? > wrf.exit.code
EOF
echo; echo "Running sbatch slurm-wrf-conus12km.sh from ${PWD}"
sbatch slurm-wrf-conus12km.sh
rm -f slurm-wrf-conus12km.sh

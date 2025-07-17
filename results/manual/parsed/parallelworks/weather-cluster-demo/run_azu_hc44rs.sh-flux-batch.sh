#!/bin/bash
#FLUX: --job-name=WRF
#FLUX: -N=8
#FLUX: --exclusive
#FLUX: --urgency=16

export I_MPI_FABRICS='ofi_rxm;tcp'
export OMP_NUM_THREADS='6'
export I_MPI_PIN_DOMAIN='omp'
export KMP_AFFINITY='compact'
export I_MPI_DEBUG='6'

source ~/.bashrc
cd conus_12km
export I_MPI_FABRICS="ofi_rxm;tcp"
cat > slurm-wrf-conus12km.sh <<EOF
spack load intel-oneapi-mpi
spack load wrf
wrf_exe=$(spack location -i wrf)/run/wrf.exe
set -x
ulimit -s unlimited
ulimit -a
export OMP_NUM_THREADS=6
export I_MPI_PIN_DOMAIN=omp
export KMP_AFFINITY=compact
export I_MPI_DEBUG=6
time mpiexec.hydra -np \$SLURM_NTASKS --ppn \$SLURM_NTASKS_PER_NODE \$wrf_exe
echo $? > wrf.exit.code
EOF
echo; echo "Running sbatch slurm-wrf-conus12km.sh from ${PWD}"
sbatch slurm-wrf-conus12km.sh
rm -f slurm-wrf-conus12km.sh

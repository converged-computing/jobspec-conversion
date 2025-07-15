#!/bin/bash
#FLUX: --job-name=WRF
#FLUX: -N=16
#FLUX: --exclusive
#FLUX: --priority=16

export OMP_NUM_THREADS='6'
export I_MPI_FABRICS='efa'
export I_MPI_PIN_DOMAIN='omp'
export KMP_AFFINITY='compact'
export I_MPI_DEBUG='4'

source ~/.bashrc
cd $HOME/wrf/conus_12km
cat > slurm-wrf-conus12km.sh <<EOF
spack load intel-oneapi-mpi
spack load wrf
wrf_exe=$(spack location -i wrf)/run/wrf.exe
set -x
ulimit -s unlimited
ulimit -a
export OMP_NUM_THREADS=6
export I_MPI_FABRICS=efa
export I_MPI_PIN_DOMAIN=omp
export KMP_AFFINITY=compact
export I_MPI_DEBUG=4
time mpiexec.hydra -np \$SLURM_NTASKS --ppn \$SLURM_NTASKS_PER_NODE \$wrf_exe
echo $? > wrf.exit.code
EOF
echo; echo "Running sbatch slurm-wrf-conus12km.sh from ${PWD}"
sbatch slurm-wrf-conus12km.sh

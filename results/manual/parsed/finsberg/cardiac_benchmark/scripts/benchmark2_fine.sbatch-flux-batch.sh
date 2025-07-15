#!/bin/bash
#FLUX: --job-name="cardiac-benchmark"
#FLUX: -n=8
#FLUX: --queue=milanq
#FLUX: -t=259200
#FLUX: --priority=16

export MKL_NUM_THREADS='$SLURM_NTASKS'
export OMP_NUM_THREADS='$SLURM_NTASKS'

module use /global/D1/homes/james/ex3modules/milanq/202309a/modulefiles
module load python-fenics-dolfin-2019.1.0.post0
export MKL_NUM_THREADS=$SLURM_NTASKS
export OMP_NUM_THREADS=$SLURM_NTASKS
LIBRARY_ROOT=/home/henriknf/local/src/cardiac_benchmark
SCRATCH_DIRECTORY=/global/D1/homes/${USER}/cardiac_benchmark/benchmark2/fine/${SLURM_JOBID}
mkdir -p ${SCRATCH_DIRECTORY}
echo "Scratch directory: ${SCRATCH_DIRECTORY}"
echo "Run command: ${LIBRARY_ROOT}/venv/bin/cardiac-benchmark benchmark2 --outdir "${SCRATCH_DIRECTORY}" --geometry-path "${LIBRARY_ROOT}/biv_ellipsoid_fine.h5""
srun -n 8 ${LIBRARY_ROOT}/venv/bin/cardiac-benchmark benchmark2 --outdir "${SCRATCH_DIRECTORY}" --geometry-path "${LIBRARY_ROOT}/biv_ellipsoid_fine.h5"
cp slurm-output/${SLURM_JOBID}-cardiac-benchmark-std* ${SCRATCH_DIRECTORY}

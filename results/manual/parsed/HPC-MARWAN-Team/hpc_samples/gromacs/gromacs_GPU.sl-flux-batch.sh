#!/bin/bash
#FLUX: --job-name=Gromacs
#FLUX: -c=20
#FLUX: --queue=gpu-testq
#FLUX: --urgency=16

export WORK_DIR='$PWD/gmx${SLURM_JOB_ID}'
export INPUT_DIR='$PWD/ubiquitin'
export OMP_NUM_THREADS='$omp_threads'

module load GROMACS/2021.3-foss-2021a-CUDA-11.3.1
export WORK_DIR=$PWD/gmx${SLURM_JOB_ID}
export INPUT_DIR=$PWD/ubiquitin
[[ -z $INPUT_DIR ]] && { echo "Error: Input Directory (INPUT_DIR) is not defined "; exit 1; }
[[ ! -d $INPUT_DIR ]] && { echo "Error:Input Directory (INPUT_DIR) does not exist "; exit 1; }
mkdir -p $WORK_DIR
cp -R $INPUT_DIR/* $WORK_DIR
cd $WORK_DIR
echo "Running Gromacs at $WORK_DIR"
if [ -n "$SLURM_CPUS_PER_TASK" ]; then
  omp_threads=$SLURM_CPUS_PER_TASK
else
  omp_threads=1
fi
export OMP_NUM_THREADS=$omp_threads
gmx_mpi pdb2gmx -f 1ubq.pdb -o protein.gro  -ff amber03 -water tip3p
gmx_mpi mdrun -v   -deffnm em
echo "Done"

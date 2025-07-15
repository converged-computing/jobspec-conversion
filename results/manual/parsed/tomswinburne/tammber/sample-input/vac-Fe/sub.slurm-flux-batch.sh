#!/bin/bash
#FLUX: --job-name=swampy-butter-5250
#FLUX: -N=10
#FLUX: --exclusive
#FLUX: -t=900
#FLUX: --priority=16

set -e
module load intel/19.4 intelmpi/2019.4.243  boost/1_69_0
ulimit -s unlimited
TAMMBER_WORK_MANAGERS=1 # need one manager for every ~500 workers
TAMMBER_CORES_PER_WORKER=1 # one core per ~20k atoms with typical LAMMPS scaling
TAMMBER_PAD_NODES=0 # only required for very large jobs
TAMMBER_SEED=2345 # random number seed
TAMMBER_BIN=/path/to/tammber/repo/build/tammber
srun -l ${TAMMBER_BIN} ${SLURM_JOB_NUM_NODES} ${SLURM_NTASKS_PER_NODE} ${TAMMBER_CORES_PER_WORKER} ${TAMMBER_WORK_MANAGERS} ${TAMMBER_PAD_NODES} ${TAMMBER_SEED}

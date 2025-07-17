#!/bin/bash
#FLUX: --job-name=salted-platanos-0692
#FLUX: -t=86340
#FLUX: --urgency=16

runs=$(pwd)
MPI_Run=$(dirname "$runs")
optfdir=$(dirname "$MPI_Run")
module load python/3.8
module load scipy-stack
module load mpi4py
cd $SLURM_TMPDIR/
source ~/ENV_2/bin/activate # activate environment
cp -v $MPI_Run/s2_newscores/main_s2_eo.py ./
cp -v $MPI_Run/fenv.py ./
cp -v $MPI_Run/fscore.py ./
cp -v $MPI_Run/s2_newscores/algo_s2_eo.py ./
cp -v $MPI_Run/s2_newscores/loss_model_global_mpi_s2_eo.py ./
cp -v $MPI_Run/s2_newscores/func_model_s2.py ./
cp -v $MPI_Run/MPI_array_allocation.py ./
cp -v $optfdir/input_files/* ./
mpiexec -n 32 python3 main_s2_eo.py --prior=$MPI_Run/prior_classic_scenario1w.txt --loss=$MPI_Run/s2_newscores/loss_model_global_mpi_s2_eo.py --algo=tpe --iter=100
cp -v ./s2_eo_opt_out_* $MPI_Run/outputs

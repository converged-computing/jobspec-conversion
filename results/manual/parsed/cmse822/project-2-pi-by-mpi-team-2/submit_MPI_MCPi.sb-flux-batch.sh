#!/bin/bash
#FLUX: --job-name=MC_Pi
#FLUX: -t=28800
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR                   ### change to the directory where your code is located
module purge
module load gcc/7.3.0-2.30 openmpi hdf5 python git
RUN_NAME=$1
mpicxx -o $RUN_NAME src/Ser_PI_Calc_MPI.cpp
DartValues=(1000 10000 100000 1000000 10000000)
RoundValues=(128)
TaskValues=(1 2 4 8 16 32 64)
for Darts in "${DartValues[@]}"; do
    for Rounds in "${RoundValues[@]}"; do
        for Tasks in "${TaskValues[@]}"; do
            mpiexec -n "$Tasks" $RUN_NAME "$Darts" "$Rounds" "$RUN_NAME.csv"
        done
    done
done
DartValues=(100000000 1000000000)
RoundValues=(128)
TaskValues=(16 32 64)
for Darts in "${DartValues[@]}"; do
    for Rounds in "${RoundValues[@]}"; do
        for Tasks in "${TaskValues[@]}"; do
            mpiexec -n "$Tasks" $RUN_NAME "$Darts" "$Rounds" "$RUN_NAME.csv"
        done
    done
done
rm $RUN_NAME
scontrol show job $SLURM_JOB_ID     ### write job information to output file

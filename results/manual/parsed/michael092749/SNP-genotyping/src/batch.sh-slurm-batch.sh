#!/bin/bash
#FLUX: --job-name=mpi_job
#FLUX: -N=2
#FLUX: -c=6
#FLUX: --urgency=16

cargo build --release
mpirun -n 4 ../target/release/final_code  /dataE/AWIGenGWAS/aux/sample_sheet.csv /dataE/AWIGenGWAS/idats /dataE/AWIGenGWAS/aux/H3Africa_2017_20021485_A3.csv

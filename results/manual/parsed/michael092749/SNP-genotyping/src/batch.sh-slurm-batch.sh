#!/bin/bash
#SBATCH --job-name=mpi_job
#SBATCH --output=output.txt
#SBATCH --error=error.txt
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --constraint=ntasks-per-node=2

cargo build --release
mpirun -n 4 ../target/release/final_code  /dataE/AWIGenGWAS/aux/sample_sheet.csv /dataE/AWIGenGWAS/idats /dataE/AWIGenGWAS/aux/H3Africa_2017_20021485_A3.csv

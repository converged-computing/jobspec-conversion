#!/bin/bash
#SBATCH --job-name=job
#SBATCH --account=project_465000712
#SBATCH --output=lcm_d.csv
#SBATCH --error=lcm_d.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=128
#SBATCH --mem=200000
#SBATCH --time=1-00:00:00
#SBATCH --partition=ju-standard
#SBATCH: --exclusive

cd /users/panastas/partially-strided-codelet
> lcm_d.csv
> lcm_d.err
module load gcc/12.2.0 2>&1
make clean; make -j
./run.sh

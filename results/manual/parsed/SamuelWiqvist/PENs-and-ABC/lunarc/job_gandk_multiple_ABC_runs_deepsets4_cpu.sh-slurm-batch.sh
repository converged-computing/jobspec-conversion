#!/bin/bash
#SBATCH --job-name=gandk_multi_ABC_deepsets4
#SBATCH --account=lu2018-2-22
#SBATCH --output=lunarc_output/gandk/outputs_gandk_multiple_deepsets_%j.out
#SBATCH --error=lunarc_output/gandk/errors_gandk_multiple_deepsets_%j.err
#SBATCH --mail-user=samuel.wiqvist@matstat.lu.se
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=11000
#SBATCH --time=4-04:00:00
#SBATCH --partition=lu

ml load GCC/6.4.0-2.28
ml load OpenMPI/2.1.2
ml load julia/1.0.0
pwd
cd ..
pwd
julia /home/samwiq/'ABC and deep learning project'/abc-dl/src/'g and k dist'/multiple_ABC_runs_deepsets.jl standard 5 4 0

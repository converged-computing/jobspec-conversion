#!/bin/bash
#SBATCH --account=def-aparamek
#SBATCH --output=/scratch/grovert4/SLURM/slurm-%x-%j.txt
#SBATCH --mail-user=tanmay.grover@mail.utoronto.ca
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=200
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4000MB
#SBATCH --time=08:00:00

module load StdEnv/2020
module load julia/1.8.5
srun julia SkX_MonoLayer_Run.jl inputParametersMonoLayer

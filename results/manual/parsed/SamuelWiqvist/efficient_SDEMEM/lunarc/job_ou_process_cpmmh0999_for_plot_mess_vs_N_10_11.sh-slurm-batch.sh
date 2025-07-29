#!/bin/bash
#SBATCH --job-name=ou_cpmmh_0999_10
#SBATCH --account=snic2019-3-630
#SBATCH --output=lunarc_output/outputs_ou_cpmmh_%j.out
#SBATCH --error=lunarc_output/errors_ou_cpmmh_%j.err
#SBATCH --mail-user=samuel.wiqvist@matstat.lu.se
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=10:00:00
#SBATCH: --exclusive

export JULIA_NUM_THREADS='1'

ml load GCC/6.4.0-2.28
ml load OpenMPI/2.1.2
ml load julia/1.0.0
pwd
cd ..
pwd
export JULIA_NUM_THREADS=1
julia /home/samwiq/'SDEMEM and CPMMH'/SDEMEM_and_CPMMH/src/'SDEMEM OU process'/run_script_cpmmh_for_plot_mess_vs_N.jl 10 0.999 11 # M_mixtures N_time nbr_particles correlation seed

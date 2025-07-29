#!/bin/bash
#SBATCH --job-name=ou_cpmmh_099
#SBATCH --account=lu2020-2-7
#SBATCH --output=lunarc_output/outputs_neuron_data_cpmmh_bridge_09_%j.out
#SBATCH --error=lunarc_output/errors_neuron_data_cpmmh_bridge_09_%j.err
#SBATCH --mail-user=samuel.wiqvist@matstat.lu.se
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=20:00:00
#SBATCH --exclusive

export JULIA_NUM_THREADS='1'

ml load GCC/6.4.0-2.28
ml load OpenMPI/2.1.2
ml load julia/1.0.0
pwd
cd ..
pwd
export JULIA_NUM_THREADS=1
julia /home/samwiq/'SDEMEM and CPMMH'/SDEMEM_and_CPMMH/src/'SDEMEM OU neuron data'/run_script_cpmmh_bridge.jl 0.9 1 $1

#!/bin/bash
#SBATCH --job-name=a3757
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --mem=0
#SBATCH --constraint=ntasks-per-node=1

export JULIA_PROJECT='julia16'

set -ev
source venv39/bin/activate
echo $PATH
which python3
nprocs=30
echo "Nprocs = $nprocs"
uptime
python=python3
export JULIA_PROJECT=julia16
julia=julia
R=R
cd code
$julia  ./population_predictions.jl
$python ./ML_population_predictions.py
$julia  ./OSAP_predictions.jl
$python ./ML_osap.py
$julia  ./crosstreat_population_predictions.jl
$julia  ./simulating_data_and_testing_procedure.jl
$julia  ./Distributions_ei_sizeRD.jl
$julia  ./sfem_on_learn.jl
$julia  ./sim_perf.jl
$julia  ./sims_sizeRD_and_avg_C.jl
$julia  ./Read_results.jl
$julia  ./generate_OSAP_table.jl
$R CMD BATCH     ./Descriptives_and_plots.R

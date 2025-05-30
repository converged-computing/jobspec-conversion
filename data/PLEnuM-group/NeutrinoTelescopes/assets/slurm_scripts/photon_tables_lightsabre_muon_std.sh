#!/bin/bash
#SBATCH -N 1
#SBATCH --job-name=photon_tables
#SBATCH --ntasks=1
#SBATCH --time=12:00:00
#SBATCH --gres=gpu:1
#SBATCH -o logs/lightsabre_%A-%a.out
#SBATCH -e logs/lightsabre_%A-%a.err

n_sims=1000
n_skip=$((SLURM_ARRAY_TASK_ID * n_sims))

start=$(date +%s)

out_folder=$WORK/photon_tables/lightsabre/

cd ~/.julia/dev/NeutrinoTelescopes/ && /home/hpc/capn/capn100h/.juliaup/bin/julia --project=. scripts/photon_tables/photon_tables_photons.jl --n_sims=${n_sims} --n_skip=${n_skip} --output $out_folder/photon_table_lightsabre_${SLURM_ARRAY_TASK_ID}.hd5 --dist_min=1 --dist_max=200 --mode lightsabre_muon | exit 1
end=$(date +%s)
echo "Elapsed Time: $(($end-$start)) seconds"
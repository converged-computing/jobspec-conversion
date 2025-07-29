#!/bin/bash
#SBATCH --job-name=sim_proc_0_5
#SBATCH --output=./Reports/output_%j.out
#SBATCH --error=./Reports/error_%j.err
#SBATCH --mail-user=swamini.khurana@natgeo.su.se
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=20000
#SBATCH --time=10:00:00
#SBATCH --chdir=/proj/hs_micro_div_072022

module load buildtool-easybuild/4.5.3-nsce8837e7
module load foss/2020b
module load Anaconda/2021.05-nsc1
conda activate ds-envsci-env
python "/home/x_swakh/tools/HoliSoils/Scripts/Linux/transient/Simulation_processing/decay_const_diff_c_pools_time_initial_conditions.py" "gen_spec_lognorm"

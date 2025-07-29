#!/bin/bash
#SBATCH --job-name=sbc_cp_ksc_model_cp_dgf_10kmcmc_3000_niter_r1
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --mem=4096
#SBATCH --time=12:00:00
#SBATCH --constraint=ntasks-per-socket=1
#SBATCH --array=1

R --vanilla < scripts/sim_ksc_results.r

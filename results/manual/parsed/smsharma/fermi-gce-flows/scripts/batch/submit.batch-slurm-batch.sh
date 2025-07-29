#!/bin/bash
#SBATCH --mail-user=sm8383@nyu.edu
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=24GB
#SBATCH --time=1-23:59:00
#SBATCH --constraint=ntasks-per-node=24

module load gsl/intel/2.6 
conda activate sbi-fermi
cd /scratch/sm8383/fermi-gce-flows
python nptfit.py --sample_name ModelO_DM_only --n_cpus 24 --r_outer 25 --n_live 1000 --disk_type thin --i_mc 4 --diffuse ModelO --new_ps_priors 0

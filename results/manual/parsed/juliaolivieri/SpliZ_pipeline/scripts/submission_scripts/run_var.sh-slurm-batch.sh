#!/bin/bash
#SBATCH --job-name=var
#SBATCH --output=/scratch/PI/horence/JuliaO/single_cell/SZS_pipeline2/scripts/job_output/var.%j.out
#SBATCH --error=/scratch/PI/horence/JuliaO/single_cell/SZS_pipeline2/scripts/job_output/var.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=40G
#SBATCH --time=06:00:00

date
DATANAME="Tabula_muris_senis_P2_10x_with_postprocessing_cellann"
SUB="tissue"
GROUP="compartment"
a="python3.6 -u /scratch/PI/horence/JuliaO/single_cell/SZS_pipeline2/scripts/variance_adjusted_permutations_bytiss.py --group_col ${GROUP} --suffix _S_0.1_z_0.0_b_5 --dataname ${DATANAME} --num_perms 100 --sub_col ${SUB}"
echo $a 
eval $a
date

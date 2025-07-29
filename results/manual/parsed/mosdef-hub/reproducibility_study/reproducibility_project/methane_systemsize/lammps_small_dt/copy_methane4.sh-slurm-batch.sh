#!/bin/bash
#SBATCH --job-name=copy_methane4
#SBATCH --output=parallel_%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1gb
#SBATCH --time=1-00:05:00

. /home/rs/anaconda3/etc/profile.d/conda.sh
conda activate mosdef-study38
rsync -av /home/rs/space/projects/final_repro_methane/reproducibility_study/reproducibility_project/methane_systemsize_subproject4/* .

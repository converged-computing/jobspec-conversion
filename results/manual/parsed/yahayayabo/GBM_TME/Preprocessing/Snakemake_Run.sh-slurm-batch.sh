#!/bin/bash
#SBATCH --job-name=LIH_GME
#SBATCH --mail-user=dimitrios.kyriakis@uni.lu
#SBATCH --mail-type=end,fail
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=3
#SBATCH --time=23:59:55
#SBATCH --partition=batch
#SBATCH --qos=qos-batch
#SBATCH --constraint=ntasks-per-node=3

conda activate bioinfo_tutorial
module load swenv/default-env/devel 
module load lang/R/3.6.0-foss-2019a-bare
cd /home/users/dkyriakis/PhD/Projects/Yahaya/Scripts/
snakemake --dag | dot -Tpdf > dag.pdf
snakemake --cores 6

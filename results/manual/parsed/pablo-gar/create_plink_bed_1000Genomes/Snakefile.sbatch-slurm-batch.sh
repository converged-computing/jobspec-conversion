#!/bin/bash
#SBATCH --output=/scratch/users/paedugar/somaticMutationsProject/clusterFiles/plink.out
#SBATCH --error=/scratch/users/paedugar/somaticMutationsProject/clusterFiles/plink.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=04:00:00
#SBATCH --partition=hbfraser,hns,normal

PATH=$HOME/bin:$PATH:$HOME/.local/bin:$HOME/gatk-4.0.3.0:$HOME/samtools_1.6/bin
export PATH
MODULEPATH=$MODULEPATH:/share/PI/hbfraser/modules/modules
export MODULEPATH
module load anaconda3
source activate fraserconda
cd ~/scripts/FraserLab/make_plink_1000genomes_phase_3_GRCh38/
snakemake --nolock --printshellcmds --keep-going --cluster-config ./cluster.json --cluster-status jobState --jobs 500 --cluster "./submit.py"

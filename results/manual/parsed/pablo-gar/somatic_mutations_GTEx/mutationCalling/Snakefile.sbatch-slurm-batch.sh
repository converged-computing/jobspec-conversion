#!/bin/bash
#SBATCH --output=/scratch/users/paedugar/somaticMutationsProject/clusterFiles/1_Snakemake_mutationCalling.out
#SBATCH --error=/scratch/users/paedugar/somaticMutationsProject/clusterFiles/1_Snakemake_mutationCalling.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=3-00:00:00
#SBATCH --partition=hbfraser,hns,normal

PATH=$HOME/bin:$PATH:$HOME/.local/bin:$HOME/gatk-4.0.3.0:$HOME/samtools_1.6/bin
export PATH
MODULEPATH=$MODULEPATH:/share/PI/hbfraser/modules/modules
export MODULEPATH
module load fraserconda
source activate fraserconda
cd ~/scripts/FraserLab/somaticMutationsProject/mutationCalling/
date
echo "Start snakemake"
snakemake --keep-going --max-jobs-per-second 15 --restart-times 2 --max-status-checks-per-second 0.016 --nolock --cluster-config ../cluster.json --cluster-status jobState --jobs 500 --cluster "../submit.py"
date
echo "Snakemake done!"

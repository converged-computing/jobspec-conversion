#!/bin/bash
#SBATCH --job-name=snakeplot
#SBATCH --output=/home/jgalvis/tflex/debugdir/slurm_output/snakeplot_%j.out
#SBATCH --mail-user=juana7@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
#SBATCH --time=00:10:00
#SBATCH --exclusive
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --chdir=/home/jgalvis/tflex/debugdir/

scontrol show job $SLURM_JOB_ID
module load snakemake
echo "testing slurm plus snakemake without snakecluster config file"
snakemake --rulegraph --snakefile $HOME/tflex/Snake_qcmapcount.smk \
--configfile $HOME/cocultureProj/src1/config_qcmapall.yaml \
--cores 1 | dot -Tpdf > figutest.pdf
echo "arrivederci"

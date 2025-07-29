#!/bin/bash
#SBATCH --job-name=busco
#SBATCH --account=cea_farman_s24cs485g
#SBATCH --mail-user=wjya222@uky.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=180GB
#SBATCH --time=08:00:00
#SBATCH --partition=normal

echo "SLURM_NODELIST: "$SLURM_NODELIST
echo "PWD :" $PWD
in=$1
out=${in/\.fasta/}_busco
module load ccs/singularity
singularity run --app busco570 /share/singularity/images/ccs/conda/amd-conda14-rocky8.sinf busco \
 --in $in --out $out --mode genome --lineage_dataset ascomycota_odb10 -f

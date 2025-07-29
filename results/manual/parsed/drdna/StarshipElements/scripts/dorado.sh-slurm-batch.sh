#!/bin/bash
#SBATCH --job-name=dorado-gpu
#SBATCH --account=gol_farman_uksr
#SBATCH --mail-user=farman@uky.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --mem=28G
#SBATCH --time=2-00:00:00
#SBATCH --partition=V4V32_SKY32M192_L

pod5s=$1
container=/share/singularity/images/ccs/conda/lcc-conda-8-rocky8.sinf
module load ccs/singularity-3.8.2
singularity run --nv --app dorado034 $container dorado download --model dna_r9.4.1_e8_hac@v3.3
singularity run --nv --app dorado034 $container dorado basecaller --device 'cuda:all' dna_r9.4.1_e8_hac@v3.3 --emit-fastq $pod5s > ${pod5s/pod5_/}.fastq

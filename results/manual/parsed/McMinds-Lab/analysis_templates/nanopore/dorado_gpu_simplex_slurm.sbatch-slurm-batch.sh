#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=175G
#SBATCH --time=7-00:00:00
#SBATCH --partition=rra
#SBATCH --qos=rra

module purge
module load apps/cuda/11.3.1
~/scripts/dorado-0.5.0-linux-x64/bin/dorado basecaller --batchsize 64 --trim adapters --verbose sup /shares/pi_mcmindsr/raw_data/20231212_1932_MN45077_FAX70185_835ac3e3/pod5/ > /shares/pi_mcmindsr/outputs/20231212_1932_MN45077_FAX70185_835ac3e3_bc20231216/20231216_basecalls.bam

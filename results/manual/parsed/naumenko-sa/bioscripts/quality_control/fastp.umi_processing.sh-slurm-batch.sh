#!/bin/bash
#SBATCH --job-name=schumacher
#SBATCH --output=project_%j.out
#SBATCH --error=project_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=10G
#SBATCH --time=05:00:00

fastp -i $1 -I $2 -o ${3}_1.fq.gz -O ${3}_2.fq.gz -h $3.fastp.html --umi --umi_loc --umi_len 8 --umi_prefix CELL --umi_skip

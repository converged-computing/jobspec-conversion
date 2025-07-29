#!/bin/bash
#SBATCH --job-name=trmor2006_full_dis
#SBATCH --account=ai
#SBATCH --output=trmor2006_full_dis.out
#SBATCH --error=trmor2006_full_dis.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=32GB
#SBATCH --time=2-08:00:00
#SBATCH --partition=ai
#SBATCH --qos=ai

echo "julia main.jl --dataSet TRDataSet --version 2006 --epochs 100 --lemma --dropouts 0.3 --modelType MorseDis"
julia main.jl --dataSet TRDataSet --version 2006 --epochs 100 --lemma --dropouts 0.3 --modelType MorseDis

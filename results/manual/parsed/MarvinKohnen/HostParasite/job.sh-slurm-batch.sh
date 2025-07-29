#!/bin/bash
#SBATCH --job-name=My_Copepod
#SBATCH --mail-user=janayaro@uni-muenster.de
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=05:00:00
#SBATCH --partition=long
#SBATCH --constraint=ntasks-per-node=1

ml palma/2022a
ml Julia/1.8.2-linux-x86_64
julia  /home/j/janayaro/Projects_JM/HostParasite/CopepodParasite2D.jl

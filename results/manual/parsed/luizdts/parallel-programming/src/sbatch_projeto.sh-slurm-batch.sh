#!/bin/bash
#SBATCH --job-name=Pascal_svd
#SBATCH --output=Pascal_svd%j.out
#SBATCH --error=Pascal_svd%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:00:10
#SBATCH --partition=amd-512
#SBATCH: --exclusive
#SBATCH --constraint=ntasks-per-node=1

$cores="1,2,4,8,16,32,64,128"
pascalanalyzer -t aut -c $cores -i "./snapshot_u1_2000.txt","./snapshot_u1_4000.txt",\
"./snapshot_u1_8000.txt","./snapshot_u1_16000.txt","./snapshot_u1_20000.txt",\
"./snapshot_u1_24000.txt","./snapshot_u1_30000.txt", "./snapshot_u1_32000.txt" -o SVD.json ./svd

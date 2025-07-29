#!/bin/bash
#SBATCH --job-name=namd
#SBATCH --account=cheme_gpu
#SBATCH --output=US-%j.out
#SBATCH --error=US-%j.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=2G
#SBATCH --time=2-00:00:00
#SBATCH --partition=gpu
#SBATCH --qos=TOP
#SBATCH --constraint=ntasks-per-node=4

export PATH='/home/zulissi/software/namd/Linux-x86_64-icc/:$PATH'

module purge;
ulimit -Sn 4096;
module load NAMD cuda
export PATH=/home/junwoony/Desktop/wham/wham:$PATH
export PATH=/home/zulissi/software/namd/Linux-x86_64-icc/:$PATH
namd2 +p4 +isomalloc_sync run_namd.conf

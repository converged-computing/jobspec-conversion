#!/bin/bash
#SBATCH --job-name=Scrape
#SBATCH --mail-user=joel.niklaus@inf.unibe.ch
#SBATCH --mail-type=end,fail
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=256GB
#SBATCH --time=15-00:00:00
#SBATCH --qos=job_epyc2_long
#SBATCH --constraint=ntasks-per-node=1

python ejustice.py

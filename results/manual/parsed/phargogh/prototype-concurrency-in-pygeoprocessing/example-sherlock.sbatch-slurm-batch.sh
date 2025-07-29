#!/bin/bash
#SBATCH --job-name=dask-warp-demo
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=00:20:00
#SBATCH --partition=hns,normal

singularity run docker://ghcr.io/phargogh/prototype-concurrency-in-pygeoprocessing:latest python example-sherlock.py

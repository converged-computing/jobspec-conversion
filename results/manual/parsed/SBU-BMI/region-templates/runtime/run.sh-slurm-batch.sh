#!/bin/bash
#SBATCH --job-name=myMPI
#SBATCH --output=myMPI.o%j
#SBATCH --mail-user=username@tacc.utexas.edu
#SBATCH --mail-type=end
#SBATCH --nodes=2
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --time=01:30:00
#SBATCH --partition=development

ibrun ./PipelineManager /work/02542/gteodoro/TCGA-02-0001-01Z-00-DX1.svs-tile/  -cpu 15 -gpu 1 -s priority -w 23

#!/bin/bash
#SBATCH --job-name=MUGA_REF_BG_CHECKS
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=100GB
#SBATCH --time=04:00:00

config=/projects/compsci/vmp/USERS/widmas/MUGA_reference_data/data/GigaMUGA/chrs.txt
chr=$(sed "${SLURM_ARRAY_TASK_ID}q;d" ${config})
echo ${chr}
echo "Running Chromosome ${chr}"
singularity run docker://sjwidmay/muga_qc:latest code/GigaMUGA_ConsensusGenos.R ${chr}

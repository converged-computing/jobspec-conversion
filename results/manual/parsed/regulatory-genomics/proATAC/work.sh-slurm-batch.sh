#!/bin/bash
#SBATCH --job-name=test
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=20G

conda activate  cutadaptenv
/storage/zhangkaiLab/fanjiaqi/data/PUBATAC_pipline/PUMATAC_dependencies/nextflow/nextflow-21.04.3-all -C atac_preprocess.config run proATAC.nf -entry atac_preprocess -resume

#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/luisas/2023_SingleCellEbolaLncRNAs_NatComms/nextflow_pipelines/00_CLUSTER_Nord3/01_preprocess_GSE.batch

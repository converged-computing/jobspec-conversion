#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/Mele-Lab/2023_SingleCellEbolaLncRNAs_NatComms/nextflow_pipelines/00_CLUSTER_Nord3/02_quantify_SAbio.batch

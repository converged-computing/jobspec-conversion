#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/MatthewHaas/genome_assembly/MSI-RIS/Kimball_WR_Annotation/Scripts/Jobs/funannotate.sh

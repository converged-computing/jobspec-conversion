#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/CasperAntonPoulsen/KnowledgeDistillation/Tk-Instruct/jobs/eval_bloom3b.job

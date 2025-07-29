#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/CasperAntonPoulsen/KnowledgeDistillation/bloom_jobs/download_and_process_wikidata_en.job

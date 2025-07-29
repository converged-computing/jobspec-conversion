#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/airoldilab/HPC_model/mmm_class_code/get_reuters_doc_topic_membs.lsf

#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/khandakerrahin/parallel-huffman-coding-MPI/scripts/jobSubmissionScripts/02_huff_dec_1000.sh

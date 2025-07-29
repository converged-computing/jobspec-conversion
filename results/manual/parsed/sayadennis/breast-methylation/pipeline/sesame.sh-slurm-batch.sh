#!/bin/bash
#SBATCH --job-name=nfsesame
#SBATCH --account=p30791
#SBATCH --output=/projects/p30791/methylation/out/sesame_nextflow.out
#SBATCH --mail-user=sayarenedennis@northwestern.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
#SBATCH --time=2-00:00:00
#SBATCH --partition=normal

module purge all
module load nextflow/23.04.3
cd ~/breast-methylation/pipeline/
nextflow run -c ./sesame.nextflow.config -cache false -work-dir "/projects/p30791/methylation/nf_workdir" sesame.nf

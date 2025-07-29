#!/bin/bash
#SBATCH --output=/home/rapleeid/practice/nextflow/sysout/nextflow%j.txt
#SBATCH --error=/home/rapleeid/practice/nextflow/sysout/nextflow-er%j.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

set -e
. /data/rapleeid/conda/etc/profile.d/conda.sh
conda activate
module load nextflow
nextflow run main.nf -with-dag /home/rapleeid/practice/nextflow/flowchart.html

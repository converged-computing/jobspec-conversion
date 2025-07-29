#!/bin/bash
#SBATCH --account=
#SBATCH --output=slurm_%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=10:00:00

pwd; hostname; date
module load software/nextflow-23.04.3
cd <run directory>
work="<work directory>"
nextflow run wes/getFastqBamQualityReports.nf -w ${work} -profile local -resume --threads 4 --njobs 10

#!/bin/bash
#SBATCH --job-name=pensacola
#SBATCH --account=bphl-umbrella
#SBATCH --output=pensacola.%j.out
#SBATCH --error=pensacola.err
#SBATCH --mail-user=<EMAIL>
#SBATCH --mail-type=FAIL,END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=300gb
#SBATCH --time=2-00:00:00
#SBATCH --qos=bphl-umbrella

module load nextflow
module load longqc
APPTAINER_CACHEDIR=./
export APPTAINER_CACHEDIR
nextflow run pensacola.nf -params-file params.yaml
mv ./*.out ./output
mv ./*err ./output
dt=$(date "+%Y%m%d%H%M%S")
mv ./output ./output-$dt
rm -r ./work
rm -r ./cache

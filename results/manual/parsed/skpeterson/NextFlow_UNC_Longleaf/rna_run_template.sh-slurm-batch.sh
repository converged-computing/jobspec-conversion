#!/bin/bash
#SBATCH --job-name=rna_nf
#SBATCH --output=/path/to/slurm_out/slurm_%j.out
#SBATCH --mail-user=email@unc.edu
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=20g
#SBATCH --time=2-00:00:00

cd /work/users/path/to/work
module load nextflow/23.04.2;
module load apptainer/1.2.2-1;
nextflow run nf-core/rnaseq -r 3.14.0 -profile unc_longleaf -params-file /path/to/parameter_file.yaml

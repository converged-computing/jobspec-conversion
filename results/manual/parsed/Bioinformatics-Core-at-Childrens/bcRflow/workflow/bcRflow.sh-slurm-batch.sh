#!/bin/bash
#SBATCH --job-name=<bcr-nextflow>
#SBATCH --output=./slurm_log/bcr-nf_%A.out
#SBATCH --error=./slurm_log/bcr-nf_%A.err
#SBATCH --mail-user=your_email@sample.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=16G
#SBATCH --time=3-00:00:00

export NXF_SINGULARITY_CACHEDIR='/path/to/bcRflow/singularity-images'
export SINGULARITY_CACHEDIR='/path/to/bcRflow/singularity-images'

unset TMPDIR
module purge
module load squashfs-tools/4.4 gcc/12.2.0 nextflow/23.04.2 singularity/3.9.6
export NXF_SINGULARITY_CACHEDIR=/path/to/bcRflow/singularity-images
export SINGULARITY_CACHEDIR=/path/to/bcRflow/singularity-images
cd /path/to/bcRflow/workflow
nextflow run ./main.nf -profile slurm -resume -work-dir ./work

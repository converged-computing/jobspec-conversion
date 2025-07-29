#!/bin/bash
#SBATCH --job-name=humann2_results
#SBATCH --account=e31333
#SBATCH --output=humann2_array_%A_%a.txt
#SBATCH --error=humann2_array_%A_%a.txt
#SBATCH --mail-user=mckennafarmer2023@u.northwestern.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=48G
#SBATCH --time=2-00:00:00
#SBATCH --partition=normal
#SBATCH --array=1-15%4

module purge all
module load singularity
echo "Starting Humann2 job"
file=$(ls /projects/e31333/mckenna/humann2/kneaddata_output/*kneaddata.fastq | sed -n ${SLURM_ARRAY_TASK_ID}p)
singularity exec -B /projects/e31333 -B /projects/e31333/mckenna/humann2/kneaddata_output -B /projects/e31333/humann2_ref_data /projects/e31333/biobakery_diamondv0822.sif humann2 --input ${file} --output /projects/e31333/mckenna/humann2/ --resume --threads 4 --nucleotide-database /projects/e31333/humann2_ref_data/chocophlan --protein-database /projects/e31333/humann2_ref_data/uniref50
echo "Finishing Humann2 job"

#!/bin/bash
#SBATCH --job-name=best_gg
#SBATCH --output=slurm_%j.out
#SBATCH --mail-user=rj931@nyu.edu
#SBATCH --mail-type=FAIL,END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10GB
#SBATCH --time=10:00:00
#SBATCH --partition=cm
#SBATCH --constraint=ntasks-per-node=1

module purge
module load nextflow/23.04.1
nextflow run -resume pe_sle_pipeline.nf  --reads "/scratch/rj931/tf_sle_project/all_sle_data/45*-Bleo*cut*_{R1,R2}*.fastq.gz" --filts "filt_files/45*-Bleo*cut*_{R1,R2}*.filt*"
nextflow run -resume pe_sle_pipeline.nf  --reads "/scratch/rj931/tf_sle_project/all_sle_data/45*-Bleo*cut*_{R1,R2}*.fastq.gz" --filts "filt_files/45*-Bleo*cut*_{R1,R2}*.filt*"
find . -name *fastqc.zip > fastqc_files.txt
module load multiqc/1.9
multiqc -force --file-list fastqc_files.txt --filename 'multiqc_report.html'
JOBID1=$(sbatch --parsable --array=1-6 make_homer.sh)
sbatch --dependency=afterok:$JOBID1 homer_anno_combined.sh

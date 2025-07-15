#!/bin/bash
#FLUX: --job-name=job_name_placeholder   # Update job name to a descriptive one
#FLUX: -n=12
#FLUX: --queue=bigmem
#FLUX: -t=18000
#FLUX: --priority=16

echo -n "scRNA-Seq QC Pipeline beginning at: "; date
echo -n "scRNA-Seq cellranger Pipeline beginning at: "; date
cd /path/to/analysis/folder/   # Update to your analysis folder
mkdir raw_data_symlink
cd raw_data_symlink/
echo "Symlinking Raw Data"
ln -s /path/to/original/data/*.fastq.gz ./   # Update to the original data path
echo -n "Symlinks created in: "; pwd
source /path/to/miniconda3/etc/profile.d/conda.sh   # Update Miniconda path
conda activate scRNA-seq # Use a conda environment for this job that has been created already
echo "Running FastQC on raw data..."
fastqc *.fastq.gz
echo "FastQC on raw data complete."
echo "Moving FastQC reports..."
mkdir fastqc_reports_raw_data
mv *fastqc.html fastqc_reports_raw_data/
mv *fastqc.zip fastqc_reports_raw_data/
echo "Moving fastqc reports on raw data complete."
cd fastqc_reports_raw_data
multiqc .
cd ..
conda deactivate
echo "FASTQC and MULTIQC complete."
mv fastqc_reports_raw_data ../

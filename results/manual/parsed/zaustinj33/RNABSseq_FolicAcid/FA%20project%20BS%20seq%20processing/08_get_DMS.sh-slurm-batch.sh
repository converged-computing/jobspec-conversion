#!/bin/bash
#SBATCH --account=davidxie_lab
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=1

module load R/4.0.2-foss-2020a
mkdir -p $1"/DMS/DMS_output"
perl /projects/epigenomicslab/zaustinj/RNA_BSnew/miniScripts/Multi_Thread_DMS_Processor.pl \
-r /apps/easybuild/software/tinkercliffs-rome/R/4.0.2-foss-2020a/bin "/beegfs/projects/epigenomicslab/RNA_project/mouse_NSC_FA_project/FA_BS/DMS/"$2 "/beegfs/projects/epigenomicslab/RNA_project/mouse_NSC_FA_project/FA_BS/DMS/"$3 \
-o $1"/DMS/DMS_output/tLF_x_tMF" \
-t $1"/DMS/DMS_temp/"
directory=$1"/DMS/DMS_output/tLF_x_tMF"
outfile="$(ls -1 $directory)"
Rscript /projects/epigenomicslab/project_data/VTCRI_Methylome/DMA/DMR_scripts/DMS.p.adj.bsharmi.r $directory/$outfile RNA_meth 10

#!/bin/bash
#FLUX: --job-name=outstanding-platanos-7238
#FLUX: -n=16
#FLUX: --queue=IB_44C_512G
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_ON_NODE'

export OMP_NUM_THREADS=$SLURM_CPUS_ON_NODE
. $MODULESHOME/../global/profile.modules
module load bismark-0.22.3
module load miniconda3-4.5.11-gcc-8.2.0-oqs2mbg
pwd; hostname; date
echo "Running program on $SLURM_CPUS_ON_NODE CPU cores"
trimmed_files="/scratch/jeirinlo/jrodr979/Clonal_divergence_paper/2020-12-08-WGBS-analysis/Trimmed_reads"
genome="/scratch/jeirinlo/jrodr979/Clonal_divergence_paper/2020-12-08-WGBS-analysis/2020-12-09-Bismark/Bismark_Inputs"
find ${trimmed_files}/*_R1_001_val_1.fq.gz | xargs basename -s _R1_001_val_1.fq.gz | xargs -I{} bismark \
--path_to_bowtie ${bowtie2_dir} \
--samtools_path ${samtools_dir} \
-p 4 \
-score_min L,0,-0.9 \
--multicore ${SLURM_CPUS_ON_NODE} \
-o /scratch/jeirinlo/jrodr979/Clonal_divergence_paper/2020-12-08-WGBS-analysis/2020-12-09-Bismark/20201221_L,0,-0.9 \
--genome ${genome} \
-1 ${trimmed_files}/{}_R1_001_val_1.fq.gz \
-2 ${trimmed_files}/{}_R2_001_val_2.fq.gz \
find /scratch/jeirinlo/jrodr979/Clonal_divergence_paper/2020-12-08-WGBS-analysis/2020-12-09-Bismark/20201221_L,0,-0.9/*.bam | \
xargs basename -s .bam | \
xargs -I{} deduplicate_bismark \
--bam \
--paired \
--samtools_path ${samtools_dir} \
--output_dir /scratch/jeirinlo/jrodr979/Clonal_divergence_paper/2020-12-08-WGBS-analysis/2020-12-09-Bismark/20201221_L,0,-0.9/ \
/scratch/jeirinlo/jrodr979/Clonal_divergence_paper/2020-12-08-WGBS-analysis/2020-12-09-Bismark/20201221_L,0,-0.9/{}.bam
find /scratch/jeirinlo/jrodr979/Clonal_divergence_paper/2020-12-08-WGBS-analysis/2020-12-09-Bismark/20201221_L,0,-0.9/*deduplicated.bam \
| xargs basename -s _001_val_1_bismark_bt2.deduplicated.bam | xargs -I{} ${samtools_dir}/samtools \
sort /scratch/jeirinlo/jrodr979/Clonal_divergence_paper/2020-12-08-WGBS-analysis/2020-12-09-Bismark/20201221_L,0,-0.9/{}_001_val_1_bismark_bt2.deduplicated.bam \
-o /scratch/jeirinlo/jrodr979/Clonal_divergence_paper/2020-12-08-WGBS-analysis/2020-12-09-Bismark/20201221_L,0,-0.9/{}_dedup.sorted.bam
find /scratch/jeirinlo/jrodr979/Clonal_divergence_paper/2020-12-08-WGBS-analysis/2020-12-09-Bismark/20201221_L,0,-0.9/*dedup.sorted.bam \
| xargs basename -s _dedup.sorted.bam | xargs -I{} ${samtools_dir}/samtools \
index /scratch/jeirinlo/jrodr979/Clonal_divergence_paper/2020-12-08-WGBS-analysis/2020-12-09-Bismark/20201221_L,0,-0.9/{}_dedup.sorted.bam
bismark_methylation_extractor \
--paired-end \
--bedGraph \
--counts \
--scaffolds \
--multicore ${SLURM_CPUS_ON_NODE}  \
--buffer_size 75% \
-o /scratch/jeirinlo/jrodr979/Clonal_divergence_paper/2020-12-08-WGBS-analysis/2020-12-09-Bismark/20201221_L,0,-0.9/ \
--samtools ${samtools_dir}/samtools \
/scratch/jeirinlo/jrodr979/Clonal_divergence_paper/2020-12-08-WGBS-analysis/2020-12-09-Bismark/20201221_L,0,-0.9/*.deduplicated.bam
bismark2report
bismark2summary
source activate my_anaconda
multiqc /scratch/jeirinlo/jrodr979/Clonal_divergence_paper/2020-12-08-WGBS-analysis/2020-12-09-Bismark/20201221_L,0,-0.9/

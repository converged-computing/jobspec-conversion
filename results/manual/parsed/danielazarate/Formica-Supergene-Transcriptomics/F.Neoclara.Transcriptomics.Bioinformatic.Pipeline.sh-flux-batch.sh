#!/bin/bash
#FLUX: --job-name=alignment.job
#FLUX: -c=30
#FLUX: -t=18000
#FLUX: --urgency=16

________________________________________________________________________________________________________
________________________________________________________________________________________________________
srun -p short --pty bash -l 
squeue -u danielaz # check on status of jobs 
________________________________________________________________________________________________________
REFERENCE=/bigdata/brelsfordlab/abrelsford/form_wgs/dovetail/glacialis/glac.v0.1.fa.gz
REFERENCE=/rhome/danielaz/bigdata/transcriptomics/glacialisREF/glac.v0.1.fa.gz
/rhome/danielaz/bigdata/transcriptomics/rawfastq
/rhome/danielaz/bigdata/transcriptomics
________________________________________________________________________________________________________
ls neoclara_*_*_*_*_R1_001.fastq.gz > neoclara.R1.samples.txt
awk '{split($0,a,"_L"); print a[1]}' neoclara.R1.samples.txt > neoclara.samples.txt
__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.
https://github.com/timflutre/trimmomatic/blob/master/adapters/TruSeq3-PE.fa
vi TrueSeq3-PE.fa
>PrefixPE/1
TACACTCTTTCCCTACACGACGCTCTTCCGATCT
>PrefixPE/2
GTGACTGGAGTTCAGACGTGTGCTCTTCCGATCT
vi trimmomatic.sh 
chmod +x trimmomatic.sh 
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
date
module load trimmomatic
cd $SLURM_SUBMIT_DIR
READ1=/rhome/danielaz/bigdata/transcriptomics/raw_fastq/PLACEHOLDER_R1_001.fastq.gz
READ2=/rhome/danielaz/bigdata/transcriptomics/raw_fastq/PLACEHOLDER_R2_001.fastq.gz
OUTPUT1=/rhome/danielaz/bigdata/transcriptomics/trim_fastq
trimmomatic PE ${READ1} ${READ2} \
 ${OUTPUT1}/PLACEHOLDER.forward.paired \
 ${OUTPUT2}/PLACEHOLDER.forward.unpaired \
 ${OUTPUT2}/PLACEHOLDER.reverse.paired \
 ${OUTPUT2}/PLACEHOLDER.reverse.unpaired \
 ILLUMINACLIP:TrueSeq3-PE.fa:2:30:10 \
 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
hostname
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
while read i ; do sed "s/PLACEHOLDER/$i/g" trimmomatic.sh > trimmomatic.$i.sh; sbatch trimmomatic.$i.sh ; done<neoclara.samples.txt
neoclara_60_6_S40.forward.paired
neoclara_60_6_S40.foward.unpaired
neoclara_60_6_S40.reverse.paired
neoclara_60_6_S40.reverse.unpaired
__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.
vi neoclara.deNovo.samples 
colony_29       sm_sp   neoclara_29_5_S4.forward.paired         neoclara_29_5_S4.reverse.paired
colony_58       sp_sp   neoclara_58_6_S32.forward.paired        neoclara_58_6_S32.reverse.paired
colony_60       sm_sm   neoclara_60_2_S38.forward.paired        neoclara_60_2_S38.reverse.paired
__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.
vi trinity.sh
chmod +x trinity.sh
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
date
cd $SLURM_SUBMIT_DIR
module load trinity-rnaseq/2.14.0
SAMPLE_LIST=/rhome/danielaz/bigdata/transcriptomics/raw_fastq/neoclara.deNovo.samples 
time Trinity  --seqType fq  --samples_file ${SAMPLE_LIST} \
    --min_contig_length 150 --CPU 30 --max_memory 90G \
    --output deNovo_Neoclara_trinity
hostname
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
vi transcript.quant.sh
chmod +x transcript.quant.sh
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
date
cd /rhome/danielaz/bigdata/transcriptomics/raw_fastq
module load trinity-rnaseq/2.14.0
FASTQ=/rhome/danielaz/bigdata/transcriptomics/raw_fastq
SAMPLES=/rhome/danielaz/bigdata/transcriptomics/trinity/neoclara.trinity.IDs.txt
DE_NOVO=/rhome/danielaz/bigdata/transcriptomics/trinity/neoclara.deNovo.fa
align_and_estimate_abundance.pl --seqType fq  \
    --samples_file ${SAMPLES}  --transcripts ${DE_NOVO} \
    --est_method salmon  --trinity_mode   --prep_reference  
    # aux_info dir
    # cmd_info.json
    # lib_format_counts.json
    # libParams dir
    # logs dir 
    # quant.sf
    # quant.sf.genes 
    # The quant.sf file is the file of interest and has the following information:
        # NumReads’ corresponding to the number of RNA-Seq fragments predicted to be derived from that transcript
        # TPM: transcripts per million 
hostname
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
sbatch transcript.quant.sh 
__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.
find c*.rep.* -name "quant.sf" | tee quant_files.v2.list
__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
vi trinity.matrix.sh
chmod +x trinity.matrix.sh
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
date
cd /rhome/danielaz/bigdata/transcriptomics/raw_fastq
module load trinity-rnaseq/2.14.0
abundance_estimates_to_matrix.pl --est_method salmon \
--out_prefix Trinity --name_sample_by_basedir \
--quant_files quant_files.v1.list \
--gene_trans_map trinity_out_dir/Trinity.fasta.gene_trans_map
hostname
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
sbatch trinity.matrix.sh 
__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.
Trinity.isoform.counts.matrix 
Trinity.isoform.TMM.EXPR.matrix
__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.
vi DESeq2.sh
chmod +x DESeq2.sh
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
date
cd /rhome/danielaz/bigdata/transcriptomics/raw_fastq
module load trinity-rnaseq/2.14.0
$TRINITY_HOME/Analysis/DifferentialExpression/run_DE_analysis.pl \
      --matrix Trinity.v2.isoform.counts.matrix \
      --samples_file neoclara.samples.v2.txt  \
      --method DESeq2 \
      --output DESeq2_trans
hostname
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
sbatch DESeq2.sh 
cd DESeq2_trans_v2  
scp 'danielaz@cluster.hpcc.ucr.edu:/rhome/danielaz/bigdata/transcriptomics/raw_fastq/DESeq2_trans_v2/*.pdf' . 
scp danielaz@cluster.hpcc.ucr.edu:/rhome/danielaz/bigdata/transcriptomics/raw_fastq/Trinity.v2.isoform.counts.matrix ./isoform.matrix
scp danielaz@cluster.hpcc.ucr.edu:/rhome/danielaz/bigdata/transcriptomics/raw_fastq/DESeq2_trans_v2/diffExpr.P1e-3_C2.matrix .
__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.
vi DESeq2_DE.sh
chmod +x DESeq2_DE.sh
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
date
cd /rhome/danielaz/bigdata/transcriptomics/raw_fastq/DESeq2_trans_v2  
module load trinity-rnaseq/2.14.0
$TRINITY_HOME/Analysis/DifferentialExpression/analyze_diff_expr.pl \
      --matrix ../Trinity.v2.isoform.TMM.EXPR.matrix \
      --samples ../neoclara.samples.v2.txt  \
      -P 1e-3 -C 2 
hostname
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
sbatch DESeq2_DE.sh 
wc -l diffExpr.P1e-3_C2.matrix
scp 'danielaz@cluster.hpcc.ucr.edu:/rhome/danielaz/bigdata/transcriptomics/raw_fastq/DESeq2_trans_v2/*_heatmap.pdf' . 
__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.
vi DESeq2.dendrogram.sh
chmod +x DESeq2.dendrogram.sh
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
date
cd /rhome/danielaz/bigdata/transcriptomics/raw_fastq/DESeq2_trans_v2  
module load trinity-rnaseq/2.14.0
$TRINITY_HOME/Analysis/DifferentialExpression/define_clusters_by_cutting_tree.pl \
       --Ptree 60 -R diffExpr.P1e-3_C2.matrix.RData
hostname
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
sbatch DESeq2.dendrogram.sh
cd  diffExpr.P1e-3_C2.matrix.RData.clusters_fixed_P_60   
ERRROR !!! 
Error in is.null(Rowv) || is.na(Rowv) : 
  'length = 2' in coercion to 'logical(1)'
Calls: heatmap.3
Execution halted
Error, cmd Rscript __tmp_define_clusters.R died with ret 256 at /opt/linux/rocky/8.x/x86_64/pkgs/trinity-rnaseq/2.14.0/Analysis/DifferentialExpression/define_clusters_by_cutting_tree.pl line 213.
scp 'danielaz@cluster.hpcc.ucr.edu:/rhome/danielaz/bigdata/transcriptomics/raw_fastq/DESeq2_trans_v2/*_plots.pdf' . 
__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.
__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.
vi DESeq2.genes.sh
chmod +x DESeq2.genes.sh
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
date
cd /rhome/danielaz/bigdata/transcriptomics/raw_fastq
module load trinity-rnaseq/2.14.0
$TRINITY_HOME/Analysis/DifferentialExpression/run_DE_analysis.pl \
      --matrix Trinity.v2.gene.counts.matrix \
      --samples_file neoclara.samples.v2.txt  \
      --method DESeq2 \
      --output DESeq2_gene
hostname
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
sbatch DESeq2.genes.sh
cd DESeq2_gene
scp 'danielaz@cluster.hpcc.ucr.edu:/rhome/danielaz/bigdata/transcriptomics/raw_fastq/DESeq2_gene/*.pdf' . 
__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.
vi DESeq2_genes_DE.sh
chmod +x DESeq2_genes_DE.sh
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
date
cd /rhome/danielaz/bigdata/transcriptomics/raw_fastq/DESeq2_gene
module load trinity-rnaseq/2.14.0
$TRINITY_HOME/Analysis/DifferentialExpression/analyze_diff_expr.pl \
      --matrix ../Trinity.v2.gene.TMM.EXPR.matrix \
      --samples ../neoclara.samples.v2.txt  \
      -P 1e-3 -C 2 
hostname
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
sbatch DESeq2_genes_DE.sh 
wc -l diffExpr.P1e-3_C2.matrix 
ERROR !!
[1] "Reading matrix file."
Error in is.null(Rowv) || is.na(Rowv) : 
  'length = 2' in coercion to 'logical(1)'
Calls: heatmap.3
Execution halted
Error, cmd: Rscript diffExpr.P1e-3_C2.matrix.R died with ret 256 at /bigdata/operations/pkgadmin/opt/linux/centos/8.x/x86_64/pkgs/trinity-rnaseq/2.14.0/Analysis/DifferentialExpression/PtR line 1703.
Error, Error, cmd: /bigdata/operations/pkgadmin/opt/linux/centos/8.x/x86_64/pkgs/trinity-rnaseq/2.14.0/Analysis/DifferentialExpression/PtR -m diffExpr.P1e-3_C2.matrix --log2 --heatmap --min_colSums 0 --min_ro
wSums 0 --gene_dist euclidean --sample_dist euclidean --sample_cor_matrix --center_rows --save  -s ../neoclara.samples.v2.txt died with ret 6400 at /opt/linux/rocky/8.x/x86_64/pkgs/trinity-rnaseq/2.14.0/Analy
sis/DifferentialExpression/analyze_diff_expr.pl line 272.
scp 'danielaz@cluster.hpcc.ucr.edu:/rhome/danielaz/bigdata/transcriptomics/raw_fastq/DESeq2_genes/*_heatmap.pdf' . 
__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.
vi DESeq2_genes_dendrogram.sh
chmod +x DESeq2_genes_dendrogram.sh
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
date
cd /rhome/danielaz/bigdata/transcriptomics/raw_fastq/DESeq2_genes
module load trinity-rnaseq/2.14.0
$TRINITY_HOME/Analysis/DifferentialExpression/define_clusters_by_cutting_tree.pl \
       --Ptree 60 -R diffExpr.P1e-3_C2.matrix.RData
hostname
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
sbatch DESeq2_genes_dendrogram.sh
cd diffExpr.P1e-3_C2.matrix.RData.clusters_fixed_P_60 
scp 'danielaz@cluster.hpcc.ucr.edu:/rhome/danielaz/bigdata/transcriptomics/raw_fastq/DESeq2_genes/*_plots.pdf' . 
__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.
mkdir Trinotate 
cd Trinotate 
vi trinotate.ORFs.sh
chmod +x trinotate.ORFs.sh
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
date
cd /rhome/danielaz/bigdata/transcriptomics/raw_fastq/Trinotate
module load transdecoder/5.5.0 
DE_NOVO_FA=/rhome/danielaz/bigdata/transcriptomics/trinity/neoclara.deNovo.fa   
$TRANSDECODER_HOME/TransDecoder.LongOrfs -t ${DE_NOVO_FA} --output_dir . 
$TRANSDECODER_HOME/TransDecoder.Predict -t ${DE_NOVO_FA}  --output_dir . 
hostname
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
sbatch trinotate.ORFs.sh
neoclara.deNovo.fa.transdecoder.pep
__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.
wget ftp://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/complete/uniprot_sprot.fasta.gz
gunzip uniprot_sprot.fasta.gz
makeblastdb -in uniprot_sprot.fasta -out uniprot_sprot.fasta -input_type fasta -dbtype prot 
vi blast.swissprot.sh
chmod +x blast.swissprot.sh
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
date
cd /rhome/danielaz/bigdata/transcriptomics/blast
module load ncbi-blast/2.14.0+ 
SWISSPROT_DB=/rhome/danielaz/bigdata/transcriptomics/blast/uniprot_sprot.fasta 
DE_NOVO_FA=/rhome/danielaz/bigdata/transcriptomics/trinity/neoclara.deNovo.fa  
blastx -db ${SWISSPROT_DB} \
         -query ${DE_NOVO_FA} -num_threads 2 \
         -max_target_seqs 1 -outfmt 6 -evalue 1e-5 \
          > swissprot.blastx.outfmt6
hostname
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
sbatch blast.swissprot.sh
vi blast.pep.swissprot.sh
chmod +x blast.pep.swissprot.sh
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
date
cd /rhome/danielaz/bigdata/transcriptomics/blast
module load ncbi-blast/2.14.0+ 
SWISSPROT_DB=/rhome/danielaz/bigdata/transcriptomics/blast/uniprot_sprot.fasta 
PEP=/rhome/danielaz/bigdata/transcriptomics/raw_fastq/Trinotate/neoclara.deNovo.fa.transdecoder.pep
blastp -db ${SWISSPROT_DB} \
         -query ${PEP} -num_threads 2 \
         -max_target_seqs 1 -outfmt 6 -evalue 1e-5 \
          > swissprot.blastp.pep.outfmt6
hostname
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
sbatch blast.pep.swissprot.sh
vi hmmmscan.sh
chmod +x hmmscan.sh
wget https://ftp.ebi.ac.uk/pub/databases/Pfam/current_release/Pfam-A.hmm.gz
gunzip Pfam-A.hmm.gz 
hmmpress Pfam-A.hmm 
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
date
cd /rhome/danielaz/bigdata/transcriptomics/blast
module load hmmer/3.3.2 
SWISSPROT_DB=/rhome/danielaz/bigdata/transcriptomics/blast/uniprot_sprot.fasta 
PEP=/rhome/danielaz/bigdata/transcriptomics/raw_fastq/Trinotate/neoclara.deNovo.fa.transdecoder.pep
PFAM=/rhome/danielaz/bigdata/transcriptomics/blast/Pfam-A.hmm  
hmmscan --cpu 2 --domtblout TrinotatePFAM.out \
          ${PFAM} ${PEP}
hostname
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
sbatch hmmmscan.sh
__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.
vi alignment.sh
chmod +x alignment.sh
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
date
cd /rhome/danielaz/bigdata/transcriptomics/chr3
module load bwa-mem2
REFERENCE=/rhome/danielaz/bigdata/polyergus/fselysi/f_selysi_v02.fasta
DE_NOVO_FA=/rhome/danielaz/bigdata/transcriptomics/trinity/neoclara.deNovo.fa 
bwa-mem2 mem -t 8 ${REFERENCE} ${DE_NOVO_FA} > neoclara.de.novo.sam
hostname
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.
sbatch alignment.sh
neoclara.de.novo.sam
__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.
python3 chrExtractor.py --input neoclara.de.novo.sam
wc -l neoclara.de.novo.sam.scaffExtract 
cp /rhome/danielaz/bigdata/transcriptomics/raw_fastq/DESeq2_trans_v2/diffExpr.P1e-3_C2.matrix . 
python3  UniqScaffMatchr.py  --input1 diffExpr.P1e-3_C2.matrix --input2 neoclara.de.novo.sam.scaffExtract 
neoclara.de.novo.sam.scaffExtract.scaffsMatched
diffExpr.P1e-3_C2.matrix.scaffsMatched
cd /rhome/danielaz/bigdata/transcriptomics/raw_fastq/DESeq2_gene
python  --file1 diffExpr.P1e-3_C2.matrix --file2 neoclara.de.novo.sam.scaffExtract  
__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.__.
squeue -u danielaz

#!/bin/bash
#FLUX: --job-name='adiff'
#FLUX: --priority=16

"This script needs to run form inside the folder scripts in a working project with the following structure:
project/scripts
project/raw_data
Raw data needs to be labeled in the following fashion:
Sample_serial-Folder-Line-Time_point/day_of_life(day_post_Treament)-treament-REPlicate-READ
and with the exact number of characters as in the example bellow:
S_001-F_HaTS-L____N2-__0-____-REP_1-READ_1.fastq.gz
S_XXX-F_XXXX-L_XXXXX-XXX-XXXX-REP_X-READ_x.fastq.gz
Please notice that for paired samples, the S_XXX is the same.
Make sure you have edited the last section of this script - cuffdiff - before you execute this script." > /dev/null 2>&1
HOMESOURCE="source ~/.bashrc"
SLURMPARTITION="blade,himem,hugemem,dontuseme"
SHIFTER="shifter --image=hub.age.mpg.de/bioinformatics/software:v2.0.5 /bin/bash"
SHIFTERSEQC="shifter --image=index.docker.io/paulklemm/seqc"
SE_unstr=("YiTS" "YiDR" "YiIS" "ShTe")
SE_str=("Yid1" "OeDA" "AgMi")
PE_str=("RoSt" "HaTS" "HaIS")
PE_uns=("XHFC")
mix=("Yid3")
unstr=("YiTS" "YiDR" "YiIS" "ShTe" "XHFC")
str=("Yid1" "OeDA" "RoSt" "HaTS" "HaIS" "AgMi" )
series="HaIS"
ann=/beegfs/common/genomes/caenorhabditis_elegans/89/
ori_GTF=${ann}original.gtf
hisat_index=${ann}toplevel_hisat2/index.fa
adapters_file=/beegfs/group_bit/home/JBoucas/documents/TruSeqAdapters.txt
genome=${hisat_index}
ORGANISMTAG="MUS"
SPECIES="'mus musculus'"
DATASET="mmusculus_gene_ensembl"
DAVIDUSER="Registered.Email@david.com" \
HOST="http://dec2017.archive.ensembl.org/biomart/"
echo "Creating required folders"
mkdir -p ../slurm_logs
mkdir -p ../fastqc_output
mkdir -p ../tmp
mkdir -p ../flexbar_output
mkdir -p ../hisat_output
mkdir -p ../stringtie_output
mkdir -p ../cuffmerge_output
mkdir -p ../cuffdiff_output
mkdir -p ../cuffquant_output
mkdir -p ../featureCounts_output
mkdir -p ../multiqc_output
mkdir -p ../seqc_output
top=$(readlink -f ../)/
tmp=$(readlink -f ../tmp)/
raw=$(readlink -f ../raw_data)/
rawt=$(readlink -f ../flexbar_output)/
merg=$(readlink -f ../cuffmerge_output)/ 
qua=$(readlink -f ../cuffquant_output)/ 
mqc=$(readlink -f ../multiqc_output)/ 
logs=$(readlink -f ../slurm_logs)/
biotypes_header=$(cat <<'EOF'
EOF
);
function contains() {
    local n=$#
    local value=${!n}
    for ((i=1;i < $#;i++)) {
        if [ "${!i}" == "${value}" ]; then
            echo "y"
            return 0
        fi
    }
    echo "n"
    return 1
}
echo "Starting FASTQC"
cd ${raw} 
for serie in $series; do
    cd ${raw}
    for file in $(ls *${serie}*.fastq.gz); do 
sbatch --partition $SLURMPARTITION << EOF
module load shifter
${SHIFTER} << SHI
${HOMESOURCE}
module load jdk fastqc
cd ${raw}
fastqc -t 4 -o ../fastqc_output ${file}
SHI
EOF
    done
done
ids=
cd ${rawt}
for serie in $series; do
    cd ${raw}
    for file in $(ls *${serie}*1.fastq.gz); do
        # Libraries and paired end vs. single end settings for HISAT    
        if [[ $(contains "${SE_unstr[@]}" "$serie") == "y" ]]; then
            lib=
            files="-U ${file}"
        elif [[ $(contains "${PE_uns[@]}" "$serie") == "y" ]]; then
            lib=
            files="-1 ${file} -2 ${file::(-10)}2.fastq.gz"
        elif [[ $(contains "${SE_str[@]}" "$serie") == "y" ]]; then
            lib="--rna-strandness R"
            files="-U ${file}"
        elif [[ $(contains "${PE_str[@]}" "$serie") == "y" ]]; then
            lib="--rna-strandness RF"
            files="-1 ${file} -2 ${file::(-10)}2.fastq.gz"
        elif [[ $(contains "${mix[@]}" "$serie") == "y" ]]; then
            files=-U ${file}
            REP=${file:30:5}
            if [[ ${REP} == REP_3 ]]; then
                lib="--rna-strandness R"
            else
                lib=
            fi
        fi
rm -rf ${logs}HS_ST_${file::(-16)}.*.out 
ids=${ids}:$(sbatch --partition $SLURMPARTITION --parsable -o ${logs}HS_ST_${file::(-16)}.%j.out << EOF
module load shifter
${SHIFTER} << SHI
${HOMESOURCE}
cd ${raw}
module load bowtie
module load hisat
hisat2 -p 18 ${lib} --dta-cufflinks --met-file ${top}hisat_output/${file::(-16)}.stats \
-x ${hisat_index} -S ${top}hisat_output/${file::(-16)}.sam \
${files}
cd ${top}hisat_output
module load samtools
samtools view -@ 18 -bhS -F 4 ${file::(-16)}.sam | samtools sort -@ 18 -o ${file::(-16)}.bam -
rm -rf ${file::(-16)}.sam
echo "samtools index ${file::(-16)}.bam ${file::(-16)}.bam.bai"
samtools index ${file::(-16)}.bam ${file::(-16)}.bam.bai
mkdir -p ${top}stringtie_output/${file::(-16)}
module load stringtie
stringtie ${file::(-16)}.bam -o ${top}stringtie_output/${file::(-16)}.gtf \
-p 18 -G ${ori_GTF} -f 0.99 \
-C ${top}stringtie_output/${file::(-16)}_full_cov.gtf \
-b ${top}stringtie_output/${file::(-16)} 
SHI
EOF
)
    done
done
echo "Waiting for HISAT and StringTie jobs${ids} to complete"
srun --partition $SLURMPARTITION -d afterok${ids} echo "HiSat and StringTie done. Starting cuffmerge"
for serie in $series; do
    rm -rf ${tmp}assemblies_${serie}.txt
    cd ${top}stringtie_output
    mkdir -p full_coverage
    mv *_full_cov.gtf full_coverage
    # Select only transcripts which have full coverage
    cd full_coverage
    for gtf in $(ls *${serie}*.gtf); do
        readlink -f ${gtf} >> ${tmp}assemblies_${serie}.txt
    done
    cd ${top}
    mkdir -p cuffmerge_output/${serie}
    cmout=$(readlink -f cuffmerge_output/${serie})/
    echo ${serie}
id=$(sbatch --partition $SLURMPARTITION --parsable << EOF
module load shifter
${SHIFTER} << SHI
${HOMESOURCE}
cd ${top}
module load cufflinks
cuffmerge -p 2 \
-o ${cmout} --min-isoform-fraction 1.0 \
-g ${ori_GTF} -s ${genome} ${tmp}assemblies_${serie}.txt
SHI
EOF
)
done
srun --partition $SLURMPARTITION -d afterok:${id} echo "Done with cuffmerge"
cd ${tmp}
echo "Starting cuffquant"
ids=
for serie in $series; do
    # Library settings for cuffquant
    if [[ $(contains "${unstr[@]}" "$serie") == "y" ]]; then
        lib="fr-unstranded"
    elif [[ $(contains "${str[@]}" "$serie") == "y" ]]; then
        lib="fr-firststrand"
    elif [[ $(contains "${mix[@]}" "$serie") == "y" ]]; then
        lib="fr-unstranded"
    fi
    cd ${top}hisat_output
    for file in $(ls *${serie}*.bam); do 
rm -rf ${logs}quant_${file::(-4)}.*.out
ids=${ids}:$(sbatch --partition $SLURMPARTITION --parsable << EOF
module load shifter
${SHIFTER} << SHI
${HOMESOURCE}
cd ${top}cuffquant_output
mkdir ${serie}
cd ${serie}
module load cufflinks
cuffquant -p 18 --library-type ${lib} \
-o ${file::(-4)} \
${top}cuffmerge_output/${serie}/merged.gtf \
${top}hisat_output/${file}
SHI
EOF
)
    done
done
echo "Waiting for cuffquant jobs${ids} to complete"
srun --partition $SLURMPARTITION -d afterok${ids} echo "Cuffquant done. Starting featureCounts."
echo "Starting featureCount"
ids=
for serie in $series; do
    # Library settings for featureCounts
    if [[ $(contains "${unstr[@]}" "$serie") == "y" ]]; then
        featureCounts_direction=0
    elif [[ $(contains "${str[@]}" "$serie") == "y" ]]; then
        featureCounts_direction=2
    elif [[ $(contains "${mix[@]}" "$serie") == "y" ]]; then
        featureCounts_direction=0
    fi
    cd ${top}hisat_output
    echo $(pwd)
    for file in $(ls *${serie}*.bam); do 
rm -rf ${logs}featureCount_${file::(-4)}.*.out
ids=${ids}:$(sbatch --partition $SLURMPARTITION --parsable << EOF
module load shifter
${SHIFTER} << SHI
${HOMESOURCE}
module load subread
cd ${top}featureCounts_output
mkdir ${serie}
cd ${top}hisat_output
echo "featureCounts -a $ori_GTF -T 18 -g gene_id -o ${top}featureCounts_output/${serie}/${file}_gene.featureCounts.txt -p -s $featureCounts_direction ${file}"
featureCounts -a $ori_GTF -T 18 -g gene_id -o ${top}featureCounts_output/${serie}/${file}_gene.featureCounts.txt -p -s $featureCounts_direction ${file}
echo "featureCounts -a $ori_GTF -T 18 -g gene_biotype -o ${top}featureCounts_output/${serie}/${file}_biotype.featureCounts.txt -p -s $featureCounts_direction ${file}"
featureCounts -a $ori_GTF -T 18 -g gene_biotype -o ${top}featureCounts_output/${serie}/${file}_biotype.featureCounts.txt -p -s $featureCounts_direction ${file}
cut -f 1,7 ${top}featureCounts_output/${serie}/${file}_biotype.featureCounts.txt | tail -n +3 | (echo "$biotypes_header" && cat) >> ${top}featureCounts_output/${serie}/${file}_biotype_counts_mqc.txt
SHI
EOF
)
    done
done
echo "Waiting for featureCounts jobs${ids} to complete"
srun --partition $SLURMPARTITION -d afterok${ids} echo "featureCounts done. Starting cuffdiff."
ids=
serie=HaIS
mkdir -p ${top}cuffdiff_output/${serie}
dout=$(readlink -f ${top}cuffdiff_output/${serie})
lib="fr-firststrand"
rm -rf ${logs}cuffdiff.${serie}.*.out
ids=${ids}:$(sbatch --partition $SLURMPARTITION --parsable << EOF
module load shifter
${SHIFTER} << SHI
${HOMESOURCE}
cd ${qua}${serie}
module load cufflinks
cuffdiff -p 18 --library-type ${lib} \
-L N2,daf2 \
-o ${dout} --dispersion-method per-condition \
${top}cuffmerge_output/${serie}/merged.gtf \
S_160-F_HaIS-L____N2-___-____-REP_1/abundances.cxb,S_161-F_HaIS-L____N2-___-____-REP_2/abundances.cxb,S_162-F_HaIS-L____N2-___-____-REP_3/abundances.cxb \
S_163-F_HaIS-L__daf2-___-____-REP_1/abundances.cxb,S_164-F_HaIS-L__daf2-___-____-REP_2/abundances.cxb,S_165-F_HaIS-L__daf2-___-____-REP_3/abundances.cxb
SHI
EOF
)
echo "Waiting for Cuffdiff jobs${ids} to complete"
srun --partition $SLURMPARTITION -d afterok${ids} echo "Cuffdiff done. Starting MultiQC and seqc."
rm -rf ${logs}multiqc.*.out
sbatch --partition $SLURMPARTITION --parsable << EOF
${SHIFTER} << SHI
${HOMESOURCE}
module load python
cd ${top}
pip install virtualenv --user
unset PYTHONHOME
virtualenv multiqc
unset PYTHONUSERBASE
source multiqc/bin/activate
pip install multiqc --ignore-installed  
multiqc . -f -o ${mqc}
SHI
EOF
seqc_ids=
for serie in $series; do
  # Set path for cuffdiff result of series
  cuffdiff_path=${top}cuffdiff_output/${serie}
  # Set seqc output path
  output_path=${top}seqc_output/${serie}
  # Create seqc outout path
  mkdir -p $output_path
  # Remove existing logs of seqc
  rm -rf ${logs}seqc.*.out
seqc_ids=${seqc_ids}:$(sbatch --partition $SLURMPARTITION --parsable << EOF
echo $cuffdiff_path
echo $output_path
${SHIFTERSEQC} << SHI
Rscript -e "library(seqc); createHTMLReport(cuffdiff_path = '${cuffdiff_path}', output_path = '${output_path}', save_plots = FALSE)"
SHI
EOF
)
done
ids=
for serie in $series; do
  # Set path for cuffdiff result of series
  cuffdiff_path=${top}cuffdiff_output/${serie}
  # Set path for cuffmerge result of series
  cuffmerge_path=${top}cuffmerge_output/${serie}
  # Set adiff output path
  output_path=${top}adiff_output/${serie}
  # Create adiff outout path
  mkdir $output_path
  # Remove existing logs of adiff
  rm -rf ${logs}adiff.*.out
ids=${ids}:$(sbatch --partition $SLURMPARTITION --parsable << EOF
${SHIFTER} << SHI
${HOMESOURCE}
cd ${top}
module load python
pip install virtualenv --user  
unset PYTHONHOME  
virtualenv agepy
unset PYTHONUSERBASE 
source agepy/bin/activate 
pip install AGEpy
aDiff \
    --inputFolder $cuffdiff_path \
    --outputFolder $output_path \
    --originalGTF ${ori_GTF} \
    --cuffcompareGTF ${cuffmerge_path}/merged.gtf \
    --TSV \
    --organismtag ${ORGANISMTAG} \
    --species ${SPECIES} \
    --dataset ${DATASET} \
    --DAVID \
    --DAVIDid ENSEMBL_GENE_ID \
    --DAVIDuser ${DAVIDUSER} \
    --host ${HOST}
SHI
EOF
)
done
echo "Waiting for adiff jobs${ids} and seqc jobs${seqc_ids} to complete"
srun --partition $SLURMPARTITION -d afterok${seqc_ids} echo "Seqc is done."
srun --partition $SLURMPARTITION -d afterok${ids} echo "Tuxedo_v3 pipeline done."
exit

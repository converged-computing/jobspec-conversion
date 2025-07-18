#!/bin/bash
#FLUX: --job-name=lovely-cupcake-0623
#FLUX: -c=2
#FLUX: --queue=himem,hugemem,blade
#FLUX: --urgency=16

TOP=$(readlink -f ../)/
BOW=$(readlink -f ../bowtie2_output)/
QC=$(readlink -f ../fastqc_output)/
RAW=$(readlink -f ../raw_data)/
LOGS=$(readlink -f ../slurm_logs)/
GENOME=/beegfs/common/genomes/homo_sapiens/83/primary_assembly_bowtie2/index.fa
MAC=$(readlink -f ../macs2_output)/
TMP=$(readlink -f ../tmp)/
diff=$(readlink -f ../bdgdiff_output)/
peak_type="broad"
GeTAG="hs"
SHIFTER="shifter --image=mpgagebioinformatics/bioinformatics_software:v1.1.1"
mkdir -p ${LOGS} ${BOW} ${MAC} ${TMP} ${diff} ${QC}
echo "Starting FASTQC"
cd ${RAW} 
for file in $(ls *${serie}*.fastq.gz); do 
sbatch << EOF
module load shifter
${SHIFTER} << SHI
source ~/.bashrc
module load fastqc
cd ${raw}
fastqc -t 4 -o ../fastqc_output ${file}
SHI
EOF
done
IDS=""
cd ${RAW}
for f in $( ls *.* ) ; do
    rm -rf ${LOGS}${f%-READ_1.fastq.gz}.*.out
IDS=:${IDS}$(sbatch --parsable << EOF
module load shifter
$SHIFTER << SHI 
source ~/.bashrc
module load bowtie/2.2.9 samtools/1.3.1
echo ${RAW} 
cd ${RAW}
if [ -e ${f%1.fastq.gz}2.fastq.gz ]; then 
bowtie2 -p 10 -x ${GENOME} -1 ${f} -2 ${f%1.fastq.gz}2.fastq.gz -S ${BOW}${f%-READ_1.fastq.gz}.sam 
else
bowtie2 -p 10 -x ${GENOME} -U ${f} -S ${BOW}${f%-READ_1.fastq.gz}.sam 
fi
echo ${BOW}
cd ${BOW}
samtools view -@ 10 -bS ${f%-READ_1.fastq.gz}.sam > ${f%-READ_1.fastq.gz}.bam 
rm ${f%-READ_1.fastq.gz}.sam
SHI
EOF
)
done
echo "Waiting for bowtie2 jobs to complete"
srun -p himem,hugemem,blade -d afterok${IDS} echo "bowtie2 completed"
cd ${BOW}
for t in "-0000-" "-0020-"; do
    for f in $( ls *.bam | grep ${t} ); do
ctr=$(ls *INPUT*${t}*) 
sbatch << EOF
${SHIFTER} << SHI
source ~/.bashrc
module load python/2.7.13
cd ${BOW}
if [ "${peak_type}" == "broad" ]; then
    macs2 callpeak -t ${f} -c ${ctr} --broad -g ${GeTAG} --outdir ${MAC} -n ${f%.bam} -B --tempdir=${TMP} --broad-cutoff 0.1 --call-summits
else;
    macs2 callpeak -t ${f} -c ${ctr} -f BAM -g ${GeTAG} --outdir ${MAC} -n ${f%.bam} -B --tempdir=${TMP} --call-summits
fi
SHI
EOF
    done
done
exit
cd ${MAC}
for expre_treat in $( ls *treat_pileup.bdg | grep -v ctr); do 
    vector_treat=$(ls *${expre_treat:5:8}L___ctr${expre_treat:20:15}*_treat_pileup.bdg)
    expre_lambda=${expre_treat%_treat_pileup.bdg}_control_lambda.bdg
    vector_lambda=${vector_treat%_treat_pileup.bdg}_control_lambda.bdg
    expre_reads=${expre_treat%_treat_pileup.bdg}_peaks.xls
    vector_reads=${vector_treat%_treat_pileup.bdg}_peaks.xls    
    expre_reads=$( egrep "tags after filtering in treatment|tags after filtering in control" ${expre_reads} | grep control | awk '{ print $7}' )
    vector_reads=$( egrep "tags after filtering in treatment|tags after filtering in control" ${vector_reads} | grep control | awk '{ print $7}' )
    sbatch -p himem,blade,dontuseme -c 1 -o ${LOGS}${f%bam}diff.%j.out << EOF
module load python/2.7.12
cd ${MAC}
echo "--t1 ${expre_treat} --c1 ${expre_lambda} --t2 ${vector_treat} --c2 ${vector_lambda} --d1 ${expre_reads} --d2 ${vector_reads} --outdir ${diff} --o-prefix ${expre_treat%_treat_pileup.bdg}_vs_${vector_treat%_treat_pileup.bdg}"
macs2 bdgdiff --t1 ${expre_treat} --c1 ${expre_lambda} --t2 ${vector_treat} --c2 ${vector_lambda} --d1 ${expre_reads} --d2 ${vector_reads} --outdir ${diff} --o-prefix ${expre_treat%_treat_pileup.bdg}_vs_${vector_treat%_treat_pileup.bdg}
EOF
done

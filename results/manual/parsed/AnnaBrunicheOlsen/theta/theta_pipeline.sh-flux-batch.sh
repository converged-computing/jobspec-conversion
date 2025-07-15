#!/bin/bash
#FLUX: --job-name=Genus-species
#FLUX: --priority=16

export PATH='$PATH:~/genmap-build/bin'

module load bioinfo
module load bioawk
module load seqtk
module load samtools
module load BEDTools
module load BBMap
module load r
module load bedops
export PATH=$PATH:~/genmap-build/bin
genus_species=
accession=
pathway=
assembly=
cd /scratch/bell/dewoody/theta/
mkdir -p ./$genus_species/${accession}_ref
mkdir ./$genus_species/${accession}_rm
mkdir ./$genus_species/${accession}_gtf
cd $genus_species
cd ${accession}_ref
wget ${pathway}${accession}_${assembly}_genomic.fna.gz 
gunzip ${accession}_${assembly}_genomic.fna.gz
cp ${accession}_${assembly}_genomic.fna original.fa # keep a copy of the original reference
cd ../
cd ${accession}_rm
wget ${pathway}${accession}_${assembly}_rm.out.gz 
gunzip ${accession}_${assembly}_rm.out.gz
cp ${accession}_${assembly}_rm.out rm.out # keep a copy of the original repeatmasker
cd ../
cd ${accession}_gtf
wget ${pathway}${accession}_${assembly}_genomic.gtf.gz 
gunzip ${accession}_${assembly}_genomic.gtf.gz
cp ${accession}_${assembly}_genomic.gtf gtf.gtf # keep a copy of the original annotation
cd ../
ls -lh ${accession}* > download_log
grep "mitochondrion" ${accession}_ref/original.fa | cut -f 1 > mito_header.txt #If no mitochondrial sequence present in reference, will be blank. Otherwise contain header
filterbyname.sh include=f in=${accession}_ref/original.fa out=${accession}_ref/original.tmp.fa names="mitochondrion" ow=t substring=t
rm ${accession}_ref/original.fa
mv ${accession}_ref/original.tmp.fa ${accession}_ref/original.fa      
reformat.sh in=${accession}_ref/original.fa out=${accession}_ref/new.fa trd=t -Xmx20g overwrite=T
sortbyname.sh in=${accession}_ref/new.fa out=${accession}_ref/ref.fa -Xmx20g length descending overwrite=T
bioawk -c fastx '{ if(length($seq) > 100000) { print ">"$name; print $seq }}' ${accession}_ref/ref_full.fa > ${accession}_ref/ref_100kb.fa
rm ${accession}_ref/new.fa
samtools faidx ${accession}_ref/ref_100kb.fa
samtools faidx ${accession}_ref/ref.fa
cd ${accession}_rm/ 
FILE1=$"rm.out"
if [ -s $FILE1 ]
then
	# parse rm.out out to create bed coordinates
	cat rm.out |tail -n +4|awk '{print $5,$6,$7,$11}'|sed 's/ /\t/g' > repeats.bed # make bed file
else	
	# if no rm.out file is available run RepeatMasker. Note, samtools conflict so had to purge first
	module --force purge
	module load biocontainers/default
	module load repeatmasker
	RepeatMasker -pa 32 -a -qq -species mammals -dir . ../${accession}_ref/ref_100kb.fa 
	cat ref_100kb.fa.out  | tail -n +4 | awk '{print $5,$6,$7,$11}' | sed 's/ /\t/g' > repeats.bed 
fi
cd ../ 
cd ${accession}_gtf/ #move into gtf directory
FILE1=$"gtf.gtf"
if [ -s $FILE1 ]
then
	# Print message
	echo "gtf file properlly formatted" > log_gtf
else	
	# Print message
	printf "no annotation available" > log_gtf
fi
echo "STEP1-REFERENCE DOWNLOAD DONE"
module --force purge
module load bioinfo
module load TrimGalore
module load cutadapt/2.5
module load fastqc
module load sra-toolkit
cd /scratch/bell/dewoody/theta/${genus_species}/
cat $CLUSTER_SCRATCH/theta/SRA_metadata/${genus_species}.txt | sed 's/ /_/g'  > ${genus_species}_SRA.txt
mkdir -p ./sra/raw
mkdir ./sra/cleaned
mkdir ./sra/aligned
cd ./sra/raw/
cat ../../${genus_species}_SRA.txt | cut -f 1 | tail -n +2 | while read g
do
mkdir ${g}
cd ${g}
echo ${g} | xargs prefetch --max-size 500GB -O ./
echo ${g}.sra | xargs fasterq-dump -e 20 --progress
find . -name '*.fastq' -exec mv {} ../ \;
cd ../
rm -r ${g}
fastqc ${g}_1.fastq --extract --quiet
fastqc ${g}_2.fastq --extract --quiet
rm ${g}_1_fastqc.zip
rm ${g}_2_fastqc.zip
cat ${g}_1_fastqc/summary.txt ${g}_2_fastqc/summary.txt > ${g}_fastqc_summary.txt
FILE=$(grep "FAIL" ${g}_fastqc_summary.txt)
echo "raw"
echo "$FILE"
rm -r ${g}_?_fastqc* 
trim_galore --stringency 1 --length 30 --quality 20 --fastqc_args "--nogroup" -o ../cleaned --paired ${g}_1.fastq ${g}_2.fastq
cd ../cleaned
cat ${g}_1.fastq_trimming_report.txt ${g}_2.fastq_trimming_report.txt > ${g}_fastqc_summary.txt
rm ${g}_1_val_1_fastqc.zip
rm ${g}_2_val_2_fastqc.zip
FILE=$(grep "FAIL" ${g}_fastqc_summary.txt)
echo "cleaned"
echo "$FILE"
rm ${g}_fastqc_summary.txt
rm ${g}_1_val_1_fastqc.html
rm ${g}_2_val_2_fastqc.html
cd ../raw
done
echo "STEP2-SRAS DONE"
module --force purge
module load bioinfo
module load bwa
module load samtools
module load picard-tools/2.9.0
module load GATK/3.8.1
module load bamtools
mkdir /scratch/bell/dewoody/theta/${genus_species}/sra/final_bams/
cd /scratch/bell/dewoody/theta/${genus_species}/*_ref/
PicardCommandLine CreateSequenceDictionary reference=ref.fa output=ref.dict
cd /scratch/bell/dewoody/theta/${genus_species}/sra/cleaned/
bwa index -a bwtsw ../../*_ref/ref.fa
ls -1 *.fq | sed "s/_[1-2]_val_[1-2].fq//g" | uniq > cleaned_sralist
for i in `cat cleaned_sralist`
do
bwa mem -t 20 -M -R "@RG\tID:group1\tSM:${i}\tPL:illumina\tLB:lib1\tPU:unit1" ../../*_ref/ref.fa  ${i}_1_val_1.fq ${i}_2_val_2.fq > ../aligned/${i}.sam
cd /scratch/bell/dewoody/theta/${genus_species}/sra/aligned/
PicardCommandLine ValidateSamFile I=${i}.sam MODE=SUMMARY O=${i}.sam.txt
noerror=$(grep "No errors found" ${i}.sam.txt)
[[ ! "$noerror" ]] && echo "$i samfile not OK" || echo "$i samfile OK"
PicardCommandLine SortSam INPUT=${i}.sam OUTPUT=${i}_sorted.bam SORT_ORDER=coordinate
PicardCommandLine MarkDuplicates INPUT=${i}_sorted.bam OUTPUT=./${i}_marked.bam METRICS_FILE=${i}_metrics.txt
PicardCommandLine BuildBamIndex INPUT=./${i}_marked.bam
GenomeAnalysisTK -nt 20 -T RealignerTargetCreator -R ../../*_ref/ref.fa -I ${i}_marked.bam -o ${i}_forIndelRealigner.intervals
GenomeAnalysisTK -T IndelRealigner -R ../../*ref/ref.fa -I ${i}_marked.bam -targetIntervals ${i}_forIndelRealigner.intervals -o ../final_bams/${i}.bam
cd /scratch/bell/dewoody/theta/${genus_species}/sra/final_bams/
samtools flagstat ./${i}.bam > ./${i}_mapping.txt
samtools depth -a ./${i}.bam | awk '{c++;s+=$3}END{print s/c}' > ./${i}_depth.txt
samtools depth -a ./${i}.bam | awk '{c++; if($3>0) total+=1}END{print (total/c)*100}' > ./${i}_breadth.txt
cd /scratch/bell/dewoody/theta/${genus_species}/sra/cleaned/
done
echo "STEP3-MAPPING DONE"
module -force purge
module load bioinfo
module load bioawk
module load seqtk
module load samtools
module load cmake/3.9.4
module load BEDTools
module load BBMap
module load R
module load bedops
export PATH=$PATH:~/genmap-build/bin
cd /scratch/bell/dewoody/theta/${genus_species}/
genmap index -F ${accession}_ref/ref_100kb.fa -I index -S 50 # build an index 
mkdir mappability
genmap map -K 100 -E 2 -T 10 -I index -O mappability -t -w -bg                
sortBed -i ${accession}_rm/repeats.bed > ${accession}_rm/repeats_sorted.bed 
awk 'BEGIN {FS="\t"}; {print $1 FS $2}' ${accession}_ref/ref_100kb.fa.fai > ${accession}_ref/ref.genome 
awk '{print $1, $2, $2}' ${accession}_ref/ref.genome > ${accession}_ref/ref2.genome
sed -i 's/ /\t/g' ${accession}_ref/ref2.genome
sortBed -i ${accession}_ref/ref2.genome > ${accession}_ref/ref3.genome
awk '{print $1, $2 }' ${accession}_ref/ref3.genome > ${accession}_ref/ref_sorted.genome
sed -i 's/ /\t/g' ${accession}_ref/ref_sorted.genome
rm ${accession}_ref/ref.genome
rm ${accession}_ref/ref2.genome
rm ${accession}_ref/ref3.genome
bedtools complement -i ${accession}_rm/repeats_sorted.bed -g ${accession}_ref/ref_sorted.genome > ${accession}_rm/nonrepeat.bed
awk '$4 == 1' mappability/ref.genmap.bedgraph > mappability/map.bed                                           
awk 'BEGIN {FS="\t"}; {print $1 FS $2 FS $3}' mappability/map.bed > mappability/mappability.bed
sortBed -i mappability/mappability.bed > mappability/mappability2.bed
sed -i 's/ /\t/g' mappability/mappability2.bed
bedtools subtract -a mappability/mappability2.bed -b ${accession}_rm/repeats_sorted.bed > mappability/map_nonreapeat.bed
bedtools sort -i mappability/map_nonreapeat.bed > mappability/filter_sorted.bed
bedtools merge -i mappability/filter_sorted.bed > mappability/merged.bed
awk '{ print $1, $2, $2 }' ./${accession}_ref/ref_100k.fa.fai > ./${accession}_ref/ref_100kb.info
awk '$2="0"' ./${accession}_ref/ref_100kb.info > ./${accession}_ref/ref_100kb.bed
sed -i 's/ /\t/g' ./${accession}_ref/ref_100kb.bed
bedtools intersect -a ./${accession}_ref/ref_100kb.bed -b ./mappability/merged.bed > ok.bed	
rm mappability/map.bed
rm mappability/filter_sorted.bed
rm mappability/mappability2.bed
rm ${accession}_ref/ref_sorted.genome
cd /scratch/bell/${USER}/theta/source/
Rscript qc_reference_stats.R --args /scratch/bell/dewoody/theta/${genus_species}/ ${genus_species} ${accession} 
cd /scratch/bell/dewoody/theta/${genus_species}/
map=$(sed -n '1p' okmap.txt)
norepeats=$(sed -n '1p' norepeat.txt)
okbed=$(sed -n '1p' okbed.txt)
echo -e "${genus_species}\t $accession\t $map\t $norepeats\t $okbed" >> map_repeat_summary.txt
mkdir /scratch/bell/dewoody/theta/${genus_species}/theta/
cd /scratch/bell/dewoody/theta/${genus_species}/theta/
ls /scratch/bell/dewoody/theta/${genus_species}/sra/final_bams/*.bam > ./bam.filelist
echo "STEP4-QC DONE"
module --force purge
module load biocontainers
module load angsd
module load r
module load bcftools
module load htslib
PD=/scratch/bell/dewoody/theta/${genus_species}/
THETA=/scratch/bell/dewoody/theta/${genus_species}/theta
mkdir -p $THETA
cd $THETA
MIND=$((`wc -l < ./bam.filelist` / 2))
awk '{print $1"\t"$2+1"\t"$3}' $PD/ok.bed > ./angsd.file
angsd sites index ./angsd.file
echo "Genotype likelihood estimation started"
angsd -P 64 -bam ./bam.filelist -sites ./angsd.file -anc $PD/*_ref/ref.fa \
-ref $PD/*_ref/ref.fa -dosaf 1 -gl 1 -remove_bads 1 -only_proper_pairs 1 \
-minMapQ 30 -minQ 30 -rf $PD/*_ref/chrs.txt -minInd $MIND -out out
echo "Genotype likelihood estimation done"
echo "SFS estimation started"
realSFS -P 64 out.saf.idx  -fold 1 > out.sfs
echo "SFS estimation done"
echo "Theta estimation started"
realSFS saf2theta  -P 64 out.saf.idx -sfs out.sfs -outname out
thetaStat print out.thetas.idx > out.thetas_persite.txt
echo "per-site Theta file created"
thetaStat do_stat out.thetas.idx -win 50000 -step 10000  -outnames theta.thetasWindow.gz
echo "window-based Theta file created"
awk '{print $4}' theta.thetasWindow.gz.pestPG > Watterson
awk '{print $5}' theta.thetasWindow.gz.pestPG > NucDiv
awk '{print $9}' theta.thetasWindow.gz.pestPG > TajimaD
awk '{print $10}' theta.thetasWindow.gz.pestPG > FuF
meanW=$(awk 'BEGIN{s=0;}{s=s+$1;}END{print s/NR;}' Watterson)
meanN=$(awk 'BEGIN{s=0;}{s=s+$1;}END{print s/NR;}' NucDiv)
meanD=$(awk 'BEGIN{s=0;}{s=s+$1;}END{print s/NR;}' TajimaD)
meanF=$(awk 'BEGIN{s=0;}{s=s+$1;}END{print s/NR;}' FuF)
sdW=$(awk '{delta = $1 - avg; avg += delta / NR; \
meanW2 += delta * ($1 - avg); } END { print sqrt(meanW2 / NR); }' Watterson)
sdN=$(awk '{delta = $1 - avg; avg += delta / NR; \
meanN2 += delta * ($1 - avg); } END { print sqrt(meanN2 / NR); }' NucDiv)
sdD=$(awk '{delta = $1 - avg; avg += delta / NR; \
meanD2 += delta * ($1 - avg); } END { print sqrt(meanD2 / NR); }' TajimaD)
sdF=$(awk '{delta = $1 - avg; avg += delta / NR; \
meanF2 += delta * ($1 - avg); } END { print sqrt(meanF2 / NR); }' FuF)
echo -e "$PWD\t $meanW\t $sdW" \
>> WattersonsTheta_${genus_species}.txt
echo -e "$PWD\t $meanN\t $sdN" \
>> NucleotideDiversity_${genus_species}.txt
echo -e "$PWD\t $meanD\t $sdD" \
>> TajimaD_${genus_species}.txt
echo -e "$PWD\t $meanF\t $sdF" \
>> FuF_${genus_species}.txt
echo "Pi, Theta, D, F .txt created"
mkdir ./HET
OUTDIR='HET'
cat ./bam.filelist | sed 's/\//\'$'\t/g' | cut -f 9 | sed 's/.bam//g' | while read -r LINE
do
echo "${LINE} heterozygosity estimation started"
angsd -i ../sra/final_bams/${LINE}.bam -ref $PD/*_ref/ref.fa -anc $PD/*_ref/ref.fa -dosaf 1 -rf $PD/*_ref/chrs.txt -sites ./angsd.file \
-minMapQ 30 -minQ 30 -P 64 -out ${OUTDIR}/${LINE} -only_proper_pairs 1 -baq 2 \
-GL 2 -doMajorMinor 1 -doCounts 1 -setMinDepthInd 5 -uniqueOnly 1 -remove_bads 1 
realSFS -P 64 -fold 1 ${OUTDIR}/${LINE}.saf.idx > ${OUTDIR}/${LINE}_est.ml
cd ${OUTDIR}
Rscript -e 'args<-commandArgs(TRUE); LINE<-args[1]; a<-scan(paste(LINE,"est.ml", sep="_")); a[2]/sum(a)' ${LINE} >>  ../Het
echo "${LINE} heterozygosity estimation done"
cd ../
done
meanH=$(awk 'BEGIN{s=0;}{s=s+$2;}END{print s/NR;}' Het)
sdH=$(awk '{delta = $2 - avg; avg += delta / NR; \
meanH2 += delta * ($2 - avg); } END { print sqrt(meanH2 / NR); }' Het)
echo -e "$PWD\t $meanH\t $sdH" \
>> Het_${genus_species}.txt
echo "Population heterozygosity .txt created"
echo "File conversion to bcf started"
angsd -b ./bam.filelist -rf $PD/*_ref/chrs.txt -sites ./angsd.file -dobcf 1 -gl 1 -dopost 1 -domajorminor 1 -domaf 1 -snp_pval 1e-6 -P 64
echo "ROH estimation started"
bcftools query -f'%CHROM\t%POS\t%REF,%ALT\t%INFO/AF\n' angsdput.bcf | bgzip -c > ${genus_species}.freqs.tab.gz
tabix -s1 -b2 -e2 ${genus_species}.freqs.tab.gz
bcftools roh --AF-file ${genus_species}.freqs.tab.gz --output ROH_${genus_species}_raw.txt --threads 64 angsdput.bcf
echo "ROH input file created"
echo "ROH raw file parsing started"
python $CLUSTER_SCRATCH/theta/ROHparser.py ${genus_species} ${accession}
echo "ROH .txt created"

#!/bin/bash
#FLUX: --job-name=gt
#FLUX: -n=40
#FLUX: --queue=development
#FLUX: -t=7200
#FLUX: --urgency=16

export PKG_CONFIG_PATH='/opt/apps/intel18/gsl/2.2.1/lib/pkgconfig/'
export GENOME_FASTA='cdh_alltags_cc.fasta'
export GENOME_DICT='cdh_alltags_cc.dict '
export GenRate='0.75 # desired genotyping rate'
export N1='`wc -l pop0.bams | cut -f 1 -d " "`'
export N2='`wc -l pop1.bams | cut -f 1 -d " "`'
export MI1='`echo "($N1*$GenRate+0.5)/1" | bc`'
export MI2='`echo "($N2*$GenRate+0.5)/1" | bc`'
export NG1='`echo "($N1*2)+1" | bc`'
export NG2='`echo "($N2*2)+1" | bc`'
export TACC_GATK_DIR='/where/gatk/is/installed/'
export TACC_PICARD_DIR='/where/picard/is/installed/'
export GENOME_REF='mygenome.fasta'

2bRAD de novo AND reference-based walkthrough
July 2021
Mikhail Matz (matz@utexas.edu) - ask me if anything does not work
=============================================
INSTALLATIONS (you can skip these until needed):
------ vcftools: 
git clone https://github.com/vcftools/vcftools.git 
./autogen.sh
./configure --prefix=$HOME/bin/vcftools
make
make install
cd
nano .bashrc
	export PATH=$HOME/bin/vcftools/bin:$PATH
	# press ctl-O, Enter, ctl-X
re-login to make PATH changes take effect
------- cutadapt: 
cdh
pip install --user cutadapt
cp .local/bin/cutadapt ~/bin
------- cd-hit:
git clone https://github.com/weizhongli/cdhit.git
cd cd-hit
make
------- Moments: 
cd
git clone https://bitbucket.org/simongravel/moments.git 
cd moments
python setup.py build_ext --inplace
  export PYTHONPATH=$PYTHONPATH:$HOME/moments
cds
cd RAD
------- ANGSD: 
cd
wget https://tukaani.org/xz/xz-5.2.3.tar.gz --no-check-certificate
tar vxf xz-5.2.3.tar.gz 
cd xz-5.2.3/
./configure --prefix=$HOME/xz-5.2.3/
make
make install
nano .bashrc
   export LD_LIBRARY_PATH=$HOME/xz-5.2.3/lib:$LD_LIBRARY_PATH
   export LIBRARY_PATH=$HOME/xz-5.2.3/lib:$LIBRARY_PATH
   export C_INCLUDE_PATH=$HOME/xz-5.2.3/include:$C_INCLUDE_PATH
logout
cd
git clone https://github.com/samtools/htslib.git
cd htslib
make CFLAGS=" -g -Wall -O2 -D_GNU_SOURCE -I$HOME/xz-5.2.3/include"
cd
git clone https://github.com/ANGSD/angsd.git 
cd angsd
make HTSSRC=../htslib
cd
nano .bashrc
   export PATH=$HOME/angsd:$PATH
   export PATH=$HOME/angsd/misc:$PATH
-------  ngsTools (incl. ngsCovar) :
cd ~/bin
git clone https://github.com/mfumagalli/ngsPopGen.git
cd ngsPopGen
make
mv ngs* ..
cd -
-------  NGSadmix :
cd ~/bin/
wget popgen.dk/software/download/NGSadmix/ngsadmix32.cpp 
g++ ngsadmix32.cpp -O3 -lpthread -lz -o NGSadmix
cd -
-------  ngsRelate :
cd 
git clone https://github.com/ANGSD/NgsRelate.git
cd NgsRelate
make HTSSRC=../htslib
cp ngs* ~/bin/
cd
------- ngsF  : (inbreeding coefficients)
git clone https://github.com/fgvieira/ngsF.git
module load gsl
cd ngsF
nano Makefile
add -I${TACC_GSL_INC}  to CC and CXX macros (CFLAGS= ...);
and -L${TACC_GSL_LIB} to the 'LIB = ...' line.
export PKG_CONFIG_PATH=/opt/apps/intel18/gsl/2.2.1/lib/pkgconfig/
make HTSSRC=../htslib
------ ngsLD :
cd 
git clone https://github.com/fgvieira/ngsLD.git
cd ngsLD
nano Makefile
add -I${TACC_GSL_INC}  to CC and CXX macros (CFLAGS= ...);
and -L${TACC_GSL_LIB} to the 'LIB = ...' line.
module load gsl
export PKG_CONFIG_PATH=/opt/apps/intel18/gsl/2.2.1/lib/pkgconfig/
make
cp ngsLD ~/bin
-------  stairwayPlot :
cdw
wget https://www.dropbox.com/s/toxnlvk8rhe1p5h/stairway_plot_v2beta2.zip
unzip stairway_plot_v2beta2.zip
mv stairway_plot_v2beta2 stairway_plot_v2beta
cd
module load python2
git clone https://github.com/Rosemeis/pcangsd.git
cd pcangsd/
python setup.py build_ext --inplace
-------  ADMIXTURE
cd ~/bin/
wget http://software.genetics.ucla.edu/admixture/binaries/admixture_linux-1.3.0.tar.gz --no-check-certificate
tar vxf admixture_linux-1.3.0.tar.gz 
mv admixture_linux-1.3.0/admixture .
cd -
-------  plink 1.9:
cd ~/bin
wget http://s3.amazonaws.com/plink1-assets/plink_linux_x86_64_20190617.zip
unzip plink_linux_x86_64_20190617.zip
cd -
-------  PopGenTools (angsd wrapper and format converter) :
git clone https://github.com/CGRL-QB3-UCBerkeley/PopGenTools.git
ll PopGenTools/
cp PopGenTools/* ~/bin
----- PGDspider :
cd ~/bin
wget http://www.cmpg.unibe.ch/software/PGDSpider/PGDSpider_2.0.7.1.zip
unzip PGDSpider_2.0.7.1.zip
cd -
----- Bayescan :
cd ~/bin
wget http://cmpg.unibe.ch/software/BayeScan/files/BayeScan2.1.zip
unzip BayeScan2.1.zip
cp BayeScan2.1/binaries/BayeScan2.1_linux64bits bayescan
chmod +x bayescan
rm -r BayeScan*
==============================================
cd
mkdir bin 
cd ~/bin 
git clone https://github.com/z0on/2bRAD_denovo.git
mv 2bRAD_denovo/* . 
rm -rf 2bRAD_denovo 
rm -rf 2bRAD_GATK 
chmod +x *.pl 
chmod +x *.py
chmod +x *.R
cd
nano .bashrc
   export PATH=$HOME/bin:$PATH
cd
2bRAD_trim_launch.pl
module load perl
module load bowtie
module load samtools
module load picard-tools
export GENOME_FASTA=$WORK/db/mygenome.fasta
export GENOME_DICT=$WORK/db/mygenome.dict 
bowtie2-build $GENOME_FASTA $GENOME_FASTA
samtools faidx $GENOME_FASTA
export GENOME_DICT=$WORK/db/mygenome.dict 
java -jar $TACC_PICARD_T_DIR/picard.jar CreateSequenceDictionary R=$GENOME_FASTA  O=$GENOME_DICT
2bRAD_trim_launch_dedup.pl fastq > trims
2bRAD_trim_launch_dedup_old.pl fastq > trims
2bRAD_trim_launch.pl fastq barcode2=4 > trims
2bRAD_trim_launch.pl fastq > trims
2bRAD_trim_launch_dedup2.pl fastq > trims
2bRAD_trim_launch_dedup_N2.pl fastq > trims
bash trims
ls -l *.tr0 | wc -l
module load cutadapt 
>trimse
for file in *.tr0; do
echo "cutadapt --format fastq -q 15,15 -m 36 -o ${file/.tr0/}.trim $file > ${file}_trimlog.txt" >> trimse;
done
>trimse
for file in *.tr0; do
echo "cutadapt --format fastq -q 15,15 -m 25 -o ${file/.tr0/}.trim $file > ${file}_trimlog.txt" >> trimse;
done
ls -l *.trim | wc -l
ls *.trim | perl -pe 's/^(.+)$/uniquerOne.pl $1 >$1\.uni/' >unii
ls -l *.uni | wc -l  
mergeUniq.pl uni minInd=10 >all.uniq
awk '!($3>7 && $4==0) && $2!="seq"' all.uniq >all.tab
awk '{print ">"$1"\n"$2}' all.tab > all.fasta
cd-hit-est -i all.fasta -o cdh_alltags.fas -aL 1 -aS 1 -g 1 -c 0.91 -M 0 -T 0  
concatFasta.pl fasta=cdh_alltags.fas num=20
export GENOME_FASTA=cdh_alltags_cc.fasta
export GENOME_DICT=cdh_alltags_cc.dict 
bowtie2-build $GENOME_FASTA $GENOME_FASTA
samtools faidx $GENOME_FASTA
java -jar $WHERE_PICARD_IS/picard.jar CreateSequenceDictionary R=$GENOME_FASTA  O=$GENOME_DICT
GENOME_FASTA=cdh_alltags_cc.fasta
GENOME_FASTA=mygenome.fasta
2bRAD_bowtie2_launch.pl '\.trim$' $GENOME_FASTA > maps
>alignmentRates
for F in `ls *trim`; do 
M=`grep -E '^[ATGCN]+$' $F | wc -l | grep -f - maps.e* -A 4 | tail -1 | perl -pe 's/maps\.e\d+-|% overall alignment rate//g'` ;
echo "$F.sam $M">>alignmentRates;
done
ls *.sam > sams
cat sams | wc -l  # number should match number of trim files
module load samtools
>s2b
for file in *.sam; do
echo "samtools sort -O bam -o ${file/.sam/}.bam $file && samtools index ${file/.sam/}.bam">>s2b;
done
ls *bam | wc -l  # should be the same number as number of trim files
ls *bam >bams
FILTERS="-uniqueOnly 1 -remove_bads 1 -minMapQ 20 -maxDepth 1000 -minInd 1000"
TODO="-doQsDist 1 -doDepth 1 -doCounts 1 -dumpCounts 2"
angsd -b bams -r chr1 -GL 1 $FILTERS $TODO -P 1 -out dd 
Rscript ~/bin/plotQC.R prefix=dd
cat quality.txt
FILTERS="-uniqueOnly 1 -remove_bads 1 -minMapQ 20 -minQ 25 -dosnpstat 1 -doHWE 1 -sb_pval 1e-5 -hetbias_pval 1e-5 -skipTriallelic 1 -minInd 1000 -snp_pval 1e-5 -minMaf 0.05"
TODO="-doMajorMinor 1 -doMaf 1 -doCounts 1 -makeMatrix 1 -doIBS 1 -doCov 1 -doGeno 8 -doBCF 1 -doPost 1 -doGlf 2"
angsd -b bams -GL 1 $FILTERS $TODO -P 1 -out myresult
NSITES=`zcat myresult.mafs.gz | wc -l`
echo $NSITES
module load python2
python ~/pcangsd/pcangsd.py -beagle myresult.beagle.gz -admix -o pcangsd -inbreed 2 -kinship -selection -threads 12
GENOME_FASTA=cdh_alltags_cc.fasta
GENOME_FASTA=mygenome.fasta
FILTERS='-minInd 1 -setMinDepthInd 10 -uniqueOnly 1 -minMapQ 30 -minQ 30'
>hets
>mybams.het
for F in `cat bams`; do
echo "angsd -i $F -anc $GENOME_FASTA $FILTERS -GL 1 -dosaf 1 -out ${F/.bam/} && realSFS ${F/.bam/}.saf.idx >${F/.bam/}.ml | awk -v file=$F '{print file\"\t\"(\$1+\$2+\$3)\"\t\"\$2/(\$1+\$2+\$3)}' ${F/.bam/}.ml >>mybams.het">>hets;
done
NS=`zcat myresult.geno.gz | wc -l`
NB=`cat bams | wc -l`
zcat myresult.mafs.gz | tail -n +2 | cut -f 1,2 > mc1.sites
module load gsl
ngsLD --geno myresult.geno.gz --probs 1 --n_ind $NB --n_sites $NS --max_kb_dist 0 --pos mc1.sites --out myresult.LD --n_threads 12 --extend_out 1
zcat myresult.mafs.gz | cut -f5 |sed 1d >freq
NIND=`cat bams | wc -l`
ngsRelate -f freq -g myresult.glf.gz -n $NIND -z bams >relatedness
export GenRate=0.75 # desired genotyping rate
export N1=`wc -l pop0.bams | cut -f 1 -d " "`
export N2=`wc -l pop1.bams | cut -f 1 -d " "`
export MI1=`echo "($N1*$GenRate+0.5)/1" | bc`
export MI2=`echo "($N2*$GenRate+0.5)/1" | bc`
FILTERS='-uniqueOnly 1 -skipTriallelic 1 -minMapQ 30 -minQ 30 -maxHetFreq 0.5 -hetbias_pval 1e-3'
GENOME_REF=mygenome.fasta # reference to which the reads were mapped
TODO="-doHWE 1 -doSaf 1 -doMajorMinor 1 -doMaf 1 -doPost 2 -dosnpstat 1 -doGeno 11 -doGlf 2 -anc $GENOME_REF -ref $GENOME_REF"
angsd -b pop0.bams -GL 1 -p 4 -minInd $MI1 $FILTERS $TODO -underFlowProtect 1 -out pop0
angsd -b pop1.bams -GL 1 -P 4 -minInd $MI2 $FILTERS $TODO -underFlowProtect 1 -out pop1
zcat pop0.mafs.gz | cut -f 1,2 | tail -n +2 | sort >pop0.sites
zcat pop1.mafs.gz | cut -f 1,2 | tail -n +2 | sort >pop1.sites
comm -12 pop0.sites pop1.sites | sort -V >allSites
angsd sites index allSites
cat allSites | cut -f 1 | uniq >regions
GENOME_REF=mygenome.fasta
angsd -b pop0.bams -rf regions -sites allSites -GL 1 -P 8 -doSaf 1 -anc $GENOME_REF -underFlowProtect 1 -out pop0s
angsd -b pop1.bams -rf regions -sites allSites -GL 1 -P 8 -doSaf 1 -anc $GENOME_REF -underFlowProtect 1 -out pop1s
realSFS pop0s.saf.idx pop1s.saf.idx -ref $GENOME_REF -anc $GENOME_REF -bootstrap 5 -P 1 -resample_chr 1 >p12
export N1=`wc -l pop0.bams | cut -f 1 -d " "`
export N2=`wc -l pop1.bams | cut -f 1 -d " "`
export NG1=`echo "($N1*2)+1" | bc`
export NG2=`echo "($N2*2)+1" | bc`
echo "$NG1 $NG2">p12.sfs
cat p12 | awk '{for (i=1;i<=NF;i++){a[i]+=$i;}} END {for (i=1;i<=NF;i++){printf "%.3f", a[i]/NR; printf "\t"};printf "\n"}' >> p12.sfs
'''R
sfs2matrix=function(sfs,n1,n2,zero.ends=TRUE) {
  dd=matrix(ncol=2*n1+1,nrow=2*n2+1,sfs)
  if(zero.ends==TRUE) { dd[1,1]=dd[2*n2+1,2*n1+1]=0 }
  return(apply(dd,2,rev))
}
s=scan("p12.sfs")
n1=(s[1]-1)/2
n2=(s[2]-1)/2
ssfs=sfs2matrix(s[-c(1:2)],n1,n2)
plot(raster(log(ssfs+0.1,10)))
'''
realSFS pop0.saf.idx pop1.saf.idx -P 24 > p01.sfs ; realSFS fst index pop0.saf.idx pop1.saf.idx -sfs p01.sfs -fstout p01 
realSFS fst stats p01.fst.idx
realSFS fst print p01.fst.idx > p01.fst
cat mygenome.gff3 | awk ' $3=="gene"' | cut -f 1,4,5,10 >gene_regions.tab
awk '{print $1"\t"$2-2000"\t"$3+2000"\t"$4}' gene_regions.tab '> genes.txt
ind1	pop0
ind2	pop0
ind3	pop1
ind4	pop1
echo "############
PARSER_FORMAT=VCF
VCF_PARSER_POP_QUESTION=true
VCF_PARSER_REGION_QUESTION=
VCF_PARSER_PLOIDY_QUESTION=DIPLOID
VCF_PARSER_IND_QUESTION=
VCF_PARSER_READ_QUESTION=
VCF_PARSER_PL_QUESTION=true
VCF_PARSER_EXC_MISSING_LOCI_QUESTION=true
VCF_PARSER_POP_FILE_QUESTION=./bspops
VCF_PARSER_QUAL_QUESTION=
VCF_PARSER_MONOMORPHIC_QUESTION=false
VCF_PARSER_GTQUAL_QUESTION=
WRITER_FORMAT=GESTE_BAYE_SCAN
GESTE_BAYE_SCAN_WRITER_DATA_TYPE_QUESTION=SNP
java -Xmx1024m -Xms512m -jar ~/bin/PGDSpider_2.0.7.1/PGDSpider2-cli.jar -inputfile OKbs.vcf -outputfile Best.bayescan -spid vcf2bayescan.spid 
bayescan Best.bayescan -threads=20
removeBayescanOutliers.pl bayescan=snp.baye_fst.txt vcf=myresult.vcf FDR=0.5 >myresult_nobs.vcf
module load gatk
module load picard-tools
export TACC_GATK_DIR=/where/gatk/is/installed/
export TACC_PICARD_DIR=/where/picard/is/installed/
export GENOME_REF=mygenome.fasta
ls *.bam > bams
echo '#!/bin/bash
java -jar $TACC_GATK_DIR/GenomeAnalysisTK.jar -T UnifiedGenotyper \
-R $GENOME_REF -nt 40 -nct 1 \
--genotype_likelihoods_model SNP \' >unig2
cat bams | perl -pe 's/(\S+\.bam)/-I $1 \\/' >> unig2
echo '-o primary.vcf ' >> unig2
bash unig2
nano clonepairs.tab
replicatesMatch.pl vcf=primary.vcf replicates=clonepairs.tab hetPairs=2 max.het=0.5 > vqsr.vcf
vcftools --vcf vqsr.vcf --TsTv-summary
export GENOME_REF=mygenome.fasta
java -jar $TACC_GATK_DIR/GenomeAnalysisTK.jar -T VariantRecalibrator \
-R $GENOME_REF -input primary.vcf -nt 12 \
-resource:repmatch,known=true,training=true,truth=true,prior=30  vqsr.vcf \
-an QD -an MQ -an FS -mode SNP --maxGaussians 6 \
--target_titv 1.44 -tranche 85.0 -tranche 90.0 -tranche 95.0 -tranche 99.0 -tranche 100 \
-recalFile primary.recal -tranchesFile recalibrate.tranches -rscriptFile recalibrate_plots.R 
export GENOME_REF=mygenome.fasta
java -jar $TACC_GATK_DIR/GenomeAnalysisTK.jar -T ApplyRecalibration \
-R $GENOME_REF -input primary_n.vcf -nt 12 \
--ts_filter_level 95.0 -mode SNP \
-recalFile primary.recal -tranchesFile recalibrate.tranches -o recal.vcf
vcftools --vcf recal.vcf --het
cat out.het 
cat out.het | awk '$4<40000' | cut -f 1  > underSequenced
cat underSequenced
vcftools --vcf recal.vcf --remove underSequenced --remove-filtered-all --max-missing 0.9  --min-alleles 2 --max-alleles 2 --recode-INFO-all --recode --out filt
grep -E "#|0/1|0/0.+1/1|1/1.+0/0" filt.recode.vcf >polymorphs.vcf
hetfilter.pl vcf=polymorphs.vcf maxhet=0.5 >best.vcf
repMatchStats.pl vcf=best.vcf replicates=clonepairs.tab 
vcftools --vcf best.vcf --het
cat out.het
cat clonepairs.tab | cut -f 2 >clones2remove
vcftools --vcf best.vcf --remove clones2remove --recode --recode-INFO-all --out final
thinner.pl vcf=final.recode.vcf criterion=maxAF >thinMaxaf.vcf
cat thinMaxaf.vcf | perl -pe 's/tag(\d)(\d+)\t(\d+)/chr$1\t$3$2/'>thinMaxChrom.vcf
plink --vcf thinMaxChrom.vcf --make-bed --out rads
for K in 1 2 3 4 5; do admixture --cv rads.bed $K | tee log${K}.out; done
grep -h CV log*.out
tbl=read.table("rads.3.Q")
barplot(t(as.matrix(tbl)), col=rainbow(5),xlab="Individual #", ylab="Ancestry", border=NA)
vcf2dadi.pl final.recode.vcf inds2pops

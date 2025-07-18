#!/bin/bash
#FLUX: --job-name=${fa%.fa}_samtoolsIndex
#FLUX: -c=72
#FLUX: -t=43200
#FLUX: --urgency=16

HOMESOURCE="source ~/.bashrc"
SLURMPARTITION="hooli"
SING="singularity exec /beegfs/common/singularity/bioinformatics_software.v3.0.9.sif /bin/bash"
unset LIST
unset RELEASE
unset ORGANISM
BIN=$(basename $0)
BASE="/beegfs/common/genomes"
VER_STAR="2.7.3a"
USAGE="USAGE:
  $BIN [OPTIONS]
OPTIONS:
  -h, --help                : show this help and exist
  -l, --list                : return available organisms/release-ids
  -b, --base, --prefix PATH : select the base directory, (default: $BASE)
  -o, --organism ORGANISM   : define organism, e.g. 'caenorhabditis_elegans'
  -r, --release RELEASE     : define release version, e.g. '81'
                              (default: automatic detection of current version)
  --ver-star VERSION        : version of STAR (default $VER_STAR)
  -n, --no-slurm            : use bash to run scripts, not sbatch from slurm
                              (not yet integrated)
  -c, --cpus NUMBER         : define number of CPUs (for STAR, default: 12)
                              (not yet integrated)
"
while [[ $# -gt 0 ]]
do
  case $1 in
    -h|--help)
      echo "$USAGE"
      exit
      ;;
    -l|--list)
      LIST=true
      ;;
    -b|--base|--prefix)
      BASE=$2
      shift
      ;;
    -o|--organism)
      ORGANISM=$2
      shift
      ;;
    -r|--release)
      RELEASE=$2
      shift
      ;;
    --version-star)
      VER_STAR=$2
      shift
      ;;
    -n|--no-slurm)
      unset SLURM
      echo "* warning: option '-n' not yet integrated"
      ;;
    -c|--cpus)
      CPUS=$2
      shift
      echo "* warning: option '-c' not yet integrated"
      ;;
    *)
      echo "error: unsupported option '$1'. See '$(basename $0) --help'."
      exit 65
      ;;
  esac
  shift
done
get_organism () {
  curl -#l ftp://ftp.ensembl.org/pub/current_fasta/
  # alternative: ncftpls -l ftp://ftp.ensembl.org/pub/current_fasta/
}
get_releases () {
  curl -#l ftp://ftp.ensembl.org/pub/ | grep release | sed 's|release-||' | sort
}
get_current () {
  echo "* getting latest release"
  gtf=$(curl -#l ftp://ftp.ensembl.org/pub/current_gtf/$1/ | grep gtf.gz | uniq)
  relA=$(echo $gtf | cut -f2 -d.)
  relB=$(echo $gtf | cut -f3 -d.)
  sep=_
  rel=$relA$sep$relB 
  echo $rel
}
if [[ ! -d $BASE || ! -x $BASE || ! -w $BASE ]]
then
  echo "error: base directory '$BASE' not found/accessable/writeable"
  exit 65
fi
echo "* fetching organism list"
ORGANISMS=($(get_organism))
echo "* fetching release list"
RELEASES=($(get_releases))
RELEASES=($(for REL in ${RELEASES[@]}; do echo $((REL)); done)) 
CURRENT=$(for REL in ${RELEASES[@]}; do echo $((REL)); done | sort -n | tail -n 1)
echo ${CURRENT}
if [[ $LIST ]]
then
  echo
  echo "* available organisms:"
  printf '%s\n' "${ORGANISMS[@]}" | column
  echo
  echo "* available releases:"
  printf '%s\n' "${RELEASES[@]}" | column
  echo
  exit
fi
if [[ -z $ORGANISM || -z $(echo ${ORGANISMS[@]} | grep $ORGANISM) ]]
then
  echo "* error: organism '$ORGANISM' not available"
  exit 65
fi
if [[ ! $RELEASE ]]
then
  RELEASE=$CURRENT
  echo $RELEASE
fi
if [[ -z $RELEASE || -z $(echo ${RELEASES[@]} | grep -o $RELEASE) ]]
then
  echo "Error: release '$RELEASE' not available"
  exit 65
fi
URL_GTF="ftp://ftp.ensembl.org/pub/release-$RELEASE/gtf/$ORGANISM/"
URL_GFF3="ftp://ftp.ensembl.org/pub/release-$RELEASE/gff3/$ORGANISM/"
URL_DNA="ftp://ftp.ensembl.org/pub/release-$RELEASE/fasta/$ORGANISM/dna/"
TARGET=$BASE/$ORGANISM/$RELEASE
echo "* settings:
  ORG : $ORGANISM
  REL : $RELEASE (current: $CURRENT)
  URL : $URL_GTF
  DIR : $TARGET
"
if [[ -d $TARGET ]]
then
  echo "* target directory '$TARGET' exists"
fi
mkdir -p $TARGET
if [[ ! -x $TARGET || ! -w $TARGET ]]
then
  echo "error: target directory '$TARGET' not accessable/writeable"
  exit 65
fi
cd $TARGET
echo "* fetching file lists"
FILES_GTF=($(curl -#l $URL_GTF | grep "\.gtf\.gz$"))
FILES_DNA=($(curl -#l $URL_DNA | grep "\.dna\."))
FILES_GFF3=($(curl -#l $URL_GFF3 | grep "\.$RELEASE.gff3\."))
BUILD=$(printf '%s\n' "${FILES_GTF[@]}" | grep "${RELEASE}.gtf.gz")
BUILD=${BUILD#*.}
BUILD=${BUILD%".${RELEASE}.gtf.gz"}
echo ${BUILD}
touch BUILD_${BUILD}_RELEASE_${RELEASE}
echo "* downloading and extracting"
shopt -s nocasematch
for FILE in ${FILES_GFF3[@]}
do
  FILE_UNZIP=${FILE%%.gz}
  SUB_STR=$(printf '%s\n' "${FILE_UNZIP//${ORGANISM}.${BUILD}.${RELEASE}./}")
  FILE_REBASED=original.${SUB_STR}
  echo "  ${FILE%%.gz} : "
  [[ -f $FILE_REBASED ]] && echo "exists" && continue
  curl -#O $URL_GFF3/$FILE
  gunzip $FILE
  mv $FILE_UNZIP $FILE_REBASED
done
echo "  README (gtf)"
curl -# $URL_GTF/README > README_gtf
shopt -s nocasematch
for FILE in ${FILES_GTF[@]}
do
  FILE_UNZIP=${FILE%%.gz}
  SUB_STR=$(printf '%s\n' "${FILE_UNZIP//${ORGANISM}.${BUILD}.${RELEASE}./}")
  FILE_REBASED=original.${SUB_STR}
  echo "  ${FILE%%.gz} : "
  [[ -f $FILE_REBASED ]] && echo "exists" && continue
  curl -#O $URL_GTF/$FILE
  gunzip $FILE
  mv $FILE_UNZIP $FILE_REBASED
done
echo "  README (fasta)"
curl -# $URL_DNA/README > README_fa
mkdir -p chromosomes
for FILE in ${FILES_DNA[@]}
do
  FILE_UNZIP=${FILE%%.gz}
  FILE_CHROM=chromosomes/${FILE_UNZIP##*chromosome.}
  SUB_STR=$(printf '%s\n' "${FILE_UNZIP//${ORGANISM}.${BUILD}.dna./}")
  FILE_REBASED=original.${SUB_STR}
  echo "  ${FILE_UNZIP} : "
  [[ -f ${FILE_REBASED} || -f ${FILE_CHROM} ]] && echo "exists" && continue
  [[ $FILE =~ nonchromosomal && -f chromosomes/nonchromosomal.fa ]] && echo "exists" && continue
  curl -#O $URL_DNA/$FILE
  gunzip $FILE
  if [[ $FILE =~ chromosome ]]
  then
    mv $FILE_UNZIP $FILE_CHROM
  elif [[ $FILE =~ nonchromosomal ]]
  then
    mv $FILE_UNZIP chromosomes/nonchromosomal.fa
  else
    mv $FILE_UNZIP $FILE_REBASED
  fi
done
echo "Alignment for index"
mkdir -p log
gtf=original.gtf
for fa in original.toplevel.fa original.primary_assembly.fa; do
if [[ -f ${fa} ]] ; then 
label_fa=${fa#original.}
label_fa=${label_fa%.fa}
name=${label_fa}_bwa
if [[ -d $name ]]
then
    echo "* indexing $name: skipped (remove folder to rebuild)"
else
    echo "* indexing $name"
    jobname=ensref_${ORGANISM}_${RELEASE}_$name
    cmd="
module load bwa
date
mkdir $name
cd $name
ln -s ../$fa index.fa
bwa index -a bwtsw -p index.fa index.fa
"
    echo "${cmd}" > log/${name}.sh
    chmod u+x log/${name}.sh
    bwa_id=$(sbatch --partition $SLURMPARTITION --parsable << EOF
echo \${HOSTNAME}
date
${SING} << SIN
${HOMESOURCE}
log/${name}.sh
echo "Done bilding bwa index."
SIN
EOF
)
fi
if [ "${ORGANISM}" == "homo_sapiens" ]
then
    mem=170GB
    mem_star=170000000000
else
    mem=130GB
    mem_star=125000000000
fi
name=${label_fa}_star_$VER_STAR
if [[ -d $name ]]
then
    echo "* indexing $name: skipped (remove folder to rebuild)"
else
    echo "* indexing $name"
    jobname=ensref_${ORGANISM}_${RELEASE}_$name
    cmd="
module purge
module load star
date
mkdir $name
cd $name
ln -s ../$fa index.fa
ln -s ../$gtf index.gtf
STAR --runMode genomeGenerate --genomeDir ./ --genomeFastaFiles index.fa \
  --runThreadN 12 --genomeSAindexNbases 12 --sjdbGTFfile index.gtf --sjdbOverhang 100 \
  --limitGenomeGenerateRAM ${mem_star}
"
    echo "${cmd}" > log/${name}.sh
    chmod u+x log/${name}.sh
    id=$(sbatch --partition $SLURMPARTITION --parsable << EOF
echo \${HOSTNAME}
date
${SING} << SIN
${HOMESOURCE}
log/${name}.sh
echo "Done bilding STAR index."
SIN
EOF
)
fi
name=${label_fa}_hisat2
if [[ -d $name ]]
then
    echo "* indexing $name: skipped (remove folder to rebuild)"
else
    echo "* indexing $name"
    jobname=ensref_${ORGANISM}_${RELEASE}_$name
    cmd="
module purge
module load hisat
date
mkdir $name
cd $name
ln -s ../$fa index.fa
hisat2-build index.fa index.fa
"
    echo "${cmd}" > log/${name}.sh
    chmod u+x log/${name}.sh
    id=$(sbatch --partition $SLURMPARTITION --parsable << EOF
echo \${HOSTNAME}
date
${SING} << SIN
${HOMESOURCE}
log/${name}.sh
echo "Done bilding hisat2 index."
SIN
EOF
)
fi
name=${label_fa}_bowtie1
if [[ -d $name ]]
then
    echo "* indexing $name: skipped (remove folder to rebuild)"
else
    echo "* indexing $name"
    jobname=ensref_${ORGANISM}_${RELEASE}_$name
    cmd="
module purge
module load bowtie/1.2.3
date
mkdir $name
cd $name
ln -s ../$fa index.fa
bowtie-build index.fa index.fa
"
    echo "${cmd}" > log/${name}.sh
    chmod u+x log/${name}.sh
    id=$(sbatch --partition $SLURMPARTITION --parsable << EOF
echo \${HOSTNAME}
date
${SING} << SIN
${HOMESOURCE}
log/${name}.sh
echo "Done building bowtie1 index."
SIN
EOF
)
fi
name=${label_fa}_bowtie2
if [[ -d $name ]]
then
    echo "* indexing $name: skipped (remove folder to rebuild)"
else
    echo "* indexing $name"
    jobname=ensref_${ORGANISM}_${RELEASE}_$name
    cmd="
module purge
module load bowtie
date
mkdir $name
cd $name
ln -s ../$fa index.fa
bowtie2-build index.fa index.fa
"
    echo "${cmd}" > log/${name}.sh
    chmod u+x log/${name}.sh
    bowtie2_id=$(sbatch --partition $SLURMPARTITION --parsable << EOF
echo \${HOSTNAME}
date
${SING} << SIN
${HOMESOURCE}
log/${name}.sh
echo "Done building bowtie2 index."
SIN
EOF
)
    #srun -d afterok:${bowtie2_id} --nodes=1 --ntasks-per-node=1 --mem=1 --time=00:01:00 echo "Done building bowtie2 index."
fi
if [[ ${bowtie2_id} ]] ;
    then
        bowtie2_id="-d afterok:${bowtie2_id}"
fi
name=${label_fa}_tophat2_cuffcompare
if [[ -d $name ]]
then
  echo "* indexing $name: skipped (remove folder to rebuild)"
else
  echo "* indexing $name"
  jobname=ensref_${ORGANISM}_${RELEASE}_$name
  cmd="
module purge
module load tophat
module load cufflinks
module load bowtie
date
mkdir $name
cuffcompare -V -CG -s chromosomes -r $gtf $gtf 2>&1
mv cuffcmp.combined.gtf cuffcompare.gtf
tar -jcvf cuffcompare.results.tar.bz2 cuffcmp.* --remove-files
tophat2 -o ${name}.tmp -G cuffcompare.gtf --transcriptome-index ${name}/index \
  ${label_fa}_bowtie2/index.fa 2>&1
rm -r ${name}.tmp
cd $name
for f in *
do
  [[ \$f =~ ^index\.fa ]] && continue
  mv \$f \${f/#index/index.fa}
done
"
      echo "${cmd}" > log/${name}.sh
      chmod u+x log/${name}.sh
      id=$(sbatch ${bowtie2_id} --partition $SLURMPARTITION --parsable << EOF
echo \${HOSTNAME}
date
${SING} << SIN
${HOMESOURCE}
log/${name}.sh
echo "Done building tophat2_cuffcompare index."
SIN
EOF
)
fi
name=${label_fa}_tophat2
if [[ -d $name ]]
then
  echo "* indexing $name: skipped (remove folder to rebuild)"
else
  echo "* indexing $name"
  jobname=ensref_${ORGANISM}_${RELEASE}_$name
  cmd="
module purge
module load bowtie
module load tophat
date
mkdir $name
tophat2 -G $gtf -o $name --transcriptome-index $name/index ${label_fa}_bowtie2/index.fa 2>&1
cd $name
for f in *
do
  [[ \$f =~ ^index\.fa ]] && continue
  [[ -d \$f ]] && continue
  mv \$f \${f/#index/index.fa}
done
"
    echo "${cmd}" > log/${name}.sh
    chmod u+x log/${name}.sh
    id=$(sbatch ${bowtie2_id} --partition $SLURMPARTITION --parsable << EOF
echo \${HOSTNAME}
date
${SING} << SIN
${HOMESOURCE}
log/${name}.sh
echo "Done building tophat2 index."
SIN
EOF
)
fi
cd $TARGET
id=$(sbatch --partition $SLURMPARTITION --parsable << EOF
echo \${HOSTNAME}
date
${SING} << SIN
${HOMESOURCE}
module load samtools
samtools faidx ${fa}
SIN
EOF
)
echo "Indexing jobs submitted."
echo "Waiting for ${fa}.fai.."
while [[ ! -f ${fa}.fai ]] ; do
    sleep 30
done
awk '{print $1 "\t" $2}' ${fa}.fai > ${fa%.fa}.genome
else
echo "${fa} does not exist"
fi
done
echo "**** Done ****"
chmod -R 775 $TARGET
exit

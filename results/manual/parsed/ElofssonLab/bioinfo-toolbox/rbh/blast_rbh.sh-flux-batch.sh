#!/bin/bash
#FLUX: --job-name=boopy-diablo-7516
#FLUX: -c=5
#FLUX: -t=3600
#FLUX: --urgency=16

ml GCC/8.2.0-2.31.1  OpenMPI/3.1.3 ADIOS2/2.5.0-Python-3.7.2
if [ -z $1 ]
then
        offset=0
else
        offset=$1
fi
abspath=/home/j/juliezhu/pfs/coevolve_miipa   ##project folder path
exepath=/home/j/juliezhu/pfs/bioinfo-toolbox/rbh  ##execute script path
ecoli=/home/j/juliezhu/pfs/coevolve_yeast/pdb/seq/pdbseq.fasta   ## one fasta file of all ecoli proteins' sequences
ecolidb=/home/j/juliezhu/pfs/coevolve_yeast/pdb/seq/pdbseqDB     ## blast database of ecoli fasta file
ecoli_list=/home/j/juliezhu/pfs/coevolve_yeast/pdb/ID_pdb_trimmed.txt    ## ID list of all ecoli proteins
rbhpath=/home/j/juliezhu/pfs/test/rbh                            ## path to save rbh files 
orthologpath=/home/j/juliezhu/pfs/test/ortholog                  ## path to save ortholog file for each ecoli protein
dbpath=/home/j/juliezhu/pfs/coevolve_miipa/data_raw/blastdb_ref          ##blast database for all reference proteomes from uniprot
idx=$(expr $offset + $SLURM_ARRAY_TASK_ID)
proteome_list=/home/j/juliezhu/pfs/coevolve_miipa/data_raw/refome/ID_proteomename_taxinfo.txt   ## ID list of all reference proteomes from uniprot
pname=$(sed -n ${idx}p $proteome_list | cut -d ' ' -f1)
folder=$(sed -n ${idx}p $proteome_list | cut -d ' ' -f2)
tmpdir=$(mktemp -d)
echo $tmpdir
mkdir $tmpdir/forward
mkdir $tmpdir/forward_trimmed
mkdir $tmpdir/backward
mkdir $tmpdir/backward_trimmed
mkdir $tmpdir/tmp
mkdir $tmpdir/rbh_hit
mkdir $tmpdir/rbh_hit/manual
mkdir $tmpdir/ortholog
cd $tmpdir/forward
psiblast -query $ecoli -db $dbpath/$pname -out $pname -num_iterations 3 -evalue 0.01 -outfmt "6 qseqid sseqid qlen slen length qcovs pident qstart qend sstart send evalue" 
sed -i '/^Search.*/d;/^$/d' $pname
python $exepath/blast_mainfilter.py $pname $tmpdir/forward_trimmed
qid=$(cat $tmpdir/forward_trimmed/$pname | cut -d '	' -f2 |cut -d '|' -f2 |sort -u)
proteome_seq=$abspath/data_raw/refome/$folder/$pname.fasta
cd $tmpdir/backward
while IFS= read -r line
do
pat1=".*${line}.*"
pat2="^>.*"
sequence=$(sed "0,/${pat1}/d;/${pat2}/,\$d" $proteome_seq)
id=$(grep $line $proteome_seq)
echo -e "${id}\n${sequence}" >> $tmpdir/tmp/$pname.fa
done <<< "$qid"
psiblast -query $tmpdir/tmp/$pname.fa -db $ecolidb -out $pname -num_iterations 3 -evalue 0.01 -outfmt "6 qseqid sseqid qlen slen length qcovs pident qstart qend sstart send evalue" 
sed -i '/^Search.*/d;/^$/d' $pname
python $exepath/blast_mainfilter.py $pname $tmpdir/backward_trimmed
cd $tmp
python $exepath/blast_interfwbw.py $pname $tmpdir
python $exepath/parsing_blast.py $pname $tmpdir
cd $tmpdir/rbh_hit/
tar --use-compress-program /home/p/pbryant/pfs/zstd/programs/zstd -cf $pname.tar.zst ./*
mv $pname.tar.zst $rbhpath/
cd $tmpdir/ortholog
filelength=$(wc -l < $ecoli_list)
for m in `seq 1 $filelength`;do
file1=$(sed -n ${m}p $ecoli_list | cut -d ' ' -f1)
file2=$(sed -n ${m}p $ecoli_list | cut -d ' ' -f2)
touch $file1
touch $file2
done
while IFS= read -r line;do
ecoli_name=$(echo $line | cut -d ' ' -f1 | cut -d '|' -f2)
echo "${line}	${pname}" >> $tmpdir/ortholog/$ecoli_name
done < $tmpdir/rbh_hit/$pname
for i in `find . -mindepth 1 -not -empty`;do
ecoli_name=$(echo $i | cut -d '/' -f2)
cat $i >> $orthologpath/$ecoli_name
done

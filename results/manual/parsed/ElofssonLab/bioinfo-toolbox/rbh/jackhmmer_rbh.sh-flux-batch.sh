#!/bin/bash
#FLUX: --job-name=chunky-hobbit-1359
#FLUX: --priority=16

ml GCC/7.3.0-2.30  CUDA/9.2.88  OpenMPI/3.1.1
ml Python/3.6.6
ml icc/2018.3.222-GCC-7.3.0-2.30  impi/2018.3.222
ml ifort/2018.3.222-GCC-7.3.0-2.30  impi/2018.3.222
ml HMMER/3.2.1
ml singularity/3.5.3
if [ -z $1 ]
then
        offset=0
else
        offset=$1
fi
abspath=/home/j/juliezhu/pfs/coevolve_miipa     ##project folder path
exepath=/home/j/juliezhu/pfs/bioinfo-toolbox/rbh    ##script folder path 
ecoli=/home/j/juliezhu/pfs/coevolve_yeast/pdb/seq/pdbseq.fasta   ##one fasta file contains all sequences
ecoli_list=/home/j/juliezhu/pfs/coevolve_yeast/pdb/ID_pdb_trimmed.txt   ## ID list of all ecoli proteins
rbhpath=/home/j/juliezhu/pfs/test/rbh   ##path to save rbh hits 
orthologpath=/home/j/juliezhu/pfs/test/ortholog  ## path to save ortholog group for each sequence 
dbpath=/home/j/juliezhu/pfs/coevolve_miipa/data_raw/refome
proteome_list=$dbpath/ID_proteomename_taxinfo.txt
idx=$(expr $offset + $SLURM_ARRAY_TASK_ID)
pname=$(sed -n ${idx}p $proteome_list | cut -d ' ' -f1)
folder=$(sed -n ${idx}p $proteome_list | cut -d ' ' -f2) 
tmpdir=$(mktemp -d)
mkdir $tmpdir/forward
mkdir $tmpdir/backward
mkdir $tmpdir/tmp
mkdir $tmpdir/rbh_hit
mkdir $tmpdir/ortholog
cd $tmpdir/forward
jackhmmer -N 3 -E 0.01 --cpu 5 --tblout $pname $ecoli $dbpath/$folder/$pname.fasta
singularity exec --nv /home/j/juliezhu/pfs/singularity/bio.sif python3 $exepath/parse_jackhmmer_totxt.py $pname
cd $tmpdir/backward
jackhmmer -N 3 -E 0.01 --cpu 5 --tblout $pname $dbpath/$folder/$pname.fasta $ecoli
singularity exec --nv /home/j/juliezhu/pfs/singularity/bio.sif python3 $exepath/parse_jackhmmer_totxt.py $pname
cd $tmp
python3 $exepath/jackhmmer_interfwbw.py -fwfile $tmpdir/forward/$pname -bwfile $tmpdir/backward/$pname -o $tmpdir/rbh_hit/$pname
python3 $exepath/jackhmmer_filter.py $tmpdir/rbh_hit/$pname
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
length=$(wc -l < $tmpdir/rbh_hit/$pname)
for i in `seq 1 $length`;do
qid=$(sed -n ${i}p $tmpdir/rbh_hit/$pname | cut -d ' ' -f1)
ol_file=$(find . -maxdepth 1 -name "*$qid*" -print)
line=$(sed -n ${i}p $tmpdir/rbh_hit/$pname)
echo "$line $pname" >> "$ol_file"
done
for i in `find . -mindepth 1 -not -empty`;do
ecoli_name=$(echo $i | cut -d '/' -f2)
cat $i >> $orthologpath/$ecoli_name
done

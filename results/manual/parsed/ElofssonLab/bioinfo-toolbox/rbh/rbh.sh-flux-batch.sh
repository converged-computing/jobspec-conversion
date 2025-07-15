#!/bin/bash
#FLUX: --job-name=phat-peas-8714
#FLUX: --urgency=16

ml GCC/7.3.0-2.30  CUDA/9.2.88  OpenMPI/3.1.1
ml Python/3.6.6
ml icc/2018.3.222-GCC-7.3.0-2.30  impi/2018.3.222
ml ifort/2018.3.222-GCC-7.3.0-2.30  impi/2018.3.222
ml HMMER/3.2.1
if [ -z $1 ]
then
        offset=0
else
        offset=$1
fi
abspath=/home/j/juliezhu/pfs/coevolve_yeast   ##project foler
exepath=/home/j/juliezhu/pfs/bioinfo-toolbox/rbh
lengthfile=$abspath/pdb/seqlen.txt
ecoli_list=$abspath/pdb/ID_pdb_trimmed.txt
ecoli=$abspath/pdb/seq/pdbseq.fasta
orthologpath=$abspath/data_coev/pdb/psiblast_rbh/ortholog
mergedpath=/home/j/juliezhu/pfs/test/merged
resultpath=/home/j/juliezhu/pfs/test/result
format=psiblast
idx=$SLURM_ARRAY_TASK_ID
tmpdir=$(mktemp -d)
mkdir $tmpdir/tmp
mkdir $tmpdir/seq
mkdir $tmpdir/homolog_seq
mkdir $tmpdir/jackhmmer
mkdir $tmpdir/combined_msa
mkdir $tmpdir/result
pr1=$(sed -n ${idx}p $ecoli_list | cut -d ' ' -f1)
pr2=$(sed -n ${idx}p $ecoli_list | cut -d ' ' -f2)
echo $pr1,$pr2
if [[ ! -s $orthologpath/$pr1 || ! -s $orthologpath/$pr2 ]];then
echo "one or more is missing!"
exit 1
fi
grep -A 1 $pr1 $ecoli > $tmpdir/seq/$pr1.fasta
grep -A 1 $pr2 $ecoli > $tmpdir/seq/$pr2.fasta
python3 $exepath/rbh_intersection.py --input $orthologpath/$pr1 $orthologpath/$pr2 --format $format --out $tmpdir/tmp
if [ ! -s $tmpdir/tmp/$pr1 ];then
echo 'no proteins from common species!'
exit 1
fi
blastdbcmd -db /home/j/juliezhu/pfs/coevolve_miipa/data_raw/allrefproteome/allproteomeDB -entry_batch $tmpdir/tmp/$pr1 -out $tmpdir/homolog_seq/$pr1
blastdbcmd -db /home/j/juliezhu/pfs/coevolve_miipa/data_raw/allrefproteome/allproteomeDB -entry_batch $tmpdir/tmp/$pr2 -out $tmpdir/homolog_seq/$pr2
echo "$(awk '/^>/{print a;a="";print;next}{a=a$0}END{print a}' $tmpdir/homolog_seq/$pr1) " > $tmpdir/homolog_seq/$pr1
echo "$(awk '/^>/{print a;a="";print;next}{a=a$0}END{print a}' $tmpdir/homolog_seq/$pr2) " > $tmpdir/homolog_seq/$pr2
sed -i '1d' $tmpdir/homolog_seq/$pr1
sed -i '1d' $tmpdir/homolog_seq/$pr2 
cd $tmpdir/jackhmmer
jackhmmer -N 1 -A $pr1.sto $tmpdir/seq/$pr1.fasta $tmpdir/homolog_seq/$pr1 
jackhmmer -N 1 -A $pr2.sto $tmpdir/seq/$pr2.fasta $tmpdir/homolog_seq/$pr2
/home/j/juliezhu/pfs/programs/hhsuite2/scripts/reformat.pl $pr1.sto $pr1.a3m
/home/j/juliezhu/pfs/programs/hhsuite2/scripts/reformat.pl $pr2.sto $pr2.a3m
echo "$(awk '/^>/{print a;a="";print;next}{a=a$0}END{print a}' $pr1.a3m )" > $pr1.a3m
echo "$(awk '/^>/{print a;a="";print;next}{a=a$0}END{print a}' $pr2.a3m )" > $pr2.a3m
sed -i '1d' $pr1.a3m
sed -i '1d' $pr2.a3m
/home/j/jlamb/pfs/call_scripts/a3mToTrimmed.py $pr1.a3m > $pr1.a3m_trim
/home/j/jlamb/pfs/call_scripts/a3mToTrimmed.py $pr2.a3m > $pr2.a3m_trim
mv $pr1.a3m_trim $pr1.a3m
mv $pr2.a3m_trim $pr2.a3m
python3 $exepath/reorder_a3m.py $tmpdir/homolog_seq/$pr1 $tmpdir/homolog_seq/$pr2 $tmpdir/jackhmmer/$pr1.a3m $tmpdir/jackhmmer/$pr2.a3m
paste -d '' $tmpdir/jackhmmer/$pr1.a3m $tmpdir/jackhmmer/$pr2.a3m > $tmpdir/combined_msa/${pr1}_${pr2}_nobound.a3m
seqlen1=$(grep $pr1 $lengthfile | cut -d ' ' -f2)
python3 $exepath/addboud_mergedmsa.py -input $tmpdir/combined_msa/${pr1}_${pr2}_nobound.a3m -seqlen1 $seqlen1 -aa_pattern G -pattern_length 20 -reverse True -outdir $tmpdir/combined_msa
SINGIMG=/home/j/juliezhu/pfs/singularity/trRosetta-ipython.simg
ROSETTA=/proj/nobackup/snic2019-35-62/TrRosetta
OUTDIR=$tmpdir/result
/opt/singularity/3.5.3/bin/singularity run -B /proj:/proj,/home:/home $SINGIMG python $ROSETTA/trRosetta_1/network/predict.py -m $ROSETTA/model2019_07 $tmpdir/combined_msa/${pr1}_${pr2}.a3m $OUTDIR/${pr1}_${pr2}.npz
/opt/singularity/3.5.3/bin/singularity run -B /proj:/proj,/home:/home $SINGIMG python $ROSETTA/trRosetta_1/network/predict.py -m $ROSETTA/model2019_07 $tmpdir/combined_msa/${pr1}_${pr2}_reversed.a3m $OUTDIR/${pr1}_${pr2}_reversed.npz
cd $tmpdir/combined_msa/
tar --use-compress-program /home/p/pbryant/pfs/zstd/programs/zstd -cf ${pr1}_${pr2}.tar.zst ./*
mv ${pr1}_${pr2}.tar.zst $mergedpath/
cd $tmpdir/result
tar --use-compress-program /home/p/pbryant/pfs/zstd/programs/zstd -cf ${pr1}_${pr2}.tar.zst ./*
mv ${pr1}_${pr2}.tar.zst $resultpath/

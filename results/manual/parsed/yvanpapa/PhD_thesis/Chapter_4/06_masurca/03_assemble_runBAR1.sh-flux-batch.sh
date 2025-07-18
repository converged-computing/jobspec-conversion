#!/bin/bash
#FLUX: --job-name=run1_masurca
#FLUX: -c=32
#FLUX: --queue=bigmem
#FLUX: -t=864000
#FLUX: --urgency=16

export PATH='/home/software/apps/masurca/3.4.1/bin/../CA8/Linux-amd64/bin:/home/software/apps/masurca/3.4.1/bin:$PATH'
export PERL5LIB='/home/software/apps/masurca/3.4.1/bin/../lib/perl${PERL5LIB:+:$PERL5LIB}'
export PE_AVG_READ_LENGTH='`awk '{if(length($1)>31){n+=length($1);m++;}}END{print int(n/m)}' pe_data.tmp`'
export ESTIMATED_GENOME_SIZE='`jellyfish histo -t 32 -h 1 k_u_hash_0 | tail -n 1 |awk '{print $2}'`'

module load masurca/3.4.1
CONFIG_PATH="/nfs/scratch/papayv/Tarakihi/TARdn/Z_fish_assemblies/7_masurca/BAR/run1/sr_config_runBAR.txt"
CMD_PATH="/home/software/apps/masurca/3.4.1/bin/masurca"
set -o pipefail
(eval "cat <(echo test) >/dev/null" 2>/dev/null) || {
  echo >&2 "ERROR: The shell used is missing important features."
  echo >&2 "       Run the assembly script directly as './$0'"
  exit 1
}
while getopts ":rc" o; do
  case "${o}" in
    c)
    echo "configuration file is '$CONFIG_PATH'"
    exit 0
    ;;
    r)
    echo "Rerunning configuration"
    exec perl "$CMD_PATH" "$CONFIG_PATH"
    echo "Failed to rerun configuration"
    exit 1
    ;;
    *)
    echo "Usage: $0 [-r] [-c]"
    exit 1
    ;;
  esac
done
set +e
save () {
  (echo -n "$1=\""; eval "echo -n \"\$$1\""; echo '"') >> environment.sh
}
GC=
RC=
NC=
if tty -s < /dev/fd/1 2> /dev/null; then
  GC='\e[0;32m'
  RC='\e[0;31m'
  NC='\e[0m'
fi
log () {
  d=$(date)
  echo -e "${GC}[$d]${NC} $@"
}
fail () {
  d=$(date)
  echo -e "${RC}[$d]${NC} $@"
  exit 1
}
signaled () {
  fail Interrupted
}
trap signaled TERM QUIT INT
rm -f environment.sh; touch environment.sh
export PATH="/home/software/apps/masurca/3.4.1/bin/../CA8/Linux-amd64/bin:/home/software/apps/masurca/3.4.1/bin:$PATH"
save PATH
export PERL5LIB=/home/software/apps/masurca/3.4.1/bin/../lib/perl${PERL5LIB:+:$PERL5LIB}
save PERL5LIB
NUM_THREADS=32
save NUM_THREADS
log 'Processing pe library reads'
rm -rf meanAndStdevByPrefix.pe.txt
echo 'pe 350 50' >> meanAndStdevByPrefix.pe.txt
rename_filter_fastq 'pe' <(exec expand_fastq '/nfs/scratch/papayv/Tarakihi/TARdn/Z_fish_assemblies/4b_bwa_mitogenome/003_BAR.mitogenome.unmapped.end1.fq.gz' | awk '{if(length($0>250)) print substr($0,1,250); else print $0;}') <(exec expand_fastq '/nfs/scratch/papayv/Tarakihi/TARdn/Z_fish_assemblies/4b_bwa_mitogenome/003_BAR.mitogenome.unmapped.end2.fq.gz' | awk '{if(length($0>250)) print substr($0,1,250); else print $0;}' ) > 'pe.renamed.fastq'
head -q -n 40000  pe.renamed.fastq | grep --text -v '^+' | grep --text -v '^@' > pe_data.tmp
export PE_AVG_READ_LENGTH=`awk '{if(length($1)>31){n+=length($1);m++;}}END{print int(n/m)}' pe_data.tmp`
save PE_AVG_READ_LENGTH
log Average PE read length $PE_AVG_READ_LENGTH
KMER=`for f in pe.renamed.fastq;do head -n 80000 $f |tail -n 40000;done | perl -e 'while($line=<STDIN>){$line=<STDIN>;chomp($line);push(@lines,$line);for($i=0;$i<6;$i++){$line=<STDIN>;}}$min_len=100000;$base_count=0;foreach $l(@lines){$base_count+=length($l);push(@lengths,length($l));@f=split("",$l);foreach $base(@f){if(uc($base) eq "G" || uc($base) eq "C"){$gc_count++}}} @lengths =sort {$b <=> $a} @lengths; $min_len=$lengths[int($#lengths*.75)];  $gc_ratio=$gc_count/$base_count;$kmer=0;if($gc_ratio>=0.35 && $gc_ratio<=0.6){$kmer=int($min_len*.66);}else{$kmer=int($min_len*.33);} $kmer++ if($kmer%2==0); $kmer=31 if($kmer<31); $kmer=127 if($kmer>127); print $kmer'`
save KMER
log Using kmer size of $KMER for the graph
KMER_J=$KMER
MIN_Q_CHAR=`cat pe.renamed.fastq |head -n 50000 | awk 'BEGIN{flag=0}{if($0 ~ /^\+/){flag=1}else if(flag==1){print $0;flag=0}}'  | perl -ne 'BEGIN{$q0_char="@";}{chomp;@f=split "";foreach $v(@f){if(ord($v)<ord($q0_char)){$q0_char=$v;}}}END{$ans=ord($q0_char);if($ans<64){print "33\n"}else{print "64\n"}}'`
save MIN_Q_CHAR
log MIN_Q_CHAR: $MIN_Q_CHAR
JF_SIZE=`ls -l *.fastq | awk '{n+=$5}END{s=int(n/50); if(s>13000000000)printf "%.0f",s;else print "13000000000";}'`
save JF_SIZE
perl -e '{if(int('$JF_SIZE')>13000000000){print "WARNING: JF_SIZE set too low, increasing JF_SIZE to at least '$JF_SIZE', this automatic increase may be not enough!\n"}}'
log Creating mer database for Quorum
awk '{print substr($0,1,200)}' pe.renamed.fastq | quorum_create_database -t 32 -s $JF_SIZE -b 7 -m 24 -q $((MIN_Q_CHAR + 5)) -o quorum_mer_db.jf.tmp /dev/stdin && mv quorum_mer_db.jf.tmp quorum_mer_db.jf
if [ 0 != 0 ]; then
  fail Increase JF_SIZE in config file, the recommendation is to set this to genome_size*coverage/2
fi
log Error correct PE
quorum_error_correct_reads  -q $(($MIN_Q_CHAR + 40)) --contaminant=/home/software/apps/masurca/3.4.1/bin/../share/adapter.jf -m 1 -s 1 -g 1 -a 3 -t 32 -w 10 -e 3 -M  quorum_mer_db.jf pe.renamed.fastq --no-discard -o pe.cor.tmp --verbose 1>quorum.err 2>&1 && mv pe.cor.tmp.fa pe.cor.fa || fail Error correction of PE reads failed. Check pe.cor.log.
if [ -s ESTIMATED_GENOME_SIZE.txt ];then
ESTIMATED_GENOME_SIZE=`head -n 1 ESTIMATED_GENOME_SIZE.txt`
else
log Estimating genome size
jellyfish count -m 31 -t 32 -C -s $JF_SIZE -o k_u_hash_0 pe.cor.fa
export ESTIMATED_GENOME_SIZE=`jellyfish histo -t 32 -h 1 k_u_hash_0 | tail -n 1 |awk '{print $2}'`
echo $ESTIMATED_GENOME_SIZE > ESTIMATED_GENOME_SIZE.txt
fi
save ESTIMATED_GENOME_SIZE
log "Estimated genome size: $ESTIMATED_GENOME_SIZE"
log Creating k-unitigs with k=$KMER
create_k_unitigs_large_k -c $(($KMER-1)) -t 32 -m $KMER -n $(($ESTIMATED_GENOME_SIZE*2)) -l $KMER -f `perl -e 'print 1/'$KMER'/1e5'` pe.cor.fa  | grep --text -v '^>' | perl -ane '{$seq=$F[0]; $F[0]=~tr/ACTGactg/TGACtgac/;$revseq=reverse($F[0]); $h{($seq ge $revseq)?$seq:$revseq}=1;}END{$n=0;foreach $k(keys %h){print ">",$n++," length:",length($k),"\n$k\n"}}' > guillaumeKUnitigsAtLeast32bases_all.fasta.tmp && mv guillaumeKUnitigsAtLeast32bases_all.fasta.tmp guillaumeKUnitigsAtLeast32bases_all.fasta
if [[ $KMER -eq $KMER_J ]];then
ln -s guillaumeKUnitigsAtLeast32bases_all.fasta guillaumeKUnitigsAtLeast32bases_all.jump.fasta
else
log Creating k-unitigs with k=$KMER_J
create_k_unitigs_large_k -c $(($KMER_J-1)) -t 32 -m $KMER_J -n $(($ESTIMATED_GENOME_SIZE*2)) -l $KMER_J -f `perl -e 'print 1/'$KMER_J'/1e5'` pe.cor.fa  | grep --text -v '^>' | perl -ane '{$seq=$F[0]; $F[0]=~tr/ACTGactg/TGACtgac/;$revseq=reverse($F[0]); $h{($seq ge $revseq)?$seq:$revseq}=1;}END{$n=0;foreach $k(keys %h){print ">",$n++," length:",length($k),"\n$k\n"}}' > guillaumeKUnitigsAtLeast32bases_all.jump.fasta.tmp && mv guillaumeKUnitigsAtLeast32bases_all.jump.fasta.tmp guillaumeKUnitigsAtLeast32bases_all.jump.fasta 
fi
log 'Computing super reads from PE '
rm -rf work1
CA_DIR="CA";
createSuperReadsForDirectory.perl -l $KMER -mean-and-stdev-by-prefix-file meanAndStdevByPrefix.pe.txt -kunitigsfile guillaumeKUnitigsAtLeast32bases_all.fasta -t 32 -mikedebug work1 pe.cor.fa 1> super1.err 2>&1
if [[ ! -e work1/superReads.success ]];then
fail Super reads failed, check super1.err and files in ./work1/
fi
ufasta extract -f <( awk 'BEGIN{last_readnumber=-1;last_super_read=""}{readnumber=int(substr($1,3));if(readnumber%2>0){readnumber--}super_read=$2;if(readnumber==last_readnumber){if(super_read!=last_super_read){print read;print $1;}}else{read=$1;last_super_read=$2}last_readnumber=readnumber}' work1/readPlacementsInSuperReads.final.read.superRead.offset.ori.txt )  pe.cor.fa > pe.linking.fa.tmp && mv pe.linking.fa.tmp pe.linking.fa
NUM_LINKING_MATES=`wc -l pe.linking.fa | perl -ane '{print int($F[0]/2)}'`
MAX_LINKING_MATES=`perl -e '{$g=int('$ESTIMATED_GENOME_SIZE'/2);$g=100000000 if($g>100000000);print $g}'`
grep --text -A 1 '^>pe' pe.linking.fa | grep --text -v '^\-\-' | sample_mate_pairs.pl $MAX_LINKING_MATES $NUM_LINKING_MATES 1 > pe.tmp && error_corrected2frg pe 350 50 2000000000 pe.tmp > pe.linking.frg.tmp && rm pe.tmp && mv pe.linking.frg.tmp pe.linking.frg
log "Using linking mates"
create_sr_frg.pl 65535 < work1/superReadSequences.fasta 2>/dev/null | fasta2frg.pl super >  superReadSequences_shr.frg.tmp && mv superReadSequences_shr.frg.tmp superReadSequences_shr.frg
echo 1 > PLOIDY.txt
log 'Celera Assembler'
rm -rf CA
echo "gkpFixInsertSizes=0
merylThreads=32
merylMemory=32768
ovlStoreMemory=32768
ovlThreads=2
frgCorrThreads=2
frgCorrConcurrency=32 
ovlCorrConcurrency=32 
ovlConcurrency=32
useGrid=0
gridEngine=SLURM
unitigger=bogart
utgGraphErrorLimit=1000
utgMergeErrorLimit=1000
utgGraphErrorRate=0.015
utgMergeErrorRate=0.025
ovlCorrBatchSize=100000
doUnitigSplitting=0
cgwDemoteRBP=0
doChimeraDetection=normal
merylThreads=32
computeInsertSize=0
cnsOnGrid=0
cnsConcurrency=32
cnsMinFrags=10000
cnsMaxCoverage=7
cnsReuseUnitigs=1
cgwErrorRate=0.1" > runCA.spec
runCA -s runCA.spec stopAfter=initialStoreBuilding -p genome -d CA cgwErrorRate=0.15 doFragmentCorrection=0 doOverlapBasedTrimming=0 doExtendClearRanges=0 ovlMerSize=30 superReadSequences_shr.frg   pe.linking.frg    1> runCA0.out 2>&1
TOTAL_READS=`gatekeeper -dumpinfo -lastfragiid CA/genome.gkpStore | awk '{print $NF}'`
save TOTAL_READS
ovlRefBlockSize=`perl -e '$s=int('$TOTAL_READS'/5); if($s>100000){print $s}else{print "100000"}'`
save ovlRefBlockSize
ovlHashBlockLength=10000000
save ovlHashBlockLength
ovlCorrBatchSize=`perl -e '$s=int('$TOTAL_READS'/100); if($s>10000){print $s}else{print "10000"}'`
save ovlCorrBatchSize
echo "ovlRefBlockSize=$ovlRefBlockSize 
ovlHashBlockLength=$ovlHashBlockLength
ovlCorrBatchSize=$ovlCorrBatchSize
" >> runCA.spec
rm -f CA/0-overlaptrim-overlap/overlap.sh CA/1-overlapper/overlap.sh CA/3-overlapcorrection/frgcorr.sh CA/3-overlapcorrection/ovlcorr.sh CA/5-consensus/consensus.sh
runCA -s runCA.spec stopBefore=scaffolder -p genome -d CA cgwErrorRate=0.15 doFragmentCorrection=0 doOverlapBasedTrimming=0 doExtendClearRanges=0 ovlMerSize=30 superReadSequences_shr.frg   pe.linking.frg    1> runCA1.out 2>&1
if [ ! -d CA/1-overlapper ]; then
  rm -f CA/0-overlaptrim-overlap/overlap.sh CA/1-overlapper/overlap.sh && 
  runCA -s runCA.spec -p genome -d CA stopBefore=scaffolder doFragmentCorrection=0 doOverlapBasedTrimming=0 doExtendClearRanges=0 ovlMerSize=30 superReadSequences_shr.frg   pe.linking.frg    1>>runCA1.out 2>&1
fi
if [ ! -d CA/3-overlapcorrection ]; then
  rm -f CA/0-overlaptrim-overlap/overlap.sh CA/1-overlapper/overlap.sh && 
  runCA -s runCA.spec -p genome -d CA stopBefore=scaffolder doFragmentCorrection=0 doOverlapBasedTrimming=0 doExtendClearRanges=0 ovlMerSize=30 superReadSequences_shr.frg   pe.linking.frg    1>>runCA1.out 2>&1
fi
if [ ! -e CA/4-unitigger/unitigger.err ]; then
  rm -f CA/0-overlaptrim-overlap/overlap.sh CA/1-overlapper/overlap.sh CA/3-overlapcorrection/frgcorr.sh CA/3-overlapcorrection/ovlcorr.sh
  echo doFragmentCorrection=0 >> runCA.spec
  runCA -s runCA.spec -p genome -d CA stopBefore=scaffolder doFragmentCorrection=0 doOverlapBasedTrimming=0 doExtendClearRanges=0 ovlMerSize=30 superReadSequences_shr.frg   pe.linking.frg    1>>runCA1.out 2>&1
fi
if [ -e CA/4-unitigger/unitigger.err ];then
  log Overlap/unitig success
else
  fail Overlap/unitig failed, check output under CA/ and runCA1.out, try re-generating and re-running assemble.sh
fi
if [ ! -e CA/recompute_astat.success ];then
  log "Recomputing A-stat for super-reads"
  recompute_astat_superreads_CA8.sh genome CA $PE_AVG_READ_LENGTH work1/readPlacementsInSuperReads.final.read.superRead.offset.ori.txt superReadSequences_shr.frg
fi
if [ ! -e CA/overlapFilter.success ];then
NUM_SUPER_READS=`cat superReadSequences_shr.frg  | grep -c --text '^{FRG' `
save NUM_SUPER_READS
log "Filtering overlaps"
( cd CA && 
tigStore -g genome.gkpStore -t genome.tigStore 5 -U -d consensus | 
awk -F "=" 'BEGIN{print ">unique unitigs";flag=0}{if($1 ~ /^>/){if($6>=5){flag=1}}else{if(flag){print $1"N"}flag=0}}' | 
jellyfish count -L 2 -C -m 30 -s $ESTIMATED_GENOME_SIZE -t 32 -o unitig_mers /dev/fd/0 && 
cat <(overlapStore -b 1 -e $NUM_SUPER_READS -d genome.ovlStore  | awk '{if($1<$2 && ($1<'$NUM_SUPER_READS' && $2<'$NUM_SUPER_READS')) print $0}'|filter_overlap_file -t 32 <(gatekeeper  -dumpfragments -withsequence genome.gkpStore| grep -P '^fragmentIdent|^fragmentSequence' | awk 'BEGIN{flag=1}{if(flag){print ">"$3}else{ print $3;} flag=1-flag; }') unitig_mers /dev/fd/0) <(overlapStore -d genome.ovlStore | awk '{if($1<$2 && ($1>='$NUM_SUPER_READS' || $2>='$NUM_SUPER_READS')) print $1" "$2" "$3" "$4" "$5" "$6" "$7}')  |convertOverlap -ovl |gzip > overlaps_dedup.ovb.gz &&  
overlapStoreBuild -o genome.ovlStore.BUILDING -M 32768 -g genome.gkpStore overlaps_dedup.ovb.gz 1>overlapStore.rebuild.err 2>&1 &&  
rm -rf ovlStoreBackup && 
mkdir ovlStoreBackup && 
mv 4-unitigger 5-consensus 5-consensus-coverage-stat 5-consensus-insert-sizes genome.tigStore genome.ovlStore ovlStoreBackup && 
mv genome.ovlStore.BUILDING genome.ovlStore && rm recompute_astat.success && touch overlapFilter.success
)
runCA -s runCA.spec stopBefore=scaffolder -p genome -d CA cgwErrorRate=0.15 doFragmentCorrection=0 doOverlapBasedTrimming=0 doExtendClearRanges=0 ovlMerSize=30 superReadSequences_shr.frg   pe.linking.frg    1> runCA2.out 2>&1 
log "Recomputing A-stat for super-reads"
recompute_astat_superreads_CA8.sh genome CA $PE_AVG_READ_LENGTH work1/readPlacementsInSuperReads.final.read.superRead.offset.ori.txt superReadSequences_shr.frg
fi
runCA -s runCA.spec cgwErrorRate=0.15 -p genome -d CA doFragmentCorrection=0 doOverlapBasedTrimming=0 doExtendClearRanges=0 ovlMerSize=30 1>runCA3.out 2>&1
if [[ -e "CA/9-terminator/genome.qc" ]];then
  log "CA success"
else
  fail CA failed, check output under CA/ and runCA3.out
fi
if [ ! -d $CA_DIR ];then
  fail "mega-reads exited before assembly"
fi
TERMINATOR="9-terminator"
if [ -s $CA_DIR/9-terminator/genome.scf.fasta ];then
  NSCF=`grep --text '^>'  $CA_DIR/9-terminator/genome.scf.fasta |wc -l`
  NCTG=`grep --text '^>'  $CA_DIR/9-terminator/genome.ctg.fasta |wc -l`
  if [ $NCTG -eq $NSCF ];then
    log 'No gap closing possible'
  else
    TERMINATOR="10-gapclose"
    if [ -s $CA_DIR/10-gapclose/genome.scf.fasta ];then
      log 'Gap closing done'
    else
      log 'Gap closing'
      closeGapsLocally.perl --max-reads-in-memory 1000000000 -s 13000000000 --Celera-terminator-directory $CA_DIR/9-terminator --reads-file 'pe.renamed.fastq' --output-directory $CA_DIR/10-gapclose --min-kmer-len 17 --max-kmer-len $(($PE_AVG_READ_LENGTH-5)) --num-threads 32 --contig-length-for-joining $(($PE_AVG_READ_LENGTH-1)) --contig-length-for-fishing 200 --reduce-read-set-kmer-size 21 1>gapClose.err 2>&1
      if [[ -s "$CA_DIR/10-gapclose/genome.ctg.fasta" ]];then
        log 'Gap close success'
      else
        fail Gap close failed, you can still use pre-gap close files under $CA_DIR/9-terminator/. Check gapClose.err for problems.
      fi
    fi
  fi
else
  fail "Assembly stopped or failed, see $CA_DIR.log"
fi
if [ -s $CA_DIR/$TERMINATOR/genome.scf.fasta ];then
  if [ ! -e $CA_DIR/filter_map.contigs.success ];then
  log 'Removing redundant scaffolds'
    PLOIDY=`cat PLOIDY.txt`
    deduplicate_contigs.sh $CA_DIR genome 32 $PLOIDY $TERMINATOR && log "Assembly complete, final scaffold sequences are in $CA_DIR/final.genome.scf.fasta"
  else
  log "Assembly complete, final scaffold sequences are in $CA_DIR/final.genome.scf.fasta"
  fi
else
  fail "Assembly stopped or failed, see $CA_DIR.log"
fi
log 'All done'
log "Final stats for $CA_DIR/final.genome.scf.fasta"
ufasta n50 -A -S -C -E -N50 $CA_DIR/final.genome.scf.fasta

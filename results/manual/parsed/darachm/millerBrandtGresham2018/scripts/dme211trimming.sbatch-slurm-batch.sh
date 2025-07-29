#!/bin/bash
#FLUX: --job-name=dme211trimming
#FLUX: -t=43200
#FLUX: --urgency=16

WORKDIR=$(pwd) 
mkdir -p ${WORKDIR}"/tmp/dme211"
DATADIR="data/dme211/dme211_fastq/"
module purge
module load cutadapt/intel/1.12
unset indicies
declare -A indicies
unset adapterName
declare -A adapterName
IFS=$'\n';
for i in $(tail -n +2 data/dme211/dme211barcodeIndex.csv );do 
  thisSampleName=$(echo -n $i | perl -ne '/^(.+?),(.+?),(.+?),(.+?)$/;print $1;' ); 
  thisAdapterName=$(echo -n $i | perl -ne '/^(.+?),(.+?),(.+?),(.+?)$/;print $3;' ); 
  adapterIndex=$(echo -n $i | perl -ne '/^(.+?),(.+?),(.+?),(.+?)$/;print $4;' ); 
  indicies["${thisAdapterName}"]="${adapterIndex}";
  adapterName["${thisSampleName}"]="${thisAdapterName}";
done;
echo "Read in:"
echo ${!adapterName[@]}
echo "as mapping to"
echo ${adapterName[@]}
echo "and"
echo ${!indicies[@]}
echo "as mapping to"
echo "${indicies[@]}"
echo 
unset adaptSeq
declare -A adaptSeq
IFS=$'\n';
for i in $(tail -n +2 data/dme211/trumiseqAdapters.csv );do 
  thisSampleName=$(echo -n $i | perl -ne '/^(DG.+)_P7,(.+?)$/;print $1;' ); 
  if [ "$thisSampleName" != "" ]; then
    thisAdapterSeq=$(echo -n $i | perl -ne '/^(DGseq_.+?)_P7,(.+?)$/;print $2;' ); 
    adaptSeq["$thisSampleName"]="${thisAdapterSeq}";
  fi
done;
echo "Read in:"
echo ${!adaptSeq[@]}
echo "as mapping to"
echo ${adaptSeq[@]}
echo 
for i in $(/bin/ls $DATADIR | grep "_[wq]1\?[0-9]_"); do
  echo `date`
  thisSampleName=$(echo -n $i | gawk -F _ '{print $3}');
  thisAdapterName=${adapterName["$thisSampleName"]}
  echo "doing file $i, which is $thisSampleName, which is $thisAdapterName"
  thisAdaptSeq=${adaptSeq["$thisAdapterName"]}
  thisIndex=${indicies["${adapterName["$thisSampleName"]}"]}
  runstring="
cat ${DATADIR}$i | grep --regexp ^$ --invert-match > tmp/dme211/fixed$i;
cutadapt -a A${thisAdaptSeq} --cut=0 -o tmp/dme211/dme211.${thisSampleName}.${adapterName["$thisSampleName"]}.$thisIndex.adapterTrimmed.fastq tmp/dme211/fixed$i"
  echo $runstring
  eval $runstring
done;
unset runstring
mv tmp/dme211/xtrimmingJobID tmp/dme211/xtrimmingMarker

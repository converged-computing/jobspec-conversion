#!/bin/bash
#FLUX: --job-name=${groupname}_done
#FLUX: --queue=${queue}
#FLUX: -t=6000
#FLUX: --urgency=16

export PATH='/gpfs0/biobuild/biobuilds-2016.11/bin:$PATH'
export TMPDIR='${tmpdir}'
export LC_COLLATE='C'
export IBM_JAVA_OPTIONS='-Xmx73728m -Xgcthreads1'
export _JAVA_OPTIONS='-Xms73728m -Xmx73728m'

juicer_version="1.5.7"
isRice=$(hostname | awk '{if ($1~/rice/){print 1}else {print 0}}')
isBCM=$(hostname | awk '{if ($1~/bcm/){print 1}else {print 0}}')
isVoltron=0
if [ $isRice -eq 1 ]
then
myPath=/bin:$PATH
load_bwa="module load BioBuilds/2015.04"
load_java="module load Java/8.0.3.22"
load_gpu="module load gcccuda/2016a;module load CUDA/8.0.54;"
juiceDir="/projects/ea14/juicer" ### RICE
queue="commons"
long_queue="commons"
long_queue_time="1440"
elif [ $isBCM -eq 1 ]
then
juiceDir="/storage/aiden/juicer/"
queue="mhgcp"
queue_time="1200"
long_queue="mhgcp"
long_queue_time="3600"
else
isVoltron=1
load_gpu="CUDA_VISIBLE_DEVICES=0,1,2,3"
juiceDir="/gpfs0/juicer/"
queue="commons"
long_queue="long"
long_queue_time="10080"
fi
groupname="a$(date +%s)"
topDir=$(pwd)
site="MboI"
genomeID="hg19"
exclude=1
usageHelp="Usage: ${0##*/} -g genomeID [-d topDir] [-s site] [-S stage] [-b ligation] [-D Juicer scripts directory] [-q queue] [-l long queue] [-Q queue time] [-L long queue time] [-f] [-h]"
genomeHelp="   genomeID is either defined in the script, e.g. \"hg19\" or \"mm10\" or the path to the chrom.sizes file"
dirHelp="   [topDir] is the top level directory (default \"$topDir\") and must contain links to all merged_nodups files underneath it"
siteHelp="   [site] must be defined in the script, e.g.  \"HindIII\" or \"MboI\" (default \"$site\"); alternatively, this can be the restriction site file"
stageHelp="* [stage]: must be one of \"final\", \"postproc\", or \"early\".\n    -Use \"final\" when the reads have been combined into merged_nodups but the\n     final stats and hic files have not yet been created.\n    -Use \"postproc\" when the hic files have been created and only\n     postprocessing feature annotation remains to be completed.\n    -Use \"early\" for an early exit, before the final creation of the stats and\n     hic files"
ligationHelp="* [ligation junction]: use this string when counting ligation junctions"
scriptDirHelp="* [Juicer scripts directory]: set the Juicer directory,\n  which should have scripts/ references/ and restriction_sites/ underneath it\n  (default ${juiceDir})"
excludeHelp="   -f: include fragment-delimited maps from Hi-C mega map (will run slower)"
helpHelp="   -h: print this help and exit"
printHelpAndExit() {
echo "$usageHelp"
echo "$genomeHelp"
echo "$dirHelp"
echo "$siteHelp"
echo "$stageHelp"
echo "$ligationHelp"
echo "$excludeHelp"
echo "$helpHelp"
exit "$1"
}
while getopts "d:g:hfs:S:l:L:q:Q:b:D:" opt; do
case $opt in
g) genomeID=$OPTARG ;;
h) printHelpAndExit 0;;
d) topDir=$OPTARG ;;
s) site=$OPTARG ;;
f) exclude=0 ;;
S) stage=$OPTARG ;;
l) long_queue=$OPTARG ;;
L) long_queue_time=$OPTARG ;;
q) queue=$OPTARG ;;
Q) queue_time=$OPTARG ;;
b) ligation=$OPTARG ;;
D) juiceDir=$OPTARG ;;
[?]) printHelpAndExit 1;;
esac
done
if [ -z "$ligation" ]; then
case $site in
HindIII) ligation="AAGCTAGCTT";;
DpnII) ligation="GATCGATC";;
MboI) ligation="GATCGATC";;
none) ligation="XXXX";;
*)  ligation="XXXX"
site_file=$site
echo "$site not listed as recognized enzyme, so trying it as site file."
echo "Ligation junction is undefined";;
esac
fi
if [ -z "$site_file" ]
then
site_file="${juiceDir}/restriction_sites/${genomeID}_${site}.txt"
fi
if [ ! -e "$site_file" ] && [ "$site" != "none" ]
then
echo "***! $site_file does not exist. It must be created before running this script."
echo "The site file is used for statistics even if fragment delimited maps are excluded"
exit 1
fi
if [ ! -z "$stage" ]
then
case $stage in
final) final=1 ;;
early) early=1 ;;
postproc) postproc=1 ;;
*)  echo "$usageHelp"
echo "$stageHelp"
exit 1
esac
fi
megadir=${topDir}"/mega"
outputdir=${megadir}"/aligned"
tmpdir=${megadir}"/HIC_tmp"
outfile=${megadir}/lsf.out
logdir="$megadir/debug"
touchfile1=${megadir}/touch1
touchfile2=${megadir}/touch2
touchfile3=${megadir}/touch3
touchfile4=${megadir}/touch4
touchfile5=${megadir}/touch5
touchfile6=${megadir}/touch6
touchfile7=${megadir}/touch7
touchfile8=${megadir}/touch8
merged_count=`find -L ${topDir} | grep merged_nodups.txt | wc -l`
if [ "$merged_count" -lt "1" ]
then
echo "***! Failed to find at least one merged_nodups files under ${topDir}"
exit 1
fi
merged_names=$(find -L ${topDir} | grep merged_nodups.txt.gz | awk '{print "<(gunzip -c",$1")"}' | tr '\n' ' ')
if [ ${#merged_names} -eq 0 ]
then
merged_names=$(find -L ${topDir} | grep merged_nodups.txt | tr '\n' ' ')
fi
inter_names=$(find -L ${topDir} | grep inter.txt | tr '\n' ' ')
if [[ -d "${outputdir}" ]] && [ -z $final ] && [ -z $postproc ]
then
echo "***! Move or remove directory \"${outputdir}\" before proceeding."
exit 101
else
mkdir -p ${outputdir}
fi
if [ ! -d "$tmpdir" ]; then
mkdir $tmpdir
chmod 777 $tmpdir
fi
if [ ! -d "$logdir" ]; then
mkdir "$logdir"
chmod 777 "$logdir"
fi
if [ -z $final ] && [ -z $postproc ]
then
jid1=`sbatch <<- TOPSTATS | egrep -o -e "\b[0-9]+$"
if ! awk -f ${juiceDir}/scripts/makemega_addstats.awk ${inter_names} > ${outputdir}/inter.txt
then
echo "***! Some problems occurred somewhere in creating top stats files."
exit 100
else
echo "(-: Finished creating top stats files."
cp ${outputdir}/inter.txt ${outputdir}/inter_30.txt
fi
touch $touchfile1
TOPSTATS`
dependtopstats="afterok:$jid1"
jid2=`sbatch <<- MRGSRT | egrep -o -e "\b[0-9]+$"
if [ ! -f "${touchfile1}" ]
then
echo "***! Top stats job failed, type \"scontrol show job $jid1\" to see what happened."
exit 1
fi
if [ $isRice -eq 1 ]
then
if ! ${juiceDir}/scripts/sort --parallel=48 -S8G -T ${tmpdir} -m -k2,2d -k6,6d ${merged_names} > ${outputdir}/merged_nodups.txt
then
echo "***! Some problems occurred somewhere in creating sorted merged_nodups files."
exit 1
fi
else
if ! sort --parallel=40 -T ${tmpdir} -m -k2,2d -k6,6d ${merged_names} > ${outputdir}/merged_nodups.txt
then
echo "***! Some problems occurred somewhere in creating sorted merged_nodups files."
exit 1
else
echo "(-: Finished sorting all merged_nodups files into a single merge."
rm -r ${tmpdir}
fi
fi
touch $touchfile2
MRGSRT`
dependmerge="#SBATCH -d afterok:$jid2"
else
touch $touchfile1
touch $touchfile2
fi
if [ -z $postproc ] && [ -z $early ]
then
jid3=`sbatch <<- INTER0 | egrep -o -e "\b[0-9]+$"
${dependmerge}
if [ ! -f "${touchfile2}" ]
then
echo "***! Sort job failed."
exit 1
fi
if ${juiceDir}/scripts/statistics.pl -q 1 -o${outputdir}/inter.txt -s $site_file -l $ligation ${outputdir}/merged_nodups.txt
then
touch $touchfile3
fi
INTER0`
dependinter0="afterok:$jid3"
jid4=`sbatch <<- INTER30 | egrep -o -e "\b[0-9]+$"
${dependmerge}
if [ ! -f "${touchfile2}" ]
then
echo "***! Sort job failed."
exit 1
fi
if ${juiceDir}/scripts/statistics.pl -q 30 -o${outputdir}/inter_30.txt -s $site_file -l $ligation ${outputdir}/merged_nodups.txt
then
touch $touchfile4
fi
INTER30`
dependinter30="afterok:$jid4"
jid5=`sbatch <<- HIC0 | egrep -o -e "\b[0-9]+$"
$load_java
if [ ! -f "${touchfile3}" ]
then
echo "***! Statistics q=1 job failed."
exit 1
fi
if [ -z "$exclude" ] &&  ${juiceDir}/scripts/juicer_tools pre -f ${site_file} -s ${outputdir}/inter.txt -g ${outputdir}/inter_hists.m -q 1 ${outputdir}/merged_nodups.txt ${outputdir}/inter.hic ${genomeID}
then
touch $touchfile5
elif [ -n "$exclude" ] &&  ${juiceDir}/scripts/juicer_tools pre -s ${outputdir}/inter.txt -g ${outputdir}/inter_hists.m -q 1 ${outputdir}/merged_nodups.txt ${outputdir}/inter.hic ${genomeID}
then
touch $touchfile5
fi
HIC0`
dependhic0="afterok:$jid5"
jid6=`sbatch <<- HIC30 | egrep -o -e "\b[0-9]+$"
$load_java
if [ ! -f "${touchfile4}" ]
then
echo "***! Statistics q=30 job failed."
exit 1
fi
if [ -z "${exclude}" ] &&  ${juiceDir}/scripts/juicer_tools pre -f ${site_file} -s ${outputdir}/inter_30.txt -g ${outputdir}/inter_30_hists.m -q 30 ${outputdir}/merged_nodups.txt ${outputdir}/inter_30.hic ${genomeID}
then
touch $touchfile6
elif [ -n "${exclude}" ] && ${juiceDir}/scripts/juicer_tools pre -s ${outputdir}/inter_30.txt -g ${outputdir}/inter_30_hists.m -q 30 ${outputdir}/merged_nodups.txt ${outputdir}/inter_30.hic ${genomeID}
then
touch $touchfile6
fi
HIC30`
dependhic30only="afterok:$jid6"
sbatchdepend="#SBATCH -d ${dependhic30only}"
dependhic30="${dependhic0}:$jid6"
else
touch $touchfile3 $touchfile4 $touchfile5 $touchfile6
sbatchdepend=""
fi
if [ -z $early ]
then
touchfile7=${megadir}/touch7
if [ $isRice -eq 1 ] || [ $isVoltron -eq 1 ]
then
if [  $isRice -eq 1 ]
then
sbatch_req="#SBATCH --gres=gpu:kepler:1"
fi
jid7=`sbatch <<- HICCUPS | egrep -o -e "\b[0-9]+$"
${sbatchdepend}
${sbatch_req}
$load_java
if [ ! -f "${touchfile6}" ]
then
echo "***! HIC maps q=30 job failed."
exit 1
fi
${load_gpu}
${juiceDir}/scripts/juicer_hiccups.sh -j ${juiceDir}/scripts/juicer_tools -i $outputdir/inter_30.hic -m ${juiceDir}/references/motif -g $genomeID
touch $touchfile7
HICCUPS`
dependhic30="${dependhic30}:$jid7"
else
touch $touchfile7
fi
touchfile8=${megadir}/touch8
jid8=`sbatch <<- ARROWHEAD | egrep -o -e "\b[0-9]+$"
${sbatchdepend}
$load_java
if [ ! -f "${touchfile6}" ]
then
echo "***! HIC maps q=30 job failed."
exit 1
fi
${juiceDir}/scripts/juicer_arrowhead.sh -j ${juiceDir}/scripts/juicer_tools -i $outputdir/inter_30.hic
touch $touchfile8
ARROWHEAD`
dependhic30="${dependhic0}:$jid8"
jid9=`sbatch <<- FINAL | egrep -o -e "\b[0-9]+$"
if [ ! -f "${touchfile5}" ]
then
echo "***! Failed to make inter.hic."
exit 1
fi
if [ ! -f "${touchfile6}" ]
then
echo "***! Failed to make inter_30.hic."
exit 1
fi
if [ ! -f "${touchfile7}" ]
then
echo "***! Failed to create loop lists."
exit 1
fi
if [ ! -f "${touchfile8}" ]
then
echo "***! Failed to create domain lists."
exit 1
fi
rm -r ${tmpdir}
rm $touchfile1 $touchfile2 $touchfile3 $touchfile4 $touchfile5 $touchfile6 $touchfile7 $touchfile8
echo "(-: Successfully completed making mega map. Done. :-)"
if [ $isRice -eq 1 ]
then
echo $topDir, $site, $genomeID, $genomePath | mail -r MegaJuicer@rice.edu -s \"Mega Juicer pipeline finished successfully @ Rice\" -t $USER@rice.edu;
fi
FINAL`
else
jid9=`sbatch <<- FINAL | egrep -o -e "\b[0-9]+$"
rm -r ${tmpdir}
rm -f $touchfile1 $touchfile2 $touchfile3 $touchfile4 $touchfile5 $touchfile6 $touchfile7 $touchfile8
echo "(-: Successfully completed making mega map. Done. :-)"
FINAL`
fi
echo "(-: Finished adding all jobs... please wait while processing."

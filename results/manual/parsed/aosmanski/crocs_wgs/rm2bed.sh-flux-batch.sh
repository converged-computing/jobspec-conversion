#!/bin/bash
#FLUX: --job-name=cAcu_RM2bed
#FLUX: --queue=nocona
#FLUX: --priority=16

. ~/conda/etc/profile.d/conda.sh
conda activate
GENOME=cAcu
RUNTYPE=${GENOME}_RM
DIR=/lustre/scratch/aosmansk/new_croc_assemblies/repeatmasker/$RUNTYPE
cd $DIR
[ ! -f ${GENOME}_rm.bed ] && python /home/daray/gitrepositories/bioinfo_tools/RM2bed.py -d . -sp class -p ${GENOME} -o lower_divergence ${GENOME}.fa.align.gz
echo "calculating genome size"
GENOMESIZE=$(cat ${GENOME}.fa |  grep -v ">"  | wc | awk '{print $3-$1}')
echo "working on ${GENOME}"
UnknownBEDBP=$(awk '{SUM += $5} END {print SUM}' ${GENOME}_Unknown_rm.bed)
SINEBEDBP=$(awk '{SUM += $5} END {print SUM}' ${GENOME}_SINE_rm.bed)
RetroposonBEDBP=$(awk '{SUM += $5} END {print SUM}' ${GENOME}_Retroposon_rm.bed)
RCBEDBP=$(awk '{SUM += $5} END {print SUM}' ${GENOME}_RC_rm.bed)
LTRBEDBP=$(awk '{SUM += $5} END {print SUM}' ${GENOME}_LTR_rm.bed)
LINEBEDBP=$(awk '{SUM += $5} END {print SUM}' ${GENOME}_LINE_rm.bed)
DNABEDBP=$(awk '{SUM += $5} END {print SUM}' ${GENOME}_DNA_rm.bed)
echo "all subgroups calculated"
TEBEDBP=$(awk "BEGIN {print ($UnknownBEDBP + $SINEBEDBP + $RetroposonBEDBP + $RCBEDBP + $LTRBEDBP + $LINEBEDBP + $DNABEDBP)}")
echo "total calculated"
TEPROPORTION=$(awk "BEGIN {print ($TEBEDBP/$GENOMESIZE)}")
LINEPROPORTION=$(awk "BEGIN {print ($LINEBEDBP/$GENOMESIZE)}")
SINEPROPORTION=$(awk "BEGIN {print ($SINEBEDBP/$GENOMESIZE)}")
UNKNOWNPROPORTION=$(awk "BEGIN {print ($UnknownBEDBP/$GENOMESIZE)}")
RCPROPORTION=$(awk "BEGIN {print ($RCBEDBP/$GENOMESIZE)}")
LTRPROPORTION=$(awk "BEGIN {print ($LTRBEDBP/$GENOMESIZE)}")
DNAPROPORTION=$(awk "BEGIN {print ($DNABEDBP/$GENOMESIZE)}")
echo "Species TE_bp LINE_bp SINE_bp Genome_size TE_proportion LINE_proportion SINE_proportion LTR_proportion DNA_proportion RC_proportion Unknown_proportion" >te_table_total.txt
echo $GENOME $TEBEDBP $LINEBEDBP $SINEBEDBP $GENOMESIZE $TEPROPORTION $LINEPROPORTION $SINEPROPORTION $LTRPROPORTION $DNAPROPORTION $RCPROPORTION $UNKNOWNPROPORTION >> te_table_total.txt
YOUNGUnknownBEDBP=$(awk '{ if ($9 <= 22) {print}}' ${GENOME}_Unknown_rm.bed | awk '{SUM += $5} END {print SUM}' )
YOUNGSINEBEDBP=$(awk '{ if ($9 <= 22) {print}}' ${GENOME}_SINE_rm.bed | awk '{SUM += $5} END {print SUM}' )
YOUNGRetroposonBEDBP=$(awk '{ if ($9 <= 22) {print}}' ${GENOME}_Retroposon_rm.bed | awk '{SUM += $5} END {print SUM}' )
YOUNGRCBEDBP=$(awk '{ if ($9 <= 22) {print}}' ${GENOME}_RC_rm.bed | awk '{SUM += $5} END {print SUM}' )
YOUNGLTRBEDBP=$(awk '{ if ($9 <= 22) {print}}' ${GENOME}_LTR_rm.bed | awk '{SUM += $5} END {print SUM}' )
YOUNGLINEBEDBP=$(awk '{ if ($9 <= 22) {print}}' ${GENOME}_LINE_rm.bed | awk '{SUM += $5} END {print SUM}' )
YOUNGDNABEDBP=$(awk '{ if ($9 <= 22) {print}}' ${GENOME}_DNA_rm.bed | awk '{SUM += $5} END {print SUM}' )
echo "all young subgroups calculated"
YOUNGTEBEDBP=$(awk "BEGIN {print ($YOUNGUnknownBEDBP + $YOUNGSINEBEDBP + $YOUNGRetroposonBEDBP + $YOUNGRCBEDBP + $YOUNGLTRBEDBP + $YOUNGLINEBEDBP + $YOUNGDNABEDBP)}")
echo "total young calculated"
YOUNGTEPROPORTION=$(awk "BEGIN {print ($YOUNGTEBEDBP/$GENOMESIZE)}")
YOUNGLINEPROPORTION=$(awk "BEGIN {print ($YOUNGLINEBEDBP/$GENOMESIZE)}")
YOUNGSINEPROPORTION=$(awk "BEGIN {print ($YOUNGSINEBEDBP/$GENOMESIZE)}")
YOUNGUNKNOWNPROPORTION=$(awk "BEGIN {print ($YOUNGUnknownBEDBP/$GENOMESIZE)}")
YOUNGRCPROPORTION=$(awk "BEGIN {print ($YOUNGRCBEDBP/$GENOMESIZE)}")
YOUNGLTRPROPORTION=$(awk "BEGIN {print ($YOUNGLTRBEDBP/$GENOMESIZE)}")
YOUNGDNAPROPORTION=$(awk "BEGIN {print ($YOUNGDNABEDBP/$GENOMESIZE)}")
echo "Species TE_bp Young_LINE_bp Young_SINE_bp Genome_size Young_TE_proportion Young_LINE_proportion Young_SINE_proportion Young_LTR_proportion Young_DNA_proportion Young_RC_proportion Young_Unknown_proportion" >te_table_young.txt
echo $GENOME $TEBEDBP $YOUNGLINEBEDBP $YOUNGSINEBEDBP $GENOMESIZE $YOUNGTEPROPORTION $YOUNGLINEPROPORTION $YOUNGSINEPROPORTION $YOUNGLTRPROPORTION $YOUNGDNAPROPORTION $YOUNGRCPROPORTION $YOUNGUNKNOWNPROPORTION >> te_table_young.txt

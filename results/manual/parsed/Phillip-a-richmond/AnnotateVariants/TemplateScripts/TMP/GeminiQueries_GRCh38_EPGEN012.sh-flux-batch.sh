#!/bin/bash
#FLUX: --job-name=phat-hope-2766
#FLUX: -c=2
#FLUX: --queue=defq
#FLUX: -t=172800
#FLUX: --urgency=16

	# Removed LOOSE DP/GQ thresholds
	# Added SPLICEAI
	# Redid columns
	# Added FATHMM-XF-NONCODING
	# Added NONCODING - not coding, CADD >= 20 or FATHMM-XF >= 0.9
	# Added pop threshold on Clinvar to get rid of actionable polymorphisms
	# Added FATHMM-XF-NONCODING
	# Added De Novo LOW (de novo variants without predicted HIGH/MED impact, useful for WGS
	# Added new GEMINI location explicitly
	# Added mendel_errors
	# Changed strict min DP to 15
	# Set maximum number of homozygotes for cph query to 15
	# GRCh38: CADDv1.4, CADDv1.6, gnomADv3, clinvar, 
	# functional update for GPCC, including pairing with an update to the tableannotator 
ANNOTATE_VARIANTS_DIR=/mnt/common/WASSERMAN_SOFTWARE/AnnotateVariants/
source $ANNOTATE_VARIANTS_DIR/opt/miniconda3/etc/profile.d/conda.sh
conda activate $ANNOTATE_VARIANTS_DIR/opt/AnnotateVariantsEnvironment/
FAMILY_ID=EPGEN012
GEMINIDB=${FAMILY_ID}_Gemini.db
DATA_DIR=/mnt/scratch/Precision/EPGEN/PROCESS/EPGEN012_PAR/
WORKING_DIR=$DATA_DIR
cd $WORKING_DIR
module load singularity
singularity pull docker://quay.io/biocontainers/gemini:0.20.0--py27_0
GEMINI="singularity run -B /usr/lib/locale/:/usr/lib/locale/ -B $DATA_DIR:/data/ gemini_0.20.0--py27_0.sif  gemini" 
MTOOLBOX_RSCRIPT=$ANNOTATE_VARIANTS_DIR/MToolBox_config_files/Mtoolbox.R
TableAnnotator=$ANNOTATE_VARIANTS_DIR/TableAnnotators/GeminiTable2CVL.py
AUTODOM_OUT=$WORKING_DIR${FAMILY_ID}_autoDom
DENOVO_OUT=$WORKING_DIR${FAMILY_ID}_deNovo
DENOVO_LOW_OUT=$WORKING_DIR${FAMILY_ID}_deNovoLow
RECESSIVE_OUT=$WORKING_DIR${FAMILY_ID}_recessive
COMPOUND_HET_OUT=$WORKING_DIR${FAMILY_ID}_compoundHet
X_RECESSIVE_OUT=$WORKING_DIR${FAMILY_ID}_Xrecessive
X_DOMINANT_OUT=$WORKING_DIR${FAMILY_ID}_Xdominant
X_DENOVO_OUT=$WORKING_DIR${FAMILY_ID}_Xdenovo
MENDEL_ERRORS_OUT=$WORKING_DIR${FAMILY_ID}_mendelErrors
DBSTATFILE=${FAMILY_ID}_GeminiDB_Stats.txt
GENERAL_DAMAGING_HET=${FAMILY_ID}_GeneralDamaging_Het
GENERAL_DAMAGING_HOMO=${FAMILY_ID}_GeneralDamaging_Homo
CLINVAR_HITS=${FAMILY_ID}_Clinvar_Hits
SPLICING_HITS=${FAMILY_ID}_SpliceCandidates
NONCODING_HITS=${FAMILY_ID}_NoncodingCandidates
COLUMNS="chrom, start, end, ref, alt, gene, ensembl_gene_id, exon, aa_change, codon_change, vepprotein_position, transcript, biotype, hgvsc, hgvsp, impact, impact_severity, rs_ids, filter, gts, gt_ref_depths, gt_alt_depths, gt_alt_freqs, gt_quals, gt_types, gt_phases, gt_depths, gt_quals, gt_alt_freqs, gnomad_genome_ac_global, gnomad_genome_an_global, gnomad_genome_af_global, gnomad_genome_hom_global, gnomad_popmax_af, gnomad_nhomalt, cadd_v1_4, cadd_v1_4_indel, cadd_v1_6, cadd_v1_6_indel, polyphen_pred, polyphen_score, sift_pred, sift_score, vepspliceai_pred_dp_ag, vepspliceai_pred_dp_al, vepspliceai_pred_dp_dg, vepspliceai_pred_dp_dl, vepspliceai_pred_ds_ag, vepspliceai_pred_ds_al, vepspliceai_pred_ds_dg, vepspliceai_pred_ds_dl, vepspliceai_pred_symbol, vepmaxentscan_alt, vepmaxentscan_diff, vepmaxentscan_ref, veppubmed, vepexisting_variation, vepclin_sig, clinvar_dbinfo, clinvar_disease_name, clinvar_pathogenic, cosmic_coding_ids, cosmic_count_observed, somatic, clin_sig, pheno,hgvs_offset,impact_so" 
GNOMAD_GENOME_RARE="( ( (gnomad_genome_af_global <= 0.001) OR (gnomad_genome_af_global is NULL)) AND ((gnomad_genome_hom_global <= 10) OR (gnomad_genome_hom_global is NULL) ) )"
GNOMAD_GENOME_DENOVO_RARE="( ( (gnomad_genome_ac_global <= 5) OR (gnomad_genome_af_global is NULL)) AND ((gnomad_genome_hom_global <= 10) OR (gnomad_genome_hom_global is NULL) ) )"
GNOMAD_GENOME_CPH_RARE="( ( (gnomad_genome_af_global <= 0.001) OR (gnomad_genome_af_global is NULL)) AND ((gnomad_genome_hom_global <= 15) OR (gnomad_genome_hom_global is NULL) ) )"
CODING='is_coding=1'
EXONIC='is_exonic=1'
SPLICING='is_splicing=1'
LOF='is_lof=1'
IMPACT_HIGH="impact_severity=='HIGH'"
IMPACT_MED="impact_severity=='MED'"
IMPACT_LOW="impact_severity=='LOW'"
FILTER='(filter is NULL)'
CADD='((cadd_v1_4 >= 20) OR (cadd_v1_4_indel >= 20) OR (cadd_v1_6 >= 20) OR (cadd_v1_6_indel >= 20)) '
NONCODING="($CADD) AND (NOT $CODING)"
SPLICEAI='( (vepspliceai_pred_ds_ag > 0.5) OR ( vepspliceai_pred_ds_al > 0.5 ) OR ( vepspliceai_pred_ds_dl > 0.5 ) OR ( vepspliceai_pred_ds_dg > 0.5 ) )'
STRICT_MIN_DP=15
STRICT_MIN_GQ=30
echo "Starting Phase 1"
$GEMINI autosomal_recessive \
	--columns "$COLUMNS" \
	--filter "$FILTER AND ($IMPACT_HIGH OR $IMPACT_MED)" \
	$GEMINIDB > $RECESSIVE_OUT
python $TableAnnotator -i $RECESSIVE_OUT -o ${RECESSIVE_OUT}_annotated.txt
$GEMINI comp_hets \
	--columns "$COLUMNS" \
	--filter "$FILTER AND ($IMPACT_HIGH OR $IMPACT_MED)" \
	$GEMINIDB > $COMPOUND_HET_OUT
python $TableAnnotator -i $COMPOUND_HET_OUT -o ${COMPOUND_HET_OUT}_annotated.txt
$GEMINI de_novo \
	--columns "$COLUMNS" \
	--filter "$FILTER AND ($IMPACT_HIGH OR $IMPACT_MED)" \
	$GEMINIDB > $DENOVO_OUT
python $TableAnnotator -i $DENOVO_OUT -o ${DENOVO_OUT}_annotated.txt
$GEMINI de_novo \
	--columns "$COLUMNS" \
	--filter "$FILTER AND ($IMPACT_LOW)" \
	$GEMINIDB > $DENOVO_LOW_OUT
python $TableAnnotator -i $DENOVO_LOW_OUT -o ${DENOVO_LOW_OUT}_annotated.txt
$GEMINI x_linked_dominant  \
	--columns "$COLUMNS" \
	--filter "$FILTER AND ($IMPACT_HIGH OR $IMPACT_MED)"\
	$GEMINIDB > $X_DOMINANT_OUT
python $TableAnnotator -i $X_DOMINANT_OUT -o ${X_DOMINANT_OUT}_annotated.txt
$GEMINI x_linked_de_novo \
	--columns "$COLUMNS" \
	--filter "$FILTER AND ($IMPACT_HIGH OR $IMPACT_MED)"\
	$GEMINIDB > $X_DENOVO_OUT
python $TableAnnotator -i $X_DENOVO_OUT -o ${X_DENOVO_OUT}_annotated.txt
$GEMINI x_linked_recessive \
        --columns "$COLUMNS" \
	--filter "$FILTER AND ($IMPACT_HIGH OR $IMPACT_MED)"\
        $GEMINIDB > $X_RECESSIVE_OUT
python $TableAnnotator -i $X_RECESSIVE_OUT -o ${X_RECESSIVE_OUT}_annotated.txt
$GEMINI autosomal_dominant \
	--columns "$COLUMNS" \
	--filter "$FILTER AND ($IMPACT_HIGH OR $IMPACT_MED)"\
	$GEMINIDB > $AUTODOM_OUT
python $TableAnnotator -i $AUTODOM_OUT -o ${AUTODOM_OUT}_annotated.txt
$GEMINI mendel_errors \
	--columns "$COLUMNS" \
	--filter "$FILTER AND ($IMPACT_HIGH OR $IMPACT_MED)"\
	$GEMINIDB > $MENDEL_ERRORS_OUT
python $TableAnnotator -i $MENDEL_ERRORS_OUT -o ${MENDEL_ERRORS_OUT}_annotated.txt
GNOMAD_GENOME_COMMON='(gnomad_genome_af_global > 0.01)'
GNOMAD_GENOME_RARE='((gnomad_genome_af_global <= 0.01) or (gnomad_genome_af_global is NULL)) '
DBSNP='rs_ids is not NULL'
UTR='( (is_coding = 0) and (is_exonic = 1))'
$GEMINI query -q "SELECT * FROM samples" $GEMINIDB > $DBSTATFILE
echo "Annotation	Total	Common	Rare" >> $DBSTATFILE
TOTAL_VARS=`$GEMINI query -q "SELECT COUNT(*) FROM variants WHERE $FILTER" $GEMINIDB`
rareTOTAL_VARS=`$GEMINI query -q "SELECT COUNT(*) FROM variants WHERE $FILTER AND $GNOMAD_GENOME_RARE" $GEMINIDB`
commonTOTAL_VARS=`$GEMINI query -q "SELECT COUNT(*) FROM variants WHERE $FILTER AND ($GNOMAD_GENOME_COMMON)" $GEMINIDB`
echo "TOTAL	$TOTAL_VARS	$commonTOTAL_VARS	$rareTOTAL_VARS" >> $DBSTATFILE
UTR_VARS=`$GEMINI query -q "SELECT COUNT(*) FROM variants \
        WHERE $UTR AND $FILTER" $GEMINIDB`
rareUTR_VARS=`$GEMINI query -q "SELECT COUNT(*) FROM variants \
        WHERE $UTR AND $FILTER AND $GNOMAD_GENOME_RARE "  $GEMINIDB`
commonUTR_VARS=`$GEMINI query -q "SELECT COUNT(*) FROM variants \
        WHERE $UTR AND $FILTER AND ($GNOMAD_GENOME_COMMON)"  $GEMINIDB`
echo "UTR	$UTR_VARS	$commonUTR_VARS	$rareUTR_VARS" >> $DBSTATFILE
EXONIC_VARS=`$GEMINI query -q "SELECT COUNT(*) FROM variants \
	WHERE $EXONIC AND $FILTER" $GEMINIDB`
rareEXONIC_VARS=`$GEMINI query -q "SELECT COUNT(*) FROM variants \
	WHERE $EXONIC AND $FILTER AND $GNOMAD_GENOME_RARE"  $GEMINIDB`
commonEXONIC_VARS=`$GEMINI query -q "SELECT COUNT(*) FROM variants \
	WHERE $EXONIC AND $FILTER AND $GNOMAD_GENOME_COMMON"  $GEMINIDB`
echo "EXONIC	$EXONIC_VARS	$commonEXONIC_VARS	$rareEXONIC_VARS" >> $DBSTATFILE
CODING_VARS=`$GEMINI query -q "SELECT COUNT(*) FROM variants \
	WHERE $CODING AND $FILTER" $GEMINIDB`
rareCODING_VARS=`$GEMINI query -q "SELECT COUNT(*) FROM variants \
	WHERE $CODING AND $FILTER AND $GNOMAD_GENOME_RARE"  $GEMINIDB`
commonCODING_VARS=`$GEMINI query -q "SELECT COUNT(*) FROM variants \
	WHERE $CODING AND $FILTER AND ($GNOMAD_GENOME_COMMON)"  $GEMINIDB`
echo "CODING	$CODING_VARS	$commonCODING_VARS	$rareCODING_VARS" >> $DBSTATFILE
SPLICING_VARS=`$GEMINI query -q "SELECT COUNT(*) FROM variants \
	WHERE $SPLICING AND $FILTER" $GEMINIDB`
rareSPLICING_VARS=`$GEMINI query -q "SELECT COUNT(*) FROM variants \
	WHERE $SPLICING AND $FILTER AND $GNOMAD_GENOME_RARE"  $GEMINIDB`
commonSPLICING_VARS=`$GEMINI query -q "SELECT COUNT(*) FROM variants \
	WHERE $SPLICING AND $FILTER AND ($GNOMAD_GENOME_COMMON)"  $GEMINIDB`
echo "SPLICING	$SPLICING_VARS	$commonSPLICING_VARS	$rareSPLICING_VARS" >> $DBSTATFILE
LOF_VARS=`$GEMINI query -q "SELECT COUNT(*) FROM variants \
	WHERE $LOF AND $FILTER" $GEMINIDB`
rareLOF_VARS=`$GEMINI query -q "SELECT COUNT(*) FROM variants \
	WHERE $LOF AND $FILTER AND $GNOMAD_GENOME_RARE"  $GEMINIDB`
commonLOF_VARS=`$GEMINI query -q "SELECT COUNT(*) FROM variants \
	WHERE $LOF AND $FILTER AND ($GNOMAD_GENOME_COMMON)"  $GEMINIDB`
echo "LOF	$LOF_VARS	$commonLOF_VARS	$rareLOF_VARS" >> $DBSTATFILE
CADD_VARS=`$GEMINI query -q "SELECT COUNT(*) FROM variants \
        WHERE $CADD AND $FILTER" $GEMINIDB`
rareCADD_VARS=`$GEMINI query -q "SELECT COUNT(*) FROM variants \
        WHERE $CADD AND $FILTER AND $GNOMAD_GENOME_RARE"  $GEMINIDB`
commonCADD_VARS=`$GEMINI query -q "SELECT COUNT(*) FROM variants \
        WHERE $CADD AND $FILTER AND ($GNOMAD_GENOME_COMMON)"  $GEMINIDB`
echo "CADD	$CADD_VARS	$commonCADD_VARS	$rareCADD_VARS" >> $DBSTATFILE
GNOMAD_GENOME_RARE='((gnomad_genome_af_global <= 0.01) or (gnomad_genome_af_global is NULL)) '
$GEMINI query -q "SELECT $COLUMNS FROM variants WHERE ( (clinvar_pathogenic == 'Pathogenic') OR (clinvar_pathogenic == 'Likely Pathogenic') ) AND (clinvar_disease_name is not NULL) AND $FILTER AND $GNOMAD_GENOME_RARE" \
	--gt-filter "(gt_types).(phenotype==2).(!=HOM_REF).(any)" \
	--header \
	$GEMINIDB > $CLINVAR_HITS
python  $TableAnnotator -i $CLINVAR_HITS -o ${CLINVAR_HITS}_annotated.txt
$GEMINI query -q "SELECT $COLUMNS FROM variants WHERE ($IMPACT_HIGH OR $IMPACT_MED) AND $FILTER"\
	--gt-filter "(gt_types).(phenotype==2).(==HET).(any)" \
	--header \
	$GEMINIDB > $GENERAL_DAMAGING_HET
python $TableAnnotator -i $GENERAL_DAMAGING_HET -o ${GENERAL_DAMAGING_HET}_annotated.txt
$GEMINI query -q "SELECT $COLUMNS FROM variants WHERE ($IMPACT_HIGH OR $IMPACT_MED) AND $FILTER" \
	--gt-filter "(gt_types).(phenotype==2).(==HOM_ALT).(any)" \
	--header \
	$GEMINIDB > $GENERAL_DAMAGING_HOMO
python $TableAnnotator -i $GENERAL_DAMAGING_HOMO -o ${GENERAL_DAMAGING_HOMO}_annotated.txt
$GEMINI query -q "SELECT $COLUMNS FROM variants WHERE $SPLICEAI AND $FILTER" \
        --gt-filter "(gt_types).(phenotype==2).(!=HOM_REF).(any)" \
        --header \
        $GEMINIDB > $SPLICING_HITS
python $TableAnnotator -i $SPLICING_HITS -o ${SPLICING_HITS}_annotated.txt
$GEMINI query -q "SELECT $COLUMNS FROM variants WHERE $NONCODING AND $FILTER" \
        --gt-filter "(gt_types).(phenotype==2).(!=HOM_REF).(any)" \
        --header \
        $GEMINIDB > $NONCODING_HITS
python $TableAnnotator -i $NONCODING_HITS -o ${NONCODING_HITS}_annotated.txt
CVL=$WORKING_DIR${FAMILY_ID}_CVL.tsv
DATE=`date`
echo "FAMILY:	$FAMILY_ID" > $CVL
echo "DATE CVL PRODUCED:	$DATE" >> $CVL
echo "------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------" >> $CVL
echo "" >> $CVL
cat $DBSTATFILE >> $CVL
echo "------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------" >> $CVL
echo "" >> $CVL
echo "De Novo (HIGH/MED)" >> $CVL
cat ${DENOVO_OUT}_annotated.txt >> $CVL
echo "De Novo (LOW)" >> $CVL
cat ${DENOVO_OUT_LOW}_annotated.txt >> $CVL
echo "---------------------------------------------------------------------------------------------------------------------" >> $CVL
echo "" >> $CVL
echo "Recessive" >> $CVL
cat ${RECESSIVE_OUT}_annotated.txt >> $CVL
echo "------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------" >> $CVL
echo "" >> $CVL
echo "Compound Het" >> $CVL
cat ${COMPOUND_HET_OUT}_annotated.txt >> $CVL
echo "------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------" >> $CVL
echo "" >> $CVL
echo "Autosomal Dominant" >> $CVL
cat ${AUTODOM_OUT}_annotated.txt >> $CVL
echo "------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------" >> $CVL
echo "" >> $CVL
echo "X De Novo" >> $CVL
cat ${X_DENOVO_OUT}_annotated.txt >> $CVL
echo "------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------" >> $CVL
echo "" >> $CVL
echo "X Recessive" >> $CVL
cat ${X_RECESSIVE_OUT}_annotated.txt >> $CVL
echo "------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------" >> $CVL
echo "" >> $CVL
echo "X Autosomal Dominant" >> $CVL
cat ${X_DOMINANT_OUT}_annotated.txt >> $CVL
echo "------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------" >> $CVL
echo "" >> $CVL
echo "Mendelian Errors" >> $CVL
cat ${MENDEL_ERRORS_OUT}_annotated.txt >> $CVL
echo "------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------" >> $CVL
echo "" >> $CVL
cp $MTOOLBOX_RSCRIPT ./
Rscript ./Mtoolbox.R
echo "MToolbox Output" >> $CVL
cat MToolBox_annotated.txt >> $CVL
echo "------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------" >> $CVL
echo "General Damaging Homozygous" >> $CVL
cat ${GENERAL_DAMAGING_HOMO}_annotated.txt >> $CVL
echo "------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------" >> $CVL
echo "" >> $CVL
echo "General Damaging Heterozygous" >> $CVL
cat ${GENERAL_DAMAGING_HET}_annotated.txt >> $CVL
echo "------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------" >> $CVL
echo "" >> $CVL
echo "Clinvar Hits" >> $CVL
cat ${CLINVAR_HITS}_annotated.txt >> $CVL
echo "------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------" >> $CVL
echo "" >> $CVL
echo "Splicing Candidates">> $CVL
cat ${SPLICING_HITS}_annotated.txt >> $CVL
echo "------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------" >> $CVL
echo "" >> $CVL
CVL_macro=$WORKING_DIR${FAMILY_ID}_CVL_macro.tsv
DATE=`date`
echo "Nothing	FAMILY:	$FAMILY_ID" > $CVL_macro
echo "Nothing	DATE CVL PRODUCED:	$DATE" >> $CVL_macro
echo "Nothing	------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------" >> $CVL_macro
echo "Nothing" >> $CVL_macro
perl -ne 'print "Nothing\t$_" unless /^gene\s+Gene_Name\s+OMIM_Phenotypes/' $DBSTATFILE >> $CVL_macro
echo "Nothing	==========================================================================================================================================================================================================================================" >> $CVL_macro
echo "Nothing" >> $CVL_macro
echo "De novo	De novo" >> $CVL_macro
perl -ne 'print "De novo\t$_" unless /^gene\s+Gene_Name\s+OMIM_Phenotypes/' ${DENOVO_OUT}_annotated.txt >> $CVL_macro
echo "De novo" >> $CVL_macro
echo "De novo	------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------" >> $CVL_macro
echo "De novo" >> $CVL_macro
echo "Nothing" >> $CVL_macro
echo "Nothing	==========================================================================================================================================================================================================================================" >> $CVL_macro
echo "Nothing" >> $CVL_macro
echo "De novo	De novo low" >> $CVL_macro
perl -ne 'print "De novo\t$_" unless /^gene\s+Gene_Name\s+OMIM_Phenotypes/' ${DENOVO_LOW_OUT}_annotated.txt >> $CVL_macro
echo "De novo" >> $CVL_macro
echo "De novo	------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------" >> $CVL_macro
echo "De novo" >> $CVL_macro
echo "Nothing" >> $CVL_macro
echo "Nothing	==========================================================================================================================================================================================================================================" >> $CVL_macro
echo "Nothing" >> $CVL_macro
echo "Autosomal Rec (Homozygous)	Autosomal Rec (Homozygous)" >> $CVL_macro
perl -ne 'print "Autosomal Rec (Homozygous)\t$_" unless /^gene\s+Gene_Name\s+OMIM_Phenotypes/' ${RECESSIVE_OUT}_annotated.txt >> $CVL_macro
echo "Autosomal Rec (Homozygous)" >> $CVL_macro
echo "Autosomal Rec (Homozygous)	------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------" >> $CVL_macro
echo "Autosomal Rec (Homozygous)" >> $CVL_macro
echo "Nothing" >> $CVL_macro
echo "Nothing	==========================================================================================================================================================================================================================================" >> $CVL_macro
echo "Nothing" >> $CVL_macro
echo "Recessive (Compound Het)	Compound Het" >> $CVL_macro
perl -ne 'print "Recessive (Compound Het)\t$_" unless /^gene\s+Gene_Name\s+OMIM_Phenotypes/' ${COMPOUND_HET_OUT}_annotated.txt >> $CVL_macro
echo "Recessive (Compound Het)" >> $CVL_macro
echo "Recessive (Compound Het)	------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------" >> $CVL_macro
echo "Recessive (Compound Het)" >> $CVL_macro
echo "Nothing" >> $CVL_macro
echo "Nothing	==========================================================================================================================================================================================================================================" >> $CVL_macro
echo "Nothing" >> $CVL_macro
echo "Autosomal Dom (Heterozygous)	Autosomal Dominant" >> $CVL_macro
perl -ne 'print "Autosomal Dom (Heterozygous)\t$_" unless /^gene\s+Gene_Name\s+OMIM_Phenotypes/' ${AUTODOM_OUT}_annotated.txt >> $CVL_macro
echo "Autosomal Dom (Heterozygous)" >> $CVL_macro
echo "Autosomal Dom (Heterozygous)	------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------" >> $CVL_macro
echo "Autosomal Dom (Heterozygous)" >> $CVL_macro
echo "Nothing" >> $CVL_macro
echo "Nothing	==========================================================================================================================================================================================================================================" >> $CVL_macro
echo "Nothing" >> $CVL_macro
echo "X De Novo	X De Novo" >> $CVL_macro
perl -ne 'print "X De Novo\t$_" unless /^gene\s+Gene_Name\s+OMIM_Phenotypes/' ${X_DENOVO_OUT}_annotated.txt >> $CVL_macro
echo "X De Novo" >> $CVL_macro
echo "X De Novo	------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------" >> $CVL_macro
echo "X De Novo" >> $CVL_macro
echo "X De Novo	X De Novo" >> $CVL_macro
perl -ne 'print "X De Novo\t$_" unless /^gene\s+Gene_Name\s+OMIM_Phenotypes/' ${X_DENOVO_OUT_LOOSE}_annotated.txt >> $CVL_macro
echo "Nothing" >> $CVL_macro
echo "Nothing	==========================================================================================================================================================================================================================================" >> $CVL_macro
echo "Nothing" >> $CVL_macro
echo "X Recessive	X Recessive" >> $CVL_macro
perl -ne 'print "X Recessive\t$_" unless /^gene\s+Gene_Name\s+OMIM_Phenotypes/' ${X_RECESSIVE_OUT}_annotated.txt >> $CVL_macro
echo "X Recessive" >> $CVL_macro
echo "X Recessive	------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------" >> $CVL_macro
echo "X Recessive" >> $CVL_macro
echo "Nothing" >> $CVL_macro
echo "Nothing	==========================================================================================================================================================================================================================================" >> $CVL_macro
echo "Nothing" >> $CVL_macro
echo "X Dominant	X Autosomal Dominant" >> $CVL_macro
perl -ne 'print "X Dominant\t$_" unless /^gene\s+Gene_Name\s+OMIM_Phenotypes/' ${X_DOMINANT_OUT}_annotated.txt >> $CVL_macro
echo "X Dominant" >> $CVL_macro
echo "X Dominant	------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------" >> $CVL_macro
echo "X Dominant" >> $CVL_macro
echo "Nothing" >> $CVL_macro
echo "Nothing	==========================================================================================================================================================================================================================================" >> $CVL_macro
echo "Nothing" >> $CVL_macro
echo "Mendelian errors	Mendelian Errors" >> $CVL_macro
perl -ne 'print "Mendelian errors\t$_" unless /^gene\s+Gene_Name\s+OMIM_Phenotypes/' ${MENDEL_ERRORS_OUT}_annotated.txt >> $CVL_macro
echo "Nothing" >> $CVL_macro
echo "Nothing	==========================================================================================================================================================================================================================================" >> $CVL_macro
echo "Nothing" >> $CVL_macro
cp $MTOOLBOX_RSCRIPT ./
Rscript ./Mtoolbox.R
echo "Mitochondrial	MToolbox Output" >> $CVL_macro
perl -ne 'print "Mitochondrial\t$_" unless /^.Variant.Allele\s+Samples\s+HF/' MToolBox_annotated.txt >> $CVL_macro
echo "Nothing" >> $CVL_macro
echo "Nothing	==========================================================================================================================================================================================================================================" >> $CVL_macro
echo "Nothing" >> $CVL_macro
echo "Damaging (No Inheritance)	General Damaging Homozygous" >> $CVL_macro
perl -ne 'print "Damaging (No Inheritance)\t$_" unless /^gene\s+Gene_Name\s+OMIM_Phenotypes/' ${GENERAL_DAMAGING_HOMO}_annotated.txt >> $CVL_macro
echo "Damaging (No Inheritance)" >> $CVL_macro
echo "Damaging (No Inheritance)	------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------" >> $CVL_macro
echo "Damaging (No Inheritance)" >> $CVL_macro
echo "Damaging (No Inheritance)	General Damaging Heterozygous" >> $CVL_macro
perl -ne 'print "Damaging (No Inheritance)\t$_" unless /^gene\s+Gene_Name\s+OMIM_Phenotypes/' ${GENERAL_DAMAGING_HET}_annotated.txt >> $CVL_macro
echo "Nothing" >> $CVL_macro
echo "Nothing	==========================================================================================================================================================================================================================================" >> $CVL_macro
echo "Nothing" >> $CVL_macro
echo "ClinVar Hits (No inheritance)	Clinvar Hits" >> $CVL_macro
perl -ne 'print "ClinVar Hits (No inheritance)\t$_" unless /^gene\s+Gene_Name\s+OMIM_Phenotypes/' ${CLINVAR_HITS}_annotated.txt >> $CVL_macro
echo "Nothing" >> $CVL_macro
echo "Nothing	==========================================================================================================================================================================================================================================" >> $CVL_macro
echo "Nothing" >> $CVL_macro
echo "Splicing Candidates	Splicing Candidates">> $CVL_macro
perl -ne 'print "Splicing Candidates\t$_" unless /^gene\s+Gene_Name\s+OMIM_Phenotypes/' ${SPLICING_HITS}_annotated.txt >> $CVL_macro
echo "Nothing" >> $CVL_macro
echo "Nothing	==========================================================================================================================================================================================================================================" >> $CVL_macro
echo "Nothing" >> $CVL_macro
rm *_annotated.txt
rm $AUTODOM_OUT
rm $DENOVO_OUT
rm $DENOVO_LOW_OUT
rm $RECESSIVE_OUT
rm $COMPOUND_HET_OUT
rm $X_RECESSIVE_OUT
rm $X_DOMINANT_OUT
rm $X_DENOVO_OUT
rm $AUTODOM_OUT_LOOSE
rm $DENOVO_OUT_LOOSE
rm $RECESSIVE_OUT_LOOSE
rm $COMPOUND_HET_OUT_LOOSE
rm $X_RECESSIVE_OUT_LOOSE
rm $X_DOMINANT_OUT_LOOSE
rm $X_DENOVO_OUT_LOOSE
rm $GENERAL_DAMAGING_HET
rm $GENERAL_DAMAGING_HOMO
rm $CLINVAR_HITS
rm $SPLICING_HITS
rm $NONCODING_HITS
rm $MENDEL_ERRORS_OUT

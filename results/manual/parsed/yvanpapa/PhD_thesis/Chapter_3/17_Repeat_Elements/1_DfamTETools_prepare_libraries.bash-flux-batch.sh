#!/bin/bash
#FLUX: --job-name=repeat_libraries
#FLUX: -c=24
#FLUX: --queue=bigmem
#FLUX: -t=864000
#FLUX: --urgency=16

dir=/nfs/scratch/papayv/Tarakihi/TARdn/09_Repeat/new_pipeline/V2P/3_Dfam_TETools_3d_run/
singdir=/nfs/scratch/papayv/Tarakihi/TARdn/09_Repeat/new_pipeline/V2P/
sing=$singdir/tetools_latest.sif
module load TandemRepeatsFinder/4.09
module load perl/CPAN/5.16
module load singularity/3.5.2
genome1=TARdn_assembly_V2_p_srn
genome1_fasta=/nfs/scratch/papayv/Tarakihi/TARdn/TARdn_assembly_V2_P/TARdn_assembly_V2_p_srn.fasta
LIBDIR=/nfs/scratch/papayv/Tarakihi/TARdn/09_Repeat/new_pipeline/V2P/Libraries/libs/Libraries/
echo "download dfam-tetools.sh to download DfamTETools container if needed"
singularity pull docker://dfam/tetools:latest
time echo "Create a Database for RepeatModeler"
singularity exec $sing BuildDatabase -name $genome1 $genome1_fasta
time echo "Run Repeat Modeler for de novo repeat detection. Also use the LTR detection pipeline"
singularity exec $sing RepeatModeler -database $genome1 -LTRStruct -pa 22
time echo "change de novo repeat library to something clearer"
cp TARdn_assembly_V2_p_srn-families.fa TARdn_V2P_denovo_repeat_lib.fa
time echo "check at what taxonomic level my species is covered. Can use name or taxonomic ID"
singularity exec $sing famdb.py -i $LIBDIR/RepeatMaskerLib.h5 lineage --ancestors --descendants Actinopterygii --format totals
singularity exec $sing famdb.py -i $LIBDIR/RepeatMaskerLib.h5 lineage --ancestors --descendants Actinopterygii
touch $dir/actinopterygii_db_ad_repeatlib.fa
singularity exec $sing famdb.py -i $LIBDIR/RepeatMaskerLib.h5 families \
--format fasta_name --ancestors --descendants Actinopterygii --include-class-in-name --add-reverse-complement \
 > $dir/actinopterygii_db_ad_repeatlib.fa
time echo "compile de novo repeat libraries and Repeatmasker db in one"
cat $dir/TARdn_V2P_denovo_repeat_lib.fa $dir/actinopterygii_db_ad_repeatlib.fa > $dir/TARdn_V2P_repeat_lib_actinodb_ad_and_denovo.fa

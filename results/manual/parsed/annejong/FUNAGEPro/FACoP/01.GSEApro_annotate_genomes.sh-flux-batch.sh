#!/bin/bash
#FLUX: --job-name=conspicuous-chair-0232
#FLUX: --priority=16

cpu=2
SCRATCHDIR=/tmp
DATABASEDIR=/data/gsea_pro/databases
PROGRAMDIR=/data/gsea_pro/FACoP
DIAMONDDIR=/data/software/diamond/diamond-master
DIAMOND_DB=$DATABASEDIR/uniprot_sprot.dmnd
genome=$1 # the full path genome filename is the protein fasta name without the .faa extension. The .faa will be added by DIAMOND
function classify_genome {		
	check_seq
	# Add classification data to the all proteins
	if [ ! -f $genome.diamond.tab ]; then
		my_diamond_faa  # DIAMOND is used to find the best hit in Uniprot ==> results is $genome.diamond.tab
	fi	
	python3 $PROGRAMDIR/diamond_format_results.py -diamond $genome.diamond.tab -db $DATABASEDIR/uniprot_sprot.description -out $genome.description
	cp $genome.description $genome.FACoP.table
	cp $genome.description $genome.g2d.FACoP.table
	python3 $PROGRAMDIR/classify_genome.py -diamond $genome.diamond.tab -db $DATABASEDIR/uniprot_sprot.GO      -class $DATABASEDIR/go-basic.obo.description    -out $genome.g2d.FACoP.GO
	python3 $PROGRAMDIR/classify_genome.py -diamond $genome.diamond.tab -db $DATABASEDIR/uniprot_sprot.IPR     -class $DATABASEDIR/IPR.description             -out $genome.g2d.FACoP.IPR
	python3 $PROGRAMDIR/classify_genome.py -diamond $genome.diamond.tab -db $DATABASEDIR/uniprot_sprot.eggNOG  -class $DATABASEDIR/eggNOG_COG.description      -out $genome.g2d.FACoP.eggNOG_COG
	python3 $PROGRAMDIR/classify_genome.py -diamond $genome.diamond.tab -db $DATABASEDIR/uniprot_sprot.COG     -class $DATABASEDIR/COG.description             -out $genome.g2d.FACoP.COG
	python3 $PROGRAMDIR/classify_genome.py -diamond $genome.diamond.tab -db $DATABASEDIR/uniprot_sprot.PFAM    -class $DATABASEDIR/PFAM.description            -out $genome.g2d.FACoP.Pfam
	python3 $PROGRAMDIR/classify_genome.py -diamond $genome.diamond.tab -db $DATABASEDIR/uniprot_sprot.Keyword -class $DATABASEDIR/KEYWORD.description         -out $genome.g2d.FACoP.KEYWORDS
	python3 $PROGRAMDIR/classify_genome.py -diamond $genome.diamond.tab -db $DATABASEDIR/uniprot_sprot.KEGGPATHWAY -class $DATABASEDIR/KEGGPATHWAY.description -out $genome.g2d.FACoP.KEGG
	$PROGRAMDIR/Annotation2Json.pl -s "$(dirname $genome)" -query "$(basename $genome)".FACoP.table -out 00.GenomeAnnotation.json
}
function check_seq {
	# to prevent errors in DIAMOND etc.. check the input
	python3 $PROGRAMDIR/CheckFastA.py -i $genome.faa 
}
function my_diamond_faa {
	# diamond is used to function map the proteins of the genome on the basis of the Uniprot_sprot database
	$DIAMONDDIR/diamond blastp --unal 1 --threads $cpu --tmpdir $SCRATCHDIR --query $genome.faa --db $DIAMOND_DB --out $genome.diamond.tab --evalue 0.1 --max-target-seqs 1
}
function my_class_assignment {
	declare -a CLASSES=("GO" "KO" "IPR" "PFAM" "Debian" "Keyword" "eggNOG" )
	database=/data/pg-molgen/databases/uniprot_sprot/uniprot_sprot
	for class in ${CLASSES[@]}; do
		echo $class
		/data/pg-molgen/software/molgentools_mirror/metagenomics/CLASS_assignment.pl -db $database.$class -diamond $genome.diamond.diamond.tab -o $genome.$class
	done
}	
function my_class_count {
	declare -a CLASSES=("GO" "KO" "IPR" "PFAM" "Debian" "Keyword" "eggNOG" )
	database=/data/pg-molgen/databases/uniprot_sprot/uniprot_sprot
	for class in ${CLASSES[@]}; do
		echo $class
		/data/pg-molgen/software/molgentools_mirror/metagenomics/CLASS_count.pl -db $database.$class -diamond $diamondresultdir/$name.diamond.tab -o $classdir/$name.$class.count
	done
}
function my_mkdir {
	if [ ! -d $1 ]; then
		mkdir $1 ;
	fi
}
classify_genome

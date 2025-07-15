#!/bin/bash
#FLUX: --job-name=TEblastp
#FLUX: --queue=nocona
#FLUX: --priority=16

module --ignore-cache load gcc/10.1.0 r/4.0.2
. ~/conda/etc/profile.d/conda.sh
conda activate curate
NAME=iRic2
MINORF=1000
PFAM=/lustre/work/daray/software/pfam_db
TARGET=${NAME}_extended_rep.fa.classified
AIDPATH=/lustre/work/daray/software/TE-Aid
ASSEMBLIESDIR=/lustre/scratch/daray/ixodes/assemblies
WORKDIR=/lustre/scratch/daray/ixodes/$NAME
EXTENSIONSDIR=$WORKDIR/extensions
AIDOUT=$WORKDIR/te-aid
mkdir -p $AIDOUT
mkdir -p $WORKDIR/prioritize
cd $WORKDIR/prioritize
<<COMMENT
COMMENT
echo -e "Extract headers and subdivide names for later concatenation.\n"
echo -e "Some hits are missing /Family. Correct for that."
grep ">" ../repeatclassifier/$TARGET | sed "s/#/-#/g" | sed "s/>//g" | sed "s|#Unknown|#Unknown/Unknown|g" | sed "s|#Satellite|#Satellite/Satellite|g" | sed "s|#LTR |#LTR/Unknown|g" | sed "s|#DNA |#DNA/Unknown|g" | sed "s|#tRNA |#tRNA/Nothing|g" | sed "s|#LINE |#LINE/Unknown|g" | sed "s|#|\\t|g" | sed "s|/|\\t|g" >${NAME}_name_class_family.txt
grep ">" ../repeatclassifier/$TARGET | sed "s/#/-#/g" | sed "s/>//g" | cut -d"#" -f1 >${NAME}_name.txt
grep ">" ../repeatclassifier/$TARGET | sed "s/#/-#/g" | sed "s/>//g" >${NAME}_original_headers.txt
echo -e "Complete.\n"
echo -e "Concatenate table.txt."
paste ${NAME}_original_headers.txt ${NAME}_name_class_family.txt > table.txt
echo -e "Complete.\n"
echo -e "Get open reading frames for later blastp search."
if [ ! -f ${NAME}_extended_rep_getorf.fa ]
	then 
	getorf ../repeatclassifier/${NAME}_extended_rep.fa.classified ${NAME}_extended_rep_getorf.fa -minsize $MINORF
fi
echo -e "Complete.\n"
echo -e "Test for presence of TE peptide library. Download if necessary and run blastp."
if [ -e db/RepeatPeps.lib.phr ] 
  then 
    blastp -query ${NAME}_extended_rep_getorf.fa  -db db/RepeatPeps.lib -outfmt 6 -evalue 1e-15 | sort -k1,1 -k12,12nr | sort -u -k1,1 | sed 's/#/--/g' > ${NAME}_extended_rep_blastp.out
  else
    mkdir -p $WORKDIR/prioritize/db
    cd db 
    wget https://raw.githubusercontent.com/rmhubley/RepeatMasker/master/Libraries/RepeatPeps.lib
    makeblastdb -in RepeatPeps.lib -out RepeatPeps.lib -dbtype prot &>/dev/null
    cd ..
	blastp -query ${NAME}_extended_rep_getorf.fa  -db db/RepeatPeps.lib -outfmt 6 -evalue 1e-15 | sort -k1,1 -k12,12nr | sort -u -k1,1 | sed 's/#/--/g' > ${NAME}_extended_rep_blastp.out
fi
echo -e "Complete.\n"
echo -e "Pull results of blastp, sort by longest hit, convert to columns, and add to growing list for concatenation."
cat ${NAME}_name.txt | while read I
  do grep "$I" ${NAME}_extended_rep_blastp.out | cut -d$'\t' -f2,4 | sed "s|--|#|g" | cut -d"#" -f2,3 >rows.tmp
  COUNT=$(wc -l rows.tmp | cut -d" " -f1)
  if (( COUNT == 0 ))
    then 
      echo $COUNT "NOHIT" >>${NAME}_typelist.txt
    else 
      sort -n -k2 -r -o rows.tmp rows.tmp
      uniq rows.tmp >tetype.tmp
      TETYPES=$(tr '\n' ' ' < tetype.tmp)
      echo $COUNT $TETYPES >>${NAME}_typelist.txt
     rm tetype.tmp
  fi
done 
sed -i 's/  */\t/g' ${NAME}_typelist.txt
rm tetype.tmp
rm rows.tmp
echo -e "Complete.\n"
echo -e "Get TE consensus sequence lengths for later concatenation."
seqkit fx2tab --length --name --header-line ../repeatclassifier/${NAME}_extended_rep.fa.classified | cut -d$'\t' -f2 >${NAME}_sizes.txt
sed -i '1d' ${NAME}_sizes.txt
echo -e "Complete.\n"
echo -e "Build the final table with results."
paste ${NAME}_original_headers.txt ${NAME}_name_class_family.txt ${NAME}_sizes.txt ${NAME}_typelist.txt > ${NAME}_table.txt
echo -e "Complete.\n"
echo -e "Create sorting directories."
TELIST="LINE SINE LTR RC DNA NOHIT"
for TENAME in $TELIST; do 
	mkdir $AIDOUT/$TENAME
done
echo -e "Complete.\n"
echo -e "Copy created files to sorting directories."
TELIST="LINE SINE LTR RC DNA NOHIT"
for TENAME in $TELIST; do 
	echo $TENAME
	awk '{print $2 "\t" $7}' ${NAME}_table.txt | sed "s|/|\t|g" | grep "$TENAME" > ${NAME}_${TENAME}s.txt
	cut -d' ' -f1 ${NAME}_${TENAME}s.txt >${NAME}_${TENAME}s.tmp
	cat ${NAME}_${TENAME}s.tmp | while read I; do
		CONSNAME=$(echo $I | awk '{print $1}')
		CONSNAMESHORT=${CONSNAME::-1}
		cp $EXTENSIONSDIR/extensionwork/${CONSNAMESHORT}/${CONSNAMESHORT}_rep.fa $AIDOUT/$TENAME/${CONSNAME}_rep.fa
		cp $EXTENSIONSDIR/extensionwork/${CONSNAMESHORT}/${CONSNAMESHORT}_MSA_extended.fa $AIDOUT/$TENAME/${CONSNAME}_MSA_extended.fa
		cp $EXTENSIONSDIR/extensionwork/${CONSNAMESHORT}/${CONSNAMESHORT}.png $AIDOUT/$TENAME/${CONSNAME}.png
	done
done
rm ${NAME}_*.tmp
echo -e "Complete.\n"
echo -e "Change the header to shortened version."
TELIST="LINE SINE LTR RC DNA"	
for TENAME in $TELIST; do 
	cat ${NAME}_${TENAME}s.txt | while read I; do
		CONSNAME=$(echo $I | awk '{print $1}')
		CONSNAMEMOD=${CONSNAME/-rnd-/.}
		CONSNAMEMOD=${CONSNAMEMOD/_family-/.}
		CLASS=$(echo $I | awk '{print $2}') 
		FAMILY=$(echo $I | awk '{print $3}') 
		HEADER=${CONSNAMEMOD}#${CLASS}/${FAMILY}
		sed "s|${CONSNAME::-1}|$HEADER|g" $AIDOUT/$TENAME/${CONSNAME}_rep.fa > $AIDOUT/$TENAME/${CONSNAME}_rep_mod.fa
	done
done
cat ${NAME}_NOHITs.txt | while read I; do
	CONSNAME=$(echo $I | awk '{print $1}')
	CONSNAMEMOD=${CONSNAME/-rnd-/.}
	CONSNAMEMOD=${CONSNAMEMOD/_family-/.}
	HEADER=$CONSNAMEMOD"#Unknown/Unknown"
	sed "s|$CONSNAME::-1}|$HEADER|g" $AIDOUT/NOHIT/${CONSNAME}_rep.fa >$AIDOUT/NOHIT/${CONSNAME}_rep_mod.fa
done
echo -e "Complete.\n"
echo -e "Check orientation of ORF-containing hits and reverse complement if necessary."
TELIST="LINE SINE LTR RC DNA"	
mkdir -p $AIDOUT/check_orientation/LINE
mkdir -p $AIDOUT/check_orientation/SINE
mkdir -p $AIDOUT/check_orientation/LTR
mkdir -p $AIDOUT/check_orientation/RC
mkdir -p $AIDOUT/check_orientation/DNA
if [ -f no_blastx_hit.txt ] 
	then rm no_blastx_hit.txt
fi
for TENAME in $TELIST; do 
	cat ${NAME}_${TENAME}s.txt | while read I; do
		CONSNAME=$(echo $I | awk '{print $1}')
		FILE=$AIDOUT/$TENAME/${CONSNAME}_rep.fa
		echo "Analyzing " $FILE
		blastx -query $FILE -db db/RepeatPeps.lib -outfmt 6 -evalue 1e-15 | sort -k1,1 -k12,12nr | sort -u -k1,1 | sed 's/#/--/g' > $AIDOUT/$TENAME/${CONSNAME}_extended_rep_blastx.out
		if [[ -s $AIDOUT/$TENAME/${CONSNAME}_extended_rep_blastx.out ]]; then
			START=$(head -1 $AIDOUT/$TENAME/${CONSNAME}_extended_rep_blastx.out | awk '{print $7}')
			echo "start = "$START
			END=$(head -1 $AIDOUT/$TENAME/${CONSNAME}_extended_rep_blastx.out | awk '{print $8}')
			echo "end = "$END
			if (( START > END )); then 
				echo "start > end. Hit is reversed."
				echo -e "Reverse complementing "$FILE"\n"
				#Reverse complement rep file
				seqkit seq -r -p -t DNA $FILE >$AIDOUT/$TENAME/${CONSNAME}-rep_rc.tmp
				mv $AIDOUT/$TENAME/${CONSNAME}-rep_rc.tmp $FILE
				#Reverse complement MSA file
				seqkit seq -r -p -t DNA $AIDOUT/$TENAME/${CONSNAME}_MSA_extended.fa >$AIDOUT/$TENAME/${CONSNAME}_MSA_extended.tmp
				mv $AIDOUT/$TENAME/${CONSNAME}_MSA_extended.tmp $AIDOUT/$TENAME/${CONSNAME}_MSA_extended.fa
				#Reverse complement rep_mod file
				seqkit seq -r -p -t DNA $AIDOUT/$TENAME/${CONSNAME}_rep_mod.fa  >$AIDOUT/$TENAME/${CONSNAME}_rep_mod.tmp
				mv $AIDOUT/$TENAME/${CONSNAME}_rep_mod.tmp $AIDOUT/$TENAME/${CONSNAME}_rep_mod.fa
			else
				echo "start < end. Hit is in correct orientation."
				echo -e "Not reverse complementing "$FILE"\n"
			fi
		else
			echo -e "No blastx hits for "$FILE"\n"
			echo $FILE >> ${NAME}_no_blastx_hit_${TENAME}.txt
			mv $FILE $AIDOUT/$TENAME/${CONSNAME}_rep_mod.fa $AIDOUT/$TENAME/${CONSNAME}_MSA_extended.fa $AIDOUT/$TENAME/${CONSNAME}.png $AIDOUT/$TENAME/${CONSNAME}_extended_rep_blastx.out $AIDOUT/check_orientation/$TENAME
		fi
	done
done
echo -e "Complete.\n"
echo -e "Run TE-Aid on files in each category."
TELIST="LINE SINE LTR RC DNA NOHIT"	
if [ -f ${NAME}_final_table.txt ] 
	then rm ${NAME}_final_table.txt
fi
echo -e "RM_ID \t Short_ID \t Class \t Family \t Modified_ID \t Consensus_length \t 90percent_consensus \t N_ORFS \t ORF1_type \t ORF1_length \t ORF2_type \t ORF2_length \t ORF3_type \t ORF3_length" >${NAME}_final_table.txt
for TENAME in $TELIST; do 
	cat ${NAME}_${TENAME}s.txt | while read I; do
		CONSNAME=$(echo $I | awk '{print $1}')
		FILE=$AIDOUT/$TENAME/${CONSNAME}_rep.fa
		echo "TE-Aid processing "$FILE
		#Generate reverse complement files for identifying TIRs
		echo "Generate reverse complement files for identifying TIRs."
		seqkit seq $FILE -r -p -t DNA >$AIDOUT/$TENAME/${CONSNAME}_rep_rc.fa
		cat $FILE $AIDOUT/$TENAME/${CONSNAME}_rep_rc.fa >$AIDOUT/$TENAME/${CONSNAME}_rep_RC.fa
		rm $AIDOUT/$TENAME/${CONSNAME}_rep_rc.fa
		#Run TE-Aid
		echo "Run TE-Aid"
		$AIDPATH/TE-Aid -q $FILE -g $ASSEMBLIESDIR/${NAME}.fa -T -o $AIDOUT/$TENAME
		mv ${FILE}.c2g.pdf $AIDOUT/$TENAME/${CONSNAME}.c2g.pdf
		#Gather information for final table
		MOD_ID=$(grep ">" $AIDOUT/$TENAME/${CONSNAME}_rep_mod.fa | sed "s|>||g") 
		tail -n +2 $AIDOUT/$TENAME/${CONSNAME}_rep.fa.genome.blastn.out | awk '{print $1 "\t" $7 "\t" $8}' | awk 'BEGIN { OFS = "\t" } { $4 = $3 - $2 + 1 } 1' > $AIDOUT/$TENAME/${CONSNAME}_rep.fa.genome.blastn.tmp
		CONSSIZE=$(seqkit fx2tab --length --name $FILE | awk '{print $2}')
		MINCONSSIZE=$(awk "BEGIN { print $CONSSIZE * 0.9 }")
		BLASTTMP=$AIDOUT/$TENAME/${CONSNAME}_rep.fa.genome.blastn.tmp
		FULLCOUNT=$(awk -v MINCONSSIZE="$MINCONSSIZE" -v BLASTOUT="$BLASTTMP" '$4 > MINCONSSIZE' $BLASTTMP | wc -l)
		ROW=$(grep $CONSNAME ${NAME}_table.txt | awk -v FULLCOUNT="$FULLCOUNT" -v MOD_ID="$MOD_ID" '{print $1 "\t" $2 "\t" $3 "\t" $4 "\t" MOD_ID "\t" $5 "\t" FULLCOUNT "\t" $6 "\t" $7 "\t" $8 "\t" $9 "\t" $10 "\t" $11 "\t" $12}')
		#Generate final table
		echo $ROW >> ${NAME}_final_table.txt
	done	
done	
TELIST="LINE SINE LTR RC DNA"	
for TENAME in $TELIST; do 
	cat ${NAME}_no_blastx_hit_${TENAME}.txt | while read I; do
		CONSNAME=$(echo $I | awk '{print $1}')
		FILE=$AIDOUT/check_orientation/$TENAME${CONSNAME}_rep.fa
		echo "TE-Aid processing "$FILE
		#Generate reverse complement files for identifying TIRs
		seqkit seq $FILE -r -p -t DNA >$AIDOUT/check_orientation/$TENAME/${CONSNAME}_rep_rc.fa
		cat $FILE $AIDOUT/check_orientation/$TENAME/${CONSNAME}_rep_rc.fa >$AIDOUT/check_orientation/$TENAME/${CONSNAME}_rep_RC.fa
		rm $AIDOUT/check_orientation/$TENAME/${CONSNAME}_rep_rc.fa
		#Run TE-Aid
		$AIDPATH/TE-Aid -q $FILE -g $ASSEMBLIESDIR/${NAME}.fa -T -o $AIDOUT/check_orientation/$TENAME/
		mv ${FILE}.c2g.pdf $AIDOUT/check_orientation/$TENAME/${CONSNAME}.c2g.pdf
		#Gather information for final table
		MOD_ID=$(grep ">" $AIDOUT/$TENAME/${CONSNAME}_rep_mod.fa | sed "s|>||g") 
		tail -n +2 $AIDOUT/$TENAME/${CONSNAME}_rep.fa.genome.blastn.out | awk '{print $1 "\t" $7 "\t" $8}' | awk 'BEGIN { OFS = "\t" } { $4 = $3 - $2 + 1 } 1' > $AIDOUT/$TENAME/${CONSNAME}_rep.fa.genome.blastn.tmp
		CONSSIZE=$(seqkit fx2tab --length --name $FILE | awk '{print $2}')
		MINCONSSIZE=$(awk "BEGIN { print $CONSSIZE * 0.9 }")
		BLASTTMP=$AIDOUT/$TENAME/${CONSNAME}_rep.fa.genome.blastn.tmp
		FULLCOUNT=$(awk -v MINCONSSIZE="$MINCONSSIZE" -v BLASTOUT="$BLASTTMP" '$4 > MINCONSSIZE' $BLASTTMP | wc -l)
		ROW=$(grep $CONSNAME ${NAME}_table.txt | awk -v FULLCOUNT="$FULLCOUNT" -v MOD_ID="$MOD_ID" '{print $1 "\t" $2 "\t" $3 "\t" $4 "\t" MOD_ID "\t" $5 "\t" FULLCOUNT "\t" $6 "\t" $7 "\t" $8 "\t" $9 "\t" $10 "\t" $11 "\t" $12}')
		#Generate final table
	done	
done	
echo -e "Complete.\n"
echo "Prepare files for download and manual inspection as necessary"
TELIST="LINE SINE LTR RC DNA NOHIT"	
for TENAME in $TELIST; do 
	mkdir -p $WORKDIR/fordownload/$TENAME
	cp $AIDOUT/$TENAME/*.pdf $AIDOUT/$TENAME/*.fa $WORKDIR/fordownload/$TENAME
	tar -zcf $WORKDIR/fordownload/fordownload_${TENAME}.tgz $WORKDIR/fordownload/$TENAME
done
TELIST="LINE SINE LTR RC DNA"	
for TENAME in $TELIST; do 
	mkdir -p $WORKDIR/fordownload/$TENAME
	cp $AIDOUT/check_orientation/$TENAME/*.pdf $AIDOUT/check_orientation/$TENAME/*.fa $WORKDIR/fordownload/check_orientation/$TENAME
	tar -zcf $WORKDIR/fordownload/fordownload_check_orientation/_${TENAME}.tgz $WORKDIR/fordownload/check_orientation/$TENAME
done

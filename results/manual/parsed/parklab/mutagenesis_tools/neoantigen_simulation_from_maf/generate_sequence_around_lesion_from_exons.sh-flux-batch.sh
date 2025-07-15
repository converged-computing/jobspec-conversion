#!/bin/bash
#FLUX: --job-name=spicy-muffin-6067
#FLUX: --urgency=16

module load \
bedtools/2.27.1 \
samtools/1.9 \
python/3.6.0
intervals=$1
config=$2
jobtask=$3
gene=$4
genegtf=$(grep -v "#" $config | grep -s "genegtf" | cut -f2)
exongtf=$(grep -v "#" $config | grep -s "exongtf" | cut -f2)
genomefa=$(grep -v "#" $config | grep -s "fasta" | cut -f2)
genomefile=$(grep -v "#" $config | grep -s "genomefile" | cut -f2)
coordsys=$(grep -v "#" $config | grep -s "coord_sys" | cut -f2)
neoaIdistlimit=$(grep -v "#" $config | grep -s "mhcI_neoa_dist_limit" | cut -f2)
echo $intervals
echo -e "#" > $jobtask.$gene.fa
echo -e "#" > $jobtask.$gene.bed
echo -e "#" > $jobtask.$gene.lesion.bed
echo -e "#" > $jobtask.$gene.lesion_control_seq.bed.temp
while read line; do
    echo $line
    # first, figure out the rule
    seqtype=$(echo $line | tr ' ' '\t' | cut -f6)
    echo $seqtype
    nameseq=$(echo $line | tr ' ' '\t' | cut -f4)
    # lesiontype
    lesiontype=$(echo $line | tr ' ' '\t' | cut -f5)
    # match the rule
    ruletype=$(grep -v "#" $config | grep -s $seqtype | cut -f2)
    # current line
    echo $line | tr ' ' '\t' > .temp.line.bed
    # now, determine the next course of action. Only act of the sequence is to keep, swap, or reverse
    # if remove, then we do not return a sequence
    if [[ $ruletype == "keep" ]]; then
        # echo $line | tr ' ' '\t' > .temp.line.bed
        bedtools getfasta -name -s -fi $genomefa -bed .temp.line.bed >> $jobtask.$gene.fa
        bedtools getfasta -name -bedOut -s -fi $genomefa -bed .temp.line.bed >> $jobtask.$gene.bed
    elif [[ $ruletype = "copy" ]]; then
        # will fix this later for duplications
        # echo -e $line > .temp.line.bed
        bedtools getfasta -name -s -fi $genomefa -bed .temp.line.bed >> $jobtask.$gene.fa
        bedtools getfasta -name -s -fi $genomefa -bed .temp.line.bed >> $jobtask.$gene.fa
        # store the line
        bedtools getfasta -name -bedOut -s -fi $genomefa -bed .temp.line.bed > .temp.lesion.bed
        cat .temp.lesion.bed >> $jobtask.$gene.bed
        cat .temp.lesion.bed >> $jobtask.$gene.bed # no more than 2 copies
        # bedtools getfasta -name -bedOut -s -fi $genomefa -bed .temp.line.bed >> $jobtask.$gene.bed
        # bedtools getfasta -name -s -fi $genomefa -bed .temp.line.bed >> $jobtask.$gene.fa # make no more than two copies
    elif [[ $ruletype == "swap" ]]; then
            # get reference allele
        ref=$(echo $line | tr ' ' '\t' | cut -f7)
        # get the allele that we need to substitute
        alt=$(echo $line | tr ' ' '\t' | cut -f8-9)
        for i in $alt; do
            if [[ $i != $ref ]]; then
                # print out the allele
                seqname=$(cut -f1-3 .temp.line.bed | sed "s/\t/_/g")
                # seqname=">allele_"$nameseq
                echo -e ">$seqname(MUT_$nameseq)" >> $jobtask.$gene.fa
                echo -e $i >> $jobtask.$gene.fa
                # echo -e ">$seqname(MUT_$nameseq)" >> .lesion.$gene.fa
                # echo -e $i >> $jobtask.$gene.fa >> .lesion.$gene.fa
                echo -e "$line $i" | tr ' ' '\t' >> $jobtask.$gene.lesion.bed # store the lesion
                cat $jobtask.$gene.lesion.bed >> $jobtask.$gene.bed
            fi
        # generate the control sequence so that we can identify "WT" peptides in the frames and filter them out
        # if ref is "-", then write a space
        if [[ $ref == "-" ]]; then
            echo -e "$line Z" | tr ' ' '\t' >> $jobtask.$gene.lesion_control_seq.bed.temp
        else
            echo -e "$line $ref" | tr ' ' '\t' >> $jobtask.$gene.lesion_control_seq.bed.temp
        fi
        # 
        done
    elif [[ $ruletype == "remove" ]]; then
        # in the case of remove
        seqname=$(cut -f1-3 .temp.line.bed | sed "s/\t/_/g")
        echo -e ">$seqname(MUT_$nameseq)" >> $jobtask.$gene.fa
        echo -e "" >> $jobtask.$gene.fa
        echo -e "$line Z" | tr ' ' '\t' > $jobtask.$gene.lesion.bed # store the lesion
        cat $jobtask.$gene.lesion.bed >> $jobtask.$gene.bed
        # generate the control sequence for identifying WT peptides
        ref=$(echo $line | tr ' ' '\t' | cut -f7)
        echo -e "$line $ref" | tr ' ' '\t' >> $jobtask.$gene.lesion_control_seq.bed.temp
        # 
    # dont worry about reversal for now
    fi    
done < $intervals
awk 'BEGIN {FS=OFS="\t"} {print $1,$2,$3,$4,$5,"WT",$7,$8,$9,$10}' $jobtask.$gene.lesion_control_seq.bed.temp > $jobtask.$gene.lesion_control_seq.bed
while read lesion; do
    echo -e $lesion | tr ' ' '\t' > .temp.lesion_line.bed
    # lesion name
    lesioname=$(cut -f1-3 .temp.lesion_line.bed | sed "s/\t/_/g")
    bedtools closest -D "ref" -fu -a .temp.lesion_line.bed -b <(grep -P "\tWT\t" $intervals) | cut -f11- > .temp.closest_upstream_exons.bed
    bedtools closest -D "ref" -fd -a .temp.lesion_line.bed -b <(grep -P "\tWT\t" $intervals) | cut -f11- > .temp.closest_downstream_exons.bed
    # obtain the sequences representing where mhcI neoa's may arise
    # do 8-12 mers
    cat <(awk -v k=$neoaIdistlimit -v lname=$lesioname 'BEGIN {FS=OFS="\t"} {print $1,$3-k,$3,lname,$5,$6,$7,$8,$9}' .temp.closest_upstream_exons.bed ) \
                   <(awk -v k=$neoaIdistlimit -v lname=$lesioname 'BEGIN {FS=OFS="\t"} {print $1,$2,$2+k,lname,$5,$6,$7,$8,$9}' .temp.closest_downstream_exons.bed) | \
                   sort -k1,1 -k2,2 | uniq | \
                   bedtools getfasta -name -bedOut -s -fi $genomefa -bed - > .mhcIneoa.template.temp #$jobtask.$gene.mhcIneoa.template.bed
    # cat the lesion bed and the template
    cat .temp.lesion_line.bed .mhcIneoa.template.temp | sort -k1,1 -k2,2n > $jobtask.$gene.seq_around_lesion.$lesioname.bed
    # convert the full sequence into a fasta
    echo -e ">$lesioname" > $jobtask.$gene.seq_around_lesion.$lesioname.fa
    outseq=""
    for i in $(cut -f10 $jobtask.$gene.seq_around_lesion.$lesioname.bed); do
        outseq=$outseq""$i
    done
    echo -e $outseq >> $jobtask.$gene.seq_around_lesion.$lesioname.fa
    # after printing out the sequence remove the "Z" placeholder if a deletion exists in the mutant
    sed -i "s/Z//g" $jobtask.$gene.seq_around_lesion.$lesioname.fa # > $jobtask.$gene.seq_around_lesion.$lesioname.fa
    # cut -f10 $jobtask.$gene.seq_around_lesion.$lesioname.bed | tr '\n' '' >> $jobtask.$gene.seq_around_lesion.$lesioname.fa
    #paste <(cut -f4 $jobtask.$gene.seq_around_lesion.$lesioname.bed | sed "s/^/>/g") \
    #<(cut -f10 $jobtask.$gene.seq_around_lesion.$lesioname.bed) | \
    #sed "s/\t/\n/g" > $jobtask.$gene.seq_around_lesion.$lesioname.fa
    # generate peptides
    python /n/data1/hms/dbmi/park/vinay/pipelines/mutagenesis/tile_peptides_from_sequence_dev.py $jobtask.$gene.seq_around_lesion.$lesioname.fa
    cat $jobtask.$gene.seq_around_lesion.$lesioname.fa_peptides_*aa.txt > $jobtask.$gene.seq_around_lesion.$lesioname.proposed_neoantigens.txt
    mv $jobtask.$gene.seq_around_lesion.$lesioname.fa_peptides_*aa.txt peptide_sequences/
done < <(grep -v "#" $jobtask.$gene.lesion.bed)
while read lesion; do
    echo -e $lesion | tr ' ' '\t' > .temp.lesion_line.bed
    # lesion name
    lesioname=$(cut -f1-3 .temp.lesion_line.bed | sed "s/\t/_/g")
    bedtools closest -D "ref" -fu -a .temp.lesion_line.bed -b <(grep -P "\tWT\t" $intervals) | cut -f11- > .temp.closest_upstream_exons.bed
    bedtools closest -D "ref" -fd -a .temp.lesion_line.bed -b <(grep -P "\tWT\t" $intervals) | cut -f11- > .temp.closest_downstream_exons.bed
    # obtain the sequences representing where mhcI neoa's may arise
    # do 8-12 mers
    cat <(awk -v k=$neoaIdistlimit -v lname=$lesioname 'BEGIN {FS=OFS="\t"} {print $1,$3-k,$3,lname,$5,$6,$7,$8,$9}' .temp.closest_upstream_exons.bed ) \
                   <(awk -v k=$neoaIdistlimit -v lname=$lesioname 'BEGIN {FS=OFS="\t"} {print $1,$2,$2+k,lname,$5,$6,$7,$8,$9}' .temp.closest_downstream_exons.bed) | \
                   sort -k1,1 -k2,2 | uniq | \
                   bedtools getfasta -name -bedOut -s -fi $genomefa -bed - > .mhcIneoa.template.temp #$jobtask.$gene.mhcIneoa.template.bed
    # cat the lesion bed and the template
    cat .temp.lesion_line.bed .mhcIneoa.template.temp | sort -k1,1 -k2,2n > $jobtask.$gene.seq_around_lesion_control.$lesioname.bed
    # convert the full sequence into a fasta
    echo -e ">$lesioname" > $jobtask.$gene.seq_around_lesion_control.$lesioname.fa
    # convert the full sequence into a fasta
    outseq=""
    for i in $(cut -f10 $jobtask.$gene.seq_around_lesion_control.$lesioname.bed); do
        outseq=$outseq""$i
    done
    echo -e $outseq >> $jobtask.$gene.seq_around_lesion_control.$lesioname.fa
    # after printing out the sequence remove the "Z" placeholder if an insertion exists in the mutant
    sed -i "s/Z//g" $jobtask.$gene.seq_around_lesion_control.$lesioname.fa
    # generate peptides
    python /n/data1/hms/dbmi/park/vinay/pipelines/mutagenesis/tile_peptides_from_sequence_dev.py $jobtask.$gene.seq_around_lesion_control.$lesioname.fa
    cat $jobtask.$gene.seq_around_lesion_control.$lesioname.fa_peptides_*aa.txt > $jobtask.$gene.seq_around_lesion_control.$lesioname.proposed_neoantigens.txt
    mv $jobtask.$gene.seq_around_lesion_control.$lesioname.fa_peptides_*aa.txt peptide_sequences/
done < <(grep -v "#" $jobtask.$gene.lesion_control_seq.bed)
diff $jobtask.$gene.seq_around_lesion_control.$lesioname.proposed_neoantigens.txt $jobtask.$gene.seq_around_lesion.$lesioname.proposed_neoantigens.txt > .temp.diff_neoas
grep -s ">" .temp.diff_neoas | sed "s/> //g" > $jobtask.$gene.seq_around_lesion.$lesioname.unique_neoas_mutant.txt
grep -s "<" .temp.diff_neoas | sed "s/< //g" > $jobtask.$gene.seq_around_lesion.$lesioname.lost_neoas_mutant.txt
echo -e "$jobtask\t$gene\t$PWD/$jobtask.$gene.fa\t$jobtask.$gene.bed\t$jobtask.$gene.lesion.bed\t$jobtask.$gene.seq_around_lesion.$lesioname.bed\t$jobtask.$gene.seq_around_lesion.$lesioname.fa\t$jobtask.$gene.seq_around_lesion.$lesioname.unique_neoas_mutant.txt\t$jobtask.$gene.seq_around_lesion.$lesioname.lost_neoas_mutant.txt" >> jobtask_gene_fasta.txt
a=$(grep -v -c "\*" $jobtask.$gene.seq_around_lesion.$lesioname.unique_neoas_mutant.txt)
echo -e "$a mutant-specific neoantigens predicted for $gene"
a=$(grep -c "^" $jobtask.$gene.seq_around_lesion.$lesioname.lost_neoas_mutant.txt)
echo -e "$a WT-specific peptides lost in mutant and predicted for $gene"

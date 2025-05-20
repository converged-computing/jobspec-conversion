#!/bin/bash
# Flux batch script

# Request resources
# Nodes: 1
# Cores: Assuming 1 core per node, adjust if needed
# Memory: 12GB
# Walltime: 12 hours

# Flux resource requests
# -n <number of tasks>
# -N <number of nodes>
# --mem <memory per node>
# --time <walltime in HH:MM format>

flux run -n 1 -N 1 --mem 12G --time 12:00 bash -c "

# Load modules
module load bedtools/2.27.1
module load samtools/1.9
module load python/3.6.0

# Get input arguments
intervals=$1
config=$2
jobtask=$3
gene=$4

# Get relevant entries from config
genegtf=$(grep -v '#' "$config" | grep -s 'genegtf' | cut -f2)
exongtf=$(grep -v '#' "$config" | grep -s 'exongtf' | cut -f2)
genomefa=$(grep -v '#' "$config" | grep -s 'fasta' | cut -f2)
genomefile=$(grep -v '#' "$config" | grep -s 'genomefile' | cut -f2)
coordsys=$(grep -v '#' "$config" | grep -s 'coord_sys' | cut -f2)
neoaIdistlimit=$(grep -v '#' "$config" | grep -s 'mhcI_neoa_dist_limit' | cut -f2)

echo "$intervals"

# Clear files
echo -e '#' > "$jobtask.$gene.fa"
echo -e '#' > "$jobtask.$gene.bed"
echo -e '#' > "$jobtask.$gene.lesion.bed"
echo -e '#' > "$jobtask.$gene.lesion_control_seq.bed.temp"

# Main script logic (identical to the original, but with quoting adjustments)
while read line; do
    echo "$line"
    seqtype=$(echo "$line" | tr ' ' '\t' | cut -f6)
    echo "$seqtype"
    nameseq=$(echo "$line" | tr ' ' '\t' | cut -f4)
    lesiontype=$(echo "$line" | tr ' ' '\t' | cut -f5)
    ruletype=$(grep -v '#' "$config" | grep -s "$seqtype" | cut -f2)

    if [[ "$ruletype" == "keep" ]]; then
        bedtools getfasta -name -s -fi "$genomefa" -bed .temp.line.bed >> "$jobtask.$gene.fa"
        bedtools getfasta -name -bedOut -s -fi "$genomefa" -bed .temp.line.bed >> "$jobtask.$gene.bed"
    elif [[ "$ruletype" == "copy" ]]; then
        bedtools getfasta -name -s -fi "$genomefa" -bed .temp.line.bed >> "$jobtask.$gene.fa"
        bedtools getfasta -name -s -fi "$genomefa" -bed .temp.line.bed >> "$jobtask.$gene.fa"
        bedtools getfasta -name -bedOut -s -fi "$genomefa" -bed .temp.line.bed > .temp.lesion.bed
        cat .temp.lesion.bed >> "$jobtask.$gene.bed"
        cat .temp.lesion.bed >> "$jobtask.$gene.bed"
    elif [[ "$ruletype" == "swap" ]]; then
        ref=$(echo "$line" | tr ' ' '\t' | cut -f7)
        alt=$(echo "$line" | tr ' ' '\t' | cut -f8-9)
        for i in $alt; do
            if [[ "$i" != "$ref" ]]; then
                seqname=$(cut -f1-3 .temp.line.bed | sed "s/\t/_/g")
                echo -e ">$seqname(MUT_$nameseq)" >> "$jobtask.$gene.fa"
                echo -e "$i" >> "$jobtask.$gene.fa"
                echo -e "$line $i" | tr ' ' '\t' >> "$jobtask.$gene.lesion.bed"
                cat "$jobtask.$gene.lesion.bed" >> "$jobtask.$gene.bed"
                if [[ "$ref" == "-" ]]; then
                    echo -e "$line Z" | tr ' ' '\t' >> "$jobtask.$gene.lesion_control_seq.bed.temp"
                else
                    echo -e "$line $ref" | tr ' ' '\t' >> "$jobtask.$gene.lesion_control_seq.bed.temp"
                fi
            fi
        done
    elif [[ "$ruletype" == "remove" ]]; then
        seqname=$(cut -f1-3 .temp.line.bed | sed "s/\t/_/g")
        echo -e ">$seqname(MUT_$nameseq)" >> "$jobtask.$gene.fa"
        echo -e "" >> "$jobtask.$gene.fa"
        echo -e "$line Z" | tr ' ' '\t' > "$jobtask.$gene.lesion.bed"
        cat "$jobtask.$gene.lesion.bed" >> "$jobtask.$gene.bed"
        ref=$(echo "$line" | tr ' ' '\t' | cut -f7)
        echo -e "$line $ref" | tr ' ' '\t' >> "$jobtask.$gene.lesion_control_seq.bed.temp"
    fi
done < "$intervals"

awk 'BEGIN {FS=OFS="\t"} {print $1,$2,$3,$4,$5,"WT",$7,$8,$9,$10}' "$jobtask.$gene.lesion_control_seq.bed.temp" > "$jobtask.$gene.lesion_control_seq.bed"

while read lesion; do
    echo -e "$lesion" | tr ' ' '\t' > .temp.lesion_line.bed
    lesioname=$(cut -f1-3 .temp.lesion_line.bed | sed "s/\t/_/g")
    bedtools closest -D "ref" -fu -a .temp.lesion_line.bed -b <(grep -P "\tWT\t" "$intervals") | cut -f11- > .temp.closest_upstream_exons.bed
    bedtools closest -D "ref" -fd -a .temp.lesion_line.bed -b <(grep -P "\tWT\t" "$intervals") | cut -f11- > .temp.closest_downstream_exons.bed

    cat <(awk -v k="$neoaIdistlimit" -v lname="$lesioname" 'BEGIN {FS=OFS="\t"} {print $1,$3-k,$3,lname,$5,$6,$7,$8,$9}' .temp.closest_upstream_exons.bed ) \
                   <(awk -v k="$neoaIdistlimit" -v lname="$lesioname" 'BEGIN {FS=OFS="\t"} {print $1,$2,$2+k,lname,$5,$6,$7,$8,$9}' .temp.closest_downstream_exons.bed) | \
                   sort -k1,1 -k2,2 | uniq | \
                   bedtools getfasta -name -bedOut -s -fi "$genomefa" -bed - > .mhcIneoa.template.temp

    cat .temp.lesion_line.bed .mhcIneoa.template.temp | sort -k1,1 -k2,2n > "$jobtask.$gene.seq_around_lesion.$lesioname.bed"

    echo -e ">$lesioname" > "$jobtask.$gene.seq_around_lesion.$lesioname.fa"
    outseq=""
    for i in $(cut -f10 "$jobtask.$gene.seq_around_lesion.$lesioname.bed"); do
        outseq=$outseq"$i"
    done
    echo -e "$outseq" >> "$jobtask.$gene.seq_around_lesion.$lesioname.fa"

    sed -i "s/Z//g" "$jobtask.$gene.seq_around_lesion.$lesioname.fa"

    python /n/data1/hms/dbmi/park/vinay/pipelines/mutagenesis/tile_peptides_from_sequence_dev.py "$jobtask.$gene.seq_around_lesion.$lesioname.fa"
    cat "$jobtask.$gene.seq_around_lesion.$lesioname.fa_peptides_*aa.txt" > "$jobtask.$gene.seq_around_lesion.$lesioname.proposed_neoantigens.txt"
    mv "$jobtask.$gene.seq_around_lesion.$lesioname.fa_peptides_*aa.txt" peptide_sequences/

done < <(grep -v "#" "$jobtask.$gene.lesion.bed")

while read lesion; do
    echo -e "$lesion" | tr ' ' '\t' > .temp.lesion_line.bed
    lesioname=$(cut -f1-3 .temp.lesion_line.bed | sed "s/\t/_/g")
    bedtools closest -D "ref" -fu -a .temp.lesion_line.bed -b <(grep -P "\tWT\t" "$intervals") | cut -f11- > .temp.closest_upstream_exons.bed
    bedtools closest -D "ref" -fd -a .temp.lesion_line.bed -b <(grep -P "\tWT\t" "$intervals") | cut -f11- > .temp.closest_downstream_exons.bed

    cat <(awk -v k="$neoaIdistlimit" -v lname="$lesioname" 'BEGIN {FS=OFS="\t"} {print $1,$3-k,$3,lname,$5,$6,$7,$8,$9}' .temp.closest_upstream_exons.bed ) \
                   <(awk -v k="$neoaIdistlimit" -v lname="$lesioname" 'BEGIN {FS=OFS="\t"} {print $1,$2,$2+k,lname,$5,$6,$7,$8,$9}' .temp.closest_downstream_exons.bed) | \
                   sort -k1,1 -k2,2 | uniq | \
                   bedtools getfasta -name -bedOut -s -fi "$genomefa" -bed - > .mhcIneoa.template.temp

    cat .temp.lesion_line.bed .mhcIneoa.template.temp | sort -k1,1 -k2,2n > "$jobtask.$gene.seq_around_lesion_control.$lesioname.bed"

    echo -e ">$lesioname" > "$jobtask.$gene.seq_around_lesion_control.$lesioname.fa"
    outseq=""
    for i in $(cut -f10 "$jobtask.$gene.seq_around_lesion_control.$lesioname.bed"); do
        outseq=$outseq"$i"
    done
    echo -e "$outseq" >> "$jobtask.$gene.seq_around_lesion_control.$lesioname.fa"

    sed -i "s/Z//g" "$jobtask.$gene.seq_around_lesion_control.$lesioname.fa"

    python /n/data1/hms/dbmi/park/vinay/pipelines/mutagenesis/tile_peptides_from_sequence_dev.py "$jobtask.$gene.seq_around_lesion_control.$lesioname.fa"
    cat "$jobtask.$gene.seq_around_lesion_control.$lesioname.fa_peptides_*aa.txt" > "$jobtask.$gene.seq_around_lesion_control.$lesioname.proposed_neoantigens.txt"
    mv "$jobtask.$gene.seq_around_lesion_control.$lesioname.fa_peptides_*aa.txt" peptide_sequences/

done < <(grep -v "#" "$jobtask.$gene.lesion_control_seq.bed")

diff "$jobtask.$gene.seq_around_lesion_control.$lesioname.proposed_neoantigens.txt" "$jobtask.$gene.seq_around_lesion.$lesioname.proposed_neoantigens.txt" > .temp.diff_neoas
grep -s ">" .temp.diff_neoas | sed "s/> //g" > "$jobtask.$gene.seq_around_lesion.$lesioname.unique_neoas_mutant.txt"
grep -s "<" .temp.diff_neoas | sed "s/< //g" > "$jobtask.$gene.seq_around_lesion.$lesioname.lost_neoas_mutant.txt"

echo -e "$jobtask\t$gene\t$PWD/$jobtask.$gene.fa\t$jobtask.$gene.bed\t$jobtask.$gene.lesion.bed\t$jobtask.$gene.seq_around_lesion.$lesioname.bed\t$jobtask.$gene.seq_around_lesion.$lesioname.fa\t$jobtask.$gene.seq_around_lesion.$lesioname.unique_neoas_mutant.txt\t$jobtask.$gene.seq_around_lesion.$lesioname.lost_neoas_mutant.txt" >> jobtask_gene_fasta.txt

a=$(grep -v -c "\*" "$jobtask.$gene.seq_around_lesion.$lesioname.unique_neoas_mutant.txt")
echo -e "$a mutant-specific neoantigens predicted for $gene"
a=$(grep -c "^" "$jobtask.$gene.seq_around_lesion.$lesioname.lost_neoas_mutant.txt")
echo -e "$a WT-specific peptides lost in mutant and predicted for $gene"
"
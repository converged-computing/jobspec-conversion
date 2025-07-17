#!/bin/bash
#FLUX: --job-name=creamy-car-6074
#FLUX: --urgency=16

sed -n '/Scaffolds_20 /,/Scaffolds_21/p' scaffolds.fasta > scaffolds_20.fasta
grep -v ">" scaffolds_87.fasta > temp.txt; mv temp.txt scaffolds_87.fasta
samtools faidx <file>.fa <chr id>
cmp --silent scaffolds_20.fasta scaffolds_87.fasta || echo "files are different"
Or 
cmp --silent  scaffolds_20.fasta scaffolds_87.fasta && echo '### SUCCESS: Files Are Identical! ###' || echo '### WARNING: Files Are Different! ###'
head -n -1 scaffolds_20.fasta > temp.txt ; mv temp.txt scaffolds_20.fasta
sed '1,1d' <file>
sed '$d' <file>
samtools faidx <file>
cut -f1-2 <file>.fai
sacct --format='JobID,JobName,Elapsed,MaxVMSize,State'
sacct --format='JobID,JobName,Elapsed,MaxVMSize,State,Start,End'
--starttime YYYY-MM-DD[THH:MM[:SS]]
grep -A10 <pattern> <file>
grep -B10 <pattern> <file>
grep -H <pattern> *.err
grep -Fx "$name" normal_BM_unique.txt
grep -xiE '([^_]*_){3}[^_]*' 
sort -k2,2 -nr lengths_scaffolds.txt | head -n40
python rename_fasta.py <fasta> --ids <chr file> > <out>
conda activate random # Has bbmap sortbyname.sh
sortbyname.sh in=file.fa out=sorted.fa length descending
awk 'BEGIN {FS="\t"}; {print $1 FS "0" FS $2}' fasta.fai > fasta.bed
scontrol hold name=JOBNAME (or comma separated list of job ids)
scontrol release name=JOBNAME
squeue --user=USERNAME --start
squeue -l -j <jobID>
scontrol show jobid <jobID>
/cm/shared/apps/accounting/job_efficiency <JOBID>
seff <jobID>
sinteractive -c <num_cpus> --mem <amount_mem> --time <minutes>
sbatch --dependency=singleton --jobname=<JOBNAME> script.sh
sbatch --job-name="<jobname>" --wrap="<command>"
$(basename $f) | sed "s/\..*//"
$(basename $f)
$(basename $(dirname $some_path))
setfacl -m u:username:rwx myfolder
chmod +rwx <filename>
for f in a2*.RG.bam 
    do
        if [ ! -f $f.bai ]; then
            samtools index -@ 16 $f
        fi
    done
echo $f | awk -F'[_.]' '{print $1}'
grep "Processed" <BWA_LOG> | awk '{print $3}' | awk '{s+=$1} END {print s}'
grep "Processed" <BWA_LOG> | awk '{print $4}' | awk '{s+=$1} END {print s}'
module load bamtools
bamtools stats -in <bam> > <bam.stats>
zgrep -c "^>" <reads.fasta.gz>
conda activate py2.7
N50 -x <fasta>
or
conda activate random
statswrapper.sh <fasta1>,<fasta2> (for several files)
stats.sh in=<fasta>
or 
conda activate quast
quast --threads 16 --eukaryote --split-scaffolds --large <fasta> 
find . -mtime -1 -type d -exec echo {} \;
find . -mtime -1 -type d -exec rm -r {} \;
find . -maxdepth 1 -mtime -1 -type f -name t* -print
find . -maxdepth 1 -mtime -1 -type f -name t* -delete
sed 's/\s.*$//' <file>
sed 's/\..*$//'
sed 's/.*|//'
sed -E 's/((_*[^_]*){2}).*/\1/'
sed 's/_.*//'
sed 's/,[^[:blank:]]*//'
cut -f3 <file> | sort | uniq -c
ls -l | grep -c ^d
conda activate py37  # has jupyter lab installed with conda
jupyter-lab --port 8888 --no-browser
ssh -t <user>@login.anunna.wur.nl -L 8888:localhost:8888
%timeit <other code>
scripts/RMout_to_bed.pl <infile> <prefix>
conda activate genestructure # has genometools package
gt bed_to_gff3 <file> > <output file>
tar -xvf <file>
tar -zvxf file.tar --directory /path/to/directory
ln -s <directory/file to link> <name of link>
zcat <file.vcf.gz> | grep "^[^#]" | cut -f 1 | uniq | sort -n
snakemake --forceall --rulegraph | dot -Tpdf > workflow.pdf
snakemake --forceall --rulegraph | dot -Tpng > workflow.png
snakemake --forceall --dag | dot -Tpng > dag.png
snakemake -n -R `snakemake --list-params-changes`
snakemake -n -R `snakemake --list-code-changes`
snakemake some_target --delete-all-output
snakemake -np --quiet
conda env export > environment.yml
conda remove <package>
conda list -e > requirements.txt
conda install -c conda-forge mamba
mamba install -c conda-forge -c bioconda snakemake
zcat vcf1 | grep -v "#" | grep "1/1:" | wc -l
module load vcftools 
vcf-query -f  '%INFO/SVTYPE\n' <vcf> | sort |uniq -c
for f in .vcf.gz
    do 
        echo $f
        bcftools query -f '[%INFO/SVTYPE\n]' $f | sort | uniq -c 
    done
ls -d */
echo $CONDA_PREFIX
bcftools query -R <chr_pos_file.txt> -f'[%CHROM\t%POS\t%INFO/CSQ\n]' <vcf> | uniq
bcftools view -S <file with one sample name> <vcf> | awk '$1 != "Contig"' | awk '$1 != "X"' | awk '$1 != "Y"' | awk '$1 != "MT"' | bcftools view -i 'AC>0' | perl -ne 'print "$1\n" if /[;\t]SVTYPE=([^;\t]+)/' | sort | uniq -c
bcftools query -l <vcf>
bcftools view --threads 16 -S <samples.txt> <vcf> | \
bcftools view -i 'AC>0' | \
bcftools +fill-tags -Oz > <output.vcf.gz>
list.of.packages <- c("optparse", "data.table")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)
git checkout <file>
awk '/^>/{if(N)exit;++N;} {print;}' <file>
snakefmt Snakefile
snakemake --lint
seqtk seq -l0 {input} > {output}
bedtools getfasta -fi <file.fasta> -bed <file.bed> -fo <output.fa>
awk 'FNR>1 || NR==1' results/*_files.txt
/usr/bin/rsync -av -e "ssh -v -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null" --progress gw2hpct02:/hpc/my_group/my_username/data /tmp/data_from_HPC/
/usr/bin/rsync -av -e "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null" --progress /tmp/data_to_HPC gw2hpct02:/hpc/my_group/my_username/data/ 
rsync --archive \
 --copy-links --progress \
 --log-file=rsync.log \
 --rsh "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null" \
 "<name>":"/path/files/to/copy" \
 "/local/path"
 # rsync - copy files in file from directory
 rsync --archive \
 --copy-links --progress \
 --log-file=rsync.log \
 --rsh "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null" \
 --files-from=files_to_sync.txt \
 "<name>":"/" \ # source
 "/local/path" #destination
git log --pretty="- %s" > CHANGELOG.md
find -name rc -exec grep -vH 0 {} \;
rename <string to replace> <new string> <filename>
tar -ztvf <file.tar.gz>
du -sh .
wc -l `find .  -type f`
for f in *.tsv
    do
        name=$(echo $f | sed 's/.tsv//g')
        awk '!seen[$0]++' $f > $name.nodups.tsv
    done
zgrep  -Hcv -- '#' *.vcf.gz > <output_file>
apptainer exec -B "<path/to/mount>" docker://<containerID> bash <yourscript.sh>
srun --jobid=<JOBID> --pty /usr/bin/bash
find -type f -name "example*" | grep <subdirectory> | xargs -I {} cp {} /path/to/destination
sed -n "3p" <file>
zgrep "##INFO=<ID=CSQ" <file.vcf.gz> | grep -o 'Format:.*$' | sed 's/Format: //' | sed 's/|/,/g' | sed 's/">//'

#!/bin/bash
#FLUX: --job-name=expressive-dog-2515
#FLUX: --urgency=16

export LC_ALL='C'
export splitdir='${splitdir}; export outputdir=${outputdir}; ${juiceDir}/scripts/check.sh'

shopt -s extglob
juicer_version="1.6"
load_bwa="module load bwa/0.7.17"
load_awk=""
load_gpu="module load CUDA/10.2"
load_coreutils="module load coreutils/9.1"  ###TODO: add coreutils back
load_samtools="module load samtools/1.14"
load_java=""
call_gem="" # gem is not working properly - not supported
juiceDir="/usr/local/apps/juicer/juicer-1.6"
motifDir=""
queue="norm"
queue_time="2880"
long_queue="norm"
long_queue_time="7200"
export LC_ALL=C
threads=32
splitsize=60000000
read1str="_R1" 
read2str="_R2" 
groupname="a$(date +%s)"
topDir=$(pwd)
site="none"
genomeID="hg38"
about=""
nofrag=1
justexact=0
echo "Running juicer version ${juicer_version}"
printHelpAndExit() {
	cat <<__EOF__
NAME
	juicer.sh - set up a juicer pipeline run on biowulf
SYNOPSIS
	${0##*/} [-g genomeID] [-d topDir] [-q queue] [-l long queue] [-s site]
		 [-a about] [-S stage] [-p chrom.sizes path]
		 [-y restriction site file] [-z reference genome file]
		 [-C chunk size] [-D Juicer scripts directory]
		 [-Q queue time limit] [-L long queue time limit] [-b ligation] [-t threads]
		 [-A account name] [-m motif dir] [-e] [-h] [-f] [-j] [-M]
OPTIONS
* [topDir] is the top level directory (default "$topDir")
  [topDir]/fastq must contain the fastq files
  [topDir]/splits will be created to contain the temporary split files
  [topDir]/aligned will be created for the final alignment
* [genomeID] mm9, mm10, hg19, or hg38
  (default "$genomeID"); alternatively, it can be defined using the -z with a full path
  to your own genome
* [site] HindIII, MseI, Arima, NcoI, DpnII, NlaIII, BlaIII, MboI, or none (default "$site")
* [about]: description of experiment, enclosed in single quotes
* [chunk size]: number of lines in split read files, must be multiple of 4
  (default ${splitsize})
* [threads]: number of threads when running BWA alignment (default $threads)
* [reference genome file]: enter path for reference sequence file, BWA index
  files must be in same directory. Alternative to using one of the predefine genomes
  with -g
* [chrom.sizes path]: enter path for chrom.sizes file. Only necessary if using
  a custom genome with -z
* [restriction site file]: enter path for restriction site file (locations of
  restriction sites in genome; can be generated with the script
  misc/generate_site_positions.py. Only necessary if not using  -s site
* [ligation junction]: use this string when counting ligation junctions
* [motif dir] <bed_file_dir> File path to a directory which contains two
  folders: "unique" and "inferred". These folders should contain a combination
  of RAD21, SMC3, and CTCF BED files. By intersecting these 1D tracks, the
  strongest peaks will be identified. Unique motifs generally use a more
  stringent combination of BED files than inferred motifs. If only CTCF data is
  available, use the same ChIP-Seq peaks in both the "unique" and "inferred"
  folders.
* [queue] is the queue for running alignments (default "$queue")
* [long queue] is the queue for running longer jobs such as the hic file
  creation (default "$long_queue")
* [queue time limit]: time limit for queue in minutes (default ${queue_time})
* [long queue time limit]: time limit for long queue in minutes (default ${long_queue_time})
* [stage]: must be one of "chimeric", "merge", "dedup", "final", "postproc", or 
  "early". 
	- Use "merge" when alignment has finished but the merged_sort file has not
	  yet been created.
	- Use "dedup" when the files have been merged into merged_sort but
	  merged_nodups has not yet been created.
	- Use "final" when the reads have been deduped into merged_nodups but the
	  final stats and hic files have not yet been created.
	- Use "postproc" when the hic files have been created and only
	  postprocessing feature annotation remains to be completed.
	- Use "early" for an early exit, before the final creation of the hic files
	  Can also use -e flag to exit early
* [Juicer scripts directory]: set the Juicer directory,
  which should have scripts/ references/ and restriction_sites/ underneath it
  (default ${juiceDir}). Should not be required.
* [account name]: user account name on cluster (not required on biowulf)
* -f: include fragment-delimited maps in hic file creation
* -j: just exact duplicates excluded at dedupping step
* -e: Use for an early exit, before the final creation of the hic files
* -c: use GEM3 as aligner [NOT AVAILABLE ON BIOWULF]
* -M: allocate 8g for dedup-split jobs. Use this if you get dupcheck failures.
* -h: print this help and exit
MAJOR CHANGES FROM 1.5.6
* Intra fragment reads are NO LONGER discarded by default. To discard them from
  the hic file, use the flag --skip-intra-frag when calling "pre". This depends
  on using the latest jar for Juicer Tools:
  https://github.com/aidenlab/juicer/wiki/Download . Using old jars will result
  in old behavior (silently discarding intrafragment reads)
* The latest jar has extensive bug fixes
* BWA now aligns in paired end mode. This requires BWA version 0.7.17 or
  higher; short read and short end mode are now deprecated
* Changed chimeric blacklist to handle quadruple reads and eliminate MT
  exception
* Rewrite of generate_site_positions
* The default site is now "none" if no site is sent in
* Fragment maps no longer included in Hi-C file by default. Before you would
  exclude them with the -x flag; now use -f to include.
* Dups has a bug fix for some degenerate cases resulting in large memory usage.
  Also now have flag -j for "just exact matches"; this will only eliminate
  exact match duplicates. Overall this flag is not recommended. However, if you
  find your jobs are often getting stuck at the dedup phase, it can be because
  of low complexity or low mapping quality and this flag will allow the jobs to
  finish much faster. You will still be left with near-duplicates in your
  library - so use caution when interpreting results. In particular note that
  near-duplicates are usually machine errors, not true biological results, and
  thus ought to be removed.
* Multiple ligation junctions now supported in juicer and statistics.pl script
ADAPTATIONS BY BIOWULF STAFF
* The code was modified to compress some of the temporary data (the initial
  alignments are stored as bam files, the split input files are gzipped)
* Changes of hardcoded paths, partitions, and walltime limits
* bug fixes
* gem-mapper is not available onbiowulf
* there are no stock motif annotations. If you have your own (for your cell
  type and genome), please provide them with the -m option. See the help
  for that option and the juicer wiki for more details on how to provide
  this information.
* added flag -M to use 8g for dedup-split jobs
__EOF__
	exit "$1"
}
hold=""
while getopts "d:g:a:hm:q:s:p:l:y:z:S:C:D:Q:L:b:A:t:jfecNM" opt; do
	case $opt in
	g) genomeID=$OPTARG ;;
	h) printHelpAndExit 0;;
	d) topDir=$OPTARG ;;
	l) long_queue=$OPTARG ;;
	q) queue=$OPTARG ;;
    m) motifDir=$OPTARG ;;
	s) site=$OPTARG ;;
	a) about=$OPTARG ;;
	p) genomePath=$OPTARG ;;  
	y) site_file=$OPTARG ;;
	z) refSeq=$OPTARG ;;
	S) stage=$OPTARG ;;
	C) splitsize=$OPTARG; splitme=1 ;;
	D) juiceDir=$OPTARG ;;
	Q) queue_time=$OPTARG ;;
	L) long_queue_time=$OPTARG ;;
	f) nofrag=0 ;;
	b) ligation=$OPTARG ;;
	t) threads=$OPTARG ;;
	A) user=$OPTARG ;;
	j) justexact=1 ;;
	e) earlyexit=1 ;;
	c) echo "ERROR: gem mapper not available on biowulf"
	   exit 1
	   ;;
	M) dedup8g=1 ;;
	N) hold="-H" ;;  # submit jobs in held state
	?) printHelpAndExit 1;;
	esac
done
if [[ ! "$threads" =~ [0-9]+ ]]; then
	echo "'$threads' is not a valid number of threads"
	exit 1
fi
if [[ ! "$queue_time" =~ ^[0-9]+$ ]]; then
	echo "-Q: queue_time needs to be specified in minutes"
	exit 1
fi
if [[ ! "$long_queue_time" =~ ^[0-9]+$ ]]; then
	echo "-L: long_queue_time needs to be specified in minutes"
	exit 1
fi
if [[ "${motifDir:-none}" != "none" ]]; then
    if [[ -d "${motifDir}/unique" && -d "${motifDir}/inferred" ]] ; then
        echo "using motifs in ${motifDir}"
        motifDir="-m ${motifDir}"
    else
        echo "motif directory '${motifDir}' is not set up correctly"
        exit 1
    fi
fi
if [ ! -z "$stage" ]
then
	case $stage in
	chimeric)  chimeric=1 ;;
		merge) merge=1 ;;
		dedup) dedup=1 ;;
		early) earlyexit=1 ;;
		final) final=1 ;;
	postproc)  postproc=1 ;; 
		*)  echo "ERROR: '$stage' is not a known stage" 
			exit 1
			;;
	esac
fi
if [ -z "$refSeq" ]
then 
	case $genomeID in
	mm9)	refSeq="${juiceDir}/references/mm9.fa";;
	mm10)	refSeq="${juiceDir}/references/mm10.fa";;
	hg38)	refSeq="${juiceDir}/references/hg38.fa";;
	hg19)	refSeq="${juiceDir}/references/hg19.fa";;
	*)	echo "ERROR: '$genomeID' is not a known genome"
		exit 1
		;;
	esac
else
	## Reference sequence passed in, so genomePath must be set for the .hic 
	## file to be properly created
	if [[ -z "$genomePath" ]] && [[ -z $earlyexit ]]
	then
		echo "***! You must define a chrom.sizes file or a standard genome ID via the"
		echo "     \"-p\" flag that delineates the lengths of the chromosomes in the"
		echo "	genome at $refSeq; you may use \"-p hg19\" or other standard genomes";
		exit 1;
	fi
fi
if [ ! -e "$refSeq" ]; then
	echo "***! Reference sequence $refSeq does not exist";
	exit 1;
fi
if [[ ! -e "${refSeq}.bwt" ]] && [[ -z $gemmapper ]]
then
	echo "***! Reference sequence $refSeq does not appear to have been indexed."
	echo "	Please run bwa index on this file before running juicer.";
	exit 1;
elif [[ -n $gemmapper ]] && [[ ! -e "${refSeq%.*}.gem" ]]
then
	echo "***! Reference sequence $refSeq does not appear to have been indexed. Please run gem index on this file before running juicer.";
	exit 1;
fi
if [ -z "$ligation" ]; then
	case $site in
		HindIII) ligation="AAGCTAGCTT" ;;
		MseI)	ligation="TTATAA" ;;
		DpnII)   ligation="GATCGATC" ;;
		MboI)	ligation="GATCGATC" ;;
	    Arima) ligation="'(GAATAATC|GAATACTC|GAATAGTC|GAATATTC|GAATGATC|GACTAATC|GACTACTC|GACTAGTC|GACTATTC|GACTGATC|GAGTAATC|GAGTACTC|GAGTAGTC|GAGTATTC|GAGTGATC|GATCAATC|GATCACTC|GATCAGTC|GATCATTC|GATCGATC|GATTAATC|GATTACTC|GATTAGTC|GATTATTC|GATTGATC)'" ;;
		NcoI)	ligation="CCATGCATGG" ;;
		NlaIII)  ligation="CATGCATG" ;;
		none)	ligation="XXXX";;
		*)  
			ligation="XXXX"
			echo "$site not listed as recognized enzyme."
			echo "Ligation junction is undefined"
			;;
	esac
fi
if [[ -n $gemmapper ]] 
then
	if [[ "$site" == "none" ]]
	then
	re=""
	else
	re=$(echo $site | tr "+" "\n" | awk '{str=str" --restriction-enzyme "$1}END{print str}')
	fi
fi
if [[ "$site" == "none" ]] 
then
	nofrag=1;
fi
if [ -z "$site_file" ]
then
	site_file="${juiceDir}/restriction_sites/${genomeID}_${site}.txt"
fi
if [[ ! -e "$site_file" ]] && [[ "$site" != "none" ]] &&  [[ ! "$site_file" =~ "none" ]]
then
	echo "***! $site_file does not exist. It must be created before running this script."
	exit 1
elif [[ "$site" != "none" ]] && [[ ! "$site_file" =~ "none" ]]
then
	echo  "Using $site_file as site file"
fi
threadstring="-t $threads"
bwa_mem=$(($threads * 5000))
if [ $bwa_mem -gt 40000 ]
then
	alloc_mem=40000
fi
splitdir=${topDir}"/splits"
donesplitdir=$topDir"/done_splits"
fastqdir=${topDir}"/fastq/*_R*.fastq*"
outputdir=${topDir}"/aligned"
tmpdir=${topDir}"/HIC_tmp"
debugdir=${topDir}"/debug"
if [ ! -d "$topDir/fastq" ]; then
	echo "Directory \"$topDir/fastq\" does not exist."
	echo "Create \"$topDir/fastq\" and put fastq files to be aligned there."
	echo "Type \"juicer.sh -h\" for help"
	exit 1
else 
	if stat -t ${fastqdir} >/dev/null 2>&1
	then
		echo "(-: Looking for fastq files...fastq files exist:"
		ls -lh ${fastqdir} | awk '{printf("	%5s %s\n", $5, $9)}'
		else
		if [ ! -d "$splitdir" ]; then 
			echo "***! Failed to find any files matching ${fastqdir}"
			echo "***! Type \"juicer.sh -h \" for help"
			exit 1		
		fi
	fi
fi
if [[ -d "$outputdir" && -z "$final" && -z "$dedup" && -z "$postproc" ]] 
then
	echo "***! Move or remove directory \"$outputdir\" before proceeding."
	echo "***! Type \"juicer.sh -h \" for help"
	exit 1			
else
	if [[ -z "$final" && -z "$dedup" && -z "$postproc" ]]; then
		mkdir "$outputdir" || { echo "***! Unable to create ${outputdir}, check permissions." ; exit 1; } 
	fi
fi
if [ -d "$splitdir" ]; then
	splitdirexists=1
else
	mkdir "$splitdir" || { echo "***! Unable to create ${splitdir}, check permissions." ; exit 1; }
fi
if [ ! -d "$tmpdir" ] && [ -z "$final" ] && [ -z "$dedup" ] && [ -z "$postproc" ]; then
	mkdir "$tmpdir"
	#chmod 777 "$tmpdir"
fi
if [ ! -d "$debugdir" ]; then
	mkdir "$debugdir"
	#chmod 777 "$debugdir"
fi
if [ -z $splitme ]
then
	fastqsize=$(ls -lL  ${fastqdir} | awk '{sum+=$5}END{print sum}')
	if [ "$fastqsize" -gt "2592410750" ]
	then
		splitme=1
	fi
fi
testname=$(ls -l ${fastqdir} | awk 'NR==1{print $9}')
if [ "${testname: -3}" == ".gz" ]
then
	read1=${splitdir}"/*${read1str}*.fastq.gz"
	gzipped=1
else
	read1=${splitdir}"/*${read1str}*.fastq"
fi
if [ -z "$user" ]
then
	userstring=""
else
	userstring="#SBATCH -A $user"
fi
jid=$(
sbatch $hold <<- HEADER | egrep -o -e "\b[0-9]+$"
	#!/bin/bash -l 
	date
	${load_bwa}
	${load_java}
	${load_awk}
	${load_coreutils}
	# Experiment description
	if [ -n "${about}" ]
	then
		echo -ne 'Experiment description: ${about}; '
	else
		echo -ne 'Experiment description: '
	fi
	# Get version numbers of all software
	echo -ne "Juicer version $juicer_version;" 
	bwa 2>&1 | awk '\$1=="Version:"{printf(" BWA %s; ", \$2)}'
	echo -ne "$threads threads; "
	if [ -n "$splitme" ]
	then
		echo -ne "splitsize $splitsize; "
	fi  
	java -version 2>&1 | awk 'NR==1{printf("%s; ", \$0);}'
	${juiceDir}/scripts/juicer_tools -V 2>&1 \
		| awk '\$1=="Juicer" && \$2=="Tools"{printf("%s; ", \$0);}'
	echo "$0 $@"
HEADER
)
headfile="${debugdir}/head-${jid}.out"
errorfile=${debugdir}/${groupname}_alignfail
if [ -f $errorfile ]
then
	rm $errorfile
fi
if [ -z $merge ] && [ -z $final ] && [ -z $dedup ] && [ -z $postproc ]
then
	if [ "$nofrag" -eq 0 ]
	then
		echo -e "(-: Aligning files matching $fastqdir\n in queue $queue to genome $genomeID with site file $site_file"
	else
		echo -e "(-: Aligning files matching $fastqdir\n in queue $queue to genome $genomeID with no fragment delimited maps."
	fi
	## Split fastq files into smaller portions for parallelizing alignment 
	## Do this by creating a text script file for the job on STDIN and then 
	## sending it to the cluster	
	dependsplit="afterok"
	### JOB _split
	if [ ! $splitdirexists ]
	then
		echo "(-: Created $splitdir and $outputdir."
		if [ -n "$splitme" ]
		then
			for i in ${fastqdir}
			do
				filename=$(basename $i)
				filename=${filename%.*}	  
				if [ -z "$gzipped" ]
				then	
					jid=$(
					sbatch $hold <<- SPLITEND | egrep -o -e "\b[0-9]+$"
					#!/bin/bash -l
					date
					echo "Split file: $filename"
					${load_coreutils}
					split -a 3 -l $splitsize -d --additional-suffix=.fastq.gz \
						--filter='pigz -p 4 > \$FILE' \
						$i $splitdir/$filename
					date
					SPLITEND
					)
				else
					jid=$(
					sbatch $hold <<- SPLITEND | egrep -o -e "\b[0-9]+$"
					#!/bin/bash -l
					date
					echo "Split file: $filename"
					${load_coreutils}
					zcat $i | split -a 3 -l $splitsize -d --additional-suffix=.fastq.gz \
						--filter='pigz -p 4 > \$FILE' \
						- $splitdir/$filename
					date
					SPLITEND
					)
				fi
				dependsplit="$dependsplit:$jid"
				# if we split files, the splits are named .fastq
				read1=${splitdir}"/*${read1str}*.fastq.gz"
			done
			# dependencies don't work with srun from within an interactive session
			jid=$(
			sbatch $hold <<-SPLITWAITEND | egrep -o -e "\b[0-9]+$"
			#!/bin/bash -l
			touch ${splitdir}/SPLIT_DONE
			SPLITWAITEND
			)
			echo "    Waiting for the fastq files to be split before continuing"
			echo "    START: $(date)"
			while true; do
			    [[ -f ${splitdir}/SPLIT_DONE ]] && break
			    sleep 1m
			done
			echo "    DONE: $(date)"
		else
			cp -rs ${fastqdir} ${splitdir}
			wait
		fi
	else
		## No need to re-split fastqs if they already exist
		echo -e "---  Using already created files in $splitdir\n"
		# unzipped files will have .fastq extension, softlinked gz 
		testname=$(ls -l ${splitdir} | awk '$9~/fastq$/||$9~/gz$/{print $9; exit}')
		if [[ ${testname: -3} == ".gz" ]]
		then
			read1=${splitdir}"/*${read1str}*.fastq.gz"
		else
			read1=${splitdir}"/*${read1str}*.fastq"
		fi
	fi
	## Launch job. Once split/move is done, set the parameters for the launch. 
	echo "(-: Starting job to launch other jobs once splitting is complete"
	## Loop over all read1/read2 fastq files and create jobs for aligning.
	## Then call chimeric script on aligned, sort individual
	## Wait for splits to be individually sorted, then do a big merge sort.
	## ARRAY holds the names of the jobs as they are submitted
	countjobs=0
	declare -a ARRAY
	declare -a JIDS
	declare -a TOUCH
	dependmerge="afterok"
	for i in ${read1}
	do
		ext=${i#*$read1str}
		name=${i%$read1str*} 
		# these names have to be right or it'll break
		name1=${name}${read1str}
		name2=${name}${read2str}	
		jname=$(basename "$name")${ext}
		usegzip=0
		if [ "${ext: -3}" == ".gz" ]
		then
			usegzip=1
		fi
		touchfile=${tmpdir}/${jname}
		# count ligations
		### JOB _count_ligations
		jid=$(
		sbatch $hold <<- CNTLIG |  egrep -o -e "\b[0-9]+$"
		#!/bin/bash -l
		date
		usegzip=${usegzip}
		name=${name}
		name1=${name1}
		name2=${name2}
		ext=${ext}
		ligation="${ligation}"
		export usegzip name name1 name2 ext ligation
		${juiceDir}/scripts/countligations.sh
		date
		CNTLIG
		)
		echo "Submitted ligation counting job ${groupname}${jname}_Count_Ligation"
		dependcount="$jid"
		if [ -z "$chimeric" ]
		then
			### JOB _align1
			# align fastqs
			jid=$(
			sbatch $hold <<- ALGNR1 | egrep -o -e "\b[0-9]+$"
			#!/bin/bash -l
			${load_bwa}
			${load_samtools}
			# Align reads
			date
			bwa mem -SP5M $threadstring $refSeq $name1$ext $name2$ext \
				| samtools view -b -@3 -o $name$ext.bam
			if [ \$? -ne 0 ]
			then  
				touch $errorfile
				exit 1
			else
				echo "(-: Mem align of $name$ext.sam done successfully"
			fi
			date
			ALGNR1
			)
			echo "Submitted align1 job ${groupname}_align1_${jname}"
			dependalign="afterok:$jid:$dependcount"
		else
			dependalign="afterok:$dependcount"
		fi
		# wait for alignment, chimeric read handling
		### JOB _merge
		jid=$(
		sbatch $hold <<- MRGALL | egrep -o -e "\b[0-9]+$"
		#!/bin/bash -l
		${load_awk}
		${load_coreutils}
		${load_samtools}
		date
		# call chimeric_blacklist.awk to deal with chimeric reads; 
		# sorted file is sorted by read name at this point
		touch ${name}${ext}_abnorm.sam ${name}${ext}_unmapped.sam ${name}${ext}_norm.txt
		awk -v "fname1"=${name}${ext}_norm.txt \
			-v "fname2"=${name}${ext}_abnorm.sam \
			-v "fname3"=${name}${ext}_unmapped.sam \
			-f $juiceDir/scripts/chimeric_blacklist.awk \
			<(samtools view -h ${name}${ext}.bam)
		if [ \$? -ne 0 ] 
		then	
			echo "***! Failure during chimera handling of $name${ext}"
			touch $errorfile
			exit 1   
		fi  
		# if any normal reads were written, find what fragment they 
		# correspond to and store that
		# check if site file exists and if so write the fragment number
		# even if nofrag set
		# one is not obligated to provide a site file if nofrag set; 
		# but if one does, frag numbers will be calculated correctly
		if [ -e "$name${ext}_norm.txt" ] && [ "$site" != "none" ] && [ -e "$site_file" ]
		then
			perl ${juiceDir}/scripts/fragment.pl ${name}${ext}_norm.txt \
				${name}${ext}.frag.txt $site_file
		elif [ "$site" == "none" ] || [ "$nofrag" -eq 1 ]
		then
			awk '{printf("%s %s %s %d %s %s %s %d", \$1, \$2, \$3, 0, \$4, \$5, \$6, 1); 
			      for (i=7; i<=NF; i++) {
					  printf(" %s",\$i);
				  }
				  printf("\n");}' $name${ext}_norm.txt > $name${ext}.frag.txt
		else
			echo "***! No $name${ext}_norm.txt file created"
			touch $errorfile
			exit 1
		fi
		if [ \$? -ne 0 ]
		then
			echo "***! Failure during fragment assignment of $name${ext}"
			touch $errorfile
			exit 1 
		fi
		# sort by chromosome, fragment, strand, and position
		sort --parallel=8 -S 400G -T /lscratch/\${SLURM_JOB_ID} \
			-k2,2d -k6,6d -k4,4n -k8,8n -k1,1n -k5,5n -k3,3n \
			$name${ext}.frag.txt > $name${ext}.sort.txt
		if [ \$? -ne 0 ]   
		then
			echo "***! Failure during sort of $name${ext}"
			touch $errorfile
			exit 1
		else
			rm $name${ext}_norm.txt $name${ext}.frag.txt
		fi
		touch $touchfile
		date
		MRGALL
		)
		echo "Submitted merge job ${groupname}_merge_${jname}"
		dependmerge="${dependmerge}:${jid}"
		ARRAY[countjobs]="${groupname}_merge_${jname}"
		JIDS[countjobs]="${jid}"
		TOUCH[countjobs]="$touchfile"
		countjobs=$(( $countjobs + 1 ))
	done # done looping over all fastq split files
	# list of all jobs. print errors if failed	
	for (( i=0; i < $countjobs; i++ ))
	do
		f=${TOUCH[$i]}
		msg="***! Error in job ${ARRAY[$i]}  Type squeue -j ${JIDS[$i]} to see what happened"
		### JOB _check
		# check that alignment finished successfully
		jid=$(
		sbatch $hold <<- EOF | egrep -o -e "\b[0-9]+$"
		#!/bin/bash -l
		date
		echo "Checking $f"
		if [ ! -e $f ]
		then
			echo $msg
			touch $errorfile
		fi
		date
		EOF
		)
		echo "Submitted check job ${groupname}_check"
		dependmergecheck="${dependmerge}:${jid}"
	done
fi  # Not in merge, dedup,  or final stage, i.e. need to split and align files.
if [ -z $final ] && [ -z $dedup ] && [ -z $postproc ]
then
	if [ -z $merge ]
	then
		sbatch_wait="#SBATCH -d $dependmergecheck"
	else
		sbatch_wait=""
	fi
	# merge the sorted files into one giant file that is also sorted. 
	jid=$(
	sbatch $hold <<- EOF
	#!/bin/bash -l
	${sbatch_wait}
	${load_coreutils}
	date
	if [ -f "${errorfile}" ]
	then
		echo "***! Found errorfile. Exiting." 
		exit 1 
	fi
	export LC_COLLATE=C
	if [ -d $donesplitdir ]
	then
		mv $donesplitdir/* $splitdir/.
	fi
	if ! sort --parallel=\${SLURM_CPUS_PER_TASK} -S 400G -T /lscratch/\${SLURM_JOB_ID} \
		-m -k2,2d -k6,6d -k4,4n -k8,8n -k1,1n -k5,5n -k3,3n $splitdir/*.sort.txt \
		> $outputdir/merged_sort.txt
	then
		echo "***! Some problems occurred somewhere in creating sorted align files."
		touch $errorfile
		exit 1
	else
		echo "(-: Finished sorting all sorted files into a single merge."
	fi
	date
	EOF
	)
	echo "Submitted fragmerge job ${groupname}_fragmerge"
	jid=$(echo $jid | egrep -o -e "\b[0-9]+$")
	dependmrgsrt="afterok:$jid"
fi
if [ -z $final ] && [ -z $postproc ]
then
	if [ -z $dedup ]
	then
		sbatch_wait="#SBATCH -d $dependmrgsrt"
	else
		sbatch_wait=""
	fi
	# Guard job for dedup. this job is a placeholder to hold any job submitted after dedup.
	# We keep the ID of this guard, so we can later alter dependencies of inner dedupping phase.
	### JOB _dedup_guard
	# After dedup is done, this job will be released. 
	guardjid=$(
	sbatch $hold <<- DEDUPGUARD | egrep -o -e "\b[0-9]+$"
	#!/bin/bash -l
	${sbatch_wait}
	date
	DEDUPGUARD
	)
	dependguard="afterok:$guardjid"
	### JOB _dedup
	# if jobs succeeded, kill the cleanup job, remove the duplicates from the big sorted file
	dedup_awk_script="$juiceDir/scripts/split_rmdups.awk"
	if [[ ${dedup8g:-0} -eq 1 ]] ; then
		echo "    using split_rmdups_8g.awk for deduplication"
		dedup_awk_script="$juiceDir/scripts/split_rmdups_8g.awk"
	fi
	jid=$(
	sbatch $hold <<- DEDUP | egrep -o -e "\b[0-9]+$"
	#!/bin/bash -l
	${sbatch_wait}
	export LC_ALL=C
	date
		if [ -f "${errorfile}" ]
		then 
			echo "***! Found errorfile. Exiting." 
			exit 1 
		fi 
	squeue -u $USER -o "%A %T %j %E %R" | column -t
	awk -v queue=$long_queue \
		-v groupname=$groupname \
		-v debugdir=$debugdir \
		-v dir=$outputdir \
		-v topDir=$topDir \
		-v juicedir=$juiceDir \
		-v site=$site \
		-v genomeID=$genomeID \
		-v genomePath=$genomePath \
		-v user=$USER \
		-v guardjid=$guardjid \
		-v justexact=$justexact \
		-f $dedup_awk_script \
		$outputdir/merged_sort.txt
	squeue -u $USER -o "%A %T %j %E %R" | column -t
	date
	scontrol release $guardjid
	DEDUP
	)
	echo "Submitted dedup job ${groupname}_dedup"
	dependosplit="afterok:$jid"
	#Push dedup guard to run only after dedup is complete:
	scontrol update JobID=$guardjid dependency=afterok:$jid
	### JOB _post_dedup
	#Wait for all parts of split_rmdups to complete:
	jid=$(
	sbatch $hold <<- MSPLITWAIT | egrep -o -e "\b[0-9]+$"
	#!/bin/bash -l
	date
	rm -Rf $tmpdir ;
	find $debugdir -type f -size 0 -exec rm {} +
	squeue -u $USER -o "%A %T %j %E %R" | column -t
	date
	MSPLITWAIT
	)
	echo "Submitted post dedup job ${groupname}_post_dedup"
	dependmsplit="afterok:$jid"
	sbatch_wait="#SBATCH -d $dependmsplit"
else
	sbatch_wait=""
fi
if [ -z "$genomePath" ]
then
	#If no path to genome is give, use genome ID as default.
	genomePath=$genomeID
fi
if [ -z $postproc ]
	then
	### JOB _dupcheck
	# Check that dedupping worked properly
	# in ideal world, we would check this in split_rmdups and not remove before we know they are correct
	awkscript='BEGIN{sscriptname = sprintf("%s/.%s_rmsplit.slurm", debugdir, groupname);}NR==1{if (NF == 2 && $1 == $2 ){print "Sorted and dups/no dups files add up"; printf("#!/bin/bash -l\n#SBATCH -o %s/dup-rm.out\n#SBATCH -e %s/dup-rm.err\n#SBATCH -p %s\n#SBATCH -J %s_msplit0\n#SBATCH -d singleton\n#SBATCH -t 1440\n#SBATCH -c 1\n#SBATCH --mem=8G\n#SBATCH --ntasks=1\ndate;\nrm %s/*_msplit*_optdups.txt; rm %s/*_msplit*_dups.txt; rm %s/*_msplit*_merged_nodups.txt;rm %s/split*;\ndate\n", debugdir, debugdir, queue, groupname, dir, dir, dir, dir) > sscriptname; sysstring = sprintf("sbatch %s", sscriptname); system(sysstring);close(sscriptname); }else{print "Problem"; print "***! Error! The sorted file and dups/no dups files do not add up, or were empty."}}'
	jid=$(
	sbatch $hold <<- DUPCHECK | egrep -o -e "\b[0-9]+$"
	#!/bin/bash -l
	${sbatch_wait}
	date	  
	ls -l ${outputdir}/merged_sort.txt \
		| awk '{printf("%s ", \$5)}' \
		> $debugdir/dupcheck-${groupname}
	ls -l ${outputdir}/merged_nodups.txt ${outputdir}/dups.txt ${outputdir}/opt_dups.txt \
		| awk '{sum = sum + \$5}END{print sum}' \
		>> $debugdir/dupcheck-${groupname}
	awk -v debugdir=$debugdir \
		-v queue=$queue \
		-v groupname=$groupname \
		-v dir=$outputdir \
		'$awkscript' $debugdir/dupcheck-${groupname}
	date
	DUPCHECK
	)
	echo "Submitted dupcheck job ${groupname}_dupcheck"
	sbatch_wait="#SBATCH -d afterok:$jid"
	### JOB _prestats
	jid=$(
	sbatch $hold <<- PRESTATS | egrep -o -e "\b[0-9]+$"
	#!/bin/bash -l
	${sbatch_wait}
	${load_java}
	date
	#export IBM_JAVA_OPTIONS="-Xmx1024m -Xgcthreads1"
	export _JAVA_OPTIONS="-Xmx2048m -Xms2048m -XX:ParallelGCThreads=1"
	#export _JAVA_OPTIONS="-Xmx409600m -Xms409600m -XX:ParallelGCThreads=1"
	tail -n1 $headfile | awk '{printf"%-1000s\n", \$0}' > $outputdir/inter.txt
	cat $splitdir/*.res.txt \
		| awk -f ${juiceDir}/scripts/stats_sub.awk >> $outputdir/inter.txt
	${juiceDir}/scripts/juicer_tools LibraryComplexity $outputdir inter.txt \
		>> $outputdir/inter.txt
	cp $outputdir/inter.txt $outputdir/inter_30.txt
	date
	PRESTATS
	)
	echo "Submitted prestats job ${groupname}_prestats"
	### JOB _stats
	sbatch_wait0="#SBATCH -d afterok:$jid"
	jid=$(
	sbatch $hold <<- STATS | egrep -o -e "\b[0-9]+$"
	#!/bin/bash -l
	${sbatch_wait0}
	date
	if [ -f "${errorfile}" ]
	then 
		echo "***! Found errorfile. Exiting." 
		exit 1 
	fi 
	perl ${juiceDir}/scripts/statistics.pl -s $site_file -l $ligation \
		-o $outputdir/inter.txt -q 1 $outputdir/merged_nodups.txt
	date
	STATS
	)
	echo "Submitted stats job ${groupname}_stats"
	sbatch_wait1="#SBATCH -d afterok:$jid"
	### JOB _stats30
	dependstats="afterok:$jid"
	jid=$(
	sbatch $hold <<-STATS30 | egrep -o -e "\b[0-9]+$"
	#!/bin/bash -l
	${sbatch_wait0}
	perl ${juiceDir}/scripts/statistics.pl -s $site_file -l $ligation \
		-o $outputdir/inter_30.txt -q 30 $outputdir/merged_nodups.txt
	date
	STATS30
	)
	echo "Submitted stats30 job ${groupname}_stats"
	dependstats30="afterok:$jid"
	sbatch_wait1="${sbatch_wait1}:$jid"
	# This job is waiting on deduping, thus sbatch_wait (vs sbatch_wait0 or 1) 
	### JOB _concat
	jid=$(
	sbatch $hold <<- CONCATFILES | egrep -o -e "\b[0-9]+$"
	#!/bin/bash -l
	${sbatch_wait}
	${load_awk}
	cat $splitdir/*_abnorm.sam > $outputdir/abnormal.sam
	cat $splitdir/*_unmapped.sam > $outputdir/unmapped.sam
	# collect collisions and dedup them
	awk -f ${juiceDir}/scripts/collisions.awk $outputdir/abnormal.sam \
		> $outputdir/collisions.txt
	# dedup: two pass algorithm, ideally would make one pass
	gawk -v fname=$outputdir/collisions.txt \
			-f ${juiceDir}/scripts/collisions_dedup_rearrange_cols.awk \
			$outputdir/collisions.txt \
		| sort -k3,3n -k4,4n -k10,10n -k11,11n -k17,17n -k18,18n -k24,24n \
			   -k25,25n -k31,31n -k32,32n \
		| awk -v name=$outputdir/ -f ${juiceDir}/scripts/collisions_dups.awk
	date
	CONCATFILES
	)
	echo "Submitted concat job ${groupname}_concat"
	# if early exit, we stop here, once the stats are calculated
	if [ ! -z "$earlyexit" ]
		then
		### JOB _prep_done
		jid=$(
		sbatch $hold <<-FINCLN1 | egrep -o -e "\b[0-9]+$" 
		#!/bin/bash -l
		${sbatch_wait1}
		date
		export splitdir=${splitdir}; 
		export outputdir=${outputdir}; 
		export early=1; 
		${juiceDir}/scripts/check.sh
		date
		FINCLN1
		)
		echo "Submitted fincln job ${groupname}_prep_done"
		echo "(-: Finished adding all jobs... Now is a good time to get that cup of coffee... Last job id $jid"
		exit 0
	fi
	### JOB _hic
	jid=$(
	sbatch $hold <<- HIC | egrep -o -e "\b[0-9]+$"
	#!/bin/bash -l
	${load_java}
	#export IBM_JAVA_OPTIONS="-Xmx49152m -Xgcthreads1"
	export _JAVA_OPTIONS="-Xmx49152m -Xms49152m -XX:ParallelGCThreads=1"
	#export _JAVA_OPTIONS="-Xmx409600m -Xms409600m -XX:ParallelGCThreads=1"
	date
	if [ -f "${errorfile}" ]
	then 
		echo "***! Found errorfile. Exiting." 
		exit 1 
	fi 
    set -x
	if [ "$nofrag" -eq 1 ]
	then 
		${juiceDir}/scripts/juicer_tools pre -s $outputdir/inter.txt \
			-g $outputdir/inter_hists.m -q 1 $outputdir/merged_nodups.txt \
			$outputdir/inter.hic $genomePath
	else
		${juiceDir}/scripts/juicer_tools pre -f $site_file -s $outputdir/inter.txt \
			-g $outputdir/inter_hists.m -q 1 $outputdir/merged_nodups.txt \
			$outputdir/inter.hic $genomePath
	fi
    set +x
	date
	HIC
	)
	echo "Submitted hic job ${groupname}_hic"
	dependhic="afterok:$jid"
	### JOB _hic30
	jid=$(
	sbatch $hold <<- HIC30 | egrep -o -e "\b[0-9]+$"
	#!/bin/bash -l
	${load_java}
	#export IBM_JAVA_OPTIONS="-Xmx49152m -Xgcthreads1"
	export _JAVA_OPTIONS="-Xmx49152m -Xms49152m -XX:ParallelGCThreads=1"
	#export _JAVA_OPTIONS="-Xmx409600m -Xms409600m -XX:ParallelGCThreads=1"
	date
	if [ -f "${errorfile}" ]
	then 
		echo "***! Found errorfile. Exiting." 
		exit 1 
	fi 
	if [ "$nofrag" -eq 1 ]
	then 
		${juiceDir}/scripts/juicer_tools pre -s $outputdir/inter_30.txt \
			-g $outputdir/inter_30_hists.m -q 30 $outputdir/merged_nodups.txt \
			$outputdir/inter_30.hic $genomePath
	else
		${juiceDir}/scripts/juicer_tools pre -f $site_file -s $outputdir/inter_30.txt \
			-g $outputdir/inter_30_hists.m -q 30 $outputdir/merged_nodups.txt \
			$outputdir/inter_30.hic $genomePath
	fi
	date
	HIC30
	)
	echo "Submitted hic30 job ${groupname}_hic30"
	dependhic30="${dependhic}:$jid"
	sbatch_wait="#SBATCH -d $dependhic30"
else
	sbatch_wait=""
fi
jid=$(
sbatch $hold <<- HICCUPS | egrep -o -e "\b[0-9]+$"
${sbatch_wait}
${load_gpu}
echo "load: $load_gpu"
${load_java}
date
nvcc -V
if [ -f "${errorfile}" ]
then 
	echo "***! Found errorfile. Exiting." 
	exit 1 
fi 
${juiceDir}/scripts/juicer_hiccups.sh -j ${juiceDir}/scripts/juicer_tools \
	-i $outputdir/inter_30.hic ${motifDir} -g $genomeID
date
HICCUPS
)
dependhiccups="afterok:$jid"
echo "Submitted hiccups_wrap job ${groupname}_hiccups_wrap"
jid=$(
sbatch $hold <<- ARROWS | egrep -o -e "\b[0-9]+$"
${sbatch_wait}
${load_java}
date
if [ -f "${errorfile}" ]
then 
	echo "***! Found errorfile. Exiting." 
	exit 1 
fi 
${juiceDir}/scripts/juicer_arrowhead.sh -j ${juiceDir}/scripts/juicer_tools \
	-i $outputdir/inter_30.hic
date
ARROWS
)
echo "Submitted arrowhead job ${groupname}_arrowhead_wrap"
dependarrows="${dependhiccups}:$jid"
jid=$(
sbatch $hold <<- FINCLN1 | egrep -o -e "\b[0-9]+$"
date
export splitdir=${splitdir}; export outputdir=${outputdir}; ${juiceDir}/scripts/check.sh
date
FINCLN1
)
echo "Submitted fincln job ${groupname}_prep_done"
echo "(-: Finished adding all jobs... Now is a good time to get that cup of coffee... Last job id $jid"

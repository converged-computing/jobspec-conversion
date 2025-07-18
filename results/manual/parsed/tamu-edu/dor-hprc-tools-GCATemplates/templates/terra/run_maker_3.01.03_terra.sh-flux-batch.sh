#!/bin/bash
#FLUX: --job-name=maker
#FLUX: -c=28
#FLUX: -t=86400
#FLUX: --urgency=16

module load MAKER/3.01.03-intel-2018b-Python-2.7.15
<<README
    - MAKER manual: http://weatherby.genetics.utah.edu/MAKER/wiki/index.php/Main_Page
    - MAKER usage: http://onlinelibrary.wiley.com/doi/10.1002/0471250953.bi0411s48/pdf
    - MAKER resources:
        http://www.yandell-lab.org/
        http://yandell-lab.org/software/maker.html
        http://gmod.org/wiki/GMOD_Online_Training_2014/MAKER_Tutorial
        https://groups.google.com/group/maker-devel?pli=1
README
<<PREREQUISITES
    - GeneMark-ES prerequisite:
        Download the 64_bit key from the following website and save it to your $HOME directory.
        Select the following: GeneMark-ES/ET/EP ver 4.57_lic  and  LINUX 64
        (you do not need to download the program just the 64_bit key file)
            http://topaz.gatech.edu/GeneMark/license_download.cgi
        Then gunzip the key file and rename it from gm_key_64 to .gm_key
        The key expires in 1 year at which time you will need to download a new key.
    - Read the pdf at the MAKER usage link above to learn about the required control files.
    - Copy the control files prior to running your job script.
        module load MAKER/3.01.03-intel-2018b-Python-2.7.15
        cp /scratch/data/bio/maker/3.01.03/*ctl ./
        - Required: edit the maker_opts.ctl file (unless running the m_tuberculosis example)
        - Optional: edit the maker_bopts.ctl file
    - You will need to create a model file using either GeneMark-ES (eukaryotes) or GeneMarkS (prokaryotes) if 
        you want sequences for the modeled genes. Add your GeneMark .mod file at the line: gmhmm= #GeneMark HMM file
        Example command for making a Prokaryotic model file
            module load MAKER/3.01.03-intel-2018b-Python-2.7.15
            gmsn.pl --prok --verbose your_genome.fasta
        Example command for making a Eukaryotic model file
            module load MAKER/3.01.03-intel-2018b-Python-2.7.15
            gmes_petap.pl --cores 4 --ES --sequence your_genome.fasta
    - See available augustus species here: /sw/eb/sw/AUGUSTUS/3.3.2-intel-2018b/config/species/
PREREQUISITES
genome='/scratch/data//bio/GCATemplates/m_tuberculosis/denovo/contigs_k91.fasta'
cpus=$SLURM_CPUS_PER_TASK
out_prefix='example_contigs'
maker -cpus $cpus -genome $genome -TMP $TMPDIR -base $out_prefix
fasta_merge -d ${out_prefix}.maker.output/${out_prefix}_master_datastore_index.log
gff3_merge -d ${out_prefix}.maker.output/${out_prefix}_master_datastore_index.log
<<CITATION
    - Acknowledge TAMU HPRC: https://hprc.tamu.edu/research/citations.html
    - MAKER:
        Brandi L. Cantarel, Ian Korf, Sofia M.C. Robb, Genis Parra, Eric Ross, Barry Moore, Carson Holt, Alejandro Sánchez Alvarado
        and Mark Yandell. MAKER: An easy-to-use annotation pipeline designed for emerging model organism genomes.
        Genome Res. 2008 Jan; 18(1): 188–196. doi:  10.1101/gr.6743907
CITATION

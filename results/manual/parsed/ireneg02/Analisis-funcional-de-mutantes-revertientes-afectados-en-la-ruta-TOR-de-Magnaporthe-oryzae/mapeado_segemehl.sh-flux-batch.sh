#!/bin/bash
#FLUX: --job-name=segemehl
#FLUX: --queue=long
#FLUX: -t=259200
#FLUX: --urgency=16

module use /beegfs/easybuild/CentOS/7.6.1810/Skylake/modules/all
module use /beegfs/easybuild/common/modules/all
module load segemehl/0.3.4-GCC-11.2.0 
PATH="$PATH:/beegfs/easybuild/CentOS/7.6.1810/Skylake/software/segemehl/0.3.4-GCC-11.2.0/bin"
cd "/home/ireneg/DATOS_DNA-SEQ/originales/MagorGY11_1/Mycocosm/Assembly/Genome Assembly (unmasked)" #Nos movemos a la carpeta que contiene el genoma de referencia de Guy11
segemehl.x -x MagorGY11_1_AssemblyScaffolds.idx -d MagorGY11_1_AssemblyScaffolds.fasta #Construimos el índice del genoma de referencia (que debe aportarse en formato fasta)
cd /home/ireneg/DATOS_DNA-SEQ/originales_descompr/ #Nos desplazamos a la carpeta con las carpetas de las muestras
for folder in $(ls -d C*/); do #Recorremos las carpetas de las muestras, en las que se encuentran las lecturas originales sin comprimir
        cd $folder #Entramos en la carpeta
        file="${folder:0:18}" #Obtenemos el nombre de la muestra
        file_1="${file}_1.fastq" #Obtenemos el nombre del archivo con las lecturas forward
        file_2="${file}_2.fastq" #Obtenemos el nombre del archivo con las lecturas reverse     
        segemehl.x -i "/home/ireneg/DATOS_DNA-SEQ/originales/MagorGY11_1/Mycocosm/Assembly/Genome Assembly (unmasked)/MagorGY11_1_AssemblyScaffolds.idx" -d "/home/ireneg/DATOS_DNA-SEQ/originales/MagorGY11_1/Mycocosm/Assembly/Genome Assembly (unmasked)/MagorGY11_1_AssemblyScaffolds.fasta" -q ${file_1} -p ${file_2}> SEGEMEHL/segemehl_map_${file}_unfiltered_Guy11.sam #Ejecutamos el mapeado de las lecturas originales. Los resultados se almacenan en una carpeta llamada "SEGEMEHL"        
        cd ..#Salimos de la carpeta de la muestra
done
cd /home/ireneg/DATOS_DNA-SEQ/procesamiento/ #Nos desplazamos a la carpeta con las carpetas de las muestras
for folder in $(ls -d */); do #Recorremos las carpetas de las muestras, en las que se encuentran las lecturas emparejadas y sin emparejar resultantes del filtrado con Fastp
        cd $folder #Entramos en la carpeta
        file="${folder:0:18}" #Obtenemos el nombre de la muestra
        file_1="${file}_1.fastq.gz" #Obtenemos el nombre del archivo con las lecturas forward
        file_2="${file}_2.fastq.gz" #Obtenemos el nombre del archivo con las lecturas reverse  
        segemehl.x -i "/home/ireneg/DATOS_DNA-SEQ/originales/MagorGY11_1/Mycocosm/Assembly/Genome Assembly (unmasked)/MagorGY11_1_AssemblyScaffolds.idx" -d "/home/ireneg/DATOS_DNA-SEQ/originales/MagorGY11_1/Mycocosm/Assembly/Genome Assembly (unmasked)/MagorGY11_1_AssemblyScaffolds.fasta" -q out_fastp_${file}_1_paired.fq -p out_fastp_${file}_2_paired.fq> SEGEMEHL/segemehl_map_${file}_PE_Guy11.sam #Se mapean las lecturas emparejadas
        segemehl.x -i "/home/ireneg/DATOS_DNA-SEQ/originales/MagorGY11_1/Mycocosm/Assembly/Genome Assembly (unmasked)/MagorGY11_1_AssemblyScaffolds.idx" -d "/home/ireneg/DATOS_DNA-SEQ/originales/MagorGY11_1/Mycocosm/Assembly/Genome Assembly (unmasked)/MagorGY11_1_AssemblyScaffolds.fasta"   -q out_fastp_${file}_1_unpaired.fq > SEGEMEHL/segemehl_map_${file}_SE_1_Guy11.sam #Se mapean las lecturas forward sin pareja
        segemehl.x -i "/home/ireneg/DATOS_DNA-SEQ/originales/MagorGY11_1/Mycocosm/Assembly/Genome Assembly (unmasked)/MagorGY11_1_AssemblyScaffolds.idx" -d "/home/ireneg/DATOS_DNA-SEQ/originales/MagorGY11_1/Mycocosm/Assembly/Genome Assembly (unmasked)/MagorGY11_1_AssemblyScaffolds.fasta"   -q out_fastp_${file}_2_unpaired.fq > SEGEMEHL/segemehl_map_${file}_SE_2_Guy11.sam #Se mapean las lecturas reverse sin pareja
        cd ..#Salimos de la carpeta de la muestra
done
cd /home/ireneg/DATOS_DNA-SEQ/originales/ncbi_dataset/data/GCF_000002495.2/ #Nos movemos a la carpeta que contiene el genoma de referencia de 70-15
segemehl.x -x GCF_000002495.2_MG8_genomic.idx -d GCF_000002495.2_MG8_genomic.fna #Construimos el índice del genoma de referencia (que debe aportarse en formato fasta)
cd /home/ireneg/DATOS_DNA-SEQ/originales_descompr/ #Nos desplazamos a la carpeta con las carpetas de las muestras
for folder in $(ls -d C*/); do #Recorremos las carpetas de las muestras, en las que se encuentran las lecturas originales sin comprimir
        cd $folder #Entramos en la carpeta
        file="${folder:0:18}" #Obtenemos el nombre de la muestra
        file_1="${file}_1.fastq" #Obtenemos el nombre del archivo con las lecturas forward
        file_2="${file}_2.fastq" #Obtenemos el nombre del archivo con las lecturas reverse     
        segemehl.x -i "/home/ireneg/DATOS_DNA-SEQ/originales/ncbi_dataset/data/GCF_000002495.2/GCF_000002495.2_MG8_genomic.idx" -d "/home/ireneg/DATOS_DNA-SEQ/originales/ncbi_dataset/data/GCF_000002495.2/GCF_000002495.2_MG8_genomic.fna" -q ${file_1} -p ${file_2}> SEGEMEHL/segemehl_map_${file}_unfiltered_70-15.sam
        cd ..#Salimos de la carpeta de la muestra
done
cd /home/ireneg/DATOS_DNA-SEQ/procesamiento/ #Nos desplazamos a la carpeta con las carpetas de las muestras
for folder in $(ls -d */); do #Recorremos las carpetas de las muestras, en las que se encuentran las lecturas emparejadas y sin emparejar resultantes del filtrado con Fastp
        cd $folder #Entramos en la carpeta
        file="${folder:0:18}" #Obtenemos el nombre de la muestra
        file_1="${file}_1.fastq.gz" #Obtenemos el nombre del archivo con las lecturas forward
        file_2="${file}_2.fastq.gz" #Obtenemos el nombre del archivo con las lecturas reverse  
        segemehl.x -i "/home/ireneg/DATOS_DNA-SEQ/originales/ncbi_dataset/data/GCF_000002495.2/GCF_000002495.2_MG8_genomic.idx" -d "/home/ireneg/DATOS_DNA-SEQ/originales/ncbi_dataset/data/GCF_000002495.2/GCF_000002495.2_MG8_genomic.fna" -q out_fastp_${file}_1_paired.fq -p out_fastp_${file}_2_paired.fq> SEGEMEHL/segemehl_map_${file}_PE_70-15.sam #Se mapean las lecturas emparejadas
        segemehl.x -i "/home/ireneg/DATOS_DNA-SEQ/originales/ncbi_dataset/data/GCF_000002495.2/GCF_000002495.2_MG8_genomic.idx" -d "/home/ireneg/DATOS_DNA-SEQ/originales/ncbi_dataset/data/GCF_000002495.2/GCF_000002495.2_MG8_genomic.fna"   -q out_fastp_${file}_1_unpaired.fq > SEGEMEHL/segemehl_map_${file}_SE_1_70-15.sam #Se mapean las lecturas forward sin pareja
        segemehl.x -i "/home/ireneg/DATOS_DNA-SEQ/originales/ncbi_dataset/data/GCF_000002495.2/GCF_000002495.2_MG8_genomic.idx" -d "/home/ireneg/DATOS_DNA-SEQ/originales/ncbi_dataset/data/GCF_000002495.2/GCF_000002495.2_MG8_genomic.fna"   -q out_fastp_${file}_2_unpaired.fq > SEGEMEHL/segemehl_map_${file}_SE_2_70-15.sam #Se mapean las lecturas reverse sin pareja
        cd ..#Salimos de la carpeta de la muestra
done

#!/bin/bash
#FLUX: --job-name=SPAdes
#FLUX: --queue=medium
#FLUX: -t=86400
#FLUX: --urgency=16

module use /beegfs/easybuild/CentOS/7.6.1810/Skylake/modules/all
module use /beegfs/easybuild/common/modules/all
module load SPAdes/3.15.2-GCC-8.2.0-2.31.1
cd /home/ireneg/DATOS_DNA-SEQ/fastp+segemehl+bwa/ #Nos desplazamos a la carpeta con las carpetas de las muestras
for folder in $(ls -d C*/); do #Recorremos las carpetas de las muestras
        cd $folder #Entramos en la carpeta
        file="${folder:0:18}" #Obtenemos el nombre de la muestra
        spades.py --pe1-1 out_fastp_${file}_1_paired.fq --pe1-2 out_fastp_${file}_2_paired.fq --pe1-s out_fastp_${file}_1_unpaired.fq --pe1-s out_fastp_${file}_2_unpaired.fq -o spades_output #Ejecutamos el ensamblado con SPAdes
        cd .. #Salimos de la carpeta de la muestra
done

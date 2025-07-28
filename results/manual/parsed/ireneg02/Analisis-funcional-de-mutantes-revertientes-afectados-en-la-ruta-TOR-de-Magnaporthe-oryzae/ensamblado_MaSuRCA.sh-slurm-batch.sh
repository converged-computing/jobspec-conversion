#!/bin/bash
#FLUX: --job-name=MaSuRCA
#FLUX: --queue=long
#FLUX: -t=298820
#FLUX: --urgency=16

module use /beegfs/easybuild/CentOS/7.6.1810/Skylake/modules/all
module use /beegfs/easybuild/common/modules/all
mamba init
mamba activate irenegmasurca
cd /home/ireneg/DATOS_DNA-SEQ/procesamiento/ #Nos desplazamos a la carpeta con las carpetas de las muestras
for folder in $(ls -d C*/); do #Recorremos las carpetas de las muestras, en las que se encuentran las lecturas de la secuenciación
        cd $folder #Entramos en la carpeta
        file="${folder:0:18}" #Obtenemos el nombre de la muestra
        file_1="${file}_1.fastq.gz" #Obtenemos el nombre del archivo con las lecturas forward
        file_2="${file}_2.fastq.gz" #Obtenemos el nombre del archivo con las lecturas reverse 
        masurca -t 32 -i ${file_1},${file_2} #Ejecutamos el ensamblado con las lecturas originales
        cd .. #Salimos de la carpeta de la muestra
done

#!/bin/bash
#FLUX: --job-name=flagstat
#FLUX: --queue=medium
#FLUX: -t=86400
#FLUX: --urgency=16

module use /beegfs/easybuild/CentOS/7.6.1810/Skylake/modules/all
module use /beegfs/easybuild/common/modules/all
module load SAMtools/1.9-GCC-8.2.0-2.31.1
cd /home/ireneg/DATOS_DNA-SEQ/originales_descompr/ #Nos desplazamos a la carpeta con las carpetas de las muestras, que contienen los mapeados
for folder in $(ls -d C*/); do #Recorremos las carpetas de las muestras
        cd $folder #Entramos en la carpeta de la muestra
        file="${folder:0:18}" #Obtenemos el nombre de la muestra
        samtools flagstat BWA/bwa_map_${file}_unfiltered_Guy11.sam >BWA/flagstat_bwa_map_${file}_unfiltered_Guy11.sam #Ejecutamos el análisis para obtener por parámetros del mapeado con el mapeado de BWA con Guy11 como referencia
        samtools flagstat BWA/bwa_map_${file}_unfiltered_70-15.sam >BWA/flagstat_bwa_map_${file}_unfiltered_70-15.sam ##Ejecutamos el análisis para obtener por parámetros del mapeado con el mapeado de BWA con G70-15 como referencia
        samtools flagstat SEGEMEHL/segemehl_map_${file}_unfiltered_Guy11.sam>SEGEMEHL/flagstat_segemehl_map_${file}_unfiltered_Guy11.sam #Ejecutamos el análisis para obtener por parámetros del mapeado con el mapeado de Segemehl con Guy11 como referencia
        samtools flagstat SEGEMEHL/segemehl_map_${file}_unfiltered_70-15.sam>SEGEMEHL/flagstat_segemehl_map_${file}_unfiltered_70-15.sam #Ejecutamos el análisis para obtener por parámetros del mapeado con el mapeado de Segemehl con 70-15 como referencia
        cd .. #Salimos de la carpeta de la muestra
done
cd /home/ireneg/DATOS_DNA-SEQ/procesamiento/ #Nos desplazamos a la carpeta con las carpetas de las muestras
for folder in $(ls -d C*/); do #Recorremos las carpetas de las muestras
        cd $folder #Entramos en la carpeta de la muestra
        file="${folder:0:18}" #Obtenemos el nombre de la muestra
        samtools merge BWA/bwa_map_${file}_merge_PE_SE_Guy11.sam BWA/bwa_map_${file}_PE_Guy11.sam BWA/bwa_map_${file}_SE_1_Guy11.sam BWA/bwa_map_${file}_SE_2_Guy11.sam #Fusionamos los archivos sam con los 3 mapeados de BWA con Guy11
        samtools merge BWA/bwa_map_${file}_merge_PE_SE_70-15.sam BWA/bwa_map_${file}_PE_70-15.sam BWA/bwa_map_${file}_SE_1_70-15.sam BWA/bwa_map_${file}_SE_2_70-15.sam #Fusionamos los archivos sam con los 3 mapeados de BWA con 70-15
        samtools merge SEGEMEHL/segemehl_map_${file}_merge_PE_SE_Guy11.sam SEGEMEHL/segemehl_map_${file}_PE_Guy11.sam SEGEMEHL/segemehl_map_${file}_SE_1_Guy11.sam SEGEMEHL/segemehl_map_${file}_SE_2_Guy11.sam #Fusionamos los archivos sam con los 3 mapeados de Segemehl con Guy11
        samtools merge SEGEMEHL/segemehl_map_${file}_merge_PE_SE_70-15.sam SEGEMEHL/segemehl_map_${file}_PE_70-15.sam SEGEMEHL/segemehl_map_${file}_SE_1_70-15.sam SEGEMEHL/segemehl_map_${file}_SE_2_70-15.sam #Fusionamos los archivos sam con los 3 mapeados de Segemehl con 70-15
        samtools flagstat BWA/bwa_map_${file}_merge_PE_SE_Guy11.sam >BWA/flagstat_bwa_map_${file}_merge_PE_SE_Guy11.sam #Ejecutamos el análisis para obtener por parámetros del mapeado con el mapeado de BWA con Guy11 como referencia
        samtools flagstat merge BWA/bwa_map_${file}_merge_PE_SE_70-15.sam >BWA/flagstat_bwa_map_${file}_merge_PE_SE_70-15.sam ##Ejecutamos el análisis para obtener por parámetros del mapeado con el mapeado de BWA con G70-15 como referencia
        samtools flagstat merge SEGEMEHL/segemehl_map_${file}_merge_PE_SE_Guy11.sam>SEGEMEHL/flagstat_segemehl_map_${file}_merge_PE_SE_Guy11.sam #Ejecutamos el análisis para obtener por parámetros del mapeado con el mapeado de Segemehl con Guy11 como referencia
        samtools flagstat SEGEMEHL/segemehl_map_${file}_merge_PE_SE_70-15.sam>SEGEMEHL/flagstat_segemehl_map_${file}_merge_PE_SE_70-15.sam #Ejecutamos el análisis para obtener por parámetros del mapeado con el mapeado de Segemehl con 70-15 como referencia
        cd .. #Salimos de la carpeta de la muestra
done

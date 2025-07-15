#!/bin/bash
#FLUX: --job-name=PD1_Kluc_GSEA # Job name
#FLUX: -c=16
#FLUX: --priority=16

export SIMG_FILE_NAME='rstudio-4.3.0-4-with_modules.sif'
export RPRIHOME='$HOME/R/$SIMG_FILE_NAME/'
export RScratch='$HOME/R/$SIMG_FILE_NAME/'
export RSLIB='$RScratch/rstudio-server/lib'
export RSRUN='$RScratch/rstudio-server/run'
export RSTMP='$RScratch/rstudio-server/tmp'

export SIMG_FILE_NAME=rstudio-4.3.0-4-with_modules.sif
export RPRIHOME=$HOME/R/$SIMG_FILE_NAME/
export RScratch=$HOME/R/$SIMG_FILE_NAME/
if [ ! -d ${RScratch}/tmp ]
then
  mkdir -p ${RScratch}/tmp
fi
if [ ! -d ${RPRIHOME} ]
then
  mkdir -p ${RPRIHOME}
fi
if [ ! -d ${HOME}/R/$SIMG_FILE_NAME/libs ]
then
  mkdir -p $HOME/R/$SIMG_FILE_NAME/libs
fi
if [ ! -d ${HOME}/R/$SIMG_FILE_NAME/.rstudio ]
then
  mkdir -p $HOME/R/$SIMG_FILE_NAME/.rstudio
fi
if [ ! -d ${HOME}/R/$SIMG_FILE_NAME/.config ]
then
  mkdir -p $HOME/R/$SIMG_FILE_NAME/.config
fi
if [ ! -e ${RPRIHOME}/.Renviron ]
then
  printf '\nNOTE: creating ~/.Renviron file'
  echo "R_LIBS_USER=$HOME/R/$SIMG_FILE_NAME/libs" > ${RPRIHOME}/.Renviron
fi
if [ ! -e ${RPRIHOME}/.Rprofile ]
then
  printf '\nNOTE: creating ~/.Rprofile file\n\n'
  echo "myPaths <- .libPaths()" > ${RPRIHOME}/.Rprofile
  echo "myPaths <- c(myPaths[3], myPaths[2],myPaths[1])" >> ${RPRIHOME}/.Rprofile
  echo ".libPaths(myPaths)" >> ${RPRIHOME}/.Rprofile
fi
mkdir -p $RScratch/rstudio-server/lib
mkdir -p $RScratch/rstudio-server/run
mkdir -p $RScratch/rstudio-server/tmp
export RSLIB=$RScratch/rstudio-server/lib
export RSRUN=$RScratch/rstudio-server/run
export RSTMP=$RScratch/rstudio-server/tmp
if [ -d /packages/containers/RStudio/ ]
then
  export SIMG_IMAGE=/packages/containers/RStudio/$SIMG_FILE_NAME
elif [ -d /packages/containers/Rstudio ]
then
  export SIMG_IMAGE=/packages/containers/Rstudio/$SIMG_FILE_NAME
elif [ -d /opt/RStudio/ ]
then
  export SIMG_IMAGE=/opt/RStudio/$SIMG_FILE_NAME
else
  echo 'cant fine a simg file that matches'
  exit
fi
module load singularity;
RSTUDIO_PASSWORD=$PASSWORD singularity exec -B /tgen_labs,/opt,$RSTMP:/tmp,$RSLIB:/var/lib/rstudio-server/,$RSRUN:/var/run/rstudio-server/,${RPRIHOME}/.Renviron:$HOME/.Renviron,${RPRIHOME}/.rstudio:$HOME/.rstudio,${RPRIHOME}/.config:$HOME/.config $SIMG_IMAGE R CMD BATCH CellChat.R

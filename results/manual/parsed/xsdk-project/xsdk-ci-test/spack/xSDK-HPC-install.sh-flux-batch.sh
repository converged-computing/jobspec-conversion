#!/bin/bash
#FLUX: --job-name=XSDK_TEST
#FLUX: -t=86400
#FLUX: --priority=16

XSDKINSTALL="#!/bin/bash
spack install xsdk<COMPILERS>"
for i in $(./spack/bin/spack compilers | grep @)
do
    rm -rf $i
    mkdir $i
    cd $i
    FILENAME=xsdk-install-$i.sh
    echo "$XSDKINSTALL" >> "$FILENAME"
    sed -i '' 's/\<COMPILERS\>/'%$i'/g' $FILENAME
    sh $FILENAME
    cd ../
done

#!/bin/bash
#
#
# INSTALL SIMULATION AND EVALUATION TOOLS:
#
sudo apt-get install libopenblas-base
conda install -c cobilab -y gto
conda install -c bioconda -y art
conda install -c bioconda -y mummer4
#
#
# INSTALL ASSEMBLY TOOLS:

#shorah
conda install shorah

#spades, metaviralspades and coronaspades
wget http://cab.spbu.ru/files/release3.15.5/SPAdes-3.15.5-Linux.tar.gz
tar -xzf SPAdes-3.15.5-Linux.tar.gz
rm SPAdes-3.15.5-Linux.tar.gz

#SAVAGE
conda install savage

#qsdpr
wget -O qsdpr "https://sourceforge.net/projects/qsdpr/files/QSdpR_v3.2.tar.gz/download"
tar xfz qsdpr
rm qsdpr

#qure
wget -O qure "https://sourceforge.net/projects/qure/files/latest/download"
unzip qure
rm qure

#virus-vg
wget -O virus-vg "https://bitbucket.org/jbaaijens/virus-vg/get/69a05f3e74f26e5571830f5366570b1d88ed9650.zip"
unzip virus-vg
rm virus-vg

wget "https://github.com/vgteam/vg/releases/download/v1.43.0/vg"
chmod +x vg

#vg-flow
wget -O vg-flow "https://bitbucket.org/jbaaijens/vg-flow/get/ac68093bbb235e508d0a8dd56881d4e5aee997e3.zip"
unzip vg-flow
rm vg-flow

#viaDBG
#cd /home && sudo wget http://downloads.sourceforge.net/project/boost/boost/1.60.0/boost_1_60_0.tar.gz
#tar xfz boost_1_60_0.tar.gz
#rm boost_1_60_0.tar.gz
#cd boost_1_60_0
#./bootstrap.sh --prefix=/usr/local --with-libraries=program_options,regex,filesystem,system
#export
#./b2 install
#cd /home
#rm -rf boost_1_60_0
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib/

#PredictHaplo
#mkdir PredictHaplo
#tar xfvz PredictHaplo-1.0.tgz
#cd PredictHaplo-1.0.tgz      
#tar xfvz scythestat-1.0.3.tar.gz
#cd scythestat-1.0.3
#./configure --prefix=PredictHaplo-1.0/NEWSCYTHE
#make install
#cd ..
#make






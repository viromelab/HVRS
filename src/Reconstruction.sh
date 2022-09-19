#!/bin/bash

#create bam files from sam files
samtools view -S -b DS1_.sam > DS1.bam

#shorah
shorah.py -b DS1.bam -f DS1.fa

#spades
cd SPAdes-3.15.5-Linux/bin/
./spades.py -o spades -1 ../../DS1_1.fq -2 ../../DS1_2.fq

#metaviralspades
./metaviralspades.py -o spades -1 ../../DS1_1.fq -2 ../../DS1_2.fq

#coronaspades
./coronaspades.py -o spades -1 ../../DS1_1.fq -2 ../../DS1_2.fq
cd ../../

#savage
mkdir savage
cd savage
savage --split 500 -p1 ../DS1_1.fq -p2 ../DS1_2.fq
cd ..

#qsdpr - missing vcf file
cd QSdpR_v3.2/
cp DS1.fa DS1_.sam data
chmod +x ./QSdpR_source/QSdpR_master.sh
./QSdpR_source/QSdpR_master.sh K1 K2 SOURCE DATA DS1_ ../DS1_1.fq ../DS1_2.fq samtools
cd DATA/sample_data;
SOURCE/QSdpR_master.sh 2 8 SOURCE DATA sample 1 1000 SAMTOOLS

#qure - unable to run
cd QuRe_v0.99971/
java -Xmx7G QuRe ../DS1.fa ../DS1.fa 1E-25 1E-25 1000
cd ..

#virus-vg - slow?
#python jbaaijens-virus-vg-69a05f3e74f2/scripts/build_graph_msga.py -f DS1_1.fq -r DS1_2.fq -c DS1.fa -vg vg -t 2

#vg-flow
python jbaaijens-vg-flow-ac68093bbb23/scripts/build_graph_msga.py -f DS1_1.fq -r DS1_2.fq -c DS1.fa -vg pwd -t 2

#tracepipelite
cd TRACESPipeLite/src/
cp ../../DS1_*.fq .
lzma -d VDB.mfa.lzma
./TRACESPipeLite.sh --threads 8 --reads1 DS1_1.fq --reads2 DS1_2.fq --database VDB.mfa --output test_viral_analysis
cd ../../


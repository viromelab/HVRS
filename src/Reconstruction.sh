#!/bin/bash

CREATE_BAM_FILES=0;
RUN_SHORAH=0;
RUN_QURE=0;
RUN_SAVAGE=0;
RUN_QSDPR=0;
RUN_SPADES=0;
RUN_METAVIRALSPADES=0;
RUN_CORONASPADES=0;
RUN_VIADBG=0;
RUN_VIRUSVG=0;
RUN_VGFLOW=0;
RUN_PREDICTHAPLO=0;
RUN_TRACESPIPELITE=1;

declare -a DATASETS=("DS1" "DS2" "DS3");
declare -a VIRUSES=("B19" "HPV" "VZV");

#create bam files from sam files - not working
if [[ "$CREATE_BAM_FILES" -eq "1" ]] 
  then  
  printf "Create bam files\n\n"
  for dataset in "${DATASETS[@]}"
    do	
    bwa index ${dataset}.fa
      bwa aln ${dataset}.fa ${dataset}_1.fq ${dataset}_2.fq > ${dataset}.sai
      bwa samse ${dataset}.fa ${dataset}.sai ${dataset}_1.fq ${dataset}_2.fq > ${dataset}.sam
      samtools view -bSh ${dataset}.sam > ${dataset}.bam;
      samtools view -bh -F4 ${dataset}.bam > FIL-${dataset}.bam;
      samtools sort -o ${dataset}.bam FIL-${dataset}.bam;
      samtools index -b ${dataset}.bam ${dataset}.bam.bai
      
    #bwa index ${dataset}.fa
    #bwa mem ${dataset}.fa ${dataset}_1.fq ${dataset}_2.fq > ${dataset}.sam
    #echo "aaaaaaaaaaaa"
    #samtools view -S -b ${dataset}.sam > ${dataset}.bam
    #echo "bbbbbbbbbb"
  done
fi

#shorah - can't test wothout bam files
if [[ "$RUN_SHORAH" -eq "1" ]] 
  then
  printf "Reconstructing with Shorah\n\n"
  for dataset in "${DATASETS[@]}"
    do	
    shorah.py -b ${dataset}.bam -f HPV-1.fa
  done
fi

#spades
if [[ "$RUN_SPADES" -eq "1" ]] 
  then
  printf "Reconstructing with SPAdes\n\n"
  mkdir -p spades/
  cd spades/
  for dataset in "${DATASETS[@]}"
    do	
    cp  ../${dataset}_1.fq .
    cp  ../${dataset}_2.fq .
    spades.py -o spades_${dataset} -1 ${dataset}_1.fq -2 ${dataset}_2.fq
    done
  cd ../
fi

#metaviralspades
if [[ "$RUN_METAVIRALSPADES" -eq "1" ]] 
  then
  printf "Reconstructing with metaviralSPAdes\n\n"
  cd SPAdes-3.15.5-Linux/bin/
  for dataset in "${DATASETS[@]}"
    do	
    cp ../../${dataset}_1.fq .
    cp ../../${dataset}_2.fq .
    ./metaviralspades.py -t 1 -o metaviralspades_${dataset} -1 ${dataset}_1.fq -2 ${dataset}_2.fq
  done
  cd ../../
fi

#coronaspades
if [[ "$RUN_CORONASPADES" -eq "1" ]] 
  then
  printf "Reconstructing with coronaSPAdes\n\n"
  cd SPAdes-3.15.5-Linux/bin/
  for dataset in "${DATASETS[@]}"
    do
    ./coronaspades.py -o spades -1 ../../${dataset}_1.fq -2 ../../${dataset}_2.fq
  done
  cd ../../
fi

#savage - Runs but no reads could be aligned to reference error
if [[ "$RUN_SAVAGE" -eq "1" ]] 
  then
  printf "Reconstructing with SAVAGE\n\n"
  mkdir savage
  cd savage
  cp ../B19.fa .
  
  for dataset in "${DATASETS[@]}"
    do
    cp ../${dataset}_1.fq .
    cp ../${dataset}_2.fq .
    savage --split 500 -p1 /home/lx/Desktop/HVRS-main/src/savage/${dataset}_1.fq -p2 /home/lx/Desktop/HVRS-main/src/savage/${dataset}_2.fq --ref /home/lx/Desktop/HVRS-main/src/savage/B19-2.fa
  done
  cd ..
fi

#qsdpr - missing vcf file
if [[ "$RUN_QSDPR" -eq "1" ]] 
  then
  printf "Reconstructing with QSdpr\n\n"
  cd QSdpR_v3.2/
  for dataset in "${DATASETS[@]}"
    do
    cp ../${dataset}.fa ../${dataset}_.sam ../${dataset}_1.fq ../${dataset}_2.fq QSdpR_data
    chmod +x ./QSdpR_source/QSdpR_master.sh
    cd QSdpR_data/
    ../QSdpR_source/QSdpR_master.sh 2 8 QSdpR_source QSdpR_data sample 1 1000 SAMTOOLS
  done
  cd ../
fi

#qure - Runs with exception at the end of execution
if [[ "$RUN_QURE" -eq "1" ]] 
  then
  printf "Reconstructing with QuRe\n\n"
  cd QuRe_v0.99971/
  for dataset in "${DATASETS[@]}"
    do
    java -Xmx7G QuRe ../${dataset}.fa ../B19.fa 1E-25 1E-25 1000
  done
  cd ..
fi

#virus-vg - not working
if [[ "$RUN_VIRUSVG" -eq "1" ]] 
  then
  printf "Reconstructing with Virus-VG\n\n"
  for dataset in "${DATASETS[@]}"
    do
    python jbaaijens-virus-vg-69a05f3e74f2/scripts/build_graph_msga.py -f ${dataset}_1.fq -r ${dataset}_2.fq -c ${dataset}.fa -vg vg -t 2
  done
fi

#vg-flow - not working
if [[ "$RUN_VGFLOW" -eq "1" ]] 
  then
  printf "Reconstructing with VG-Flow\n\n"
  for dataset in "${DATASETS[@]}"
    do
    python jbaaijens-vg-flow-ac68093bbb23/scripts/build_graph_msga.py -f ${dataset}_1.fq -r ${dataset}_2.fq -c ${dataset}.fa -vg pwd -t 2
  done
fi

#tracespipelite - runs
if [[ "$RUN_TRACESPIPELITE" -eq "1" ]] 
  then
  printf "Reconstructing with TracePipeLite\n\n"
  cd TRACESPipeLite/src/  
  for dataset in "${DATASETS[@]}"
    do	
    cp ../../${dataset}_*.fq .
    lzma -d VDB.mfa.lzma
    ./TRACESPipeLite.sh --similarity 50 --threads 1 --reads1 ${dataset}_1.fq --reads2 ${dataset}_2.fq --database VDB.mfa --output test_viral_analysis_${dataset}
    done
  cd ../../
fi


#!/bin/bash
#
CREATE_RECONSTRUCTION_FOLDERS=0;
#RUN_SHORAH=0;
RUN_QURE=0;
RUN_SAVAGE=0;
RUN_QSDPR=1; #-
RUN_SPADES=0; #
RUN_METAVIRALSPADES=0;
RUN_CORONASPADES=0; #
RUN_VIADBG=0;
RUN_VIRUSVG=0;
RUN_VGFLOW=0;
RUN_PREDICTHAPLO=0;
RUN_TRACESPIPELITE=0; #
RUN_TRACESPIPE=0;
RUN_ASPIRE=0;
RUN_QVG=0; #
RUN_VPIPE=0;
RUN_STRAINLINE=0;
RUN_HAPHPIPE=0;
RUN_ABAYESQR=0;
RUN_HAPLOCLIQUE=0;
RUN_VISPA=0;
RUN_QUASIRECOMB=0;
RUN_LAZYPIPE=0; 
RUN_VIQUAS=0;
RUN_MLEHAPLO=0;
RUN_PEHAPLO=0;
RUN_REGRESSHAPLO=0;
RUN_CLIQUESNV=0; #
RUN_IVA=0;
RUN_PRICE=0;
RUN_VIRGENA=0; #
RUN_TARVIR=0;
RUN_VIP=0;
RUN_DRVM=0;
RUN_SSAKE=0; #
RUN_VIRALFLYE=0;
RUN_ENSEMBLEASSEMBLER=0;
RUN_HAPLOFLOW=0;
RUN_TENSQR=0;
RUN_ARAPANS=0;
RUN_VIQUF=0;

#declare -a DATASETS=("DS1");
declare -a DATASETS=("DS1" "DS2" "DS3");
declare -a VIRUSES=( "VZV" );
#declare -a VIRUSES=("B19" "HPV" "VZV");

#Creates a folder for each dataset
if [[ "$CREATE_RECONSTRUCTION_FOLDERS" -eq "1" ]] 
  then  
  rm -rf reconstructed
  mkdir reconstructed
  cd reconstructed
  for dataset in "${DATASETS[@]}"
  do
    mkdir $dataset  
  done
fi

#create bam files from sam files
create_bam_files () { 
  printf "Creating .bam files from .sam files\n\n"
  for dataset in "${DATASETS[@]}"
  do	
    cd samtools-1.16.1/
    ./samtools view -bS ../${dataset}_.sam > ../${dataset}.bam
    cd ..
  done
}

#create fasta files from sam files
create_fa_from_sam_files () { 
  printf "Creating fasta files from .sam files\n\n"
  for dataset in "${DATASETS[@]}"
  do	
    cd samtools-1.16.1/
    ./samtools fasta ../${dataset}_.sam > ../gen_${dataset}.fasta 
    cd ..
  done
}

#shorah
#if [[ "$RUN_SHORAH" -eq "1" ]] 
#  then
#  printf "Reconstructing with Shorah\n\n"
#  create_bam_files
#  for dataset in "${DATASETS[@]}"
#    do	
#    shorah.py -b ${dataset}.bam -f HPV-1.fa
#  done
#fi

#spades - working; stats.
if [[ "$RUN_SPADES" -eq "1" ]] 
  then
  printf "Reconstructing with SPAdes\n\n"
  eval "$(conda shell.bash hook)"
  conda activate spades
  for dataset in "${DATASETS[@]}"
    do
    rm -rf spades_${dataset}
    mkdir spades_${dataset}	
    cp ${dataset}_1.fq spades_${dataset}
    cp ${dataset}_2.fq spades_${dataset}
    /bin/time -f "TIME\t%e\nMEM\t%M\nCPU_perc\t%P" -o spades-${dataset}-time.txt spades.py -o spades_${dataset} -1 spades_${dataset}/${dataset}_1.fq -2 spades_${dataset}/${dataset}_2.fq #\
    
    mv spades-${dataset}-time.txt reconstructed/$dataset
    mv spades_${dataset}/scaffolds.fasta spades_${dataset}/spades-${dataset}.fa
    #mv spades_${dataset}/contigs.fasta spades_${dataset}/spades-${dataset}.fa
    cp spades_${dataset}/spades-${dataset}.fa reconstructed/$dataset
  done
  conda activate base
fi

#metaviralspades - runs, No complete extrachromosomal contigs assembled!!
if [[ "$RUN_METAVIRALSPADES" -eq "1" ]] 
  then
  printf "Reconstructing with metaviralSPAdes\n\n"
  #cd SPAdes-3.15.5-Linux/bin/
  eval "$(conda shell.bash hook)"
  conda activate spades
  for dataset in "${DATASETS[@]}"
    do
    rm -rf metaviralspades_${dataset}
    mkdir metaviralspades_${dataset}	
    cp ${dataset}_1.fq metaviralspades_${dataset}
    cp ${dataset}_2.fq metaviralspades_${dataset}
    /bin/time -f "TIME\t%e\nMEM\t%M\nCPU_perc\t%P" -o metaviralspades-${dataset}-time.txt metaviralspades.py -t 1 -o metaviralspades_${dataset} -1 metaviralspades_${dataset}/${dataset}_1.fq -2 metaviralspades_${dataset}/${dataset}_2.fq
  done
  conda activate base
fi

#coronaspades - working
if [[ "$RUN_CORONASPADES" -eq "1" ]] 
  then
  printf "Reconstructing with coronaSPAdes\n\n"
  eval "$(conda shell.bash hook)"
  conda activate spades
  for dataset in "${DATASETS[@]}"
    do
    rm -rf coronaspades_${dataset}
    mkdir coronaspades_${dataset}	
    cp ${dataset}_1.fq coronaspades_${dataset}
    cp ${dataset}_2.fq coronaspades_${dataset}
    /bin/time -f "TIME\t%e\nMEM\t%M\nCPU_perc\t%P" -o coronaspades-${dataset}-time.txt coronaspades.py -o coronaspades_${dataset} -1 coronaspades_${dataset}/${dataset}_1.fq -2 coronaspades_${dataset}/${dataset}_2.fq
    mv coronaspades-${dataset}-time.txt reconstructed/$dataset
    mv coronaspades_${dataset}/raw_scaffolds.fasta coronaspades_${dataset}/coronaspades-${dataset}.fa
    cp coronaspades_${dataset}/coronaspades-${dataset}.fa reconstructed/$dataset
  done
  conda activate base
fi

#viaDBG - err - ./bin/viaDBG: error while loading shared libraries: libboost_system.so.1.60.0: cannot open shared object file: No such file or directory
if [[ "$RUN_VIADBG" -eq "1" ]] 
  then
  printf "Reconstructing with viaDBG\n\n"
  #cd viadbg/
  for dataset in "${DATASETS[@]}"
    do
    
    rm -rf viadbg_${dataset}
    mkdir viadbg_${dataset}	    
    cp ${dataset}_*.fq viadbg_${dataset}
    
    rm -rf viadbg_output_${dataset} 
    mkdir viadbg_output_${dataset}
    
    cd viadbg/
    
    
    ./bin/viaDBG -p ../viadbg_${dataset} -o ../viadbg_output_${dataset}
    
    cd ..
  
     
    
    #cd viadbg_docker
    #rm -rf viadbg_${dataset}
    #mkdir viadbg_${dataset}	
    #cp ${dataset}_*.fq viadbg_${dataset}
    #cd ..
    #/bin/time -f "TIME\t%e\tMEM\t%M\tCPU_perc\t%P" sudo docker run -d viadbg_docker
    
  done
  
  
fi

#savage - Runs, w/ ref ->no reads could be aligned to reference error
#no ref - empty results
if [[ "$RUN_SAVAGE" -eq "1" ]] 
  then
  printf "Reconstructing with SAVAGE\n\n"
  eval "$(conda shell.bash hook)"
  conda activate savage
  rm -rf savage
  mkdir savage
  cd savage
  cp ../B19.fa .
  
  for dataset in "${DATASETS[@]}"
    do
    cp ../${dataset}_1.fq ../${dataset}_2.fq .
    /bin/time -f "TIME\t%e\tMEM\t%M\tCPU_perc\t%P" savage --split 500 -p1 ${dataset}_1.fq -p2 ${dataset}_2.fq #--ref $(pwd)/B19.fa
  done
  cd ..
  conda activate base
fi

#qsdpr - working
if [[ "$RUN_QSDPR" -eq "1" ]] 
  then
  printf "Reconstructing with QSdpr\n\n"
  eval "$(conda shell.bash hook)"
  conda activate qsdpr
  cd QSdpR_v3.2/
  for dataset in "${DATASETS[@]}"
    do
    rm -rf QSdpR_data/${dataset}
    mkdir QSdpR_data/${dataset}
    cp ../${dataset}.fa ../${dataset}_.sam ../${dataset}_1.fq ../${dataset}_2.fq QSdpR_data/${dataset}
    chmod +x ./QSdpR_source/QSdpR_master.sh
    cd QSdpR_data/

    /bin/time -f "TIME\t%e\tMEM\t%M\tCPU_perc\t%P" -o qsdpr-${dataset}-time.txt ../QSdpR_source/QSdpR_master.sh 2 10 ../QSdpR_source ../QSdpR_data sample 1 1000 ../../samtools-1.16.1
    
    mv qsdpr-${dataset}-time.txt ../../reconstructed/$dataset
    mv sample_10_recon.fasta qsdpr_$dataset.fa
    cp qsdpr_$dataset.fa ../../reconstructed/$dataset
    cd ..
  done
  cd ../
  python --version
  conda activate base
fi

#qure - Runs with exception - Exception in thread "main" java.lang.ArrayIndexOutOfBoundsException: 0 at ReadSet.estimateBaseSet(ReadSet.java:243)
if [[ "$RUN_QURE" -eq "1" ]] 
  then
  printf "Reconstructing with QuRe\n\n"
  cd QuRe_v0.99971/
  for dataset in "${DATASETS[@]}"
    do
    for virus in "${VIRUSES[@]}"
    do
    cp ../${dataset}.fa ../$virus.fa .
    /bin/time -f "TIME\t%e\tMEM\t%M\tCPU_perc\t%P" java QuRe ${dataset}.fa $virus.fa 1E-25 1E-25 1000
    done
  done
  cd ..
fi

#virus-vg - err; Subcommand 'msga' is deprecated and is no longer being actively maintained. Future releases may eliminate it entirely.
#error: could not parse i from argument "-a"
if [[ "$RUN_VIRUSVG" -eq "1" ]] 
  then
  printf "Reconstructing with Virus-VG\n\n"
  eval "$(conda shell.bash hook)"
  conda activate virus-vg-deps
  chmod +x jbaaijens-virus-vg-69a05f3e74f2/scripts/build_graph_msga.py
  for dataset in "${DATASETS[@]}"
    do
    rm -rf samples_virusvg
    mkdir samples_virusvg
    cp ${dataset}_*.fq ${dataset}.fa samples_virusvg
    cd jbaaijens-virus-vg-69a05f3e74f2
    /bin/time -f "TIME\t%e\tMEM\t%M\tCPU_perc\t%P" scripts/build_graph_msga.py -f ../samples_virusvg/${dataset}_1.fq -r ../samples_virusvg/${dataset}_2.fq -c ../samples_virusvg/${dataset}.fa -vg ./vg -t 2
    
    #/bin/time -f "TIME\t%e\tMEM\t%M\tCPU_perc\t%P" python scripts/optimize_strains.py -m 1 -c 2 node_abundance.txt contig_graph.final.gfa
    cd ..
  done
  conda activate base
fi

#vg-flow - err - deprecated msga; vg crashed
if [[ "$RUN_VGFLOW" -eq "1" ]] 
  then
  printf "Reconstructing with VG-Flow\n\n"
  eval "$(conda shell.bash hook)"
  conda activate vg-flow-env
  chmod +x jbaaijens-vg-flow-ac68093bbb23/scripts/build_graph_msga.py
  cd jbaaijens-vg-flow-ac68093bbb23/
  for dataset in "${DATASETS[@]}"
    do
    rm -rf samples_vgflow
    mkdir samples_vgflow
    cp ../${dataset}_1.fq ../${dataset}_2.fq ../${dataset}.fa samples_vgflow
    cd samples_vgflow
    /bin/time -f "TIME\t%e\tMEM\t%M\tCPU_perc\t%P" python ../scripts/build_graph_msga.py -f ${dataset}_1.fq -r ${dataset}_2.fq -c ${dataset}.fa -vg .././vg -t 2
    
    #example
    #cd example
    #python ../scripts/build_graph_msga.py -f forward.fastq -r reverse.fastq -c input.fasta -vg .././vg -t 2
    python ../scripts/vg-flow.py -m 1 -c 2 node_abundance.txt contig_graph.final.gfa
    
    #cd jbaaijens-vg-flow-ac68093bbb23/
    #/bin/time -f "TIME\t%e\tMEM\t%M\tCPU_perc\t%P" scripts/build_graph_msga.py -f ../samples_vgflow/${dataset}_1.fq -r ../samples_vgflow/${dataset}_2.fq -c ../samples_vgflow/${dataset}.fa -vg ./vg -t 2
    cd ..
  done
  conda activate base
fi

#PredictHaplo - runs; can't detect reads on the .sam file
if [[ "$RUN_PREDICTHAPLO" -eq "1" ]] 
  then
  printf "Reconstructing with PredictHaplo\n\n"
  eval "$(conda shell.bash hook)"  
  conda activate predicthaplo
  rm -rf predicthaplo_data
  mkdir predicthaplo_data
  cd predicthaplo_data
  for dataset in "${DATASETS[@]}"
  do
    cp ../${dataset}_.sam . 
    for virus in "${VIRUSES[@]}"
    do        
      cp ../$virus.fa .    
      /bin/time -f "TIME\t%e\tMEM\t%M\tCPU_perc\t%P" predicthaplo --sam ${dataset}_.sam --reference $virus.fa       
    done  
  done
  cd ..
  conda activate base
  
fi

#tracespipelite - working
if [[ "$RUN_TRACESPIPELITE" -eq "1" ]] 
  then
  printf "Reconstructing with TRACESPipeLite\n\n"
  eval "$(conda shell.bash hook)"  
  conda activate tracespipelite
  cd TRACESPipeLite/src/  
  for dataset in "${DATASETS[@]}"
  do	
    cp ../../${dataset}_*.fq .
    lzma -d VDB.mfa.lzma
    /bin/time -f "TIME\t%e\nMEM\t%M\nCPU_perc\t%P" -o tracespipelite-${dataset}-time.txt ./TRACESPipeLite.sh --similarity 50 --threads 1 --reads1 ${dataset}_1.fq --reads2 ${dataset}_2.fq --database VDB.mfa --output test_viral_analysis_${dataset}
    
    
    cd test_viral_analysis_${dataset}
    for virus in "${VIRUSES[@]}"
    do
      printf "copying $virus\n\n"
      cd $virus*   
      cp *-consensus.fa ../../
      cd .. 
    done
    cd ..
    cat *-consensus.fa > tracespipelite-$dataset.fa
    mv tracespipelite-${dataset}-time.txt ../../reconstructed/$dataset
    cp tracespipelite-$dataset.fa ../../reconstructed/$dataset
  done  
  cd ../../
  conda activate base
fi

#tracespipe - efetch error
if [[ "$RUN_TRACESPIPE" -eq "1" ]] 
  then
  printf "Reconstructing with TRACESPipe\n\n"
  eval "$(conda shell.bash hook)"
  conda activate tracespipe
  cd tracespipe/
  for dataset in "${DATASETS[@]}"
    do	
    cd input_data/
    cp ../../${dataset}_*.fq .
    rm -rf *.fq.gz
    gzip *.fq
    cd ../meta_data/
    echo "x:${dataset}_1.fq.gz:${dataset}_2.fq.gz" > meta_info.txt
    cd ../src/
    /bin/time -f "TIME\t%e\tMEM\t%M\tCPU_perc\t%P" ./TRACESPipe.sh --run-meta --run-all-v-alig --remove-dup --min-similarity 3 --best-of-bests
    cd ..
    done
  cd ..   
  conda activate base  
fi

#ASPIRE - Can't locate App/Cmd/Setup.pm, tried installing one of the missing dependencies (Sub::Exporter), was not sucessfull, tried installing one of the missing dependencies for it (Test::LeakTrace) and it failed installation.
if [[ "$RUN_ASPIRE" -eq "1" ]] 
  then
  printf "Reconstructing with ASPIRE\n\n"
  cd aspire
  /bin/time -f "TIME\t%e\tMEM\t%M\tCPU_perc\t%P" ./aspire
  cd ..
fi

#QVG - working
if [[ "$RUN_QVG" -eq "1" ]] 
  then
  printf "Reconstructing with QVG\n\n"
  eval "$(conda shell.bash hook)"
  conda activate qvg-env
  cd QVG
  rm -rf reconstruction_files
  mkdir reconstruction_files
  rm -rf *.fa*
  for dataset in "${DATASETS[@]}"
    do	 
    for virus in "${VIRUSES[@]}"
      do
      #rm -rf ${dataset}_files
      mkdir ${dataset}_files
      echo "${dataset}" > ${dataset}_files/samples
      cd ${dataset}_files
      rm -rf output
      mkdir output
      cp ../../${dataset}_*.fq .
      gzip -cvf ${dataset}_1.fq > ${dataset}_R1.fastq.gz
      gzip -cvf ${dataset}_2.fq > ${dataset}_R2.fastq.gz
      cd ..
      cp ../${virus}.fa reconstruction_files
      /bin/time -f "TIME\t%e\nMEM\t%M\nCPU_perc\t%P" -o qvg-${dataset}-time.txt ./QVG.sh -r ./reconstruction_files/${virus}.fa -samples-list ./${dataset}_files/samples -s ./${dataset}_files -o ./${dataset}_files/output -annot yes
      rm -rf ${dataset}_files/output/samples_multifasta_masked*
      cat ${dataset}_files/output/samples_multifasta_* > ${dataset}_files/output/qvg-${virus}-${dataset}.fasta      
      cp ${dataset}_files/output/qvg-${virus}-${dataset}.fasta .
    done
    cat *.fasta > qvg-${dataset}.fa
    rm -rf *.fasta
    mv qvg-${dataset}-time.txt ../reconstructed/$dataset
    cp qvg-${dataset}.fa ../reconstructed/$dataset 
  done
  
  conda activate base 
fi

#V-pipe - Failed to open source file https://raw.githubusercontent.com/cbg-ethz/V-pipe/master/workflow/rules/scripts/functions.sh
if [[ "$RUN_VPIPE" -eq "1" ]]
  then
  printf "Reconstructing with V-pipe\n\n"
  eval "$(conda shell.bash hook)"
  conda activate vpipe 
  #cd V-pipe-2.99.3
  
  
    
  for dataset in "${DATASETS[@]}"
    do 
    
    for virus in "${VIRUSES[@]}"
    do  
    #cd config
    rm -rf samples
    mkdir samples
    cd samples
    
    mkdir ${dataset}
    cd ${dataset}
    mkdir ${dataset}_2
    cd ${dataset}_2 
    mkdir raw_data
    cd raw_data 
    cp ../../../../${dataset}_*.fq .    
    cd ../../../../
    
    rm -rf resources
    mkdir resources
    cd resources
    mkdir $virus
    cd $virus
    cp ../../$virus.fa .
    cd ../../
    
    
    echo "input:
  datadir: samples
  samples_file: config/samples.tsv
  reference: resources/$virus/$virus.fa

output:
  datadir: results
  snv: true
  local: true
  global: false
  visualization: true
  QA: true" > config/config.yaml 
    
    
    
    
    snakemake --use-conda --jobs 4 --printshellcmds --dry-run
    
    # edit config.yaml and provide samples/ directory
    #sudo docker run --rm -it -v $PWD:/work ghcr.io/cbg-ethz/v-pipe:master --jobs 4 --printshellcmds --dry-run
    #/bin/time -f "TIME\t%e\tMEM\t%M\tCPU_perc\t%P" ./vpipe --cores 1
    
   done
  done
  conda activate base
  cd ..
fi

#Strainline - missing reads*.las, example fails execution as well
if [[ "$RUN_STRAINLINE" -eq "1" ]] 
  then
  printf "Reconstructing with Strainline\n\n"
  create_fa_from_sam_files
  eval "$(conda shell.bash hook)"
  conda activate strainline
  cd Strainline/src/
  rm -rf out/tmp/
  chmod +x ./strainline.sh
  cd ..
  for dataset in "${DATASETS[@]}"
    do
    rm -rf ${dataset}
    mkdir ${dataset} 
    cd ${dataset}    
    cp ../../gen_${dataset}.fasta .
    
    ../src/strainline.sh -i gen_${dataset}.fasta -o out -p ont -k 20 -t 32
    
    
    #./strainline.sh -i ../../${dataset}*.fa -o out -p ont
    #/bin/time -f "TIME\t%e\tMEM\t%M\tCPU_perc\t%P" ../src/strainline.sh -i ${dataset}_test.fa -o ${dataset} -p ont -k 20 -t 32
    
    #example
    #cd ../example/
    #rm -rf out
    #../src/strainline.sh -i reads.fa -o out -p pb -k 20 -t 32
    
    cd ..
    done
  cd ../
  conda activate base
  
  
fi

#HAPHPIPE - pipeline fails on stage ec_reads
if [[ "$RUN_HAPHPIPE" -eq "1" ]] 
  then
  printf "Reconstructing with HAPHPIPE\n\n"
  eval "$(conda shell.bash hook)"
  conda activate haphpipe
  
  rm -rf haphpipe_data
  mkdir haphpipe_data
  cd haphpipe_data
   
  for dataset in "${DATASETS[@]}"
    do
    
    for virus in "${VIRUSES[@]}"
    do   
      cp ../${dataset}_*.fq .
      cp ../$virus.fa .
      echo "" > empty.gtf
    
      rm -rf denovo_assembly_${dataset}_$virus
      mkdir denovo_assembly_${dataset}_$virus
    
      #/bin/time -f "TIME\t%e\tMEM\t%M\tCPU_perc\t%P" haphpipe assemble_denovo --fq1 ${dataset}_1.fq --fq2 ${dataset}_2.fq --outdir denovo_assembly_${dataset} --meta #--no_error_correction TRUE
      #haphpipe_assemble_01 ${dataset}_1.fq ${dataset}_1.fq $virus.fa empty.gtf $virus.fa denovo_assembly_${dataset}_$virus
      /bin/time -f "TIME\t%e\tMEM\t%M\tCPU_perc\t%P" haphpipe_assemble_02 ${dataset}_1.fq ${dataset}_2.fq $virus.fa $virus #denovo_assembly_${dataset}_$virus
      done
    done
  cd ..
  conda activate base 
fi

#aBayesQR - running; doesn't output results
if [[ "$RUN_ABAYESQR" -eq "1" ]] 
  then
  printf "Reconstructing with aBayesQR\n\n"
  cd aBayesQR 
  for dataset in "${DATASETS[@]}"
    do
    
    for virus in "${VIRUSES[@]}"
    do
    
      #cp ${dataset}_*.fq .
      cp ../$virus.fa ../${dataset}_.sam .
      rm -rf config_${dataset}
      echo "filename of reference sequence (FASTA) : ${virus}.fa
filname of the aligned reads (sam format) : ${dataset}_.sam
paired-end (1 = true, 0 = false) : 1
SNV_thres : 0.01
reconstruction_start : 1
reconstruction_stop: 10000
min_mapping_qual : 60
min_read_length : 10
max_insert_length : 250
characteristic zone name : test
seq_err (assumed sequencing error rate(%)) : 0.1
MEC improvement threshold : 0.0395 " >> config_${dataset}
      /bin/time -f "TIME\t%e\tMEM\t%M\tCPU_perc\t%P" ./aBayesQR config_${dataset}
      done
    done
  cd ..
    
fi

#HaploClique - No reads could be retrieved from the BamFile.
if [[ "$RUN_HAPLOCLIQUE" -eq "1" ]] 
  then
  printf "Reconstructing with HaploClique\n\n"
  eval "$(conda shell.bash hook)"
  conda activate haploclique  
  create_bam_files

  rm -rf haploclique_data
  mkdir haploclique_data
  cd haploclique_data
  for dataset in "${DATASETS[@]}"
    do
    cp ../$dataset.bam .
    /bin/time -f "TIME\t%e\tMEM\t%M\tCPU_perc\t%P" haploclique $dataset.bam 
  done
  cd ..
  conda activate base

fi

#ViSpA - runs; result files *_EM.txt are empty
if [[ "$RUN_VISPA" -eq "1" ]] 
  then
  printf "Reconstructing with ViSpA\n\n"  
  eval "$(conda shell.bash hook)"
  conda activate vispa  
  cd home
  rm -rf test
  mkdir test
  #touch test/log.txt 
  cd code/vispa_mosaik   
  for dataset in "${DATASETS[@]}"
    do	
    cp ../../../${dataset}.fa ../../test
    cp ../../../${dataset}.bam ../../test
    for virus in "${VIRUSES[@]}"
    do
      cp ../../../$virus.fa ../../test 
     
      echo "" >> ../../test/${dataset}.txt
    
      /bin/time -f "TIME\t%e\tMEM\t%M\tCPU_perc\t%P" ./main_mosaik.bash ../../test/${dataset}.fa ../../test/$virus.fa 2 100 120
      done
    done    
    conda activate base  
fi

#QuasiRecomb -> ParsingException in thread "main" java.lang.reflect.InvocationTargetException
#Caused by: net.sf.samtools.SAMException: No index is available for this BAM file.
if [[ "$RUN_QUASIRECOMB" -eq "1" ]] 
  then
  printf "Reconstructing with QuasiRecomb\n\n"
  eval "$(conda shell.bash hook)"
  conda activate quasirecomb
  #cd QuasiRecomb-1.2
  for dataset in "${DATASETS[@]}"
    do
    #cp ../${dataset}_.sam .
    #java -jar QuasiRecomb.jar -i ${dataset}_.sam
    #/bin/time -f "TIME\t%e\tMEM\t%M\tCPU_perc\t%P" java -jar QuasiRecomb.jar -i ${dataset}_.sam -coverage
    java -XX:+UseParallelGC -Xms2g -Xmx8g -XX:+UseNUMA -XX:NewRatio=9 -jar QuasiRecomb.jar -i $dataset.bam

    done
  conda activate base
fi

#Lazypipe 
if [[ "$RUN_LAZYPIPE" -eq "1" ]] 
  then
  printf "Reconstructing with Lazypipe\n\n"
  #timer
  #/bin/time -f "TIME\t%e\tMEM\t%M\tCPU_perc\t%P"
  
fi

#ViQuaS - err - [0] smalt.c:1116 ERROR: could not open file cut: alnc.sam: No such file or directory, may be caused by lack of Bio::Seq module, which couldn't be installed
if [[ "$RUN_VIQUAS" -eq "1" ]] 
  then
  printf "Reconstructing with ViQuaS\n\n"
  create_bam_files
  eval "$(conda shell.bash hook)"
  conda activate viquas
  cd ViQuaS1.3  
  for dataset in "${DATASETS[@]}"
    do 
        
    for virus in "${VIRUSES[@]}"
    do       
      cp ../${dataset}.bam .  
      cp ../${virus}.fa .
      /bin/time -f "TIME\t%e\tMEM\t%M\tCPU_perc\t%P" Rscript ViQuaS.R ${virus}.fa $dataset.bam 1 1 1 20 
      
      #example
      #Rscript ViQuaS.R reference.fsa sample_reads.bam
    
    done
  done
  conda activate base  
  cd ..  
fi

#MLEHaplo - constructs graphs with 0 vertices and 0 edges, illegal division by 0
if [[ "$RUN_MLEHAPLO" -eq "1" ]] 
  then
  printf "Reconstructing with MLEHaplo\n\n"  
  #timer
  #/bin/time -f "TIME\t%e\tMEM\t%M\tCPU_perc\t%P"
  create_fa_from_sam_file
  eval "$(conda shell.bash hook)"
  conda activate mlehaplo
  cd MLEHaplo-0.4.1  
  for dataset in "${DATASETS[@]}"
    do
    rm -rf ${dataset}
    mkdir ${dataset}
    cd ${dataset}
    echo ${dataset}"_1.fq
"${dataset}"_2.fq" > files_${dataset}.txt
    echo "55
45
35
25" > listofkmers.txt
    cp ../../gen_${dataset}.fasta .
    mv gen_${dataset}.fasta paired-reads.fasta
    cd ..   
    
    #example given
    #./multi-dsk/multi-dsk Example/paired-reads.fasta  Example/listofkmers.txt  -m 8192 -d 10000
    #./multi-dsk/parse_results Example/paired-reads.solid_kmers_binary.60 > paired-reads.60
    #perl construct_graph.pl  Example/paired-reads.fasta paired-reads.60 0 paired-reads.60.graph "s"
    #perl construct_paired_without_bloom.pl -fasta Example/paired-reads.fasta -kmerfile paired-reads.60 -thresh 0 -wr paired-reads.60.pk.txt
    #perl dg_cover.pl -graph paired-reads.60.graph -kmer paired-reads.60 -paired paired-reads.60.pk.txt -fact 15 -thresh 0 -IS 400 > paired-reads.60.fact15.txt
    #perl process_dg.pl paired-reads.60.fact15.txt > paired-reads.60.fact15.fasta
    #perl get_paths_dgcover.pl -f paired-reads.60.fact15.txt -w paired-reads.60.fact15.paths.txt
    #perl likelihood_singles_wrapper.pl -condgraph paired-reads.60.cond.graph -compset paired-reads.60.comp.txt -pathsfile paired-reads.60.fact15.paths.txt -back -gl 1200 -slow  > paired-reads.60.smxlik.txt
    #perl extract_MLE.pl -f paired-reads.60.fact15.fasta -l paired-reads.60.smxlik.txt > paired-reads.60.MLE.fasta
    
    #adaptation to the example given
    ./multi-dsk/multi-dsk ${dataset}/paired-reads.fasta  ${dataset}/listofkmers.txt  -m 8192 -d 10000
    ./multi-dsk/parse_results ${dataset}/paired-reads.solid_kmers_binary.60 > paired-reads.60
    perl construct_graph.pl  ${dataset}/paired-reads.fasta paired-reads.60 0 paired-reads.60.graph "s"
    perl construct_paired_without_bloom.pl -fasta ${dataset}/paired-reads.fasta -kmerfile paired-reads.60 -thresh 0 -wr paired-reads.60.pk.txt
    perl dg_cover.pl -graph paired-reads.60.graph -kmer paired-reads.60 -paired paired-reads.60.pk.txt -fact 15 -thresh 0 -IS 400 > paired-reads.60.fact15.txt
    perl process_dg.pl paired-reads.60.fact15.txt > paired-reads.60.fact15.fasta
    perl get_paths_dgcover.pl -f paired-reads.60.fact15.txt -w paired-reads.60.fact15.paths.txt
    perl likelihood_singles_wrapper.pl -condgraph paired-reads.60.cond.graph -compset paired-reads.60.comp.txt -pathsfile paired-reads.60.fact15.paths.txt -back -gl 1200 -slow  > paired-reads.60.smxlik.txt
    perl extract_MLE.pl -f paired-reads.60.fact15.fasta -l paired-reads.60.smxlik.txt > paired-reads.60.MLE.fasta   
  
  done
  conda activate base 
fi

#PEHaplo - err - subprocess.CalledProcessError: Command 'gt readjoiner overlap -readset samp -memlimit 2GB -l 180' returned non-zero exit status 1 , working with test example
if [[ "$RUN_PEHAPLO" -eq "1" ]] 
  then
  printf "Reconstructing with PEHaplo\n\n"
  eval "$(conda shell.bash hook)"
  conda activate bio2
  cd TAR-VIR/PEHaplo/  
  
  for dataset in "${DATASETS[@]}"
    do	
    
    for virus in "${VIRUSES[@]}"
    do
    
      rm -rf data
      mkdir data
      cd data
    
      cp ../../../${virus}.fa .
      cp ../../../gen_${dataset}.fasta .
    
      mkdir index
      bowtie2-build -f ${virus}.fa index/HXB2
      bowtie2 -x index/HXB2 -f gen_${dataset}.fasta --score-min L,0,-0.05 -t -p 4 -S result.sam
    
      cd ..
      build -f data/gen_${dataset}.fasta -o virus
      overlap -S data/result.sam -x virus -f data/gen_${dataset}.fasta -c 180 -o data/virus_recruit.fa
      
      rm -rf test
      mkdir test
      cd test
      
      printf "\n $(pwd)\n\n"
      
      python ../tools/get_read_pairs.py ../data/virus_recruit.fa
    
      python ../pehaplo.py -f1 pair1.fa -f2 pair2.fa -l 180 -l1 210 -r 250 -F 600 -std 150 -n 3 -correct yes
      
      cd ..
    done
  done
  conda activate base
  
fi

#RegressHaplo
if [[ "$RUN_REGRESSHAPLO" -eq "1" ]] 
  then
  printf "Reconstructing with RegressHaplo\n\n"
  
  #timer
  #/bin/time -f "TIME\t%e\tMEM\t%M\tCPU_perc\t%P"
  
fi

#CliqueSNV - working
if [[ "$RUN_CLIQUESNV" -eq "1" ]] 
  then
  printf "Reconstructing with CliqueSNV\n\n"
  cd CliqueSNV-2.0.3
  for dataset in "${DATASETS[@]}"
    do
    cp ../${dataset}_.sam .
    /bin/time -f "TIME\t%e\nMEM\t%M\nCPU_perc\t%P" -o cliquesnv-${dataset}-time.txt java -jar clique-snv.jar -m snv-illumina -in ${dataset}_.sam -outDir $(pwd)
    cp ${dataset}_.fasta cliquesnv-${dataset}.fa
    mv cliquesnv-${dataset}-time.txt ../reconstructed/$dataset
    cp cliquesnv-${dataset}.fa ../reconstructed/${dataset}
    done
  cd ..  
fi

#IVA - err - Failed to make first seed. Cannot continue
if [[ "$RUN_IVA" -eq "1" ]] 
  then
  printf "Reconstructing with IVA\n\n"
  #iva --test outdir
  rm -rf iva_data
  mkdir iva_data
  for dataset in "${DATASETS[@]}"
    do    
    cp ${dataset}_*.fq iva_data
    sudo rm -rf ${dataset}_Output_directory 
    /bin/time -f "TIME\t%e\tMEM\t%M\tCPU_perc\t%P" sudo docker run --rm -it -v $(pwd):/iva_data sangerpathogens/iva iva -f /iva_data/${dataset}_1.fq -r /iva_data/${dataset}_2.fq /iva_data/${dataset}_Output_directory    
  done
fi

#PRICE - did nothing, no errors
if [[ "$RUN_PRICE" -eq "1" ]] 
  then
  printf "Reconstructing with PRICE\n\n"
  cd PriceSource130506
  for dataset in "${DATASETS[@]}"
    do
    cp ../${dataset}_*.fq .    
    /bin/time -f "TIME\t%e\tMEM\t%M\tCPU_perc\t%P" ./PriceTI -a 8 -fp ${dataset}_1.fq ${dataset}_2.fq 150 -nc 1 -o result_${dataset}.fasta
    done
  cd ..  
fi

#VirGenA 
if [[ "$RUN_VIRGENA" -eq "1" ]] 
  then
  printf "Reconstructing with VirGenA\n\n"
  cd release_v1.4
  chmod +x ./tools/vsearch
  for dataset in "${DATASETS[@]}"
    do
    
    for virus in "${VIRUSES[@]}"
    do
      rm -rf ${dataset}_*.fq
      rm -rf ${virus}.fa
      rm -rf *.gz
      
      cp ../${dataset}_*.fq .
      cp ../${virus}.fa .
    
      gzip *.fq
      
      #rm -rf $dataset-$virus 
      #mkdir $dataset-$virus
    
      echo "<config>
    <Data>
        <pathToReads1>${dataset}_1.fq.gz</pathToReads1>
        <pathToReads2>${dataset}_2.fq.gz</pathToReads2>
        <InsertionLength>1000</InsertionLength>
    </Data>
    <Reference>${virus}.fa</Reference>
    <OutPath>./res/$dataset-$virus</OutPath>
    <ThreadNumber>-1</ThreadNumber>
	<BatchSize>1000</BatchSize>
    <ReferenceSelector>
		<Enabled>true</Enabled>
        <UseMajor>false</UseMajor>
        <ReferenceMSA>./data/HIV_RefSet_msa.fasta</ReferenceMSA>
        <PathToVsearch>./tools/vsearch</PathToVsearch>
        <UclustIdentity>0.95</UclustIdentity>
        <MinReadLength>50</MinReadLength>
        <MinContigLength>1000</MinContigLength>
        <Delta>0.05</Delta>
		<MaxNongreedyComponentNumber>5</MaxNongreedyComponentNumber>
        <MapperToMSA>
			<K>7</K>
			<IndelToleranceThreshold>1.5</IndelToleranceThreshold>
			<pValue>0.01</pValue>
			<RandomModelParameters>
				<Order>4</Order>
				<ReadNum>1000</ReadNum>
				<Step>10</Step>
			</RandomModelParameters>
        </MapperToMSA>
        <Graph>
            <MinReadNumber>5</MinReadNumber>
            <VertexWeight>10</VertexWeight>
			<SimilarityThreshold>0.5</SimilarityThreshold>
			<Debug>false</Debug>
        </Graph>
        <Debug>false</Debug>
    </ReferenceSelector>
    <Mapper>
		<K>5</K>
		<IndelToleranceThreshold>1.25</IndelToleranceThreshold>
        <pValue>0.01</pValue>
		<RandomModelParameters>
			<Order>4</Order>
			<ReadNum>1000</ReadNum>
			<Step>10</Step>
		</RandomModelParameters>
        <Aligner>
            <Match>2</Match>
            <Mismatch>-3</Mismatch>
            <GapOpenPenalty>5</GapOpenPenalty>
            <GapExtensionPenalty>2</GapExtensionPenalty>
        </Aligner>
    </Mapper>
    <ConsensusBuilder>
        <IdentityThreshold>0.9</IdentityThreshold>
        <CoverageThreshold>0</CoverageThreshold>
        <MinIntersectionLength>10</MinIntersectionLength>
        <MinTerminationReadsNumber>1</MinTerminationReadsNumber>
        <Reassembler>
            <IdentityThreshold>0.9</IdentityThreshold>
            <MinTerminatingSequenceCoverage>0</MinTerminatingSequenceCoverage>
            <PairReadTerminationThreshold>0.1</PairReadTerminationThreshold>
            <MinReadLength>50</MinReadLength>
        </Reassembler>
        <Debug>false</Debug>
    </ConsensusBuilder>
    <Postprocessor>
        <Enabled>true</Enabled>
        <MinFragmentLength>500</MinFragmentLength>
        <MinIdentity>0.99</MinIdentity>
		<MinFragmentCoverage>0.99</MinFragmentCoverage>
        <Debug>false</Debug>
    </Postprocessor>
</config>" > $dataset-conf.xml
      /bin/time -f "TIME\t%e\nMEM\t%M\nCPU_perc\t%P" -o virgena-${dataset}-time.txt java -jar VirGenA.jar assemble -c $dataset-conf.xml # config_test_linux.xml
    #java -jar VirGenA.jar map -c config.xml -r ../B19.fa -p1 ../DS1_1.fq -p2 ../DS1_2.fq
    done
    cd res
    cat *_complete_genome_assembly.fasta > virgena-$dataset.fa
    rm -rf *_complete_genome_assembly.fasta
    mv ../virgena-${dataset}-time.txt ../../reconstructed/$dataset
    cp virgena-$dataset.fa ../../reconstructed/$dataset 
    cd ..
    
  done
  cd ..
  
fi

#TAR-VIR - no errors but no seed reads, example runs and detects seed reads
#likely an error in the sam file format
if [[ "$RUN_TARVIR" -eq "1" ]] 
  then
  printf "Reconstructing with TAR-VIR\n\n"
  eval "$(conda shell.bash hook)"
  conda activate bio2
  
  #timer
  #/bin/time -f "TIME\t%e\tMEM\t%M\tCPU_perc\t%P"
  
  cd TAR-VIR/
  for dataset in "${DATASETS[@]}"
    do
    rm -rf data
    mkdir data
    cd Overlap_extension/
  
    cp ../../gen_${dataset}.fasta ../data
    cp ../../${dataset}_.sam ../data
    
    #example
    #./build -f test_data/virus.fa -o virus   
    #./overlap -S test_data/HIV.sam -x virus -f test_data/virus.fa -c 180 -o virus_recruit.fa 
    
    ./build -f ../data/gen_${dataset}.fasta -o virus
    ./overlap -S data/${dataset}_.sam -x virus -f ../data/gen_${dataset}.fasta -c 180 -o virus_recruit.fa
  done 
  
  cd ../../
  conda activate base
  
fi

#VIP - missing DBI module, can´t install it
if [[ "$RUN_VIP" -eq "1" ]] 
  then
  printf "Reconstructing with VIP\n\n"
  eval "$(conda shell.bash hook)"
  conda activate vip
  
  #timer
  #/bin/time -f "TIME\t%e\tMEM\t%M\tCPU_perc\t%P"
  
  cd VIP-master
  chmod +x ./VIP.sh
  
  for dataset in "${DATASETS[@]}"
    do
    
    for virus in "${VIRUSES[@]}"
    do
      rm -rf reconstruction
      mkdir reconstruction
      cd reconstruction
      rm -rf ${dataset}.fa.report
      cp ../../${dataset}_*.fq .
      cp ../../gen_${dataset}.fasta .
      cp ../../${virus}.fa .
      .././VIP.sh -z -i gen_${dataset}.fasta -p illumina -f fasta -r ${virus}.fa
      .././VIP.sh -c gen_DS1.fasta.conf -i gen_DS1.fasta
      cd ..
      
      done
    done
  cd ..
  conda activate base
fi

#drVM - err - Please check your snap DB location
if [[ "$RUN_DRVM" -eq "1" ]] 
  then
  printf "Reconstructing with drVM\n\n"

  cd Tools 
  for dataset in "${DATASETS[@]}"
    do
    cp ../${dataset}_*.fq .
    /bin/time -f "TIME\t%e\tMEM\t%M\tCPU_perc\t%P" ./drVM.py -1 ${dataset}_1.fq -2 ${dataset}_2.fq
  done
  cd ..
fi

#SSAKE - running
if [[ "$RUN_SSAKE" -eq "1" ]] 
  then
  printf "Reconstructing with SSAKE\n\n"
  cd ssake/tools/
  
  for dataset in "${DATASETS[@]}"
    do
    cp ../../${dataset}_*.fq .
    /bin/time -f "TIME\t%e\nMEM\t%M\nCPU_perc\t%P" -o ssake-${dataset}-time.txt ./runSSAKE.sh ${dataset}_1.fq ${dataset}_2.fq 10 ${dataset}_assembly
    
    mv ${dataset}_assembly_scaffolds.fa ssake-${dataset}.fa
    cp ssake-${dataset}.fa ../../reconstructed/${dataset}
    mv ssake-${dataset}-time.txt ../../reconstructed/$dataset
  done
  cd ../../

fi

#viralFlye - err can't find out dir, can't create out dir with flye - ERROR: No reads above minimum length threshold (1000)
if [[ "$RUN_VIRALFLYE" -eq "1" ]] 
  then
  printf "Reconstructing with viralFlye\n\n"
  eval "$(conda shell.bash hook)"
  conda activate viralFlye
  
  for dataset in "${DATASETS[@]}"
    do
    cd Flye/bin
    cp ../../${dataset}_*.fq . 
    rm -rf ../../viralFlye/out
    ./flye --nano-raw ${dataset}_1.fq ${dataset}_2.fq -o ../../viralFlye/out
    cd ../../
  
    cd viralFlye
    rm -rf flye_assembly_dir
    mkdir flye_assembly_dir 
    cd flye_assembly_dir 
    cp ../../${dataset}_*.fq .
    cd ..
    rm -rf output_dir
    mkdir output_dir
  
    /bin/time -f "TIME\t%e\tMEM\t%M\tCPU_perc\t%P" ./viralFlye.py --dir out --hmm ../Pfam-A.hmm.gz --reads flye_assembly_dir --outdir output_dir
    cd ..
  done
  conda activate base
fi

#EnsembleAssembler - no errors, doesn't output results
if [[ "$RUN_ENSEMBLEASSEMBLER" -eq "1" ]] 
  then
  printf "Reconstructing with EnsembleAssembler \n\n"
  #eval "$(conda shell.bash hook)"
  #conda activate ensembleAssembler
  cd ensembleAssembly_1

  for dataset in "${DATASETS[@]}"
    do
    rm -rf reconstruction
    mkdir reconstruction
    cd reconstruction    
    cp ../../${dataset}_*.fq
    echo "PE=260 30 $(pwd)/${dataset}_1.fq $(pwd)/${dataset}_2.fq
#SE=$(pwd)/${dataset}_2.fq
NUM_THREADS= 3
SOAP_KMER=31
ABYSS_KMER = 31
METAVELVET_KMER=31
CON_LEN_DBG=50
CON_LEN_OLC=50
ASSEMBLY_MODE=optimal
#ASSEMBLY_MODE=quick " > config.txt
    .././ensembleAssembly config.txt
    
    cd ..
    
    #chmod +x ./ensemble.sh
    #./ensemble.sh
    
  done
  cd ..
  #conda activate base 
  
fi

#Haploflow -working
if [[ "$RUN_HAPLOFLOW" -eq "1" ]] 
  then
  printf "Reconstructing with Haploflow\n\n"
  eval "$(conda shell.bash hook)"
  conda activate haploflow
  rm -rf haploflow_data
  mkdir haploflow_data
  cd haploflow_data
  for dataset in "${DATASETS[@]}"
    do
    cp ../${dataset}_1.fq .
    /bin/time -f "TIME\t%e\tMEM\t%M\tCPU_perc\t%P" haploflow --read-file ${dataset}_1.fq --out test --log test/log    
  done
  cd ..  
  conda activate base 
fi

#TenSQR - FileNotFoundError: no data contained in sample_SNV_matrix.txt
if [[ "$RUN_TENSQR" -eq "1" ]] 
  then
  printf "Reconstructing with TenSQR\n\n"
  cd TenSQR
  rm -rf reconstruction_data
  for dataset in "${DATASETS[@]}"
    do
    
    for virus in "${VIRUSES[@]}"
    do
    
    cp ../${dataset}_.sam .
    cp ../$virus.fa .
    echo "filename of reference sequence (FASTA) : "$virus.fa"
filname of the aligned reads (sam format) : "${dataset}_.sam"
SNV_thres : 0.0001
reconstruction_start : 500
reconstruction_stop: 1200
min_mapping_qual : 40
min_read_length : 50
max_insert_length : 500
characteristic zone name : zone
seq_err (assumed sequencing error rate(%)) : 0.2
MEC improvement threshold : 0.0312
initial population size : 5" >> config_${dataset}
    ./ExtractMatrix config_${dataset}
    /bin/time -f "TIME\t%e\tMEM\t%M\tCPU_perc\t%P" python3 TenSQR.py config_${dataset}  
    done
  done  
  cd ..
  
fi

#ViQUF - UnboundLocalError: local variable 'extension' referenced before assignment
if [[ "$RUN_VIQUF" -eq "1" ]] 
  then
  printf "Reconstructing with ViQUF\n\n"
  #eval "$(conda shell.bash hook)"
  #conda activate viquf
  
  
  cd viquf
  
  
  for dataset in "${DATASETS[@]}"
    do
    rm -rf $dataset
    mkdir $dataset
    cd $dataset     
    cp ../../${dataset}_*.fq .    
    cd ..
    
    /bin/time -f "TIME\t%e\tMEM\t%M\tCPU_perc\t%P" python scripts/testBcalm.py $dataset 4 10 ngs --no-correct --no-join --no-meta
    ./bin/output.out tmp 4 tmp/unitigs.graph tmp/unitigs.unitigs.fa tmp/unitigs-viadbg.fa tmp/Ownlatest/append.fasta --virus
    python scripts/post-process.py 
  done
  
  cd ..
  #conda activate base  
fi


 

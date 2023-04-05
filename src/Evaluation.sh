#!/bin/bash
#
declare -a DATASETS=("DS1" "DS2" "DS3" "DS4" "DS5" "DS6" "DS7" "DS8" "DS9" "DS10" "DS11" "DS12");
declare -a VIRUSES=("B19" "HPV" "VZV" "MT");
#
declare -a ANALYSIS=("tracespipelite" "spades" "metaspades" "metaviralspades" "coronaspades" "ssake" "tracespipe" "lazypipe" "pehaplo");
declare -a NO_ANALYSIS=("qvg" "qure" "vispa" "virgena");
#
declare -a CLASSIFICATION=("tracespipelite" "tracespipe" "lazypipe");
declare -a NO_CLASSIFICATION=("spades" "metaspades" "metaviralspades" "coronaspades" "ssake" "pehaplo" "qvg" "qure" "vispa" "virgena");
#
D_PATH="reconstructed";
#
cd $D_PATH
echo "Dataset	File	Time(s)	SNPs	AvgIdentity	NCD	NRC	Mem(GB)	%CPU	Nr contigs	Metagenomic_analysis	Metagenomic_classification" > total_stats.tsv
rm -rf total_stats.tex
for dataset in "${DATASETS[@]}" #analyse each virus
  do
  printf "$dataset\n";	  

  echo "
  
$dataset
  
" >> total_stats.tex

  for file in `cd ${dataset};ls -1 *.fa*` #for each fasta file in curr dir
  do 	 
    printf "\n\nFile: $file\nDataset: $dataset \n\n"; #print file name, virus and dataset	  
    #cp $dataset/$file G_A.fa; #reference
    #cp ../$dataset.fa G_B.fa #query
    #
    fst_char=$(cat $dataset/$file | head -c 1)
    if [[ -z "$fst_char" ]]; then
      printf "The result file is empty."    
    else
      dnadiff $dataset/$file ../$dataset.fa ; #run dnadiff
      #quast $dataset/$file -r ../$dataset.fa ; #run quast
      #mv quast_results/results_*_*_*_*_* quast_results/results_${dataset}_$file
      #
      IDEN=`cat out.report | grep "AvgIdentity " | head -n 1 | awk '{ print $2;}'`;  #retrieve results
      ALBA=`cat out.report | grep "AlignedBases " | head -n 1 | awk '{ print $2;}'`;
      SNPS=`cat out.report | grep TotalSNPs | awk '{ print $2;}'`;
      TBASES=`cat out.report | grep "TotalBases" | awk '{ print $2;}'`;
      AUX="$(cut -d')' -f1 <<< "$ALBA")"
      PERALBA="$(cut -d'(' -f2 <<< "$AUX")"
      TALBA="$(cut -d'(' -f1 <<< "$ALBA")"    
      NRBASES=`cat out.report | grep "TotalBases" | awk '{ print $2;}'`;  
    
      file_wout_extension="$(cut -d'.' -f1 <<< $file)"
      TIME=`cat $dataset/$file_wout_extension-time.txt | grep "TIME" | awk '{ print $2;}'`;
      MEM=`cat $dataset/$file_wout_extension-time.txt | grep "MEM" | awk '{ print $2;}'`;
      CPU_P=`cat $dataset/$file_wout_extension-time.txt | grep "CPU_perc" | awk '{ print $2;}'`;
    
      TMP=$(($TALBA * 100))
      ACCURACY=$(echo $TMP \/ $TBASES |bc -l | xargs printf %.3f)
      
      NAME_TOOL="$(cut -d'-' -f1 <<< $file_wout_extension)"
      
      DOES_ANALYSIS="?"
      DOES_CLASSIFICATION="?"
      

      for i in "${ANALYSIS[@]}" #check if the tool does metagenomic analysis
      do
        if [ "$i" == "$NAME_TOOL" ] ; then
          DOES_ANALYSIS="Yes"
          break
        fi 
      done
      
      if [ "$DOES_ANALYSIS" == "?" ] ; then
        for i in "${NO_ANALYSIS[@]}"
        do
          if [ "$i" == "$NAME_TOOL" ] ; then
            DOES_ANALYSIS="No"
            break
          fi 
        done
      fi
      
      for i in "${CLASSIFICATION[@]}" #check if the tool does metagenomic classification
      do
        if [ "$i" == "$NAME_TOOL" ] ; then
          DOES_CLASSIFICATION="Yes"
          break
        fi
      done
      
      if [ "$DOES_CLASSIFICATION" == "?" ] ; then
        for i in "${NO_CLASSIFICATION[@]}"
        do
          if [ "$i" == "$NAME_TOOL" ] ; then
            DOES_CLASSIFICATION="No"
            break
          fi 
        done
      fi
      
      NR_SPECIES=$(grep '>' $dataset/$file -c)
      gto_fasta_rand_extra_chars < $dataset/$file > tmp.fa
      gto_fasta_to_seq < tmp.fa > $dataset/$file_wout_extension.seq
      
      #Compressing sequences C(X) or C(X,Y)
      GeCo3 -tm 1:1:0:1:0.9/0:0:0 -tm 7:10:0:1:0/0:0:0 -tm 16:100:1:10:0/3:10:0.9 -lr 0.03 -hs 64 $dataset/$file_wout_extension.seq
   
      COMPRESSED_SIZE_WOUT_REF=$(ls -l $dataset/$file_wout_extension.seq.co | cut -d' ' -f5)
      rm $dataset/$file_wout_extension.seq.*
      
      #Conditional compression C(X|Y) [use reference and target]
      GeCo3 -rm 20:500:1:12:0.9/3:100:0.9 -rm 13:200:1:1:0.9/0:0:0 -tm 1:1:0:1:0.9/0:0:0 -tm 7:10:0:1:0/0:0:0 -tm 16:100:1:10:0/3:10:0.9 -lr 0.03 -hs 64 -r ../DS1.fa $dataset/$file_wout_extension.seq
      COMPRESSED_SIZE_COND_COMPRESSION=$(ls -l $dataset/$file_wout_extension.seq.co | cut -d' ' -f5)      
      rm $dataset/$file_wout_extension.seq.*
      
      #Relative compression (only reference models) C(X||Y)
      GeCo3 -rm 20:500:1:12:0.9/3:100:0.9 -rm 13:200:1:1:0.9/0:0:0 -lr 0.03 -hs 64 -r ../DS1.fa $dataset/$file_wout_extension.seq
      COMPRESSED_SIZE_W_REF=$(ls -l $dataset/$file_wout_extension.seq.co | cut -d' ' -f5)      
      rm $dataset/$file_wout_extension.seq.*
            
      FILE_SIZE=$(ls -l $dataset/$file_wout_extension.fa | cut -d' ' -f5)
     
      NCD=$(echo $COMPRESSED_SIZE_COND_COMPRESSION \/ $COMPRESSED_SIZE_WOUT_REF |bc -l | xargs printf %.3f)
      
      AUX_MULT=$(echo "$FILE_SIZE * 2" | bc -l )
      
      printf "AUX mult -> $AUX_MULT\n\n"
      NRC=$(echo $COMPRESSED_SIZE_W_REF \/ $AUX_MULT|bc -l | xargs printf %.3f)
      
      
      IDEN=$(echo $IDEN |bc -l | xargs printf %.3f)
      MEM=$(echo $MEM \/ 1048576 |bc -l | xargs printf %.3f)
      
    #ds	file	exec_time	snps	avg_identity	NCD	NRC	max_mem	cpu_avg	nr_contigs_reconstructed	metagenomic_analysis	metagenomic_classification
    echo "$dataset	$file	$TIME	$SNPS	$IDEN	$NCD	$NRC	$MEM	$CPU_P	$NR_SPECIES	$DOES_ANALYSIS	$DOES_CLASSIFICATION" >> total_stats.tsv
    CPU="$(cut -d'%' -f1 <<< "$CPU_P")"
    echo "$NAME_TOOL & $TIME & $SNPS & $IDEN & $NCD & $NRC & $MEM & $CPU & $NR_SPECIES & $DOES_ANALYSIS & $DOES_CLASSIFICATION \\\\\\hline" >> total_stats.tex
    printf "%s\t%s\t%s\n" "$ALBA" "$IDEN" "$SNPS";
    #rm -f G_A.fa G_B.fa ; #remove tmp files
    fi
  done
done
#

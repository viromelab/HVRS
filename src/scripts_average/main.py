import os
import statistics
from to_plot import *

dict_time = {}
dict_snp = {}
dict_identity = {}
dict_ncd = {}
dict_nrc = {}
dict_mem = {}
dict_cpu = {}
dict_nr_contigs = {}

dict_analysis = {}
dict_classification = {}
dict_cov = {}
dict_snp_ds = {}
dict_cont = {}

dict_recon_bases = {}
dict_recon_bases_wout_n = {}
dict_min_len = {}
dict_max_length = {}
dict_avg_length = {}

dict_min_length_wout_n = {}
dict_max_length_wout_n = {}
dict_avg_length_wout_n = {}



list_datasets = ["DS1", "DS2", "DS3", "DS4", "DS5", "DS6", "DS7", "DS8", "DS9", "DS10", "DS11", "DS12", "DS13",  "DS14",
                 "DS15",  "DS16",  "DS17",  "DS18",  "DS19",  "DS20",  "DS21",  "DS22",  "DS23",  "DS24",  "DS25",
                 "DS26", "DS27", "DS28",  "DS29",  "DS30",  "DS31",  "DS32",  "DS33",  "DS34",  "DS35",  "DS36",
                 "DS37",  "DS38",  "DS39",  "DS40", "DS41",  "DS42",  "DS43",  "DS44",  "DS45",  "DS46",  "DS47",
                 "DS48",  "DS49",  "DS50",  "DS51",  "DS52",  "DS53",  "DS54",  "DS55",  "DS56",  "DS57",  "DS58",
                 "DS59",  "DS60",  "DS61",  "DS62", "DS63", "DS64", "DS65", "SRR23101281", "SRR23101235",
                 "SRR23101259", "SRR23101276", "SRR23101228", "SRR12175231", "SRR12175232", "SRR12175233"]
tools_available = ["coronaspades","haploflow","irma","lazypipe","metaspades","metaviralspades","pehaplo",
                   "qure","qvg","spades","ssake","tracespipe","tracespipelite","virgena","vispa", "v-pipe"]

correct_names = ["coronaSPAdes","Haploflow","IRMA","LAZYPIPE","metaSPAdes","metaviralSPAdes","PEHaplo",
                   "QuRe","QVG","SPAdes","SSAKE","TRACESPipe","TRACESPipeLite","VirGenA","ViSpA", "V-pipe"]

decimal_cases = 3

def add_to_dict(key, val, sel_dict):

    if key in sel_dict:
        # append the new number to the existing array at this slot
        sel_dict[key].append(float(val.replace(",", "." )))
    else:
        # create a new array in this slot
        try:
            sel_dict[key] = [float(val.replace(",", "." ))]
        except:
            sel_dict[key] = [0.000]

def add_vals_dict(line): #adds vals of time to dict. key is tool and DS, vals are time

#time SNPs	AvgIdentity	NCD	NRC	Mem(GB)	%CPU	Nr contigs
    list_vals = line.split('\t')

    #print(list_vals)

    add_to_dict(list_vals[1], list_vals[2], dict_time)
    add_to_dict(list_vals[1], list_vals[3], dict_snp)
    add_to_dict(list_vals[1], list_vals[4], dict_identity)
    add_to_dict(list_vals[1], list_vals[5], dict_ncd)
    add_to_dict(list_vals[1], list_vals[6], dict_nrc)
    add_to_dict(list_vals[1], list_vals[7], dict_mem)
    add_to_dict(list_vals[1], list_vals[8].split("%")[0], dict_cpu)
    add_to_dict(list_vals[1], list_vals[9], dict_nr_contigs)

    dict_analysis[list_vals[1]] = list_vals[10]
    dict_classification[list_vals[1]] = list_vals[11]
    dict_cov[list_vals[1]] = list_vals[12]
    dict_snp_ds[list_vals[1]] = list_vals[13]
    dict_cont[list_vals[1]] = list_vals[14]

    add_to_dict(list_vals[1], list_vals[15], dict_recon_bases)
    add_to_dict(list_vals[1], list_vals[16], dict_min_len)
    add_to_dict(list_vals[1], list_vals[17], dict_max_length)
    add_to_dict(list_vals[1], list_vals[18], dict_avg_length)

    add_to_dict(list_vals[1], list_vals[19], dict_recon_bases_wout_n)
    add_to_dict(list_vals[1], list_vals[20], dict_min_length_wout_n)
    add_to_dict(list_vals[1], list_vals[21], dict_max_length_wout_n)
    add_to_dict(list_vals[1], list_vals[22], dict_avg_length_wout_n)



def alternative_mean(list_vals):

    mean_lst = statistics.mean(list_vals)
    max_lst = max(list_vals)
    min_lst = min(list_vals)
    time = -1

    if len(list_vals) > 1:
        if (max_lst + min_lst) / 2 == mean_lst:
            time = mean_lst
        elif max_lst - mean_lst > mean_lst - min_lst :
            list_vals.remove(max_lst)
            time = statistics.mean(list_vals)
        else:
            list_vals.remove(min_lst)
            time = statistics.mean(list_vals)
            '''try:
                time = statistics.mean(list_vals)
            except:
                pass'''
    else:
        time = mean_lst

    return time


def key_getter(key):

    if key.split("-")[1].split(".")[0] != "pipe":
        return key.split("-")[1].split(".")[0]
    else:
        return key.split("-")[2].split(".")[0]


def calculate_answer(key):

    try:
        len(dict_time.get(key))
    except:
        return [(" & -- & -- & -- & -- & -- & -- & -- & -- & -- & -- & -- & --  \\\\\\hline"), "", (" & -- & -- & -- & -- & -- & -- & -- & -- & -- & -- & -- & --  \\\\\\hline")]

    time = alternative_mean(dict_time.get(key))
    #print(time)

    identity = statistics.mean(dict_identity.get(key))
    ncd = statistics.mean(dict_ncd.get(key))
    #print(dict_time.get(key), dict_snp.get(key))
    snp = statistics.mean(dict_snp.get(key))
    '''if ncd > 1:
        print("changed ncd  -> ", key, ncd)
        ncd = 1.000'''

    nrc = statistics.mean(dict_nrc.get(key))

    '''if nrc > 1:
        print("changed nrc  -> ", key, nrc)
        nrc = 1.000'''

    mem = statistics.mean(dict_mem.get(key))
    cpu = statistics.mean(dict_cpu.get(key))
    contigs = statistics.mean(dict_nr_contigs.get(key))
    analysis = dict_analysis.get(key)
    classification = dict_classification.get(key)
    cov = dict_cov.get(key)
    snps_ds = dict_snp_ds.get(key)
    cont = dict_cont.get(key)
    recon_bases = statistics.mean(dict_recon_bases.get(key))
    min_len = statistics.mean(dict_min_len.get(key))
    max_length = statistics.mean(dict_max_length.get(key))
    avg_length = statistics.mean(dict_avg_length.get(key))

    recon_bases_wout_n = statistics.mean(dict_recon_bases_wout_n.get(key))
    min_len_wout_n = statistics.mean(dict_min_length_wout_n.get(key))
    max_len_wout_n = statistics.mean(dict_max_length_wout_n.get(key))
    avg_len_wout_n = statistics.mean(dict_avg_length_wout_n.get(key))

    #print(key)


    #print(float(snp), float(recon_bases_wout_n))


    snps_nr_bases = float(snp) / float(recon_bases)
    try:
        snps_nr_bases_wout_n = float(snp) / float(recon_bases_wout_n)
        to_write = str(format(snps_nr_bases_wout_n, '.5f'))

    except:
        to_write = "err"

    return [" & " + str(round(time, decimal_cases)) + " & " + str(round(snp, decimal_cases)) + " & " + str(round(identity, decimal_cases))+
            " & " + str(round(ncd, decimal_cases)) + " & " + str(round(nrc, decimal_cases)) + " & " + str(round(mem, decimal_cases)) +
            " & " + str(round(cpu, decimal_cases)) + " & "+ str(round(contigs, decimal_cases)) +" & " + str(round(recon_bases, decimal_cases)) +
            " & "+ str(round(min_len, decimal_cases)) + " & " + str(round(max_length, decimal_cases)) + " & " + str(round(avg_length, decimal_cases)) + " \\\\\\hline",
            key_getter(key) + "\t" + key + "\t" + str(round(time, decimal_cases)) + "\t" + str(round(snp, decimal_cases)) + "\t" + str(
                round(identity, decimal_cases)) + "\t" + str(round(ncd, decimal_cases)) + "\t" + str(
                round(nrc, decimal_cases)) + "\t" + str(round(mem, decimal_cases)) + "\t" + str(
                round(cpu, decimal_cases)) + "\t" + str(round(contigs, decimal_cases)) + "\t" + str(
                analysis) + "\t" + str(classification.split("\n")[0])  + "\t" + str(cov.split("\n")[0]) + "\t" + str(snps_ds.split("\n")[0]) +
            "\t" + str(cont.split("\n")[0]) + "\t" + str(round(recon_bases, decimal_cases)) + "\t" + str(round(min_len, decimal_cases)) +
            "\t" + str(round(max_length, decimal_cases)) + "\t" + str(round(avg_length, decimal_cases)) + "\t" +
            str(round(recon_bases_wout_n, decimal_cases)) + "\t" + str(round(min_len_wout_n, decimal_cases)) + "\t" + str(round(max_len_wout_n, decimal_cases))+
            "\t" + str(round(avg_len_wout_n, decimal_cases)) + "\t" + str(format(snps_nr_bases, '.5f')) + "\t" + to_write
            + "\n" ,
            " & " + str(round(time, decimal_cases)) + " & " + str(round(mem, decimal_cases)) +
            " & " + str(round(cpu, decimal_cases)) + " & " + str(round(contigs, decimal_cases)) + " & " + str(
                round(recon_bases, decimal_cases)) +
            " & " + str(round(min_len, decimal_cases)) + " & " + str(round(max_length, decimal_cases)) + " & " + str(
                round(avg_length, decimal_cases)) + " & " + str(
                round(recon_bases_wout_n, decimal_cases)) +
            " & " + str(round(min_len_wout_n, decimal_cases)) + " & " + str(round(max_len_wout_n, decimal_cases)) + " & " + str(
                round(avg_len_wout_n, decimal_cases)) + " \\\\\\hline",
            ]


def create_results():

    f = open("total_avg_stats.tex", "a")
    f_tsv = open("total_avg_stats.tsv", "a")
    f_alt = open("total_avg_stats_for_real_data.tex", "a")

    counter = 0

    for curr_ds in list_datasets:
        f.write("\\begin{table*}[!h] \n\\begin{center} \n\caption{Results obtained for " + str(curr_ds) + " using the benchmark and applying it to the different databases generated. The execution time was measured in seconds, the RAM usage was measured in GB and the average identity, accuracy and CPU usage are presented as a percentage. The executions were, when possible, capped at 6 threads and 48 GB of RAM.}\n\label{resultstable:DS"+ str(curr_ds) + "}\n\scriptsize\n\\begin{tabular}{| m{7em} | m{4em}| m{2.5em} | m{4em} | m{2.5em} | m{2.5em} | m{3em} | m{3em} | m{4.5em} | m{5.5em} | m{3.8em}  | m{3.8em} | m{3.8em} | } \n\\textbf{Reconstruction tool} & \\textbf{Execution time} & \\textbf{SNPs} & \\textbf{Avg Identity} & \\textbf{NCSD} & \\textbf{NRC} & \\textbf{RAM usage} & \\textbf{CPU usage} & \\textbf{Number of contigs} & \\textbf{Reconstructed bases} & \\textbf{Minimum contig length} & \\textbf{Maximum contig length} & \\textbf{Average contig length} \\\\\\hline " + "\n%\n")
        f_alt.write("\\begin{table*}[!h] \n\\begin{center} \n\caption{Results obtained for " + str(
            curr_ds) + " using the benchmark and applying it to the different databases generated. The execution time was measured in seconds, the RAM usage was measured in GB and the average identity, accuracy and CPU usage are presented as a percentage. The executions were, when possible, capped at 6 threads and 48 GB of RAM.}\n\label{resultstable:DS" + str(
            curr_ds) + "}\n\scriptsize\n\\begin{tabular}{| m{7em} | m{4em}| m{2.5em} | m{4em} | m{2.5em} | m{2.5em} | m{3em} | m{3em} | m{4.5em} | m{5.5em} | m{3.8em}  | m{3.8em} | m{3.8em} | } \n\\textbf{Reconstruction tool} & \\textbf{Execution time} & \\textbf{RAM usage} & \\textbf{CPU usage} & \\textbf{Number of contigs} & \\textbf{Reconstructed bases} & \\textbf{Minimum contig length} & \\textbf{Maximum contig length} & \\textbf{Average contig length} & \\textbf{Reconstructed bases (excluding N)} & \\textbf{Minimum contig length (excluding N)} & \\textbf{Maximum contig length (excluding N)} & \\textbf{Average contig length (excluding N)} \\\\\\hline " + "\n%\n")

        for inc_name in tools_available:

            tool = ""
            for name in correct_names:

                if inc_name == name.lower():
                    tool = name

            val = inc_name+"-"+str(curr_ds)+".fa"

            #print(val, dict_snp.keys())

            content = calculate_answer(val)

            f.write(tool + content[0])
            #print(content[1])
            f_tsv.write(content[1])
            f_alt.write(tool + content[2])
            counter += 1
            f.write("\n")
            f_alt.write("\n")

        f.write("%\n\end{tabular}\n\end{center}\n\end{table*}\n\n\n")
        f_alt.write("%\n\end{tabular}\n\end{center}\n\end{table*}\n\n\n")

    f.close()
    f_tsv.close()
    f_alt.close()


def import_files_in_dir(path):
    files = os.listdir(path)
    fst_file = True

    for file_name in files:
        file = open(path+"/"+file_name, "r")
        is_first_line = True

        for line in file:

            if is_first_line == False:
                add_vals_dict(line)
            else:
                is_first_line = False
                if fst_file == True:
                    f_tsv=open(file_tsv, "a")
                    f_tsv.write(line.split("\n")[0] + "\tNr SNPs / All bases\tNr SNPs / All non N bases\n")
                    f_tsv.close()

                    fst_file = False

        file.close()

    create_results()


if __name__ == '__main__':
    filename = "total_avg_stats.tex"
    file_tsv = "total_avg_stats.tsv"
    if os.path.exists(filename):
        os.remove(filename)
    if os.path.exists(file_tsv):
        os.remove(file_tsv)

    import_files_in_dir("results")

    exec_avgs()




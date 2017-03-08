import numpy
import scipy
import matplotlib
import dadi

with open('file_name', 'r') as myfile:
    dadi_input=myfile.read().replace('\n', '')

dd = dadi.Misc.make_data_dict(dadi_input)

with open(dadi_input, 'r') as myfile:
    headerline=myfile.readline().replace('\n', '').split('\t')

headerline.remove('ingroup')
headerline.remove('outgroup')
headerline.remove('Allele1')
headerline.remove('Allele2')

no_of_pops = (len(headerline)-2)/2
pop_name = headerline[0:no_of_pops]

final_fs = 0
final_spectrum = 0
pop_projections = 0
x = 0

print 'Up to the following line'
with open('fs_combos.txt', 'r') as myfile:
    for line in myfile:
        line=line.replace('\n', '').split(' ')
        line = [int(i) for i in line]
        print x
        x = x + 1
        fs = dadi.Spectrum.from_data_dict(dd , pop_ids =pop_name ,projections =line ,polarized = False)
        if fs.S() > final_fs:
            final_fs=fs.S()
            final_spectrum = fs
            pop_projections=line
            print 'Up to the following line'
            
final_spectrum.to_file("spectrum_output.txt")
print 'The optimum fs.S. is'
print final_fs
print 'The projection for this optimum is'
print pop_name
print pop_projections
print 'The spectrum for this is saved as "spectrum_output.txt"'


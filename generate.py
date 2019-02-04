""" Generates the counting code for the script """

import sys

files = ['3dnow', 'adx', 'aes', 'avx', 'avx2', 'avx512', 'bmi1', 'bmi2', 'clwb', 'f16c', 'fma', 'fsgsbase', 'mmx', 'movbe', 'mpx', 'pclmulqdq', 'prefetch', 'rdrand', 'rdseed', 'sgx', 'sha', 'sse', 'sse2', 'sse3', 'sse4.1', 'sse4.2', 'ssse3', 'vmx']

for file in files:
	with open('raw/' + file + '.txt') as fp:
		fu = file.upper() # filename used to display as name
		fc = '_' + fu.replace(".", "_") # filename used for code
		instructions = []
		line = fp.readline()
		
		while line:
			parts = line.strip().split()
			for part in parts:
				if part not in instructions:
					instructions.append(part)
			line = fp.readline()
		
		sys.stdout.write(fc + '=`echo "$INSTRUCTIONS" | awk \'/[ \\t](')
		for inst in instructions:
			sys.stdout.write(inst.lower())
			if inst != instructions[-1]:
				 sys.stdout.write('|')
		print(')[ \\t]/\' | wc -l`')
		print('if [ $' + fc + ' -ne 0 ]; then')
		print('\tprintf "%-12s %-12s\\n" \"' + fu + ':\" \"$' + fc + '\"')
		print('fi\n')
		
sys.stdout.flush()

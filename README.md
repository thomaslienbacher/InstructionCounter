# Instruction Counter
This shell script counts the amount of x86 extension instructions in a binary.

Supported extensions:
* 3DNOW
* ADX
* AES
* AVX
* AVX2
* AVX512
* BMI1
* BMI2
* CLWB
* F16C
* FMA
* FSGSBASE
* MMX
* MOVBE
* MPX
* PCLMULQDQ
* PREFETCH
* RDRAND
* RDSEED
* SGX
* SHA
* SSE
* SSE2
* SSE3
* SSE4.1
* SSE4.2
* SSSE3

## Source
The information about the instructions was grabbed from the ORACLE docs: 
[https://docs.oracle.com/cd/E37838_01/html/E61064/enmzx.html#scrolltoc](https://docs.oracle.com/cd/E37838_01/html/E61064/enmzx.html#scrolltoc).

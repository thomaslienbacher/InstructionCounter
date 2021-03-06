#! /bin/sh
# 
# Author: Thomas Lienbacher [github.com/thomaslienbacher]
# 
# Counts the amount of special instructions in a binary
# 

function usage {
	cat << EOF
Usage: ixcount.sh <binary>

Counts the amount of special instructions in a binary.

Supported extensions:
EOF

	printf "%-12s %-12s %-12s\n" "3DNOW" "ADX" "AES"
	printf "%-12s %-12s %-12s\n" "AVX" "AVX2" "AVX512"
	printf "%-12s %-12s %-12s\n" "BMI1" "BMI2" "CLWB"
	printf "%-12s %-12s %-12s\n" "F16C" "FMA" "FSGSBASE"
	printf "%-12s %-12s %-12s\n" "MMX" "MOVBE" "MPX"
	printf "%-12s %-12s %-12s\n" "CLMUL" "PREFETCH" "RDRAND"
	printf "%-12s %-12s %-12s\n" "RDSEED" "SGX" "SHA"
	printf "%-12s %-12s %-12s\n" "SSE" "SSE2" "SSE3"
	printf "%-12s %-12s %-12s\n" "SSE4.1" "SSE4.2" "SSSE3"
	printf "%-12s\n" "VMX"
	
	exit 1
}

if [ $# -ne 1 ]; then
   usage;
fi

INSTRUCTIONS=`objdump -d $1` 

_3DNOW=`echo "$INSTRUCTIONS" | awk '/[ \t](femms|pavgusb|pf2id|pf2iw|pfacc|pfadd|pfcmpeq|pfcmpge|pfcmpgt|pfmax|pfmin|pfmul|pfnacc|pfpnacc|pfrcp|pfrcpit1|pfrcpit2|pfrsqit1|pfrsqrt|pfsub|pfsubr|pi2fd|pi2fw|pmulhrw|pswapd)[ \t]/' | wc -l`
if [ $_3DNOW -ne 0 ]; then
	printf "%-12s %-12s\n" "3DNOW:" "$_3DNOW"
fi

_ADX=`echo "$INSTRUCTIONS" | awk '/[ \t](adcx|adox)[ \t]/' | wc -l`
if [ $_ADX -ne 0 ]; then
	printf "%-12s %-12s\n" "ADX:" "$_ADX"
fi

_AES=`echo "$INSTRUCTIONS" | awk '/[ \t](aesdec|aesdeclast|aesenc|aesenclast|aesimc|aeskeygenassist)[ \t]/' | wc -l`
if [ $_AES -ne 0 ]; then
	printf "%-12s %-12s\n" "AES:" "$_AES"
fi

_AVX=`echo "$INSTRUCTIONS" | awk '/[ \t](addpd|addps|addsd|addss|addsubpd|addsubps|andnpd|andnps|andpd|andps|blendpd|blendps|blendvpd|blendvps|cmppd|cmpps|cmpsd|cmpss|comisd|comiss|cvtdq2pd|cvtdq2ps|cvtpd2dq|cvtpd2ps|cvtps2dq|cvtps2pd|cvtsd2si|cvtsd2ss|cvtsi2sd|cvtsi2ss|cvtss2sd|cvtss2si|cvttpd2dq|cvttps2dq|cvttsd2si|cvttss2si|divpd|divps|divsd|divss|dppd|dpps|extractps|haddpd|haddps|hsubpd|hsubps|insertps|lddqu|ldmxcsr|maskmovdqu|maxpd|maxps|maxsd|maxss|minpd|minps|minsd|minss|movapd|movaps|movdmovq|movddup|movdqa|movdqu|vmovdqu32|vmovdqu64|movhlps|movhpd|movhps|movlhps|movlpd|movlps|movmskpd|movmskps|movntdq|movntdqa|movntpd|movntps|movq|movsd|movshdup|movsldup|movss|movupd|movups|mpsadbw|mulpd|mulps|mulsd|mulss|orpd|orps|pabsb|pabsw|pabsd|pabsq|packsswb|packssdw|packusdw|packuswb|paddb|paddw|paddd|paddq|paddsb|paddsw|paddusb|paddusw|palignr|pand|pandn|pavgb|pavgw|pblendvb|pblendw|pcmpeqb|pcmpeqw|pcmpeqd|pcmpeqq|pcmpestri|pcmpestrm|pcmpgtb|pcmpgtw|pcmpgtd|pcmpgtq|pcmpistri|pcmpistrm|pextrb|pextrd|pextrq|pextrw|phaddsw|phaddw|phaddd|phminposuw|phsubsw|phsubw|phsubd|pinsrb|pinsrd|pinsrq|pinsrw|pmaddubsw|pmaddwd|pmaxsb|pmaxsw|pmaxsd|pmaxsq|pmaxub|pmaxud|pmaxuq|pmaxuw|pminsb|pminsd|pminsq|pminsw|pminub|pminud|pminuq|pminuw|pmovmskb|pmovsx|pmovzx|pmuldq|pmulhrsw|pmulhuw|pmulhw|pmulld|pmullw|pmuludq|por|psadbw|pshufb|pshufd|pshufhw|pshuflw|psignb|psignw|psignd|pslldq|psllw|pslld|psllq|psraw|psrldq|psrlw|psrld|psrlq|psubb|psubw|psubd|psubq|psubsb|psubsw|psubusb|psubusw|ptest|punpckhbw|punpckhwd|punpckhdq|punpckhqdq|punpcklbw|punpcklwd|punpckldq|punpcklqdq|pxor|pxord|pxorq|rcpps|rcpss|roundpd|roundps|roundsd|roundss|rsqrtps|rsqrtss|shufpd|shufps|sqrtpd|sqrtps|sqrtsd|sqrtss|stmxcsr|subpd|subps|subsd|subss|ucomisd|ucomiss|unpckhpd|unpckhps|unpcklpd|unpcklps|vbroadcast|vextractf128|vextractf32x4|vextractf64x4|vinsertf128|vinsertf32x4|vinsertf64x4|vmaskmov|vperm2f128|vpermilpd|vpermilps|vtestpdvtestps|vzeroall|vzeroupper|xorpd|xorps|pclmulqdq)[ \t]/' | wc -l`
if [ $_AVX -ne 0 ]; then
	printf "%-12s %-12s\n" "AVX:" "$_AVX"
fi

_AVX2=`echo "$INSTRUCTIONS" | awk '/[ \t](movntdqa|mpsadbw|pabsb|pabsw|pabsd|pabsq|packsswb|packssdw|packusdw|packuswb|paddb|paddw|paddd|paddq|paddsb|paddsw|paddusb|paddusw|palignr|pand|pandn|pavgb|pavgw|pblendvb|pblendw|pcmpeqb|pcmpeqw|pcmpeqd|pcmpeqq|pcmpgtb|pcmpgtw|pcmpgtd|pcmpgtq|phaddsw|phaddw|phaddd|phsubsw|phsubw|phsubd|pmaddubsw|pmaddwd|pmaxsb|pmaxsw|pmaxsd|pmaxsq|pmaxub|pmaxud|pmaxuq|pmaxuw|pminsb|pminsd|pminsq|pminsw|pminub|pminud|pminuq|pminuw|pmovmskb|pmovsx|pmovzx|pmuldq|pmulhrsw|pmulhuw|pmulhw|pmulld|pmullw|pmuludq|por|psadbw|pshufb|pshufd|pshufhw|pshuflw|psignb|psignw|psignd|pslldq|psllw|pslld|psllq|psraw|psrad|psraq|psrldq|psrlw|psrld|psrlq|psubb|psubw|psubd|psubq|psubsb|psubsw|psubusb|psubusw|punpckhbw|punpckhwd|punpckhdq|punpckhqdq|punpcklbw|punpcklwd|punpckldq|punpcklqdq|pxor|pxord|pxorq|vbroadcast|vextracti128|vextracti32x4|vextracti64x4|vgatherdps|vgatherdpd|vgatherqps|vgatherqpd|vinserti128|vinserti32x4|vinserti64x4|vpblendd|vpbroadcast|vbroadcasti128|vperm2i128|vpermd|vpermpd|vpermps|vpermq|vpgatherdd|vpgatherdq|vpgatherqd|vpgatherqq|vpmaskmov|vpsllvw|vpsllvd|vpsllvq|vpsravd|vpsravq|vpsrlvw|vpsrlvd|vpsrlvq)[ \t]/' | wc -l`
if [ $_AVX2 -ne 0 ]; then
	printf "%-12s %-12s\n" "AVX2:" "$_AVX2"
fi

_AVX512=`echo "$INSTRUCTIONS" | awk '/[ \t](kaddb|kaddd|kaddq|kaddw|kandb|kandd|kandnb|kandnd|kandnq|kandq|kmovb|kmovd|kmovq|knotb|knotd|knotq|korb|kord|korq|kortestb|kortestd|kortestq|kshiftlb|kshiftld|kshiftlq|kshiftrb|kshiftrd|kshiftrq|ktestb|ktestd|ktestq|ktestw|kunpckdq|kunpckwd|kxnorb|kxnord|kxnorq|kxorb|kxord|kxorq|vaddpd|vaddps|valignd|valignq|vandnpd|vandnps|vandpd|vandps|vblendmpd|vblendmps|vbroadcastf32x2|vbroadcastf32x4|vbroadcastf32x8|vbroadcastf64x2|vbroadcasti32x2|vbroadcasti32x4|vbroadcasti32x8|vbroadcasti64x2|vbroadcastss|vcmppd|vcmpps|vcompresspd|vcompressps|vcvtdq2pd|vcvtdq2ps|vcvtpd2dq|vcvtpd2ps|vcvtpd2qq|vcvtpd2udq|vcvtpd2uqq|vcvtph2ps|vcvtps2dq|vcvtps2pd|vcvtps2ph|vcvtps2qq|vcvtps2udq|vcvtps2uqq|vcvtqq2pd|vcvtqq2ps|vcvttpd2dq|vcvttpd2qq|vcvttpd2udq|vcvttpd2uqq|vcvttps2dq|vcvttps2qq|vcvttps2udq|vcvttps2uqq|vcvtudq2pd|vcvtudq2ps|vcvtuqq2pd|vcvtuqq2ps|vdbpsadbw|vdivpd|vdivps|vexp2pd|vexp2ps|vexpandpd|vexpandps|vextractf32x4|vextractf64x2|vextracti32x4|vextracti64x2|vfixupimmpd|vfixupimmps|vfmadd132pd|vfmadd132ps|vfmadd213pd|vfmadd213ps|vfmadd231pd|vfmadd231ps|vfmaddsub132pd|vfmaddsub132ps|vfmaddsub213pd|vfmaddsub213ps|vfmaddsub231pd|vfmaddsub231ps|vfmsub132pd|vfmsub132ps|vfmsub213pd|vfmsub213ps|vfmsub231pd|vfmsub231ps|vfmsubadd132pd|vfmsubadd132ps|vfmsubadd213pd|vfmsubadd213ps|vfmsubadd231pd|vfmsubadd231ps|vfnmadd132pd|vfnmadd132ps|vfnmadd213pd|vfnmadd213ps|vfnmadd231pd|vfnmadd231ps|vfnmsub132pd|vfnmsub132ps|vfnmsub213pd|vfnmsub213ps|vfnmsub231pd|vfnmsub231ps|vfpclasspd|vfpclassps|vfpclasssd|vfpclassss|vgatherdpd|vgatherdps|vgatherpf0dpd|vgatherpf0dps|vgatherpf0qpd|vgatherpf0qps|vgatherpf1dpd|vgatherpf1dps|vgatherpf1qpd|vgatherpf1qps|vgatherqpd|vgatherqps|vgetexppd|vgetexpps|vgetmantpd|vgetmantps|vinsertf32x4|vinsertf32x8|vinsertf64x2|vinserti32x4|vinserti32x8|vinserti64x2|vmaxpd|vmaxps|vminpd|vminps|vmovapd|vmovaps|vmovddup|vmovdqa32|vmovdqa64|vmovdqu16|vmovdqu32|vmovdqu64|vmovdqu8|vmovntdq|vmovntdqa|vmovntpd|vmovntps|vmovshdup|vmovsldup|vmovupd|vmovups|vmulpd|vmulps|vorpd|vorps|vpabsb|vpabsd|vpabsq|vpabsw|vpackssdw|vpacksswb|vpackusdw|vpackuswb|vpaddb|vpaddd|vpaddq|vpaddsb|vpaddsw|vpaddusb|vpaddusw|vpaddw|vpalignr|vpandd|vpandnd|vpandnq|vpandq|vpavgb|vpavgw|vpblendmb|vpblendmd|vpblendmq|vpblendmw|vpbroadcastb|vpbroadcastd|vpbroadcastmb2q|vpbroadcastmw2d|vpbroadcastq|vpbroadcastw|vpcmpb|vpcmpd|vpcmpeqq|vpcmpgtb|vpcmpgtd|vpcmpgtq|vpcmpgtw|vpcmpq|vpcmpub|vpcmpud|vpcmpuq|vpcmpuw|vpcmpw|vpcompressd|vpcompressq|vpconflictd|vpconflictq|vpermd|vpermi2b|vpermi2d|vpermi2pd|vpermi2ps|vpermi2q|vpermi2w|vpermilpd|vpermilps|vpermpd|vpermps|vpermq|vpermt2b|vpermt2d|vpermt2pd|vpermt2ps|vpermt2q|vpermt2w|vpermw|vpexpandd|vpexpandq|vpextrb|vpextrd|vpgatherdd|vpgatherdq|vpgatherqd|vpgatherqq|vpinsrb|vpinsrd|vpinsrq|vpinsrw|vplzcntd|vplzcntq|vpmadd52huq|vpmadd52luq|vpmaddubsw|vpmaddwd|vpmaxsb|vpmaxsd|vpmaxsq|vpmaxsw|vpmaxub|vpmaxud|vpmaxuq|vpmaxuw|vpminsb|vpminsd|vpminsq|vpminsw|vpminub|vpminud|vpminuq|vpminuw|vpmovb2m|vpmovd2m|vpmovdb|vpmovdw|vpmovm2b|vpmovm2d|vpmovm2q|vpmovm2w|vpmovq2m|vpmovqb|vpmovqd|vpmovqw|vpmovsdb|vpmovsdw|vpmovsqb|vpmovsqd|vpmovsqw|vpmovswb|vpmovsxbd|vpmovsxbq|vpmovsxbw|vpmovsxdq|vpmovsxwd|vpmovsxwq|vpmovusdb|vpmovusdw|vpmovusqb|vpmovusqd|vpmovusqw|vpmovuswb|vpmovw2m|vpmovwb|vpmovzxbd|vpmovzxbq|vpmovzxbw|vpmovzxdq|vpmovzxwd|vpmovzxwq|vpmuldq|vpmulhrsw|vpmulhuw|vpmulhw|vpmulld|vpmullq|vpmullw|vpmultishiftqb|vpmuludq|vpord|vporq|vprold|vprolq|vprolvd|vprolvq|vprord|vprorq|vprorvd|vprorvq|vpsadbw|vpscatterdd|vpscatterdq|vpscatterqd|vpscatterqq|vpshufb|vpshufd|vpshufhw|vpshuflw|vpslld|vpslldq|vpsllq|vpsllvd|vpsllvq|vpsllvw|vpsllw|vpsrad|vpsraq|vpsravd|vpsravq|vpsravw|vpsraw|vpsrld|vpsrldq|vpsrlq|vpsrlvd|vpsrlvq|vpsrlvw|vpsrlw|vpsubb|vpsubd|vpsubq|vpsubsb|vpsubsw|vpsubusb|vpsubusw|vpsubw|vpternlogd|vpternlogq|vptestmb|vptestmd|vptestmq|vptestmw|vptestnmb|vptestnmd|vptestnmq|vptestnmw|vpunpckhbw|vpunpckhdq|vpunpckhqdq|vpunpckhwd|vpunpcklbw|vpunpckldq|vpunpcklqdq|vpunpcklwd|vpxord|vpxorq|vrangepd|vrangeps|vrangesd|vrangess|vrcp14pd|vrcp14ps|vrcp28pd|vrcp28ps|vrcp28sd|vrcp28ss|vreducepd|vreduceps|vreducess|vrndscalepd|vrndscaleps|vrsqrt14pd|vrsqrt14ps|vscalefpd|vscalefps|vscatterdpd|vscatterdps|vscatterpf0dpd|vscatterpf0dps|vscatterpf0qpd|vscatterpf0qps|vscatterpf1dpd|vscatterpf1dps|vscatterpf1qpd|vscatterpf1qps|vscatterqpd|vscatterqps|vshuff32x4|vshuff64x2|vshufi32x4|vshufi64x2|vshufpd|vshufps|vsqrtpd|vsqrtps|vsubpd|vsubps|vunpckhpd|vunpckhps|vunpcklpd|vunpcklps|vxorpd|vxorps)[ \t]/' | wc -l`
if [ $_AVX512 -ne 0 ]; then
	printf "%-12s %-12s\n" "AVX512:" "$_AVX512"
fi

_BMI1=`echo "$INSTRUCTIONS" | awk '/[ \t](andn|bextr|blsi|blsmsk|blsr|lzcnt|tzcnt)[ \t]/' | wc -l`
if [ $_BMI1 -ne 0 ]; then
	printf "%-12s %-12s\n" "BMI1:" "$_BMI1"
fi

_BMI2=`echo "$INSTRUCTIONS" | awk '/[ \t](bzhi|mulx|pdep|pext|rorx|sarx|shlx|shrx)[ \t]/' | wc -l`
if [ $_BMI2 -ne 0 ]; then
	printf "%-12s %-12s\n" "BMI2:" "$_BMI2"
fi

_CLMUL=`echo "$INSTRUCTIONS" | awk '/[ \t](pclmulqdq|pclmullqlqdq|pclmulhqlqdq|pclmullqhqdq|pclmulhqhqdq)[ \t]/' | wc -l`
if [ $_CLMUL -ne 0 ]; then
	printf "%-12s %-12s\n" "CLMUL:" "$_CLMUL"
fi

_CLWB=`echo "$INSTRUCTIONS" | awk '/[ \t](clwb)[ \t]/' | wc -l`
if [ $_CLWB -ne 0 ]; then
	printf "%-12s %-12s\n" "CLWB:" "$_CLWB"
fi

_F16C=`echo "$INSTRUCTIONS" | awk '/[ \t](vcvtph2ps|vcvtps2ph)[ \t]/' | wc -l`
if [ $_F16C -ne 0 ]; then
	printf "%-12s %-12s\n" "F16C:" "$_F16C"
fi

_FMA=`echo "$INSTRUCTIONS" | awk '/[ \t](vfmadd132pd|vfmadd213pd|vfmadd231pd|vfmadd132ps|vfmadd213ps|vfmadd231ps|vfmadd132sd|vfmadd213sd|vfmadd231sd|vfmadd132ss|vfmadd213ss|vfmadd231ss|vfmaddsub132pd|vfmaddsub213pd|vfmaddsub231pd|vfmaddsub132ps|vfmaddsub213ps|vfmaddsub231ps|vfmsub132pd|vfmsub213pd|vfmsub231pd|vfmsub132ps|vfmsub213ps|vfmsub231ps|vfmsub132sd|vfmsub213sd|vfmsub231sd|vfmsub132ss|vfmsub213ss|vfmsub231ss|vfmsubadd132pd|vfmsubadd213pd|vfmsubadd231pd|vfmsubadd132ps|vfmsubadd213ps|vfmsubadd231ps|vfnmadd132pd|vfnmadd213pd|vfnmadd231pd|vfnmadd132ps|vfnmadd213ps|vfnmadd231ps|vfnmadd132sd|vfnmadd213sd|vfnmadd231sd|vfnmadd132ss|vfnmadd213ss|vfnmadd231ss|vfnmsub132pd|vfnmsub213pd|vfnmsub231pd|vfnmsub132ps|vfnmsub213ps|vfnmsub231ps|vfnmsub132sd|vfnmsub213sd|vfnmsub231sd|vfnmsub132ss|vfnmsub213ss|vfnmsub231ss)[ \t]/' | wc -l`
if [ $_FMA -ne 0 ]; then
	printf "%-12s %-12s\n" "FMA:" "$_FMA"
fi

_FSGSBASE=`echo "$INSTRUCTIONS" | awk '/[ \t](rdfsbase|rdgsbase|wrfsbase|wrgsbase)[ \t]/' | wc -l`
if [ $_FSGSBASE -ne 0 ]; then
	printf "%-12s %-12s\n" "FSGSBASE:" "$_FSGSBASE"
fi

_MMX=`echo "$INSTRUCTIONS" | awk '/[ \t](movd|movq|packssdw|packsswb|packuswb|punpckhbw|punpckhdq|punpckhwd|punpcklbw|punpckldq|punpcklwd|paddb|paddd|paddsb|paddsw|paddusb|paddusw|paddw|pmaddwd|pmulhw|pmullw|psubb|psubd|psubsb|psubsw|psubusb|psubusw|psubw|pcmpeqb|pcmpeqd|pcmpeqw|pcmpgtb|pcmpgtd|pcmpgtw|pand|pandn|por|pxor|pslld|psllq|psllw|psrad|psraw|psrld|psrlq|psrlw|emms)[ \t]/' | wc -l`
if [ $_MMX -ne 0 ]; then
	printf "%-12s %-12s\n" "MMX:" "$_MMX"
fi

_MOVBE=`echo "$INSTRUCTIONS" | awk '/[ \t](movbe)[ \t]/' | wc -l`
if [ $_MOVBE -ne 0 ]; then
	printf "%-12s %-12s\n" "MOVBE:" "$_MOVBE"
fi

_MPX=`echo "$INSTRUCTIONS" | awk '/[ \t](bndcl|bndcn|bndcu|bndldx|bndmk|bndmov|bndstx)[ \t]/' | wc -l`
if [ $_MPX -ne 0 ]; then
	printf "%-12s %-12s\n" "MPX:" "$_MPX"
fi

_PREFETCH=`echo "$INSTRUCTIONS" | awk '/[ \t](prefetch|prefetchw|prefetchwt1)[ \t]/' | wc -l`
if [ $_PREFETCH -ne 0 ]; then
	printf "%-12s %-12s\n" "PREFETCH:" "$_PREFETCH"
fi

_RDRAND=`echo "$INSTRUCTIONS" | awk '/[ \t](rdrand)[ \t]/' | wc -l`
if [ $_RDRAND -ne 0 ]; then
	printf "%-12s %-12s\n" "RDRAND:" "$_RDRAND"
fi

_RDSEED=`echo "$INSTRUCTIONS" | awk '/[ \t](rdseed)[ \t]/' | wc -l`
if [ $_RDSEED -ne 0 ]; then
	printf "%-12s %-12s\n" "RDSEED:" "$_RDSEED"
fi

_SGX=`echo "$INSTRUCTIONS" | awk '/[ \t](encls|enclu)[ \t]/' | wc -l`
if [ $_SGX -ne 0 ]; then
	printf "%-12s %-12s\n" "SGX:" "$_SGX"
fi

_SHA=`echo "$INSTRUCTIONS" | awk '/[ \t](sha1msg1|sha1msg2|sha1nexte|sha1rnds4|sha256msg1|sha256msg2|sha256rnds2)[ \t]/' | wc -l`
if [ $_SHA -ne 0 ]; then
	printf "%-12s %-12s\n" "SHA:" "$_SHA"
fi

_SSE=`echo "$INSTRUCTIONS" | awk '/[ \t](movaps|movhlps|movhps|movlhps|movlps|movmskps|movss|movups|addps|addss|divps|divss|maxps|maxss|minps|minss|mulps|mulss|rcpps|rcpss|rsqrtps|rsqrtss|sqrtps|sqrtss|subps|subss|cmpps|cmpss|comiss|ucomiss|andnps|andps|orps|xorps|shufps|unpckhps|unpcklps|cvtpi2ps|cvtps2pi|cvtsi2ss|cvtss2si|cvttps2pi|cvttss2si|ldmxcsr|stmxcsr|pavgb|pavgw|pextrw|pinsrw|pmaxsw|pmaxub|pminsw|pminub|pmovmskb|pmulhuw|psadbw|pshufw|maskmovq|movntps|movntq|prefetchnta|prefetcht0|prefetcht1|prefetcht2|sfence)[ \t]/' | wc -l`
if [ $_SSE -ne 0 ]; then
	printf "%-12s %-12s\n" "SSE:" "$_SSE"
fi

_SSE2=`echo "$INSTRUCTIONS" | awk '/[ \t](addpd|addsd|divpd|divsd|maxpd|maxsd|minpd|minsd|mulpd|mulsd|sqrtpd|sqrtsd|subpd|subsd|andnpd|andpd|orpd|xorpd|cmppd|cmpsd|comisd|ucomisd|shufpd|unpckhpd|unpcklpd|cvtdq2pd|cvtpd2dq|cvtpd2pi|cvtpd2ps|cvtpi2pd|cvtps2pd|cvtsd2si|cvtsd2ss|cvtsi2sd|cvtss2sd|cvttpd2dq|cvttpd2pi|cvttsd2si|cvtdq2ps|cvtps2dq|cvttps2dq|movdq2q|movdqa|movdqu|movq2dq|paddq|pmuludq|pshufd|pshufhw|pshuflw|pslldq|psrldq|psubq|punpckhqdq|punpcklqdq|clflush|lfence|maskmovdqu|mfence|movntdq|movnti|movntpd|pause)[ \t]/' | wc -l`
if [ $_SSE2 -ne 0 ]; then
	printf "%-12s %-12s\n" "SSE2:" "$_SSE2"
fi

_SSE3=`echo "$INSTRUCTIONS" | awk '/[ \t](addsubpd|addsubps|haddpd|haddps|hsubpd|hsubps|lddqu|movddup|movshdup|movsldup)[ \t]/' | wc -l`
if [ $_SSE3 -ne 0 ]; then
	printf "%-12s %-12s\n" "SSE3:" "$_SSE3"
fi

_SSE4_1=`echo "$INSTRUCTIONS" | awk '/[ \t](blendpd|blendps|blendvpd|blendvps|dppd|dpps|extractps|insertps|movntdqa|mpsadbw|packusdw|pblendvb|pblendw|pcmpeqb|pcmpeqw|pcmpeqd|pcmpeqq|pextrb|pextrd|pextrq|pextrw|phminposuw|pinsrb|pinsrd|pinsrq|pmaxsb|pmaxsw|pmaxsd|pmaxsq|pmaxud|pmaxuq|pmaxuw|pminsb|pminsd|pminsq|pminud|pminuq|pminuw|pmovsx|pmovzx|pmuldq|pmulld|ptest|roundpd|roundps|roundsd|roundss)[ \t]/' | wc -l`
if [ $_SSE4_1 -ne 0 ]; then
	printf "%-12s %-12s\n" "SSE4.1:" "$_SSE4_1"
fi

_SSE4_2=`echo "$INSTRUCTIONS" | awk '/[ \t](pcmpestri|pcmpestrm|pcmpgtb|pcmpistri|pcmpistrm)[ \t]/' | wc -l`
if [ $_SSE4_2 -ne 0 ]; then
	printf "%-12s %-12s\n" "SSE4.2:" "$_SSE4_2"
fi

_SSSE3=`echo "$INSTRUCTIONS" | awk '/[ \t](pabsb|pabsw|pabsd|pabsq|palignr|phaddsw|phaddw|phaddd|phsubsw|phsubw|phsubd|pmaddubsw|pmulhrsw|pshufb|psignb|psignw|psignd)[ \t]/' | wc -l`
if [ $_SSSE3 -ne 0 ]; then
	printf "%-12s %-12s\n" "SSSE3:" "$_SSSE3"
fi

_VMX=`echo "$INSTRUCTIONS" | awk '/[ \t](invept|invvpid|vmcall|vmclear|vmfunc|vmlaunch|vmresume|vmptrld|vmptrst|vmread|vmwrite|vmxoff|vmxon)[ \t]/' | wc -l`
if [ $_VMX -ne 0 ]; then
	printf "%-12s %-12s\n" "VMX:" "$_VMX"
fi

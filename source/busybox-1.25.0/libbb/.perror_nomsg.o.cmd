cmd_libbb/perror_nomsg.o := arm-linux-gnueabi-gcc -Wp,-MD,libbb/.perror_nomsg.o.d   -std=gnu99 -Iinclude -Ilibbb  -include include/autoconf.h -D_GNU_SOURCE -DNDEBUG -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -D"BB_VER=KBUILD_STR(1.25.0)" -DBB_BT=AUTOCONF_TIMESTAMP  -Wall -Wshadow -Wwrite-strings -Wundef -Wstrict-prototypes -Wunused -Wunused-parameter -Wunused-function -Wunused-value -Wmissing-prototypes -Wmissing-declarations -Wno-format-security -Wdeclaration-after-statement -Wold-style-definition -fno-builtin-strlen -finline-limit=0 -fomit-frame-pointer -ffunction-sections -fdata-sections -fno-guess-branch-probability -funsigned-char -static-libgcc -falign-functions=1 -falign-jumps=1 -falign-labels=1 -falign-loops=1 -fno-unwind-tables -fno-asynchronous-unwind-tables -fno-builtin-printf -Os     -D"KBUILD_STR(s)=\#s" -D"KBUILD_BASENAME=KBUILD_STR(perror_nomsg)"  -D"KBUILD_MODNAME=KBUILD_STR(perror_nomsg)" -c -o libbb/perror_nomsg.o libbb/perror_nomsg.c

deps_libbb/perror_nomsg.o := \
  libbb/perror_nomsg.c \
  /usr/arm-linux-gnueabi/include/stdc-predef.h \
  include/platform.h \
    $(wildcard include/config/werror.h) \
    $(wildcard include/config/big/endian.h) \
    $(wildcard include/config/little/endian.h) \
    $(wildcard include/config/nommu.h) \
  /usr/lib/gcc-cross/arm-linux-gnueabi/4.9/include-fixed/limits.h \
  /usr/lib/gcc-cross/arm-linux-gnueabi/4.9/include-fixed/syslimits.h \
  /usr/arm-linux-gnueabi/include/limits.h \
  /usr/arm-linux-gnueabi/include/features.h \
  /usr/arm-linux-gnueabi/include/sys/cdefs.h \
  /usr/arm-linux-gnueabi/include/bits/wordsize.h \
  /usr/arm-linux-gnueabi/include/gnu/stubs.h \
  /usr/arm-linux-gnueabi/include/gnu/stubs-soft.h \
  /usr/arm-linux-gnueabi/include/bits/posix1_lim.h \
  /usr/arm-linux-gnueabi/include/bits/local_lim.h \
  /usr/arm-linux-gnueabi/include/linux/limits.h \
  /usr/arm-linux-gnueabi/include/bits/posix2_lim.h \
  /usr/arm-linux-gnueabi/include/bits/xopen_lim.h \
  /usr/arm-linux-gnueabi/include/bits/stdio_lim.h \
  /usr/arm-linux-gnueabi/include/byteswap.h \
  /usr/arm-linux-gnueabi/include/bits/byteswap.h \
  /usr/arm-linux-gnueabi/include/bits/types.h \
  /usr/arm-linux-gnueabi/include/bits/typesizes.h \
  /usr/arm-linux-gnueabi/include/bits/byteswap-16.h \
  /usr/arm-linux-gnueabi/include/endian.h \
  /usr/arm-linux-gnueabi/include/bits/endian.h \
  /usr/lib/gcc-cross/arm-linux-gnueabi/4.9/include/stdint.h \
  /usr/arm-linux-gnueabi/include/stdint.h \
  /usr/arm-linux-gnueabi/include/bits/wchar.h \
  /usr/lib/gcc-cross/arm-linux-gnueabi/4.9/include/stdbool.h \
  /usr/arm-linux-gnueabi/include/unistd.h \
  /usr/arm-linux-gnueabi/include/bits/posix_opt.h \
  /usr/arm-linux-gnueabi/include/bits/environments.h \
  /usr/lib/gcc-cross/arm-linux-gnueabi/4.9/include/stddef.h \
  /usr/arm-linux-gnueabi/include/bits/confname.h \
  /usr/arm-linux-gnueabi/include/getopt.h \
  /usr/arm-linux-gnueabi/include/bits/unistd.h \

libbb/perror_nomsg.o: $(deps_libbb/perror_nomsg.o)

$(deps_libbb/perror_nomsg.o):

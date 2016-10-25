VERSION = 2
SUBLEVEL = 0
# *DOCUMENTATION*
# To see a list of typical targets execute "make help"
# More info can be located in ./README
# Comments in this file are targeted only to the developer, do not
# expect to learn how to build the kernel and uboot reading this file.
OPI_WORK_DIR=$(PWD)
include $(PWD)/script/orangepi.conf

MAKE = make
ARCH = arm
CROSS_COMPILE = arm-linux-gnueabi-
PATH := $(PWD)/toolchain/gcc-linaro/bin:$(PATH)
export ARCH CROSS_COMPILE PATH OPI_WORK_DIR
#
PHONY += help
help :
	@$(MAKE) -sf $(OPI_WORK_DIR)/script/Makefile help

PHONY += all
all : uboot linux
	@date
	@echo Orange Pi build 
	
PHONY += config_uboot
config_uboot :
	@echo "+++++config uboot+++++" 
	@$(PWD)/script/config_uboot_source.sh 

PHONY += config_kernel
config_kernel :
	@echo "+++++config kernel+++++" 
	@$(PWD)/script/config_kernel_source.sh

PHONY += linux
PHONY += kernel
linux kernel :
	@echo "+++++build kernel+++++" | tee  $(OPI_OUTPUT_DIR)/build_kernel.log
	@$(PWD)/script/make_kernel.sh 2>&1 | tee -a  $(OPI_OUTPUT_DIR)/build_kernel.log
	
PHONY += uboot
PHONY += bootloader
uboot bootloader :
	@echo "+++++build u-boot+++++" | tee  $(OPI_OUTPUT_DIR)/build_uboot.log
	@$(PWD)/script/make_uboot.sh 2>&1 | tee -a $(OPI_OUTPUT_DIR)/build_uboot.log

PHONY += modules
modules :
	@echo "+++++build kernel modules+++++" | tee $(OPI_OUTPUT_DIR)/build_modules.log
	@$(PWD)/script/make_module.sh 2>&1 | tee -a  $(OPI_OUTPUT_DIR)/build_modules.log
	
PHONY += image
image :
	@echo "Script run sudo , Please authorize :" | tee  $(OPI_OUTPUT_DIR)/build_image.log
	@sudo $(PWD)/script/make_image.sh $(sdcard) 2>&1 | tee -a $(OPI_OUTPUT_DIR)/build_image.log

PHONY += rootfs
rootfs :
	@echo "Script run sudo , Please authorize :"
	@sudo $(PWD)/script/make_rootfs.sh $(OPI_SYSTEM_OUTPUT_DIR) $(OPI_SYSTEM_TYPE) $(OPI_SYSTEM_VERSION) 2>&1 | tee $(OPI_OUTPUT_DIR)/build_rootfs.log

PHONY += install_uboot
install_uboot :
	@echo "Script run sudo , Please authorize :"
	@sudo $(PWD)/script/install_uboot.sh $(sdcard)

PHONY += install_kernel
install_kernel :
	@echo "Script run sudo , Please authorize :"
	@sudo $(PWD)/script/install_kernel.sh $(sdcard)

PHONY += install_rootfs
install_rootfs :
	@echo "Script run sudo , Please authorize :"
	@sudo $(PWD)/script/install_rootfs.sh $(sdcard)

PHONY += update_uboot
update_uboot :
	@echo "Script run sudo , Please authorize :"
	@sudo $(PWD)/script/update_uboot.sh $(sdcard)

PHONY += update_kernel
update_kernel :
	@echo "Script run sudo , Please authorize :"
	@sudo $(PWD)/script/update_kernel.sh $(sdcard)

PHONY += test
test :
	@echo $(OPI_OUTPUT_DIR)
	#@$(PWD)/script/init.sh

PHONY += clean
clean :
	@echo "clear sdk..."
	@echo "run sudo , Please authorize :"
	@-sudo rm -rf output/dtb/*
	@-sudo rm -rf output/kernel/*
	@-sudo rm -rf output/u-boot/*
	@-sudo rm -rf output/rootfs/*
	@-sudo rm -rf output/sdcard/*
	@-sudo rm -rf output/*.log
	@cd $(OPI_K_source) && $(MAKE)  distclean
	@cd $(OPI_U_source) && $(MAKE)  distclean
	

.PHONY: $(PHONY)


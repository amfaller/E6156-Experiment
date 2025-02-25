CC := gcc-14

obj-m += malwareDriver.o
KDIR := /lib/modules/$(shell uname -r)/build
PWD := $(shell pwd)

all:
	make -C $(KDIR) M=$(PWD) modules CC=$(CC)

clean:
	make -C $(KDIR) M=$(PWD) clean

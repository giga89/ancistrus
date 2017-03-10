include ../Settings.mak

DIRLIST			:=
TARLIST			:=

BUILTINLIB		:=
BUILTIN			:=
THIRDPARTYLIB		:=
THIRDPARTY		:=
SUBDIRS			:=

$(PROJECT_NAME)		:= $(PROJECT_NAME)_core-0.0.0
DL_$(PROJECT_NAME)	:= void
TAR_$(PROJECT_NAME)	:= void

NVRAM			:= nvram
DL_$(NVRAM)		:= $(SRC_APPS_REL_DIR)
TAR_$(NVRAM)		:= nvram
DIRLIST			+= $(NVRAM)

UTELNETD		:= utelnetd-0.1.11
DL_$(UTELNETD)		:= http://public.pengutronix.de/software/utelnetd
TAR_$(UTELNETD)		:= utelnetd-0.1.11.tar.gz
DIRLIST			+= $(UTELNETD)
TARLIST			+= $(TAR_$(UTELNETD))

IPROUTE2		:= iproute2-4.10.0
DL_$(IPROUTE2)		:= https://www.kernel.org/pub/linux/utils/net/iproute2
TAR_$(IPROUTE2)		:= iproute2-4.10.0.tar.gz
DIRLIST			+= $(IPROUTE2)
TARLIST			+= $(TAR_$(IPROUTE2))

QOS_SQM			:= qos-sqm-scripts-0.0.0
DL_$(QOS_SQM)		:= void
TAR_$(QOS_SQM)		:= void

QOS_NG_36_42N		:= qos-netgear-36_42n
DL_$(QOS_NG_36_42N)	:= void
TAR_$(QOS_NG_36_42N)	:= void

BUILTINLIB 		+= $(NVRAM)
#THIRDPARTY		+= $($(PROJECT_NAME))
ifndef LOCAL
BUILTIN			+= $(UTELNETD)
BUILTIN			+= $(IPROUTE2)
THIRDPARTY		+= $(QOS_SQM)
#THIRDPARTY		+= $(QOS_NG_36_42N)
endif

SUBDIRS			+= $(BUILTINLIB)
SUBDIRS			+= $(THIRDPARTYLIB)
SUBDIRS			+= $(BUILTIN)
SUBDIRS			+= $(THIRDPARTY)

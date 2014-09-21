intermediates := $(local-intermediates-dir)

ifneq (,$(LIBBT_VENDORFILE))
        SRC := $(LIBBT_VENDORFILE)
else
        SRC := $(call my-dir)/include/$(addprefix vnd_, $(addsuffix .txt,$(basename $(TARGET_DEVICE))))
endif

ifeq (,$(wildcard $(SRC)))
# configuration file does not exist. Use default one
$(error using generic device for BBT. This is almost certainly wrong)
SRC := $(call my-dir)/include/vnd_generic.txt
endif
GEN := $(intermediates)/vnd_buildcfg.h
TOOL := $(TOP_DIR)external/bluetooth/bluedroid/tools/gen-buildcfg.sh

$(GEN): PRIVATE_PATH := $(call my-dir)
$(GEN): PRIVATE_CUSTOM_TOOL = $(TOOL) $< $@
$(GEN): $(SRC)  $(TOOL)
	$(transform-generated-source)

LOCAL_GENERATED_SOURCES += $(GEN)

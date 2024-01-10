## @file
#
#  Copyright (c) 2011-2015, ARM Limited. All rights reserved.
#  Copyright (c) 2014, Linaro Limited. All rights reserved.
#  Copyright (c) 2015 - 2016, Intel Corporation. All rights reserved.
#  Copyright (c) 2018, Bingxing Wang. All rights reserved.
#
#  SPDX-License-Identifier: BSD-2-Clause-Patent
#
##

################################################################################
#
# Defines Section - statements that will be processed to create a Makefile.
#
################################################################################
[Defines]
  PLATFORM_NAME                  = sweet
  PLATFORM_GUID                  = 318e5c55-1d4d-454c-a690-ca34755b963c
  PLATFORM_VERSION               = 0.1
  DSC_SPECIFICATION              = 0x00010005
  OUTPUT_DIRECTORY               = Build/sweetPkg
  SUPPORTED_ARCHITECTURES        = AARCH64
  BUILD_TARGETS                  = RELEASE|DEBUG
  SKUID_IDENTIFIER               = DEFAULT
  FLASH_DEFINITION               = sweetPkg/sweet.fdf
#  DISPLAY_USES_RGBA              = 0
  USE_DISPLAYDXE                 = 0
  AB_SLOT_SUPPORT                = 0

  # 0 = SM7150
  # 1 = SM7150-AB
  # 2 = SM7150-AC
  SOC_TYPE                       = 2

[BuildOptions.common]
  *_*_*_CC_FLAGS = -DSOC_TYPE=$(SOC_TYPE) -DDISPLAY_USES_RGBA=$(DISPLAY_USES_RGBA)

[LibraryClasses.common]
  DeviceMemoryMapLib|sweetPkg/Library/DeviceMemoryMapLib/DeviceMemoryMapLib.inf
  DeviceConfigurationMapLib|sweetPkg/Library/DeviceConfigurationMapLib/DeviceConfigurationMapLib.inf

[PcdsFixedAtBuild.common]
  # Device Specific
  gArmTokenSpaceGuid.PcdSystemMemoryBase|0x80000000                 # Starting Address
!if $(RAM_SIZE) == 8
  gArmTokenSpaceGuid.PcdSystemMemorySize|0x200000000                # 8GB Size
!elseif $(RAM_SIZE) == 6
  gArmTokenSpaceGuid.PcdSystemMemorySize|0x180000000                # 6GB Size
!else
!error "Invaild RAM Size! Use 8 or 6."
!endif

  gEfiMdeModulePkgTokenSpaceGuid.PcdFirmwareVendor|L"No Maintainer" # Device Maintainer

  gArmTokenSpaceGuid.PcdCpuVectorBaseAddress|0x9FF8C000

  gEmbeddedTokenSpaceGuid.PcdPrePiStackBase|0x9FF90000
  gEmbeddedTokenSpaceGuid.PcdPrePiStackSize|0x00040000              # 256K stack

  # SmBios
  gQcomPkgTokenSpaceGuid.PcdSmbiosSystemVendor|"Xiaomi Inc"
  gQcomPkgTokenSpaceGuid.PcdSmbiosSystemModel|"Redmi Note 10 Pro"
  gQcomPkgTokenSpaceGuid.PcdSmbiosSystemRetailModel|"M2101K6G"
  gQcomPkgTokenSpaceGuid.PcdSmbiosSystemRetailSku|"Redmi_Note_10_Pro_M2101K6G"
  gQcomPkgTokenSpaceGuid.PcdSmbiosBoardModel|"Redmi Note 10 Pro"

  # Simple FrameBuffer
  gQcomPkgTokenSpaceGuid.PcdMipiFrameBufferWidth|1080
  gQcomPkgTokenSpaceGuid.PcdMipiFrameBufferHeight|2400
  gQcomPkgTokenSpaceGuid.PcdMipiFrameBufferPixelBpp|32

[PcdsDynamicDefault.common]
  gEfiMdeModulePkgTokenSpaceGuid.PcdVideoHorizontalResolution|1080
  gEfiMdeModulePkgTokenSpaceGuid.PcdVideoVerticalResolution|2400
  gEfiMdeModulePkgTokenSpaceGuid.PcdSetupVideoHorizontalResolution|1080
  gEfiMdeModulePkgTokenSpaceGuid.PcdSetupVideoVerticalResolution|2400
  gEfiMdeModulePkgTokenSpaceGuid.PcdSetupConOutColumn|135
  gEfiMdeModulePkgTokenSpaceGuid.PcdSetupConOutRow|126
  gEfiMdeModulePkgTokenSpaceGuid.PcdConOutColumn|135
  gEfiMdeModulePkgTokenSpaceGuid.PcdConOutRow|126

!include SM7150Pkg/SM7150Pkg.dsc.inc
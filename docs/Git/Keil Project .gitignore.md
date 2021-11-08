# Keil Project .gitignore

Keil文件说明：
[https://www.keil.com/support/man/docs/uv4/uv4_b_filetypes.htm](https://www.keil.com/support/man/docs/uv4/uv4_b_filetypes.htm)

## Project Files under Version Control

Before setting up the workflow, the project manager should be absolutely clear about the files that need to be
version controlled. Of course all source code files need to be versioned, but there are a couple of files that are
special to µVision that need to be monitored as well.

- All user generated source files (*.c, *.cpp, *.h, *.inc, *.s)
- Project file: Project.uvprojx (is used to build the project from scratch)
- Project options file: Project.uvoptx (contains information about the debugger and trace configuration)
- Project file for multi-project workspaces: Project.uvmpw
- Configuration files for the run-time environment that are copied to the project (all files below .\RTE)
- List of #includes created by software components: RTE\RTE_Components.h file
- Device configuration file: for example RTE\Device\LPC1857\RTE_Device.h
- Linker control file (Project.sct) if created manually
- All relevant Pack files (for example ARM::CMSIS, Keil::Middleware, Device Family Packs, etc.)

## Files that do not need to be monitored

- Project screen layout file: Project.uvguix.username
- All files that are part of a Pack (the complete Pack will be revision controlled and is available to every
user as soon as he is installing it using Pack Installer)
- Generated output files in the sub-directories .\Listings and .\Objects
- INI files for debug adapters

## Template

```
# Timye .gitignore for Keil projects.
# Taken mostly from https://github.com/mrshrdlu/gitignore-keil/blob/master/keil.gitignore

# User-specific uVision files
*.opt
*.uvopt
*.uvoptx
*.uvgui
*.uvgui.*
*.uvguix.*

# Listing files
*.cod
*.htm
*.i
*.lst
*.map
*.m51
*.m66
# define exception below if needed
*.scr

# Object and HEX files
*.axf
*.b[0-3][0-9]
*.hex
*.d
*.crf
*.elf
*.hex
*.h86
*.lib
*.obj
*.o
*.sbr

# Build files
# define exception below if needed
*.bat
*._ia
*.__i
*._ii

# Generated output files
**/Listings/*
**/Objects/*
**/output/*
**/RTE/*

# Debugger files
# define exception below if needed
*.ini
*.dbgconf

# Other files
*.build_log.htm
*.cdb
*.dep
*.ic
*.lin
*.lnp
*.orc
# define exception below if needed
*.pack
# define exception below if needed
*.pdsc
*.plg
# define exception below if needed
*.sct
*.sfd
*.sfr
*.scvd

# Miscellaneous
*.tra
*.bin
*.fed
*.l1p
*.l2p
*.iex

# Special source files
# bootloader.c

# To explicitly override the above, define any exceptions here; e.g.:
# !my_customized_scatter_file.sct
```
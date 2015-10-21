/*
 * hw_ver.c
 *
 * Copyright (C) 2015 OMNI ROM
 *
 * by Victor B. M. Roque <victor.rooque@gmail.com> 
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <fcntl.h>
#include "log.h"

#define BOOTINFO_PATH   "/sys/bootinfo/hw_version"
#define BUF_SIZE         64

#define HW_MAJOR_VERSION_SHIFT 4
#define HW_MAJOR_VERSION_MASK  0xF0
#define HW_MINOR_VERSION_SHIFT 0
#define HW_MINOR_VERSION_MASK  0x0F

static char buff_tmp[BUF_SIZE];

static int read_file3(const char *fname, char *data, int max_size)
{
    int fd, rc;

    if (max_size < 1)
        return 0;

    fd = open(fname, O_RDONLY);
    if (fd < 0) {
        ERROR("failed to open '%s'\n", fname);
        return 0;
    }

    rc = read(fd, data, max_size - 1);
    if ((rc > 0) && (rc < max_size))
        data[rc] = '\0';
    else
        data[0] = '\0';
    close(fd);

    return 1;
}

unsigned long get_hw_version(){
    int rc = 0;
    unsigned long hw_ul;

    rc = read_file3(BOOTINFO_PATH, buff_tmp, sizeof(buff_tmp));
    if(rc) {
        hw_ul = strtoul(buff_tmp, NULL, 0);
        return hw_ul;    
    } else {
        return 75;
    }
    
}

unsigned long get_hw_version_major() {
	return ((get_hw_version() & HW_MAJOR_VERSION_MASK) >> HW_MAJOR_VERSION_SHIFT);
}

unsigned long get_hw_version_minor() {
	return ((get_hw_version() & HW_MINOR_VERSION_MASK) >> HW_MINOR_VERSION_SHIFT);
}

unsigned long real_hw_version() {
        return ((get_hw_version_major() * 10) + get_hw_version_minor());
}

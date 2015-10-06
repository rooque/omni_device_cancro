/*
 * mixer_path_cancro.c
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

const char *v3_mixer_paths[] = {"mixer_paths_3_1.xml", "mixer_paths_3_1_forte.xml", "mixer_paths_3_2.xml", "mixer_paths_3_2_forte.xml"};
const char *v4_mixer_paths[] = {"mixer_paths_4_x.xml", "mixer_paths_4_x_forte.xml"};
const char *v5_mixer_paths[] = {"mixer_paths_5_x.xml", "mixer_paths_5_x_forte.xml"};

const char *v3_mixer_paths_auxpcm[] = {"mixer_paths_auxpcm_3_1.xml", "mixer_paths_auxpcm_3_2.xml"};
const char *v4_mixer_paths_auxpcm[] = {"mixer_paths_auxpcm_4_x.xml"};
const char *v5_mixer_paths_auxpcm[] = {"mixer_paths_auxpcm_5_x.xml"};

const char *mixer_paths_prefix = "/system/etc/";
const char *def_mixer_paths = "mixer_paths.xml";
const char *def_mixer_paths_aux = "mixer_paths_auxpcm.xml";

char *get_mixer_paths()
{
    unsigned long hw_major,hw_minor;
    char *tmp_mixer_paths;

    hw_major = get_hw_version_major();
    hw_minor = get_hw_version_minor();

    if(hw_major == 3){

        if(hw_minor == 1){
            
            tmp_mixer_paths = v3_mixer_paths[1];
        } else {
            
            tmp_mixer_paths = v3_mixer_paths[3];
        }


    } else if (hw_major == 4) {
        tmp_mixer_paths = v4_mixer_paths[1];
       

    } else if (hw_major == 5) {
        tmp_mixer_paths = v5_mixer_paths[1];
        

    } else {
        
        tmp_mixer_paths = def_mixer_paths;
 
    }

    return tmp_mixer_paths;    

}

char *get_mixer_paths_auxpcm()
{
    unsigned long hw_major,hw_minor;
    char *tmp_mixer_paths_aux;

    hw_major = get_hw_version_major();
    hw_minor = get_hw_version_minor();

    if(hw_major == 3){

        if(hw_minor == 1){
            tmp_mixer_paths_aux = v3_mixer_paths_auxpcm[0];
        } else {
            tmp_mixer_paths_aux = v3_mixer_paths_auxpcm[1];
        }

    } else if (hw_major == 4) {
        tmp_mixer_paths_aux = v4_mixer_paths_auxpcm[0];

    } else if (hw_major == 5) {
        tmp_mixer_paths_aux = v5_mixer_paths_auxpcm[0];

    } else {
        tmp_mixer_paths_aux = def_mixer_paths_aux;

    }

    return tmp_mixer_paths_aux; 

}

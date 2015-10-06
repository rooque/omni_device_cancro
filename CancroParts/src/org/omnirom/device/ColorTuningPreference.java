/*
 * Copyright (C) 2013 CyanogenMod Project
 * Copyright (C) 2013 The OmniROM Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.omnirom.device;

import android.content.Context;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;
import android.preference.DialogPreference;
import android.preference.PreferenceManager;
import android.util.AttributeSet;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.SeekBar;
import android.widget.TextView;

/**
 * Special preference type that allows configuration of both the ring volume and
 * notification volume.
 */
public class ColorTuningPreference extends DialogPreference implements OnClickListener {

    private static final String COLOR_FILE = "/sys/class/graphics/fb0/rgb";

    private static final int[] SEEKBAR_ID = new int[] {
        R.id.color_red_seekbar,
        R.id.color_green_seekbar,
        R.id.color_blue_seekbar
    };

    private static final int[] VALUE_DISPLAY_ID = new int[] {
        R.id.color_red_value,
        R.id.color_green_value,
        R.id.color_blue_value
    };

    
    private ColorSeekBar mSeekBars[] = new ColorSeekBar[3];

    private String accColor;
	

    // Track instances to know when to restore original color
    // (when the orientation changes, a new dialog is created before the old one is destroyed)
    private static int sInstances = 0;

    private static final int MAX_VALUE = 32768;

    private static final int MIN_VALUE = 255;

    private static final String DEF_VALUE = "32768 32768 32768";

    public ColorTuningPreference(Context context, AttributeSet attrs) {
        super(context, attrs);

        setDialogLayoutResource(R.layout.preference_dialog_color_tuning);
    }

    @Override
    protected void onBindDialogView(View view) {
        super.onBindDialogView(view);

        sInstances++;

        
         for (int i = 0; i < SEEKBAR_ID.length; i++) {
            SeekBar seekBar = (SeekBar) view.findViewById(SEEKBAR_ID[i]);
            TextView valueDisplay = (TextView) view.findViewById(VALUE_DISPLAY_ID[i]);
            mSeekBars[i] = new ColorSeekBar(seekBar, valueDisplay);
        }

         Utils.writeValue(COLOR_FILE, DEF_VALUE);

     

        SetupButtonClickListener(view);
    }

    private void SetupButtonClickListener(View view) {
        Button mResetButton = (Button)view.findViewById(R.id.color_reset);
        mResetButton.setOnClickListener(this);
    }

    @Override
    protected void onDialogClosed(boolean positiveResult) {
        super.onDialogClosed(positiveResult);

        sInstances--;

       if (positiveResult) {

           savePref();
           
           
        } else if (sInstances == 0) {
            for (ColorSeekBar csb : mSeekBars) {
                csb.reset();
            }
        }
    }

    /**
     * Restore screen color tuning from SharedPreferences. (Write to kernel.)
     * @param context       The context to read the SharedPreferences from
     */

    public static void restore(Context context) {
        if (!isSupported()) {
            return;
        }

        SharedPreferences sharedPrefs = PreferenceManager.getDefaultSharedPreferences(context);
       
            String value = sharedPrefs.getString(COLOR_FILE, DEF_VALUE);
            Utils.writeValue(COLOR_FILE, value);
        

    }

    /**
     * Check whether the running kernel supports color tuning or not.
     * @return              Whether color tuning is supported or not
     */
    public static boolean isSupported() {
        boolean supported = true;
        
            if (!Utils.fileExists(COLOR_FILE)) {
                supported = false;
            }
        
        return supported;
    }


   public String getRGBfromSBs(){
   String color="";

   for (ColorSeekBar csb : mSeekBars) {
	color+=" " + String.valueOf(csb.getProgress());
            }
    

   accColor=color;
   return color;

   }

   public void updateColorFile(){

   Utils.writeValue(COLOR_FILE, getRGBfromSBs());


   }

   public void savePref(){


            Editor editor = getEditor();
            editor.putString(COLOR_FILE, accColor);
            editor.commit();


   }

    class ColorSeekBar implements SeekBar.OnSeekBarChangeListener {

        protected String mFilePath;
        protected int mOriginal;
        protected SeekBar mSeekBar;
        protected TextView mValueDisplay;

        public ColorSeekBar(SeekBar seekBar, TextView valueDisplay) {
            mSeekBar = seekBar;
            mValueDisplay = valueDisplay;
            

            // Read original value
            SharedPreferences sharedPreferences = getSharedPreferences();
           

            seekBar.setMax(MAX_VALUE);
            reset();
            seekBar.setOnSeekBarChangeListener(this);
        }

        // For inheriting class
        protected ColorSeekBar() {
        }

        public int getProgress(){
        return mSeekBar.getProgress();
        }

        public void reset() {
            mSeekBar.setProgress(MAX_VALUE);
            updateValue(MAX_VALUE);
        }

        @Override
        public void onProgressChanged(SeekBar seekBar, int progress,
                boolean fromUser) {
            updateColorFile();
            updateValue(progress);
        }

        @Override
        public void onStartTrackingTouch(SeekBar seekBar) {
            // Do nothing
        }

        @Override
        public void onStopTrackingTouch(SeekBar seekBar) {
            // Do nothing
        }

        protected void updateValue(int progress) {
            mValueDisplay.setText(String.format("%.3f", (double) progress / MAX_VALUE));
        }

        public void resetDefault(int value) {
            mSeekBar.setProgress(value);
            updateValue(value);
            
        }

    }

    


    public void onClick(View v) {
        switch(v.getId()) {
            case R.id.color_reset:
                    for (int i = 0; i < SEEKBAR_ID.length; i++) {
                    mSeekBars[i].resetDefault(MAX_VALUE);
                }
                    
                    Utils.writeValue(COLOR_FILE, DEF_VALUE);
                
                break;
        }
    }

}

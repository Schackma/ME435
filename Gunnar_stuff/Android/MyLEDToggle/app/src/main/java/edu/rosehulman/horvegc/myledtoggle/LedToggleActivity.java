package edu.rosehulman.horvegc.myledtoggle;

import android.graphics.Color;
import android.os.Bundle;
import android.view.View;
import android.widget.SeekBar;
import android.widget.Toast;

import edu.rosehulman.me435.AccessoryActivity;
import edu.rosehulman.me435.TextToSpeechHelper;

public class LedToggleActivity extends AccessoryActivity {

    private TextToSpeechHelper mTts;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_led_toggle);
        final SeekBar sk = (SeekBar) findViewById(R.id.lightBar);
        sk.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            @Override
            public void onStopTrackingTouch(SeekBar seekBar) {
            }

            @Override
            public void onStartTrackingTouch(SeekBar seekBar) {
            }

            @Override
            public void onProgressChanged(SeekBar seekBar, int progress,boolean fromUser) {
                //Toast.makeText(getApplicationContext(), String.valueOf(progress),Toast.LENGTH_SHORT).show();
                sendCommand("light:"+progress);
            }
        });
    }

    @Override
    protected void onStart() {
        super.onStart();
        mTts = new TextToSpeechHelper(this);
    }

    @Override
    protected void onStop() {
        super.onStop();
        mTts.shutdown();
    }

    public void handleLedOn(View view) {
        sendCommand("ON");
    }

    public void handleLedOff(View view) {
        sendCommand("OFF");
    }

    @Override
    protected void onCommandReceived(String receivedCommand) {
        super.onCommandReceived(receivedCommand);
        Toast.makeText(this, "Recieved: " + receivedCommand, Toast.LENGTH_SHORT).show();

        if (receivedCommand.toLowerCase().contains("left")) {
            findViewById(android.R.id.content).setBackgroundColor(Color.GREEN);
            mTts.speak(receivedCommand);
        } else if (receivedCommand.toLowerCase().contains("right")) {
            findViewById(android.R.id.content).setBackgroundColor(Color.BLACK);
            mTts.speak(receivedCommand);
        }
    }


}
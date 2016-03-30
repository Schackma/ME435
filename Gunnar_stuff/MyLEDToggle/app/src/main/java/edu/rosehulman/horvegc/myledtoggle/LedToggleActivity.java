package edu.rosehulman.horvegc.myledtoggle;

import android.os.Bundle;
import android.view.View;
import android.widget.Toast;

import edu.rosehulman.me435.AccessoryActivity;

public class LedToggleActivity extends AccessoryActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_led_toggle);
    }

    public void handleLedOn(View view) {
        Toast.makeText(this, "LED On", Toast.LENGTH_SHORT).show();
        sendCommand("On");
    }

    public void handleLedOff(View view) {
        Toast.makeText(this, "LED Off", Toast.LENGTH_SHORT).show();
        sendCommand("Off");
    }
}

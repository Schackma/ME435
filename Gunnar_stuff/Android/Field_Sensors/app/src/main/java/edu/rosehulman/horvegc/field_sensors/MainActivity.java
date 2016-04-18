package edu.rosehulman.horvegc.field_sensors;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.TextView;
import android.widget.Toast;



public class MainActivity extends AppCompatActivity {

    private TextView mGpsXTextView;
    private TextView mGpsYTextView;
    private TextView mGpsHeadingTextView;
    private TextView mGpsCounterTextView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        mGpsXTextView = (TextView) findViewById(R.id.x_value_disp);
        mGpsYTextView = (TextView) findViewById(R.id.y_value_disp);
        mGpsHeadingTextView = (TextView) findViewById(R.id.heading_value_disp);
        mGpsCounterTextView = (TextView) findViewById(R.id.gps_counter_disp);
    }

    public void handleSetxAxis(View view) {
        Toast.makeText(this, "You pressed 'Set X-Axis'", Toast.LENGTH_SHORT).show();
    }

    public void handleSetOrigin(View view) {
        Toast.makeText(this, "You pressed 'Set Origin'", Toast.LENGTH_SHORT).show();
    }
}

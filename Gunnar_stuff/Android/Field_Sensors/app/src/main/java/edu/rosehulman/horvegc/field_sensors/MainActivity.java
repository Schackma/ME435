package edu.rosehulman.horvegc.field_sensors;

import android.location.Location;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.view.WindowManager;
import android.widget.TextView;
import android.widget.ToggleButton;

import edu.rosehulman.me435.FieldGps;
import edu.rosehulman.me435.FieldGpsListener;
import edu.rosehulman.me435.FieldOrientation;
import edu.rosehulman.me435.FieldOrientationListener;


public class MainActivity extends AppCompatActivity implements FieldGpsListener, FieldOrientationListener {

    private int mGpsCounter = 0;
    private FieldGps mFieldGps;
    private TextView mGpsXTextView;
    private TextView mGpsYTextView;
    private TextView mGpsHeadingTextView;
    private TextView mGpsCounterTextView;
    private TextView mSensorHeadingTextView;
    private FieldOrientation mFieldOrientation;
    private boolean mSetFieldOrientationWithGpsheading = false;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        
        mFieldGps = new FieldGps(this);
        mFieldOrientation = new FieldOrientation(this);

        getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);

        mGpsXTextView = (TextView) findViewById(R.id.x_value_disp);
        mGpsYTextView = (TextView) findViewById(R.id.y_value_disp);
        mGpsHeadingTextView = (TextView) findViewById(R.id.heading_value_disp);
        mGpsCounterTextView = (TextView) findViewById(R.id.gps_counter_disp);
        mSensorHeadingTextView = (TextView) findViewById(R.id.sendor_heading_textview);
    }

    @Override
    protected void onStart() {
        super.onStart();
        mFieldGps.requestLocationUpdates(this);
        mFieldOrientation.registerListener(this);
    }

    @Override
    protected void onStop() {
        super.onStop();
        mFieldGps.removeUpdates();
        mFieldOrientation.unregisterListener();
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        mFieldGps.requestLocationUpdates(this);
    }

    public void handleSetxAxis(View view) {
//        Toast.makeText(this, "You pressed 'Set X-Axis'", Toast.LENGTH_SHORT).show();
        mFieldGps.setCurrentLocationAsLocationOnXAxis();
    }

    public void handleSetOrigin(View view) {
//        Toast.makeText(this, "You pressed 'Set Origin'", Toast.LENGTH_SHORT).show();
        mFieldGps.setCurrentLocationAsOrigin();
    }

    public void handleSetHeadingTo0(View view) {
        mFieldOrientation.setCurrentFieldHeading(0);
    }

    public void handleToggle(View view) {
        ToggleButton tb = (ToggleButton) view;
        mSetFieldOrientationWithGpsheading = tb.isChecked();
    }

    @Override
    public void onLocationChanged(double x, double y, double heading, Location location) {
        mGpsCounter++;
        mGpsCounterTextView.setText(""+mGpsCounter);
        mGpsXTextView.setText((int) x + " ft");
        mGpsYTextView.setText((int) y + " ft");
        if (heading > -180.0 && heading <= 180.0) {
            mGpsHeadingTextView.setText((int) heading + "°");
            if(mSetFieldOrientationWithGpsheading) {
                mFieldOrientation.setCurrentFieldHeading(heading);
            }
        } else {
            mGpsHeadingTextView.setText("--");
        }
    }

    @Override
    public void onSensorChanged(double fieldHeading, float[] orientationValues) {
        mSensorHeadingTextView.setText((int) fieldHeading + "°");
    }
}
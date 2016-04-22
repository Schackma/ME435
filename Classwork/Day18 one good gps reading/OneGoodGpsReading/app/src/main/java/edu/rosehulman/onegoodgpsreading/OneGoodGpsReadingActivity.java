package edu.rosehulman.onegoodgpsreading;

import android.location.Location;
import android.os.Bundle;
import android.os.Handler;
import android.support.annotation.NonNull;
import android.view.View;
import android.view.WindowManager;
import android.widget.TextView;
import android.widget.Toast;

import java.util.Timer;

import me435.AccessoryActivity;
import me435.FieldGps;
import me435.FieldGpsListener;
import me435.FieldOrientationListener;

public class OneGoodGpsReadingActivity extends AccessoryActivity implements FieldGpsListener, FieldOrientationListener {
    // Various constants and member variable names.
    private static final String TAG = "OneGoodGps";
    private static final double NO_HEADING_KNOWN = 360.0;
    private TextView mCurrentStateTextView, mStateTimeTextView, mGpsInfoTextView, mSensorOrientationTextView;
    private FieldGps mFieldGps;
    private int mGpsCounter = 0;
    private double mCurrentGpsX, mCurrentGpsY, mCurrentGpsHeading;
    private double mCurrentSensorHeading;
    private Handler mCommandHandler = new Handler();
    private Timer mTimer;
    public static final int LOOP_INTERVAL_MS = 100;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_one_good_gps_reading);
        getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
        mCurrentStateTextView = (TextView) findViewById(R.id.current_state_textview);
        mStateTimeTextView = (TextView) findViewById(R.id.state_time_textview);
        mGpsInfoTextView = (TextView) findViewById(R.id.gps_info_textview);
        mSensorOrientationTextView = (TextView) findViewById(R.id.orientation_textview);
        mFieldGps = new FieldGps(this);
    }


    public void handleRedTeamGo(View view) {
        Toast.makeText(this, "You clicked Red Team Go!", Toast.LENGTH_SHORT).show();
    }

    public void handleBlueTeamGo(View view) {
        Toast.makeText(this, "You clicked Blue Team Go!", Toast.LENGTH_SHORT).show();
    }

    public void handleFakeGps(View view) {
        Toast.makeText(this, "You clicked Fake GPS Signal", Toast.LENGTH_SHORT).show();
    }

    public void handleMissionComplete(View view) {
        Toast.makeText(this, "You clicked Mission Complete!", Toast.LENGTH_SHORT).show();
        sendCommand("CUSTOM: gunnar is dumb!");
    }

    @Override
    protected void onCommandReceived(String receivedCommand) {
        super.onCommandReceived(receivedCommand);
        Toast.makeText(this, "Received: "+receivedCommand, Toast.LENGTH_SHORT).show();
    }

    @Override
    public void onLocationChanged(double x, double y, double heading, Location location) {
        mGpsCounter++;
        mCurrentGpsX = x;
        mCurrentGpsY = y;
        mCurrentGpsHeading = NO_HEADING_KNOWN;
        String gpsInfo = getString(R.string.xy_format,x,y);
        if (heading > -180.0 && heading <= 180.0) {
            gpsInfo += getString(R.string.degrees_format,heading);
            mSensorOrientationTextView.setText((int) heading + "°");
//            mFieldOrientation.setCurrentFieldHeading(heading);
            mCurrentGpsHeading = heading;
        }else{
            gpsInfo +=" ?°";
        }
        gpsInfo+="   "+mGpsCounter;
        mGpsInfoTextView.setText(gpsInfo);
    }

    @Override
    public void onSensorChanged(double fieldHeading, float[] orientationValues) {
        mCurrentSensorHeading = fieldHeading;
        mSensorOrientationTextView.setText(getString(R.string.degrees_format,fieldHeading));
    }

    @Override
    protected void onStart() {
        super.onStart();
//        mFieldGps.requestLocationUpdates(this);
//        mFieldOrientation.registerListener(this);
    }

    @Override
    protected void onStop() {
        super.onStop();
        mFieldGps.removeUpdates();
//        mFieldOrientation.unregisterListener();
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        mFieldGps.requestLocationUpdates(this);
    }
}

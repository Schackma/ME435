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
import me435.FieldOrientation;
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

    private FieldOrientation mFieldOrientation;
    public enum State{
        READY_FOR_MISSION, FIGURE_8_RED_SCRIPT, FIGURE_8_BLUE_SCRIPT, WAITING_FOR_GPS, DRIVING_HOME, SEEKING_HOME,WAITING_FOR_PICKUP
    }
    private State mState = State.READY_FOR_MISSION;
    private long mStateStartTime;

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
        mFieldOrientation = new FieldOrientation(this);
        setState(State.READY_FOR_MISSION);
    }


    public void handleRedTeamGo(View view) {
        if(mState == State.READY_FOR_MISSION) { setState(State.FIGURE_8_RED_SCRIPT); }
    }

    public void handleBlueTeamGo(View view) {
        if(mState == State.READY_FOR_MISSION) { setState(State.FIGURE_8_BLUE_SCRIPT); }
    }

    public void handleFakeGps(View view) {
        Toast.makeText(this, "You clicked Fake GPS Signal", Toast.LENGTH_SHORT).show();
    }

    public void handleMissionComplete(View view) {
        if(mState == State.WAITING_FOR_PICKUP) { setState(State.READY_FOR_MISSION); }
        sendCommand("CUSTOM: schack is dumb!");
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
            mFieldOrientation.setCurrentFieldHeading(heading);
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
        mFieldOrientation.registerListener(this);
//        mFieldGps.requestLocationUpdates(this);
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

    private void setState(State newState){
        mStateStartTime = System.currentTimeMillis();
        mCurrentStateTextView.setText(newState.name());

        switch(newState) {
            case READY_FOR_MISSION:
                break;
            case FIGURE_8_RED_SCRIPT:
                break;
            case FIGURE_8_BLUE_SCRIPT:
                break;
            case WAITING_FOR_GPS:
                break;
            case DRIVING_HOME:
                break;
            case SEEKING_HOME:
                break;
            case WAITING_FOR_PICKUP:
                break;
        }

        mState = newState;

    }

    private long getStateTimeMs(){
        return System.currentTimeMillis()-mStateStartTime;
    }

    private void runRedScript() {
        Toast.makeText(this, "Red", Toast.LENGTH_SHORT).show();
        sendCommand("WHEEL SPEED FORWARD 175 FORWARD 200");

        mCommandHandler.postDelayed(new Runnable() {
            @Override
            public void run() {
                Toast.makeText(OneGoodGpsReadingActivity.this, "Driving", Toast.LENGTH_SHORT).show();
                sendCommand("WHEEL SPEED FORWARD 150 FORWARD 175");
            }
        }, 2000);
        mCommandHandler.postDelayed(new Runnable() {
            @Override
            public void run() {
                sendCommand("WHEEL SPEED FORWARD 150 FORWARD 150");
                setState(State.WAITING_FOR_GPS);
            }
        }, 4000);
    }

    private void runBlueScript() {
        Toast.makeText(this, "Blue", Toast.LENGTH_SHORT).show();
        sendCommand("WHEEL SPEED FORWARD 200 FORWARD 175");

        mCommandHandler.postDelayed(new Runnable() {
            @Override
            public void run() {
                Toast.makeText(OneGoodGpsReadingActivity.this, "Driving", Toast.LENGTH_SHORT).show();
                sendCommand("WHEEL SPEED FORWARD 175 FORWARD 150");
            }
        }, 2000);
        mCommandHandler.postDelayed(new Runnable() {
            @Override
            public void run() {
                sendCommand("WHEEL SPEED FORWARD 150 FORWARD 150");
                setState(State.WAITING_FOR_GPS);
            }
        }, 4000);
    }

    private void runHomeScript() {
        Toast.makeText(this, "Driving", Toast.LENGTH_SHORT).show();
        sendCommand("WHEEL SPEED FORWARD 150 FORWARD 250");

        mCommandHandler.postDelayed(new Runnable() {
            @Override
            public void run() {
                Toast.makeText(OneGoodGpsReadingActivity.this, "Home", Toast.LENGTH_SHORT).show();
            }
        }, 3000);
        mCommandHandler.postDelayed(new Runnable() {
            @Override
            public void run() {
                sendCommand("WHEEL SPEED BRAKE 0 BRAKE 0");
                setState(State.WAITING_FOR_PICKUP);
            }
        }, 5000);
    }
}
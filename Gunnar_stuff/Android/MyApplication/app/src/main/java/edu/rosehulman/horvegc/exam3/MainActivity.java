package edu.rosehulman.horvegc.exam3;

import android.location.Location;
import android.os.Bundle;
import android.os.Handler;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.TextView;
import android.widget.Toast;

import java.util.Timer;
import java.util.TimerTask;

import me435.FieldGps;
import me435.FieldGpsListener;
import me435.FieldOrientation;
import me435.FieldOrientationListener;

import static me435.NavUtils.getDistance;
import static me435.NavUtils.getTargetHeading;

public class MainActivity extends AppCompatActivity implements FieldGpsListener, FieldOrientationListener {
    private TextView mStateDisp, mTimeDisp, mGpsDisp, mSensorHeadingDisp, mXyGuessDisp, mTargetHeadingDisp, mTurnAmountDisp, mCommandDisp;
    private double mCurrentGpsY, mCurrentGpsX, mCurrentSensorHeading, mGuessX, mGuessY;
    private FieldOrientation mFieldOrientation;

    public enum State{ WAITING_FOR_GPS, SEEKING_HOME, CORRECTIVE_SCRIPT, STRAIGHT_TO_TRY_FOR_GPS }
    private State mState = State.WAITING_FOR_GPS;

    public static final int LOOP_INTERVAL_MS = 100;
    private long mStateStartTime;
    private Timer mTimer;

    int wrongDirCounter = 0;
    private int SPEED = 3;
    private Handler mCommandHandler = new Handler();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        mStateDisp = (TextView) findViewById(R.id.state_disp);
        mTimeDisp = (TextView) findViewById(R.id.time_disp);
        mGpsDisp = (TextView) findViewById(R.id.gps_disp);
        mSensorHeadingDisp = (TextView) findViewById(R.id.sensor_heading_disp);
        mXyGuessDisp = (TextView) findViewById(R.id.xy_guess_disp);
        mTargetHeadingDisp = (TextView) findViewById(R.id.target_heading_disp);
        mTurnAmountDisp = (TextView) findViewById(R.id.turn_amount_disp);
        mCommandDisp = (TextView) findViewById(R.id.command_disp);

        mFieldOrientation = new FieldOrientation(this);
        setState(mState);
    }

    @Override
    protected void onStart() {
        super.onStart();
        mFieldOrientation.registerListener(this);
        mTimer = new Timer();
        mTimer.scheduleAtFixedRate(new TimerTask() {
            @Override
            public void run() {
                runOnUiThread(new Runnable() {
                    public void run() {
                        loop();
                    }
                });
            }
        }, 0, LOOP_INTERVAL_MS);
    }

    @Override
    protected void onStop() {
        super.onStop();
        mFieldOrientation.unregisterListener();
    }

    public void handle_20_0(View view) { onLocationChanged(20, 0, FieldGps.NO_BEARING_AVAILABLE, null); }
    public void handle_40_0(View view) { onLocationChanged(40, 0, FieldGps.NO_BEARING_AVAILABLE, null); }
    public void handle_60_0(View view) { onLocationChanged(60, 0, FieldGps.NO_BEARING_AVAILABLE, null); }
    public void handle_80_0(View view) { onLocationChanged(80, 0, FieldGps.NO_BEARING_AVAILABLE, null); }
    public void handle_100_0(View view) { onLocationChanged(100, 0, FieldGps.NO_BEARING_AVAILABLE, null); }
    public void handle_0_deg(View view) { onStop(); onSensorChanged(0,null); }
    public void handle_90_deg(View view) { onSensorChanged(90,null); onStop(); }
    public void handle_neg_90_deg(View view) { onStop(); onSensorChanged(-90,null); }
    public void handle_180_deg(View view) { onStop(); onSensorChanged(180,null); }

    private void setState(State newState){
        mStateStartTime = System.currentTimeMillis();

        mStateDisp.setText(newState.name());
        switch(newState) {
            case WAITING_FOR_GPS:
                break;
            case SEEKING_HOME:
                break;
            case CORRECTIVE_SCRIPT:
                correctiveScript();
                break;
            case STRAIGHT_TO_TRY_FOR_GPS:
                break;
        }

        mState = newState;
    }

    private long getStateTimeMs(){
        return System.currentTimeMillis()-mStateStartTime;
    }

    public void loop(){
        mTimeDisp.setText(""+getStateTimeMs()/1000);
        mGuessX += SPEED * (double)LOOP_INTERVAL_MS / 1000.0 * Math.cos(Math.toRadians(mCurrentSensorHeading));
        mGuessY += SPEED * (double)LOOP_INTERVAL_MS / 1000.0 * Math.sin(Math.toRadians(mCurrentSensorHeading));
        mXyGuessDisp.setText(getString(R.string.xy_format,mGuessX,mGuessY));
        switch (mState) {
            case WAITING_FOR_GPS:
                if(getStateTimeMs() >= 5000){
                    setState(State.SEEKING_HOME);
                }
                break;
            case SEEKING_HOME:
                double targetHeading = getTargetHeading(mGuessX,mGuessY,0,0);
                double right = mCurrentSensorHeading - targetHeading; if(right < 0) { right += 360; }

                if(right <= 180) {
                    mTurnAmountDisp.setText("Right " + getString(R.string.degrees_format,right));
                    mCommandDisp.setText("SPEED FORWARD 255 FORWARD " + (int) (255 - right));
                } else {
                    mTurnAmountDisp.setText("Left " + getString(R.string.degrees_format,360-right));
                    mCommandDisp.setText("SPEED FORWARD " + (int) (255 - (360-right)) + " FORWARD 255");
                }

                mTargetHeadingDisp.setText(getString(R.string.degrees_format, targetHeading));

                break;
            case CORRECTIVE_SCRIPT:
                break;
            case STRAIGHT_TO_TRY_FOR_GPS:
                StraightForGpsLogic();
                break;
        }
    }

    private void StraightForGpsLogic() {
        TextView[] views = {mSensorHeadingDisp, mXyGuessDisp, mTargetHeadingDisp, mTurnAmountDisp, mCommandDisp};
        for(int i = 0; i < views.length; i++) { views[i].setText("---"); }
        if (getStateTimeMs() >= 4000) {
            setState(State.WAITING_FOR_GPS);
        }
    }

    public void handle_reset(View view) {
        TextView[] views = {mStateDisp, mTimeDisp, mGpsDisp, mSensorHeadingDisp, mXyGuessDisp, mTargetHeadingDisp, mTurnAmountDisp, mCommandDisp};
        for(int i = 0; i < views.length; i++) { views[i].setText("---"); }
        onLocationChanged(50, 0, FieldGps.NO_BEARING_AVAILABLE, null);
        mFieldOrientation.setFieldBearing(0);
        handle_0_deg(mSensorHeadingDisp);
        setState(State.WAITING_FOR_GPS );
    }

    @Override
    public void onLocationChanged(double x, double y, double heading, Location location) {
        correctionLogicCheck(x,y);
        mCurrentGpsX = x; mCurrentGpsY = y;
        mGuessX = x; mGuessY = y;
        mGpsDisp.setText(getString(R.string.xy_format, x, y));

    }

    private void correctionLogicCheck(double x, double y) {
        if(mState != State.SEEKING_HOME) { return; }
        if(getDistance(x,y,0,0) > getDistance(mCurrentGpsX,mCurrentGpsY,0,0)) {
            wrongDirCounter++;
        } else {
            wrongDirCounter = 0;
        }

        if(wrongDirCounter >= 3) {
            setState(State.CORRECTIVE_SCRIPT);
        }
    }

    @Override
    public void onSensorChanged(double fieldHeading, float[] orientationValues) {
        mCurrentSensorHeading = fieldHeading;
        mSensorHeadingDisp.setText(getString(R.string.degrees_format, fieldHeading));
    }

    private void correctiveScript() {
        Toast.makeText(MainActivity.this, "Correcting", Toast.LENGTH_SHORT).show();
        mCommandHandler.postDelayed(new Runnable() {
            @Override
            public void run() {
                Toast.makeText(MainActivity.this, "direction", Toast.LENGTH_SHORT).show();
            }
        }, 2000);
        mCommandHandler.postDelayed(new Runnable() {
            @Override
            public void run() {
                setState(State.STRAIGHT_TO_TRY_FOR_GPS);
            }
        }, 4000);
    }
}
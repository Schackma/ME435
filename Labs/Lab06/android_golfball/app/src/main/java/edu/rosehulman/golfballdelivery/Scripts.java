/*
TODO: redifine restPos so that it's not just 0's
TODO: actually call removeBallAtLocation from main script
TODO: ensure that LEFT, CENTER, and RIGHT are actually defined as the correct values
TODO: test code on physical robot
 */

package edu.rosehulman.golfballdelivery;

import android.os.Handler;
import android.widget.Toast;

import me435.NavUtils;
import me435.RobotActivity;

public class Scripts {

    private int LEFT = 1;
    private int CENTER = 2;
    private int RIGHT = 3;

    private int home[] = {0,90,0,-90,90};
    private int restPos[] = {0,0,0,0,0};

    private int killRight[] = {-19,119,-90,-147,96};
    private int killMid[] = {6,119,-90,-147,96};
    private int killLeft[] = {39,119,-90,-147,96};

    private int boop[] = { -43,119,-90,-147,96 };
    private int boopLeft[] = {79,119,-90,-147,96};

    /** Reference to the primary activity. */
    private GolfBallDeliveryActivity mGolfBallDeliveryActivity;

    /** Handler used to create scripts in this class. */
    protected Handler mCommandHandler = new Handler();

    /** Time in milliseconds needed to perform a ball removal. */
    private int ARM_REMOVAL_TIME_MS = 3000;

    /** Simple constructor. */
    public Scripts(GolfBallDeliveryActivity golfBallDeliveryActivity) {
        mGolfBallDeliveryActivity = golfBallDeliveryActivity;
    }


    /** Used to test your values for straight driving. */
    public void testStraightDriveScript() {
        Toast.makeText(mGolfBallDeliveryActivity, "Begin Short straight drive test at " +
                        mGolfBallDeliveryActivity.mLeftStraightPwmValue + "  " + mGolfBallDeliveryActivity.mRightStraightPwmValue,
                Toast.LENGTH_SHORT).show();
        mGolfBallDeliveryActivity.sendWheelSpeed(mGolfBallDeliveryActivity.mLeftStraightPwmValue, mGolfBallDeliveryActivity.mRightStraightPwmValue);
        mCommandHandler.postDelayed(new Runnable() {
            @Override
            public void run() {
                Toast.makeText(mGolfBallDeliveryActivity, "End Short straight drive test", Toast.LENGTH_SHORT).show();
                mGolfBallDeliveryActivity.sendWheelSpeed(0, 0);
            }
        }, 8000);
    }


    /** Runs the script to drive to the near ball (perfectly straight) and drop it off. */
    public void nearBallScript() {
        Toast.makeText(mGolfBallDeliveryActivity, "Drive 103 ft to near ball.", Toast.LENGTH_SHORT).show();
        double distanceToNearBall = NavUtils.getDistance(15, 0, 90, 50);
        long driveTimeToNearBallMs = (long) (distanceToNearBall / RobotActivity.DEFAULT_SPEED_FT_PER_SEC * 1000);
        driveTimeToNearBallMs = 3000; // Make this mock script not take so long.
        mGolfBallDeliveryActivity.sendWheelSpeed(mGolfBallDeliveryActivity.mLeftStraightPwmValue, mGolfBallDeliveryActivity.mRightStraightPwmValue);
        mCommandHandler.postDelayed(new Runnable() {
            @Override
            public void run() {
                removeBallAtLocation(mGolfBallDeliveryActivity.mNearBallLocation);
            }
        }, driveTimeToNearBallMs);
        mCommandHandler.postDelayed(new Runnable() {
            @Override
            public void run() {
                if (mGolfBallDeliveryActivity.mState == GolfBallDeliveryActivity.State.NEAR_BALL_SCRIPT) {
                    mGolfBallDeliveryActivity.setState(GolfBallDeliveryActivity.State.DRIVE_TOWARDS_FAR_BALL);
                }
            }
        }, driveTimeToNearBallMs + ARM_REMOVAL_TIME_MS);
    }


    /** Script to drop off the far ball. */
    public void farBallScript() {
        mGolfBallDeliveryActivity.sendWheelSpeed(0, 0);
        Toast.makeText(mGolfBallDeliveryActivity, "Figure out which ball(s) to remove and do it.", Toast.LENGTH_SHORT).show();
        removeBallAtLocation(mGolfBallDeliveryActivity.mFarBallLocation);
        mCommandHandler.postDelayed(new Runnable() {
            @Override
            public void run() {
                if (mGolfBallDeliveryActivity.mWhiteBallLocation != 0) {
                    removeBallAtLocation(mGolfBallDeliveryActivity.mWhiteBallLocation);
                }
                if (mGolfBallDeliveryActivity.mState == GolfBallDeliveryActivity.State.FAR_BALL_SCRIPT) {
                    mGolfBallDeliveryActivity.setState(GolfBallDeliveryActivity.State.DRIVE_TOWARDS_HOME);
                }
            }
        }, ARM_REMOVAL_TIME_MS);
    }


    // -------------------------------- Arm script(s) ----------------------------------------

    /** Removes a ball from the golf ball stand. */
    public void removeBallAtLocation(final int location) {

        mGolfBallDeliveryActivity.sendCommand("ATTACH 111111"); // Just in case
        mGolfBallDeliveryActivity.sendCommand("GRIPPER 50");    // Just in case

        mCommandHandler.postDelayed(new Runnable() {
            @Override
            public void run() {
                mGolfBallDeliveryActivity.sendCommand(String.format("POSITION %d %d %d %d %d",home[0], home[1], home[2], home[3], home[4], home[5]));
            }
        }, 10);
        mCommandHandler.postDelayed(new Runnable() {
            @Override
            public void run() {
                if(location == RIGHT) {
                    sendPos(killRight);
                } else if (location == CENTER) {
                    sendPos(killMid);
                } else if (location == LEFT) {
                    sendPos(killLeft);
                }
            }
        }, 2000);
        mCommandHandler.postDelayed(new Runnable() {
            @Override
            public void run() {
                if(location == LEFT) {
                    sendPos(boopLeft);
                } else {
                    sendPos(boop);
                }
                mGolfBallDeliveryActivity.setLocationToColor(location, GolfBallDeliveryActivity.BallColor.NONE);
            }
        }, 4000);
        mCommandHandler.postDelayed(new Runnable() {
            @Override
            public void run() {
                sendPos(restPos);
            }
        }, 5000);
        mCommandHandler.postDelayed(new Runnable() {
            @Override
            public void run() {
                sendPos(home);
                //actually change state
            }
        }, 7000);
    }

    private void sendPos(int toSend[]) {
        mGolfBallDeliveryActivity.sendCommand(String.format("POSITION %d %d %d %d %d",toSend[0], toSend[1], toSend[2], toSend[3], toSend[4], toSend[5]));
    }
}
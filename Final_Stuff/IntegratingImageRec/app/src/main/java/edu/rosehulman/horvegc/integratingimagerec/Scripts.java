/*
TODO: redifine restPos so that it's not just 0's
DONE: actually call removeBallAtLocation from main script
DONE: ensure that LEFT, CENTER, and RIGHT are actually defined as the correct values
TODO: test code on physical robot
 */

package edu.rosehulman.horvegc.integratingimagerec;

import android.os.Handler;
import android.widget.Toast;

import me435.NavUtils;
import me435.RobotActivity;

public class Scripts {

    private int LEFT = 1;
    private int CENTER = 2;
    private int RIGHT = 3;

    private int home[] = {0,90,0,-90,90};

    private int killRight[] = {-13,39,-87,-155,90};
    private int killMid[] = {9, 39, -87, -155, 90};
    private int killLeft[] = {47,39,-87,-155,90};

    private int boopRight[] = { -13,17, -87,-178,90 };
    private int boopMid[] ={9,17,-87,-178,90};
    private int boopLeft[] = {47,17,-87,-180,90};


    /** Reference to the primary activity. */
    private GolfBallDeliveryActivity mGolfBallDeliveryActivity;

    /** Handler used to create scripts in this class. */
    protected Handler mCommandHandler = new Handler();

    /** Time in milliseconds needed to perform a ball removal. */
    private int ARM_REMOVAL_TIME_MS = 8000;

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
                mGolfBallDeliveryActivity.setState(GolfBallDeliveryActivity.State.READY_FOR_MISSION);
            }
        }, 8000);
    }


    /** Runs the script to drive to the near ball (perfectly straight) and drop it off. */
    public void nearBallScript() {
        removeBallAtLocation(mGolfBallDeliveryActivity.mNearBallLocation,GolfBallDeliveryActivity.State.GO_TO_FAR_BALL_WITH_GPS);
    }


    /** Script to drop off the far ball. */
    public void farBallScript() {
        removeBallAtLocation(mGolfBallDeliveryActivity.mFarBallLocation, GolfBallDeliveryActivity.State.DRIVE_TOWARDS_HOME);
    }

    public void midBallScript(){
        if (mGolfBallDeliveryActivity.mWhiteBallLocation != 0) {
            removeBallAtLocation(mGolfBallDeliveryActivity.mWhiteBallLocation, GolfBallDeliveryActivity.State.DROP_FAR_BALL);
        }else{
            mGolfBallDeliveryActivity.setState(GolfBallDeliveryActivity.State.DROP_FAR_BALL);
        }
    }



    // -------------------------------- Arm script(s) ----------------------------------------

    /** Removes a ball from the golf ball stand. */
    public void removeBallAtLocation(final int location,final GolfBallDeliveryActivity.State newState) {

        mGolfBallDeliveryActivity.sendCommand("ATTACH 111111"); // Just in case
        mGolfBallDeliveryActivity.sendCommand("GRIPPER 55");    // Just in case

        mCommandHandler.postDelayed(new Runnable() {
            @Override
            public void run() {
                sendPos(home);
            }
        }, 10);
        Toast.makeText(mGolfBallDeliveryActivity,""+location,Toast.LENGTH_SHORT).show();


        mCommandHandler.postDelayed(new Runnable() {
            @Override
            public void run() {
                if(location == RIGHT) {
                    sendPos(killRight);
                } else if(location == LEFT){
                    sendPos(killLeft);
                }else{
                    sendPos(killMid);
                }
            }
        }, 2000);
        mCommandHandler.postDelayed(new Runnable() {
            @Override
            public void run() {
                if(location == LEFT) {
                    sendPos(boopLeft);
                } else if (location == RIGHT){
                    sendPos(boopRight);
                }else{
                    sendPos(boopMid);
                }
                mGolfBallDeliveryActivity.setLocationToColor(location, GolfBallDeliveryActivity.BallColor.NONE);
            }
        }, 4000);
        mCommandHandler.postDelayed(new Runnable() {
            @Override
            public void run() {
                sendPos(home);
                if(newState != null) {
                    mGolfBallDeliveryActivity.setState(newState);
                }
            }
        }, 5000);
    }

    private void sendPos(int toSend[]) {
        mGolfBallDeliveryActivity.sendCommand(String.format("POSITION %d %d %d %d %d",toSend[0], toSend[1], toSend[2], toSend[3], toSend[4]));
    }

    public void goToNearBallScript() {
        double distanceToNearBall = NavUtils.getDistance(15, 0, 90, 50);
        long driveTimeToNearBallMs = (long) (distanceToNearBall / RobotActivity.DEFAULT_SPEED_FT_PER_SEC * 1000);
        driveTimeToNearBallMs = 0; // Make this mock script not take so long.
        mGolfBallDeliveryActivity.sendWheelSpeed(mGolfBallDeliveryActivity.mLeftStraightPwmValue, mGolfBallDeliveryActivity.mRightStraightPwmValue);
        mCommandHandler.postDelayed(new Runnable() {
            @Override
            public void run() {
                mGolfBallDeliveryActivity.sendWheelSpeed(0, 0);
                mGolfBallDeliveryActivity.setState(GolfBallDeliveryActivity.State.DROP_NEAR_BALL);
            }
        }, driveTimeToNearBallMs);

    }

//    public void goToMidScript() {
//        double distanceToMidBall = NavUtils.getDistance(15, 0, 90, 50);
//        long driveTimeToMidBallMs = (long) (distanceToMidBall / RobotActivity.DEFAULT_SPEED_FT_PER_SEC * 1000);
//        driveTimeToMidBallMs = 1000; // Make this mock script not take so long.
//        mGolfBallDeliveryActivity.sendWheelSpeed(mGolfBallDeliveryActivity.mLeftStraightPwmValue, mGolfBallDeliveryActivity.mRightStraightPwmValue);
//        mCommandHandler.postDelayed(new Runnable() {
//            @Override
//            public void run() {
//                mGolfBallDeliveryActivity.sendWheelSpeed(0, 0);
//                mGolfBallDeliveryActivity.setState(GolfBallDeliveryActivity.State.MID_BALL_SCRIPT);
//            }
//        }, driveTimeToMidBallMs);
//
//    }

//    public void midBallScript() {
//        if (mGolfBallDeliveryActivity.mWhiteBallLocation != 0) {
//            removeBallAtLocation(mGolfBallDeliveryActivity.mWhiteBallLocation, GolfBallDeliveryActivity.State.GO_TO_FAR_BALL);
//        }else {
//            mGolfBallDeliveryActivity.setState(GolfBallDeliveryActivity.State.GO_TO_FAR_BALL);
//        }
//    }

    public void goToFarBallScript() {
        double distanceToFarBall = NavUtils.getDistance(15, 0, 90, 50);
        long driveTimeToFarBallMs = (long) (distanceToFarBall / RobotActivity.DEFAULT_SPEED_FT_PER_SEC * 1000);
        driveTimeToFarBallMs = 1000; // Make this mock script not take so long.
        mGolfBallDeliveryActivity.sendWheelSpeed(mGolfBallDeliveryActivity.mLeftStraightPwmValue, mGolfBallDeliveryActivity.mRightStraightPwmValue);
        mCommandHandler.postDelayed(new Runnable() {
            @Override
            public void run() {
                mGolfBallDeliveryActivity.sendWheelSpeed(0, 0);
                mGolfBallDeliveryActivity.setState(GolfBallDeliveryActivity.State.DROP_FAR_BALL);
            }
        }, driveTimeToFarBallMs);

    }

    public void driveTowardsHomeScript() {
        mGolfBallDeliveryActivity.sendWheelSpeed(-mGolfBallDeliveryActivity.mLeftStraightPwmValue, -mGolfBallDeliveryActivity.mRightStraightPwmValue);
        mCommandHandler.postDelayed(new Runnable() {
            @Override
            public void run() {
                mGolfBallDeliveryActivity.sendWheelSpeed(0, 0);
                mGolfBallDeliveryActivity.setState(GolfBallDeliveryActivity.State.READY_FOR_MISSION);}
        }, 2000);
    }
}
package edu.rosehulman.simplefsm;

import android.app.Activity;
import android.os.Bundle;
import android.os.Handler;
import android.view.View;
import android.widget.TextView;
import android.widget.Toast;

import java.util.Timer;
import java.util.TimerTask;

public class MainActivity extends Activity {

  private TextView mCurrentStateTextView, mStateTimeTextView;
  private long mStateStartTime;
  private Handler mCommandHandler = new Handler();

  public enum State{
    READY, RUNNING_A_SCRIPT, SEEKING_HOME, SUCCESS, MAGIC_CARPET, SEEKING_SOMEWHERE
  }

  private State mState = State.READY;
  private Timer mTimer;
  private static final int LOOP_INTERVAL_MS = 100;

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    setContentView(R.layout.activity_main);
    
    mCurrentStateTextView = (TextView) findViewById(R.id.current_state_textview);
    mStateTimeTextView = (TextView) findViewById(R.id.state_time_textview);
    setState(State.READY);
  }

  private void setState(State newState){
    mStateStartTime = System.currentTimeMillis();
    mCurrentStateTextView.setText(newState.name());

    switch(newState){
      case READY:
        break;
      case RUNNING_A_SCRIPT:
          runScript();
        break;
      case SEEKING_HOME:
        break;
      case SUCCESS:
        break;
      case MAGIC_CARPET:
          magic();
        break;
    }

    mState = newState;

  }


  public void handleGo(View view) {
    Toast.makeText(this, "You pressed Go!", Toast.LENGTH_SHORT).show();
    if(mState == State.READY){
      setState(State.RUNNING_A_SCRIPT);
    }

    if(mState == State.SEEKING_HOME){
        setState(State.SEEKING_SOMEWHERE);
    }
  }
  
  public void handleReset(View view) {
    Toast.makeText(this, "You pressed Reset", Toast.LENGTH_SHORT).show();
    if(mState == State.SEEKING_HOME || mState == State.SUCCESS) {
      setState(State.READY);
    }
  }
  
  public void handleHitTarget(View view) {
    Toast.makeText(this, "You pressed Hit Target", Toast.LENGTH_SHORT).show();
    if(mState == State.READY){
        setState(State.MAGIC_CARPET);
    }

    if(mState == State.SEEKING_HOME){
      setState(State.READY);
    }


  }

  private long getStateTimeMs(){
      return System.currentTimeMillis()-mStateStartTime;
  }

  private void runScript() {
      Toast.makeText(this, "Run script step 0", Toast.LENGTH_SHORT).show();
      mCommandHandler.postDelayed(new Runnable() {
          @Override
          public void run() {
              Toast.makeText(MainActivity.this, "Run script step 1", Toast.LENGTH_SHORT).show();
          }
      }, 2000);
      mCommandHandler.postDelayed(new Runnable() {
          @Override
          public void run() {
              Toast.makeText(MainActivity.this, "Run script step 2", Toast.LENGTH_SHORT).show();
          }
      }, 4000);
      mCommandHandler.postDelayed(new Runnable() {
          @Override
          public void run() {
              if (mState == State.RUNNING_A_SCRIPT) {
                  setState(State.SEEKING_HOME);
              }
          }
      }, 6000);
  }

    private void magic() {
        Toast.makeText(this, "Magic", Toast.LENGTH_SHORT).show();
        mCommandHandler.postDelayed(new Runnable() {
            @Override
            public void run() {
                Toast.makeText(MainActivity.this, "Carpet", Toast.LENGTH_SHORT).show();
            }
        }, 2000);
        mCommandHandler.postDelayed(new Runnable() {
            @Override
            public void run() {
                setState(State.SUCCESS);
            }
        }, 5000);
    }

  @Override
  protected void onStart() {
      super.onStart();
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
      mTimer.cancel();
      mTimer = null;
  }

  public void loop(){
    mStateTimeTextView.setText(""+getStateTimeMs()/1000);
    switch(mState){
        case SEEKING_HOME:

            if(getStateTimeMs() > 6000){
                setState(State.READY);
            }
            break;
        case SEEKING_SOMEWHERE:
            if(getStateTimeMs()> 3000){
                setState(State.SUCCESS);
            }
    }
  }

}

package schackma.field_sensors;

import android.location.Location;
import android.support.annotation.NonNull;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.view.WindowManager;
import android.widget.TextView;
import android.widget.Toast;
import android.widget.ToggleButton;

import edu.rosehulman.me435.FieldGps;
import edu.rosehulman.me435.FieldGpsListener;
import edu.rosehulman.me435.FieldOrientation;
import edu.rosehulman.me435.FieldOrientationListener;

public class MainActivity extends AppCompatActivity implements FieldGpsListener, FieldOrientationListener{
    private TextView mGpsXTextView;
    private TextView mGpsYTextView;
    private TextView mGpsHeadingTextView;
    private TextView mGpsCounterTextView;
    private TextView mSensorHeadingTextView;
    private FieldOrientation mFieldOrientation;
    private boolean mSetFieldOrientationWithGpsHeadings = false;
    private int mGpsCounter = 0;
    private FieldGps mFieldGps;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        mFieldGps = new FieldGps(this);
        mFieldOrientation = new FieldOrientation(this);

        getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);

        mGpsXTextView = (TextView) findViewById(R.id.textView_x_gps);
        mGpsYTextView = (TextView) findViewById(R.id.textView_y_gps);
        mGpsHeadingTextView = (TextView) findViewById(R.id.textView_heading);
        mGpsCounterTextView = (TextView) findViewById(R.id.textView_counter);
        mSensorHeadingTextView = (TextView) findViewById(R.id.textView_internal_heading);

    }

    @Override
    protected void onStart() {
        super.onStart();
        mFieldOrientation.registerListener(this);
        mFieldGps.requestLocationUpdates(this);
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        mFieldGps.requestLocationUpdates(this);
    }

    @Override
    protected void onStop(){
        super.onStop();
        mFieldOrientation.unregisterListener();
        mFieldGps.removeUpdates();
    }


    public void set_orgin(View view) {
//        Toast.makeText(this,"orgin set",Toast.LENGTH_SHORT).show();
        mFieldGps.setCurrentLocationAsOrigin();
    }

    public void set_x_axis(View view) {
//        Toast.makeText(this,"x axis set",Toast.LENGTH_SHORT).show();
        mFieldGps.setCurrentLocationAsLocationOnXAxis();
    }

    @Override
    public void onLocationChanged(double x, double y, double heading, Location location) {
        mGpsXTextView.setText((int) x + "ft");
        mGpsYTextView.setText((int) y + "ft");
        if (heading <=180.0 && heading > -180.0){
            mGpsHeadingTextView.setText((int) heading+ "degrees");
            if(mSetFieldOrientationWithGpsHeadings){
                mFieldOrientation.setCurrentFieldHeading(heading);
            }
        }else{
            mGpsHeadingTextView.setText("----");
        }
        mGpsCounter++;
        mGpsCounterTextView.setText(""+mGpsCounter);
    }

    public void handleToggle(View view){
//        Toast.makeText(this,"toggle pressed",Toast.LENGTH_SHORT).show();
        mFieldOrientation.setCurrentFieldHeading((double)0);
    }

    public void handleSetHeadingTo0(View view){
//        Toast.makeText(this,"set heading to 0",Toast.LENGTH_SHORT).show();
        ToggleButton tb = (ToggleButton)view;
        mSetFieldOrientationWithGpsHeadings = tb.isChecked();
    }

    @Override
    public void onSensorChanged(double fieldHeading, float[] orientationValues){
        mSensorHeadingTextView.setText((int) fieldHeading+ " degrees");
    }
}

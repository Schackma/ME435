package schackma.field_sensors;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
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
        mGpsXTextView = (TextView) findViewById(R.id.textView_x_gps);
        mGpsYTextView = (TextView) findViewById(R.id.textView_y_gps);
        mGpsHeadingTextView = (TextView) findViewById(R.id.textView_heading);
        mGpsCounterTextView = (TextView) findViewById(R.id.textView_counter);
    }

    public void set_orgin(View view) {
        Toast.makeText(this,"orgin set",Toast.LENGTH_SHORT).show();
    }

    public void set_x_axis(View view) {
        Toast.makeText(this,"x axis set",Toast.LENGTH_SHORT).show();
    }
}

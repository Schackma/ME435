package edu.rosehulman.horvegc.hellobutton;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {

    private TextView mMessageTextView;
    private int mCounter = 0;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        mMessageTextView = (TextView) findViewById(R.id.message_textView);
    }

    public void handleIncrement(View view) {
//        Toast.makeText(this, "you clicked the button", Toast.LENGTH_SHORT).show();
        mCounter++;
        mMessageTextView.setText(getString(R.string.message_format, mCounter));
    }

    public void resetAction(View view) {
        mCounter=0;
        mMessageTextView.setText(getString(R.string.message_start));
    }
}

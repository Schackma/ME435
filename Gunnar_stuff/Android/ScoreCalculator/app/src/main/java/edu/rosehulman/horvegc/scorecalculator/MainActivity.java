package edu.rosehulman.horvegc.scorecalculator;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.View;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.Spinner;
import android.widget.TextView;


public class MainActivity extends AppCompatActivity {
    private EditText nearBallDist;
    private EditText farBallDist;
    private EditText robotHomeDist;
    private RadioGroup wbRadio;
    private RadioGroup fixRadio;

    private TextView fixScore;
    private TextView wbScore;
    private TextView totalScore;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        bindObjects();
        setListeners();
        extra();
    }

    private void bindObjects() {
        nearBallDist = (EditText) findViewById(R.id.near_ball_distance);
        farBallDist = (EditText) findViewById(R.id.far_ball_distance);
        robotHomeDist = (EditText) findViewById(R.id.robot_home_distance);
        wbRadio = (RadioGroup) findViewById(R.id.wb_radio_group);
        fixRadio = (RadioGroup) findViewById(R.id.fix_radio_group);

        fixScore = (TextView) findViewById(R.id.Fix_score);
        wbScore = (TextView) findViewById(R.id.wb_mission_score);
        totalScore = (TextView) findViewById(R.id.total_score);
    }

    private void setListeners() {
        add_editListen(nearBallDist,false,(TextView) findViewById(R.id.near_ball_score));
        add_editListen(farBallDist,true,(TextView) findViewById(R.id.far_ball_score));
        add_editListen(robotHomeDist, false, (TextView) findViewById(R.id.robot_home_score));

        fixRadio.setOnCheckedChangeListener(new RadioGroup.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(RadioGroup group, int checkedId) {
                String totStr = totalScore.getText().toString();
                int tot = Integer.parseInt(totStr.substring(0, totStr.length() - " points".length()));
                String fixStr = fixScore.getText().toString();
                tot -= Integer.parseInt(fixStr.substring(0, fixStr.length() - " color points".length()));

                switch (getRadioString(fixRadio)) {
                    case "3 Fixes":
                        tot += 0;
                        fixScore.setText(0 + " color points");
                        break;
                    case "2 Fixes":
                        tot += 25;
                        fixScore.setText(25 + " color points");
                        break;
                    case "1 Fix":
                        tot += 75;
                        fixScore.setText(75 + " color points");
                        break;
                    case "0 Fixes":
                        //Toast.makeText(getApplicationContext(), "0", Toast.LENGTH_LONG).show();
                        tot += 150;
                        fixScore.setText(150 + " color points");
                        break;
                }
                totalScore.setText(tot + " points");
            }
        });

        wbRadio.setOnCheckedChangeListener(new RadioGroup.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(RadioGroup group, int checkedId) {
                String totStr = totalScore.getText().toString();
                int tot = Integer.parseInt(totStr.substring(0, totStr.length() - " points".length()));
                String wbStr = wbScore.getText().toString();
                tot -= Integer.parseInt(wbStr.substring(0, wbStr.length() - " wb points".length()));

                switch (getRadioString(wbRadio)) {
                    case "WB Failure":
                        tot += 0;
                        wbScore.setText(0 + " wb points");
                        break;
                    case "WB Success":
                        tot += 60;
                        wbScore.setText(60 + " wb points");
                        break;
                }
                totalScore.setText(tot + " points");
            }
        });

        final Button reset = (Button) findViewById((R.id.reset_button));
        reset.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                nearBallDist.setText("" + 50);
                farBallDist.setText("" + 50);
                robotHomeDist.setText("" + 50);

                RadioButton tmp = (RadioButton) findViewById(R.id.default_fix_choice);
                tmp.setChecked(true);
                RadioButton tmp2 = (RadioButton) findViewById(R.id.default_wb_choice);
                tmp2.setChecked(true);
            }
        });
    }

    private void add_editListen(final EditText toLink,  final boolean farBall, final TextView toChange) {
        toLink.addTextChangedListener(new TextWatcher() {
            int prev, cur;
            boolean subtractPrev, addCur;

            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {
                try {
                    prev = Integer.parseInt(toLink.getText().toString());
                } catch (NumberFormatException e) {
                    subtractPrev = false;
                    return;
                }
                subtractPrev = true;
            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {
                try {
                    cur = Integer.parseInt(toLink.getText().toString());
                } catch (NumberFormatException e) {
                    addCur = false;
                    return;
                }
                addCur = true;
            }

            @Override
            public void afterTextChanged(Editable s) {
                String totStr = totalScore.getText().toString();

                int tot = Integer.parseInt(totStr.substring(0, totStr.length() - " points".length()));
                if (addCur) {
                    toChange.setText("" + getDistScore(cur, farBall));
                    tot += getDistScore(cur, farBall);
                } else {
                    toChange.setText("" + 0);
                }

                if (subtractPrev) {
                    tot -= getDistScore(prev, farBall);
                }
                totalScore.setText(tot + " points");
            }
        });
    }

    int getDistScore(int dist, boolean farBall) {
        int toReturn = 0;
        if(dist <= 5) {
            toReturn = 110;
        } else if(dist <= 10) {
            toReturn = 100;
        } else if(dist <= 20) {
            toReturn = 80;
        } else if(dist <= 30) {
            toReturn = 50;
        } else if(dist <= 45) {
            toReturn = 10;
        }

        if(farBall) { return toReturn*2; }
        return toReturn;
    }

    String getRadioString(RadioGroup gr) {
        return ((RadioButton)findViewById(gr.getCheckedRadioButtonId())).getText().toString();
    }

    private void extra() {
        final Spinner spin = (Spinner) findViewById((R.id.poke_picker));
        spin.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                ImageView banner = (ImageView)findViewById(R.id.pokeBox);
                switch (String.valueOf(spin.getSelectedItem())) {
                    case "Gyarados":
                        banner.setImageDrawable(getResources().getDrawable(R.drawable.gyrados));
                        break;
                    case "Charizard":
                        banner.setImageDrawable(getResources().getDrawable(R.drawable.charizard));
                        break;
                    case "Blastoise":
                        banner.setImageDrawable(getResources().getDrawable(R.drawable.blastoise));
                        break;
                    case "Venusaur":
                        banner.setImageDrawable(getResources().getDrawable(R.drawable.ivysaur));
                        break;
                    case "Pikachu":
                        banner.setImageDrawable(getResources().getDrawable(R.drawable.pikachu));
                        break;
                }
            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) {

            }
        });

    }
}
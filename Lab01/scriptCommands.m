s = RobotOpen;
fprintf(s,'X-AXIS 5');
fprintf(getResponse(s));
fclose(s);
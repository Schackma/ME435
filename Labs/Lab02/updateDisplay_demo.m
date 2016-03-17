a = axes();
set(a,'Units','Pixels','Visible','Off');
set(a,'Position',[7.4, 9, 426.4, 228]);

updateDisplay(a,[0,0,0,0,1],false,3,1);
updateDisplay(a,[0,0,0,0,1],false,4,1);
updateDisplay(a,[0,0,0,0,1],false,5,1);
updateDisplay(a,[0,0,0,0,1],true,5,3);
updateDisplay(a,[0,0,0,0,0],false,5,3);
updateDisplay(a,[0,0,0,0,0],false,4,3);
updateDisplay(a,[0,0,0,0,0],false,3,3);
updateDisplay(a,[0,0,0,0,0],false,2,3);
updateDisplay(a,[0,0,0,0,0],false,1,3);
updateDisplay(a,[0,0,0,0,0],true,1,3);
updateDisplay(a,[1,0,0,0,0],false,1,1);
updateDisplay(a,[1,0,0,0,0],false,2,1);
updateDisplay(a,[1,0,0,0,0],false,3,1);
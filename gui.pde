/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.

 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
     // It is safe to enter your event code here  
 } //_CODE_:button1:12356:
 
 * Do not rename this tab!
 * =========================================================
 */

synchronized public void win_draw1(PApplet appc, GWinData data) { //_CODE_:window1:203970:
  appc.background(230);
} //_CODE_:window1:203970:

public void windStrengthControlAltered(GCustomSlider source, GEvent event) { //_CODE_:windStrengthControl:590021:
  windStrength = windStrengthControl.getValueF();
} //_CODE_:windStrengthControl:590021:

public void windDirAltered(GStick source, GEvent event) { //_CODE_:windDirControl:901153:
  println(windDirControl.getPosition()); 
  
  if (windDirControl.getPosition() == 0) {
    windTheta = 0;
  }
  
  else if (windDirControl.getPosition() == 1) {
    windTheta = 315;
  }
  
  else if (windDirControl.getPosition() == 2) {
    windTheta = 270;
  }
  
  else if (windDirControl.getPosition() == 3) {
    windTheta = 225;
  }
  else if (windDirControl.getPosition() == 4) {
    windTheta = 180;
  }
  else if (windDirControl.getPosition() == 5) {
    windTheta = 135;
  }
  else if (windDirControl.getPosition() == 6) {
    windTheta = 90;
  }
  else if (windDirControl.getPosition() == 7) {
    windTheta = 45;
  }
} //_CODE_:windDirControl:901153:

public void crashFactorControlAltered(GCustomSlider source, GEvent event) { //_CODE_:crashFactorControl:900789:
  crashFactor = crashFactorControl.getValueF();
} //_CODE_:crashFactorControl:900789:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("Sketch Window");
  window1 = GWindow.getWindow(this, "Window title", 0, 0, 240, 300, JAVA2D);
  window1.noLoop();
  window1.setActionOnClose(G4P.KEEP_OPEN);
  window1.addDrawHandler(this, "win_draw1");
  windStrengthControl = new GCustomSlider(window1, 90, 12, 100, 40, "grey_blue");
  windStrengthControl.setLimits(1.0, 0.0, 10.0);
  windStrengthControl.setNumberFormat(G4P.DECIMAL, 2);
  windStrengthControl.setOpaque(false);
  windStrengthControl.addEventHandler(this, "windStrengthControlAltered");
  label1 = new GLabel(window1, -6, 21, 80, 20);
  label1.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label1.setText("Wind Strength");
  label1.setOpaque(false);
  windDirControl = new GStick(window1, 124, 87, 60, 60);
  windDirControl.setMode(G4P.X8);
  windDirControl.setOpaque(false);
  windDirControl.addEventHandler(this, "windDirAltered");
  label2 = new GLabel(window1, 25, 108, 80, 20);
  label2.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label2.setText("wind direction");
  label2.setOpaque(false);
  crashFactorControl = new GCustomSlider(window1, 85, 163, 100, 40, "grey_blue");
  crashFactorControl.setLimits(0.5, 0.0, 1.0);
  crashFactorControl.setNumberFormat(G4P.DECIMAL, 2);
  crashFactorControl.setOpaque(false);
  crashFactorControl.addEventHandler(this, "crashFactorControlAltered");
  label3 = new GLabel(window1, 3, 170, 80, 20);
  label3.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label3.setText("crash factor");
  label3.setOpaque(false);
  window1.loop();
}

// Variable declarations 
// autogenerated do not edit
GWindow window1;
GCustomSlider windStrengthControl; 
GLabel label1; 
GStick windDirControl; 
GLabel label2; 
GCustomSlider crashFactorControl; 
GLabel label3; 

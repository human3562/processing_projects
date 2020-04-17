import processing.sound.*;
float[] scaleFrequencies = {440, 493.88, 523.25, 587.33, 659.25, 739.99, 783.99, 880};
//int currentPitch = 0;
SinOsc sine;
SinOsc sine2;
float BPM = 1;
float elapsedTime = 0;
float time = 0;
int t = 0;
float frequency1 = 0;
float frequency2 = 0;
void setup(){
  size(600,600);
  sine = new SinOsc(this);
  sine2 = new SinOsc(this);
  sine.play();
  sine2.play();
  sine2.amp(0.05);
  sine.amp(0.1);
  frameRate(600);
}

void draw(){
  background(0);
  elapsedTime = 1/frameRate;
  
  if(time / 0.1 > 1){
    frequency1 = scaleFrequencies[round(random(0, scaleFrequencies.length-1))];
    frequency2 = scaleFrequencies[round(random(0, scaleFrequencies.length-1))];
    //println(frequency);
    //println(t % scaleFrequencies.length);
    sine2.freq((frequency1-10));
    sine.freq(frequency1);
    time = 0;
    t++;
  }
  text(frequency1,width/2, height/2);
  time+=elapsedTime;
}

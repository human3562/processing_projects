//import beads.*;
//import org.jaudiolibs.beads.*;


//AudioContext ac;
//Gain ga;
//SamplePlayer sp;
//Glide gainValue;
//String sourceFile;
//PowerSpectrum ps;

int Gold = 100;
Fish fish;
ArrayList<character> characters = new ArrayList<character>();
int selectedA = 0;
float elapsedTime = 0;
float timer = 0;
int talkto = -1;
float r, g, b = 0;


void setup() {
  //ac = new AudioContext();
  //gainValue = new Glide(ac, 0.0, 20);
  //ga = new Gain(ac, 1, gainValue);
  //g.addInput(sp);
  //ac.out.addInput(ga);
  //ac.start();
  //gainValue.setValue(0.5);
  //sourceFile =  sketchPath("") +
  //  "data/ass.mp3";
  //try {
  //  sp = new SamplePlayer(ac, new Sample(sourceFile));
  //}
  //catch(Exception e) {
  //  e.printStackTrace();
  //  exit();
  //}
  //ga.addInput(sp);
  //ShortFrameSegmenter sfs = new ShortFrameSegmenter(ac);
  //sfs.addInput(ac.out);
  //FFT fft = new FFT();
  //sfs.addListener(fft);
  //ps = new PowerSpectrum();
  //fft.addListener(ps);
  //ac.out.addDependent(sfs);
  size(1200, 600, P2D);
  fish = new Fish();
  imageMode(CORNER);
  fish.charArt = loadImage("fishman.png");
  setFish();
  //ArrayList<q> Q = new ArrayList<q>();

  //ArrayList<a> A0 = new ArrayList<a>();
  //a a1 = new a("Yes", 0, 1);
  //a a2 = new a("No", 1, 2);
  //a a3 = new a("Fuck you.", 2, 3);

  //A0.add(a1); 
  //A0.add(a2); 
  //A0.add(a3);
  //q q0 = new q("You new here?", 0, A0);
  //Q.add(q0);

  //q q1 = new q("Come on in boy, i've got everything you need.", 1, null);
  //q q2 = new q("I don't recognize your face, little one. Get lost.", 2, null);
  //q q3 = new q("How rude. You can leave now.", 3, null);

  //Q.add(q1); 
  //Q.add(q2); 
  //Q.add(q3);
  //SALESMAN.questions = Q;
  //SALESMAN.Name = "The Salesman";
  characters.add(fish);
  stroke(255);
  fill(255);
  textSize(24);
}

void draw() {
  elapsedTime = 1/frameRate;
  r = noise(timer)*255;
  g = noise(timer+100)*255;
  b = noise(timer-100)*255;
  background(r, g, b);
  if (talkto == -1&&!characters.isEmpty()) {
    for (int i = 0; i<characters.size(); i++) {
      text(characters.get(i).Name, 20, 50+50*i);
    }
  } else {
    characters.get(talkto).update();
    if (!characters.get(talkto).equals("character")) {
      characters.get(talkto).checkAnswerLog();
    }
  }
  text("GOLD: "+Gold, 10, 25);
  //float[] features = ps.getFeatures();
  //for (int i = 0; i<features.length; i++) {
  //  float barHeight = map(features[i],0,0.1,0,height);
  //  if(barHeight>height) barHeight = height;
   // line(i*4, height, i*4, height - barHeight);
  //}
  //float avg=0;
  //for(int i = 0; i<10; i++){
  //  avg+=features[i]; 
  //}
  //avg/=10;
  //println(avg);
  //timer+=avg;
}

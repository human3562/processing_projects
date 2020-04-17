class state {
  boolean isStarted;
  void Start() {
  }
  void Update() {
  }
}


class s_playground extends state {
  body ball;
  //settingsA someButtons;
  void Start() {
    //someButtons = new settingsA();
    //someButtons.settings.add(new bool("Авто-движение камеры (камеру можно двигать зажав правую кнопку мыши)", 10, height-20, false));
    float d = random(0, maxWindV);
    float a = random(0, TWO_PI);
    Vwind = new PVector(cos(a)*0, sin(a)*0);
    ball = new body();
  }

  void Update() {
    ball.dT = (1/frameRate)/48;
    //camX = lerp(camX, (ball.position.x * pixelScale) - width/2, ball.dT*24*16);
    //camY = lerp(camY, (ball.position.y * pixelScale) - height/2, ball.dT*24*16);

    pushMatrix();
    translate(-camX, -camY);
    background(20);

    drawMap();
    ellipse(0, 0, 10, 10); 

    for (int i = 0; i < 48; i++)
      ball.update();

    ball.show();
    stroke(255);
    strokeWeight(1);
    line(camX, ball.groundLevel*pixelScale, camX+width, ball.groundLevel*pixelScale);
    popMatrix();

    //someButtons.show();
    
    windBallX = width-110;
    windBallY = 110;

    drawWindDirection(ball, windBallX, windBallY, true);

    info(ball);
  }
}


class s_launchSetting extends state {
  settingsA setupSettings;
  void Start() {
    setupSettings = new settingsA();
    setupSettings.settings.add(new valueBox("Нулевой уровень:", 10, 40, "10"));
    setupSettings.settings.add(new valueBox("Начальная координата X:", 10, 90, "0"));
    setupSettings.settings.add(new valueBox("Начальная координата Y:", 10, 140, "0"));
    setupSettings.settings.add(new valueBox("Начальная скорость по X:", 10, 190, "0"));
    setupSettings.settings.add(new valueBox("Начальная скорость по Y:", 10, 240, "0"));
    setupSettings.settings.add(new valueBox("Δt:", 10, 290, "0.1"));
    setupSettings.settings.add(new button("Запустить!", 100, height-30, 200, 50));
    setupSettings.settings.add(new button("Интерактивный режим", 350, height-25, 280, 40));
  }

  void Update() {
    background(0);
    
    if(float(setupSettings.settings.get(5).strvalue) <= 0 && !setupSettings.settings.get(5).selected) setupSettings.settings.get(5).strvalue = "0.01";
    
    
    if (setupSettings.settings.get(setupSettings.settings.size()-2).act) {
      //review.Start();
      //review.isStarted = true;
      println("wot");
      review.ball = new body();
      review.ball.groundLevel= float(setupSettings.settings.get(0).strvalue);
      review.ball.position.x = float(setupSettings.settings.get(1).strvalue);
      review.ball.position.y = float(setupSettings.settings.get(2).strvalue);
      review.ball.velocity = new PVector(float(setupSettings.settings.get(3).strvalue), float(setupSettings.settings.get(4).strvalue));
      review.ball.dT = float(setupSettings.settings.get(5).strvalue);
      println(float(setupSettings.settings.get(2).strvalue));
      println(review.ball.velocity.x);
      PROGRAM_STATE = 2;
      launchSetting.isStarted = false;
    }
    
    if(setupSettings.settings.get(setupSettings.settings.size()-1).act){
      playground.ball = new body();
      playground.ball.groundLevel= float(setupSettings.settings.get(0).strvalue);
      playground.ball.position.x = float(setupSettings.settings.get(1).strvalue);
      playground.ball.position.y = float(setupSettings.settings.get(2).strvalue);
      playground.ball.velocity = new PVector(float(setupSettings.settings.get(3).strvalue), float(setupSettings.settings.get(4).strvalue));
      PROGRAM_STATE = 0;
      launchSetting.isStarted = false;
    }
    setupSettings.show();
  }
}


class s_review extends state {
  ArrayList<PVector> recordVelocity = new ArrayList<PVector>();
  ArrayList<PVector> recordAcceleration = new ArrayList<PVector>();
  ArrayList<PVector> recordPosition = new ArrayList<PVector>();
  //ArrayList<recGraph> graphs = new ArrayList<recGraph>();

  body ball;
  timeSlider replay;
  void Start() {
    recordPosition.clear();
    recordVelocity.clear();
    recordAcceleration.clear();
    //graphs.clear();
    //float d = random(0, maxWindV);
    //float a = random(0, TWO_PI);
    Vwind = new PVector(0, 0);
    //ball = new body();

    //graphs.add(new recGraph((width/4), height/4, (width/2) - 30, (height/2) - 30)); // velocity Y
    //graphs.get(0).pointLimit = 800;
    //graphs.add(new recGraph(width/2 + width/4, height/4, (width/2) - 30, (height/2) - 30)); // velocity X
    //graphs.get(1).pointLimit = 800;

    while (ball.hitGround == false) {
      recordPosition.add(new PVector(ball.position.x, ball.position.y));
      recordVelocity.add(new PVector(ball.velocity.x, ball.velocity.y));
      recordAcceleration.add(new PVector(ball.acceleration.x, ball.acceleration.y));

      //println(ball.hitGround);
      ball.update();
      if (ball.lifeT > 20) break;
    }

    replay = new timeSlider();
    replay.startX = 20;
    replay.endX = width-20;
    replay.h = height-20;
    replay.points = recordPosition.size();
    //println(graphs.get(0).points.size());
  }

  void Update() {
    background(0);



    stroke(100);
    noFill();
    beginShape();
    for (PVector p : recordPosition) {
      vertex(p.x*pixelScale, p.y*pixelScale);
    }
    endShape();

    ball.position = recordPosition.get(replay.currentPoint);
    ball.velocity = recordVelocity.get(replay.currentPoint);
    ball.acceleration = recordAcceleration.get(replay.currentPoint);


    float deltaTime = 1/frameRate;
    camX = lerp(camX, (ball.position.x * pixelScale) - width/2, deltaTime*16);
    camY = lerp(camY, (ball.position.y * pixelScale) - height/2, deltaTime*16);

    pushMatrix();
    translate(-camX, -camY);
    background(20);

    drawMap();
    ellipse(0, 0, 10, 10); 

    stroke(100);
    noFill();
    beginShape();
    for (PVector p : recordPosition) {
      vertex(p.x*pixelScale, p.y*pixelScale);
    }
    endShape();

    ball.show();
    
    stroke(255);
    strokeWeight(1);
    line(camX, ball.groundLevel*pixelScale, camX+width, ball.groundLevel*pixelScale);

    popMatrix();
      
    info(ball);
    
    //drawWindDirection(ball, width-110, 110, false);
    
    
    replay.startX = 20;
    replay.endX = width-20;
    replay.h = height-20;
    textSize(20);
    text(nfc(replay.currentPoint * ball.dT, 2) +" s", constrain(replay.x + 30, 0, width-65), replay.h - 20);
    //println(width - replay.x + 80);
    replay.show();
    //for (recGraph g : graphs) {
    //  g.show();
    //}
  }
}

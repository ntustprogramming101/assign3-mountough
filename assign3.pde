

final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;
int gameState = 0;

final int GRASS_HEIGHT = 15;
final int START_BUTTON_W = 144;
final int START_BUTTON_H = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;

PImage bg, title, gameover, startNormal, startHovered, restartNormal, restartHovered;
PImage groundhog, soldier, cabbage, life;
PImage soil8x24,soil0, soil1, soil2, soil3, soil4, soil5, stone1 ,stone2;

int grid = 80;
int groundhogX = grid*4;
int groundhogY = grid;
int groundhogSpeed = 5;
final int STOP = 0, GO_DOWN1 = 1, GO_DOWN2 = 2, GO_RIGHT = 3, GO_LEFT = 4;
int movement = STOP;


//PImage [] soils = new PImage [6];
int soilY;
boolean liDeepGround = false;
boolean deepGround = false;

int soilderDeep = (floor(random(4))+2)*grid;
int soilderX = -50;
int soilderXSpeed = 5;
boolean willHurt = true;
int time = 0, ms = 1;

int cabbageX =(floor(random(8)))*grid;
int cabbageY =(floor(random(4))+2)*grid;
boolean cabbagegrow = true;

int lifescore = 2;
int heartFirst = 10;
int heartPlus = 70;

// For debug function; DO NOT edit or remove this!
int playerHealth = 0;
float cameraOffsetY = 0;
boolean debugMode = false;

void setup() {
	size(640, 480, P2D);
	// Enter your setup code here (please put loadImage() here or your game will lag like crazy)
	bg = loadImage("img/bg.jpg");
	title = loadImage("img/title.jpg");
	gameover = loadImage("img/gameover.jpg");
	startNormal = loadImage("img/startNormal.png");
	startHovered = loadImage("img/startHovered.png");
	restartNormal = loadImage("img/restartNormal.png");
	restartHovered = loadImage("img/restartHovered.png");
  groundhog = loadImage("img/groundhogIdle.png");
	soil8x24 = loadImage("img/soil8x24.png");
  soil0 = loadImage("img/soil0.png");
  soil1 = loadImage("img/soil1.png");
  soil2 = loadImage("img/soil2.png");
  soil3 = loadImage("img/soil3.png");
  soil4 = loadImage("img/soil4.png");
  soil5 = loadImage("img/soil5.png");
  stone1 = loadImage("img/stone1.png");
  stone2 = loadImage("img/stone2.png");
  cabbage = loadImage("img/cabbage.png");
  soldier = loadImage("img/soldier.png");
  life = loadImage("img/life.png");
}

void draw() {
    /* ------ Debug Function ------ 

      Please DO NOT edit the code here.
      It's for reviewing other requirements when you fail to complete the camera moving requirement.

    */
    if (debugMode) {
      pushMatrix();
      translate(0, cameraOffsetY);
    }
    /* ------ End of Debug Function ------ */
    
	switch (gameState) {

		case GAME_START: // Start Screen
		image(title, 0, 0);
		if(START_BUTTON_X + START_BUTTON_W > mouseX && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY && START_BUTTON_Y < mouseY){
			image(startHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
			}
		}else{
			image(startNormal, START_BUTTON_X, START_BUTTON_Y);
		}
		break;

		case GAME_RUN: // In-Game

		// Background
		image(bg, 0, 0);
		// Sun
	  stroke(255,255,0);
	  strokeWeight(5);
	  fill(253,184,19);
	  ellipse(590,50,120,120);
		// Grass
		fill(124, 204, 25);
		noStroke();
		rect(0, 160 - GRASS_HEIGHT - soilY, width, GRASS_HEIGHT);
		// Soil - REPLACE THIS PART WITH YOUR LOOP CODE!
    /*for(int s=0; s>=5; s++){
        img = soils[s];
        for(int y=grid*(2+s*4); y<=grid*(6+s*4); y+=grid){
           for(int x=0 ; x<width ; x+=grid)
             image(img, x, y-soilY);*/
         for (int y=grid*2 ; y<=grid*6 ; y+=grid){
           for (int x=0 ; x<width ; x+=grid){
             image(soil0, x, y-soilY); }}
         for (int y=grid*6 ; y<=grid*10 ; y+=grid){
           for (int x=0 ; x<width ; x+=grid){
             image(soil1, x, y-soilY); }}
         for (int y=grid*10 ; y<=grid*14 ; y+=grid){
           for (int x=0 ; x<width ; x+=grid){
             image(soil2, x, y-soilY); }}
         for (int y=grid*14 ; y<=grid*18 ; y+=grid){
           for (int x=0 ; x<width ; x+=grid){
             image(soil3, x, y-soilY); }}
         for (int y=grid*18 ; y<=grid*22 ; y+=grid){
           for (int x=0 ; x<width ; x+=grid){
             image(soil4, x, y-soilY); }}
         for (int y=grid*22 ; y<=grid*26 ; y+=grid){
           for (int x=0 ; x<width ; x+=grid){
             image(soil5, x, y-soilY); }}
    // stone
         for (int i=0 ; i<=8 ; i++){
           image(stone1, grid*i, grid*(i+2)-soilY);}
           
         for (int X=0 ; X<=8 ; X+=1){
           if (X==0 || X==3 || X==4 || X==7){
             for (int Y=0 ; Y<=8 ; Y+=1){
               if (Y==1 || Y==2 || Y==5 || Y==6){
                 image(stone1, grid*X, grid*(Y+10)-soilY);}}
           }else{
             for (int Y=0 ; Y<=8 ; Y+=1){
                   if (Y==0 || Y==3 || Y==4 || Y==7){
                     image(stone1, grid*X, grid*(Y+10)-soilY);}}
            }
         }
         for (int H=0 ; H<=8 ; H+=1){
           for (int A=1 ; A<=13; A+=3){image(stone1, grid*(A-H), grid*(H+18)-soilY);image(stone1, grid*(A-H+1), grid*(H+18)-soilY);}
           for (int A=2 ; A<=14 ; A+=3){image(stone2, grid*(A-H), grid*(H+18)-soilY);}
         }
		// Player
        image(groundhog,groundhogX, groundhogY);
        if (soilY>=1600){deepGround = true;}
        switch(movement){
          case STOP:
            groundhog = loadImage("img/groundhogIdle.png");
            break;
          case GO_LEFT:
            groundhogX-=groundhogSpeed;
            groundhog = loadImage("img/groundhogLeft.png");
            if (groundhogX%grid==0){movement=STOP;}
            break;
          case GO_RIGHT:
            groundhogX+=groundhogSpeed;
            groundhog = loadImage("img/groundhogRight.png");
            if (groundhogX%grid==0){movement=STOP;}
            break;
          case GO_DOWN1:
            groundhog = loadImage("img/groundhogDown.png");
            soilY+=groundhogSpeed;
            cabbageY-=groundhogSpeed;
            soilderDeep-=groundhogSpeed;
            if (soilY%grid==0){movement=STOP;}
            break;
          case GO_DOWN2:
            groundhogY+=groundhogSpeed;
            groundhog = loadImage("img/groundhogDown.png");
            if (groundhogY%grid==0){movement=STOP;}
            break;
        }
    //cabbage
        if (cabbagegrow == true){
          image(cabbage ,cabbageX,cabbageY);
          if (cabbageY<0){cabbagegrow = false;}
          if (cabbageX < groundhogX+grid && cabbageX+grid > groundhogX &&
              cabbageY < groundhogY+grid && cabbageY+grid > groundhogY){
            lifescore += 1;
            cabbagegrow = false;
          }
        }else{
            if(soilY%grid==0 && liDeepGround == true){
              cabbageX =(floor(random(8)))*grid;
              cabbageY =(floor(random(6)))*grid;
              cabbagegrow = true;
            }else if(soilY%grid==0 && liDeepGround == false){
              cabbageX =(floor(random(8)))*grid;
              cabbageY =(floor(random(4))+2)*grid;
              cabbagegrow = true;
            } 
         }
    //soilder
        soilderX += soilderXSpeed;
        image(soldier, soilderX, soilderDeep);
        if (soilderX > 640){
          soilderX = -50;
          if(soilY%grid==0 && liDeepGround == true){
          soilderDeep = floor(random(6))*grid;}
          if(soilY%grid==0 && liDeepGround == false){
          soilderDeep = floor(random(4)+2)*grid;}
        }
    /*hit 你們這些經驗值的奴隸QQ*/
    if (willHurt == true){
        if (soilderX < groundhogX+80 && soilderX+80 > groundhogX &&
            soilderDeep < groundhogY+80 && soilderDeep+grid > groundhogY){
         lifescore -= 1;
         willHurt = false;
        }
     }
    if (willHurt == false){
           tint(200, 0, 0);
           time+=ms;
           if (time > 60){
             willHurt = true;
             noTint();
             time = 0;
           }
    }

		// Health UI
       if (lifescore == 0){gameState = GAME_OVER;noTint();}
       for(int i =0; i<=4; i+=1){
         if (lifescore > i){image(life, heartFirst+(heartPlus)*i,10);}
         }
       if (lifescore > 5){lifescore = 5;}

		break;

		case GAME_OVER: // Gameover Screen
		image(gameover, 0, 0);
		
		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {
			image(restartHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
       //initialize game
       lifescore = 2;
       groundhogX = grid*4;
       groundhogY = grid;
       soilY = 0;
       soilderX = -50;
       soilderDeep = floor(random(4)+2)*grid;
       cabbageX =(floor(random(8)))*grid;
       cabbageY =(floor(random(4))+2)*grid;
       cabbagegrow = true;
       boolean liDeepGround = false;
       boolean deepGround = false;
       movement=STOP;
       gameState = GAME_RUN;
			}
		}else{
			image(restartNormal, START_BUTTON_X, START_BUTTON_Y);
		}
		break;
	}

    // DO NOT REMOVE OR EDIT THE FOLLOWING 3 LINES
    if (debugMode) {
        popMatrix();
    }
}

void keyPressed(){
	// Add your moving input code here
  if (key == CODED) {
    switch (keyCode) {
      case DOWN:
        if (deepGround == false){movement=GO_DOWN1;}
        if (groundhogY < height-grid &&deepGround == true){movement=GO_DOWN2;}
        break;
      case LEFT:
        if (groundhogX > 0){movement=GO_LEFT;}
        break;
      case RIGHT:
        if (groundhogX < width-grid ){movement=GO_RIGHT;}
        break;
    }
  }
	// DO NOT REMOVE OR EDIT THE FOLLOWING SWITCH/CASES
    switch(key){
      case 'w':
      debugMode = true;
      cameraOffsetY += 50;
      break;

      case 's':
      debugMode = true;
      cameraOffsetY -= 50;
      break;

      case 'a':
      if(lifescore > 0) lifescore --;
      break;

      case 'd':
      if(playerHealth < 5) lifescore ++;
      break;
    }
}

void keyReleased(){
}


// group members:    Thomas Cassady & Jason Huang
// class:  	CSC 690
// project: Final
// date:    11/13/2014
// file:	ComicYourself.pde


//__________________________________________________________________________________________________________________________
import processing.video.*;
import java.awt.*;
import controlP5.*;
import ddf.minim.* ;




//__________________________________________________________________________________________________________________________
Capture webcam;
PImage [] Photos;
PImage [] stockBackground;
boolean changeBackground = false;
PImage [] Panels;
int numPhotos = 0;
int numPanels = 0;
int currPhotoIndex = 0;
int photoIndex = 0;
int mode = 0;
int phase = 1;
PImage frame, mode2Capture, mode2Calibration, calibratedFrame, editedFrame, cropImage;
PFont font;
ControlP5 cp5;
boolean displayButtons = true;
PFont buttonFont;
Minim minim;
AudioPlayer Snap, Click;

//mode 4 variables:
color paint = color(0);
int strokeWt = 1;
int flag = 0;
PImage editPhoto;
boolean displayPhoto = true;
ColorPicker cp;
PFont smallFont;
float resizeValue = 100;

//Jason edits for mode 2
boolean removeBackground = false;
int threshold = 70;

//______________________________________________________________
//______________________________________________________________
//______________________________________________________________
//Jason mode4phase3 cropImage boolean
boolean crop = false;
int x1, y1, x2, y2;
//Jason mode4phase5 stockCaptions
PShape[] stockCaption;



//__________________________________________________________________________________________________________________________
void setup()
{
	size(1080, 720);
	background(255);

	buttonFont = loadFont("CordiaNew-Bold-30.vlw");
        smallFont = loadFont("Calibri-18.vlw");
  	textFont(buttonFont);
	webcam = new Capture(this, 640, 480);
	webcam.start();

	displayStartButton();
	Photos = new PImage[20];
	Panels = new PImage[20];

	//added by Jason
	mode2Calibration = webcam.get();

	minim = new Minim(this);
	Snap = minim.loadFile("snap.wav");
	Click = minim.loadFile("click.wav");
	// sound used is from freesound.org
  	// https://www.freesound.org/people/stijn/sounds/43680/
  	// https://www.freesound.org/people/Snapper4298/sounds/178186/
}

//__________________________________________________________________________________________________________________________
//__________________________________________________________________________________________________________________________
//__________________________________________________________________________________________________________________________
File[] listFiles(String directory){
  File file = new File(directory);
  if(file.isDirectory()){
    File[] files = file.listFiles();
    return files;
  } else {
    return null;
  }
}
//__________________________________________________________________________________________________________________________
//__________________________________________________________________________________________________________________________
//__________________________________________________________________________________________________________________________


//__________________________________________________________________________________________________________________________
void draw()
{
	if(mode == 0)
	{
		// START SCREEN mode
		background(255);
		drawStartScreen();
	}
	else if(mode == 1)
	{
		// OVERVIEW mode
		background(255);	

		drawOverview();
	}
	else if(mode == 2)
	{
		background(255);
		// TAKE A PHOTO mode
		if(phase == 1)
		{
			// show live feed
			drawCam();
			mode2phase1Buttons();
		}
		else if(phase == 2)
		{
			// show picture taken as freeze frame
			textFont(font);
	       	        text("Do you want to keep this picture?", 20, 40);
			displayPhoto(numPhotos - 1);
			mode2phase2Buttons();
		}
		else if(phase == 3)
		{
			calibrationPhase();
			mode2phase3buttons();
		}

	}
	else if(mode == 3)
	{
		// MAKE A PANEL mode
		background(255);
		if(phase == 1)
		{
			// show list of taken photos

			mode3displayPhotos();
			mode3phase1displayButtons();
		}
		else if(phase == 2)
		{
			// show photo that user clicked large
			// display save or discard buttons
			displayPhoto(photoIndex);
			mode3phase2displayButtons();
		}
	}
	else if(mode == 4) // edit photo mode
	{
		if(phase == 1)
		{
			// edit photo hub
			background(255);
			displayPhoto(photoIndex);
			mode4phase1displayButtons();
		}
		else if(phase == 2)
		{
			// simple drawing mode
			mode4phase2draw();
		}
		else if(phase == 3)
		{
                        ///*
                        println("r--"+resizeValue);
                        background(255);
                        displayResizedPhoto(photoIndex, resizeValue);
                        mode4phase3displayButtons();
                        //*/
		}
		else if(phase == 4)
		{
			// save edits
                        textFont(font);
                        text("Click and drag to crop.", 20, 40);
                        displayPhoto(photoIndex);
                        mode4phase4displayButtons();
                        stroke(255);
                        line(x1,y1,x2,y1);
                        line(x1,y1,x1,y2);
                        line(x2,y1,x2,y2);
                        line(x1,y2,x2,y2);
                        System.out.println(x1 +" "+ y1 + " " + x2 + " " + y2);
		}
                else if(phase == 5)
                {
                        textFont(font);
                        text("Click and drag to add caption.", 20, 40);
                        displayPhoto(photoIndex);
                        mode4phase5displayButtons();
                        drawStockCaption();
                }
	}
}



//__________________________________________________________________________________________________________________________
void captureEvent(Capture video) 
{
  video.read();
}



//__________________________________________________________________________________________________________________________
void keyPressed()
{
	if (key == ' ')
	{
		if( mode == 2 && phase == 1)
		{
			takePhoto();
		}
                if(mode == 2 && phase == 3)
                {
                        takeCalibrationPhoto();
                }
                if(mode == 4 && phase == 4)
                {
                        mode4phase4save();
                }
	}
	if (mode == 4)
	{
		switch(key)
		{
			case('1'):
			// method A to change color
			cp.setArrayValue(new float[] {120, 0, 120, 255});
			break;
			case('2'):
			// method B to change color
			cp.setColorValue(color(255, 0, 0, 255));
			break;
		}
	}
}



//__________________________________________________________________________________________________________________________
void mousePressed()
{
	switch (mode) 
	{
		case 1: mode1mousePressed();
				break;
		case 3: mode3mousePressed(); 
				break;
		default: break;
	}
        if(crop){
          if(mouseX>=140 && mouseY>=70 && mouseX<=940 && mouseY<=670){
            x1 = mouseX;
            y1 = mouseY;
            x2 = mouseX;
            y2 = mouseY;
          }
        }
}



//__________________________________________________________________________________________________________________________
void mouseDragged()
{
	if(mode == 4 && phase == 2)
	{
		println("mouseDragged");
 		flag = 1;
 	}
       if(crop)
       {         
         if(mouseX>=140 && mouseY>=70 && mouseX<=940 && mouseY<=670){
           x2 = mouseX;
           y2 = mouseY;
         }
       }
 
}



//__________________________________________________________________________________________________________________________
void mouseReleased()
{
	if(mode == 4 && phase == 2)
	{
		flag = 0;
		println("mouse released");
	}
        
}


//__________________________________________________________________________________________________________________________
public void controlEvent(ControlEvent c)
{
  if(c.isFrom(cp))
  {
    int r = int(c.getArrayValue(0));
    int g = int(c.getArrayValue(1));
    int b = int(c.getArrayValue(2));
    int a = int(c.getArrayValue(3));
    paint = color(r,g,b,a);
    println("event\talpha:"+a+"\tred:"+r+"\tgreen:"+g+"\tblue:"+b+"\tcol"+paint);
  }
}

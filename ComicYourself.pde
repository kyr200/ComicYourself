
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
PImage [] Panels;
int numPhotos = 0;
int numPanels = 0;
int currPhotoIndex = 0;
int photoIndex = 0;
int mode = 0;
int phase = 1;
int threshold = 40;
PImage frame, mode2Capture, mode2Calibration;
PFont font;
ControlP5 cp5;
boolean displayButtons = true;
PFont buttonFont;
Minim minim;
AudioPlayer Snap, Click;




//__________________________________________________________________________________________________________________________
void setup()
{
	size(1080, 720);
	buttonFont = loadFont("CordiaNew-Bold-30.vlw");
  	textFont(buttonFont);
	webcam = new Capture(this, 640, 480);
	webcam.start();

	displayStartButton();
	Photos = new PImage[20];
	Panels = new PImage[20];

	minim = new Minim(this);
	Snap = minim.loadFile("snap.wav");
	Click = minim.loadFile("click.wav");
	// sound used is from freesound.org
  	// https://www.freesound.org/people/stijn/sounds/43680/
  	// https://www.freesound.org/people/Snapper4298/sounds/178186/
        mode2Calibration = webcam.get();
        
}



//__________________________________________________________________________________________________________________________
void draw()
{
	background(255);	

	if(mode == 0)
	{
		// START SCREEN mode
		drawStartScreen();
	}
	else if(mode == 1)
	{
		// OVERVIEW mode
		drawOverview();
	}
	else if(mode == 2)
	{
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
		if(phase == 1)
		{
			// show list of taken photos
			mode3displayPhotos();
		}
		else if(phase == 2)
		{
			// show photo that user clicked large
			// display save or discard buttons
			displayPhoto(photoIndex);
			mode3displayButtons();
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
	}
}



//__________________________________________________________________________________________________________________________
void mousePressed()
{
	switch (mode) 
	{
		case 3: mode3mousePressed(); 
				break;
		default: break;
	}
}

// File: Mode4.pde
// Mode4 is the photo editing hub
//	Phase 1 = simple drawing mode (ie: ms paint)
//	Phase 2 = selection and removal

// variable used:


//__________________________________________________________________________________________________________________________
void mode4phase1displayButtons()
{
  if(displayButtons)
  {
    cp5 = new ControlP5(this);

    cp5.setControlFont(buttonFont);

    cp5.addButton("mode4phase1back")
      .setPosition(width/2 - 50, 677)
      .setCaptionLabel("<")
      .align(CENTER,CENTER,CENTER,CENTER)
      .setSize(40, 40)
      ;

    cp5.addButton("mode4phase1draw")
      .setPosition(width/2 + 10, 677)
      .setCaptionLabel("Draw")
      .align(CENTER,CENTER,CENTER,CENTER)
      .setSize(80, 40)
      ;
      ///*
    cp5.addButton("mode4phase1resize")
      .setPosition(width/2 + 100, 677)
      .setCaptionLabel("Resize")
      .align(CENTER,CENTER,CENTER,CENTER)
      .setSize(90, 40)
      ;//*/
//____________________________________________________

//____________________________________________________

//____________________________________________________

//____________________________________________________

//____________________________________________________

    cp5.addButton("mode4phase1crop")
      .setPosition(width/2 + 200, 677)
      .setCaptionLabel("Crop")
      .align(CENTER,CENTER,CENTER,CENTER)
      .setSize(90, 40)
      ;//*/
      
    cp5.addButton("mode4phase1caption")
      .setPosition(width/2 + 300, 677)
      .setCaptionLabel("Caption")
      .align(CENTER,CENTER,CENTER,CENTER)
      .setSize(90, 40)
      ;//*/
//____________________________________________________

//____________________________________________________
//____________________________________________________

//____________________________________________________

    displayButtons = false;
  }
}



//__________________________________________________________________________________________________________________________
public void mode4phase1back()
{
  println("button: back to photo list");
  mode = 1;
  phase = 1;
  cp5.hide();
  displayButtons = true;
}



//__________________________________________________________________________________________________________________________
public void mode4phase1draw()
{
  println("button: edit photo");
  phase = 2;
  cp5.hide();
  displayButtons = true;
  displayPhoto = true;
  background(255);
  paint = color(255, 128, 0, 255);
}

///*

//__________________________________________________________________________________________________________________________
public void mode4phase1resize()
{
  println("button: resize photo");
  phase = 3;
  cp5.hide();
  displayButtons = true;
  displayPhoto = true;
  background(255);
  //displayResizePhoto = true;
  resizeValue = 100;
}
//*/

//__________________________________________________________________________________________________________________________
void mode4phase2draw()
{
        fill(#909090);
        textFont(smallFont);
        text("Brush size:", (width - 100)/2 - 30, 15);
        textFont(buttonFont);
        
	mode4phase2displayButtons();

	if(displayPhoto)
	{
		displayPhoto(photoIndex);
		displayPhoto = false;
	}

	stroke(255, 255, 255);
	fill(255, 255, 255);
	ellipse((width - 200)/2 - 60, 20, 60, 60);

	fill(paint);
        stroke(paint);
	ellipse((width - 200)/2 - 60, 20, strokeWt, strokeWt);




	stroke(paint);
	strokeWeight(strokeWt);

	if(flag == 1
		&& mouseX >= (width - 800)/2
		&& mouseX <= (width - 800)/2 + 800
		&& mouseY >= 70
		&& mouseY <= 70 + 600)
		line(mouseX, mouseY, pmouseX, pmouseY);
}




//__________________________________________________________________________________________________________________________
void mode4phase2displayButtons()
{
  if(displayButtons)
  {
    cp5 = new ControlP5(this);
    fill(#909090);

    cp5.setControlFont(buttonFont);

    cp5.addButton("mode4phase2back")
		.setPosition(width/2 - 50, 677)
		.setCaptionLabel("<")
		.align(CENTER,CENTER,CENTER,CENTER)
		.setSize(40, 40)
		;

    cp5.addButton("mode4phase2save")
		.setPosition(width/2 + 10, 677)
		.setCaptionLabel("Save")
		.align(CENTER,CENTER,CENTER,CENTER)
		.setSize(80, 40)
		;

    cp5.addSlider("brushSize")
    	.setCaptionLabel("")
    	.setPosition((width - 100)/2 - 30, 20)
    	.setSize(100, 20)
    	.setRange(1, 50)
        .setValue(5)
    	.setNumberOfTickMarks(10)
    	;

    cp5.getController("brushSize").getValueLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);

    cp5.setControlFont(smallFont);

	cp = cp5.addColorPicker("colorPicker")
		.setPosition((width + 100)/2 + 20, 5)
		.setColorValue(color(255, 128, 0, 255))
		;
    cp5.setControlFont(buttonFont);

    displayButtons = false;
  }
}



//__________________________________________________________________________________________________________________________
public void mode4phase2back()
{
  println("button: back to photo list");
  mode = 4;
  phase = 1;
  cp5.hide();
  displayButtons = true;
}


//__________________________________________________________________________________________________________________________
public void mode4phase2save()
{
	println("button: save to photo list");
	mode = 1;
	phase = 1;
	cp5.hide();
	displayButtons = true;

	// save edited photo to photo list
	PImage screenShot = get();
  	editPhoto = createImage(640, 480, RGB);
	editPhoto.copy(screenShot, (width - 800)/2, 70, 800, 600, 0, 0, 640, 480);
	Photos[numPhotos] = editPhoto;
	numPhotos++;
}


void brushSize(int theBrushSize)
{
	strokeWt = theBrushSize;
}


void picker(int col)
{
  println("picker\talpha:"+alpha(col)+"\tred:"+red(col)+"\tgreen:"+green(col)+"\tblue:"+blue(col)+"\tcol"+col);
}

///*


//__________________________________________________________________________________________________________________________
void mode4phase3displayButtons()
{
  if(displayButtons)
  {
    cp5 = new ControlP5(this);

    cp5.setControlFont(buttonFont);

    cp5.addButton("mode4phase2back")
      .setPosition(width/2 - 50, 677)
      .setCaptionLabel("<")
      .align(CENTER,CENTER,CENTER,CENTER)
      .setSize(40, 40)
      ;
      
   cp5.addButton("mode4phase2save")
      .setPosition(width/2 + 10, 677)
      .setCaptionLabel("Save")
      .align(CENTER,CENTER,CENTER,CENTER)
      .setSize(80, 40)
      ;
      
    cp5.addSlider("imageSize")
      .setCaptionLabel("")
      .setPosition((width - 100)/2 - 30, 20)
      .setSize(100, 20)
      .setRange(1, 100)
      .setDefaultValue(100)
      .setValue(100)
      .setNumberOfTickMarks(50)
      ;

    cp5.getController("imageSize").getValueLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);



    displayButtons = false;
  }
}


void imageSize(float value)
{
  println(value);
  resizeValue = value;
}


//____________________________________________________
//____________________________________________________

//____________________________________________________

//____________________________________________________


void mode4phase1crop()
{
  phase = 4;
  cp5.hide();
  displayButtons = true;
  displayPhoto = true;
  crop = true;
  background(255);
  
}

void mode4phase4displayButtons()
{
  if(displayButtons)
  {
    cp5 = new ControlP5(this);

    cp5.setControlFont(buttonFont);

    cp5.addButton("mode4phase4back")
      .setPosition(width/2 - 50, 677)
      .setCaptionLabel("<")
      .align(CENTER,CENTER,CENTER,CENTER)
      .setSize(40, 40)
      ;
    cp5.addButton("mode4phase4save")
      .setPosition(width/2 + 10, 677)
      .setCaptionLabel("Save")
      .align(CENTER,CENTER,CENTER,CENTER)
      .setSize(80, 40)
      ;
    displayButtons = false;
  }
}

void mode4phase4back()
{
  mode = 4;
  phase = 1;
  cp5.hide();
  displayButtons = true;
  crop = false;
}

void mode4phase4save()
{
  mode = 1;
  phase = 1;
  cp5.hide();
  displayButtons = true;

  // save edited photo to photo list
  PImage screenShot = get();
  
  if(x2<x1){
    int temp = x1;
    x1 = x2;
    x2 = temp;
  }
  if(y2<y1){
    int temp = y1;
    y1 = y2;
    y2 = temp;
  }
  int w = x2-x1;
  int h = y2-y1;
  editPhoto = createImage(w, h, RGB);
  editPhoto.copy(screenShot, x1, y1, w, h, 0, 0, w, h);
  
  Photos[numPhotos] = editPhoto;
  numPhotos++;
  x1=0;
  x2=0;
  y1=0;
  y2=0;
  crop = false;
}
//_____________________________________________________________
//_____________________________________________________________
//_____________________________________________________________
void mode4phase1caption()
{
  phase = 5;
  cp5.hide();
  displayButtons = true;
  displayPhoto = true;
  background(255);
  crop = true;
  loadStockCaption();
}

void mode4phase5displayButtons()
{
  if(displayButtons)
  {
    cp5 = new ControlP5(this);

    cp5.setControlFont(buttonFont);

    cp5.addButton("mode4phase5back")
      .setPosition(width/2 - 50, 677)
      .setCaptionLabel("<")
      .align(CENTER,CENTER,CENTER,CENTER)
      .setSize(40, 40)
      ;
    cp5.addButton("mode4phase5save")
      .setPosition(width/2 + 10, 677)
      .setCaptionLabel("Save")
      .align(CENTER,CENTER,CENTER,CENTER)
      .setSize(80, 40)
      ;
    displayButtons = false;
  }
}

void mode4phase5back()
{
  mode = 4;
  phase = 1;
  cp5.hide();
  displayButtons = true;
  crop = false;
}

void mode4phase5save()
{
  println("button: save to photo list");
  mode = 1;
  phase = 1;
  cp5.hide();
  displayButtons = true;

  // save edited photo to photo list
  PImage screenShot = get();
    editPhoto = createImage(640, 480, RGB);
  editPhoto.copy(screenShot, (width - 800)/2, 70, 800, 600, 0, 0, 640, 480);
  Photos[numPhotos] = editPhoto;
  numPhotos++;
  crop = false;
}

void loadStockCaption(){
  String path = sketchPath+"/stockcaption/"; //folder of images rename as needed
  File[] files = listFiles(path);
  stockCaption = new PShape[files.length];
  for(int i=0; i<files.length; i++){
    stockCaption[i]=loadShape(files[i].getAbsolutePath());
  }
}

void drawStockCaption()
{
  if(x2<x1){
    int temp = x1;
    x1 = x2;
    x2 = temp;
  }
  if(y2<y1){
    int temp = y1;
    y1 = y2;
    y2 = temp;
  }
  int w = x2-x1;
  int h = y2-y1;
  shape(stockCaption[0], x1, y1, w, h);
}

//*/

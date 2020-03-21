import java.util.Vector;

float maxDistance = 1000;
int obstacleR = 100, agentR = 30; 
PVector obstPosition = new PVector(0,0,0);

void setup() 
{
  size(800, 800, P3D);
  surface.setTitle("Motion planning");

}

void draw() 
{
  createBoard();
  drawAgent();
  
  /* draw the Goal */
  PVector goal=new PVector(9,9,0);
  goal.mult(20);
  fill(252, 252, 66);
  translate(300,300);
  ellipse(goal.x, goal.y, 30,30);
  
  /* draw the obstacle */
  fill(252, 66, 78);
  translate(-200,-200);
  ellipse(0, 0, 100,100);
  
  roadMap(obstPosition, obstacleR, agentR);
  drawEdge();
  /*for (int i=0; i <random_samples.size(); i++){
    for (int j=0; j<random_samples.size(); j++) {
      
      if(distance[i][j] < maxDistance) {
      }
    }
  }*/

}

void createBoard(){
//  stroke(0,0,0);
  noStroke();
  //scale(10);
  //rotateX(PI/3);
  for (int i = 0; i < 30; i++) {
    for (int j = 0; j < 30; j++) {
      fill(105, 161, 179);
      pushMatrix();
      //translate(50*(i-10), 50*(j-10),0);
      rect(i*50,j*50,50,50);
      popMatrix();
    }   
  }

}

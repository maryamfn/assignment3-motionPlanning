import java.util.*;  //<>// //<>// //<>//
import java.util.Random;
import java.util.Collections;

Map<PVector, Map.Entry<PVector,Float>> point_distance_mapping = new HashMap<PVector, Map.Entry<PVector,Float>>();
ArrayList<PVector> points = new ArrayList<PVector>();
  
void roadMap(PVector obstPosition,int obstacleR,int agentR) 
{
  
  int n = 20;
  //Random rand; //instance of random class
  start.mult(20);
  points.add(start);
  while (points.size() < n) {
    //int rand_x = rand.nextInt(10);
    int rand_x = (int)(Math.random() * ((10 - 0) + 1));
    //int rand_y = rand.nextInt(10); 
    int rand_y = (int)(Math.random() * ((10 - 0) + 1));
    PVector node = new PVector(rand_x,rand_y,0);
    node.mult(20);

    //if the node is in free space add it to the array of points
    if (!ostacleIntersection(node,obstPosition,obstacleR,agentR)){ 
      points.add(node);
    }
  }
  
  for (int i=0; i < points.size(); i++) {
    println(points.size());
    Map<PVector, Float> neighbors = new HashMap<PVector, Float>(); //<>//
    PVector p1 = points.get(i);
    for (int j=0; j< points.size(); j++){
      PVector p2 = points.get(j);
      if (i!=j){
         float distance = dist(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z);
         if (line_sphere_intersection(obstPosition,obstacleR,p1,p2) == false){
           neighbors.put(p2,distance);
           //println("added");
         }
      }
    }
    List<Map.Entry<PVector,Float>> sortedList = new ArrayList<Map.Entry<PVector,Float>>(neighbors.entrySet());
    Collections.sort(sortedList,new Comparator<Map.Entry<PVector,Float>>() 
    {
      //sort ascending
      public int compare(Map.Entry<PVector, Float> o1,Map.Entry<PVector, Float> o2) 
      {
        return o1.getValue().compareTo(o2.getValue());
      }        
    });
    int k = 0;
    for(Map.Entry<PVector,Float> sList: sortedList){
      k++;
      if (k>3){
        break;
      }else {
        point_distance_mapping.put(p1,sList);
      }
      
    }
  } 
  //println("here: " + point_distance_mapping);
}

void drawEdge(){
  for (PVector point: point_distance_mapping.keySet()) {
    stroke(255,255,255);
    Map.Entry<PVector,Float> values = point_distance_mapping.get(point);
    PVector keys = values.getKey();
    //line(point.x,point.y,point.z,keys.x,keys.y,keys.z); 
    
  }
}

boolean line_sphere_intersection (PVector obstPosition,int obstacleR,PVector p1,PVector p2 ) {
  boolean intersection = false;
  float a = pow((p2.x-p1.x),2) + pow((p2.y-p1.y),2) + pow((p2.z-p1.z),2);
  float b = 2*((p2.x-p1.x)*(p1.x-obstPosition.x) + (p2.y-p1.y)*(p1.y-obstPosition.y) + (p2.z-p1.z)*(p1.z-obstPosition.z));
  float c = pow(obstPosition.x,2) + pow(obstPosition.y,2) + pow(obstPosition.z,2) + pow(p1.x,2) + pow(p1.y,2) + pow(p1.z,2)
            - 2*(obstPosition.x*p1.x + obstPosition.y*p1.y + obstPosition.z*p1.z) - pow(obstacleR,2);
  
  /*println("a: " + a);
  println("b: " + b);
  println("c: " + c);
  println("********");*/
  float returnVal = pow(b,2) - 4*a*c;
  if (returnVal < 0){
    intersection = false;
    //println("no");
  } else if (returnVal == 0) {
    //the line is a tangent to the sphere
    intersection = false;
    //println("no no");
  } else if (returnVal > 0){
    intersection = true;
    //println("yeay");
  }
  
  return intersection;
  
}

boolean ostacleIntersection(PVector node,PVector obstPosition, int obstacleR, int agentR)
{
  boolean intersection = false;
  float r = obstacleR + agentR;
  float distance = dist(node.x, node.y, node.z, obstPosition.x, obstPosition.y, obstPosition.z);
  if (distance < r) {
    intersection = true;
  }
  return intersection;
}

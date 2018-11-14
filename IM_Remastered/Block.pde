/*
  Block generating algorithrm credit from Coding Train
*/
class Block {
   float x,y,w,h;
   float minX,minY,maxX,maxY;
   
   ArrayList<PVector> points;
   Block(float x, float y) {
     minX = x;
     minY = y;
     maxX = x;
     maxY = y;
     points = new ArrayList<PVector>();
     points.add(new PVector(x,y));
   }
   
   boolean isNear(float px, float py){
     /*
      float cx = max(min(x,maxX),minX);
      float cy = max(min(y,maxY),minY);
      float d = Utils.distSq(cx,cy,px,py);
      */
      float d = 100000;
      for(PVector v: points){
         float td =  Utils.distSq(px,py,v.x,v.y);
         if(td < d){
            d = td;
         }
      }
      if(d < Config.BLOCKS_DISTANCES * Config.BLOCKS_DISTANCES) {
         return true; 
      } else {
         return false; 
      }
   }
   

   float size(){
     return (maxX-minX)*(maxY-minY);
   }
   void add(float x, float y){
       points.add(new PVector(x,y));
       
       minX = min(minX,x);
       minY = min(minY,y);
       maxX = max(maxX,x);
       maxY = max(maxY,y);
   }
   void show() {
      stroke(0);
      fill(255);
      strokeWeight(2);
      //rectMode(CORNERS);
      //rect(minX,minY,maxX,maxY);
      ellipse((minX+maxX)/2,(minY+maxY)/2, 24, 24);
      /*
      for(PVector v : points){
         stroke(0,0,255);
         point(v.x,v.y);  
      }
      */
   }
   PVector position(){
       return new PVector((minX+maxX)/2,(minY+maxY)/2);
   }
}

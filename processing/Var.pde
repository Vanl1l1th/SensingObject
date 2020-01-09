class Vor{
 ArrayList<Seed> seeds;
 int n;
 int r=0;
 Vor(int _n){
   n=_n;
   seeds=new ArrayList<Seed>();
   
   for(int i=0;i<n;i++){
    seeds.add(new Seed());
   }
 }
 
 void display(PVector e){
  
   animate(e);
 }
  void animate(PVector e){
    boolean f=false;
    for(Seed s:seeds){ 
    float d=dist(e.x,e.y,s.pos.x,s.pos.y);
    if(d<r){f=true;}else{f=false;}
    s.display(); s.animate(seeds,f,int(d));}
    if(r<width/2){r++;}
    //noFill();
    //stroke(255);
    //ellipse(e.x,e.y,r,r);
  }
}

class Seed{
 PVector speed;
 PVector pos;
 int rM=50;
 int c=0;
 Seed(){
   pos=new PVector(random(0,width),random(0,height));
   speed=new PVector(random(-1,1),random(-1,1));
 }
 
 void display(){
   fill(255);
   ellipse(pos.x,pos.y,5,5);
 }
 
 void animate(ArrayList<Seed> s, boolean f,int r){
   float dis=width;
   float dis2=width;
   float dis3=width;
   PVector p=new PVector();
   PVector p2=new PVector();
   PVector p3=new PVector();
   for(int j=0;j<s.size();j++){
     float d=dist(pos.x,pos.y,s.get(j).pos.x,s.get(j).pos.y);
     if(d>1&&d<dis){dis=d; p=new PVector(s.get(j).pos.x,s.get(j).pos.y);}
     else if(d>1&&d<dis2){dis2=d; p2= new PVector(s.get(j).pos.x,s.get(j).pos.y);}
     else if(d>1&&d<dis3){dis3=d; p3= new PVector(s.get(j).pos.x,s.get(j).pos.y);}
   }
   if(dis<rM){
   float xs=(pos.x-p.x)*0.0001+speed.x;
   float ys=(pos.y-p.y)*0.0001+speed.y;
   speed=new PVector(xs,ys);
   }
   if(pos.x>width||pos.x<0||pos.y>height||pos.y<0){
   float xs=speed.x*-1; float ys=speed.y*-1;
   speed=new PVector(xs,ys);
   }
   
   float x=pos.x+speed.x;
   float y=pos.y+speed.y;
   pos=new PVector(x,y);
   if(speed.mag()>0.8){speed.mult(0.9);}
   stroke(255);
   noFill();
   if(f){fill(c);c=int(map(r,0,width/2,255,0));}
   beginShape();
   vertex(pos.x,pos.y);
   vertex(p.x,p.y);
   vertex(p2.x,p2.y);
   vertex(p3.x,p3.y);
   vertex(pos.x,pos.y);
   endShape();
   rM=int(map(r,0,width/2,300,50));
 }
 
}

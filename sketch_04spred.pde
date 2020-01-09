Osc o;
Vor v;
Spreed s;
void setup(){
 fullScreen(); 
 o=new Osc(width/2,height/2);
 v=new Vor(300);
 s=new Spreed(width/2,height/2,5,4);
 noCursor();
}

void draw(){
  background(0);
  s.display();
  //o.display();
  //PVector p= new PVector(width/2,height/2);
  //v.display(p);
}

class Spreed{
  ArrayList<Col> points;
  float x;
  float y;
  int n;
  int np=1;
  int f;
  Spreed(float _x,float _y,int _n, int _f){
    n=_n; x=_x; y=_y; f=_f;
    points= new ArrayList<Col>();
  }
  
  void display(){
    noFill();
    stroke(255);
    for(int i=0;i<points.size();i++){
     int index=0;
      for(int m=0;m<points.get(i).p.length;m++){
        //line(points.get(i-1).p[m].x,points.get(i-1).p[m].y,points.get(i).p[n].x,points.get(i).p[n].y);
        float x1=points.get(i).p[m].x;
        float y1=points.get(i).p[m].y;
        ellipse(x1,y1,5,5);
        if(i>0){
            line(x1,y1,points.get(i-1).p[index].x,points.get(i-1).p[index].y);
            if((m+1)%f==0){index++;}
        }
      }
      
      }
    
    animate();
  }
  
  void animate(){
   if(points.size()<n&&frameCount%25==0){
     
     int cc= int(80*(log(np)));
     points.add(new Col(np,cc,x,y,f));
     np*=f;
   }
  }
  
}

class Col{
 PVector[] p;
 int tol=5;
 Col(int n, int r,float x,float y,int f){
  p=new PVector[n]; 
  for(int i=0;i<n;i++){
   p[i]=new PVector(r*cos(radians(360/n*(i*f)))+x,r*sin(radians(360/n*(i*f)))+y); 
  }
 }
}

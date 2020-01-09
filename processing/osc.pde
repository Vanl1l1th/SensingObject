class Osc{
 ArrayList<Par> pars;
 int mX;
 int mY;
 Osc(int x, int y){
   mX=x; mY=y;
   pars=new ArrayList<Par>();
   for(int i=0; i<10;i++){
    pars.add(new Par(mX,mY)); 
   }
 }
 
 void display(){
  for(Par p: pars){
   p.display(); 
  }
 }
}

class Par{
  int a;
  int b;
  int A;
  int B;
  float alpha;
  int mX;
  int mY;
  float speed;
  Par(int x,int y){
    a=0; b=0; A= int(random(width/15,width/2)); B= int(random(height/15,height/2));
    alpha= random(0,360);
    mX=x; mY=y;
    speed=random(1,2.5);
  }
  
  void display(){
    float alpha2=alpha;
    noStroke();
    for(int j=0; j<10;j++){
      for(int i=1;i<20;i+=2){
     fill(255/(i*0.5));
     float xp=a*cos(radians(alpha2-i))+mX;
     float yp=b*sin(radians(alpha2-i))+mY;
     ellipse(xp,yp,10,10);
    }
    alpha2-=30;
    }
    
    animate();
  }
  
  void animate(){
   if(A>a){a++;} if(B>b){b++;}
   if(alpha<360){alpha+=speed;}else{alpha=0;}
  }
}

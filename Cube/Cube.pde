PVector[] p = new PVector[8];
float rx=0,ry=0;
void setup(){
  size(500,500,P3D);
  for(int i=0;i<2;i++)
  for(int j=0;j<2;j++)
  for(int k=0;k<2;k++){
    p[i*4+j*2+k] = new PVector(i*200,j*200,k*200);
  }
  // 计算正方体中心
  PVector cen = new PVector(0,0,0);
  for(PVector s : p){
    cen.add(s);
  }
  cen.div(8);
  // 将中心点移到(0,0,0)
  cen.mult(-1);  
  for(PVector s : p){
    s.add(cen);
  }
}

void draw(){
  background(255);
  translate(width/2,height/2,0);
  rotateY(map(rx,0,width,0,PI));
  rotateX(map(ry,0,-height,0,PI));
  // 中心放个球
  sphere(30);
  // 以中心为原点画坐标系
  fill(0);
  line(0,0,0,200,0,0); // x轴
  text("+x",202,0,0);
  line(0,0,0,0,200,0); // y轴
  text("+y",0,200,0);
  line(0,0,0,0,0,200); // z轴
  text("+z",0,0,200);
  
  // 画正方体
  for(PVector s1:p){
    for(PVector s2:p){
      line(s1.x,s1.y,s1.z,s2.x,s2.y,s2.z);
    }
  }
}

float curx = rx;
float cury = ry;
void mousePressed() {
  curx = mouseX;
  cury = mouseY;
}

void mouseDragged() {
  rx = rx + mouseX-curx;
  ry = ry + mouseY-cury;
  curx = mouseX;
  cury = mouseY;
}

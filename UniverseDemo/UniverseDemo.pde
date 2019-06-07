// 先放个宇宙
Universe sys = new Universe();
// 中心坐标
float cx;
float cy;
// 放大倍率
float sc = 1;
Star sun; // 中心天体
boolean prt = false; // 保留轨迹

void setup(){
  size(800,600);
  noStroke();
  cx = width/2;
  cy = height/2;
  int id = 0;
  sun = new Star(new PVector(0,0),new PVector(0,0),1000);
  sun.radius = 50;
  sun.c = color(255,0,0);
  sun.id=id++;
  sys.add(sun);
  for(int i=0;i<width;i+=40){
    Star b = new Star(new PVector(i-cx,-height/2),new PVector(random(2.5,3.5),0),0.5);
    b.radius = 8;
    b.id = id;
    b.c=color(random(255),random(0,20),random(255));
    sys.add(b);
    id++;
  }
}

void draw(){
  if(!prt){
      background(255);
  }
  translate(cx, cy);
  fill(0);
  float st = -cy+10;
  text("剩余天体："+sys.stars.size(),-cx+10,st);
  for(Star s : sys.stars){
    st+=20;
    fill(s.c);
    circle(-cx+40,st-3,15);
    text(s.id+" ",-cx+10,st);
  }
  scale(sc);
  
  sys.update();
}

float curx = cx;
float cury = cy;
void mousePressed() {
  curx = mouseX;
  cury = mouseY;
}

void mouseDragged() {
  cx = cx + mouseX-curx;
  cy = cy + mouseY-cury;
  curx = mouseX;
  cury = mouseY;
}

void mouseReleased(){

}

void keyPressed(){
  switch(key){
    case 'a':
    case 'A':
      cx = width/2+sun.pos.x;
      cy = height/2+sun.pos.y;
      break;
    case 'q': // 缩小
    case 'Q':
      sc*=0.9;
      break;
    case 'w': // 放大
    case 'W':
      sc/=0.9;
      break;
    case 'p': // 放大
    case 'P':
      prt=!prt;
      break;
  }
}

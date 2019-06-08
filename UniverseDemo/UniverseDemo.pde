// 先放个宇宙
Universe sys = new Universe();
// 中心坐标
float cx;
float cy;
// 放大倍率
float sc = 1;
int hz = 1; // 刷新快慢
boolean prt = false; // 保留轨迹
boolean info = true; // 显示运行信息

// 像素与实际距离比值（200px/水星轨道）
float prRatio = 3.4536349507857018e-09;

// 天体名称
String[] names = new String[]{"太阳", "水星", "金星", "地球", "火星", "木星", "土星", "天王", "海王"};
// 各个星体轨道半径 m
float[] starDis = new float[]{0, 5.79100e+10, 1.08200e+11, 1.49600e+11, 2.27940e+11, 7.78330e+11, 1.42694e+12, 2.87099e+12, 4.49707e+12};

// 各个星体质量
float[] starM = new float[]{1.9891e+30, 3.3000e+23, 4.8690e+24, 5.9736e+24, 6.4219e+23, 1.9000e+27, 5.6800e+26, 8.6830e+25, 1.0247e+26};

// 各个星体速度 m/s
float[] starV = new float[9];

// 开始坐标
PVector startPos = new PVector(0,0);
// 开始速度
PVector startV = new PVector(0,0);

// 显示的星体数量
int show = 7;

// 初始化星体速度
void speed(float ratio){
  starM[0]=starM[0]*ratio;
  for(int i=1;i<show;i++){
    starM[i]=starM[i]*ratio;
    // 都按水星偏心率0.206处理
    starV[i] = 1.1965*sqrt(starM[0]*sys.g/starDis[i]);
  }
}
void setup(){
  size(800,600);
  noStroke();
  cx = width/2;
  cy = height/2;
  translate(cx, cy);
  speed(1.5e8);
  // 初始化各个星体参数，往正x轴依次排开
  for(int i=0;i<show;i++){
    // 初始位置
     PVector pos = startPos.copy();
     pos.add(new PVector(starDis[i],0));
     // 初始速度，向上（-y）
     PVector v = startV.copy();
     v.add(new PVector(0,-starV[i]));
     Star s = new Star(pos,v,starM[i]);
     s.name = names[i];
     s.prRatio=prRatio;
     if(i==0){ // 太阳单独处理
       s.radius = 100.0; // 100个像素
       s.c = color(255,0,0);
     }else{
       s.radius = 30.0; // 30个像素
       s.c=color(random(255),random(0,20),random(255));
     }
     sys.add(s);
  }
}

void draw(){
  
  if(!prt){
      background(255);
  }
  translate(cx, cy);
  fill(0);
  if(info){
    float st = -cy+10;
    text("当前时率：  "+hz,-cx+20,st+=20);
    text("剩余天体：  "+sys.stars.size(),-cx+20,st+=20);
    //text("最大速度：  "+sys.maxV,-cx+20,st+=20);
    text("最大距离：  "+sys.maxD,-cx+20,st+=20);
    text("当前最大距离："+sys.maxDC,-cx+20,st+=20);
    text("天体|颜色",-cx+20,st+=20);
    for(Star s : sys.stars){
      st+=20;
      fill(s.c);
      int dx = 20;
      int dxx = 35;
      text(s.name+" ",-cx+dx,st);
      circle(-cx+(dx+=dxx),st-3,15);
    }
  }
  scale(sc);
  for(int i=0;i<hz;i++){
    sys.update();
  }
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
    case 'q': // 缩小
    case 'Q':
      sc*=0.9;
      break;
    case 'w': // 放大
    case 'W':
      sc/=0.9;
      break;
    case 'p': // 保留轨迹
    case 'P':
      prt=!prt;
      break;
    case 'i': // 显示当前状态
    case 'I':
      info=!info;
      break;
    case 'u': // 加速
    case 'U':
      hz++;
      break;
    case 'd': // 减速到1
    case 'D':
      hz=1;
      break;
  }
}

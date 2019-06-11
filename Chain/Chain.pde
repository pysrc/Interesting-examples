
// 模拟铁链
float[] x, y;
float len;
int cnt = 15;

void setup(){
  size(400, 400);
  x = new float[cnt];
  y = new float[cnt];
  len = 20;
}

void draw(){
  background(255);
  float xc = mouseX;
  float yc = mouseY;
  float dx = xc-x[0];
  float dy = yc-y[0];
  float theta = atan2(dy, dx);
  x[0] = xc-len*cos(theta);
  y[0] = yc-len*sin(theta);
  show(xc,yc,theta);
  for(int i=0;i<cnt-1;i++){
    theta = atan2(y[i]-y[i+1],x[i]-x[i+1]);
    x[i+1] = x[i]-len*cos(theta);
    y[i+1] = y[i]-len*sin(theta);
    show(x[i],y[i],theta);
  }
}

// 显示x,y坐标之后theta角度的线段
void show(float x, float y, float theta){
  pushMatrix();
  translate(x, y); 
  rotate(PI+theta);
  noStroke();
  fill(0);
  rect(0,0,len,3);
  popMatrix();
}

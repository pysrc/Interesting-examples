// 星体
class Star{
  String name; // 天体名称
  float mass; // 质量
  float radius;// 半径
  PVector v; // 速度
  PVector pos; // 位置
  float maxV=0; // 最大速度
  color c = color(255,255,255); // 颜色
  int cunt = 1; // 合并的行星数
  PVector[] tail = new PVector[30]; // 轨道的尾巴
  float prRatio=1; // 像素/真实长度
  int num = 0;
  boolean showName = false;
  Star(PVector pos,PVector v, float mass){
    this.pos = pos;
    this.v = v;
    this.mass = mass;
  }
  void apply(PVector a){
    this.v.add(a);
    if(v.mag()>maxV){
      maxV = v.mag();
    }
  }
  void show(){
    pos.add(v);
    float px = pos.x*prRatio;
    float py = pos.y*prRatio;
    fill(0);
    if(showName){
      text(name,px,py-radius-5);
    }
    fill(c);
    if(tail!=null){
      if(num==tail.length){
        num = 0;
      }
      tail[num]=pos.copy();
      num++;
      for(PVector p : tail){
        if(p!=null){
          circle(p.x*prRatio,p.y*prRatio,3);
        }
      }
    }
    circle(px,py,radius*2);
  }
}

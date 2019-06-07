// 星体
class Star{
  int id; // 天体编号
  float mass; // 质量
  float radius = 5; // 半径
  PVector v; // 速度
  PVector pos; // 位置
  color c = color(255,255,255); // 颜色
  PVector[] tail = new PVector[80]; // 轨道的尾巴
  int num = 0;
  Star(PVector pos,PVector v, float mass){
    this.pos = pos;
    this.v = v;
    this.mass = mass;
  }
  void show(){
    fill(c);
    if(num==tail.length){
      num = 0;
    }
    tail[num]=pos.copy();
    num++;
    for(PVector p : tail){
      if(p!=null){
        circle(p.x,p.y,3);
      }
    }
    circle(pos.x,pos.y,radius);
  }
}

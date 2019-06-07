import java.util.*;
// 模拟宇宙
class Universe{
  List<Star> stars = new ArrayList();
  float g = 3;
  void add(Star b){
    stars.add(b);
  }
  void update(){
    // 计算星体间的引力加速度
    for(int i=0;i<stars.size();i++){
      Star b1 = stars.get(i);
      for(int j=0;j<stars.size();j++){
        if(j==i){
          continue;
        }
        Star b2 = stars.get(j);
        PVector diss = PVector.sub(b2.pos,b1.pos);
        float leng = diss.mag();
        if(leng<=b1.radius+b2.radius){ // 距离过小，碰撞合并
          float newMass = b1.mass+b2.mass;
          float newRadius = sqrt(b1.radius*b1.radius+b2.radius*b2.radius);
          // 动量守恒
          PVector pv = PVector.mult(b1.v,b1.mass);
          pv.add(PVector.mult(b2.v,b2.mass));
          pv.div(newMass);
          if(b1.mass>b2.mass){ // 谁小谁被合并
            b1.mass=newMass;
            b1.radius = newRadius;
            b1.v = pv;
            stars.remove(j);
          }else{
            b2.mass=newMass;
            b2.radius = newRadius;
            b2.v = pv;
            stars.remove(i);
          }
          continue;
        }
        // 计算b1的引力加速度
        float a = g*b2.mass/(leng*leng);
        b1.v.add(diss.normalize().mult(a));
      }
    }
    // 计算下一刻的位置
    for(Star b : stars){
      b.pos.add(b.v);
      b.show();
    }
  }
}

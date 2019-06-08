import java.util.*;
// 模拟宇宙
class Universe{
  List<Star> stars = new ArrayList();
  float g = 6.67e-11; // 万有引力常数
  float maxV = 0; // 系统中存在过的最大速度
  float maxD = 0; // 系统中存在过的最大距离
  float maxDC = 0; // 当前系统最大距离
  float limitDis = 1.0247e+27; // 系统最大允许距离
  void add(Star b){
    stars.add(b);
  }
  void update(){
    // 计算星体间的引力加速度
    maxDC = 0;
    for(int i=0;i<stars.size();i++){
      Star b1 = stars.get(i);
      for(int j=0;j<stars.size();j++){
        if(j==i){
          continue;
        }
        Star b2 = stars.get(j);
        PVector diss = PVector.sub(b2.pos,b1.pos);
        float leng = diss.mag();
        if(leng>maxD){
          maxD=leng;
        }
        if(leng>maxDC){
          maxDC=leng;
        }
        if(leng>=limitDis){ // 超过最大允许距离，剔除质量小的天体
          if(b1.mass>b2.mass){
            stars.remove(j);
          }else{
            stars.remove(i);
          }
        }
        if(leng<=b1.radius+b2.radius){ // 距离过小，碰撞合并
          float newMass = b1.mass+b2.mass; // 新质量
          float newRadius = sqrt(b1.radius*b1.radius+b2.radius*b2.radius); // 新半径
          // 动量守恒
          PVector pv = PVector.mult(b1.v,b1.mass);
          pv.add(PVector.mult(b2.v,b2.mass));
          pv.div(newMass);
          if(b1.mass>b2.mass){ // 谁小谁被合并
            b1.mass=newMass;
            b1.radius = newRadius;
            b1.v = pv;
            b1.cunt+=b2.cunt;
            if(j<=stars.size()){
              stars.remove(j);
            }
          }else{
            b2.mass=newMass;
            b2.radius = newRadius;
            b2.v = pv;
            b2.cunt+=b1.cunt;
            if(i<stars.size()){
              stars.remove(i);
            }
          }
          continue;
        }
        // 计算b1的引力加速度
        float a = g*b2.mass/(leng*leng);
        b1.apply(diss.normalize().mult(a));
      }
    }
    // 计算并显示下一刻的位置
    for(Star b : stars){
      b.show();
      // 计算速度最大值
      if(b.v.mag()>maxV){
        maxV = b.v.mag();
      }
    }
    
  }
}

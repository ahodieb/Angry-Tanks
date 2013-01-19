//Stuff needed for GLCD Library to work.
char GLCD_DataPort at PORTC;

sbit GLCD_CS1 at RB1_bit;
sbit GLCD_CS2 at RB2_bit;
sbit GLCD_RS  at RB3_bit;
sbit GLCD_RW  at RB4_bit;
sbit GLCD_EN  at RB5_bit;
sbit GLCD_RST at RB6_bit;

sbit GLCD_CS1_Direction at TRISB1_bit;
sbit GLCD_CS2_Direction at TRISB2_bit;
sbit GLCD_RS_Direction  at TRISB3_bit;
sbit GLCD_RW_Direction  at TRISB4_bit;
sbit GLCD_EN_Direction  at TRISB5_bit;
sbit GLCD_RST_Direction at TRISB6_bit;

//settings of the game.
unsigned short repaint = 0x01;
unsigned short t_color = 1;
unsigned short mv_step = 5;
unsigned char t_indc = '>';

unsigned short current_t = 0x00;
unsigned short current_m = 0x00;
unsigned short current_l = 0x00;
unsigned short started = 0x00;
unsigned short fire = 0x00;
unsigned short i,j;


//struct for the tank , the closest thing u can get to a class :D.
typedef struct{
  unsigned short body_width;
  unsigned short body_height;

  unsigned short head_width;
  unsigned short head_height;
  
  unsigned short wheel_dis;
  unsigned short x;
  unsigned short y;
  unsigned char* name;
  
  unsigned short gun_length;
  int gun_angle;
  int gun_power;
    
}  Tank;
  
//struct for the obstacles . things that comes in ur way while shooting like a wall or sth.
typedef struct{
  unsigned short width;
  unsigned short height;
  unsigned short x;
  unsigned short y;
}  Obstacle;

  
//game variables.
Tank t1;
Tank t2;

Tank* Tank_Ptr;
Tank* Tank_Ptr2;

Obstacle ob1;

  
//interupt function which is called whenever any key is pressed.
void interrupt(){
  if(INTCON.INTF == 1 ){
  
  if( PORTD.F0)
  {
   if(current_t == 0x00) Tank_Ptr = &t1;
   if(current_t == 0xff) Tank_Ptr = &t2;

   if(current_m == 0x00) Tank_Ptr->gun_angle ++;
   else Tank_Ptr->gun_power ++;
  
  }
  if( PORTD.F1)
  {

   if(current_t == 0x00) Tank_Ptr = &t1;
   if(current_t == 0xff) Tank_Ptr = &t2;

   if(current_m == 0x00)Tank_Ptr->gun_angle --;
   else Tank_Ptr->gun_power --;
   
  }
  if( PORTD.F2)
  {
  current_m = ~current_m;
  }
  if( PORTD.F3)
  {

  fire = 0x01;
  }

  repaint = 0x01;
  INTCON.INTF = 0;
  }
}

// function drawing the players names.
void draw_Labels()
{
    Glcd_Write_Text(t1.name,11,0,1);
    if(current_t == 0x00) Glcd_Write_Char(t_indc,2,0,1);
    
    Glcd_Write_Text(t2.name,111,0,1);
    if(current_t == 0xff) Glcd_Write_Char(t_indc,100,0,1);
    Glcd_H_Line(0,127,8,t_color);

}

//function drawing the upper menu with the power and angle bar.
int pw,a;
void draw_menu()
{

    Glcd_Rectangle(14,11,114,13,1);
    Glcd_Rectangle(14,15,114,17,1);
    if(current_t ==0x00)
    {
    a = t1.gun_angle;
    pw = t1.gun_power;
    }
    if(current_t == 0xff)
    {
    a =  180 - t2.gun_angle ;
    pw = t2.gun_power;
    }
    Glcd_Line(15,12,15+a,12,1);
    Glcd_Line(15,16,15+pw,16,1);


    if(current_m == 0x00)Glcd_Rectangle(6,11,8,13,1);
    if(current_m == 0xff)Glcd_Rectangle(6,15,8,17,1);
    
    Glcd_H_Line(0,127,20,t_color);
}

//function drawing the tank.
unsigned short ux,uy,lx,ly,hd;
unsigned int g_x,g_y;
void draw_Tank(Tank* t)
{
    ux = t->x - (t->body_width/2);
    uy = 63 -  (t->y + (t->body_height));
    lx =  t->x + (t->body_width/2) ;
    ly =  63 - ( t->y );
    
    Glcd_Box(ux,uy,lx,ly,1);
    Glcd_Dot(ux + t->wheel_dis,ly + 1,t_color);
    Glcd_Dot(lx - t->wheel_dis,ly + 1,t_color);
    
    hd = (t->body_width - t->head_width)/2;
    Glcd_Box(ux + hd,uy - t->head_height,lx - hd,uy,1);
    
    g_x = (cosE3(t->gun_angle) * t->gun_length) /1000;
    g_y = (sinE3(t->gun_angle) * t->gun_length) /1000;
    
    Glcd_Line(t->x,63 - (t->y + t->body_height + t->head_height + 1),t->x + g_x,63 - (t->y + t->body_height + g_y +  t->head_height + 1),1);

}

//function drawing obstacle
void draw_ob()
{
    ux = ob1.x - (ob1.width/2);
    uy = 63 -  (ob1.y + (ob1.height));
    lx =  ob1.x + (ob1.width/2) ;
    ly =  63 - ( ob1.y);

    Glcd_Box(ux,uy,lx,ly,1);
}


void draw_win()
{

     Glcd_Fill(0x00);
     Glcd_Rectangle(0,0,127,63,1);
     Glcd_Write_Text(Tank_Ptr->name,57,3,1);
     Glcd_Write_Text("Won",52,4,1);
     
}
//the function used to  detect collision hits.and its used by the drawing function almost every step of the loop.
unsigned short results;
unsigned short detect_collision(int x , int y)
{
// 0x00 for air ( no collision )
// 0x01 for tank collision
// 0x02 miss ( no collision untill hitting ground)
// 0x03 collision with obstaelce
  if(current_t == 0xFF) Tank_Ptr2 = & t1;
  if(current_t == 0x00) Tank_Ptr2 = & t2;
  
  y =  63 - y;
  results = 0x00;

  if(y <= 0) results = 0x02;
  else   results = 0x00;

  if(x >= (Tank_Ptr2->x - (Tank_Ptr2->body_width / 2))  &&
     x <= (Tank_Ptr2->x + (Tank_Ptr2->body_width / 2)) )
  {

     if(y >= (Tank_Ptr2->y)  &&
     y <= (Tank_Ptr2->y + (Tank_Ptr2->body_height)) )
     results = 0x01;
  }
  
    if(x >= (Tank_Ptr2->x - (Tank_Ptr2->head_width / 2))  &&
     x <= (Tank_Ptr2->x + (Tank_Ptr2->head_width / 2)) )
  {

     if(y >= (Tank_Ptr2->body_height)  &&
     y <= (Tank_Ptr2->body_height + (Tank_Ptr2->head_height)) )
     results = 0x01;
  }
  
   if(x >= (ob1.x - (ob1.width / 2))  &&
     x <= (ob1.x + (ob1.width / 2)) )
  {
     if(y >= (ob1.y)  &&
     y <= (ob1.y + (ob1.height)) )
     results = 0x03;
  }

 return results;
}

//function drawing the projectile and firing at the target. and determining if u missed or hit the target.
long f_x,f_y,ex;
long l_x , l_y;
short collision;
short cont_fire;
void draw_fire()
{
    if(current_t == 0x00) Tank_Ptr = & t1;
    if(current_t == 0xFF) Tank_Ptr = & t2;
    cont_fire = 0x01;

    for (i = 1;i<=Tank_Ptr->gun_power  && cont_fire ==0x01;i++){

    f_x = cosE3(Tank_Ptr->gun_angle);
    f_x = f_x * i;
    f_x = f_x / 1000;

    f_y = sinE3(Tank_Ptr->gun_angle);
    f_y = f_y * i;
    f_y = f_y / 1000;

    l_x = Tank_Ptr->x;
    l_y = 63 - (Tank_Ptr->y + Tank_Ptr->body_height + Tank_Ptr->head_height);

    if((l_x + f_x)<=127 && (l_x + f_x)>=0 && (l_y - f_y)>=0  && (l_y - f_y)<=63)
    Glcd_Line(l_x,l_y,l_x + f_x, l_y - f_y,1);
    
    collision = detect_collision(l_x + f_x,l_y - f_y);


    if (collision == 0x01)
    {
     draw_win();
     cont_fire = 0x00;
     started = 0x00;
    }
    
    if (collision == 0x03)
    {

     cont_fire = 0x00;
     Glcd_Write_Text("You O Missed",25,4,1);
    }


    l_x += f_x;
    l_y -= f_y;
    Delay_ms(50);
  }


  if(cont_fire = 0x01)
  {
  ex = 1000 * (f_y + Tank_Ptr->head_height + Tank_Ptr->body_height + Tank_Ptr->y);
  ex = ex / sinE3(Tank_Ptr->gun_angle);



  for (i = 1;i<=ex  && cont_fire ==0x01;i++){;

    f_x = cosE3(Tank_Ptr->gun_angle);
    f_x = f_x * i;
    f_x = f_x / 1000;

    f_y = sinE3(Tank_Ptr->gun_angle);
    f_y = f_y * i;
    f_y = f_y / 1000;

    if((l_x + f_x)<=127 && (l_x + f_x)>=0 )

    {
    //if((l_y + f_y)>=0  && (l_y + f_y)<=63)
    Glcd_Line(l_x,l_y,l_x + f_x, l_y + f_y,1);
    }

    collision = detect_collision(l_x + f_x,l_y + f_y);

    if (collision == 0x01)
    {
     draw_win();
     cont_fire = 0x00;
     started = 0x00;
    }
    else if (collision == 0x02)
    {
    Glcd_Write_Text("You Missed",25,4,1);
    }
    else if (collision == 0x03)
    {

     cont_fire = 0x00;
     Glcd_Write_Text("You Missed",25,4,1);
    }

    

    Delay_ms(50);
  }
    l_x += f_x;
    l_y += f_y;
    
    }

    Delay_ms(1000);
    current_t = ~ current_t;
    repaint = 0x01;
}


// at the last day of my project i decided i have time ti implement levels . levels were basicly 
// done by changing the positions of the tanks , and changing the size and location of the obstacle.
void Init_Level()
{
current_l ++;
if (current_l == 0x01)
{

t1.body_width = 15;
t1.body_height = 4;
t1.head_width = 6;
t1.head_height = 2;
t1.x = 7;
t1.y = 1;
t1.wheel_dis = 2;
t1.name  = "T1";
t1.gun_angle = 30;
t1.gun_power = 30;
t1.gun_length = 12;

t2.body_width = t1.body_width;
t2.body_height = t1.body_height;
t2.head_width = t1.head_width ;
t2.head_height = t1.head_height ;
t2.x = 120;
t2.y = 1;
t2.wheel_dis = t1.wheel_dis;
t2.name  = "T2";
t2.gun_angle = 180 - t1.gun_angle ;
t2.gun_power = 80;
t2.gun_length = t1.gun_length;

ob1.x = 64;
ob1.y = 0;
ob1.width = 10;
ob1.height = 30;
}
else if (current_l == 0x02)
{

t1.body_width = 15;
t1.body_height = 4;
t1.head_width = 6;
t1.head_height = 2;
t1.x = 7;
t1.y = 1;
t1.wheel_dis = 2;
t1.name  = "T1";
t1.gun_angle = 50;
t1.gun_power = 65;
t1.gun_length = 12;

t2.body_width = t1.body_width;
t2.body_height = t1.body_height;
t2.head_width = t1.head_width ;
t2.head_height = t1.head_height ;
t2.x = 120;
t2.y = 1;
t2.wheel_dis = t1.wheel_dis;
t2.name  = "T2";
t2.gun_angle = 180 - 40 ;
t2.gun_power = 30;
t2.gun_length = t1.gun_length;

ob1.x = 80;
ob1.y = 10;
ob1.width = 10;
ob1.height = 20;
}
else if (current_l == 0x03)
{

t1.body_width = 15;
t1.body_height = 4;
t1.head_width = 6;
t1.head_height = 2;
t1.x = 7;
t1.y = 1;
t1.wheel_dis = 2;
t1.name  = "T1";
t1.gun_angle = 15;
t1.gun_power = 50;
t1.gun_length = 12;

t2.body_width = t1.body_width;
t2.body_height = t1.body_height;
t2.head_width = t1.head_width ;
t2.head_height = t1.head_height ;
t2.x = 120;
t2.y = 10;
t2.wheel_dis = t1.wheel_dis;
t2.name  = "T2";
t2.gun_angle = 180 - t1.gun_angle ;
t2.gun_power = 80;
t2.gun_length = t1.gun_length;

ob1.x = 50;
ob1.y = 0;
ob1.width = 10;
ob1.height = 30;
}
else
{

t1.body_width = 15;
t1.body_height = 4;
t1.head_width = 6;
t1.head_height = 2;
t1.x = 7;
t1.y = 15;
t1.wheel_dis = 2;
t1.name  = "T1";
t1.gun_angle = 30;
t1.gun_power = 65;
t1.gun_length = 12;

t2.body_width = t1.body_width;
t2.body_height = t1.body_height;
t2.head_width = t1.head_width ;
t2.head_height = t1.head_height ;
t2.x = 100;
t2.y = 1;
t2.wheel_dis = t1.wheel_dis;
t2.name  = "T2";
t2.gun_angle = 180 - t1.gun_angle ;
t2.gun_power = 80;
t2.gun_length = t1.gun_length;

current_l = 0x00;
}
}

void main() {
TRISB = 0x01;
TRISD = 0xff;
Glcd_Init();
Glcd_Fill(0x00);
Glcd_Set_Font(Character8x7, 8, 7, 32);


intLevel:
if(started == 0x00)
{

Init_Level();
INTCON = 0x90;
started = 0x01;
}
while(1)
{
if(started != 0x01) goto intLevel;
if(repaint == 0x01)
{
    Glcd_Fill(0x00);
    Glcd_Rectangle(0,8,127,63,1);

    draw_Labels();
    draw_menu();
    draw_Tank(&t1);
    draw_Tank(&t2);
    draw_ob();
    repaint = 0x00;

    if(fire == 0x01)
    {
     draw_fire();
     fire = 0x00;
    }

}
}
}
